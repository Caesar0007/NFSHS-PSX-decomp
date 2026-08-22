/* syslib/psx/libcd/stcdint.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(C_011.OBJ): StCdInterrupt -- the CD-streaming sector interrupt handler.
 *
 *   Installed as the libcd ready callback by a streaming read (cdread2.cpp).  On each sector
 *   "data ready" interrupt it: gates on the MDECout DMA in RGB24 mode, reads the CD result and the
 *   sector sub-header (submode magic 0x160 / channel / sector# / #sectors / frame#), applies the
 *   start-frame / channel / sync filters, advances the ring write index (wrapping or clamping at the
 *   ring end), and programs CD DMA channel 3 -- or, for an emulated stream, a plain word copy -- to
 *   deposit the sector into the ring.  On a frame's last sector it sets StFinalSector and fires the
 *   user StFunc2; on the start frame it clears StSTART_FLAG.  Two file-static helpers: _st_copy_words
 *   (word memcpy @0x800F8794) and _st_dma (DMA-channel programmer @0x800F87C0).
 *
 *   Structure follows the matched libcd reference decomp (Sotn/psxsdk c_011.c -> dma_execute/mem2mem):
 *   the cached current ring slot lives in the GLOBAL _st_slot (re-read each use, NOT held in a saved
 *   register), and the CD result / sub-header are staged through a small on-stack scratch array so the
 *   sub-header word lands in the ring slot via an unaligned copy.  Hardware is reached through a .data
 *   table of CD/DMA register pointers @0x80136A98 (materialised below from the EXE).  All St* state
 *   lives in stream.cpp; _st_slot (cached current ring slot) and debug_cause are owned here. */

typedef unsigned char  u_char;
typedef unsigned short u_short;
/* W71-A9: the sub-header word is copied into the ring slot by an ALIGN-1 struct
 * assignment -- retail emits gcc's unaligned movstrsi (`lwl 43(sp)/lwr 40(sp)` +
 * `swl 31(v0)/swr 28(v0)`), which a plain `*(int *)(slot+0x1C) = loc[0]` (2 insns)
 * can never produce.  See the cluster-(B) receipt at the store site. */
typedef struct { char b[4]; } Pack4_;

/* ---- CD/DMA hardware-register pointer table (.data @0x80136A98, materialised from NFS4.EXE) ----
 * Each entry is a 4-byte initialised pointer; under -G4 it would land in .sdata -> gp-relative, but
 * the oracle reaches the table ABSOLUTELY (lui %hi; lw %lo).  Pin to .data so the addressing matches. */
#define ST_DATA __attribute__((section(".data")))
static volatile u_char *_cd_idx      ST_DATA = (volatile u_char *)0x1F801800; /* @0x80136A98 CDREG0/index */
static volatile u_char *_cd_reg3     ST_DATA = (volatile u_char *)0x1F801803; /* @0x80136AA4 CDREG3       */
static volatile u_char *_cd_reg2     ST_DATA = (volatile u_char *)0x1F801802; /* @0x80136AA0 CDREG2 (data)*/
static volatile int    *_cdrom_delay ST_DATA = (volatile int   *)0x1F801018;  /* @0x80136AA8 CDROM_DELAY  */
static volatile int    *_com_delay   ST_DATA = (volatile int   *)0x1F801020;  /* @0x80136AAC COM_DELAY    */
static volatile int    *_dpcr        ST_DATA = (volatile int   *)0x1F8010F0;  /* @0x80136AB0 DPCR         */
static volatile u_char *_dicr        ST_DATA = (volatile u_char *)0x1F8010F4;  /* @0x80136AB4 DICR         */
static volatile int    *_d1_chcr     ST_DATA = (volatile int   *)0x1F801098;  /* @0x80136AB8 MDECout CHCR */
static volatile int    *_d3_chcr     ST_DATA = (volatile int   *)0x1F8010B8;  /* @0x80136AC8 CD CHCR      */

/* ---- C_011-owned globals ---------------------------------------------------------------------- */
/* Regular .bss / .data, reached absolutely in the oracle -- pin to .bss so they stay out of
 * .sdata/.sbss (which would make them gp-relative and mismatch the ROM).  _st_slot is the cached
 * current ring slot pointer (StRingAddr + StRingIdx1*0x20); the oracle re-loads it from memory on
 * every use, so it is a global, not a register-cached local. */
#define ST_BSS __attribute__((section(".bss")))

/* 🔴 W65-A6: the `ST_BSS` (`section(".bss")`) attribute above is INERT on this lane -- gcc-2.7.2
 * emits an uninitialised file-scope object as `.comm NAME,size` regardless, and this TU is on
 * the cc1_272 lane (no maspsx to rewrite it).  `nm` reported BOTH as COMMON (`C`): 2 of the 37
 * tree-wide COMMONs, placed by ld rather than by the object, so neither can reach the VA its
 * own breadcrumb names (W62-A18 T6).
 * `_st_slot` is real BSS (0x80144864 > t_addr+t_size 0x8013E000) and is given a real,
 * object-owned definition below.  Its slot runs to StFunc1 @0x80144874 (16 B); only the 4-byte
 * pointer is attributable, the trailing 12 B are recorded as unattributed, not invented.
 * `debug_cause` is NOT bss: 0x80136AE0 is inside the initialised image and the splat blob
 * already emits that word -- but inside a larger `dlabel` run, so there is no name to alias to
 * yet.  It therefore STAYS a COMMON here, deliberately: demoting it to `extern` would only turn
 * a COMMON into an undefined symbol.  ACTION FOR THE BLOB/.ld LANE: cut a `dlabel D_80136AE0`
 * at 0x80136AE0 in asm/data/data_8010CCD4_r17.data.s, then this line becomes
 * `extern int debug_cause __asm__("D_80136AE0");` (byte-neutral, same device as INTR.c's
 * g_intr).  Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\t_st_slot\n\t.section\t.bss\n\t.align\t2\n_st_slot:\n\t.space\t4\n\t.text");
extern u_short *_st_slot;   /* @0x80144864 : cached current ring slot                 */
/* W66-A3: the blob cut named above HAS LANDED -- asm/data/data_8010CCD4_r17.data.s
 * now carries `dlabel debug_cause` at 0x80136AE0, under that exact name, so no
 * asm-label alias is needed either.  Demoting this to a pure `extern` retires the
 * last COMMON in the tree (37 -> 1 -> 0) and stops a zero-filled ld-placed COMMON
 * from competing with the real in-image word. */
