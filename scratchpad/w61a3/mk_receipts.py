"""Span-based receipt insertion: ASCII-only anchors, byte mode, match-count asserts."""
import os
import sys

CR = b'\r\n'
P = 'recon/syslib/psx/libmcrd/LIBMCRD.c'


def J(*ls):
    return CR.join(ls) + CR


data = open(P, 'rb').read()
orig_len = len(data)


def replace_span(start_anchor, end_anchor, new_text):
    """Replace [start_anchor .. end_anchor] inclusive; both must be unique."""
    global data
    assert data.count(start_anchor) == 1, ('start anchor count', data.count(start_anchor))
    assert data.count(end_anchor) == 1, ('end anchor count', data.count(end_anchor))
    i = data.find(start_anchor)
    j = data.find(end_anchor) + len(end_anchor)
    assert j > i, 'anchors out of order'
    data = data[:i] + new_text + data[j:]


def insert_before(anchor, new_text):
    global data
    assert data.count(anchor) == 1, ('anchor count', data.count(anchor))
    i = data.find(anchor)
    data = data[:i] + new_text + data[i:]


# ---------------- MemCardDeleteFile : replace the stale w60-a2 FALSIFIED paragraph --------
replace_span(
    b'     * swap (47 -> 17 with 8 read-only fence operands) does NOT reach this fn',
    b'the minimal MULTI-pseudo delta, instead of hand-dialling one pseudo at a time. */',
    J(b'     * W61-A3: THE w60-A2 NAMED ANGLE IS CLOSED -- 57 -> 23.  The "a three-way rotation',
      b'     * cannot be expressed by a single-pseudo delta" verdict was true and beside the point:',
      b'     * a rotation is a TOTAL ORDER, so dial every pseudo that has to move, at once, and',
      b'     * price it with tools/reqdelta272.py (the real 2.7.2 rule pri = floor_log2(refs)*refs',
      b'     * / live -- NO size term; the old gcc-2.8 pricing was wrong on this lane).  Retail order',
      b'     * file > retry > chan > base, predicted handout == measured handout (qty272.py):',
      b'     *   file  refs 2 -> 4  (2 fence operands)              pri 0.222 -> 0.889  -> $s0',
      b'     *   retry refs 7 -> 9  (1 operand INSIDE the loop, x2) pri 0.241 -> 0.466  -> $s1',
      b'     *   chan  refs 4 -> 8  (2 operands INSIDE the loop)    pri 0.131 -> 0.393  -> $s2',
      b'     *   base  untouched                                    pri 0.246          -> $s3',
      b'     * (57 -> 47 on this step alone.)',
      b'     *',
      b'     * The `file` fence sits ABOVE the busy guard on purpose.  There it ALSO forces',
      b'     * assign_parms` file copy into the prologue group (retail`s `sw $s0,56($sp);',
      b'     * addu $s0,$a1,$zero`) instead of leaving it the last insn before the guard load, where',
      b'     * reorg steals it into the `beqz` slot and retail`s `retry = 0` can never land there.',
      b'     * Same fence, same operand count, 6 diffs apart, purely by POSITION (29 -> 23).',
      b'     *',
      b'     * SECOND ANCHOR (47 -> 37 -> 34): retail runs the head guard off one materialization',
      b'     * ($s3) and hands it to a SECOND pointer ($s0, `addu $s0,$s3,$zero` in the loop',
      b'     * preheader, which frees $s3 for the hoisted `li 2`).  A PLAIN `p = base;` reproduces',
      b'     * it -- cse2-after-loop rewrites the hoisted `&mc.cmd` as a reg COPY of the live base.',
      b'     * An opacity fence on `p` is WORSE (37 vs 34): it makes `*p` may-alias `_mc_save_cb`,',
      b'     * so sched1 can no longer hoist retail`s `lw $v1,0($s0)` above that store.  Cost of the',
      b'     * plain form: `p[3]` is a LOAD at a non-zero offset through a known-constant pointer,',
      b'     * so cse constant-folds it back to the `lui;lw` macro (2 of the remaining 23).  STORES',
      b'     * at non-zero offsets do NOT fold, which is why p[0..2] stay base-relative.',
      b'     *',
      b'     * EXIT-BLOCK PLACEMENT, catalog 12C (34 -> 29): retail`s `erase() != 0` success block is',
      b'     * the LAST block before the epilogue (`j <epi>; nop`, then a bare `addu $v0,$zero,$zero`',
      b'     * falling into it).  Written inline in the loop, gcc emits it right after the busy-return',
      b'     * block and displaces `retry = 0`.  `goto erased;` + the block placed after `return rslt;`',
      b'     * is the zero-cost fix.',
      b'     *',
      b'     * REMAINING 23 = the inlined-MemCardSync anchor class (15, see that fn`s receipt) + the',
      b'     * p[3] fold (2) + tail scheduling.  FALSIFIED in this basin: retry fence moved out of',
      b'     * the loop (29, inert); MemCardSync`s base fence dropped (42) or made non-volatile',
      b'     * (identical); a shared `static __inline__ int *mc_anchor(void)` so both fences share ONE',
      b'     * source line (48 -- see MemCardSync). */'))

