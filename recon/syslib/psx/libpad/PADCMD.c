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

typedef void (*PadSndRcv)(unsigned char *info);

extern int  (*_padFuncChkEng)(unsigned char *info);            /* dispatch slot: engine-busy? (0 = free) */
extern void (*_padFuncClrInfo)(unsigned char *info);

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

/* @0x80105680 : _padRecvAtLoadInfo -- consume one response of the load-info handshake.
 * w51-a5: 105 -> 70 diffs, now COUNT-EXACT 83/83.  Three oracle-read corrections:
 *   (a) a real `switch (info[0x46])` with cases in SOURCE order 2/3/4 -- gcc-2.8's
 *       balance_case_nodes fingerprint (median-pivot `beq ,3` with `slti ,4` in its delay slot,
 *       out-of-line case bodies, `j` default).  The if/else-if cascade laid the arms out wrong.
 *   (b) the rx pointer (+0x3c) is spelled INLINE at every use -- case 2's oracle has FOUR
 *       separate `lw $v0,0x3C($s0)` because each `sb` may-alias the pointer field.
 *   (c) `accum + 8` is its own term (a single `a + 8 + ((n+3)&0x1fc)` expression reassociates
 *       the +8 onto the masked term), and the size guard is `>= 0x81` so the `slti 0x81; bnez`
 *       arm order matches.
 * RESIDUAL 70 @83/83: register rotation (v0/v1/a0) in the case-2 byte shuffle + the shared
 * return-0 block (.L8010576C) that jump.c duplicates here. */
extern int _padRecvAtLoadInfo(unsigned char *info)
{
    switch (info[0x46]) {
    case 2:
        info[0xe3] = (*(unsigned char **)(info + 0x3c))[3];
        info[0xe4] = (*(unsigned char **)(info + 0x3c))[4];
        *(unsigned short *)(info + 0xe6) = 0;
        info[0xe9] = (*(unsigned char **)(info + 0x3c))[5];
        info[0xea] = (*(unsigned char **)(info + 0x3c))[6];
        *(int *)(info + 0xec) = 0;
        return 1;
    case 3:
        info[0x47] = 0;
        *(unsigned short *)(info + 0xe6) =
            (unsigned short)(*(unsigned char **)(info + 0x3c))[5] +
            (unsigned short)(*(unsigned char **)(info + 0x3c))[4] * 0x100;
        return 1;
    case 4: {
        unsigned char idx = info[0x47] + 1;
        int acc = *(int *)(info + 0xec) + 8;     /* MATCH: `accum + 8` FIRST -- one expression
                                                  * reassociates the +8 onto the masked term */
        info[0x47] = idx;
        acc += (((*(unsigned char **)(info + 0x3c))[4] + 3) & 0x1fc);
        *(int *)(info + 0xec) = acc;
        if (idx < info[0xea])
            return 0;
        if (_padGetActSize(info) >= 0x81) {       /* MATCH: oracle `slti 0x81; bnez` -- the
                                                   * >= arm is the FALL-THROUGH */
            info[0x46] = 0xfe;
            info[0x49] = 2;
            return 0;
        }
        info[0x46] = 0xff;
        _padLoadActInfo(info, info + 0x63);
        info[0x46] = 2;
        return 0;
    }
    }
    return 1;
}

/* @0x80105804 : _padLoadActInfo -- carve the actuator buffer (info+0x63) into mode/act sub-regions
 *   and install the descriptor send/recv pump.  `buf` is that buffer (aligned up to 4). */