extern int debug_cause;   /* @0x80136AE0 : last interrupt stage/abort code (debug) */


/* ---- streaming state (stream.cpp) ------------------------------------------------------------- */
extern int StFinalSector, StRgb24, StEmu_Addr, StEmu_Idx, StSTART_FLAG, StStartFrame;
extern int CChannel, Stframe_no, StRingIdx1, StRingIdx2, StRingAddr, StRingSize, StRingBase;
extern int StEndFrame, StCHANNEL, StFunc2, StMode, StCdIntrFlag;
extern short Stsector_offset;

/* ---- peer libcd objects ----------------------------------------------------------------------- */
extern int  CdReady(int mode, u_char *result);          /* @0x800F786C (DRV) */
extern void init_ring_status(int base, unsigned count); /* C_008 @0x80108758 */
extern void data_ready_callback(void);                 /* C_004 @0x80108798 */
extern int  printf(const char *, ...);                  /* libc C63 @0x801028AC */

/* W60-A4: retail VA order -- StCdInterrupt @0x800F7E78 precedes _st_copy_words
 * @0x800F8794 and _st_dma @0x800F87C0; forward decls for the two helpers. */
extern void _st_copy_words(int *dst, int *src, unsigned num, int arg3);
extern void _st_dma(int ch, int madr, int blocks, int blocksize, volatile int chcr,
                    u_char enable_irq, int arg6);

/* @0x800F7E78 : the CD-streaming sector interrupt handler.
 *
 * MATCH (w52-a2): 89 -> 81 diffs on the WIRED lane, and 89 -> 36 once the TU also carries
 * `no_strength_reduce` (see the RECOMMENDED-FLAG note below).  Three source levers, each
 * gated in BOTH configurations:
 *  (1) SUB-HEADER LOOP -> INDEX FORM.  Retail recomputes the element address every iteration
 *      (`addu $v1,$a1,$a0` off a loop-invariant `addiu $a1,$sp,40`) and tests the COUNTER
 *      against an immediate (`sltiu $v0,$a0,4`); our pointer-walk `do { *p++ = ...; } while
 *      (p < end);` tested against an end POINTER (`sltu $v0,$v1,$a0`).  Written as
 *      `for (i = 0; i < 4; i++) p[i] = *_cd_reg2;` the shape is right BUT gcc's
 *      strength-reduction converts it straight back -- the index form only takes effect
 *      together with `-fno-strength-reduce` (89 -> 52 combined; the flag ALONE is inert at
 *      89, and the source edit alone is diff-neutral, so BOTH halves are needed).
 *  (2) DROP the `(u_short)` cast on CChannel and the `(short)` cast on `_st_slot[2]`:
 *      retail reads CChannel as a full word (`lw`) and the slot half-word unsigned (`lhu`);
 *      the casts were emitting `lhu`/`lh` respectively.  52 -> 48 (85 unflagged).
 *  (3) DECLARATION ORDER of the header-relocate loop's two pointers: retail's FIRST-loaded
 *      global ($a1) is the DESTINATION (StRingAddr) and the second ($v1) the SOURCE
 *      (_st_slot); ours had them the other way round, swapping the whole loop.  48 -> 36
 *      (81 unflagged).
 * RESIDUAL 36 (flagged) = four named clusters:
 *   (A) 1-insn order at the sub-header loop's entry;
 * W61-A8 RE-PRICING of (B) on the CURRENT basin (all gated, all reverted): the Pack4
 * `struct {char b[4];}` cast-assign REPRODUCES retail's `lwl 43(sp)/lwr 40(sp)` +
 * `swl 31(v0)/swr 28(v0)` EXACTLY and its only residual in that block is a 3-register
 * rotation (retail {a0 = the 0x20843 constant, a1 = copy temp, v1 = _cdrom_delay ptr},
 * ours {v1, a0, v0}) -- but it still scores 43.  Falsified for that rotation: moving
 * the `*_cdrom_delay = 0x20843` store AHEAD of the copy (43; and 41 without Pack4),
 * a named `int d1 = 0x20843` local (43), a read-only fence on `_st_slot` after the
 * delay stores (45) and one on `loc[0]` (44).  Cluster (D) IS reachable: a w61-a20
 * DEVICE-2 identity fence on the `_st_slot[4]` read (`int fn_ = ...; asm =r/0`)
 * RESTORES the `andi v0,v0,0xFFFF` retail keeps -- the 12E law that only an
 * OUTPUT-BEARING fence invalidates cse's value-range proof, confirmed at a new site
 * -- but it lands the mask 9 insns early and nets +3 (39).
 *   (B) the `_st_slot[0x1C] = loc[0]` store: retail emits an UNALIGNED movstrsi block move
 *       (`lwl/lwr` + `swl/swr`, +3 insns of our 8-insn shortfall).  A `struct {char b[4];}`
 *       cast-assign DOES reproduce that exact sequence -- verified twice -- but the
 *       surrounding coloring then costs more than it gains (36 -> 43, 48 -> 59 in the
 *       earlier basin), because retail also materializes the following 0x20843 CDROM_DELAY
 *       constant into $a0 BEFORE the copy so the copy temp lands in $a1.  FALSIFIED for the
 *       constant: hoisting it into a named local before the copy.  NEXT DIAL: get the
 *       constant materialized first, then re-land the Pack4 aggregate;
 *   (C) the channel-mismatch tail: retail RE-READS `_st_slot` from its global into $v1 for
 *       the `_st_slot[0] = 0` store (plus a dead `lhu $v0,0($a0)` on the StEmu_Addr==0 edge)
 *       instead of reusing the cached $a0 -- the SELECTIVE-CACHING class;
 *   (D) one `andi $v0,0xFFFF` retail keeps on `Stframe_no = _st_slot[4] & 0xFFFF` that our
 *       cc1 folds away (the `lhu` already proves the range).
 *
 * RECOMMENDED PER-TU FLAG (orchestrator action, w52-a2): add `"no_strength_reduce": True`
 * beside this TU's existing `cc1_272` entry.  Whole-TU gate, measured both ways:
 *      _st_copy_words  PASS      -> PASS
 *      _st_dma         25 diffs  -> 25 diffs   (inert)
 *      StCdInterrupt   81 diffs  -> 36 diffs
 * i.e. -45 diffs, zero PASS regressions.  (`no_schedule_insns` / `no_schedule_insns2` /
 * `no_delayed_branch` / `no_split_addresses` were all probed on this TU and are worse or
 * inert -- see the w52-a2 report table.) */
