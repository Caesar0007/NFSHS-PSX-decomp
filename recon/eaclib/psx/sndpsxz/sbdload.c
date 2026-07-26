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
                    abs = bankData + off4 + *(int *)(cur4 + 0x14);
                    *(int *)(cur4 + 0x14) = abs;
                } else {
                    abs = anchor + off2 + *(int *)(cur2 + 0xc);
                    *(int *)(cur2 + 0xc) = abs;
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
     *      separate arg temp and a per-arm abs were all tried (46/42/37+1insn). */
    return ret;
}
