/* syslib/psx/libgpu/SYS.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; Ghidra mangled here).
 *   obj libgpu.lib(SYS.OBJ) @0x800ED670..0x800EFE58 -- the complete PsyQ libgpu GPU driver:
 *   the public API (ResetGraph/DrawSync/DrawOTag/Put+GetEnv/SetEnv/LoadImage/ClearOTagR/...) over
 *   the internal engine (GPU register I/O, DMA-chain processor, command queue, blitters,
 *   timeout watchdog, video-mode setup).
 *
 *   Reconstructed in 4 review sub-groups:
 *     1. leaf register/memory primitives + GPU-context state model   <-- THIS COMMIT
 *     2. DMA-chain + command-queue engine
 *     3. env builders + software blitters
 *     4. public API
 *
 *   GPU MMIO is reached indirectly through context pointers (set up by _reset /
 *   _gpu_init_videomode), exactly as the original driver does:
 *     GPU_GP0 @0x801237A0 -> 0x1F801810 (GP0 / GPUREAD)
 *     GPU_GP1 @0x801237A4 -> 0x1F801814 (GP1 / GPUSTAT)
 *     DMA ch2 (GPU)  MADR/BCR/CHCR @0x801237A8/AC/B0
 *     DMA ch6 (OTC)  MADR/BCR/CHCR @0x801237B4/B8/BC ; DPCR @0x801237C0
 *
 *   w26-a3 TOOLCHAIN migration (.cpp -> .c, CC1PSX/C lane): mechanical only --
 *   `extern "C"` stripped (plain C has no name mangling to guard against), a local
 *   `bool`/`true`/`false` shim added (matches the eaclib spchrule.c/spchsamp.c and
 *   libc/SPRINTF.c convention for C TUs that used C++'s builtin bool), and every
 *   C89 "mixed declarations and code" spot (a `TYPE x = expr;` appearing after a
 *   prior STATEMENT in the same block -- illegal pre-C99) rewritten as a bare
 *   `TYPE x;` hoisted to the top of its enclosing block plus an `x = expr;`
 *   assignment left at the original textual position, so evaluation order/timing
 *   is unchanged (§3.25 code class: this is dialect-only, no semantic edit).
 *   Dual-compile measurement (verify_asm.py, cc1 vs the pre-migration cc1plus
 *   baseline) confirmed net non-regressive across all 44 oracled functions --
 *   see the migration commit message for the full per-fn before/after table.
 *
 *   W60-A3 (2026-08-14) -- FUNCTION ORDER.  The definitions below are emitted in RETAIL VA
 *   ORDER (0x800ED670 ResetGraph .. 0x800EFE34 _memset).  They used to follow the four
 *   reconstruction "sub-groups", which put 37 of the 44 symbols after a higher-VA symbol --
 *   the W59-11C MSC02 defect class (wrong VAs in a real link; the byte gate diffs one symbol
 *   in isolation and can never see it).  All file-scope state keeps its original RELATIVE
 *   order and now precedes every body; the forward-declaration block before `_gpu_tbl` exists
 *   only because that table's initializer names 15 of the functions.  KEEP THE ORDER: check
 *   with `python tools/tu_order_audit.py 2>&1 | grep libgpu.SYS` (must print nothing).
 *
 *   W60-A3 -- WHOLE-TU RUNG LADDER (04Z says re-ladder after every landing; this is the
 *   post-reorder table, `NFS4_FORCE_CC1_ALT=<v> python tools/tugate.py <this file>`):
 *     2.8.1 (wired) 34/44 PASS  | 2.8.0 34/44 (identical except MoveImage 9 -> 35)
 *     2.91.66       far-miss    | 2.95.2 far-miss  (both wreck the whole TU)
 *   Sub-2.8 rungs cannot be laddered whole-TU at all: they reject `-mno-split-addresses`,
 *   which this TU's clamp identity needs.  They CAN be reached per-function -- see DrawOTag. */

typedef unsigned long  u_long;
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
typedef int bool;
#define true 1
#define false 0

/* PsyQ's own libgpu clamp idiom (verbatim from the matched PSY-Q 4.0 sys.c in the
 * psyz decomp): a nested ternary that assigns BACK into the value being clamped.
 * The oracle PROVES the shape: every clamp site reads its source TWICE with two
 * DIFFERENT widths -- `lh` for the `> high` compare (int) and `lhu` for the
 * assignment arm (truncated to the short lvalue) -- which only a macro that
 * expands `value`/`high` twice can produce. */
#define CLAMP(value, low, high)  ((value) < (low) ? (low) : ((value) > (high) ? (high) : (value)))

typedef struct RECT { short x, y, w, h; } RECT;   /* the PsyQ libgpu RECT */

/* PsyQ DRAWENV prefix (the DR_ENV primitive follows at +0x1C -- see PutDrawEnv). */
typedef struct DRAWENV {
    RECT    clip;      /* 0x00 */
    short   ofs[2];    /* 0x08 */
    RECT    tw;        /* 0x0C */
    u_short tpage;     /* 0x14 */
    u_char  dtd;       /* 0x16 */
    u_char  dfe;       /* 0x17 */
    u_char  isbg;      /* 0x18 */
    u_char  r0, g0, b0;/* 0x19..0x1B */
} DRAWENV;

/* ---- GPU context state (BSS; pointers installed at runtime by _reset) ----
 * These 4-byte pointers would default to .sbss under -G4 (gp-relative).
 * The oracle addresses every one of them ABSOLUTELY (lui %hi; lw %lo).
 * Force each into regular .bss so the compiler materialises them with
 * lui+lw, not a single gp-relative lw (§3.12 #6 absolute lever). */
static volatile u_long *GPU_GP0  __attribute__((section(".bss")));  /* @0x801237A0 */
static volatile u_long *GPU_GP1  __attribute__((section(".bss")));  /* @0x801237A4 */
static volatile u_long *D2_MADR  __attribute__((section(".bss")));  /* @0x801237A8 */
static volatile u_long *D2_BCR   __attribute__((section(".bss")));  /* @0x801237AC */
static volatile u_long *D2_CHCR  __attribute__((section(".bss")));  /* @0x801237B0 */
static volatile u_long *D6_MADR  __attribute__((section(".bss")));  /* @0x801237B4 */
static volatile u_long *D6_BCR   __attribute__((section(".bss")));  /* @0x801237B8 */
static volatile u_long *D6_CHCR  __attribute__((section(".bss")));  /* @0x801237BC */
static volatile u_long *DMA_DPCR __attribute__((section(".bss")));  /* @0x801237C0 */

/* @0x8013EAF8 : last value written per GP1 command (top byte = index).
 * Non-static + .bss to force gcc to use the split %hi/%lo reloc displacement
 * form (lui; addu idx; lbu/sb %lo(arr)) instead of fused lui+addiu form. */
/* 🔴 W65-A6: the `section(".bss")` attribute here was INERT -- gcc-2.7.2 emits an
 * uninitialised file-scope object as `.comm _gp1_shadow,256` regardless, and SYS.c is on the
 * cc1_alt/272-style lane (no maspsx), so `nm` reported it COMMON (`C`): the last-but-one of the
 * 37 tree-wide COMMONs.  ld -- not the object -- places COMMONs, so it could never land at
 * 0x8013EAF8 (W62-A18 T6).  `D_8013EAD8` (2 reloc sites) was undefined outright.
 * Both are genuine BSS (> t_addr+t_size 0x8013E000 => no file bytes) and CONTIGUOUS, so one
 * object-owned `.section .bss` block covers the run exactly:
 *      D_8013EAD8   @0x8013EAD8  32  (= 0x8013EAF8 - 0x8013EAD8; the _blit_buf+10 restore
 *                                     sub-packet this TU already names at line ~192)
 *      _gp1_shadow  @0x8013EAF8 256  (ends 0x8013EBF8; _que @0x8013EC00 follows after 8 B)
 * The C view stays `extern`, which is ALSO what the comment above asks for (split %hi/%lo
 * displacement form rather than a fused lui+addiu) -- byte-neutral by construction, 39/44 PASS
 * unchanged.  Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\tD_8013EAD8\n\t.globl\t_gp1_shadow\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "D_8013EAD8:\n\t.space\t32\n"
        "_gp1_shadow:\n\t.space\t256\n\t.text");
extern u_char _gp1_shadow[256];

/* ============================ SUB-GROUP 1 ============================ */

/* ============================ SUB-GROUP 2 ============================
 *   Async DMA-chain + command-queue engine.  GPU work requests are pushed to a 64-entry
 *   ring of slots; a slot is dispatched either inline (when the GPU is idle) or from the
 *   channel-2 DMA-complete interrupt (the drain).  A VSync-based watchdog recovers from a
 *   wedged GPU (timeout -> reset queue + GPU).  All ring/index mutation runs inside a
 *   SetIntrMask(0) critical section. */

extern int  VSync(int mode);                 /* libetc  VSYNC.obj @0x800F231C */
extern int  SetIntrMask(int mask);           /* libetc  INTR.obj  @0x800F2950 (returns old mask) */
extern int  DMACallback(int ch, int func);   /* libetc  INTR.obj  @0x800F28AC */
extern int  printf(const char *fmt, ...);    /* libc    C63.obj   @0x801028AC */

typedef void (*QueFunc)(u_long *arg, int extra);

typedef struct GpuQue {               /* 0x60 bytes */
    QueFunc func;                    /* +0x00 */
    u_long *arg;                     /* +0x04 */
    int     extra;                   /* +0x08 */
    u_long  buf[21];                 /* +0x0C : inline-copied args (when push n != 0) */
} GpuQue;
typedef union GpuQueRing {
    /* The matched Rage Racer producer writes the interrupt-shared ring through volatile
     * lvalues, while the retail drain allocation requires ordinary field reads.  Both views
     * name the same 0x1800-byte storage; the detailed gate confirms push PASS and preserves
     * the drain's smaller allocation basin. */
    GpuQue plain[64];
    volatile GpuQue shared[64];
} GpuQueRing;
static GpuQueRing _que;              /* @0x8013EC00 : the request ring */
/* MATCH: force absolute placement (same §3.12 lever as GPU_GP0/GEnv above) -- the oracle
 * addresses every one of these via lui %hi;lw/sw %lo, never gp-relative. Without the section
 * force these 4-byte statics default into .sbss under -G4 (single gp-relative lw/sw), a
 * systematic divergence that cascades through _gpu_que_drain/_gpu_que_push/_reset/ResetGraph. */
/* MATCH: _qin/_qout are VOLATILE.  The producer index is bumped by _gpu_que_push on the main
 * thread while the consumer index is bumped by _gpu_que_drain running from the channel-2 DMA
 * interrupt, so each genuinely changes behind the compiler's back -- and the oracle shows it:
 * every single test and every `_que[_qout]` field fetch RE-LOADS the index from memory
 * (three independent `lui/lw _qout` + *96 chains inside one dispatch block).  Plain ints let
 * gcc CSE all of them into one register, running _gpu_que_drain 16 instructions short. */
static volatile int _qin         __attribute__((section(".bss")));  /* @0x801237C4 : producer index (mod 64) */
static volatile int _qout        __attribute__((section(".bss")));  /* @0x8013xxxx : consumer index (mod 64) */
static int    _q_saved_mask      __attribute__((section(".bss")));  /* @0x801237CC : imask saved across the push critical section */
static int    _drain_saved_mask  __attribute__((section(".bss")));  /* @0x801237D0 : imask saved across the drain critical section */
static int    _q_reset_mask      __attribute__((section(".bss")));  /* @0x801237D4 : imask saved across timeout/reset */
static int    _gpu_timeout_target __attribute__((section(".bss")));  /* @0x801237D8 : VSync deadline */
static int    _gpu_timeout_count  __attribute__((section(".bss")));  /* @0x801237DC : spin counter */
/* @0x8012369C..0x8012371C : the whole "GEnv" GPU-environment block, 0x80 bytes, cleared in ONE
 * shot by ResetGraph (`_memset(&GEnv,0,0x80)` in the oracle -- NOT 7 separate field=0 stores,
 * which is what an earlier draft of this file did). Modeled as a real struct so multi-field
 * accesses within one function share ONE `lui %hi(GEnv)` base + per-field CONST offsets (matching
 * the oracle's addressing), instead of each field re-materializing its own independent %hi/%lo.
 * Force the instance into REGULAR .bss (absolute), not .sdata/.sbss gp-rel -- the oracle addresses
 * every GEnv field absolute (§3.12 absolute lever), same reasoning as the GPU_GP0/GP1/DMA ptrs above. */
typedef struct GEnvT {
    char    mode;      /* +0x00 @0x8012369C : current video mode (was static _genv_mode) */
    u_char  active;     /* +0x01 @0x8012369D : driver running, set by ResetGraph (was static _gpu_active) */
    u_char  debug;      /* +0x02 @0x8012369E : GPU debug level, 0=off (was static _gpu_debug) */
    u_char  _pad3;      /* +0x03 @0x8012369F : NOT unreferenced -- PutDispEnv reads it and ORs
                         * 0x80 into the mode cmd when nonzero (found reconstructing PutDispEnv;
                         * no call site sets it yet, semantics otherwise unknown). */
    short   screenW;    /* +0x04 @0x801236A0 : current screen width (was static _screenW) */
    short   screenH;    /* +0x06 @0x801236A2 : current screen height (was static _screenH) */
    int     busy;       /* +0x08 @0x801236A4 (was static _gpu_busy) */
    void  (*idle_cb)();  /* +0x0C @0x801236A8 : "queue drained" callback.  UNPROTOTYPED --
                          * the oracle's `jalr $a0` has a bare `nop` delay slot and NO $aN
                          * setup, so it takes no arguments (psyz: `void (*drawSyncCb)()`). */
    char    drawenv[0x5c]; /* +0x10 @0x801236AC : last-set DRAWENV cache (was static _genv_drawenv) */
    char    dispenv[0x14]; /* +0x6C @0x80123708 : last-set DISPENV cache (was static _genv_dispenv) */
} GEnvT;                                                          /* total 0x80 bytes, matches the oracle's clear */
static GEnvT GEnv __attribute__((section(".bss")));   /* @0x8012369C */

extern int _gpu_que_drain(void);     /* @0x800EF60C (fwd) */

/* ============================ SUB-GROUP 3a ============================
 *   DRAWENV -> DR_ENV builders.  These pack the GP0 environment commands (clip area, draw
 *   offset, draw mode, texture window) from a DRAWENV, clamping coordinates to the screen.
 *   _set_drawenv assembles the whole DR_ENV primitive and, when DRAWENV.isbg is set, appends
 *   a background-clear fill (GP0 0x02 fast fill for 64-aligned rects, GP0 0x60 mono-rect with
 *   offset-relative coordinates otherwise).  Screen size lives in GEnv.screenW/GEnv.screenH. */

/* ============================ SUB-GROUP 3b ============================
 *   Software blitters (the *Image backends).  Each clamps its RECT to the screen, then:
 *     _BlitClear : builds a self-restoring OT in _blit_buf -- it queries the live draw env
 *                  (_get_gpuinfo 3/4/5), clears under a full-screen clip, then restores the
 *                  env -- and kicks it via _gpu_dma_chain.
 *     _dws       : LoadImage  (CPU->VRAM, GP0 0xA0): manual remainder words + 16-word DMA blocks.
 *     _drs       : StoreImage (VRAM->CPU, GP0 0xC0): manual remainder reads + 16-word DMA blocks.
 *   _dws/_drs poll the GPU-ready bit with the watchdog and bail (-1) on timeout. */

static u_long _blit_buf[18];   /* @0x8013EAB0 : scratch OT for _BlitClear */
extern u_long D_8013EAD8[];    /* restore sub-packet at _blit_buf + 10 */

/* ============================ SUB-GROUP 4a ============================
 *   Public env-setter primitives.  Each fills a small GPU primitive `p` (length byte at +3,
 *   GP0 command words at +4/+8/...) using the SG3a word builders.  No queue/DMA involved. */

/* ============================ SUB-GROUP 4b-i ============================
 *   The GPU driver dispatch table + the public ops that go through it.  libgpu reaches its
 *   primitive routines indirectly via a link-time-constant table (the PsyQ "GsGPU" struct)
 *   pointed to by a const pointer at 0x80123694 -> table @0x80123654.  Image ops push a work
 *   request (snapshotting the 8-byte RECT into the queue slot, n=8); DrawOTag/MoveImage push a
 *   DMA-chain; ClearOTagR clears via the OTC DMA; DrawSync waits on the queue/GPU. */

/* GPU_printf @0x80123698 : libgpu debug-print hook fn-ptr; null unless SetGraphDebug installs it.
 *   Defined here (SYS.obj owns it); all libgpu trace sites call through it. */
/* GEnv block (0x80123694..) lives in REGULAR .data/.bss in the original -- the oracle addresses every
 * field ABSOLUTE (`lui %hi;lw/lbu %lo`).  Small (<=4B) statics would default into .sdata/.sbss under
 * -G4 here -> single gp-relative loads, a systematic +1-insn divergence.  Pin each into .data (init)
 * or .bss (zero) so it materializes absolute, matching the oracle (§3.12 absolute lever; gp-rel
 * CAVEAT: a small global can be regular .data/.bss, not .sdata/.sbss). */
extern int (*GPU_printf)(const char *fmt, ...) __attribute__((section(".bss"))) = 0;

static u_long _move_prim[5] = {      /* @0x80123734 : MoveImage's VRAM->VRAM copy primitive */
    0x04ffffffu,                     /* tag: 4 words, terminates */
    0x80000000u                      /* GP0 0x80 move-image command */
};

extern int _reset(int mode);                     /* @0x800EF86C (fwd; defined in SG4b-ii) */
extern int _sync(int mode);                      /* @0x800EF9BC (fwd; defined below) */

typedef struct GpuTbl {                          /* @0x80123654 */
    const char *id;                              /* +0  */
    int  (*que_ref)(QueFunc, u_long *, int);     /* +4  _que_ref */
    int  (*que_push)(QueFunc, u_long *, int, int);/* +8  _gpu_que_push */
    QueFunc blit_clear;                          /* +12 _BlitClear */
    void (*send_gp1)(u_long);                    /* +16 _send_gp1 */
    int  (*send_gp0)(u_long *, int);             /* +20 _send_gp0 */
    void (*dma_chain)(u_long *);                 /* +24 _gpu_dma_chain */
    QueFunc drs;                                 /* +28 _drs */
    QueFunc dws;                                 /* +32 _dws */
    int  (*que_drain)(void);                     /* +36 _gpu_que_drain */
    int  (*get_gp1)(int);                        /* +40 _get_gp1 */
    void (*clear_otag)(u_long *, int);           /* +44 _clearOTagR_dma */
    int  (*get_gpuinfo)(u_long);                 /* +48 _get_gpuinfo */
    int  (*reset)(int);                          /* +52 _reset */
    int  (*get_status)(void);                    /* +56 _get_status */
    int  (*sync)(int);                           /* +60 _sync (DrawSync backend) */
} GpuTbl;

/* ---- forward declarations -------------------------------------------------
 * W60-A3: the function DEFINITIONS below are emitted in retail VA order (the
 * object's .text symbol order must match 0x800ED670..0x800EFE58; a wrong intra-TU
 * order is a LINK-VISIBLE defect the byte gate cannot see -- see the MSC02
 * precedent).  Since a callee can now sit after its call site, every definition
 * gets a prototype here.  The prototypes are byte-identical to the definitions'
 * own signatures, so no call site sees a different declaration than before. */
extern int ResetGraph(int mode);
extern void SetDispMask(int mask);
extern int DrawSync(int mode);
extern void _image(const char *label, RECT *r);
extern int ClearImage(void *rect, unsigned char r, unsigned char g, unsigned char b);
extern int LoadImage(void *rect, u_long *data);
extern int StoreImage(void *rect, u_long *data);
extern int MoveImage(void *rect, int x, int y);
extern u_long *ClearOTagR(u_long *ot, int n);
extern void DrawOTag(u_long *ot);
extern void *PutDrawEnv(void *env);
extern void *PutDispEnv(void *env);
extern void SetTexWindow(void *p, void *tw);
extern void SetDrawArea(void *p, void *r);
extern void SetDrawStp(void *p, int pbw);
extern void SetDrawMode(void *p, int dfe, int dtd, int tpage, void *tw);
extern void SetDrawEnv(void *dr_env, void *env);
extern void _set_drawenv(void *dr_env, void *env);
extern u_long _set_draw_mode(int dfe, int dtd, int tpage);
extern u_long _set_clip_tl(short x, short y);
extern u_long _set_clip_br(short x, short y);
extern u_long _set_draw_offset(int x, int y);
extern u_long _get_tw(void *tw);
extern int _get_status(void);
extern int _clearOTagR_dma(u_long *ot, int n);
extern int _BlitClear(RECT *rect, u_long color);
extern int _dws(RECT *rect, u_long *data);
extern int _drs(RECT *rect, u_long *data);
extern void _send_gp1(u_long cmd);
extern int _get_gp1(int idx);
extern int _send_gp0(u_long *p, int n);
extern void _gpu_dma_chain(u_long *ot);
extern int _get_gpuinfo(u_long cmd);
extern int _que_ref(QueFunc func, u_long *arg, int extra);
extern int _gpu_que_push(QueFunc func, u_long *arg, int n, int extra);
extern int _gpu_que_drain(void);
extern int _reset(int mode);
extern int _sync(int mode);
extern void _gpu_arm_timeout(void);
extern int _gpu_check_timeout(void);
extern int _gpu_init_videomode(int mode);
extern int DrawOTag2(u_long *p);
extern void _install_drain_cb(void);
extern void _memset(char *p, int c, int n);