extern void StCdInterrupt(void)
{
    /* W64-A6 re-gate: 27 @576/583 (w63's landed void barrier holds).  TWO axes re-run
     * in the NEW basin per 04Z and both CLOSED:
     *  (a) A SECOND void barrier: tools/fencesweep.py over all 116 statement positions
     *      in this body finds NOTHING under 27 -- the best non-baseline results are 28
     *      (5 positions) and 29 (7 positions), everything else 27 or worse.  (The same
     *      sweep is what found the 36 -> 27 barrier, so its emptiness is a real negative.)
     *  (b) COMPILER LADDER: 2.6.0 66 / 2.6.3 66 / 2.7.2 27 (wired) / 2.7.2-970404 756 /
     *      2.8.0 756 / 2.8.1 756.  The wired 272 lane is decisively optimal.
     * The residual is still the w52-a2 cluster list; the ring-mechanics twins the W64
     * corpus sweep looked for do not exist (see the file header note). */
    volatile short hdr[4];   /* status/sub-header scratch (sp+0x20); stages result[0..1] at [1]/[2] */
    int     loc[2];          /* CdlLOC sub-header staging (sp+0x28) -> copied into the ring slot     */
    u_char  result[8];       /* CdReady result buffer (sp+0x30)                                      */
    u_char *p;
    int     t0;
    unsigned i;
    volatile int *dly_;      /* W71-A9: CDROM_DELAY reg ptr, loaded BEFORE the slot copy */

    if (StFinalSector == 1)
        return;

    /* RGB24: never disturb an in-flight MDECout DMA -- retry next interrupt. */
    if (StRgb24 != 0 && (*_d1_chcr & 0x1000000)) {
        StCdIntrFlag = 1;
        if (StEmu_Addr != 0)
            StEmu_Idx++;
        debug_cause = 1;
        return;
    }

    if (CdReady(1, result) == 5)                    /* CdlDiskError */
        return;
    hdr[1] = result[0];
    hdr[2] = result[1];
    if (hdr[1] & 4) {                               /* error flag in status */
        debug_cause = 3;
        return;
    }

    _st_slot = (u_short *)(StRingAddr + (StRingIdx1 << 5));
    if (_st_slot[0] != 0) {                         /* target slot not yet consumed -> overflow */
        if (StEmu_Addr != 0)
            StEmu_Idx++;
        debug_cause = 4;
        return;
    }

    /* ---- pull the sector sub-header off the drive ------------------------------------------- */
    *_cd_idx  = 0;
    *_cd_reg3 = 0;
    *_cd_idx  = 0;
    *_cd_reg3 = 0x80;
    *_cdrom_delay = 0x20943;
    *_com_delay   = 0x1323;
    /* MATCH (W71-A9, 27 -> 24): the sub-header counter is zeroed BEFORE the StMode guard.
     * Retail fills the guard `bnez`'s DELAY SLOT with `addu $a0,$zero,$zero` (i = 0), so
     * that zeroing is UNCONDITIONAL (methodology 3.1) -- writing it inside the guarded
     * block leaves it behind `p = &loc[0]` in the fall-through thread, reorg's simple
     * backward scan finds nothing eligible and the slot stays a `nop` (cluster (A) of the
     * w52-a2 residual list).  Measured: here 24 · `i = 0;` as the first statement INSIDE
     * the block 25 · `p` assigned inside the loop 24 (inert on top) · hoisting `p` above
     * the guard as well 77 (the &loc[0] address must NOT leave the guarded block). */
    i = 0;
    if (StMode == 0) {
        p = (u_char *)&loc[0];                      /* &hdr[4] == loc -> 4 raw sub-header bytes */
        for (; i < 4; i++) p[i] = *_cd_reg2;        /* MATCH: INDEX form (oracle `addu v1,a1,a0`) */
        for (i = 0; i < 8; i++) (void)*_cd_reg2;    /* drain */
    }

    /* ---- deposit the raw sector into the slot (emulated copy or CD DMA) ---------------------- */
    t0 = 0x11000000;
    if (StEmu_Addr != 0) {
        _st_copy_words((int *)_st_slot, (int *)(StEmu_Addr + (StEmu_Idx << 11)), 8, 0);
    } else {
        _st_dma(3, (int)_st_slot, 0, 8, t0, 0, 0);
    }
    while (*_d3_chcr & 0x1000000)
        ;
    /* MATCH (W71-A9, 24 -> 7, cluster (B) of the w52-a2 list SOLVED): TWO cooperating
     * pieces -- neither works alone, which is why five waves of Pack4-only probes
     * (w52-a2 36->43, w61-a8 "reproduces the lwl/lwr EXACTLY but still scores 43",
     * W71 first pass 24->31) all read as a net loss:
     *   (1) the ALIGN-1 struct assignment reproduces retail's unaligned movstrsi
     *       (`lwl 43(sp)/lwr 40(sp)/nop/swl 31(v0)/swr 28(v0)`, +3 insns of the
     *       8-insn shortfall) -- the plain `*(int *)` store is 2 insns and no
     *       spelling of it can grow;
     *   (2) `_cdrom_delay` must be READ INTO A LOCAL BEFORE the copy.  Retail loads
     *       BOTH pointers up front (`lw v0,_st_slot; lw v1,_cdrom_delay`) and only
     *       then runs the copy, storing the delay constant AFTER it (`sw a0,0(v1)`);
     *       with the deref left inline, cc1 emits the delay pointer load AFTER the
     *       copy and the copy temp lands in the wrong register, which is exactly the
     *       "surrounding coloring costs more than it gains" the old receipts recorded.
     * Measured in this basin: minimal pair 7 · Pack4 alone 31 · the pointer local
     * alone (no Pack4) 28 · adding `d1_`/`slot_` locals for the constant and the slot
     * base 7 (inert, so they are NOT part of the lever) · `char b[3]; char c;` as the
     * pack struct 31 (the trailing named byte re-aligns it to 4).  The old
     * "NEXT DIAL: get the constant materialized first" reading was wrong -- the
     * constant is free, the POINTER LOAD is the dial. */
    dly_ = _cdrom_delay;
    *(Pack4_ *)((char *)_st_slot + 0x1C) = *(Pack4_ *)&loc[0];  /* sub-header word -> slot+0x1C */
    *dly_ = 0x20843;
    *_com_delay   = 0x1325;

    /* ---- start-frame gating ----------------------------------------------------------------- */
    if (StSTART_FLAG == 1 && StStartFrame != 0) {
        if (StStartFrame == _st_slot[4]) {
            StSTART_FLAG = 0;                       /* reached the requested start frame */
        } else {
            _st_slot[0] = 0;                        /* skip frames before it */
            if (StEmu_Addr != 0)
                StEmu_Idx++;
            return;
        }
    }

    /* ---- submode / channel filter ----------------------------------------------------------- */
    if (_st_slot[0] != 0x160 || ((_st_slot[1] >> 10) & 0x1F) != CChannel) {
        /* MATCH (W71-A9, 5 -> 0 -- CLUSTER (C) SOLVED, the function PASSES 583/583):
         * the emulated-stream arm and the real-drive arm are NOT merged in retail.
         * Oracle (StCdInterrupt.s @0x800F8200):
         *      beqz  StEmu_Addr, .L800F8220
         *      lui   at,%hi(StEmu_Idx)
         *      j     .L800F8224
         *       sw   zero,%lo(StEmu_Idx)(at)     <- StEmu_Idx = 0, in the j's slot
         *  .L800F8220:
         *      lhu   v0,0(a0)                    <- a DEAD read of _st_slot[0], on the
         *                                           StEmu_Addr == 0 EDGE ONLY
         *  .L800F8224:
         *      lui   v1,%hi(_st_slot); lw v1,...  <- _st_slot RE-LOADED for the store
         * i.e. the else arm really does read the slot's consumed-flag and throw the
         * value away.  Modelling it as a VOLATILE read inside an explicit `else`
         * reproduces all three residual insns at once: the read is undeletable, it
         * gives the else arm its own one-insn block (so the two arms stop
         * cross-jumping and the if arm keeps its own `j` + delay-slot store), and it
         * breaks the cached-base equivalence so the `_st_slot[0] = 0` store reloads
         * the pointer like retail.  It is also the honest semantics: `_st_slot[0]` is
         * cleared asynchronously by the ring consumer.
         * Measured: else-arm + volatile 0 (PASS) · the SAME read hoisted out of the
         * else, unconditional, 5 · non-volatile in the else arm 6 · read kept in BOTH
         * places 16 · a laundered `_st_slot` pointer local for the store 8 ·
         * `*(volatile u_short *)&_st_slot[0] = 0;` on the store instead 5. */
        if (StEmu_Addr != 0) { StEmu_Idx = 0; }
        else                 { (void)*(volatile u_short *)&_st_slot[0]; }
        /* W71-A9: the w63-a6 zero-insn VOID BARRIER that used to sit here (36 -> 27,
         * found by a whole-body fence-position sweep) is RETIRED -- it was papering
         * over exactly the un-merged else arm above, and with the real shape in place
         * it measures INERT (0 with and without).  Removed per floor-hygiene: a
         * matching device that no longer buys anything is scaffolding. */
        debug_cause = 5;
        _st_slot[0] = 0;
        return;
    }

    /* ---- sector-offset / frame-number sync check -------------------------------------------- */
    if (Stsector_offset != _st_slot[2] ||
        (Stframe_no != 0 && Stframe_no != _st_slot[4])) {
        Stframe_no      = 0;
        Stsector_offset = 0;
        init_ring_status(StRingIdx2, (unsigned)(StRingIdx1 - StRingIdx2));
        StRingIdx1      = StRingIdx2;
        _st_slot[0]     = 0;
        if (StEmu_Addr != 0) StEmu_Idx++;
        debug_cause = 6;
        return;
    }

    /* ---- first sector of a new frame: range-check + ring-space bookkeeping ------------------- */
    if (_st_slot[2] == 0) {
        Stsector_offset = 0;
        /* MATCH (W71-A9, 6 -> 5): retail KEEPS an `andi $v0,$v0,0xFFFF` here that our
         * cc1 folds away (the `lhu` already proves the range) -- the w52-a2 cluster (D).
         * A READ-ONLY fence on the loaded value (one ref, zero insns) is enough to
         * defeat the range proof; W61-A8's identity fence also restores the mask but
         * lands it 9 insns early and costs +3 (measured again here: launder 10,
         * read-only fence 6, 2-operand read-only fence 6, a `(unsigned)` cast 7). */
        {
            int fn_ = _st_slot[4];
            __asm__("" : : "r"(fn_));
            Stframe_no = fn_ & 0xFFFF;
        }

        if (StEndFrame != 0 && (unsigned)Stframe_no >= (unsigned)StEndFrame) {  /* past the end frame */
            Stframe_no      = 0;
            Stsector_offset = 0;
            init_ring_status(StRingIdx2, (unsigned)(StRingIdx1 - StRingIdx2));
            StRingIdx1      = StRingIdx2;
            _st_slot[0]     = 0;
            StSTART_FLAG    = 1;
            if (StFunc2 != 0) ((void (*)())StFunc2)();
            if (StEmu_Addr != 0) StEmu_Idx++;
            debug_cause = 7;
            return;
        }

        if ((unsigned)(StRingSize - StRingIdx1 - 1) < (unsigned)_st_slot[3]) {  /* frame won't fit */
            if (StEndFrame == 0) {                  /* endless stream -> wait/wrap */
                _st_slot[0]  = 1;
                StSTART_FLAG = 1;
                if (StFunc2 != 0) ((void (*)())StFunc2)();
                if (StEmu_Addr != 0) StEmu_Idx++;
                debug_cause = 8;
                return;
            }
            /* bounded stream: rewind to slot 0 if it is free, else stall */
            if (*(short *)StRingAddr != 0) {
                _st_slot[0] = 0;
                if (StEmu_Addr != 0) StEmu_Idx++;
                debug_cause = 9;
                return;
            }
            _st_slot[0] = 1;
            {
                int *dst = (int *)StRingAddr;   /* MATCH: dst declared FIRST -- retail's first-
                                                 * loaded global ($a1) is the DESTINATION */
                int *src = (int *)_st_slot;
                StRingIdx1 = 0;
                for (i = 0; i < 8; i++) *dst++ = *src++;   /* copy header down to slot 0 */
                _st_slot = (u_short *)StRingAddr;
            }
        }
        StRingIdx2 = StRingIdx1;
    }

    /* ---- dispatch the sector body into the ring's frame area -------------------------------- */
    debug_cause = 0xA;
    Stsector_offset = (short)(Stsector_offset + 1);
    StRingBase = StRingAddr + (StRingSize << 5) + ((StRingIdx1 * 0x3F) << 5);

    if (StRgb24 != 0) {
        t0 = 0x11000000;
        *_cdrom_delay = 0x20943;
        *_com_delay   = 0x1323;
    } else {
        *_cdrom_delay = 0x21020843;
        t0 = 0x11400100;
    }

    if ((int)_st_slot[3] - 1 == (int)_st_slot[2]) {     /* last sector of the frame */
        StFinalSector = 1;
        if (StEmu_Addr != 0) {
            _st_copy_words((int *)StRingBase, (int *)(StEmu_Addr + (StEmu_Idx << 11) + 0x20), 0x1F8, 1);
            StEmu_Idx++;
        } else {
            _st_dma(3, StRingBase, 0, 0x1F8, t0, 1, 0);
        }
        Stsector_offset = 0;
        Stframe_no      = 0;
        CChannel        = StCHANNEL;
    } else {
        if (StEmu_Addr != 0) {
            _st_copy_words((int *)StRingBase, (int *)(StEmu_Addr + (StEmu_Idx << 11) + 0x20), 0x1F8, 0);
            StEmu_Idx++;
        } else {
            _st_dma(3, StRingBase, 0, 0x1F8, t0, 0, 0);
        }
    }

    *_com_delay = 0x1325;
    _st_slot[0] = 3;                                /* mark the slot "DMA in flight" */
    StRingIdx1++;
    if (StEmu_Addr != 0 && StFinalSector != 0)
        data_ready_callback();
}

