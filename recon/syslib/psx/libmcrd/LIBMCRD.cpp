/* syslib/psx/libmcrd/LIBMCRD.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libmcrd.lib(LIBMCRD.OBJ): the high-level memory-card API (17 public MemCard* entries plus
 *   nine file-static helpers).  It drives an asynchronous command engine: each public call latches
 *   a command code into _mc_cmd and pushes a step-callback onto the USERFUNC stack; a VSync pump
 *   (_MemCardStart_cb, registered by MemCardStart) calls UserFuncExecute every frame, advancing the
 *   per-command finite-state machine until the stack drains, at which point the command is marked
 *   done, snapshotted for MemCardSync, and the user MemCardCallback (if any) is fired.
 *
 *   FSM callback return contract (recovered from disasm $v0; Ghidra typed them void): a step returns
 *   1 when the operation is complete (so UserFuncExecute pops it -> stack empties -> the pump fires
 *   completion) and 0 to remain queued for the next frame.  state[0] (the first word of the
 *   USERFUNC argument block) is the FSM state.
 *
 *   The low-level card and file primitives (open/read/write/_card_clear/...) live in libcard.lib;
 *   the event layer (_card_open/_clr_card_event/_get_card_event/...) is BIOS.OBJ in this library. */

typedef unsigned int uint;

/* ---- PsyQ directory entry (libcard), 0x28 bytes ---------------------------------------------- */
struct DIRENTRY {
    char            name[20];
    unsigned long   attr;
    unsigned long   size;
    DIRENTRY       *next;
    unsigned long   head;
    char            system[4];
};

/* ---- BIOS.OBJ event layer (same library) ----------------------------------------------------- */
extern "C" void _card_open(int pad_enable);     /* @0x801095F0 */
extern "C" void _card_close(void);              /* @0x801097FC */
extern "C" void _card_start(void);              /* @0x80109620 */
extern "C" void _card_stop(void);               /* @0x8010981C */
extern "C" void _clr_card_event(void);          /* @0x801098D0 */
extern "C" int  _get_card_event(void);          /* @0x801099D8 -> event-class index */
extern "C" int  _get_card_event_x(void);        /* @0x80109AB0 */
extern "C" int  _chk_card_event(void);          /* @0x80109B88 -> combined slot-0 flags */
extern "C" int  _chk_card_event_x(void);        /* @0x80109BC4 */

/* ---- USERFUNC.OBJ callback stack ------------------------------------------------------------- */
extern "C" void UserFuncInit(void);             /* @0x80109C00 */
extern "C" void UserFuncOpen(int func);         /* @0x80109C10 */
extern "C" void UserFuncExecute(void);          /* @0x80109C8C */
extern "C" int  UserFuncComplete(void);         /* @0x80109CF8 */

/* ---- libetc VSync callback table ------------------------------------------------------------- */
extern "C" int  VSyncCallbacks(int idx, int func);   /* @0x800F2910 */

/* ---- libcard.lib low-level file / card primitives -------------------------------------------- */
extern "C" int  open(const char *name, int flag);            /* @0x80109D70 */
extern "C" int  close(int fd);                               /* @0x80109D80 */
extern "C" int  lseek(int fd, int ofs, int whence);          /* @0x80109D90 */
extern "C" int  read(int fd, void *buf, int n);              /* @0x80109DA0 */
extern "C" int  write(int fd, void *buf, int n);             /* @0x80109DB0 */
extern "C" DIRENTRY *firstfile(const char *name, DIRENTRY *dir); /* @0x80109DC0 */
extern "C" DIRENTRY *nextfile(DIRENTRY *dir);                /* @0x8010A060 */
extern "C" int  erase(const char *name);                     /* @0x8010A070 */
extern "C" int  format(const char *name);                    /* @0x8010A080 */
extern "C" void _new_card(void);                             /* @0x8010A090 */
extern "C" int  _card_write(int chan, int blk, void *buf);   /* @0x8010A0A0 */
extern "C" int  _card_info(int chan);                        /* @0x80109D10 */
extern "C" int  _card_clear(int chan);                       /* @0x80109D20 */
extern "C" int  _card_load(int chan);                        /* @0x80109D60 */