static const GpuTbl _gpu_tbl = {                 /* the live driver table */
    "GPU",                                        /* @0x80056cd8 */
    _que_ref, _gpu_que_push, (QueFunc)_BlitClear, _send_gp1, _send_gp0,
    _gpu_dma_chain, (QueFunc)_drs, (QueFunc)_dws, _gpu_que_drain, _get_gp1, _clearOTagR_dma,
    _get_gpuinfo, _reset, _get_status, _sync
};
/* GEnv_drv lives in REGULAR .data in the original (oracle addresses it ABSOLUTE: `lui %hi;lw %lo`),
 * but a 4-byte initialized pointer would default into .sdata under -G4 here -> a single gp-relative
 * load (`lw v0,N(gp)`), a +1-insn divergence (LoadImage/StoreImage 1 from PASS).  Force it back into
 * .data with an explicit section so it is addressed absolute, matching the oracle (§3.12 absolute
 * lever; the gp-rel CAVEAT -- a small global can be regular .data, not .sdata). */
static const GpuTbl *GEnv_drv __attribute__((section(".data"))) = &_gpu_tbl;   /* @0x80123694 -> @0x80123654 */

/* ============================ SUB-GROUP 4b-ii (FINALE) ============================
 *   GPU init/reset + env-commit, with their data tables.  ResetGraph zeroes GEnv, resets the
 *   queue+GPU via _reset, latches the video mode and screen size; PutDrawEnv/PutDispEnv commit a
 *   draw/display environment (caching the last one in GEnv); ClearOTagR clears an OT in reverse
 *   and links a fixed terminator tail. */

extern int   GetVideoMode(void);                 /* libetc VMODE.obj */
/* w26-a3: called via a renamed local decl (asm-label back to the real symbol "memcpy") --
 * under CC1PSX (C lane, unlike cc1plus) both calls below pass a COMPILE-TIME-CONSTANT length
 * (0x5c/0x14), which gcc's builtin-function table matches by the literal identifier "memcpy"
 * and expands INLINE as an lwl/lwr/swl/swr unrolled copy (~35 extra insns, PutDrawEnv 48->95),
 * unlike the oracle (and the pre-migration cc1plus build, which never triggered this because
 * C++'s extern "C" memcpy apparently never hit gcc2's builtin table the same way here) which
 * always calls the real libc C42.obj routine. The asm-label renames the C-visible identifier so
 * gcc's name-keyed builtin lookup can't match it, while still linking to the real "memcpy"
 * symbol -- a real `jal memcpy`, verified byte-for-byte against this same idiom in isolation. */
extern void *_memcpy(void *d, const void *s, unsigned n) __asm__("memcpy");/* libc C42.obj @0x800EAAC4 */
extern void  GPU_cw(u_long cw);                  /* libapi C73.obj @0x80104A0C (BIOS) */
extern void  ResetCallback(void);                /* libetc INTR.obj @0x800F284C */

/* per-video-mode VRAM clip extents: stride-4 in .data (low u16 = value, high u16 = 0
   padding); @0x8012371C (_vmode_w) / 0x80123728 (_vmode_h). EXE bytes 00 04 00 00.. confirm
   4-byte stride; oracle ResetGraph reads u_short @ base + mode*4 (sll 2, lhu). */
static const struct { u_short v, pad; } _vmode_w[3] = { {1024,0}, {1024,0}, {1024,0} };  /* @0x8012371C */
static const struct { u_short v, pad; } _vmode_h[3] = { { 512,0}, { 512,0}, {1024,0} };  /* @0x80123728 */

/* display H/V overscan ranges, indexed (videomode*5 + resIdx); @0x80123770 (base/end u16 pairs). */
static const struct { u_short base, end; } _disp_overscan[10] = {
    { 590, 3150 }, { 600, 3160 }, { 539, 3227 }, { 615, 3175 }, { 620, 3180 },
    { 610, 3170 }, { 624, 3184 }, { 560, 3248 }, { 635, 3195 }, { 640, 3200 }
};
static const u_char _disp_mult[5] = { 10, 8, 7, 5, 4 };    /* @0x80123798 : per-resIdx dot multiplier */

static u_long _otc_link;                       /* @0x8012375C : OT terminator link (runtime) */
static const u_long _otc_term = 0x04ffffffu;   /* @0x80123748 : list terminator word */
/* @0x800ED670 : initialise the graphics system for the given mode. */
extern int ResetGraph(int mode)
{
    GEnvT *g;
    u_char *graphState;
    int graphType;
    u_char *clearEnv;
    int fillValue;
    /* W52-A3, from the matched psyz `ResetGraph`:
     *  - a `switch (mode & 7)` with case 3 / case 0 FALLING THROUGH into case 5 (the
     *    oracle's `beq 3 -> print block -> falls into the memset block`, plus the
     *    balance_case_nodes tree `beq 3 / slti 4 / beqz 0 / beq 5`);
     *  - the screen size is indexed by a RE-READ of the just-stored GEnv.mode
     *    (`sb $v0,0($s0)` then THREE separate `lbu $v0,0($s0)`), never by a local --
     *    the store-then-read-back is the whole shape;
     *  - the return value is likewise a fresh `lbu` of GEnv.mode. */
    switch (mode & 7) {
    case 3:
    case 0:
        printf("ResetGraph:jtb=%08x,env=%08x\n",   /* @0x80056D10 (always; libc printf) */
               (int)(long)&_gpu_tbl, (int)(long)&GEnv);
        /* FALLTHROUGH */
    case 5:
        /* MATCH: ONE base register for the whole GEnv block -- the oracle keeps
         * `la $s0,GEnv` (materialized for the first _memset arg) and reaches every
         * field by displacement (0/1/4/6/0x10/0x6C).  Under the macro lane a bare
         * `GEnv.field = ...` is an `sw/sb $r,sym` $at macro instead; the fenced
         * pointer local restores the anchor. */
        g = &GEnv;
        __asm__("" : "=r"(g) : "0"(g));
        graphState = (u_char *)g;
        _memset((char *)graphState, 0, 0x80);
        ResetCallback();
        GPU_cw((u_long)(long)GEnv_drv & 0x00ffffffu);
        graphType = _reset(mode);
        clearEnv = graphState + 0x10;
        *(volatile u_char *)graphState = graphType;
        /* MATCH (2026-08-14, 30 -> PASS, 93/93): port Rage Racer's matched
         * ResetGraph inner-block shape: read mode, store active, fetch width,
         * re-read mode, then store width/height.  With this 2.8.1 lane the raw
         * byte locals add two unwanted `andi 255`s; staging the already-scaled
         * offsets in int locals preserves the retail `lbu; sll` webs and their
         * v0/v1 allocation exactly.  A direct expression reached 20 diffs and
         * ordinary int/byte comma-staging was neutral or count-worse. */
        {
            int st0 = (int)*(volatile char *)graphState << 2;
            u_short v;
            int st1;

            *(volatile u_char *)(graphState + 1) = 1;
            v = *(u_short *)((char *)_vmode_w + st0);
            st1 = (int)*(volatile char *)graphState << 2;
            fillValue = -1;
            g->screenW = v;
            g->screenH = *(u_short *)((char *)_vmode_h + st1);
        }
        _memset((char *)clearEnv, fillValue, 0x5c);
        _memset((char *)graphState + 0x6c, -1, 0x14);
        return *(volatile u_char *)graphState;
    }
    if (GEnv.debug >= 2)
        GPU_printf("ResetGraph(%d)...\n", mode);   /* @0x80056D30 */
    return GEnv_drv->reset(1);
}

/* @0x800ED7E4 : turn the display on (mask!=0) or off (mask==0). */
extern void SetDispMask(int mask)
{
    if (GEnv.debug >= 2)
        GPU_printf("SetDispMask(%d)...\n", mask);   /* @0x80056DA0 (oracle @0x800ed7fc-824) */
    if (mask == 0)
        _memset(GEnv.dispenv, -1, 0x14);
    /* MATCH: the oracle dispatches through the DRIVER TABLE (`lw v0,GEnv_drv; lw v0,0x10(v0);
     * jalr v0` = GpuTbl.send_gp1 at +16), not a direct `jal _send_gp1` -- 4 insns.
     * Shape confirmed against the Rage-Racer matched libgpu (graph_control.c uses
     * g_GpuFuncs->... for the same call class). */
    GEnv_drv->send_gp1(mask ? 0x03000000u : 0x03000001u);
}

/* @0x800ED87C : DrawSync */
extern int DrawSync(int mode)
{
    if (GEnv.debug >= 2)
        GPU_printf("DrawSync(%d)...\n", mode);       /* @0x80056DB4 */
    return GEnv_drv->sync(mode);
}

/* @0x800ED8E4 : debug-only RECT validator/printer (inert when GPU debug level is 0). */
extern void _image(const char *label, RECT *r)
{
    /* W52-A3 = psyz's `checkRECT`: a real 2-case SWITCH on the debug level (the oracle's
     * `li $v0,1; beq` / `li $v0,2; beq` / `j default` linear chain is gcc-2.8's <=2-node
     * switch lowering), with the printf PAIR written out in FULL in each case -- gcc
     * cross-jumps them into the oracle's one shared print block reached by `j`.  The old
     * `fmt` funnel variable produced the merge in SOURCE and could not match.  Predicate
     * order/operands verbatim from psyz (note `r->w + r->x`, not `x + w`). */
    switch (GEnv.debug) {
    case 1:
        if (r->w > GEnv.screenW || r->w + r->x > GEnv.screenW ||
            r->y > GEnv.screenH || r->y + r->h > GEnv.screenH ||
            r->w <= 0 || r->x < 0 || r->y < 0 || r->h <= 0) {
            GPU_printf("%s:bad RECT", label);                 /* @0x80056dc8 */
            GPU_printf("(%d,%d)-(%d,%d)\n", r->x, r->y, r->w, r->h);  /* @0x80056dd4 */
        }
        break;
    case 2:
        GPU_printf("%s:", label);                             /* @0x80056de8 */
        GPU_printf("(%d,%d)-(%d,%d)\n", r->x, r->y, r->w, r->h);
        break;
    }
}

/* @0x800EDA00 : ClearImage(RECT*, r, g, b) */
extern int ClearImage(void *rect, unsigned char r, unsigned char g, unsigned char b)
{
    /* MATCH (2026-08-14): 8 -> PASS, 36/36.  Rage Racer's byte-matched libgpu
     * source preserves the original unsigned-byte RGB parameter types.  Those
     * narrow declarations change assign_parms scheduling without adding code:
     * the saved `b` copy moves into _image's jal delay slot exactly as retail. */
    int color;
    _image("ClearImage", rect);                  /* @0x80056dec */
    color = ((b & 0xff) << 16) | ((g & 0xff) << 8) | (r & 0xff);
    return GEnv_drv->que_push(GEnv_drv->blit_clear, (u_long *)rect, 8, color);
}

/* @0x800EDA90 : LoadImage(RECT*, u_long *data) */
extern int LoadImage(void *rect, u_long *data)
{
    _image("LoadImage", rect);                   /* @0x80056e04 */
    return GEnv_drv->que_push(GEnv_drv->dws, (u_long *)rect, 8, (int)data);
}

/* @0x800EDAF0 : StoreImage(RECT*, u_long *data) */
extern int StoreImage(void *rect, u_long *data)
{
    _image("StoreImage", rect);                  /* @0x80056e10 */
    return GEnv_drv->que_push(GEnv_drv->drs, (u_long *)rect, 8, (int)data);
}

/* @0x800EDB50 : MoveImage(RECT*, x, y) -- VRAM->VRAM block copy. */
extern int MoveImage(void *rect, int x, int y)
{
    short *r = (short *)rect;
    u_long *p;
    u_long srcxy;
    GpuTbl *drv;
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (r[2] == 0 || r[3] == 0)
        return -1;
    /* MATCH (W64-A3, SEALED 46/46) -- TWO landings, both mechanism-first.
     * (1) THE FENCE POSITION WAS THE CFG (see the block at the fence below):
     *     reorg's stop_search_p returns 1 at any asm, so the opacity fence at the
     *     BODY-thread head starved guard2's target-thread steal.  9 -> 4, 46/46.
     * (2) THE LAST 4 WERE A sched2 LUID TIE, not coloring: retail emits the src
     *     word load `lw $a1,0($s0)` and THEN the driver-table load `lui/lw $a3`,
     *     before `addiu $a2,$zero,0x14`.  Both are loads of equal priority, so
     *     sched.c breaks the tie on LUID = RTL order = SOURCE order.  Naming the
     *     two values (`srcxy` then `drv`, in that order, right after the anchor)
     *     puts them in retail's order -> PASS.  Measured ladder in this basin:
     *     nothing 4 * `drv` alone after the anchor 2 * `drv` after p[0]/p[1]/the
     *     fence/p[2] 4 each * `GpuTbl *drv = GEnv_drv;` decl-init 35 (49 insns) *
     *     a named `dc` for dma_chain only 14 * `srcxy` alone (no `drv`) 4 *
     *     `drv` BEFORE `srcxy` 2 (the order IS the dial) * p[1]-store-before-p[0]
     *     on top of `drv` 24 * a read-only fence on `drv` 9 (45 insns, loses the
     *     reorg steal again -- an asm right after the anchor re-starves guard2).
     * The historical falsification map below is kept as the record of what did NOT
     * work; it was all aimed at a register handout that was in fact already right.
     *
     * MATCH: PAYLOAD-ANCHOR POINTER (w51-a1, landed WITH the cc1_272 lane wiring).
     * The oracle materializes ONE base for the payload words -- `la $v1,_move_prim+8`
     * (= &_move_prim[2]) -- stores the three words as 0/4/8($v1) displacements, and
     * derives the call argument by `addiu $a1,$v1,-8`.  Direct `_move_prim[2] = ...`
     * writes compile to the assembler macro `sw $r,sym` (one `lui $at` per store)
     * under the gcc-2.7.2 lane, which has no -msplit-addresses to pre-split the
     * address.  The explicit payload pointer restores the anchor+displacement shape.
     * (Under the OLD 2.8 lane this form regressed the then-PASS to 35 -- lane-paired.) */
    p = &_move_prim[2];
    srcxy = *(u_long *)rect;
    drv = GEnv_drv;
    /* FALSIFIED (272 basin, w51): dst-xy store FIRST rotates the payload base off
     * $v1 onto $a2 and costs +16 (17 -> 33); the oracle's `sw 4 / sw 0 / sw 8`
     * emission order is a scheduling product, not the source statement order.
     *
     * 🟢 NAMED ANGLE (w59-a8, MEASURED, NOT LANDED -- 9 diffs is still the best gate score,
     * but this basin is STRUCTURALLY correct where the 9 is not; pick it up with a coloring
     * dial and it should beat 9).  The 9-diff residual is NOT coloring: ours is 45 insns vs
     * the oracle's 46 and the CFG differs.  Retail's `||` guard expands to
     *   beqz r[2] -> epilogue [slot: li v0,-1]
     *   bnez r[3] -> BODY     [slot: sll v0,s1,16  <- STOLEN from the body head]
     *   j epilogue            [slot: li v0,-1]
     *   BODY:
     * i.e. the second test branches TO the body and the `return -1` block survives.  Ours has
     * reorg invert that branch (`beqz -> epilogue`) and delete the block, because reorg fills
     * the slot from the FALL-THROUGH thread instead of the target thread -- the body's first
     * insn must be the `sll` for the eager target-steal to happen, and in our emission order
     * the body starts with the payload anchor's `lui/addiu`.
     * TWO SOURCE EDITS reproduce retail's CFG + insn count EXACTLY (46/46):
     *   (1) hoist the dst-xy word into its own statement computed BEFORE `p = &_move_prim[2]`
     *       (`u_long dstxy; dstxy = (u_long)((y << 16) | (x & 0xffff));`), which puts the
     *       `sll` at the body head where reorg can steal it -> 46/46, 22 diffs;
     *   (2) THEN store `p[1] = dstxy;` BEFORE `p[0] = src;` (the oracle's `sw 4 / sw 0 / sw 8`
     *       order really is the source order once (1) is in place -- the w51 note above was
     *       measured in the OLD basin, 04Z) -> 14 diffs, still 46/46.
     * Residual at 14: a pure 3-register rotation -- retail {dstxy=$v0, p=$v1, x&0xffff temp=$a0,
     * src=$a1 loaded early}, ours {dstxy=$v0, p=$v1, temp=$v1-reused, src reloaded at the store}
     * -- plus the anchor's `lui/addiu` sitting after the andi/or instead of between the `sll`
     * and the `andi`.  FALSIFIED on this basin (all re-measured after (1)+(2)):
     *   named `srcxy` local for `*(u_long *)rect` (22, fresh pseudo re-colors the head) *
     *   `dstxy` decl before/after `p` (14 both, decl order is not the dial here) *
     *   splitting `dstxy = y<<16; dstxy |= x&0xffff;` (14, inert) *
     *   `(x & 0xffff) | (y << 16)` operand swap (22, rotates the parm copies) *
     *   read-only fence on `dstxy` after its last use (14, inert) *
     *   anchor-assigned-first with dstxy at its store (33, loses the steal) *
     *   PER_FN flag splices -fno-schedule-insns / -insns2 / -delayed-branch / -cse-follow-jumps
     *     (29 / 21 / 26 / 14) and per-fn cc1 rungs 2.8.0 / 2.91.66 / 2.95.2 (28 / 41 / 43).
     * Also falsified on the ORIGINAL 9-diff basin: -fno-thread-jumps, -fno-schedule-insns{,2},
     * -fno-cse-follow-jumps, -fno-peephole, -fno-strength-reduce, -fno-expensive-optimizations,
     * -fno-rerun-cse-after-loop (all 9 or worse) -- the branch inversion is reorg's
     * relax_delay_slots "conditional jump around an unconditional jump", not a flag.
     *
     * W60-A3 RE-WALK of the 14-diff basin (edits (1)+(2) re-applied, re-measured, then
     * UNWOUND per the hard-floor basin rule -- 14 never beat the authoritative 9).  The
     * residual there is now DIAGNOSED, not just described: retail emits the payload ANCHOR
     * (`la $v1,_move_prim+8`) BEFORE the `andi`, so $v1 is taken and the x-mask temp falls to
     * $a0 and the src word to $a1; ours emits `andi` FIRST into the still-free $v1 and then
     * overwrites $v1 with the anchor, which frees $v0 to double as the src scratch.  One
     * ordering decision produces the whole 3-register rotation.  Every attempt to move the
     * anchor ahead of the andi WITHOUT losing reorg's `sll` steal failed:
     *   anchor assigned before dstxy, opacity fence left at its old position   -> 14 (inert;
     *     the fence, not the assignment, is what pins where the address materializes) *
     *   dstxy SPLIT across the anchor (`dstxy = y<<16;` head, `dstxy |= x&0xffff;` after the
     *     fence -- textually retail's own order)                               -> 14 (sched2
     *     re-merges the two halves back above the anchor) *
     *   the same split with the fence made `__asm__ __volatile__` (hard barrier) -> 28 *
     *   named `xm` local for the mask                                          -> 22 (fresh
     *     pseudo re-colors the head, the standard trap) *
     *   read-only fence on `*(u_long *)rect` to force the early src load       -> 16 AND
     *     +2 insns (48/46) -- a multi-operand pointer fence is not zero-insn *
     *   dropping the opacity fence entirely (its rationale was written for the retired 272
     *     lane, so it was worth re-testing on 2.8.1+nosplit)                   -> 16.
     * Ladder on this fn (whole-TU force, W60-A3): 2.8.1 = 9 (wired), 2.8.0 = 35, 2.91.66 = 45,
     * 2.95.2 = 45; per-fn 2.7.2 splice = 18 real, 2.6.3 = 23 real.  No rung helps.
     * 🔴 W60-A3 ROUND 2 -- I TOOK THE INSTRUMENT LANE TO IT, AND MY OWN "sched2 emission
     * order" ANGLE ABOVE IS FALSIFIED.  Recipe (11A, real ladder cc1, no instrumented build
     * needed): compile the TU's own .i with `-dS -dR -dl -dg` and read the post-global-alloc
     * RTL (`*.greg`) + the sched2 ready lists (`*.sched2`); artifacts under
     * scratchpad/w60a3/instr/.  In the 46/46 basin MoveImage's body block is, ALREADY at
     * greg (i.e. before sched2 runs):
     *     48 (set (reg v0) (ashift (reg s1) 16))            <- the sll reorg steals
     *     49 (set (reg v1) (and (reg s2) 65535))            <- the x mask  -> $v1
     *     50 (set (reg v0) (ior (reg v0) (reg v1)))
     *    106 (set (reg v1) (const (plus (symbol_ref "_move_prim") 8)))   <- anchor REUSES $v1
     * and sched2's block-3 ready lists never reorder that quartet (it emits 48,49,50,106 in
     * RTL order; its only real choices are further down, around the a3/a0/a2 call setup).
     * ⇒ The residual is NOT an emission-order/scheduling decision at all.  It is a GLOBAL
     * REGISTER ASSIGNMENT: the allocator hands the anonymous mask temp `$v1` and then reuses
     * `$v1` for the anchor once the mask dies, whereas retail parks the mask in `$a0` and the
     * src word in `$a1`, leaving `$v1` to the anchor for its whole live range.  The 3-register
     * rotation is a consequence of that ONE handout, which is why every statement-order,
     * split, fence-flavour and named-temp spelling above was inert or worse.
     * ⇒ Also explains the two "inert" readings precisely: `p` is the opacity fence's OUTPUT,
     * so insn 106 is generated at the FENCE's position, not at the assignment's -- moving
     * `p = &_move_prim[2];` earlier while leaving the fence alone cannot move the anchor.
     * NEXT ANGLE (named, correctly this time): dial the mask temp's allocno REFS so it loses
     * $v1 to the anchor (05C/06B fence dials).  ⚠️ It must be dialed EMPIRICALLY -- allocsim/
     * reqdelta do not model this lane (11A: "reqdelta unusable in 272/alt lanes") -- and the
     * mask is an ANONYMOUS temp here, while giving it a name to fence costs +8 (the 22 row
     * above).  So the dial has to be applied to a NEIGHBOURING named value, not to the mask.
     * W62-A3 -- THE NAMED ANGLE ABOVE IS NOW FALSIFIED.  `p` IS the neighbouring named value
     * (it owns the anchor), and its ref dial is INERT past one operand: in the 14-basin
     * (edits (1)+(2) re-applied, control re-measured at 14, 46/46) a read-only fence on `p`
     * with 1 / 2 / 3 / 4 operands gives 22 / 22 / 22 / 22 -- the +1 change is structural, not
     * a priority step, so the handout is not ref-priced here.  In the authoritative 9-basin
     * the same fence gives 23 (1-op) / 23 (2-op).  Also falsified this wave, all in the
     * 14-basin: a read-only fence on `dstxy` after the stores 32 (+2 insns); anchor assigned
     * and fenced FIRST 33 (loses reorg's sll steal, reproducing the W60-A3 reading exactly);
     * `dstxy` split across the anchor 14 (inert), that split with an identity launder on
     * `dstxy` 14, and a joint 2-operand fence on (p, dstxy) after the anchor 22.
     * REMAINING ANGLE (unchanged in kind, now with one option removed): the handout that must
     * move is the ANONYMOUS mask temp's, and neither naming it (+8) nor dialling its only
     * named neighbour reaches it -- this is the 06E local-alloc/global-handout gap, and the
     * device that cracked PutDispEnv's site 1 (pin a COMPETING value's materialization earlier
     * with an opacity fence) has no competing value to pin here: the anchor is already the
     * only fenced pseudo in the block. */
    p[0] = srcxy;                                /* src xy */
    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */
    /* W64-A3 -- FENCE POSITION IS THE CFG DIAL (reorg.c:685-712 stop_search_p).
     * This opacity fence still pins the payload ANCHOR (see the note above), but it
     * must NOT sit at the head of the BODY thread: `stop_search_p` returns 1 at ANY
     * asm insn, so guard2 (`bnez h,BODY`) could never reach the `sll $v0,$s1,16` that
     * retail steals into its delay slot -- with no target-thread candidate reorg
     * inverted guard2 and folded the whole `li -1; j` block away (45 insns vs 46).
     * Fence placed AFTER the dst-xy store instead: statement order (and therefore the
     * whole register handout, which already matches retail) is untouched, the anchor
     * is still laundered, and reorg gets its steal back.  9 -> 4, count EXACT 46/46.
     * Measured alternatives, same basin: fence after p[0] 28 * after p[2] 29 (47 insns)
     * * dropped entirely 28 * read-only fence after the stores 28. */
    __asm__("" : "=r"(p) : "0"(p));
    p[2] = *((u_long *)rect + 1);                /* wh */
    return drv->que_push((QueFunc)drv->dma_chain, p - 2, 0x14, 0);
}

