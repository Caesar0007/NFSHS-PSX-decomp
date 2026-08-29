/* syslib/psx/libgpu/FONT.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3; Ghidra
 *   mangled the id-bounds checks).  obj libgpu.lib(FONT.OBJ): the PsyQ debug-font printer.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) then
 *   measured strictly better per-fn diff counts than cc1 (C) on this TU. Do NOT revert to .cpp
 *   without a user decision; see recon/syslib/psx/libcd/cdread.c, recon/syslib/psx/libcd/iso9660.c
 *   and recon/eaclib/psx/eacpsxz/cdfs.c for the sibling KEEP-CPP-turned-uniform TUs (same ruling,
 *   same date).  [W52-A10: that C-vs-C++ penalty is now MOOT for FntFlush -- the C lane reaches
 *   6 diffs at an EXACT 199/199 instruction count once the reconstruction uses the real PsyQ
 *   types; the old gap was shape, not language.]  C89 dialect note: `bool wrap` -> `int wrap`
 *   and FntFlush's locals are plain declarations at function top with their computation in
 *   separate assignment statements (C89 forbids declarations after statements in a block).
 *
 *   A struct Font (0x30 B, array @0x80135E58, count @0x80135FD8, active id @0x80135FDC) is a
 *   self-describing text overlay: its first 16 bytes double as a TILE background-box primitive
 *   (tag/colour/x/y/w/h), its draw_mode heads the per-character sprite list, and buffer/written
 *   accumulate the formatted string.  FntPrint formats into buffer; FntFlush turns the text into
 *   8x8 font sprites and draws the OT.  The character glyph index is
 *   (c >= 'a' ? c - 0x40 : c - 0x20), laid out in a 16-wide 8x8 font texture.
 *
 *   `id` selects a stream: a valid (0 <= id < count) id is used directly, otherwise the active
 *   stream is used.  (Ghidra rendered the bounds as the impossible `id<0 || id>=-1` -- disasm
 *   gives the real test.) */

typedef unsigned long  u_long;
typedef unsigned char  u_char;
typedef unsigned short u_short;

#include <stdarg.h>
#include <stddef.h>   /* NULL */

extern void  TermPrim(void *p);          /* libgpu P09 @0x80107020 */
extern void  AddPrim(void *ot, void *p); /* libgpu P06 @0x80107040 */
extern void  DrawOTag(u_long *ot);       /* libgpu SYS @0x800EDCB4 */
extern unsigned strlen(const char *s);   /* libc C27 (returns int in the original) */

typedef struct {                /* TILE (libgpu.h) : the bg-box primitive, 0x10 bytes */
    u_long tag;
    u_char r0, g0, b0, code;
    short  x0, y0;
    short  w,  h;
} TILE;

typedef struct {                /* DR_MODE (libgpu.h) : 0x0C bytes */
    u_long tag;
    u_long code[2];
} DR_MODE;

typedef struct {                /* SPRT_8 (libgpu.h) : one 8x8 glyph, 0x10 bytes */
    u_long  tag;
    u_char  r0, g0, b0, code;
    short   x0, y0;
    u_char  u0, v0;
    u_short clut;
} SPRT_8;

struct Font {                   /* 0x30 bytes; @0x80135E58 + id*0x30 */
    TILE     tile;              /* +0x00 : bg-box primitive (code != 0 => draw box) */
    DR_MODE  draw_mode;         /* +0x10 : sprite OT head ('this') + tpage/clip words */
    int      capacity;          /* +0x1C : text capacity */
    SPRT_8  *sprites;           /* +0x20 : per-character sprite buffer */
    char    *buffer;            /* +0x24 : accumulated text */
    int      written;           /* +0x28 : current text length */
    int      unwrap;            /* +0x2C : auto-fit the clip box to the text */
};

/* W66-A3 (link): the stream array IS in the image; the splat blob emits it under
 * the project label `Font` (data_8010CCD4_r17.data.s, symbol_addrs Font=0x80135E58).
 * Alias the PsyQ spelling onto it -- name-only, no second copy. */
extern struct Font _fnt[8] __asm__("Font"); /* @0x80135E58 : open font streams */
extern int _fnt_count __asm__("D_80135FD8");          /* @0x80135FD8 : number of open streams */
extern int _fnt_active __asm__("D_80135FDC");         /* @0x80135FDC : current active stream id */
extern char *D_801369E4;        /* @0x801369E4 : "0123456789ABCDEF" */

