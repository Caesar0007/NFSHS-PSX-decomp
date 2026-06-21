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

extern "C" int  (*_padFuncChkEng)(unsigned char *info);            /* dispatch slot: engine-busy? (0 = free) */
extern "C" void (*_padFuncClrInfo)(unsigned char *info);

static unsigned char *_actcur;   /* @0x8014859C : actuator-descriptor write cursor */

/* ---- forward declarations (mutually recursive) ----------------------------------------------- */
extern "C" int _padCmdParaMode(unsigned char *info, int para);
extern "C" int _padCmdGetStatus(unsigned char *info);
extern "C" int _padCmdSetMap(unsigned char *info, int idx);
extern "C" int _padCmdGetDescR0(unsigned char *info, int idx);
extern "C" int _padCmdGetDescR1(unsigned char *info, int idx);
extern "C" int _padCmd4B(unsigned char *info);
extern "C" int _padGetActSize(unsigned char *info);
extern "C" int _padLoadActInfo(unsigned char *info, unsigned char *buf);
static void _padLoadActInfo_snd(unsigned char *info);
static void _padLoadActInfo_rcv(unsigned char *info);
static void _padSetActAlign_snd(unsigned char *info);
static void _padSetActAlign_rcv(unsigned char *info);
static void _padSetMainMode_snd(unsigned char *info);
static void _padSetMainMode_rcv(unsigned char *info);

/* =====================  command-byte builders (one DualShock opcode each)  ===================== */

/* @0x801055F0 : _padSetAct -- stash the actuator data pointer + length for a later send. */
extern "C" void _padSetAct(unsigned char *info, int data, int len)
{
    *(int *)(info + 0x28) = data;
    info[0x34] = (unsigned char)len;
}

/* @0x80105E8C : _padCmdParaMode -- 0x43 enter-config(para). */
extern "C" int _padCmdParaMode(unsigned char *info, int para)
{
    info[0x36] = 0x43;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    info[0x24] = (unsigned char)para;
    info[0x35] = 1;
    return 1;
}

/* @0x80105EAC : _padCmdGetStatus -- 0x45 get-status. */
extern "C" int _padCmdGetStatus(unsigned char *info)
{
    info[0x36] = 0x45;
    *(int *)(info + 0x2c) = 0;
    info[0x35] = 0;
    return 0x45;
}

/* @0x80105EC0 : _padCmdSetMap -- 0x4C set-config-map(idx). */
extern "C" int _padCmdSetMap(unsigned char *info, int idx)
{
    info[0x36] = 0x4c;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    info[0x24] = (unsigned char)idx;
    info[0x35] = 1;
    return 1;
}

/* @0x80105EE0 : _padCmdGetDescR0 -- 0x46 get-descriptor-0(idx). */
extern "C" int _padCmdGetDescR0(unsigned char *info, int idx)
{
    info[0x36] = 0x46;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    info[0x24] = (unsigned char)idx;
    info[0x35] = 1;
    return 1;
}

/* @0x80105F00 : _padCmdGetDescR1 -- 0x47 get-descriptor-1(idx). */
extern "C" int _padCmdGetDescR1(unsigned char *info, int idx)
{
    info[0x36] = 0x47;
    *(unsigned char **)(info + 0x2c) = info + 0x24;
    info[0x24] = (unsigned char)idx;
    info[0x35] = 1;
    return 1;
}

/* @0x80105F20 : _padCmd4B -- 0x4B exit-config. */
extern "C" int _padCmd4B(unsigned char *info)
{
    info[0x36] = 0x4b;
    *(int *)(info + 0x2c) = 0;
    info[0x35] = 0;
    return 0x4b;
}

/* =====================  load-info (actuator/mode descriptor) command sequence  ================= */

/* @0x801055FC : _padSendAtLoadInfo -- pick the send command for the current load-info phase. */
extern "C" int _padSendAtLoadInfo(unsigned char *info)
{
    int st = info[0x46], r;
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
extern "C" int _padGetActSize(unsigned char *info)
{
    return ((info[0xe3] + 1) >> 1) * 4
         + (((unsigned)info[0xe9] * 5 + 3) & 0xffc) + 4
         + *(int *)(info + 0xec);
}

/* @0x80105680 : _padRecvAtLoadInfo -- consume one response of the load-info handshake. */
extern "C" int _padRecvAtLoadInfo(unsigned char *info)
{
    unsigned char *rx = *(unsigned char **)(info + 0x3c);
    int st = info[0x46];

    if (st == 3) {
        unsigned char hi = rx[4], lo = rx[5];
        info[0x47] = 0;
        *(unsigned short *)(info + 0xe6) = (unsigned short)lo + (unsigned short)hi * 0x100;
        return 1;
    }
    if (st > 3) {
        if (st != 4)
            return 1;
        unsigned char idx = info[0x47] + 1;
        unsigned char nb  = rx[4];
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
extern "C" int _padLoadActInfo(unsigned char *info, unsigned char *buf)
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
static void _padLoadActInfo_snd(unsigned char *info)
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
static void _padLoadActInfo_rcv(unsigned char *info)
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

/* @0x80105BF4 : _padSetActAlign -- queue the actuator-alignment command (returns 1 if accepted). */
extern "C" int _padSetActAlign(unsigned char *info, int data)
{
    if (_padFuncChkEng(info) == 0) {
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padSetActAlign_snd;
        *(int *)(info + 0x20) = data;
        *(PadSndRcv *)(info + 0x18) = _padSetActAlign_rcv;
        return 1;
    }
    return 0;
}

/* @0x80105C5C : _padSetActAlign_snd -- emit the 0x4D align packet. */
static void _padSetActAlign_snd(unsigned char *info)
{
    info[0x36] = 0x4d;
    info[0x35] = 6;
    *(int *)(info + 0x2c) = *(int *)(info + 0x20);
}

/* @0x80105C78 : _padSetActAlign_rcv -- resolve each mode's actuator map from the alignment request. */
static void _padSetActAlign_rcv(unsigned char *info)
{
    unsigned mode = 0;
    if (info[0xe9] != 0) {
        int row = 0;
        do {
            unsigned char *p;
            int matchcount, j, k;

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

/* @0x80105D40 : _padSetMainMode -- queue the main-mode switch (offs = mode index, lock = lock flag). */
extern "C" int _padSetMainMode(unsigned char *info, int offs, int lock)
{
    if (_padFuncChkEng(info) == 0) {
        info[0x46] = 1;
        *(PadSndRcv *)(info + 0x14) = _padSetMainMode_snd;
        *(PadSndRcv *)(info + 0x18) = _padSetMainMode_rcv;
        info[0x51] = (unsigned char)offs;
        info[0x52] = (unsigned char)lock;
        info[0x53] = (unsigned char)((offs & 0xff) == info[0xe4]);
        return 1;
    }
    return 0;
}

/* @0x80105DD8 : _padSetMainMode_snd. */
static void _padSetMainMode_snd(unsigned char *info)
{
    if (info[0x46] == 2) {
        info[0x36] = 0x44;
        *(unsigned char **)(info + 0x2c) = info + 0x51;
        info[0x35] = 2;
    } else if (info[0x46] == 3) {
        info[0x36] = 0x4d;
        *(unsigned char **)(info + 0x2c) = info + 0x5d;
        info[0x35] = 6;
    }
}

/* @0x80105E2C : _padSetMainMode_rcv. */
static void _padSetMainMode_rcv(unsigned char *info)
{
    if (info[0x53] == 0)
        _padFuncClrInfo(info);
    else if (info[0x46] != 2)
        info[0x46] = 0xfe;
}