/* @0x800F8794 : copy `num` 32-bit words src -> dst.  (4th arg present in the original signature
 *   but unused -- callers pass a trailing 0 / 1; reproduced so the call-site stack layout matches.) */
extern void _st_copy_words(int *dst, int *src, unsigned num, int arg3)
{
    /* MATCH (w51-a4, cc1_272 lane): a counted `for (i = 0; i < num; i++)` makes gcc-2.7.2
     * reserve an 8-byte `vars` frame on every such loop (`.frame $sp,8` -> subu/addu $sp),
     * where the oracle is frameless.  Guard-then-goto is frameless and reproduces the
     * oracle byte-for-byte (`beqz num` with `i=0` in the slot; bottom `sltu`/`bnez` with
     * `addiu a0,a0,4` in ITS slot).  Lane-neutral: still PASSes on the 2.8 lane. */
    unsigned i = 0;
    (void)arg3;
    if (num == 0)
        return;
loop:
    *dst++ = *src++;
    i++;
    if (i < num)
        goto loop;
}

/* @0x800F87C0 : program DMA channel `ch` (madr, blocks x blocksize, chcr); waits for the channel
 *   idle first and gates the kick on CDREG0 bit 0x40.  `enable_irq` toggles the channel DICR bit.
 * MATCH (w51-a4): shape TRANSPLANTED from the byte-exact Rage Racer libcd decomp,
 * C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/dma_start.c :: CD_dmastart.  What it recovered
 * that the earlier reconstruction was MISSING (ours 91 insns vs oracle 106):
 *   (a) TWO discarded `volatile` read-backs the original keeps (`sw $v0,0x10($sp)` twice in the
 *       oracle = one stack `dummy` slot): the DICR word re-read after the byte-mask store, and the
 *       CHCR read-back after the kick -- both are real PSX DMA write-posting flushes;
 *   (b) the DICR bit is read into a TEMP then stored (`bv = dptr[2]; dptr[2] = bv | (1<<ch);`)
 *       through a NON-volatile `u_char *`, not a `|=` on a volatile lvalue;
 *   (c) the 6th argument is a `u_char` (oracle `lbu $s1,0x44($sp)`), not an int;
 *   (d) the busy-wait is a plain rotated `while (busy) { if (i == 0x10000) {printf; break;} i++; }`.
 *   (7th arg present in the original signature but unused; reproduced for the call-site layout.) */
