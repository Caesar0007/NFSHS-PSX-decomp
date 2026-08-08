/* syslib/psx/libmcrd/BIOS.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libmcrd.lib(BIOS.OBJ): the low-level memory-card BIOS/event layer (17 fns).
 *   The card's BIOS reports completion via four event specs (I/O-end, error, timeout, new-card)
 *   on each of the two card buses (class 0xF4000001 = slot 0, 0xF0000011 = slot 1).  _card_start
 *   opens+enables those eight events with the funcEvSp* callbacks (which raise the matching flag
 *   in _card_evflag); the _get/_clr/_chk helpers poll and acknowledge them.
 *
 * TOOLCHAIN IDENTITY (w51-a2, 2026-08-09): this object is a **gcc-2.7.2** module --
 *   PER_TU_FLAGS "cc1_272": True (PsyQ 4.0 CC1PSX + direct GNU as in reorder mode, -G0),
 *   per the 04M law.  Whole-TU verify_asm A/B over all 17 reconstructed functions:
 *       2.8  lane : 13/17 PASS  (_card_start 3, _clr_card_event 4, _get_card_event 6, _x 6)
 *       2.7.2 lane: 17/17 PASS  <-- the whole object byte-matches
 *   The old per-fn "no_split_addresses" entry becomes moot in this lane (2.7.2 has no
 *   -msplit-addresses at all -- it emits assembler macros, which is exactly what the retail
 *   bytes show).  Every match lever below is tuned in the 2.7.2 basin; earlier-wave 2.8
 *   receipts in this file are basin-stale by construction. */

extern int  OpenEvent(unsigned cls, int spec, int mode, void *func);  /* BIOS A0:08 */
extern int  CloseEvent(int ev);                                       /* BIOS A0:09 */
extern int  EnableEvent(int ev);                                      /* BIOS A0:0C */
extern int  TestEvent(int ev);                                        /* BIOS A0:0B */
extern int  EnterCriticalSection(void);                               /* BIOS A0:01 */
extern void ExitCriticalSection(void);                                /* BIOS A0:02 */
extern void InitCARD(int pad_enable);                                 /* BIOS B0:4A */
extern void StartCARD(void);                                          /* BIOS B0:4B */
extern void StopCARD(void);                                           /* BIOS B0:4C */
extern void _bu_init(void);                                           /* libapi C112 */
extern int  printf(const char *fmt, ...);                             /* libc C63 */

/* NOTE (was WRONG -- corrected 2026-07-24, w23-a4): these were modeled as two 8-element arrays,
 *   which forced gcc to materialize a shared base register + a stride/index for every access.
 *   The oracle disassembly for the callers (open/close/clear/get/check helpers below) proves each
 *   slot is its OWN separately-relocated 4-byte symbol (D_801489EC, D_801489F0, ..., each reached
 *   via its own bare "lui hi(D_x); .../lo(D_x)", never a shared base plus a runtime stride), i.e.
 *   the original source had 16 individually-named globals, NOT two arrays. This is the catalog's
 *   "SPLIT-STORAGE class (systemic)" pattern in reverse (one array modeled where the oracle has N
 *   separate scalars). Fixed by declaring each slot as its own static and unrolling every loop
 *   that walked the old arrays (the oracle unrolls _card_start/_card_stop/_clr_card_event fully --
 *   no loop instructions at all in those three).
 *
 *   Each new scalar also needs `__attribute__((section(".data")))` + an explicit `= 0` initializer
 *   (same trick already used by libmcrd/USERFUNC.c's _uf_top): a bare `static int x;` tentative def
 *   is a `.lcomm` that maspsx's -G4 pass auto-promotes to sbss/gp-relative addressing, but aspsx
 *   2.77 (the original toolchain) always materialized these single 4-byte statics with an absolute
 *   `lui $at,%hi(sym); sw $r,%lo(sym)($at)` -- the documented TOOLCHAIN FLOOR family (catalog G,
 *   "libmcrd BIOS.cpp funcEvSp*"). Forcing `.data` placement bypasses maspsx's .lcomm/.comm
 *   sbss-eligibility check (it only fires on tentative-def commons) and reproduces the oracle's
 *   absolute form. */
