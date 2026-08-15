/* syslib/psx/libpad/MCXMAIN.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(MCXMAIN.OBJ): the controller-exchange state machine -- the five step functions
 *   the SIO engine (PADMAIN::_padSioMain) dispatches through padIntFunc[_padSioState]:
 *     _padIntInit    select the controller / multitap, issue the first byte
 *     _padIntQuery   send the poll/config opcode, read the reply header low nibble
 *     _padIntRecvId  read the device id, derive the byte count (multitap-aware)
 *     _padIntRecvHdr read+validate the 0x5A acknowledge header
 *     _padIntRecvData stream the payload bytes (multitap: across all sub-ports), then advance port
 *   Each takes the per-port info block in $a0 and returns a SIO step code (<0 = bus error).
 *   _padFuncGetTxd is called with TWO args here (info, align) -- so its target (_pad_getbyte) is
 *   really 2-arg; Ghidra drops the second.  JOY_DATA reached through _padSioRegs (cf. PADMAIN). */

extern int      (*_padFuncSendAuto)(unsigned char *info);
extern int      (*_padFuncGetTxd)(unsigned char *info, int align);
extern int      (*_padFuncCurrLimit)(unsigned char *info);
extern unsigned (*_padFuncRecvAuto)(unsigned char *info);
extern unsigned char *(*_padFuncNextPort)(int flag);
extern unsigned (*_padFuncClrCmdNo)(unsigned char *info);

extern unsigned _padSioRW(unsigned char *dev, unsigned arg2);   /* PADMAIN @0x80105128 */
extern unsigned _padSioRW2(unsigned char *dev, int tx);         /* PADMAIN @0x80105300 */
extern int      _padClrIntSio0(void);                           /* PADMAIN @0x80105538 */
extern void     _padWaitRXready(void);                          /* PADMAIN @0x801055C8 */
extern void     setRC2wait(int ticks);                          /* WAITRC2 @0x8010BFE8 (VOID) */

extern int            _padModeMtap;
extern int            _padSioChan;
extern int            _padChanStart;
extern int            _padGunExec;
extern void          (*_padFuncGetGunPos)(void);
extern void          (*_padFuncSetGunPort)(void);
extern unsigned char *_padInfoDir;
extern int            _padFixResult[2];
extern unsigned char     *_padSioRegs;                              /* @0x80137CDC -> 0x1F801040 */
#define JOY_DATA8 (*(volatile unsigned char *)(_padSioRegs))

/* @0x8013C308 : originally a 12-byte block (3 words); the oracle addresses each word via its OWN
 * independent lui/lw pair (no shared base register cached across a call/branch) -- e.g.
 * _padIntRecvId materializes &_padMtapFlag (@0x8013C310) via a plain direct-load macro at entry
 * and a SEPARATE direct-store macro for &_padMtapCount (@0x8013C308) later, never a persisting
 * base pointer. Modeling them as one C array let gcc CSE a shared base into a callee-saved reg
 * (s2) across the intervening _padSioRW2 call -> extra frame slot the oracle doesn't pay
 * (_padIntRecvId 32-byte/4-saved-reg frame vs oracle's 24-byte/2-saved-reg). Split into three
 * independent statics (still ST_BSS-forced so none becomes gp-relative -- see DSCB.c's identical
 * trick) to match the oracle's per-access addressing. */
#define ST_BSS  __attribute__((section(".bss")))
#define ST_DATA __attribute__((section(".data")))
static int _padMtapCount ST_BSS;                       /* @0x8013C308 */
static int _padMtapDataReg ST_DATA = 0x1F801040;        /* @0x8013C30C : JOY_DATA mmio base (real image bytes) */
static int _padMtapFlag ST_BSS;                         /* @0x8013C310 */

