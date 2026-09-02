/* syslib/psx/libpad/PADCMD.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADCMD.OBJ): the DualShock command-protocol builders -- 19 functions that compose
 *   the controller command packets (type byte @info+0x36, length @info+0x35, data ptr @info+0x2c) and
 *   parse the responses while loading the controller's actuator / mode descriptors.  Command IDs:
 *     0x43 config-into-mode   0x44 set-main-mode   0x45 get-status   0x46/0x47 get-descriptor R0/R1
 *     0x4B "exit"             0x4C set-map         0x4D actuator-align.
 *   The send/receive halves of the multi-step commands are installed as the per-port callbacks
 *   (info+0x14 = sender, info+0x18 = receiver), pumped by the SIO engine in PADMAIN.
 *
 *   The per-port device block ("info", 0xF0 bytes, shared with PADENTRY/PADMAIN) is addressed by raw
 *   byte offset here: several fields are union-overloaded with PADENTRY's view (e.g. +0x34 is both
 *   PADENTRY's status word and this obj's actuator length byte), so a single struct can't model both
 *   cleanly -- offset access is the faithful form.  Key fields touched below:
 *     +0x00 modeTbl  +0x04 actTbl  +0x08 actTbl2  +0x14 sndCb  +0x18 rcvCb  +0x20 alignData
 *     +0x24 cmdParam +0x28 actCb   +0x2c cmdData  +0x34 actLen +0x35 cmdLen +0x36 cmdType
 *     +0x3c rxBuf*   +0x46 cmdState +0x47 subIdx  +0x48 byteCtr +0x49 result
 *     +0x51 mmOffs   +0x52 mmLock   +0x53 mmLocked +0x5d actMap[6]  +0x63 actBuf
 *     +0xe3 nMode    +0xe4 curMode  +0xe6 modeWord +0xe9 nAct  +0xea nAct2  +0xec actAccum */

extern int  (*_padFuncChkEng)(unsigned char *info);            /* dispatch slot: engine-busy? (0 = free) */
extern void (*_padFuncClrInfo)(unsigned char *info);

/* SYM-GLOBAL-CARRIER: _actcur -- PADCOMMAND.obj-private BSS cursor; the exact
 * retail VA and addressing mode are proven by the reconstruction receipt. */
static unsigned char *_actcur __attribute__((section(".bss")));
                                 /* @0x8014859C : actuator-descriptor write cursor.
                                  * MATCH (w51-a5): the oracle reaches it ABSOLUTE (`lui $at,%hi;
                                  * sw %lo($at)`), not gp-relative -- this 4-byte static would land
                                  * in .sbss under -G4.  Same per-symbol -G0 emulation the other 11
                                  * syslib TUs use (w48-a9). */

/* ---- forward declarations (mutually recursive) ----------------------------------------------- */
extern int _padCmdParaMode(unsigned char *info, int para);
extern int _padCmdGetStatus(unsigned char *info);
extern int _padCmdSetMap(unsigned char *info, int idx);
extern int _padCmdGetDescR0(unsigned char *info, int idx);
extern int _padCmdGetDescR1(unsigned char *info, int idx);
extern int _padCmd4B(unsigned char *info);
extern int _padGetActSize(unsigned char *info);
extern int _padLoadActInfo(unsigned char *info, unsigned char *buf);
extern void _padLoadActInfo_snd(unsigned char *info);
extern int  _padLoadActInfo_rcv(unsigned char *info);
extern void _padSetActAlign_snd(unsigned char *info);
extern int  _padSetActAlign_rcv(unsigned char *info);
extern void _padSetMainMode_snd(unsigned char *info);
extern int  _padSetMainMode_rcv(unsigned char *info);

/* =====================  command-byte builders (one DualShock opcode each)  ===================== */

/* @0x801055F0 : _padSetAct -- stash the actuator data pointer + length for a later send. */
extern void _padSetAct(unsigned char *info, int data, int len)
{
    *(int *)(info + 0x28) = data;
    info[0x34] = (unsigned char)len;
}

/* =====================  load-info (actuator/mode descriptor) command sequence  ================= */

/* @0x801055FC : _padSendAtLoadInfo -- pick the send command for the current load-info phase. */
extern void _padSendAtLoadInfo(unsigned char *info)
{
    switch (info[0x46]) {                            /* MATCH (w51-a5): a real `switch` -- the
                                                      * oracle carries gcc-2.8's balance_case_nodes
                                                      * fingerprint (median-pivot `beq` on 3 with
                                                      * `slti ,4` in its delay slot, case bodies
                                                      * out-of-line in SOURCE order 2/3/4, `j`
                                                      * default).  Also VOID: no $v0 is staged at
                                                      * any exit. */
    case 2:
        _padCmdGetStatus(info);
        break;
    case 3:
        _padCmdSetMap(info, info[0xe4]);
        break;
    case 4:
        _padCmdGetDescR1(info, info[0x47]);
        break;
    }
}

/* @0x80105680 : _padRecvAtLoadInfo -- consume one response of the load-info handshake.
 * w51-a5: 105 -> 70 diffs.  Three oracle-read corrections:
 *   (a) a real `switch (info[0x46])` with cases in SOURCE order 2/3/4 -- gcc-2.8's
 *       balance_case_nodes fingerprint (median-pivot `beq ,3` with `slti ,4` in its delay slot,
 *       out-of-line case bodies, `j` default).  The if/else-if cascade laid the arms out wrong.
 *   (b) the rx pointer (+0x3c) is spelled INLINE at every use -- case 2's oracle has FOUR
 *       separate `lw $v0,0x3C($s0)` because each `sb` may-alias the pointer field.
 *   (c) `accum + 8` is its own term (a single `a + 8 + ((n+3)&0x1fc)` expression reassociates
 *       the +8 onto the masked term), and the size guard is `>= 0x81` so the `slti 0x81; bnez`
 *       arm order matches.
 * MATCH (2026-08-14, 70 -> 6, count-exact 83/83): case 2 reads the mutable rx-pointer cell
 * through a one-use volatile view at each access, reproducing retail's four loads; case 3
 * names the pointer/high/low values so its loads and zero store match; case 4 stages acc,
 * idx, rx and chunk in retail lifetime order; explicit physical return_zero/return_one labels
 * reproduce both shared result blocks and eliminate jump.c's duplicated zero/copy cascade.
 * The remaining 6 are instruction-order only.  A scratch PER_FN_TEXT_MOVES proof reaches
 * PASS 83/83 by ordering the case-4 six-line window as:
 *   lw $4,236($16); lbu $2,71($16); lw $3,60($16);
 *   addu $2,$2,1; lbu $3,4($3); addu $4,$4,8.
 * Source-order/type/volatile/flag probes are byte-identical at 6; -fno-schedule-insns is 25,
 * -fno-schedule-insns2 38, and -fno-delayed-branch 32.
 * >>> w61-a6: THAT TEXT_MOVES PROOF IS NOW A MEASURED, GATE-VERIFIED SPEC -- 6 -> PASS 83/83.
 * The case-4 window our cc1 emits is
 *   lw $4,236($16) / lw $3,60($16) / lbu $2,71($16) / addu $4,$4,8 / lbu $3,4($3) / addu $2,$2,1
 * and retail's is  A C B F E D of that same six.  `lw $3,60($16)` occurs FOUR times in the fn
 * (case 2 re-reads the volatile rx cell), so no move may anchor on it; the other five lines are
 * unique.  Three moves with unique anchors, applied in order, reach A C B F E D:
 *   PER_FN_TEXT_MOVES["recon/syslib/psx/libpad/PADCMD.c"]["_padRecvAtLoadInfo"] = [
 *     {"take": r"\taddu\t\$4,\$4,8\n",          "after": r"\taddu\t\$2,\$2,1\n"},
 *     {"take": r"\tlbu\t\$2,71\(\$16\)\n",      "after": r"\tlw\t\$4,236\(\$16\)\n"},
 *     {"take": r"\tlbu\t\$3,4\(\$3\)\n",        "after": r"\taddu\t\$2,\$2,1\n"},
 *   ]
 * WHOLE-TU A/B (19 fns, tools/verify_asm.py, probe harness scratchpad/w61a6/vprobe6.py):
 * PASS 14 -> 16 (this fn + _padLoadActInfo), ZERO PASS->FAIL, every other fn byte-identical. */
