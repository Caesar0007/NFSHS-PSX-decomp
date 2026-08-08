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
 *   Every lever below is tuned in the 2.7.2 basin; earlier-wave 2.8 receipts are basin-stale. */

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
struct McState {
    int   exretry;               /* +0x00 @0x80147500 : MemCardExist retry counter */
    int   exrslt;                /* +0x04 @0x80147504 : MemCardExist event scratch */
    int   retry;                 /* +0x08 @0x80147508 : MemCardAccept retry counter */
    int   evrslt;                /* +0x0C @0x8014750C : MemCardAccept event scratch */
    int   cleared;                /* +0x10 @0x80147510 : card-was-cleared flag */
    int   _rsvd_present;          /* +0x14 @0x80147514 : SPLIT OUT -> _mc_present below */
    int   cmd;                     /* +0x18 @0x80147518 : current command code (0 = idle) */
    int   rslt;                    /* +0x1C @0x8014751C : command result */
    int   done;                     /* +0x20 @0x80147520 : command-complete flag */
    int   chan;                      /* +0x24 @0x80147524 : active channel */
    int   fd;                         /* +0x28 @0x80147528 : open file descriptor (-1 = closed) */
    int   ofs;                         /* +0x2C @0x8014752C : transfer offset */
    int   len;                          /* +0x30 @0x80147530 : transfer length */
    void *adrs;                          /* +0x34 @0x80147534 : transfer buffer */
    char  devname[32];                    /* +0x38 @0x80147538 : "buNN:filename" device path */
    int (*callback)(int, int);             /* +0x58 @0x80147558 : user MemCardCallback */
    int   _rsvd1;                           /* +0x5C @0x8014755C : UNREFERENCED anywhere in the obj --
                                                real struct slot never exercised in retail, or a dead
                                                planned field; layout-only, no semantics attested */
};
typedef struct McState McState;
static McState mc;                       /* @0x80147500 */

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
static int   _mc_sync_cmd   __attribute__((section(".bss")));   /* @0x80147560 : snapshot of cmd  */
static int   _mc_sync_rslt  __attribute__((section(".bss")));   /* @0x80147564 : snapshot of rslt */
static int (*_mc_save_cb)(int, int) __attribute__((section(".bss")));  /* @0x8014756C : callback saved across a nested sync */

/* MATCH (w51-a2): SPLIT-STORAGE -- every oracle access to 0x80147514 materializes its OWN
 * %hi/%lo pair (read `lui v1; lw %lo(D_80147514)(v1)`, write `lui at; sw %lo(...)(at)`)
 * even where a struct base for cmd/chan is ALREADY live in a register, so this word is a
 * standalone static in retail, not a member of the mc aggregate. */
static int   _mc_present __attribute__((section(".bss")));  /* @0x80147514 : per-channel card-present bitmask */

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

/* @0x800FABF0 : MemCardExist / MemCardAccept(card-present) probe step. */
static int MemCardExist_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];
    int ev;

    /* MATCH (w51-a2): NOT a switch here -- the oracle's dispatch is an if/else-if CASCADE
     * (`beqz`(0) -> `bltz`(<0 default) -> `beq 10` -> `beq 0xb`), no slti bound test, so
     * balance_case_nodes never ran.  The block layout is dispatch / case-0 body / shared
     * "reissue" tail / case-0xb body, and the case-0 body FALLS INTO the tail -- reproduced
     * with explicit gotos (§5.0c goto-to-shared-tail; EA/Sony-era C used goto freely).
     * 152 -> 111 diffs.  Ours is still ~19 insns SHORT: named angle in the ev<3 node below. */
    if (state == 0) {                   /* first entry */
        mc.exrslt = 0;
        mc.exretry = 0;
        st[0] = 10;
        goto reissue;
    }
    if (state < 0)     return 0;
    if (state == 10)   goto reissue;
    if (state != 0xb)  return 0;
    goto evcheck;
reissue:
    /* states 0 and 10 share the (re)issue-info tail */
    _clr_card_event();
    _card_info(mc.chan);
    st[0] = st[0] + 1;                  /* -> 0xb */
    return 0;
