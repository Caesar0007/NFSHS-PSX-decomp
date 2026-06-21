/* syslib/psx/libpad/PADPORTD.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADPORTD.OBJ): the DIRECT-mode pad driver -- PadInitDirect plus the seven helper
 *   functions it installs into the global dispatch table (_padFunc*) that PADENTRY/PADMAIN/PADCMD
 *   call through.  PadInitDirect wires the table, lays out the two per-port info blocks (0xF0 bytes
 *   each), points each port at the caller's PADL data buffer (pad1/pad2), and arms the VSync engine.
 *
 *   Dispatch wiring (PadInitDirect):
 *     _padFuncNextPort  = _pad_failall      _padFuncClrInfo  = _pad_reset_state
 *     _padFuncGetTxd    = _pad_getbyte      _padFuncCurrLimit= _pad_filter
 *     _padFuncPtr2Port  = _pad_port_to_slot _padFuncPort2Info= _pad_get_port
 *     _padFuncClrCmdNo  = _pad_shift        _padInfoDir      = _pad_info
 *
 *   The per-port info block is addressed by raw byte offset (union-overloaded across libpad objs; see
 *   PADCMD.cpp for the field map).  HW SIO0 register reached through _padSioRegs (cf. PADMAIN). */

extern "C" void _padInitDirSeq(void);                 /* PADSEQD @0x8010A0B0 */
extern "C" void _dirFailAuto(unsigned char *info);    /* PADSEQD @0x8010A434 */
extern "C" int  _padInitSioMode(unsigned char *info); /* PADMAIN @0x80104D2C */
extern "C" void _padSetVsyncParam(void);              /* PADMAIN @0x80104A1C */
extern "C" void bzero(void *p, unsigned n);           /* libc C40 @0x8010A540 */

/* ---- libpad state globals (defined in PAD.OBJ data) ------------------------------------------ */
extern "C" int            _padIntExec;
extern "C" int            _padModeMtap;
extern "C" int            _padSioChan;
extern "C" int            _padChanStop;   /* loop-again bound (==2 direct driver); @0x800fdf84 */
extern "C" int            _padSioState;
extern "C" int            _padTotalCurr;
extern "C" unsigned char *_padInfoDir;
extern "C" int            _padFixResult[2];
extern unsigned char     *_padSioRegs;                /* @0x80137CDC -> 0x1F801040 SIO0 block */
#define JOY_CTRL (*(volatile unsigned short *)(_padSioRegs + 0x0a))

/* dispatch slots (this obj installs the direct-mode handlers below into them) */
extern "C" unsigned char *(*_padFuncNextPort)(int flag);
extern "C" void           (*_padFuncClrInfo)(unsigned char *info);
extern "C" int            (*_padFuncGetTxd)(unsigned char *info, int align);
extern "C" int            (*_padFuncCurrLimit)(unsigned char *info);
extern "C" int            (*_padFuncPtr2Port)(unsigned char *info);
extern "C" unsigned char *(*_padFuncPort2Info)(int slot);
extern "C" unsigned       (*_padFuncClrCmdNo)(unsigned char *info);

/* ---- this obj's .bss: two per-port info blocks + their receive/scratch buffers --------------- */
static unsigned char _pad_rxbuf[2][0x23];          /* @0x80147570 : per-port SIO receive buffer */
static unsigned char _pad_buf2[2][0x23];           /* @0x801475B8 : per-port scratch buffer */
static unsigned char _pad_info[2 * 0xf0 + 0x40];   /* @0x80147600 : 2 info blocks (+0x40 slack: the
                                                      init bzero over-clears 0x40 bytes past the end) */

/* forward declarations */
extern "C" unsigned char *_pad_failall(int flag);
extern "C" void           _pad_reset_state(unsigned char *info);
extern "C" int            _pad_getbyte(unsigned char *info, int align);
extern "C" int            _pad_filter(unsigned char *info);
extern "C" int            _pad_port_to_slot(unsigned char *p);
extern "C" unsigned char *_pad_get_port(int slot);
extern "C" unsigned       _pad_shift(unsigned char *info);

