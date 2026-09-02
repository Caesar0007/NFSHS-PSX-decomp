/* syslib/psx/libmcrd/LIBMCRD.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libmcrd.lib(LIBMCRD.OBJ): the high-level memory-card API (17 public MemCard* entries plus
 *   nine file-static helpers).  It drives an asynchronous command engine: each public call latches
 *   a command code into _mc_cmd and pushes a step-callback onto the USERFUNC stack; a VSync pump
 *   (MemCardStart_cb, registered by MemCardStart) calls UserFuncExecute every frame, advancing the
 *   per-command finite-state machine until the stack drains, at which point the command is marked
 *   done, snapshotted for MemCardSync, and the user MemCardCallback (if any) is fired.
 *
 *   FSM callback return contract (recovered from disasm $v0; Ghidra typed them void): a step returns
 *   1 when the operation is complete (so UserFuncExecute pops it -> stack empties -> the pump fires
 *   completion) and 0 to remain queued for the next frame.  state[0] (the first word of the
 *   USERFUNC argument block) is the FSM state.
 *
 *   The low-level card and file primitives (open/read/write/_card_clear/...) live in libcard.lib;
 *   the event layer (_card_open/_clr_card_event/_get_card_event/...) is BIOS.OBJ in this library.
 *
 * TOOLCHAIN IDENTITY (w51-a2, 2026-08-09): like its sibling objects BIOS.OBJ and USERFUNC.OBJ,
 *   this is a **gcc-2.7.2** module -- PER_TU_FLAGS "cc1_272": True (PsyQ 4.0 CC1PSX + direct
 *   GNU as in reorder mode, -G0), per the 04M law.  Whole-TU verify_asm A/B over all 26 fns
 *   (measured 2026-08-09; "before" = the state at the head of wave 51):
 *       before, 2.8 lane :  2 PASS / 1302 total diffs
 *       after,  2.8 lane :  2 PASS / 1116 total diffs   (the structural levers help both basins)
 *       after,  2.7.2    :  8 PASS /  718 total diffs   <-- the lane to wire
 *   -G4 and -G8 in the 2.7.2 lane measured IDENTICAL to each other (no symbol in the 5..8-byte
 *   band) and a wash vs -G0; keep the lane default -G0.
 *   Consequences already applied below: (a) the opacity fences must use the gcc-2.7.2-legal
 *   `"=r"(x) : "0"(x)` spelling -- 2.7.2 rejects a "+" constraint ("output operand constraint
 *   contains `+'"); this rewrite is codegen-NEUTRAL in the 2.8 basin.  (b) the "jtbl_at_fusion"
 *   PER_TU entry is inert in this lane (no maspsx in the 2.7.2 pipeline).
 *   Every lever below is tuned in the 2.7.2 basin; earlier-wave 2.8 receipts are basin-stale.
 *
 * 🏆 w53-a7 (2026-08-09): 8 PASS / 663 diffs -> 12 PASS / 389 diffs, ZERO regressions.
 *   +4 PASS: MemCardReadData, MemCardWriteData, MemCardReadFile, MemCardWriteFile.
 *   Per-fn: Exist_cb 121->47 · Cmd_cb 107->55 · CreateFile 68 · DeleteFile 58->57 ·
 *   GetDirentry 91 · Start_cb 33->22 · ReadData_cb 15->10 · WriteData_cb 9->4 ·
 *   Read/WriteFile_cb 12->9 · Exist/Accept/Format 4 · Unformat 5.
 *
 *   THREE TU-WIDE LAWS, each read off a census of every MemCard*.s (they generalize -- check
 *   them first on any sibling libmcrd/libcard object):
 *   (1) 🔴 STORAGE SPLIT: the six words @0x80147500-0x80147514 are SEPARATE statics, not the
 *       head of the `mc` aggregate.  All 30+ oracle accesses are fresh `lui %hi + lw/sw %lo`
 *       pairs, never a displacement off a live base -- even where &_mc_cmd/&_mc_chan IS already
 *       in a register two insns earlier.  As struct fields, gcc CSE'd ONE address across the
 *       function (`lui $a0;addiu $a0` then `addiu $s0,$a0,32` to reach _mc_chan from it), a shape
 *       the oracle never has.  The aggregate starts at _mc_cmd.  (Conversely 0x560/0x564 ARE one
 *       8-byte object -- MemCardStart_cb reaches both by displacement off one base.)
 *   (2) 🏆 THE BASE-ANCHOR LAW: every function that touches 2+ aggregate fields reaches them
 *       through ONE opacity-fenced `int *p = &mc.<field>;` local, indexed by displacement --
 *       and the anchor FIELD differs per function (ReadData/WriteData: &_mc_fd + a DERIVED
 *       `addiu $v1,$a3,-16` &_mc_cmd for the store block; Read/WriteFile: &_mc_cmd, which also
 *       supplies the devname address as `addiu $s0,$s1,32`; the *_cb steps: &_mc_rslt, with
 *       _mc_fd at +0xC, _mc_devname at +28 and a derived `$s0-4` &_mc_cmd for the error code).
 *       The natural `mc.field = x` form emits a `lui $at; sw %lo(sym)($at)` MACRO PER STORE
 *       (+1 insn each) even with the base already live -- that macro pile was the entire
 *       76-vs-70 count gap in Read/WriteFile.  A base materialized AFTER an intervening call
 *       lands in a caller-saved reg (write it as `r = f(...); p = &mc.cmd; fence; p[1] = r;`);
 *       one materialized BEFORE a call takes a callee-saved reg + a frame save.
 *   (3) FENCE FLAVOUR IS LOAD-BEARING: `__asm__ __volatile__` is a SCHEDULING BARRIER, plain
 *       `__asm__` is not.  Read/WriteFile only PASS with the NON-volatile spelling (the volatile
 *       one pins the 5th stack parm's load to the top of the prologue instead of letting the
 *       scheduler drop it into the `lw $v0,0($s1)` load-delay gap: 5 diffs vs 0).  MemCardStart_cb
 *       measured the other way (volatile 24, non-volatile 22), and CreateFile keeps volatile (68)
 *       vs non-volatile (70) vs none (81) -- always A/B both spellings.
 *
 * 🏆 w55-a7 (2026-08-09): 12 PASS / 389 -> 15 PASS / 347 diffs, ZERO regressions.
 *   +3 PASS: MemCardExist, MemCardAccept (both 4 -> 0, count was already exact 26/26),
 *            MemCardStart_cb (22 -> 0, count was already exact 33/33).
 *   MemCardReadFile_cb / MemCardWriteFile_cb 9 -> 3 each (both twins, same edit);
 *   MemCardReadData_cb 10 -> 4 (parm-spill pin, now at parity with its WriteData twin).
 *   The four *_cb dispatches were then down to one shared 3/4-diff angle.  Superseded by the
 *   w78 pure-C late-jump receipt below: all four now PASS.
 *
 *   🔴 SECOND TU-WIDE LEVER -- THE QTY-LAYER REF-STEP ON A BARE CONSTANT (see the full receipt
 *   at the `pc[1] = five;` block in Read/WriteFile_cb): when a small block's ONLY residual is an
 *   address-vs-constant register swap, the constant is an anonymous qty with the SAME ref count
 *   as the address but a SHORTER live range, so `QTY_CMP_PRI` hands the address the lower reg.
 *   NAME the constant, ASSIGN it (never a decl-with-init -- that is emitted at block head and
 *   fixes the wrong emission order), and hang THREE identity fences on it to cross the
 *   floor_log2 ref step (4 -> 8 refs, zero insns).  Both halves are required.  Landed TWICE this
 *   wave: Read/WriteFile_cb's `five` (9 -> 3 each) and MemCardStart_cb's `one` (22 -> 6, then
 *   PASS with the barrier below).  ⚠️ ONE fence is NOT enough and TWO is not either -- the dial
 *   is the flr2 STEP at 8 refs, so count the fences, don't sprinkle them.
 *
 *   🔴 THIRD TU-WIDE LEVER -- THE ZERO-INSN VOID-TAIL BARRIER `__asm__ __volatile__("" : : "i"(0))`
 *   AS A LOAD-HOIST BLOCKER.  When a base+2-offsets block reads a field the same base just STORED
 *   to, our sched hoists the load above the store (it uses the store to fill the load's own delay
 *   slot); that keeps two values live at once and burns a register the oracle does not spend.
 *   Placing the barrier AFTER the load statement (with the load broken out into its own named
 *   temp) restores retail's store->load order AND pins the next address materialization below the
 *   load so it fills the load-delay slot.  Position is the entire dial -- before the load costs a
 *   `nop`, after it does not.  (MemCardStart_cb; do NOT confuse with the opacity fence, whose job
 *   is addressing/refs -- this one is purely a scheduling wall and takes no operand.)
 *
 *   🔴🔴 NEW TU-WIDE LAW -- THE FENCE-vs-PROLOGUE-PARM-COPY CONFLICT (generalizes; check it on
 *   every fn in this library family whose residual is a GUARD's delay slot):
 *       assign_parms emits an incoming parameter's copy (`addu $sN,$a0,$zero`) as the FIRST RTL
 *       insn of the function.  reorg's `fill_simple_delay_slots` finds a slot filler by scanning
 *       BACKWARD from the branch -- and `stop_search_p` returns 1 for ANY insn with
 *       `asm_noperands (PATTERN) >= 0`.  So an opacity fence placed ABOVE an early-exit guard
 *       WALLS THE PARM COPY OFF from that guard's delay slot, and reorg falls back to an eager
 *       steal of the guard target's first insn (our spurious `li $v0,1` / `nop` pairs).
 *       CURE: the base-anchor fence is only needed for the STORE block's addressing, so put it
 *       BELOW the guard.  Zero insns, and the parm copy walks straight into the slot.
 *       SCOPE (measured, do NOT apply blind): MemCardExist 4->PASS, MemCardAccept 4->PASS;
 *       MemCardCreateFile 68->70 and MemCardFormat 4->5 both REGRESS (their residual is not the
 *       guard slot, and their guard READ wants the register base too).  Gate per fn.
 *       This is the w54-06B "any asm stops reorg's backward scan" boundary seen from the other
 *       side: there the fence PINNED a prologue store; here it STARVED a delay slot.
 *
 *   OPEN ANGLE shared by all four `*_cb` dispatches (2-3 diffs each): retail's gcc reorg hoists
 *   the NEXT case-compare constant (`li $v0,0xB` / `li $v0,0x1E`) out of the branch-target block
 *   into the bound test's `beqz $v0` DELAY SLOT and retargets the branch; ours leaves a `nop`
 *   there and emits the `li` in the block.  The same trick DOES fire for us when the constant is
 *   the block's first insn AND is not fenced (MemCardStart_cb's `one`, MemCardExist_cb's `mask`);
 *   an `asm` anywhere in the block freezes reorg, which is why the fenced spellings lose it. */

typedef unsigned int uint;

/* ---- PsyQ directory entry (libcard), 0x28 bytes ---------------------------------------------- */
struct DIRENTRY {
    char            name[20];
    unsigned long   attr;
    unsigned long   size;
    struct DIRENTRY       *next;
    unsigned long   head;
    char            system[4];
};
typedef struct DIRENTRY DIRENTRY;

/* ---- BIOS.OBJ event layer (same library) ----------------------------------------------------- */
extern void _card_open(int pad_enable);     /* @0x801095F0 */
extern void _card_close(void);              /* @0x801097FC */
extern void _card_start(void);              /* @0x80109620 */
extern void _card_stop(void);               /* @0x8010981C */
extern void _clr_card_event(void);          /* @0x801098D0 */
extern int  _get_card_event(void);          /* @0x801099D8 -> event-class index */
extern int  _get_card_event_x(void);        /* @0x80109AB0 */
extern int  _chk_card_event(void);          /* @0x80109B88 -> combined slot-0 flags */
extern int  _chk_card_event_x(void);        /* @0x80109BC4 */

/* ---- USERFUNC.OBJ callback stack ------------------------------------------------------------- */
extern void UserFuncInit(void);             /* @0x80109C00 */
extern void UserFuncOpen(int func);         /* @0x80109C10 */
extern void UserFuncExecute(void);          /* @0x80109C8C */
extern int  UserFuncComplete(void);         /* @0x80109CF8 */

/* ---- libetc VSync callback table ------------------------------------------------------------- */
extern int  VSyncCallbacks(int idx, int func);   /* @0x800F2910 */

/* ---- libcard.lib low-level file / card primitives -------------------------------------------- */
extern int  open(const char *name, int flag);            /* @0x80109D70 */
extern char *strcpy(char *dst, const char *src);           /* libc */
extern int  close(int fd);                               /* @0x80109D80 */
extern int  lseek(int fd, int ofs, int whence);          /* @0x80109D90 */
extern int  read(int fd, void *buf, int n);              /* @0x80109DA0 */
extern int  write(int fd, void *buf, int n);             /* @0x80109DB0 */
extern DIRENTRY *firstfile(const char *name, DIRENTRY *dir); /* @0x80109DC0 */
extern DIRENTRY *nextfile(DIRENTRY *dir);                /* @0x8010A060 */
extern int  erase(const char *name);                     /* @0x8010A070 */
extern int  format(const char *name);                    /* @0x8010A080 */
extern void _new_card(void);                             /* @0x8010A090 */
extern int  _card_write(int chan, int blk, void *buf);   /* @0x8010A0A0 */
extern int  _card_info(int chan);                        /* @0x80109D10 */
extern int  _card_clear(int chan);                       /* @0x80109D20 */
extern int  _card_load(int chan);                        /* @0x80109D60 */

/* ---- libc ------------------------------------------------------------------------------------ */
extern int   printf(const char *fmt, ...);               /* libc C63 */
extern char *strcat(char *dst, const char *src);         /* libc C21 @0x800E78E8 */

/* =================================  module state (.bss)  ====================================== */
/* The 19 _mc_* globals @0x80147500-0x8014756F are ONE 0x70-byte aggregate in the original source,
 * not 19 independent statics: every multi-field function below materializes exactly ONE %hi/%lo
 * address (of whichever field the compiler reached first -- _mc_cmd, _mc_rslt, _mc_fd, _mc_chan
 * all serve as the anchor in different functions) and reaches every OTHER touched field through a
 * literal +/-offset from that single register (e.g. MemCardReadData: $a3=&_mc_fd(0x528), then
 * lw $v0,-0x10($a3) reads _mc_cmd(0x518); MemCardExist_cb: $v1=&_mc_chan(0x524)-0xC=&_mc_cmd,
 * sw $a0,0x4($v1) writes _mc_rslt). A set of 19 separate globals can never produce that codegen --
 * each would need its OWN %hi/%lo pair every access (each is individually <=4B, i.e. sdata/gp-
 * relative-eligible under -G4) -- verify_asm confirmed this exactly: our per-symbol build emitted
 * `lw v0,0(gp)` (gp-relative) everywhere the oracle has `lui/addiu` + reused-base+offset. Folding
 * the fields into ONE struct instance makes the *whole* 0x70-byte object gp-ineligible (too big for
 * -G4's sdata threshold), so gcc naturally CSEs repeated field accesses onto one materialized base
 * register within a function -- exactly the oracle's shape, no manual `T *p=&G;` hoist needed.
 *
 * Layout resolved byte-for-byte from every `D_801475xx`/`D_8014756x` access across all ~19 public
 * fns' oracle .s (asm/nonmatchings/main/MemCard*.s) -- every offset from 0x00 to 0x6C is attested
 * by at least one lw/sw in the raw. TWO 4-byte spans (0x5C and 0x68) are never referenced by name
 * OR by any offset-from-a-neighbor access anywhere in the whole asm/ tree (grepped for D_8014755C,
 * D_80147568 and swept every file touching the 0x558-0x56C region) -- i.e. genuinely dead/unused
 * struct slots in retail, not a misread offset. All surrounding fields are naturally 4-byte aligned
 * ints/pointers, so this isn't ABI padding either; modeled as unnamed reserved ints to preserve the
 * byte-exact layout without inventing semantics no code exercises. */
/* 🔴 w53-a7 SPLIT-STORAGE CORRECTION #2 (the same finding as _mc_present, extended): the SIX words
 * @0x80147500-0x80147514 are SEPARATE statics, NOT the head of the `mc` aggregate.  Census over
 * every MemCard*.s: EVERY access to 0x500/0x504/0x508/0x50C/0x510/0x514 -- 30+ sites -- is a fresh
 * `lui %hi(D_x)` + `lw/sw %lo(D_x)` pair, and NOT ONE reaches them by displacement off a live base,
 * even in functions where the &_mc_cmd/&_mc_chan base register IS already live (MemCardExist_cb
 * holds $s0=&_mc_chan and STILL emits `lui $at,%hi(D_80147504); sw ...` two insns later).  Keeping
 * them as struct fields let gcc CSE ONE address across the function (`lui $a0;addiu $a0` for
 * _mc_exrslt, then `addiu $s0,$a0,32` to reach _mc_chan from it) -- a shape the oracle never has.
 * The aggregate therefore STARTS at _mc_cmd (0x518) and runs to 0x5C. */
static int   _mc_exretry __attribute__((section(".bss")));  /* @0x80147500 : Exist retry counter  */
static int   _mc_exrslt  __attribute__((section(".bss")));  /* @0x80147504 : Exist event scratch  */
static int   _mc_retry   __attribute__((section(".bss")));  /* @0x80147508 : Accept retry counter */
static int   _mc_evrslt  __attribute__((section(".bss")));  /* @0x8014750C : Accept event scratch */
static int   _mc_cleared __attribute__((section(".bss")));  /* @0x80147510 : card-was-cleared     */

struct McState {
    int   cmd;                     /* +0x00 @0x80147518 : current command code (0 = idle) */
    int   rslt;                    /* +0x04 @0x8014751C : command result */
    int   done;                     /* +0x08 @0x80147520 : command-complete flag */
    int   chan;                      /* +0x0C @0x80147524 : active channel */
    int   fd;                         /* +0x10 @0x80147528 : open file descriptor (-1 = closed) */
    int   ofs;                         /* +0x14 @0x8014752C : transfer offset */
    int   len;                          /* +0x18 @0x80147530 : transfer length */
    void *adrs;                          /* +0x1C @0x80147534 : transfer buffer */
    char  devname[32];                    /* +0x20 @0x80147538 : "buNN:filename" device path */
    int (*callback)(int, int);             /* +0x40 @0x80147558 : user MemCardCallback */
    int   _rsvd1;                           /* +0x44 @0x8014755C : UNREFERENCED anywhere in the obj --
                                                real struct slot never exercised in retail, or a dead
                                                planned field; layout-only, no semantics attested */
};
typedef struct McState McState;
static McState mc;                       /* @0x80147518 */

/* w48-a1 SPLIT-STORAGE CORRECTION: 0x80147560/64/6C are NOT fields of the `mc` aggregate above.
 * Every oracle reference to them materializes its OWN %hi/%lo pair (MemCardSync:
 * `lui $v0,%hi(D_80147564); addiu; lw 0($v0)` while $v1 already holds &mc.cmd; MemCardCreateFile:
 * `lui $at,%hi(D_8014756C); sw $v0,%lo(...)($at)`), and NO oracle in the obj reaches them as
 * 0x48/0x4C/0x54 off the mc base -- grepped every MemCard*.s (the only 0x48/0x4C hits are $sp
 * frame slots).  Modeling them as struct fields forced a base+displacement access the oracle
 * never has.  (The TU header note above -- "the 19 globals are ONE aggregate" -- is therefore
 * true only for the 0x00..0x5C span; corrected here rather than rewritten there.) */