/* @0x800EDC08 : clear an ordering table in reverse, then append the fixed terminator tail. */
extern u_long *ClearOTagR(u_long *ot, int n)
{
    /* W52-A3: psyz's `ClearOTagR` returns the OT pointer -- the oracle keeps `$v0 = $s0`
     * (the `addu $v0,$s0,$zero` in the jalr's shadow doubles as the store base). */
    if (GEnv.debug >= 2)
        GPU_printf("ClearOTagR(%08x,%d)...\n", ot, n);   /* @0x80056E40 */
    GEnv_drv->clear_otag(ot, n);
    /* MATCH (W55-A8, ported from the Rage-Racer matched `ClearOTagR`, pin dropped):
     * the terminator tail is written through a POINTER LOCAL holding `&_otc_link` with the
     * 0xffffff mask in its OWN local.  The oracle materializes `la $a1,_otc_link` ONCE and
     * then REUSES that very register for the masked value (`sw $v1,0($a1); and $a1,$a1,$a2;
     * sw $a1,0($v0)`).  A bare `_otc_link = ...` store compiles to the assembler `$at`
     * macro under this no-split-addresses lane and re-materializes the address a second
     * time for the value. */
    {
        u_long mask = 0x00ffffffu;
        u_long *link = &_otc_link;
        *link = 0x04000000u | ((u_long)(long)&_otc_term & mask);
        ot[0] = (u_long)(long)link & mask;
    }
    return ot;
}

/* @0x800EDCB4 : DrawOTag -- queue an ordering-table for DMA.
 * FLOOR (2 diffs, re-tried w24-a4): oracle materializes a3=0 independently (addu a3,zero,zero)
 * in the jalr delay slot; ours CSEs it from the just-set a2=0 (addu a3,a2,zero). Tried+no
 * effect: named `int n=0` local, both n/extra as separate named locals -- gcc CSEs the two
 * zero args regardless of source form (both are the literal 0 in the same call). Same class as
 * the documented commutative-operand-selection floors; not source-reachable.
 * 🟢 W60-A3 -- FLOOR REFUTED + WIRED (PASS).  It was never a source problem: it is the 04M
 * COMPILER-VERSION axis (cse.c constant-sharing, catalog 11B).  The blocker was a WIRING
 * artifact, not the rung -- every pre-2.8 cc1 exits on `-mno-split-addresses` ("Invalid
 * option"), which is why the W56 receipt concluded "the 2.7.2 rung is unreachable for this
 * TU".  It is unreachable only WHOLE-TU; per-FUNCTION the flag simply has to be dropped for
 * the splice compile (orchestrator's `_cc1_flags_for_rung`, now in both ver-splice paths).
 * Wired `PER_FN_CC1_VER_SPLICE_272[SYS.c]["2.7.2"] = {DrawOTag, _gpu_init_videomode}`;
 * real-gate verified, SYS.c 36/44 -> 38/44.
 * ⚠️ `_set_draw_mode` was in the first draft of that set and is NOT wired -- its REAL=0 came
 * from a probe bug (same-mnemonic mismatch scored as a relocation).  Re-scored through the
 * gate's own code it is 2 diffs on EVERY rung.  See its block; and score per-fn splices only
 * with scratchpad/w60a3/probe_272.py + gatecmp.py, never a hand-rolled word compare. */
extern void DrawOTag(u_long *ot)
{
    if (GEnv.debug >= 2)
        GPU_printf("DrawOTag(%08x)...\n", ot);   /* @0x80056e58 */
    GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, ot, 0, 0);
}

/* @0x800EDD24 : build the env draw environment, queue it, and cache it. */
extern void *PutDrawEnv(void *env)
{
    /* MATCH (W55-A8, ported verbatim in SHAPE from the Rage-Racer matched `PutDrawEnv`):
     * the whole tail is a block of NAMED locals declared in the order
     * mask / sendTag / size / word / gpu -- that decl order IS the register handout
     * ($a0 mask, $a1 tag, $a2 size, $v1 driver table).  Writing the call inline as
     * `GEnv_drv->que_push(GEnv_drv->dma_chain, e+0x1c, 0x40, 0)` puts the mask in $v1 and
     * the driver-table load in $v0.  `debug` is the &GEnv.debug anchor RR also uses --
     * the drawenv cache is reached as `debug + 0xE`. */
    u_char *debug = &GEnv.debug;
    void   *prim  = env;
    u_long *tag;

    if (*debug >= 2)
        GPU_printf("PutDrawEnv(%08x)...\n", prim);   /* @0x80056E6C */
    tag = (u_long *)((u_char *)prim + 0x1c);
    _set_drawenv(tag, prim);
    {
        u_long        mask    = 0x00ffffffu;
        u_long       *sendTag = tag;
        int           size    = 0x40;
        u_long        word    = *tag;
        const GpuTbl *gpu     = GEnv_drv;

        word |= mask;                                /* terminate the DR_ENV */
        *tag  = word;
        gpu->que_push((QueFunc)gpu->dma_chain, sendTag, size, 0);
    }
    _memcpy(debug + 0xE, prim, 0x5c);
    return prim;
}

