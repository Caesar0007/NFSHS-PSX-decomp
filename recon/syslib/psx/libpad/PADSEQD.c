/* syslib/psx/libpad/PADSEQD.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADSEQD.OBJ): the direct-mode "auto" sequencer -- 5 functions that drive the
 *   per-VSync controller handshake for one port.  _padInitDirSeq installs the three auto-mode
 *   dispatch slots; the SIO engine (PADMAIN) then calls _dirSendAuto to emit the next request,
 *   _dirRecvAuto to absorb the reply (copying it into the caller's PADL buffer at info+0x30), and
 *   _dirFailAuto on a timeout/no-controller; _dirCheck reports whether the command engine is busy.
 *
 *   "info" is the per-port device block, addressed by raw byte offset (field map in PADCMD.cpp).
 *   rx = *(info+0x3c) is the SIO receive buffer; padbuf = *(info+0x30) is the user PADL buffer.
 *   NOTE: _padFuncChkEng takes info in $a0 (Ghidra drops the arg). */

typedef int      (*PadSnd)(unsigned char *info);
typedef unsigned (*PadRcv)(unsigned char *info);

extern void (*_padFuncClrInfo)(unsigned char *info);         /* dispatch slot: reset port state
                                                                  (same symbol PADPORTD.c wires to
                                                                  _pad_reset_state -- must be called
                                                                  indirectly, not as a direct fn) */
extern int  _padCmdParaMode(unsigned char *info, int para);  /* PADCMD */
extern int  _padSendAtLoadInfo(unsigned char *info);         /* PADCMD */
extern int  _padRecvAtLoadInfo(unsigned char *info);         /* PADCMD */

/* auto-mode dispatch slots installed by _padInitDirSeq (defined in PAD.OBJ data) */
extern int      (*_padFuncSendAuto)(unsigned char *info);
extern int      (*_padFuncChkEng)(unsigned char *info);
extern unsigned (*_padFuncRecvAuto)(unsigned char *info);

/* forward declarations */
extern int      _dirSendAuto(unsigned char *info);
extern unsigned _dirRecvAuto(unsigned char *info);
extern int      _dirFailAuto(unsigned char *info);
extern int      _dirCheck(unsigned char *info);

/* @0x8010A0B0 : _padInitDirSeq -- wire the auto-mode send/check/recv handlers.
 * MATCH: r = _dirRecvAuto hoisted so its addr is live before jr ra delay slot can consume store. */
/* FLOOR: sw v0,%lo(_padFuncRecvAuto)($at) delay-slot fill — compiler scheduling.
 * Tried: original order, hoisted r=_dirRecvAuto temp, order swap, r=_dirRecvAuto var. 4 levers. */
extern void _padInitDirSeq(void)
{
    _padFuncSendAuto = _dirSendAuto;
    _padFuncChkEng   = _dirCheck;
    _padFuncRecvAuto = _dirRecvAuto;
}

/* @0x8010A510 : _dirCheck (_padFuncChkEng) -- 1 = engine free/idle, 0 = mid actuator-load command.
 * MATCH: lhu (unsigned short) for the modeword field; lh (signed) generates wrong instruction.
 * MATCH (w48-a4): the "5-diff scheduling floor" note below was WRONG -- it was a STRUCTURE miss.
 *   The old `if (A || B) return 1; return 0;` shape emits TWO `jr ra` blocks (12 insns); the oracle
 *   has ONE shared epilogue reached from both arms, i.e. the source is the De-Morgan EARLY-OUT
 *   `if (!A && !B) return 0; return 1;` (11/11 count-exact, 6 diffs).  MATCH: `int ff = 0xff;`
 *   (catalog NAMED-ONE) then moves the byte load onto the oracle's $v1 (6 -> 4).
 * RESIDUAL 4 (2 lines): ours `li a1,255 / beq v1,a1` vs oracle `li v0,255 / beq v1,v0`.
 *   NOT a priority dial -- `-dg` shows the constant's allocno literally `81 conflicts: 80 81 2 3 29`,
 *   i.e. a HARD-REG conflict with $v0(2) that no ref/live dial can move (reqdelta class:
 *   conflict-set, w46 "a hard-reg conflict beats every allocno dial").  Falsified at this basin:
 *   yoda-compare (6), nested-if block scope (6), (int) cast (6), byte-local (12), decl-after-guard
 *   (12), word/const SHARED pseudo -- in-place reuse, all 3 spellings put the merged pseudo in $a1
 *   (8), opacity fence on ff (5 @12 insns), fence in the nested-reuse form (8), pre-loaded byte
 *   local (8 @9 insns).  NEXT ANGLE: find what puts hard $v0 in the constant's conflict set
 *   (global.c record_conflicts around the two return-value sets) -- retail's constant IS $v0. */