evcheck:
    {
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        mc.exrslt = ev;
        if (ev < 3) {
            if (ev == 0) {              /* ev == 0 : I/O complete */
                mc.exrslt = 0;
                if ((_mc_present & (1 << mc.chan)) == 0)
                    mc.exrslt = 4;     /* never seen -> "no card" */
                mc.rslt = MemCardEventToRslt(mc.exrslt);
                return 1;
            }
            /* MATCH/ANGLE: the oracle's `ev < 3` node is a 3-WAY split -- `bgtz` (retry),
             * `beqz` (I/O complete), else (`ev < 0`) straight to the common tail. `ev` is
             * `_get_card_event()`'s `sum >> 1`, so the negative arm is unreachable; spelling
             * the 3rd path explicitly measured WORSE (113 vs 111, 272 lane).  Named angle:
             * the missing ~19 insns are in this node + the &mc.cmd-anchored rslt stores. */
            mc.exretry = mc.exretry + 1;
            if (mc.exretry < 5) { st[0] = 10; return 0; }
        } else if (ev == 4) {           /* new card */
            mc.rslt = MemCardEventToRslt(4);
            return 1;
        }
        _mc_present &= ~(1 << mc.chan);
        mc.rslt = MemCardEventToRslt(ev);
        return 1;
    }
}

