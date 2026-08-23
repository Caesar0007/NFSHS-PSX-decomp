#!/usr/bin/env python
"""w46-a10: apply the GCC_TRACE_ALLOC instrumentation to a pristine gcc-2.8.1 tree.

Usage:  python apply_traces.py <path-to-gcc-2.8.1-srcdir>

Keeps *.orig copies; refuses to double-apply.

Patched files:
  obstack.h     -- gcc>=5 rejects cast-as-lvalue (BUILD FIX, not a trace)
  global.c      -- [allocno_compare] sorted order, [find_reg] entry+result,
                   [caller-save] retry
  local-alloc.c -- [qty_sugg_order] / [qty_order] sorted lists, [qty_combine]
                   merges, [find_free_reg] per-window availability   (NEW in w46)
  reload1.c     -- [reload-rehome] every post-alloc reg_renumber write
                   (retry_global_alloc + the SILENT inheritance re-homes)  (NEW in w46)

All traces are gated on env GCC_TRACE_ALLOC=1 and written to stderr.

🔴 K&R GOTCHA (paid for in w45 and again here): a new `static` helper must have a
PROTO forward declaration ABOVE its first USE, otherwise the K&R implicit
declaration makes gcc report "static declaration follows non-static".  Hence the
forward decls are injected into each file's existing PROTO block.
"""
import os, re, sys

MARK = "nfs4_trace_on"          # global.c marker
MARK_LA = "nfs4_la_trace"       # local-alloc.c marker
MARK_RL = "nfs4_rl_trace"       # reload1.c marker
MARK_RP = "nfs4_reload_pick"    # reload1.c [reload_pick] marker (w75-A20)
MARK_RO = '"[reload-order] FUNCTION'  # reload1.c [reload-order] marker (hand w59-era; folded w76-A20)
MARK_DN = "nfs4_dn_trace"       # combine.c [distribute_notes] marker (w76-A20)


def rd(p):  return open(p, 'r', newline='').read()
def wr(p, s): open(p, 'w', newline='').write(s)

def backup(p):
    if not os.path.exists(p + '.orig'):
        wr(p + '.orig', rd(p))

def sub1(s, old, new, what):
    n = s.count(old)
    if n != 1:
        raise SystemExit("PATCH FAIL (%s): anchor count=%d\n%r" % (what, n, old[:160]))
    return s.replace(old, new)


# 🔴 `extern char *getenv ();` IS MANDATORY.  The host gcc is x86_64-w64-mingw32,
# so cc1.exe is a 64-BIT binary; under K&R rules an undeclared getenv() is assumed
# to return `int`, which TRUNCATES the returned pointer to 32 bits and makes the
# very first `*e` segfault.  (Cost: one whole build cycle in w46.)
TRACE_FN = r'''
extern char *getenv ();

static int %(name)s ()
{
  static int t = -1;
  if (t < 0)
    {
      char *e = getenv ("GCC_TRACE_ALLOC");
      t = (e && *e && *e != '0') ? 1 : 0;
    }
  return t;
}
'''

# =========================================================================
def patch_obstack(root):
    p = os.path.join(root, 'obstack.h')
    s = rd(p)
    if 'next_free += sizeof' in s:
        print("  obstack.h  already patched"); return
    backup(p)
    for a, b in [
        ('*((void **)__o->next_free)++ = ((void *)datum);',
         '(*(void **)__o->next_free = ((void *)datum), __o->next_free += sizeof (void *));'),
        ('*((int *)__o->next_free)++ = ((int)datum);',
         '(*(int *)__o->next_free = ((int)datum), __o->next_free += sizeof (int));'),
        ('# define obstack_ptr_grow_fast(h,aptr) (*((void **) (h)->next_free)++ = (void *)aptr)',
         '# define obstack_ptr_grow_fast(h,aptr) (*(void **) (h)->next_free = (void *)aptr, (h)->next_free += sizeof (void *))'),
        ('# define obstack_int_grow_fast(h,aint) (*((int *) (h)->next_free)++ = (int) aint)',
         '# define obstack_int_grow_fast(h,aint) (*(int *) (h)->next_free = (int) aint, (h)->next_free += sizeof (int))'),
        ('# define obstack_ptr_grow_fast(h,aptr) (*((char **) (h)->next_free)++ = (char *) aptr)',
         '# define obstack_ptr_grow_fast(h,aptr) (*(char **) (h)->next_free = (char *) aptr, (h)->next_free += sizeof (char *))'),
    ]:
        assert s.count(a) >= 1, a
        s = s.replace(a, b)
    wr(p, s)
    print("  obstack.h  patched (cast-as-lvalue)")