/* MEASURED (whole-TU, 4 consumers): as struct fields 271 diffs; as plain 4-byte statics 270
 * (they land in sbss -> gp-relative, which the oracle never uses); forced to .bss = 248 (the
 * adopted form); as ONE 8-byte `int[2]` pair = 253 (better for MemCardStart_cb, which does
 * share a base across the two, but worse for MemCardSync, which materializes each separately). */
/* w53-a7 RE-MEASURE: the two snapshot words ARE one 8-byte object after all -- MemCardStart_cb's
 * oracle materializes ONE base and reaches both by displacement (`sw v0,0(a1)`, `sw v0,4(a1)`,
 * then `lw a0,0(a1)`, `lw a1,4(a1)` for the callback args), which two independent statics can
 * never produce (no compile-time distance between separate symbols).  MemCardSync still gets its
 * per-site full-address materialization from the fenced pointer locals there. */
static int   _mc_sync[2]    __attribute__((section(".bss")));   /* @0x80147560/64: cmd/rslt snap */
#define _mc_sync_cmd  _mc_sync[0]
#define _mc_sync_rslt _mc_sync[1]
static int (*_mc_save_cb)(int, int) __attribute__((section(".bss")));  /* @0x8014756C : callback saved across a nested sync */

/* MATCH (w51-a2): SPLIT-STORAGE -- every oracle access to 0x80147514 materializes its OWN
 * %hi/%lo pair (read `lui v1; lw %lo(D_80147514)(v1)`, write `lui at; sw %lo(...)(at)`)
 * even where a struct base for cmd/chan is ALREADY live in a register, so this word is a
 * standalone static in retail, not a member of the mc aggregate. */
static int   _mc_present __attribute__((section(".bss")));  /* @0x80147514 : per-channel card-present bitmask */

/* 🔴 w60-a2 FALSIFIED (recorded so nobody re-fights it): the UNSIZED-ARRAY ASM-LABEL VIEW
 * of the `mc` aggregate -- `extern int mc_words[] __asm__("mc"); mc_words[1] = r;` -- does
 * NOT reproduce retail's `lui $v1,%hi(mc); addiu $v1,$v1,%lo(mc); sw $v0,4($v1)` here.  In
 * THIS shape the element index is a COMPILE-TIME CONSTANT, so gcc-2.7.2 folds the access
 * straight back to a MEM at `(symbol_ref mc + 4)` and emits the 2-insn `lui $at; sw
 * %lo(mc+4)($at)` assembler macro -- identical to the plain `mc.rslt = r` field store.  The
 * catalog's wave-13 asm-label-view lever therefore needs a NON-constant index (or an
 * address that outlives folding) to make the %hi an RTL pseudo; the `int *pc = &mc.cmd;`
 * + opacity-fence anchor idiom stays the only device that produces the base-in-a-register
 * form on constant-offset field stores.  MEASURED on MemCardWriteData_cb (272 lane):
 *   fenced `pc` anchor, single shared call .................. 1  (ours 78 / oracle 79)
 *   mc_words[] view + fully duplicated call arms ............ 5  (ours 78 / oracle 79)
 * The view DID buy the cross_jump the w55-a7 named angle asked for (the duplicated
 * `jal MemCardEventToRslt` tails merged and the `addu $a0,$zero,$zero` block appeared,
 * i.e. that half of the angle is CONFIRMED source-reachable) -- but it costs the store
 * form, which is a bigger loss.  NAMED ANGLE (unchanged, now sharper): a device that is
 * BOTH cross_jump-transparent (not an `__asm__`) AND holds `&mc` in a register. */

static int   _mc_rd_retry;               /* @0x80136CB8 : MemCardReadData retry counter */
static int   _mc_wr_retry;               /* @0x80136CBC : MemCardWriteData retry counter */
static int   _mc_rf_retry;               /* @0x80136CC0 : MemCardReadFile retry counter */
static int   _mc_wf_retry;               /* @0x80136CC4 : MemCardWriteFile retry counter */

/* forward declarations (callbacks <-> public API are mutually recursive).  These are `static`
 * (file-local, matching the oracle's local-symbol linkage) but must ALSO be `extern "C"` --
 * otherwise C++ name-mangles them (MemCardEventToRslt -> MemCardEventToRslt__FUi) and verify_asm
 * can never find the oracle's bare-name block ("NOT IN OBJECT" forever). `static`+`extern "C"`
 * can't combine as adjacent storage-class specifiers on this compiler -- wrap in `extern "C" { }`
 * instead (same fix as libetc/INTR.cpp's `_bzero_w`). */

static uint MemCardMakeDevname(int chan, char *str);
static uint MemCardEventToRslt(uint ev);
static int  MemCardExist_cb(void *pv);
static int  MemCardCmd_cb(void *pv);
static int  MemCardReadData_cb(void *pv);
static int  MemCardWriteData_cb(void *pv);
static int  MemCardReadFile_cb(void *pv);
static int  MemCardWriteFile_cb(void *pv);
static void MemCardStart_cb(void);
   /* extern "C" */

extern long MemCardSync(long mode, int *cmds, int *result);
extern int  MemCardCallback(int func);

/* =================================  static helpers  =========================================== */



/* @0x800FAAAC : MemCardInit -- bring up the card subsystem. */
/* PsyQ 4.3 <libmcrd.h> declares the public ABI as `void MemCardInit(long val)`. */
extern void MemCardInit(long val)
{
    /* NEAR-MISS (11/11 insns, differs only in base-register reuse): the oracle re-materializes a
     * fresh %hi/%lo per field here (two independent $at-based stores) rather than reusing one base
     * -- the ONE ctor among the ~19 public fns that does NOT share a base across its 2 field
     * writes. Every technique tried to force two independent materializations (asm register fence,
     * volatile-qualified pointer) re-introduced an extra ADDIU the oracle's plain `sw $zero,...`
     * idiom doesn't need (a bare zero-store needs no completed pointer value, just lui+sw) --
     * net-negative. Left as the natural/cheapest form; same instruction count as the oracle. */
    _mc_present  = 0;
    mc.callback = 0;
    _card_open(val);
}

/* @0x800FAAD8 : MemCardEnd. */
extern void MemCardEnd(void)
{
    _card_close();
}

/* @0x800FAAF8 : MemCardStart -- arm the command engine and install the VSync pump. */
extern void MemCardStart(void)
{
    int * base;
    UserFuncInit();
    base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    base[0] = 0;    /* cmd  */
    base[1] = 0;    /* rslt */
    base[2] = 0;    /* done */
    base[4] = -1;   /* fd   */
    _card_start();
    VSyncCallbacks(7, (int)MemCardStart_cb);
}

/* @0x800FAB48 : MemCardStop -- drain any pending command, remove the pump. */
extern void MemCardStop(void)
{
    /* NEAR-MISS (16/16 insns): the oracle hoists &_mc_cmd OUTSIDE the spin loop (one lui/addiu,
     * reused every pass) while a plain re-read of `mc.cmd` recomputes the address fresh each
     * iteration instead -- functionally identical, just not loop-invariant-hoisted. A non-volatile
     * local pointer + register fence looked promising but is a REAL correctness bug here: without
     * `volatile` the compiler proved the loop body doesn't touch *pcmd and hoisted the LOAD itself
     * out of the loop too (not just the address), producing a `bnez v0,self` that spins on a STALE
     * value forever -- this word is mutated ASYNCHRONOUSLY by the VSync-driven MemCardStart_cb, so
     * that optimization is unsound. A `volatile` pointer fixes correctness but nets a WORSE diff
     * count (19/16) than the plain form below. Kept plain: correct and already insn-count-exact. */
    /* 🔴 w48-a1 RUNTIME BUG FIX (the note above was WRONG -- read the disasm, not the intent).
     * The "plain" form compiled to `lui v0; lw v0; beqz v0,end; bnez v0,self` -- gcc hoisted the
     * LOAD out of the empty loop exactly as the note feared, so a non-zero `cmd` spun forever on a
     * stale register and MemCardStop could never return (mc.cmd is cleared ASYNCHRONOUSLY by the
     * VSync pump MemCardStart_cb).  A volatile-qualified READ at the use site is the honest fix:
     * the address stays loop-invariant (hoisted `lui/addiu` like the oracle) while the VALUE is
     * re-fetched every pass.  It also removes gcc's zero-trip rotation guard, matching the
     * oracle's bare `L: lw; bnez L` -- 12 diffs -> 0 (PASS 16/16). */
    while (*(volatile int *)&mc.cmd != 0)
        ;
    VSyncCallbacks(7, 0);
    _card_stop();
}

/* @0x800FAB88 : MemCardExist -- begin an async "is a card present on chan?" query.
 * MATCH: the oracle materializes &_mc_cmd ONCE at entry ($v1) and reuses it for the guard READ
 * and all four field WRITES (cmd/rslt/done/chan at +0/+4/+8/+C) -- the early-base-pointer-hoist
 * lever (fence a local pointer at the field the oracle anchors on, index the rest from it). */
