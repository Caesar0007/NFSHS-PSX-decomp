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
 *   see the migration commit message for the full per-fn before/after table. */

typedef unsigned long  u_long;
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
typedef int bool;
#define true 1
#define false 0

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
extern u_char _gp1_shadow[256];
u_char _gp1_shadow[256] __attribute__((section(".bss")));

/* ============================ SUB-GROUP 1 ============================ */

/* @0x800EEA64 : read the GPU status register (GPUSTAT, shares GP1 address). */
extern int _get_status(void)
{
    return (int)*GPU_GP1;
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

/* @0x800EE9C8 : build a GP0 0xE5 "drawing offset" command word. */
extern u_long _set_draw_offset(int x, int y)
{
    u_long yi = (u_long)(y & 0x7ff) << 11;
    return 0xe5000000u | yi | (u_long)(x & 0x7ff);
}

/* @0x800EE878 : build a GP0 0xE1 "draw mode" command word (dfe=draw-to-display, dtd=dither).
 * Oracle uses beqz dtd delay-slot=lui v1,E100 (hi base in delay slot), then beqz dfe
 * delay-slot=andi v0,a2,9ff (lo base in delay slot).  Return or v0,v1,v0 = lo|hi. */
extern u_long _set_draw_mode(int dfe, int dtd, int tpage)
{
    /* MATCH (w48-a2, 5 -> 2, count-exact 8/8): the `lo = tpage & 0x9ff` statement must sit
     * AFTER the dtd block, so the `andi` is the last insn before the dfe `beqz` and dbr's
     * backward scan takes it as the delay-slot fill (ours previously hoisted it to the top and
     * nop'd the slot).  The old note's "hi-first order = wrong coloring" reading was basin-stale.
     * RESIDUAL 2 = the final `or $v0,$v1,$v0` OPERAND ORDER (ours `or $v0,$v0,$v1`).  Invariant
     * across 11 spellings, all count-exact 8/8: lo|=hi, fresh result var, `dfe`-block reorder,
     * decl-order lo-first, separate `hi=` assignment, `hi = dtd ? .. : ..` ternary, int-typed lo,
     * int-typed lo+hi (all 2); `return hi|lo` in any decl order (10 -- recolors lo into $a2).
     * = RTL commutative-operand canonicalization (w41 find_reg/cost-pass boundary class). */
    u_long hi = (u_long)0xe1000000u;
    u_long lo;
    if (dtd) hi |= 0x200u;
    lo = (u_long)(tpage & 0x9ff);
    if (dfe) lo |= 0x400u;
    return lo | hi;
}

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
static GpuQue _que[64];              /* @0x8013EC00 : the request ring */
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
    QueFunc idle_cb;    /* +0x0C @0x801236A8 : "queue drained" callback (was static _gpu_idle_cb) */
    char    drawenv[0x5c]; /* +0x10 @0x801236AC : last-set DRAWENV cache (was static _genv_drawenv) */
    char    dispenv[0x14]; /* +0x6C @0x80123708 : last-set DISPENV cache (was static _genv_dispenv) */
} GEnvT;                                                          /* total 0x80 bytes, matches the oracle's clear */
static GEnvT GEnv __attribute__((section(".bss")));   /* @0x8012369C */

extern int _gpu_que_drain(void);     /* @0x800EF60C (fwd) */

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
    int now = VSync(-1);
    if (!(_gpu_timeout_target < now)) {
        int cnt = _gpu_timeout_count;
        _gpu_timeout_count = cnt + 1;
        if (!(0xF0000 < cnt))
            return 0;
    }
    printf("GPU timeout:que=%d,stat=%08x,chcr=%08x,madr=%08x\n",   /* @0x80056EB8 */
           (_qin - _qout) & 0x3f, (int)*GPU_GP1, (int)*D2_CHCR, (int)*D2_MADR);
    _q_reset_mask = SetIntrMask(0);
    _qout = 0;
    _qin  = 0;
    *D2_CHCR = 0x401;
    *DMA_DPCR |= 0x800;
    *GPU_GP1 = 0x02000000;
    *GPU_GP1 = 0x01000000;
    SetIntrMask(_q_reset_mask);
    return -1;
}

/* @0x800EF60C : dequeue-and-dispatch.  Called inline after a push and from the channel-2
 *   DMA-complete interrupt.  Runs queued requests until the queue empties or a request
 *   kicks off a DMA (CHCR busy), then fires the idle callback if the queue is fully drained. */