/* @0x800FDD28 : PadInitDirect */
extern "C" void PadInitDirect(unsigned char *pad1, unsigned char *pad2)
{
    int p;

    _padIntExec  = 0;
    _padModeMtap = 0;
    _padInitDirSeq();

    _padFuncNextPort  = _pad_failall;
    _padFuncClrInfo   = _pad_reset_state;
    _padFuncGetTxd    = _pad_getbyte;
    _padFuncCurrLimit = _pad_filter;
    _padFuncPtr2Port  = _pad_port_to_slot;
    _padFuncPort2Info = _pad_get_port;
    _padInfoDir       = _pad_info;
    _padFuncClrCmdNo  = _pad_shift;

    bzero(_pad_info + 0x40, 0x1e0);
    *(unsigned char **)(_pad_info + 0x00 + 0x30) = pad1;
    *(unsigned char **)(_pad_info + 0xf0 + 0x30) = pad2;

    for (p = 0; p < 2; p++) {
        unsigned char *info = _pad_info + p * 0xf0;
        unsigned char *padbuf = *(unsigned char **)(info + 0x30);
        int i;
        *(int *)(info + 0x0c) = 0;
        *(unsigned char **)(info + 0x10) = info;        /* self ptr */
        padbuf[0] = 0xff;
        padbuf[1] = 0;
        *(unsigned char **)(info + 0x3c) = _pad_rxbuf[p];
        *(unsigned char **)(info + 0x40) = _pad_buf2[p];
        for (i = 0; i < 6; i++)
            info[0x5d + i] = 0xff;
    }

    _padSetVsyncParam();
    _padIntExec = 1;
}

/* @0x800FDE88 : _pad_reset_state (_padFuncClrInfo) -- wipe a port's transient state. */
extern "C" void _pad_reset_state(unsigned char *info)
{
    if (info[0x49] != 0) {
        int i;
        info[0x49] = 0;
        info[0x46] = 0;
        *(unsigned short *)(info + 0xe6) = 0;
        *(int *)(info + 0x14) = 0;
        *(int *)(info + 0x18) = 0;
        info[0xe3] = 0;
        info[0xe4] = 0;
        *(unsigned short *)(info + 0xe6) = 0;
        info[0xe9] = 0;
        info[0xea] = 0;
        *(int *)(info + 0x00) = 0;
        *(int *)(info + 0x04) = 0;
        *(int *)(info + 0x08) = 0;
        for (i = 0; i < 6; i++)
            info[0x5d + i] = 0xff;
    }
}

/* @0x800FDEF0 : _pad_failall (_padFuncNextPort) -- abandon the current port, advance to the next. */
extern "C" unsigned char *_pad_failall(int flag)
{
    unsigned char *ret;
    do {
        unsigned char *info = _pad_info + _padSioChan * 0xf0;
        if (flag != -9) {
            if (flag == 0)
                _padFixResult[_padSioChan] = 0;
            else {
                _dirFailAuto(info);
                _pad_shift(info);
            }
        }
        _padSioState = 0;
        JOY_CTRL = 0;
        _padSioChan = _padSioChan + 1;
        ret = (unsigned char *)1;
        if (_padSioChan <= _padChanStop)   /* oracle @0x800fdf94-98: call iff !(_padChanStop < _padSioChan) */
            ret = (unsigned char *)(unsigned long)
                  _padInitSioMode(_pad_info + _padSioChan * 0xf0);
        flag = 0xffff;
    } while (ret == 0);
    return ret;
}

/* @0x800FDFE4 : _pad_shift (_padFuncClrCmdNo) -- consume the queued command byte. */
extern "C" unsigned _pad_shift(unsigned char *info)
{
    unsigned char b = info[0x36];
    info[0x36] = 0;
    info[0x37] = b;
    return b;
}

/* @0x800FDFF4 : _pad_getbyte (_padFuncGetTxd) -- next byte to clock out for the current command.
 *   `align` (2nd dispatch arg) is unused in direct mode. */