/* @0x800EDDE4 : program the GPU display environment (display area, mode, H/V ranges). */
extern void *PutDispEnv(void *env)
{
    /* W55-A8/W56 (319 -> 54 diffs, count now EXACT 318/318, frame EXACT 0x20 with s0/s1/s2).
     * Six shape corrections, each gate-measured, mined from the Rage-Racer matched
     * `PutDispEnv` (src/main/PAL/lib/libgpu/display_environment.c) and re-anchored on THIS
     * oracle.  RR's BLOCK ORDER does NOT transfer (RR sends GP1(06/07) before GP1(08);
     * NFS4's oracle is mode-first) -- what transfers is every INNER idiom:
     *   (1) the $s2 anchor is `&GEnv.debug`, and it must NOT be fenced.  An identity fence
     *       adds +2 refs and PROMOTES the anchor over `env`, swapping $s1/$s2 and cascading
     *       through ~180 instructions (with fence 203, without 115).
     *   (2) the dispenv cache halfwords are UNSIGNED storage compared as SIGNED, and the
     *       load must be VOLATILE: `(short)cache[k]` on a plain `u_short *` gets fused back
     *       into one `lh` (the volatile-HImode law, catalog W50-A7), while the oracle has
     *       `lhu; sll 16; sra 16` against the env's `lh` -- 2 insns x 8 compares.
     *   (3) block 2 carries a FIFTH gate term `eb[0x12] != 8` (see its own comment) -- a
     *       real behaviour bug in the old recon, not just a diff.
     *   (4) `mode` is built with `|= 8` off the `lui $s0,0x800` seed materialized in the
     *       debug test's delay slot, not re-assigned `= 0x8000008`.
     *   (5) the PAL clamp arm is the FALL-THROUGH (`if (eb[0x12] != 0)`), and its test must
     *       RE-READ eb[0x12] through a volatile view -- gcc otherwise reuses the copy it
     *       already has from the overscan index (273 -> 203 -> 115 -> 60).
     *   (6) each `send_gp1` call site is a NAMED-LOCAL block `{ gpu; hi; lo; }` exactly like
     *       the sealed `PutDrawEnv` (115 -> 76): the driver table loads into $a1 up front and
     *       the constant groups with the LOW term.
     * W56: comma-staging each call's `hi` and `lo` assignments inside the argument expression
     * changes their pseudo birth/copy-web shape without emitting instructions, transferring the
     * allocator recipe proven by frontend/common's `GetShapeInfo`: 60 -> 54, still 318/318.
     * RESIDUAL 54, two count-neutral classes: (a) at the three `send_gp1` sites the
     * shifted term takes $v0 and the command constant $v1, the oracle has them swapped
     * (falsified: a named `k` constant local 72, split lo/hi decls 124, six or-groupings);
     * (b) ~6 in the overscan span -- the oracle loads .base BEFORE .end so `subu` runs
     * end-minus-base in the just-loaded register (falsified: named ovbase/ovend locals 147,
     * h_start-first 147).  Both are local_alloc handout order.
     * 🟢 W60-A3 -- MEASURED HONESTLY instead of estimated (scratchpad/w60a3/classify.py, which
     * buckets the GATE's OWN normalized streams position-by-position).  318 insns, exactly 30
     * mismatched POSITIONS, and they are almost one thing:
     *     22  pure $v0 <-> $v1 role swap
     *      3  that same swap PLUS a commutative-operand flip (the `or $a0,$v1,$a0` sites)
     *      4  ONE instruction rotated by three slots in the overscan span
     *          (retail `addu $v1,$a0,$v0` BEFORE the `lbu 0x12($s1)` + `beqz`; ours after)
     *      1  `andi $v0,$v1,4095` vs `andi $v1,$v1,4095` (dest register only)
     * So 25 of 30 are ONE coupled register-role decision repeated at the three `send_gp1`
     * sites -- the SAME family as `_set_draw_mode` (see its block: 2 diffs, and now proven
     * COMPILER-VERSION-INVARIANT), not three independent floors.  Corollary: this fn's
     * realistic ceiling if that class ever cracks is ~54 -> under 10, so it is worth
     * re-testing the moment anything moves `_set_draw_mode`.  New falsifications on top of
     * the existing list, both gate-measured and reverted: flipping ONLY the final or to
     * `hi | lo` at all three sites = 60 (order right, registers still wrong -- the same
     * coupling `_set_draw_mode` shows); ALSO swapping the comma-staging so `lo` is assigned
     * first = 124 (it changes which field lands in $a0).
     * W61-A4 -- THE 22-POSITION $v0/$v1 SWAP IS PRICED, AND IT IS A **LOCAL-ALLOC** QTY
     * ORDERING, NOT the global set_preference story that governs `_set_draw_mode` (read the
     * mechanism there first; both are needed).  Instrumented cc1 (GCC_TRACE_ALLOC=1 on
     * C:/Temp/gccbuild-ecoff/cc1.exe, the 2.8.1 lane's flags) prints this block for the first
     * `send_gp1` site -- every temp there is block-local, so global.c never sees them:
     *     [qty_order] 1/96:6/14=8571   0/97:6/18=6666   2/104:2/4=5000  3/95:2/4=5000 ...
     *     qty1 (the x-chain -> $a0, suggested by the call arg) -> reg 4
     *     qty0 (the y-chain = `hi`, refs 6 life 18)            -> reg 2   <-- ours
     *     qty2 (the 0x5000000 command constant `K`, refs 2 life 4) -> reg 3
     * Retail has K in $v0 and `hi` in $v1 (and then the driver-table fn-ptr reuses $v0, which
     * is where the rest of the 22 positions come from), i.e. retail allocated K BEFORE hi.
     * QTY_CMP_PRI = floor_log2(refs)*refs*size/life*10000 (local-alloc.c:1727), so the flip
     * needs pri(K) > 6666: refs 2 -> 4 at life 4..6 gives 13333.  That is exactly the 12C
     * REF-STEP dial, and it is REACHABLE ONLY IF K IS A NAMED LOCAL -- which is where it dies:
     * naming K alone costs +4 (58) before any fence is applied, and the fenced forms recover
     * only 2 of that.  MEASURED (site 1 only, all count-neutral 318/318, all reverted):
     *   named `k` local, no fence 58 | + 1-operand read-only fence 56 | + 2-operand 56 |
     *   + 3-operand 56 | 2-operand fence with the final or spelled `hi | lo` 58.
     * So the dial exists and is priced, but the +4 naming penalty swamps it at this site.
     * NAMED NEXT ANGLE (untried, and the one the mechanism actually points at): give the
     * command constant its extra refs WITHOUT naming it -- e.g. share ONE named constant
     * across all three sites, so the naming cost is paid once while the ref count rises to
     * 6 -- or find the source shape that makes `hi` conflict with $a0 (the call-argument
     * register IS live across hi's range here, unlike $v0 in `_set_draw_mode`, so retail's
     * "op0 preferred the dest and was denied" is genuinely source-reachable in this fn).
     *
     * W52-A3: the four range clamps and the two "compute-then-override" pairs are the
     * PsyQ CLAMP macro and plain ternaries -- the same idiom the matched PSY-Q 4.0
     * `PutDispEnv` (psyz) uses (`h_start = CLAMP(h_start, 500, 3290)` etc.).  The old
     * body carried Ghidra's comma-expression expansion of them
     * (`if (499 < u7 && (u8 = 0xcb2, u7 < 0xcb3)) u8 = u7;`), which is the same VALUE
     * but a hand-expanded control-flow shape.  Variable names follow psyz
     * (h_start/h_end/v_start/v_end) so the two implementations can be diffed directly;
     * the OVERSCAN TABLE lookups are 4.3-specific and stay.
     * MATCH: single base pointer for `env` (methodology 3.12 lever). */
    u_char *eb = (u_char *)env;
#define ES(i) (*(short *)(eb + (i) * 2))
#define EU(i) (*(u_short *)(eb + (i) * 2))
#define EI(i) (*(int *)(eb + (i) * 4))
    u_char  *dbg;
    volatile u_short *cache;
    int mode;
    int h_start = 0, h_end = 0, v_start, v_end;
    int i9;

    /* MATCH (W55-A8, shape from the Rage-Racer matched `PutDispEnv`, re-anchored on THIS
     * oracle): the $s2 anchor is `&GEnv.debug` (0x8012369E), NOT `&GEnv` -- the debug level
     * is `lbu 0($s2)` and the dispenv cache is reached at `+0x6A` / `+0x7A` off it.  The
     * anchor DIES after the first cache compare (the oracle re-uses $s2 as v_end later), so
     * `_pad3`, the second cache block and the final memcpy target are BARE `GEnv.` accesses
     * that materialize their own absolute address.  The cache halfwords are UNSIGNED storage
     * compared as SIGNED (`(short)cache[k]` -> `lhu; sll 16; sra 16` against the env's `lh`);
     * a plain `*(short *)` emits one `lh` and loses two insns per compare, x8 compares. */
    dbg = &GEnv.debug;
    mode = 0x8000000;                            /* oracle: `lui $s0,0x800` in the bnez slot */
    if (*dbg >= 2)
        GPU_printf("PutDispEnv(%08x)...\n", env);   /* @0x80056EA0 */
    /* MATCH (W62-A3, 54 -> 42, count-exact 318/318): the site-1 $v0/$v1 role swap is
     * NOT a priority dial on `hi` or on the command constant -- it is decided by WHERE the
     * driver-table load sits in the block.  Instrumented cc1 (GCC_TRACE_ALLOC=1) shows the
     * table address pseudo born at luid 16, BETWEEN the constant (14) and the `or` (18), so
     * the constant's qty has life 4 (pri 5000) and loses to the y-chain (6 refs / life 18,
     * pri 6666), which then takes the first free reg $v0.  An OPACITY FENCE on `gpu` pins
     * the table load ahead of the whole argument computation; the constant's qty becomes
     * adjacent to its `or`, outranks the y-chain, and takes $v0 -- so the y-chain falls to
     * $v1 and the fn-ptr reload inherits $v0, exactly as retail.  Paired with retail's
     * `hi | lo` operand order (op0 = hi, denied the dest, so the dest ties to op1 = lo:
     * `or $a0,$v1,$a0`).  Both halves are required: fence alone 44, order alone 56.
     * Read-only `("" : : "r"(gpu))` and `__volatile__` flavours measure identically (42).
     * Residual at this site = a 4-instruction EMISSION-ORDER rotation only (ours emits the
     * two table-load words before `lui $v0,0x500`/the two `lhu`s; retail after) -- every
     * REGISTER at the site now matches.  Falsified on the way (all gate-measured, reverted):
     * named `k` constant + 1/2-operand fences 60/58/58; identity-launder on `hi` 56 and on
     * `lo` 60; read-only fence on `hi` after the call 208 (+2 insns, it makes the qty
     * call-crossing); psyz's single-expression `(hi|x)|K` 60; `hi|(x|K)` 57 (-1 insn);
     * fn-ptr hoisted to its own local 56; `K` as op0 of `lo` 56; plain statements 56.
     * The SAME fence at site 2 is catastrophic (148) and at site 3 costs +2 (56) -- those
     * two blocks have their operands already in callee-saved registers, so the table load
     * is not what is crowding them.  See their own notes below.
     * ORCHESTRATOR WIRING (W62-A3, probe-verified TWICE with scratchpad/w60a3/probe_moves.py,
     * which scores through verify_asm's own logic): 42 -> 38, count-exact 318/318.  The fence
     * pins the table load AHEAD of the argument words; retail emits it AFTER them, so the last
     * site-1 residual is a pure 2-line relocation.  ADD THIS ROW TO THE EXISTING SYS.c ENTRY of
     * PER_FN_TEXT_MOVES (12F: a duplicate dict key is silently shadowed -- the file already has
     * _BlitClear and _clearOTagR_dma there):
     *     "PutDispEnv": [
     *         {"take":  r"\tlw\t\$5,GEnv_drv\n",
     *          "after": r"\tlhu\t\$4,0\(\$17\)\n"},
     *     ],
     * Craft checks: `lw $5,GEnv_drv` occurs 3x in the region and a move entry consumes the
     * FIRST match, which is site 1's; the `after` anchor `lhu $4,0($17)` is UNIQUE in the
     * region; both anchors are label-agnostic and carry no trailing hex comment. */
    { const GpuTbl *gpu = GEnv_drv;
        u_long lo;
        u_long hi;
        __asm__("" : "=r"(gpu) : "0"(gpu));      /* opacity: pin the table load first */
        gpu->send_gp1((hi = (u_long)(EU(1) & 0x3ff) << 10,
                       lo = (EU(0) & 0x3ff) | 0x5000000u,
                       hi | lo)); }
    /* the gate is a CACHE COMPARE against GEnv.dispenv (disp.x/y/w/h + the
     * isinter/isrgb24/pad word at +0x10), not a check against literal zero. */
    cache = (u_short *)(dbg + 0x6A);
    if (*(u_long *)(dbg + 0x7A) != *(u_long *)(eb + 0x10) ||
        (short)cache[0] != ES(0) ||
        (short)cache[1] != ES(1) ||
        (short)cache[2] != ES(2) ||
        (short)cache[3] != ES(3)) {
        eb[0x12] = (u_char)GetVideoMode();
        if (eb[0x12] == 1) mode |= 8;             /* MODE_PAL */
        if (eb[0x11] != 0) mode |= 0x10;          /* isrgb24 */
        if (eb[0x10] != 0) mode |= 0x20;          /* isinter */
        if (GEnv._pad3 != 0) mode |= 0x80;        /* reverse (absolute, off-anchor) */
        if (ES(2) <= 280)      ;
        else if (ES(2) <= 352) mode |= 1;
        else if (ES(2) <= 400) mode |= 0x40;
        else if (ES(2) <= 560) mode |= 2;
        else                   mode |= 3;
        if (ES(3) <= (eb[0x12] == 0 ? 256 : 288)) ;
        else                                      mode |= 0x24;
        GEnv_drv->send_gp1(mode);
        eb[0x12] = 8;
    }
    /* same class -- gate on GEnv.dispenv.screen (+8/+10/+12/+14) vs env's screen fields.
     * W55-A8: the oracle carries a FIFTH term the old recon dropped -- after all four
     * halfwords match it also tests `eb[0x12] != 8` (`addiu $v0,8; lbu $v1,0x12($s1);
     * bne $v1,$v0,memcpy`), i.e. the block RE-RUNS whenever the mode block above just
     * stamped the 8 sentinel.  That was a real behaviour bug, not only a diff.
     * The four cache halfwords are UNSIGNED storage compared as SIGNED
     * (`lhu; sll 16; sra 16` vs the env's `lh`), off a FRESH absolute `la GEnv.dispenv+8`
     * (the $s2 debug anchor is already dead here -- the oracle re-uses $s2 as v_end). */
    {
        volatile u_short *c2 = (volatile u_short *)(GEnv.dispenv + 8);
        if ((short)c2[0] == ES(4) &&
            (short)c2[1] == ES(5) &&
            (short)c2[2] == ES(6) &&
            (short)c2[3] == ES(7) &&
            eb[0x12] != 8)
            goto done;
    }
    {
        eb[0x12] = (u_char)GetVideoMode();
        v_start = ES(5) + (eb[0x12] ? 0x13 : 0x10);
        v_end   = v_start + (ES(7) ? ES(7) : 0xf0);
        i9 = 0;
        {   short w = ES(2);
            if (0x118 < w && (i9 = 1, 0x160 < w) && (i9 = 2, 400 < w) && (i9 = 4, w < 0x231))
                i9 = 3;
        }
        {
            /* 🟢 W71-A11 -- THE OVERSCAN ROTATION CRACKED (18 -> 8), and it is a LEVER
             * PAIR: neither half works alone (04Z/05H).  Retail loads `.base` FIRST into
             * $v1 (`lhu $v1,%lo(D_80123770)($v1)`) and `.end` SECOND into $v0 via the $at
             * macro, so `subu $v0,$v0,$v1` runs end-minus-base in the just-loaded register
             * and `addu $a0,$v1,$a3` builds h_start off the surviving base.  A named
             * `base` local read before the subtraction reproduces exactly that order --
             * but ALONE it costs an instruction (21 diffs at 319/318, which is why W62-A3
             * filed it "109 (+1 insn)" and stopped).  The extra insn is reorg: with the
             * loads reordered, reorg EAGER-STEALS the `h_end = h_start + span` add into
             * the delay slot of the FOLLOWING `beqz $v0` (retail keeps it at the join
             * label `.L800EE118` and nop-fills that branch).  A zero-instruction VOID-TAIL
             * fence after the add stops reorg's backward scan at that point (w48-a1's
             * `__asm__("" : : "i"(0))` -- the flavour usable where no live value exists),
             * and the pair lands count-exact:
             *     base local alone            21  (319 insns, +1)
             *     void-tail fence alone       18  (inert)
             *     base local + void-tail      8   (318/318)
             * Re-falsified in THIS basin (04Z -- the W62-A3 list was measured at 42):
             * h_start statement first 21 (+1), `-(base - end)` 18 (inert), in-place
             * mutation of the base carrier 21 (-1 insn), a do/while(0) ref dial on the
             * base read 154, a ref dial on the whole span statement 41, one on the
             * h_start statement 42. */
            int idx = eb[0x12] * 5 + i9;
            int base = (int)_disp_overscan[idx].base;
            int span = (int)_disp_overscan[idx].end - base;
            h_start = base + (int)ES(4) * (int)_disp_mult[i9];
            if (ES(6) != 0) span = span * ES(6) >> 8;
            h_end = h_start + span;
            __asm__("" : : "i"(0));      /* void-tail: deny reorg the h_end add */
        }
        /* MATCH (W55-A8): the PAL arm is the FALL-THROUGH -- the oracle's `beqz $v0` on
         * eb[0x12] jumps AWAY to the NTSC (500/3250) clamps with the PAL bound `slti
         * $v0,$a0,540` already in its delay slot.  The old `if (eb[0x12] == 0)` polarity
         * put NTSC inline and PAL out of line. */
        if (*(volatile u_char *)&eb[0x12] != 0) {
            h_start = CLAMP(h_start, 0x21c, 0xc94);
            h_end   = CLAMP(h_end, h_start + _disp_mult[i9] * 4, 0xcbc);
            v_start = CLAMP(v_start, 0x13, 0x12f);
            v_end   = CLAMP(v_end, v_start + 2, 0x131);
        } else {
            h_start = CLAMP(h_start, 500, 0xcb2);
            h_end   = CLAMP(h_end, h_start + _disp_mult[i9] * 4, 0xcda);
            v_start = CLAMP(v_start, 0x10, 0x101);
            v_end   = CLAMP(v_end, v_start + 2, 0x102);
        }
        /* W62-A3 -- SITES 2 AND 3 ARE **NOT** THE SITE-1 CLASS, measured not assumed.  Both
         * live in ONE basic block (no branch between them, and it runs on to the memcpy), so
         * the site-1 opacity fence hoists the driver-table load to the top of a block that
         * spans the OTHER call: site 2 + fence = 148, site 2 fence-only = 136, site 3 + fence
         * = 56 (all vs 42).  Their residual is the same $v0/$v1 role swap plus the `or` operand
         * order (15 pure swaps + 2 swap-with-flip over both sites), but the crowding value is
         * not the table pointer: at both sites the operands arrive in callee-saved registers
         * from the clamps, and the constant's qty already sits 3 insns from its `or` in RETAIL
         * TOO -- the priorities are identical on both sides, so no local dial separates them.
         * Falsified this wave (gate-measured, reverted): `hi | lo` order alone at site 2 = 44,
         * at site 3 = 44, at both = 46; in-place mutation of the clamp variables themselves
         * (`h_end = (h_end & 0xfff) << 12` etc, which is retail's `andi $v1,$v1,0xFFF`
         * shape) = 136 at site 2 / 46 at site 3; a named `k` constant plus a read-only fence
         * at site 2 = 134; a read-only fence on `lo` after the site-2 call = 136 and +2 insns.
         * Every site-2 edit lands in the same 134-136 basin, i.e. it re-colors the whole clamp
         * band -- treat sites 2/3 as ONE joint problem, and price any candidate against 38.
         * The overscan span keeps its own 4-position rotation (retail loads .base into $v1
         * BEFORE .end into $v0 and runs `subu $v0,$v0,$v1`, so the span lands in $v0 and the
         * h_end add is emitted before the `lbu $v0,0x12($s1)` instead of in its branch slot).
         * Re-falsified in THIS basin per 04Z: h_start statement first 109 (+1 insn), a named
         * `base` local 109 (+1 insn), `span` reused as the base carrier 141, `-(base - end)`
         * 42 (inert), an identity launder on `span` 42 (inert).
         * W67-A2 (2026-08-15) BYTE-TRUTH + the 05J RR display_environment.c mine:
         *  - PutDispEnv in the PsyQ 4.3 vendor member (C:/Temp/nfs4-clean/psyq43/extracted/
         *    LIBGPU/obj/SYS.obj, .text+0xBAC, XDEF 318w) is BYTE-IDENTICAL to our oracle
         *    318/318 incl. every reloc word (scratchpad/w67a2/objtruth.py) -- likewise
         *    _dws (+0x1C20 143/143), _drs (+0x1E5C 160/160), _gpu_que_drain (+0x24A0
         *    152/152), _set_draw_mode (+0x170C 8/8, ZERO relocs).  Source structure is
         *    certified; every residual on these five is coloring/scheduling identity.
         *  - Rage Racer's byte-exact PutDispEnv (rage-racer-decomp src/main/PAL/lib/libgpu/
         *    display_environment.c, gcc-2.6.3-era revision) spells sites 2/3 as block-scoped
         *    decl-inits `long hi = ...; long lo = ...; u_long k = 0x6000000; submit(hi|(lo|k))`.
         *    Gated on OUR 4.3 revision: named-k triple = 42, literal-k `hi|(lo|0x6000000u)`
         *    = 176 -- BOTH FALSIFIED (the RR shape does not survive the revision/toolchain
         *    gap; the shipped comma-expr form stays the best basin at 38). */
        /* 🟢 W71-A11 -- SITES 2 AND 3 CRACKED (38 -> 18, then the overscan block below
         * 18 -> 8; count-exact 318/318 throughout).  The W62-A3 verdict above ("the
         * priorities are identical on both sides, so no local dial separates them") was
         * measured only against the COMMA-STAGED form, and it was the comma staging that
         * hid the dial.  What the local-alloc dumps actually say (scratchpad/A11 -dl on
         * the wired 2.8.1/-mno-split lane, function block 82):
         *     reg 321 (K = 0x7000000)      used 2 times across 6 insns
         *     reg 319 (v_end & 0x3ff)      used 2 times across 2 insns   <- dies at the sll
         *     reg 317 (hi = 319 << 10)     used 2 times across 7 insns
         * 319 dies into 317, so local-alloc's combine_regs TIES them into ONE qty of
         * refs 4 / life 8 => QTY_CMP_PRI = flr2(4)*4/8 = 1.00, against K's flr2(2)*2/6 =
         * 0.33.  hi therefore reaches find_free_reg first and takes the numeric-scan
         * first-free $v0; retail has K in $v0, hi in $v1 and the fn-ptr reload inheriting
         * $v0.  The dial is K's REF COUNT, and the 12C/w44 zero-instruction inflator
         * reaches it: a `do { lo = ...; } while (0)` DEPTH WRAPPER around the K-bearing
         * statement doubles K's loop-weighted refs 2 -> 4, lifting pri(K) to
         * flr2(4)*4/6 = 1.33 > 1.00.  K takes $v0, hi falls to $v1, the fn-ptr inherits
         * $v0 -- every register at both sites now matches retail.
         * ⚠️ BOTH HALVES ARE REQUIRED and the wrapper only works on the STATEMENT form:
         *   wrapper + `hi | lo`            : 28 (site 3 alone) / 18 (both sites)
         *   wrapper + `lo | hi`            : 30 / --      (order must be op0 = hi, since
         *                                    RTL ior operand order is source order and
         *                                    retail's `or $a0,$v1,$a0` has op0 = hi)
         *   statement form, NO wrapper     : 40 (worse than the 38 comma baseline)
         *   comma form + a wrapper on `lo` : 44/42  (the wrapper must contain the
         *                                    ASSIGNMENT, not sit beside the expression)
         *   depth 2 (nested do-while)      : 28 -- identical to depth 1, so one level is
         *                                    already past the flr2 step; do not nest.
         * FALSIFIED on top of the landing (all gate-measured, all reverted): an opacity
         * fence breaking the 319/317 combine (`ve = v_end & 0x3ff; asm(""="r"(ve):"0"(ve));
         * hi = ve << 10`) 40 -- it does NOT break the tie; hoisting `hi` out of the comma
         * list without the wrapper 40; `gpu` assigned after `hi` 8 (inert), after the
         * wrapper 24 (+2 insns, measured in the 18-basin), inside the wrapper 166, declared last 8 (inert),
         * inlined at the call 14 (+2 insns); an opacity fence on `gpu` 122; wrapping `hi`
         * too 8 (inert); `lo` statement before `hi` 102; the call inside the wrapper 8
         * (inert).
         * RESIDUAL 8 = ONE class, ZERO register diffs: at each of the two sites our
         * `lw $5,GEnv_drv` macro pair (`lui $a1,0; lw $a1,0($a1)`) is emitted TWO slots
         * early -- ours after the `sll` that builds `hi`, retail after the `lui $v0,K`.
         * Source position is inert on it (all seven placements above), i.e. it is a pure
         * sched2 emission-order rotation of a 2-word macro = the PER_FN_TEXT_MOVES class,
         * exactly like the site-1 row this file already carries.  ORCHESTRATOR WIRING
         * ASK (2 more rows on the existing SYS.c/"PutDispEnv" entry; note the file's site-1
         * row consumes the FIRST `lw $5,GEnv_drv` match, so these must target the 2nd/3rd):
         *     {"take": r"\tlw\t\$5,GEnv_drv\n", "after": r"\tlui\t\$2,1536\n"},
         *     {"take": r"\tlw\t\$5,GEnv_drv\n", "after": r"\tlui\t\$2,1792\n"},
         * (anchors label-agnostic; `lui $2,1536` / `lui $2,1792` are each UNIQUE in the
         * region -- they are the 0x6000000 / 0x7000000 command constants.) */
        { const GpuTbl *gpu = GEnv_drv;
        u_long hi;
        u_long lo;
        hi = (u_long)(h_end & 0xfff) << 12;
        /* the do/while(0) is a REF DIAL, not a loop -- see the block comment above.
         * Removing it silently costs 10 diffs. */
        do { lo = (u_long)(h_start & 0xfff) | 0x6000000u; } while (0);
        gpu->send_gp1(hi | lo); }
        { const GpuTbl *gpu = GEnv_drv;
        u_long hi;
        u_long lo;
        hi = (u_long)(v_end & 0x3ff) << 10;
        do { lo = (u_long)(v_start & 0x3ff) | 0x7000000u; } while (0);
        gpu->send_gp1(hi | lo); }
    }
done:
    _memcpy(GEnv.dispenv, eb, 0x14);
    return eb;                                   /* oracle @0x800ee2c0 $v0 = $s1 = env */
#undef ES
#undef EU
#undef EI
}

/* @0x800EE2DC : SetTexWindow(DR_TWIN *p, RECT *tw) */
extern void SetTexWindow(void *p, void *tw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_get_tw(tw);
    ((int *)p)[2] = 0;
}

/* @0x800EE314 : SetDrawArea(DR_AREA *p, RECT *r) */
extern void SetDrawArea(void *p, void *r)
{
    short   *rs = (short *)r;
    u_short *ru = (u_short *)r;
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_set_clip_tl(rs[0], rs[1]);
    ((int *)p)[2] = (int)_set_clip_br((short)(ru[0] + ru[2] - 1), (short)(ru[1] + ru[3] - 1));
}

/* @0x800EE394 : SetDrawStp(DR_STP *p, int pbw) -- GP0 0xE6 mask-bit setting */
extern void SetDrawStp(void *p, int pbw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)(pbw ? 0xe6000001u : 0xe6000000u);
    ((int *)p)[2] = 0;
}

/* @0x800EE3BC : SetDrawMode(DR_MODE *p, int dfe, int dtd, int tpage, RECT *tw) */
extern void SetDrawMode(void *p, int dfe, int dtd, int tpage, void *tw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_set_draw_mode(dfe, dtd, tpage & 0xffff);
    ((int *)p)[2] = (int)_get_tw(tw);
}

/* @0x800EE410 : SetDrawEnv(DR_ENV *dr_env, DRAWENV *env) -- public twin of _set_drawenv. */
extern void SetDrawEnv(void *dr_env, void *env)
{
    /* W52-A3: this is psyz's `SetDrawEnv` -- the PUBLIC twin has NO 64-alignment test
     * at all (the oracle falls straight from the height clamp into the three pushes
     * with a fixed 0x60000000 command word; only the internal `_set_drawenv`
     * == psyz `SetDrawEnv2` carries the aligned/unaligned split).  The old recon had
     * the align test copied in from _set_drawenv -- a structural miss, not codegen.
     * MATCH (2026-08-14, 31 -> PASS, 126/126): retain the RR three-slot reservation shape,
     * but comma-stage the final size offset as `sizo = (sizo = len, sizo << 2)`.  The extra
     * source assignment folds away while changing its copy web enough to give retail's
     * cmdo/poso/sizo = $a2/$a3/$a1 allocation.  Storing h inside the packet block and spelling
     * the two unsigned coordinate biases directly then gives retail's $v0 height result and
     * load schedule.  No volatile, register pin, asm, or post-cc1 rewrite is required. */
#define PUSH_CODE ((u_long *)dr)[len++]
    DRAWENV *e = (DRAWENV *)env;
    u_long *dr;
    int len;
    RECT rect;
    int coord;
    u_short w, h;

    len = 1;
    dr = (u_long *)dr_env;
    PUSH_CODE = _set_clip_tl(e->clip.x, e->clip.y);
    PUSH_CODE = _set_clip_br(e->clip.w + e->clip.x - 1, e->clip.y + e->clip.h - 1);
    PUSH_CODE = _set_draw_offset(e->ofs[0], e->ofs[1]);
    PUSH_CODE = _set_draw_mode(e->dfe, e->dtd, e->tpage);
    PUSH_CODE = _get_tw(&e->tw);
    PUSH_CODE = 0xe6000000u;
    if (e->isbg) {
        rect.x = e->clip.x;
        rect.y = e->clip.y;
        rect.w = e->clip.w;
        rect.h = e->clip.h;
        if (rect.w >= 0) {
            if (GEnv.screenW - 1 < rect.w) w = GEnv.screenW - 1;
            else                           w = rect.w;
        } else {
            w = 0;
        }
        rect.w = w;
        if (rect.h >= 0) {
            if (GEnv.screenH - 1 < rect.h) h = GEnv.screenH - 1;
            else                           h = rect.h;
        } else {
            h = 0;
        }
        /* Same RR `Gpu_BuildDrawEnvCmds` push shape as `_set_drawenv`: reserve the three
         * word slots first, then add the packet base and store. */
        {
            int cmdo, poso, sizo, value;
            cmdo = len * 4; len++;
            poso = len * 4; len++;
            sizo = (sizo = len, sizo << 2); len++;
            rect.h = h;
            cmdo += (int)(long)dr;
            rect.x = (u_short)rect.x - (u_short)e->ofs[0];
            rect.y = (u_short)rect.y - (u_short)e->ofs[1];
            *(u_long *)(long)cmdo = 0x60000000u | (e->b0 << 16) | (e->g0 << 8) | e->r0;
            poso += (int)(long)dr;
            *(u_long *)(long)poso = *(u_long *)&rect.x;
            sizo += (int)(long)dr;
            *(u_long *)(long)sizo = *(u_long *)&rect.w;
        }
    }
    ((char *)dr)[3] = (char)(len - 1);
#undef PUSH_CODE
}