extern int _padRecvAtLoadInfo(unsigned char *info)
{
    switch (info[0x46]) {
    case 2:
        info[0xe3] = (*(unsigned char * volatile *)(info + 0x3c))[3];
        info[0xe4] = (*(unsigned char * volatile *)(info + 0x3c))[4];
        *(unsigned short *)(info + 0xe6) = 0;
        info[0xe9] = (*(unsigned char * volatile *)(info + 0x3c))[5];
        info[0xea] = (*(unsigned char * volatile *)(info + 0x3c))[6];
        *(int *)(info + 0xec) = 0;
        goto return_one;
    case 3: {
        unsigned char *rx = *(unsigned char **)(info + 0x3c);
        unsigned hi = rx[4];
        unsigned lo = rx[5];
        info[0x47] = 0;
        *(unsigned short *)(info + 0xe6) =
            (unsigned short)lo + (unsigned short)hi * 0x100;
        goto return_one;
    }
    case 4: {
        /* MATCH (2026-08-26, source-only 4 -> PASS 83/83): retaining `acc + 8`
         * as the named `acc8` value changes sched1's equal-priority ready-list tie
         * to retail's idx++ / rx[4] / acc+8 order.  Only the accumulator source
         * read needs volatile provenance to keep its lw first; removing that one
         * qualifier is exactly 2 diffs (the lw moves after the idx/rx loads).
         * The former idx, rx-cell and chunk volatile reads were retested on this
         * final basin, proved unnecessary, and removed. */
        int acc = *(volatile int *)(info + 0xec);
        int acc8;
        unsigned char idx = info[0x47];
        unsigned char *rx = *(unsigned char **)(info + 0x3c);
        unsigned chunk;
        idx++;
        chunk = rx[4];
        acc8 = acc + 8;
        info[0x47] = idx;
        acc = acc8 + ((chunk + 3) & 0x1fc);
        *(int *)(info + 0xec) = acc;
        if (!(idx < info[0xea]))
            goto finish_load_info;
return_zero:
        return 0;
finish_load_info:
        if (_padGetActSize(info) >= 0x81) {       /* MATCH: oracle `slti 0x81; bnez` -- the
                                                   * >= arm is the FALL-THROUGH */
            info[0x46] = 0xfe;
            info[0x49] = 2;
            goto return_zero;
        }
        info[0x46] = 0xff;
        _padLoadActInfo(info, info + 0x63);
        info[0x46] = 2;
        goto return_zero;
    }
    }
return_one:
    return 1;
}

/* @0x801057CC : _padGetActSize -- size of the actuator-info block being assembled. */
extern int _padGetActSize(unsigned char *info)
{
    int nmode = info[0xe3];
    int nact  = info[0xe9];
    int accum = *(int *)(info + 0xec);
    int a = ((nmode + 1) >> 1) << 2;
    int b = ((nact * 5 + 3) & 0xffc) + 4;
    return a + b + accum;
}

/* @0x80105804 : _padLoadActInfo -- carve the actuator buffer (info+0x63) into mode/act sub-regions
 *   and install the descriptor send/recv pump.  `buf` is that buffer (aligned up to 4). */
extern int _padLoadActInfo(unsigned char *info, unsigned char *buf)
{
    int aw;
    unsigned char *a;

    if (buf == 0 || *(int *)(info + 4) != 0 || _padFuncChkEng(info) != 0)
        return 0;
    /* w59-a7: 38 -> 26 (source) -> PASS 53/53 with the wiring below.  The w55-a6 residual was
     * NOT the PER_FN_PROLOGUE_FILL class at all -- it was the GUARD SHAPE.
     *
     * ** THE `||`-CHAIN LAW.  Retail's three guards are ONE `||` expression, not three separate
     * `if (..) return 0;` statements.  In a `||` chain gcc emits each leading condition as a
     * branch TO the shared then-block and the LAST condition as the INVERTED branch that skips
     * it -- which reproduces, in one edit, ALL of:
     *   (a) `beqz $s1,.L8010584C` with `sw $ra,0x18($sp)` IN ITS DELAY SLOT (reorg has no
     *       `v0=0` left to steal for that slot -- guard1 now branches to a real block whose
     *       first insn is the shared `v0=0`, and reorg cannot steal-and-redirect past the
     *       block's own `j`, so it reaches BACKWARD into the prologue instead).  The
     *       "prologue store in a delay slot" was a CONSEQUENCE, never an independent mechanism.
     *   (b) the SHARED ret0 block `.L8010584C: j <epilogue>; addu $v0,$zero,$zero` sitting
     *       BETWEEN the ChkEng test and the body, with guard2 (`bnez`) steal-redirected
     *       straight to the epilogue -- retail's exact two-route layout.
     *   (c) `beqz $v0,.L80105854` (branch to the BODY) with `addiu $v0,$zero,1` pre-set in
     *       its slot.
     *   (d) the jalr's `nop`: with the guards in ONE expression the whole entry..call region
     *       is a single extended basic block, so cse propagates $a0 and delete_noop_moves
     *       kills the `addu $a0,$s0,$zero` our three-statement form emitted.
     * FALSIFIED (w55-a6, kept): hoisting the body into `if (ChkEng(info)==0){...} return 0;`
     * (43 @54/53).  FALSIFIED (w59-a7): void-tail fence `__asm__("":: "i"(0))` before the
     * body (inert, 26); named `nmode`/`nact` locals for the two lbu's (inert, 26); moving the
     * `aw` statement below the byte stores (inert, 26) -- the body residual is a sched1
     * ready-list decision, not a source-order one.
     *
     * ORCHESTRATOR WIRING (probe-validated on a scratchpad build.py copy, this fn only):
     *   PER_FN_CC1_VER_SPLICE_272["recon/syslib/psx/libpad/PADCMD.c"] = {"2.7.2": {"_padLoadActInfo"}}
     *   PER_FN_TEXT_MOVES["recon/syslib/psx/libpad/PADCMD.c"]["_padLoadActInfo"] =
     *       [{"take": r"\tli\t\$3,0x00000004[^\n]*\n", "after": r" #NO_APP\n"}]
     * WHY the rung: 2.7.2 has NO -msplit-addresses, so it emits `la $3,sym` MACROS where the
     * wired 2.7.2-970404 rung pre-splits `lui/addiu` and sched1 then scatters the rcv pair
     * across the two `lbu`s (costing a 3rd temp, $a2).  On the 2.7.2 rung this fn is 2 diffs;
     * the whole-TU flip is net-negative (4 cmd builders 0->4 each, _padRecvAtLoadInfo 6->24)
     * => per-fn splice.  The single text move restores retail's `li $3,4`-before-the-aw-round-up
     * (sched1-only; source order is provably inert per the falsifications above).
     * >>> w61-a6 RE-VALIDATION (the w59-a7 spec was never wired; re-measured from a clean object
     * on the CURRENT basin, unchanged source, probe harness scratchpad/w61a6/vprobe6.py):
     * ver-splice alone 26 -> 2 (@53/53, the residual is exactly the `li $3,4` position);
     * ver-splice + the one text move -> PASS 53/53.  WHOLE-TU A/B over all 19 fns: PASS 14 -> 15
     * with this pair alone, ZERO PASS->FAIL.  Both remain ORCHESTRATOR actions, verbatim above. */
    {
        int r = 1;
        int four = 4;
        __asm__("" : "=r"(r) : "0"(r));      /* MATCH: opacity fence -- same device as the sibling
                                              * _padSetActAlign; stops cse copy-substituting the
                                              * return constant into the info[0x46] store */
        aw = ((int)buf + 3) >> 2;            /* MATCH (w51-a5): the oracle rounds up with a SIGNED
                                              * `addiu ,3 / sra ,2` ... `sll ,2` PAIR (word index
                                              * materialized early, scaled back late), not the
                                              * `& ~3` mask a single expression emits */
        /* MATCH (W78, 2 -> PASS 53/53 on the historical 2.7.2 per-fn rung;
         * also a strict source-only reduction 26 -> 24): the opaque named 4
         * gives sched1 the retail constant's earlier position. */
        __asm__("" : "=r"(four) : "0"(four));
        info[0x49] = four;
        info[0x46] = 1;
        *(void (**)(unsigned char *))(info + 0x14) = _padLoadActInfo_snd;
        *(void (**)(unsigned char *))(info + 0x18) =
            (void (*)(unsigned char *))_padLoadActInfo_rcv;
        a = (unsigned char *)(aw << 2);
        *(unsigned char **)(info + 0) = a;
        info[0x47] = 0;
        a += ((info[0xe3] + 1) >> 1) << 2;
        *(unsigned char **)(info + 4) = a;
        *(unsigned char **)(info + 8) = a + ((info[0xe9] * 5 + 3) & 0xffc);
        return r;
    }
}

