# 0 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
# 20 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern void ChangeClearRCnt(int n, int m);
extern void SysDeqIntRP(int pri, void *rp);
extern void SysEnqIntRP(int pri, void *rp);
extern void setRC2wait(int ticks);
extern int chkRC2wait(void);


extern unsigned char *_padSioRegs;
extern unsigned char *_padIntRegs;
# 44 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int _padIntExec;
extern int _padSioState;
extern int _padSioChan;
extern int _padChanStart;
extern int _padChanStop;
extern int _padTotalCurr;
extern unsigned char *_padInfoDir;
extern int _padFixResult[2];
extern int padIntFunc[];
extern int _startTime;
extern int _waitTime;
extern int _padVbExec;


extern int (*_padFuncNextPort)(int flag);
extern int (*_padFuncRecvAuto)(unsigned char *info);
extern void (*_padFuncClrInfo)(unsigned char *info);
extern void (*_padFuncClrCmdNo)(unsigned char *info);
extern int (*_padFuncIntGun)(void);


extern int _padInitSioMode(unsigned char *info);
extern void _padSioMain(unsigned char *info);
extern int _padClrIntSio0(void);
extern void _padWaitRXready(void);


struct _PadIntRP {
    struct _PadIntRP *next;
    void (*handler)();
    int (*verifier)();
    int _pad0c;
};
typedef struct _PadIntRP _PadIntRP;
static _PadIntRP _padVbCb;





static int _padFrames[2];




extern int _padVbCallback0(void);
extern int _padVbCallback1(void);
# 103 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern void _padSetVsyncParam(void)
{
    void (**p)() = &_padVbCb.handler;
    __asm__("" : "=r"(p) : "0"(p));
    p[0] = (void (*)())_padVbCallback0;
    p[1] = (void (*)())_padVbCallback1;
    p[-1] = 0;
    p[2] = 0;
}


extern int _padVbCallback1(void)
{
    if (((*(volatile unsigned int *)(_padIntRegs + 0x04)) & 1) != 0 && ((*(volatile unsigned int *)(_padIntRegs + 0x00)) & 1) != 0) {
        if (_padFuncIntGun != 0)
            _padFuncIntGun();
        return 1;
    }
    return 0;
}



extern int _padVbCallback0(void)
{
    _padVbExec = 1;




    if (_padChanStart != 0) {
        int *n = &_padFrames[0];


        if (*n < 0x96)
            *n = *n + 1;
    }
    if (_padChanStop == 0) {
        int *n = &_padFrames[1];
        if (*n < 0x96)
            *n = *n + 1;
    }





    if (_padIntExec != 0 && _padChanStart <= _padChanStop) {
        _padSioState = 0;
        _padSioChan = _padChanStart;
        if (_padInitSioMode(_padInfoDir + _padChanStart * 0xf0) == 0)
            _padFuncNextPort(0xffff);
        _padTotalCurr = 0;
        while (_padChanStop >= _padSioChan)
            _padSioMain(_padInfoDir + _padSioChan * 0xf0);
        (*(volatile unsigned short *)(_padSioRegs + 0x0e)) = 0x88;
    }
    return 0;

}
# 175 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern void _padStartCom(void)
{
    unsigned char *ir;
    int *f;

    _padIntExec = 0;
    EnterCriticalSection();
    SysDeqIntRP(2, &_padVbCb);
    SysEnqIntRP(2, &_padVbCb);
    ir = _padIntRegs;
    *(volatile unsigned int *)(ir + 0x00) = 0xfffffffe;
    *(volatile unsigned int *)(ir + 0x04) = *(volatile unsigned int *)(ir + 0x04) | 1;
    ChangeClearRCnt(3, 0);
    ExitCriticalSection();
    _padFuncClrInfo(_padInfoDir);
    _padFuncClrInfo(_padInfoDir + 0xf0);
    f = _padFrames;
    __asm__("" : "=r"(f) : "0"(f));
    f[1] = 0;
    f[0] = 0;
    _padIntExec = 1;
}