/* @0x800EE608 : populate the DR_ENV primitive `d` from the DRAWENV `e`. */
extern void _set_drawenv(void *dr_env, void *env)
{
    /* W52-A3 REWRITE from the matched PSY-Q 4.0 `SetDrawEnv2` (psyz libgpu/sys.c).
     * The oracle proves every element of that shape:
     *  - a POST-INCREMENTING WORD CURSOR, not constant indices: the three isbg pushes
     *    emit `sll $aN,$t0,2; addiu $t0,$t0,1` triples and then `addu $aN,$aN,$s1;
     *    sw ...,0($aN)` -- i.e. `((u_long*)dr)[len++] = v` with `len` const-folded to
     *    7 (`addiu $t0,$zero,7` in the isbg guard's delay slot) for the six fixed
     *    pushes, and `sb len-1,3(dr)` at the end;
     *  - a real STACK `RECT rect` (frame slots 0x10..0x17) copied field-by-field from
     *    env->clip, clamped IN PLACE, then read back as two words (`lw 0x10(sp)` /
     *    `lw 0x14(sp)`) -- the old `short xy[2]/wh[2]` pair could not produce the
     *    store/reload set.  W56 restored the previously omitted `rect.h = h` after
     *    the second clamp; that one semantic store supplied the missing 15-instruction
     *    height path and moved the function from 43 diffs to PASS (156/156);
     *  - the offset bias is an IN-PLACE `rect.x -= env->ofs[0]` on that stack RECT
     *    (`subu; sh 0x10(sp)`), duplicated pushes in BOTH arms (cross-jump keeps them
     *    separate here because the colour command word differs). */
#define PUSH_CODE ((u_long *)dr)[len++]
    DRAWENV *e = (DRAWENV *)env;
    u_long *dr;
    int len;
    RECT rect;
    int coord;
    u_short w, h;

    len = 1;
    dr = (u_long *)dr_env;
    PUSH_CODE = _set_clip_tl(e->clip.x, e->clip.y);
    PUSH_CODE = _set_clip_br(e->clip.w + e->clip.x - 1, e->clip.y + e->clip.h - 1);
    PUSH_CODE = _set_draw_offset(e->ofs[0], e->ofs[1]);
    PUSH_CODE = _set_draw_mode(e->dfe, e->dtd, e->tpage);
    PUSH_CODE = _get_tw(&e->tw);
    PUSH_CODE = 0xe6000000u;
    if (e->isbg) {                        /* DRAWENV.isbg : append a background clear */
        rect.x = e->clip.x;
        rect.y = e->clip.y;
        rect.w = e->clip.w;
        rect.h = e->clip.h;
        if (rect.w >= 0) {
            if (GEnv.screenW - 1 < rect.w) w = GEnv.screenW - 1;
            else                           w = rect.w;
        } else {
            w = 0;
        }
        rect.w = w;
        if (rect.h >= 0) {
            if (GEnv.screenH - 1 < rect.h) h = GEnv.screenH - 1;
            else                           h = rect.h;
        } else {
            h = 0;
        }
        rect.h = h;
        /* MATCH (W55-A8, from the Rage-Racer matched `Gpu_BuildDrawEnvCmds`): the three
         * pushes of each arm RESERVE their slots FIRST -- `off = len * 4; len++;` x3 (the
         * oracle's `sll $aN,$t0,2; addiu $t0,$t0,1` run before any value is computed) and
         * only then `off += (int)dr; *(u_long *)off = v;`.  The `PUSH_CODE` macro
         * interleaved each triple with its own store.  Also: the oracle's unaligned arm has
         * NO trailing `rect.x += ofs / rect.y += ofs` restore (RR's retail carries one, this
         * one does not) -- those two were 9 dead instructions (165 vs oracle 156). */
        coord = (u_short)rect.x;
        if ((coord & 0x3f) != 0 || ((u_short)rect.w & 0x3f) != 0) {
            /* unaligned: GP0 0x60 mono-rect, coordinates relative to the draw offset */
            int cmdo, poso, sizo, value;
            cmdo = len * 4; len++;
            poso = len * 4; len++;
            sizo = len * 4; len++;
            value = (u_short)e->ofs[0];
            cmdo += (int)(long)dr;
            value = coord - value;
            rect.x = value;
            value = (u_short)rect.y;
            coord = (u_short)e->ofs[1];
            value -= coord;
            rect.y = value;
            *(u_long *)(long)cmdo = 0x60000000u | (e->b0 << 16) | (e->g0 << 8) | e->r0;
            poso += (int)(long)dr;
            *(u_long *)(long)poso = *(u_long *)&rect.x;
            sizo += (int)(long)dr;
            *(u_long *)(long)sizo = *(u_long *)&rect.w;
        } else {
            /* 64-aligned: GP0 0x02 fast framebuffer fill, absolute coordinates */
            int cmdo, poso, sizo;
            cmdo = len * 4; len++;
            poso = len * 4; len++;
            sizo = len * 4; len++;
            cmdo += (int)(long)dr;
            *(u_long *)(long)cmdo = 0x02000000u | (e->b0 << 16) | (e->g0 << 8) | e->r0;
            poso += (int)(long)dr;
            *(u_long *)(long)poso = *(u_long *)&rect.x;
            sizo += (int)(long)dr;
            *(u_long *)(long)sizo = *(u_long *)&rect.w;
        }
    }
    ((char *)dr)[3] = (char)(len - 1);    /* primitive length word-count */
#undef PUSH_CODE
}

/* @0x800EE878 : build a GP0 0xE1 "draw mode" command word (dfe=draw-to-display, dtd=dither).
 * Oracle uses beqz dtd delay-slot=lui v1,E100 (hi base in delay slot), then beqz dfe
 * delay-slot=andi v0,a2,9ff (lo base in delay slot).  Return or v0,v1,v0 = lo|hi. */
extern u_long _set_draw_mode(int dfe, int dtd, int tpage)
{
    /* W56: the explicit PSY-Q hi/lo statement form is count-exact on the current 2.8.1
     * lane (8/8), unlike the single ternary expression, which duplicates the final
     * `jr/or` return pair (10/8).  Allocation and every branch/delay slot now match.
     * The remaining two normalized diffs are only the commutative final `or` operands:
     * ours `or v0,v0,v1`, retail `or v0,v1,v0`.  The matched 2.7.2 lane emits retail
     * order from the ternary form, but that compiler is net-negative for the SYS TU.
     * FALSIFIED (w59-a8) on the commutative-operand axis -- the operand order and the
     * register map are COUPLED here, so no spelling reaches retail's `or $v0,$v1,$v0`
     * (op0 in a NON-dest register): `return hi | lo;` = 10 diffs (hi moves into $v0, lo
     * into $a2 -- right operand order, wrong regs); the same with the decl order swapped
     * to `lo; hi` = 10; `lo = hi | lo; return lo;` folds straight back to `or v0,v0,v1`
     * = 2.  gcc computes op0 INTO the dest, so getting op0 off the dest needs the whole
     * value-to-register map to change.  The 2.7.2 rung is unreachable for this TU: the
     * pre-2.8 cc1s reject `-mno-split-addresses` outright ("Invalid option"), so the SYS
     * ladder is only {2.8.0, 2.8.1, 2.91.66, 2.95.2} and the wired 2.8.1 wins it -- see
     * the whole-TU ladder receipt at MoveImage.
     * W60-A3 -- the "2.7.2 is unreachable" HALF of that receipt is indeed wrong (a per-FN
     * splice now reaches any rung; see DrawOTag), BUT that does NOT help here.
     * 🔴 RETRACTION: an earlier W60-A3 note in this block claimed 2.7.2 gives 8/8 with zero
     * real diffs.  That was a PROBE BUG -- scratchpad/w60a3/probe_272.py classified any
     * same-mnemonic word mismatch as a "relocation", which is exactly what this residual is
     * (`or $2,$2,$3` vs `or $2,$3,$2`), in a function that carries NO relocations at all.
     * Re-scored through the gate's own code (scratchpad/w60a3/gatecmp.py), the per-FN rung
     * table is: 2.7.2 = 2 · 2.8.0 = 2 · 2.8.1 = 2 (wired) · 2.91.66 = 2.  So this fn is NOT
     * wired to any rung, and the finding is STRONGER than the old floor note: the commutative
     * operand order here is COMPILER-VERSION-INVARIANT, so both the spelling axis (w59-a8's
     * six forms + w60-a3's inline-ternary, 16 diffs / 12 insns) and the version axis are now
     * exhausted.  What is left is a post-reload operand-slot choice; the only vehicles that
     * could reach it are an RTL-level instrument (06E) or a mechanism that rewrites the
     * operand in the .s -- and a bare line-rewrite mechanism would be hand-asm smuggling,
     * NOT a TEXT_MOVES-class relocation.  Do not re-grind spellings here.
     *
     * W61-A4 -- THE MECHANISM, READ OUT OF THE GCC SOURCE (this replaces "post-reload
     * operand-slot choice", which was a guess).  The operand order is NOT chosen after
     * reload: it is the RTL order, fixed at expand, and it is COUPLED to the register map
     * through ONE function, global.c:1584 `set_preference`:
     *     if (GET_RTX_FORMAT (GET_CODE (src))[0] == 'e') src = XEXP (src, 0), copy = 0;
     * i.e. for `(set (reg 2 v0) (ior A B))` the FIRST ior operand A -- and only A -- is given
     * a hard-reg PREFERENCE for the dest ($v0).  Then global.c:571 `prune_preferences` builds
     * `regs_someone_prefers[X]` = the preferences of every LOWER-priority allocno that
     * conflicts with X, MINUS X's own preferences; and global.c:982 `find_reg` pass 0 treats
     * those as used.  MIPS defines no REG_ALLOC_ORDER, so the fallback scan is the numeric
     * 0,1,2,... = $v0 first.  Consequences, all confirmed by A/B here:
     *   `lo | hi` -> lo (op0) prefers $v0, takes it, hi falls to $v1  => `or $v0,$v0,$v1` (2)
     *   `hi | lo` -> hi (op0) prefers $v0, takes it, lo (which also prefers $a2 via
     *                `(set lo (and (reg 6 a2) 0x9ff))`, same set_preference rule) takes $a2,
     *                and $v0 is in regs_someone_prefers[lo] so pass 0 skips it => 10 diffs.
     * RETAIL is `hi | lo` (op0 = hi) WITH lo in the dest $v0 -- i.e. retail's hi had NO usable
     * $v0 preference, which per prune_preferences means retail's hi CONFLICTED with hard reg
     * $v0.  In this function $v0 is live only at the epilogue, after hi is dead, so that
     * conflict is not source-reachable here.  (It IS reachable in a function where the dest
     * hard reg is a CALL-ARGUMENT register that is live across the first operand's range --
     * that is the named angle for PutDispEnv, see its block.)
     * NEW FALSIFICATIONS (all gate-measured, all reverted): identity fence on hi 10;
     * read-only fence on tpage to kill lo's $a2 preference 10 (it WORKS -- lo moves $a2 -> $v1
     * -- but hi still wins $v0, so the pair is still swapped); `lo |= hi; return lo;` 2;
     * `lo = hi | lo; return lo;` 2 (expand_binop swaps a commutative op so op0 == target, so
     * both fold back to the baseline); `hi |= lo; return hi;` 10; if/return two-ior forms
     * (both arms `hi | (lo|0x400)` / `hi | lo`) 12/14 at 10 insns (the duplicate tails do not
     * cross-jump); both-ternary `hi | (dfe ? lo|0x400 : lo)` 10 at 10 insns; the same with a
     * result local declared FIRST 10.
     * VERSION AXIS RE-LADDERED IN THE `hi | lo` BASIN TOO (04Z: rung tables are basin-relative,
     * so the W60-A3 table -- measured only in the `lo | hi` basin -- did not close this):
     * 2.7.2 = 10 | 2.8.0 = 10 | 2.8.1 = 10 | 2.91.66 = 10 (2.6.3 / 2.7.2-970404 / 2.95.2
     * as-fail on the spliced region).  Both basins are rung-invariant; the axis is CLOSED
     * twice over.
     * W62-A3 -- THE ONE BOUNDED PROBE THE 13A LAW ASKS FOR, RUN AND NEGATIVE; this fn is now a
     * QUANTIFIED HARDNESS CERTIFICATE.  Note first what the 2 diffs are NOT: the REGISTER MAP
     * ALREADY MATCHES retail exactly (ours `or $v0,$v0,$v1`, retail `or $v0,$v1,$v0` -- same
     * three registers, only the commutative operand ORDER differs).  Getting retail's order
     * needs source op0 = hi, and that spelling costs the map (10) because set_preference hands
     * op0 the dest's hard reg, so hi wins $v0 in find_reg PASS 0 -- before any numeric scan.
     * The 12A law says a priority dial cannot beat a hard-reg preference, and that is exactly
     * what measures: in the `hi | lo` basin, a read-only fence on `tpage` (which does kill
     * lo's $a2 preference) plus a 1 / 2 / 3 / 4-operand read-only fence on `lo` to raise its
     * allocno priority above hi's gives 10 / 10 / 10 / 10; the lo fence alone 10; a fence on
     * `hi` to lower it 10.  Eight dial points, all inert.  Denying hi its $v0 preference needs
     * prune_preferences to see a CONFLICT with hard reg $v0, and in this 8-instruction leaf
     * nothing occupies $v0 while hi is live -- there is no competing value to pin, which is
     * precisely what distinguishes it from PutDispEnv's site 1 (where pinning the driver-table
     * load with an opacity fence supplied the missing occupant and flipped the pair).  BOUNDED
     * VERDICT: 2 diffs = one commutative operand order, compiler-version-invariant (both
     * basins laddered), dial-invariant (8 points), and structurally unreachable in a leaf with
     * no third live value.  Do not re-spend budget without a NEW mechanism.
     * 🏆 W72-A19 (2026-08-22) -- **PASS 8/8**.  The certificate above asked for exactly one
     * thing ("denying hi its $v0 preference needs prune_preferences to see a CONFLICT with
     * hard reg $v0, and in this 8-instruction leaf nothing occupies $v0 while hi is live"),
     * and the NEW MECHANISM it asked for is the catalog's 20B/21A-1 zero-insn hard-register
     * denial, which POSTDATES the W62 verdict: `__asm__("" : "=r"(hi) : "0"(hi) : "$2")`
     * MANUFACTURES that conflict without a third live value and without an instruction.  The
     * seal is a TWO-PART joint cell -- neither half alone reaches it, which is why every
     * per-axis sweep above plateaued (21A-5 grid law):
     *   (1) source op0 = hi (`return hi | lo;`) gives retail's commutative order, and the
     *       $v0-clobber launder on hi (placed right after hi's definition, i.e. INSIDE hi's
     *       live range and OUTSIDE lo's -- a launder before the `return` denies $v0 to lo too
     *       and stalls at 6) sends hi to $v1 => `or $v0,$v1,X` = retail's word shape;
     *   (2) that leaves ONE diff class: `lo` is computed IN PLACE on the dying parameter
     *       (`andi $a2,$a2,2559`) because local-alloc's combine_regs ties a dest to a source
     *       that dies on the same insn; retail computes it into a fresh `$v0`.  Keeping
     *       `tpage` LIVE past the `andi` with a read-only fence removes the tie, and lo then
     *       takes the first free reg in the numeric scan = $v0.
     * Four cells PASS: fence after the `lo =` statement (shipped), after the `dfe` block,
     * immediately before the return, and a `: "$6"` clobber launder on `lo` instead of the
     * tpage fence.  FALSIFIED in the same sweep: clobber-on-hi alone 6 (either placement);
     * clobber + tpage fence BEFORE the `lo =` statement 6; clobber + `0x9ff & tpage`
     * constant-first 6; clobber + a `lo = tpage; lo &= 0x9ff;` split 6; clobber-on-hi
     * carrying "$2","$6" together 10; a `$a2` clobber added to the tpage fence 9 @9 insns;
     * a `$v1` clobber launder on lo 10; every one of these in the `lo | hi` basin ties the
     * old 2.  CATALOG: 20B is not only a copy-minting device -- it is the general supplier
     * of a MISSING HARD-REG CONFLICT, and it retires the whole class of certificates whose
     * blocker was "nothing occupies register R here". */
    u_long hi = 0xe1000000u;
    u_long lo;
    if (dtd != 0)
        hi = 0xe1000200u;
    /* W72-A19 seal, half 1: deny $v0 to `hi` so set_preference cannot hand it the dest
     * register in find_reg pass 0 -- zero insns, see the MATCH block above. */
    __asm__("" : "=r"(hi) : "0"(hi) : "$2");
    lo = (u_long)(tpage & 0x9ff);
    /* W72-A19 seal, half 2: keep `tpage` live past the `andi` so combine_regs cannot tie
     * lo's destination to the dying parameter register -- zero insns. */
    __asm__("" : : "r"(tpage));
    if (dfe != 0)
        lo |= 0x400u;
    return hi | lo;
}

/* @0x800EE898 : GP0 0xE3 drawing-area top-left, x/y clamped to the screen. */
/* W51-A1 RECEIPT (29 diffs 2.8 / 36 diffs 272, ours 39 vs oracle 38).  Two residual classes:
 * (1) ADDRESS CSE -- ours hoists one `la $a3,GEnv+4` and does `lh 0($a3)`/`lhu 0($a3)`; the
 *     oracle emits the two assembler MACROS `lh $r,GEnv+4` / `lhu $r,GEnv+4` (self-temp
 *     lui+load each).  Same insn count, different registers/form.
 * (2) the X clamp funnels through $v0 (`addu v0,a0,zero` + `addu a0,v0,zero`) and pre-sets its
 *     default in the bltz DELAY SLOT, so it spends 2 insns where ours spends a `j` (+1 net).
 *     The Y clamp already matches ours (no funnel).
 * FALSIFIED (both basins, each gate-measured): Rage-Racer `Gpu_BuildDrawAreaTopLeftCmd`
 * funnel shape verbatim (52), same non-volatile (44), RR + mutate-param (54), volatile casts
 * on both loads (33), volatile on the signed load only (33), volatile + x funnel temp (33),
 * plain x funnel temp (29, copy-propagated = identical to base), default-first + funnel (45),
 * both halves funnelled (47).  `volatile` is the WRONG direction here: it defeats
 * TARGET_SPLIT_ADDRESSES and forces a register-base address (+4 insns).  The funnel temp is
 * copy-propagated away.  Next angle: an address FORM that blocks the cse of the two loads'
 * shared symbol (unsized asm-label view per access), not a volatile. */
extern u_long _set_clip_tl(short x, short y)
{
    x = CLAMP(x, 0, GEnv.screenW - 1);
    y = CLAMP(y, 0, GEnv.screenH - 1);
    return 0xe3000000u | ((u_long)(y & 0x3ff) << 10) | (u_long)(x & 0x3ff);
}

/* @0x800EE930 : GP0 0xE4 drawing-area bottom-right, x/y clamped to the screen. */
extern u_long _set_clip_br(short x, short y)
{
    x = CLAMP(x, 0, GEnv.screenW - 1);
    y = CLAMP(y, 0, GEnv.screenH - 1);
    return 0xe4000000u | ((u_long)(y & 0x3ff) << 10) | (u_long)(x & 0x3ff);
}

/* @0x800EE9C8 : build a GP0 0xE5 "drawing offset" command word. */
extern u_long _set_draw_offset(int x, int y)
{
    u_long yi = (u_long)(y & 0x7ff) << 11;
    return 0xe5000000u | yi | (u_long)(x & 0x7ff);
}

/* @0x800EE9E4 : GP0 0xE2 texture window from a RECT (mask x/y at +0/+2, window w/h at +4/+6),
 *   or 0 when tw is null. */
extern u_long _get_tw(void *tw)
{
    /* MATCH (w48-a2, 40 diffs -> PASS; the old "register-pressure spill FLOOR" note here was
     * WRONG on all three counts).  Three cooperating levers:
     *  1. LOCAL ARRAY, not four scalars.  The oracle's four `sw` to 0/4/8/0xC(sp) are DEAD
     *     stores that are never read back -- gcc-2.8 has no SRA, so an `int m[4]` is written
     *     to its stack home on every element assignment while cse forwards the just-stored
     *     value to the reader (store-then-read-back).  Four separate `int` scalars are pure
     *     pseudos and the stores never appear (that was the missing 8 insns, ours 24/32).
     *     Slot order proves the shape: 0=m[0] 4=m[1] 8=m[2] 0xC=m[3].
     *  2. SINGLE-EXIT `ret` FUNNEL with the NULL case as the `if` BODY.  `if (tw == 0) ret=0;
     *     else {...}` gives the oracle's `bnez $a0,body` + fall-through `j end; addu v0,0,0`
     *     + shared `jr ra; addiu sp,0x10` epilogue.  An early `return 0;` inverts the
     *     polarity and puts the zero block out of line.
     *  3. OR-TERM ORDER: the m[1]<<15 term must come BEFORE m[0]<<10.  `|` is commutative so
     *     this is semantically identical, but it decides which shifted value's register the
     *     constant is folded into and therefore which pseudo becomes the accumulator
     *     (oracle: a1 = m0<<10|C then v0 = m1<<15|a1).  Measured sweep of six term orders,
     *     all count-exact 32/32: C,B,A,D,E = PASS; C,A,B,D,E = 10; C,A,B,E,D = 28;
     *     A,C,B,E,D = 28; C,E,A,B,D = 39; A,B,D,E,C = 55 (33 insns). */
    u_char *b;
    short  *s;
    int m[4];
    u_long ret;
    if (tw == 0) {
        ret = 0;
    } else {
        b = (u_char *)tw;
        s = (short *)tw;
        m[0] = b[0] >> 3;
        m[2] = (-s[2] & 0xff) >> 3;
        m[1] = b[2] >> 3;
        m[3] = (-s[3] & 0xff) >> 3;
        ret = 0xe2000000u | ((u_long)m[1] << 15) | ((u_long)m[0] << 10)
                          | ((u_long)m[3] << 5)  | (u_long)m[2];
    }
    return ret;
}

/* @0x800EEA64 : read the GPU status register (GPUSTAT, shares GP1 address). */
extern int _get_status(void)
{
    return (int)*GPU_GP1;
}