extern int _padLoadActInfo(unsigned char *info, unsigned char *buf)
{
    int aw;
    unsigned char *a;

    if (buf == 0)
        return 0;
    if (*(int *)(info + 4) != 0)
        return 0;
    /* RESIDUAL 38 @53/53 count-exact (w55-a6 re-read of the oracle -- the block LAYOUT is the
     * root, not coloring).  Retail places the SHARED `return 0` block (.L8010584C:
     * `j <epilogue>; addu $v0,$zero,$zero`) BETWEEN the ChkEng test and the body, because the
     * `buf == 0` guard branches to it -- so the ChkEng guard has to SKIP OVER it
     * (`beqz $v0,.L80105854` = branch to the BODY, with `addiu $v0,$zero,1` -- the eventual
     * `return 1` -- pre-set in its delay slot).  Ours emits `bnez $v0,<ret0>` with ret0 placed
     * elsewhere.  🔑 And retail's `buf == 0` branch carries `sw $ra,0x18($sp)` IN ITS DELAY SLOT
     * -- a PROLOGUE STORE, i.e. the w54-06B PER_FN_PROLOGUE_FILL class (reorg's backward scan
     * reaching into the prologue), where ours fills that slot with `addu $v0,$zero,$zero`.
     * FALSIFIED (w55-a6): hoisting the whole body into `if (_padFuncChkEng(info) == 0) { ... }
     * return 0;` -- it flips the ChkEng polarity the right way but ALSO flips the info+4 guard
     * (which already matched) and adds an insn: 43 @54/53.  The two guards' polarities are
     * coupled through the shared ret0 block; the reachable lever is its PLACEMENT. */
    if (_padFuncChkEng(info) != 0)
        return 0;
    {
        aw = ((int)buf + 3) >> 2;            /* MATCH (w51-a5): the oracle rounds up with a SIGNED
                                              * `addiu ,3 / sra ,2` ... `sll ,2` PAIR (word index
                                              * materialized early, scaled back late), not the
                                              * `& ~3` mask a single expression emits */
        info[0x49] = 4;
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padLoadActInfo_snd;
        *(PadSndRcv *)(info + 0x18) = (PadSndRcv)_padLoadActInfo_rcv;
        a = (unsigned char *)(aw << 2);
        *(unsigned char **)(info + 0) = a;
        info[0x47] = 0;
        a += ((info[0xe3] + 1) >> 1) << 2;
        *(unsigned char **)(info + 4) = a;
        *(unsigned char **)(info + 8) = a + ((info[0xe9] * 5 + 3) & 0xffc);
        return 1;
    }
    return 0;
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
 *   under the cc1_272 lane, where this fn is COUNT-EXACT 157/157 @38). */
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
        return 1;
    }
    case 3: {                                        /* mode descriptor R0 */
        unsigned char *d = *(unsigned char **)(info + 4) + info[0x47] * 5;
        unsigned char n;
        d[0] = (*(unsigned char **)(info + 0x3c))[4];
        d[1] = (*(unsigned char **)(info + 0x3c))[5] & 0x7f;
        d[2] = (*(unsigned char **)(info + 0x3c))[6];
        d[3] = (*(unsigned char **)(info + 0x3c))[7];
        d[4] = (unsigned char)((*(unsigned char **)(info + 0x3c))[5] >> 7);
        n = info[0x47] + 1;
        info[0x47] = n;
        if (n < info[0xe9])
            return 0;
        info[0x47] = 0;
        info[0x48] = 0;
        return 1;
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
            cnt = 3;
            __asm__("" : "=r"(cnt) : "0"(cnt));  /* MATCH: opacity fence, 0 insns -- keeps cse from
                                                  * folding the live `3` into the woff `sll ,3`
                                                  * (retail rematerializes: `sllv` is the tell) */
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
            *(unsigned char **)(d + 4) = cur;
            _actcur = cur;
        } else {
            src = (*(unsigned char **)(info + 0x3c)) + 2;
            cnt = 6;
        }
        ac = &_actcur;                           /* MATCH: pointer local -- the oracle keeps
                                                  * `la $a3,_actcur` live across the loop and the
                                                  * body does ONE `lw 0($a3)` / `sw 0($a3)` per
                                                  * iteration (a direct `_actcur` re-reads twice) */
        while (--cnt != -1) {
            if (info[0x48] == 0) goto tail;
            *(*ac)++ = *src++;
            info[0x48] = info[0x48] - 1;
        }
        if (info[0x48] == 0) goto tail;
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
        return 0;
    }
    }
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
extern int _padSetActAlign(unsigned char *info, int data)
{
    if (_padFuncChkEng(info) == 0) {
        int r = 1;
        __asm__("" : "=r"(r) : "0"(r));   /* MATCH: opacity fence, 0 insns -- see header */
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padSetActAlign_snd;
        *(int *)(info + 0x20) = data;
        *(PadSndRcv *)(info + 0x18) = (PadSndRcv)_padSetActAlign_rcv;
        return r;
    }
    return 0;
}

/* @0x80105C5C : _padSetActAlign_snd -- emit the 0x4D align packet. */
extern void _padSetActAlign_snd(unsigned char *info)
{
    info[0x36] = 0x4d;
    info[0x35] = 6;
    *(int *)(info + 0x2c) = *(int *)(info + 0x20);
}

/* @0x80105C78 : _padSetActAlign_rcv -- resolve each mode's actuator map from the alignment request.
 * MATCH (w51-a5): it is NOT void -- the oracle's epilogue is `jr $ra / addu $v0,$zero,$zero`
 * (§3.2 void-return bug); the `return 0;` reserves $v0 and re-shapes the tail. */
extern int _padSetActAlign_rcv(unsigned char *info)
{
    unsigned mode = 0;
    if (info[0xe9] != 0) {
        int row = 0;
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
                unsigned thresh = *(unsigned char *)(row + *(int *)(info + 4) + 2);
                unsigned char *slot = info;
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
                        if (matchcount < (int)thresh) { slot[0x5d] = 0xff; matchcount--; }
                        else                          slot[0x5d] = (unsigned char)mode;
                    }
                    k++;
                    slot++;
                } while (k < 6);
            }
            mode++;
            row += 5;
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
        *(PadSndRcv *)(info + 0x14) = _padSetMainMode_snd;
        *(PadSndRcv *)(info + 0x18) = (PadSndRcv)_padSetMainMode_rcv;
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