/* @0x800FAE2C : MemCardAccept command step (probe -> clear -> load). */
static int MemCardCmd_cb(void *pv)
{
    int *st = (int *)pv;
    uint state = (uint)st[0];
    uint ev;

    if (state > 0x1f)
        return 0;

    switch (state) {
    case 0:
        mc.cleared = 0;
        mc.evrslt  = 0;
        mc.retry   = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        return 0;

    case 10:
        if (mc.rslt != 0) {
            if (mc.rslt == 3) {        /* new card -> (re)clear it */
                mc.cleared = 1;
                _mc_present |= 1 << mc.chan;   /* MATCH: no `& 0x1f` -- the shift-count mask is a Ghidra transcription artifact (sllv masks in HW); writing it emits a real andi the oracle lacks */
                _clr_card_event();
                _card_clear(mc.chan);
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
        _card_load(mc.chan);
        st[0] = st[0] + 1;              /* 0x1e -> 0x1f */
        return 0;

    case 0x1f:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        mc.evrslt = ev;
        if (ev < 3) {
            if (ev == 0) {              /* ev == 0 : done (oracle if(v1==0) goto done @0x800faf84) */
                if (mc.cleared != 0) { mc.rslt = 3; return 1; }
                mc.rslt = 0;
                return 1;
            }
            /* ev == 1 or 2 : retryable */
        } else if (ev != 4) {           /* unexpected -> error result */
            mc.rslt = MemCardEventToRslt(ev);
            return 1;
        }
        mc.retry = mc.retry + 1;
        if (mc.retry > 4) {
            if (ev != 4) { mc.rslt = MemCardEventToRslt(ev); return 1; }
            mc.rslt = 4;
            return 1;
        }
        st[0] = 0x1e;                   /* retry the load */
        return 0;

    default:
        return 0;
    }
}

/* @0x800FB118 : MemCardReadData transfer step. */
static int MemCardReadData_cb(void *pv)
{
    int ev;
    int r;
    int *st = (int *)pv;
    int state = st[0];


    /* MATCH (w51-a2): real `switch` (balance_case_nodes: `beq $v1,$s0(=10)` pivot + `slti
     * $v0,$v1,0xB` in the delay slot).  Case order 0, 10, 0x1e, and case 0 FALLS THROUGH into
     * case 10 (the oracle's case-0 block ends `sw $s0,0($s1)` with no `j`, landing on the
     * case-10 label).  61 -> 15 diffs, count 78/79. */
    switch (state) {
    case 0:
        _mc_rd_retry = 0;
        st[0] = 10;
        /* FALLTHROUGH */
    case 10:
        do { r = lseek(mc.fd, mc.ofs, 0); } while (r != mc.ofs);
        _clr_card_event();
        do { r = read(mc.fd, mc.adrs, mc.len); } while (r != 0);
        st[0] = 0x1e;
        return 0;
    case 0x1e:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        if (ev != 0) {
            _mc_rd_retry = _mc_rd_retry + 1;
            if (_mc_rd_retry < 4) { st[0] = 10; return 0; }
        }
        mc.rslt = MemCardEventToRslt(ev);
        return 1;
    default:
        return 0;
    }
}

/* @0x800FB30C : MemCardWriteData transfer step. */
static int MemCardWriteData_cb(void *pv)
{
    int ev;
    int r;
    int *st = (int *)pv;
    int state = st[0];


    /* MATCH (w51-a2): real `switch` -- but note the ASYMMETRY vs the ReadData twin, read off
     * the oracle: here case 0 does NOT fall through (its block ends `j` to the shared return-0)
     * and the SOURCE case order is 0, 0x1e, 10 (that is the order the bodies are emitted in).
     * 87 -> 9 diffs, count 78/79. */
    switch (state) {
    case 0:
        _mc_wr_retry = 0;
        st[0] = 10;
        return 0;
    case 0x1e:
        if (_chk_card_event() == 0) return 0;
        ev = _get_card_event();
        if (ev != 0) {
            _mc_wr_retry = _mc_wr_retry + 1;
            if (_mc_wr_retry < 4) { st[0] = 10; return 0; }
        }
        mc.rslt = MemCardEventToRslt(ev);
        return 1;
    case 10:
        do { r = lseek(mc.fd, mc.ofs, 0); } while (r != mc.ofs);
        _clr_card_event();
        do { r = write(mc.fd, mc.adrs, mc.len); } while (r != 0);
        st[0] = 0x1e;
        return 0;
    default:
        return 0;
    }
}

/* @0x800FB560 : MemCardReadFile step (exist -> open -> read -> close). */
static int MemCardReadFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    /* MATCH (w51-a2): the state dispatch is a REAL `switch`, not an if/else-if cascade -- the
     * oracle carries gcc's balance_case_nodes fingerprint (`beq $v1,$s0(=10)` median pivot with
     * the `slti $v0,$v1,0xB` bound test in its DELAY SLOT, case bodies emitted out-of-line in
     * SOURCE order, unconditional `j default`).  Two facts read straight off the block layout:
     *   (1) case order in the source is 0, 10, 0xb, 0x14 (the oracle emits the bodies in that
     *       order after the dispatch);
     *   (2) case 10 FALLS THROUGH into case 0xb -- retail's shared "issue the data phase" tail
     *       sits immediately after the case-10 body, before the case-0x14 body, which only a
     *       fallthrough (not a `break` to code after the switch) reproduces.
     * 46 -> 22 (switch) -> 12 diffs, count EXACT 66/66.  Same lever on the WriteFile/ReadData/
     * WriteData twins: 46->12, 61->15, 87->9.  RESIDUAL 12: the `beqz` bound-test delay slot
     * (oracle fills it with the next `li v0,11`, ours nops) and the case-10 arm's field stores,
     * where the oracle anchors $s0 at &mc.rslt and reaches fd by displacement (`sw v0,12(s0)`)
     * plus rslt via a rematerialized `addiu v1,s0,-4` &mc.cmd base. */
    switch (state) {
    case 0:
        _mc_rf_retry = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        return 0;
    case 10:
        if (mc.rslt != 0) return 1;                /* card not present -> abort */
        mc.fd = open(mc.devname, 0x8001);
        if (mc.fd < 0) { mc.rslt = 5; return 1; } /* open failed */
        /* FALLTHROUGH */
    case 0xb:
        st[0] = 0x14;
        UserFuncOpen((int)MemCardReadData_cb);
        return 0;
    case 0x14:
        close(mc.fd);
        mc.fd = -1;
        return 1;
    default:
        return 0;
    }
}

/* @0x800FB780 : MemCardWriteFile step (exist -> open -> write -> close). */
static int MemCardWriteFile_cb(void *pv)
{
    int *st = (int *)pv;
    int state = st[0];

    /* MATCH (w51-a2): real `switch` + case-10-falls-into-case-0xb, same as the ReadFile twin
     * (balance_case_nodes fingerprint in the oracle).  46 -> 12 diffs, count exact 66/66. */
    switch (state) {
    case 0:
        _mc_wf_retry = 0;
        UserFuncOpen((int)MemCardExist_cb);
        st[0] = 10;
        return 0;
    case 10:
        if (mc.rslt != 0) return 1;
        mc.fd = open(mc.devname, 0x8001);
        if (mc.fd < 0) { mc.rslt = 5; return 1; }
        /* FALLTHROUGH */
    case 0xb:
        st[0] = 0x14;
        UserFuncOpen((int)MemCardWriteData_cb);
        return 0;
    case 0x14:
        close(mc.fd);
        mc.fd = -1;
        return 1;
    default:
        return 0;
    }
}

/* @0x800FC170 : VSync pump -- step the queued FSM; on drain, latch result + fire user callback. */
static void MemCardStart_cb(void)
{
    if (UserFuncComplete() != 0)        /* stack already empty -> nothing pending */
        return;
    UserFuncExecute();
    if (UserFuncComplete() == 0)        /* still busy -> wait for the next frame */
        return;

    /* command finished this frame */
    mc.done      = 1;
    _mc_sync_cmd  = mc.cmd;
    _mc_sync_rslt = mc.rslt;
    mc.cmd       = 0;
    if (mc.callback != 0) {
        mc.rslt = 0;
        (*mc.callback)(_mc_sync_cmd, _mc_sync_rslt);
    }
}

   /* extern "C" */

/* =================================  public API  =============================================== */

/* @0x800FAAAC : MemCardInit -- bring up the card subsystem. */
extern void MemCardInit(int val)
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
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    if (base[0] > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    base[0] = 1;      /* cmd  */
    base[1] = 0;      /* rslt */
    base[2] = 0;      /* done */
    base[3] = chan;   /* chan */
    UserFuncOpen((int)MemCardExist_cb);
    return 1;
}

/* @0x800FADC4 : MemCardAccept -- begin an async "accept/clear the card on chan". Same base-reuse
 * shape as MemCardExist above. */
extern long MemCardAccept(long chan)
{
    int *base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));
    if (base[0] > 0) {
        printf("Access Denied. : event multiple open\n");
        return 0;
    }
    base[0] = 2;      /* cmd  */
    base[1] = 0;      /* rslt */
    base[2] = 0;      /* done */
    base[3] = chan;   /* chan */
    UserFuncOpen((int)MemCardCmd_cb);
    return 1;
}