/* @0x800EEA7C : clear an ordering table in reverse via the OTC DMA (channel 6), with watchdog. */
extern int _clearOTagR_dma(u_long *ot, int n)
{
    /* W52-A3, from the matched psyz `_otc`:  RETURNS n (oracle stages `addu $v0,$s0,$zero`
     * -- the count -- in BOTH loop-exit delay slots, and -1 on timeout), the watchdog is
     * armed AFTER the CHCR kick (the store sits in the `jal _gpu_arm_timeout` delay slot),
     * and the MADR address is spelled `ot - 1 + n` so the reassociation gives the oracle's
     * `sll $v0,n,2; addiu $v0,$v0,-4; addu` instead of `addiu n,-1; sll 2; addu`.
     *
     * W55-A8 (18 -> 10): the s0<->s1 rotation the briefing named is a RESULT-FUNNEL
     * question, not an allocator coin-flip.  With `int r = n;` + `r = -1; break;` the
     * count-variable takes $s0 and the hoisted 0x01000000 busy mask takes $s1 with its own
     * fresh `lui $s1,256` -- exactly the oracle -- where the bare `while (...) { return -1; }
     * return n;` form put the mask in $s0 as a COPY of the pre-loop test constant
     * (`addu $s0,$v1,$zero`) and the count in $s1.  Sweep (all gate-measured): bare 18 ·
     * named `u_long busy` mask local 21 · exit-in-the-middle `while(1)` 27 · funnel+direct
     * `return -1` 11 · funnel + read-only fence on r 11 · do/while-on-timeout 41.
     * RESIDUAL 10 (ours 58 / oracle 56, +2): the oracle reaches the -1 exit with a DIRECT
     * `li $v0,-1` in the `bnez` delay slot while the funnel routes it through `j` + `li
     * $s0,-1`, and it stages `addu $v0,$s0,$zero` in the pre-loop `beqz` slot.  Getting
     * both at once needs the funnel's ALLOCATION with the direct form's TAIL -- the
     * direct-return variants above lose the allocation.  Permuter / reqdelta candidate.
     * W56 UPDATE: a zero-trip-guarded do/while with two normal `return r` sites preserves
     * the retail $s0=count / $s1=busy-mask allocation and restores the direct timeout tail:
     * 10 -> 2, exact 56/56.  The last residual is only reorg placement of `v0 = r`: retail
     * fills both normal-exit branch slots, while ours leaves the pretest slot for `lui $s1`
     * and copies after the backedge.  Literal/variable returns, comma staging, inverted
     * nesting, and a two-assignment result funnel were neutral or worse and were reverted.
     * 🟢 W60-A3 -- SOLVED, and it was never reorg's to give: BOTH slot insns WRITE $v0 while
     * their branches READ $v0, so 09L says gcc reorg can NEVER place either.  Retail's shape
     * is the assembler's: it COPIED the merge-point `addu $v0,$s0,$zero` into the pre-loop
     * `beqz` slot (idempotent on both paths -- the value is the same $s0) and MOVED it into
     * the loop-back `bnez` slot.  Same COPY class as the W59 AIPhysic_CalcAcceleration row.
     * PROBE-VERIFIED (scratchpad/w60a3/probe_moves.py, exact _apply_text_moves semantics +
     * build.py's `as` line): 56/56 with **ZERO real word diffs**.  EXACT WIRING SPEC,
     * label-agnostic (the $L numbers renumbered in the W60-A3 VA-order reorder, so a literal
     * $L<n> would silently no-op -- w60-a8's law):
     *   "recon/syslib/psx/libgpu/SYS.c": {"_clearOTagR_dma": [
     *       {"take": r"\taddu\t\$2,\$16,\$0\n(?=\$L\d+:\n\tlw\t\$31,24)",
     *        "after": r"\tbeq\t\$2,\$0,\$L\d+\n", "copy": True},
     *       {"take": r"\taddu\t\$2,\$16,\$0\n(?=\$L\d+:\n\tlw\t\$31,24)",
     *        "after": r"\tand\t\$2,\$2,\$17\n\tbne\t\$2,\$0,\$L\d+\n", "slot": True}]}
     * Move 1 needs no slot wrapper (the `beq` already sits in cc1's own noreorder/nomacro
     * block, so the inserted line becomes its slot and the old slot `li $17` follows); move 2
     * needs `slot` so gas stops materializing its nop.  Both moves take the SAME line -- the
     * lookahead is what keeps move 2 off move 1's copy.  The branch that gains a slot keeps
     * targeting the copy's old label; re-executing an idempotent `$v0 = $s0` is harmless and
     * the gate is branch-target-lenient anyway. */
    *DMA_DPCR |= 0x08000000;                      /* enable DMA channel 6 (OTC) */
    *D6_CHCR = 0;
    *D6_MADR = (u_long)(ot - 1 + n);              /* last word of the table */
    *D6_BCR  = (u_long)n;
    *D6_CHCR = 0x11000002;                        /* start: backward, OTC clear */
    _gpu_arm_timeout();
    {
        int r = n;
        if ((*D6_CHCR & 0x01000000) == 0)
            return r;
        do {
            if (_gpu_check_timeout() != 0)
                return -1;
        } while ((*D6_CHCR & 0x01000000) != 0);
        return r;
    }
}

/* @0x800EEB5C : ClearImage backend -- fill rect with `color`.
 * W52-A3 REWRITE from the PSY-Q 4.0 matched `_clr` (psyz decomp libgpu/sys.c), every
 * shape re-confirmed against THIS oracle:
 *  - the clamps write BACK INTO THE RECT (`sh $v0,4($t0)` / `sh $v1,6($t0)`), and the
 *    alignment test RE-READS x/w from the struct (`lhu 0($t0)` / `lhu 4($t0)`) -- the
 *    old local-`cw`/`ch` form could never produce that store-then-read-back;
 *  - the UNALIGNED arm is the FALL-THROUGH (`bnez ...,unaligned` on `x & 0x3f`,
 *    `beqz ...,aligned` on `w & 0x3f`) -- the old source had the arms inverted;
 *  - the GP0-0xE1 `mode` word is computed INDEPENDENTLY IN EACH ARM (two `lw` of
 *    the GP1 pointer, two `srl/sll/or` chains), not hoisted into one local;
 *  - the fn RETURNS 0 (`addu $v0,$zero,$zero` after the tail `jal`), it is not void;
 *  - `ptr` (psyz's name) is a REAL POINTER anchor: the oracle keeps the independently
 *    named interior symbol `D_8013EAD8` in $s0 across the three `_get_gpuinfo` calls and
 *    reaches the restore block by 0/4/8/0xC displacements off it, while ALSO masking it
 *    for the header tag.  Spelling that existing linker symbol directly prevents CSE from
 *    deriving it as `_blit_buf + 40`; it also makes both former opacity fences unnecessary.
 * W56 continuation: `D_8013EAD8` plus removal of those fences takes the authoritative
 * residual 7 -> 2 (exact 140/140).  The remaining pair is a pure sched2 relocation of the
 * existing `v0 = 0` return copy from below the epilogue reloads to immediately after the
 * `_gpu_dma_chain` call; a scratch PER_FN_TEXT_MOVES probe reaches PASS 140/140.
 * W60-A3 -- that probe RE-RUN on the current tree (scratchpad/w60a3/probe_moves.py, which
 * replicates build.py's _apply_text_moves verbatim and then assembles with build.py's own
 * `as` line): 140/140 with **ZERO real word diffs**.  EXACT WIRING SPEC, label-agnostic:
 *   "recon/syslib/psx/libgpu/SYS.c": {"_BlitClear": [
 *       {"take": r"\taddu\t\$2,\$0,\$0\n(?=\t\.set\tnoreorder)",
 *        "after": r"\tjal\t_gpu_dma_chain\n"}]}
 * (cc1 emits `jal; lw $31; lw $18; lw $17; lw $16; addu $2,$0,$0` -- retail has the result
 * copy BEFORE the reload chain.  The `jal`'s slot is already taken by the `la` split, so the
 * relocated line lands at the oracle's index 133 with no slot wrapper needed.)  Keep the
 * existing PER_FN_CC1_VER_SPLICE_272 2.8.0 entry: the 2.7.2 rung is catastrophic here
 * (146 insns, 113 real diffs). */
extern int _BlitClear(RECT *rect, u_long color)
{
    u_long *ptr;
    rect->w = CLAMP(rect->w, 0, GEnv.screenW - 1);
    rect->h = CLAMP(rect->h, 0, GEnv.screenH - 1);
    if (rect->x & 0x3f || rect->w & 0x3f) {
        /* unaligned: GP0 0x60 mono-rect under a full-screen clip, then restore the env */
        u_long *b = _blit_buf;
        u_long mask = 0x00ffffffu;
        u_long clip_br = 0xe4ffffffu;
        u_long last;
        ptr = D_8013EAD8;
        b[0] = ((u_long)ptr & mask) | 0x08000000u;            /* 8-word header -> restore block */
        b[1] = 0xe3000000u;                                   /* clip TL = 0,0 */
        b[2] = clip_br;                                        /* clip BR = max */
        b[3] = 0xe5000000u;                                   /* draw offset = 0,0 */
        b[4] = 0xe6000000u;                                   /* mask */
        b[5] = 0xe1000000u | (*GPU_GP1 & 0x7ff) | ((color >> 31) << 10);
        b[6] = 0x60000000u | (color & mask);
        b[7] = *(u_long *)rect;
        last = *((u_long *)rect + 1);
        ptr[0] = 0x03ffffffu;                                 /* restore block: 3 words, terminates */
        b[8] = last;
        ptr[1] = _get_gpuinfo(3) | 0xe3000000u;
        ptr[2] = _get_gpuinfo(4) | 0xe4000000u;
        ptr[3] = _get_gpuinfo(5) | 0xe5000000u;
    } else {
        /* 64-aligned: GP0 0x02 fast fill, list terminates immediately */
        u_long tag = 0x05ffffffu;
        u_long mask = 0x00ffffffu;
        u_long *b = _blit_buf;
        __asm__("" : "=r"(b) : "0"(b));
        b[0] = tag;
        b[1] = 0xe6000000u;
        b[2] = 0xe1000000u | (*GPU_GP1 & 0x7ff) | ((color >> 31) << 10);
        b[3] = 0x02000000u | (color & mask);
        b[4] = *(u_long *)rect;
        b[5] = *((u_long *)rect + 1);
    }
    _gpu_dma_chain(_blit_buf);
    return 0;
}

/* @0x800EED8C : LoadImage backend -- transfer `data` words into the VRAM rect.
 * W52-A3: rebuilt on the matched PSY-Q 4.0 `_dws` (psyz), every detail re-confirmed
 * against THIS oracle:
 *  - the clamps write BACK INTO THE RECT (`sh $a0,4($s1)` / `sh $a0,6($s1)`) and the
 *    word count RE-READS `rect->w` from the struct (`lh $v1,4($s1)`);
 *  - the clamp ceiling here is `GEnv.screenW` with NO `-1` (the oracle's `slt $v0,$v0,$a1`
 *    has no `addiu -1` -- unlike _BlitClear/_set_clip_*, which do).  The old `-1` was a
 *    behaviour bug as well as a mismatch;
 *  - `(w*h + 1) / 2` is a SIGNED DIVIDE (`srl 31; addu; sra 1`), not `>> 1`; the `>> 4`
 *    for the block count then COMPOSES with it into the oracle's single `sra $s0,$v1,5`;
 *  - the remainder is `to_write % 16` (`sll blocks,4; subu`), not `& 0xf` (no `andi`);
 *  - the remainder loop is a DOWN-COUNTING `while (n--)` (oracle: `addiu $s0,$s0,-1` +
 *    `beq $s0,-1` peel, then `bne $s0,$a0` with the store in the delay slot), not an
 *    up-counting `for`.
 * W56: the apparently redundant `saved` alias is an allocator-shape receipt.  Its copy web
 * raises the rectangle base above the pixel cursor, producing retail $s1/$s2 ownership in
 * both transfer workers (_dws 43->13, _drs 47->15).  Comma-staging the quotient additionally
 * prevents gcc from rematerializing the block count directly into $s4 (_dws 13->11 and
 * _drs 15->13), without adding instructions or changing transfer semantics. */
extern int _dws(RECT *rect, u_long *data)
{
    int to_write;
    int size;
    int var_s0;
    int var_s4;
    int quotient;
    int readyMask;
    RECT *saved;

    /* W60-A3 (11 -> 8, and the instruction count became EXACT 143/143): three idioms ported
     * from the 100%-byte-exact Rage-Racer `Gpu_LoadImage`
     * (C:/Temp/rage-racer-decomp/src/main/PAL/lib/libgpu/image_commands.c) -- the SAME PsyQ
     * function, same-era toolchain.  Its register-asm pins are of course dropped (this project
     * is pin-free); only the C shapes transfer:
     *   (1) `rem = x >> N; <opacity fence>; quotient = rem;` -- RR's `rem = transferValue >> 5;
     *       asm("" : "=r"(rem) : "0"(rem)); quotient = rem;`.  This is what produces retail's
     *       `sra $s0,$v1,5; addu $v1,$s0,$zero` (compute into one register, then COPY) where a
     *       plain comma-staged `quotient = x >> 4` folds to a single in-place `sra $v1,$v1,5`.
     *       Worth +1 instruction -- it is the whole count gap.
     *   (2) ZERO-TRIP-GUARDED do/while for the GPU-ready spin, with the mask held in a NAMED
     *       local inside the guard (RR's `readyMask`), instead of a bare `while (...)`.
     *   (3) the transfer loop PEELED the RR way -- `n--; if (n != -1) { do { ... } while
     *       (n != -1); }` -- not `while (n--)`.
     * FALSIFIED on top of this basin (each gate-measured, all reverted): RR's entry opacity
     * fence on the rect pointer (inert, 8) * RR's `status = *GP1; status &= readyMask;` temp
     * inside the spin (inert, 8) * a named `current` local for the data pointer, declared after
     * `saved` to mirror RR's decl order (inert, 8) * a void-tail parm-spill pin before the
     * first statement (10) * an identity fence on `readyMask` to break cse's constant sharing
     * (52 -- it rotates the whole saved-reg band) * a `sentinel` local re-assigned -1 before
     * each of the two loop tests, per the W60 catalog "re-assign the same variable a fresh
     * literal" row (15, and drops back to 140 insns).
     * RESIDUAL 8 = TWO classes, both shared verbatim with `_drs` below:
     *   (a) 3.25-3b OLD-GCC NO-COPY-PROP: retail rematerializes a constant we copy-propagate
     *       (`lui $s3,1024` vs our `addu $s3,$v1,$zero` for the 0x04000000 mask; `li $a0,-1`
     *       vs our `addu $a0,$v0,$zero` for the loop sentinel).  The version axis is CLOSED
     *       here -- 2.8.0 and 2.8.1 are BYTE-IDENTICAL on this function (regions diffed
     *       directly, not just scores) and 2.7.2 is 59; see the W60-A3 rung table in
     *       scratchpad/w60a3/RECEIPTS.md.
     *   (b) the two parm (save, copy) pairs are emitted in the opposite ORDER to retail
     *       (retail does $s1<-$a0 then $s2<-$a1; ours the reverse) -- an assign_parms/sched2
     *       emission-order question, i.e. the 06E instrument gap, not a spelling.
     * W64-A3 -- THE PARM-ORDER HYPOTHESIS THAT LOOKED CERTAIN IS FALSIFIED.  Reading
     * the prologue as MoveImage's RTL taught me to (each callee-save `sw` is emitted
     * immediately before the parm copy that first uses that register, in PARAMETER
     * order), ours must be emitting the `data` parm copy first because our
     * `addu $s1,$a0,$zero` is the BODY statement `saved = rect;` (the rect parm copy
     * having been propagated away) rather than assign_parms' own copy.  Cure tried:
     * drop the `saved` alias and use `rect` directly -- _dws 38 / _drs 42, i.e. `saved`
     * IS retail's shape and removing it re-colours the whole clamp band.  Keeping ONE
     * late use of `rect` to hold the parm pseudo live is worse still and costs an insn
     * (_dws: rect at the GP0 payload 41/144, at payload word 0 only 51/146, for the
     * clamps only 41/144; _drs: payload 45/161, clamps 45/161).  Declaration position
     * of `saved` is inert (first: _dws 8, _drs 10).  A read-only fence on `rect` at the
     * top costs 4 (12).  The class stands as the 06E local-alloc/assign_parms gap.
     * W72-A19 (2026-08-22) -- RESIDUAL CLASS (b) IS A PURE LINE RELOCATION AND IS SOLVED
     * BY A PER_FN_TEXT_MOVES ROW (probe-verified twice, whole TU re-gated twice, zero
     * PASS->FAIL): _dws 6 -> 2 and _drs 8 -> 4, both count-EXACT.  Class (b) is the two parm
     * (save, copy) PAIRS emitted in the opposite order to retail; the cc1 text is
     *     subu $sp,$sp,N / sw $18,24($sp) / addu $18,$5,$0 / sw $17,20($sp) / addu $17,$4,$0
     * and retail wants the $17 pair FIRST.  Both pairs are already byte-correct, so this is
     * exactly the W60-A5 BSEARCH.c / W61-A4 FntFlush prologue-emission-order class: move the
     * $17 pair to sit directly after the `subu $sp`.  Anchors are label-agnostic and occur
     * EXACTLY ONCE in each function's region (verified by a region-scoped regex count).
     * ORCHESTRATOR WIRING (agents cannot edit tools/*.py) -- ADD to PER_FN_TEXT_MOVES:
     *     "recon/syslib/psx/libgpu/SYS.c": {
     *         "_dws": [
     *             {"take": r"\tsw\t\$17,20\(\$sp\)\n\taddu\t\$17,\$4,\$0\n",
     *              "after": r"\tsubu\t\$sp,\$sp,48\n"},
     *         ],
     *         "_drs": [
     *             {"take": r"\tsw\t\$17,20\(\$sp\)\n\taddu\t\$17,\$4,\$0\n",
     *              "after": r"\tsubu\t\$sp,\$sp,40\n"},
     *         ],
     *     }
     * (the two `subu` immediates differ -- _dws frame 48, _drs frame 40 -- so the rows are
     * NOT copy-paste identical.  SYS.c already owns a PER_FN_FLAG_SPLICE_272 entry; this is
     * a different table.  A probe copy of the rows lives at
     * scratchpad/W72_A19/moves_sys.json and is driven with
     * `W60_TEXT_MOVES_FILE=... python tools/vprobe.py`.)  Measured under the rows: whole TU
     * PASS-set UNCHANGED, _dws 2, _drs 4, PutDispEnv still PASS.
     * RESIDUAL AFTER THE ROWS = class (a) only (the `lui $s3,1024` / `lui $s1,2048` constant
     * rematerialisations), and its FLAG AXIS IS NOW CLOSED TOO: per-fn splices of
     * -fno-cse-follow-jumps, -fno-cse-skip-blocks and -fno-thread-jumps are BIT-FOR-BIT
     * INERT on both fns, -fno-rerun-cse-after-loop is worse (_dws 10), and
     * -fno-expensive-optimizations is catastrophic (43/45, and +1 insn).  Source cells
     * falsified on the moved basin as well: `readyMask` hoisted above the guard with an
     * identity launder 39 @144 / without 39 @142 / with a read-only fence 44 @137; a
     * named+laundered `guardMask` for the guard test 12; an in-place identity launder on
     * `readyMask` 36 (_dws) and 54 (_drs).  It is the 3.25-3b old-gcc no-copy-prop identity,
     * unreachable from source AND from the cse/jump flag set.
     * 🏆 W74-A18 (2026-08-23) -- CLASS (a) IS SOLVED; _dws PASS 143/143, _drs PASS 160/160.
     * The "3.25-3b old-gcc no-copy-prop" NAME WAS WRONG, and that is why eight waves of cse
     * / jump / version / flag dials all measured inert: the copy is NOT made by cse and NOT
     * by any -f option.  It is made by RELOAD_CSE_REGS -- gcc-2.8's "very simple CSE pass
     * over just the hard registers", called UNCONDITIONALLY at -O2 from toplev.c:3501 after
     * reload and before jump2.  Its `reload_cse_simplify_set` (reload1.c ~8173) takes any
     * `(set (hardreg) <non-register>)`, scans i = 0..FIRST_PSEUDO_REGISTER for a hard reg
     * its reg_values table says already holds that value, and rewrites the set as a REGISTER
     * COPY (lowest regno wins -- here $v1 = reg 3, the guard test's mask).
     * PROOF (RTL stage walk, scratchpad/W74_A18/rtl, insn 323 = the readyMask set):
     *     greg  : (set (reg/v:SI 19 s3) (const_int 67108864))  + REG_EQUIV
     *     jump2 : (set (reg/v:SI 19 s3) (reg:SI 3 v1))         + REG_EQUIV
     * i.e. still a constant after global-alloc, a copy before jump2 -- only reload_cse runs
     * in between.  NOT a version axis either: 2.8.1 (this lane), 2.8.0 and the REAL retail
     * PsyQ 4.3 CC1PSX all emit `move $19,$3` from this source (all three measured).
     * THE CURE, zero insns: reload_cse's own main loop invalidates a register's recorded
     * value on any CLOBBER -- for every non-SET element of a PARALLEL it runs
     * `note_stores (x, reload_cse_invalidate_rtx)` (reload1.c ~8007) -- and forgets the whole
     * table at a CODE_LABEL, and forgets all call-used regs at a CALL_INSN.  So an empty asm
     * that clobbers the DONOR register, placed between the donor's set and the constant set,
     * makes the constant rematerialize exactly like retail.  `__asm__("" : : : "$3")` before
     * `readyMask = 0x04000000;` => `lui $s3,1024`, PASS.  (This also explains why the third
     * occurrence, the `*GPU_GP1 = 0x04000000` store value, was ALWAYS fresh: a CODE_LABEL
     * sits between it and the guard.)  Placement law = 22B-1's, but for a DIFFERENT pass:
     * what matters is the FINAL post-reload insn ORDER, not the live ranges -- and the
     * clobber denies nothing here, the guard mask pseudo is already dead at that point.
     * RAW40 / vendor-rung verdict for these two fns: FALSIFIED.  PsyQ 4.0's CC1PSX (wired as
     * a per-fn CC1_VER splice rung) gives _dws 139 insns / 74 diffs and _drs 159 / 57, with a
     * different frame (80 vs 48) and saved-reg set -- retail's _dws/_drs are 2.8-lane code
     * that was merely missing this device.  (The 4.0 rung DOES rematerialize 0x04000000 at
     * all four uses, which is what made the old "old-gcc no-copy-prop" story plausible.) */
    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    _gpu_arm_timeout();
    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_write = (saved->w * saved->h + 1) / 2;
    if (to_write <= 0)
        return -1;
    var_s0 = to_write >> 4;
    __asm__("" : "=r"(var_s0) : "0"(var_s0));
    quotient = var_s0;
    var_s0 = to_write - (quotient << 4);
    size = quotient;
    if ((*GPU_GP1 & 0x04000000) == 0) {          /* wait until ready to receive DMA */
        /* W74-A18: reload_cse_regs donor-invalidation -- see the block comment above.
         * WITHOUT this clobber the mask is copied out of the guard's $v1
         * (`addu $s3,$v1,$zero`); with it, retail's fresh `lui $s3,1024`.  Zero insns. */
        __asm__("" : : : "$3");
        readyMask = 0x04000000;
        do {
            if (_gpu_check_timeout())
                return -1;
        } while ((*GPU_GP1 & readyMask) == 0);
    }
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
    /* 🟢 W71-A11 (8 -> 6, count-exact 143/143) -- HALF OF RESIDUAL CLASS (a) IS NOT THE
     * 3.25-3b no-copy-prop identity after all; it is cse CONSTANT SHARING, and the 09L/W47
     * opacity fence breaks it.  The peel test and the loop-back test both spell the literal
     * `-1`, so cse gives them ONE pseudo: retail materializes `li $a0,-1` fresh for the
     * loop-back compare while we emitted `addu $a0,$v0,$zero` off the peel test's `li
     * $v0,-1`.  Naming the PEEL sentinel and laundering it (zero insns -- the value is
     * register-resident) leaves cse with no equivalence to substitute, so the loop's `-1`
     * is re-materialized exactly like retail.  The fence must sit on the FIRST occurrence;
     * on `readyMask` (the second occurrence of the 0x04000000 mask) it costs 44 (50).
     * The sibling constant `lui $s3,1024` did NOT fall to the same treatment -- measured on
     * top of this landing and all reverted: a named+fenced `guardMask` for the guard test 12
     * (14 measured before the peel landed), the same un-fenced 6 (inert), one shared `readyMask` for
     * guard and loop 39 (-1 insn), an identity fence on `readyMask` 50, a void-tail fence
     * before its assignment 6 (inert), a do/while(0) ref dial on it 36.  That one stays in
     * class (a). */
    {
        int peel = -1;
        __asm__("" : "=r"(peel) : "0"(peel));    /* cse constant-sharing breaker */
        var_s0--;
        if (var_s0 != peel) {
            do {
                *GPU_GP0 = *data;
                data++;
                var_s0--;
            } while (var_s0 != -1);
        }
    }
    if (size) {
        *GPU_GP1 = 0x04000002;
        *D2_MADR = (u_long)data;
        *D2_BCR  = (size << 16) | 0x10;
        *D2_CHCR = 0x01000201;
    }
    return 0;
}

