/* eaclib/psx/sndpsxz/ssysinit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\ssysinit.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800F1D58 .. 0x800F204C].  The SND public-API boot layer: read/write the option block, bring
 *   the whole sound system up (SNDSYS_init) and tear it down (SNDSYS_restore).
 *   Ghidra nfs4-f.exe.c (ssysinit) + IDA sigs / disasm:
 *     SNDSYS_init forwards (membase,memsize) to iSNDmeminit (IDA's 0-arg is wrong); SNDSYS_setopts's
 *     0x80147860 constant RESOLVED to &sndgs (no bare VA); the option block is sndgs[0..0xe].
 */

#include "sdfx.h"
#include "sdata.h"
#include "sndcrtpriv.h"
#include "sndchpriv.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"
#include "ssysinit.h"
#include "slib.h"
#include "smemman.h"
#include "sserver.h"
#include "sstopall.h"

/* W65-A6 DATA-MAT: `sndgs` was extern-only tree-wide -- 201 reloc-referenced undefined sites,
 * the single biggest link hole.  Retail: .bss @0x80147860, size 180 (= sndchanreserved
 * @0x80147914 - 0x80147860); VA > t_addr+t_size (0x8013E000) so it carries NO file bytes =
 * pure zero-init BSS.  ssysinit.obj owns it (SNDSYS_getopts/setopts read+write the whole
 * option block sndgs[0..0xe] and it is the sound system's init module).
 * DEVICE = file-scope asm .bss definition, NOT a C tentative definition: every consumer
 * (30 TUs incl. this one) declares it `extern int sndgs[]` UNSIZED, and the unsized-vs-sized
 * array shape is a live codegen lever (methodology 3.12 #5 / 3.15-CORRECTION) -- a sized
 * `int sndgs[45]` definition would change address materialization in this TU.  Keeping the
 * C view `extern` makes the storage byte-neutral BY CONSTRUCTION (TU re-gates 4/4).
 * Receipts: scratchpad/w65a6/RECEIPTS.md
 * INTERIOR ALIASES: three of the tree's undefined `DAT_`/`D_` names are not separate objects
 * at all -- they are fixed offsets INSIDE this block, which is why nothing ever defined them:
 *      D_80147871   = sndgs + 0x11   (the channel count byte; sdpacket.c)
 *      D_80147898   = sndgs + 0x38   (SNDSYS_setopts' opts[14] destination; this TU)
 *      DAT_801478f4 = sndgs + 0x94   (= sndgs[0x25], the SndChannel * pool base; salloc.c)
 * They are emitted as extra LABELS at their exact offsets rather than as `sym = sndgs+N`
 * assignments, because ASPSX 2.77 (the production assembler) has no symbol-assignment form
 * (catalog 15E) -- a second label is the only dual-legal spelling.  This also retires 3 of the
 * 7 `DAT_` seal-criterion #3 violations (a Ghidra-ism referenced from code).
 * W66-A3 adds TWO more interior/alias labels of the SAME run, both previously
 * undefined at link time and both previously "defined" by a private 4-byte
 * tentative def at a VA retail does not have (the gRepeatCount class):
 *      gSndState        = sndgs + 0      (snd.h's `SND` base view; 3 TUs)
 *      sndgs_fx_bus0_master = sndgs + 0xA0 (= D_80147900, SndFxBus[0].master
 *                                         read by SNDPKTPLAY_start/stagpat;
 *                                         inside the DAT_801478f4 sub-run) */
/* (2026-09-20) the run itself is defined by sdata.obj (sdata.c), its retail link-order owner */

/* SNDSYS_getopts @0x800F1D58 : copy the live option block sndgs[0..0xe] into the caller's struct (lazily
 *   publishing the platform output caps first, defaulting maxbanks to 0x10).
 *   MATCH: non-void -- $v0 at exit is iSNDplatformoutputcaps()'s return (or 0 if that path wasn't
 *   taken), threaded through a local exactly like the §3.2 Ghidra void-return-bug class; the header's
 *   `void` prototype is the same incidental-vs-real-return question, resolved here from the oracle
 *   (`addu a1,zero,zero` init -> `addu a1,v0,zero` on the call path -> `addu v0,a1,zero` at exit). */
int SNDSYS_getopts(SNDSYSOPTS *opts)
{
    int r = 0;
    SNDSYSOPTS *base;
    if (!DAT_80134a68[0]) {
        r = iSNDplatformoutputcaps();
        DAT_80134a68[0] = 1;
    }
    base = (SNDSYSOPTS *)sndgs;
    if (!base->set.maxbanks)
        base->set.maxbanks = 0x10;
    *opts = *base;
    return r;
}