# ---------------- MemCardCreateFile ----------------
insert_before(
    b'    int *base = &mc.cmd;\r\n    __asm__ __volatile__("" : "=r"(base) : "0"(base));\r\n'
    b'    __asm__("" : : "r"(file), "r"(file));',
    J(b'    /* W61-A3 68 -> 30: the MemCardDeleteFile recipe ported (read that receipt for the laws).',
      b'     * Retail band file=$s0, retry=$s1, base=$s2 (-> $s0 via the preheader copy), chan=$s3,',
      b'     * blocks=$s4, hoisted `li 2` inherits $s2.  Priced with reqdelta272 in STEPS, because',
      b'     * the second anchor re-writes the table (04Z: re-price after every structural landing):',
      b'     *   p = base (second anchor) + file fence 2 operands ......... 81  (file=$s0 only)',
      b'     *   chan +2 refs (1 operand in the loop) ..................... 65  (chan/blocks fixed)',
      b'     *   retry +6 refs (3 operands in the loop) ................... 39  (retry over base)',
      b'     *   file fence moved ABOVE the guard + `goto created` tail .... 34',
      b'     *   `if (0) { nocard: return 7; }` after the return-6 block ... 30',
      b'     * The 3rd retry operand bought exactly ONE step: at 11 refs retry priced 0.4783 against',
      b'     * base`s 0.4800 -- reqdelta272 named the +1 ref and the gate confirmed 65 -> 39.',
      b'     * FALSIFIED here (DeleteFile measures the opposite way, so A/B per function): dropping',
      b'     * the base opacity fence 39 -> 68; `p = &mc.cmd` instead of `p = base` 39 -> 60.',
      b'     * REMAINING 30: the inlined-MemCardSync anchor class (15), the `p[0]`-load-vs-',
      b'     * `_mc_save_cb`-store schedule the opaque base costs us (8; DeleteFile is free of it',
      b'     * because its base is plain), and the `li $a1,1` open() argument position. */'))

# ---------------- MemCardGetDirentry ----------------
insert_before(
    b'     * REFINED NAMED ANGLE (unclaimed): retail is ASYMMETRIC about _mc_chan -- it READS it off',
    J(b'     * W61-A3 69 -> 44 WITH NO ANCHOR LOCAL AT ALL (so the frame stays 0x90 and the whole',
      b'     * "the base anchor costs a 9th saved reg" objection above evaporates).  The base register',
      b'     * retail uses is the COMPILER`S OWN cse-created base for the `mc` struct -- our build',
      b'     * already has it ($s2); it was merely ranked one place too high.  qty272 named the pair:',
      b'     *   base   refs 16 / live 100 / pri 0.6400',
      b'     *   idx    refs 11 / live  51 / pri 0.6470   (sits in the gap)',
      b'     *   fretry refs 10 / live  49 / pri 0.6122',
      b'     * The window between idx and base is 0.007 wide, so fretry cannot be lifted into it on',
      b'     * its own -- lift BOTH by one ref (two 1-operand read-only fences at loop depth 0, right',
      b'     * after `idx = 0` and `fretry = 0`): idx -> 0.7059 ($s1), fretry -> 0.6735 ($s2), base',
      b'     * unchanged at 0.6400 ($s3) = retail.  69 -> 54.',
      b'     * LAW: when a pair will not flip because a THIRD allocno sits in the gap, move the third',
      b'     * one up as well -- only the ORDER matters, never the absolute priorities.',
      b'     * Then the guard written blez-side (`if (mc.cmd > 0) printf; else latch`, the same shape',
      b'     * MemCardCreateFile/DeleteFile already use) puts the latch block out-of-line: 54 -> 44.',
      b'     * REMAINING 44: (a) the $t0/$t1 local-QTY swap on the `max` reload and on `files`;',
      b'     * (b) retail hoists the movstrsi end pointer `addiu $t0,$sp,80` into the preheader and',
      b'     *     SPILLS it (`sw $t0,0x60($sp)`, reloaded inside the copy loop) while ours recomputes',
      b'     *     it -- that missing spill slot is also why our `files` param lands at 0x60($sp) and',
      b'     *     retail`s at 0x5C($sp); (c) the _mc_chan read/write asymmetry named just below.'))

assert len(data) > orig_len
tmp = P + '.tmp'
open(tmp, 'wb').write(data)
os.replace(tmp, P)
print('ok %d -> %d bytes' % (orig_len, len(data)))
