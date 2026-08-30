/* syslib/psx/libcd/drv.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3), structurally
 *   re-derived from the canonical PsyQ libcd BIOS.OBJ source (cf. SOTN psxsdk libcd/bios.c).
 *   The low-level CD-ROM driver core that cdcont.cpp wraps: the command-write / event-poll state
 *   machine that talks to the CD-ROM controller (CDREG0-3, reached through CACHED register pointers
 *   in the driver globals @0x8013C20C..) and pulls sector data over DMA channel 3.
 *
 *   STRUCTURE NOTE: the original INLINES set_alarm / get_alarm / callback into each of CD_sync /
 *   CD_ready / CD_cw / CD_datasync (they are `static inline` helpers, NOT separate functions).
 *   getintr is a real out-of-line function (func_80107080).  An earlier reconstruction factored the
 *   inlined helpers out into _cd_arm_timeout/_cd_timed_out/_cd_drain which made the big CD_* bodies
 *   structurally far smaller than the oracle.
 *
 *   HW registers are reached through pointer globals the driver caches at init (D_8013C20C = &CDREG0,
 *   etc.) -- the original does `*(volatile u_char*)D_8013C20C`, NOT a literal MMIO store.
 *
 * W52-A1 RECEIPT (2026-08-09).  The whole TU was re-shaped against the byte-exact RAGE RACER
 * libcd decomp (C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/{command_sync,command_ready,
 * command_write,data_sync,interrupt_status}.c) -- ALL of its register-asm pins DROPPED.
 * verify_asm, wired cc1_272 lane, before -> after:
 *   CD_get_intr 368 -> 74 (count-EXACT 343/343)   CD_sync   91 -> 36 (EXACT 160/160)
 *   CD_ready    102 -> 36 (EXACT 178/178)         CD_cw    199 -> 134 (255/259)
 *   CD_datasync  42 -> 22 (EXACT 90/90)           0 PASS regressions (6 PASS held).
 * The five load-bearing levers, each transferring across several functions:
 *   (1) _spin_bump()  -- REGISTER post-increment for the watchdog counter (the oracle's
 *       `addu v1,v0,zero` copy); (2) _memcpy8 rewritten as the down-counting do/while against
 *       a named -1 sentinel; (3) volatile stack `nReg`/`result[8]` in CD_get_intr (the
 *       `sb 16(sp)`/`lbu 16(sp)` round-trip, and no giv on the buffer); (4) explicit
 *       loop-invariant locals for CD_comstr/CD_intstr/&Intr in the poll loops; (5) `u_char com`
 *       + the `_cd_result_flag[0x40+com]` shared table base + a pointer base for the Intr clears
 *       in CD_cw.  The `const` on _cd_result_flag/_cd_param_count had to GO: retail RELOADS the
 *       param count every iteration (A/B: restoring const costs CD_cw 134 -> 167).
 * LADDER (04U): whole-TU A/B over 2.6.0 / 2.6.3 / 2.7.2-970404 / 2.7.2 / 2.8.0 / 2.8.1 /
 *   2.91.66 / 2.95.2 -- the WIRED 2.7.2 rung wins outright (TU total 339 vs 415 for 2.6.3,
 *   which also loses _cd_intr_dispatch's PASS).  NO cc1_alt change; keep `cc1_272`.
 * FLAG: `no_strength_reduce` is a clean whole-TU win in this lane -- CD_get_intr 74 -> 61,
 *   CD_cw 134 -> 90, every other function bit-identical, all 6 PASSes held.  RECOMMENDED for
 *   wiring; no_builtin is inert, no_delayed_branch / no_schedule_insns / no_schedule_insns2
 *   all regress.  (Once wired, the walker-vs-index residual in CD_cw's two param loops goes.)
 * W53-A9 RECEIPT (2026-08-09) -- the w52 "OPEN, NAMED" timeout-printf sched1 block is CRACKED.
 *   THE LEVER (asymmetric arg splitting; see the block comment in CD_datasync): the READY status
 *   name as a whole named local, and the SYNC arg's INDEX BYTE ONLY as another -- the sync STRING
 *   stays inline so its load lands last, exactly as the oracle has it.  That gives the RTL the
 *   oracle's evaluation order and sched1 then reproduces the whole block.  Measured on
 *   CD_datasync (gate, count-exact 90/90 throughout): inline 22 | both strings 12 | sync string
 *   12 | ready string 20 | both index bytes 22 | &intstr[i] slot 12 | READY-string + SYNC-index
 *   >>> 8 <<< | + syncSlot ptr 12 | + identity/read-only fence on syncIdx 17 (+1 insn) | syncIdx
 *   hoisted above puts() 53 | ready-assigned-first 20.  Applied to CD_sync (36 -> 22), CD_ready
 *   (36 -> 22), CD_datasync (22 -> 8).  It does NOT transfer to the shared get_alarm() copy that
 *   CD_cw inlines (90 -> 93, and 84 -> 87 after the store-flag breaker below) -- different basin.
 *   RESIDUAL 8 x3, NAMED: one register.  The oracle runs the sync index chain in a SEPARATE
 *   scratch ($a0: `lbu a0; sll a0; addu a0,a0,s0; lw a3,0(a0)`) while ours self-temps it in the
 *   arg register ($a3 throughout).  Everything else in the block is byte-identical.  Next angle =
 *   the local-alloc QTY layer (the whole arg block is ONE basic block, so these are block-local
 *   qtys, not global allocnos): allocsim/reqdelta on the chain qty vs the $LC5 (format-string)
 *   qty, which is what currently owns $a0 at allocation time -- the fence route is measured
 *   NEGATIVE here (+1 insn) and the ref-step re-mask inflator is measured NEUTRAL.
 * W53-A9 also: CD_cw 90 -> 84 (STORE-FLAG BREAKER on the return, see the tail) and the CdControlF
 *   PASS in cdcont.c (int command parameter + the RR identity fences).
 *
 * W55-A5 RECEIPT (2026-08-09) -- the 8x3 residual is now MECHANISM-EXPLAINED (RTL-evidenced,
 *   `-dg -dl` dumps of the wired 2.7.2 lane via scratchpad/w55a5_rtl.py):
 *     the whole printf arg block IS one basic block, so every value in it is a LOCAL-ALLOC qty
 *     assigned by find_free_reg's NUMERIC first-free scan (MIPS defines no REG_ALLOC_ORDER).
 *     `used` = fixed_regs | every hard reg live over [qty_birth, qty_death).  Our sync-chain
 *     qtys are p106 (`sll`, insns 114-116) and p107 (`addu`, 116-126); over BOTH ranges $v0 is
 *     held by the CD_com chain (p104, 111-124) and $v1 by readyName (p90, 98-118), so the scan
 *     falls through to... $a0 -- EXCEPT that sched1 hoisted `(set (reg:SI 4 a0) (symbol_ref
 *     "*$LC5"))` (the FORMAT-STRING arg) from its emission point (RTL insn 120, after the whole
 *     chain) up to between insns 106 and 118.  That makes $a0 live across 114-126, the scan skips
 *     $a0/$a1/$a2 and lands on $a3.  Retail's local-alloc saw the $LC5 set still LATE, so $a0 was
 *     free and the chain got it; sched2/reorg then re-sank the `lui $a0` in BOTH builds, which is
 *     why the FINAL instruction ORDER is byte-identical and only the register differs.
 *     ==> THE DIAL IS NOT the chain qty and NOT a fence -- it is the sched1 POSITION of the
 *     $LC5 a0-set.  allocsim/reqdelta do NOT model this (they read the GLOBAL allocno table out
 *     of `.greg`; this decision is entirely local-alloc + sched1, the 06E "local-alloc QTY
 *     handouts outside allocsim's model" gap).  FALSIFIED this wave (all still 8, or worse):
 *     naming the format string as a local (8) / naming it first (8) / + an identity fence on it
 *     (47) / `unsigned char syncIdx` (8) / identity fence on syncIdx (17) / naming
 *     `comstr[CD_com]` (22) / a `syncSlot` pointer (12).  Per-fn `-fno-schedule-insns` splice
 *     PROVEN (scratchpad/w55a5_splice.py) = 14, `-fno-schedule-insns2` 37, `-fno-delayed-branch`
 *     17 -- sched1-off does move the a0-set back but re-orders the rest.  gcc LADDER re-run and
 *     CLOSED for this TU: 2.7.2 == WIRED on all 7 fns; 2.6.0/2.6.3 equal-or-worse; every 2.8+
 *     rung is catastrophic (CD_datasync 77, CD_get_intr 271).  NEXT ANGLE (named, unmeasured):
 *     an insn-level sched1 instrument -- a PER_FN_TEXT_MOVES-style pass cannot help (the final
 *     text already matches), so this needs either a cc1 `-dS`/sched-dump-driven priority dial or
 *     acceptance.  Same one-register residual x3 (CD_datasync 8, CD_sync 22, CD_ready 22 -- the
 *     latter two carry two/three MORE independent clusters, see their own notes). */

typedef int (*CdlCB)(int intr, unsigned char *result);

/* ---- cached HW-register pointers (driver globals, defined in asm/data @0x8013C20C..) -----------
 *   The driver caches each CD/SPU/DMA register address in a word at init; every access dereferences
 *   the cached pointer (matches the oracle's `lui %hi(D_8013Cxx); lw; sb/lbu`). */

static volatile unsigned char  *reg0; /* &CDREG0 */
static volatile unsigned char  *reg1; /* &CDREG1 */
static volatile unsigned char  *reg2; /* &CDREG2 */
static volatile unsigned char  *reg3; /* &CDREG3 */
static volatile unsigned int   *com_delay;
static volatile unsigned short *spu;
static volatile unsigned int   *dv5_delay;
static volatile unsigned int   *d_pcr;
static volatile unsigned int   *d3_madr;
static volatile unsigned int   *d3_bcr;
static volatile unsigned int   *d3_chcr;

/* Address-style compatibility spellings remain only in existing function
 * commentary/expressions; emitted symbols use the archived C identifiers. */
#define D_8013C20C reg0
#define D_8013C210 reg1
#define D_8013C214 reg2
#define D_8013C218 reg3
#define D_8013C21C com_delay
#define D_8013C220 spu
#define D_8013C240 dv5_delay
#define D_8013C244 d_pcr
#define D_8013C248 d3_madr
#define D_8013C24C d3_bcr
#define D_8013C250 d3_chcr

#define CDREG0  (*reg0)
#define CDREG1  (*reg1)
#define CDREG2  (*reg2)
#define CDREG3  (*reg3)

/* ---- externs (kernel / other libs) ----------------------------------------------------------- */
extern int  VSync(int mode);
extern int  CheckCallback(void);
extern void ResetCallback(void);
extern void InterruptCallback(int n, void (*cb)(void));
extern int  puts(const char *s);
extern int  printf(const char *fmt, ...);

extern void CD_flush(void);
extern int  CD_sync(int mode, unsigned char *result);
extern void _cd_intr_dispatch(void);   /* @0x80108680 -- defined LAST in this TU (retail VA order) */

/* BIOS.OBJ starts with Sony's two-word library-info record, followed by the
 * driver state in the exact order exposed by the archived ECOFF symbols and
 * the retail CPE.  This TU is compiled on the -G0 2.7.2 library lane, so these
 * definitions stay in ordinary .data and retain the absolute accesses used by
 * retail. */
unsigned int __ps_libinfo__[2] = { 0x26047350, 0x10432df4 }; /* @0x8013BF40 */
int           CD_cbsync = 0;       /* @0x8013BF48 */
int           CD_cbready = 0;      /* @0x8013BF4C */
int           CD_debug = 0;        /* @0x8013BF50 */
int           CD_status = 0;       /* @0x8013BF54 */
int           CD_status1 = 0;      /* @0x8013BF58 */
int           CD_nopen = 0;        /* @0x8013BF5C */
unsigned char CD_pos[4] = {2,0,0,0}; /* @0x8013BF60 */
unsigned char CD_mode = 0;         /* @0x8013BF64 */
unsigned char CD_com = 0;          /* @0x8013BF65 */
int           DS_active = 0;       /* @0x8013BF68 */