/* @0x8010C0A8 : _padIntInit -- begin the exchange (issue 0x01 select).
 * MATCH (w48-a4, 6 -> PASS 18/18): NAMED TEMPS + LOAD-BEFORE-STORE ORDER.  The oracle loads the
 * rx pointer into $v1 (`lw $v1,0x3C($s0)`) and sets $a1 BEFORE storing the call's return value to
 * _padMtapFlag, so $v0 still holds that return value when the store macro runs.  Writing the store
 * as the first statement (`_padMtapFlag = _padFuncSendAuto(info);`) frees $v0 early and gcc then
 * reloads the rx pointer INTO $v0 after the store -- same 18 instructions, wrong order and wrong
 * register.  Splitting the call result and the deref into named locals and placing the deref
 * BEFORE the global store reproduces the oracle exactly.  (Catalog: "load-before-store ordering
 * steers the backward scan"; the `sb $zero,0($v1)` is the jal's delay slot on both sides.)
 * Falsified: `*rx = 0;` before the flag store (5 diffs @19/18, an extra insn); rx as a bare local
 * with the flag store still first (6). */
extern int _padIntInit(unsigned char *info)
{
    int flag = _padFuncSendAuto(info);
    unsigned char *rx = *(unsigned char **)(info + 0x3c);

    _padMtapFlag = flag;
    *rx = 0;
    return (int)_padSioRW(info, 0xfffffffe);
}

/* @0x8010C0F0 : _padIntQuery -- send the command opcode (default 0x42 = poll).
 * MATCH (w48-a4, 8 -> PASS 54/54): the opcode select is TWO FULL CALLS, not a ternary/if-else
 * value-select feeding one call (catalog w41 "a value-select ternary in a CALL ARGUMENT should
 * be TWO FULL CALLS cross-jump-merged").  The oracle's tail is `bnez $v0,L / addu $a0,$s0,$zero`
 * then `j Lcall / li $a1,66` with the other arm's `lbu $a1,0x36($s0)` falling into a SHARED `jal`
 * -- i.e. cross_jump merged two identical calls and the constant lives in the `j` delay slot.
 * ARM ORDER is load-bearing: the `!= 0` arm must be written FIRST (the `== 0` arm first gives
 * 7 diffs @55/54, one insn over).  A single call with a selected value can never reach it: the
 * ternary and the if/else both CSE the second `info[0x36]` read into the tested register
 * (`addu $a1,$v0,$zero`, 8 diffs @52/54, two insns SHORT), and forcing the re-read with a
 * volatile view gets the load but adds an `andi $a1,$v0,255` promotion mask (10 @54/54);
 * `op = info[0x36]; if (op == 0) op = 0x42;` is worse still (12).
 * MATCH (w53-a8, the MCXMAIN LANE ENABLER -- PASS in BOTH basins): the volatile view belongs on
 * the *TEST* read, NOT on the re-read.  cse never records a volatile MEM, so the plain
 * `info[0x36]` in the arm is a genuinely fresh `lbu $a1,54($s0)` with no promotion mask -- exactly
 * the oracle.  Under the gcc-2.7.2 rung the old plain-test form loses the second load entirely
 * (10 diffs @52/54) and the mirrored spelling (volatile on the RE-READ) leaves cc1-2.7.2 emitting
 * a DUPLICATE `addu $a0,$s0,$zero` in the taken arm on top of the one reorg puts in the `bne`
 * delay slot (1 diff @55/54; robust across 14 spellings: both-volatile, cast-narrowed,
 * arm-swapped, one-call funnel, ternary, `dev` copy local, identity fence on `dev`, explicit
 * `else`, use fence before/inside the arm, void-tail fence, block-scoped `op`).
 * This edit is what makes the whole TU legal on the 2.7.2 rung (231 -> 178, 3 PASSes held). */
extern unsigned _padIntQuery(unsigned char *info)
{
    if (_padSioChan == _padChanStart) {
        if (_padGunExec != 0) {
            _padFuncGetGunPos();
            _padFuncSetGunPort();
        }
    }
    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc));
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0xf0);
    }
    if (*(volatile unsigned char *)(info + 0x36) != 0)
        return _padSioRW2(info, info[0x36]);
    return _padSioRW2(info, 0x42);
}