/* @0x801058D8 : _padLoadActInfo_snd -- emit the right descriptor request for the current sub-phase. */
extern void _padLoadActInfo_snd(unsigned char *info)
{
    switch (info[0x46]) {                            /* MATCH (w51-a5): balance_case_nodes switch */
    case 2:
        _padCmdSetMap(info, info[0x47]);
        break;
    case 3:
        _padCmdGetDescR0(info, info[0x47]);
        break;
    case 4:
        if (info[0x48] == 0)
            _padCmdGetDescR1(info, info[0x47]);
        else
            _padCmd4B(info);
        break;
    }
}

/* @0x80105980 : _padLoadActInfo_rcv -- parse a descriptor response into the mode/act tables.
 * w51-a5 rebuild from the oracle: 175 diffs @134/157 -> 40 @155/157.  FIVE corrections:
 *   (a) IT IS NOT void (§3.2).  Every exit stages $v0: `.L80105BE8: addiu $v0,$zero,1` is a
 *       dedicated block in front of the shared `jr $ra`, and `addu $v0,$zero,$zero` sits in three
 *       branch delay slots.  1 = "sub-phase index wrapped / state not handled", 0 = "more to come".
 *   (b) THE RX POINTER IS RE-READ AT EVERY USE, not cached in a local.  In the st==3 arm the
 *       oracle has FIVE `lw $v0,0x3C($a1)` (each followed by the load-delay nop) because the
 *       intervening `sb` into the descriptor may-alias the +0x3c pointer field and kills cse's
 *       copy; the st==2 arm has NO store between its two byte reads, so the same inline spelling
 *       still CSEs down to one `lw` there -- exactly what the oracle shows.  A cached
 *       `unsigned char *rx` local is the 23-instruction shortfall.
 *   (b2) the state dispatch is a real `switch`, not an if/else-if cascade -- gcc-2.8's
 *       balance_case_nodes fingerprint (median pivot `beq ,3` with `slti ,4` in its delay slot,
 *       case bodies OUT-OF-LINE in SOURCE order 2/3/4, `j` default).  The cascade inlined the
 *       st==3 arm and mis-ordered the whole block layout.
 *   (c) the sub-index guard reuses the INCREMENTED byte (`addiu; sb; andi 0xFF; sltu`), it does
 *       NOT re-load info[0x47]: hence the `unsigned char n` carrier.
 *   (d) the R1 payload loop counts the REAL byte counts 3 (rx[5..7]) and 6 (rx[2..7]) with a
 *       pre-decrementing guard `while (--cnt != -1)`; the oracle's `li 3 / addiu -1` and
 *       `li 6 / addiu -1` preheader pairs are that peeled first decrement (the old `cnt = 2/5`
 *       spelling folded them into a single `li`).
 * RESIDUAL 40 @155/157, all named: (i) the two `return 1` wrap sites keep their own `li $v0,1`
 *   plus a duplicated `jr $ra` where retail shares one `.L80105BE8` block (jump.c return
 *   duplication -- the `__asm__ volatile("")`-at-the-label device COSTS more here, it blocks
 *   reorg's steal of the two DEFAULT `li $v0,1`s into the dispatch beq slots: measured worse);
 *   (ii) `srl` vs the oracle's `sra` on `rx[5] >> 7` -- our cc1-2.8 combine proves the `lbu`
 *   value non-negative and demotes the arithmetic shift; a COMPILER-VERSION artifact (04M
 *   gcc-2.7.2 law), not source-reachable while the load stays `lbu`; (iii) $v0/$v1 coloring on
 *   the `base+woff` store pair; (iv) the `la $a3,_actcur` preheader anchor lands 2 insns early
 *   and `t0 = -1` is a copy instead of a fresh `li` (the no-copy-prop identity -- both close
 *   under the cc1_272 lane, where this fn is COUNT-EXACT 157/157 @38).
 * MATCH (w61-a6, 29 -> 17 @156/157) -- THE SHARED-EXIT OWNERSHIP LAW (same instrument that took
 *   PADIF's _padIntRecvData 12 -> 4; see that receipt for the mechanism).  Residual item (i)
 *   above ("the two `return 1` wrap sites keep their own `li $v0,1` ... where retail shares one
 *   .L80105BE8 block") was NOT jump.c return duplication -- it was the OWNERSHIP BIT of two
 *   independent shared exits, and both were on the wrong site:
 *     * `return 1`: retail's physical owner is the SWITCH DEFAULT (the trailing `return 1`), with
 *       case 2 and case 3 cross-jumped onto it.  Spelled as one `return_one:` label at the
 *       default + `goto return_one;` in cases 2 and 3.  (Owner at case 3 instead = 25 @154; owner
 *       at case 2 = the 29-diff baseline.)
 *     * `return 0`: retail's owner is case 4's post-loop `if (info[0x48]==0) goto tail; return 0;`
 *       site.  Spelled as `return_zero:` there + `goto return_zero;` on the LAST tail return only
 *       -- the `n >= info[0xea]` arm must keep its OWN literal `return 0;`, because retail
 *       materialises that arm's zero locally (`addu $v0,$zero,$zero` ahead of the `li $v1,6` /
 *       `li $v1,254` byte stores, which is also what puts those constants in $v1 not $v0).
 *       Routing that arm through the goto too costs 9 diffs (26 vs 17) -- MEASURED both ways.
 *   LANE RE-LADDERED AT THE NEW BASIN (04Z): the "closes under the cc1_272 lane, COUNT-EXACT
 *   157/157 @38" claim above is now FALSE -- per-fn ver-splice 2.7.2 = 31 @158, 2.6.3 = 50 @159,
 *   2.8.0 = 33 @156, whole-TU cc1_272 = 31 @158; the wired 2.7.2-970404 rung is best at 17.
 * MATCH (w62-a5, 17 -> 14 @155/157) -- TWO of the four named residual items closed:
 *   (ii) `srl` vs `sra` on `rx[5] >> 7` was NOT a "compiler-version artifact, not source-reachable
 *       while the load stays lbu".  combine proves the `lbu` value non-negative and demotes the
 *       arithmetic shift, so the cure is to make the value OPAQUE to combine without changing the
 *       load: stage it in an `int` and IDENTITY-LAUNDER it (13B, `__asm__("" : "=r"(x) : "0"(x))`,
 *       zero insns).  `lbu` stays, `sra` returns, nothing else moves.  -1 diff.
 *   (iv) the `la $a3,_actcur` preheader anchor landing 2 insns early WITH `t0 = -1` as a cse copy
 *       was ONE structural fact, not two allocator facts: retail's byte loop is a ZERO-TRIP-GUARDED
 *       do/while whose anchor is assigned INSIDE the guard.  `if (--cnt != -1) { ac = &_actcur;
 *       do {...} while (--cnt != -1); }` puts the `la` after the guard AND spells the `-1` twice,
 *       so the back edge gets its own `li $t0,-1` instead of `addu $t0,$v0,$zero`.  -2 diffs.
 *   RESIDUAL 14 = ONE identity, fully diagnosed: THE SPLIT-ADDRESSES AXIS.  cc1 emits the UNSPLIT
 *   macro forms `sw $2,_actcur` / `la $7,_actcur` in the .s, then (this rung being a SPLIT-address
 *   build) splits them itself into `lui $2,%hi; sw $3,%lo($2)` / `lui $2,%hi; addiu $7,$2,%lo` and
 *   FILLS TWO BRANCH DELAY SLOTS with the `lui` halves (that is also why we are 2 insns SHORT:
 *   155 vs 157).  Retail keeps both macros whole -- ASPSX expands the store through `$at`
 *   (`lui $at,0; sw $3,0($at)`) and the `la` dest-as-scratch (`lui $a3; addiu $a3,$a3`), and
 *   refuses to put a multi-word macro in a delay slot, so retail pays a `nop` and fills the `j`
 *   slot with `addiu $a0,$a0,-1` instead.  PROVEN by A/B: whole-TU `cc1_alt 2.8.0` +
 *   `no_split_addresses` reproduces retail's `lui $at,0 / sw ,0($at)` and the `addiu $a0,$a0,-1`
 *   j-slot EXACTLY (and is COUNT-EXACT 157/157) -- but scores 32 on the rest, and whole-TU 2.8.0
 *   costs the TU's other PASSes, so it is not a wiring recommendation.  The 970404 rung REJECTS
 *   the flag outright (`cc1.exe: Invalid option 'no-split-addresses'`), so neither
 *   PER_FN_NO_SPLIT_ADDRESSES (default lane only -- inert here) nor PER_FN_FLAG_SPLICE_272 can
 *   express it; the missing mechanism is a per-fn ver-splice that ALSO carries the flag (the 272
 *   twin of the 12G `PER_FN_NO_SPLIT_ADDRESSES` + version-splice composition).  TEXT_MOVES cannot
 *   substitute: the two forms differ in REGISTER ($at/$a3 vs $v0), not only in line position.
 *   psyqproof (psq43 CC1PSX 2.8.0 + ASPSX 2.77) scores REAL=96 on this fn -- count-exact 157
 *   words but a different codegen basin; the gate rung stays authoritative.
 *   RESIDUAL (pre-existing, now the only other item):
 *   (iii) the `_actcur` store reaching through `$at` in retail (an ASSEMBLER MACRO SPLIT, the
 *   W51 AT-MACRO class) vs our `$v0` base; (iv) the `la $a3,_actcur` preheader anchor landing 2
 *   insns early with `t0 = -1` as a copy; plus one `lbu $v0,4($v0)` load-delay placement.
 * w64-a7 2026-08-15 -- THE 2.8.0+nosplit BASIN RE-DERIVATION (w63-a8's named job) EXECUTED, and
 *   the answer is that the three shipped devices do NOT all transfer.  Re-gated wired baseline
 *   14 @155/157.  Probed through the w63-a8 PER_FN_VERFLAG_SPLICE_272 harness (kept at
 *   `scratchpad/w64a7/verflag.py`; build.py untouched), key "2.8.0|-mno-split-addresses":
 *     shipped 3 devices                       28 @157/157   (w63's number, reproduced)
 *     - the `cnt` opacity fence                26   <-- the fence is HARMFUL in this basin
 *     - the `hi` opacity fence                 28   (inert here; keep it, the wired rung wants it)
 *     - `hi` local dropped entirely            30
 *     - the anchor assigned OUTSIDE the guard  32   (load-bearing in BOTH basins)
 *     - the anchor local altogether            28
 *     - `cnt` fence AND `hi` fence             26   (the basin's current best)
 *     - all three                              30
 *   AND the `cnt` fence's premise does not hold here either: its in-source rationale is "retail
 *   rematerializes, `sllv` is the tell", but the ORACLE HAS NO `sllv` -- both `woff` shifts are
 *   `sll $v0,$v0,3` (0x80105AC0, 0x80105B04).  In the 2.8 basin OURS emits `sllv $v0,$v0,$a0`
 *   with or without the fence (cse substitutes `cnt`'s live 3 for the literal), so the device is
 *   aimed at a real defect but does not cure it there.  Four statement POSITIONS of `cnt = 3;`
 *   measured against that fold: top of the block 26, end of the block 28, after the `woff`
 *   if/else 28, end + fence 27 @158 -- position is not the dial.
 *   ⇒ 26 @157 count-exact is the basin's floor as of this wave, still 12 worse than the wired
 *   14 @155, so NOTHING is wired and the shipped source is unchanged.  The named next step is
 *   unchanged in KIND but sharper in CONTENT: the 2.8+nosplit basin needs its OWN cure for the
 *   `cnt`-into-`sll` cse substitution (a non-fence one), not a transplant of the 970404 device.
 *   ALSO FALSIFIED this wave, on the WIRED rung, against residual item (iv) (`la $a3,_actcur`
 *   separate-scratch vs retail's self-temp -- the catalog-E sized-vs-scalar %hi-scratch family):
 *   declaring `_actcur` as a sized `*_actcur[1]` with the anchor by array decay (14), the same
 *   with `&_actcur[0]` (14), and a `(unsigned char **)&_actcur` cast anchor on the scalar (14) --
 *   all three byte-identical.  The `section(".bss")` attribute already fixes the storage shape,
 *   so the declaration-shape family is CLOSED for this symbol.
 * A14/w71 2026-08-21 -- re-gated 14 @155/157 on the wired 970404 rung; the w62 SPLIT-ADDRESSES
 *   diagnosis reproduces exactly and NOTHING was landed.  The residual decomposes as [4] the
 *   `li $a0,3` load-delay placement (ours fills the `lw $v0,0x3c($a1)` slot with it, retail nops
 *   the slot and emits the `li` after the `lbu`), [6] the `_actcur` store reaching through
 *   retail's `$at` macro vs our `lui $v0` (with retail's `j` slot carrying a DUPLICATED
 *   `addiu $a0,$a0,-1` we lack), [4] the `la $a3,_actcur` preheader anchor (retail
 *   `nop; lui $a3; addiu $a3,$a3` vs ours `lui $v0` in the branch slot + `addiu $a3,$v0`).
 *   Clusters 2 and 3 are ONE fact -- ASPSX refuses to place a multi-word macro in a delay slot,
 *   our lane splits both macros and spends the freed slots -- and that is why we run 2 SHORT.
 *   RE-SWEPT for cluster 1 at this basin (04Z), all measured: four positions of `cnt = 3;`
 *   (top / after the first store / after both stores / with a void barrier ahead of it) are ALL
 *   14 and byte-identical -- statement position is not the dial.  Seven fence spellings around
 *   the `v` load (read-only on `v`, read-only after `cnt`, a void barrier after the cnt fence, a
 *   2-operand read-only on `v`+`cnt`, a doubled cnt fence, and two orderings of the pair) ALL
 *   land on the SAME object: 13 @156 -- the `li $a0,3` moves ABOVE the `lw` instead of below the
 *   `lbu`, buying one diff by paying a nop.  NOT LANDED: it is a one-line diff bought by an
 *   unexplained asm whose only effect is to add an instruction (the "no scaffolding" rule), and
 *   it does not touch the real cluster.  The mechanism gap is unchanged and is the ONLY route:
 *   a per-fn ver-splice that ALSO carries `-mno-split-addresses` (the 272 twin of 12G's
 *   PER_FN_NO_SPLIT_ADDRESSES + version-splice composition) -- shared build change, reported.
 * *** MATCH (W72-A17): 14 @155 -> 10 @155 FROM SOURCE ALONE, and -> 2 @157/157 COUNT-EXACT with
 * ONE PER_FN_FLAG_SPLICE_272 ROW.  The "missing mechanism" three waves asked for DOES NOT NEED TO
 * BE BUILT -- it already exists, and the flag it needs is not `-mno-split-addresses` but `-G4`. ***
 *   🏆 THE LAW (read out of gcc's mips backend, not guessed).  `mips_split_addresses` is set
 *   UNCONDITIONALLY on this rung (`override_options`, mips.c:3696: `TARGET_GAS &&
 *   TARGET_SPLIT_ADDRESSES && optimize && !flag_pic && Pmode==SImode`; there is NO user switch --
 *   confirmed by string-scanning the 970404 cc1.exe: it carries the internal symbol
 *   `mips_split_addresses` but NO "split-addresses" option string, which is why the w62 probe got
 *   `Invalid option`).  But the split is applied PER ADDRESS, through `mips_check_split`
 *   (mips.c:893), which returns 0 -- NO SPLIT, emit the assembler MACRO -- when the symbol has
 *   SYMBOL_REF_FLAG set.  ENCODE_SECTION_INFO (mips.h:2792) sets that flag iff
 *   `size > 0 && size <= mips_section_threshold`, i.e. iff the object is SMALL DATA under -G.
 *   The 272 lane compiles at -G0 (build.py `_compile_c_272`, tu_g_value default "0"), so NOTHING
 *   is ever small-data and EVERY address is pre-split.  Compiling THIS FUNCTION at -G4 sets the
 *   flag on the 4-byte `_actcur`, cc1 emits `sw $v1,_actcur` / `la $a3,_actcur` whole, and GNU-as
 *   expands them into retail's `lui $at; sw ,0($at)` and dest-as-scratch `lui $a3; addiu $a3,$a3`
 *   -- while the ASSEMBLER still runs at the TU's -G0, so the symbol stays ABSOLUTE (this is the
 *   half that makes the trick safe: a whole-TU -G4 would also hand `as` a -G4 and risk gp-rel).
 *   ⇒ THE WIRING (orchestrator; build.py is a shared file, so it is NOT landed here):
 *        PER_FN_FLAG_SPLICE_272["recon/syslib/psx/libpad/PADCMD.c"] = {"-G4": {"_padLoadActInfo_rcv"}}
 *   The mechanism appends the flag AFTER the lane's own `-G0`, so the later -G wins; the splice
 *   then grafts only this function's `.ent` region.  MEASURED, whole-TU, via tools/vprobe.py's
 *   W61_TABLE hook (build.py untouched): 18/19 PASS with the row, IDENTICAL to the 18/19 without
 *   it -- ZERO PASS->FAIL.  (A whole-TU `g_value: 4` reaches the same 12 on this fn but COSTS 4
 *   PASSes -- _padLoadActInfo, _padSetActAlign, _padSetMainMode, _padSetMainMode_rcv each go 1
 *   insn short at 3 diffs -- so the per-FN splice is the only wirable form.)
 *   THE SOURCE HALF (landed, and a net win at 14 -> 10 even WITHOUT the row):
 *     (1) §21A-1 read-only fence + `"$2"` clobber on `cur` -- 12 -> 6 with the row (14 -> ~10
 *         without).  Retail runs the `base + woff` store pair through $v1; the clobber denies $v0
 *         to that allocno at zero instructions.  A `"$3"` clobber is a no-op control (12).
 *     (2) a VOID BARRIER before `cnt = 3;` REPLACING the old `cnt` opacity fence -- 6 -> 2.  The
 *         old fence's premise (block cse from folding the live 3 into the `woff` shift) is
 *         basin-stale; what the site needs now is a barrier that stops the `li $a0,3` rising into
 *         the `lw $v0,0x3C($a1)` load-delay slot, so it lands in the LBU's slot like retail.
 *         KEEPING BOTH = 6, the old fence alone = 6, moving `cnt = 3;` below the `info[0x48]`
 *         store = 6.  (04Z at full strength: a device that was load-bearing for three waves is
 *         now the thing to delete.)
 *   RUNG RE-LADDERED at this basin (04Z): wired 2.7.2-970404 = 14, plain 2.7.2 = 25 @158,
 *   2.8.0 = 30 @155, 2.8.1 = 30 @155, 2.6.3 / 2.6.0 = 44 @159.  The wired rung stays optimal.
 *   RESIDUAL 2 @157/157 with the row (10 without), ONE class: `addu $t0,$v0,$zero` where retail
 *   has `li $t0,-1` -- cse CONSTANT-SHARING (§21E-5) between the zero-trip guard's `-1` and the
 *   back-edge test's.  FALSIFIED at this basin, all byte-identical unless noted: a laundered
 *   named `m1` sentinel for the GUARD's -1 (4); the same with a read-only fence inside the guard
 *   (2); a void fence at the guard head / after `ac = &_actcur;` (2); and 21B-3 born-in-the-loop
 *   -- an `e = -1;` assignment at ALL FOUR statement positions inside the do-while body, with the
 *   test spelled `while (--cnt != e)` (2 at every position; cse folds `e` back to the guard's
 *   live value before loop.c ever sees a movable).  §21E-5's "fence the FIRST occurrence" is the
 *   right instrument and the guard IS the first occurrence, but every register-resident spelling
 *   of that first -1 either changes the guard's own shape or is folded away. */