/* The 3-byte interrupt-state struct {sync, ready, c} @0x8013C224. */
struct CD_intr { unsigned char sync, ready, c; };
typedef struct CD_intr CD_intr;
typedef struct {
    CD_intr *intr;
    unsigned char *result;
    unsigned char *cd_com;
    int *cd_status;
    unsigned char *cd_pos;
    const char *rcsid;
} CD_init_struct;
static volatile CD_intr Intr __asm__("D_8013C224");
/* Intr is the archived BIOS.OBJ identifier (in the fixed driver data region).
 * MATCH (w51-a4): `volatile` is CORRECT and is the retail shape -- the byte-exact Rage Racer
 * libcd decomp declares the same struct `extern volatile CdIntr g_CdSyncStatus;`
 * (C:\Temp\rage-racer-decomp\include\psyq\cd_internal.h:54); it is mutated by the CD IRQ
 * behind the compiler's back (methodology §3.12 #13).  The earlier "DO NOT mark volatile"
 * receipt (w24-a1) measured it on the gcc-2.8/cc1plpsx lane, where it IS a mild net loss.
 * On the gcc-2.7.2 lane (`cc1_272`, the proven Sony-library toolchain) it is a large NET WIN:
 *   CD_sync 95->91, CD_ready 126->102, CD_cw 225->199, CD_datasync 60->42,
 *   _cd_intr_dispatch 26->PASS, CD_init 31->24 (count-exact 120/120); CD_flush unchanged 13.
 * Zero PASS->FAIL on EITHER lane.  Keep it paired with the cc1_272 lane recommendation. */
/* BIOS.OBJ's two BSS objects: Result[3] followed by Alarm.  Compatibility
 * aliases for the three result rows remain declared because two verified
 * text-move anchors key on their historical address labels. */
typedef unsigned char CD_result[8];
extern CD_result Result[3];
extern unsigned char D_8014899C[8];
extern unsigned char D_801489A4[8];
extern unsigned char D_801489AC[8];
/* ======================== W65-A6 DATA-MAT: drv.obj's BSS run @0x8014899C ==================
 * BEFORE: D_8014899C/A4/AC were C tentative definitions.  This TU compiles on the cc1_272 lane
 * (macro cc1 + direct GNU as, NO maspsx), so a tentative def stays a genuine `.comm` = a
 * COMMON symbol -- and ld places COMMONs wherever it likes, so NONE of them could ever reach
 * its retail VA (W62-A18 T6 / W64-A19 sec.3.4).  D_801489B4 was worse: extern-only with 56
 * reloc sites, the single biggest undefined in syslib, "defined" only by a hard-coded
 * `D_801489B4 = 0x801489B4;` row in linkers/undefined_syms_auto.txt -- an address with no
 * storage behind it.
 * AFTER: one file-scope asm `.section .bss` block owns the whole 36-byte run at its exact
 * retail offsets (all VAs > t_addr+t_size 0x8013E000 => pure zero-init BSS, no file bytes):
 *      D_8014899C  8  sync result   | D_801489A4 8 ready result | D_801489AC 8 data-end result
 *      D_801489B4  4  alarm deadline| D_801489B8 4 spin counter | D_801489BC 4 op-name ptr
 *      (the last three are the ONE 12-byte CD_alarm object modelled below)
 * The C view of all six stays `extern`, so cc1 sees exactly what it saw before this change and
 * the storage is byte-neutral BY CONSTRUCTION -- drv.c re-gates 11/13 with both residuals
 * (CD_init_80108140 @10, CD_cw @18) at their pre-existing counts.
 * Labels, never `sym = base+N`: ASPSX 2.77 has no symbol-assignment form (catalog 15E).
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
/* alarm/timeout state is part of the driver's fixed data block.  These need
 * external linkage so each inlined polling helper uses absolute references,
 * as in the oracle, rather than gp-relative small-BSS accesses. */
/* W63-A5: the three are ONE 12-byte alarm object.  Both matched sibling libcd
 * decomps model it that way (sotn-decomp psxsdk/libcd/bios.c `volatile Alarm_t
 * Alarm`; rage-racer-decomp libcd/command_write.c `((CdAlarm *)&g_CdTimeoutDeadline)
 * ->name`).  Kept as a VIEW so the three data symbols stay owned as-is. */
typedef struct { int deadline; int counter; char *name; } CD_alarm;
extern volatile CD_alarm Alarm;
/* PsyQ declares the object volatile but its inline helpers intentionally use
 * a non-volatile typed view, as the matched SDK sources do. */
#define ALARM (*(CD_alarm *)&Alarm)

/* BIOS.OBJ-owned command/interrupt names.  PsyQ 4.3's archived BIOS.O and
 * the retail CPE agree byte-for-byte on this pool and on its placement ahead
 * of the driver's remaining literals.  Keeping these definitions in the
 * driver TU also restores their true object ownership from the SYM/MAP
 * layout; the historical standalone cddebug.c split could not reproduce it. */
char *CD_comstr[32] = {                    /* @0x8013BF6C */
    "CdlSync",     "CdlNop",       "CdlSetloc",  "CdlPlay",
    "CdlForward",  "CdlBackward",  "CdlReadN",   "CdlStandby",
    "CdlStop",     "CdlPause",     "CdlReset",   "CdlMute",
    "CdlDemute",   "CdlSetfilter", "CdlSetmode", "?",
    "CdlGetlocL",  "CdlGetlocP",   "?",          "CdlGetTN",
    "CdlGetTD",    "CdlSeekL",     "CdlSeekP",   "?",
    "?",           "?",            "?",          "CdlReadS",
    "?",           "?",            "?",          "?"
};

char *CD_intstr[8] = {                     /* @0x8013BFEC */
    "NoIntr", "DataReady", "Complete", "Acknowledge",
    "DataEnd", "DiskError", "?", "?"
};

/* BIOS.OBJ owns one 128-word local aggregate named ComAttr.  Its ECOFF symbol
 * starts at data+0xCC and the next local, reg0, starts exactly 0x200 bytes
 * later.  The four views below preserve the established source expressions
 * while restoring that authoritative object boundary. */
static int ComAttr[128] = {               /* @0x8013C00C */
    0,0,0,0,0,0,0,1, 1,1,1,0,0,0,0,0, 0,0,1,0,0,1,1,0, 0,0,1,0,0,0,0,0,
    0,0,0,1,1,1,1,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,0, 0,0,0,1,0,0,0,0,
    1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1, 0,0,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,
    0,0,3,0,0,0,0,0, 0,0,0,0,0,2,1,0, 0,0,1,0,1,0,0,0, 0,0,0,0,0,0,0,0
};
#define _cd_int3_ack    (ComAttr)
#define _cd_result_flag (ComAttr + 0x20)
#define _cd_status_ok   (ComAttr + 0x40)
#define _cd_param_count (ComAttr + 0x60)

/* Archived BIOS.O local names, retaining their established assembler labels
 * so the already-verified instruction stream and linker anchors stay exact. */
static volatile unsigned char  *reg0      = (volatile unsigned char *)0x1f801800;
static volatile unsigned char  *reg1      = (volatile unsigned char *)0x1f801801;
static volatile unsigned char  *reg2      = (volatile unsigned char *)0x1f801802;
static volatile unsigned char  *reg3      = (volatile unsigned char *)0x1f801803;
static volatile unsigned int   *com_delay = (volatile unsigned int *)0x1f801020;
static volatile unsigned short *spu       = (volatile unsigned short *)0x1f801c00;
static volatile CD_intr Intr __asm__("D_8013C224") = {0,0,0};

/* Result[3][8] and Alarm occupy BIOS.O's contiguous 36-byte BSS tail.  Keep
 * the established external labels until the local-name migration is gated. */
__asm__("\t.section\t.bss\n\t.align\t2\n"
        "Result:\nD_8014899C:\n\t.space\t8\n"
        "D_801489A4:\n\t.space\t8\n"
        "D_801489AC:\n\t.space\t8\n"
        "Alarm:\n\t.space\t12\n\t.align\t4\n\t.text");

/* StMode is the final isolated BIOS.obj BSS word @0x801489CC.  It was
 * previously grouped into the synthetic stream.c TU. */
__asm__("\t.globl\tStMode\n"
        "\t.section\t.bss.st_801489CC,\"aw\",@nobits\n\t.align\t2\n"
        "StMode:\n\t.space\t4\n\t.text");

/* ------------------------------------------------------------------------------------------------
 * getintr  (func_80107080) -- acquire one CD-ROM controller interrupt: read+stabilise the code,
 *   drain the response FIFO, acknowledge, update status, route the result into the sync/ready/done
 *   buffers, and return a dispatch code (1/2/4/6) or 0 if nothing pending.  Out-of-line function.
 * ---------------------------------------------------------------------------------------------- */
/* MATCH (w52-a1): the 8-byte result copy is a DOWN-counting do/while against a
 * named `-1` sentinel, not an ascending indexed for-loop.  Oracle:
 *   li v1,7 / li a3,-1 / lbu / addiu src,1 / addiu v1,-1 / sb / bne v1,a3 / addiu dst,1
 * (shape from the byte-exact Rage Racer libcd decomp's copy8()).  An
 * `for(i=0;i<8;i++) dst[i]=src[i];` emits `addiu end,dst,8 ... slt; bnez` instead. */
static inline void _memcpy8(unsigned char *dst, unsigned char *src)
{
    unsigned char *d;
    unsigned char *s;
    int count;
    int end;

    d = dst;
    s = src;
    if (d == 0)
        return;
    count = 7;
    end = -1;
    do {
        *d++ = *s++;
    } while (--count != end);
}

/* MATCH (w52-a1): `nReg` and the 8-byte response buffer are VOLATILE STACK locals --
 * the oracle round-trips the decoded interrupt code through the frame (`sb v0,16(sp)`
 * immediately followed by `lbu v0,16(sp)`) and never strength-reduces the buffer
 * accesses into a walking pointer (`addu v1,a0,s0` per iteration).  Both are the shape
 * the byte-exact Rage Racer libcd decomp carries (interrupt_status.c: `volatile u_char
 * mode; volatile u_char buf[8];`), and both are semantically honest -- the CD IRQ can
 * fire between the two reads of the status register.  DECLARATION ORDER is the frame
 * layout: nReg @16(sp), result @24(sp).  `p` caches the CDREG3 pointer the oracle
 * loads once into $a0 and re-uses for every status read. */
/* MATCH (W60-A4, 61 -> 10, count-exact 343/343).  Five independent levers, each gated:
 *  (1) OPAQUE Intr BASE.  Retail reaches the Intr flag bytes through a REGISTER base
 *      (`lui v0; addiu v0,v0,0; sb v1,1(v0)` / `sb v1,2(v0)` / `lbu v1,2(v0)`), ours
 *      emitted the assembler's absolute macro `lui at; sb v0,Intr+N`.  A block-local
 *      `volatile u_char *b = &Intr` is NOT enough -- gcc const-folds the pointer straight
 *      back into the store address.  A zero-insn IDENTITY FENCE on the pointer makes it
 *      opaque, so the address is materialized once and every access becomes base+disp.
 *      cases 4+5: 56 -> 39.  case 1 (`Intr.ready = err?5:1`): 39 -> 33.  case 2 the SAME
 *      edit REGRESSES (39 -> 42) -- retail really does use the absolute macro there.
 *  (2) DOUBLE `CD_debug > 0` GUARD.  Retail tests CD_debug TWICE inside the nReg==5 arm
 *      -- once before `puts("DiskError: ")` and again before the printf.  (The guard is
 *      NOT cse-shared because the intervening puts() call may clobber the global.)  Ours
 *      called puts unconditionally.  61 -> 56.  This is a REAL BEHAVIOURAL FIX: retail
 *      does not print "DiskError: " when CD_debug is 0.
 *  (3) NON-VOLATILE ALIAS READ for the two constant compares.  `nReg` must stay
 *      `volatile u_char` (the `sb 16(sp)` / `lbu 16(sp)` round-trip depends on it), but a
 *      volatile QImode read cannot fold its zero-extend into the load, so `nReg != 3` /
 *      `nReg == 5` each emitted a redundant `andi v0,v0,255`.  Reading through
 *      `*(const unsigned char *)&nReg` at those two sites (and ONLY there -- the switch
 *      and the settle loop must keep the volatile form) folds the extend into the `lbu`
 *      exactly like retail.  33 -> 21.  FALSIFIED: plain non-volatile nReg (163),
 *      non-volatile + an "m" constraint (77), `(unsigned char)` casts on the constants
 *      (inert), the alias on the switch selector (inert).
 *  (4) TERNARY VALUE INTO A NAMED LOCAL BEFORE THE BASE in case 1 -- retail materializes
 *      the Intr base AFTER the 5/1 select; a bare `b[1] = err?5:1` materializes it first.
 *      21 -> 17.
 *  (5) `&result[i]` TAKEN BEFORE THE CDREG0 TEST in the fill loop -- retail fills the
 *      `beqz` delay slot with `addu v1,a0,s0` (the element address), which reorg's
 *      backward scan can only steal if the address is computed BEFORE the branch.
 *      17 -> 10.  Paired with the identity fence on `i` between the two loops: retail
 *      RE-EVALUATES `i < 8` as the second loop's entry guard where ours cse-shared the
 *      value it had speculated into the break-branch delay slot (fence on i: 17 -> 16;
 *      a void-tail fence between the loops scores the same 16; `j != 8` 25; while-form 17).
 * RESIDUAL 10, NAMED = PURE LINE ORDER (a PER_FN_TEXT_MOVES job, spec in the W60-A4
 *   receipt file): (a) 8 diffs = in switch cases 4 and 5 retail emits the _memcpy8
 *   DESTINATION `la` (`la $4,D_801489AC` / `la $4,D_8014899C`) BEFORE the Intr-base `la`
 *   (`la $2,D_8013C224`); ours emits the base first because the identity fence is a
 *   scheduling barrier the dest `la` cannot cross.  FALSIFIED at source level: a `dst`
 *   local declared before `b` (10, .s order unchanged), the same with the memcpy call
 *   pulled inside the block (10), an identity fence on `dst` as well (32).  (b) 2 diffs =
 *   ours steals `li v0,5` into the `beqz` delay slot where retail has a `nop`. */
