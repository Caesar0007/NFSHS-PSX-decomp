/* syslib/psx/libmcrd/BIOS.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libmcrd.lib(BIOS.OBJ): the low-level memory-card BIOS/event layer (17 fns).
 *   The card's BIOS reports completion via four event specs (I/O-end, error, timeout, new-card)
 *   on each of the two card buses (class 0xF4000001 = slot 0, 0xF0000011 = slot 1).  _card_start
 *   opens+enables those eight events with the funcEvSp* callbacks (which raise the matching flag
 *   in _card_evflag); the _get/_clr/_chk helpers poll and acknowledge them. */

extern "C" int  OpenEvent(unsigned cls, int spec, int mode, void *func);  /* BIOS A0:08 */
extern "C" int  CloseEvent(int ev);                                       /* BIOS A0:09 */
extern "C" int  EnableEvent(int ev);                                      /* BIOS A0:0C */
extern "C" int  TestEvent(int ev);                                        /* BIOS A0:0B */
extern "C" int  EnterCriticalSection(void);                               /* BIOS A0:01 */
extern "C" void ExitCriticalSection(void);                                /* BIOS A0:02 */
extern "C" void InitCARD(int pad_enable);                                 /* BIOS B0:4A */
extern "C" void StartCARD(void);                                          /* BIOS B0:4B */
extern "C" void StopCARD(void);                                           /* BIOS B0:4C */
extern "C" void _bu_init(void);                                           /* libapi C112 */
extern "C" int  printf(const char *fmt, ...);                             /* libc C63 */

static int          _card_evhandle[8];   /* @0x801489EC : OpenEvent handles */
static volatile int _card_evflag[8];     /* @0x80148A0C : per-event completion flags */

/* ----- event-spec callbacks: raise the matching flag (4 events x 2 slots; "x" = slot 1) ----- */
/* NOTE: funcEvSp* are FLOORS — oracle uses assembler-macro lui/sw ($at) but our pipeline
 *   generates explicit lui+sw ($v0/$v1) for array[0] and lui+addiu+sw for array[1-7].
 *   The maspsx -G4 sbss-gp-rel expansion vs aspsx 2.77 absolute behavior is the root cause. */
extern "C" int funcEvSpIOE(void)      { _card_evflag[0] = 1; return 0; }   /* @0x80109550 */
extern "C" int funcEvSpError(void)    { _card_evflag[1] = 1; return 0; }   /* @0x80109564 */
extern "C" int funcEvSpTimeout(void)  { _card_evflag[2] = 1; return 0; }   /* @0x80109578 */
extern "C" int funcEvSpNewcard(void)  { _card_evflag[3] = 1; return 0; }   /* @0x8010958C */
extern "C" int funcEvSpIOEx(void)     { _card_evflag[4] = 1; return 0; }   /* @0x801095A0 */
extern "C" int funcEvSpErrorx(void)   { _card_evflag[5] = 1; return 0; }   /* @0x801095B4 */
extern "C" int funcEvSpTimeoutx(void) { _card_evflag[6] = 1; return 0; }   /* @0x801095C8 */
extern "C" int funcEvSpNewcardx(void) { _card_evflag[7] = 1; return 0; }   /* @0x801095DC */

/* @0x801095F0 : _card_open -- bring up the card subsystem. */
extern "C" void _card_open(int pad_enable)
{
    InitCARD(pad_enable);
    StartCARD();
    _bu_init();
}

/* @0x801097FC : _card_close */
extern "C" void _card_close(void)
{
    StopCARD();
}

/* @0x801098D0 : _clr_card_event -- acknowledge & clear every card event. */
extern "C" void _clr_card_event(void)
{
    int i;
    for (i = 0; i < 8; i++)
        TestEvent(_card_evhandle[i]);
    for (i = 0; i < 8; i++)
        _card_evflag[i] = 0;
}

/* @0x80109620 : _card_start -- open + enable the eight card events. */
extern "C" void _card_start(void)
{
    int prev = EnterCriticalSection();
    _card_evhandle[0] = OpenEvent(0xf4000001, 4,      0x1000, (void *)funcEvSpIOE);
    _card_evhandle[1] = OpenEvent(0xf4000001, 0x8000, 0x1000, (void *)funcEvSpError);
    _card_evhandle[2] = OpenEvent(0xf4000001, 0x100,  0x1000, (void *)funcEvSpTimeout);
    _card_evhandle[3] = OpenEvent(0xf4000001, 0x2000, 0x1000, (void *)funcEvSpNewcard);
    _card_evhandle[4] = OpenEvent(0xf0000011, 4,      0x1000, (void *)funcEvSpIOEx);
    _card_evhandle[5] = OpenEvent(0xf0000011, 0x8000, 0x1000, (void *)funcEvSpErrorx);
    _card_evhandle[6] = OpenEvent(0xf0000011, 0x100,  0x1000, (void *)funcEvSpTimeoutx);
    _card_evhandle[7] = OpenEvent(0xf0000011, 0x2000, 0x1000, (void *)funcEvSpNewcardx);
    {   int i; for (i = 0; i < 8; i++) EnableEvent(_card_evhandle[i]); }
    _clr_card_event();
    if (prev == 1)
        ExitCriticalSection();
}

/* @0x8010981C : _card_stop -- close the eight card events. */
extern "C" void _card_stop(void)
{
    int prev = EnterCriticalSection();
    int i;
    for (i = 0; i < 8; i++)
        CloseEvent(_card_evhandle[i]);
    if (prev == 1)
        ExitCriticalSection();
}

/* @0x801099D8 : _get_card_event -- block until a slot-0 event fires, acknowledge the slot-1
 *   handles, clear the slot-0 flags, and return the event-class index (sum>>1: 0=IOE, 1=error,
 *   2=timeout, 4=new-card). */
extern "C" int _get_card_event(void)
{
    int sum;
    while ((sum = _card_evflag[0] + _card_evflag[1] * 2 + _card_evflag[2] * 4 + _card_evflag[3] * 8) == 0)
        ;
    TestEvent(_card_evhandle[4]);
    TestEvent(_card_evhandle[5]);
    TestEvent(_card_evhandle[6]);
    TestEvent(_card_evhandle[7]);
    _card_evflag[3] = 0;
    _card_evflag[2] = 0;
    _card_evflag[1] = 0;
    _card_evflag[0] = 0;
    return sum >> 1;
}

/* @0x80109AB0 : _get_card_event_x -- as above for the slot-1 bus. */
extern "C" int _get_card_event_x(void)
{
    int sum;
    while ((sum = _card_evflag[4] + _card_evflag[5] * 2 + _card_evflag[6] * 4 + _card_evflag[7] * 8) == 0)
        ;
    TestEvent(_card_evhandle[0]);
    TestEvent(_card_evhandle[1]);
    TestEvent(_card_evhandle[2]);
    TestEvent(_card_evhandle[3]);
    _card_evflag[7] = 0;
    _card_evflag[6] = 0;
    _card_evflag[5] = 0;
    _card_evflag[4] = 0;
    return sum >> 1;
}

/* @0x80109B88 : _chk_card_event -- non-blocking poll: combined slot-0 event flags (0 = none). */
extern "C" int _chk_card_event(void)
{
    return _card_evflag[0] + _card_evflag[1] * 2 + _card_evflag[2] * 4 + _card_evflag[3] * 8;
}

/* @0x80109BC4 : _chk_card_event_x -- combined slot-1 event flags. */
extern "C" int _chk_card_event_x(void)
{
    return _card_evflag[4] + _card_evflag[5] * 2 + _card_evflag[6] * 4 + _card_evflag[7] * 8;
}