/* ---- libc ------------------------------------------------------------------------------------ */
extern "C" int   printf(const char *fmt, ...);               /* libc C63 */
extern "C" char *strcat(char *dst, const char *src);         /* libc C21 @0x800E78E8 */

/* =================================  module state (.bss)  ====================================== */
static int   _mc_exretry;                /* @0x80147500 : MemCardExist retry counter */
static int   _mc_exrslt;                 /* @0x80147504 : MemCardExist event scratch */
static int   _mc_retry;                  /* @0x80147508 : MemCardAccept retry counter */
static int   _mc_evrslt;                 /* @0x8014750C : MemCardAccept event scratch */
static int   _mc_cleared;                /* @0x80147510 : card-was-cleared flag */
static int   _mc_present;                /* @0x80147514 : per-channel card-present bitmask */
static int   _mc_cmd;                    /* @0x80147518 : current command code (0 = idle) */
static int   _mc_rslt;                   /* @0x8014751C : command result */
static int   _mc_done;                   /* @0x80147520 : command-complete flag */
static int   _mc_chan;                   /* @0x80147524 : active channel */
static int   _mc_fd;                     /* @0x80147528 : open file descriptor (-1 = closed) */
static int   _mc_ofs;                    /* @0x8014752C : transfer offset */
static int   _mc_len;                    /* @0x80147530 : transfer length */
static void *_mc_adrs;                   /* @0x80147534 : transfer buffer */
static char  _mc_devname[32];            /* @0x80147538 : "buNN:filename" device path */
static int (*_mc_callback)(int, int);    /* @0x80147558 : user MemCardCallback */
static int   _mc_sync_cmd;               /* @0x80147560 : MemCardSync snapshot of _mc_cmd */
static int   _mc_sync_rslt;              /* @0x80147564 : MemCardSync snapshot of _mc_rslt */
static int (*_mc_save_cb)(int, int);     /* @0x8014756C : callback saved across nested sync */

static int   _mc_rd_retry;               /* @0x80136CB8 : MemCardReadData retry counter */
static int   _mc_wr_retry;               /* @0x80136CBC : MemCardWriteData retry counter */
static int   _mc_rf_retry;               /* @0x80136CC0 : MemCardReadFile retry counter */
static int   _mc_wf_retry;               /* @0x80136CC4 : MemCardWriteFile retry counter */

/* forward declarations (callbacks <-> public API are mutually recursive) */
static uint make_devname(int chan, char *str);
static uint card_event_to_rslt(uint ev);
static int  _MemCardExist_cb(void *pv);
static int  _MemCardCmd_cb(void *pv);
static int  _MemCardReadData_cb(void *pv);
static int  _MemCardWriteData_cb(void *pv);
static int  _MemCardReadFile_cb(void *pv);
static int  _MemCardWriteFile_cb(void *pv);
static void _MemCardStart_cb(void);

extern "C" long MemCardSync(long mode, int *cmds, int *result);
extern "C" int  MemCardCallback(int func);

/* =================================  static helpers  =========================================== */

/* @0x800FC11C : translate a raw card event-class index into a libmcrd result code. */
static uint card_event_to_rslt(uint ev)
{
    uint r = 0;
    if (ev == 1) {
        r = 2;
    } else if ((int)ev < 2) {           /* ev == 0 */
        if (ev != 0)
            r = ev | 0x8000;
    } else {                            /* ev >= 2 */
        r = 1;
        if (ev != 2) {
            r = ev | 0x8000;
            if (ev == 4)
                r = 3;
        }
    }
    return r;
}

/* @0x800FC1F4 : build the "buNN:" device prefix for channel `chan` into `str`. */
static uint make_devname(int chan, char *str)
{
    int t = chan;
    int q, lo;
    if (chan < 0)
        t = chan + 0xf;                 /* signed divide-by-16 round-toward-zero */
    q  = t >> 4;
    lo = chan - q * 0x10 + 0x30;
    str[0] = 'b';
    str[1] = 'u';
    str[2] = (char)q + '0';
    str[3] = (char)lo;
    str[4] = ':';
    str[5] = '\0';
    return (uint)lo;
}