/* @0x800EEFC8 : StoreImage backend -- read the VRAM rect back into `data` words. */
extern int _drs(RECT *rect, u_long *data)
{
    /* W52-A3: same psyz `_drs` shape as _dws above (in-struct clamps, signed /2, `% 16`).
     * W60-A3 (13 -> 10, instruction count now EXACT 160/160): the three Rage-Racer
     * `Gpu_StoreImage` idioms ported wholesale from _dws above -- shift-into-a-fenced-local
     * then COPY into `quotient`, zero-trip-guarded do/while spins with the mask in a named
     * local, and the peeled `n--; if (n != -1) do{...}while(n != -1);` transfer loop.  _drs
     * has TWO spins (0x04000000 ready, 0x08000000 send), matching RR's two, so it gets two
     * named masks.  Source: C:/Temp/rage-racer-decomp/src/main/PAL/lib/libgpu/image_commands.c
     * (100% byte-exact corpus; its register-asm pins dropped -- shapes port, pins do not).
     * RESIDUAL 10 = the identical two classes listed at the end of _dws: three no-copy-prop
     * constant rematerializations (`lui $s3,1024`, `lui $s1,2048`, `li $v1,-1` vs our copies)
     * plus the parm (save, copy) emission order.  Do not re-grind spellings -- the _dws block
     * lists six that were measured and reverted, and the whole version axis is closed.
     * 🏆 W74-A18: PASS 160/160.  Both surviving constant rematerializations were the
     * RELOAD_CSE_REGS class (mechanism, proof and cure in the _dws block above); each spin
     * gets the same zero-insn donor-invalidation clobber on $v1 before its mask assignment.
     * The two spins are independent instances -- the second one's donor is $v1 as well
     * (the 0x08000000 guard test), so both need their own clobber. */
    int to_read;
    int size;
    int var_s0;
    int quotient;
    int readyMask;
    int sendMask;
    RECT *saved;

    saved = rect;
    _gpu_arm_timeout();
    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_read = (saved->w * saved->h + 1) / 2;
    if (to_read <= 0)
        return -1;
    var_s0 = to_read >> 4;
    __asm__("" : "=r"(var_s0) : "0"(var_s0));
    quotient = var_s0;
    var_s0 = to_read - (quotient << 4);
    size = quotient;
    if ((*GPU_GP1 & 0x04000000) == 0) {          /* wait until ready for DMA */
        __asm__("" : : : "$3");                  /* W74-A18 reload_cse donor-invalidation */
        readyMask = 0x04000000;
        do {
            if (_gpu_check_timeout())
                return -1;
        } while ((*GPU_GP1 & readyMask) == 0);
    }
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
    if ((*GPU_GP1 & 0x08000000) == 0) {          /* wait until ready to send pixels */
        __asm__("" : : : "$3");                  /* W74-A18 reload_cse donor-invalidation */
        sendMask = 0x08000000;
        do {
            if (_gpu_check_timeout())
                return -1;
        } while ((*GPU_GP1 & sendMask) == 0);
    }
    /* 🟢 W71-A11 (10 -> 8, count-exact 160/160): the same cse constant-sharing breaker as
     * _dws above -- see its block for the mechanism and the falsification list.  Applying
     * the equivalent fence to the SECOND spin's guard (`sendGuard = 0x08000000`) costs an
     * instruction (9 at 161/160) and was reverted, so `lui $s3,1024` / `lui $s1,2048` both
     * stay in class (a). */
    {
        int peel = -1;
        __asm__("" : "=r"(peel) : "0"(peel));    /* cse constant-sharing breaker */
        var_s0--;
        if (var_s0 != peel) {
            do {
                *data = *GPU_GP0;
                var_s0--;
                data++;
            } while (var_s0 != -1);
        }
    }
    if (size) {
        *GPU_GP1 = 0x04000003;
        *D2_MADR = (u_long)data;
        *D2_BCR  = (size << 16) | 0x10;
        *D2_CHCR = 0x01000200;
    }
    return 0;
}

/* @0x800EF248 : write one GP1 (control) command and shadow its low byte by command number. */
extern void _send_gp1(u_long cmd)
{
    *GPU_GP1 = cmd;
    _gp1_shadow[cmd >> 24] = (u_char)cmd;
}

/* @0x800EF26C : read back the shadowed low byte for GP1 command number `idx`. */
extern int _get_gp1(int idx)
{
    return _gp1_shadow[idx];
}

/* @0x800EF280 : push n words straight to GP0 with DMA disabled (CPU->GP0 transfer). */
extern int _send_gp0(u_long *p, int n)
{
    /* MATCH: counter split from the param and computed up-front (oracle addiu a2,a1,-1
     * FIRST insn); guard keeps n live so i gets a fresh reg; explicit -1 sentinel
     * compare -> li a1,-1 reusing the dead param reg (catalog rows 47/48). */
    int i = n - 1;
    /* MATCH: volatile cast away on the two stores -- the oracle has BOTH in branch
     * delay slots (GP1 store in the beqz slot, GP0 store in the loop bne slot); gcc
     * refuses to slot-fill volatile MEMs, the original assembler filled them blind. */
    *(u_long *)GPU_GP1 = 0x04000000;        /* DMA direction = off */
    if (n != 0) {
        do { *(u_long *)GPU_GP0 = *p++; i--; } while (i != -1);
    }
    return 0;
}

/* @0x800EF2C0 : kick off a GPU ordering-table (linked-list) DMA on channel 2. */
extern void _gpu_dma_chain(u_long *ot)
{
    *GPU_GP1 = 0x04000002;                   /* DMA direction = 2 (linked list) */
    *D2_MADR = (u_long)ot;
    *D2_BCR  = 0;
    /* MATCH: volatile cast away -- oracle has this final sw in the jr delay slot;
     * gcc won't slot-fill a volatile MEM (same lever as _send_gp0). */
    *(u_long *)D2_CHCR = 0x01000401;         /* start, linked-list mode */
}

/* @0x800EF308 : issue a GP1 0x10 "get GPU info" query and return the 24-bit GPUREAD reply. */
extern int _get_gpuinfo(u_long cmd)
{
    *GPU_GP1 = cmd | 0x10000000;
    return (int)(*GPU_GP0 & 0x00ffffffu);
}

/* @0x800EF338 : convenience wrapper -- push with no inline-arg copy (n = 0). */
extern int _que_ref(QueFunc func, u_long *arg, int extra)
{
    return _gpu_que_push(func, arg, 0, extra);
}

/* @0x800EF35C : enqueue a GPU request func(arg,extra).  If the GPU is idle the request is
 *   run inline; otherwise it is queued (optionally snapshotting n bytes of args into the
 *   slot).  Spins on the watchdog while the ring is full.  Returns the resulting depth. */
extern int _gpu_que_push(QueFunc func, u_long *arg, int n, int extra)
{
    GEnvT *g;
    _gpu_arm_timeout();
    while (((_qin + 1) & 0x3f) == _qout) {       /* ring full */
        if (_gpu_check_timeout() != 0)
            return -1;
        _gpu_que_drain();
    }
    /* MATCH (W52-A3): ONE fenced base register for GEnv -- the oracle reaches active
     * (`lbu $v1,1($a0)`), busy (`sw $v0,8($a0)`) and idle_cb (`lw $v0,12($a0)`) by
     * displacement off a single `la $a0,GEnv`; bare field accesses re-emit a `lui`
     * self-temp / `$at` macro each under this lane.  And the dispatch decision is a
     * W56: the matched Rage Racer `Gpu_AddQueue` switch/break region is load-bearing: it
     * retains that branch chain but removes a duplicated GPU-ready precheck.  Together with
     * its volatile byte-copy loop and shared queue view this makes the function PASS. */
    _q_saved_mask = SetIntrMask(0);              /* enter critical section */
    g = &GEnv;
    __asm__("" : "=r"(g) : "0"(g));
    g->busy = 1;
    switch (0) { default:
        if (g->active != 0) {
            if (_qin != _qout || (*D2_CHCR & 0x01000000) != 0 || g->idle_cb != 0)
                break;
        }
        do {
        } while ((*GPU_GP1 & 0x04000000) == 0);
        func(arg, extra);
        SetIntrMask(_q_saved_mask);
        return 0;
    }
    DMACallback(2, (int)_gpu_que_drain);         /* (re)attach drain to channel-2 interrupt */
    if (n != 0) {
        volatile u_long *pbase = (volatile u_long *)((u_char *)_que.shared + 12);
        int i = 0;
        u_long *src = arg;
        while (i < n / 4) {
            *(volatile u_long *)((u_char *)pbase + _qin * 96 + i * 4) = *src;
            src++;
            i++;
        }
        _que.shared[_qin].arg = (u_long *)_que.shared[_qin].buf;
    } else {
        _que.shared[_qin].arg = arg;
    }
    _que.shared[_qin].extra = extra;
    _que.shared[_qin].func  = func;
    _qin = (_qin + 1) & 0x3f;
    SetIntrMask(_q_saved_mask);                  /* leave critical section */
    _gpu_que_drain();
    return (_qin - _qout) & 0x3f;
}

/* @0x800EF60C : dequeue-and-dispatch.  Called inline after a push and from the channel-2
 *   DMA-complete interrupt.  Runs queued requests until the queue empties or a request
 *   kicks off a DMA (CHCR busy), then fires the idle callback if the queue is fully drained. */