static int          _card_evhandle0 __attribute__((section(".data"))) = 0;  /* @0x801489EC : OpenEvent handle, slot-0 IOE   */
static int          _card_evhandle1 __attribute__((section(".data"))) = 0;  /* @0x801489F0 : OpenEvent handle, slot-0 error */
static int          _card_evhandle2 __attribute__((section(".data"))) = 0;  /* @0x801489F4 : OpenEvent handle, slot-0 timeout */
static int          _card_evhandle3 __attribute__((section(".data"))) = 0;  /* @0x801489F8 : OpenEvent handle, slot-0 newcard */
static int          _card_evhandle4 __attribute__((section(".data"))) = 0;  /* @0x801489FC : OpenEvent handle, slot-1 IOE   */
static int          _card_evhandle5 __attribute__((section(".data"))) = 0;  /* @0x80148A00 : OpenEvent handle, slot-1 error */
static int          _card_evhandle6 __attribute__((section(".data"))) = 0;  /* @0x80148A04 : OpenEvent handle, slot-1 timeout */
static int          _card_evhandle7 __attribute__((section(".data"))) = 0;  /* @0x80148A08 : OpenEvent handle, slot-1 newcard */
static volatile int _card_evflag0 __attribute__((section(".data"))) = 0;    /* @0x80148A0C : slot-0 IOE     completion flag */
static volatile int _card_evflag1 __attribute__((section(".data"))) = 0;    /* @0x80148A10 : slot-0 error   completion flag */
static volatile int _card_evflag2 __attribute__((section(".data"))) = 0;    /* @0x80148A14 : slot-0 timeout completion flag */
static volatile int _card_evflag3 __attribute__((section(".data"))) = 0;    /* @0x80148A18 : slot-0 newcard completion flag */
static volatile int _card_evflag4 __attribute__((section(".data"))) = 0;    /* @0x80148A1C : slot-1 IOE     completion flag */
static volatile int _card_evflag5 __attribute__((section(".data"))) = 0;    /* @0x80148A20 : slot-1 error   completion flag */
static volatile int _card_evflag6 __attribute__((section(".data"))) = 0;    /* @0x80148A24 : slot-1 timeout completion flag */
static volatile int _card_evflag7 __attribute__((section(".data"))) = 0;    /* @0x80148A28 : slot-1 newcard completion flag */

/* ----- event-spec callbacks: raise the matching flag (4 events x 2 slots; "x" = slot 1) ----- */
extern int funcEvSpIOE(void)      { _card_evflag0 = 1; return 0; }   /* @0x80109550 */
extern int funcEvSpError(void)    { _card_evflag1 = 1; return 0; }   /* @0x80109564 */
extern int funcEvSpTimeout(void)  { _card_evflag2 = 1; return 0; }   /* @0x80109578 */
extern int funcEvSpNewcard(void)  { _card_evflag3 = 1; return 0; }   /* @0x8010958C */
extern int funcEvSpIOEx(void)     { _card_evflag4 = 1; return 0; }   /* @0x801095A0 */
extern int funcEvSpErrorx(void)   { _card_evflag5 = 1; return 0; }   /* @0x801095B4 */
extern int funcEvSpTimeoutx(void) { _card_evflag6 = 1; return 0; }   /* @0x801095C8 */
extern int funcEvSpNewcardx(void) { _card_evflag7 = 1; return 0; }   /* @0x801095DC */

/* @0x801095F0 : _card_open -- bring up the card subsystem. */
extern void _card_open(int pad_enable)
{
    InitCARD(pad_enable);
    StartCARD();
    _bu_init();
}

/* @0x801097FC : _card_close */
extern void _card_close(void)
{
    StopCARD();
}