/* ---- inlined alarm helpers (set_alarm / get_alarm) --------------------------------------------
 *
 * The PsyQ BIOS.OBJ and retail CPE place these helpers' timeout literals before
 * CD_get_intr's debug literals.  Static-inline bodies contribute no standalone
 * text here, but their source order controls gcc's literal-pool order. */

static inline void set_alarm(const char *name)
{
    ALARM.deadline = VSync(-1) + 0x3c0;
    ALARM.counter = 0;
    ALARM.name = (char *)name;
}

/* MATCH (w52-a1): the oracle's spin bump is `lw v0; addu v1,v0,zero; addiu v0,v0,1; sw v0`
 * -- a REGISTER post-increment (copy-out then in-place +1), NOT gcc's memory-postincrement
 * expansion (`lw v1; addiu v0,v1,1; sw v0`, one insn shorter, what a bare `D_801489B8++`
 * emits).  Reading the global into a local and post-incrementing THE LOCAL reproduces it:
 * the copy survives cse/delete_noop_moves because `c` is modified while `old` is still live
 * (catalog: "two values simultaneously live with different values => un-copy-propagatable"). */
static inline int _spin_bump(void)
{
    int c = ALARM.counter;
    int old = c++;
    ALARM.counter = c;
    return old;
}

static inline int get_alarm(void)
{
    if (ALARM.deadline < VSync(-1) || _spin_bump() > 0x3c0000) {
        /* w53-a9 FALSIFIED HERE (90->93, +1 insn): the CD_datasync/CD_sync
         * split-local lever does NOT transfer to this shared get_alarm() copy
         * -- CD_cw's inlined instance is 4 insns SHORT of its oracle, i.e. a
         * different (structural) basin.  Re-probe after CD_cw's count is exact. */
        puts("CD timeout: ");
        printf("%s:(%s) Sync=%s, Ready=%s\n", ALARM.name,
               CD_comstr[CD_com], CD_intstr[Intr.sync], CD_intstr[Intr.ready]);
        CD_flush();
        return -1;
    }
    return 0;
}

extern int CD_get_intr(void)
{
    volatile unsigned char nReg;
    volatile unsigned char result[8];
    int i;
    int j;

    int bHasError;
    volatile unsigned char *p;

    CDREG0 = 1;
    p = D_8013C218;
    nReg = *p & 7;
    if (nReg == 0)
        return 0;

    bHasError = 0;
    while (nReg != (*p & 7))
        nReg = *p & 7;

    for (i = 0; i < 8; i++) {
        volatile unsigned char *q = &result[i];
        if ((CDREG0 & 0x20) == 0)
            break;
        *q = CDREG1;
    }
    __asm__("" : "=r"(i) : "0"(i));  /* MATCH (W60-A4): stop cse sharing the i<8 test */
    for (j = i; j < 8; j++)
        result[j] = 0;

    CDREG0 = 1;  CDREG3 = 7;  CDREG2 = 7;

    if ((*(const unsigned char *)&nReg) != 3 || _cd_status_ok[CD_com]) {
        if (!(CD_status & 0x10) && (result[0] & 0x10))
            CD_nopen++;
        CD_status  = result[0];
        CD_status1 = result[1];
        bHasError  = CD_status & 0x1d;
    }
    /* MATCH (W60-A4): VOID-TAIL FENCE at the HEAD of the nReg==5 thread.  Reorg
     * STEALS the first insn of a branch TARGET thread when the branch can be
     * redirected past it (steal_delay_list_from_target): ours copied this block's
     * `li $2,5` into the `beq $2,$0` slot of the _cd_status_ok test and moved the
     * label after it, where retail has a plain `nop`.  A zero-insn void-tail fence
     * at the thread head makes the thread unstealable (the CdInit device).  This
     * is the LAST 2 diffs -- CD_get_intr is PASS 343/343 with it, PAIRED with the
     * two PER_FN_TEXT_MOVES rows for the case-4/5 `la` order (see RECEIPTS.md);
     * fence alone / moves alone do NOT seal.  Inside the block instead of before
     * it = 2 (the steal happens at the thread HEAD). */
    __asm__("" : : "i"(0));
    if ((*(const unsigned char *)&nReg) == 5) {
        /* MATCH (W65-A3, calltarget): retail calls PRINTF here, not puts -- the
         * oracle's first jal in this arm is `jal printf` with a lone `%hi/%lo
         * (D_800577A0)` arg ("DiskError: ", 12 bytes before the format string at
         * D_800577AC).  A transcription bug the reloc-name-lenient gate could
         * never see; the instruction stream is unchanged (one pointer arg either
         * way), only the call TARGET was wrong. */
        if (CD_debug > 0)
            printf("DiskError: ");
        if (CD_debug > 0)
            printf("com=%s,code=(%02x:%02x)\n", CD_comstr[CD_com], CD_status, CD_status1);
    }

    switch (nReg) {
    case 3:
        if (bHasError) {
            Intr.sync = 5;
            _memcpy8(D_8014899C, (unsigned char *)result);
            return 2;
        }
        if (_cd_int3_ack[CD_com]) {
            Intr.sync = 3;
            _memcpy8(D_8014899C, (unsigned char *)result);
            return 1;
        }
        Intr.sync = 2;
        _memcpy8(D_8014899C, (unsigned char *)result);
        return 2;
    case 2:
        Intr.sync = bHasError ? 5 : 2;
        _memcpy8(D_8014899C, (unsigned char *)result);
        return 2;
    case 1:
        if (bHasError && i == 1)
            bHasError = 0;
        {
            unsigned char rv = bHasError ? 5 : 1;
            volatile unsigned char *b = (volatile unsigned char *)&Intr;
            __asm__("" : "=r"(b) : "0"(b));  /* MATCH (W60-A4): OPAQUE BASE -- see the receipt above */
            b[1] = rv;
        }
        _memcpy8(D_801489A4, (unsigned char *)result);
        CDREG0 = 0;  CDREG3 = 0;
        return 4;
    case 4:
        /* MATCH (w52-a1): STORE-THEN-READ-BACK through a BLOCK-LOCAL base -- oracle
         * `lui v0; addiu v0; li v1,4; sb v1,2(v0); lbu v1,2(v0); sb v1,1(v0)`.  A chained
         * `Intr.ready = Intr.c = 4;` emits two independent `sb $0,SYM+N` assembler macros
         * and no reload; a FUNCTION-scope base gets CSE'd into one hoisted register for
         * the whole switch (measured: 74 -> 98).  Rage Racer libcd carries the same
         * per-case `volatile u_char *sp = &g_CdSyncStatus.sync;` shape.
         *
         * MATCH (W79-A3, strict 8 -> PASS 343/343): expand this case's first
         * `_memcpy8` directly and tie its destination to the Intr base in ONE
         * fence.  The destination then materializes in $a0 before the base in
         * $v0, as retail does.  Splitting the volatile read-back into `value`,
         * then assigning `src`, then storing `value` lets `addiu $a1,$sp,24`
         * fill the read's load-delay slot.  Case 5 repeats the same exact shape. */
        {
            unsigned char *dst = D_801489AC;
            unsigned char *src;
            int count;
            int end;
            volatile unsigned char *b = (volatile unsigned char *)&Intr;
            __asm__("" : "=r"(b), "=r"(dst) : "0"(b), "1"(dst));
            b[2] = 4;
            {
                unsigned char value = b[2];
                src = (unsigned char *)result;
                b[1] = value;
            }
            if (dst != 0) {
                count = 7;
                end = -1;
                do {
                    *dst++ = *src++;
                } while (--count != end);
            }
        }
        _memcpy8(D_801489A4, (unsigned char *)result);
        return 4;
    case 5:
        /* MATCH (w52-a1): as case 4 -- .ready is written FIRST, then .sync is a
         * read-back of it (`li v1,5; sb v1,1(v0); lbu v1,1(v0); sb v1,0(v0)`). */
        {
            unsigned char *dst = D_8014899C;
            unsigned char *src;
            int count;
            int end;
            volatile unsigned char *b = (volatile unsigned char *)&Intr;
            __asm__("" : "=r"(b), "=r"(dst) : "0"(b), "1"(dst));
            b[1] = 5;
            {
                unsigned char value = b[1];
                src = (unsigned char *)result;
                b[0] = value;
            }
            if (dst != 0) {
                count = 7;
                end = -1;
                do {
                    *dst++ = *src++;
                } while (--count != end);
            }
        }
        _memcpy8(D_801489A4, (unsigned char *)result);
        return 6;
    default:
        puts("CDROM: unknown intr");
        printf("(%d)\n", nReg);
        return 0;
    }
}

/* ---- inlined callback helper ------------------------------------------------------------------ */

static inline void callback(void)
{
    int interrupt;
    unsigned char restore;

    restore = CDREG0 & 3;
    for (;;) {
        interrupt = CD_get_intr();
        if (interrupt == 0)
            break;
        if ((interrupt & 4) && CD_cbready != 0)
            ((CdlCB)CD_cbready)(Intr.ready, D_801489A4);
        if ((interrupt & 2) && CD_cbsync != 0)
            ((CdlCB)CD_cbsync)(Intr.sync, D_8014899C);
    }
    CDREG0 = restore;
}

/* @0x801075DC : CD_sync -- wait for the command to acknowledge (mode 0 = block, else poll once). */
/* MATCH (w52-a1): SHAPE PORTED from the byte-exact Rage Racer libcd decomp,
 * ...\rage-racer-decomp\src\main\PAL\lib\libcd\command_sync.c :: CD_sync (their
 * register-asm pins DROPPED).  Levers: the three loop-invariant bases are explicit
 * locals assigned between the deadline store and the counter store (statusNames =
 * CD_intstr, intr = &Intr, ready = &intr->ready -> the oracle's `addiu s5,s2,1`);
 * the drain is inlined here so it uses those locals; and the sync byte is read into
 * a SIGNED CHAR then masked (`sync = syncRaw & 0xff`) -- that is where the oracle's
 * otherwise-redundant `andi a2,v0,255` after the `lbu` comes from. */