# =========================================================================
def patch_global(root):
    p = os.path.join(root, 'global.c')
    s = rd(p)
    if MARK in s:
        print("  global.c   already patched"); return
    backup(p)

    # 1) forward decl in the existing PROTO block
    s = sub1(s,
             "static int allocno_compare\tPROTO((const GENERIC_PTR, const GENERIC_PTR));\n",
             "static int allocno_compare\tPROTO((const GENERIC_PTR, const GENERIC_PTR));\n"
             "static int nfs4_trace_on\tPROTO((void));\t/* w46-a10 */\n",
             "global proto")

    # 2) definition just above allocno_compare
    anchor = "/* Sort predicate for ordering the allocnos.\n"
    s = sub1(s, anchor,
             "/* ---- w46-a10 instrumentation ---- */"
             + (TRACE_FN % {'name': 'nfs4_trace_on'})
             + "/* --------------------------------- */\n\n" + anchor,
             "global helper def")

    # 3) sorted allocno order right after the qsort
    a = "      qsort (allocno_order, max_allocno, sizeof (int), allocno_compare);\n"
    b = a + r"""
      if (nfs4_trace_on ())
	{
	  int k_;
	  fprintf (stderr, "[allocno_compare]  order (allocno/pseudo:refs/live/calls/size=pri):");
	  for (k_ = 0; k_ < max_allocno; k_++)
	    {
	      int a_ = allocno_order[k_];
	      fprintf (stderr, " %d/%d:%d/%d/%d/%d=%d", a_, allocno_reg[a_],
		       allocno_n_refs[a_], allocno_live_length[a_],
		       allocno_calls_crossed[a_], allocno_size[a_],
		       (int) (((double) (floor_log2 (allocno_n_refs[a_])
					 * allocno_n_refs[a_])
			       / allocno_live_length[a_])
			      * 10000 * allocno_size[a_]));
	    }
	  fprintf (stderr, "\n");
	}
"""
    s = sub1(s, a, b, "allocno order dump")

    # 4) find_reg entry+result
    a = "  /* Did we find a register?  */\n\n  if (best_reg >= 0)\n    {"
    b = r"""  /* Did we find a register?  */

  if (nfs4_trace_on ())
    fprintf (stderr,
	     "[find_reg]         allocno %d pseudo %d refs %d live %d calls %d size %d alt %d ccl %d retry %d -> reg %d\n",
	     allocno, allocno_reg[allocno], allocno_n_refs[allocno],
	     allocno_live_length[allocno], allocno_calls_crossed[allocno],
	     allocno_size[allocno], alt_regs_p, accept_call_clobbered,
	     retrying, best_reg);

  if (best_reg >= 0)
    {"""
    s = sub1(s, a, b, "find_reg result")

    # 5) caller-save retry
    idx = s.index("	  && CALLER_SAVE_PROFITABLE (allocno_n_refs[allocno],")
    m = re.search(r"\)\)\s*\n\s*\{\n", s[idx:idx + 400])
    if not m:
        raise SystemExit("PATCH FAIL: caller-save block")
    at = idx + m.end()
    s = (s[:at]
         + '	  if (nfs4_trace_on ())\n'
           '	    fprintf (stderr, "[caller-save]      pseudo %d PROFITABLE (4*%d < %d) -> retry\\n",\n'
           '		     allocno_reg[allocno], allocno_calls_crossed[allocno],\n'
           '		     allocno_n_refs[allocno]);\n'
         + s[at:])

    wr(p, s)
    print("  global.c   patched")