extern int _padLoadActInfo_rcv(unsigned char *info)
{
    switch (info[0x46]) {
    case 2: {                                        /* mode-id list (set-map) */
        unsigned char n;
        *(unsigned short *)(*(unsigned char **)(info + 0) + info[0x47] * 2) =
            (unsigned short)(*(unsigned char **)(info + 0x3c))[5] +
            (unsigned short)(*(unsigned char **)(info + 0x3c))[4] * 0x100;
        n = info[0x47] + 1;
        info[0x47] = n;
        if (n < info[0xe3])
            return 0;
        info[0x47] = 0;
        goto return_one;
    }
    case 3: {                                        /* mode descriptor R0 */
        unsigned char *d = *(unsigned char **)(info + 4) + info[0x47] * 5;
        unsigned char n;
        d[0] = (*(unsigned char **)(info + 0x3c))[4];
        d[1] = (*(unsigned char **)(info + 0x3c))[5] & 0x7f;
        d[2] = (*(unsigned char **)(info + 0x3c))[6];
        d[3] = (*(unsigned char **)(info + 0x3c))[7];
        {
            int hi = (*(unsigned char **)(info + 0x3c))[5];
            d[4] = (unsigned char)(hi >> 7);
        }
        n = info[0x47] + 1;
        info[0x47] = n;
        if (n < info[0xe9])
            return 0;
        info[0x47] = 0;
        info[0x48] = 0;
        goto return_one;
    }
    case 4: {                                        /* actuator descriptor R1 (variable length) */
        unsigned char *d = *(unsigned char **)(info + 8) + info[0x47] * 8;
        unsigned char *src;
        unsigned char **ac;
        unsigned char n;
        int cnt;
        if (info[0x48] == 0) {
            unsigned char v = (*(unsigned char **)(info + 0x3c))[4];
            unsigned char *base;
            unsigned woff;
            unsigned char *cur;
            /* MATCH (W72-A17): a VOID BARRIER here, and the `cnt` opacity fence that used to
             * sit after `cnt = 3;` is GONE -- 04Z basin-relativity, the old fence is now
             * HARMFUL (6 -> 2 by dropping it and adding this).  The barrier's job: ours filled
             * the `lw $v0,0x3C($a1)` load-delay slot with `li $a0,3` and then needed a `nop`
             * after the `lbu`; retail nops the `lw` slot and spends the `li` on the LBU's slot.
             * An asm stops reorg/sched from lifting the `li` above the byte read, so the `li`
             * lands where retail has it.  MEASURED at this basin: with the old cnt fence kept
             * as well = 6; the cnt fence alone (no barrier) = 6; `cnt = 3;` moved below
             * `info[0x48] = v;` = 6. */
            cnt = 3;
            info[0x48] = v;
            d[0] = v;
            src = (*(unsigned char **)(info + 0x3c)) + 5;
            if (info[0x47] == 0) {
                base = *(unsigned char **)(info + 8);
                woff = (unsigned)info[0xea] << 3;
            } else {
                base = *(unsigned char **)(d - 4);
                woff = (d[-8] + 3) & 0x1fc;
            }
            cur = base + woff;
            /* MATCH (W72-A17): §21A-1 READ-ONLY FENCE + HARD-REG DENIAL, zero insns.  Retail
             * runs the whole `base + woff` store pair through $v1 (`addu $v1,$v1,$v0;
             * sw $v1,4($a3); sw $v1,0($at)`); ours took $v0.  Denying $2 to `cur`'s allocno via
             * the clobber list is the entire mechanism -- the `"r"(cur)` operand is only a
             * carrier and `cur` is already register-resident, so nothing is emitted.  A `"$3"`
             * clobber instead measures the un-fenced number, i.e. this is not a generic
             * perturbation.  Worth 6 diffs. */
            __asm__("" : : "r"(cur) : "$2");
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
        } else {
            src = (*(unsigned char **)(info + 0x3c)) + 2;
            cnt = 6;
        }
        /* MATCH: pointer local -- the oracle keeps `la $a3,_actcur` live across the loop and
         * the body does ONE `lw 0($a3)` / `sw 0($a3)` per iteration (a direct `_actcur`
         * re-reads twice).  MATCH (w62-a5): the loop is a ZERO-TRIP-GUARDED do/while and the
         * anchor is assigned INSIDE the guard -- that is what puts `la $a3,_actcur` AFTER the
         * `beq $a0,$v0` guard (ours hoisted it 2 insns early) and gives the back-edge its OWN
         * `li $t0,-1` instead of a cse copy of the guard's `li $v0,-1`.
         * MATCH (W74-A20, 2 -> PASS 157/157): the cse CONSTANT-SHARING residual (`addu $t0,$v0,
         * $zero` where retail materializes `li $t0,-1` fresh) closes with the §21E-5 instrument
         * once TWO placement laws are obeyed -- neither is a new device, both are position:
         *   (1) FENCE THE FIRST OCCURRENCE, AND THAT IS THE GUARD'S -1, NOT THE LOOP'S.  The
         *       launder protects USES, so a sentinel DEFINED where -1 is already live is copied
         *       anyway (the FontPrint law, recon/syslib/psx/libgpu/FONT.c:505).  Making the
         *       GUARD's -1 an opaque pseudo `g` means cse has NO -1 in any register at the loop
         *       sentinel's def, so the plain literal `neg1 = -1;` inside the guard emits a fresh
         *       `li` -- and, being inside the guard, it lands after `la $a3,_actcur` exactly like
         *       retail.  `g` still costs nothing: the launder is identity and tied to its input,
         *       so it is retail's own `li $v0,-1` in front of the `beq`.
         *   (2) PEEL THE DECREMENT OUT OF THE GUARD TEST (`--cnt; if (cnt != g)`).  reorg fills
         *       the preceding arm-join `j`'s delay slot by STEALING the first insn of the target
         *       block and duplicating it; retail's stolen insn is the peeled `addiu $a0,$a0,-1`.
         *       With the decrement still inside the `if`, whatever we put before it becomes the
         *       block's first insn and gets stolen instead (measured: the sentinel's `li $t0,-1`
         *       duplicated into the slot, 4 diffs).
         * MEASURED at this basin, all 157/157 count-exact: the pair above PASS | `neg1 = -1`
         * BEFORE `ac = &_actcur;` 2 (the `li` then precedes the `la`) | a read-only fence on `g`
         * instead of the launder 2 | additionally laundering `neg1` 12, with a `"$7"` clobber 8 |
         * no peel-split, sentinel laundered before the guard + `"$7"` clobber 4 (the register
         * pair is right, the `li` is stolen) | the same without the clobber 14 ($a3/$t0 swapped:
         * the sentinel allocates first and takes the lower reg) | 22B-3 tied multi-output launder
         * on (cnt, neg1) 30 | void barrier at the anchor 2 (inert). */
        --cnt;
        {
            int g = -1;
            __asm__("" : "=r"(g) : "0"(g));   /* 21E-5 first-occurrence opacity fence */
            if (cnt != g) {
                int neg1;
                ac = &_actcur;
                neg1 = -1;                    /* fresh `li $t0,-1` -- no live -1 to share */
                do {
                    if (info[0x48] == 0) goto tail;
                    *(*ac)++ = *src++;
                    info[0x48] = info[0x48] - 1;
                } while (--cnt != neg1);
            }
        }
        if (info[0x48] == 0) goto tail;
return_zero:
        return 0;
tail:
        n = info[0x47] + 1;
        info[0x47] = n;
        if (n >= info[0xea]) {
            info[0x49] = 6;
            info[0x46] = 0xfe;
            return 0;
        }
        info[0x48] = 0;
        goto return_zero;
    }
    }
return_one:
    return 1;
}