extern int _gpu_que_drain(void)
{
    if ((*D2_CHCR & 0x01000000) != 0)
        return 1;                                /* a DMA is still running */
    _drain_saved_mask = SetIntrMask(0);
    if (_qin != _qout && (*D2_CHCR & 0x01000000) == 0) {
        for (;;) {
            if (((_qout + 1) & 0x3f) == _qin && GEnv.idle_cb == 0)
                DMACallback(2, 0);               /* last entry, no idle cb: detach drain */
            while ((*GPU_GP1 & 0x04000000) == 0) /* wait until the GPU can accept DMA */
                ;
            {
                u_long *arg  = _que[_qout].arg;
                int     extra = _que[_qout].extra;
                QueFunc func = _que[_qout].func;
                func(arg, extra);
            }
            _qout = (_qout + 1) & 0x3f;
            if (_qin == _qout)
                break;                           /* queue empty */
            if ((*D2_CHCR & 0x01000000) != 0)
                break;                           /* a DMA was started */
        }
    }
    SetIntrMask(_drain_saved_mask);
    if (_qin == _qout && (*D2_CHCR & 0x01000000) == 0
        && GEnv.busy != 0 && GEnv.idle_cb != 0) {
        GEnv.busy = 0;
        GEnv.idle_cb(0, 0);
    }
    return (_qin - _qout) & 0x3f;
}

/* @0x800EF35C : enqueue a GPU request func(arg,extra).  If the GPU is idle the request is
 *   run inline; otherwise it is queued (optionally snapshotting n bytes of args into the
 *   slot).  Spins on the watchdog while the ring is full.  Returns the resulting depth. */
extern int _gpu_que_push(QueFunc func, u_long *arg, int n, int extra)
{
    _gpu_arm_timeout();
    while (((_qin + 1) & 0x3f) == _qout) {       /* ring full */
        if (_gpu_check_timeout() != 0)
            return (_qin - _qout) & 0x3f;
        _gpu_que_drain();
    }
    _q_saved_mask = SetIntrMask(0);              /* enter critical section */
    GEnv.busy = 1;
    {
        int direct;
        if (GEnv.active == 0)                     direct = 1;
        else if (_qin != _qout)                  direct = 0;
        else if ((*D2_CHCR & 0x01000000) != 0)   direct = 0;
        else if (GEnv.idle_cb != 0)              direct = 0;
        else                                     direct = 1;
        if (direct) {
            while ((*GPU_GP1 & 0x04000000) == 0)
                ;
            func(arg, extra);
            SetIntrMask(_q_saved_mask);
            return 0;
        }
    }
    DMACallback(2, (int)_gpu_que_drain);         /* (re)attach drain to channel-2 interrupt */
    if (n != 0) {
        int words = n / 4;
        int i;
        for (i = 0; i < words; i++)
            _que[_qin].buf[i] = arg[i];
        _que[_qin].arg = _que[_qin].buf;
    } else {
        _que[_qin].arg = arg;
    }
    _que[_qin].extra = extra;
    _que[_qin].func  = func;
    _qin = (_qin + 1) & 0x3f;
    SetIntrMask(_q_saved_mask);                  /* leave critical section */
    _gpu_que_drain();
    return (_qin - _qout) & 0x3f;
}

/* @0x800EF338 : convenience wrapper -- push with no inline-arg copy (n = 0). */
extern int _que_ref(QueFunc func, u_long *arg, int extra)
{
    return _gpu_que_push(func, arg, 0, extra);
}

/* @0x800EFE0C : attach _gpu_que_drain as the channel-2 (GPU) DMA-complete callback. */
extern void _install_drain_cb(void)
{
    DMACallback(2, (int)_gpu_que_drain);
}

/* @0x800EEA7C : clear an ordering table in reverse via the OTC DMA (channel 6), with watchdog. */
extern void _clearOTagR_dma(u_long *ot, int n)
{
    *DMA_DPCR |= 0x08000000;                      /* enable DMA channel 6 (OTC) */
    *D6_CHCR = 0;
    *D6_MADR = (u_long)(ot + (n - 1));            /* last word of the table */
    *D6_BCR  = (u_long)n;
    _gpu_arm_timeout();
    *D6_CHCR = 0x11000002;                        /* start: backward, OTC clear */
    if ((*D6_CHCR & 0x01000000) != 0) {
        do {
            if (_gpu_check_timeout() != 0)
                break;
        } while ((*D6_CHCR & 0x01000000) != 0);
    }
}