# =========================================================================
LA_DUMP = r'''
/* ---- w46-a10 instrumentation ---- */
extern char *getenv ();

static int nfs4_la_trace ()
{
  static int t = -1;
  if (t < 0)
    {
      char *e = getenv ("GCC_TRACE_ALLOC");
      t = (e && *e && *e != '0') ? 1 : 0;
    }
  return t;
}

/* Print a whole block's qty table in the order local_alloc will hand out
   registers.  Columns: qty/firstreg:refs/life/calls/nsugg/ncopysugg=QTY_CMP_PRI  */
static void
nfs4_dump_qty_order (tag, order, n)
     char *tag;
     int *order;
     int n;
{
  int k_;
  if (! nfs4_la_trace ())
    return;
  fprintf (stderr, "[%s] (qty/reg1:refs/life/calls/sg/csg=pri):", tag);
  for (k_ = 0; k_ < n; k_++)
    {
      int q_ = order[k_];
      int life_ = qty_death[q_] - qty_birth[q_];
      fprintf (stderr, " %d/%d:%d/%d/%d/%d/%d=%d", q_, qty_first_reg[q_],
	       qty_n_refs[q_], life_, qty_n_calls_crossed[q_],
	       qty_phys_num_sugg[q_], qty_phys_num_copy_sugg[q_],
	       life_ ? (int) (((double) (floor_log2 (qty_n_refs[q_])
					 * qty_n_refs[q_] * qty_size[q_])
			       / life_) * 10000) : -1);
    }
  fprintf (stderr, "\n");
}
/* --------------------------------- */
'''


