/* syslib/psx/libgpu/SYS.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; Ghidra mangled here).
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
 */

typedef unsigned long  u_long;
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;

/* ---- GPU context state (BSS; pointers installed at runtime by _reset) ---- */
static volatile u_long *GPU_GP0;     /* @0x801237A0 */
static volatile u_long *GPU_GP1;     /* @0x801237A4 */
static volatile u_long *D2_MADR;     /* @0x801237A8 */
static volatile u_long *D2_BCR;      /* @0x801237AC */
static volatile u_long *D2_CHCR;     /* @0x801237B0 */
static volatile u_long *D6_MADR;     /* @0x801237B4 */
static volatile u_long *D6_BCR;      /* @0x801237B8 */
static volatile u_long *D6_CHCR;     /* @0x801237BC */
static volatile u_long *DMA_DPCR;    /* @0x801237C0 */

static u_char _gp1_shadow[256];      /* @0x8013EAF8 : last value written per GP1 command (top byte = index) */

/* ============================ SUB-GROUP 1 ============================ */

/* @0x800EEA64 : read the GPU status register (GPUSTAT, shares GP1 address). */
int _get_status(void)
{
    return (int)*GPU_GP1;
}

/* @0x800EF248 : write one GP1 (control) command and shadow its low byte by command number. */
void _send_gp1(u_long cmd)
{
    *GPU_GP1 = cmd;
    _gp1_shadow[cmd >> 24] = (u_char)cmd;
}

/* @0x800EF26C : read back the shadowed low byte for GP1 command number `idx`. */
int _get_gp1(int idx)
{
    return _gp1_shadow[idx];
}

/* @0x800EF280 : push n words straight to GP0 with DMA disabled (CPU->GP0 transfer). */
int _send_gp0(u_long *p, int n)
{
    *GPU_GP1 = 0x04000000;                  /* DMA direction = off */
    if (n != 0) {
        do { *GPU_GP0 = *p++; } while (--n);
    }
    return 0;
}

/* @0x800EF2C0 : kick off a GPU ordering-table (linked-list) DMA on channel 2. */
void _gpu_dma_chain(u_long *ot)
{
    *GPU_GP1 = 0x04000002;                   /* DMA direction = 2 (linked list) */
    *D2_MADR = (u_long)ot;
    *D2_BCR  = 0;
    *D2_CHCR = 0x01000401;                   /* start, linked-list mode */
}

/* @0x800EF308 : issue a GP1 0x10 "get GPU info" query and return the 24-bit GPUREAD reply. */
int _get_gpuinfo(u_long cmd)
{
    *GPU_GP1 = cmd | 0x10000000;
    return (int)(*GPU_GP0 & 0x00ffffffu);
}

/* @0x800EFE34 : obj-local byte fill (libgpu's private memset). */
void _memset(char *p, int c, int n)
{
    if (n != 0) {
        int i = n - 1;
        do { *p++ = (char)c; } while (--i != -1);
    }
}

/* @0x800EE9C8 : build a GP0 0xE5 "drawing offset" command word. */
u_long _set_draw_offset(int x, int y)
{
    return 0xe5000000u | ((u_long)(x & 0x7ff)) | ((u_long)(y & 0x7ff) << 11);
}

/* @0x800EE878 : build a GP0 0xE1 "draw mode" command word (dfe=draw-to-display, dtd=dither). */
u_long _set_draw_mode(int dfe, int dtd, int tpage)
{
    u_long hi = dtd ? 0xe1000200u : 0xe1000000u;
    u_long lo = (u_long)(tpage & 0x9ff);
    if (dfe) lo |= 0x400u;
    return hi | lo;
}

/* ============================ SUB-GROUP 2 ============================
 *   Async DMA-chain + command-queue engine.  GPU work requests are pushed to a 64-entry
 *   ring of slots; a slot is dispatched either inline (when the GPU is idle) or from the
 *   channel-2 DMA-complete interrupt (the drain).  A VSync-based watchdog recovers from a
 *   wedged GPU (timeout -> reset queue + GPU).  All ring/index mutation runs inside a
 *   SetIntrMask(0) critical section. */

