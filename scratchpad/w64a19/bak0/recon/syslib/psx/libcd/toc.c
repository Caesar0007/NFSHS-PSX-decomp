/* syslib/psx/libcd/toc.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(TOC.OBJ): CdGetToc / CdGetToc2 -- read the disc Table-Of-Contents.
 *
 *   CdGetToc2 issues CdlGetTN (command 0x13) to learn the first/last track numbers, then CdlGetTD
 *   (command 0x14) once per track to fetch each track's MSF start, filling `loc[]` (one CdlLOC per
 *   track, lead-in entry first).  Track numbers are exchanged in BCD.  CD_debug>=2 prints a trace.
 *
 *   Binary quirk reproduced verbatim: the value fed back to CdSyncCallback() at every exit is the
 *   CdlGetTN result ($s6), NOT the callback CdSyncCallback(0) returned (which is discarded) -- the
 *   original captured the wrong register.  The function returns the track count - 1 (nTrack). */

typedef unsigned char u_char;
struct CdlLOC { u_char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;

/* ---- libcd public API (cdcont.cpp) / libc ----------------------------------------------------- */
extern int  CdControlB(u_char com, u_char *param, u_char *result); /* @0x800F7B24 */
extern int  CdSyncCallback(int func);                              /* @0x800F788C */
extern int  printf(const char *fmt, ...);                         /* libc C63 @0x801028AC */

/* ---- driver debug level (DRV.OBJ) ------------------------------------------------------------- */
extern int CD_debug;   /* @0x8013BF50 */

/* W60-A4: retail VA order -- CdGetToc @0x8010929C precedes CdGetToc2 @0x801092C0. */
extern int CdGetToc2(int n, CdlLOC *loc);

/* @0x8010929C : CdGetToc -- convenience wrapper, loc[] points at the caller's CdlLOC array. */
extern int CdGetToc(CdlLOC *loc)
{
    return CdGetToc2(1, loc);
}

/* @0x801092C0 : CdGetToc2 -- fill loc[] with the MSF start of every track (lead-in entry first).
 *
 * MATCH: shape transplanted from the byte-exact Rage Racer decomp
 * (C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\initialization_and_toc.c,
 * CdGetToc2) -- same PsyQ libcd TU, matched in plain C.  Load-bearing pieces:
 *   - `save = CdSyncCallback(0);`  The oracle captures $v0 in the FOLLOWING
 *     `jal CdControlB`'s DELAY SLOT (`jal ...; addu $s6,$v0,$zero`), i.e. the
 *     value live BEFORE that call = CdSyncCallback's return (methodology 3.1).
 *     The previous recon read it as "the CdlGetTN result -- the original
 *     captured the wrong register"; that note was the delay-slot trap and is
 *     retracted.  This is a real DATAFLOW fix, not just a matching lever.
 *   - the TOC entries are written through a `u_char *` walking pointer with a
 *     `u_long` load temp, in the oracle's byte order  [0] , [2]=0 , [1] .
 *   - the track loop is a GUARDED do-while (`if (first <= last) { ptr = toc+4;
 *     do {...} while (first <= last); }`), and the debug loop likewise
 *     (`if (nTrack >= 0) do {...} while (i <= nTrack);` -- the oracle's
 *     `bltz` guard).
 *   - every error exit is DUPLICATED inline (no shared `err:` label).
 * FALSIFIED in this basin (measured, do not retry): (a) the FULL Rage Racer
 * body -- u_char* walking-pointer stores with a `u_long` load temp, guarded
 * do-while loops, duplicated inline error exits, `ptr` reused to carry
 * `count-1` -- reaches the oracle's EXACT 137 instructions but rotates the
 * whole s-register handout (71 -> 112 diffs; RR needs `register u_char *ptr
 * asm("$17")` to land it, and asm register pins are forbidden here,
 * methodology 3.13); (b) spelling `track_first / 10` as its literal
 * multiply-high with a named `0x66666667` local to get the oracle's
 * preheader-hoisted magic in $s5 (71 -> 80 at 139 insns).
 * RESIDUAL (71): ours uses 6 callee-saved regs where the oracle uses 7 -- the
 * oracle hoists the /10 magic reciprocal into $s5 and puts `save` in $s6,
 * ours rematerializes the magic in the loop and puts `save` in $s5, so ours
 * is 3 instructions short (the $s6 save/restore pair + one hoist half).
 *
 * W60-A4 (64 -> 56): MAGIC-RECIPROCAL SHARING (catalog 09H) partially landed.
 *   A named `int magic = 0x66666667;` plus a ZERO-INSN READ-ONLY FENCE on it at the
 *   TOP OF THE TRACK-LOOP BODY (in-loop => +2 refs => callee-saved rank) reproduces
 *   retail's preheader hoist EXACTLY: `sw s5,52(sp); lui s5,26214; ori s5,s5,26215`
 *   and the 7-callee-saved-register frame.  That alone retires the whole
 *   s0/s1/s2/s5/s6 band rotation the previous basin carried.
 *   POSITION IS THE DIAL, measured: fence at the TOP of the function = 66 diffs but
 *   count-EXACT 137/137 (the magic lands in a caller-saved $t0 and the loop still
 *   rematerializes its own); fence in the loop = 56 at 139 (+2); fence at BOTH places
 *   = 56; the magic local with NO fence = 64 (inert, identical to the pre-W60 form);
 *   a 2-operand read-only fence = 69.
 * W61-A7 (56 -> 4, count EXACT 137/137): three cooperating dials, each measured.
 *   (1) THE MAGIC LOCAL'S *ASSIGNMENT* POSITION IS A DIAL IN ITS OWN RIGHT (w60-a4 swept
 *       only the FENCE position).  `magic = 0x66666667;` as the FIRST statement of the
 *       function puts its `lui/ori` in the block that ENDS with the loop-entry test, so
 *       sched1 feeds the two halves into that block's load-delay nops and the pair
 *       straddles the branch.  Moving the assignment down to the loop PREHEADER puts it
 *       where retail has it: 56 -> 40 and the count becomes EXACT.
 *   (2) THE GUARDED do-while (Rage Racer's shape, `if (first <= last) { magic = ...;
 *       do {...} while (first <= last); }`) is what makes the preheader a real block, so
 *       `li s2,1` (i = 1) lands in retail's branch DELAY SLOT and the magic halves stay
 *       together after the branch: 10 -> 4.
 *   (3) THE +2-REF DIAL ON track_first, priced with tools/reqdelta272.py (NOT guessed):
 *       global.c allocated the loop CURSOR (11 refs / live 30 / pri 1.10) before
 *       track_first (15 / 60 / 0.75), so ours took $s1 for track_first where retail has
 *       $s0 -- a 14-diff two-register swap.  reqdelta272 `--flip` printed the exact
 *       requirement "refs 15->17 (+2, CROSSES a floor_log2 step)"; adding track_first as
 *       a SECOND OPERAND of the in-loop read-only fence buys exactly +2 (in-loop = x2)
 *       and the whole swap resolves: 40 -> 10.  The two rivals do not conflict, so
 *       track_first then shares $s0 with the (dead-by-then) result-buffer pointer and the
 *       cursor is pushed to $s1 -- retail's handout, register for register.
 * RESIDUAL 4 (the ONLY diff left, ours 139 / oracle 137): the hoisted $s5 magic is still
 *   NOT SHARED with the division's own expansion -- we emit `lui v0,26214; ori v0,v0,26215;
 *   mult s0,v0` inside the loop where retail has the bare `mult s0,s5`.  MECHANISM (this
 *   is now a precise claim, not a guess): the fenced `magic` pseudo is set in the PREHEADER
 *   block and the division's constant is loaded in the LOOP-BODY block; gcc-2.7.2's cse
 *   works per extended basic block and the loop body is a multi-predecessor block, so cse
 *   never learns that the live $s5 already holds 0x66666667, and loop.c does not hoist the
 *   division's own const load (removing the magic local entirely proves this: 18 diffs at
 *   135 insns -- no hoist at all, and the frame loses a callee-saved register).
 *   FALSIFIED for the sharing (all measured in THIS basin, all still 4 diffs / 139 insns,
 *   i.e. INERT): the fence moved AFTER the division statement; `track_first / 10` spelled
 *   twice so the constant has two uses; a split `tens = track_first / 10;` statement.
 *   FALSIFIED and WORSE: the explicit multiply-high `(int)(((long long)track_first * magic)
 *   >> 32)` driven off `magic` -- 73 diffs at 140, because 2.7.2 expands the DImode form as
 *   a FULL 64-bit multiply (`mfhi` AND `mflo` + an extra shift pair), not the `smulsi3
 *   highpart` retail uses; dropping the magic local and fencing only track_first, 18 @135.
 *   NEXT ANGLE (named): the only remaining route is to make loop.c hoist the DIVISION's own
 *   const load (retail's actual mechanism) instead of carrying a second value -- i.e. a
 *   loop.c-level instrument (`-dL` loop dump on the lane binary, which W60-A1 proved
 *   CC1PSX accepts) to find why the invariant `(set (reg) (const_int 1717986919))` is not
 *   in `move_movables`' list here. */
extern int CdGetToc2(int n, CdlLOC *loc)
{
    int track_first;
    int track_last;
    u_char param[4];
    u_char result[4];
    int save;                 /* $s6 : previous sync callback, restored at every exit */

    int i;
    int nTrack;
    int magic;               /* MATCH (W60-A4): magic-reciprocal hoist, see above */

    /* 🔴 W63-A5 -- W62-A6's MECHANISM CITATION IS REFUTED, and the real one is now READ
     * OFF THE COMPILER, not inferred.  W62 blamed loop.c `scan_loop`'s "potential
     * lossage" rule (2.8.1 loop.c:738-755, the reg_single_usage / validate_replace_rtx
     * path).  That rule never fires here: `-dL` on the lane binary (CC1PSX accepts it,
     * W60-A1; driver = tools/qty272.py, which writes the .loop dump) prints
     *
     *     Loop from 147 to 250: 31 real insns.
     *     Insn 154: regno 117 (life 1), move-insn savings 1 not desirable
     *     Insn 154: possible biv, reg 117, const = 1717986919      <- 0x66666667
     *
     * i.e. the division's own constant IS entered as a movable (so it was NOT
     * substituted-and-deleted); it is `move_movables` that DECLINES it at loop.c:1640
     *
     *     already_moved[regno] || (threshold * savings * m->lifetime) >= insn_count
     *
     * with `threshold = (loop_has_call ? 1 : 2) * (1 + n_non_fixed_regs)` (loop.c:535 --
     * this loop HAS a call, so the x2 is lost), savings = 1, lifetime = 1 and
     * insn_count = 31.  The verdict is a pure budget miss, and the dump gives the exact
     * shortfall: ONE unit of `savings` or of `lifetime` on THAT movable flips it.
     * NEXT ANGLE (precise, replaces W62's): buy savings/lifetime on the DIVISION's own
     * const movable -- `force_movables` (loop.c:1195-1232) doubles savings and adds
     * lifetimes when another movable's set_src chains off it, and `combine_movables`
     * merges equal invariants; lifetime is the luid distance from the const's set to its
     * single use, currently adjacent.
     * MEASURED in this basin: putting `magic = 0x66666667;` INSIDE the loop makes it a
     * second movable that combine_movables merges with reg 117 -- the hoist LANDS and the
     * count becomes EXACT 137/137 -- but the whole s-band rotates (54 diffs; fence
     * variants there: 1-operand track_first 18 @135, 3-operand 18 @135, magic-only 70,
     * no fence 64 @135, fence-before-assignment 22 @137).  That basin is structurally
     * right and 14 diffs from being better than this one; it is the recommended
     * re-entry point, together with the -dL numbers above.
     * (The cse-scope observation below still stands as the reason our PREHEADER `magic`
     * pseudo is not itself the sharer.)
     * W62-A6 FALSIFIED (all re-gated in the landed basin): `magic = 0x66666667;` moved
     * INTO the loop body as its first statement 54 / after the fence 22 / in-loop with
     * the magic operand dropped from the fence 18 @135 / duplicated preheader+in-loop 54
     * / `magic = magic;` in the loop INERT 4.  Trying to give the constant a SECOND use
     * so the lossage rule stops firing is also dead: `(track_first - (track_first / 10) *
     * 10)` spelled out, and the same via a named `tens` local, are both INERT at 4 -- cse
     * runs BEFORE loop and merges the two divisions back into one.  Control re-gate:
     * dropping the magic local entirely is now 64 @135 (the w60-a4 receipt's 18 is
     * basin-stale).  W62's closing sentence ("make the constant have >= 2 in-loop uses,
     * or defeat validate_replace_rtx") is SUPERSEDED by the -dL block above: neither is
     * the gate -- the movable exists and is declined on budget.
     * W63-A5 additionally falsified here (all re-gated, all at 4 or worse): splitting the
     * BCD build through a named `tens` local (INERT 4 @139); a 3-operand fence listing
     * `magic` twice 32 @139; duplicating `magic = 0x66666667;` after the fence 32 @139.  */
    param[0] = 1;
    save = CdSyncCallback(0);
    if (CdControlB(0x13, 0, result) == 0)               /* CdlGetTN */
        goto err;
    track_first = (result[1] >> 4) * 10 + (result[1] & 0xF);     /* BCD -> decimal */
    track_last  = (result[2] >> 4) * 10 + (result[2] & 0xF);
    if (CD_debug >= 2)
        printf("track=%d,%d\n", track_first, track_last);

    param[0] = 0;
    if (CdControlB(0x14, param, result) == 0)           /* CdlGetTD, track 0 = lead-in */
        goto err;
    loc->minute = result[1];
    loc->second = result[2];
    loc->sector = 0;

    i = 1;
    if (track_first <= track_last) {
        magic = 0x66666667;
        do {
            __asm__("" : : "r"(magic), "r"(track_first));   /* MATCH (W60-A4): see the receipt above */
            param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);   /* track # -> BCD */
            if (CdControlB(0x14, param, result) == 0)
                goto err;
            loc[i].minute = result[1];
            loc[i].second = result[2];
            loc[i].sector = 0;
            i++;
            track_first++;
        } while (track_first <= track_last);
    }
    nTrack = i - 1;

    if (CD_debug >= 2) {
        for (i = 0; i <= nTrack; i++)
            printf("CdGetToc2: %02x:%02x:00\n", loc[i].minute, loc[i].second);
    }
    CdSyncCallback(save);
    return nTrack;

err:
    if (CD_debug != 0)
        printf("CdGetToc2: error\n");
    CdSyncCallback(save);
    return 0;
}