/* SNDSYS_setopts @0x800F1E14 : apply the canonical 44-byte opts->set block at
 *   +0x0c and the opts->vec callback at +0x38, then re-derive the output
 *   configuration. SNDSYSSET's two-byte alignment produces the oracle's
 *   inline lwl/lwr-vs-lw/sw alignment-checked copy. The typed `SNDSYSOPTS` view
 *   rooted at sndgs preserves the explicit +0x0c displacement. The
 *   array-shaped D_80147898 alias lets the callback store fill outputset's jal
 *   delay slot; spelling that store as a direct typed vec assignment regresses
 *   this function while preserving behavior. */
int SNDSYS_setopts(SNDSYSOPTS *opts)
{
    SNDSYSOPTS *base = (SNDSYSOPTS *)sndgs;
    base->set = opts->set;
    D_80147898[0] = opts->vec.issurfacelocked;
    iSNDplatformoutputset();
    return 0;
}

/* SNDSYS_init @0x800F1F10 : bring up the sound system from a `memsize`-byte pool at `membase` -- init the
 *   allocator, default the options, allocate the channel + bank tables, install the 100 Hz server, and
 *   start the SPU (iSNDinit). MATCH (79/79): returns the platform status on failure after cleanup,
 *   otherwise zero; no-op with zero when already up. */
int SNDSYS_init(void *membase, int memsize)
{
    unsigned int nchan;
    int          rv;
    SndChannel  *pool;
    struct SndGlobalServerStateView *base = (struct SndGlobalServerStateView *)sndgs;

    if (base->initialized)
        return 0;

    iSNDmeminit(membase, memsize);
    nchan = ((SNDSYSOPTS *)base)->set.inputvoices;
    if (!nchan) {                                              /* no caps yet -> defaults */
        SNDSYS_getopts((SNDSYSOPTS *)base);
        SNDSYS_setopts((SNDSYSOPTS *)base);
        nchan = ((SNDSYSOPTS *)base)->set.inputvoices;
    }
    pool = iSNDmalloc(nchan * sizeof(SndChannel));
    base->play_records = pool;                       /* allocated channel-array base */
    memset(pool, 0, ((SNDSYSOPTS *)base)->set.inputvoices * sizeof(SndChannel));
    base->bank_table = iSNDmalloc(
        ((SNDSYSOPTS *)base)->set.maxbanks * sizeof(struct SndBankTableEntry)); /* bank table base */
    memset(base->bank_table, 0,
           ((SNDSYSOPTS *)base)->set.maxbanks * sizeof(struct SndBankTableEntry));
    if (!base->server_callback)
        base->server_callback = iSND100hzserver;
    SNDI_mutexalloc();
    base->tick_count = 0;
    base->real_ticks = 0;
    base->master_volume = 0x7f;                                             /* master vol */
    rv = iSNDinit();
    if (rv < 0) {
        iSNDrestore();
        return rv;
    }
    base->initialized = 1;                                                /* audio up */
    return 0;
}

/* SNDSYS_restore @0x800F204C : shut the sound system down -- fire the registered teardown hooks, stop all
 *   voices, restore the SPU, free the mutex + memory.  No-op if not up. */
int SNDSYS_restore(void)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)                             /* audio not up */
        return -10;
    if (((struct SndGlobalServerStateView *)sndgs)->service_callbacks[10]) (*(void (*)(void))((struct SndGlobalServerStateView *)sndgs)->service_callbacks[10])();
    if (((struct SndGlobalServerStateView *)sndgs)->service_callbacks[11]) (*(void (*)(void))((struct SndGlobalServerStateView *)sndgs)->service_callbacks[11])();
    if (((struct SndGlobalServerStateView *)sndgs)->service_callbacks[8]) (*(void (*)(void))((struct SndGlobalServerStateView *)sndgs)->service_callbacks[8])();
    if (((struct SndGlobalLifecycleHookView *)sndgs)->stream_destroy_all_hook)
        ((struct SndGlobalLifecycleHookView *)sndgs)->stream_destroy_all_hook();
    if (((struct SndGlobalServerStateView *)sndgs)->service_callbacks[7]) (*(void (*)(void))((struct SndGlobalServerStateView *)sndgs)->service_callbacks[7])();
    SNDstopall();
    if (((struct SndGlobalLifecycleHookView *)sndgs)->bank_remove_hook)
        ((struct SndGlobalLifecycleHookView *)sndgs)->bank_remove_hook(-1);
    iSNDrestore();
    ((struct SndGlobalServerStateView *)sndgs)->initialized = 0;                                     /* audio down */
    SNDI_mutexfree();
    return iSNDmemrestore();   /* $v0 holds iSNDmemrestore's return on this path (incidental);
                                * the -10 sentinel lives only in the not-up beqz delay slot */
}

/* ssysinit.obj .data 0x80134A68, owned here since 2026-09-19 (gprefs.py: SNDSYS_getopts is the only user; retail
 * link order ssysinit, ssysreal, MSC00 = data order 0x80134A68, A6C, A70).  Defined after its use so the unsized
 * extern keeps the retail absolute addressing. */
int DAT_80134a68[1] __attribute__((section(".data"))) = { 0 };