extern int _gpu_que_drain(void)
{
    /* Rage Racer's two long-lived mask quantities are source-shape significant.  Keeping the
     * same declaration order and spelling the wait as an entry test plus do/while restores
     * retail's $s1=GPU-ready / $s0=DMA-active allocation (58 -> 31 diffs).  W56: declaring
     * the slot's narrow scalar `extra` before `arg` and `func` gives the closest retail
     * three-index dispatch schedule; the remaining tail is handled below (31 -> 14 total).
     * W62-A3 -- the 14 residual READ OFF precisely (it was described as "interleaving"; here is
     * what it costs and why).  Ours and retail compute the SAME three `_que.plain[_qout]` index
     * chains from the SAME two `_qout` values (the pre-branch one still in $a1, and one fresh
     * reload).  Two differences, and the second is a CONSEQUENCE of the first: (a) retail hoists
     * chain 2's `sll/addu` ABOVE the `.arg` load and defers its `sll ,5` until after the reload,
     * where ours runs each chain to completion in turn; (b) chain 2's temp therefore lands in
     * $v1 for retail and $v0 for ours -- and because ours then wants `lw $v0,_que($v0)` (dest ==
     * index), the ASSEMBLER has to route it through the $at macro (`lui $at; addu $at,$at,$v0;
     * lw $v0,%lo($at)`) while retail's `lw $v0,_que($v1)` uses the dest as its own %hi scratch.
     * So 3 of the 14 are the $at macro, and they are DOWNSTREAM of one register handout -- fix
     * the handout and the $at goes with it.  Falsified this wave (gate-measured, reverted):
     * reading `.arg` before `.extra` 22; an identity launder on `func` 14 (inert); one on
     * `extra` before the `func` read 14; one immediately after the `extra` read 14; declaring
     * `func` first 14.  Still the 06E gap: the decision is a local-alloc handout inside one
     * block, and unlike PutDispEnv's site 1 there is no address materialization to pin (all
     * three chains already start from registers).
     * W64-A3 -- TWO MORE AXES CLOSED, both from a fresh read-off of the two streams.
     * (a) THE RELOAD->CHAIN MAP.  Retail's three `_qout` reloads feed .func / .arg /
     *     .extra in that order; ours feed .extra / .arg / .func.  That looks exactly
     *     like a READ-ORDER permutation (gcc numbers the reloads in read order), so
     *     every permutation was measured: func,arg,extra 24 * func,extra,arg 16 *
     *     extra,func,arg 16 * arg,func,extra 25 (151 insns) * arg,extra,func 22 *
     *     the same six with the declaration list re-ordered func,arg,extra 14/24.
     *     FALSIFIED: read order is not the dial, the map is a consequence of the
     *     local-alloc handout, not of the RTL emission order.
     * (b) THE SLOT-ACCESS SHAPE, element by element (the brief's ask): `func` local +
     *     both args inlined 24 * `extra`/`arg` locals + `func` inlined 14 (inert) *
     *     decl-with-init form 14 (inert) * `(*func)(arg, extra)` call spelling 14
     *     (inert) * a void-tail fence before the `.func` read 34 * one after the
     *     `.extra` read 27 (153 insns).  Hoisting the locals to function scope does
     *     not compile (C89 use-before-declaration in this nesting).
     * CORPUS: psyz's libgpu/sys.c leaves `_exeque` as INCLUDE_ASM (line 868) -- there is
     * NO matched PsyQ-4.0 body for this function anywhere, and sotn's is a different SDK
     * generation (1.83 vs our 1.140), so 15F says shape-oracle only where the CFG matches
     * and it does not.  The 5 corpora added mid-W64 (mgs_reversing, KAIN2, TOMB5,
     * VandalHearts-PcPort, vh) carry NO Sony libgpu source at all -- TOMB5/EMULATOR and
     * VandalHearts platform/pc are PC re-implementations (SDL/OpenGL rasterisers), mgs's
     * libdg is Konami glue over `#include <libgpu.h>`.  Recorded so nobody re-mines.
     * W71-A11 -- THE RESIDUAL 14 READ OFF THE RTL, and a THIRD axis closed.  The .lreg dump
     * (scratchpad/A11) shows the dispatch block as three IDENTICAL `*96` chains, one per
     * volatile `_qout` reload, each with its own anonymous temps:
     *     121 reg109 = _qout   ->  124/126/127 chain -> 168 (reg a1) = _que+8[113]   (extra)
     *     136 reg116 = _qout   ->  139/141/142 chain -> 166 (reg a0) = _que+4[120]   (arg)
     *     151 reg123 = _qout   ->  154/156/157 chain -> 163 reg108   = _que[127]     (func)
     * `reg127` (the func index) DIES exactly where `reg108` (the func value) is born, and
     * both carry refs 4 / life 2 -- an exact QTY_CMP_PRI tie -- so local-alloc hands them
     * the SAME first-free $v0, and the ASSEMBLER must then route `lw $v0,_que($v0)` through
     * the `$at` macro (3 of the 14).  Retail's func index is born at insn 66 and lives to
     * 84, spanning BOTH other chains' use of $v0, so it is forced to $v1 and the dest gets
     * $v0 with no macro.  The lever therefore has to make the func index chain live EARLY;
     * every source form that asks for it was measured and gcc sinks the arithmetic to its
     * use every time (the volatile LOAD moves, the `*96` does not):
     *   `GpuQue *fslot = &_que.plain[_qout];` hoisted first / last / mid   16 / 16 / 16
     *   the same with an identity fence on fslot 26, with a read-only fence 18 (+2 insns)
     *   `int fidx = _qout * 96;` hoisted 16, fenced 16, split as `_qout * 3` + `<< 5` 19
     *   `int fidx = _qout * 3` + `<< 5` 19 (151 insns, -1)
     *   a do/while(0) ref dial on the func read 40, on arg 31 (+1 insn), on extra 34
     *   the arg slot pointer hoisted instead (control) 14 (inert)
     * ADDRESS-SPELLING axis, also closed (the 09I cast-int-subscript family): index-term-
     * first `*(QueFunc *)((_qout * 96) + (int)_que.plain)` 27 (155 insns), the same on all
     * three accesses 47 (159), a block-scoped `GpuQue *p = &_que.plain[_qout]` for the func
     * read only 14 (inert), reading `func` through the VOLATILE `_que.shared[]` view 14
     * (inert), reading `extra`/`arg` through it instead 28 (154).
     * The DECLARATION-ORDER axis is now closed too (w41's "pseudo numbers follow FIRST-USE
     * order" at full strength): all six decl permutations at the retail read order measure
     * 24 EXACTLY, i.e. decl order is bit-for-bit inert here.  Read order re-measured in this
     * basin and unchanged from W64-A3: eaf 14 (shipped) | efa 16 | fea 16 | aef 22 |
     * afe 25 (-1 insn) | fae 24 -- and `fae` IS retail's order (its three reloads feed
     * func/arg/extra in that order, and volatile reads cannot be re-ordered), which is the
     * cleanest proof yet that the residual is the local-alloc handout and NOT the source
     * read order.  06E instrument gap; do not re-grind spellings. */
    u_long dma_busy = 0x01000000;

    if ((*D2_CHCR & dma_busy) != 0)
        return 1;                                /* a DMA is still running */
    _drain_saved_mask = SetIntrMask(0);
    if (_qin != _qout && (*D2_CHCR & dma_busy) == 0) {
        u_long gpu_ready = 0x04000000;
        u_long dma_active = 0x01000000;
        for (;;) {
            if (((_qout + 1) & 0x3f) == _qin && GEnv.idle_cb == 0)
                DMACallback(2, 0);               /* last entry, no idle cb: detach drain */
            if ((*GPU_GP1 & gpu_ready) == 0) {
                u_long wait_ready = 0x04000000;
                do {
                } while ((*GPU_GP1 & wait_ready) == 0);
            }
            {
                int     extra;
                u_long *arg;
                QueFunc func;
                int     fidx;
                /* 🟢 W72-A19 (14 -> 10, count still EXACT 152/152): THE QTY TIE IS BROKEN.
                 * The W71-A11 read-off named the residual exactly -- the func INDEX pseudo
                 * dies on the very insn the func VALUE is born, both refs 4 / live 2, an
                 * exact QTY_CMP_PRI tie, so local-alloc hands them the SAME first-free $v0
                 * and the assembler must route `lw $v0,_que($v0)` through the $at macro.
                 * The cure is NOT a priority dial (the two tie, so no ref-step or
                 * live-length change can separate them -- that is why every hoist/fence/
                 * spelling in the W64/W71 lists measured 14-27); it is a CONFLICT: the
                 * catalog's 20B/21A-1 zero-insn hard-register denial `: "$2"` takes $v0
                 * away from the index pseudo, so the index lands in $v1 and the value in
                 * $v0 -- retail's handout exactly, `lw $v0,_que($v1)`, no $at macro.
                 * The launder must carry the clobber (identity alone 16, read-only-with-
                 * clobber 13 @153, "$3" instead of "$2" 16) and the index must be NAMED
                 * (the byte-spelling `(char *)_que.plain + fidx` is the only form that
                 * exposes the scaled index as a C value; on its own it measures 27).
                 * FALSIFIED on top of this landing (all gated, all reverted): fidx block
                 * at every position x all six read orders -- eaf@0/@1, efa@0/@1, fea@0
                 * all tie at 10 count-exact, eaf@2 11 @151, aef/afe/fae 18-19; the split
                 * multiply `_qout * 3` + `<< 5` in this new basin (19 @151 with the
                 * clobber anywhere, 13 @151 without); an 'm'-operand fence on the slot
                 * (43 @151) or through a `GpuQue *fslot` (41 @153); a $v0 clobber on a
                 * `fslot` POINTER launder (25 @153); a read-only fence with a $v0 clobber
                 * on `arg` before the func read (34); a read-only fence on `extra` after
                 * it (46).
                 * RESIDUAL 10 = a pure sched1 EMISSION-POSITION question, and the whole
                 * insn stream is otherwise identical: retail computes the func index chain
                 * EARLY (`sll $v1,$a1,1; addu $v1,$v1,$a1` right after the arg chain, then
                 * `sll $v1,$v1,5` after the arg field load) so $a1 dies at insn 67 and the
                 * THIRD volatile `_qout` reload REUSES $a1 at 71; ours runs the index chain
                 * to completion last, so its `_qout` reload must stay live across both
                 * other chains and takes $a2 instead.  Same 06E sched1/local-alloc gap --
                 * but now it is a 3-insn placement, not a register handout.
                 * W74-A18 (2026-08-23) -- THE SCHEDULER MECHANISM READ OFF gcc-2.8.1's
                 * sched.c, and the residual is now MECHANISM-NAMED rather than "06E gap".
                 * sched1 is a BACKWARD list scheduler: `last = next_tail` and each pick is
                 * inserted before the previously placed insn, so the FIRST insn chosen ends
                 * up LAST in the text.  The ready list holds insns whose successors are all
                 * placed (INSN_REF_COUNT == 0); rank_for_schedule (sched.c:2415) sorts on
                 * (1) INSN_PRIORITY = dependence depth from the block TOP, (2) the
                 * dependent-on-last-scheduled class, (3) INSN_LUID, higher preferred.
                 * THE DECISIVE RULE IS NOT ANY OF THOSE THREE: when an insn is launched
                 * because its last successor was just placed, schedule_insn calls
                 * adjust_priority (sched.c:2533), whose n_deaths is ALWAYS 0 (gcc's own
                 * "??? this code has no effect, REG_DEAD notes are removed" comment), so the
                 * `case 0:` arm runs and bumps it to max_priority IF birthing_insn_p holds --
                 * i.e. if the insn SETS A REGISTER that is live here and has REG_N_SETS == 1.
                 * Every single-set chain temp qualifies, and max_priority is re-seeded from
                 * the just-scheduled insn, so THE BUMP IS SELF-SUSTAINING: once a dependence
                 * chain is entered it runs to completion, beating everything in the ready
                 * list.  That -- not a coloring tie and not a source read order -- is why
                 * "ours runs each chain to completion in turn" (the W62/W64/W71 read-offs).
                 * The counterpart: our three field loads set the HARD regs $a0/$a1 (combine
                 * folded each `_que.plain[i].f` straight into the call's argument set), and
                 * REG_N_SETS($a0) >> 1, so they are NOT birthing and sit at priority 2 --
                 * which is exactly why they lose to the chain.  Retail's stream requires the
                 * func chain to be interrupted TWICE, i.e. ALL THREE of its insns must be
                 * non-birthing (REG_N_SETS > 1) while still out-ranking the argument loads
                 * on LUID.  Those two requirements are in direct conflict under our RTL: the
                 * folded loads carry the block's HIGHEST luids, so anything that survives to
                 * out-rank them must be emitted after them in source, and anything with
                 * REG_N_SETS > 1 is a user variable whose extra set costs a real copy.
                 * MEASURED THIS WAVE on top of the shipped basin (all reverted; the probe
                 * harness + case files are scratchpad/W74_A18/probe.py + cases{1..4}.json):
                 *   IDENTITY/FLAG AXIS, now CLOSED for this fn: per-fn -fno-schedule-insns
                 *   56 @154 * -fno-schedule-insns2 18 @154 * -fno-delayed-branch 23 @155.
                 *   Retail's _gpu_que_drain is scheduled code; do not re-probe the flags.
                 *   REG_N_SETS DIAL (works, but overshoots): a SECOND assignment to `fidx`
                 *   makes its pseudo non-birthing and the whole func chain drops to the very
                 *   FRONT of the block instead of splitting -- two chained launders 13 @153
                 *   in every arrangement tried (clob+plain / plain+clob / clob,E,A,plain /
                 *   three launders / plain-only pair / E,A,clob,plain / clob,E,plain,A: all
                 *   13 @153, the +1 insn being the copy the second set costs), and the
                 *   zero-cost spellings of the same idea are worse (`fidx=_qout; fidx=fidx*96`
                 *   22 @152, `fidx*=96` 22, the split `*3`+`<<5` three-set form 17 @151 with
                 *   the clobber / 13 @151 without, `fidx=_qout;fidx=fidx*96` unclobbered 16).
                 *   LOAD-FOLD AXIS (trying to give the loads low luids): identity launder on
                 *   `extra` 10 (inert) * on `arg` 33 @151 * on both 12 * on all three 10
                 *   (inert) * multi-output tied launder (22B-3) on (arg,extra) 26, and with
                 *   read order fae 39 @151.  READ ORDER re-priced in this basin: fae 18 *
                 *   fae+launders 15 @151 * aef+launders 15 @151 (W64/W71 numbers hold).
                 *   CLOBBER PLACEMENT: $v0 clobber moved off `fidx` onto a tied launder of
                 *   `extra` 20 * of `arg` 28 * of `extra` before the arg read 20 * an
                 *   output-less volatile `$v0` clobber before the func read 36 (it is a
                 *   sched1 barrier, 20A) * a read-only fence on `fidx` after the arg read 34.
                 *   INERT AT 10 (safe, no gain): the clobber statement moved below the
                 *   extra/arg reads * adding "$6" to it * spelling the call as
                 *   `(*(QueFunc *)((char *)_que.plain + fidx))(arg, extra)`.
                 *   `$a2` denial alone ("$6" instead of "$2") 16 -- the $a2 holder is the
                 *   _qout READ pseudo, not `fidx`, so the existing launder cannot reach it.
                 * A TEXT_MOVES row was SPECIFIED AND REJECTED here (it is not a pure
                 * relocation): retail's three reloads live in TWO registers ($a1,$v1,$a1 --
                 * the third reusing the first) where ours needs THREE ($a2,$a1,$v1), because
                 * the reuse is a CONSEQUENCE of the split, so no permutation of our text can
                 * reach retail's.  The best legal permutation (lifting our `sll $v1,$a2,1;
                 * addu $v1,$v1,$a2` above the arg load) leaves the $a2-vs-$a1 pair plus the
                 * reload-pair displacement = 8, and moving the reload down instead is
                 * ILLEGAL (its chain would read $a2 before the load).  Rows are for
                 * assembler-side relocations; this one would only launder a register diff. */
                fidx = _qout * 96;
                __asm__("" : "=r"(fidx) : "0"(fidx) : "$2");
                extra = _que.plain[_qout].extra;
                arg = _que.plain[_qout].arg;
                func = *(QueFunc *)((char *)_que.plain + fidx);
                func(arg, extra);
            }
            _qout = (_qout + 1) & 0x3f;
            if (_qin == _qout)
                break;                           /* queue empty */
            if ((*D2_CHCR & dma_active) != 0)
                break;                           /* a DMA was started */
        }
    }
    SetIntrMask(_drain_saved_mask);
    if (_qin == _qout && (*D2_CHCR & 0x01000000) == 0) {
        /* Rage's pending-flag store is volatile.  Preserve that source fact here: comma-staging
         * the containing GEnv base and callback from the busy-field pointer gives retail's
         * $v1=busy / $a0=callback ownership, while the volatile store remains before jalr
         * instead of being moved into its delay slot.  This makes the function count-exact. */
        int *busy = &GEnv.busy;
        if (*busy != 0) {
            GEnvT *g;
            void (*idle_cb)(void);
            if ((g = (GEnvT *)((char *)busy - 8),
                 idle_cb = *(void (**)(void))(busy + 1),
                 idle_cb) != 0) {
                *(volatile int *)&g->busy = 0;
                idle_cb();
            }
        }
    }
    return (_qin - _qout) & 0x3f;
}

/* @0x800EF86C : reset the GPU command queue and (optionally) the GPU itself. */
extern int _reset(int mode)
{
    /* W52-A3, from the matched psyz `_reset`:
     *  - `_qin = _qout;` (the oracle LOADS _qout back and stores it into _qin), not
     *    two independent `= 0` stores;
     *  - a real `switch (mode & 7)` -- the oracle carries gcc-2.8's balance_case_nodes
     *    TREE (root `beq 1`, `slti 2` bound test, then `beqz 0` / `beq 3` / `bne 5`),
     *    which the old if/else-if chain cannot produce (>2 case NODES => tree);
     *  - the return is `!(mode & 7) ? _gpu_init_videomode(mode) : 0` (oracle stages
     *    `addu $v0,$zero,$zero` in the guard's delay slot) -- the old code returned
     *    SetIntrMask's saved mask on the non-zero path, a behaviour bug too. */
    _q_reset_mask = SetIntrMask(0);
    _qout = 0;
    _qin = _qout;
    switch (mode & 7) {
    case 0:
    case 5:
        *D2_CHCR = 0x401;
        *DMA_DPCR |= 0x800;
        *GPU_GP1 = 0;
        _memset((char *)_gp1_shadow, 0, 0x100);
        _memset((char *)&_que, 0, 0x1800);
        break;
    case 1:
    case 3:
        *D2_CHCR = 0x401;
        *DMA_DPCR |= 0x800;
        *GPU_GP1 = 0x02000000;
        *GPU_GP1 = 0x01000000;
        break;
    }
    SetIntrMask(_q_reset_mask);
    return !(mode & 7) ? _gpu_init_videomode(mode) : 0;
}

/* @0x800EF9BC : DrawSync backend.  mode==0 blocks until the queue and GPU are idle (or the
 *   watchdog fires, -1).  mode!=0 polls and returns the current queue depth. */
extern int _sync(int mode)
{
    /* MATCH: mode==0 arm written FIRST -- the oracle's bnez-mode branches AROUND this whole
     * block (placing it inline/fallthrough) and the mode!=0 arm out-of-line at the tail;
     * writing mode!=0 first (as an early-return `if`) inverted the branch and swapped which
     * block lands inline vs branched-to. */
    if (mode == 0) {
        _gpu_arm_timeout();
        while (_qin != _qout) {
            _gpu_que_drain();
            if (_gpu_check_timeout() != 0)
                return -1;
        }
        while ((*D2_CHCR & 0x01000000) != 0 || (*GPU_GP1 & 0x04000000) == 0) {
            if (_gpu_check_timeout() != 0)
                return -1;
        }
        return 0;
    }
    {
        int depth = (_qin - _qout) & 0x3f;
        if (depth != 0)
            _gpu_que_drain();
        /* MATCH (W55-A8, from the Rage-Racer matched `Gpu_DrawSync` poll arm): the two
         * readiness tests are an EMPTY-then-else nested pair whose ready path leaves the
         * block (RR spells it `break` out of a `switch(0)`), and the ready return is its
         * OWN return site -- the `&&` + shared `return depth` form let reorg eager-steal
         * `addu v0,s0,zero` into the FIRST branch's delay slot, which occupies $v0 and
         * pushes the GP1 read onto $v1/$a0 (the whole 16-diff residual). */
        if ((*D2_CHCR & 0x01000000) != 0) {
        } else {
            if ((*GPU_GP1 & 0x04000000) != 0)
                goto ready;
        }
        if (depth != 0)
            return depth;                        /* `addu v0,s0,zero` = the bnez delay slot */
        return 1;
    ready:
        return depth;
    }
}

/* @0x800EFAF8 : arm the GPU watchdog against the current VSync hsync count. */
extern void _gpu_arm_timeout(void)
{
    _gpu_timeout_target = VSync(-1) + 0xF0;
    _gpu_timeout_count = 0;
}

/* @0x800EFB2C : poll the watchdog.  Returns 0 while still waiting; on timeout it prints the
 *   GPU state, force-resets the queue + GPU, and returns -1. */
extern int _gpu_check_timeout(void)
{
    /* MATCH (W55-A8, ported in SHAPE from the Rage-Racer matched `Gpu_CheckTimeout`,
     * register pins dropped).  Four idioms, all oracle-evidenced:
     *  (a) the poll counter is bumped through a POINTER LOCAL with a POST-INCREMENT --
     *      `la $v1,_gpu_timeout_count; lw $v0,0($v1); addu $a0,$v0,zero; addiu $v0,$v0,1;
     *      sw $v0,0($v1)` -- a bare `_gpu_timeout_count = cnt + 1` is an `$at` macro store
     *      and compares the pre-read copy instead of the post-increment's saved value;
     *  (b) a DEAD READ of *GPU_GP1 through a POINTER LOCAL before the printf (RR spells it
     *      `(void)*gp1ForLog;`) -- the oracle's `lw $v0,0($a2)` whose result is dropped;
     *      the same $a2 then serves the printf's `stat` argument;
     *  (c) the queue indices are pulled into NAMED locals for the depth expression;
     *  (d) the reset block READS _qout BACK to seed _qin (`_qout = 0; state = _qout;
     *      _q_reset_mask = mask; _qin = state;`) -- the same read-back `_reset` already uses;
     *  (e) a RESULT FUNNEL over the whole body (RR's `switch (0) { default: ... }`) so both
     *      exits reach ONE shared epilogue via `j`. */
    int result;
    int state2;
    switch (0) { default:
    if (!(_gpu_timeout_target < VSync(-1))) {
        int *pollp = &_gpu_timeout_count;
        int  state = (*pollp)++;
        if (!(0xF0000 < state))
            break;
    }
    {
        volatile u_long *gp1 = GPU_GP1;
        int pending, gputail, mask;

        (void)*gp1;                              /* dead read, oracle `lw $v0,0($a2)` */
        pending = _qin;
        gputail = _qout;
        printf("GPU timeout:que=%d,stat=%08x,chcr=%08x,madr=%08x\n",   /* @0x80056EB8 */
               (pending - gputail) & 0x3f, (int)*gp1, (int)*D2_CHCR, (int)*D2_MADR);
        mask = SetIntrMask(0);
        _qout = 0;
        state2 = _qout;
        _q_reset_mask = mask;
        _qin = state2;
        *D2_CHCR = 0x401;
        *DMA_DPCR |= 0x800;
        *GPU_GP1 = 0x02000000;
        *GPU_GP1 = 0x01000000;
        SetIntrMask(_q_reset_mask);
    }
    result = -1;
    return result;
    }
    result = 0;
    return result;
}

/* @0x800EFC70 : reconfigure the GPU display registers for the current video mode. */
extern int _gpu_init_videomode(int mode)
{
    /* W55-A8 RECEIPT (14 diffs, ours 38 / oracle 40): the body, the branch polarities and
     * every arm's VALUE staging already match instruction-for-instruction.  The ENTIRE
     * residual is that reorg's `relax_delay_slots` converted our two `j <epilogue>` edges
     * into duplicated `jr ra` returns (and then filled their slots, which also pulled the
     * `andi v0,a0,8` up into the leading `beq`'s slot); the oracle keeps `j T; nop` /
     * `j T; sw a0,0(v1)` reaching ONE shared bare `jr ra; nop`.  FALSIFIED: the
     * result-funnel form (`int r; ... return r;`) -- gcc colors r into $a0 and adds an
     * `addu v0,a0,zero` copy per arm (31 diffs, ours 41).  This is a per-fn delayed-branch
     * / return-duplication mechanism, not a source shape -- SPEC'd for the orchestrator
     * (P2 `-fno-delayed-branch` splice candidate).
     * W60-A3 ADDITIONS.  (a) The explicit GOTO-FUNNEL (`int r; ... r=K; goto done; ... done:
     * return r;`, arms ordered PAL-then-NTSC so the NTSC block precedes the shared exit --
     * i.e. 11D COMPLETE-THE-FUNNEL done properly) lands in the SAME basin as the plain funnel:
     * 31 diffs, ours 41, `r` colored $a0 with an `addu v0,a0,zero` per arm.  Moving `r = 0;`
     * above the discarded `(void)*GPU_GP0` read is inert (31).  Root cause read off the
     * oracle: retail's dummy GP0 re-read goes through $v1 BECAUSE $v0 already holds the
     * result; ours takes $v0 for the re-read scratch, which forces `r` elsewhere -- circular,
     * and no arm/order/goto spelling breaks the circle.  (b) Read from the gcc source
     * (reorg.c:4289 make_return_insns, gated at 4586): only a jump to `end_of_function_label`
     * whose slot is ALREADY FILLED is turned into a RETURN, so retail's surviving `j <tail>`
     * pair means retail's jump.c never redirected those arms into returns at all -- a
     * compiler-version property.  (c) CONFIRMED SO: probed on the ladder's gcc-2.7.2 (272
     * recipe minus `-mno-split-addresses`, this fn's region only) -> 40/40 with **ZERO real
     * word diffs**, from THIS UNCHANGED SOURCE.  Not a floor and not a delayed-branch splice:
     * it is the 04M version axis.  Wiring spec in the DrawOTag block. */
    *GPU_GP1 = 0x10000007;
    if ((*GPU_GP0 & 0x00ffffff) != 2) {          /* old GPU */
        *GPU_GP0 = (*GPU_GP1 & 0x3fff) | 0xe1001000u;
        (void)*GPU_GP0;
        return 0;
    }
    if ((mode & 8) == 0)                          /* new GPU, NTSC */
        return 1;
    *GPU_GP1 = 0x09000001;                        /* new GPU, PAL : enable */
    return 2;
}

/* @0x800EFD10 : DrawOTag2 -- synchronous ordering-table draw (waits, then DMAs directly). */
extern int DrawOTag2(u_long *p)
{
    if (GEnv.debug >= 2)
        GPU_printf("DrawOTag(%08x)...\n", p);    /* @0x80056e58 */
    /* MATCH: the oracle ARMS THE WATCHDOG INLINE here -- `jal VSync` with $a0=-1 in the slot,
     * then `_gpu_timeout_target = v0 + 0xF0` and `_gpu_timeout_count = 0` as two direct stores.
     * A `jal _gpu_arm_timeout` (the helper call we had) is one instruction where the oracle
     * spends seven; the jal-count census flagged it (oracle VSync x1, ours _gpu_arm_timeout x1). */
    _gpu_timeout_target = VSync(-1) + 0xF0;
    _gpu_timeout_count = 0;
    while ((*D2_CHCR & 0x01000000) != 0 || (*GPU_GP1 & 0x04000000) == 0) {
        if (_gpu_check_timeout() != 0)
            return -1;
    }
    DMACallback(2, (int)_install_drain_cb);
    GEnv_drv->dma_chain(p);
    return 0;
}

/* @0x800EFE0C : attach _gpu_que_drain as the channel-2 (GPU) DMA-complete callback. */
extern void _install_drain_cb(void)
{
    DMACallback(2, (int)_gpu_que_drain);
}

/* @0x800EFE34 : obj-local byte fill (libgpu's private memset). */
extern void _memset(char *p, int c, int n)
{
    /* MATCH: i=n-1 hoisted ABOVE the guard -- n stays live across the compare, so the
     * counter can't coalesce into $a2: fresh $v0 counter + $v1 sentinel, and the init
     * lands in the beqz delay slot (oracle: addiu v0,a2,-1). */
    int i = n - 1;
    if (n != 0) {
        do { *p++ = (char)c; } while (--i != -1);
    }
}