/* =================================  per-command FSM steps  ===================================== */

/* @0x800FABF0 : MemCardExist / MemCardAccept(card-present) probe step. */
static int _MemCardExist_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];
    int ev;

    if (state != 0 && state != 10) {
        if (state < 0)    return 0;
        if (state != 0xb) return 0;
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        _mc_exrslt = ev;
        if (ev < 3) {
            if (ev == 0) {              /* ev == 0 : I/O complete (oracle if(v1==0) goto done @0x800facac) */
                _mc_exrslt = 0;
                if ((_mc_present & (1 << (_mc_chan & 0x1f))) == 0)
                    _mc_exrslt = 4;     /* never seen -> "no card" */
                _mc_rslt = card_event_to_rslt(_mc_exrslt);
                return 1;
            }
            _mc_exretry = _mc_exretry + 1;
            if (_mc_exretry < 5) { st[0] = 10; return 0; }
        } else if (ev == 4) {           /* new card */
            _mc_rslt = card_event_to_rslt(4);
            return 1;
        }
        _mc_present &= ~(1 << (_mc_chan & 0x1f));
        _mc_rslt = card_event_to_rslt(ev);
        return 1;
    }

    if (state == 0) {                   /* first entry */
        _mc_exrslt = 0;
        _mc_exretry = 0;
        st[0] = 10;
    }
    /* states 0 and 10 share the (re)issue-info tail */
    _clr_card_event();
    _card_info(_mc_chan);
    st[0] = st[0] + 1;                  /* -> 0xb */
    return 0;
}

/* @0x800FAE2C : MemCardAccept command step (probe -> clear -> load). */
static int _MemCardCmd_cb(void *pv)
{
    int *st = (int *)pv;
    uint state = (uint)st[0];
    uint ev;

    if (state > 0x1f)
        return 0;

    switch (state) {
    case 0:
        _mc_cleared = 0;
        _mc_evrslt  = 0;
        _mc_retry   = 0;
        UserFuncOpen((int)_MemCardExist_cb);
        st[0] = 10;
        return 0;

    case 10:
        if (_mc_rslt != 0) {
            if (_mc_rslt == 3) {        /* new card -> (re)clear it */
                _mc_cleared = 1;
                _mc_present |= 1 << (_mc_chan & 0x1f);
                _clr_card_event();
                _card_clear(_mc_chan);
                st[0] = 0x15;
            }
            return 0;
        }
        st[0] = 0x1e;                   /* card already known -> straight to load */
        return 0;

    case 0x15:
        if (_chk_card_event_x() == 0) return 0;
        _get_card_event_x();
        st[0] = 0x1e;
        /* fall through */
    case 0x1e:
        _clr_card_event();
        _card_load(_mc_chan);
        st[0] = st[0] + 1;              /* 0x1e -> 0x1f */
        return 0;

    case 0x1f:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        _mc_evrslt = ev;
        if (ev < 3) {
            if (ev == 0) {              /* ev == 0 : done (oracle if(v1==0) goto done @0x800faf84) */
                if (_mc_cleared != 0) { _mc_rslt = 3; return 1; }
                _mc_rslt = 0;
                return 1;
            }
            /* ev == 1 or 2 : retryable */
        } else if (ev != 4) {           /* unexpected -> error result */
            _mc_rslt = card_event_to_rslt(ev);
            return 1;
        }
        _mc_retry = _mc_retry + 1;
        if (_mc_retry > 4) {
            if (ev != 4) { _mc_rslt = card_event_to_rslt(ev); return 1; }
            _mc_rslt = 4;
            return 1;
        }
        st[0] = 0x1e;                   /* retry the load */
        return 0;

    default:
        return 0;
    }
}

