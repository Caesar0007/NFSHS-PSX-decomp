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
extern void     _padClrIntSio0(void);                           /* PADMAIN @0x80105538 */
extern void     _padWaitRXready(void);                          /* PADMAIN @0x801055C8 */
extern unsigned setRC2wait(int ticks);                          /* WAITRC2 @0x8010BFE8 */

extern int            _padModeMtap;
extern int            _padSioChan;
extern unsigned char *_padInfoDir;
extern int            _padFixResult[2];
extern unsigned char     *_padSioRegs;                              /* @0x80137CDC -> 0x1F801040 */
#define JOY_DATA8 (*(volatile unsigned char *)(_padSioRegs))

/* @0x8013C308 : 12-byte block (3 words) forces out of .sdata → absolute lui/sw addressing.
 *  [0]=_padMtapCount @0x8013C308, [1]=padding @0x8013C30C, [2]=_padMtapFlag @0x8013C310. */
static int _padMtapData[3];
#define _padMtapCount (_padMtapData[0])
#define _padMtapFlag  (_padMtapData[2])

/* @0x8010C0A8 : _padIntInit -- begin the exchange (issue 0x01 select). */
extern int _padIntInit(unsigned char *info)
{
    _padMtapFlag = _padFuncSendAuto(info);
    *(*(unsigned char **)(info + 0x3c)) = 0;
    return (int)_padSioRW(info, 0xfffffffe);
}

/* @0x8010C0F0 : _padIntQuery -- send the command opcode (default 0x42 = poll). */
extern unsigned _padIntQuery(unsigned char *info)
{
    unsigned op;
    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc));
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0xf0);
    }
    op = (info[0x36] == 0) ? 0x42 : info[0x36];
    return _padSioRW2(info, op);
}

/* @0x8010C1C8 : _padIntRecvId -- read the device id; derive the multitap byte count. */
extern int _padIntRecvId(unsigned char *info)
{
    int arg2 = 0;
    unsigned r;
    if (_padMtapFlag != 0) {
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x1e0);
        _padFuncSendAuto(*(unsigned char **)(info + 0xc) + 0x2d0);
    }
    if (info[0x36] == 0)
        arg2 = _padModeMtap;
    r = _padSioRW2(info, arg2);
    if ((int)r >= 0) {
        unsigned lo = r & 0xf;
        if ((r & 0xf0) == 0) {
            r = 0xfffffff7;
        } else {
            _padMtapCount = lo << 1;
            r = 0;
            if (lo == 0) {
                _padMtapCount = 0x20;
                r = 0;
            }
        }
    }
    return (int)r;
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
    if (r != 0x5a && r != 0) {
        if ((int)r >= 0)
            return 0xfffffff7;
        return r;
    }
    return r;
}

/* @0x8010C314 : _padIntRecvData -- stream the payload (multitap sub-ports), then advance the port. */
extern unsigned _padIntRecvData(unsigned char *info)
{
    unsigned r;
    int align = 0;

    _padFuncCurrLimit(info);
    if (_padModeMtap != 0 && (int)(**(unsigned char **)(info + 0x3c) >> 4) == 8)
        align = (info[0x36] == 0);

    /* multitap: drive the per-sub-port command bytes */
    if (align != 0) {
        int idx = -1, off = -0xf0;
        do {
            _padMtapCount = _padMtapCount - 1;
            if (_padMtapCount < 1)
                break;
            if (idx >= 0)
                _padFuncCurrLimit(*(unsigned char **)(info + 0xc) + off);
            r = (unsigned)_padFuncGetTxd(info, 1);
            r = _padSioRW2(info, r & 0xff);
            if ((int)r < 0)
                return r;
            r = setRC2wait(0x3c);
            _padClrIntSio0();
            idx = idx + 1;
            if (r == 0)
                return 0xfffffffd;
            off = off + 0xf0;
        } while (idx < 4);
    }

    /* dispatch the auto-recv of the other ports' queued replies */
    if (1 < _padMtapCount) {
        int *fix = &_padFixResult[_padSioChan == 0 ? 1 : 0];
        int base = (_padSioChan == 0) * 0xf0;
        unsigned char *cur = 0;
        do {
            int v = *fix;
            if (v < 0)
                break;
            if (0 < v) {
                cur = *(unsigned char **)(base + _padInfoDir + 0xc) + v * 0xf0 - 0xf0;
                _padFuncRecvAuto(cur);
            }
            v = *fix;
            if (v == 3) {
                _padFuncRecvAuto(cur - 0xf0);
                *fix = 1;
            } else if (v < 4) {
                if (v < 2 && v >= 0) {
                    cur = _padInfoDir + base;
                    _padFuncRecvAuto(cur);
                    _padFuncClrCmdNo(cur);
                    *fix = -1;
                }
            } else if (v == 4) {
                *fix = 3;
            }
            r = (unsigned)_padFuncGetTxd(info, align);
            r = _padSioRW(info, r & 0xff);
            if ((int)r < 0)
                return r;
            r = setRC2wait(0x3c);
            _padClrIntSio0();
            if (r == 0)
                return 0xfffffffd;
            _padMtapCount = _padMtapCount - 1;
        } while (1 < _padMtapCount);
    }

    /* stream the remaining payload bytes into the receive buffer */
    for (;;) {
        _padMtapCount = _padMtapCount - 1;
        if (_padMtapCount < 1) {
            unsigned char len;
            _padWaitRXready();
            len = info[0x44];
            info[0x44] = len + 1;
            (*(unsigned char **)(info + 0x3c))[len] = JOY_DATA8;
            _padFuncNextPort(0);
            return 0;
        }
        r = (unsigned)_padFuncGetTxd(info, align);
        r = _padSioRW(info, r & 0xff);
        if ((int)r < 0)
            break;
        r = setRC2wait(0x3c);
        _padClrIntSio0();
        if (r == 0)
            return 0xfffffffd;
    }
    return r;
}