extern int CD_sync(int mode, unsigned char *result)
{
    char **cmdNames;
    char **statusNames;
    volatile CD_intr *intr;
    volatile unsigned char *ready;
    int interrupt;
    unsigned char restore;
    unsigned char sync;

    ALARM.deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    statusNames = CD_intstr;
    intr  = &Intr;
    ready = &intr->ready;
    ALARM.counter = 0;
    ALARM.name = "CD_sync";

    for (;;) {
        int alarm;
        if (ALARM.deadline < VSync(-1) || _spin_bump() > 0x3c0000) {
            /* MATCH (w53-a9): see CD_datasync -- the "ready" string as a named
             * local + the "sync" INDEX BYTE as a named local reproduce the
             * oracle's arg-block schedule (late CD_com lbu, sync string load
             * last). */
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx   = intr->sync;
            readyName = statusNames[intr->ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", ALARM.name,
                   cmdNames[CD_com], statusNames[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;

        if (CheckCallback()) {
            restore = CDREG0 & 3;
            for (;;) {
                interrupt = CD_get_intr();
                if (interrupt == 0)
                    break;
                if ((interrupt & 4) && CD_cbready != 0)
                    ((CdlCB)CD_cbready)(*ready, D_801489A4);
                if ((interrupt & 2) && CD_cbsync != 0)
                    ((CdlCB)CD_cbsync)(intr->sync, D_8014899C);
            }
            CDREG0 = restore;
        }

        {
            /* MATCH (w52-a1): the oracle masks the just-`lbu`'d sync byte with an
             * otherwise-redundant `andi a2,v0,255`.  gcc range-proves an `lbu` result
             * to 0..255 and folds any `& 0xff` away, so the mask only survives behind
             * a zero-insn opacity fence (catalog w47 §A; the byte-exact Rage Racer
             * decomp carries the identical `asm("" : "=r"(x) : "0"(x))` at this site). */
            /* MATCH (W60-A4, 22 -> 8): retail keeps the MASKED byte (`andi a2,v0,255`)
             * live across the whole tail -- both `== 2` / `== 5` tests AND the return
             * value come out of $a2 -- while the raw `lbu` result dies immediately.
             * Ours returned the RAW byte (cse substitutes it for the mask result: an
             * `lbu` is already zero-extended, so the two are provably equal) which
             * pinned the raw pseudo to the exit and pushed the _memcpy8 sentinel off
             * $a3.  A zero-insn IDENTITY FENCE on the masked value makes it cse-opaque,
             * so the mask survives as its own pseudo and takes $a2 with the sentinel
             * falling back to $a3 -- the oracle's whole tail band. */
            int syncv;
            sync = intr->sync;
            syncv = sync;
            __asm__("" : "=r"(syncv) : "0"(syncv));
            if (syncv == 2 || syncv == 5) {
                intr->sync = 2;
                _memcpy8(result, D_8014899C);
                return syncv;
            }
        }
        if (mode != 0)
            return 0;
    }
}

/* @0x8010785C : CD_ready -- wait for a data-ready / data-end interrupt. */
/* MATCH (w52-a1): same treatment as CD_sync -- SHAPE from the byte-exact Rage Racer
 * libcd decomp (command_ready.c), with the loop-invariant table bases and the &Intr
 * base as explicit locals (the oracle hoists CD_comstr into $fp, CD_intstr, &Intr and
 * the +1/+2 field addresses) and the drain inlined here rather than via callback(). */
/* MATCH (W60-A4, 22 -> 8): PER-REGION FIELD ANCHORS (catalog 11D).  Retail derives
 * BOTH sub-field addresses from the single &Intr base -- `addiu s6,s2,1` (&intr->ready,
 * consumed by the drain) and `addiu s4,s2,2` (&intr->c) -- and then reads the poll bytes
 * THROUGH THE +2 ANCHOR (`lbu 0(s4)` = c, `lbu -1(s4)` = ready) while WRITING the clears
 * through the BASE (`sb zero,2(s2)`, `sb zero,1(s2)`).  Three cooperating edits, each
 * measured on the gate (count-exact 178/178 unless noted):
 *   (a) the drain INLINED here with the local pointers (`*readyp`, `intr->sync`) instead
 *       of the shared callback() -- callback() reaches the `Intr` GLOBAL, so gcc
 *       materialized &Intr a second time and cse turned it into the copy `addu s5,s2,zero`
 *       that retail does not have.  ALONE: 59 (175 insns, 3 short).
 *   (b) `cflag = &intr->c` + reads AND writes through it.  ALONE: 45 (179 insns, +1).
 *       (a)+(b): 30, count-exact -- residual = an s3/s4 band swap plus the two stores.
 *   (c) the asymmetric access: READ via `*cflag` / `cflag[-1]`, WRITE via `intr->c` /
 *       `intr->ready`.  That drops cflag's ref count enough to hand it $s4 and the result
 *       pointer $s3 (retail's band) AND reproduces the base-relative `sb`s.  30 -> 8.
 * RESIDUAL 8 = the shared timeout-printf sync-chain register only (see the W55-A5 receipt
 * at the top of this file); every other instruction is byte-identical. */
extern int CD_ready(int mode, unsigned char *result)
{
    char **cmdNames;
    char **statusNames;
    volatile CD_intr *intr;
    volatile unsigned char *readyp;
    volatile unsigned char *cflag;
    int interrupt;
    unsigned char restore;
    int c;
    int ready;

    ALARM.deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    statusNames = CD_intstr;
    intr = &Intr;
    readyp = &intr->ready;
    cflag = &intr->c;
    ALARM.counter = 0;
    ALARM.name = "CD_ready";

    for (;;) {
        int alarm;
        if (ALARM.deadline < VSync(-1) || _spin_bump() > 0x3c0000) {
            /* MATCH (w53-a9): see CD_datasync. */
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx   = intr->sync;
            readyName = statusNames[intr->ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", ALARM.name,
                   cmdNames[CD_com], statusNames[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;

        if (CheckCallback()) {
            restore = CDREG0 & 3;
            for (;;) {
                interrupt = CD_get_intr();
                if (interrupt == 0)
                    break;
                if ((interrupt & 4) && CD_cbready != 0)
                    ((CdlCB)CD_cbready)(*readyp, D_801489A4);
                if ((interrupt & 2) && CD_cbsync != 0)
                    ((CdlCB)CD_cbsync)(intr->sync, D_8014899C);
            }
            CDREG0 = restore;
        }

        c = *cflag;
        if (c != 0) {
            intr->c = 0;
            _memcpy8(result, D_801489AC);
            return c;
        }
        ready = cflag[-1];
        if (ready != 0) {
            intr->ready = 0;
            _memcpy8(result, D_801489A4);
            return ready;
        }
        if (mode != 0)
            return 0;
    }
}

/* @0x80107B24 : CD_cw -- write a command (with parameters) and await the ack. */
/* MATCH (w52-a1): `com` is an UNSIGNED CHAR parameter, not an int -- the oracle re-masks
 * it with `andi vN,s1,255` at EVERY use (four sites: both CD_comstr indexings, the ==2 and
 * the ==0xe tests, the table indexings).  cc1 re-masks a u_char-typed value on each use
 * (methodology 3.12 #9); an `int` parameter emits none of them.  Confirmed by the byte-exact
 * Rage Racer libcd decomp, whose CD_cw takes `u_char command`. */
extern int CD_cw(unsigned char com, unsigned char *param, unsigned char *result, int arg3)
{
    volatile CD_intr *ip;
    char **cmdNames;
    volatile CD_intr *ep;
    int i;
    int ret;
    int *tbl;
    int *cnt;

    if (CD_debug > 1)
        printf("%s...\n", CD_comstr[com]);
    if (_cd_param_count[com] != 0 && param == 0) {
        if (CD_debug > 0)
            printf("%s: no param\n", CD_comstr[com]);
        return -2;
    }
    CD_sync(0, 0);
    if (com == 2)
        for (i = 0; i < 4; i++)
            CD_pos[i] = param[i];
    if (com == 0xe)
        CD_mode = param[0];
    /* MATCH (W62-A6): 75 -> 49.  THE FRAME IS NOW RETAIL'S EXACTLY (72 bytes /
     * `vars= 16` -> 56 / `vars= 0`, 20 diffs) -- the two DANGLING `(use (reg))`
     * pseudos w61-a7 located are GONE.  MECHANISM (gcc-cited, combine.c
     * distribute_notes ~11395): when a REG_DEAD note for a pseudo whose set combine
     * folded away finds no home, the backward scan runs to a CODE_LABEL and gcc
     * plants `(use (reg))` after that label; reload then hands the def-less pseudo an
     * 8-byte stack slot.  Each of the two orphans was worth 8 bytes of frame.
     * The CURE is to RESHAPE the two expressions so combine deletes the set instead:
     *   (a) the ready-flag test as an INDEX-FIRST CAST -- `*(int *)((com << 2) +
     *       (int)_cd_result_flag)` (12D A6 spelling); the plain subscript, `!= 0`,
     *       a named `int flag` local and a `&_cd_result_flag[com]` pointer local ALL
     *       leave the orphan (each measured: 76 with the loop already fixed);
     *   (b) the parameter loop as `i = 0; if (count > 0) do { ... } while (i < count);`
     *       -- the guard must be a REAL statement outside the loop.  The `for` form
     *       (any bound spelling) and a `while` form both keep the orphan.
     * Ladder: 75 -> 64 (both orphans dead, frame exact, count exact 259/259)
     *      -> 57 (identity fence on `ip`: the ready-clear now reuses the materialized
     *             base, `sb zero,1(v1)`, instead of the `lui at; sb` macro.  This is
     *             the SAME fence w61-a7 measured at 94 in the pre-landing basin --
     *             04Z basin-relativity, re-probe parked fences after every landing)
     *      -> 49 (a FRESH fenced tail pointer `ep` for the `sync == 5` test: retail
     *             re-materializes `&Intr` there as a `la` and reads `lbu 0(reg)`,
     *             where our folded `lui; lbu %lo` was 1 insn short; routing the test
     *             through the existing `ip` instead costs a 9th callee-saved reg = 88).
     * FALSIFIED in this basin: all 23 permutations of the 4 preamble statements
     * (57 or 61 -- the preamble block order is a sched1 tie, TEXT_MOVES only); a
     * shared bare-symbol `tbl = _cd_result_flag` pointer for the count (58) or for
     * both accesses (57); index-first casts on the count sites (57); `+ 256` spelled
     * on the cast (57); `ep` placed before `ret = 0` (52, count exact).  */
    /* MATCH (w52-a1): the two Intr byte-clears go through ONE materialized base
     * (`lui a1; addiu a1; sb zero,0(a1) ... sb zero,1(a1)`), not two independent
     * `sb $0,SYM+N` assembler macros -- same lever CD_flush already carries. */
    ip = &Intr;
    __asm__("" : "=r"(ip) : "0"(ip));
    __asm__("" : : : "$4");   /* MATCH (W75-A17): 20B zero-insn hard-register DENIAL of $a0
                               * inside `ip`'s live range (and outside `i`'s) -- see the
                               * W75-A17 receipt above.  Without it `ip` finds $a0 free and
                               * takes it, pushing the com<<2 index onto $a1. */
    ip->sync = 0;
    tbl = _cd_result_flag;
    if (*(int *)((com << 2) + (int)_cd_result_flag))
        ip->ready = 0;
    CDREG0 = 0;
    /* MATCH (w52-a1): the parameter-count table is _cd_result_flag's OWN array 0x100
     * bytes on (oracle: `addiu v0,v1,256; addu v1,a0,v0; lw`), i.e. one base shared by
     * the ready-clear flag and the count -- the same `[0x40 + command]` spelling the
     * byte-exact Rage Racer libcd decomp uses.
     * W63-A5 (41 -> 40, count now EXACT 259/259 and this whole region STRUCTURALLY
     * retail-shaped): the `+ 0x40` must be its OWN STATEMENT on a base POINTER LOCAL
     * (`tbl = _cd_result_flag; ... cnt = tbl + 0x40; cnt[com]`).  Spelling the count as
     * `_cd_result_flag[0x40 + com]` folds the whole thing into ONE `la sym+256` (2 insns,
     * +1 over retail); spelling it with a base pointer but keeping `tbl[0x40 + com]`
     * folds the 256 into the LOAD DISPLACEMENT (`lw v0,256(v1)`) because the index add
     * happens first.  Only the split form emits retail's three-step
     * `la tbl / addiu cnt,tbl,256 / addu idx,a0,cnt / lw 0(idx)`, and the `la` then sits
     * where GNU-as (reorder mode) SPLITS it across the preceding `beqz` -- reproducing
     * the oracle's `lui v1` before the branch and `addiu v1,v1,%lo` IN its delay slot,
     * which is where our two nops were.
     * FALSIFIED in this basin (all re-gated after the alarm-struct landing, i.e. the
     * w52/w62 receipts for these were basin-stale): `tbl` used for the FLAG too 49;
     * `tbl = _cd_result_flag + 0x40` with `tbl[com]` 46 @257; an index-first cast on
     * the count 49; SOTN's `[com + 0x40]` operand order INERT 41; identity fence on
     * `tbl` 44 @261 (the UNLAUNDERED control is the winner -- 13B); read-only fence on
     * `tbl` 42 @261; `tbl` assigned before `ip` 40 (inert, same basin); dropping the
     * `ip` identity fence 47; ip read-only instead of identity 47.
     * W64-A5 (40 -> 18, count still EXACT 259/259, ZERO instructions added): the w63-a5
     * verdict above was WRONG ON THE LAYER -- none of {ip, tbl, maskedCom, idx} is a
     * local-alloc qty.  All four are GLOBAL allocnos (each spans the `beqz` at the
     * ready-clear, so REG_BASIC_BLOCK == -1 and local-alloc.c:470-77 never even considers
     * them), so global.c's priority order + find_free_reg's ascending numeric scan decide
     * the whole rotation -- and that IS priced.  Read off the .greg conflict lists:
     *     ip(p77) conflicts with tbl(p82), maskedCom(p111) and idx(p115);
     *     maskedCom does NOT conflict with tbl or idx;  tbl <-> idx DO conflict;
     *     all four conflict with hard $v0, so the scan starts at $v1.
     * Solving the scan for retail's handout {maskedCom=$v1, tbl=$v1, idx=$a0, ip=$a1}
     * gives exactly two ordering constraints: tbl BEFORE idx, and ip LAST.  (The other
     * 22 orders are provably unreachable -- with tbl after idx, idx takes $v1 and tbl is
     * pushed to $a0; with ip anywhere but last it takes $v1 or $a0.)
     * Both constraints were bought with zero-insn read-only fences, each priced with
     * tools/reqdelta272.py first:
     *   - ip LAST: `__asm__("" : : "r"(ip));` immediately before the `CD_com` store (the
     *     last point before the next call, so ip stays caller-saved).  refs 5 -> 6 AND
     *     live 8 -> 26: priority 1.2500 -> 0.4615, which drops it below tbl.  40 -> 34.
     *   - tbl BEFORE idx: a TWO-operand fence on `tbl` (reqdelta272 --flip 82 115 prints
     *     "refs 2->4 (+2, CROSSES a floor_log2 step)").  POSITION IS THE DIAL and it is
     *     the difference between free and +2 insns: at the `tbl = _cd_result_flag;`
     *     statement the fence forces a second materialisation (44 @261); placed at the
     *     CONSUMER, immediately before `cnt = tbl + 0x40;`, it is zero-insn.  34 -> 18.
     *     (1 operand is an under-dial: INERT at 34.  3 operands = same 18.)
     * FALSIFIED for the remaining 18: shortening tbl's live range instead of raising its
     * refs -- moving `tbl = _cd_result_flag;` down to the guard / after the guard / to the
     * `cnt` statement all cost the la-split-into-the-beqz-slot (+1 insn, 35 @260).
     * RESIDUAL 18 = two clusters, neither in this region: (a) 2 diffs, the parameter
     * loop's saved count-address pointer in $a2 where retail has $a1; (b) ~14 diffs of
     * pure EMISSION ORDER in the ALARM block (retail materialises the `la &Intr` for the
     * while-entry test BEFORE the deadline store and puts the `bnez` ahead of the
     * cmdNames `la`).  All 6 source orderings of the four ALARM statements are INERT at
     * 18, so (b) is a scheduler decision, not a statement-order one -- next instrument is
     * a mechanical void-barrier position sweep (fencesweep) over that block. */
    /* W72-A16 re-gate: 4 @259/259.  Residual (b) is gone (W71-A9's in-loop `cmdNames`
     * landing took the ALARM block); residual (a) -- the parameter loop's saved count
     * pointer in $a2 where retail has $a1 -- is now a QUANTIFIED HARD-REGISTER
     * CERTIFICATE, read off the allocator's own dumps rather than guessed:
     *   tools/qty272.py --keep: the pointer is global allocno 201 (refs 8 / live 11 /
     *   pri 2.1818, rank 5 of 27); its ONLY hard conflicts are $v0 and $sp; it does NOT
     *   conflict with `ip` (allocno 77), which is the allocno that holds retail's $a1.
     *   global.c find_reg (gcc-2.8.1 sources, C:/Temp/gcc-2.8.1-src) runs TWO passes and
     *   pass 0 ORs in `~regs_used_so_far` -- "we never allocate a register for the FIRST
     *   TIME in pass 0".  At 201's turn the handout so far is {$v0, $a0, $s0} (allocnos
     *   186/193/80/184/144), so $a1 is simply NOT YET A CANDIDATE; it is first handed out
     *   ten ranks later, to `ip` itself.  ⇒ for 201 to land on $a1, some EARLIER-ranked
     *   allocno must already own $a1, and no dial available here produces that: raising
     *   `ip` over 201 needs refs 6 -> 16 at live 27 (the floor_log2 pri formula), i.e. 10
     *   fence operands -- and cc1 REJECTS an asm with more than 10 operands ("more than 10
     *   operands in `asm'", measured), so the ceiling is hard; lowering 201 below `ip`
     *   needs live 11 -> 55.  MEASURED CONFIRMATION that denial only walks the allocator
     *   UPWARD, never down to an unused $a1: an in-loop 20B hard-register conflict on
     *   "$6" moves it $a2 -> $a3 (still 4 diffs, verified in the disasm), "$6","$7" and
     *   "$6","$7","$8" stay 4, and clobbering the loop's live regs is catastrophic
     *   ("$3" 52, "$4" 42, "$3"+"$6" 52, all-temps 48).
     * ALSO FALSIFIED at this basin (all gated + reverted): moving the `ip` read-only fence
     * ABOVE the parameter loop -- the obvious "let ip die first" cure -- costs 28 (its
     * demote works through the LIVE-RANGE extension, so shortening it undoes W64-A5);
     * dropping it 28; a fence before the tbl fence 28; a bare "$6" clobber before the
     * guard 15; a read-only fence on `i` or on `cnt` inside the loop 4 / 13; a launder on
     * `i` with a "$6" clobber 6.  This is a REGISTER-HANDOUT certificate, not a floor
     * verdict -- the reachable lever would be an EARLIER allocno taking $a1, i.e. a
     * hard-reg conflict on $a0 for allocno 80 (the CD_pos loop counter), which retail
     * itself keeps in $a0, so it is not spellable without breaking a matched region.
     *
     * 🔴 W74-A14 CORRECTION -- THE W72 CERTIFICATE'S PREMISE IS WRONG, AND ITS PRICE IS
     * FALSIFIED BY MEASUREMENT.  Read global.c:333-356 (gcc-2.8.1): `regs_used_so_far` is
     * SEEDED, before any allocno is handed anything, with every hard reg for which
     * `regs_ever_live[i] || call_used_regs[i]`.  $a1 is CALL-USED, so it is in
     * regs_used_so_far from the very first allocno and the pass-0 `IOR_COMPL(used,
     * regs_used_so_far)` term (global.c:948) NEVER excludes it.  "$a1 is not yet a
     * candidate at 201's turn" is not a thing; that clause only excludes CALLEE-SAVED regs
     * nobody has touched yet (the "no cost in using them" comment right above the loop).
     * The real pass-0 exclusion is the OTHER term on the same line, `regs_someone_prefers
     * [201]` -- built by prune_preferences (global.c:864) as the union of the FULL
     * PREFERENCES of every LOWER-priority CONFLICTING allocno, minus 201's own preferences.
     * ⇒ this is a PREFERENCE certificate, not a priority one.
     * MEASURED CONSEQUENCES (all gated + reverted, zero source kept):
     *  - the "raise `ip` refs 6 -> 16" price is FALSE, and the "cc1 caps an asm at 10
     *    operands so the ceiling is hard" ceiling is FALSE TOO: the cap is per-ASM, and N
     *    back-to-back read-only fences at the SAME source position stack their operand
     *    refs while leaving the live range alone.  Ladder on the `ip` fence
     *    (scratchpad/W74_A14_cw.json): 1 operand (shipped) 4 - 2 ops 4 - 4 ops 4 - 6 ops 4
     *    - 8 ops 4 - 10 ops 4 - 10+1 4 - 10+4 4 - 10+10 4 - 1+1 4 - 1+1+1+1 4 - a tied
     *    launder + 1 read-only 4 - tied launder + 10 read-only 4 - 10+10+10 (30 refs) 50.
     *    So `ip` at ~25 refs, far past the predicted 16, is completely INERT: raising its
     *    priority does not give 201 $a1, exactly as the preference reading predicts.
     *  - the prune_preferences exit (add a hard conflict on $a1 to whichever lower-priority
     *    allocno prefers it, so its preference is AND_COMPL'd away before the union) was
     *    swept by position with zero-insn 20B clobbers (scratchpad/W74_A14_cw2.json):
     *    "$5" and "$5","$6" at `ip = &Intr` 4 - at the `com == 2` guard 4 - at `ALARM.name`
     *    4 (all inert, 201 not live there and the preferring allocno evidently not either)
     *    - at `tbl =` 8 - at `ip->ready = 0` 8 - at the `tbl` fence 8 - at the `ip` fence 8
     *    (all worse: those positions DO deny $a1 to something load-bearing).
     * RESTATED CERTIFICATE: 201 avoids $a1 in pass 0 because some lower-priority
     * CONFLICTING allocno lists $a1 in hard_reg_full_preferences.  prune_preferences
     * removes $a1 from regs_someone_prefers[201] in exactly two ways: (i) 201 itself
     * prefers $a1 (the AND_COMPL at global.c:872) -- which needs a hard-reg COPY to/from
     * $a1, i.e. a register-asm PIN (banned), or a source shape in which the count pointer
     * genuinely arrives in / departs to $a1; (ii) the preferring allocno acquires a hard
     * CONFLICT with $a1 (prune_preferences AND_COMPLs hard_reg_conflicts out of the
     * preference sets at :855-57) at a point where 201 is NOT live -- the sweep above
     * found no such position.  Next instrument, if this is ever re-opened: dump
     * hard_reg_full_preferences from the instrumented cc1 (C:/Temp/nfs4-instr-cc1) to NAME
     * the preferring allocno instead of sweeping blind; the position that works must lie
     * inside ITS live range and outside 201's. */
    /* ==========================================================================
     * 🏆 W75-A17: SEALED.  4 -> 16 -> PASS 259/259.  The W72 "hard-register
     * certificate" and the W74 "preference certificate" were BOTH wrong about the
     * mechanism, and the real one is readable straight out of `tools/qty272.py`
     * (the .greg conflict lists) -- no instrumented cc1 needed.
     *
     * WHAT THE DUMP ACTUALLY SAYS (control basin, 4 diffs).  The parameter loop's
     * saved count-address pointer is global allocno 130 (NOT 201 -- 201 is the
     * INLINED `_memcpy8` destination; W72/W74 read the wrong pseudo out of a stale
     * numbering, which is why their price and their exits never matched reality).
     *   130: refs 3 / live 9 / pri 3333, rank 15, conflicts {72 74 75 76 77 80, $v0,$v1}
     *   77 (`ip`): refs 6 / live 27 / pri 4444, rank 10, home $a1
     *   80 (`i`):  rank 2, home $a0
     * global.c's ascending scan for 130 therefore reads: $v0/$v1 hard-barred, $a0
     * barred by 80, $a1 barred by **77** -> $a2.  There is no preference involved at
     * all (130's `prefs` field is empty); 130 avoids $a1 because IT CONFLICTS WITH
     * `ip`, and it conflicts with `ip` because the W64-A5 read-only fence that demotes
     * `ip` sits AFTER the parameter loop and holds `ip` live across it.  Retail's `ip`
     * is also $a1 -- it just DIES at `sb $0,1($a1)`, so retail reuses $a1 for the
     * count pointer.  ⇒ the defect was a LIVE-RANGE OVERLAP the demote device created,
     * not an allocator tie-break.
     *
     * THE FIX, two coupled parts (a CELL -- neither works alone; cf. 21E-1/22C-8):
     *  (1) DELETE the `ip` read-only fence (its only job was "ip after tbl") and buy
     *      the same ordering on the OTHER side instead: raise `tbl`'s refs from 4 to 8
     *      by widening the existing zero-insn read-only fence from 2 to 6 operands.
     *      tbl 5714 -> 17142 (rank 9 -> 7), ip 4444 -> 12500 with live 27 -> 8.
     *      `ip` now dies before the loop, 130 takes $a1 = retail.  4 -> 16.
     *  (2) The 16 is a NEW, DIFFERENT rotation: with its live range shortened, `ip`
     *      (rank 9) finds $a0 FREE -- it does not conflict with `i`(80) -- and takes it,
     *      pushing the `com << 2` index (allocno 115) onto $a1.  Cure = a 20B ZERO-INSN
     *      HARD-REGISTER DENIAL of $a0 placed strictly INSIDE `ip`'s live range and
     *      OUTSIDE `i`'s: `__asm__("" : : : "$4");`.  `ip` -> $a1, 115 -> $a0.  16 -> 0.
     *
     * MEASURED (all gated; the ladder is the receipt):
     *   tbl fence operand ladder with the ip fence dropped: 3 ops 28 - 4 ops 28 -
     *     5 ops 28 - 6 ops 16 - 7 ops 16 - 8 ops 16 - 10 ops 16  (the floor_log2 step
     *     at refs 8 is the dial; 6 operands = 8 refs is the minimum that lands it)
     *   ip fence MOVED above the loop instead of dropped, same ladder: 3/4 28 - 6/8 16
     *     (identical -- confirming the fence's position is irrelevant once tbl outranks
     *     it, i.e. w64-a5's "position is the dial" was basin-local)
     *   $a0-denial position/mask sweep from the 16 basin: "$4" after the ip identity
     *     fence 0 - after `ip->sync = 0` 0 - before the ready-flag guard 0 - BEFORE
     *     `ip = &Intr` 16 (INERT: outside ip's live range, the 22B-1 law) - "$4","$5"
     *     at all three inside positions 8 - "$5" alone at all three 16 (INERT).
     *   FALSIFIED on the way: moving `ip = &Intr` (+ its identity fence) up to just
     *     after `CD_sync(0,0)` to demote by an EARLIER BIRTH rather than a later death
     *     -- 11 @258/259 in every variant (fence kept 15, fence before the loop 11,
     *     fence at the tbl fence 11, no extra fence 11, 2-operand fence 11); the
     *     earlier birth also costs an instruction, so that whole family is out.
     *   The plain "move the ip fence above the loop" control (no tbl boost) reproduces
     *     W64-A5's 28 exactly.
     *
     * 🔑 TRANSFERABLE LAWS:
     *  (a) A READ-ONLY (live-extending) DEMOTE FENCE IS ALSO A CONFLICT GENERATOR.
     *      When the demoted value's register is one the oracle REUSES later in the
     *      function, the fence's own live extension is what blocks the reuse.  Prefer
     *      buying the ordering by PROMOTING THE RIVAL (a ref-only dial, live-neutral)
     *      whenever the demoted value's register is reused downstream.
     *  (b) READ THE PSEUDO NUMBER OFF A FRESH DUMP.  Two waves of certificates were
     *      built on a stale pseudo id; qty272's conflict list would have refuted both
     *      in one call.  A conflict list is a stronger instrument than a preference
     *      argument -- check conflicts FIRST, preferences second.
     *  (c) The 20B denial DOES reach a global allocno whose scan simply finds a free
     *      lower-numbered register (unlike 22B-2's adjacent-def/use QTY, where there is
     *      no decision left to deny).  Gate on "is the register free at this allocno's
     *      turn", not on "is there a tie".
     * ========================================================================== */
    __asm__("" : : "r"(tbl), "r"(tbl), "r"(tbl), "r"(tbl), "r"(tbl), "r"(tbl));
    /* MATCH (W64-A5 device, W75-A17 re-dialled): +6 refs on `tbl` (4 -> 8, crossing the
     * floor_log2 step) so tbl outranks `ip` WITHOUT the live-extending ip fence. */
    cnt = tbl + 0x40;
    i = 0;
    if (cnt[com] > 0)
        do {
            CDREG2 = param[i];
            i++;
        } while (i < cnt[com]);
    CD_com = (unsigned char)com;
    CDREG1 = CD_com;
    if (arg3 != 0)
        return 0;

    /* MATCH (W61-A7): 84 -> 75.  The alarm is inlined HERE (it was routed through the
     * shared get_alarm(), the only caller) with the SAME shape CD_sync/CD_ready carry --
     * three cooperating pieces, each measured:
     *   (1) a `cmdNames` local: retail hoists the command-name table into the loop
     *       PREHEADER (`lui s5; addiu s5` right after the entry test) and therefore
     *       carries EIGHT callee-saved registers where the shared-get_alarm form bought
     *       only seven.  The shared copy's single `CD_comstr[CD_com]` use gives cse no
     *       common subexpression, so no invariant pseudo exists to hoist and the base is
     *       re-materialized inside the arg block (`lui a2; addu a2,a2,v1`, +1 insn).
     *       An IDENTITY FENCE on the local is NOT needed and is a NET LOSS here (77 vs 75):
     *       it materializes the `la` before the loop ENTRY TEST (s3) instead of in the
     *       preheader (s5) and rotates the whole s3/s4/s5 band.
     *   (2) the split locals `syncIdx` / `readyName` (the w53-a9 CD_datasync lever) --
     *       falsified against the SHARED get_alarm() in w53-a9 (90 -> 93), it lands here
     *       once the copy is private to CD_cw.
     *   (3) the `alarm` VARIABLE + `if (alarm != 0) return -1;` funnel, not a direct
     *       `return -1` inside the timeout block: that is retail's extra
     *       `addu v0,zero,zero; bnez v0` pair and it makes the count exact.
     * FALSIFIED in this basin (all re-measured after the landing): identity fence on
     * cmdNames 77 · an explicit `statusNames` local 79 · `cmdNames = CD_comstr` moved to
     * the last preamble statement 75 (INERT) · identity fence on `ip` 94 · a separate
     * loop counter `j` for the parameter loop 93 · dropping the store-flag breaker 86. */
    ALARM.deadline = VSync(-1) + 0x3c0;
    ALARM.counter = 0;
    ALARM.name = "CD_cw";
    while (Intr.sync == 0) {
        int alarm;
        /* MATCH (W71-A9, 18 -> 4): the command-name base is assigned INSIDE the loop.
         * Retail materialises it in the loop PREHEADER (`lui s5; addiu s5` AFTER the
         * entry `bnez`); a preheader source statement (`cmdNames = CD_comstr;` written
         * before the `while`) lands in the ENTRY block instead, which is where our whole
         * 14-diff ALARM-block "emission order" cluster came from -- with the la in the
         * entry block, sched1 also re-lays the four ALARM stores/loads around it.
         * Written in the loop body it is a loop-INVARIANT with n_times_set == 1, so
         * loop.c builds a movable and hoists it to exactly retail's slot; the ALARM
         * block then falls into retail's order for free.  (The w61-a7 note above --
         * "the shared get_alarm() copy gives cse no common subexpression so no invariant
         * pseudo exists to hoist" -- had the right mechanism and the wrong cure: the
         * pseudo has to be BORN IN THE LOOP, not merely local to this function.)
         * Measured: here 4 · assigned in BOTH places 22 · as the last preamble statement
         * 18 (inert, the w61-a7 reading) · plus a read-only fence on it 14. */
        cmdNames = CD_comstr;
        if (ALARM.deadline < VSync(-1) || _spin_bump() > 0x3c0000) {
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx   = Intr.sync;
            readyName = CD_intstr[Intr.ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", ALARM.name,
                   cmdNames[CD_com], CD_intstr[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;
        if (CheckCallback())
            callback();
    }
    _memcpy8(result, D_8014899C);
    /* MATCH (w52-a1 diagnosed / w53-a9 APPLIED): the oracle picks the return value with a
     * real BRANCH and a shared `addu v0,a0,zero` funnel (`addu a0,zero,zero; ...; li v0,5;
     * bne v1,v0; addu v0,a0,zero; li a0,-1; addu v0,a0,zero`), i.e. default-then-override
     * through a named result var -- an arithmetic `-(sync == 5)` compiles to the
     * branchless `xori; sltiu; negu` triple instead.
     * w53-a9 FALSIFICATION: this default-then-override spelling is DIFF-NEUTRAL (90 -> 90) --
     * so are `if (sync == 5) return -1; return 0;`, the inverted `ret = -1; if (sync != 5)
     * ret = 0;` and the early-return form: cc1-2.7.2 canonicalizes ALL FOUR back to the
     * store-flag triple (jump.c folds a single-set guarded block).  Keeping the branched
     * spelling because it is what the oracle's `li v0,5; bne v1,v0; addu v0,a0,zero` shows;
     * the STORE-FLAG BREAKER (make the guarded block 2 insns, e.g. a zero-insn fence beside
     * the store -- catalog w46 fence grammar mode 2) is the named next angle. */
    ret = 0;
    ep = &Intr;
    __asm__("" : "=r"(ep) : "0"(ep));
    /* W61-A7: NON-VOLATILE ALIAS READ (catalog: CD_get_intr lever 3) -- a volatile
     * QImode read cannot fold its zero-extend into the `lbu`, which is where our
     * redundant `andi v0,v0,255` before the ==5 test came from. */
    if (*(const unsigned char *)&ep->sync == 5) {
        ret = -1;
        __asm__("" : : "i"(0));   /* STORE-FLAG BREAKER: jump.c's `-(cond)` fold only matches
                                   * a SINGLE-set guarded block; the zero-insn void-tail fence
                                   * makes it two, so the oracle's real `li v0,5; bne v1,v0`
                                   * branch + `addu v0,a0,zero` funnel come back (90 -> 84). */
    }
    return ret;
}

extern int CD_cw_i(int com, unsigned char *param, unsigned char *result, int arg3)
    __asm__("CD_cw");

/* @0x80107F30 : CD_flush -- abort and reset the controller interrupt state. */
extern void CD_flush(void)
{
    /* MATCH (w51-a4): shape TRANSPLANTED from the byte-exact Rage Racer libcd decomp,
     * C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\drive_initialization.c :: CD_flush.
     * Two levers carried over: (1) the tail takes a real `volatile u_char *` to the .ready
     * field, which is what forces the oracle's ONE `lui/addiu` base register reused by
     * displacement (`sb 2(v1) / lbu 2(v1) / sb 1(v1) / sb 0(v1)`); a bare `Intr.field = ...`
     * or a plain `CD_intr *` local both compile to per-field `sb $0,SYM+N` assembler macros
     * on the gcc-2.7.2 lane.  (2) the poll loop is the guarded do/while the oracle rotates to.
     * The `% 8` spelling is Rage Racer's; `& 7` is identical here (u_char).
     *
     * MATCH (w55-a5): 13 (54/53, count WRONG) -> PASS 53/53.  THREE cooperating pieces --
     *  (1) the anchor must be OPAQUE.  A plain `state = &Intr.sync` is const-folded straight
     *      back to the symbol at every subscript, so `state[2]`/`state[1]` still come out as
     *      `sb $0,Intr+2` ASSEMBLER MACROS (`lui $at; sb $0,%lo`) -- only `state[0]` survived
     *      as a displacement.  The W49 IDENTITY FENCE makes the address one un-foldable pseudo
     *      and the whole `sb 2 / lbu 2 / sb 1 / sb 0` displacement block appears.
     *  (2) `reg = D_8013C20C;` as its own local (Rage Racer's `reg`) hoists the CDREG0 pointer
     *      load into the middle of that block, exactly where the oracle has it.
     *  (3) the residual was then a UNIFORM $v0<->$v1 swap (anchor $v0 / byte $v1, oracle the
     *      reverse) at count-EXACT 53/53.  An IDENTITY FENCE on the reloaded byte `c` (+2 refs,
     *      the W50 ref-step PROMOTE dial) lifts its local-alloc qty above the anchor's, so `c`
     *      takes $v0 and the anchor drops to $v1 = retail.  FALSIFIED in this basin: decl-order
     *      swap (14), double fence on the anchor (14), read-only fence on the anchor (18),
     *      anchoring at `&Intr` instead of `&Intr.sync` (14), hoisting the anchor above the
     *      poll loop (23), unfenced anchor (14). */
    volatile unsigned char *state;   /* $v1 : &Intr, reached by displacement 0/1/2 */
    volatile unsigned char *reg;     /* $a0 : CDREG0 pointer                       */
    unsigned char c;
    CDREG0 = 1;
    while (CDREG3 & 7) {
        CDREG0 = 1;
        CDREG3 = 7;
        CDREG2 = 7;
    }
    state = &Intr.sync;
    __asm__("" : "=r"(state) : "0"(state));   /* (1) keep the anchor un-foldable */
    state[2] = 0;                             /* Intr.c     = 0 */
    c = state[2];                             /* oracle genuinely RELOADS .c (volatile) */
    __asm__("" : "=r"(c) : "0"(c));           /* (3) ref-step PROMOTE: c -> $v0 */
    state[1] = c;                             /* Intr.ready = Intr.c */
    reg = D_8013C20C;                         /* (2) CDREG0 pointer hoist */
    state[0] = 2;                             /* Intr.sync  = 2 */
    *reg = 0;
    CDREG3 = 0;
    *D_8013C21C = 0x1325;
}

/* @0x80108004 : CD_initvol -- enable CD audio and set the mixer volumes to maximum.
 *   MATCH (verify_asm PASS 60/60): the volume-guard is two SHORT-CIRCUIT branches in the
 *   oracle (`bnez 0x1b8; bnez 0x1ba`), so the `A==0 && B==0` test must be written as NESTED
 *   ifs (methodology lever #7 -- a single `&&` made gcc fold both compares into one
 *   `sltiu;beqz`, +1 insn).  The `vol[]` byte inits must be `vol[0]=vol[2]=0x80` order (NOT
 *   `vol[2]=vol[0]=`) so the rightmost assignment stores offset 2 before 0, matching the
 *   oracle's `sb v0,2(sp); sb v0,0(sp)` schedule. */
extern int CD_initvol(void)
{
    unsigned char vol[4];
    if (D_8013C220[0x1b8 / 2] == 0) {
        if (D_8013C220[0x1ba / 2] == 0) {
            D_8013C220[0x180 / 2] = 0x3fff;
            D_8013C220[0x182 / 2] = 0x3fff;
        }
    }
    D_8013C220[0x1b0 / 2] = 0x3fff;
    D_8013C220[0x1b2 / 2] = 0x3fff;
    D_8013C220[0x1aa / 2] = 0xc001;
    vol[0] = vol[2] = 0x80;
    vol[1] = vol[3] = 0;
    CDREG0 = 2;
    CDREG2 = vol[0];
    CDREG3 = vol[1];
    CDREG0 = 3;
    CDREG1 = vol[2];
    CDREG2 = vol[3];
    CDREG3 = 0x20;
    return 0;
}

/* @0x801080F4 : CD_initintr -- (re)install the CD interrupt callbacks. */
extern int CD_initintr(void)
{
    CD_cbready = 0;
    CD_cbsync  = 0;
    CD_status1 = 0;
    CD_status  = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);
    /* MATCH: NO `return 0;` -- the oracle sets up no $v0 at all (retail's return value is
     * incidental); an explicit `return 0` adds `addu v0,zero,zero` (ours 20 vs oracle 19). */
}

/* @0x80108140 : libcd's lowercase CD_init -- bring the CD-ROM subsystem up (nop, reset, demute).
 * NAME (W52-A10): the symbol is spelled `CD_init_80108140` on BOTH sides of the gate, not
 * `CD_init`.  splat appended the VA because this name and eaclib's high-level `CD_Init`
 * @0x800FA394 case-FOLD to one string on NTFS; keeping the recon on the bare `CD_init` left
 * the expected side with NO symbol for this VA at all, while `INCLUDE_ASM(..., CD_init)` in
 * src/syslib/psx/libmcrd/BIOS.c silently assembled CD_Init.s -- so expected BIOS.c.o carried a
 * DUPLICATE definition of eaclib's CD_Init and MATCH_PROGRESS grew a phantom
 * `0x800FA394 0.00%% syslib/psx/libmcrd/BIOS CD_Init` row.  Propagating splat's disambiguated
 * name (rather than renaming the oracle back to `CD_init` and re-creating the collision) is
 * what closes it.  Oracle: asm/nonmatchings/main/CD_init_80108140.s. */
extern int CD_init_80108140(void)
{
    static CD_init_struct tab = {
        (CD_intr *)&Intr, D_8014899C, &CD_com, &CD_status, CD_pos,
        "$Id: bios.c,v 1.86 1997/03/28 07:42:42 makoto Exp yos $"
    };
    /* MATCH (w55-a5): the Intr reset block is the SAME fenced byte anchor + `reg`
     * local recipe that took CD_flush to PASS (see its receipt) -- 24 diffs at
     * 120/120 -> 15 at 117/120.  The remaining 3-instruction shortfall is all in
     * the tail: retail BRANCHES on the CD_sync result (`addu $a0,$v0,$zero;
     * li $v1,2; bne $a0,$v1; li $v0,-1; j; addu $v0,$zero,$zero; li $v0,-1` --
     * note the duplicated -1 and the un-propagated result copy, same 06E class as
     * CdReset above), where ours store-flag-folds it to `xori;sltu;negu`.
     * FALSIFIED in the PRE-anchor basin (all 24, gcc canonicalized them to the
     * identical stream): `== 2` first, a named result temp with/without an
     * identity fence, a named `two = 2` compare constant.  RE-PROBE THEM IN THIS
     * BASIN -- the 3-insn gap is exactly the store-flag fold, and CD_cw's tail
     * (drv.c:560) already shows a zero-insn void-tail fence is the breaker for
     * jump.c's `-(cond)` fold when the guarded block is single-set. */
    volatile unsigned char *state;
    volatile unsigned char *reg;
    unsigned char c;
    int cwCom;
    int cwZero;
    /* MATCH (W78 source-only, 4 -> PASS 120/120): stage the first CdlNop
     * arguments before the Intr-base materialization.  The asm-label alias
     * preserves CD_cw's real u_char definition while exposing the raw ABI int
     * at this call, avoiding a spurious `andi a0,255` on the opaque carrier. */
    puts("CD_init:");
    printf("addr=%08x\n", &tab);
    CD_com     = 0;
    CD_mode    = 0;
    CD_cbready = 0;
    CD_cbsync  = 0;
    CD_status1 = 0;
    CD_status  = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);

    CDREG0 = 1;
    while (CDREG3 & 7) {
        CDREG0 = 1;
        CDREG3 = 7;
        CDREG2 = 7;
    }
    cwCom = 1;
    cwZero = 0;
    __asm__("" : "=r"(cwCom), "=r"(cwZero) : "0"(cwCom), "1"(cwZero));
    state = &Intr.sync;
    __asm__("" : "=r"(state) : "0"(state));   /* keep the anchor un-foldable (see CD_flush) */
    state[2] = 0;                             /* Intr.c     = 0 */
    c = state[2];                             /* volatile RELOAD */
    /* W71-A9: the `c` identity fence recorded here was already flagged INERT in W64-A5 and
     * is re-confirmed inert in this basin (9 with and without) -- removed as scaffolding.
     * The `state` identity fence above IS load-bearing (9 -> 18 without it). */
    state[1] = c;                             /* Intr.ready = Intr.c */
    reg = D_8013C20C;
    state[0] = 2;                             /* Intr.sync  = 2 */
    *reg = 0;
    CDREG3 = 0;
    *D_8013C21C = 0x1325;

    CD_cw_i(cwCom, (unsigned char *)cwZero, 0, 0); /* CdlNop */
    if (CD_status & 0x10)
        CD_cw(1, 0, 0, 0);
    if (CD_cw(0xa, 0, 0, 0))                 /* CdlReset */
        return -1;
    /* MATCH (W71-A9, 10 -> 9 and the R2 THREAD CHOICE SOLVED): the two error exits are
     * ASYMMETRIC IN RETAIL and the source has to be asymmetric too.  Retail's CdlReset
     * `bnez` eager-steals `li $v0,-1` from its TARGET thread (ours matches there), but
     * the CdlDemute `bnez` takes `addu $a0,$zero,$zero` from the FALL-THROUGH thread --
     * the W64-A5 "sharpened angle" that was filed as needing a reorg trace.  The cure is
     * the 16C CFG dial: route ONLY this arm to a shared `err:` block whose head carries a
     * zero-insn void fence.  reorg's `stop_search_p` returns 1 at ANY asm (reorg.c:685),
     * so the target thread yields no candidate, reorg falls back to the fall-through, and
     * the arg setup lands in the slot exactly as retail has it.  The branch polarity and
     * the `li $v0,-1`-in-the-`bne`-slot tail come with it (ours 120 -> 119 @ oracle 120).
     * Measured: this asymmetric form 9 · ALL THREE exits routed to `err:` 10 (the reset
     * arm must keep its own stealable `return -1`) · `goto err` with NO fence at the
     * label 12 · the fence doubled 9 (inert) · re-priced in this basin and still inert:
     * a named `sr_` CD_sync result with an identity launder 9, with a read-only fence 9
     * (confirming the W64-A5 mechanism note -- the copy is a hard-reg suggestion, not a
     * combine_regs tie).  The old STORE-FLAG BREAKER fence in the CD_sync arm is now
     * INERT (9 with and without) and has been dropped as scaffolding. */
    if (CD_cw(0xc, 0, 0, 0))                 /* CdlDemute */
        goto err;
    /* MATCH (w55-a5): STORE-FLAG BREAKER, the CD_cw device (drv.c:560) applied to
     * both arms.  jump.c's `-(cond)` fold turns this guard into `xori;sltu;negu`
     * (3 insns, no branch) unless each arm is more than a single set; a zero-insn
     * void-tail fence in BOTH arms restores retail's real `li $v1,2; bne; li -1;
     * j; addu $v0,$zero,$zero; li -1` branch + duplicated-constant tail.
     * 15 (117/120) -> 10 at count-EXACT 120/120.  One fence only = 10 @118/120. */
    /* W62-A6: the 12D A5 DEAD-PSEUDO STAGING law was tested here and is FALSIFIED for
     * this function.  Retail copies CD_sync's result into $a0 (`addu $a0,$v0,$zero`) and
     * tests $a0, filling the `bne`'s slot with `li $v0,-1`.  A5 says to assign into the
     * variable that ALREADY owns $a0 -- here the only owner is CD_sync's own first
     * argument, so the argument was made a variable and the result assigned back into
     * it: `sarg = 0; sarg = CD_sync(sarg, 0);` INERT (10), the same with both arguments
     * from the carrier INERT (10), and the plain named result temp INERT (10) -- all
     * count-EXACT 120/120.  The 13B anti-steal void fence in the earlier `return -1`
     * arms (retail fills the preceding `bnez`'s slot with the `addu $a0,$zero,$zero` arg
     * setup where we steal `li $v0,-1` into it) is WORSE: CdlDemute arm 13, CdlReset arm
     * 15, both 18.  Class stands as 3b old-gcc no-copy-prop + one reorg steal choice.
     * W63-A5: the 10 splits into TWO independent items, and the tail one is now
     * MECHANISM-NAMED rather than "a reorg steal choice":
     *   (R1, 2 diffs) a pure CODE MOTION -- retail emits `li $a0,1; move $a1,$0` (the
     *     CD_cw(CdlNop,...) arg setup) BEFORE the `la` of the Intr base; ours emits them
     *     four insns later, after the `lbu`.  Everything else in the block is identical,
     *     so this is a PER_FN_TEXT_MOVES take/after row (spec + anchors in
     *     scratchpad/w63a5/moves_cd_init.json, NOT submitted -- the anchors were derived
     *     from the -dl dump's out.s and did not fire against the build pipeline's .s, so
     *     it lacks the mandatory probe proof; re-derive from the pipeline .s).
     *   (R2, 4 diffs) retail's `li $v0,-1` sits in the FINAL `bne`'s delay slot, which is
     *     WHY the tested value has to live somewhere else -- reorg cannot fill a slot with
     *     an insn writing a register the branch READS (09L, reorg.c insn_sets_resource_p).
     *     So retail's `addu $a0,$v0,$zero` copy is a CONSEQUENCE of that fill, not a
     *     separate no-copy-prop artifact: the cure must stop reorg stealing the -1 into the
     *     EARLIER CdlDemute `bnez` slot so it is still available for the `bne`.
     * Also re-gated here (04Z, post-alarm-struct): the `c` identity fence is now INERT
     * (10 with and without) -- it is documented as a ref-step promote but no longer buys
     * anything; the `state` identity fence IS load-bearing (10 -> 19 @123 without it).
     * And the Intr triple's spelling is CERTIFIED FREE: our store/reload/store form, the
     * chained `state[1] = state[2] = 0;` (sotn-decomp psxsdk/libcd/bios.c) and the
     * two-statement `state[2] = 0; state[1] = state[2];` (psyz decomp/src/libcd/bios.c)
     * all gate identically at 10 @120/120 -- the corpus angle is confirmed equivalent,
     * not a lever. */
    /* W64-A5 re-probe of R2 (still 10 @120/120).  13B's IDENTITY LAUNDER on the CD_sync
     * result -- the one device W62's "plain named result temp INERT" note never gated, and
     * which the 13B law says must be tried before believing such a note -- is ALSO INERT
     * here: a named `syncRet` with an identity fence 10, with a read-only fence 10, two
     * identity fences 10, Yoda `2 != syncRet` 10, plain 10; dropping the store-flag void
     * fences with the launder 15 @117.  MECHANISM (why the launder cannot reach it): the
     * value is set FROM A HARD REG (the call's $v0), and combine_regs takes the hard-reg
     * branch (local-alloc.c ~1895) which records `qty_phys_sugg = $v0` for the pseudo
     * instead of tying it -- a suggestion no die-twice trick removes.
     * SHARPENED ANGLE for R2 (replaces "stop reorg stealing the -1"): the two builds differ
     * only in what fills the CdlDemute `bnez`'s slot -- retail takes `addu $a0,$zero,$zero`
     * from the FALL-THROUGH thread, ours eager-steals `li $v0,-1` from the TARGET thread.
     * reorg.c:3901 picks the thread from `mostly_true_jump`, which for this NE branch scores
     * 1 (likely taken) via the `case NE: return 1` rule at reorg.c ~1440 once
     * `rare_fallthrough - rare_dest` is 0.  So the question is precisely: what makes retail's
     * target thread yield nothing (or its rarity differ) -- a `-dj`/reorg trace on the two
     * `return -1` predecessors, NOT another source spelling. */
    /* 🏆 W72-A16 (5 -> PASS 120/120).  R2's `qty_phys_sugg = $v0` CERTIFICATE IS RETIRED --
     * the "suggestion no die-twice trick removes" IS removable, by the 20B ZERO-INSN
     * HARD-REGISTER CONFLICT (a launder whose clobber list names the suggested reg).
     * Chain of three, each measured on the gate:
     *  (1) `__asm__("" : "=r"(sr) : "0"(sr) : "$2")` -- the clobber puts $v0 into the
     *      qty's hard-reg conflict set, so local-alloc CANNOT honour qty_phys_sugg and
     *      retail's `addu $a0,$v0,$zero` copy MINTS.  This is the SAME device W64-A5
     *      tried as a plain launder (10, inert): the launder alone does nothing here
     *      because it does not touch the suggestion -- only the CLOBBER does.
     *      Count went EXACT 120/120 immediately; the R1 "TEXT_MOVES" item (the
     *      `li $a0,1; move $a1,$0` CD_cw(CdlNop) arg pair emitted four insns late) FELL
     *      OUT WITH IT and needs no orchestrator row.  5 -> 6 with `$2` alone, because
     *      the compare's literal 2 then takes $v0 and re-blocks the slot.
     *  (2) so the CONSTANT needs the same treatment: name it and give it a tied output on
     *      the same asm.  With both values laundered under one `"$2"` clobber, `sr`->$a0
     *      and `two`->$v1, exactly retail (6 -> 2).  Two SEPARATE laundered locals each
     *      with `"$2"` also gate 2; clobbering `$a0` on the constant's fence pushes `sr`
     *      off $a0 (6); `"$2","$3"` on `sr` alone is 6.
     *  (3) the last diff was the `bne`'s slot: reorg could not steal retail's `li $v0,-1`
     *      from the shared `err:` block because W71-A9 put a stop_search_p VOID BARRIER at
     *      its head (for the CdlDemute `bnez`, which must take its FALL-THROUGH).  The two
     *      exits want OPPOSITE reorg behaviour, so they must be SEPARATE blocks: the
     *      CdlDemute arm keeps `goto err` + the barrier, and THIS arm gets its own inline
     *      `return -1` with no barrier -- reorg then duplicates its `li $v0,-1` into the
     *      slot exactly as retail does.  Measured: inline return here 0 (PASS) - dropping
     *      the `err:` barrier instead 3 - dropping it AND inlining 3 - inlining WITH a
     *      void barrier in the arm 4.  (Generalises W71-A9's own finding that "the two
     *      error exits are ASYMMETRIC IN RETAIL": there are THREE exits and all three
     *      want different reorg treatment.) */
    {
        int sr = CD_sync(0, 0);
        int two = 2;
        __asm__("" : "=r"(sr), "=r"(two) : "0"(sr), "1"(two) : "$2");
        if (sr != two) {
            return -1;
        }
    }
    __asm__("" : : "i"(0));
    return 0;
err:
    __asm__("" : : "i"(0));   /* reorg stop_search_p barrier -- see the CdlDemute note */
    return -1;
}

/* @0x80108320 : CD_datasync -- wait for the CD DMA (channel 3) to finish (mode 0 = block). */
/* MATCH (w52-a1): SHAPE PORTED from the byte-exact Rage Racer libcd decomp,
 * C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\data_sync.c :: CD_datasync
 * (their register-asm pins are DROPPED -- forbidden here).  Three carried levers:
 *   (1) the three loop-invariant table/struct bases are EXPLICIT locals assigned
 *       between the deadline store and the counter store -- that is the oracle's
 *       materialization ORDER (s3=CD_comstr, s1=&Intr, s0=CD_intstr);
 *   (2) the alarm is inlined HERE (not via the shared get_alarm) so the printf
 *       indexes through those locals (`intr[0]`/`intr[1]`, `comstr[CD_com]`);
 *   (3) the loop is a bottom-tested do/while whose condition IS the `mode`
 *       poll test, with a `goto done` for the DMA-complete exit. */
extern int CD_datasync(int mode)
{
    char **comstr;
    volatile unsigned char *intr;
    char **intstr;
    int spinmax;
    int ret;

    ALARM.deadline = VSync(-1) + 0x3c0;
    spinmax = 0x3c0000;
    comstr = CD_comstr;
    intr   = &Intr.sync;
    intstr = CD_intstr;
    ALARM.counter = 0;
    ALARM.name = "CD_datasync";
    do {
        int status;
        if (VSync(-1) > ALARM.deadline || _spin_bump() > spinmax) {
            /* MATCH (w53-a9): the oracle's arg block issues
             *   lbu sync; lbu ready; lw name; <ready index+load>; <sync sll>;
             *   lbu CD_com; <com index+load>; sw ready,16(sp); lw sync-value
             * i.e. the CD_com byte load comes LATE (after the ready STRING is
             * already in a register) and the sync STRING load is the very last
             * insn before the call.  With all four args spelled inline, cc1's
             * sched1 hoists the CD_com lbu to the head of the load group (all
             * three byte loads back-to-back) -- 22 diffs.  Splitting the two
             * "ready" arg into a NAMED local, and the "sync" arg's INDEX BYTE
             * (only the index -- the string load stays inline so it lands last)
             * into another, gives the RTL the oracle's evaluation order and
             * sched1 reproduces the block exactly.  Hoisting the sync STRING
             * instead (or both strings) pulls its load forward = 12; hoisting
             * only the ready string = 20; hoisting both index bytes = 22. */
            /* W62-A6 -- the ONE genuinely new device the w60-a4 sched1 HARDNESS
             * CERTIFICATE had not been tested against: a zero-insn SCHEDULING BARRIER
             * (13B head-of-thread void fence).  All three placements measured on this,
             * the 8-diff instance: before `puts` 10, after `puts` 10, BETWEEN the arg
             * chain and the `printf` 10 -- every one WORSE than the unfenced 8.  The
             * certificate therefore stands: the residual is a sched1 ready-list pick
             * forced by the MIPS-I load-delay hazard on the CD_com load, and a barrier
             * cannot change WHICH insn is ready at that cycle.  */
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx   = intr[0];
            readyName = intstr[intr[1]];
            printf("%s:(%s) Sync=%s, Ready=%s\n", ALARM.name,
                   comstr[CD_com], intstr[syncIdx], readyName);
            CD_flush();
            status = -1;
        } else {
            status = 0;
        }
        if (status != 0) {
            ret = -1;
            return ret;
        }
        if ((*D_8013C250 & 0x1000000) == 0) {
            ret = 0;
            goto done;
        }
    } while (mode == 0);
    ret = 1;
done:
    return ret;
}

/* @0x80108488 : CD_getsector -- DMA `size` words of the current sector to `madr` (blocking). */
extern int CD_getsector(void *madr, int size)
{
    CDREG0 = 0;
    CDREG3 = 0x80;
    *D_8013C240 = 0x20943;
    *D_8013C21C = 0x1323;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)
        ;
    *D_8013C250 = 0x11000000;
    while (*D_8013C250 & 0x1000000)
        ;
    *D_8013C21C = 0x1325;
    return 0;
}

/* @0x80108588 : CD_getsector2 -- async variant (kick the DMA, do not wait for completion). */
extern int CD_getsector2(void *madr, int size)
{
    volatile int tmp;    /* oracle spills the D3_CHCR readback to a stack slot -> volatile local */
    CDREG0 = 0;
    CDREG3 = 0x80;
    *D_8013C240 = 0x21020843;
    *D_8013C21C = 0x1325;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)
        ;
    *D_8013C250 = 0x11400100;
    tmp = *D_8013C250;   /* readback stored to the stack slot; NOT re-read (no `(void)tmp` -> no extra lw) */
    return 0;
}

/* @0x80108674 : patch command 0x19's parameter count.  ECOFF identifies
 * ComAttr as the owning aggregate; element 0x79 is retail VA 0x8013C1F0. */
extern void CD_set_test_parmnum(int n) { ComAttr[0x79] = n; }

/* @0x80108680 : the registered CD interrupt handler (InterruptCallback(2, ...)).
 * W60-A4: moved to the END of the TU -- retail VA order puts it LAST in drv.obj
 * (it sat 2nd in source, inverting all 11 following functions; tu_order_audit). */
extern void _cd_intr_dispatch(void) { callback(); }

/* Remaining BIOS.O register-cache words follow CD_init's static `tab` in
 * retail .data.  Keeping the definitions after the function reproduces that
 * source/emission order while the declarations near the top serve earlier
 * users. */
static volatile unsigned int *dv5_delay = (volatile unsigned int *)0x1f801018;
static volatile unsigned int *d_pcr     = (volatile unsigned int *)0x1f8010f0;
static volatile unsigned int *d3_madr   = (volatile unsigned int *)0x1f8010b0;
static volatile unsigned int *d3_bcr    = (volatile unsigned int *)0x1f8010b4;
static volatile unsigned int *d3_chcr   = (volatile unsigned int *)0x1f8010b8;

/* BIOS.OBJ uses 16-byte section tails.  These are layout directives only:
 * the retail CPE contains twelve zero bytes after both the last .rdata string
 * and d3_chcr, while the SYM/ECOFF BSS extent likewise rounds Alarm to 0x30. */
__asm__("\t.data\n\t.align\t4\n\t.rdata\n\t.align\t4\n\t.text");