def patch_local_alloc(root):
    p = os.path.join(root, 'local-alloc.c')
    s = rd(p)
    if MARK_LA in s:
        print("  local-alloc.c already patched"); return
    backup(p)

    # 1) forward decls
    s = sub1(s,
             "static int qty_sugg_compare    \tPROTO((int, int));\n",
             "static int qty_sugg_compare    \tPROTO((int, int));\n"
             "static int nfs4_la_trace\tPROTO((void));\t\t/* w46-a10 */\n"
             "static void nfs4_dump_qty_order\tPROTO((char *, int *, int));\t/* w46-a10 */\n",
             "la proto")

    # 2) definitions above the QTY_CMP_PRI comment
    anchor = ("/* Note that the quotient will never be bigger than\n"
              "   the value of floor_log2 times the maximum number of\n"
              "   times a register can occur in one insn (surely less than 100).\n"
              "   Multiplying this by 10000 can't overflow.\n"
              "   QTY_CMP_PRI is also used by qty_sugg_compare.  */\n")
    s = sub1(s, anchor, LA_DUMP + "\n" + anchor, "la helper def")

    # 2b) FUNCTION MARKER at local_alloc entry -- the trace stream is otherwise
    #     one undifferentiated blob.  `current_function_name` is a char* global.
    a = "local_alloc ()\n{\n  register int b, i;\n  int max_qty;\n"
    b = (a
         + "\n  if (nfs4_la_trace ())\n"
           "    fprintf (stderr, \"\\n===== FUNCTION %s =====\\n\","
           " current_function_name);\n")
    s = sub1(s, a, b, "function marker")

    # 3) group-1 (suggested) order dump
    a = ("  /* Try to put each quantity in a suggested physical register, if it has one.\n"
         "     This may cause registers to be allocated that otherwise wouldn't be, but\n"
         "     this seems acceptable in local allocation (unlike global allocation).  */\n")
    s = sub1(s, a, '  nfs4_dump_qty_order ("qty_sugg_order", qty_order, next_qty);\n\n' + a,
             "sugg order dump")

    # 4) group-2 (priority) order dump
    a = ("  /* Now for each qty that is not a hardware register,\n"
         "     look for a hardware register to put it in.\n"
         "     First try the register class that is cheapest for this qty,\n"
         "     if there is more than one class.  */\n")
    s = sub1(s, a, '  nfs4_dump_qty_order ("qty_order     ", qty_order, next_qty);\n\n' + a,
             "qty order dump")

    # 5) find_free_reg: WHICH regs are blocked over this qty's window, and why
    a = ("  /* If at least one would be suitable, test each hard reg.  */\n\n"
         "  for (i = 0; i < FIRST_PSEUDO_REGISTER; i++)\n    {")
    b = r"""  /* If at least one would be suitable, test each hard reg.  */

  if (nfs4_la_trace ())
    {
      int r_, ins_, why_;
      fprintf (stderr,
	       "[find_free_reg]    qty %d reg1 %d class %d calls %d acc %d sugg %d win [%d,%d) blocked:",
	       qty, qty_first_reg[qty], (int) class, qty_n_calls_crossed[qty],
	       accept_call_clobbered, just_try_suggested,
	       born_index, dead_index);
      for (r_ = 0; r_ < FIRST_PSEUDO_REGISTER; r_++)
	{
	  if (! TEST_HARD_REG_BIT (reg_class_contents[(int) class], r_))
	    continue;			/* not in this class: uninteresting */
	  if (! TEST_HARD_REG_BIT (first_used, r_))
	    continue;			/* free */
	  why_ = 0;			/* 0=other 1=live-in-window 2=fixed 3=call-used */
	  for (ins_ = born_index; ins_ < dead_index; ins_++)
	    if (TEST_HARD_REG_BIT (regs_live_at[ins_], r_))
	      { why_ = 1; break; }
	  if (! why_ && TEST_HARD_REG_BIT (fixed_reg_set, r_))
	    why_ = 2;
	  if (! why_ && qty_n_calls_crossed[qty] != 0
	      && TEST_HARD_REG_BIT (call_used_reg_set, r_))
	    why_ = 3;
	  if (! why_ && accept_call_clobbered
	      && TEST_HARD_REG_BIT (call_fixed_reg_set, r_))
	    why_ = 4;
	  if (! why_ && just_try_suggested)
	    why_ = 5;			/* simply not one of the suggestions */
	  fprintf (stderr, " %d(%s)", r_,
		   why_ == 1 ? "live" : why_ == 2 ? "fixed"
		   : why_ == 3 ? "callused" : why_ == 4 ? "callfixed"
		   : why_ == 5 ? "notsugg" : "other");
	}
      fprintf (stderr, "\n");
    }

  for (i = 0; i < FIRST_PSEUDO_REGISTER; i++)
    {"""
    s = sub1(s, a, b, "find_free_reg blocked dump")

    # 6) find_free_reg result
    a = ("	      post_mark_life (regno, mode, 1, born_index, dead_index);\n"
         "	      return regno;")
    b = ("	      post_mark_life (regno, mode, 1, born_index, dead_index);\n"
         "	      if (nfs4_la_trace ())\n"
         "		fprintf (stderr, \"[find_free_reg]    qty %d -> reg %d\\n\", qty, regno);\n"
         "	      return regno;")
    s = sub1(s, a, b, "find_free_reg result")

    # 7) combine_regs: which pseudos got merged into one qty (refs/calls SUM)
    a = ("      /* Update info about quantity SQTY.  */\n"
         "      qty_n_calls_crossed[sqty] += REG_N_CALLS_CROSSED (sreg);\n"
         "      qty_n_refs[sqty] += REG_N_REFS (sreg);\n")
    b = a + ("      if (nfs4_la_trace ())\n"
             "	fprintf (stderr, \"[qty_combine]      pseudo %d (refs %d calls %d) merged into qty %d"
             " of pseudo %d -> qty refs %d calls %d\\n\",\n"
             "		 sreg, REG_N_REFS (sreg), REG_N_CALLS_CROSSED (sreg), sqty, ureg,\n"
             "		 qty_n_refs[sqty], qty_n_calls_crossed[sqty]);\n")
    s = sub1(s, a, b, "combine_regs merge dump")

    # 7b) the hard-reg SUGGESTION paths (a hard reg tied to a pseudo's qty)
    a = ("	      SET_HARD_REG_BIT (qty_phys_copy_sugg[reg_qty[sreg]], ureg);\n"
         "	      qty_phys_num_copy_sugg[reg_qty[sreg]]++;\n")
    b = a + ("	      if (nfs4_la_trace ())\n"
             "		fprintf (stderr, \"[qty_sugg]         qty %d (pseudo %d) COPY-suggests hard reg %d\\n\",\n"
             "			 reg_qty[sreg], sreg, ureg);\n")
    s = sub1(s, a, b, "combine_regs copy-sugg dump")

    wr(p, s)
    print("  local-alloc.c patched")