/* @0x8010C1C8 : _padIntRecvId -- read the device id; derive the multitap byte count.
 * MATCH (w48-a4, 13 -> PASS 48/48): DIRECT RETURNS, not a result funnel.  The oracle writes the
 * result straight into $v0 on every path (`li $v0,-9` in a `j` delay slot; `addu $v0,$zero,$zero`
 * in the `bnez` delay slot; the r<0 path just falls out with the call's return still in $v0) and
 * its shared epilogue carries NO return copy.  The old single-`r`-funnel form parked r in $v1 and
 * paid `addu $v0,$v1,$zero` at the exit (13 diffs @47/48, one insn short and the whole tail
 * rotated $v0<->$v1/$a0).  Also load-bearing: fold the `<< 1` INTO lo before the store
 * (`lo = (r & 0xf) << 1; _padMtapCount = lo; if (lo != 0)`) -- the oracle tests the SHIFTED value
 * that is already in the register (`sll $v0,$v0,1; sw; bnez $v0`); keeping lo unshifted and
 * storing `lo << 1` costs the separate test (12 diffs @46/48). */
extern int _padIntRecvId(unsigned char *info)
{
    int r;
    unsigned lo;

    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x1e0);
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x2d0);
    }
    r = (int)_padSioRW2(info, (info[0x36] == 0) ? _padModeMtap : 0);
    if (r < 0)
        return r;
    if ((r & 0xf0) == 0)
        return 0xfffffff7;
    lo = (unsigned)(r & 0xf) << 1;
    _padMtapCount = lo;
    if (lo != 0)
        return 0;
    _padMtapCount = 0x20;
    return 0;
}