/* @0x800F6D18 : convert a stream's accumulated text into font sprites and draw the OT.
 * An out-of-range id falls back to the active stream; if THAT stream has no text buffer
 * (never opened) the call is a no-op returning NULL.
 *
 * MATCH (W52-A10, 2026-08-09): 184 -> 6 diffs, instruction count now EXACT 199/199 and the
 * frame EXACT (0x50, every stack slot at the oracle's offset: dr@0x10 xscreen@0x14 max_y@0x18
 * r@0x1C g@0x20 b@0x24).  Four independent shape corrections, each gate-measured; the whole
 * previous "allocator coloring cascade / weak floor" diagnosis below was WRONG -- it was
 * RECONSTRUCTION SHAPE all the way down (same lesson as P34/SetDrawMove this wave).
 *
 *   (1) REAL PsyQ TYPES instead of byte-offset casts (the big one, 184 -> 36).  struct Font is
 *       a TILE (0x00) + DR_MODE (0x10) + fields, and the glyph cursor is an `SPRT_8 *`, not a
 *       `u_char *` walked with `p += 0x10`.  Writing `p->u0/v0/x0/y0/r0/g0/b0` + `AddPrim(dr,
 *       p++)` and `AddPrim(dr, &fs->tile)` gives the oracle's addressing for free; the old
 *       hand-rolled `*(short *)(p + 8)` form cost registers and a bigger frame.  Declaration
 *       order is psyz's (dr, font, x/y, xscreen, max_y, sprt, max_x, unwrap, len,
 *       line_break, buf, ch2, ch, u/v, r/g/b) -- that IS the oracle's stack-slot order.
 *   (2) SPLIT LOAD FROM ADD for max_x (methodology 3.12 #15b): `max_x = font->tile.w;
 *       max_x = x + (short)max_x;` loads `w` into its own temp early and lets gcc
 *       schedule the `addu $s7,$s1,$v0` into the TermPrim jal's delay slot, exactly as retail.
 *   (3) SIGNED-CHAR TYPING of the text cursor (36 -> 13).  `signed char *buf` + `signed char
 *       ch` (NOT `u_char *` / `int`): the escape-digit reads `16 * (*++buf - 48)` then emit
 *       the oracle's sign-extending `lb`, the loop-carried char is a QImode pseudo loaded with
 *       `lbu` and sign-extended per use (`sll 24; sra 24` -- the oracle's shared-delay-slot
 *       pair in the a-z/else arms of do_char), and `ch2 = ch;` replaces the wrong `ch2 = ch &
 *       0xFF` (which emitted an `andi` retail does not have).  cc1 defaults `char` to
 *       UNSIGNED on this toolchain (04M/w47-a10), so the `signed` keyword is load-bearing.
 *   (4) LOOP TAIL ORDER `++buf; len--; ch = *buf; if (!ch) break;` (13 -> 6, and the count
 *       became exact).  Retail's test block is `addiu $s0,1; addiu $fp,-1; lb; lbu; bnez`,
 *       i.e. the capacity countdown sits BEFORE the reload where it fills the load-delay slot
 *       (psyz's `ch = *++buf; if (!ch) break; len--;` put it in the branch delay slot
 *       instead, costing a nop AND blocking the entry-test cross-jump).  With this order gcc
 *       cross-jumps the peeled entry test into the bottom block, reproducing retail's single
 *       `j` loop entry.  `len` is dead after the loop, so the extra decrement on the
 *       final iteration is semantically free.
 *
 * LADDER (04U, re-run on the NEW source -- the verdict changed with the shape, so re-ladder
 * after any large rewrite): wired lane (2.8 + maspsx + no_split_addresses + jtbl_at_fusion)
 * 6 diffs; ladder lane 2.6.0 108 / 2.6.3 104 / 2.7.2-970404 39 / 2.7.2 91 / 2.8.0 39 /
 * 2.8.1 39 / 2.91.66 213 / 2.95.2 170.  KEEP THE WIRED LANE.
 *
 * RESIDUAL 6, two classes, both count-neutral:
 *   (a) 4 diffs -- retail floats `sw $a2,0x1C(sp)` / `sw $a2,0x20(sp)` (the r/g defaults)
 *       ABOVE the ten callee-save stores; ours emits them after.  Pure sched2 ready-list
 *       ordering inside the prologue block.  FALSIFIED: all six init-order permutations of
 *       `maxx/r/g/b` (m,r,g,b = 6 -- best; r,m,g,b 6; r,g,m,b 6; m,b,g,r 8; r,g,b,m 10;
 *       b,g,r,m 10) -- the two stores never move across the save block.
 *   (b) 2 diffs -- the TermPrim argument: retail RELOADS `dr` from its stack slot
 *       (`sw $a2,0x10(sp); lw $a0,0x10(sp)`) while ours keeps it live in $a2 and copies
 *       (`addu $a0,$a2,$zero`).  This is reload INHERITANCE (retail's dr pseudo had no hard
 *       reg at the call, so the arg setup became a load that sched hoisted to the top).
 *       FALSIFIED: assigning `dr` immediately before the call, and calling
 *       `TermPrim(&fs->draw_mode)` directly -- both still 6.  Known no-source-lever class
 *       (catalog: choose_reload_regs / reload-inheritance identity).
 *
 *   W53-A12 re-attack, NO MOVEMENT (6 both before and after; recorded so the ground is not
 *   re-walked).  The 4-diff half is purely a sched2 POSITION question: retail issues the two
 *   `sw $a2,0x1C/0x20($sp)` (r and g) between `addiu $sp` and the callee-save block, i.e.
 *   sched2 floated them ABOVE the whole prologue save run, and puts b's store in the `bltz`
 *   delay slot.  Falsified this wave: five further init ORDERS on top of the six already
 *   recorded -- r,g,b then maxx (10); r,g / maxx / b (6); r / g / maxx / b (6); b,g,r then
 *   maxx (10); the chained `r = g = b = 0x80` (10) -- and three FENCE placements, which is
 *   the instrument the catalog names for a sched-issue-position residual: a void-tail
 *   `__asm__("" : : "i"(0))` after the colour block (9, +1 insn), the same before `maxx`
 *   (6), and a read-only fence on `id` (9, +1 insn).  MECHANISM NOTE explaining why the
 *   fence cannot win here: a fence is a BARRIER, so it can stop an insn from moving but
 *   cannot make one float FURTHER up -- and the stores must move UP, past the prologue.
 *   r/g/b are stack AUTOs (not register-resident), so every fence form that touches them
 *   also costs the +1 `lw` the cost profile predicts.  NAMED NEXT ANGLE: make the colour
 *   defaults register-resident for their whole live range (they are only spilled because
 *   the glyph loop re-reads them), then the zero-cost fence forms become available; or dial
 *   sched2's ready list via the dependence chain of the FIRST post-prologue insn.
 *
 *   W61-A4 -- THE (a) HALF IS SOLVED: 6 -> 2, count still EXACT 199/199.  W53-A12's own
 *   mechanism note ("a fence is a BARRIER, so it can stop an insn from moving but cannot make
 *   one float FURTHER up -- and the stores must move UP, past the prologue") is exactly the
 *   signature of a PER_FN_TEXT_MOVES row, not of a source lever: the residual IS a pure line
 *   relocation.  Retail emits `li $a2,0x80; sw $a2,0x1C($sp); sw $a2,0x20($sp)` BEFORE the ten
 *   callee-save stores; cc1 emits both stores after them (and after `sw $zero,0x14($sp)`).
 *   Relocating exactly those two lines reproduces retail's prologue verbatim -- same class as
 *   the landed W60-A3 `_BlitClear` row (sched2 emission position, expressed as a relocation).
 *   Probe-verified through the gate's own code (scratchpad/w61a4, W60_TEXT_MOVES_FILE hook on
 *   a scratchpad copy of tools/vprobe.py; run twice, identical).  Anchors are label-agnostic
 *   (no `$L<n>`) and the `li` anchor tolerates the trailing hex comment, per the W60 12F craft
 *   rules; `sw $6,28($sp)` occurs exactly ONCE in the region, so the two rows cannot collide.
 *   ORCHESTRATOR WIRING (I cannot edit tools/*.py):
 *       PER_FN_TEXT_MOVES["recon/syslib/psx/libgpu/FONT.c"] = {
 *           "FntFlush": [
 *               {"take": r"\tsw\t\$6,28\(\$sp\)\n", "after": r"\tli\t\$6,128[^\n]*\n"},
 *               {"take": r"\tsw\t\$6,32\(\$sp\)\n", "after": r"\tsw\t\$6,28\(\$sp\)\n"},
 *           ],
 *       }
 *   RESIDUAL 2 = the (b) reload-inheritance half only, re-tested in the NEW basin per 04Z
 *   (rung tables and lever verdicts are basin-relative) and all still falsified:
 *   `TermPrim(&fs->draw_mode)` 2 (inert) / dropping the `dr` local entirely 14 /
 *   void-tail fence before the call 9 (and -1 insn) / read-only fence on `dr` 45 (+1 insn).
 *   VERSION AXIS CLOSED per-FUNCTION too (W61-A4, the 12G flag-dropping splice applied to the
 *   maspsx lane, both fns spliced): 2.6.3 = 98/183 | 2.7.2 = 74/173 | 2.7.2-970404 = as-fails |
 *   2.8.0 = 6/4 (FntPrint WORSE) | 2.8.1 (wired) = 6/3 | 2.91.66 = 182/255 | 2.95.2 = 156/243.
 *   No rung to wire; the whole-TU NFS4_FORCE_CC1_ALT path still cannot reach the sub-2.8 rungs
 *   at all (it does not drop `-mno-split-addresses`), only the per-fn splice can.
 *
 *   W55-A8 re-attack on the (b) reload-inheritance half, STILL 6 (recorded so the ground is
 *   not re-walked a third time): `volatile DR_MODE *dr` + `(void *)` casts at the three use
 *   sites = 6 (no movement -- the volatile view does force a reload, but sched hoists it to
 *   exactly where our register copy already sat); `DR_MODE * volatile dr` (volatile POINTER,
 *   i.e. a real stack home for dr) = 21 / 202 insns (spills at every use); and one more
 *   colour-init order (r,g then maxx then b) on the (a) half = 6.  Both halves remain what
 *   the W52/W53 receipts say they are.
 *
 *   W64-A3 -- FntPrint RE-VERIFIED PASS 240/240 (the W63 TEXT_MOVES row is wired and
 *   holding).  FntFlush's PLACEMENT axis re-probed in THIS 2-diff basin, all reverted:
 *   a void-tail fence immediately after `dr = &fs->draw_mode;` 2 (inert) * `dr` assigned
 *   just before the call instead of at the top 2 (inert) * `TermPrim(dr)` hoisted above
 *   the whole field-load block 27 (200 insns) * an identity launder on `dr` right before
 *   the call 45 (200 insns) * a void-tail fence right before the call 9 (198 insns).
 *   MECHANISM (so the next belt starts from the right place, not from spellings): the
 *   `dr` pseudo is SPILLED, so its def emits an output reload into $a2 plus the store,
 *   and reload1.c's choose_reload_regs then satisfies the call-argument input reload by
 *   INHERITING $a2 (it still validly contains the pseudo).  Retail did not inherit, i.e.
 *   in retail $a2 was no longer valid at that point.  Nothing in this block writes $a2
 *   (all eight following field loads are long-lived and take callee-saved registers), so
 *   the named angle is unchanged and precise: manufacture a SHORT-LIVED value between the
 *   spill and the call that the allocator must put in $a2 -- the 14C intruder-eviction
 *   device -- and the inheritance is invalidated for free.  There is no such value in the
 *   source today, and a hard-register clobber fence is pin-adjacent (user sign-off).
 *
 *   W71-A10 (2026-08-21) -- RE-GATED 2 @199/199 (twice), and the W64-A3 mechanism note
 *   above is re-confirmed: nothing in the field-load block can be turned into a
 *   short-lived $a2 value from source.  FALSIFIED this pass (all gated, all reverted):
 *   split-load for `boty` (`boty = fs->tile.h; boty = cury + (short)boty;`) 2, inert *
 *   `boty` computed BEFORE `rightx` 13 @198 (it eats the TermPrim delay-slot `addu
 *   $s7,$s1,$v0` -- the W52 lever (2) is order-sensitive, do not reorder that pair) *
 *   `dr = &_fnt[id].draw_mode;` instead of `&fs->draw_mode` 13 @200 (re-derives the array
 *   address) * `dr` assigned after `p = fs->sprites;` 2, inert * removing the blank line
 *   before `TermPrim(dr)` (i.e. no statement-group change at all) 2, inert.
 *   The window between the `dr` spill and the call contains ONLY the eight long-lived
 *   field loads (all callee-saved, no reloads), so there is no reload for $a2 to collide
 *   with; the two short-lived values that DO exist there (`fs->tile.w`, `fs->tile.h`)
 *   already take $v0/$v1 in BOTH builds.  The angle stays exactly as W64-A3 named it.
 *
 *   W72-A19 (2026-08-22) -- RE-GATED 2 @199/199 (twice).  The residual is now READ OFF the
 *   two streams exactly and it is NOT a scheduling position at all: BOTH builds hoist the
 *   `$a0` setup to the SAME insn index (43/44, twelve insns ahead of `jal TermPrim`); the
 *   only difference is its FORM and its order against the spill store --
 *       ours   : addiu $a2,$s3,16 ; addu $a0,$a2,$zero ; sw $a2,16($sp)
 *       retail : addiu $a2,$s3,16 ; sw $a2,16($sp)     ; lw  $a0,16($sp)
 *   i.e. reload1.c's choose_reload_regs satisfies the call's input reload by INHERITING the
 *   output-reload register $a2 (it still validly holds the pseudo), where retail re-loaded
 *   from the spill slot.  Every zero-insn device this campaign owns was swept against it and
 *   ALL are catastrophic, because $a2 is a reload/spill register FUNCTION-WIDE here (catalog
 *   16B: an asm-used hard reg enters reload1.c's bad_spill_regs for the whole function) --
 *   FALSIFIED, all gated, all reverted: 20B clobber launder "$6" on `dr` 68 @201 * on `p`
 *   42 * on `text` 38 * read-only fence on `dr` with "$6" 69 @200 * the 20A void clobber
 *   `__asm__ __volatile__("" : : : "$6")` before the call 41 @198 * a plain identity launder
 *   on `dr` 45 @200 * an 'm'-operand fence on `fs->draw_mode` 9 @198 * on `dr` itself (which
 *   forces a REAL stack home) 16-20 @201 in every position * a volatile pointer VIEW at the
 *   TermPrim site only `*(DR_MODE * volatile *)&dr` 38 (and at all four `dr` uses 38) * a
 *   non-volatile pointer view 38.  STATEMENT-LEVEL cells, also falsified: the colour-default
 *   block moved below `dr = &fs->draw_mode;` (to put an $a2-scratch store between the spill
 *   and the call -- the 14C intruder the W64 note asks for) 16 @199; `boty` computed after
 *   `dr` 2 (inert); one extra spilled field-load statement (`remain`) moved in front of the
 *   call 4 @199.
 *   The W64-A3 angle therefore stands, now with its cost bound: the intruder must occupy $a2
 *   in the [spill .. call] window WITHOUT naming $a2 in an asm (naming it forbids retail's own
 *   spill use), so the only remaining vehicles are (a) a real short-lived C value that the
 *   allocator independently puts in $a2 -- none exists in the eight-load window -- or (b) a
 *   build-side per-fn mechanism.  TEXT_MOVES cannot express it: the two instructions differ in
 *   OPCODE (`addu` vs `lw`), not in position.
 *
 *   W74-A17 (2026-08-23) -- RE-GATED 2 @199/199 (twice).  THE MECHANISM IS NOW PROVEN BY
 *   EXPERIMENT AND THE INVALIDATOR IS NAMED FROM THE COMPILER SOURCE, which turns the W64-A3
 *   "manufacture an intruder in $a2" angle into a precise, quantified certificate.
 *   🔴 RELOAD-INHERITANCE INVALIDATORS ARE AN EXHAUSTIVE, READABLE LIST (reload1.c, gcc-2.8.1
 *   source at C:/Temp/gcc-2.8.1-src/extracted).  choose_reload_regs inherits an input reload
 *   from `reg_last_reload_reg[regno]` only while `reg_reloaded_contents[i] == regno`
 *   (reload1.c:5514-5586).  That record is cleared in exactly four places, and NOTHING else
 *   in the pass touches it:
 *       (a) a CODE_LABEL          -- "a reload reg's contents are unknown after a label"
 *                                    (reload_as_needed, reload1.c:4208);
 *       (b) a CALL_INSN           -- for every call-used spill reg (:4217);
 *       (c) another reload that lands in the same spill reg (emit_reload_insns, :6929);
 *       (d) INSN_CLOBBERS_REGNO_P -- not defined by the MIPS backend, so unavailable here.
 *   There is no flag: `for (inheritance = optimize > 0; ...)` (reload1.c:5418) means -O2
 *   always tries inheritance first.
 *   ✅ PROOF PROBE (gated, reverted): inserting a branch between `dr = &fs->draw_mode;` and
 *   `TermPrim(dr)` (`if (remain == 0x7FFFFFFF) return (u_long *)0;`) makes the region come out
 *   as retail's `addiu $a2,$s3,16 ; sw $a2,16($sp) ; lw $a0,16($sp)` VERBATIM -- the CODE_LABEL
 *   kills the inheritance and the input reload becomes the spill-slot load.  So the residual is
 *   understood completely; it is not a scheduling or coloring question at all.
 *   ⛔ WHY NO ZERO-INSN VEHICLE EXISTS: (a) needs a real branch (+2 insns, and jump.c deletes a
 *   label whose only reference is a fall-through goto BEFORE reload runs); (b) needs a call;
 *   (c) needs another SPILLED pseudo to be reloaded into $a2 inside the window -- the eight
 *   field loads there are all long-lived and take callee-saved registers, and the only $a2-using
 *   spill stores in the function are the colour defaults; (d) is absent on MIPS.  Naming "$6"
 *   in an asm is the one remaining way and is self-defeating (catalog 16B: an asm-used hard reg
 *   enters reload1.c's bad_spill_regs FUNCTION-WIDE, which forbids retail's own $a2 spill).
 *   FALSIFIED THIS PASS (all gated, all reverted -- the (c) route, which the W64/W71/W72 notes
 *   named but never actually ran): moving exactly ONE colour default into the window so its
 *   `li $6,128; sw $6,N($sp)` invalidates $a2 -- `b` after `dr` 7 @200, `g` after `dr` 5 @200,
 *   `r` after `dr` 5 @200, `b` just before `TermPrim` 7 @200, `g` just before `TermPrim` 5 @200,
 *   `g`+`b` together 7 @200 (each costs +1 insn AND disturbs the wired PER_FN_TEXT_MOVES
 *   anchors, which key off `li $6,128` / `sw $6,28($sp)` / `sw $6,32($sp)`); `maxx = 0;` moved
 *   after `dr` 4 @199 and before `TermPrim` 4 @199 (count-exact but worse -- its store is
 *   `sw $zero,...` and uses no reload register at all, so it cannot invalidate anything).
 *   VERDICT: the 2-diff residual is a CERTIFIED reload-inheritance identity with no source
 *   vehicle.  The only remaining expression is build-side, and it is NOT TEXT_MOVES (the two
 *   words differ in opcode); it needs a per-fn textual REWRITE of one line
 *   (`addu $4,$6,$0` -> `lw $4,16($sp)`) plus the adjacent swap -- i.e. the same class as the
 *   W67 "PER_FN_POST_MASPSX_MOVES" mechanism that _padInitDirSeq is waiting on.
 *
 *   🔴🔴 W75-A15 (2026-08-23) -- RE-GATED 2 @199/199 (twice), and THE W74-A17 MECHANISM
 *   ATTRIBUTION IS REFUTED BY THE COMPILER'S OWN DUMP.  The residual is NOT choose_reload_regs
 *   inheritance.  RECEIPT: the `-dg` post-reload RTL dump (scratchpad/w75/a15_FONT_base.greg,
 *   printed by toplev.c BEFORE reload_cse_regs runs -- that is what makes it the discriminator)
 *   contains, adjacent and in this order:
 *       (insn 547 (set (mem:SI (plus (reg sp) (const_int 16))) (reg:SI 6 a2)))
 *       (insn 117 (set (reg:SI 4 a0) (mem:SI (plus (reg sp) (const_int 16)))))
 *   i.e. RELOAD ALREADY EMITS RETAIL'S `sw $a2,16($sp) ; lw $a0,16($sp)` VERBATIM -- there is no
 *   inheritance and never was.  The copy is manufactured afterwards by **reload_cse_regs**
 *   (toplev.c:3501, `if (optimize > 0)`, NO -f switch), whose reload_cse_simplify_set
 *   (reload1.c:8178) rewrites `(set hardreg MEM)` into a copy from the LOWEST-NUMBERED hard reg
 *   whose recorded value equals that MEM (scan `for (i = 0; i < FIRST_PSEUDO_REGISTER; i++)` at
 *   :8203, gated only by MEMORY_MOVE_COST >= 2 and REGISTER_MOVE_COST == 2, both fixed on MIPS).
 *   $a2 still holds the value from the store, so the load becomes `move $4,$6`; sched2 then
 *   swaps it above the store, giving our final `addu $a0,$a2,$zero ; sw $a2,16($sp)`.  This is
 *   the SAME pass W72/W74 identified for _dws/_drs in libgpu/SYS.c (catalog 23A-2) -- FntFlush
 *   is its MEM flavour: the tell is `addu rD,rS,zero` where retail has a `lw` from a slot the
 *   SAME register was stored to earlier in the same label/call-free region.
 *   WHY THE CORRECTION MATTERS (and why no source device can win): reload_cse_regs runs on the
 *   FINAL hard-register stream, and its value record for $a2 is cleared in exactly three places
 *   (reload1.c:7899 CODE_LABEL -- "forget all the register values at a code label"; :7929
 *   CALL_INSN for every call_used reg; :7786 reload_cse_invalidate_rtx via note_stores, i.e. any
 *   insn that WRITES $a2 or stores to an aliasing MEM).  The store and the load are ADJACENT in
 *   the post-reload stream by construction (output reload of `dr`, then the call's input
 *   reload), so there is NO WINDOW for any of the three -- which is why W74's branch probe
 *   worked (it planted a CODE_LABEL, +2 insns) and why every colour-default relocation costs
 *   +1 insn.  Naming "$6" in an asm remains self-defeating (16B bad_spill_regs function-wide).
 *   FALSIFIED THIS PASS (all gated, all reverted): the ZERO-INSN PRESERVED-LABEL device
 *   `{ void *lp = &&term; (void)lp; } term:` before the call (and its `if (lp == 0) goto term;`
 *   variant) -- 2 @199, INERT: the dead label-address set is DCE'd and jump.c then deletes the
 *   label, so no CODE_LABEL survives to reload_cse (the device is real but needs an escaping
 *   reference, which costs code -- recorded so it is not re-invented); the ZERO-INSN
 *   ADDRESS-TAKING device `(void)&dr;` (three positions) -- 38 @199 count-exact, and the
 *   side-by-side shows WHY it cannot win: dr leaves the spilled-pseudo pool for the
 *   address-taken-scalar pool (16A frame-order sub-law) so its slot moves 16 -> 36 and every
 *   other slot shifts, AND cse store-forwards the memory home anyway, so the copy survives.
 *   PER-FN VERSION LADDER re-measured in THIS basin (04Z basin-relativity; maspsx-lane
 *   PER_FN_CC1_VER_SPLICE): 2.6.3 98 @201 | 2.7.2 85 @200 | 2.7.2-970404 27 @200 |
 *   2.8.0 2 @199 (ties the wired 2.8.1) | 2.91.66 178 @205 -- no rung wins, even though the
 *   23A-2 version fingerprint says 2.6.x/2.7.2 LACK reload_cse_regs entirely: those rungs lose
 *   the whole-fn shape.  VERDICT (unchanged in value, corrected in mechanism): a 2-diff
 *   CERTIFIED reload_cse_regs identity.  🔴 UNDER THE 2026-08-23 USER POLICY (post-recompile
 *   instruction rewrites FORBIDDEN) the only expression this residual ever had is now OFF the
 *   table: the 23D-2 pre-flight FAILS anyway (the two words differ in OPCODE, so the diff is
 *   not a line-multiset permutation and no relocation row could express it), and the W74 "per-fn
 *   POST-cc1 line rewrite / PER_FN_POST_MASPSX_MOVES" ask is exactly the forbidden class.  What
 *   remains legitimate is a COMPILER-INPUT lane -- and the 23A-2 fingerprint says the pass is
 *   ABSENT on 2.6.x/2.7.2, so a rung that lacks reload_cse_regs would fix it for free IF its
 *   whole-fn codegen matched; measured here, none does (ladder above).  That is the standing
 *   angle: a cc1 rung (or a rebuilt cc1) that is 2.8.0 in every pass EXCEPT reload_cse_regs.
 *   🔑 TREE-WIDE: any standing
 *   "reload-inheritance" verdict should be re-checked the same way -- the `-dg` dump is printed
 *   BEFORE reload_cse_regs, so `.greg` showing the ORACLE's insn while the `.s` shows ours is a
 *   one-run proof that the actor is reload_cse_regs, not reload.
 *
 *   🏆 W76-A15 (2026-08-23) -- HELD at 2 @199/199 (gated twice); the W75 certificate is now
 *   PROVEN SUFFICIENT by a one-variable compiler experiment, and every remaining input-lane
 *   angle is measured shut:
 *   (1) §24B DONOR-CLOBBER FAMILY MEASURED AND FALSIFIED ON THIS SITE (the brief's ask; the
 *       W64 16B prediction confirmed by gate, all reverted): A14 __adddf3-recipe anchored
 *       clobber `__asm__("" : : "r"(dr) : "$6")` after `dr = &fs->draw_mode;` 68 @201; the
 *       same just before `TermPrim(dr)` 69 @200; ARG-LAUNDER `("" : "=r"(dr) : "0"(dr))`
 *       before the call 45 @200; launder+"$6" 68 @201.  Root cause of the blowups: the donor
 *       $a2 is a RELOAD register here (not an allocated pseudo's home as in __adddf3), so any
 *       asm naming "$6" poisons bad_spill_regs FUNCTION-WIDE (16B) and every reload in the fn
 *       re-deals; the launder alone costs the +1 the count cannot absorb (24B-2).
 *   (2) RAW40 (PsyQ 4.0 cc1; reachable -- FONT.c IS a maspsx-lane TU -- and never tried):
 *       whole-fn 84 diffs, frame 80 vs 120 -- the PADSEQD whole-fn scope rule FAILS, lane
 *       inapplicable.  (Probe note: the 1996 cc1 rejects `-mno-split-addresses`; the raw40
 *       branch's _flags40 filter must also strip it for any no_split_addresses TU.)
 *   (3) FLAG AXIS CLOSED (15 rungs via vprobe_flag, never measured for this fn):
 *       -fcaller-saves / -fno-function-cse / -fforce-mem / -fno-peephole / -fno-defer-pop /
 *       -fno-cse-follow-jumps / -fno-thread-jumps / -fno-rerun-cse-after-loop all INERT at 2;
 *       -fno-strength-reduce 4 @199; -fforce-addr 13 @198; -fno-cse-skip-blocks 15 @204;
 *       -fno-schedule-insns2 21 @202; -fno-schedule-insns 52 @201; -fno-delayed-branch
 *       48 @215; -fno-expensive-optimizations 92 @205.
 *   (4) VENDOR COMPARANDUM (psyz, PSY-Q 4.0 matched decomp, decomp/src/libgpu/font.c:303,
 *       HEAD 6d47e5e): FntFlush's matched source is SHAPE-IDENTICAL to ours at the site
 *       (`dr = &font->draw_mode;` -> the eight field loads -> `TermPrim(dr);`) -- the source
 *       shape is vendor-confirmed; the residual is toolchain identity, not source.
 *   (5) 🏆 SUFFICIENCY PROOF (instrument lab, scratchpad/w76/a15_lab_{base,norcse}_fn.s):
 *       scratch/gccsrc/gcc-2.8.1/toplev.c:3501 is now env-guarded
 *       (`getenv("GCC_NO_RELOAD_CSE")`, behavior unchanged when unset; cc1 rebuilt in
 *       scratch/gccbuild-ecoff).  Pass ON: the lab reproduces our defect VERBATIM
 *       (`move $4,$6` above the sw).  Pass OFF (GCC_NO_RELOAD_CSE=1): the SAME binary emits
 *       retail's `sw $6,16($sp); lw $4,16($sp)` -- AND the two colour-default stores
 *       `sw $6,28/32($sp)` move to retail's early position, i.e. the exact two lines the
 *       wired w61-a4 PER_FN_TEXT_MOVES rows relocate.  The whole-region diff is exactly
 *       those two effects and nothing else.  ⇒ Sony's internal lib rung = a 2.8-shape cc1
 *       WITHOUT reload_cse_regs (pre-970404 dev snapshot); a sanctioned no-rcse rung would
 *       seal FntFlush AND retire both TEXT_MOVES rows.
 *
 *   W78-root (2026-08-26) -- SOURCE/COMPILER-IDENTITY PASS 199/199.  The user confirmed that
 *   syslib's original per-object compiler-version identities belong in the source-level gate.
 *   tools/build.py now selects the hash-pinned 2.8.1 no-reload-CSE compiler only for FntFlush,
 *   using the exact proven vendor-style flags.  Its complete FntFlush region is accepted under
 *   a narrow structural contract even though that compiler faults while beginning FntPrint.
 *   Normal and NFS4_SOURCE_ONLY gates both PASS 199/199; strict_branch is CLEAN for all 20
 *   branch words, FntPrint remains PASS 240/240, and PER_FN_TEXT_MOVES stays empty. */