# =========================================================================
def patch_reload1(root):
    """The SILENT re-homes: every reg_renumber write inside reload1.c that is not
    a spill (-1).  Covers retry_global_alloc (~3722) and the inheritance sites
    (~6277 / ~7362) that allocsim cannot model."""
    p = os.path.join(root, 'reload1.c')
    s = rd(p)
    if MARK_RL in s:
        print("  reload1.c  already patched"); return
    backup(p)

    incs = list(re.finditer(r'^#include [^\n]*\n', s, re.M))
    at = incs[-1].end()
    s = (s[:at]
         + "\n/* ---- w46-a10 instrumentation ---- */\n"
           "static int nfs4_rl_trace PROTO((void));\n"
         + (TRACE_FN % {'name': 'nfs4_rl_trace'})
         + "/* --------------------------------- */\n"
         + s[at:])

    # index forms seen in 2.8.1: `reg_renumber[i]` and `reg_renumber[REGNO (x)]`
    IDX = r'([A-Za-z_][A-Za-z_0-9]*|REGNO \([A-Za-z_][A-Za-z_0-9]*\))'
    out, n = [], 0
    for line in s.split('\n'):
        out.append(line)
        m = re.match(r'^(\s*)reg_renumber\[\s*%s\s*\] = ([^;]+);\s*$' % IDX, line)
        if m and m.group(3).strip() != '-1':
            ind, idx = m.group(1), m.group(2)
            out.append('%sif (nfs4_rl_trace ()) fprintf (stderr, '
                       '"[reload-rehome]    SILENT: pseudo %%d now in %%d (reload1.c inheritance)\\n",'
                       ' (int) (%s), reg_renumber[%s]);' % (ind, idx, idx))
            n += 1
    s = '\n'.join(out)

    # the LOUD re-home: retry_global_alloc inside spill_hard_reg (dumpfile-only
    # in stock gcc) -- mirror it to stderr so one trace stream has both.
    a = ("	if (dumpfile)\n"
         "	  {\n"
         "	    if (reg_renumber[i] == -1)\n")
    if s.count(a) == 1:
        s = s.replace(a,
                      '	if (nfs4_rl_trace ())\n'
                      '	  fprintf (stderr, "[reload-rehome]    retry_global_alloc: pseudo %d now in %d\\n",\n'
                      '		   i, reg_renumber[i]);\n' + a)
        n += 1
    wr(p, s)
    print("  reload1.c  patched (%d re-home trace sites)" % n)