extern int _dirCheck(unsigned char *info)
{
    int ff = 0xff;
    if (*(unsigned short *)(info + 0xe6) != 0 && info[0x46] == ff)
        return 0;
    return 1;
}

/* @0x8010A0E4 : _dirSendAuto (_padFuncSendAuto) -- emit the next request for the current state. */
extern int _dirSendAuto(unsigned char *info)
{
    unsigned char st;
    unsigned char *rx = *(unsigned char **)(info + 0x3c);

    if (rx[0] == (unsigned char)0xf3) {          /* controller present */
        if (info[0xe8] == 0)                     /* unconfigured: shares the st==0xfe call site below */
            goto reenter_cfgmode;
        if (info[0x49] == 2)
            _padFuncClrInfo(info);
        /* fall through to the state dispatch */
    }

    st = info[0x46];
    if (st == 1) {
        _padCmdParaMode(info, 1);
        return 0;
    }
    if (st < 2) {
        if (st == 0)
            return 0;
    } else {
        if (st == 0xfe) {
        reenter_cfgmode:
            _padCmdParaMode(info, 0);
            return 0;
        }
        if (st == 0xff)
            return 0;
    }
    if (*(void **)(info + 0x14) == 0)
        _padSendAtLoadInfo(info);
    else
        (*(PadSnd *)(info + 0x14))(info);
    return 0;
}

/* @0x8010A1E4 : _dirRecvAuto (_padFuncRecvAuto) -- absorb the reply, advance the state machine. */
extern unsigned _dirRecvAuto(unsigned char *info)
{
    char           prev_e8 = info[0xe8];
    unsigned char *rx      = *(unsigned char **)(info + 0x3c);
    unsigned char *padbuf  = *(unsigned char **)(info + 0x30);
    unsigned char  mode    = rx[0] >> 4;
    unsigned char  st;
    unsigned       r;

    info[0xe8] = mode;
    if (mode == 0xf) {
        info[0xe8] = (unsigned char)prev_e8;     /* no controller: keep last type */
    } else {
        int i;
        padbuf[0] = 0;
        padbuf[1] = rx[0];
        for (i = 2; i < (int)info[0x44]; i++)
            padbuf[i] = rx[i];
    }

    if ((rx[1] == 0 &&
         ((info[0x46] != 1 || *(int *)(info + 0x14) != 0) && info[0x50] == 0)) ||
        (_dirCheck(info) == 0 && info[0x37] == 0 && info[0x4a] == 0 &&
         info[0xe8] != (unsigned char)prev_e8)) {
        _padFuncClrInfo(info);
    }
    info[0x4a] = 0;

    if (info[0x46] == 0xff)
        return 0xff;
    if ((unsigned char)(info[0x46] - 2) < 0xfc && rx[0] != (unsigned char)0xf3)
        _padFuncClrInfo(info);
    if (info[0x46] != 0 && info[0x36] == 0)
        return 0;

    st = info[0x46];
    if (st == 1) {
        info[0x47] = 0;
        r = (unsigned)st + 1;
        info[0x46] = (unsigned char)r;
        return r;
    }
    if (st < 2) {
        if (st == 0) {
            info[0x49] = 1;
            r = (unsigned)st + 1;
            info[0x46] = (unsigned char)r;
            return r;
        }
    } else if (st == 0xfe) {
        info[0x46] = 0xff;
        return 0xff;
    }
    if (*(void **)(info + 0x18) == 0)
        r = _padRecvAtLoadInfo(info);
    else
        r = (*(PadRcv *)(info + 0x18))(info);
    info[0x46] = info[0x46] + (unsigned char)r;
    return r;
}

/* @0x8010A434 : _dirFailAuto -- a poll produced no usable reply; retry or give up. */
extern int _dirFailAuto(unsigned char *info)
{
    unsigned char *rx = *(unsigned char **)(info + 0x3c);
    int r;

    *(int *)(info + 0x4c) = *(int *)(info + 0x4c) + 1;

    if (info[0x46] == 0) {
fail_reset:
        r = 0xf3;
        if (rx[0] != (unsigned char)0xf3) {
            unsigned char *padbuf = *(unsigned char **)(info + 0x30);
            padbuf[0] = 0xff;
            padbuf[1] = 0;
            r = (int)(unsigned long)padbuf;
            info[0xe8] = 0;
        }
    } else {
        unsigned cnt = info[0x4a];
        if (info[0x46] == 1) {
            if (1 < cnt) {
                info[0x49] = 2;
                info[0x46] = 0xff;
                return 0xff;
            }
        } else {
            if (3 < cnt) {
                if (info[0x49] != 0)
                    _padFuncClrInfo(info);
                goto fail_reset;
            }
        }
        r = cnt + 1;
        info[0x4a] = (unsigned char)r;
    }
    return r;
}