/* @0x800FB118 : MemCardReadData transfer step. */
static int _MemCardReadData_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];
    int ev, r;

    if (state != 10) {
        if (state > 10) {
            if (state != 0x1e) return 0;
            if (_chk_card_event() == 0) return 0;
            ev = _get_card_event();
            if (ev != 0) {
                _mc_rd_retry = _mc_rd_retry + 1;
                if (_mc_rd_retry < 4) { st[0] = 10; return 0; }
            }
            _mc_rslt = card_event_to_rslt(ev);
            return 1;
        }
        if (state != 0) return 0;
        _mc_rd_retry = 0;
        st[0] = 10;
    }
    do { r = lseek(_mc_fd, _mc_ofs, 0); } while (r != _mc_ofs);
    _clr_card_event();
    do { r = read(_mc_fd, _mc_adrs, _mc_len); } while (r != 0);
    st[0] = 0x1e;
    return 0;
}

/* @0x800FB30C : MemCardWriteData transfer step. */
static int _MemCardWriteData_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];
    int ev, r;

    if (state == 10) {
        do { r = lseek(_mc_fd, _mc_ofs, 0); } while (r != _mc_ofs);
        _clr_card_event();
        do { r = write(_mc_fd, _mc_adrs, _mc_len); } while (r != 0);
        st[0] = 0x1e;
        return 0;
    }
    if (state < 0xb) {
        if (state == 0) {
            _mc_wr_retry = 0;
            st[0] = 10;
        }
        return 0;
    }
    if (state != 0x1e) return 0;
    if (_chk_card_event() == 0) return 0;
    ev = _get_card_event();
    if (ev != 0) {
        _mc_wr_retry = _mc_wr_retry + 1;
        if (_mc_wr_retry < 4) { st[0] = 10; return 0; }
    }
    _mc_rslt = card_event_to_rslt(ev);
    return 1;
}

/* @0x800FB560 : MemCardReadFile step (exist -> open -> read -> close). */
static int _MemCardReadFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    if (state == 10) {
        if (_mc_rslt != 0) return 1;                /* card not present -> abort */
        _mc_fd = open(_mc_devname, 0x8001);
        if (_mc_fd < 0) { _mc_rslt = 5; return 1; } /* open failed */
    } else {
        if (state < 0xb) {
            if (state != 0) return 0;
            _mc_rf_retry = 0;
            UserFuncOpen((int)_MemCardExist_cb);
            st[0] = 10;
            return 0;
        }
        if (state != 0xb) {
            if (state != 0x14) return 0;
            close(_mc_fd);
            _mc_fd = -1;
            return 1;
        }
    }
    st[0] = 0x14;
    UserFuncOpen((int)_MemCardReadData_cb);
    return 0;
}

/* @0x800FB780 : MemCardWriteFile step (exist -> open -> write -> close). */
static int _MemCardWriteFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    if (state == 10) {
        if (_mc_rslt != 0) return 1;
        _mc_fd = open(_mc_devname, 0x8001);
        if (_mc_fd < 0) { _mc_rslt = 5; return 1; }
    } else {
        if (state < 0xb) {
            if (state != 0) return 0;
            _mc_wf_retry = 0;
            UserFuncOpen((int)_MemCardExist_cb);
            st[0] = 10;
            return 0;
        }
        if (state != 0xb) {
            if (state != 0x14) return 0;
            close(_mc_fd);
            _mc_fd = -1;
            return 1;
        }
    }
    st[0] = 0x14;
    UserFuncOpen((int)_MemCardWriteData_cb);
    return 0;
}

/* @0x800FC170 : VSync pump -- step the queued FSM; on drain, latch result + fire user callback. */
static void _MemCardStart_cb(void)
{
    if (UserFuncComplete() != 0)        /* stack already empty -> nothing pending */
        return;
    UserFuncExecute();
    if (UserFuncComplete() == 0)        /* still busy -> wait for the next frame */
        return;

    /* command finished this frame */
    _mc_done      = 1;
    _mc_sync_cmd  = _mc_cmd;
    _mc_sync_rslt = _mc_rslt;
    _mc_cmd       = 0;
    if (_mc_callback != 0) {
        _mc_rslt = 0;
        (*_mc_callback)(_mc_sync_cmd, _mc_sync_rslt);
    }
}