# =========================================================================
def patch_reload_pick(root):
    """w75-A20: the [reload_pick] instrument --- allocate_reload_reg's decision.

    reload1.c:5031 allocate_reload_reg walks spill_regs[] ROUND-ROBIN starting at
    `last_spill_reg + 1` (reload1.c:5083 `i = last_spill_reg;` then :5088
    `i = (i + 1) % n_spills;`) over TWO passes: pass 0 accepts only registers
    already in reload_reg_used_at_all and NOT in reload_reg_used_for_inherit
    (reload1.c:5100-5104 = "reuse first"), pass 1 accepts any free one.  That
    rotating cursor is the mechanism behind the uniform +-1 scratch-rotation
    class, so the trace prints, per pick: the whole spill_regs order with each
    entry's free/used_at_all/inherit/class-membership state, the incoming
    last_spill_reg cursor, and (on success) the winning index + pass.

    Requires patch_reload1() to have run first (reuses its nfs4_rl_trace gate).
    """
    p = os.path.join(root, 'reload1.c')
    s = rd(p)
    if MARK_RP in s:
        print("  reload1.c  [reload_pick] already patched"); return
    if 'nfs4_rl_trace' not in s:
        raise SystemExit("PATCH FAIL (reload_pick): run patch_reload1 first")

    # 1) entry dump -- right after force_group is computed, before the pass loop.
    a = "  int force_group = reload_nregs[r] > 1 && ! last_reload;\n"
    b = a + r"""
  /* ---- w75-A20 [reload_pick] instrumentation ---- */
  if (nfs4_reload_pick_trace ())
    {
      int k_, cls_ = (int) reload_reg_class[r];
      fprintf (stderr,
	       "[reload_pick]      r=%d insn=%d class=%d mode=%d nregs=%d opnum=%d when=%d noerror=%d force_group=%d n_spills=%d last_spill_reg=%d start=%d order:",
	       r, insn ? INSN_UID (insn) : -1, cls_, (int) reload_mode[r],
	       reload_nregs[r], reload_opnum[r], (int) reload_when_needed[r],
	       noerror, force_group, n_spills, last_spill_reg,
	       (noerror || ! force_group)
	       ? (n_spills ? (last_spill_reg + 1) % n_spills : -1) : 0);
      for (k_ = 0; k_ < n_spills; k_++)
	fprintf (stderr, " %d:$%d%s%s%s%s", k_, spill_regs[k_],
		 TEST_HARD_REG_BIT (reg_class_contents[cls_], spill_regs[k_]) ? "c" : "",
		 reload_reg_free_p (spill_regs[k_], reload_opnum[r],
				    reload_when_needed[r]) ? "f" : "",
		 TEST_HARD_REG_BIT (reload_reg_used_at_all, spill_regs[k_]) ? "u" : "",
		 TEST_HARD_REG_BIT (reload_reg_used_for_inherit, spill_regs[k_]) ? "h" : "");
      fprintf (stderr, "\n");
    }
  /* ----------------------------------------------- */
"""
    s = sub1(s, a, b, "reload_pick entry dump")

    # 2) result dump -- at the one site that commits the choice (reload1.c:5185).
    a = "	    last_spill_reg = i;\n"
    b = ("	    if (nfs4_reload_pick_trace ())\n"
         "	      fprintf (stderr, \"[reload_pick]      r=%d WON i=%d $%d pass=%d"
         " (cursor %d -> %d)\\n\",\n"
         "		       r, i, spill_regs[i], pass, last_spill_reg, i);\n"
         + a)
    s = sub1(s, a, b, "reload_pick result dump")

    # 3) the gate helper + its K&R forward decl (see the PROTO gotcha above).
    a = "static int nfs4_rl_trace PROTO((void));\n"
    b = (a + "static int nfs4_reload_pick_trace PROTO((void));\t/* w75-A20 */\n")
    s = sub1(s, a, b, "reload_pick proto")

    a = "/* --------------------------------- */\n"
    b = ("/* ---- w75-A20 " + MARK_RP + " ---- */\n"
         + (TRACE_FN % {'name': 'nfs4_reload_pick_trace'}).replace(
             'GCC_TRACE_ALLOC', 'GCC_TRACE_RELOAD_PICK')
             .replace('extern char *getenv ();\n', '')
         + "/* --------------------------------- */\n"
         + a)
    s = sub1(s, a, b, "reload_pick helper def")

    wr(p, s)
    print("  reload1.c  [reload_pick] patched")