extern long MemCardExist(long chan)
{
    int *base = &mc.cmd;
    if (base[0] > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    base[0] = 1;      /* cmd  */
    base[1] = 0;      /* rslt */
    base[2] = 0;      /* done */
    base[3] = chan;   /* chan */
    UserFuncOpen((int)MemCardExist_cb);
    return 1;
}

/* 🏆 w55-a7 -- BOTH TWINS SEALED (4 -> PASS 26/26) BY MOVING THE FENCE ONE STATEMENT DOWN.
 * See the FENCE-vs-PARM-COPY law in the TU header.  The residual was WHICH insn fills the guard's
 * `bgtz` delay slot: retail puts the `chan` parm copy (`addu $a1,$a0,$zero`) there, ours left a
 * prologue-position copy and eager-stole `li $v0,1` from the fall-through block instead.  The
 * `base` opacity fence sat between assign_parms' copy and the guard branch, and reorg's
 * `stop_search_p` halts the backward delay-slot scan at ANY asm -- so the copy was unreachable.
 * The fence is only needed for the STORE block's addressing (without it the three non-zero-offset
 * stores go out as `lui $at; sw %lo(sym+N)($at)` macros, +3 insns -- measured 9), so moving it
 * BELOW the guard costs nothing and hands the copy straight to reorg.
 *
 * HISTORICAL (w52-a6) falsification table -- every one of these was fighting the fence, not the
 * allocator; kept as the record of what the wrong diagnosis cost.  Measured then (272 lane):
 *   fence on `chan` BEFORE the guard ............................  4 (no change)
 *   fence on `chan` AFTER  the guard ............................  3 (`li $v0,1` lands correctly
 *                                                                    but the slot becomes `nop` --
 *                                                                    the fence blocks the steal)
 *   `c = chan;` + opacity fence at the BLOCK HEAD ............... 16 (the copy DOES sink into the
 *                                                                    block = retail's position, but
 *                                                                    `c` is then a BLOCK-LOCAL qty
 *                                                                    and local_alloc -- which runs
 *                                                                    before global_alloc -- hands
 *                                                                    it $v1, evicting the global
 *                                                                    `base` allocno to $a1; retail
 *                                                                    has base=$v1, c=$a1)
 *   ...same + `do{}while(0)` ref inflator on the 3 const stores . 16 (a priority dial cannot flip a
 *                                                                    local-vs-global race)
 *   `c = chan;` + fence AFTER the three const stores .............  8 (position EXACT; `c` homes in
 *                                                                    $v0 because the `li $v0,1` qty
 *                                                                    already died -- retail's copy
 *                                                                    PRECEDES the `li`, so $v0
 *                                                                    conflicts and `c` takes $a1)
 *   natural `mc.cmd/.rslt/.done/.chan` field form ................  9 (coloring EXACTLY retail --
 *                                                                    base=$v1, copy=$a1, correct
 *                                                                    slot -- but the three non-zero
 *                                                                    offset stores go out as
 *                                                                    `lui $at; sw %lo(sym+N)`
 *                                                                    assembler macros, +3 insns)
 * (The w52 "NAMED ANGLE" filed here -- "make `c` a GLOBAL allocno" -- was a WRONG diagnosis: the
 * registers were already retail's; only the fence position was wrong.  Floor-hygiene: a receipt
 * that names an allocator mechanism is still falsifiable.) */

/* W61-A3 47 -> 41: the same BLOCK-LOCAL ANCHOR law that sealed MemCardCmd_cb (see its
 * receipt).  The function-scope `pc` was a GLOBAL allocno shared by the ev==4 arm and the
 * iodone tail; giving each arm its own pointer makes both local QTYs and every anchor
 * register now matches retail ($v1).  `pc` itself became dead and was removed (re-gated:
 * still 41, so the unused decl was not load-bearing here).
 * FALSIFIED in the post-split basin (the "return constant materialized BEFORE the store"
 * angle below, re-measured because 12C says receipts are basin-relative):
 *   fenced `long ret = 1;` after the call, before the store ... 41 but +2 insns (116->118)
 *   12D dead-pseudo staging -- reuse the dead `c` as the result carrier ... 52
 * REMAINING 41: (a) the two tails` `addu $a0,$v0,$zero` / `addu $v1,$v0,$zero` copies,
 * i.e. retail materialises the return constant into $v0 BEFORE the store and therefore has
 * to move the call result out of $v0 -- ours stores straight from $v0 and puts the `li` in
 * the `j` slot, 1 insn shorter per tail; (b) a $v0/$v1 swap on the `_mc_exretry` bump and
 * on the common tail`s mask chain, both of which look like the same local-QTY-vs-return-
 * value race as (a).  NAMED ANGLE: the carrier for the return constant must be a BLOCK-LOCAL
 * qty born BEFORE the call result`s qty in the same block -- neither a fence (parks it in a
 * saved reg) nor an existing dead variable (12D) does that here. */
/* W62-A8 (2026-08-15): 41 -> 4, count now EXACT 117/117.  FOUR devices, in order, each
 * whole-TU gated; every one of them is zero-insn and pin-free:
 *   41 -> 39  DROP the second opacity fence on `pchan` in the common tail.  reorg's
 *             stop_search_p returns 1 at ANY asm (13B), so the fence standing between
 *             `pchan -= 3` and the jal made retail`s `addiu $s0,$s0,-0xC` delay-slot fill
 *             unreachable; without it reorg steals the mutate exactly as retail does.
 *   39 -> 26  BLOCK-LOCAL ANCHOR (13A) in the common tail.  `pchan` was FUNCTION-SCOPE and
 *             shared with the iodone tail => a global allocno; local_alloc had already given
 *             the chan VALUE $v0 before global.c placed it, so the whole `li 1; sllv; nor;
 *             and` chain came out as retail`s MIRROR.  A block-local `pc` is a local QTY,
 *             takes $v1, and `li $v0,1` is emitted FIRST = retail, insn for insn.
 *             FALSIFIED on this basin: a FUNCTION-SCOPE named `mask` 53 (the same global-vs-
 *             local race one level up), block-local `int m = 1` fenced 27 / unfenced 26
 *             (inert -- the mask must stay a literal), iodone-mirror c/pres temps 47.
 *   26 -> 25  `pc = pc - 3;` (in-place mutate, 3.12 #14) instead of `pchan = pc - 3;` -- the
 *             separate destination let gcc fold the -12 into the store displacement
 *             (`sw $v0,-8($s0)`) and lose retail`s `addiu`.  Fencing the mutated `pc` = 29.
 *   25 -> 17  13D SHARED-EXIT FUNNEL on case 10.  Retail`s case-10 exit is a bare `j` onto the
 *             ONE `addu $v0,$zero,$zero` block before the epilogue; spelled `return 0;` gcc
 *             materialises 0 locally and then FILLS the `lw $v1,0($s0)` load-delay slot with
 *             it (ours had `addu $v0,$zero,$zero` where retail has a `nop`, and the whole
 *             counter moved $v0->$v1).  `goto ret0;` + `ret0:` on the default arm fixes all 4.
 *             The label alone, without the goto, is inert (25).
 *   17 -> 11 -> 4  THE IDENTITY-LAUNDER ON THE CALL RESULT (13B) -- the crack for the
 *             three-wave "retail materialises the return constant BEFORE the store" class.
 *             `__asm__("" : "=r"(r) : "0"(r))` on the MemCardEventToRslt result makes `r` die
 *             twice, so combine_regs refuses to tie it to the call`s hard $v0; it becomes a
 *             global allocno assigned by conflict, retail`s `addu $a0,$v0,$zero` /
 *             `addu $v1,$v0,$zero` copy appears, and the hard `li $v0,1` of `return 1` can
 *             then be emitted BEFORE the store -- leaving the store for the `j` slot.
 *             Common tail -6, iodone tail -7, ev==4 arm INERT (its residual was a different
 *             row).  THE DIAL IS ON THE RESULT, NOT ON THE CONSTANT: every previous attempt
 *             (w61-a3`s opacity-fenced `long ret = 1;`, 12D staging on the dead `c`) dialled
 *             the constant and parked it in a saved reg.  ==> CATALOG ROW.
 * RESIDUAL (4 = ONE two-line swap): in the iodone tail retail emits `li $v0,1` BEFORE
 * `addiu $v1,$s0,-0xC`, we emit it after; identical insns, sched2 order only.  FALSIFIED:
 * `pi` assigned after the r launder (4, inert), same without the pi fence (7), dropping the
 * pi fence (7).  NEXT = a PER_FN_TEXT_MOVES two-line relocation (row filed in
 * scratchpad/w62a8/text_moves_probe.json).  NOT a floor. */
/* @0x800FABF0 : MemCardExist / MemCardAccept(card-present) probe step. */
static int MemCardExist_cb(void *pv)
{
    int *st = (int *)pv;
    int  ev;
    int  mask;
    int  c;
    int  pres;
    int *pchan;

    /* MATCH (w53-a7 -- SUPERSEDES the w51-a2 "not a switch" reading): the dispatch IS a real
     * `switch` on cases 0 / 10 / 0xB.  gcc-2.7.2 expands a 3-case set whose lowest case is 0 as a
     * LINEAR (unbalanced) case tree -- `beqz`(case 0) -> `bltz`(below the range -> default) ->
     * `beq 10` -> `beq 0xB` -> `j default` -- which is exactly the oracle's chain; the absence of
     * an `slti` bound test is what a linear tree looks like, NOT evidence against a switch.  The
     * decisive tell is the BLOCK LAYOUT: every case body is emitted OUT-OF-LINE after the whole
     * dispatch (an if/else cascade inlines the first body right after its test) and the case-0
     * body FALLS INTO the case-10 body (`.L800FAC34` runs straight on into `.L800FAC48`).
     *
     * MATCH: every `_mc_rslt` write goes through a &_mc_cmd-BASED pointer at [1], never a direct
     * `sw %lo(_mc_rslt)($at)` -- twice derived from the live &_mc_chan pointer (`addiu $v1,$s0,-0xC`
     * / the in-place `addiu $s0,$s0,-0xC` in a jal delay slot, §3.12 #14) and once materialized
     * fresh (`lui $v1,%hi(D_80147518); addiu; sw $v0,0x4($v1)`).  _mc_exrslt / _mc_exretry /
     * _mc_present keep their own `$at` store macros = plain field/static access.
     * 121 -> 47, count 116/117.  Landed, in order: the switch + case-0-falls-into-case-10 (->97),
     * the storage split of 0x500-0x514 (->97 but +5 insns of real body), the ORACLE BLOCK ORDER
     * (ev==4 / ev==0 / retry / common, all three arms of the `ev<3` node branching away) (->66),
     * post-call &_mc_cmd materialization in the ev==4 arm (->56), the `li 1;sllv` mask fence +
     * the chan/present load order (->47).
     * NAMED ANGLE (the 47): every `return 1` tail is 1 insn shorter than retail's -- retail
     * materializes the return constant BEFORE the store, forcing a redundant `addu $a0,$v0,$zero`
     * / `addu $v1,$v0,$zero` copy of the result out of $v0; an opacity-fenced `long ret = 1;`
     * reproduces the copy but parks the constant in a SAVED reg ($s0/$a1) instead of $v0
     * (iodone 47->49, common 47->52), so the crack is a de-merger that is not a fence. */
    switch (st[0]) {
    case 0:                             /* first entry */
        _mc_exrslt  = 0;
        _mc_exretry = 0;
        st[0] = 10;
        /* FALLTHROUGH -- retail's case-0 block runs straight into the (re)issue block */
    case 10:
        _clr_card_event();
        _card_info(mc.chan);
        st[0] = st[0] + 1;              /* -> 0xb */
        goto ret0;                      /* 13D shared-exit funnel: retail's case-10 exit is a bare
                                         * `j` onto the ONE `addu $v0,$zero,$zero` block that sits
                                         * just before the epilogue; spelled as `return 0;` gcc
                                         * materializes 0 locally and fills the chan load-delay
                                         * slot with it (ours had `addu $v0,$zero,$zero` where
                                         * retail has a `nop`).  25 -> 17. */

    case 0xb:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        _mc_exrslt = ev;
        /* BLOCK ORDER, read off the oracle: the `ev<3` node is a 3-WAY split whose arms ALL
         * branch away (`bgtz`->retry, `beqz`->iodone, `j`->common), and the bodies are emitted
         * in SOURCE order ev==4 / ev==0 / retry / common -- so the retry arm must NOT be the
         * fall-through (an `if (ev>0){...}` body inline gives `blez` + the wrong layout). */
        if (ev < 3) {
            if (ev > 0)  goto retry;    /* ev == 1 or 2 : retryable */
            if (ev == 0) goto iodone;
            goto common;                /* ev < 0 (unreachable: ev is `sum >> 1`) */
        }
        if (ev != 4) goto common;
        {                               /* new card */
            /* the &_mc_cmd base is materialized AFTER the call, into a CALLER-saved reg
             * (`jal; li a0,4; lui v1; addiu v1; sw v0,4(v1)`) -- computing it before the
             * call would force a callee-saved home + a frame save (catalog: post-call
             * address materialization) */
            int r = MemCardEventToRslt(4);
            int *pn = &mc.cmd;          /* w61-a3: block-local anchor = a local QTY */
            __asm__("" : "=r"(pn) : "0"(pn));
            pn[1] = r;
            return 1;
        }
iodone:                                 /* ev == 0 : I/O complete */
        /* the shift constant is this block's FIRST insn -- reorg then hoists it into the
         * `beqz $v1` delay slot and retargets the branch (oracle: `beqz $v1,.L800FACE4;
         * addiu $v0,$zero,0x1`), which is where our missing insn went */
        mask = 1;
        /* the fence keeps the mask a real `sllv` value: without it gcc canonicalizes
         * `(present & (1<<chan)) == 0` into `(present >> chan) & 1` (srav+andi), which the
         * oracle never has -- it computes `li 1; sllv; and; bnez` */
        pchan = &mc.chan;
        c    = *pchan;                  /* lw $a0,0($s0)   */
        pres = _mc_present;             /* lui $v1; lw $v1 -- fills the chan load's delay */
        mask = mask << c;
        if ((pres & mask) == 0)
            _mc_exrslt = 4;             /* never seen -> "no card" */
        {   /* &_mc_cmd is derived AFTER the call here, into its OWN caller-saved temp; the
             * return constant is materialized BEFORE the store, which is what forces retail's
             * otherwise-redundant `addu $a0,$v0,$zero` copy of the result out of $v0
             * (`addu a0,v0,zero; li v0,1; addiu v1,s0,-0xC; j; sw a0,4(v1)`) */
            int r = MemCardEventToRslt(_mc_exrslt);
            int ret;
            int *pi;                    /* w61-a3: block-local anchor = a local QTY */
            /* MATCH (W78 source-only, first half of 4 -> PASS): declaration
             * without initialization is load-bearing.  The tied return value
             * is emitted before the later `pi = pchan - 3` address assignment. */
            ret = 1;
            __asm__ __volatile__("" : "=r"(ret) : "0"(ret));
            pi = pchan - 3;
            __asm__("" : "=r"(pi) : "0"(pi));
            /* W62-A8: same IDENTITY-LAUNDER on the result as the common tail -- 11 -> 4.
             * Inert on the ev==4 arm (that tail`s residual is a different, slot-choice
             * row), so price it per tail. */
            __asm__("" : "=r"(r) : "0"(r));
            pi[1] = r;
            return ret;
        }
retry:
        _mc_exretry = _mc_exretry + 1;
        if (_mc_exretry < 5) { st[0] = 10; return 0; }
        /* FALLTHROUGH to the common tail */
common:
        /* W62-A8: the BLOCK-LOCAL ANCHOR LAW (13A) applied to the COMMON tail.  The
         * function-scope `pchan` was shared with the iodone tail => a GLOBAL allocno, and
         * local_alloc had already handed the chan VALUE $v0 before global.c placed it, so the
         * whole mask chain came out as retail's MIRROR (ours chan=$v0/mask=$v1, retail
         * chan=$v1/mask=$v0).  A block-local `pc` is a local QTY born before the value qty and
         * takes $v1, so the `li $v0,1` is emitted FIRST and every insn of the chain matches.
         * 39 -> 26.  NOTE the mask must stay a LITERAL: a named `m` (block-local, fenced or
         * not) is inert-or-worse here (26/27), and a FUNCTION-SCOPE `mask` costs +14 (53) --
         * the same global-vs-local race, one level up. */
        {
            int *pc = &mc.chan;
            int one;
            __asm__("" : "=r"(pc) : "0"(pc));
            /* MATCH (W78 source-only, second half): make the shift's 1 an
             * opaque first occurrence before loading *pc; retail places the
             * `li v0,1` ahead of the chan load. */
            one = 1;
            __asm__ __volatile__("" : "=r"(one) : "0"(one));
            _mc_present &= ~(one << *pc);
            pc = pc - 3;             /* MUTATED IN PLACE (`addiu $s0,$s0,-0xC` in the jal
                                         * delay slot); dropping the second opacity fence that
                                         * used to sit here is what lets reorg reach it -- an
                                         * asm makes stop_search_p return 1 (13B).  41 -> 39. */
            /* ANGLE (both tails, 2 diffs): retail materializes the return constant BEFORE the
             * store, forcing a redundant `addu $v1,$v0,$zero` copy of the result out of $v0
             * (`addu v1,v0,zero; li v0,1; j; sw v1,4(s0)`); ours stores straight from $v0 and
             * puts the `li` in the `j` slot = 1 insn shorter per tail.  FALSIFIED: opacity-
             * fenced `long ret = 1;` before the store (saved reg, not $v0); 12D staging on the
             * dead `c` (52). */
            {   /* W62-A8: the IDENTITY-LAUNDER (13B) on the CALL RESULT is the crack for
             * the `retail materialises the return constant BEFORE the store` class.  The
             * launder makes `r` die twice so combine_regs refuses to tie it to the call`s
             * hard $v0; it becomes a global allocno assigned by conflict, retail`s
             * `addu $v1,$v0,$zero` copy appears and the hard `li $v0,1` of `return 1` can
             * then be emitted BEFORE the store, leaving the store for the `j` slot.
             * 17 -> 11.  (An opacity-fenced `long ret = 1;` on the CONSTANT side was the
             * w61-a3 falsification -- it parks the constant in a saved reg; the dial is on
             * the RESULT, not on the constant.) */
                int r = MemCardEventToRslt(_mc_exrslt);
                __asm__("" : "=r"(r) : "0"(r));
                pc[1] = r;
            }
        }
        return 1;

    default:
ret0:
        return 0;
    }
}

/* @0x800FADC4 : MemCardAccept -- begin an async "accept/clear the card on chan". Same base-reuse
 * shape as MemCardExist above (and the same 4-diff delay-slot residual -- see the angle above). */
extern long MemCardAccept(long chan)
{
    int *base = &mc.cmd;
    if (base[0] > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    base[0] = 2;      /* cmd  */
    base[1] = 0;      /* rslt */
    base[2] = 0;      /* done */
    base[3] = chan;   /* chan */
    UserFuncOpen((int)MemCardCmd_cb);
    return 1;
}

/* W61-A3 -- MemCardCmd_cb 17 -> PASS (141/141).  THREE devices, all zero-insn:
 *
 * (1) BLOCK-LOCAL ANCHORS BEAT THE SHARED ONE (17 -> 11 -> 5).  A single function-scope
 *     `pc` referenced from three arms is a GLOBAL allocno, so local_alloc has already
 *     handed each arm`s own qty (the rslt value, the loaded event) $v0 by the time
 *     global.c places `pc` -- it lands in $v1 and every store in the function comes out
 *     mirrored.  Declaring the anchor INSIDE the arm makes it a block-local QTY whose
 *     local_alloc priority (refs/live = 3/3) beats the rslt qty`s (2/4), so it takes $v0
 *     and rslt falls to $v1 -- retail`s handout, exactly.  cdone: -6.  ctail ev==4: -6.
 *     GENERAL RULE: if retail`s per-arm registers are the mirror of ours and the arms
 *     share one pointer variable, SPLIT the variable -- do not dial it.  This is the
 *     cheap answer to the whole "local-alloc QTY handout" class that methodology 4.6
 *     de-prioritised as instrument-blind: qty272.py shows the local table directly, and
 *     scope (not refs) is the lever that moves a pseudo between the two allocators.
 *
 * (2) ARM ORDER (5 -> 4).  Retail branches `beqz` with the ZERO arm as the branch target
 *     and the `li 3` arm as the fall-through, so the source test is `if (cleared != 0)
 *     { rslt = 3; } else { rslt = 0; }`, not the natural `== 0` spelling.
 *
 * (3) HEAD-OF-THREAD BARRIER (4 -> PASS).  With the arms right, reorg still filled the
 *     `beqz` slot from the FALL-THROUGH thread (`li $v1,3`) instead of stealing the
 *     target thread`s `addu $v1,$zero,$zero`: mostly_true_jump (reorg.c) scores an EQ
 *     branch 0 = "unlikely", and fill_eager_delay_slots then tries the fall-through
 *     FIRST.  A zero-insn `__asm__("" : : "i"(0));` as the first statement of the
 *     fall-through arm makes that thread unstealable, so reorg falls through to the
 *     target thread and reproduces retail`s slot -- and the extra `j; nop` block that
 *     our version needed for the zero arm disappears (143 -> 141 insns).
 *     CATALOG CANDIDATE: "reorg took the wrong delay-slot thread" is dialable -- put a
 *     zero-insn barrier at the HEAD of the thread you do not want it to take.
 */
/* @0x800FAE2C : MemCardAccept command step (probe -> clear -> load). */
static int MemCardCmd_cb(void *pv)
{
    int *st = (int *)pv;
    int  ev;
    int  rslt;
    int  e;
    int  one;
    int *pc;
    int *prslt;

    /* MATCH (w53-a7): a real jump-table `switch` (oracle `sltiu $v0,$v1,0x20; sll $v0,$v1,2;
     * lw %lo(jtbl_80057398)`), so NO hand-written `if (state > 0x1f) return 0;` guard -- the
     * table's own range test IS that guard.
     * 🔴 TWO CORRECTNESS FIXES read off the oracle (the old body had both wrong):
     *   (1) case 10 with `rslt != 0 && rslt != 3` RETURNS 1 (`bne $v1,$v0,.L800FB04C` with
     *       `addiu $v0,$zero,0x1` in the delay slot = the epilogue with $v0=1), i.e. the command
     *       COMPLETES carrying the probe's error result.  The old body returned 0, so a failed
     *       MemCardAccept would have stayed queued in the USERFUNC stack forever.
     *   (2) the `ev >= 3` arm branches to the RETRY path when `ev == 4` (`beq $v1,$v0,.L800FAFD4`)
     *       and to the result tail otherwise; the old body had the ev==4 case inverted into a
     *       result store and did the retry accounting for the wrong events. */
    /* 107 -> 55.  LEVERS THAT LANDED: the jump-table switch (no manual range guard) · the two
     * correctness fixes above · a SHARED `ret0:` block for every `st[0]=N; return 0;` site (69->59,
     * retail's jlabel .L800FB048 = the switch default, which all of them `j` to) · an explicit
     * `set1e:` label so case 10's `rslt==0` path and the retry path share ONE `st[0]=0x1e` block
     * placed after the retry arm (77->69) · an opacity fence INSIDE one arm of the cleared-select
     * to block gcc's branchless if-conversion (`sltu;negu;andi 3`) (89->79, polarity flip ->77) ·
     * a SEPARATE local for the tail's re-read of _mc_evrslt (reusing `ev` extends its web onto the
     * $a0 call-arg and re-colors the whole dispatch) (57).
     * w60-a2: 55 -> 47 -> 17.  TWO further landings:
     *   🔴 CORRECTNESS: the `ctail` re-read wrote `ev = _mc_evrslt;` but then USED the never-
     *      assigned `e` in both the `e == 4` test and the two `pc[1] = e` / EventToRslt(e) uses
     *      -- an uninitialised local.  The w53-a7 note's own wording ("a SEPARATE local for the
     *      tail's re-read") says the assignment was meant to be `e = _mc_evrslt;`.  Fixed; worth
     *      8 diffs on its own (55 -> 47), which is the usual sign a "matching" hack was really
     *      standing in for a bug.
     *   🏆 NAMED ANGLE (a) CLOSED, 47 -> 17: the $s0<->$s1 swap is a global_alloc PRIORITY tie,
     *      priced with the floor_log2 REF-STEP dial (w44/catalog §A "priced register dial").
     *      priority ~ floor_log2(refs)*refs/live_length, and the first-allocated allocno takes
     *      the lowest free callee-saved reg ($s0=$16).  Retail hands $s0 to the `pv` param and
     *      $s1 to the case-10 &mc.rslt anchor; ours had it the other way because the anchor's
     *      live range is SHORT (one case arm) while `st` spans the whole function.  Buying `st`
     *      refs with ONE zero-insn read-only fence flips it -- but only once the count crosses a
     *      floor_log2 step.  MEASURED (each operand = +1 ref): 1 = 47, 4 = 47, 5 = 47, 6 = 47,
     *      7 = 47, 8 = 17, 9 = 17, 10 = 17; 12+ makes CC1PSX fail (asm-operand limit).  8 is the
     *      minimum that lands the step -- do not "tidy" the operand list, the COUNT is the dial.
     *      The swap cascaded through every `0($sN)` state access, so one fence took 30 diffs.
     * NAMED ANGLE (the 17 residual, both are the SAME class as MemCardExist_cb's): (a) the
     * `cdone` tail is a $v0<->$v1 swap -- retail keeps `rslt` in $v1 and the &mc.cmd anchor in
     * $v0, stores BEFORE the `j`, and fills the `j` slot with `li $v0,1`; ours holds rslt in $v0,
     * the anchor in $v1 and fills the slot with the store, cross-jump-merging its own `li $v0,1`
     * into a shared block (ours 140 vs oracle 141 = exactly that one merged constant);
     * (b) the `ctail` ev==4 arm wants the anchor in $v0 (reusing the just-dead `li $v0,4`
     * compare constant) where ours takes a fresh $v1.  FALSIFIED w60-a2: 2 extra identity fences
     * on `pc` in the ev==4 arm = 17 (inert) -- these are LOCAL-alloc QTY handouts, not global
     * allocnos, so the priced dial above does not reach them (methodology §4.6). */
    __asm__("" : : "r"(st),"r"(st),"r"(st),"r"(st),"r"(st),"r"(st),"r"(st),"r"(st));
    switch (st[0]) {
    case 0:
        _mc_cleared = 0;
        _mc_evrslt  = 0;
        _mc_retry   = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        goto ret0;

    case 10:
        /* anchor: retail materializes &_mc_rslt ($s1) and reaches _mc_chan as `0x8($s1)` */
        prslt = &mc.rslt;
        __asm__("" : "=r"(prslt) : "0"(prslt));
        if (prslt[0] == 0) goto set1e;  /* known card -> straight to load (SHARED block) */
        if (prslt[0] != 3) return 1;                    /* error result -> command complete */
        /* new card -> (re)clear it.  MATCH: ONE `li $v1,1` serves BOTH the _mc_cleared store
         * and the `1 << chan` shift (shared-constant); and no `& 0x1f` on the shift count --
         * the mask is a Ghidra transcription artifact (sllv masks in HW) that emits a real andi */
        one = 1;
        _mc_cleared  = one;
        _mc_present |= one << prslt[2];
        _clr_card_event();
        _card_clear(prslt[2]);
        st[0] = 0x15;
        goto ret0;

    case 0x15:
        if (_chk_card_event_x() == 0) return 0;
        _get_card_event_x();
        st[0] = 0x1e;
        /* FALLTHROUGH */
    case 0x1e:
        _clr_card_event();
        _card_load(mc.chan);
        st[0] = st[0] + 1;              /* 0x1e -> 0x1f */
        goto ret0;

    case 0x1f:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        _mc_evrslt = ev;
        if (ev < 3) {
            if (ev > 0)  goto cretry;
            if (ev == 0) goto cdone;
            goto ctail;                 /* ev < 0 (unreachable) */
        }
        if (ev == 4) goto cretry;
        goto ctail;
cdone:                                  /* ev == 0 : the accept sequence completed */
        /* MATCH: retail BRANCHES here (`beqz $v0,.L800FAFC0; addu $v1,$zero,$zero` -- the 0 in
         * the delay slot, the 3 on the fall-through).  Writing the select as `rslt = 0; if
         * (cleared) rslt = 3;` lets gcc-2.7.2 go BRANCHLESS (`sltu;negu;andi 3`), so the two
         * arms must both assign (§5.0c clamp-as-if/else). */
        if (_mc_cleared != 0) {
            __asm__("" : : "i"(0));
            rslt = 3;                   /* 3 = "new card, was cleared" */
            /* the fence is what BLOCKS the branchless if-conversion: gcc-2.7.2 turns BOTH
             * `rslt=0; if(c) rslt=3;` and a bare two-arm if/else into `sltu;negu;andi 3`, and an
             * asm inside an arm is the only thing that keeps the arm a real basic block */
        } else {
            rslt = 0;
        }
        {   /* w61-a3: a BLOCK-LOCAL anchor here (not the shared function-scope `pc`).
             * `pc` is referenced from three arms, so it is a GLOBAL allocno and
             * local_alloc hands this block's rslt qty $v0 first; a block-local pointer
             * is a local QTY whose priority (refs/live) beats rslt`s, so it takes $v0
             * and rslt falls to $v1 -- retail`s handout. */
            int *pd = &mc.cmd;
            __asm__("" : "=r"(pd) : "0"(pd));
            pd[1] = rslt;
            return 1;
        }
cretry:
        _mc_retry = _mc_retry + 1;
        /* the `st[0]=0x1e` block is the FALL-THROUGH here and the result tail is the branch
         * target (retail: `slti $v0,$v0,5; beqz $v0,.L800FB004` -> falls into `.L800FAFF8`),
         * and case 10's `rslt == 0` path cross-jumps INTO that same block */
        if (_mc_retry >= 5) goto ctail;
set1e:
        st[0] = 0x1e;
        goto ret0;
ctail:
        e = _mc_evrslt;                 /* re-read: retail loads it into $a0 for the call/store */
        if (e == 4) {
            int *pe = &mc.cmd;          /* w61-a3: block-local anchor (see cdone) */
            __asm__("" : "=r"(pe) : "0"(pe));
            pe[1] = e;                  /* stores the LOADED 4, not a fresh `li` */
            return 1;
        }
        {
            int r = MemCardEventToRslt(e);
            pc = &mc.cmd;
            __asm__("" : "=r"(pc) : "0"(pc));
            pc[1] = r;
            return 1;
        }

    default:
ret0:                                   /* the SHARED `addu $v0,$zero,$zero` block --
                                         * every `st[0] = N; return 0;` site jumps here
                                         * (retail jlabel .L800FB048 = the switch default) */
        return 0;
    }
}

/* PsyQ 4.3's vendor LIBMCRD.OBJ and the retail CPE both place this diagnostic
 * before the ReadData diagnostics.  Keeping the accessor inline records the
 * pooled literal at this source position without emitting an extra function;
 * its two consumers still compile to the same direct literal address. */
static __inline__ const char *MemCardFileAlreadyOpenMessage(void)
{
    return "Access Denied. : file already open.\n";
}

/* @0x800FB060 : MemCardReadData -- async read into adrs (offset/length must be 128-byte aligned). */
extern long MemCardReadData(unsigned long *adrs, long ofs, long bytes)
{
    /* 🏆 PASS (w53-a7, 26 -> 0).  FOUR cooperating details, all read off the oracle:
     *  (1) TWO bases: the guard reads go through &_mc_fd ($a3, `lw 0($a3)` / `lw -16($a3)`) and
     *      the store block through a DERIVED &_mc_cmd (`addiu $v1,$a3,-16`) indexed +4/+8/+20/
     *      +24/+28.  The derived pointer needs its OWN opacity fence or gcc folds it back into
     *      negative displacements off $a3 (one base, 5 diffs worse).
     *  (2) _mc_cmd is read AND written through the $a3 anchor (`pfd[-4]`), NOT the derived base
     *      -- that is what keeps $a3 live past the derivation instead of gcc mutating it in place.
     *  (3) the pc definition sits AFTER the cmd guard, so it is emitted in that block and GNU-as
     *      backward-fills it into the `blez` delay slot (defining it earlier lands it in the
     *      `bgez` slot instead).
     *  (4) a fenced copy of the `adrs` parm at the HEAD of the fd-guard's else block: retail's
     *      `addu $t0,$a0,$zero` is the `bgez` delay-slot filler, not a prologue parm copy.
     *  Store ORDER is cmd, rslt, done, ofs, adrs, len (the LEN store is the one as backward-fills
     *  into the `jal` delay slot). */
    const char *fmt;
    int *pfd = &mc.fd;
    __asm__ __volatile__("" : "=r"(pfd) : "0"(pfd));
    if (*pfd < 0) {
        fmt = "Access Denied. : file not open.\n";
    } else {
        unsigned long *ad = adrs;                   /* parm copy at the BLOCK head (bgez slot) */
        __asm__ __volatile__("" : "=r"(ad) : "0"(ad));
        if (0 < pfd[-4]) {                             /* cmd */
            fmt = "Access Denied. : event multiple open\n";
        } else {
            int *pc = pfd - 4;                      /* &mc.cmd, derived (addiu v1,a3,-16) */
            __asm__ __volatile__("" : "=r"(pc) : "0"(pc));
            if ((bytes & 0x7f) != 0) {
                fmt = "Access Denied. : invalid data size align\n";
            } else if ((ofs & 0x7f) == 0) {
                pfd[-4] = 5;                            /* cmd  */
                pc[1] = 0;                               /* rslt */
                pc[2] = 0;                                /* done */
                pc[5] = ofs;                               /* ofs  */
                *(unsigned long **)&pc[7] = ad;             /* adrs */
                pc[6] = bytes;                               /* len  */
                UserFuncOpen((int)MemCardReadData_cb);
                return 1;
            } else {
                fmt = "Access Denied. : invalid offset value align\n";
            }
        }
    }
    printf(fmt);
    return 0;
}

/* w60-a2 -- THE SAME-SOURCE-LINE CROSS_JUMP RULE.  Both *Data_cb twins report their
 * completion through TWO duplicated `MemCardEventToRslt` tails that retail's gcc CROSS-JUMPED
 * back into one shared call, leaving only the ev==0 arm's own argument setup behind
 * (`.L800FB21C: addu $a0,$zero,$zero` falling into `.L800FB220: jal MemCardEventToRslt`).
 * A single shared call with the `if (ev != 0)` guard above it CANNOT produce that block --
 * the ev==0 edge lands straight on the join, so the arm has nowhere to put its `$a0 = 0`.
 * Writing the two tails out DOES make gcc cross-jump them -- but ONLY if their two `__asm__`
 * base-anchor fences sit on the SAME SOURCE LINE.  find_cross_jump compares candidate insns
 * with rtx_renumbered_equal_p (jump.c:2637), whose generic loop compares every 'i' field of
 * the rtx -- and ASM_OPERANDS carries ASM_OPERANDS_SOURCE_LINE as an 'i' field.  Two
 * byte-identical fences on different lines therefore compare UNEQUAL, the merge stops at
 * them, and two `jal`s survive (that is the w55-a7 receipt's "cross_jump will NOT merge
 * across the __asm__", 85 insns / 10 diffs -- it was never the asm itself, it was the LINE).
 * Expanding both tails from ONE macro invoked twice on ONE line makes the fences identical
 * rtx, the merge runs the whole way back through the call, and both twins byte-match.
 *   MemCardReadData_cb  1 -> PASS 79/79      MemCardWriteData_cb  1 -> PASS 79/79
 * DO NOT reformat the two invocation sites onto separate lines -- that silently reverts both
 * functions to a 1-diff near-miss.  (The non-volatile fence is NOT rejected by
 * find_cross_jump's own asm guard, which only refuses ASM_INPUT and VOLATILE ASM_OPERANDS.)
 * Falsified alternative (w60-a2): an unsized-array asm-label view `extern int mc_words[]
 * __asm__("mc")` removes the fence and DOES merge, but a constant element index folds the
 * access back to `(symbol_ref mc + 4)` and emits the `lui $at; sw %lo` macro -- 1 -> 5. */
#define MCRD_REPORT(EV) r = MemCardEventToRslt(EV); pc = &mc.cmd; __asm__("" : "=r"(pc) : "0"(pc)); pc[1] = r; return 1

/* @0x800FB118 : MemCardReadData transfer step. */
static int MemCardReadData_cb(void *pv)
{
    int ev;
    int r;
    int *st = (int *)pv;
    int state;
    /* 🏆 MATCH (w55-a7, 10 -> 4 = parity with the WriteData twin): the PARM-SPILL PIN (w54 06B).
     * Retail copies the incoming `pv` into $s1 at the TOP (`sw $s1,0x14($sp); addu $s1,$a0,$zero`)
     * and reads the state through it (`lw $v1,0($s1)`); ours read `lw $v1,0($a0)` directly and let
     * reorg sink the copy into the case-10 `beq`'s delay slot.  An opacity fence on `st` placed
     * BEFORE its first use pins assign_parms' copy at retail's prologue position.  The twin
     * MemCardWriteData_cb does not need it (its case 0 returns instead of falling through, so the
     * copy is not a slot candidate there).  Measured INERT on MemCardExist_cb (47, unchanged) --
     * per-fn, not a sweep. */
    state = st[0];


    /* 🏆 PASS (w78, 79/79): hand-balanced form of the retail switch tree.  The staged
     * `zero = state - state` deliberately keeps jump1 from inverting the high/low diamond.
     * CSE erases the zero-net carrier; jump2 can then invert after `thirty` has received $v0,
     * and reorg puts `li $v0,30` in the bound-test slot.  Case 0 still falls into state10. */
    {
        int thirty;
        int zero;
        if (state == 10) goto state10;
        if (state < 11) goto lowstate;
        zero = state;
        zero = zero - state;
        thirty = zero + 30;
        if (zero == 0) goto highstate;
        goto ret0;
lowstate:
        if (state == 0) goto state0;
        goto ret0;
highstate:
        if (state == thirty) goto state30;
        goto ret0;
    }
state0:
        _mc_rd_retry = 0;
        st[0] = 10;
        /* FALLTHROUGH */
state10:
        do { r = lseek(mc.fd, mc.ofs, 0); } while (r != mc.ofs);
        _clr_card_event();
        do { r = read(mc.fd, mc.adrs, mc.len); } while (r != 0);
        st[0] = 0x1e;
        goto ret0;
state30:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        {
            int  r;
            int *pc;
            if (ev != 0) { _mc_rd_retry = _mc_rd_retry + 1; if (_mc_rd_retry < 4) { st[0] = 10; return 0; } MCRD_REPORT(ev); } MCRD_REPORT(0);
        }
ret0:
        return 0;
}

/* @0x800FB254 : MemCardWriteData -- async write from adrs. */
extern long MemCardWriteData(unsigned long *adrs, long ofs, long bytes)
{
    /* MATCH shape: see MemCardReadData above (same anchor-on-&_mc_fd pattern). */
    const char *fmt;
    int *pfd = &mc.fd;
    __asm__ __volatile__("" : "=r"(pfd) : "0"(pfd));
    if (*pfd < 0) {
        fmt = "Access Denied. : file not open.\n";
    } else {
        unsigned long *ad = adrs;                   /* parm copy at the BLOCK head (bgez slot) */
        __asm__ __volatile__("" : "=r"(ad) : "0"(ad));
        if (0 < pfd[-4]) {                             /* cmd */
            fmt = "Access Denied. : event multiple open\n";
        } else {
            int *pc = pfd - 4;                      /* &mc.cmd, derived (addiu v1,a3,-16) */
            __asm__ __volatile__("" : "=r"(pc) : "0"(pc));
            if ((bytes & 0x7f) != 0) {
                fmt = "Access Denied. : invalid data size align\n";
            } else if ((ofs & 0x7f) == 0) {
                pfd[-4] = 6;                            /* cmd  */
                pc[1] = 0;                               /* rslt */
                pc[2] = 0;                                /* done */
                pc[5] = ofs;                               /* ofs  */
                *(unsigned long **)&pc[7] = ad;             /* adrs */
                pc[6] = bytes;                               /* len  */
                UserFuncOpen((int)MemCardWriteData_cb);
                return 1;
            } else {
                fmt = "Access Denied. : invalid offset value align\n";
            }
        }
    }
    printf(fmt);
    return 0;
}

/* @0x800FB30C : MemCardWriteData transfer step. */
static int MemCardWriteData_cb(void *pv)
{
    int ev;
    int r;
    int *st = (int *)pv;
    int state = st[0];


    /* 🏆 PASS (w78, 79/79): same delayed-jump pure-C receipt as ReadData.  Keep the body order
     * state0, state30, state10: unlike ReadData, state0 returns through ret0 rather than falling
     * into the transfer body.  The zero-net carrier is load-bearing despite emitting no code. */
    {
        int thirty;
        int zero;
        if (state == 10) goto state10;
        if (state < 11) goto lowstate;
        zero = state;
        zero = zero - state;
        thirty = zero + 30;
        if (zero == 0) goto highstate;
        goto ret0;
lowstate:
        if (state == 0) goto state0;
        goto ret0;
highstate:
        if (state == thirty) goto state30;
        goto ret0;
    }
state0:
        _mc_wr_retry = 0;
        st[0] = 10;
        goto ret0;
state30:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        {   /* MATCH (w53-a7): the &_mc_cmd base is materialized AFTER the call, into a
             * caller-saved reg (`jal; nop; lui $v1; addiu $v1; sw $v0,0x4($v1)`); the natural
             * `mc.rslt = ...` field store emits a `lui $at; sw %lo(...)($at)` macro instead.
             * MATCH (w55-a7): the completion is written TWICE -- once per arm -- and gcc
             * cross-jumps the two `jal MemCardEventToRslt` tails back into ONE shared call
             * (`.L800FB3B8: addu $a0,$zero,$zero` falls into `.L800FB3BC: jal ...`).  A single
             * shared call with the `if (ev != 0)` guard above it cannot produce that block: the
             * ev==0 edge lands straight on the join, so there is nowhere for the arm's own
             * `$a0 = 0` arg setup to live. */
            int  r;
            int *pc;
            if (ev != 0) { _mc_wr_retry = _mc_wr_retry + 1; if (_mc_wr_retry < 4) { st[0] = 10; return 0; } MCRD_REPORT(ev); } MCRD_REPORT(0);
        }
state10:
        do { r = lseek(mc.fd, mc.ofs, 0); } while (r != mc.ofs);
        _clr_card_event();
        do { r = write(mc.fd, mc.adrs, mc.len); } while (r != 0);
        st[0] = 0x1e;
        goto ret0;
ret0:
        return 0;
}

/* @0x800FB448 : MemCardReadFile -- async open+read of a named card file. */
extern long MemCardReadFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    /* MATCH (w53-a7): ONE fenced anchor at &_mc_cmd ($s1 in retail) serves the guard READS
     * (cmd @0, fd @16), the devname address (`addiu $s0,$s1,32`) and ALL SEVEN field stores by
     * displacement.  The natural `mc.field = x` store form emits a `lui $at; sw %lo(sym)($at)`
     * assembler macro PER STORE (+6 insns) even with the base already live -- that macro pair
     * was the entire 76-vs-70 count gap.  Store ORDER is read off the oracle: cmd, rslt, done,
     * ofs, adrs, len, chan (the chan store is the one GNU-as backward-fills into the `jal`
     * delay slot).  🏆 PASS (w53-a7, 34 -> 0) -- and the LAST 5 diffs were the fence FLAVOUR:
     * with `__asm__ __volatile__` the barrier pins the 5th (stack) parm's `lw $s6,0x40($sp)` to
     * the top of the prologue, where retail's scheduler instead drops it into the `lw $v0,0($s1)`
     * load-delay gap.  Plain `__asm__` (schedulable) = PASS. */
    const char *fmt;
    int *base = &mc.cmd;
    __asm__("" : "=r"(base) : "0"(base));
    if (0 < base[0]) {
        fmt = "Access Denied. : system busy\n";
    } else if (0 <= base[4]) {                     /* fd */
        fmt = MemCardFileAlreadyOpenMessage();
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else if ((ofs & 0x7f) == 0) {
        MemCardMakeDevname(chan, (char *)&base[8]);
        strcat((char *)&base[8], file);
        base[0] = 3;                               /* cmd  */
        base[1] = 0;                               /* rslt */
        base[2] = 0;                               /* done */
        base[5] = ofs;                             /* ofs  */
        *(unsigned long **)&base[7] = adrs;        /* adrs */
        base[6] = bytes;                           /* len  */
        base[3] = chan;                            /* chan */
        UserFuncOpen((int)MemCardReadFile_cb);
        return 1;
    } else {
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB560 : MemCardReadFile step (exist -> open -> read -> close). */
static int MemCardReadFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    /* 🏆 PASS (w78, 66/66): hand-balanced retail switch tree plus the pure-C late-jump carrier.
     * Keeping `eleven` target-local lets local_alloc give it $v0; the staged zero and its true
     * test postpone branch inversion from jump1 to jump2, after allocation, so reorg emits the
     * retail `beqz ...; li $v0,11`.  state10 still falls directly into state11. */
    {
        int eleven;
        int zero;
        if (state == 10) goto state10;
        if (state < 11) goto lowstate;
        zero = state;
        zero = zero - state;
        eleven = zero + 11;
        if (zero == 0) goto highstate;
        goto ret0;
lowstate:
        if (state == 0) goto state0;
        goto ret0;
highstate:
        if (state == eleven) goto state11;
    }
    if (state == 20) goto state20;
    goto ret0;
state0:
        _mc_rf_retry = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        goto ret0;                                 /* SHARED `addu $v0,$zero,$zero` block */
state10: {
        /* MATCH (w53-a7): retail anchors on &_mc_rslt ($s0) and reaches _mc_fd by displacement
         * (`sw $v0,0xC($s0)`) and the error code through a DERIVED &_mc_cmd base
         * (`addiu $v1,$s0,-4; sw $v0,0x4($v1)`); the natural field stores emit `$at` macros.
         * The fd store is UNCONDITIONAL -- it sits in the `bgez` delay slot. */
        /* SOURCE-ONLY: the zero-net offset keeps the retail &_mc_rslt base allocation without
         * the former empty-asm identity fence (verified byte-identical on both File twins). */
        int *prslt = (int *)((char *)&mc.rslt + state - state);
        int  fd;
        if (prslt[0] != 0) return 1;               /* card not present -> abort */
        fd = open((char *)&prslt[7], 0x8001);   /* _mc_devname = `addiu $a0,$s0,28` */
        prslt[3] = fd;                             /* _mc_fd */
        if (fd < 0) {                              /* open failed */
            /* 🏆 MATCH (w55-a7, 9 -> 3 on BOTH twins): this 2-qty block is a pure local_alloc
             * rotation -- retail addr=$v1 / const=$v0, ours was addr=$v0 / const=$v1.  Per the
             * w45 §A0 law `QTY_CMP_PRI == allocno_compare` (= floor_log2(refs)*refs*size/live),
             * the address qty out-ranked the bare constant (equal refs, but live 1 vs 2), so it
             * took the lower reg.  CURE = the floor_log2 REF-STEP dial applied at the QTY layer:
             * name the constant and give it THREE identity fences (each = +2 refs at ZERO insns),
             * lifting it 4 -> 8 refs = one flr2 step, so it is allocated first and takes $v0.
             * BOTH ingredients are load-bearing and were found in this order:
             *   bare `pc[1] = 5;` ............................................ 9
             *   named `five` DECLARED-with-init before pc (birth order only) . 9  (emission order
             *                                                                  flipped, registers
             *                                                                  did NOT -- birth
             *                                                                  order is not the
             *                                                                  dial here)
             *   + 3 identity fences on `five`, still declared-with-init ...... 5  (registers now
             *                                                                  retail's; only the
             *                                                                  li/addiu EMISSION
             *                                                                  order wrong)
             *   + `int five;` uninitialised, ASSIGNED after pc's fence ....... 3  (a decl-with-init
             *                                                                  is emitted at block
             *                                                                  head no matter what;
             *                                                                  the separate
             *                                                                  assignment is what
             *                                                                  puts `addiu` first)
             * Residual 3 = the shared *_cb bound-test delay slot (see the TU header OPEN ANGLE). */
            int  five;
            int *pc = prslt - 1;                   /* &_mc_cmd */
            __asm__("" : "=r"(pc) : "0"(pc));
            five = 5;
            __asm__("" : "=r"(five) : "0"(five));
            pc[1] = five;
            return 1;
        }
        }
        /* FALLTHROUGH */
state11:
        st[0] = 0x14;
        UserFuncOpen((int)MemCardReadData_cb);
        goto ret0;
state20:
        close(mc.fd);
        mc.fd = -1;
        return 1;
ret0:
        return 0;
}

/* @0x800FB668 : MemCardWriteFile -- async open+write of a named card file. */
extern long MemCardWriteFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    /* MATCH (w53-a7): identical shape to the MemCardReadFile twin -- ONE NON-volatile-fenced
     * anchor at &_mc_cmd ($s1) for the guard reads, the devname address and all seven stores. */
    const char *fmt;
    int *base = &mc.cmd;
    __asm__("" : "=r"(base) : "0"(base));
    if (0 < base[0]) {
        fmt = "Access Denied. : system busy\n";
    } else if (0 <= base[4]) {                     /* fd */
        fmt = MemCardFileAlreadyOpenMessage();
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else if ((ofs & 0x7f) == 0) {
        MemCardMakeDevname(chan, (char *)&base[8]);
        strcat((char *)&base[8], file);
        base[0] = 4;                               /* cmd  */
        base[1] = 0;                               /* rslt */
        base[2] = 0;                               /* done */
        base[5] = ofs;                             /* ofs  */
        *(unsigned long **)&base[7] = adrs;        /* adrs */
        base[6] = bytes;                           /* len  */
        base[3] = chan;                            /* chan */
        UserFuncOpen((int)MemCardWriteFile_cb);
        return 1;
    } else {
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB780 : MemCardWriteFile step (exist -> open -> write -> close). */
static int MemCardWriteFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    /* 🏆 PASS (w78, 66/66): exact twin of ReadFile's pure-C jump1/CSE/jump2 receipt. */
    {
        int eleven;
        int zero;
        if (state == 10) goto state10;
        if (state < 11) goto lowstate;
        zero = state;
        zero = zero - state;
        eleven = zero + 11;
        if (zero == 0) goto highstate;
        goto ret0;
lowstate:
        if (state == 0) goto state0;
        goto ret0;
highstate:
        if (state == eleven) goto state11;
    }
    if (state == 20) goto state20;
    goto ret0;
state0:
        _mc_wf_retry = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        goto ret0;                                 /* SHARED `addu $v0,$zero,$zero` block */
state10: {
        /* MATCH (w53-a7): same &_mc_rslt anchor as the ReadFile twin -- _mc_fd by displacement
         * (`sw $v0,0xC($s0)`, UNCONDITIONAL: it is the `bgez` delay slot), _mc_devname as
         * `addiu $a0,$s0,28`, and the error code through a derived &_mc_cmd base. */
        /* SOURCE-ONLY: twin of MemCardReadFile_cb's pure-C zero-offset base anchor. */
        int *prslt = (int *)((char *)&mc.rslt + state - state);
        int  fd;
        if (prslt[0] != 0) return 1;
        fd = open((char *)&prslt[7], 0x8001);      /* _mc_devname */
        prslt[3] = fd;                             /* _mc_fd */
        if (fd < 0) {
            /* 🏆 MATCH (w55-a7, 9 -> 3 on BOTH twins): this 2-qty block is a pure local_alloc
             * rotation -- retail addr=$v1 / const=$v0, ours was addr=$v0 / const=$v1.  Per the
             * w45 §A0 law `QTY_CMP_PRI == allocno_compare` (= floor_log2(refs)*refs*size/live),
             * the address qty out-ranked the bare constant (equal refs, but live 1 vs 2), so it
             * took the lower reg.  CURE = the floor_log2 REF-STEP dial applied at the QTY layer:
             * name the constant and give it THREE identity fences (each = +2 refs at ZERO insns),
             * lifting it 4 -> 8 refs = one flr2 step, so it is allocated first and takes $v0.
             * BOTH ingredients are load-bearing and were found in this order:
             *   bare `pc[1] = 5;` ............................................ 9
             *   named `five` DECLARED-with-init before pc (birth order only) . 9  (emission order
             *                                                                  flipped, registers
             *                                                                  did NOT -- birth
             *                                                                  order is not the
             *                                                                  dial here)
             *   + 3 identity fences on `five`, still declared-with-init ...... 5  (registers now
             *                                                                  retail's; only the
             *                                                                  li/addiu EMISSION
             *                                                                  order wrong)
             *   + `int five;` uninitialised, ASSIGNED after pc's fence ....... 3  (a decl-with-init
             *                                                                  is emitted at block
             *                                                                  head no matter what;
             *                                                                  the separate
             *                                                                  assignment is what
             *                                                                  puts `addiu` first)
             * Residual 3 = the shared *_cb bound-test delay slot (see the TU header OPEN ANGLE). */
            int  five;
            int *pc = prslt - 1;                   /* &_mc_cmd */
            __asm__("" : "=r"(pc) : "0"(pc));
            five = 5;
            __asm__("" : "=r"(five) : "0"(five));
            pc[1] = five;
            return 1;
        }
        }
        /* FALLTHROUGH */
state11:
        st[0] = 0x14;
        UserFuncOpen((int)MemCardWriteData_cb);
        goto ret0;
state20:
        close(mc.fd);
        mc.fd = -1;
        return 1;
ret0:
        return 0;
}

/* @0x800FB888 : MemCardGetDirentry -- synchronous directory listing (max files into dir[]). */
extern long MemCardGetDirentry(long chan, char *name, DIRENTRY *dir,
                                long *files, long ofs, long max)
{
    char devname[32];
    DIRENTRY ent;
    DIRENTRY *p;
    int idx;
    int stored;
    int retry;
    int command;
    long offset;
    McState *mcp;
    long *output;
    int d0, d1, d2, d3, d4;
    struct {
        int result;
        long *files;
    } local;

    __asm__("" : : "r"(dir), "r"(dir));
    mcp = &mc;
    local.files = files;
    offset = *(volatile long *)&ofs;

    if (mcp->cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    MemCardMakeDevname(chan, devname);
    __asm__("" : : "r"(chan), "r"(chan), "r"(chan));
    strcat(devname, name);
    __asm__("" : "=r"(mcp) : "0"(mcp));

    local.result = 0;
    retry = 0;
    idx = 0;
    command = 2;
    _mc_present |= 1 << mcp->chan;
    stored = 0;

    if (offset + max > 0) {
        do {
            __asm__("" : : "r"(idx), "r"(idx), "r"(idx),
                             "r"(retry), "r"(retry), "r"(retry));
            if (idx == 0) {
                for (;;) {
                    _clr_card_event();
                    p = firstfile(devname, &ent);
                    if (p != 0)
                        break;

                    local.result = MemCardEventToRslt((uint)_get_card_event_x());
                    if (local.result == 0)
                        break;

                    retry++;
                    if (retry >= 4) {
                        _mc_save_cb =
                            (int (*)(int, int))MemCardCallback(0);
                        if (mcp->cmd > 0) {
                            printf("Access Denied. : event multiple open\n");
                        } else {
                            mcp->cmd = command;
                            mcp->rslt = 0;
                            mcp->done = 0;
                            UserFuncOpen((mc.chan = chan,
                                          (int)MemCardCmd_cb));
                        }
                        MemCardSync(0, 0, &local.result);
                        MemCardCallback((int)_mc_save_cb);
                        return local.result;
                    }
                }
            } else {
                p = nextfile(&ent);
            }

            if (p == 0)
                break;

            if (idx >= offset && dir != 0) {
                dir[stored++] = ent;
            }

            idx++;
        } while (idx < offset + max);
    }

    __asm__("" : : "r"(stored), "r"(stored), "r"(dir));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : : "i"(0));
    __asm__("" : "=r"(d0), "=r"(d1), "=r"(d2),
                  "=r"(d3), "=r"(d4));
    __asm__("" : : "r"(d0), "r"(d1), "r"(d2),
                     "r"(d3), "r"(d4));
    output = local.files;
    if (output != 0)
        *output = stored;
    return 0;
}
/* @0x800FBAE8 : MemCardCallback -- install completion callback, return the previous one. */
extern int MemCardCallback(int func)
{
    int prev;
    typedef int (*CbT)(int, int);
    CbT *p = &mc.callback;
    prev = (int)p[0];
    p[0] = (CbT)func;
    return prev;
}

/* @0x800FBAFC : MemCardSync -- poll (mode!=0) or block (mode==0) for command completion.
 *
 * 🏆 MATCH (w52-a6): `__inline__` (GNU C89 semantics: plain `inline` on a non-static function still
 * emits the out-of-line copy, so the exported @0x800FBAFC symbol survives AND still PASSes) -- the
 * oracle INLINES this function into MemCardCreateFile / MemCardDeleteFile.  Proof in the oracle:
 * both callers have NO `jal MemCardSync` (jal census was ours 12 / retail 11) and instead carry
 * this body verbatim at .L800FBD38 -- including the two DEAD snapshot loads (`lw $v0,0($s0)`,
 * `lw $v0,4($s0)`, results unused because `cmds` is the constant 0 at those call sites), which no
 * hand-written copy of the logic would ever contain.  That expansion was the whole 22-24-insn
 * shortfall in both callers (CreateFile 108 -> 132 of 130, DeleteFile 87 -> 111 of 111 EXACT). */
/* W61-A3 NAMED ANGLE (worth 15 diffs in EACH of MemCardCreateFile / MemCardDeleteFile;
 * mechanism now identified end to end, so this is a receipt, not a floor).
 *
 * SYMPTOM: in both callers retail`s INLINED copy of this body reaches cmd/rslt/done through
 * the CALLER`s anchor register ($s0: `lw $v0,0($s0)`, `lw $v0,4($s0)`, `sw $zero,8($s0)`)
 * and materialises a SEPARATE `lui;addiu` only for the spin address, while ours materialises
 * this fn`s own anchor inside the loop and then rebases it (`addiu $v1,$v1,8`).  Retail also
 * keeps the two DEAD snapshot loads (`lw $v0,0($s0); lw $v0,4($s0)`) that our inlined copy
 * dead-code-eliminates, which is independent evidence that retail`s reads are not plain.
 *
 * WHY THE OBVIOUS FIXES CANNOT WORK (all measured, in the post-rotation basin):
 *   drop this fence entirely ....... MemCardSync 0 -> 3, DeleteFile 34 -> 39, Create -> 73
 *                                    (with a plain base the inlined loads at offsets 4/8
 *                                    constant-fold to `lui;lw` macros -- 2 insns each)
 *   make it non-volatile ........... byte-identical whole-TU (so the flavour is NOT the
 *                                    lever, contrary to what the old note implied)
 *   shared `static __inline__ int *mc_anchor(void)` used by this fn AND the callers, so
 *   every expansion of the fence carries ONE source line ... DeleteFile 48, Create 41.
 *     Rationale (correct, but insufficient): cse.c`s exp_equiv_p compares the generic
 *     `i` fields, and ASM_OPERANDS carries ASM_OPERANDS_SOURCE_LINE as one -- so two
 *     fences on the SAME line ARE cse-equal (this is 12C`s rule, on the cse side).
 *     It still does not merge, because the caller`s anchor is in the loop PREHEADER and
 *     the inlined body is inside the loop: different extended basic blocks, and cse`s
 *     table is reset at an EBB boundary.  loop.c would have to hoist the asm first;
 *     invariant_p (loop.c) does accept a non-volatile ASM_OPERANDS, but scan_loop does
 *     not move it out of this loop (maybe_never is set by the branches above it).
 *
 * SHARPENED ANGLE: get the inlined anchor into the loop PREHEADER (where cse2-after-loop
 * can merge it with the caller`s anchor) -- i.e. a device that is loop-hoistable AND
 * opacity-preserving.  A gcc -dL/-dS dump of MemCardDeleteFile will show exactly why
 * scan_loop declines the asm; that is the next experiment, not another spelling sweep. */
/* 🏆 W64-A4 — THE INLINED-ANCHOR CLASS, SOLVED (CreateFile 30 -> 12, DeleteFile 23 -> 5,
 * both COUNT-EXACT; MemCardSync itself stays PASS).  Five waves treated this as an
 * "anchor cannot merge" allocator/LICM problem; it is a SIGNATURE problem.
 *
 * THE MECHANISM (read off the cc1-2.7.2 `-dL` dump of MemCardDeleteFile, not guessed):
 * the inlined copy's own `int *base = &mc.cmd;` NEVER appears in loop.c's movable list at
 * all -- neither with the opacity fence nor without it (measured both; the w63-a4
 * "scan_loop declines the volatile asm" reading is REFUTED: dropping the fence leaves the
 * movable list byte-identical, `Insn 120 regno 88 savings 2 moved` + `Insn 275 regno 119
 * done move-insn matches 120` and nothing else).  With no fence cse folds every access
 * through the known-constant pointer into the `lw/sw $r,sym+off` assembler MACRO, so there
 * is no pseudo to hoist; with the fence there IS a pseudo but it is opaque, so
 * `rtx_equal_for_loop_p` can never match it against the caller's anchor and
 * `combine_movables` (loop.c:1342, the `m->match` merge that DOES fire for the two `li 2`
 * movables in the same loop) cannot merge them.  A pincer: no source spelling of a
 * FUNCTION-LOCAL anchor can reach retail's shared register.
 *
 * THE CURE: the anchor is a PARAMETER.  Then the inliner substitutes the CALLER's pointer
 * pseudo directly and retail's single shared base ($s0 across the caller's field stores AND
 * the whole inlined sync body) falls out with no dial at all.  MemCardSync keeps its own
 * body (see below) because the two instantiations need OPPOSITE spellings of the
 * spin-pointer / done-store pair -- which is itself evidence for the split, and a 2x2
 * matrix proves no single spelling serves both:
 *      pdone=&base[2] store=fresh-anchor   Sync PASS | Create 22 | Delete 15
 *      pdone=&mc.done store=base[2]=0      Sync   9  | Create 13 | Delete  6
 *      pdone=&base[2] store=base[2]=0      Sync   8  | Create 17 | Delete 10
 *      pdone=&mc.done store=fresh-anchor   Sync   3  | Create 18 | Delete 11
 * so the helper takes row 2 and the standalone keeps row 1.  Landed with the plain
 * `return 1` (the callers discard the result, so the cross-jump launder's `li $v0,1` is
 * pure excess here: 13/6 -> 12/5).
 *
 * FALSIFIED in THIS basin (04Z re-probes, all whole-TU gated):
 *   volatile snapshot reads to keep retail's two dead `lw 0($s0)/4($s0)` .. Cre 14 Del  7
 *   read-only fence on cmd+rslt (same goal) ......................... Cre 18 Del 11
 *   read-only fence on cmd only ..................................... Cre 16 Del  9
 *   block-local fenced `pc` for the p[3] chan read (the GetDirentry
 *     device) -- re-confirms the w62-a8 verdict in the new basin ..... Cre 12 Del 29
 *   named `oflag = 1;` before/after the _mc_present statement to move
 *     retail's early `li $a1,1` ............................. inert (12/5); FENCED 22/5
 * REMAINING: Delete 5 = the `p[3]` load-fold (2) + retail's two dead snapshot loads (2);
 * Create 12 = the same 4 + the `li $a1,1` open()-arg position (2) + the `p[0]`-load-above-
 * the-`_mc_save_cb`-store schedule that CreateFile's opaque base costs (DeleteFile's plain
 * base is free of it).  All named, none a floor. */
/* 🔑 W71-A13 -- THE TWO DEAD SNAPSHOT LOADS, PRICED (they are the last 2 diffs of BOTH callers).
 * Retail's inlined copy keeps `lw $v0,0($s0); lw $v0,4($s0)` (SAME dest, both dead: `cmds` and
 * `result` are compile-time constants at both call sites, so the non-blocking arm is gone).  A
 * plain C read is deleted by flow.c's dead-insn pass, so retail's globals were VOLATILE in the
 * SDK source (methodology 3.12 #13 -- the block is mutated by the VSync pump).  Making just these
 * two reads volatile REPRODUCES the loads and makes BOTH callers count-EXACT, but ours then puts
 * the second one in `$v1` where retail reuses `$v0` (both are dead-on-arrival, so the qty pair
 * does not conflict and gcc still hands out two registers).  Net +1 diff each -- NOT landed.
 * MEASURED (whole-TU gated, W71-A13, on the post-R1 basin):
 *   plain (kept) ............................... Delete  5 @110/111  Create  6 @128/130
 *   both reads volatile ........................ Delete  6 @111/111  Create  7 @130/130
 *   bare `(void)*(volatile int *)&base[N];` x2 . Delete  6           Create  7
 *   only base[1] volatile ...................... Delete  7           Create  8
 *   ONE shared dead temp for both reads ........ Delete  8           Create 15
 *   read-only fence on cmd+rslt after the reads  Delete 11           Create 18
 *   identity launder on cmd+rslt ............... inert (the launder itself is dead-deleted)
 * NAMED ANGLE: a device that makes the SECOND dead load reuse the FIRST one's register (retail's
 * `$v0` twice).  Both qtys die at their own insn, so this is a local-alloc handout question --
 * the 06E instrument gap, not a spelling.
 * 🔑 W72-A18 re-measure (unchanged: plain 5/6, both-volatile 6/7) + one more falsification:
 *   the second read written INTO the first read's variable (`rslt = *(vol)&base[0]; cmd = rslt;
 *   rslt = *(vol)&base[1];`) = Delete 8 / Create 9 -- the copy is real, not free.  Together with
 *   W71's "ONE shared dead temp" (8/15) the whole variable-identity family is now closed on both
 *   callers: no C-level naming makes the two dead destinations share a hard register.
 *   SHARPENED ANGLE (from this wave's sprintf work, same mechanism family): the two dead loads'
 *   destinations are pseudos with ONE ref and no uses, so they are the same class as sprintf's
 *   movstrsi scratches -- decided by whichever of local-alloc / reload assigns them.  THE CHEAP
 *   DISCRIMINATOR (proven on sprintf this wave): drop a zero-insn hard-reg clobber FAR from the
 *   site, `__asm__("" : : "i"(0) : "$3");`, and see whether the second load moves.  If it shifts,
 *   the pair is coming from reload's `potential_reload_regs` (order_regs_for_reload, ascending
 *   over the `uses == 0 && call_used` set) and the cure is a whole-function pool question; if it
 *   does not, they are local-alloc qtys and the cure is inside the block.  One run each. */
/* 🔑 W74-A15 -- THE §22D(2) DISCRIMINATOR WAS RUN.  VERDICT: LOCAL-ALLOC, NOT THE RELOAD POOL.
 * On the post-W74 basin (DeleteFile 2 / CreateFile 6) the two reads were made volatile (which
 * restores retail's two dead loads and makes BOTH callers count-EXACT, at +1 diff each: 3 / 7)
 * and a zero-insn `__asm__("" : : "i"(0) : "$N")` clobber was dropped right after them:
 *     no clobber .. 3/7 | "$3" .. 3/7 | "$2" .. 3/7 | "$4" .. 3/7 | "$3","$4" .. 3/7 | "$8" .. 3/7
 * COMPLETELY INERT in every cell -- the second dead destination does not move.  So the pair is
 * NOT coming from reload's `potential_reload_regs` walk, and the whole-function pool angle
 * (order_regs_for_reload's ascending-uses sort) is CLOSED for this row.  They are local-alloc
 * qtys whose homes are decided inside the block, which -- with the W72 "no C-level naming makes
 * the two dead destinations share a hard register" result -- means the remaining handle is
 * local-alloc's own preference/conflict step (12A/find_reg), the same place FIRST.c's p/scan
 * certificate landed.  Keep the reads PLAIN: volatile buys count-exactness and costs +1. */
/* 🏆 W75-A18 -- THE "+1" WAS NEVER A REGISTER HANDOUT: IT WAS THE THIRD READ'S LOAD-DELAY SLOT.
 * MemCardDeleteFile SEALED PASS 111/111; MemCardCreateFile 6 -> 4 count-EXACT 130/130.
 * Five waves priced the two dead loads as a local-alloc handout problem ("make the second dead
 * load reuse $v0") and every dial was inert.  The real shape is one statement further on.
 * Retail's three consecutive reads are, in SOURCE order and all into the SAME register:
 *      lw $v0,0x0($s0)   <- cmd    (dead)
 *      lw $v0,0x4($s0)   <- rslt   (dead)
 *      lw $v0,0x8($s0)   <- the mode==0 zero-trip guard on `done`
 *      nop                          <- the guard load's own load-delay bubble
 *      bnez $v0,...
 * With only base[0]/base[1] volatile, ours emitted 0 / 8 / 4 : sched1 is free to sink the
 * PLAIN 8-load past the volatile 4-load (a volatile MEM orders only against other volatile
 * MEMs here) and then uses the 4-load to FILL the 8-load's load-delay slot -- which both
 * reorders the pair AND deletes retail's `nop`, so the second dead value has to live in $v1
 * (its range now spans the guard load's $v0).  That is the entire "+1": one insn short
 * (110/111) and a $v0/$v1 rename, neither of them an allocator decision.
 * THE CURE IS THE THIRD VOLATILE, not a dial: `*(volatile int *)&base[2]` on the zero-trip
 * guard.  All three reads are then volatile MEMs, sched1 may not reorder them, the 4-load can
 * no longer fill the 8-load's delay slot (retail's `nop` comes back), and each dead pseudo
 * dies on its own insn -> local-alloc hands all three $v0 for free.  It is also the HONEST
 * declaration: mc.cmd / mc.rslt / mc.done are all written asynchronously by the VSync pump
 * (the same MemCardStop spin-hoist bug class, catalog w48 17A), so every read of them here is
 * genuinely volatile -- the reconstruction was under-declaring two thirds of them.
 * LAW (belt-wide, new): when a volatile-vs-plain read pair reads as "+1 insn and a register
 * rename", check whether the NEXT PLAIN read of the same aggregate is eating the residual as
 * a load-delay filler before pricing anything as a register handout -- one non-volatile
 * sibling read is enough to re-order and absorb a whole volatile group.
 * FALSIFIED/priced on this landing (measured, gated): base[2] guard volatile with the two reads
 * left PLAIN -> Delete 2 / Create 6 = EXACTLY the baseline, completely INERT (with the two reads
 * plain there is nothing to keep, so ordering them buys nothing).  The three reads are ONE
 * indivisible cell -- a 23B "two-half cell", and the reason five waves of half-probes read as
 * "volatile costs +1".  cc1 LADDER on the pre-landing basin (all three fns, PER_FN_CC1_VER_SPLICE_272):
 * 2.7.2 = the lane (6/2/23), 2.7.2-970404 77/62/134, 2.8.0 86/66/166, 2.8.1 86/62/166,
 * 2.6.0 + 2.6.3 REJECT the TU ("inconsistent operand constraints in an asm", GetDirentry) --
 * the version axis is CLOSED for LIBMCRD.  Post-landing flag sweep on CreateFile
 * (PER_FN_FLAG_SPLICE_272): -fno-peephole 4, -fno-function-cse 4 (both inert),
 * -fno-schedule-insns2 18, -fno-schedule-insns 20, -fno-delayed-branch 10 (@134/130). */
static __inline__ long MemCardSyncAt(long mode, int *cmds, int *result, int *base)
{
    int rslt;
    int cmd;
    /* MATCH: anchor = &_mc_cmd; cmd/rslt/done all reached by offset from it, and sync_cmd/
     * sync_rslt (0x560/0x564, cmd+0x48/+0x4C) likewise -- one shared base for the whole fn. */
    if (base[0] == 0 && base[2] == 0)
        return -1;                          /* nothing in flight */

    /* w48-a1: the snapshot reads come AFTER the guard -- the oracle emits
     * `lw $t0,0($v1); lw $a3,4($v1)` at the .L800FBB24 join, not before the bnez. */
    cmd = *(volatile int *)&base[0];
    rslt = *(volatile int *)&base[1];

    if (mode == 0) {                        /* blocking */
        /* MATCH (w52-a6, 26 -> 7 diffs): the oracle spins on a REBASED anchor -- it zero-trip-
         * guards on `lw $v0,8($v1)`, then `addiu $v1,$v1,8` mutates the shared base IN PLACE
         * (§3.12 #14: `base` is dead in this arm, so gcc reuses its register) and the loop body
         * reads `lw $v0,0($v1)`.  That mutation is ALSO what keeps this arm's tail DISTINCT from
         * the non-blocking `done != 0` tail (which still reaches `done` as `8($v1)`): with a
         * shared `base[2] = 0;` the two byte-identical tails cross-jump-MERGE and the whole
         * blocking arm collapses -- that single statement was 24 of the 26 missing insns. */
        if (*(volatile int *)&base[2] == 0) { /* explicit zero-trip guard, as retail wrote it */
            volatile int *pdone = (volatile int *)&mc.done;
            /* the guard is EXPLICIT + the loop is bottom-tested: a plain `while` makes gcc add
             * its OWN rotation copy of the test on top of ours (double guard, +3 insns).
             * `volatile` is the same honest fix as MemCardStop's: `done` is cleared
             * ASYNCHRONOUSLY by the VSync pump, so a plain read gets hoisted and spins forever. */
            do {
                /* nothing -- wait for MemCardStart_cb to set done */
            } while (*pdone == 0);
        }
        /* MATCH: the oracle materializes each snapshot's FULL address into a register
         * (`lui; addiu; lw 0($v0)`) instead of the lane's 2-insn self-temp macro expansion
         * (`lui; lw %lo($v0)`) -- a fenced pointer local per read site is what reaches it. */
        if (result != 0) {
            int *psr = &_mc_sync_rslt;
            __asm__ __volatile__("" : "=r"(psr) : "0"(psr));
            *result = *psr;                   /* sync_rslt */
        }
        if (cmds != 0) {
            int *psc = &_mc_sync_cmd;
            *cmds = *psc;                     /* sync_cmd  */
        }
        /* W64-A4: store `done` through the SHARED (caller`s) anchor so `base` stays
         * live past the spin loop -- which is why retail materialises a FRESH pointer
         * for the spin instead of rebasing in place (the w63-a4 coupling). */
        base[2] = 0;                          /* done      */
        /* W64-A4: the standalone MemCardSync needs the cross-jump de-merger launder
         * (see its own body); the INLINED copies discard the result, so a plain
         * `return 1` is right here -- the launder emits an `li $v0,1` retail lacks.
         * Measured (helper only): laundered Create 13 / Delete 6; plain 12 / 5. */
        return 1;
    }

    /* non-blocking */
    if (base[2] == 0) {
        if (result != 0) *result = rslt;
        if (cmds   != 0) *cmds   = cmd;
        return 0;
    }
    /* same full-address materialization as the blocking arm above */
    if (result != 0) {
        int *psr = &_mc_sync_rslt;
        *result = *psr;                       /* sync_rslt */
    }
    if (cmds != 0) {
        int *psc = &_mc_sync_cmd;
        *cmds = *psc;                         /* sync_cmd  */
    }
    base[2] = 0;                              /* done      */
    return 1;
}

/* W64-A4: the STANDALONE MemCardSync keeps its own body (its own `&mc.cmd` anchor and
 * the `pdone=&base[2]` / fresh-reanchor-store pair).  It is not routed through
 * MemCardSyncAt because the two instantiations provably need opposite spellings of that
 * pair (the 2x2 matrix in the helper receipt); routing it through the helper costs this
 * function its PASS (0 -> 9).  MemCardGetDirentry / MemCardFormat / MemCardUnformat
 * still call THIS one and are unaffected (re-gated: 36 / PASS / PASS, unchanged). */
__inline__ long MemCardSync(long mode, int *cmds, int *result)
{
    int rslt;
    int cmd;
    /* MATCH: anchor = &_mc_cmd; cmd/rslt/done all reached by offset from it, and sync_cmd/
     * sync_rslt (0x560/0x564, cmd+0x48/+0x4C) likewise -- one shared base for the whole fn. */
    int *base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    if (base[0] == 0 && base[2] == 0)
        return -1;                          /* nothing in flight */

    /* w48-a1: the snapshot reads come AFTER the guard -- the oracle emits
     * `lw $t0,0($v1); lw $a3,4($v1)` at the .L800FBB24 join, not before the bnez. */
    cmd = base[0];
    rslt = base[1];

    if (mode == 0) {                        /* blocking */
        /* MATCH (w52-a6, 26 -> 7 diffs): the oracle spins on a REBASED anchor -- it zero-trip-
         * guards on `lw $v0,8($v1)`, then `addiu $v1,$v1,8` mutates the shared base IN PLACE
         * (§3.12 #14: `base` is dead in this arm, so gcc reuses its register) and the loop body
         * reads `lw $v0,0($v1)`.  That mutation is ALSO what keeps this arm's tail DISTINCT from
         * the non-blocking `done != 0` tail (which still reaches `done` as `8($v1)`): with a
         * shared `base[2] = 0;` the two byte-identical tails cross-jump-MERGE and the whole
         * blocking arm collapses -- that single statement was 24 of the 26 missing insns. */
        if (base[2] == 0) {                  /* explicit zero-trip guard, as retail wrote it */
            volatile int *pdone = (volatile int *)&base[2];
            /* the guard is EXPLICIT + the loop is bottom-tested: a plain `while` makes gcc add
             * its OWN rotation copy of the test on top of ours (double guard, +3 insns).
             * `volatile` is the same honest fix as MemCardStop's: `done` is cleared
             * ASYNCHRONOUSLY by the VSync pump, so a plain read gets hoisted and spins forever. */
            do {
                /* nothing -- wait for MemCardStart_cb to set done */
            } while (*pdone == 0);
        }
        /* MATCH: the oracle materializes each snapshot's FULL address into a register
         * (`lui; addiu; lw 0($v0)`) instead of the lane's 2-insn self-temp macro expansion
         * (`lui; lw %lo($v0)`) -- a fenced pointer local per read site is what reaches it. */
        if (result != 0) {
            int *psr = &_mc_sync_rslt;
            __asm__ __volatile__("" : "=r"(psr) : "0"(psr));
            *result = *psr;                   /* sync_rslt */
        }
        if (cmds != 0) {
            int *psc = &_mc_sync_cmd;
            __asm__ __volatile__("" : "=r"(psc) : "0"(psc));
            *cmds = *psc;                     /* sync_cmd  */
        }
        {   /* re-anchor: the oracle re-materializes &_mc_cmd here (its $v1 was consumed by the
             * spin-loop rebase above) and stores through the fresh base at +8 */
            int *reanchor = &mc.cmd;
            __asm__ __volatile__("" : "=r"(reanchor) : "0"(reanchor));
            reanchor[2] = 0;                  /* done      */
        }
        {   /* CROSS-JUMP DE-MERGER: without this the `li $v0,1` return-value setup is a common
             * suffix with the non-blocking `done != 0` tail, so gcc merges it away and this arm's
             * `j` steals the `sw zero,8($v0)` for its delay slot instead of the oracle's `li`. */
            long r = 1;
            __asm__ __volatile__("" : "=r"(r) : "0"(r));
            return r;
        }
    }

    /* non-blocking */
    if (base[2] == 0) {
        if (result != 0) *result = rslt;
        if (cmds   != 0) *cmds   = cmd;
        return 0;
    }
    /* same full-address materialization as the blocking arm above */
    if (result != 0) {
        int *psr = &_mc_sync_rslt;
        __asm__ __volatile__("" : "=r"(psr) : "0"(psr));
        *result = *psr;                       /* sync_rslt */
    }
    if (cmds != 0) {
        int *psc = &_mc_sync_cmd;
        __asm__ __volatile__("" : "=r"(psc) : "0"(psc));
        *cmds = *psc;                         /* sync_cmd  */
    }
    base[2] = 0;                              /* done      */
    return 1;
}

/* @0x800FBC18 : MemCardCreateFile -- synchronously create a `blocks`-block file. */
extern long MemCardCreateFile(long chan, char *file, long blocks)
{
    char devname[32];
    int  fd;
    int  retry;
    int  rslt;
    int *p;
    int  cmd0;
    /* MATCH (w52-a6): ONE anchor at &_mc_cmd ($s2 in retail) serves cmd/rslt/done/chan --
     * the oracle reaches _mc_chan as `lw $a2,0xC($s2)`, not with its own %hi/%lo pair. */
    /* W61-A3 68 -> 30: the MemCardDeleteFile recipe ported (read that receipt for the laws).
     * Retail band file=$s0, retry=$s1, base=$s2 (-> $s0 via the preheader copy), chan=$s3,
     * blocks=$s4, hoisted `li 2` inherits $s2.  Priced with reqdelta272 in STEPS, because
     * the second anchor re-writes the table (04Z: re-price after every structural landing):
     *   p = base (second anchor) + file fence 2 operands ......... 81  (file=$s0 only)
     *   chan +2 refs (1 operand in the loop) ..................... 65  (chan/blocks fixed)
     *   retry +6 refs (3 operands in the loop) ................... 39  (retry over base)
     *   file fence moved ABOVE the guard + `goto created` tail .... 34
     *   `if (0) { nocard: return 7; }` after the return-6 block ... 30
     * The 3rd retry operand bought exactly ONE step: at 11 refs retry priced 0.4783 against
     * base`s 0.4800 -- reqdelta272 named the +1 ref and the gate confirmed 65 -> 39.
     * FALSIFIED here (DeleteFile measures the opposite way, so A/B per function): dropping
     * the base opacity fence 39 -> 68; `p = &mc.cmd` instead of `p = base` 39 -> 60.
     * REMAINING 30: the inlined-MemCardSync anchor class (15), the `p[0]`-load-vs-
     * `_mc_save_cb`-store schedule the opaque base costs us (8; DeleteFile is free of it
     * because its base is plain), and the `li $a1,1` open() argument position. */
    int *base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    __asm__("" : : "r"(file), "r"(file));

    if (base[0] != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    MemCardMakeDevname(chan, devname);
    strcat(devname, file);
    /* W76-A18 -- PIN-SEALED (LAST RESORT under the 2026-08-23 policy): 4 -> PASS 130/130.
     * THE ROW: retail emits `addiu $a0,$sp,16 ; li $a1,1` EARLY, leaves the open() jal slot
     * EMPTY, and gas backward-fills it by SPLITTING the `sw $3,_mc_present` macro
     * (`lui $at` above, `sw $v1,%lo(_mc_present)($at)` in the slot).  Ours: reorg's
     * fill_simple_delay_slots takes `li $5,1` (the FIRST eligible candidate walking back from
     * the jal -- calls.c emits arg moves LAST, so no C statement can sit between them and the
     * call; reorg.c:3082-3125 + stop_search_p :685-712, the W75 citation).
     * FALSIFIED before this (the last-resort justification): every fence/constant-position
     * device (W71/W72/W74 lists), named-oflag forms 6-70, cc1 ladder (2.7.2-970404 77 / 2.8.0 86
     * / 2.8.1 86 / 2.6.x reject), per-fn -fno-peephole / -fno-function-cse (inert),
     * -fno-schedule-insns{,2} 18/20, -fno-delayed-branch 10 @134/130 with a >=4-diff floor
     * (target-thread steal unrecoverable by gas); PER_FN_SLOT_UNFILL_272 = post-compile rewrite,
     * FORBIDDEN by policy.  THE CELL (all three parts REQUIRED -- measured this wave:
     * pins-without-wall 4, m1-pin+wall 4, wall-only 4, full cell PASS):
     *   1. `register char *dn asm("$4") = devname` -- the address materializes at the DECL
     *      (early, retail's position), not inside expand_call;
     *   2. `register long m1 asm("$5") = 1` -- same for the mode constant;
     *   3. an output-less (volatile, sched-anchored) zero-insn asm BETWEEN the pinned sets and
     *      the RMW -- stop_search_p wall: the backward scan now dies before reaching either
     *      pinned set, the slot stays empty, and gas produces retail's macro split.
     * The pins carry values the ABI puts in those registers at the call anyway (a0/a1 = the
     * open() args); no allocation is being forced that the call itself does not force. */
    {
    char *dn = devname;
    long  m1 = 1;
    __asm__("" : "=r"(dn) : "0"(dn));
    __asm__("" : "=r"(m1) : "0"(m1));
    __asm__ __volatile__("" : : "i"(0));
    { long c = base[3]; _mc_present |= 1 << c; __asm__("" : : "r"(c)); __asm__("" : : "i"(0)); }
    fd = open(dn, m1);                           /* probe: does it already exist? */
    }
    if (fd >= 0) {
        close(fd);
        return 6;                                /* already present */
    }
    if (0) {
nocard:
        return 7;                                /* no card */
    }

    /* MATCH: retail shifts the block count IN PLACE once (`sll $s4,$s4,16`) before the loop and
     * re-uses it every iteration (`ori $a1,$s4,0x200`); recomputing `blocks << 16` inside the
     * call argument emits a fresh `sll` per pass. */
    blocks = blocks << 16;
    p = base;
    while (1) {
        fd = open(devname, (int)blocks | 0x200);   /* create */
        if (fd >= 0)
            goto created;
        /* create failed: re-accept card and inspect the result */
        /* 🏆 MATCH (W71-A13, 12 -> 6): READ p[0] BEFORE THE _mc_save_cb STORE, EXPLICITLY.
         * Retail's order is `jal MemCardCallback; lw $v1,0($s0); lui $at; blez $v1; sw $v0,%lo(..)($at)`
         * -- the command load is HOISTED ABOVE the callback store and the store fills the blez's
         * delay slot.  Ours could not reproduce that by scheduling: this function's base is
         * OPACITY-FENCED (it needs the fence for its saved-reg band, see the receipt above), so
         * `*p` MAY-ALIAS the `_mc_save_cb` store and sched1 is forbidden to move the load across it.
         * MemCardDeleteFile gets the same shape for free because its base is a plain address
         * expression (provably independent) -- that asymmetry was the standing 6-diff row.
         * THE CURE IS SOURCE-LEVEL, NOT A DIAL: write the load BEFORE the store in C (name the
         * callback result, read p[0], then store).  Order is then a data fact, not an alias
         * question, and the opaque base costs nothing.  LAW (belt-wide): when a fence's ALIAS
         * side-effect blocks a hoist the oracle performs, do the hoist in the SOURCE -- do not
         * trade the fence away (dropping it here measured 39 -> 68 in the w61 basin).
         * FALSIFIED on THIS basin (all whole-TU gated, 04Z re-probes of the w64 list):
         *   block-scoped cmd0 instead of fn-scope ............ 6 (identical -- fn-scope kept)
         *   the same explicit hoist applied to DeleteFile too . inert (5, its base is plain)
         *   named `oflag = 1;` before the RMW / after `retry = 0` (for the `li $a1,1` row)  6, inert
         *   the same laundered (identity fence on oflag) ...... 16  (cse const-props a plain
         *                                                       named constant straight back;
         *                                                       the fence's barrier costs 10)
         *   volatile snapshot reads in MemCardSyncAt (for the two dead `lw`s)  7 / Delete 6 */
        /* 🔑 W72-A18 -- THE `li $a1,1` ROW IS NOT A CONSTANT-POSITION QUESTION; IT IS THE
         * AT-MACRO SPLIT.  The two streams side by side name it (the open() probe site above):
         *   retail  addiu $a0,$sp,16 ; li $a1,1 ; li $v0,1 ; lw $a2,0xC($s2) ; lui $v1 ; lw $v1
         *           ; sllv ; or ; lui $at ; JAL open ; sw $v1,0($at)  <- the _mc_present store's
         *           SECOND macro half fills the call's delay slot
         *   ours    addiu $a0,$sp,16 ; li $v0,1 ; ... ; lui $at ; sw $v1,0($at) ; JAL open ;
         *           li $a1,1                                   <- reorg took the arg constant,
         *           because our store macro was already COMPLETE before the branch
         * i.e. the flag constant is not "late": it is the only filler LEFT once the store macro
         * is emitted whole.  Retail's build split `sw $3,_mc_present` across the jal (the w48-a5
         * AT-MACRO-SPLIT-ACROSS-BRANCH class), which consumed the slot and let the `li` emit
         * early and naturally.  FALSIFIED THIS WAVE on top of W71's list (all whole-TU gated,
         * restored): a named `oflag` assigned before the RMW + a READ-ONLY fence right after it
         * 8 | the same with the fence after the RMW 8 | THREE identity launders (the 07B
         * bare-constant step) 16 | assigned before `strcat`, no fence 6 (inert) | assigned
         * before `strcat` WITH a read-only fence 70 (the barrier walls off the whole arg block).
         * ==> no constant-position or fence device reaches it, because the row lives on the
         * assembler/macro side, not the value side.  Route: the same maspsx GNU-as-reorder-mode
         * option that owns the rest of the w48 class-5 family. */
        /* 🔑 W74-A15 -- W72's ROUTE LINE IS WRONG AND THE REAL BLOCKER IS NAMED + BYTE-PROVEN.
         * There is NO maspsx in this TU: LIBMCRD.c is wired `cc1_272`, and _compile_c_272 IS
         * "PsyQ 4.0 CC1PSX + GNU as in default reorder mode, no maspsx".  So the vendor-build
         * identity route W72 asked for is ALREADY THE LANE, and GNU as ALREADY splits the store
         * macro across a branch when the slot is empty -- the AT-MACRO-SPLIT is not the missing
         * piece.  THE MISSING PIECE IS ONE LINE OF cc1's OWN OUTPUT.  Read it (build/recon/
         * syslib/psx/libmcrd/LIBMCRD.c.s, MemCardCreateFile):
         *      sw    $3,_mc_present            <- the RMW store, still a MACRO
         *      .set noreorder / .set nomacro
         *      jal   open
         *      li    $5,0x00000001             <- reorg filled the slot ITSELF
         *      .set macro / .set reorder
         * gas therefore expands the sw macro WHOLE, before the (already-full) jal.  Retail's
         * build left that one slot EMPTY, and gas then backward-filled it by SPLITTING the
         * macro: `lui $at` before the jal, `sw $v1,%lo(_mc_present)($at)` in the slot.
         * WHY reorg picks `li $5,1`: fill_simple_delay_slots scans back from the call; the sw is
         * rejected because mark_referenced_resources(CALL, include_delayed_effects=1) sets
         * res->memory, and every insn between the `li $5,1` and the call belongs to the RMW
         * chain (each one's result is consumed by the next), so `li $5,1` is the FIRST movable
         * candidate.  Retail's reorg would make the same choice -- ergo retail's cc1 did not run
         * the fill for this call.
         * 🏆 BYTE PROOF that the assembler half needs no work at all: with `-fno-delayed-branch`
         * spliced onto this ONE function the object comes out
         *      11e4 addiu a0,sp,16 / 11e8 li a1,1 / ... / 1204 lui at,%hi(_mc_present)
         *      1208 jal open / 120c sw v1,%lo(_mc_present)(at)
         * = retail's words exactly, and the 4-diff `li $a1,1` row VANISHES from the gate.
         * IT IS NOT LANDED because the flag is whole-function: it also unfills three slots cc1
         * legitimately fills for retail (`addu $s1,$0,$0` in the busy-guard's beqz, `sll $20,
         * $20,16` in the bltz, `addiu $a0,$sp,16`), so the gate goes 6 -> 12 (@132/130).  Same
         * measurement on the siblings: DeleteFile 5 -> 9, GetDirentry 24 -> 39.
         * 🔴 SPEC (build.py, one new mechanism -- the exact analogue of the existing
         * `_apply_epilogue_unfill_272`, which already un-fills a slot by rewriting cc1's text):
         *      PER_FN_SLOT_UNFILL_272 = {rel: {fn: [<regex matching the noreorder block>]}}
         *   applied to the 272 lane's `txt` after the flag/version splices, rewriting
         *      \t.set\tnoreorder\n\t.set\tnomacro\n\tjal\topen\n(\tli\t\$5,[^\n]*\n)\t.set\tmacro\n\t.set\treorder\n
         *   into  <the captured filler line> + "\tjal\topen\n"  (reorder mode, empty slot).
         *   gas then does the rest.  EXPECTED 6 -> 2 (the two dead snapshot loads only).
         *   The alternative -- `-fno-delayed-branch` + three PER_FN_TEXT_MOVES rows to put the
         *   other three slots back (the w60-a2 MemCardFormat recipe) -- reaches the same place
         *   with four table rows instead of one; prefer the unfill.
         * (Also measured this wave and INERT here: per-fn `-G4` and `-G8` flag splices -- §22A(5)'s
         * mips_check_split small-data gate is a 2.8-rung property; 2.7.2 has no address
         * pre-splitting at all, so the -G dial has nothing to gate.  Cross it off for this TU.) */
        /* 🔴 W75-A18 -- THE W74 SPEC IS *NOT* BUILT, ON PURPOSE, AND THE `-fno-delayed-branch`
         * ALTERNATIVE IS NOW PROVEN UNREACHABLE.  Read both halves before re-opening this row.
         * (i) POLICY.  Commit 75be7d4c ("Restore exact SYM graph for textureprocess without
         *     rewrites") records the user policy of 2026-08-23: POST-RECOMPILE INSTRUCTION
         *     REWRITES ARE FORBIDDEN -- PER_FN_RA_SINK was emptied for it and the concurrent
         *     working copy is removing PER_FN_TEXT_MOVES rows (psxcontroller) for the same
         *     reason.  PER_FN_SLOT_UNFILL_272 is exactly that class (it deletes an instruction
         *     cc1 emitted and re-emits it above the branch), so it was NOT wired.  Wiring it is
         *     a USER CALL, not a belt call.  Everything else about the spec still holds:
         *     the `-fno-delayed-branch` byte-proof in the W74 block above is real.
         * (ii) THE FOUR-ROW ALTERNATIVE IS DEAD ANYWAY (measured on the post-volatile basin).
         *     `-fno-delayed-branch` spliced onto this fn alone now gives 10 @134/130, and its
         *     four missing insns are THREE distinct slot classes, not one:
         *        beq(busy-guard) slot   nop vs `addu $s1,$0,$0`   -- gas CAN backward-fill this
         *                                                            (move `retry = 0` above the
         *                                                            guard)
         *        bltz(probe) slot       nop vs `sll $20,$20,16`   -- gas CAN backward-fill
         *        beq(rslt==3) slot      nop vs `addiu $a0,$sp,16` -- 🔴 gas CAN NEVER DO THIS.
         *     The third is reorg's EAGER TARGET-THREAD STEAL: retail's `beq $3,$v0,.L800FBCDC`
         *     jumps PAST the `addiu $a0,$sp,0x10` and carries it in the slot, i.e. the insn comes
         *     from the branch's TARGET side and the branch is re-pointed to a label one insn
         *     later.  GNU as only ever fills backwards from the preceding instruction (w48 04K,
         *     re-confirmed) so under -fno-delayed-branch that fill is structurally lost.
         *     ⇒ the -fno-delayed-branch route's floor is >= 4 diffs = the row it was meant to buy.
         * (iii) WHY NO SOURCE FENCE REACHES IT (reorg.c, cited).  fill_simple_delay_slots starts
         *     its backward scan at `prev_nonnote_insn(jal)` and takes the FIRST eligible trial
         *     (reorg.c:3082-3125); stop_search_p (:685-712) fires at any asm, but an asm can only
         *     be placed BEFORE the argument-register moves in C -- calls.c emits those moves last,
         *     inside expand_call -- so the scan always meets `li $5,1` before any fence.  A fence
         *     can only BLOCK theft, and here there is nothing to block it WITH (13B).  Falsified
         *     this wave on top of the W71/W72/W74 lists: cc1 LADDER (2.7.2-970404 77, 2.8.0 86,
         *     2.8.1 86, 2.6.x reject the TU) and per-fn flag splices -fno-peephole 4 (inert),
         *     -fno-function-cse 4 (inert), -fno-schedule-insns2 18, -fno-schedule-insns 20.
         * ⇒ STATUS: 4 diffs, count-EXACT 130/130, ONE named row, blocked on a USER POLICY
         *   DECISION rather than on a missing lever. */
        {
            int prevcb = (int)MemCardCallback(0);
            cmd0 = p[0];
            _mc_save_cb = (int (*)(int, int))prevcb;
        }
        /* MATCH (w52-a6): retail's guard is `blez $v1` -- the PRINTF is the FALL-THROUGH arm and
         * the command-latch block is the out-of-line branch target, i.e. the test is written the
         * other way round from the natural `if (cmd < 1)`.  The latch reaches cmd/rslt/done through
         * a SECOND anchor ($s0, a copy of the base) while _mc_chan keeps its own `lui $at` macro.
         * MEASURED (w52-a6 AND RE-MEASURED w53-a7 in the post-split-storage basin -- same verdict):
         * retail also keeps the command code 2 in a register that the `rslt != 2` test below
         * re-uses (`addu $s0,$s3,$zero; li $s3,2` -- the base HANDS OVER to another saved reg so
         * $s3 can hold the 2), but spelling that as a named `cmdCode` local is WORSE
         * (w52: CreateFile 68->84, DeleteFile 58->64; w53 re-measure: DeleteFile 57->63, +2
         * insns) -- cse already shares the literal and the named local rotates the saved-reg
         * band the wrong way.  NAMED ANGLE: the residual on both fns is exactly that saved-reg
         * rotation (retail chan=$s2/file=$s0/base=$s3->$s0; ours chan=$s3/file=$s2/base=$s0). */
        if (cmd0 > 0) {
            printf("Access Denied. : event multiple open\n");
        } else {
            p[0] = 2;
            p[1] = 0;
            p[2] = 0;
            mc.chan = chan;
            __asm__("" : : "r"(chan));
            UserFuncOpen((int)MemCardCmd_cb);
        }
        MemCardSyncAt(0, 0, &rslt, p);
        MemCardCallback((int)_mc_save_cb);

        if (rslt == 0)
            goto nocard;
        if (rslt == 3)
            continue;                            /* new card -> retry */
        if (rslt != 2)
            break;
        retry = retry + 1;
        __asm__("" : : "r"(retry), "r"(retry), "r"(retry));
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;
    return rslt;

created:
    close(fd);
    return 0;
}

/* @0x800FBE20 : MemCardDeleteFile -- synchronously erase a named file. */
extern long MemCardDeleteFile(long chan, char *file)
{
    char devname[32];
    int  retry;
    int  rslt;
    McState *p;
    /* w53-a7: NO fence on this base here (unlike CreateFile).  The fence makes the pointer
     * opaque, so gcc can no longer prove it equals the &_mc_cmd the INLINED MemCardSync
     * materializes below -- retail shares ONE register ($s0) across the caller's field stores
     * AND the whole inlined sync body (`lw $v1,0($s0)` ... `lw $v0,8($s0)`), which only happens
     * when the caller's base is a plain address expression.  Measured: no fence 57 / non-volatile
     * 57 / volatile 60.  (CreateFile measures the opposite way -- volatile 68 / plain 70 / none
     * 81 -- so A/B per function.)
     * 🔴 w60-a2 FALSIFIED -- the floor_log2 REF-STEP dial that cracked MemCardCmd_cb's $s0/$s1
     * W61-A3: THE w60-A2 NAMED ANGLE IS CLOSED -- 57 -> 23.  The "a three-way rotation
     * cannot be expressed by a single-pseudo delta" verdict was true and beside the point:
     * a rotation is a TOTAL ORDER, so dial every pseudo that has to move, at once, and
     * price it with tools/reqdelta272.py (the real 2.7.2 rule pri = floor_log2(refs)*refs
     * / live -- NO size term; the old gcc-2.8 pricing was wrong on this lane).  Retail order
     * file > retry > chan > base, predicted handout == measured handout (qty272.py):
     *   file  refs 2 -> 4  (2 fence operands)              pri 0.222 -> 0.889  -> $s0
     *   retry refs 7 -> 9  (1 operand INSIDE the loop, x2) pri 0.241 -> 0.466  -> $s1
     *   chan  refs 4 -> 8  (2 operands INSIDE the loop)    pri 0.131 -> 0.393  -> $s2
     *   base  untouched                                    pri 0.246          -> $s3
     * (57 -> 47 on this step alone.)
     *
     * The `file` fence sits ABOVE the busy guard on purpose.  There it ALSO forces
     * assign_parms` file copy into the prologue group (retail`s `sw $s0,56($sp);
     * addu $s0,$a1,$zero`) instead of leaving it the last insn before the guard load, where
     * reorg steals it into the `beqz` slot and retail`s `retry = 0` can never land there.
     * Same fence, same operand count, 6 diffs apart, purely by POSITION (29 -> 23).
     *
     * SECOND ANCHOR (47 -> 37 -> 34): retail runs the head guard off one materialization
     * ($s3) and hands it to a SECOND pointer ($s0, `addu $s0,$s3,$zero` in the loop
     * preheader, which frees $s3 for the hoisted `li 2`).  A PLAIN `p = base;` reproduces
     * it -- cse2-after-loop rewrites the hoisted `&mc.cmd` as a reg COPY of the live base.
     * An opacity fence on `p` is WORSE (37 vs 34): it makes `*p` may-alias `_mc_save_cb`,
     * so sched1 can no longer hoist retail`s `lw $v1,0($s0)` above that store.  Cost of the
     * plain form: `p[3]` is a LOAD at a non-zero offset through a known-constant pointer,
     * so cse constant-folds it back to the `lui;lw` macro (2 of the remaining 23).  STORES
     * at non-zero offsets do NOT fold, which is why p[0..2] stay base-relative.
     *
     * EXIT-BLOCK PLACEMENT, catalog 12C (34 -> 29): retail`s `erase() != 0` success block is
     * the LAST block before the epilogue (`j <epi>; nop`, then a bare `addu $v0,$zero,$zero`
     * falling into it).  Written inline in the loop, gcc emits it right after the busy-return
     * block and displaces `retry = 0`.  `goto erased;` + the block placed after `return rslt;`
     * is the zero-cost fix.
     *
     * REMAINING 23 = the inlined-MemCardSync anchor class (15, see that fn`s receipt) + the
     * p[3] fold (2) + tail scheduling.  FALSIFIED in this basin: retry fence moved out of
     * the loop (29, inert); MemCardSync`s base fence dropped (42) or made non-volatile
     * (identical); a shared `static __inline__ int *mc_anchor(void)` so both fences share ONE
     * source line (48 -- see MemCardSync). */
    /* 🔑 W71-A13 -- THE `p[3]` FOLD IS A LANE PROPERTY, MECHANISM NAMED (re-gated at 5 @110/111).
     * The residual is exactly two rows:
     *   (a) `_mc_present |= 1 << p[3]`: ours `lui $a0,%hi(mc+12); lw $a0,%lo(..)($a0)` (2 insns),
     *       retail `lw $a0,0xC($s0)` (1) -- 3 diffs.
     *   (b) retail`s two DEAD snapshot loads `lw $v0,0($s0); lw $v0,4($s0)` inside the inlined
     *       MemCardSyncAt (see that fn`s receipt) -- 2 diffs, and they are why ours is 1 SHORT.
     * MECHANISM of (a) (read off the cc1 `.s`, not guessed): cse folds a MEM whose address is
     * `(plus (reg-with-a-known-constant-equivalent) (const_int N))` -- simplify_binary_operation
     * turns it into a CONSTANT address and validate_change accepts it because on the cc1_272 lane
     * a bare symbolic address IS a legitimate MIPS address (the `lw $r,sym+N` assembler macro;
     * gcc-2.7.2 has no -msplit-addresses).  An OFFSET-0 load has no PLUS to simplify, which is why
     * `p[0]` (`lw $v1,0($s0)`) and every non-zero-offset STORE stay base-relative.  Retail`s
     * base-relative `lw $a0,0xC($s0)` therefore requires the fold to be REJECTED, i.e. a build
     * where a symbolic address is NOT legitimate = -msplit-addresses = the 2.8 lane.
     * MEASURED (in-memory PER_TU hook, no build.py edit): whole-TU cc1_272:false (2.8 lane) gives
     * DeleteFile 38 @111/111 and CreateFile 71 -- the lane swap fixes THIS row and loses the TU,
     * so it is an orchestrator-level per-fn wiring question (PER_FN_CC1_VER_SPLICE), not source.
     * FALSIFIED HERE (all whole-TU gated, this basin): `*(volatile int *)&p[3]` 5 (inert -- cse
     * folds the ADDRESS before volatility matters); `((McState *)p)->chan` 5 (inert); `mc.chan`
     * 5 (inert); `_mc_present |= 1 << base[3]` before `p = base` 5 (inert); identity fence on
     * `p` 21; block-local fenced `pc` copy of p 29; fenced `pc` taken from `base` 17.  The only
     * device that reaches it (an opaque pointer, as MemCardCreateFile uses) costs more than the
     * row: it makes `*p` may-alias `_mc_save_cb` and loses the load hoist -- see CreateFile.
     * 🔑 W72-A18: re-gated 5 @110/111.  ONE STATED ESCAPE FALSIFIED + ONE LANE VERDICT MEASURED.
     *   (a) The W71 mechanism note ends "an OFFSET-0 load has no PLUS to simplify, which is why
     *       `p[0]` stays base-relative" -- and therefore predicts that routing the chan read
     *       through a zero-offset pointer escapes the fold.  IT DOES NOT: `{int *q = p + 3;
     *       ... 1 << *q;}` = 5 (inert) and `{int *q = (int*)((char*)p + 12); ... 1 << q[0];}` = 5
     *       (inert).  cse propagates the pointer's own known-constant equivalent INTO the
     *       zero-offset MEM before the address is ever a PLUS, so the offset-0 exemption is a
     *       property of the ORIGINAL `p[0]` expression's cse history, not a reachable spelling.
     *       Cross the whole "spell it as offset 0" family off.
     *   (b) The 2.8-lane per-fn splice named in the W71 note was MEASURED this wave and is NOT
     *       the cure: `PER_FN_CC1_VER_SPLICE_272 {"2.8.0": {"MemCardDeleteFile"}}` (in-memory
     *       hook, tools/vprobe.py W61_TABLE) gives 62 diffs @111/111 -- count-exact but a
     *       completely different saved-reg band (s5/s4 appear, the whole prologue rotates).
     *       The lane swap fixes the 3-diff fold row and loses ~60 elsewhere.  So the standing
     *       "needs the 2.8-lane per-fn splice" spec is RETIRED as written; if it is ever revived
     *       it has to come with the band re-dialled in the 2.8 basin, i.e. it is a from-scratch
     *       re-match of the function, not a wiring line. */
    /* 🏆 W74-A15 -- THE `p[3]` FOLD IS CLOSED: 5 -> 2, count 109/111, zero regressions.
     * The W71/W72 receipts above are right that the cure needs an OPAQUE pointer (only that
     * defeats cse's known-constant address fold) and right that every prior opaque form cost
     * MORE than the row -- but they priced the fence against the WRONG second variable.  The
     * fence's real cost here was never the opacity; it was the ALIAS CHAIN: with `p` opaque and
     * every access spelled `p[N]` (an int-subscript through a cast pointer), the MEMs carry
     * MEM_IN_STRUCT_P == 0, so they alias-chain to the scalar `_mc_save_cb` store and sched1
     * loses retail's `lw $v1,0($s0)`-above-the-store hoist (that is the whole 21-diff identity
     * fence measurement in the W71 list).
     * THE FIX = §22C(3) MEM_IN_STRUCT_P ALIAS DIAL, applied TOGETHER with the fence: declare `p`
     * as the real `McState *` and spell every access as a COMPONENT_REF (`p->cmd`, `p->rslt`,
     * `p->done`, `p->chan`).  A COMPONENT_REF sets /s on the MEM, which un-chains it from the
     * scalar, so the hoist survives the fence -- and the fence still defeats the fold, so
     * `lw $a0,0xC($s0)` comes out base-relative exactly like retail.
     * MEASURED THIS WAVE (all whole-TU gated, 2x):
     *   COMPONENT_REFs + identity fence ....... 2 @109/111   <- LANDED
     *   COMPONENT_REFs, no fence .............. 5  (fold returns)
     *   COMPONENT_REFs + read-only fence ...... 5  (pc's value still known -> fold returns)
     *   int* p + identity fence (W71's form) .. 21
     *   chan read only via a fenced McState* q  29 / via a fenced `&mc.chan` int* .. 17
     *   chan read via a COMPONENT_REF with the fence still on the int* p ........... 8
     * ==> 🔴 LAW (belt-wide): an OPACITY FENCE AND THE ACCESS SPELLING ARE ONE DEVICE, not two.
     * When a fence buys the codegen you want but "costs more elsewhere", check whether the cost
     * is an ALIAS cost before pricing the fence away -- convert the accesses to COMPONENT_REFs
     * and re-price.  (Cross-basin cell, §22C(8): each half alone is neutral or worse.)
     * The 2.8-lane spec above stays RETIRED -- this reaches the row with no wiring at all.
     * REMAINING 2 = retail's two DEAD snapshot loads inside the inlined MemCardSyncAt; see that
     * function's receipt (W74-A15 ran the §22D(2) reload-pool discriminator there: INERT). */
    int *base = &mc.cmd;
    __asm__("" : : "r"(file), "r"(file));

    if (base[0] != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    MemCardMakeDevname(chan, devname);
    strcat(devname, file);
    /* W74-A15: opaque `p` (defeats the cse address fold) + COMPONENT_REF accesses (keeps the
     * MEM /s so the fence does not alias-chain them to `_mc_save_cb`).  Both halves required. */
    p = (McState *)base;
    __asm__("" : "=r"(p) : "0"(p));
    _mc_present |= 1 << p->chan;

    while (1) {
        rslt = erase(devname);          /* retail stores the result in the `rslt` stack slot
                                         * (`bnez $v0,...; sw $v0,0x30($sp)` -- the store is the
                                         * branch's delay slot, so it is unconditional) */
        if (rslt != 0)
            goto erased;
        /* erase failed: re-accept card and inspect the result */
        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
        /* MATCH (w52-a6): retail's guard is `blez $v1` -- the PRINTF is the FALL-THROUGH arm and
         * the command-latch block is the out-of-line branch target, i.e. the test is written the
         * other way round from the natural `if (cmd < 1)`.  The latch reaches cmd/rslt/done through
         * a SECOND anchor ($s0, a copy of the base) while _mc_chan keeps its own `lui $at` macro.
         * MEASURED (w52-a6 AND RE-MEASURED w53-a7 in the post-split-storage basin -- same verdict):
         * retail also keeps the command code 2 in a register that the `rslt != 2` test below
         * re-uses (`addu $s0,$s3,$zero; li $s3,2` -- the base HANDS OVER to another saved reg so
         * $s3 can hold the 2), but spelling that as a named `cmdCode` local is WORSE
         * (w52: CreateFile 68->84, DeleteFile 58->64; w53 re-measure: DeleteFile 57->63, +2
         * insns) -- cse already shares the literal and the named local rotates the saved-reg
         * band the wrong way.  NAMED ANGLE: the residual on both fns is exactly that saved-reg
         * rotation (retail chan=$s2/file=$s0/base=$s3->$s0; ours chan=$s3/file=$s2/base=$s0). */
        if (p->cmd > 0) {
            printf("Access Denied. : event multiple open\n");
        } else {
            p->cmd = 2;
            p->rslt = 0;
            p->done = 0;
            mc.chan = chan;
            UserFuncOpen((int)MemCardCmd_cb);
        }
        MemCardSyncAt(0, 0, &rslt, (int *)p);
        MemCardCallback((int)_mc_save_cb);

        if (rslt == 3)
            continue;
        if (rslt != 2)
            break;
        retry = retry + 1;
        __asm__("" : : "r"(retry));
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;
    return rslt;

erased:
    return 0;
}

/* @0x800FBFDC : MemCardFormat -- synchronously format the card on chan. */
extern long MemCardFormat(long chan)
{
    char devname[64];
    int  ev;
    /* SOURCE-ONLY (2026-08-27): `chan - chan` is a pure-C zero-offset opacity
     * carrier.  It preserves the retail one-register McState anchor exactly,
     * while removing the former volatile empty-asm fence.  A plain `&mc`
     * lets CSE split cmd/chan back into independent symbol accesses (15 diffs). */
    McState *base = (McState *)((char *)&mc + chan - chan);

    if (base->cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    /* MATCH-ANGLE (w52-a6, 4-diff residual, count-exact 35/35): the sole residual is WHICH insn
     * GNU-as backward-fills into the `jal MemCardMakeDevname` delay slot.  Retail's cc1 emitted the
     * arg pointer `addiu $a1,$sp,0x10` BEFORE the `_mc_present` store macro, so as split the macro
     * across the branch (`lui $at,%hi` before the jal, `sw $v1,%lo($at)` in the slot) -- the
     * AT-MACRO-SPLIT identity of the 2.7.2 lane.  Ours emits the store macro first and the arg
     * `addiu` last, so as fills with the `addiu` instead.  Falsified this wave (2.7.2 lane):
     *   precomputed named pointer `char *dn = devname;` .......... 34 (forces $s0 + a frame save --
     *                                                                 SCHED_GROUP'd out too far)
     *   split RMW + read-only fence `"r"(devname)` between ....... 22 (materializes &devname into
     *                                                                 its own saved reg, +4 insns)
     * NAMED ANGLE: what is needed is a ZERO-INSN way to make the arg `addiu` issue before the store
     * macro (a sched-position fixpoint fence placed between them, or a statement whose value the
     * arg address CSEs with) -- not a named pointer, which changes the arg's register class.
     * w55-a7 additional falsifications (2.7.2 lane): named `char *dn = devname;` assigned right
     * before the RMW = 34 (dn takes $s0 + a frame save); the same with an identity fence on `dn`
     * = 21/36 (dn materializes into $a2, whole head recolors); moving the old `base` opacity fence
     * BELOW the guard (the lever that sealed Exist/Accept) = 5/36 -- here the guard READ wants the
     * register base too.  The pure-C zero-offset anchor above now supplies that same shape without
     * a scheduling barrier.  Per w46, the arg is not precomputed
     * because `(plus (reg sp) (const_int 16))` has rtx_cost <= 2, so it is SCHED_GROUP'd onto the
     * CALL_INSN and can only be displaced by making the STORE the later insn. */
    MemCardMakeDevname((_mc_present |= 1 << base->chan, chan), devname);
    _clr_card_event();
    format(devname);
    ev = _get_card_event_x();
    return MemCardEventToRslt(ev);
}

/* @0x800FC068 : MemCardUnformat -- low-level "unformat" by writing 0xFF blocks 0..14. */
extern long MemCardUnformat(long chan)
{
    signed char buf[128];
    signed char fill;
    int  blk;
    long c;
    int *base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));

    if (base[0] != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    /* 🔴 w52-a6 CORRECTNESS FIX (read the oracle, not the intent): the failure test is on
     * `_get_card_event_x()`, NOT on `_card_write()` -- the oracle IGNORES _card_write's $v0 and
     * branches on the event returned by the following `jal _get_card_event_x` (`bnez $v0` ->
     * `return 0`), with `blk++` in that branch's DELAY SLOT (i.e. unconditional, §3.1).  The old
     * body tested the wrong call and discarded the event, so an unformat that failed mid-way
     * reported success and a write that merely queued was treated as fatal.
     * MATCH: the fill loop counts DOWN (`addiu $s0,$s0,-1; bgez` off a walking `addiu $v0,$v0,-1`
     * pointer seeded at `&buf[127]` = `$sp+0x8F`) and stores the byte as -1, not 0xFF
     * (`addiu $v1,$zero,-1`; a 0xFF constant on this unsigned-char build emits `li 255`). */
    /* 🏆 MATCH (w60-a2, 3 -> PASS 45/45): THE OUT-OF-LINE RETURN-0 BLOCK, placed HERE.
     * Retail's failure exit is a standalone 2-insn block sitting between the busy-guard's
     * `return -1` and the fill loop -- `.L800FC0A4: j <epilogue>; addu $v0,$zero,$zero`
     * (the zero IS the j's delay slot) -- and the loop's `bnez $v0,.L800FC0A4` fills its OWN
     * slot with the unconditional `addiu $s0,$s0,1`.  Ours had no such block: with the
     * `return 0;` written inline in the loop, gcc laid its landing pad directly ON the
     * epilogue, the `j` folded away, and reorg then STOLE the bare `addu $v0,$zero,$zero`
     * into the bnez slot (1 insn shorter than retail, 3 diffs).
     * MECHANISM (why placement is the whole lever): reorg processes the unconditional `j`
     * FIRST and fills its slot with the preceding `addu`, turning the block into a SEQUENCE;
     * `stop_search_p` then refuses to search a thread that starts with a SEQUENCE/JUMP_INSN,
     * so the later `bnez` can no longer steal from it and falls back to a plain backward fill
     * (the `blk++`).  A landing pad ADJACENT to the epilogue has no `j` to protect it.  The
     * `if (0) { failed: ... }` wrapper is a ZERO-INSN placement device -- gcc drops the dead
     * branch but keeps the labelled block at THIS point in the RTL, which is exactly the
     * "zero-insn de-merger that is NOT a scheduling barrier" the w52-a6 named angle asked
     * for.  (The falsified alternatives are receipted at the `goto failed` below.)
     * DO NOT "simplify" this back to an inline `return 0;` -- it silently re-merges. */
    if (0) {
failed:
        return 0;
    }

    /* the parm copy is retail's beqz DELAY-SLOT filler (eager steal of the guard target's
     * first insn), not a prologue copy -- an opacity-fenced copy at the block head sinks it */
    c = chan;

    /* ONE counter serves both loops (retail keeps both in $s0) -- a separate `i` gets its own
     * caller-saved pseudo and the fill loop then runs in $v1 instead.
     * MATCH (w60-a2, 5 -> 3): the fill BYTE is a NAMED LOCAL assigned before the loop, not the
     * literal `buf[blk] = -1`.  Retail materializes the -1 BEFORE the counter
     * (`addiu $v1,$zero,-1; addiu $s0,$zero,0x7F`); with the literal in the loop body the -1 is
     * a loop INVARIANT that loop.c hoists into the preheader AFTER the for-init, giving the
     * reversed `li $s0,127; li $v1,-1` (2 diffs).  A plain preceding assignment emits it as an
     * ordinary statement, i.e. first. */
    fill = -1;
    for (blk = 127; blk >= 0; blk--)
        buf[blk] = fill;

    blk = 0;
    do {
        _clr_card_event();
        _new_card();
        _card_write(c, blk, buf);
        /* the failure exit jumps to the out-of-line `failed:` block placed ABOVE (see the big
         * receipt there -- that placement is what puts retail's `addiu $s0,$s0,1` in this
         * bnez's delay slot instead of an eager-stolen return-0).  Falsified w52-a6 in the
         * inline-`return 0` basin, kept for the record:
         *   opacity-fenced `long r = 0; return r;` ....... 7 (block materializes but the
         *                                                    fence barrier nops the j slot)
         *   increment written BEFORE the test ............ 8 (43 insns, loses 2 elsewhere)
         * w60-a2 additionally falsified, all in the post-`fill` 3-diff basin, all 272 lane:
         *   -fno-delayed-branch splice ................... 12   -fno-strength-reduce ..... 11
         *   -fno-schedule-insns2 splice ..................  7   -fno-schedule-insns ......  3
         *   -fno-thread-jumps ............................  3 */
        if (_get_card_event_x() != 0)
            goto failed;
        blk = blk + 1;
    } while (blk < 0xf);
    return 1;
}

/* @0x800FC11C : translate a raw card event-class index into a libmcrd result code. */
static uint MemCardEventToRslt(uint ev)
{
    uint r = 0;
    if (ev == 1)
        goto is_one;
    if ((int)ev < 2) {                  /* ev == 0 */
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
    goto done;
is_one:
    r = 2;
done:
    return r;
}

/* @0x800FC170 : VSync pump -- step the queued FSM; on drain, latch result + fire user callback. */
static void MemCardStart_cb(void)
{
    int *base;
    int *snap;
    int  one;
    int  cmdv;
    int (*cb)(int, int);

    if (UserFuncComplete() != 0)        /* stack already empty -> nothing pending */
        return;
    UserFuncExecute();
    if (UserFuncComplete() == 0)        /* still busy -> wait for the next frame */
        return;

    /* command finished this frame.
     * MATCH (w53-a7): ONE anchor at &_mc_cmd ($v1) reaches done(+8), cmd(+0), rslt(+4) AND the
     * user callback (+64 = _mc_callback), and ONE anchor at &_mc_sync ($a1) reaches both snapshot
     * words (+0/+4).  🔴 The `rslt = 0` store is UNCONDITIONAL in retail -- it sits in the
     * `beqz $a2` DELAY SLOT (§3.1), so it executes whether or not a user callback is installed;
     * the old recon had it inside the `if`, leaving a stale result behind on the no-callback path.
     * 33 -> 22 diffs, count now EXACT 33/33; the `one` opacity temp lands the constant AS THE
     * BLOCK'S FIRST INSN (GNU-as then eager-steals it into the `beqz` slot, killing our +1 nop).
     * 🏆 w55-a7 SEALED: 22 -> PASS 33/33.  The w52/w53 "make `base` a GLOBAL allocno" angle filed
     * here was WRONG -- it was executed properly and does not crack it (receipts below).  The 22
     * were ONE v0<->v1 swap (retail base=$v1 / value-temps=$v0; ours base=$v0 / temps=$v1,$a0) and
     * the swap was DOWNSTREAM of a scheduling defect that cost a second value register:
     *   retail emits `sw $v0,8($v1)` (done=1) BEFORE `lw $v0,0($v1)` (cmd), so the `one` qty dies
     *   at the store and the cmd load REUSES $v0 -- retail needs exactly ONE value register,
     *   leaving $v1 for base.  Our sched hoisted the cmd load ABOVE the done store (using the
     *   store to fill the load's own delay slot), so `one` and cmd were simultaneously live and
     *   burned $v1 + $a0, pushing base to $v0.
     * THE THREE-PART CURE (all zero-insn, each one measured necessary):
     *   (1) THREE identity fences on `one` (4 -> 8 refs = one floor_log2 REF step) so the constant
     *       qty outranks the base qty in `QTY_CMP_PRI` and takes $v0.  With ONE fence: 22.
     *       With three: 6.  (Same QTY-layer ref-step dial as the Read/WriteFile_cb `five` block.)
     *   (2) a named `cmdv = base[0];` temp, so the cmd load is its own statement, plus
     *   (3) a zero-insn VOID-TAIL BARRIER `__asm__ __volatile__("" : : "i"(0));` placed AFTER that
     *       load and BEFORE the snap block.  Barrier position is the whole dial: BEFORE the load
     *       it fixes the store/load order but the load-delay slot goes `nop` (3 diffs, 34 insns,
     *       because the snap `lui/addiu` -- retail's filler for that slot -- stays hoisted above
     *       the load); AFTER the load it also pins the snap address BELOW the load, which both
     *       fills the slot and drops the nop.  A barrier in BOTH places is equivalent (measured
     *       PASS either way); the one after the load is the load-bearing one.
     * FALSIFIED (kept so nobody re-fights them):
     *   05D GLOBAL-ALLOCNO PROMOTION of `base`, done properly -- define it in the SECOND guard
     *   block AFTER that block's last `jal` (`busy = UserFuncComplete(); base = &mc.cmd; fence;
     *   if (busy == 0) return;`): zero insns, no call crossed, `base` really does become a global
     *   allocno -- and it moves $v0 -> $a0, still 22.  local_alloc had ALREADY taken BOTH $v0 and
     *   $v1 for block-local qtys, so global.c's numeric scan can only offer $a0.  LAW: promotion
     *   cannot reach a register that local_alloc has already handed out; fix the LOCAL qty
     *   population first (that is what (1)+(3) do).  Also falsified: fence order swap
     *   (base-first = 23), volatile opacity fences (24, +1 insn), no fence at all (at-macro
     *   stores, far worse), a 2nd fence alone on `one` (22). */
    one = 1;
    __asm__("" : "=r"(one) : "0"(one));
    __asm__("" : "=r"(one) : "0"(one));
    base = &mc.cmd;
    __asm__("" : "=r"(base) : "0"(base));
    base[2] = one;                     /* done = 1 */
    cmdv = base[0];
    __asm__ __volatile__("" : : "i"(0));
    snap = &_mc_sync[0];
    __asm__("" : "=r"(snap) : "0"(snap));
    snap[0] = cmdv;                    /* sync_cmd  = cmd  */
    cb      = (int (*)(int, int))base[16];   /* _mc_callback */
    snap[1] = base[1];                 /* sync_rslt = rslt */
    base[0] = 0;                       /* cmd  = 0 */
    base[1] = 0;                       /* rslt = 0 (unconditional: retail's beqz delay slot) */
    if (cb != 0)
        (*cb)(snap[0], snap[1]);
}

   /* extern "C" */

/* =================================  public API  =============================================== */

/* @0x800FC1F4 : build the "buNN:" device prefix for channel `chan` into `str`. */
static uint MemCardMakeDevname(int chan, char *str)
{
    int q;
    int lo;

    /* MATCH: the oracle opens with an INLINE 6-byte copy of the rodata literal "bu00:"
     * (`lwl/lwr 3/0($a1)` + `lb 4/5` -> `swl/swr` + `sb`) -- that is gcc's builtin strcpy
     * expansion for a constant source of known length into an unknown-alignment char*,
     * NOT six per-character stores.  The two digits are then OVERWRITTEN in place. */
    strcpy(str, "bu00:");
    q  = chan / 0x10;                   /* signed /16: bgez; addiu 0xF; sra 4 */
    lo = chan - q * 0x10 + 0x30;
    str[2] = (char)(q + 0x30);
    str[3] = (char)lo;
    return (uint)lo;
}

/* =================================  per-command FSM steps  ===================================== */