extern u_long *FntFlush(int id)
{
    DR_MODE  *dr;
    struct Font *font;
    int    x, y;
    int    xscreen;
    int    max_y;
    SPRT_8 *sprt;
    int    max_x;
    int    unwrap;
    int    len;
    int    line_break;
    signed char *buf;
    int    ch2;
    signed char ch;
    u_char u, v;
    int    r, g, b;

    xscreen = 0;
    r = 0x80; g = 0x80; b = 0x80;       /* default glyph colour */

    if (!(id >= 0 && id < _fnt_count)) {
        struct Font *act = &_fnt[_fnt_active];
        if (act->buffer == NULL)
            return NULL;
        id = _fnt_active;
    }
    font = &_fnt[id];
    dr = &font->draw_mode;

    sprt  = font->sprites;
    unwrap = font->unwrap;
    buf   = (signed char *)font->buffer;
    len   = font->capacity;
    x     = font->tile.x0;
    y     = font->tile.y0;
    max_x = font->tile.w;
    max_x = x + (short)max_x;     /* split load from add: w lands in its own temp */
    max_y = y + font->tile.h;

    TermPrim(dr);
    ch = *buf;
    while (ch) {
        if (!len) break;
        line_break = 0;
        ch2 = ch;
        if (ch2 != ' ') {
            if (ch2 <= ' ') {
                switch (ch2) {
                case 9:  goto do_tab;
                case 10: goto set_linebreak;
                }
                goto do_char;
            } else if (ch2 == '~') {
                if (*++buf == 'c') {
                    r = 16 * (*++buf - 48);
                    g = 16 * (*++buf - 48);
                    b = 16 * (*++buf - 48);
                }
            } else {
                goto do_char;
            do_tab:
                x += 0x20;
                goto check_x;
            do_char:
                ch = *buf;
                if (ch >= 'a' && ch <= 'z') ch2 = ch - 0x40; else ch2 = ch - 0x20;
                u = (ch2 % 16) * 8;
                v = (ch2 / 16) * 8;
                sprt->u0 = u;
                sprt->v0 = v;
                sprt->x0 = x;
                sprt->y0 = y;
                sprt->r0 = r;
                sprt->g0 = g;
                sprt->b0 = b;
                AddPrim(dr, sprt++);
                x += 8;
            check_x:
                if (x >= max_x && !unwrap) {
                set_linebreak:
                    line_break = 1;
                }
            }
        } else {
            x += 8;
            if (x >= max_x && !unwrap) line_break = 1;
        }
        if (line_break) {
            if (xscreen < x) xscreen = x;
            y += 8;
            x = font->tile.x0;
            if (y >= max_y) break;
        }
        ++buf;
        len--;
        ch = *buf;
        if (!ch) break;
    }
    if (font->tile.code) {                              /* draw the background box */
        AddPrim(dr, &font->tile);
        if (unwrap) {
            unwrap = xscreen;
            font->tile.w = unwrap - font->tile.x0;
            font->tile.h = y - ((u_short)font->tile.y0 - 8);
        }
    }
    DrawOTag((u_long *)dr);
    font->written = 0;
    *font->buffer = 0;
    return (u_long *)dr;
}