/* MATCH (w52-a2): 95 -> 25 diffs, frame 56 -> 48 (= retail).  Four levers, in the order they
 * landed -- each one gated individually:
 *  (1) `volatile int chcr` PARAM.  Retail reads the 5th (stack-passed) argument at its POINT
 *      OF USE (`lw $v0,0x40($sp)` right before the CHCR store).  Ours copied it into a 6th
 *      callee-saved register ($s5) in the prologue, which grew the frame by 8 and shifted
 *      EVERY incoming stack-arg displacement (arg6 read at 0x4C instead of 0x44).  Marking the
 *      parameter `volatile` keeps it in its incoming home and loads it once, at the store.
 *      95 -> 67, frame exact.
 *  (2) The two `__asm__ __volatile__("")` SCHEDULING BARRIERS -- transplanted verbatim from the
 *      byte-exact Rage Racer decomp's identical routine (C:/Temp/rage-racer-decomp/src/main/
 *      PAL/lib/libcd/dma_start.c, CD_dmastart: one after the DICR read-back, one after
 *      `bit = 1 << (dv+3)`).  Without them sched1 interleaves the DPCR/bit/p computation into
 *      the DICR read-back's two load-delay gaps; retail keeps that read-back SERIAL
 *      (`lui; lw; nop; lw; nop; sw`).  67 -> 65 and the whole DICR region became byte-exact.
 *  (3) READ-ONLY FENCE on `bv` after the if/else (allocno DEMOTE dial, W49 fence-direction
 *      law): lengthening bv's live range drops its priority so `dptr` wins the lower register
 *      -- retail has dptr=$v1 / bv=$a0, ours had them swapped.  65 -> 47.
 *  (4) IDENTITY FENCES (PROMOTE dial, +2 refs each) on `bit` (x2) and `dp` (x1): retail's
 *      fill order is bit($v1) > dp($a0) > p($a1) > dv($a2); ours was dv > p > bit > dp.  The
 *      `bit` pseudo has only 2 refs, so its allocno numerator floor_log2(refs)*refs - SIZE is
 *      NEGATIVE -- one fence was not enough, two were.  47 -> 39 -> 31 -> 25.
 * Rage Racer needed `register long bv asm("$4")` / `register long dv asm("$6")` for the same
 * two registers; the fences reach $a0 and $v1 pin-free.
 * RESIDUAL 25 = (a) `dv` colors $v0 where retail has $a2, and (b) ONE extra `li $v0,1` reorg
 * speculates into the busy-wait entry branch's delay slot.  NAMED ANGLE for (a) (numeric-scan
 * law): retail's $v0 is occupied across dv's whole window by the BCR value
 * (`sll $v0,$s3,16` scheduled UP into the DPCR load's delay gap), so $v0 is not free when dv
 * fills; ours computes BCR after dv dies.  FALSIFIED so far: hoisting BCR into a named local
 * W61-A8: the PLACEMENT axis of the BCR hoist is now falsified too (the CD_newmedia lesson
 * that fence position is a separate dial from fence choice does NOT transfer here): with
 * `bcr_` hoisted above `dp = _dpcr`, a read-only fence placed AFTER its real consumer
 * (`*p++ = bcr_`, so the live range genuinely spans dv), the same with two operands, an
 * identity fence there, and a read-only fence at the `dv = *dp` line are ALL exactly 25;
 * both fences together cost 46.  The hoist alone is 25 (inert), reconfirming w52-a2.
 * before `dp = _dpcr` / before `dv = *dp` (sched1 sinks it straight back, 25), the same with a
 * read-only fence pinning it (25), read-only/identity/volatile fences on `p` (31, +2 insns),
 * read-only fences on dv at either def (25/33), a 3rd `bit` fence (25), and a void-tail fence
 * before the mode test for (b) (27).  Next dial: make the BCR value's live range genuinely
 * span dv (a second consumer), or an out-of-loop ref-step on dv.
 * W63-A6: re-gated at 25 @107/106 and the VOID-BARRIER POSITION axis is now CLOSED -- a
 * mechanical sweep inserting a zero-insn `__asm__("" : : "i"(0))` before every statement in
 * the body (scratchpad/w63a6/fencesweep.py) found no position under 25.  Recorded as a real
 * negative: the SAME sweep moved this TU's StCdInterrupt 36 -> 27, so the axis was live.
 *
 * W72-A16 re-gate: 25 @107/106.  The wave's TWO NEW INSTRUMENTS -- the 20B ZERO-INSN
 * HARD-REGISTER CONFLICT (which retired CD_init's `qty_phys_sugg` certificate outright)
 * and the 2-OUTPUT TIED IDENTITY LAUNDER (which sealed CdRead by equalising two
 * independent sched1 chains) -- were both applied here and BOTH FAIL, so the two clusters
 * are re-classified rather than merely re-measured.
 *  (a) THE EXTRA `li $v0,1`.  The oracle materialises the constant 1 ONCE and fills the
 *      busy-wait guard's `beqz` slot with `lui $a2,1` (the 0x10000 limit); ours duplicates
 *      `li $v0,1` into that slot and keeps its own copy at the mode test.  The reorg-only
 *      barrier that this wave found (a NON-VOLATILE launder: reorg.c stop_search_p stops
 *      at ANY `asm_noperands >= 0` insn, so it blocks a thread steal WITHOUT the sched1
 *      barrier a void/read-only fence brings) was tried at the head of the target thread
 *      and is blocked by the 21A-3 dead-launder rule: `i` is DEAD after the loop so its
 *      launder is deleted (25, inert), and every value that IS live there is load-bearing
 *      elsewhere -- launder `mode` 43, `ch` 27, `madr` 39, `blocksize` 43, `blocks` 41, a
 *      `g = ch` round-trip 27.  The plain void barrier remains 27 (w62's reading).
 *      ⚠️ NEW TOOL LIMIT found here: a 2-output tied launder over two PARAMETERS
 *      (`"=r"(ch), "=r"(madr)`) CRASHES cc1 ("abnormal program termination") -- tie the
 *      device to locals only.
 *  (b) THE BCR/ADDRESS EMISSION ORDER.  Retail fills the `lw $a2,0($a0)` load-delay gap
 *      with the two BCR insns (`sll $v0,$s3,16; or $v0,$v0,$s4`) and reuses $a2 for the
 *      DPCR read-modify-write; ours fills that gap with the `p` address add and computes
 *      BCR after the stores.  The 2-output tied launder is the natural instrument for a
 *      sched1 chain-length tie -- and it is NET-NEGATIVE at every pairing: (bcr, p) 53,
 *      (p, bcr) 53, (bcr, dp) 53, (bcr, bit) 47, a laundered `bcr_` after the `dp` fence
 *      48, `bcr_` computed between the load and the store WITHOUT a fence 25 (inert, cse
 *      re-sinks it).  Hard-register denial is equally inert or worse: a "$2" clobber added
 *      to the FIRST `bit` fence 25, to BOTH 25, to the `dp` fence 25, "$6" on the `dp`
 *      fence 25, a split `sh = ch*4` with a "$2"-clobbered launder 31, a "$6"-clobbered
 *      `p` launder 31, a "$2"-clobbered launder on the second `dv` 35.
 *      ⇒ RE-CLASSIFICATION: (b) is NOT an allocation tie the 20B family can dial.  Every
 *      device that could reach it needs an insn in the load-delay gap, and any asm we can
 *      put there IS an insn (or a barrier that stops the fill).  The remaining named angle
 *      is unchanged in kind but sharper: give the BCR value a SECOND CONSUMER so its chain
 *      genuinely outlives `dv` (a real use after the stores), rather than trying to pin its
 *      position -- that is the only way its sched1 priority rises without adding an insn.
 * ALSO RE-CONFIRMED: the else-arm VOLATILE-READ construct that sealed StCdInterrupt this
 * TU does NOT recur here -- the two `if (mode == 1)`/`else` arms already match byte for
 * byte in the current basin (the diff hunks are entirely outside them), so there is no
 * un-merged-arm insn supply to recover.
 *
 * W74-A14 re-gate: 25 @107/106.  Both named angles executed; both close, and the two
 * clusters are re-classified again -- this time from the compiler sources.
 *  (a) THE EXTRA `li $v0,1`, MECHANISM NOW EXACT.  Our .s (build/.../stcdint.c.s) shows
 *      `.set noreorder / beq $2,$0,$L86 / li $2,0x00000001` with a SECOND `li $2,1`
 *      emitted just BEFORE `$L86:` -- that is fill_eager_delay_slots taking the TARGET
 *      thread, copying the target insn (own_target == 0, so copy_rtx) and redirecting the
 *      branch past it (reorg.c:3455 fill_slots_from_thread + the `new_thread != thread`
 *      redirect at :3806).  Retail took the FALL-THROUGH thread instead, whose first insn
 *      is the loop-invariant `li $6,0x10000` that loop.c hoisted into the preheader --
 *      taking it costs ZERO text, which is why retail is one insn shorter.
 *      mostly_true_jump (reorg.c:1353) returns 0 for this EQ condition, so fill_eager
 *      tries fall-through FIRST; ours therefore FAILED on `li $6,0x10000` and fell
 *      through to the target.  It is not a length problem: large_int (mips.c) returns
 *      FALSE for 0x10000 because its low 16 bits are zero, so the insn is a 1-word `lui`
 *      and eligible_for_delay accepts it.  NEXT INSTRUMENT (not blind sweeps): dump the
 *      RTL at .dbr with the instrumented cc1 and read which of the three
 *      fill_slots_from_thread guards rejects it (opposite_needed / own_fallthrough /
 *      eligible_for_delay) -- every source-level dial for this cluster has now been swept
 *      (w63-a6 whole-body void-barrier sweep, w72-a16 launder sweep, and the general law
 *      re-confirmed on _read_issue this wave: BLOCKING one thread never buys the other,
 *      it only buys a `nop`).
 *  (b) THE BCR/ADDRESS EMISSION ORDER -- the "give BCR a second consumer" angle is now
 *      FALSIFIED IN PRINCIPLE, not just unmeasured.  Retail itself has exactly two BCR
 *      insns and exactly ONE consumer (`sw $v0,0($a1)`), so a genuine second consumer does
 *      not exist to be recovered -- any we add is a real insn.  What retail actually has is
 *      a different sched1 SUPPLY: it finishes the WHOLE `p` address (`lui $a1;ori $a1;
 *      sll $v0,$s0,4; addu $a1,$v0,$a1`) BEFORE the `lw $a0,_dpcr`, so the only work left
 *      for the `lw $a2,0($a0)` load-delay gap is the BCR pair; ours leaves `sll $a1,$s0,4`
 *      + `addu $a1,$a1,$a2` for that gap and sinks BCR below the stores.  REMOVING THE
 *      COMPETITOR IS INERT: (scratchpad/W74_A14_dma2.json, all gated + reverted) computing
 *      `p` only AFTER the DPCR read-modify-write 25, + a named `bcr` hoisted above the
 *      DPCR block 25, `bcr` hoisted with `p` still before 25 -- all BYTE-IDENTICAL to the
 *      control.  ⇒ extend the w64-a6(iii) verdict: it is not merely that six SPELLINGS of
 *      the address fold together, it is that the whole region's emission order is decided
 *      by sched1 from a dependency DAG that every legal STATEMENT ORDER produces
 *      identically.  Only a DAG change could move it, and none is available without an
 *      insn.  (The in-place base mutation `p = 0x1F801080; p += ch << 2;` -- 3.12 #14, the
 *      shape that would give retail's `addu $a1,$v0,$a1` dest-is-the-BASE form -- is
 *      re-priced at 33 alone, 33 with the bcr hoist, 33 computed after the RMW, 33 with
 *      both: unchanged from w62-a7.)
 *      ALSO NEW AND NEGATIVE: the 22B-1 clobber-live-range law applied properly to `dv`.
 *      Every previously-measured clobber sat OUTSIDE dv's live range (on the `dp` or `bit`
 *      fences), and dv's range is the single gap between `dv = *dp;` and `*dp = dv | bit;`
 *      -- which has no statement in it.  Splitting the two and placing a BARE zero-ref
 *      clobber inside (scratchpad/W74_A14_dma.json): "$2" 25 (INERT -- the denial does NOT
 *      move dv off $v0), "$4" 25, "$6" 25, "$2","$4" 25, "$2","$8" 25, "$2" placed after
 *      the store 25 (the negative control), while "$3" 32, "$2","$3" 32, "$2","$3","$4" 32,
 *      "$5" 33, "$2","$5" 33.  ⇒ 22B-2's "manufacture the missing hard-reg conflict" does
 *      NOT reach a pseudo whose only def is the load feeding the very next insn: there is
 *      no allocation decision left to deny. */
