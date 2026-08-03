/* eaclib/psx/sndpsxz/sbdload.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbdload.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010266C.  iSNDdownloadbank -- resolve (DMA to SPU) every patch in a bank, rebasing each
 *   patch's self-relative pointer to an absolute address.  Ghidra nfs4-f.exe.c (sbdload).
 *
 *   Patch ptrs are stored as offsets relative to their own field (+0x14 for bank type 4, else +0xc):
 *   abs = fieldAddr + offset.
 */

extern int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch);   /* stagpat */

extern int iSNDdownloadbank(int bankData, int patchData);   /* @0x8010266C */

/* iSNDdownloadbank @0x8010266C : rebase + resolve all patches of the bank at `bankData`.  Returns 7 (all
 *   ok) or 8 (a patch failed). */
extern int iSNDdownloadbank(int bankData, int patchData)
{
    /* SHAPE (from the IDA per-variable register annotations of sub_8010266C, w32):
     *   v3 $s6=ret  v4/v6 $s0=ONE counter shared by the clear loop and the scan loop
     *   v7 $s5=off2  v8 $s2=cur2  v9 $s3=off4  v10 $s1=cur4  $fp=anchor  $s4=bankData
     *   v11 $v0=off  v12 $v0=abs.
     * Two facts this pinned down, both worth generalizing:
     *  - the two cursors are INT variables dereferenced at a CONSTANT byte displacement
     *    (`*(int *)(cur4 + 0x14)`), not `int *` walkers indexed `[5]`;
     *  - the 255-down-counter and the scan counter are ONE variable.  Splitting them into two
     *    locals drops that pseudo's ref count below the cursors' and re-colors the whole frame
     *    (i lands in $s2, cur2 in $s0); sharing it restores the oracle's $s0.
     * The do/while (NOT a label+goto loop) is also load-bearing: the front end's loop notes are
     * what make flow.c weight in-loop refs by loop depth, and that weighting is the ONLY thing
     * that lifts the short-lived loop constants above the long-lived base copies -- it is what
     * puts off4 in $s3 ahead of bankData in $s4, and type4 in $s7 ahead of anchor in $fp.
     * (A goto-loop gets the displacements right, see the residual below, but loses the weighting
     * and mis-colors four callee-saved registers; measured 46 diffs vs 42 here.) */
    int scratch[512];
    int i;
    int ret = 7;
    int anchor, type4, off2, off4;
    int cur2, cur4;
    int off, abs;

    i = 0xff;
    do {
        scratch[i * 2] = -1;
        i--;
    } while (i >= 0);

    anchor = bankData;
    if (*(unsigned short *)(bankData + 6) != 0) {
        i = 0;
        type4 = 4;
        off2 = 0xc;
        cur2 = bankData;
        off4 = 0x14;
        cur4 = bankData;
        do {
            if (*(unsigned char *)(bankData + 4) == type4)
                off = *(int *)(cur4 + 0x14);
            else
                off = *(int *)(cur2 + 0xc);
            if (off != 0) {
                if (*(unsigned char *)(bankData + 4) == type4) {
                    *(int *)(cur4 + 0x14) = bankData + off4 + *(int *)(cur4 + 0x14);
                    abs = *(int *)(cur4 + 0x14);   /* read-back: cse forwards -> retail's addu copy */
                } else {
                    *(int *)(cur2 + 0xc) = anchor + off2 + *(int *)(cur2 + 0xc);
                    abs = *(int *)(cur2 + 0xc);
                }
                if (iSNDresolvetaggedpatch(abs, patchData, (int)scratch) != 7)
                    ret = 8;
            }
            off2 += 4;
            cur2 += 4;
            off4 += 4;
            i++;
            cur4 += 4;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
    }
    /* RESIDUAL 42 diffs, 84/84 insns.  All nine callee-saved assignments now match the oracle;
     * what is left is ONE loop.c decision plus its fallout:
     *  (a) loop.c strength-reduces each cursor biv into its +0x14 / +0xc giv and eliminates the
     *      biv, so ours walks `bankData+0x14` and loads `0(s1)` where retail keeps the plain
     *      cursor and loads `0x14(s1)`.  Retail's object shows NO strength reduction at all
     *      (four parallel +4 counters survive, and `bankData+off4` is recomputed alongside the
     *      cursor that already holds the same address) -- the §3.25-3d per-obj flag identity
     *      (-fno-strength-reduce class), not a source shape.
     *      🔬 w33-a6 QUANTIFIED THE IDENTITY (this source, unchanged, one flag flipped):
     *        -fno-strength-reduce ............ 42 -> 23 diffs (85 insns vs 84)
     *        -fno-schedule-insns ............. 64   -fno-schedule-insns2 ........ 52
     *        -fno-cse-follow-jumps / -fno-expensive-optimizations / -fno-thread-jumps /
     *        -fno-force-mem .................. 42 (all diff-neutral)
     *      Under -fno-strength-reduce ALL NINE callee-saved assignments AND both cursor shapes
     *      land exactly: `addu s1,s4,zero` + `lw v0,20(s1)` and `addu s2,s4,zero` + `lw v0,12(s2)`,
     *      i/cur2 stop swapping $s0<->$s2, and (b) below disappears entirely.  The 23 that remain
     *      are: the scratch-clear loop (which NEEDS strength reduction -- with SR off it degrades
     *      to `sll v0,s0,3; addu v0,v1,v0; sw a0,0(v0)`, +1 insn, vs the oracle's descending
     *      `sw v1,0(v0); addiu v0,v0,-8` walker), the (c) merge copy, and two scheduling slots.
     *      => sbdload.obj wants SR OFF for the patch loop and ON for the clear loop, i.e. this is a
     *      genuine per-obj cc1 identity, not a whole-TU flag we could adopt even if flags were on
     *      the table (W30 rule 6: record, do not flip).  Also tried and rejected as a source-side
     *      SR escape: writing the clear loop as an explicit descending `int *p` walker -- it removes
     *      the clear loop's SR dependence (84 insns under -fno-SR) but costs `i` its extra ref, so
     *      i/cur4 swap $s0<->$s1 (38 under -fno-SR, 44 under normal flags).  Earlier rejects: goto-loop
     *      (kills SR but loses the loop-depth ref weighting -> 46), for(;;)/while(1)+break (42,
     *      identical), `int *`+[5] indexing (42, identical), volatile cursor derefs (55, +1 insn).
     *  (b) with the bivs gone the giv pseudos out-rank the counter, so i/cur2 swap $s0<->$s2.
     *  (c) the oracle spends one extra `addu a0,v0,zero` at the arm merge; ours coalesces abs
     *      straight into $a0 (the classic ours-1-shorter merge copy).  In-place `abs +=`, a
     *      separate arg temp and a per-arm abs were all tried (46/42/37+1insn).
     *  🟢 2026-07-27 inline: the w33-a6 identity is now ADOPTED as a PER-TU FLAG
     *  (tools/build.py PER_TU_FLAGS "no_strength_reduce", same precedent as movf.c's
     *  no_schedule_insns): 42 -> 23 diffs with THIS source untouched.  The 23 = the clear
     *  loop's no-SR degradation (+1 insn, indexed sll/addu vs retail's -8 walker), the (c)
     *  merge copy, and two scheduling slots.  ATTACKED AND FALSIFIED on top of the flag
     *  (full matrix, all at 84/84 unless noted): explicit i+p walker clear loop 50 (fixes
     *  the loop shape but i loses its index ref -> i/cur2 s0<->s2 swap); walker + zero-trip
     *  guard 36 (i climbs to s1; residual = pure i/cur4 s0<->s1, i at 15refs/46len=0.978 vs
     *  cur4 33/33=1.0 -- needs exactly +1 ref or -1 len); walker+guard+cur2-early 40
     *  (bankData s4->s5); walker+guard+cur-set-swap 42; (i=0)-inside-the-guard-expression
     *  52 (loses the ref); indexed loop + zero-trip guard 47 (overshoots).  The 36-state's
     *  i/cur4 tie is THE remaining lever target if a zero-cost +1 i-ref is ever found;
     *  until then the plain body + flag at 23 stands.
     *  W34-a6 re-verdict, with the wave's NEW evidence class (NFS2 PC-beta named source): the
     *      floor STANDS.  `pc-split` has no iSNDdownloadbank file, but nfsw.IDA.c's sub_483468 IS
     *      it (NFS2 SYM `iSNDdownloadbank_` @0x483468).  That older generation writes the scratch
     *      clear as an ASCENDING index loop (`for (i = 0; i != 768; v14[i] = -1) i += 3;` -- stride
     *      3, 256 entries) and the patch loop with ONE byte-offset induction variable added to
     *      base+constant, not four parallel cursors.  Neither matches the PSX oracle (descending
     *      clear walker; four +4 cursors), i.e. EA rewrote the function between generations, so the
     *      NFS2 source does NOT supply the "different loop shape" that would reopen this.  The
     *      per-obj SR identity (clear loop needs SR ON, patch loop needs it OFF) is unchanged.
     *
     *  🏆 W47-a4: 23 -> 14 diffs (86 insns / oracle 84) -- residual class (c) SOLVED by
     *  STORE-THEN-READ-BACK (catalog w43/w44/w45).  Retail computes the rebased pointer into $v0,
     *  STORES it, and only then copies it to the call's $a0 (`addu v0,v0,v1; sw v0,20(s1);
     *  addu a0,v0,zero`); our `abs = base + off + *field; *field = abs;` computed straight into $a0
     *  and was one insn short at BOTH arms.  Writing the store first and then reading the field BACK
     *  into `abs` makes cse forward the just-stored value as a register COPY -- retail's exact
     *  three-instruction shape, in both arms, and it also fixed the a0/v0 colouring of the whole
     *  merge.  (This is the same lever family the w31/w32 notes above were looking for under the
     *  name "old-gcc no-copy-prop identity"; it is source-reachable after all.  The earlier
     *  in-place `abs +=` / arg-temp / per-arm-abs attempts all wrote the VALUE into a variable --
     *  the load-bearing detail is that the second read must come from MEMORY, i.e. from the field
     *  that was just written.)
     *  RE-TESTED IN THE NEW BASIN (lever-order-dependence law): walker clear loop 31 (was 50),
     *  bound-load-before-`i++` via a named `nents` local 14 (diff-neutral, reverted -- sched1
     *  re-floats the lhu below the increment regardless of statement position).
     *  REMAINING 14 = the clear loop's -fno-strength-reduce degradation (`sll s0,3; addu` + a
     *  separate `li -1` vs retail's `sw v1,0(v0); addiu v0,v0,-8` descending walker, +1 insn), the
     *  `addu fp,s4,zero` delay-slot occupant that follows from it, and the loop-tail `lhu`/`addiu`
     *  issue order (+1 nop).  All three are downstream of the SAME per-obj SR identity already
     *  documented above -- the clear loop wants SR ON while the patch loop wants it OFF. */
    return ret;
}
