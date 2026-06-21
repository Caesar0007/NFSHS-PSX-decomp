/* syslib/psx/libcd/streamhelp.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   The CD-streaming ring consumer, teardown, and the small one-function helper objects that the
 *   streaming core (stream.cpp / stcdint.cpp) calls.  Grouped here as the logical "streaming helpers"
 *   module; each retains its libcd/libds object tag:
 *     StGetNext         (@0x800F9A28, C_009)  -- hand the caller the next decoded frame, if ready.
 *     StUnSetRing       (@0x800F8EC8, C_003)  -- tear the streaming callbacks down.
 *     init_ring_status  (@0x80108758, C_008)  -- zero the status word of a run of ring slots.
 *     data_ready_callback(@0x80108798, C_004) -- per-sector decode-done hook (marks slot ready).
 *     StSetMask         (@0x8010885C, C_010)  -- set the start-flag / start-frame / end-frame gate.
 *     DsReadyCallback   (@0x80108824, DSCB)   -- libds ready-callback slot.
 *     DsDataCallback    (@0x80108838, DSCB)   -- libds data-callback -> DMACallback(3,..).
 *
 *   Ring slots are 0x20 bytes; the per-frame data area starts at StRingAddr + StRingSize*0x20, one
 *   0x7E0-byte (0x3F*0x20) frame slot per ring index.  slot[0] is a status word: 0 free, 1 wrap
 *   marker, 2 decoded/ready, 3 DMA in flight, 4 handed to the caller. */

typedef unsigned long  u_long;
typedef unsigned short u_short;
typedef unsigned char  u_char;

/* ---- streaming state (stream.cpp) ------------------------------------------------------------- */
extern "C" int StRingAddr, StRingIdx1, StRingIdx2, StRingIdx3, StRingSize, StEndFrame;
extern "C" int StFunc1, StFinalSector, StSTART_FLAG, StStartFrame;

/* ---- peers ------------------------------------------------------------------------------------ */
extern "C" int  CdDataCallback(int func);   /* cdcont @0x800F7CB0 */
extern "C" int  CdReadyCallback(int func);  /* cdcont @0x800F78A0 */
extern "C" int  DMACallback(int ch, int func); /* libetc @0x800F28AC */
extern "C" int  EnterCriticalSection(void); /* BIOS @0x8010698C */
extern "C" void ExitCriticalSection(void);  /* BIOS @0x8010696C */
extern "C" int  DS_active;                  /* @0x8013BF68 : libds stream active */

/* ---- libds / C_004 globals (anonymous in the original) ---------------------------------------- */
/* Regular .bss, reached absolutely in the oracle (their 0x801489Dx addresses are far outside the
 * -G4 small-data window) -- pin to .bss so they are not placed in .sdata/.sbss (= gp-relative). */
#define ST_BSS __attribute__((section(".bss")))
extern "C" {
int _ds_word0   ST_BSS;   /* @0x801489D0 : last sector sub-header (slot+28) */
int _ds_word1   ST_BSS;   /* @0x801489D4 : last sector word (slot+8)        */
int _ds_ready_cb ST_BSS;  /* @0x801489E4 : DsReadyCallback slot             */
}

/* cached CD register pointers used only by StUnSetRing.  In the original these live in regular
 * .data @0x80136C48/0x80136C54 and are reached ABSOLUTELY (lui %hi; lw %lo) -- a plain initialised
 * `static` pointer is only 4 bytes so -G4 would place it in .sdata -> gp-relative (mismatch).
 * Pin to .data to keep the absolute addressing. */
static volatile u_char *_un_cd_idx  __attribute__((section(".data"))) = (volatile u_char *)0x1F801800;  /* @0x80136C48 CDREG0 */
static volatile u_char *_un_cd_reg3 __attribute__((section(".data"))) = (volatile u_char *)0x1F801803;  /* @0x80136C54 CDREG3 */

extern "C" int  data_ready_callback(void);
extern "C" int  DsReadyCallback(int func);
extern "C" int  DsDataCallback(int func);