extern void _st_dma(int ch, int madr, int blocks, int blocksize, volatile int chcr,
                    u_char enable_irq, int arg6)
{
    volatile int  dummy;
    int           i;
    volatile int *p;
    u_char       *dptr;
    volatile int *dp;
    int           bv;
    int           mode;
    (void)arg6;

    mode = enable_irq;
    i = 0;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }

    if (mode == 1) {
        dptr = (u_char *)_dicr;
        bv = dptr[2];
        dptr[2] = bv | (1 << ch);
    } else {
        dptr = (u_char *)_dicr;
        bv = dptr[2];
        dptr[2] = bv & ~(1 << ch);
    }

    /* RESIDUAL 25 (w62-a7 re-gate, ours 107 / oracle 106 = 1 LONG).  Two clusters:
     * (a) ours emits an EXTRA `li v0,1` in the busy-wait guard's `beqz` delay slot
     *     (reorg rematerialises the `mode == 1` constant there) where retail fills that
     *     slot with `lui a2,1` (the 0x10000 limit) and materialises the 1 only once;
     * (b) retail computes the BCR word BEFORE the DPCR read-modify-write and reuses the
     *     BASE constant's register for the channel address (`addu a1,v0,a1`) where ours
     *     reuses the shift temp's (`addu a1,a1,a2`).
     * FALSIFIED W62-A7 (all gated + reverted): a named `bcr` local before the DPCR update
     * 25 (INERT -- cse hoists the expression there anyway), `bcr` at the block top 39,
     * the mode test straight off the u_char parameter (no `mode` copy) 37, both 37, the
     * channel address as a mutated pointer (`p = 0x1F801080; p += ch << 2;`) 33, and that
     *
     * W64-A6 -- THREE MORE AXES CLOSED, all measured in the CURRENT basin (04Z):
     * (i) COMPILER LADDER re-run after w63's StCdInterrupt landing (rungs driven with
     *     NFS4_FORCE_CC1_ALT through the 272 recipe): 2.6.0 25 / 2.6.3 25 / 2.7.2 25
     *     (the wired lane) / 2.7.2-970404 81 / 2.8.0 74 / 2.8.1 77.  The wired 2.7.2 is
     *     optimal and the sub-2.8 rungs are merely equal -- no version lever here.
     * (ii) EVERY LANDED FENCE IN THIS FUNCTION IS LOAD-BEARING (the w64 CdRead lesson --
     *     an inherited fence can itself be the blocker -- was tested here and does NOT
     *     apply): drop the `bv` read-only fence 43 / drop the two `bit` identity fences
     *     39 / keep only ONE `bit` fence 31 / add a THIRD 25 (saturated) / drop the `dp`
     *     identity fence 39 / drop the FIRST __volatile__ barrier 37 @105 / drop BOTH
     *     barriers 41 @105.  Only the SECOND __volatile__ barrier is inert (25) -- it is
     *     kept as documentation of the Rage-Racer CD_dmastart shape.
     * (iii) The cluster-(b) address/BCR EMISSION ORDER is a STRONG structural floor:
     *     SIX distinct source spellings compile BYTE-IDENTICALLY (25 @107) --
     *     `int base` + index-first sum, `int base` + base-first sum, literal index-first
     *     sum, `p` computed before `dp`, a named `bcr` hoisted above the DPCR RMW, and
     *     base+bcr together.  cse/RTL canonicalisation absorbs the whole family, so the
     *     `addu a1,v0,a1` vs `addu a1,a1,a2` operand/dest tie (12D qty_combine) is not
     *     reachable from C here.  Fencing the `bcr` temp instead COSTS 2 insns (53 @109).
     *     Also re-confirmed inert: naming the 0x10000 busy-wait limit (27, slightly
     *     worse -- it does NOT move retail's `lui a2,1` into the guard's delay slot).
     * with `bcr` 33. */
    __asm__("" : : "r"(bv));   /* MATCH: DEMOTE bv (read-only fence) so dptr wins $v1 */
    dummy = *(volatile int *)_dicr;
    __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier -- keep the DICR read-back serial */
    {
        int dv;
        int bit;

        dv  = ch * 4;
        bit = 1 << (dv + 3);
        __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier */
        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: PROMOTE bit -> $v1 (2 refs => negative */
        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: allocno numerator; needs TWO fences)   */
        p   = (volatile int *)(0x1F801080 + (ch << 4));
        dp  = _dpcr;
        __asm__("" : "=r"(dp) : "0"(dp));  /* MATCH: PROMOTE dp -> $a0 (p then takes $a1) */
        dv  = *dp;
        *dp = dv | bit;
        *p++ = madr;                                /* MADR */
        *p++ = (blocks << 16) | blocksize;          /* BCR  */
        while ((*_cd_idx & 0x40) == 0)              /* wait until the CD is ready to DMA */
            ;
        *p = chcr;                                  /* CHCR -- kick the transfer */
        dummy = *p;
    }
}