extern "C" int _pad_getbyte(unsigned char *info, int align)
{
    int idx = info[0x45] - 3;
    unsigned char *buf;
    (void)align;

    if (info[0x36] == 0) {                       /* poll: stream the actuator data */
        if (idx < 6 && info[0x57 + idx] == 0)
            return 0;
        if (info[0x34] <= idx)
            return 0;
        buf = *(unsigned char **)(info + 0x28);
    } else if (info[0x36] != 'M') {              /* fixed command param block */
        if (info[0x35] <= idx)
            return 0;
        return (*(unsigned char **)(info + 0x2c))[idx];
    } else {                                     /* 'M' (0x4D align): pad with 0xff */
        if (info[0x35] <= idx)
            return 0xff;
        buf = *(unsigned char **)(info + 0x2c);
    }
    return buf[idx];
}

/* @0x800FE0B0 : _pad_filter (_padFuncCurrLimit) -- gate the actuators against the current budget. */
extern "C" int _pad_filter(unsigned char *info)
{
    unsigned r = 0;
    bzero(info + 0x57, 6);

    if (*(short *)(info + 0xe6) == 0 || *(int *)(info + 0x28) == 0) {
        if (((unsigned char)(info[0xe8] - 4) < 2 || info[0xe8] == 7) &&
            (*(short *)(info + 0xe6) == 0 && info[0x34] > 1)) {
            unsigned hdr = **(unsigned char **)(info + 0x28) & 0xc0;
            r = hdr;
            if (hdr == 0x40) {
                unsigned char b1 = (*(unsigned char **)(info + 0x28))[1];
                r = b1 & 1;
                if ((b1 & 1) != 0) {
                    r = 1;
                    if (_padTotalCurr + 10 < 0x3d) {
                        info[0x58] = 1;
                        info[0x57] = 1;
                        _padTotalCurr = _padTotalCurr + 10;
                        r = _padTotalCurr;
                    }
                }
            }
        } else {
            r = 1;
            if (info[0xe8] == 3) {
                info[0x57] = 1;
            } else if (*(short *)(info + 0xe6) == 0) {
                int i;
                for (i = 5; i >= 0; i--)
                    info[0x57 + i] = 1;
            }
        }
    } else {
        unsigned nmask = info[0x34] < 7 ? info[0x34] : 6;
        unsigned mode = 0;
        if (info[0xe9] != 0) {
            int row = 0;
            do {
                int matched = 0;
                unsigned char mask = 1;
                unsigned char *map = info + 0x5d;
                unsigned char *dat = *(unsigned char **)(info + 0x28);
                unsigned i = 0;
                if (*(char *)(row + *(int *)(info + 4) + 2) != 0)
                    mask = 0xff;
                if (nmask != 0) {
                    do {
                        if (*map == mode && (*dat & mask) != 0) { matched = 1; break; }
                        map++; i++; dat++;
                    } while (i < nmask);
                }
                if (matched) {
                    int t = _padTotalCurr + *(unsigned char *)(row + *(int *)(info + 4) + 3);
                    if (t < 0x3d) {
                        unsigned char *m2 = info + 0x5d;
                        unsigned char *flag = info + 0x57;
                        unsigned k = 0;
                        _padTotalCurr = t;
                        if (nmask != 0) {
                            do {
                                if (*m2 == mode) *flag = 1;
                                m2++; k++; flag++;
                            } while (k < nmask);
                        }
                    }
                }
                mode++;
                row += 5;
            } while (mode < (unsigned)info[0xe9]);
        }
        r = 0;
    }
    return r;
}

/* @0x800FE32C : _pad_port_to_slot (_padFuncPtr2Port) -- info block ptr -> slot id (0x10/0x20). */
extern "C" int _pad_port_to_slot(unsigned char *p)
{
    int i, slot = 0x10;
    unsigned char *info = _pad_info;
    for (i = 0; i < 2; i++) {
        if (p == info)
            return slot;
        slot += 0x10;
        info += 0xf0;
    }
    return 0xff;
}

/* @0x800FE364 : _pad_get_port (_padFuncPort2Info) -- slot id -> info block ptr. */
extern "C" unsigned char *_pad_get_port(int slot)
{
    if ((slot & 0xf0) != 0)
        return _pad_info + 0xf0;
    return _pad_info;
}
