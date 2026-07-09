/* eaclib/psx/eacpsxz/inittmr.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   obj nfs4\eaclib\psx\inittmr.obj ; EACPSXZ.LIB.  4 fns @[0x800F4180 .. 0x800F4328].  Root-counter timer
 *   setup: open the RCnt event, install the per-tick handler list (tmrsub[8]), and tick libticks/ticks.
 *   Ghidra nfs4-f.exe.c (inittmr) + disasm-v3 + IDA sigs.  Bare VAs symbolicated: addexit arg 0x800F4304 =
 *   &restoretimer; blockclear target 0x8012360C = &tmrsub; creatememclass template 0x8013DD48 = &DAT_8013dd48.
 */
 int timerflag;    /* @0x8013..  owning-TU tentative def → .comm/.sbss → gp-rel */
 int timerevent;  /* @0x8013..  owning-TU tentative def → .comm/.sbss → gp-rel */
extern int   reentryflag;   /* tmrint re-entry guard */
extern int   timerhz;       /* tick rate */
extern int   memclass;      /* memstd class id */
extern int   DAT_8013e904;  /* cached memclass */
extern int   DAT_8013dd48;  /* creatememclass template */
extern int   tmrsub;        /* int[8] : per-tick handler list */
extern int   ticks;         /* raw tick counter */
extern int   libticks;      /* library tick counter */
extern int   g_currentthread;

extern int  creatememclass(char *name, int tmpl);   /* memstd */
extern void blockclear(int dst, int len);           /* blkfill */
extern int  addexit(int fn);                        /* exit */
extern void initgp(void);                           /* savegp */
extern void savegp(void *buf);                      /* savegp */
extern void restoregp(int gp);                      /* savegp */
extern void resettick(void);                        /* timer */
extern void trap(unsigned int code);
/* --- syslib (PsyQ libapi/libetc) --- */
extern void EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern int  OpenEvent(unsigned int cls, int spec, int mode, int *fn);
extern void EnableEvent(int ev);
extern void DisableEvent(int ev);
extern void SetRCnt(int spec, unsigned short target, int mode);
extern void StartRCnt(int spec);

extern int  initmemadr(int base, int size);   /* @0x800F4180 */
extern int  inittimer(int hz);                /* @0x800F41F0 */
extern void restoretimer(void);               /* @0x800F4304 */
extern unsigned int tmrint(void);             /* @0x800F4328 */

/* initmemadr @0x800F4180 : create the timer's memory class from the static template. */
extern int initmemadr(int base, int size)
{
    int r = creatememclass((char *)0, (int)&DAT_8013dd48);
    (void)base; (void)size;
    DAT_8013e904 = memclass;
    return r;
}

/* inittimer @0x800F41F0 : install (once) the RCnt event + restore hook, then arm the counter for `hz` Hz. */
extern int inittimer(int hz)
{
    if (hz == 0)
        hz = 100;
    EnterCriticalSection();
    if (timerflag == 0) {
        blockclear((int)&tmrsub, 0x20);
        timerevent = OpenEvent(0xf2000002, 2, 0x1000, (int *)tmrint);
        EnableEvent(timerevent);
        timerflag = 1;
        addexit((int)restoretimer);
    }
    initgp();
    reentryflag = 0;
    timerhz = hz;
    SetRCnt(0xf2000002, (unsigned short)(0x409980 / hz), 0x1000);
    StartRCnt(0xf2000002);
    ExitCriticalSection();
    resettick();
    return addexit((int)restoretimer);
}

/* restoretimer @0x800F4304 : disable the RCnt event (exit hook). */
extern void restoretimer(void)
{
    DisableEvent(timerevent);
    timerflag = 0;
}

/* tmrint @0x800F4328 : the per-tick interrupt handler -- advance the tick counters and run tmrsub[0..7]. */
extern unsigned int tmrint(void)
{
    unsigned int gpbuf[2];
    int          i = 0;
    int         *p = &tmrsub;
    savegp(gpbuf);
    ticks = ticks + 1;
    g_currentthread = 1;
    libticks = libticks + 1;
    do {
        if (*p != 0)
            ((void (*)(void))*p)();
        i = i + 1;
        p = p + 1;
    } while (i < 8);
    g_currentthread = 0;
    restoregp((int)gpbuf[0]);
    return 0;
}