/* ============================ SUB-GROUP 3a ============================
 *   DRAWENV -> DR_ENV builders.  These pack the GP0 environment commands (clip area, draw
 *   offset, draw mode, texture window) from a DRAWENV, clamping coordinates to the screen.
 *   _set_drawenv assembles the whole DR_ENV primitive and, when DRAWENV.isbg is set, appends
 *   a background-clear fill (GP0 0x02 fast fill for 64-aligned rects, GP0 0x60 mono-rect with
 *   offset-relative coordinates otherwise).  Screen size lives in GEnv.screenW/GEnv.screenH. */

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
extern u_long _set_clip_tl(int x, int y)
{
    int sx = (short)x, cx;
    int sy, cy;
    if (sx >= 0) {
        if (GEnv.screenW - 1 < sx) cx = (u_short)GEnv.screenW - 1;
        else                   cx = x;
    } else {
        cx = 0;
    }
    sy = (short)y;
    if (sy >= 0) {
        if (GEnv.screenH - 1 < sy) cy = (u_short)GEnv.screenH - 1;
        else                   cy = y;
    } else {
        cy = 0;
    }
    return 0xe3000000u | ((u_long)(cy & 0x3ff) << 10) | (u_long)(cx & 0x3ff);
}

/* @0x800EE930 : GP0 0xE4 drawing-area bottom-right, x/y clamped to the screen. */
extern u_long _set_clip_br(int x, int y)
{
    int sx = (short)x, cx;
    int sy, cy;
    if (sx >= 0) {
        if (GEnv.screenW - 1 < sx) cx = (u_short)GEnv.screenW - 1;
        else                   cx = x;
    } else {
        cx = 0;
    }
    sy = (short)y;
    if (sy >= 0) {
        if (GEnv.screenH - 1 < sy) cy = (u_short)GEnv.screenH - 1;
        else                   cy = y;
    } else {
        cy = 0;
    }
    return 0xe4000000u | ((u_long)(cy & 0x3ff) << 10) | (u_long)(cx & 0x3ff);
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

/* @0x800EE608 : populate the DR_ENV primitive `d` from the DRAWENV `e`. */
extern void _set_drawenv(void *dr_env, void *env)
{
    /* MATCH: ONE base pointer per parameter -- the oracle addresses every DR_ENV word off a
     * single s-reg (dr_env) and every DRAWENV field off a single other s-reg (env), just with
     * different LOAD WIDTHS at each offset (lh, lhu, lbu on the SAME base register). Declaring
     * separate typed views (int, short, u_short, u_char pointers) as their own locals gave
     * each view its own callee-saved register even though they hold the same address -- a
     * 72-byte, 6-reg frame vs the oracle's 40-byte, 2-reg frame. Macros over one db/eb base
     * collapse them back to a single register each, matching the oracle. */
    char   *db = (char *)dr_env;
    u_char *eb = (u_char *)env;
    int t0;
#define D(i)  (*(int *)(db + (i) * 4))
#define ES(i) (*(short *)(eb + (i) * 2))
#define EU(i) (*(u_short *)(eb + (i) * 2))

    D(1) = (int)_set_clip_tl(ES(0), ES(1));
    D(2) = (int)_set_clip_br((short)(EU(2) + EU(0) - 1), (short)(EU(3) + EU(1) - 1));
    D(3) = (int)_set_draw_offset(ES(4), ES(5));
    D(4) = (int)_set_draw_mode(eb[23], eb[22], EU(10));
    D(5) = (int)_get_tw(eb + 0xc);
    D(6) = (int)0xe6000000;

    /* MATCH: t0's constant 7 materializes HERE (oracle: addiu t0,zero,7 right before this
     * check), not at function entry -- it is dead across every call above, so a caller-saved
     * temp suffices and t0 never needs to be spilled/restored (the oracle uses raw $t0). */
    t0 = 7;
    if (eb[24] != 0) {                    /* DRAWENV.isbg : append a background clear */
        short rx = (short)EU(0), ry = (short)EU(1);
        short rw, rh;
        {   int v = (short)EU(2);         /* clamp width to screen */
            if (v < 0)                     rw = 0;
            else if (GEnv.screenW - 1 < v)     rw = (short)(GEnv.screenW - 1);
            else                           rw = (short)v;
        }
        {   int v = (short)EU(3);          /* clamp height to screen */
            if (v < 0)                     rh = 0;
            else if (GEnv.screenH - 1 < v)     rh = (short)(GEnv.screenH - 1);
            else                           rh = (short)v;
        }
        if ((rx & 0x3f) != 0 || (rw & 0x3f) != 0) {
            /* unaligned: GP0 0x60 mono-rect, coordinates relative to the draw offset */
            short xy[2], wh[2];
            xy[0] = (short)(rx - ES(4));
            xy[1] = (short)(ry - ES(5));
            wh[0] = rw;
            wh[1] = rh;
            D(t0)     = (int)(0x60000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
            D(t0 + 1) = *(int *)xy;
            D(t0 + 2) = *(int *)wh;
        } else {
            /* 64-aligned: GP0 0x02 fast framebuffer fill, absolute coordinates */
            short xy[2], wh[2];
            xy[0] = rx; xy[1] = ry;
            wh[0] = rw; wh[1] = rh;
            D(t0)     = (int)(0x02000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
            D(t0 + 1) = *(int *)xy;
            D(t0 + 2) = *(int *)wh;
        }
        t0 += 3;
    }
    db[3] = (char)(t0 - 1);               /* primitive length word-count */
#undef D
#undef ES
#undef EU
}

/* ============================ SUB-GROUP 3b ============================
 *   Software blitters (the *Image backends).  Each clamps its RECT to the screen, then:
 *     _BlitClear : builds a self-restoring OT in _blit_buf -- it queries the live draw env
 *                  (_get_gpuinfo 3/4/5), clears under a full-screen clip, then restores the
 *                  env -- and kicks it via _gpu_dma_chain.
 *     _dws       : LoadImage  (CPU->VRAM, GP0 0xA0): manual remainder words + 16-word DMA blocks.
 *     _drs       : StoreImage (VRAM->CPU, GP0 0xC0): manual remainder reads + 16-word DMA blocks.
 *   _dws/_drs poll the GPU-ready bit with the watchdog and bail (-1) on timeout. */

static u_long _blit_buf[18];   /* @0x8013EAB0 : scratch OT for _BlitClear */

/* @0x800EEB5C : ClearImage backend -- fill rect with `color`. */
extern void _BlitClear(void *rect, int color)
{
    short   *rs = (short *)rect;
    u_short *ru = (u_short *)rect;
    short cw, ch;
    u_long mode;
    {   int v = (short)ru[2];
        if (v < 0) cw = 0; else if (GEnv.screenW - 1 < v) cw = (short)(GEnv.screenW - 1); else cw = (short)v; }
    rs[2] = cw;
    {   int v = (short)ru[3];
        if (v < 0) ch = 0; else if (GEnv.screenH - 1 < v) ch = (short)(GEnv.screenH - 1); else ch = (short)v; }
    rs[3] = ch;

    mode = 0xe1000000u | (*GPU_GP1 & 0x7ff) | (((u_long)color >> 31) << 10);
    if ((ru[0] & 0x3f) == 0 && (cw & 0x3f) == 0) {
        /* 64-aligned: GP0 0x02 fast fill, list terminates immediately */
        _blit_buf[0] = 0x05ffffffu;
        _blit_buf[1] = 0xe6000000u;
        _blit_buf[2] = mode;
        _blit_buf[3] = 0x02000000u | ((u_long)color & 0xffffffu);
        _blit_buf[4] = *(u_long *)rect;
        _blit_buf[5] = *((u_long *)rect + 1);
    } else {
        /* unaligned: GP0 0x60 mono-rect under a full-screen clip, then restore the env */
        _blit_buf[0] = ((u_long)&_blit_buf[10] & 0x00ffffffu) | 0x08000000u;   /* 8-word header -> restore block */
        _blit_buf[1] = 0xe3000000u;                          /* clip TL = 0,0 */
        _blit_buf[2] = 0xe4ffffffu;                          /* clip BR = max */
        _blit_buf[3] = 0xe5000000u;                          /* draw offset = 0,0 */
        _blit_buf[4] = 0xe6000000u;                          /* mask */
        _blit_buf[5] = mode;
        _blit_buf[6] = 0x60000000u | ((u_long)color & 0xffffffu);
        _blit_buf[7] = *(u_long *)rect;
        _blit_buf[8] = *((u_long *)rect + 1);
        _blit_buf[10] = 0x03ffffffu;                         /* restore block: 3 words, terminates */
        {
            u_long g3 = _get_gpuinfo(3);
            u_long g4 = _get_gpuinfo(4);
            u_long g5 = _get_gpuinfo(5);
            _blit_buf[11] = g3 | 0xe3000000u;
            _blit_buf[12] = g4 | 0xe4000000u;
            _blit_buf[13] = g5 | 0xe5000000u;
        }
    }
    _gpu_dma_chain(_blit_buf);
}

/* @0x800EED8C : LoadImage backend -- transfer `data` words into the VRAM rect. */
extern int _dws(void *rect, u_long *data)
{
    /* MATCH: single base pointer for `rect` (§3.12 lever). */
    u_char *rb = (u_char *)rect;
#define RS(i) (*(short *)(rb + (i) * 2))
#define RU(i) (*(u_short *)(rb + (i) * 2))
    int s5 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    short cw, ch;
    int words;
    int blocks, remainder;
    _gpu_arm_timeout();
    {   int v = (short)RU(2);
        if (v < 0) cw = 0; else if (GEnv.screenW - 1 < v) cw = (short)(GEnv.screenW - 1); else cw = (short)v; }
    RS(2) = cw;
    {   int v = (short)RU(3);
        if (v < 0) ch = 0; else if (GEnv.screenH - 1 < v) ch = (short)(GEnv.screenH - 1); else ch = (short)v; }
    RS(3) = ch;
    words = ((int)RS(2) * (int)RS(3) + 1) >> 1;
    if (words <= 0)
        return -1;
    blocks    = words >> 4;
    remainder = words & 0xf;
    while ((*GPU_GP1 & 0x04000000) == 0)         /* wait until ready to receive DMA */
        if (_gpu_check_timeout() != 0)
            return -1;
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = s5 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)rb;
    *GPU_GP0 = *((u_long *)rb + 1);
    {   int i;
        for (i = 0; i < remainder; i++)
            *GPU_GP0 = *data++;
    }
    if (blocks != 0) {
        *GPU_GP1 = 0x04000002;
        *D2_MADR = (u_long)data;
        *D2_BCR  = ((u_long)blocks << 16) | 0x10;
        *D2_CHCR = 0x01000201;
    }
    return 0;
#undef RS
#undef RU
}

/* @0x800EEFC8 : StoreImage backend -- read the VRAM rect back into `data` words. */
extern int _drs(void *rect, u_long *data)
{
    /* MATCH: single base pointer for `rect` (§3.12 lever). */
    u_char *rb = (u_char *)rect;
#define RS(i) (*(short *)(rb + (i) * 2))
#define RU(i) (*(u_short *)(rb + (i) * 2))
    short cw, ch;
    int words;
    int blocks, remainder;
    _gpu_arm_timeout();
    {   int v = (short)RU(2);
        if (v < 0) cw = 0; else if (GEnv.screenW - 1 < v) cw = (short)(GEnv.screenW - 1); else cw = (short)v; }
    RS(2) = cw;
    {   int v = (short)RU(3);
        if (v < 0) ch = 0; else if (GEnv.screenH - 1 < v) ch = (short)(GEnv.screenH - 1); else ch = (short)v; }
    RS(3) = ch;
    words = ((int)RS(2) * (int)RS(3) + 1) >> 1;
    if (words <= 0)
        return -1;
    blocks    = words >> 4;
    remainder = words & 0xf;
    while ((*GPU_GP1 & 0x04000000) == 0)         /* wait until ready for DMA */
        if (_gpu_check_timeout() != 0)
            return -1;
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)rb;
    *GPU_GP0 = *((u_long *)rb + 1);
    while ((*GPU_GP1 & 0x08000000) == 0)         /* wait until ready to send pixels */
        if (_gpu_check_timeout() != 0)
            return -1;
    {   int i;
        for (i = 0; i < remainder; i++)
            *data++ = *GPU_GP0;
    }
    if (blocks != 0) {
        *GPU_GP1 = 0x04000003;
        *D2_MADR = (u_long)data;
        *D2_BCR  = ((u_long)blocks << 16) | 0x10;
        *D2_CHCR = 0x01000200;
    }
    return 0;
#undef RS
#undef RU
}

/* ============================ SUB-GROUP 4a ============================
 *   Public env-setter primitives.  Each fills a small GPU primitive `p` (length byte at +3,
 *   GP0 command words at +4/+8/...) using the SG3a word builders.  No queue/DMA involved. */

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
    /* MATCH: single base pointer per parameter (§3.12 lever; same fix as _set_drawenv). */
    char   *db = (char *)dr_env;
    u_char *eb = (u_char *)env;
    int t0;
#define D(i)  (*(int *)(db + (i) * 4))
#define ES(i) (*(short *)(eb + (i) * 2))
#define EU(i) (*(u_short *)(eb + (i) * 2))

    D(1) = (int)_set_clip_tl(ES(0), ES(1));
    D(2) = (int)_set_clip_br((short)(EU(2) + EU(0) - 1), (short)(EU(3) + EU(1) - 1));
    D(3) = (int)_set_draw_offset(ES(4), ES(5));
    D(4) = (int)_set_draw_mode(eb[23], eb[22], EU(10));
    D(5) = (int)_get_tw(eb + 0xc);
    D(6) = (int)0xe6000000;

    /* MATCH: t0's constant 7 materializes HERE, not at function entry (see _set_drawenv). */
    t0 = 7;
    if (eb[24] != 0) {
        short rx = (short)EU(0), ry = (short)EU(1);
        short rw, rh;
        short xy[2], wh[2];
        {   int v = (short)EU(2);
            if (v < 0) rw = 0; else if (GEnv.screenW - 1 < v) rw = (short)(GEnv.screenW - 1); else rw = (short)v; }
        {   int v = (short)EU(3);
            if (v < 0) rh = 0; else if (GEnv.screenH - 1 < v) rh = (short)(GEnv.screenH - 1); else rh = (short)v; }
        wh[0] = rw; wh[1] = rh;
        if ((rx & 0x3f) != 0 || (rw & 0x3f) != 0) {
            xy[0] = (short)(rx - ES(4));
            xy[1] = (short)(ry - ES(5));
            D(t0) = (int)(0x60000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
        } else {
            xy[0] = rx; xy[1] = ry;
            D(t0) = (int)(0x02000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
        }
        D(t0 + 1) = *(int *)xy;
        D(t0 + 2) = *(int *)wh;
        t0 += 3;
    }
    db[3] = (char)(t0 - 1);
#undef D
#undef ES
#undef EU
}

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

/* @0x800ED8E4 : debug-only RECT validator/printer (inert when GPU debug level is 0). */
extern void _image(const char *label, void *rect)
{
    short *r = (short *)rect;
    const char *fmt;
    if (GEnv.debug == 1) {
        if (GEnv.screenW < r[2] || GEnv.screenW < r[0] + r[2] ||
            GEnv.screenH < r[1] || GEnv.screenH < r[1] + r[3] ||
            r[2] <= 0 || r[0] < 0 || r[1] < 0 || r[3] <= 0) {
            fmt = "%s:bad RECT";                  /* @0x80056dc8 */
        } else {
            return;                               /* in bounds */
        }
    } else if (GEnv.debug == 2) {
        fmt = "%s:";                              /* @0x80056de8 */
    } else {
        return;
    }
    GPU_printf(fmt, label);
    GPU_printf("(%d,%d)-(%d,%d)\n", r[0], r[1], r[2], r[3]);   /* @0x80056dd4 */
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
        if ((*D2_CHCR & 0x01000000) == 0 && (*GPU_GP1 & 0x04000000) != 0)
            return depth;
        if (depth != 0)
            return depth;
        return 1;
    }
}

/* @0x800EFC70 : reconfigure the GPU display registers for the current video mode. */
extern int _gpu_init_videomode(int mode)
{
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

/* @0x800EDA00 : ClearImage(RECT*, r, g, b) */
extern int ClearImage(void *rect, int r, int g, int b)
{
    /* W51-A1 RECEIPT (8 diffs, count-EXACT 36/36 in both basins): pure PROLOGUE PARAM-COPY
     * SINK -- the oracle interleaves the `la` + `addu a1,s3,zero` call-arg setup between the
     * s-reg saves and sinks `addu s0,a3,zero` (the `b` param) into the `jal _image` delay slot;
     * ours emits all four parm copies up front.  FALSIFIED: hoisting the label to a local (8),
     * opacity fence on `b` after the call (8), fence on `b` before the call (10 / 8).
     * = the w46 assign_parms park class (emitted before any statement; only sched dependence
     * depth reaches it).  Same class as _image's count-exact 46. */
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
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (r[2] == 0 || r[3] == 0)
        return -1;
    /* MATCH: PAYLOAD-ANCHOR POINTER (w51-a1, landed WITH the cc1_272 lane wiring).
     * The oracle materializes ONE base for the payload words -- `la $v1,_move_prim+8`
     * (= &_move_prim[2]) -- stores the three words as 0/4/8($v1) displacements, and
     * derives the call argument by `addiu $a1,$v1,-8`.  Direct `_move_prim[2] = ...`
     * writes compile to the assembler macro `sw $r,sym` (one `lui $at` per store)
     * under the gcc-2.7.2 lane, which has no -msplit-addresses to pre-split the
     * address.  The explicit payload pointer restores the anchor+displacement shape.
     * (Under the OLD 2.8 lane this form regressed the then-PASS to 35 -- lane-paired.) */
    p = &_move_prim[2];
    __asm__("" : "=r"(p) : "0"(p));              /* zero-insn opacity fence: keeps cse from
                                                  * folding p back to the bare symbol address
                                                  * (which re-emits `sw $r,sym` $at macros). */
    /* FALSIFIED (272 basin, w51): dst-xy store FIRST rotates the payload base off
     * $v1 onto $a2 and costs +16 (17 -> 33); the oracle's `sw 4 / sw 0 / sw 8`
     * emission order is a scheduling product, not the source statement order. */
    p[0] = *(u_long *)rect;                      /* src xy */
    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */
    p[2] = *((u_long *)rect + 1);                /* wh */
    return GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, p - 2, 0x14, 0);
}

/* @0x800EDCB4 : DrawOTag -- queue an ordering-table for DMA.
 * FLOOR (2 diffs, re-tried w24-a4): oracle materializes a3=0 independently (addu a3,zero,zero)
 * in the jalr delay slot; ours CSEs it from the just-set a2=0 (addu a3,a2,zero). Tried+no
 * effect: named `int n=0` local, both n/extra as separate named locals -- gcc CSEs the two
 * zero args regardless of source form (both are the literal 0 in the same call). Same class as
 * the documented commutative-operand-selection floors; not source-reachable. */
extern void DrawOTag(u_long *ot)
{
    if (GEnv.debug >= 2)
        GPU_printf("DrawOTag(%08x)...\n", ot);   /* @0x80056e58 */
    GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, ot, 0, 0);
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

/* @0x800EF86C : reset the GPU command queue and (optionally) the GPU itself. */
extern int _reset(int mode)
{
    int ret;
    int m;
    _q_reset_mask = SetIntrMask(0);
    _qout = 0;
    _qin = 0;
    m = mode & 7;
    if (m == 0 || m == 5) {
        *D2_CHCR = 0x401;
        *DMA_DPCR |= 0x800;
        *GPU_GP1 = 0;
        _memset((char *)_gp1_shadow, 0, 0x100);
        _memset((char *)_que, 0, 0x1800);
    } else if (m == 1 || m == 3) {
        *D2_CHCR = 0x401;
        *DMA_DPCR |= 0x800;
        *GPU_GP1 = 0x02000000;
        *GPU_GP1 = 0x01000000;
    }
    ret = SetIntrMask(_q_reset_mask);
    if (m == 0)
        ret = _gpu_init_videomode(mode);
    return ret;
}

/* @0x800ED670 : initialise the graphics system for the given mode. */
extern int ResetGraph(int mode)
{
    int m = mode & 7;
    if (m == 0 || m == 3 || m == 5) {
        if (m == 0 || m == 3)
            printf("ResetGraph:jtb=%08x,env=%08x\n",   /* @0x80056D10 (always; libc printf) */
                   (int)(long)&_gpu_tbl, (int)(long)&GEnv);
        _memset((char *)&GEnv, 0, 0x80);
        ResetCallback();
        GPU_cw((u_long)(long)GEnv_drv & 0x00ffffffu);
        {
            int u = _reset(mode);
            GEnv.mode = (char)u;
            GEnv.active = 1;
            GEnv.screenW = (short)_vmode_w[u & 0xff].v;
            GEnv.screenH = (short)_vmode_h[u & 0xff].v;
        }
        _memset(GEnv.drawenv, -1, 0x5c);
        _memset(GEnv.dispenv, -1, 0x14);
        return GEnv.mode;
    }
    if (GEnv.debug >= 2)
        GPU_printf("ResetGraph(%d)...\n", mode);   /* @0x80056D30 */
    return GEnv_drv->reset(1);
}

/* @0x800EDC08 : clear an ordering table in reverse, then append the fixed terminator tail. */
extern void ClearOTagR(u_long *ot, int n)
{
    if (GEnv.debug >= 2)
        GPU_printf("ClearOTagR(%08x,%d)...\n", ot, n);   /* @0x80056E40 */
    GEnv_drv->clear_otag(ot, n);
    _otc_link = 0x04000000u | ((u_long)(long)&_otc_term & 0x00ffffffu);
    ot[0] = (u_long)(long)&_otc_link & 0x00ffffffu;
}

/* @0x800EDD24 : build the env draw environment, queue it, and cache it. */
extern void *PutDrawEnv(void *env)
{
    char *e = (char *)env;
    if (GEnv.debug >= 2)
        GPU_printf("PutDrawEnv(%08x)...\n", env);    /* @0x80056E6C */
    _set_drawenv(e + 0x1c, env);
    *(u_long *)(e + 0x1c) |= 0x00ffffffu;            /* terminate the DR_ENV */
    GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, (u_long *)(e + 0x1c), 0x40, 0);
    _memcpy(GEnv.drawenv, env, 0x5c);
    return env;
}

