/* syslib/psx/libetc/INTR.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm, IDA unreliable
 *   for libetc).  obj INTR.obj ; libetc.lib.  The PsyQ interrupt-callback manager: init/teardown, the
 *   _intrhand IRQ dispatcher (longjmp'd to from the BIOS entry-int vector via the setjmp buffer), and the
 *   per-IRQ callback registration API.  IRQ regs: I_STAT=0x1F801070, I_MASK=0x1F801074, DPCR=0x1F8010F0.
 *   EvCB block @0x80134AF8 (0x41a words) modelled as IntrState so _bzero_w clears the exact region; the
 *   vsync/dma slot-setters returned by startIntr{VSync,DMA} are cached in g_vsync_setter/g_dma_setter.
 */

typedef int (*IntrSetter)(int, int);

extern "C" int  printf(const char *fmt, ...);          /* C63 */
extern "C" void ReturnFromException(void);             /* A23 */
extern "C" void ChangeClearPAD(int v);                 /* A91 */
extern "C" int  ChangeClearRCnt(int t, int m);         /* L10 */
extern "C" int  setjmp(long *env);                     /* C19 */
extern "C" void HookEntryInt(void *h);                 /* A25 */
extern "C" int  EnterCriticalSection(void);            /* A36 */
extern "C" void ExitCriticalSection(void);             /* A37 */
extern "C" void ResetEntryInt(void);                   /* A24 */
extern "C" void _96_remove(void);                      /* C114 */
extern "C" void *startIntrVSync(void);                 /* INTR_VB */
extern "C" void *startIntrDMA(void);                   /* INTR_DMA */

extern "C" void _intrhand(void);
extern "C" int  _set_intr_callback(unsigned int idx, int handler);

/* EvCB block @0x80134AF8 (0x41a words) */
typedef struct {
    unsigned short inited;                 /* +0x00  @0x80134AF8 */
    unsigned short in_handler;             /* +0x02  @0x80134AFA */
    int   cb[11];                          /* +0x04  @0x80134AFC : IRQ callbacks 0..10 */
    unsigned short enabled;                /* +0x30  @0x80134B28 : enabled-IRQ mask */
    unsigned short saved_imask;            /* +0x32  @0x80134B2A */
    int   saved_dpcr;                      /* +0x34  @0x80134B2C */
    long  jmpbuf[(0x1018 - 0x38) / 4];     /* +0x38  @0x80134B30 : setjmp buf + filler */
    int   evcb[(0x1068 - 0x1018) / 4];     /* +0x1018 @0x80135B10 : BIOS EvCB table */
} IntrState;
extern "C" IntrState g_intr;               /* @0x80134AF8 */
extern "C" IntrState *_initIntr(void);

/* MATCH (structural): the libetc callback API dispatches through a HOOK TABLE --
 * D_80135B60 = 8-slot struct {entry, dma_setter, set_cb, reset, stop, vsync_setter,
 * restart, &g_intr}, D_80135B80 = POINTER to it; every public fn loads the pointer and
 * jalr's the slot (lw v0,%lo(D_80135B80); lw v0,OFF(v0); jalr).  The former separate
 * g_dma_setter/g_vsync_setter globals @0x80135B64/74 ARE the +0x04/+0x14 slots. */
typedef struct {
    int        (*entry)();                        /* +0x00 @0x80135B60 : 0x80056F4C (static init) */
    IntrSetter   dma_setter;                      /* +0x04 : filled by _initIntr (startIntrDMA) */
    int        (*set_cb)(unsigned int, int);      /* +0x08 : _set_intr_callback */
    IntrState *(*reset)(void);                    /* +0x0C : _initIntr */
    IntrState *(*stop)(void);                     /* +0x10 : StopCallback */
    IntrSetter   vsync_setter;                    /* +0x14 : filled by _initIntr (startIntrVSync) */
    void       (*restart)(void);                  /* +0x18 : RestartCallback */
    IntrState   *state;                           /* +0x1C : &g_intr */
} IntrHooks;
extern "C" IntrHooks        g_hooks;             /* @0x80135B60 */
extern "C" IntrHooks       *g_hooks_ptr;         /* @0x80135B80 : = &g_hooks */
extern "C" volatile unsigned short *g_istat_ptr; /* @0x80135B84 : = 0x1F801070 */
extern "C" volatile unsigned short *g_imask_ptr; /* @0x80135B88 : = 0x1F801074 */
extern "C" volatile unsigned int   *g_dpcr_ptr;  /* @0x80135B8C : = 0x1F8010F0 */
extern "C" int g_intr_timeout;                   /* @0x80135B90 */

#define I_STAT (*g_istat_ptr)
#define I_MASK (*g_imask_ptr)
#define DPCR   (*g_dpcr_ptr)

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_bzero_w" (no __F mangling suffix), but
 * this `static` C++ fn got C++-mangled to _bzero_w__FPii, a NAME MISMATCH invisible to the gate
 * ("NOT IN OBJECT" forever). `static`+`extern "C"` can't combine as adjacent storage-class
 * specifiers on this compiler -- wrap in an `extern "C" { }` block instead. */
extern "C" {
static void _bzero_w(int *p, int n)        /* @0x800F2E70 */
{
    int i = n - 1;
    if (n != 0) { do { *p = 0; i = i - 1; p = p + 1; } while (i != -1); }
}
}   /* extern "C" */