/* @0x8010C288 : _padIntRecvHdr -- read + validate the 0x5A acknowledge byte. */
extern unsigned _padIntRecvHdr(unsigned char *info)
{
    int align = 0;
    unsigned tx, r;
    if ((unsigned)(**(unsigned char **)(info + 0x3c) >> 4) == 8)
        align = (info[0x36] == 0);
    tx = (unsigned)_padFuncGetTxd(info, align);
    r = _padSioRW2(info, tx & 0xff);
    /* MATCH (w55-a6, 6 @37/35 -> 2 @35/35): the INNER test's POLARITY is `< 0`, not `>= 0`.
     * Under the 2.7.2 rung the `if ((int)r >= 0) return 0xfffffff7; return r;` spelling emits
     * `bltz` + an extra `j` + a `nop` (two instructions over) because the `return r` arm becomes
     * the branch target; writing it as `if ((int)r < 0) return r; return 0xfffffff7;` makes the
     * -9 arm the taken/merged one, so reorg puts `li $v0,-9` in the `bgez` delay slot and the
     * `addu $v0,$v1,$zero` falls through -- the oracle's exact tail.  (The old note below was
     * measured in the 2.8 basin; the TU moved to cc1_alt 2.7.2 in w53-a8, which re-opened it.)
     * Falsified at the 2.7.2 basin (w55-a6): 3-term `&&` with the sign test folded in (14 diffs,
     * count-exact but the whole compare web rotates to $a0/$v1); flat 4-way `if (r == K) return r;`
     * chain (10 @37/35); `res = r;` pre-set default before the tests (2, byte-identical).
     * RESIDUAL 2 (1 line, count-exact 35/35): reorg DUPLICATES the shared tail's `addu $v0,$v1,$zero`
     * return copy into a delay slot; the oracle puts the duplicate in the FIRST branch's slot
     * (beq slot = addu, beqz slot = nop), ours in the SECOND (beq slot = nop, beqz slot = addu).
     * Everything else is byte-identical.  w48-a4 re-swept the whole spelling space at this basin:
     * `&&`-guard block (base), two flat early `return r`s, `||` early-out, goto-out funnel,
     * fully nested ifs, 3-term `&&` with the sign test folded in, opacity fence on r before the
     * chain, use fence BETWEEN the two tests, use fence after them -- ALL NINE compile to the
     * BYTE-IDENTICAL 35 instructions.  jump.c canonicalizes the tail before reorg runs, so no
     * source spelling reaches the fill ORDER; this is the reorg-duplicate-placement class, not a
     * structural or coloring miss.  NEXT ANGLE: reorg processes branches in order and fills the
     * second only after failing the first -- find why the first steal is rejected (`-dR`/reorg
     * trace), or route to the permuter.
     * w61-a6 RTL-LEVEL DIAGNOSIS (the named angle answered as far as C can see it).  Dumped
     * `-dJ`/`-dd` on the real 2.7.2 rung: our jump2 stream is
     *   59: beq v1,v0 -> L80 | 61: beq v1,0 -> L80 | 94: v0=-9 | 65: bgez v1 -> L93
     *   L80: 83: v0=v1 | L93: 92: (use v0) | epilogue
     * i.e. jump.c ALREADY cross-jumped the two `return r` blocks and hoisted the -9, so the
     * pre-reorg layout is byte-for-byte what retail must have had.  Retail's extra
     * `addu $v0,$v1,$zero` is therefore reorg's fill_eager_delay_slots COPYING insn 83 out of
     * the (un-owned, 2-ref) target thread into insn 59's slot and redirecting it past the copy
     * to L93; the beqz then hits `redundant_insn` (the slot already performed the copy), gets
     * redirected to L93 too, and keeps an empty slot -- which is exactly the oracle's
     * `beq/addu`, `beqz/nop`, `bgez/li -9`, fall-through `addu`.  Our reorg refuses the FIRST
     * steal.  MINIMAL REPRO built (`pbuild/w61a6/t1.c`, 12 lines, same 4-block tail) and swept:
     *   * compiler ladder 2.6.0 / 2.6.3 / 2.7.2 / PsyQ CC1PSX 4.0: all refuse the steal
     *     (identical `beq/beq/bgez+li -9/L2: move` output); 2.7.2-970404 / 2.8.0 / 2.8.1 /
     *     2.95.2 fill the SECOND branch instead (`beq $3,$0,$L4 / move $2,$3`) -- no rung on
     *     disk emits retail's shape from this source;
     *   * flags inert: -fno-schedule-insns, -fno-schedule-insns2, -fno-thread-jumps,
     *     -fno-cse-follow-jumps, -fomit-frame-pointer;
     *   * 16 source shapes swept (flat 3x `return r`, if/else-if value chain, goto-out funnel,
     *     `res` pre-set variable, `||` pair + inner `if` with the label INSIDE the block,
     *     fully nested ifs both arm orders, do{}while(0)+break, `&&`-folded sign test,
     *     distinct-arm store to force non-merge): every one either reproduces the base output
     *     byte-identically or adds instructions.  The `ret_r:`-inside-the-if form
     *     (`if (r==0x5a||r==0) goto ret_r; if ((int)r<0) { ret_r: return r; } return -9;`) is
     *     BYTE-IDENTICAL to the current spelling -- jump.c canonicalises them all.
     * MECHANISM READ (gcc-2.8.1 reorg.c, the only surviving discriminator): the steal is gated
     * on `! insn_sets_resource_p (trial, &opposite_needed, 1)`, and `opposite_needed` comes from
     * `mark_target_live_regs`, which reads `basic_block_live_at_start[]` -- an array that reorg
     * NEVER recomputes and that was last filled by sched2's `find_basic_blocks`, BEFORE the
     * post-sched2 `jump_optimize (insns, 1, 1, 0)` cross-jumped these very blocks.  So the
     * liveness reorg consults is CFG-stale, and whether $v0 looks live at the opposite thread
     * depends on the pre-cross-jump block numbering of the WHOLE function, not on this tail.
     * => NOT reachable from a local spelling; the lever, if any, is a whole-function change
     * that alters the pre-jump2 block layout (or a build.py TEXT_MOVES relocation of the one
     * line).  Same class as _padIntRecvData's 4-diff residual.
     * MATCH (w62-a5, 2 -> PASS 35/35) -- IT IS THE ASSEMBLER'S INSN, NOT gcc's (11B mostly_true_jump
     * EQ rule).  `beq $3,$2,$L19` is an EQ FORWARD branch, which mostly_true_jump scores 0, so
     * gcc does NO eager target-thread fill on it and leaves the slot empty BY CONSTRUCTION -- the
     * w61-a6 CFG-stale-liveness read explains why our reorg refuses, but retail's duplicate was
     * never gcc's to begin with: ASPSX COPIED the merge-point `addu $v0,$v1,$zero` into the slot
     * and kept the copy at $L19 (libpad = Sony vendor-prebuilt; this is the VENDOR-TOOLCHAIN
     * residual class, cf. _padInitDirSeq @e471bfa9).  Expressed with ONE `copy`+`slot`
     * PER_FN_TEXT_MOVES row (spec in scratchpad/w62a5/RECEIPTS.md); zero collateral, the other
     * four MCXMAIN fns stay byte-identical. */
    if (r != 0x5a && r != 0) {
        if ((int)r < 0)
            return r;
        return 0xfffffff7;
    }
    return r;
}