extern void _padStopCom(void)
{
    EnterCriticalSection();
    ChangeClearRCnt(3, 1);
    SysDeqIntRP(2, &_padVbCb);
    ExitCriticalSection();
}
# 268 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int _padInitSioMode(unsigned char *info)
{
    (*(volatile unsigned short *)(_padSioRegs + 0x0a)) = 0x40;
    (*(volatile unsigned short *)(_padSioRegs + 0x0a)) = 0;
    (*(volatile unsigned short *)(_padSioRegs + 0x08)) = 0xd;
    (*(volatile unsigned short *)(_padSioRegs + 0x0e)) = 0x88;
    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    (*(volatile unsigned short *)(_padSioRegs + 0x0a)) = (_padSioChan != 0) ? 0x3003 : 0x1003;


    {
        int fix = *(int *)((_padSioChan << 2) + (int)_padFixResult);
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --_padFixResult[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[_padSioChan] * 0xf0);
                } while (_padFixResult[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }

    if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {
        (*(volatile unsigned short *)(_padSioRegs + 0x0a)) = (*(volatile unsigned short *)(_padSioRegs + 0x0a)) | 0x10;
        if (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x200) != 0) {
            while (chkRC2wait() == 0)
                ;
            (*(volatile unsigned char *)(_padSioRegs)) = 1;
            setRC2wait(100);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)(*(volatile unsigned char *)(_padSioRegs));
            setRC2wait(0x1ae);
            while (((*(volatile unsigned int *)(_padIntRegs + 0x00)) & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            (*(volatile unsigned char *)(_padSioRegs)) = 0x42;
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)(*(volatile unsigned char *)(_padSioRegs));
            setRC2wait(0x1ae);
            while (((*(volatile unsigned int *)(_padIntRegs + 0x00)) & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            (*(volatile unsigned char *)(_padSioRegs)) = 1;
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)(*(volatile unsigned char *)(_padSioRegs));
            return 0;
        }
        (*(volatile unsigned int *)(_padIntRegs + 0x00)) = 0xffffff7f;
    }
    if (info[0x50] == 0)
        return 1;
    if (info[0x36] != 0)
        return 0;
    {
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }
}
# 362 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern void _padSioMain(unsigned char *info)
{
    int (*fn)(unsigned char *);
    int r;
    int *st = &_padSioState;
    int s;

    s = *st;
    fn = (int (*)(unsigned char *))padIntFunc[s];
    __asm__("" : : "r"(fn));
    *st = s + 1;
    r = fn(info);
    if (r >= 0) {
        if (_padSioState != 0) {
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                _padFuncNextPort(0xfffffffd);
        }
        if (_padSioState > 4)
            _padSioState = _padSioState - 1;
    } else {
        _padFuncNextPort(r);
    }
}
# 400 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int _padSioRW(unsigned char *dev, int tx)
{
    int rx;

    if (tx < 0) {
        unsigned char *out = *(unsigned char **)(dev + 0x40);
        rx = (*(volatile unsigned char *)(_padSioRegs));
        dev[0x44] = 0xff;
        dev[0x45] = 1;
        *out = (unsigned char)~tx;
        while (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 1) == 0)
            ;
        while (chkRC2wait() == 0)
            ;
        {
            unsigned char value = (unsigned char)~tx;
            volatile unsigned char *data = _padSioRegs;
            *data = value;
        }
        goto return_rx;
    } else {
        unsigned short baud = 0x88;
        int hdr = **(unsigned char **)(dev + 0x3c);
        if (hdr >> 4 == 8 && dev[0x44] > 8)
            baud = 0x22;
        {
            unsigned short start = (*(volatile unsigned short *)0x1F801120);
            unsigned char *sio = _padSioRegs;
            unsigned short stat;
            stat = *(volatile unsigned short *)(sio + 4);
            _waitTime = 0x1ae;
            _startTime = start;
            if ((stat & 2) == 0) {
                do {
                } while (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 2) == 0);
            }
        }
        {
            unsigned char *sio = _padSioRegs;
            unsigned char *ir = _padIntRegs;
            rx = *(volatile unsigned char *)sio;
            *(volatile unsigned short *)(sio + 0xe) = baud;
            if ((*(volatile unsigned int *)ir & 0x80) == 0) {
                do {
                    if (chkRC2wait() != 0)
                        return -0x14;
                } while (((*(volatile unsigned int *)(_padIntRegs + 0x00)) & 0x80) == 0);
            }
        }
        (*(volatile unsigned char *)(_padSioRegs)) = (unsigned char)tx;
        dev[0x45] = dev[0x45] + 1;
        *(*(unsigned char **)(dev + 0x3c) + dev[0x44]) = rx;
        dev[0x44] = dev[0x44] + 1;
return_rx:
        return rx;
    }
}
# 477 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int _padSioRW2(unsigned char *dev, int tx)
{
    unsigned short baud = 0x88;
    int rx;
    int hdr = **(unsigned char **)(dev + 0x3c);

    if (hdr >> 4 == 8 && dev[0x44] > 8)
        baud = 0x22;

    while (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 2) == 0)
        ;
    setRC2wait(0x190);
    rx = (*(volatile unsigned char *)(_padSioRegs)) & 0xff;
    if (*(volatile unsigned char *)(dev + 0x44) != 0 ||
        rx >> 4 != 8)
        (*(volatile unsigned short *)(_padSioRegs + 0x0e)) = baud;
    else
        (*(volatile unsigned short *)(_padSioRegs + 0x0e)) = 0x22;
    __asm__("" : : "r"(baud));

    while (((*(volatile unsigned int *)(_padIntRegs + 0x00)) & 0x80) == 0) {
        unsigned cur = (*(volatile unsigned short *)0x1F801120) & 0xffff;
        if (cur < (unsigned)_startTime) {
            if ((*(volatile unsigned short *)0x1F801128) != 0)
                cur += (*(volatile unsigned short *)0x1F801128);
            else
                cur += 0x10000;
        }
        if (((*(volatile unsigned short *)0x1F801124) & 0x200) != 0) {
            if (cur - (unsigned)_startTime >= (unsigned)_waitTime)
                return -2;
        } else {
            if ((cur - (unsigned)_startTime) >> 3 >= (unsigned)_waitTime)
                return -2;
        }
    }
    if (dev[0xe8] != 8 && _padSioState == 2) {
        setRC2wait(0x3c);
        while (chkRC2wait() == 0)
            ;
    }
    (*(volatile unsigned char *)(_padSioRegs)) = (unsigned char)tx;
    {
        int idx = dev[0x44];
        dev[0x45] = dev[0x45] + 1;
        if (idx != 0xff) {
            idx = dev[0x44];
            *(*(unsigned char **)(dev + 0x3c) + idx) = rx;
        }
    }
    dev[0x44] = dev[0x44] + 1;
    return rx;
}
# 551 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
extern int _padClrIntSio0(void)
{
    unsigned char *ir = _padIntRegs;
    unsigned char *sio = _padSioRegs;

    *(volatile unsigned int *)(ir + 0x00) = 0xffffff7f;
    if ((*(volatile unsigned short *)(sio + 0x04) & 0x80) != 0) {
        do {
            if (chkRC2wait() != 0)
                return 0;
        } while (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 0x80) != 0);
    }
    (*(volatile unsigned short *)(_padSioRegs + 0x0a)) = (*(volatile unsigned short *)(_padSioRegs + 0x0a)) | 0x10;
    return 1;
}


extern void _padWaitRXready(void)
{
    do {
    } while (((*(volatile unsigned short *)(_padSioRegs + 0x04)) & 2) == 0);
}