extern "C" int  VSync(int mode);                 /* libetc  VSYNC.obj @0x800F231C */
extern "C" int  SetIntrMask(int mask);           /* libetc  INTR.obj  @0x800F2950 (returns old mask) */
extern "C" int  DMACallback(int ch, int func);   /* libetc  INTR.obj  @0x800F28AC */
extern "C" int  printf(const char *fmt, ...);    /* libc    C63.obj   @0x801028AC */

typedef void (*QueFunc)(u_long *arg, int extra);

struct GpuQue {                      /* 0x60 bytes */
    QueFunc func;                    /* +0x00 */
    u_long *arg;                     /* +0x04 */
    int     extra;                   /* +0x08 */
    u_long  buf[21];                 /* +0x0C : inline-copied args (when push n != 0) */
};
static GpuQue _que[64];              /* @0x8013EC00 : the request ring */
static int    _qin;                  /* @0x801237C4 : producer index (mod 64) */
static int    _qout;                 /* @0x8013xxxx : consumer index (mod 64) */
static int    _q_saved_mask;         /* @0x801237CC : imask saved across the push critical section */
static int    _drain_saved_mask;     /* @0x801237D0 : imask saved across the drain critical section */
static int    _q_reset_mask;         /* @0x801237D4 : imask saved across timeout/reset */
static int    _gpu_timeout_target;   /* @0x801237D8 : VSync deadline */
static int    _gpu_timeout_count;    /* @0x801237DC : spin counter */
/* GEnv block small statics -> .bss (absolute), not .sdata/.sbss gp-rel.  See the GEnv_drv/_gpu_debug
 * note below (§3.12 absolute lever); the original addresses every GEnv field absolute. */
static u_char _gpu_active __attribute__((section(".bss")));   /* @0x8012369D : driver running (set by ResetGraph) */
static int    _gpu_busy   __attribute__((section(".bss")));   /* @0x801236A4 */
static QueFunc _gpu_idle_cb __attribute__((section(".bss"))); /* @0x801236A8 : "queue drained" callback */

static void _gpu_que_drain(void);    /* @0x800EF60C (fwd) */

/* @0x800EFAF8 : arm the GPU watchdog against the current VSync hsync count. */
static void _gpu_arm_timeout(void)
{
    _gpu_timeout_target = VSync(-1) + 0xF0;
    _gpu_timeout_count = 0;
}

/* @0x800EFB2C : poll the watchdog.  Returns 0 while still waiting; on timeout it prints the
 *   GPU state, force-resets the queue + GPU, and returns -1. */