extern "C" IntrState *_initIntr(void)       /* @0x800F2968 */
{
    if (g_intr.inited != 0)
        return 0;

    I_STAT = I_MASK = 0;
    DPCR = 0x33333333;
    _bzero_w((int *)&g_intr, 0x41a);
    if (setjmp(g_intr.jmpbuf) != 0)
        _intrhand();
    g_intr.jmpbuf[1] = (long)g_intr.evcb;
    HookEntryInt(g_intr.jmpbuf);
    g_intr.inited = 1;
    g_hooks_ptr->vsync_setter = (IntrSetter)startIntrVSync();
    g_hooks_ptr->dma_setter   = (IntrSetter)startIntrDMA();
    _96_remove();
    ExitCriticalSection();
    return &g_intr;
}

extern "C" void ResetCallback(void)        /* @0x800F284C */
{
    g_hooks_ptr->reset();
}

extern "C" void InterruptCallback(unsigned int idx, int handler)   /* @0x800F287C */
{
    g_hooks_ptr->set_cb(idx, handler);
}

extern "C" int DMACallback(int ch, int func)   /* @0x800F28AC */
{
    return g_hooks_ptr->dma_setter(ch, func);
}

extern "C" int VSyncCallback(int func)     /* @0x800F28DC */
{
    return g_hooks_ptr->vsync_setter(4, func);
}

extern "C" int VSyncCallbacks(int idx, int func)   /* @0x800F2910 */
{
    return g_hooks_ptr->vsync_setter(idx, func);
}

/* @0x800F2940 -- returns g_intr.in_handler (D_80134AFA); lhu = unsigned read */
extern "C" int CheckCallback(void)
{
    return (unsigned short)g_intr.in_handler;
}

extern "C" int SetIntrMask(int mask)   /* @0x800F2950 */
{
    /* MATCH: oracle uses g_imask_ptr (D_80135B88) indirection → lw ptr; lhu *ptr; sh a0,*ptr in jr delay */
    unsigned short *p = (unsigned short *)g_imask_ptr;
    int old = *p;
    *p = (unsigned short)mask;
    return old;
}

extern "C" void _intrhand(void)            /* @0x800F2A40 */
{
    if (g_intr.inited == 0) {
        printf("unexpected interrupt(%04x)\n", I_STAT);
        ReturnFromException();
    }
    g_intr.in_handler = 1;
    unsigned short pending = (unsigned short)((g_intr.enabled & I_STAT) & I_MASK);
    while (pending != 0) {
        for (int i = 0; pending != 0 && i < 11; ++i, pending >>= 1) {
            if (pending & 1) {
                I_STAT = (unsigned short)~(1 << i);
                if (g_intr.cb[i] != 0) {
                    ((void (*)())g_intr.cb[i])();
                }
            }
        }
        pending = (unsigned short)((g_intr.enabled & I_STAT) & I_MASK);
    }

    if (I_STAT & I_MASK) {
        if (g_intr_timeout++ > 0x800) {
            printf("intr timeout(%04x:%04x)\n", I_STAT, I_MASK);
            g_intr_timeout = 0;
            I_STAT = 0;
        }
    } else {
        g_intr_timeout = 0;
    }
    g_intr.in_handler = 0;
    ReturnFromException();
}

extern "C" int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */
{
    int *slot = &g_intr.cb[idx];
    int old = *slot;
    if ((handler != old) && (g_intr.inited != 0)) {
        unsigned short imask = I_MASK;
        I_MASK = 0;
        if (handler != 0) {
            *slot = handler;
            unsigned short bit = (unsigned short)(1 << (idx));
            imask = imask | bit;
            g_intr.enabled = g_intr.enabled | bit;
        } else {
            unsigned short bit = ~(unsigned short)(1 << (idx));
            *slot = 0;
            imask = imask & bit;
            g_intr.enabled = g_intr.enabled & bit;
        }
        /* @0x800F2CC0-D20: ChangeClearRCnt(<per-IRQ root-counter index>, handler==0). $a0 = the timer
         * id (idx0->RCnt3, idx4->0, idx5->1, idx6->2), $a1 = $s0 = (handler<1) = (handler==0) = the
         * clear flag. Reconstruction passed (0,0) to all four -- wrong timer + ignored handler (H48). */
        if (idx == 0) { ChangeClearPAD(handler == 0); ChangeClearRCnt(3, handler == 0); }
        if (idx == 4)   ChangeClearRCnt(0, handler == 0);
        if (idx == 5)   ChangeClearRCnt(1, handler == 0);
        if (idx == 6)   ChangeClearRCnt(2, handler == 0);
        I_MASK = imask;
    }
    return old;
}

extern "C" IntrState *StopCallback(void)   /* @0x800F2D58 */
{
    if (g_intr.inited == 0)
        return 0;
    EnterCriticalSection();
    g_intr.saved_imask = I_MASK;
    g_intr.saved_dpcr  = DPCR;
    I_MASK = 0;
    I_STAT = 0;
    DPCR = DPCR & 0x77777777;
    ResetEntryInt();
    g_intr.inited = 0;
    return &g_intr;
}

extern "C" int RestartCallback(void)       /* @0x800F2DF8 */
{
    if (g_intr.inited == 0) {
        HookEntryInt(g_intr.jmpbuf);
        g_intr.inited = 1;
        I_MASK = g_intr.saved_imask;
        DPCR   = g_intr.saved_dpcr;
        ExitCriticalSection();
        return (int)&g_intr;
    }
    return 0;
}

extern "C" { IntrState g_intr; }  /* owning-TU def (BSS) -- at EOF for type visibility */