/* @0x801098D0 : _clr_card_event -- acknowledge & clear every card event.  Oracle is fully
 *   unrolled (no loop instructions) and clears each flag GROUP via a right-to-left CHAINED
 *   assignment (`f0 = f1 = f2 = f3 = 0;`) -- gcc re-reads each just-stored slot to produce the
 *   next assignment's rvalue, which is exactly the store/reload/store/reload chain the oracle
 *   disasm shows (D_...18 stored 0 directly, D_...14/10/0C each store a RELOAD of the prior slot). */
extern void _clr_card_event(void)
{
    TestEvent(_card_evhandle0);
    TestEvent(_card_evhandle1);
    TestEvent(_card_evhandle2);
    TestEvent(_card_evhandle3);
    TestEvent(_card_evhandle4);
    TestEvent(_card_evhandle5);
    TestEvent(_card_evhandle6);
    TestEvent(_card_evhandle7);
    _card_evflag0 = _card_evflag1 = _card_evflag2 = _card_evflag3 = 0;
    _card_evflag4 = _card_evflag5 = _card_evflag6 = _card_evflag7 = 0;
    /* w48-a1 ZERO-INSN SCHED2 FENCE (catalog "USE FENCE IS A SCHED-ISSUE-POSITION
     * FIXPOINT"): without it sched2 HOISTS the epilogue `lw ra,16(sp)` ~25 insns up into
     * the flag-clear store chain to fill a load-delay slot, which then frees `addiu sp` to
     * be dbr's filler for the `jr ra` slot -- ours 65 insns vs the oracle's 66.  A volatile
     * asm here is a scheduling barrier that nothing after it may float above, so the
     * restore stays at the tail and `addiu sp` goes back to covering the `lw ra`
     * load-delay (count-EXACT 66/66).  The operand is an IMMEDIATE ("i"), not "r": an
     * operand-LESS `asm("")` is deleted before reorg, an "r" operand would cost a real
     * insn here (no value is reg-resident at this point), and "i"(0) emits NOTHING. */
    __asm__("" : : "i"(0));
}

/* @0x80109620 : _card_start -- open + enable the eight card events.  Oracle fully unrolls both
 *   the OpenEvent and EnableEvent sequences (no loop). */
extern void _card_start(void)
{
    int prev = EnterCriticalSection();
    _card_evhandle0 = OpenEvent(0xf4000001, 4,      0x1000, (void *)funcEvSpIOE);
    _card_evhandle1 = OpenEvent(0xf4000001, 0x8000, 0x1000, (void *)funcEvSpError);
    _card_evhandle2 = OpenEvent(0xf4000001, 0x100,  0x1000, (void *)funcEvSpTimeout);
    _card_evhandle3 = OpenEvent(0xf4000001, 0x2000, 0x1000, (void *)funcEvSpNewcard);
    _card_evhandle4 = OpenEvent(0xf0000011, 4,      0x1000, (void *)funcEvSpIOEx);
    _card_evhandle5 = OpenEvent(0xf0000011, 0x8000, 0x1000, (void *)funcEvSpErrorx);
    _card_evhandle6 = OpenEvent(0xf0000011, 0x100,  0x1000, (void *)funcEvSpTimeoutx);
    _card_evhandle7 = OpenEvent(0xf0000011, 0x2000, 0x1000, (void *)funcEvSpNewcardx);
    EnableEvent(_card_evhandle0);
    EnableEvent(_card_evhandle1);
    EnableEvent(_card_evhandle2);
    EnableEvent(_card_evhandle3);
    EnableEvent(_card_evhandle4);
    EnableEvent(_card_evhandle5);
    EnableEvent(_card_evhandle6);
    EnableEvent(_card_evhandle7);
    _clr_card_event();
    if (prev == 1)
        ExitCriticalSection();
}

/* @0x8010981C : _card_stop -- close the eight card events (oracle fully unrolled). */
extern void _card_stop(void)
{
    int prev = EnterCriticalSection();
    CloseEvent(_card_evhandle0);
    CloseEvent(_card_evhandle1);
    CloseEvent(_card_evhandle2);
    CloseEvent(_card_evhandle3);
    CloseEvent(_card_evhandle4);
    CloseEvent(_card_evhandle5);
    CloseEvent(_card_evhandle6);
    CloseEvent(_card_evhandle7);
    if (prev == 1)
        ExitCriticalSection();
}