# =========================================================================
def patch_reload_order(root):
    """w76-A20: fold the previously HAND-APPLIED [reload-order] trace into this
    script.  W75-A20 flagged that the trace existed ONLY in the built repo tree
    (scratch/gccsrc/gcc-2.8.1/reload1.c) -- a from-scratch rebuild (deleting
    gccsrc) would silently lose it.  This emits BYTE-IDENTICAL text to the hand
    patch, so an already-hand-patched tree is detected and skipped.

    Prints, at the end of order_regs_for_reload's use census (just before the
    ELIMINABLE_REGS block), each GP reg r2..r15's hard_reg_n_uses[].uses +
    regs_explicitly_used -- the INPUT to the spill-pool ORDER (pairs with
    [reload_pick], which shows the round-robin walk over the resulting pool).
    Gated on GCC_TRACE_ALLOC via nfs4_rl_trace; requires patch_reload1 first.
    """
    p = os.path.join(root, 'reload1.c')
    s = rd(p)
    if MARK_RO in s:
        print("  reload1.c  [reload-order] already patched"); return
    if 'nfs4_rl_trace' not in s:
        raise SystemExit("PATCH FAIL (reload_order): run patch_reload1 first")

    a = ("  hard_reg_n_uses[HARD_FRAME_POINTER_REGNUM].uses += 2 * large + 2;\n"
         "  SET_HARD_REG_BIT (bad_spill_regs, HARD_FRAME_POINTER_REGNUM);\n")
    b = a + r"""
  if (nfs4_rl_trace ())
    {
      fprintf (stderr, "[reload-order] FUNCTION %s large=%d", current_function_name, large);
      for (i = 2; i <= 15; i++)
        fprintf (stderr, " r%d=%d/e%d", i, hard_reg_n_uses[i].uses,
                 (int) regs_explicitly_used[i]);
      fprintf (stderr, "\n");
    }
"""
    s = sub1(s, a, b, "reload-order census dump")
    wr(p, s)
    print("  reload1.c  [reload-order] patched")


# =========================================================================
DN_HELPER = r'''
/* ---- w76-A20 [distribute_notes] instrumentation ---- */
extern char *getenv ();
extern char *current_function_name;

static int nfs4_dn_trace ()
{
  static int t = -1;
  if (t < 0)
    {
      char *e = getenv ("GCC_TRACE_DISTRIBUTE_NOTES");
      t = (e && *e && *e != '0') ? ((*e == '2') ? 2 : 1) : 0;
    }
  return t;
}
/* ---------------------------------------------------- */

'''