/* @0x800EDDE4 : program the GPU display environment (display area, mode, H/V ranges). */
extern void *PutDispEnv(void *env)
{
    /* MATCH: single base pointer for `env` (§3.12 lever; same class of bug as _set_drawenv). */
    u_char *eb = (u_char *)env;
#define ES(i) (*(short *)(eb + (i) * 2))
#define EU(i) (*(u_short *)(eb + (i) * 2))
#define EI(i) (*(int *)(eb + (i) * 4))
    u_int u10, u3 = 0, u6 = 0, u7, u8 = 0;
    int i9;

    if (GEnv.debug >= 2)
        GPU_printf("PutDispEnv(%08x)...\n", env);   /* @0x80056EA0 (was entirely missing) */
    u10 = 0x8000000;
    GEnv_drv->send_gp1(((u_long)(EU(1) & 0x3ff) << 10) | (EU(0) & 0x3ff) | 0x5000000u);
    /* MATCH (bug fix): gate is a CACHE COMPARE against GEnv.dispenv (disp.x/y/w/h + the
     * isinter/isrgb24/pad word at +0x10), not a check against literal zero -- the whole point
     * of caching the last-committed DISPENV. `GEnv.dispenv` bytes: disp at +0, screen at +8,
     * isinter/isrgb24/pad word at +0x10 (oracle: lw s2+0x7A == GEnv+0x7C == dispenv+0x10). */
    if (*(u_int *)(GEnv.dispenv + 0x10) != (u_int)EI(4) ||
        *(short *)(GEnv.dispenv + 0) != ES(0) ||
        *(short *)(GEnv.dispenv + 2) != ES(1) ||
        *(short *)(GEnv.dispenv + 4) != ES(2) ||
        *(short *)(GEnv.dispenv + 6) != ES(3)) {
        u_int v = (u_int)GetVideoMode();
        eb[0x12] = (u_char)v;
        if ((v & 0xff) == 1) u10 = 0x8000008;
        if (eb[0x11] != 0) u10 |= 0x10;
        if (eb[0x10] != 0) u10 |= 0x20;
        if (GEnv._pad3 != 0) u10 |= 0x80;      /* @0x8012369F : was mislabeled "unreferenced pad" */
        {   short w = ES(2);
            if (0x118 < w) {
                if (w < 0x161)      u10 |= 1;
                else if (w < 0x191) u10 |= 0x40;
                else if (w < 0x231) u10 |= 2;
                else                u10 |= 3;
            }
        }
        {   bool b2 = (ES(3) < 0x121);
            if (eb[0x12] == 0) b2 = (ES(3) < 0x101);
            if (!b2) u10 |= 0x24;
        }
        GEnv_drv->send_gp1(u10);
        eb[0x12] = 8;
    }
    /* MATCH (bug fix): same class -- gate on GEnv.dispenv.screen (+8/+10/+12/+14) vs env's
     * screen fields, not a zero check. */
    if (*(short *)(GEnv.dispenv + 8)  == ES(4) &&
        *(short *)(GEnv.dispenv + 10) == ES(5) &&
        *(short *)(GEnv.dispenv + 12) == ES(6) &&
        *(short *)(GEnv.dispenv + 14) == ES(7))
        goto done;
    {
        u_int vm = (u_int)GetVideoMode();
        eb[0x12] = (u_char)vm;
        u3 = (u_int)ES(5) + 0x13;
        if ((vm & 0xff) == 0) u3 = (u_int)ES(5) + 0x10;
        u10 = u3 + (u_int)ES(7);
        if (ES(7) == 0) u10 = u3 + 0xf0;
        i9 = 0;
        {   short w = ES(2);
            if (0x118 < w && (i9 = 1, 0x160 < w) && (i9 = 2, 400 < w) && (i9 = 4, w < 0x231))
                i9 = 3;
        }
        {
            int idx = eb[0x12] * 5 + i9;
            int i5  = (int)_disp_overscan[idx].end - (int)_disp_overscan[idx].base;
            u7 = (u_int)_disp_overscan[idx].base + (u_int)((int)ES(4) * (int)_disp_mult[i9]);
            if (ES(6) != 0) i5 = i5 * ES(6) >> 8;
            u6 = u7 + (u_int)i5;
        }
        if (eb[0x12] == 0) {
            u8 = 500;
            if (499 < (int)u7 && (u8 = 0xcb2, (int)u7 < 0xcb3)) u8 = u7;
            u7 = u8 + (u_int)_disp_mult[i9] * 4;
            if ((int)u7 <= (int)u6 && (u7 = 0xcda, (int)u6 < 0xcdb)) u7 = u6;
            if ((int)u3 < 0x10) u6 = 0x10;
            else { u6 = 0x101; if ((int)u3 < 0x102) u6 = u3; }
            { bool b2 = ((int)u10 < 0x103);
              u3 = u6 + 2;
              if ((int)u3 <= (int)u10) { u3 = 0x102; if (b2) u3 = u10; } }
        } else {
            u8 = 0x21c;
            if (0x21b < (int)u7 && (u8 = 0xc94, (int)u7 < 0xc95)) u8 = u7;
            u7 = u8 + (u_int)_disp_mult[i9] * 4;
            if ((int)u7 <= (int)u6 && (u7 = 0xcbc, (int)u6 < 0xcbd)) u7 = u6;
            if ((int)u3 < 0x13) u6 = 0x13;
            else { u6 = 0x12f; if ((int)u3 < 0x130) u6 = u3; }
            { bool b2 = ((int)u10 < 0x132);
              u3 = u6 + 2;
              if ((int)(u6 + 2) <= (int)u10) { u3 = 0x131; if (b2) u3 = u10; } }
        }
        GEnv_drv->send_gp1(((u7 & 0xfff) << 12) | (u8 & 0xfff) | 0x6000000u);
        GEnv_drv->send_gp1(((u3 & 0x3ff) << 10) | (u6 & 0x3ff) | 0x7000000u);
    }
done:
    _memcpy(GEnv.dispenv, env, 0x14);
    return env;                                  /* oracle @0x800ee2c0 $v0 = $s1 = env */
#undef ES
#undef EU
#undef EI
}