/* @0x800F7034 : printf-style append into a stream's text buffer (%x/%X/%c/%d/%s + width).
 * Psy-Q also accepts the format string itself as the first argument, selecting the active stream.
 * NEAR-MISS (W56, 80 -> 3 diffs; ours 239 / retail 240): retail mutates the variadic `id`
 * parameter itself, which produces its stack home and fixes the whole active-stream entry path.
 * A signed-byte zero-pad flag removes the spurious mask; statement-ordering the width clamp
 * before `bufPtr`, keeping the explicit sign `else`, and staging the `%c` vararg through a
 * block-local pointer match the remaining large regions.  The dependency-shaped preloop
 * `percent = ch ^ (ch ^ '%')` is mathematically constant but delays pseudo birth just enough for
 * GCC 2.8.x to allocate retail s4='%' / s5=0xCCCCCCCD.  The final residual is only reorg's
 * filled initial zero-check slot (retail nop) plus jump2 reusing v0=-1 instead of rematerializing
 * a2=-1.  Hand-rolled vararg pointer bumps remain required; stdarg `va_arg` regresses. */
#define WriteChar(c)                                                        \
    fs->buffer[fs->written++] = (c);                                        \
    if (fs->written > fs->capacity) {                                       \
        return -1;                                                          \
    }