/* =====================  set-actuator-align command  =========================================== */

/* @0x80105BF4 : _padSetActAlign -- queue the actuator-alignment command (returns 1 if accepted).
 * w48-a3: PASS 26/26.  The w23-a8 "WEAK floor" (oracle materializes TWO separate `li 1`'s --
 * $v0 for the return, $v1 for the 0x46 store -- where ours copy-substituted `addu v1,v0,zero`)
 * is the §3.25-3b "old-gcc no-copy-prop" identity: retail's cc1 rematerializes a still-live
 * constant, ours lets cse substitute the equal live value.  The reachable lever is the w47
 * OPACITY/IDENTITY FENCE `__asm__("" : "=r"(x) : "0"(x))` -- a ZERO-INSTRUCTION value-numbering
 * barrier (output tied to input by the "0" constraint, so no code is emitted) that stops cse
 * proving `r == 1` at the store.  DIRECTION IS LOAD-BEARING: fencing the STORE's constant
 * instead leaves both `li`s but in the WRONG ORDER (ours v1-then-v0 vs the oracle's v0-then-v1,
 * still 2 diffs) -- fencing `r` also PINS the return constant's materialization first, which is
 * exactly the oracle's order.  Do not "simplify" the asm away. */
extern int _padSetActAlign(unsigned char *info, unsigned char *data)
{
    if (_padFuncChkEng(info) == 0) {
        int r = 1;
        __asm__("" : "=r"(r) : "0"(r));   /* MATCH: opacity fence, 0 insns -- see header */
        info[0x46] = 1;
        *(void (**)(unsigned char *))(info + 0x14) = _padSetActAlign_snd;
        *(unsigned char **)(info + 0x20) = data;
        *(void (**)(unsigned char *))(info + 0x18) =
            (void (*)(unsigned char *))_padSetActAlign_rcv;
        return r;
    }
    return 0;
}