/* @0x801099D8 : _get_card_event -- block until a slot-0 event fires, acknowledge the slot-1
 *   handles, clear the slot-0 flags, and return the event-class index (sum>>1: 0=IOE, 1=error,
 *   2=timeout, 4=new-card).  The spin-wait is a DO-WHILE (`do{sum=...;}while(sum==0);`), not a
 *   `while(cond);` -- the oracle's `.L...: <compute>; beqz s0,.L...` is a single copy of the sum
 *   computation with a back-edge at the BOTTOM (test-at-bottom, natural do-while); a `while()`
 *   with an empty body makes gcc peel a duplicate pre-computation + entry-jump instead.  The
 *   flag-clear also uses the same right-to-left CHAINED-assignment idiom as _clr_card_event
 *   (oracle stores 0 once then RELOADS each prior slot for the next store in the chain). */
extern int _get_card_event(void)
{
    int sum;
    do {
        sum = _card_evflag0 + _card_evflag1 * 2 + _card_evflag2 * 4 + _card_evflag3 * 8;
    } while (sum == 0);
    TestEvent(_card_evhandle4);
    TestEvent(_card_evhandle5);
    TestEvent(_card_evhandle6);
    TestEvent(_card_evhandle7);
    /* MATCH (w51-a2): the flag-clear chain is the NATURAL chained-assignment shape -- store 0
     * into the top slot, then each link reads back the slot it just wrote (these are
     * `volatile int`, so every link really reloads; the oracle disasm shows exactly that) --
     * and the tail is the plain `return sum >> 1;`.  PASS 54/54.
     *   The w48-a1 receipt that stood here (split `r = sum>>1` hoisted BEFORE the last reload
     *   + two zero-insn use fences, residual 2) was tuned in the gcc-2.8 basin and is FALSIFIED
     *   for this object: under this TU's real toolchain (gcc-2.7.2, PER_TU_FLAGS "cc1_272")
     *   that spelling scores 16 and the natural one scores 0.  Falsifications are BASIN-
     *   RELATIVE -- do not re-add the devices. */
    {
        _card_evflag3 = 0;
        _card_evflag2 = _card_evflag3;
        _card_evflag1 = _card_evflag2;
        _card_evflag0 = _card_evflag1;
        return sum >> 1;
    }
}

/* @0x80109AB0 : _get_card_event_x -- as above for the slot-1 bus. */
extern int _get_card_event_x(void)
{
    int sum;
    do {
        sum = _card_evflag4 + _card_evflag5 * 2 + _card_evflag6 * 4 + _card_evflag7 * 8;
    } while (sum == 0);
    TestEvent(_card_evhandle0);
    TestEvent(_card_evhandle1);
    TestEvent(_card_evhandle2);
    TestEvent(_card_evhandle3);
    /* MATCH (w51-a2): natural chained assignment + plain `return sum >> 1;` -- see the
     * _get_card_event twin above for the full receipt (the w48-a1 split-temp + fence devices
     * are 2.8-basin artifacts; PASS 54/54 under the cc1_272 lane). */
    {
        _card_evflag7 = 0;
        _card_evflag6 = _card_evflag7;
        _card_evflag5 = _card_evflag6;
        _card_evflag4 = _card_evflag5;
        return sum >> 1;
    }
}

/* @0x80109B88 : _chk_card_event -- non-blocking poll: combined slot-0 event flags (0 = none). */
extern int _chk_card_event(void)
{
    return _card_evflag0 + _card_evflag1 * 2 + _card_evflag2 * 4 + _card_evflag3 * 8;
}

/* @0x80109BC4 : _chk_card_event_x -- combined slot-1 event flags. */
extern int _chk_card_event_x(void)
{
    return _card_evflag4 + _card_evflag5 * 2 + _card_evflag6 * 4 + _card_evflag7 * 8;
}