/* @0x8010C314 : _padIntRecvData -- stream the payload (multitap sub-ports), then advance the port.
 * MATCH (w52-a5, 289 -> 227): (a) setRC2wait is VOID and the tested value is _padClrIntSio0's
 * RETURN -- the old `u = setRC2wait(0x3c); _padClrIntSio0(); if (u == 0)` tested the wrong thing;
 * (b) the function-scope `unsigned r` funnel forced a 7th callee-saved register (retail uses
 * s0-s5): every `st = call(...); if (st < 0) return st;` is now a BLOCK-LOCAL that dies at its
 * own return, so the call result stays in $v0 (`bltz $v0` with no `addu sN,$v0,$zero` copy);
 * (c) the header nibble goes through a named `int hdr` local; (d) `idx` gets its own init
 * statement.
 * MATCH (2026-08-14, 172 -> 12; count-exact 223/223): explicit loop/header labels reproduce
 * retail's three backedges; `_padSioChan == 0` is computed once for both `fix` and `base`;
 * `cur` is not initialized on paths that define it before use; staging `_padFixResult` through
 * `fixBase` gives the retail address materialization; separate pre-call `initial`, post-call `v`,
 * and stored `next` values reproduce the a0/v1/v0 webs.  The remaining 12 are one duplicated
 * a0 delay-slot placement plus two inverse but count-balancing clear-error branch layouts.
 * MATCH (w61-a6, 12 -> 4 @223/223) -- THE SHARED-EXIT OWNERSHIP LAW.  The "two inverse but
 * count-balancing clear-error branch layouts" above were NOT a coin flip: they are a choice of
 * WHICH of the three `if (_padClrIntSio0() == 0) return 0xfffffffd;` sites physically OWNS the
 * `li $v0,-3; j <epilogue>` block.  The owner emits the LONG form (`bnez <skip>; nop; j <end>;
 * [slot] li $v0,-3`); every other site is cross-jumped onto it, and reorg then steals the
 * owner block's `li $v0,-3` into the branch slot and redirects -- the SHORT form
 * (`beqz <end>; [slot] li $v0,-3`).  Ours put the owner at site 3 (stream_retry), retail at
 * [w62-a5: the remaining 4 closed to PASS 223/223 -- ONE `slot`+`drop_after` PER_FN_TEXT_MOVES
 *  row.  Same class as _padIntRecvHdr's: retail's `addu $a0,$s1,$zero` sits in the FIRST of two
 *  consecutive branches' slots (`beqz $v0`), ours in the SECOND (`bltz $v1`); gcc's fill order
 *  is not source-reachable (16 shapes / 8 rungs / 6 flags falsified in w61-a6) and the insn is
 *  ASPSX's placement.  The row moves the line into the beqz slot and DROPS the now-orphaned
 *  `.set noreorder/.set nomacro` pair in front of the bltz so the assembler nops that slot --
 *  without the drop the following `j` falls into the bltz delay slot (measured: 1 diff @222).]
 * site 2 (the recv_auto `send_byte` tail).  Writing the owner explicitly -- ONE physical
 * `clr_fail:` return block at the retail site plus `goto clr_fail;` at the other two -- is
 * codegen-exact and reaches retail's layout at all three sites.  MEASURED: owner at site 1
 * (drive_mtap) = 12 diffs (three sites wrong in a different pattern), owner at site 2 = 4,
 * baseline (no explicit owner, gcc picks site 3) = 12.  Transferable: any fn with N identical
 * early-return sites has a free 1-bit dial per site, and the gate's branch-target blindness
 * hides it in the LCS count -- read the LONG/SHORT shape, not the diff number.
 * RESIDUAL 4 (@223/223, one site): the `beqz`/`bltz` pair that both branch to `send_byte`
 * (`if (v >= 2) goto send_byte; if (v < 0) goto send_byte;`).  Retail steals send_byte's first
 * insn `addu $a0,$s1,$zero` into the FIRST branch's (beqz) slot and leaves the bltz's empty
 * (redundant_insn suppresses the second steal); ours fills the SECOND.  This is the same reorg
 * class as _padIntRecvHdr's residual below -- see that receipt for the falsification set. */