/* @0x800F9A28 (C_009) : if the next frame is decoded, return its data + header; else return 1. */
extern "C" u_long StGetNext(u_long **addr, u_long **header)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));

    if (slot[0] == 1) {                         /* wrap marker: rewind to slot 0 */
        StRingIdx3 = 0;                          /* oracle: unconditional (beqz delay slot) */
        if (StEndFrame != 0)                     /* bounded stream: also clear the marker */
            slot[0] = 0;
        slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));
    }
    if (slot[0] != 2)                           /* not decoded yet (oracle returns 1 here) */
        return 1;

    slot[0] = 4;                                /* claim it */
    *addr   = (u_long *)(StRingAddr + (StRingSize << 5) + ((StRingIdx3 * 0x3F) << 5));
    *header = (u_long *)slot;
    return 0;
}

/* @0x800FA994 (C_007) : release the frame that `base` points into; advance the read index past it. */
extern "C" u_long StFreeRing(u_long *base)
{
    int       data_start = StRingAddr + (StRingSize << 5);   /* start of the frame-data area */
    int       idx        = ((int)base - data_start) / 0x7E0; /* 0x7E0 = 0x3F sectors * 0x20 */
    u_short  *slot       = (u_short *)(StRingAddr + (idx << 5));
    int       nframes    = slot[3];

    if (slot[0] != 4)                          /* not claimed by a StGetNext caller */
        return 1;
    if ((short)nframes > 0) {
        int k;
        for (k = 0; k < nframes; k++)
            *(u_short *)(StRingAddr + ((idx + k) << 5)) = 0;
    }
    StRingIdx3 = idx + nframes;
    return 0;
}

/* @0x80108758 (C_008) : zero the status word of `count` slots from `base`.
 * Oracle ends `jr ra; nop` with NO $v0 set -> the original returns void (the loop's
 * last $v0 scratch is left dead). A `return 0` would emit `addu v0,zero,zero` in the
 * delay slot (1 extra diff). Declared void here; the callers discard the result. */
extern "C" void init_ring_status(int base, unsigned count)
{
    unsigned i;
    for (i = 0; i < count; i++)
        *(int *)(StRingAddr + ((i + base) << 5)) = 0;   /* oracle adds i+base (addu v0,a2,a0) */
}

/* @0x80108798 (C_004) : a sector finished decoding -- mark its slot ready and notify StFunc1. */
extern "C" int data_ready_callback(void)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx2 << 5));

    slot[0]  = 2;                               /* status = decoded/ready */
    _ds_word0 = *(int *)((char *)slot + 28);   /* stash sub-header */
    _ds_word1 = *(int *)((char *)slot + 8);
    if (StFunc1 != 0) {
        StRingIdx2 = StRingIdx1;
        ((void (*)())StFunc1)();
    }
    StFinalSector = 0;
    return 0;
}

/* @0x8010885C (C_010) : configure the start gate. */
extern "C" void StSetMask(u_long mask, u_long start_frame, u_long end_frame)
{
    StSTART_FLAG = (int)mask;
    StStartFrame = (int)start_frame;
    StEndFrame   = (int)end_frame;
}

/* DsReadyCallback (@0x80108824) and DsDataCallback (@0x80108838) are OWNED by
 * libds.lib(DSCB.OBJ) -> defined in syslib/psx/libds/DSCB.cpp.  They were duplicated
 * here originally; removed to avoid a multiple-definition link conflict.  The extern
 * decls above keep the calls below resolving against the libds definitions. */

/* @0x800F8EC8 (C_003) : remove the streaming callbacks and quiesce the drive. */
extern "C" void StUnSetRing(void)
{
    EnterCriticalSection();
    if (DS_active == 1) {
        DsDataCallback(0);
        DsReadyCallback(0);
    } else {
        CdDataCallback(0);
        CdReadyCallback(0);
    }
    *_un_cd_idx  = 0;     /* CDREG0 = 0 */
    *_un_cd_reg3 = 0;     /* CDREG3 = 0 */
    ExitCriticalSection();
}