/* =================================  public API  =============================================== */

/* @0x800FAAAC : MemCardInit -- bring up the card subsystem. */
extern "C" void MemCardInit(int val)
{
    _mc_present  = 0;
    _mc_callback = 0;
    _card_open(val);
}

/* @0x800FAAD8 : MemCardEnd. */
extern "C" void MemCardEnd(void)
{
    _card_close();
}

/* @0x800FAAF8 : MemCardStart -- arm the command engine and install the VSync pump. */
extern "C" void MemCardStart(void)
{
    UserFuncInit();
    _mc_cmd  = 0;
    _mc_rslt = 0;
    _mc_done = 0;
    _mc_fd   = -1;
    _card_start();
    VSyncCallbacks(7, (int)_MemCardStart_cb);
}

/* @0x800FAB48 : MemCardStop -- drain any pending command, remove the pump. */
extern "C" void MemCardStop(void)
{
    while (_mc_cmd != 0)
        ;
    VSyncCallbacks(7, 0);
    _card_stop();
}

/* @0x800FAB88 : MemCardExist -- begin an async "is a card present on chan?" query. */
extern "C" long MemCardExist(long chan)
{
    if (_mc_cmd > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    _mc_cmd  = 1;
    _mc_rslt = 0;
    _mc_done = 0;
    _mc_chan = chan;
    UserFuncOpen((int)_MemCardExist_cb);
    return 1;
}

/* @0x800FADC4 : MemCardAccept -- begin an async "accept/clear the card on chan". */
extern "C" long MemCardAccept(long chan)
{
    if (_mc_cmd > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    _mc_cmd  = 2;
    _mc_rslt = 0;
    _mc_done = 0;
    _mc_chan = chan;
    UserFuncOpen((int)_MemCardCmd_cb);
    return 1;
}

/* @0x800FB060 : MemCardReadData -- async read into adrs (offset/length must be 128-byte aligned). */
extern "C" long MemCardReadData(unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (_mc_fd < 0) {
        fmt = "Access Denied. : file not open.\n";
    } else if (_mc_cmd < 1) {
        if ((bytes & 0x7f) == 0) {
            if ((ofs & 0x7f) == 0) {
                _mc_cmd  = 5;
                _mc_rslt = 0;
                _mc_done = 0;
                _mc_ofs  = ofs;
                _mc_len  = bytes;
                _mc_adrs = adrs;
                UserFuncOpen((int)_MemCardReadData_cb);
                return 1;
            }
            fmt = "Access Denied. : invalid offset value align\n";
        } else {
            fmt = "Access Denied. : invalid data size align\n";
        }
    } else {
        fmt = "Access Denied. : event multiple open\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB254 : MemCardWriteData -- async write from adrs. */
extern "C" long MemCardWriteData(unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (_mc_fd < 0) {
        fmt = "Access Denied. : file not open.\n";
    } else if (_mc_cmd < 1) {
        if ((bytes & 0x7f) == 0) {
            if ((ofs & 0x7f) == 0) {
                _mc_cmd  = 6;
                _mc_rslt = 0;
                _mc_done = 0;
                _mc_ofs  = ofs;
                _mc_len  = bytes;
                _mc_adrs = adrs;
                UserFuncOpen((int)_MemCardWriteData_cb);
                return 1;
            }
            fmt = "Access Denied. : invalid offset value align\n";
        } else {
            fmt = "Access Denied. : invalid data size align\n";
        }
    } else {
        fmt = "Access Denied. : event multiple open\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB448 : MemCardReadFile -- async open+read of a named card file. */
extern "C" long MemCardReadFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (_mc_cmd < 1) {
        if (_mc_fd < 0) {
            if ((bytes & 0x7f) == 0) {
                if ((ofs & 0x7f) == 0) {
                    make_devname(chan, _mc_devname);
                    strcat(_mc_devname, file);
                    _mc_cmd  = 3;
                    _mc_rslt = 0;
                    _mc_done = 0;
                    _mc_len  = bytes;
                    _mc_chan = chan;
                    _mc_ofs  = ofs;
                    _mc_adrs = adrs;
                    UserFuncOpen((int)_MemCardReadFile_cb);
                    return 1;
                }
                fmt = "Access Denied. : invalid offset value align\n";
            } else {
                fmt = "Access Denied. : invalid data size align\n";
            }
        } else {
            fmt = "Access Denied. : file already open.\n";
        }
    } else {
        fmt = "Access Denied. : system busy\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB668 : MemCardWriteFile -- async open+write of a named card file. */
extern "C" long MemCardWriteFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (_mc_cmd < 1) {
        if (_mc_fd < 0) {
            if ((bytes & 0x7f) == 0) {
                if ((ofs & 0x7f) == 0) {
                    make_devname(chan, _mc_devname);
                    strcat(_mc_devname, file);
                    _mc_cmd  = 4;
                    _mc_rslt = 0;
                    _mc_done = 0;
                    _mc_len  = bytes;
                    _mc_chan = chan;
                    _mc_ofs  = ofs;
                    _mc_adrs = adrs;
                    UserFuncOpen((int)_MemCardWriteFile_cb);
                    return 1;
                }
                fmt = "Access Denied. : invalid offset value align\n";
            } else {
                fmt = "Access Denied. : invalid data size align\n";
            }
        } else {
            fmt = "Access Denied. : file already open.\n";
        }
    } else {
        fmt = "Access Denied. : system busy\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB888 : MemCardGetDirentry -- synchronous directory listing (max files into dir[]). */
extern "C" long MemCardGetDirentry(long chan, char *name, void *dir, long *files,
                                   long ofs, long max)
{
    char     devname[32];
    DIRENTRY ent;
    DIRENTRY *p;
    int      idx;
    int      stored;
    int      fretry;
    int      err;

    if (_mc_cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    make_devname(chan, devname);
    strcat(devname, name);
    err     = 0;
    idx     = 0;
    stored  = 0;
    fretry  = 0;
    _mc_present |= 1 << (_mc_chan & 0x1f);

    if (ofs + max > 0) {
        do {
            if (idx == 0) {
                while (1) {
                    _clr_card_event();
                    p = firstfile(devname, &ent);
                    if (p != 0)
                        break;
                    err = card_event_to_rslt((uint)(ofs > 0));
                    if (err == 0)
                        goto have_entry;        /* (p == 0, err == 0): empty directory */
                    fretry = fretry + 1;
                    if (fretry > 3) {
                        /* repeated failure: re-accept the card, then bail */
                        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
                        if (_mc_cmd < 1) {
                            _mc_cmd  = 2;
                            _mc_rslt = 0;
                            _mc_done = 0;
                            _mc_chan = chan;
                            UserFuncOpen((int)_MemCardCmd_cb);
                        } else {
                            printf("Access Denied. : event multiple open\n");
                        }
                        MemCardSync(0, 0, &err);
                        MemCardCallback((int)_mc_save_cb);
                        return err;
                    }
                }
            } else {
                p = nextfile(&ent);
have_entry:
                if (p == 0)
                    break;
            }

            if ((idx >= ofs) && dir != 0) {
                /* copy this 0x28-byte entry into the user array slot `stored` */
                *(DIRENTRY *)((char *)dir + stored * 0x28) = ent;
                stored = stored + 1;
            }
            idx = idx + 1;
        } while (idx < ofs + max);
    }

    if (files != 0)
        *files = stored;
    return 0;
}

/* @0x800FBAE8 : MemCardCallback -- install completion callback, return the previous one. */
extern "C" int MemCardCallback(int func)
{
    int prev = (int)_mc_callback;
    _mc_callback = (int (*)(int, int))func;
    return prev;
}

/* @0x800FBAFC : MemCardSync -- poll (mode!=0) or block (mode==0) for command completion. */
extern "C" long MemCardSync(long mode, int *cmds, int *result)
{
    int cmd  = _mc_cmd;
    int rslt = _mc_rslt;

    if (_mc_cmd == 0 && _mc_done == 0)
        return -1;                          /* nothing in flight */

    if (mode == 0) {                        /* blocking */
        while (_mc_done == 0)
            ;
        if (result != 0) *result = _mc_sync_rslt;
        if (cmds   != 0) *cmds   = _mc_sync_cmd;
        _mc_done = 0;
        return 1;
    }

    /* non-blocking */
    if (_mc_done == 0) {
        if (result != 0) *result = rslt;
        if (cmds   != 0) *cmds   = cmd;
        return 0;
    }
    if (result != 0) *result = _mc_sync_rslt;
    if (cmds   != 0) *cmds   = _mc_sync_cmd;
    _mc_done = 0;
    return 1;
}

/* @0x800FBC18 : MemCardCreateFile -- synchronously create a `blocks`-block file. */
extern "C" long MemCardCreateFile(long chan, char *file, long blocks)
{
    char devname[32];
    int  fd;
    int  retry;
    int  rslt;

    if (_mc_cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    make_devname(chan, devname);
    strcat(devname, file);
    _mc_present |= 1 << (_mc_chan & 0x1f);

    fd = open(devname, 1);                       /* probe: does it already exist? */
    if (fd >= 0) {
        close(fd);
        return 6;                                /* already present */
    }

    while (1) {
        fd = open(devname, (int)(blocks << 16) | 0x200);   /* create */
        if (fd >= 0) {
            close(fd);
            return 0;
        }
        /* create failed: re-accept card and inspect the result */
        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
        if (_mc_cmd < 1) {
            _mc_cmd  = 2;
            _mc_rslt = 0;
            _mc_done = 0;
            _mc_chan = chan;
            UserFuncOpen((int)_MemCardCmd_cb);
        } else {
            printf("Access Denied. : event multiple open\n");
        }
        MemCardSync(0, 0, &rslt);
        MemCardCallback((int)_mc_save_cb);

        if (rslt == 0)
            return 7;                            /* no card */
        if (rslt == 3)
            continue;                            /* new card -> retry */
        if (rslt != 2)
            break;
        retry = retry + 1;
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;
    return rslt;
}

/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */
extern "C" long MemCardDeleteFile(long chan, char *file)
{
    char devname[32];
    int  retry;
    int  rslt;

    if (_mc_cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    make_devname(chan, devname);
    strcat(devname, file);
    _mc_present |= 1 << (_mc_chan & 0x1f);

    while (1) {
        if (erase(devname) != 0)
            return 0;
        /* erase failed: re-accept card and inspect the result */
        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
        if (_mc_cmd < 1) {
            _mc_cmd  = 2;
            _mc_rslt = 0;
            _mc_done = 0;
            _mc_chan = chan;
            UserFuncOpen((int)_MemCardCmd_cb);
        } else {
            printf("Access Denied. : event multiple open\n");
        }
        MemCardSync(0, 0, &rslt);
        MemCardCallback((int)_mc_save_cb);

        if (rslt == 3)
            continue;
        if (rslt != 2)
            break;
        retry = retry + 1;
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;
    return rslt;
}

/* @0x800FBFDC : MemCardFormat -- synchronously format the card on chan. */
extern "C" long MemCardFormat(long chan)
{
    char devname[64];
    int  ev;

    if (_mc_cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    _mc_present |= 1 << (_mc_chan & 0x1f);
    make_devname(chan, devname);
    _clr_card_event();
    format(devname);
    ev = _get_card_event_x();
    return card_event_to_rslt(ev);
}

/* @0x800FC068 : MemCardUnformat -- low-level "unformat" by writing 0xFF blocks 0..14. */
extern "C" long MemCardUnformat(long chan)
{
    unsigned char buf[128];
    int  blk;
    int  i;

    if (_mc_cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    for (i = 0; i < 128; i++)
        buf[i] = 0xff;

    blk = 0;
    do {
        _clr_card_event();
        _new_card();
        if (_card_write(chan, blk, buf) != 0)
            return 0;
        _get_card_event_x();
        blk = blk + 1;
    } while (blk < 0xf);
    return 1;
}