extern unsigned _padIntRecvData(unsigned char *info)
{
    int align = 0;

    _padFuncCurrLimit(info);
    if (_padModeMtap != 0) {
        int hdr = **(unsigned char **)(info + 0x3c);
        if (hdr >> 4 == 8)
            align = (info[0x36] == 0);
    }

    /* multitap: drive the per-sub-port command bytes */
    if (align != 0) {
        int idx = -1;
        int off = -0xf0;

    drive_mtap:
        {
            _padMtapCount = _padMtapCount - 1;
            if (_padMtapCount < 1)
                goto drive_done;
            if (idx >= 0)
                _padFuncCurrLimit(*(unsigned char **)(info + 0xc) + off);
            {
                int st = _padSioRW2(info, _padFuncGetTxd(info, 1) & 0xff);
                if (st < 0)
                    return (unsigned)st;
            }
            {
                setRC2wait(0x3c);
                if (_padClrIntSio0() == 0)
                    goto clr_fail;
                idx = idx + 1;
            }
            off = off + 0xf0;
            if (idx < 4)
                goto drive_mtap;
        }
    }

drive_done:

    /* dispatch the auto-recv of the other ports' queued replies */
    {
        int other = (_padSioChan == 0);

        if (1 < _padMtapCount) {
            int *fixBase = _padFixResult;
            int *fix = &fixBase[other];
            int base = other * 0xf0;
            int three = 3;
            unsigned char *cur;

        recv_auto:
        {
            int initial = *fix;
            int v;
            int next;
            if (initial < 0)
                goto stream_count;
            if (0 < initial) {
                cur = *(unsigned char **)((unsigned)base + (unsigned)_padInfoDir + 0xc)
                    + initial * 0xf0 - 0xf0;
                _padFuncRecvAuto(cur);
            }
            v = *fix;
            if (v == three)
                goto fix_is_3;
            if (v >= 4)
                goto fix_at_least_4;
            if (v >= 2)
                goto send_byte;
            if (v < 0)
                goto send_byte;
            goto fix_is_0_or_1;

        fix_at_least_4:
            if (v != 4)
                goto send_byte;
            *fix = three;
            goto send_byte;

        fix_is_3:
            _padFuncRecvAuto(cur - 0xf0);
            next = 1;
            goto store_fix;

        fix_is_0_or_1:
            cur = _padInfoDir + base;
            _padFuncRecvAuto(cur);
            _padFuncClrCmdNo(cur);
            next = -1;

        store_fix:
            *fix = next;

        send_byte:
            {
                int st = _padSioRW(info, _padFuncGetTxd(info, align) & 0xff);
                if (st < 0)
                    return (unsigned)st;
            }
            setRC2wait(0x3c);
            if (_padClrIntSio0() != 0)
                goto clr_ok;
        clr_fail:
            return 0xfffffffd;
        clr_ok:
            _padMtapCount = _padMtapCount - 1;
            if (1 < _padMtapCount)
                goto recv_auto;
        }
        }
    }
    goto stream_count;

    /* stream the remaining payload bytes into the receive buffer */
stream_retry:
    {
        int st = _padSioRW(info, _padFuncGetTxd(info, align) & 0xff);
        if (st < 0)
            return (unsigned)st;
    }
    setRC2wait(0x3c);
    if (_padClrIntSio0() == 0)
        goto clr_fail;

stream_count:
    _padMtapCount = _padMtapCount - 1;
    if (_padMtapCount > 0)
        goto stream_retry;
    {
        unsigned char len;
        _padWaitRXready();
        len = info[0x44];
        info[0x44] = len + 1;
        (*(unsigned char **)(info + 0x3c))[len] = JOY_DATA8;
        _padFuncNextPort(0);
        return 0;
    }
}