/* @0x80105C5C : _padSetActAlign_snd -- emit the 0x4D align packet. */
extern void _padSetActAlign_snd(unsigned char *info)
{
    info[0x36] = 0x4d;
    info[0x35] = 6;
    *(unsigned char **)(info + 0x2c) = *(unsigned char **)(info + 0x20);
}

/* @0x80105C78 : _padSetActAlign_rcv -- resolve each mode's actuator map from the alignment request.
 * MATCH (w51-a5): it is NOT void -- the oracle's epilogue is `jr $ra / addu $v0,$zero,$zero`
 * (§3.2 void-return bug); the `return 0;` reserves $v0 and re-shapes the tail.
 * w61-a6 STRUCTURAL FINDING (27 @51/50, count NOT yet improved -- reported, not landed).  The
 * actMap store is the one real SHAPE difference left: retail keeps `slot` as a plain biv
 * (`addu $a2,$a0,$zero` in the inner preheader, `sb $t3,93($a2)`, `addiu $a2,$a2,1`), while our
 * loop.c strength-reduces the address `slot[0x5d]` into its own giv (`addiu $v1,$a0,93`,
 * `sb $t3,0($v1)`).  A PER_FN_FLAG_SPLICE_272 `-fno-strength-reduce` on THIS FN ALONE reproduces
 * retail's `sb $t3,93($a2)` / `sb $t0,93($a2)` exactly (verified in the spliced .s).  Diff count
 * is UNCHANGED at 27 because two other items remain, so this is NOT a wiring recommendation yet:
 *   (i) `addu $t2,$t0,$zero` (cse copies `mode`'s just-materialised 0 into `row`) vs retail's
 *       independent `addu $t2,$zero,$zero` emitted AFTER `li $t3,255` -- retail's `row` is a
 *       loop.c GIV of `mode*5` whose preheader init lands in the giv group (same class as
 *       eaclib pad.c PAD_update item 2, which has ~15 falsified forms);
 *   (ii) a 3-way register rotation, ours matchcount/k/slot = $a2/$a3/$v1 vs retail $a3/$v1/$a2;
 *   (iii) one insn over (51 vs 50): retail hoists the outer-loop re-test `lbu $v0,233($a0)`
 *       ABOVE `addiu $t0,$t0,1` so the increment covers the load-delay slot; ours emits it after
 *       and pays a nop.  That one IS a pure TEXT_MOVES relocation once (i)+(ii) are settled.
 * Lane-invariant: 27 on the wired 2.7.2-970404 rung AND on the cc1_272 (PsyQ CC1PSX) lane.
 * w62-a5 RE-LADDER + falsifications (04Z re-probe at the current basin, all re-gated here):
 *   per-fn flag splices -fno-strength-reduce / -fno-schedule-insns / -fno-schedule-insns2 are
 *   ALL still 27 @51/50 (the strength-reduce splice still produces retail's `sb $t3,93($v1)`
 *   displacement form, but its base copy `addu $v1,$a0,$zero` then lands 9 insns EARLY, in the
 *   OUTER preheader instead of the inner one, so the win is traded 1:1).  For item (iii) (the
 *   one-insn overrun: retail loads `lbu $v0,233($a0)` ABOVE `addiu $t0,$t0,1` so the increment
 *   covers the load delay) two source spellings were falsified: flipping the do/while compare
 *   operand order (`(int)info[0xe9] > (int)mode`, inert 27) and hoisting the limit into a named
 *   `int nmodes` read before `mode++` (inert 27) -- gcc's scheduler re-sinks the load either way.
 *   Item (ii) remains the blocker: a 3-way LOCAL-QTY rotation (ours matchcount/k/slot =
 *   $a2/$a3/$v1, retail $a3/$v1/$a2).  Next instrument, not yet run here: tools/qty272.py /
 *   reqdelta272.py (12A -- the 2.7.x local-alloc handout is now readable off `-dl`), to price
 *   which qty must move before any further spelling sweep.
 * MATCH (w63-a8, 27 -> 2 @50/50 count-EXACT; PASS under a per-fn 2.7.2 ver-splice).  The w61/w62
 *   verdict "3-way LOCAL-QTY rotation" was WRONG ON TWO COUNTS, and running the instrument the
 *   w62 receipt itself named settled both:
 *   (A) THEY ARE GLOBAL ALLOCNOS, NOT LOCAL QTYS.  qty272.py puts matchcount/slot/k at global
 *       ranks 3/2/4 (pri 2.3448 / 3.0000 / 1.6500); the local-qty list holds only the $v0 temps.
 *       So the 3-QTY LADDER LAW (14C) never applied and the whole "local-alloc handout" framing
 *       was a dead end.  reqdelta272 prices the WHOLE 3-cycle as ONE promotion: `k` must clear
 *       pri 3.00 to overtake BOTH rivals, i.e. refs 11 -> 16 across the floor_log2 step
 *       (4*16/20 = 3.20).  Two in-loop read-only fence operands buy exactly that -> 27 -> 8, and
 *       matchcount/k/slot land on retail's $a3/$v1/$a2 simultaneously.  OPERAND COUNT IS THE DIAL
 *       (1 op = 26, 2/3/4 ops = 8) and FENCE POSITION IS A SEPARATE DIAL (13B): after the if-block
 *       and BEFORE `k++` = 2 @50/50; after `k++` = 5 @51 (the asm then sits between the branch and
 *       its only eligible filler, and reorg.c:685 stop_search_p aborts the backward scan -> the
 *       back-edge slot stays `nop` where retail has `addiu $a2,$a2,1`); top-of-body = 24; before
 *       the `if` = 5 @49.
 *   (B) TWO "allocator" items were really GHIDRA-INVENTED BIVS -- the same defect twice:
 *       * `slot` (a walking `unsigned char *`) made loop.c strength-reduce `slot[0x5d]` into its
 *         own address giv (`addiu $v1,$a0,93` + `sb $t3,0($v1)`).  Retail keeps a plain walker
 *         with 0x5D as the load DISPLACEMENT.  Deleting `slot` and writing the INDEX form
 *         `info[k + 0x5d]` (the counter `k` already exists) makes loop.c build exactly retail's
 *         giv: `addu $a2,$a0,$zero` + `sb $t3,0x5D($a2)` + `addiu $a2,$a2,1`.  This RETIRES the
 *         w61/w62 `-fno-strength-reduce` PER_FN_FLAG_SPLICE_272 angle -- the shape is source-
 *         reachable, and the flag splice is now measured 48 @48 (strictly worse).
 *       * `row` (the `row += 5` accumulator) is retail's giv of `mode*5`.  Deleting it and
 *         writing `mode * 5 + *(int *)(info + 4) + 2` inline puts the init in the giv preheader
 *         group and closes item (iii) (the `lbu $v0,233($a0)` hoist) for free: 8 -> 5 @51.
 *   RESIDUAL 2 (wired 970404 rung), count-EXACT: `addu $t2,$t0,$zero` vs retail `addu $t2,$zero,
 *       $zero` -- cse substitutes the still-live 0 in `mode`'s register for the giv's own zero.
 *       That is the pure 3.25-3b no-copy-prop identity, and it is a RUNG property, not a spelling:
 *       falsified here = identity-launder on `row`, decl/assign split, row-before-mode (10).
 *   04Z (9th+ confirmation): the ladder INVERTED at the new basin.  Pre-landing this fn was
 *       LANE-INVARIANT at 27 (970404 == cc1_272); post-landing 2.7.2 = 3 and 2.6.3 = 3 vs the
 *       wired 970404's 5, and after the fence-position fix 2.7.2 = PASS 50/50 vs 970404's 2.
 *       => ORCHESTRATOR WIRING (spec + whole-TU receipts in scratchpad/w63a8/): add
 *       `_padSetActAlign_rcv` to the EXISTING PER_FN_CC1_VER_SPLICE_272 2.7.2 set for this TU
 *       (merge into the existing key -- 12F duplicate-key hazard).  Whole-TU with the splice:
 *       18/19 PASS, ZERO regressions (all 19 fns gated). */