def patch_distribute_notes(root):
    """w76-A20: the [distribute_notes] instrument -- combine.c's orphaned-REG_DEAD
    synthetic-USE emission (catalog 24E-6; the Night_CreateNightTableElement
    reg-137 mechanism, W75-A13 receipt in recon/game/psx/night.cpp).

    distribute_notes' REG_DEAD case walks BACKWARD from i3
    (`for (tem = prev_nonnote_insn (i3); place == 0 && tem && (INSN||CALL_INSN);
    tem = prev_nonnote_insn (tem))`, combine.c:11298 in the pristine file)
    looking for a home for the death note; when the walk is stopped by a
    non-INSN (a CODE_LABEL) with no home found, combine.c:11396 emits a
    synthetic `(use (reg))` after the stopper and hangs the note there.  That
    orphan USE is a SECOND death -> REG_N_DEATHS==2 -> the pseudo fails
    local-alloc.c:472 eligibility and loses its hard register.  NOTE the
    version asymmetry (W75-A13, ChangeLog-cited): the vendor-2.8.0 lane orphans
    Night's reg 137; FSF 2.8.1 (this lab) does NOT (Feb-1998 distribute_notes
    fixes) -- so on that fn this trace's value is the NEGATIVE certificate plus
    the =2 walk lines showing where 2.8.1 seats the note instead.

    Gated on its OWN env var GCC_TRACE_DISTRIBUTE_NOTES (so GCC_TRACE_ALLOC
    streams aren't flooded):
      =1  one line per ORPHAN emission:
          [distribute_notes] fn=<name> ORPHAN reg=<regno> i3=<uid>
              from_insn=<uid|-1> stopped_at=<rtxcode>:<uid> use=<uid>
      =2  additionally, one line per REG_DEAD note that ENTERS the place==0
          backward walk, with its final disposition:
          [distribute_notes] fn=<name> walk reg=<regno> i3=<uid>
              from_insn=<uid|-1> place=<uid|0> tem=<rtxcode>:<uid>|null kind=<n>
    combine runs BEFORE local_alloc's `===== FUNCTION =====` marker, hence the
    inline fn= field.  Patched into combine.c, which is shared backend -- BOTH
    cc1 and cc1plus pick it up on rebuild.
    """
    p = os.path.join(root, 'combine.c')
    s = rd(p)
    if MARK_DN in s:
        print("  combine.c  [distribute_notes] already patched"); return
    backup(p)

    # 1) K&R forward decl in the existing PROTO block
    s = sub1(s,
             "static void distribute_notes\tPROTO((rtx, rtx, rtx, rtx, rtx, rtx));\n",
             "static void distribute_notes\tPROTO((rtx, rtx, rtx, rtx, rtx, rtx));\n"
             "static int nfs4_dn_trace\tPROTO((void));\t/* w76-A20 */\n",
             "distribute_notes proto")

    # 2) helper definition just above distribute_notes' own comment block
    a = "/* Given a chain of REG_NOTES originally from FROM_INSN, try to place them\n"
    s = sub1(s, a, DN_HELPER + a, "dn helper def")

    # 3) the ORPHAN emission trace (=1) -- inside the emission block, after the
    #    basic_block_head fixup, while `tem` (the stopper) is still in scope.
    a = ("\t      if (REG_NOTE_KIND (note) == REG_DEAD && place == 0 && tem != 0)\n"
         "\t\t{\n"
         "\t\t  place\n"
         "\t\t    = emit_insn_after (gen_rtx (USE, VOIDmode, XEXP (note, 0)),\n"
         "\t\t\t\t       tem);\n"
         "\n"
         "\t\t  /* If this insn was emitted between blocks, then update\n"
         "\t\t     basic_block_head of the current block to include it.  */\n"
         "\t\t  if (basic_block_end[this_basic_block - 1] == tem)\n"
         "\t\t    basic_block_head[this_basic_block] = place;\n"
         "\t\t}\n")
    b = a[:-len("\t\t}\n")] + r"""
		  /* w76-A20 [distribute_notes] ORPHAN trace */
		  if (nfs4_dn_trace ())
		    fprintf (stderr,
			     "[distribute_notes] fn=%s ORPHAN reg=%d i3=%d from_insn=%d stopped_at=%s:%d use=%d\n",
			     current_function_name ? current_function_name : "?",
			     REGNO (XEXP (note, 0)), INSN_UID (i3),
			     from_insn ? INSN_UID (from_insn) : -1,
			     GET_RTX_NAME (GET_CODE (tem)), INSN_UID (tem),
			     INSN_UID (place));
		}
	      /* w76-A20 [distribute_notes] walk-outcome trace (verbose =2) */
	      if (nfs4_dn_trace () > 1)
		fprintf (stderr,
			 "[distribute_notes] fn=%s walk reg=%d i3=%d from_insn=%d place=%d tem=%s:%d kind=%d\n",
			 current_function_name ? current_function_name : "?",
			 GET_CODE (XEXP (note, 0)) == REG
			 ? (int) REGNO (XEXP (note, 0)) : -1,
			 INSN_UID (i3), from_insn ? INSN_UID (from_insn) : -1,
			 place ? INSN_UID (place) : 0,
			 tem ? GET_RTX_NAME (GET_CODE (tem)) : "null",
			 tem ? INSN_UID (tem) : -1,
			 (int) REG_NOTE_KIND (note));
"""
    s = sub1(s, a, b, "dn orphan trace")

    wr(p, s)
    print("  combine.c  [distribute_notes] patched")


# =========================================================================
if __name__ == '__main__':
    root = sys.argv[1] if len(sys.argv) > 1 else '.'
    print("patching gcc tree at %s" % os.path.abspath(root))
    patch_obstack(root)
    patch_global(root)
    patch_local_alloc(root)
    patch_reload1(root)
    patch_reload_pick(root)
    patch_reload_order(root)
    patch_distribute_notes(root)
    print("DONE")
