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

static unsigned char *_actcur;   /* @0x8014859C : actuator-descriptor write cursor */

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
extern void _padLoadActInfo_rcv(unsigned char *info);
extern void _padSetActAlign_snd(unsigned char *info);
extern void _padSetActAlign_rcv(unsigned char *info);
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
extern int _padSendAtLoadInfo(unsigned char *info)
{
    int st;
    int r;
    st = info[0x46];
    if (st == 3) {
        r = _padCmdSetMap(info, info[0xe4]);
    } else if (st < 4) {
        r = 2;
        if (st == 2)
            r = _padCmdGetStatus(info);
    } else {
        r = 4;
        if (st == 4)
            r = _padCmdGetDescR1(info, info[0x47]);
    }
    return r;
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

/* @0x80105680 : _padRecvAtLoadInfo -- consume one response of the load-info handshake. */
extern int _padRecvAtLoadInfo(unsigned char *info)
{
    unsigned char *rx = *(unsigned char **)(info + 0x3c);
    int st = info[0x46];

    if (st == 3) {
        unsigned char hi;
        unsigned char lo;
        hi = rx[4];
        lo = rx[5];
        info[0x47] = 0;
        *(unsigned short *)(info + 0xe6) = (unsigned short)lo + (unsigned short)hi * 0x100;
        return 1;
    }
    if (st > 3) {
        unsigned char nb;
        unsigned char idx;
        if (st != 4)
            return 1;
        idx = info[0x47] + 1;
        nb = rx[4];
        info[0x47] = idx;
        *(int *)(info + 0xec) = *(int *)(info + 0xec) + 8 + ((nb + 3) & 0x1fc);
        if (info[0xea] <= idx) {
            int sz = _padGetActSize(info);
            if (sz < 0x81) {
                info[0x46] = 0xff;
                _padLoadActInfo(info, info + 0x63);
                info[0x46] = 2;
            } else {
                info[0x46] = 0xfe;
                info[0x49] = 2;
            }
        }
        return 0;
    }
    if (st != 2)
        return 1;
    info[0xe3] = rx[3];
    info[0xe4] = rx[4];
    *(unsigned short *)(info + 0xe6) = 0;
    info[0xe9] = rx[5];
    info[0xea] = rx[6];
    *(int *)(info + 0xec) = 0;
    return 1;
}

/* @0x80105804 : _padLoadActInfo -- carve the actuator buffer (info+0x63) into mode/act sub-regions
 *   and install the descriptor send/recv pump.  `buf` is that buffer (aligned up to 4). */
extern int _padLoadActInfo(unsigned char *info, unsigned char *buf)
{
    if (buf != 0 && *(int *)(info + 4) == 0 && _padFuncChkEng(info) == 0) {
        unsigned char *a = (unsigned char *)(((unsigned long)buf + 3) & ~3UL);
        info[0x49] = 4;
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padLoadActInfo_snd;
        *(PadSndRcv *)(info + 0x18) = _padLoadActInfo_rcv;
        *(unsigned char **)(info + 0) = a;
        info[0x47] = 0;
        a += ((info[0xe3] + 1) >> 1) * 4;
        *(unsigned char **)(info + 4) = a;
        *(unsigned char **)(info + 8) = a + (((unsigned)info[0xe9] * 5 + 3) & 0xffc);
        return 1;
    }
    return 0;
}

/* @0x801058D8 : _padLoadActInfo_snd -- emit the right descriptor request for the current sub-phase. */
extern void _padLoadActInfo_snd(unsigned char *info)
{
    int st = info[0x46];
    if (st == 3) {
        _padCmdGetDescR0(info, info[0x47]);
    } else if (st < 4) {
        if (st == 2)
            _padCmdSetMap(info, info[0x47]);
    } else if (st == 4) {
        if (info[0x48] == 0)
            _padCmdGetDescR1(info, info[0x47]);
        else
            _padCmd4B(info);
    }
}

/* @0x80105980 : _padLoadActInfo_rcv -- parse a descriptor response into the mode/act tables. */
extern void _padLoadActInfo_rcv(unsigned char *info)
{
    unsigned char *rx = *(unsigned char **)(info + 0x3c);
    int st = info[0x46];

    if (st == 3) {                                   /* mode descriptor R0 */
        unsigned char *d = *(unsigned char **)(info + 4) + info[0x47] * 5;
        d[0] = rx[4];
        d[1] = rx[5] & 0x7f;
        d[2] = rx[6];
        d[3] = rx[7];
        d[4] = (unsigned char)((unsigned)rx[5] >> 7);
        info[0x47] = info[0x47] + 1;
        if (info[0xe9] <= info[0x47]) { info[0x47] = 0; info[0x48] = 0; }
    } else if (st < 4) {                             /* mode-id list (set-map) */
        if (st == 2) {
            *(unsigned short *)(*(unsigned char **)(info + 0) + info[0x47] * 2) =
                (unsigned short)rx[5] + (unsigned short)rx[4] * 0x100;
            info[0x47] = info[0x47] + 1;
            if (info[0xe3] <= info[0x47]) info[0x47] = 0;
        }
    } else if (st == 4) {                            /* actuator descriptor R1 (variable length) */
        unsigned char *d = *(unsigned char **)(info + 8) + info[0x47] * 8;
        unsigned char *src;
        int cnt;
        if (info[0x48] == 0) {
            unsigned char v = rx[4];
            info[0x48] = v;
            d[0] = v;
            src = rx + 5;
            {
                unsigned char *base;
                unsigned woff;
                if (info[0x47] == 0) {
                    base = *(unsigned char **)(info + 8);
                    woff = (unsigned)info[0xea] << 3;
                } else {
                    base = *(unsigned char **)(d - 4);
                    woff = (d[-8] + 3) & 0x1fc;
                }
                _actcur = base + woff;
            }
            *(unsigned char **)(d + 4) = _actcur;
            cnt = 2;
        } else {
            src = rx + 2;
            cnt = 5;
        }
        while (cnt != -1) {
            cnt = cnt - 1;
            if (info[0x48] == 0) goto tail;
            *_actcur = *src;
            src++;
            _actcur++;
            info[0x48] = info[0x48] - 1;
        }
        if (info[0x48] == 0) {
tail:
            info[0x47] = info[0x47] + 1;
            if (info[0x47] < info[0xea]) {
                info[0x48] = 0;
            } else {
                info[0x49] = 6;
                info[0x46] = 0xfe;
            }
        }
    }
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
        *(PadSndRcv *)(info + 0x18) = _padSetActAlign_rcv;
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

/* @0x80105C78 : _padSetActAlign_rcv -- resolve each mode's actuator map from the alignment request. */
extern void _padSetActAlign_rcv(unsigned char *info)
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
                unsigned char v = *p++;
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
                    unsigned char v = *p++;
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
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padSetMainMode_snd;
        *(PadSndRcv *)(info + 0x18) = _padSetMainMode_rcv;
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