extern int _padSetActAlign_rcv(unsigned char *info)
{
    unsigned mode = 0;
    if (info[0xe9] != 0) {
        do {
            int matchcount;
            int j;
            int k;
            unsigned char *p;


            p = *(unsigned char **)(info + 0x20);
            matchcount = 0;
            j = 5;
            do {
                unsigned v = *p++;   /* MATCH (w53-a8): BASIN-RELATIVE -- this same widening
                                      * measured 40 BEFORE the second loop's local was widened
                                      * and 28 -> 27 after it (w45 lever-order law).  Re-probe
                                      * parked spellings after every landing. */
                if (v == mode) matchcount++;
                j--;
            } while (j > -1);

            {
                unsigned thresh = *(unsigned char *)(mode * 5 + *(int *)(info + 4) + 2);
                p = *(unsigned char **)(info + 0x20);
                k = 0;
                if (thresh == 0) thresh = 1;
                do {
                    unsigned v = *p++;   /* MATCH (w53-a8): `unsigned`, not `unsigned char` --
                                          * the byte-typed local re-masks with `andi $v0,$v0,255`
                                          * on every use; `lbu` already zero-extends (29 -> 28,
                                          * -1 insn).  The SAME change on the match-count loop
                                          * above regresses (40) -- per-site, measure both. */
                    if (v == mode) {
                        if (matchcount < (int)thresh) { info[k + 0x5d] = 0xff; matchcount--; }
                        else                          info[k + 0x5d] = (unsigned char)mode;
                    }
                    __asm__("" : : "r"(k), "r"(k));
                    k++;
                } while (k < 6);
            }
            mode++;
        } while ((int)mode < (int)info[0xe9]);
    }
    info[0x46] = 0xfe;
    return 0;
}

/* =====================  set-main-mode command  ================================================= */

/* @0x80105D40 : _padSetMainMode -- queue the main-mode switch (offs = mode index, lock = lock flag).
 * w48-a3: PASS 38/38, refuting the w23-a8 "FLOOR (21 diffs)" note.  FOUR cooperating parts, each
 * measured (drop any one and it regresses: [] 21 / [r] 15 / [o] 14 / [l] 27 / [ro] 10 / [rl] 23 /
 * [ol] 4 / [rol] 0):
 *   (1) `int m = offs;` BEFORE the call.  Retail keeps `offs` in TWO callee-saved regs across the
 *       ChkEng() call -- $s1 for the `info[0x51]` store and $s3 (copied in the jalr delay slot) for
 *       the `(offs & 0xff)` compare.  Our cse copy-propagates the second home away, so the copy is
 *       deleted (delete_noop_moves / the §3.25-3b "old-gcc no-copy-prop" identity).
 *   (2) an OPACITY FENCE on `offs` (w47 §A, `__asm__("" : "=r"(x) : "0"(x))` = a ZERO-INSTRUCTION
 *       value-numbering barrier) placed AFTER the call: it makes `m` and `offs` un-equatable at the
 *       compare, so the copy survives -- and, being after the call, it does NOT block dbr from
 *       sinking that copy into the jalr's delay slot (the same fence placed BEFORE the call keeps
 *       the copy but pins it in the prologue and costs two nops: measured 20 diffs).
 *   (3) a fence on `lock` as a pure ZERO-INSN REF INFLATOR (w44/w46 ref-step family).  Without it
 *       `lock` (2 refs / 38 insns, pri .0526) loses the allocno race to `m` (2 refs / 21, pri .0952)
 *       and the two land in the WRONG registers ($s3/$s2 instead of retail's $s2/$s3).  The asm insn
 *       adds a def+use, taking `lock` to 4 refs -> floor_log2 steps 1->2 -> pri .2105 -> `lock` is
 *       allocated first and takes $s2.  (Measured NEGATIVE first: `& 0xff` re-mask and do{}while(0)
 *       depth-1/2/3 wrappers all left REG_N_REFS at 2 -- cse/loop.c strip them here.)
 *   (4) `int cur = info[0xe4];` as a DECL-INITIALIZER at the top of the block -- this, and only this,
 *       makes sched1 hoist the `lbu a0,0xe4(s0)` to retail's position right after the `li v0,1`.
 *       The same read as a later ASSIGNMENT statement (any of 3 positions probed) does NOT hoist.
 *   (5) the fence on `r` supplies the fresh `li v1,1` for the 0x46 store and the `sltiu v1,v1,1`
 *       immediate compare -- same device/reason as _padSetActAlign above.
 * Do not "simplify" any of the three asm statements away. */