static int _gpu_check_timeout(void)
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
static void _gpu_que_drain(void)
{
    if ((*D2_CHCR & 0x01000000) != 0)
        return;                                  /* a DMA is still running */
    _drain_saved_mask = SetIntrMask(0);
    if (_qin != _qout && (*D2_CHCR & 0x01000000) == 0) {
        for (;;) {
            if (((_qout + 1) & 0x3f) == _qin && _gpu_idle_cb == 0)
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
        && _gpu_busy != 0 && _gpu_idle_cb != 0) {
        _gpu_busy = 0;
        _gpu_idle_cb(0, 0);
    }
}

/* @0x800EF35C : enqueue a GPU request func(arg,extra).  If the GPU is idle the request is
 *   run inline; otherwise it is queued (optionally snapshotting n bytes of args into the
 *   slot).  Spins on the watchdog while the ring is full.  Returns the resulting depth. */
static int _gpu_que_push(QueFunc func, u_long *arg, int n, int extra)
{
    _gpu_arm_timeout();
    while (((_qin + 1) & 0x3f) == _qout) {       /* ring full */
        if (_gpu_check_timeout() != 0)
            return (_qin - _qout) & 0x3f;
        _gpu_que_drain();
    }
    _q_saved_mask = SetIntrMask(0);              /* enter critical section */
    _gpu_busy = 1;
    {
        int direct;
        if (_gpu_active == 0)                     direct = 1;
        else if (_qin != _qout)                  direct = 0;
        else if ((*D2_CHCR & 0x01000000) != 0)   direct = 0;
        else if (_gpu_idle_cb != 0)              direct = 0;
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
static int _que_ref(QueFunc func, u_long *arg, int extra)
{
    return _gpu_que_push(func, arg, 0, extra);
}

/* @0x800EFE0C : attach _gpu_que_drain as the channel-2 (GPU) DMA-complete callback. */
static void _install_drain_cb(void)
{
    DMACallback(2, (int)_gpu_que_drain);
}

/* @0x800EEA7C : clear an ordering table in reverse via the OTC DMA (channel 6), with watchdog. */
static void _clearOTagR_dma(u_long *ot, int n)
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
 *   offset-relative coordinates otherwise).  Screen size lives in _screenW/_screenH. */

static short _screenW __attribute__((section(".bss")));   /* @0x801236A0 (GEnv; absolute, not gp-rel) */
static short _screenH __attribute__((section(".bss")));   /* @0x801236A2 (GEnv; absolute, not gp-rel) */

/* @0x800EE898 : GP0 0xE3 drawing-area top-left, x/y clamped to the screen. */
static u_long _set_clip_tl(int x, int y)
{
    int sx = (short)x, cx;
    if (sx < 0)                  cx = 0;
    else if (_screenW - 1 < sx)  cx = _screenW - 1;
    else                         cx = x;
    int sy = (short)y, cy;
    if (sy < 0)                  cy = 0;
    else if (_screenH - 1 < sy)  cy = _screenH - 1;
    else                         cy = y;
    return 0xe3000000u | ((u_long)(cy & 0x3ff) << 10) | (u_long)(cx & 0x3ff);
}

/* @0x800EE930 : GP0 0xE4 drawing-area bottom-right, x/y clamped to the screen. */
static u_long _set_clip_br(int x, int y)
{
    int sx = (short)x, cx;
    if (sx < 0)                  cx = 0;
    else if (_screenW - 1 < sx)  cx = _screenW - 1;
    else                         cx = x;
    int sy = (short)y, cy;
    if (sy < 0)                  cy = 0;
    else if (_screenH - 1 < sy)  cy = _screenH - 1;
    else                         cy = y;
    return 0xe4000000u | ((u_long)(cy & 0x3ff) << 10) | (u_long)(cx & 0x3ff);
}

/* @0x800EE9E4 : GP0 0xE2 texture window from a RECT (mask x/y at +0/+2, window w/h at +4/+6),
 *   or 0 when tw is null. */
static u_long _get_tw(void *tw)
{
    if (tw == 0)
        return 0;
    u_char *b = (u_char *)tw;
    short  *s = (short *)tw;
    int m0 = b[0] >> 3;
    int m2 = b[2] >> 3;
    int w4 = (-s[2] & 0xff) >> 3;
    int w6 = (-s[3] & 0xff) >> 3;
    return 0xe2000000u | ((u_long)m0 << 10) | ((u_long)m2 << 15)
                       | ((u_long)w6 << 5)  | (u_long)w4;
}

/* @0x800EE608 : populate the DR_ENV primitive `d` from the DRAWENV `e`. */
static void _set_drawenv(void *dr_env, void *env)
{
    int    *d  = (int *)dr_env;
    char   *db = (char *)dr_env;
    short  *es = (short *)env;            /* clip.x/y/ofs : signed */
    u_short *eu = (u_short *)env;         /* clip.w/h/tpage : unsigned */
    u_char *eb = (u_char *)env;
    int t0 = 7;

    d[1] = (int)_set_clip_tl(es[0], es[1]);
    d[2] = (int)_set_clip_br((short)(eu[2] + eu[0] - 1), (short)(eu[3] + eu[1] - 1));
    d[3] = (int)_set_draw_offset(es[4], es[5]);
    d[4] = (int)_set_draw_mode(eb[23], eb[22], eu[10]);
    d[5] = (int)_get_tw((char *)env + 0xc);
    d[6] = (int)0xe6000000;

    if (eb[24] != 0) {                    /* DRAWENV.isbg : append a background clear */
        short rx = (short)eu[0], ry = (short)eu[1];
        short rw, rh;
        {   int v = (short)eu[2];         /* clamp width to screen */
            if (v < 0)                     rw = 0;
            else if (_screenW - 1 < v)     rw = (short)(_screenW - 1);
            else                           rw = (short)v;
        }
        {   int v = (short)eu[3];          /* clamp height to screen */
            if (v < 0)                     rh = 0;
            else if (_screenH - 1 < v)     rh = (short)(_screenH - 1);
            else                           rh = (short)v;
        }
        if ((rx & 0x3f) != 0 || (rw & 0x3f) != 0) {
            /* unaligned: GP0 0x60 mono-rect, coordinates relative to the draw offset */
            short xy[2], wh[2];
            xy[0] = (short)(rx - es[4]);
            xy[1] = (short)(ry - es[5]);
            wh[0] = rw;
            wh[1] = rh;
            d[t0]     = (int)(0x60000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
            d[t0 + 1] = *(int *)xy;
            d[t0 + 2] = *(int *)wh;
        } else {
            /* 64-aligned: GP0 0x02 fast framebuffer fill, absolute coordinates */
            short xy[2], wh[2];
            xy[0] = rx; xy[1] = ry;
            wh[0] = rw; wh[1] = rh;
            d[t0]     = (int)(0x02000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
            d[t0 + 1] = *(int *)xy;
            d[t0 + 2] = *(int *)wh;
        }
        t0 += 3;
    }
    db[3] = (char)(t0 - 1);               /* primitive length word-count */
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
static void _BlitClear(void *rect, int color)
{
    short   *rs = (short *)rect;
    u_short *ru = (u_short *)rect;
    short cw, ch;
    {   int v = (short)ru[2];
        if (v < 0) cw = 0; else if (_screenW - 1 < v) cw = (short)(_screenW - 1); else cw = (short)v; }
    rs[2] = cw;
    {   int v = (short)ru[3];
        if (v < 0) ch = 0; else if (_screenH - 1 < v) ch = (short)(_screenH - 1); else ch = (short)v; }
    rs[3] = ch;

    u_long mode = 0xe1000000u | (*GPU_GP1 & 0x7ff) | (((u_long)color >> 31) << 10);
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
static int _dws(void *rect, u_long *data)
{
    short   *rs = (short *)rect;
    u_short *ru = (u_short *)rect;
    int s5 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    _gpu_arm_timeout();
    short cw, ch;
    {   int v = (short)ru[2];
        if (v < 0) cw = 0; else if (_screenW - 1 < v) cw = (short)(_screenW - 1); else cw = (short)v; }
    rs[2] = cw;
    {   int v = (short)ru[3];
        if (v < 0) ch = 0; else if (_screenH - 1 < v) ch = (short)(_screenH - 1); else ch = (short)v; }
    rs[3] = ch;
    int words = ((int)rs[2] * (int)rs[3] + 1) >> 1;
    if (words <= 0)
        return -1;
    int blocks    = words >> 4;
    int remainder = words & 0xf;
    while ((*GPU_GP1 & 0x04000000) == 0)         /* wait until ready to receive DMA */
        if (_gpu_check_timeout() != 0)
            return -1;
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = s5 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
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
}

/* @0x800EEFC8 : StoreImage backend -- read the VRAM rect back into `data` words. */
static int _drs(void *rect, u_long *data)
{
    short   *rs = (short *)rect;
    u_short *ru = (u_short *)rect;
    _gpu_arm_timeout();
    short cw, ch;
    {   int v = (short)ru[2];
        if (v < 0) cw = 0; else if (_screenW - 1 < v) cw = (short)(_screenW - 1); else cw = (short)v; }
    rs[2] = cw;
    {   int v = (short)ru[3];
        if (v < 0) ch = 0; else if (_screenH - 1 < v) ch = (short)(_screenH - 1); else ch = (short)v; }
    rs[3] = ch;
    int words = ((int)rs[2] * (int)rs[3] + 1) >> 1;
    if (words <= 0)
        return -1;
    int blocks    = words >> 4;
    int remainder = words & 0xf;
    while ((*GPU_GP1 & 0x04000000) == 0)         /* wait until ready for DMA */
        if (_gpu_check_timeout() != 0)
            return -1;
    *GPU_GP1 = 0x04000000;
    *GPU_GP0 = 0x01000000;
    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
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
}

/* ============================ SUB-GROUP 4a ============================
 *   Public env-setter primitives.  Each fills a small GPU primitive `p` (length byte at +3,
 *   GP0 command words at +4/+8/...) using the SG3a word builders.  No queue/DMA involved. */

/* @0x800EE2DC : SetTexWindow(DR_TWIN *p, RECT *tw) */
extern "C" void SetTexWindow(void *p, void *tw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_get_tw(tw);
    ((int *)p)[2] = 0;
}

/* @0x800EE314 : SetDrawArea(DR_AREA *p, RECT *r) */
extern "C" void SetDrawArea(void *p, void *r)
{
    short   *rs = (short *)r;
    u_short *ru = (u_short *)r;
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_set_clip_tl(rs[0], rs[1]);
    ((int *)p)[2] = (int)_set_clip_br((short)(ru[0] + ru[2] - 1), (short)(ru[1] + ru[3] - 1));
}

/* @0x800EE394 : SetDrawStp(DR_STP *p, int pbw) -- GP0 0xE6 mask-bit setting */
extern "C" void SetDrawStp(void *p, int pbw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)(pbw ? 0xe6000001u : 0xe6000000u);
    ((int *)p)[2] = 0;
}

/* @0x800EE3BC : SetDrawMode(DR_MODE *p, int dfe, int dtd, int tpage, RECT *tw) */
extern "C" void SetDrawMode(void *p, int dfe, int dtd, int tpage, void *tw)
{
    ((char *)p)[3] = 2;
    ((int *)p)[1] = (int)_set_draw_mode(dfe, dtd, tpage & 0xffff);
    ((int *)p)[2] = (int)_get_tw(tw);
}

/* @0x800EE410 : SetDrawEnv(DR_ENV *dr_env, DRAWENV *env) -- public twin of _set_drawenv. */
extern "C" void SetDrawEnv(void *dr_env, void *env)
{
    int     *d  = (int *)dr_env;
    char    *db = (char *)dr_env;
    short   *es = (short *)env;
    u_short *eu = (u_short *)env;
    u_char  *eb = (u_char *)env;
    int t0 = 7;

    d[1] = (int)_set_clip_tl(es[0], es[1]);
    d[2] = (int)_set_clip_br((short)(eu[2] + eu[0] - 1), (short)(eu[3] + eu[1] - 1));
    d[3] = (int)_set_draw_offset(es[4], es[5]);
    d[4] = (int)_set_draw_mode(eb[23], eb[22], eu[10]);
    d[5] = (int)_get_tw((char *)env + 0xc);
    d[6] = (int)0xe6000000;

    if (eb[24] != 0) {
        short rx = (short)eu[0], ry = (short)eu[1];
        short rw, rh;
        {   int v = (short)eu[2];
            if (v < 0) rw = 0; else if (_screenW - 1 < v) rw = (short)(_screenW - 1); else rw = (short)v; }
        {   int v = (short)eu[3];
            if (v < 0) rh = 0; else if (_screenH - 1 < v) rh = (short)(_screenH - 1); else rh = (short)v; }
        short xy[2], wh[2];
        wh[0] = rw; wh[1] = rh;
        if ((rx & 0x3f) != 0 || (rw & 0x3f) != 0) {
            xy[0] = (short)(rx - es[4]);
            xy[1] = (short)(ry - es[5]);
            d[t0] = (int)(0x60000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
        } else {
            xy[0] = rx; xy[1] = ry;
            d[t0] = (int)(0x02000000u | ((u_long)eb[27] << 16) | ((u_long)eb[26] << 8) | eb[25]);
        }
        d[t0 + 1] = *(int *)xy;
        d[t0 + 2] = *(int *)wh;
        t0 += 3;
    }
    db[3] = (char)(t0 - 1);
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
extern "C" int (*GPU_printf)(const char *fmt, ...) __attribute__((section(".bss"))) = 0;

static u_char _gpu_debug __attribute__((section(".bss")));  /* @0x8012369E : GPU debug level (0=off; GEnv+2) */
static char  _genv_dispenv[0x14];   /* @0x80123708 : last-set DISPENV cache (GEnv+0x6C) */
static u_long _move_prim[5] = {      /* @0x80123734 : MoveImage's VRAM->VRAM copy primitive */
    0x04ffffffu,                     /* tag: 4 words, terminates */
    0x80000000u                      /* GP0 0x80 move-image command */
};

static int _reset(int mode);                     /* @0x800EF86C (fwd; defined in SG4b-ii) */
static int _sync(int mode);                      /* @0x800EF9BC (fwd; defined below) */

struct GpuTbl {                                  /* @0x80123654 */
    const char *id;                              /* +0  */
    int  (*que_ref)(QueFunc, u_long *, int);     /* +4  _que_ref */
    int  (*que_push)(QueFunc, u_long *, int, int);/* +8  _gpu_que_push */
    QueFunc blit_clear;                          /* +12 _BlitClear */
    void (*send_gp1)(u_long);                    /* +16 _send_gp1 */
    int  (*send_gp0)(u_long *, int);             /* +20 _send_gp0 */
    void (*dma_chain)(u_long *);                 /* +24 _gpu_dma_chain */
    QueFunc drs;                                 /* +28 _drs */
    QueFunc dws;                                 /* +32 _dws */
    void (*que_drain)(void);                     /* +36 _gpu_que_drain */
    int  (*get_gp1)(int);                        /* +40 _get_gp1 */
    void (*clear_otag)(u_long *, int);           /* +44 _clearOTagR_dma */
    int  (*get_gpuinfo)(u_long);                 /* +48 _get_gpuinfo */
    int  (*reset)(int);                          /* +52 _reset */
    int  (*get_status)(void);                    /* +56 _get_status */
    int  (*sync)(int);                           /* +60 _sync (DrawSync backend) */
};
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
static void _image(const char *label, void *rect)
{
    short *r = (short *)rect;
    const char *fmt;
    if (_gpu_debug == 1) {
        if (_screenW < r[2] || _screenW < r[0] + r[2] ||
            _screenH < r[1] || _screenH < r[1] + r[3] ||
            r[2] <= 0 || r[0] < 0 || r[1] < 0 || r[3] <= 0) {
            fmt = "%s:bad RECT";                  /* @0x80056dc8 */
        } else {
            return;                               /* in bounds */
        }
    } else if (_gpu_debug == 2) {
        fmt = "%s:";                              /* @0x80056de8 */
    } else {
        return;
    }
    GPU_printf(fmt, label);
    GPU_printf("(%d,%d)-(%d,%d)\n", r[0], r[1], r[2], r[3]);   /* @0x80056dd4 */
}

/* @0x800EF9BC : DrawSync backend.  mode==0 blocks until the queue and GPU are idle (or the
 *   watchdog fires, -1).  mode!=0 polls and returns the current queue depth. */
static int _sync(int mode)
{
    if (mode != 0) {
        int depth = (_qin - _qout) & 0x3f;
        if (depth != 0)
            _gpu_que_drain();
        if ((*D2_CHCR & 0x01000000) == 0 && (*GPU_GP1 & 0x04000000) != 0)
            return depth;
        if (depth != 0)
            return depth;
        return 1;
    }
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

/* @0x800EFC70 : reconfigure the GPU display registers for the current video mode. */
static int _gpu_init_videomode(int mode)
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
extern "C" void SetDispMask(int mask)
{
    if (_gpu_debug >= 2)
        GPU_printf("SetDispMask(%d)...\n", mask);   /* @0x80056DA0 (oracle @0x800ed7fc-824) */
    if (mask == 0)
        _memset(_genv_dispenv, -1, 0x14);
    _send_gp1(mask ? 0x03000000u : 0x03000001u);
}

/* @0x800ED87C : DrawSync */
extern "C" int DrawSync(int mode)
{
    if (_gpu_debug >= 2)
        GPU_printf("DrawSync(%d)...\n", mode);       /* @0x80056DB4 */
    return GEnv_drv->sync(mode);
}

/* @0x800EDA00 : ClearImage(RECT*, r, g, b) */
extern "C" int ClearImage(void *rect, int r, int g, int b)
{
    int color;
    _image("ClearImage", rect);                  /* @0x80056dec */
    color = ((b & 0xff) << 16) | ((g & 0xff) << 8) | (r & 0xff);
    return GEnv_drv->que_push(GEnv_drv->blit_clear, (u_long *)rect, 8, color);
}

/* @0x800EDA90 : LoadImage(RECT*, u_long *data) */
extern "C" int LoadImage(void *rect, u_long *data)
{
    _image("LoadImage", rect);                   /* @0x80056e04 */
    return GEnv_drv->que_push(GEnv_drv->dws, (u_long *)rect, 8, (int)data);
}

/* @0x800EDAF0 : StoreImage(RECT*, u_long *data) */
extern "C" int StoreImage(void *rect, u_long *data)
{
    _image("StoreImage", rect);                  /* @0x80056e10 */
    return GEnv_drv->que_push(GEnv_drv->drs, (u_long *)rect, 8, (int)data);
}

/* @0x800EDB50 : MoveImage(RECT*, x, y) -- VRAM->VRAM block copy. */
extern "C" int MoveImage(void *rect, int x, int y)
{
    short *r = (short *)rect;
    _image("MoveImage", rect);                   /* @0x80056e1c */
    if (r[2] == 0 || r[3] == 0)
        return -1;
    _move_prim[2] = *(u_long *)rect;             /* src xy */
    _move_prim[3] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */
    _move_prim[4] = *((u_long *)rect + 1);       /* wh */
    return GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, _move_prim, 0x14, 0);
}

/* @0x800EDCB4 : DrawOTag -- queue an ordering-table for DMA. */
extern "C" void DrawOTag(u_long *ot)
{
    if (_gpu_debug >= 2)
        GPU_printf("DrawOTag(%08x)...\n", ot);   /* @0x80056e58 */
    GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, ot, 0, 0);
}

/* @0x800EFD10 : DrawOTag2 -- synchronous ordering-table draw (waits, then DMAs directly). */
extern "C" int DrawOTag2(u_long *p)
{
    if (_gpu_debug >= 2)
        GPU_printf("DrawOTag(%08x)...\n", p);    /* @0x80056e58 */
    _gpu_arm_timeout();
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

extern "C" int   GetVideoMode(void);                 /* libetc VMODE.obj */
extern "C" void *memcpy(void *d, const void *s, unsigned n);/* libc   C42.obj @0x800EAAC4 */
extern "C" void  GPU_cw(u_long cw);                  /* libapi C73.obj @0x80104A0C (BIOS) */
extern "C" void  ResetCallback(void);                /* libetc INTR.obj @0x800F284C */

static char  _genv_mode;             /* @0x8012369C : current video mode (GEnv+0) */
static char  _genv_drawenv[0x5c];    /* @0x801236AC : last-set DRAWENV cache (GEnv+0x10) */

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
static int _reset(int mode)
{
    int ret;
    _q_reset_mask = SetIntrMask(0);
    _qout = 0;
    _qin = 0;
    int m = mode & 7;
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
extern "C" int ResetGraph(int mode)
{
    int m = mode & 7;
    if (m == 0 || m == 3 || m == 5) {
        if (m == 0 || m == 3)
            printf("ResetGraph:jtb=%08x,env=%08x\n",   /* @0x80056D10 (always; libc printf) */
                   (int)(long)&_gpu_tbl, (int)(long)&_genv_mode);
        /* _memset(&GEnv, 0, 0x80) : clear the whole GPU env block */
        _genv_mode = 0; _gpu_active = 0; _gpu_debug = 0;
        _screenW = 0; _screenH = 0; _gpu_busy = 0; _gpu_idle_cb = 0;
        ResetCallback();
        GPU_cw((u_long)(long)&_gpu_tbl & 0x00ffffffu);
        {
            int u = _reset(mode);
            _genv_mode = (char)u;
            _gpu_active = 1;
            _screenW = (short)_vmode_w[u & 0xff].v;
            _screenH = (short)_vmode_h[u & 0xff].v;
        }
        _memset(_genv_drawenv, -1, 0x5c);
        _memset(_genv_dispenv, -1, 0x14);
        return _genv_mode;
    }
    if (_gpu_debug >= 2)
        GPU_printf("ResetGraph(%d)...\n", mode);   /* @0x80056D30 */
    return GEnv_drv->reset(1);
}

/* @0x800EDC08 : clear an ordering table in reverse, then append the fixed terminator tail. */
extern "C" void ClearOTagR(u_long *ot, int n)
{
    if (_gpu_debug >= 2)
        GPU_printf("ClearOTagR(%08x,%d)...\n", ot, n);   /* @0x80056E40 */
    GEnv_drv->clear_otag(ot, n);
    _otc_link = 0x04000000u | ((u_long)(long)&_otc_term & 0x00ffffffu);
    ot[0] = (u_long)(long)&_otc_link & 0x00ffffffu;
}

/* @0x800EDD24 : build the env draw environment, queue it, and cache it. */
extern "C" void *PutDrawEnv(void *env)
{
    char *e = (char *)env;
    if (_gpu_debug >= 2)
        GPU_printf("PutDrawEnv(%08x)...\n", env);    /* @0x80056E6C */
    _set_drawenv(e + 0x1c, env);
    *(u_long *)(e + 0x1c) |= 0x00ffffffu;            /* terminate the DR_ENV */
    GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, (u_long *)(e + 0x1c), 0x40, 0);
    memcpy(_genv_drawenv, env, 0x5c);
    return env;
}

/* @0x800EDDE4 : program the GPU display environment (display area, mode, H/V ranges). */
extern "C" void *PutDispEnv(void *env)
{
    short   *es = (short *)env;
    u_short *eu = (u_short *)env;
    u_char  *eb = (u_char *)env;
    int     *ei = (int *)env;
    u_int u10, u3 = 0, u6 = 0, u7, u8 = 0;
    int i9;

    u10 = 0x8000000;
    _send_gp1(((u_long)(eu[1] & 0x3ff) << 10) | (eu[0] & 0x3ff) | 0x5000000u);
    if (ei[4] != 0 || es[0] != 0 || es[1] != 0 || es[2] != 0 || es[3] != 0) {
        u_int v = (u_int)GetVideoMode();
        eb[0x12] = (u_char)v;
        if ((v & 0xff) == 1) u10 = 0x8000008;
        if (eb[0x11] != 0) u10 |= 0x10;
        if (eb[0x10] != 0) u10 |= 0x20;
        {   short w = es[2];
            if (0x118 < w) {
                if (w < 0x161)      u10 |= 1;
                else if (w < 0x191) u10 |= 0x40;
                else if (w < 0x231) u10 |= 2;
                else                u10 |= 3;
            }
        }
        {   bool b2 = (es[3] < 0x121);
            if (eb[0x12] == 0) b2 = (es[3] < 0x101);
            if (!b2) u10 |= 0x24;
        }
        _send_gp1(u10);
        eb[0x12] = 8;
    }
    if (es[4] == 0 && es[5] == 0 && es[6] == 0 && es[7] == 0 && eb[0x12] != 8)
        goto done;
    {
        u_int vm = (u_int)GetVideoMode();
        eb[0x12] = (u_char)vm;
        u3 = (u_int)es[5] + 0x13;
        if ((vm & 0xff) == 0) u3 = (u_int)es[5] + 0x10;
        u10 = u3 + (u_int)es[7];
        if (es[7] == 0) u10 = u3 + 0xf0;
        i9 = 0;
        {   short w = es[2];
            if (0x118 < w && (i9 = 1, 0x160 < w) && (i9 = 2, 400 < w) && (i9 = 4, w < 0x231))
                i9 = 3;
        }
        {
            int idx = eb[0x12] * 5 + i9;
            int i5  = (int)_disp_overscan[idx].end - (int)_disp_overscan[idx].base;
            u7 = (u_int)_disp_overscan[idx].base + (u_int)((int)es[4] * (int)_disp_mult[i9]);
            if (es[6] != 0) i5 = i5 * es[6] >> 8;
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
        _send_gp1(((u7 & 0xfff) << 12) | (u8 & 0xfff) | 0x6000000u);
        _send_gp1(((u3 & 0x3ff) << 10) | (u6 & 0x3ff) | 0x7000000u);
    }
done:
    memcpy(_genv_dispenv, env, 0x14);
    return env;                                  /* oracle @0x800ee2c0 $v0 = $s1 = env */
}