extern int FntPrint(const char *id, ...)
{
    char buf[0x200];
    va_list args;
    struct Font *fs;
    signed char padZeros;
    int num;
    int len;
    int width;
    signed char *f;
    char *bufPtr;
    char sign;
    unsigned int ch;
    int percent;

    va_start(args, id);
    if ((int)id < 0 || (int)id >= _fnt_count) {
        f = (signed char *)id;
        id = (const char *)_fnt_active;
        if (_fnt[(int)id].buffer == NULL)
            return -1;
    } else {
        f = *(signed char **)args; args = (void *)((char *)args + 4);
    }

    fs = &_fnt[(int)id];
    if (fs->written > fs->capacity)
        return -1;

    ch = *f;
    if (ch == 0)
        goto fnt_done;
    /* MATCH (W63-A3, 3 -> 2 and the count became EXACT 240/240): retail leaves the
     * `beqz $a0` zero-check delay slot EMPTY; reorg steals `percent`'s `li $s4,37`
     * from the fall-through thread into it (fill_slots_from_thread), so ours ran one
     * instruction short.  A void-tail fence at the HEAD of that thread is the one
     * instrument that reaches reorg (stop_search_p returns 1 at any asm) and it is
     * zero-insn.  Placement variants all measure identically (2/240): fence before
     * this block, fence inside it, and a read-only fence on `ch`; the void-tail form
     * is kept because it neither adds a ref nor names a value. */
    __asm__("" : : "i"(0));
    {
        percent = ch ^ (ch ^ '%');
    }
    for (; ch; ch = *++f) {
        if (ch != percent) {
            WriteChar(ch);
            continue;
        }

        ch = *++f;
        if (ch == percent) {
            WriteChar(percent);
            continue;
        }

        width = 0;
        padZeros = ch == '0';
        while (ch >= '0' && ch <= '9') {
            width = (width * 10) + (ch - '0');
            ch = *++f;
        }
        if (width <= 0)
            width = 1;
        bufPtr = (char *)&args;

        switch (ch) {
        case 'd':
            num = *(int *)args; args = (void *)((char *)args + 4);
            if (num < 0) {
                num = -num;
                sign = '-';
            } else {
                sign = 0;
            }
            len = 0;
            do {
                do {
                    *--bufPtr = (num % 10U) + '0';
                    num /= 10U;
                    len++;
                } while (len == 0);
            } while (num != 0);
            if (sign != 0) {
                *--bufPtr = sign;
                len++;
            }
            break;

        case 'X':
        case 'x':
            len = 0;
            num = *(int *)args; args = (void *)((char *)args + 4);
            do {
                do {
                    *--bufPtr = D_801369E4[num % 16U];
                    num /= 16U;
                    len++;
                } while (len == 0);
            } while (num != 0);
            if (padZeros) {
                while (len < width) {
                    *--bufPtr = '0';
                    len++;
                }
            }
            break;

        case 'c': {
            int *arg = (int *)args;
            --bufPtr;
            *bufPtr = (char)*arg;
            args = (void *)(arg + 1);
            len = 1;
            break;
        }

        case 's':
            bufPtr = *(char **)args; args = (void *)((char *)args + 4);
            len = strlen(bufPtr);
            break;
        }

        while (len < width) {
            WriteChar(' ');
            width--;
        }
        /* MATCH (W63-A3): retail materializes the loop sentinel FRESH
         * (`addiu $a2,$zero,-1`) where every natural spelling of this countdown
         * gives us a COPY of the peel's -1 (`addu $a2,$v0,$zero`) -- cse's
         * constant-sharing: at the sentinel's DEF a register already holds -1, and
         * cse substitutes it (the launder protects USES, so a sentinel declared
         * INSIDE the guard is still copied).  Cure = give the sentinel its own
         * pseudo BEFORE the peel test, then identity-launder it so cse can neither
         * fold it back nor feed it to the peel's own compare -- both -1s are then
         * materialized independently, exactly retail's instruction set.
         * FALSIFIED first (all gate-measured, this basin): the plain comma-peel
         * (2), explicit peel with two literal -1 (2), laundered sentinel declared
         * inside the guard (2), void-tail fence between peel and loop (2),
         * read-only fence on len (2), peel spelled `len >= 0` (3, loses retail's
         * own `li $v0,-1`), un-laundered sentinel before the peel (5), laundered
         * sentinel used in BOTH tests (7), double launder (64).
         * The residual after this edit is a PURE ONE-LINE RELOCATION (`li $6,-1`
         * belongs after the peel branch, not before it) -- probe-verified TWICE as
         * PASS 240/240 with the PER_FN_TEXT_MOVES row below (scratchpad/w63a3):
         *     "recon/syslib/psx/libgpu/FONT.c": {
         *         "FntPrint": [
         *             {"take":  r"\tli\t\$6,-1[^\n]*\n",
         *              "after": r"\tbeq\t\$5,\$2,\$L\d+\n"},
         *         ],
         *     }
         * (the FONT.c entry already exists for FntFlush -- ADD this key to it;
         * a duplicate rel key would silently shadow the earlier entry, 12F). */
        /* MATCH (W78 source-only, 2 -> PASS 240/240): retire that relocation.
         * Decrement first, then birth and launder the peel sentinel in a nested
         * block; the loop sentinel is born only on the taken path.  This orders
         * `addiu a1,-1; li v0,-1; beq; li a2,-1` directly from C. */
        {
            {
                int peel;
                len--;
                peel = -1;
                __asm__("" : "=r"(peel) : "0"(peel));
                if (len != peel) {
                    int neg1 = -1;
                    do {
                        WriteChar(*bufPtr++);
                        len--;
                    } while (len != neg1);
                }
            }
        }
    }
fnt_done:
    fs->buffer[fs->written] = 0;
    return fs->written;
}
#undef WriteChar