extern int _padSetMainMode(unsigned char *info, int offs, int lock)
{
    int m = offs;                                  /* MATCH: retail's 2nd callee-saved home for offs */
    if (_padFuncChkEng(info) == 0) {
        int r = 1;
        int cur = info[0xe4];                      /* MATCH: decl-init -> sched1 hoists the lbu */
        __asm__("" : "=r"(r) : "0"(r));            /* MATCH: opacity fence, 0 insns -- see header */
        __asm__("" : "=r"(offs) : "0"(offs));      /* MATCH: keeps m's copy alive (post-call) */
        __asm__("" : "=r"(lock) : "0"(lock));      /* MATCH: ref inflator, wins $s2 for lock */
        /* MATCH (w53-a8, 2 -> PASS 38/38): USE FENCE ON `cur` = a sched1 issue-position fixpoint.
         * The only residual was POSITION: retail issues `lbu $a0,228($s0)` immediately after the
         * `li $v0,1`, ours let sched1 sink it 5 slots down into the second address-materialize's
         * latency gap.  A zero-insn read-only fence on cur pins it (insns before a fence cannot
         * sink past it -- w45 law).  Falsified at this basin: splitting the decl-init into
         * decl + assignment (2, identical). */
        __asm__("" : : "r"(cur));
        info[0x46] = 1;
        *(void (**)(unsigned char *))(info + 0x14) = _padSetMainMode_snd;
        *(void (**)(unsigned char *))(info + 0x18) =
            (void (*)(unsigned char *))_padSetMainMode_rcv;
        info[0x51] = (unsigned char)offs;
        info[0x52] = (unsigned char)lock;
        info[0x53] = (unsigned char)((m & 0xff) == cur);
        return r;
    }
    return 0;
}

/* @0x80105DD8 : _padSetMainMode_snd.
 * MATCH: goto form → beq/beq/j pattern (not bne/bne fall-through).
 *        info[0x35]=st in case2 delay slot reuses cached v1=st(=2).
 * w48-a3: PASS 21/21, refuting the w23-a8 "FLOOR (7 diffs)" note.  The residual was gcc-2.8
 * jump.c replacing each `j end` with a DUPLICATED `jr ra`, because the `end:` label sat
 * immediately in front of the return -- retail keeps ONE shared epilogue block (`jr ra; nop`
 * @.L80105E24) that both the no-match fallthrough and case2 `j` to.  A ZERO-INSTRUCTION
 * `__asm__ volatile ("")` AT the label makes end:'s block start with a non-return insn, so
 * jump_optimize leaves both `j`s alone; the asm emits no bytes, so the object is retail's
 * exactly.  (`"r"(info)` use-fence and a `"memory"` clobber measure identically -- the empty
 * volatile form is the least invasive.)  Do not delete the asm statement. */
extern void _padSetMainMode_snd(unsigned char *info)
{
    int st = info[0x46];    /* lbu; int avoids andi 0xff promotion */
    if (st == 2) goto case2;
    if (st == 3) goto case3;
    goto end;
case2:
    info[0x36] = 0x44;
    *(unsigned char **)(info + 0x2c) = info + 0x51;
    info[0x35] = st;
    goto end;
case3:
    info[0x36] = 0x4d;
    *(unsigned char **)(info + 0x2c) = info + 0x5d;
    info[0x35] = 6;
end: ;
    __asm__ volatile ("");   /* MATCH: keeps the shared epilogue -- see header */
}

/* @0x80105E2C : _padSetMainMode_rcv -- w48-a3: PASS 24/24 (was FAIL 19).
 * TWO reconstruction errors, both read straight off the oracle (§3.2 + §D arm-order):
 *   (a) it is NOT void -- the oracle stages `addiu $v0,$zero,1` / `addu $v0,$zero,$zero` into the
 *       return register on the two paths (1 = "already in the requested mode", 0 = otherwise).
 *       Declaring it void loses both, and costs the $v0 reservation that shapes the whole tail.
 *   (b) the ARM ORDER was inverted: the oracle's `beqz $v0,.L80105E64` makes the ClrInfo call the
 *       BRANCH TARGET and the `info[0x53] != 0` case the FALL-THROUGH, i.e. the != arm is the
 *       if-BODY.  (The callback is still installed through a `void (*)(u_char *)` slot -- the
 *       return value is simply ignored by the SIO pump, exactly as in retail.) */
extern int _padSetMainMode_rcv(unsigned char *info)
{
    if (info[0x53] != 0) {
        if (info[0x46] == 2)
            return 1;
        info[0x46] = 0xfe;
        return 0;
    }
    _padFuncClrInfo(info);
    return 0;
}

/* @0x80105E8C : _padCmdParaMode -- 0x43 enter-config(para).
 * MATCH: r=1 hoisted early so v0=1 is live before sb a1,0x24; jr ra delay-slot gets sb v0,0x35. */
extern int _padCmdParaMode(unsigned char *info, int para)
{
    int r;
    info[0x36] = 0x43;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    r = 1;
    info[0x24] = (unsigned char)para;
    info[0x35] = (unsigned char)r;
    return r;
}

/* @0x80105EAC : _padCmdGetStatus -- 0x45 get-status. */
extern int _padCmdGetStatus(unsigned char *info)
{
    int r = 0x45;                       /* one li v0,0x45 reused for the 0x36 store AND the return */
    info[0x36] = (unsigned char)r;
    *(int *)(info + 0x2c) = 0;
    info[0x35] = 0;
    return r;
}

/* @0x80105EC0 : _padCmdSetMap -- 0x4C set-config-map(idx).
 * MATCH: same r=1 hoist as _padCmdParaMode. */
extern int _padCmdSetMap(unsigned char *info, int idx)
{
    int r;
    info[0x36] = 0x4c;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    r = 1;
    info[0x24] = (unsigned char)idx;
    info[0x35] = (unsigned char)r;
    return r;
}

/* @0x80105EE0 : _padCmdGetDescR0 -- 0x46 get-descriptor-0(idx).
 * MATCH: same r=1 hoist. */
extern int _padCmdGetDescR0(unsigned char *info, int idx)
{
    int r;
    info[0x36] = 0x46;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    r = 1;
    info[0x24] = (unsigned char)idx;
    info[0x35] = (unsigned char)r;
    return r;
}

/* @0x80105F00 : _padCmdGetDescR1 -- 0x47 get-descriptor-1(idx).
 * MATCH: same r=1 hoist. */
extern int _padCmdGetDescR1(unsigned char *info, int idx)
{
    int r;
    info[0x36] = 0x47;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    r = 1;
    info[0x24] = (unsigned char)idx;
    info[0x35] = (unsigned char)r;
    return r;
}

/* @0x80105F20 : _padCmd4B -- 0x4B exit-config. */
extern int _padCmd4B(unsigned char *info)
{
    int r = 0x4b;                       /* one li v0,0x4b reused for the 0x36 store AND the return */
    info[0x36] = (unsigned char)r;
    *(int *)(info + 0x2c) = 0;
    info[0x35] = 0;
    return r;
}