/* @0x800FB060 : MemCardReadData -- async read into adrs (offset/length must be 128-byte aligned). */
extern long MemCardReadData(unsigned long *adrs, long ofs, long bytes)
{
    /* MATCH: the oracle anchors on &_mc_fd ($a3) and reaches cmd/rslt/done via NEGATIVE offsets
     * (-0x10/-0xc/-0x8) and ofs/len/adrs via POSITIVE ones (+4/+8/+0xc) from that SAME base --
     * fd sits in the middle of the field cluster this fn touches. */
    const char *fmt;
    int *pfd = &mc.fd;
    __asm__ __volatile__("" : "=r"(pfd) : "0"(pfd));
    if (*pfd < 0) {
        fmt = "Access Denied. : file not open.\n";
    } else if (0 < pfd[-4]) {                          /* cmd */
        fmt = "Access Denied. : event multiple open\n";
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else {
        if ((ofs & 0x7f) == 0) {
            pfd[-4] = 5;                            /* cmd  */
            pfd[-3] = 0;                             /* rslt */
            pfd[-2] = 0;                              /* done */
            pfd[1]  = ofs;                             /* ofs  */
            pfd[2]  = bytes;                            /* len  */
            *(unsigned long **)&pfd[3] = adrs;           /* adrs */
            UserFuncOpen((int)MemCardReadData_cb);
            return 1;
        }
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
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
    } else if (0 < pfd[-4]) {                          /* cmd */
        fmt = "Access Denied. : event multiple open\n";
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else {
        if ((ofs & 0x7f) == 0) {
            pfd[-4] = 6;                            /* cmd  */
            pfd[-3] = 0;                             /* rslt */
            pfd[-2] = 0;                              /* done */
            pfd[1]  = ofs;                             /* ofs  */
            pfd[2]  = bytes;                            /* len  */
            *(unsigned long **)&pfd[3] = adrs;           /* adrs */
            UserFuncOpen((int)MemCardWriteData_cb);
            return 1;
        }
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB448 : MemCardReadFile -- async open+read of a named card file. */
extern long MemCardReadFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (0 < mc.cmd) {
        fmt = "Access Denied. : system busy\n";
    } else if (0 <= mc.fd) {
        fmt = "Access Denied. : file already open.\n";
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else if ((ofs & 0x7f) == 0) {
        MemCardMakeDevname(chan, mc.devname);
        strcat(mc.devname, file);
        mc.cmd  = 3;
        mc.rslt = 0;
        mc.done = 0;
        mc.len  = bytes;
        mc.chan = chan;
        mc.ofs  = ofs;
        mc.adrs = adrs;
        UserFuncOpen((int)MemCardReadFile_cb);
        return 1;
    } else {
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB668 : MemCardWriteFile -- async open+write of a named card file. */
extern long MemCardWriteFile(long chan, char *file, unsigned long *adrs, long ofs, long bytes)
{
    const char *fmt;
    if (0 < mc.cmd) {
        fmt = "Access Denied. : system busy\n";
    } else if (0 <= mc.fd) {
        fmt = "Access Denied. : file already open.\n";
    } else if ((bytes & 0x7f) != 0) {
        fmt = "Access Denied. : invalid data size align\n";
    } else if ((ofs & 0x7f) == 0) {
        MemCardMakeDevname(chan, mc.devname);
        strcat(mc.devname, file);
        mc.cmd  = 4;
        mc.rslt = 0;
        mc.done = 0;
        mc.len  = bytes;
        mc.chan = chan;
        mc.ofs  = ofs;
        mc.adrs = adrs;
        UserFuncOpen((int)MemCardWriteFile_cb);
        return 1;
    } else {
        fmt = "Access Denied. : invalid offset value align\n";
    }
    printf(fmt);
    return 0;
}

/* @0x800FB888 : MemCardGetDirentry -- synchronous directory listing (max files into dir[]). */
extern long MemCardGetDirentry(long chan, char *name, void *dir, long *files,
                                   long ofs, long max)
{
    char     devname[32];
    DIRENTRY ent;
    DIRENTRY *p;
    int      idx;
    int      stored;
    int      fretry;
    int      err;

    if (mc.cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    MemCardMakeDevname(chan, devname);
    strcat(devname, name);
    err     = 0;
    idx     = 0;
    stored  = 0;
    fretry  = 0;
    _mc_present |= 1 << (mc.chan);

    if (ofs + max > 0) {
        do {
            if (idx == 0) {
                while (1) {
                    _clr_card_event();
                    p = firstfile(devname, &ent);
                    if (p != 0)
                        break;
                    err = MemCardEventToRslt((uint)(ofs > 0));
                    if (err == 0)
                        goto have_entry;        /* (p == 0, err == 0): empty directory */
                    fretry = fretry + 1;
                    if (fretry > 3) {
                        /* repeated failure: re-accept the card, then bail */
                        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
                        if (mc.cmd < 1) {
                            mc.cmd  = 2;
                            mc.rslt = 0;
                            mc.done = 0;
                            mc.chan = chan;
                            UserFuncOpen((int)MemCardCmd_cb);
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
extern int MemCardCallback(int func)
{
    int prev;
    typedef int (*CbT)(int, int);
    CbT *p = &mc.callback;
    __asm__ __volatile__("" : "=r"(p) : "0"(p));
    prev = (int)p[0];
    p[0] = (CbT)func;
    return prev;
}

/* @0x800FBAFC : MemCardSync -- poll (mode!=0) or block (mode==0) for command completion. */
extern long MemCardSync(long mode, int *cmds, int *result)
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
        while (*(volatile int *)&base[2] == 0)   /* async: cleared by the VSync pump */
            ;
        if (result != 0) *result = _mc_sync_rslt;  /* sync_rslt */
        if (cmds   != 0) *cmds   = _mc_sync_cmd;  /* sync_cmd  */
        base[2] = 0;                          /* done      */
        return 1;
    }

    /* non-blocking */
    if (base[2] == 0) {
        if (result != 0) *result = rslt;
        if (cmds   != 0) *cmds   = cmd;
        return 0;
    }
    if (result != 0) *result = _mc_sync_rslt;      /* sync_rslt */
    if (cmds   != 0) *cmds   = _mc_sync_cmd;      /* sync_cmd  */
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

    if (mc.cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    MemCardMakeDevname(chan, devname);
    strcat(devname, file);
    _mc_present |= 1 << (mc.chan);

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
        if (mc.cmd < 1) {
            mc.cmd  = 2;
            mc.rslt = 0;
            mc.done = 0;
            mc.chan = chan;
            UserFuncOpen((int)MemCardCmd_cb);
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
extern long MemCardDeleteFile(long chan, char *file)
{
    char devname[32];
    int  retry;
    int  rslt;

    if (mc.cmd != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    retry = 0;
    MemCardMakeDevname(chan, devname);
    strcat(devname, file);
    _mc_present |= 1 << (mc.chan);

    while (1) {
        if (erase(devname) != 0)
            return 0;
        /* erase failed: re-accept card and inspect the result */
        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);
        if (mc.cmd < 1) {
            mc.cmd  = 2;
            mc.rslt = 0;
            mc.done = 0;
            mc.chan = chan;
            UserFuncOpen((int)MemCardCmd_cb);
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
extern long MemCardFormat(long chan)
{
    char devname[64];
    int  ev;
    int *base = &mc.cmd;
    __asm__ __volatile__("" : "=r"(base) : "0"(base));

    if (base[0] != 0) {
        printf("Access Denied. : system busy\n");
        return -1;
    }

    _mc_present |= 1 << (base[3]);      /* chan = cmd+0xC */
    MemCardMakeDevname(chan, devname);
    _clr_card_event();
    format(devname);
    ev = _get_card_event_x();
    return MemCardEventToRslt(ev);
}

/* @0x800FC068 : MemCardUnformat -- low-level "unformat" by writing 0xFF blocks 0..14. */
extern long MemCardUnformat(long chan)
{
    unsigned char buf[128];
    int  blk;
    int  i;

    if (mc.cmd != 0) {
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
