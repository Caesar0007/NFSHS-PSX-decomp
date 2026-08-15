/* syslib/psx/libcd/stream.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   The libcd CD-streaming ring-buffer API + its shared state block.  PsyQ ships each St* entry as a
 *   one-function object (C_002/C_003/C_005/C_009/CDROM/C_010/C_011...); the ones reconstructed here
 *   are grouped as the logical "streaming API" module since they all manipulate the same globals.
 *
 *   This TU is also the define-once owner of the streaming subsystem's shared .bss (three discontiguous
 *   regions in the original: StFunc1/2 @0x80144874, StMode @0x801489CC, and the main St* block
 *   @0x80146C7C..0x80146CC4).  Other streaming objects (cdread2.cpp, the forthcoming StCdInterrupt /
 *   StGetNext / StUnSetRing) declare these extern.
 *
 *   Functions reconstructed here:
 *     StSetStream (@0x800F8FF8, C_005)  -- arm a streaming read: mask + callbacks + reset counters.
 *     StClearRing (@0x800F8968, C_002)  -- reset all ring indices / flags and re-init slot status.
 *     StSetRing   (@0x800F99F8, CDROM)  -- install the caller's ring buffer, then StClearRing(). */

typedef unsigned long u_long;

/* ---- streaming subsystem shared state (.bss; @VA breadcrumbs) --------------------------------- */
/* These globals live in regular .bss in the original and are reached ABSOLUTELY (lui %hi; lw %lo)
 * by every St* function -- NONE is gp-relative in the oracle (their .bss addresses @0x80146Cxx /
 * 0x801489CC are far outside the -G4 small-data window around _gp=0x8013C54C).  Defining them as a
 * plain `int X = 0;` would place them in .sdata/.sbss -> gp-relative, which mismatches the ROM.  The
 * `section(".bss")` attribute keeps the (single, TU-owned) definition but pins it to regular .bss so
 * the addressing matches.  (cf. methodology 3.12 #6 caveat: gate gp-rel on %gp_rel in the oracle.) */
/* 🔴 W65-A6 CORRECTION: the `__attribute__((section(".bss")))` device above is INERT on this
 * lane.  gcc-2.7.2 emits an uninitialised file-scope object as `.comm NAME,size` regardless of
 * the section attribute, and this TU compiles on the cc1_272 lane (macro cc1 + direct GNU as,
 * NO maspsx), so nothing rewrites the `.comm` -- `nm` reported all 21 as COMMON (`C`).
 * A COMMON IS PLACED BY ld, NOT BY THE OBJECT, so none of them could ever reach the retail VA
 * its own breadcrumb names (W62-A18 T6 / W64-A19 sec.3.4: 37 such symbols tree-wide).
 * REPLACEMENT: a file-scope asm `.section .bss` block -- a REAL, object-owned definition at
 * exact retail offsets, with the C view demoted to `extern` so cc1 emits precisely the
 * absolute `lui %hi; lw %lo` references it emitted before (byte-neutral by construction;
 * TU re-gates 3/3 PASS).  Sizes/offsets are the SYM's VA deltas, fully accounted.
 * 🔴 FOR THE .ld LANE: these 21 symbols form THREE DISJOINT retail runs, so one object's
 * (contiguous) .bss cannot reproduce all three -- retail's LIBCD split them across objects our
 * stream.c merges.  The runs are:
 *      A @0x80144874   8 B : StFunc1, StFunc2   (then 9216 B = iso9660.c's _cd_* buffers)
 *      B @0x80146C7C  72 B : StEmu_Addr .. StStartFrame (ends exactly at Cdinfo @0x80146CC4)
 *      C @0x801489CC   4 B : StMode      (then 16 B unattributed, GlobalCallback @0x801489E0)
 * They are emitted below in VA order as one block; splitting stream.c (or per-run sections)
 * is a placement decision for the link lane, not a symbol-definition one.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\tStFunc1\n\t.globl\tStFunc2\n"
        "\t.globl\tStEmu_Addr\n\t.globl\tStCdIntrFlag\n\t.globl\tCChannel\n\t.globl\tStCHANNEL\n"
        "\t.globl\tStframe_no\n\t.globl\tStRgb24\n\t.globl\tStEndFrame\n\t.globl\tStSTART_FLAG\n"
        "\t.globl\tStEmu_Idx\n\t.globl\tStsector_offset\n\t.globl\tStFinalSector\n"
        "\t.globl\tStRingBase\n\t.globl\tStRingAddr\n\t.globl\tStRingIdx1\n\t.globl\tStRingIdx2\n"
        "\t.globl\tStRingIdx3\n\t.globl\tStRingSize\n\t.globl\tStStartFrame\n\t.globl\tStMode\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "StFunc1:\n\t.space\t4\n"
        "StFunc2:\n\t.space\t4\n"
        "StEmu_Addr:\n\t.space\t4\n"
        "StCdIntrFlag:\n\t.space\t4\n"
        "CChannel:\n\t.space\t4\n"
        "StCHANNEL:\n\t.space\t4\n"
        "Stframe_no:\n\t.space\t4\n"
        "StRgb24:\n\t.space\t4\n"
        "StEndFrame:\n\t.space\t4\n"
        "StSTART_FLAG:\n\t.space\t4\n"
        "StEmu_Idx:\n\t.space\t4\n"
        "Stsector_offset:\n\t.space\t4\n"   /* `short`, but retail's slot is 4 (StFinalSector @+4) */
        "StFinalSector:\n\t.space\t4\n"
        "StRingBase:\n\t.space\t4\n"
        "StRingAddr:\n\t.space\t4\n"
        "StRingIdx1:\n\t.space\t4\n"
        "StRingIdx2:\n\t.space\t4\n"
        "StRingIdx3:\n\t.space\t4\n"
        "StRingSize:\n\t.space\t4\n"
        "StStartFrame:\n\t.space\t4\n"
        "StMode:\n\t.space\t4\n\t.text");

extern int   StFunc1;            /* @0x80144874 : per-sector "VLC ready" callback   */
extern int   StFunc2;            /* @0x80144878 : per-frame "frame ready" callback  */
extern int   StMode;             /* @0x801489CC : RGB24/mono streaming flag         */
extern int   StEmu_Addr;         /* @0x80146C7C : emulated-stream source (0 = CD)   */
extern int   StCdIntrFlag;       /* @0x80146C80 */
extern int   CChannel;           /* @0x80146C84 : current channel                   */
extern int   StCHANNEL;          /* @0x80146C88 : selected channel                  */
extern int   Stframe_no;         /* @0x80146C8C : current frame number              */
extern int   StRgb24;            /* @0x80146C90 : RGB24 mode                        */
extern int   StEndFrame;         /* @0x80146C94 : last frame to play (0 = endless)  */
extern int   StSTART_FLAG;       /* @0x80146C98 : start-frame gating enabled        */
extern int   StEmu_Idx;          /* @0x80146C9C : emulated-stream sector index      */
extern short Stsector_offset;    /* @0x80146CA0 : sector offset within frame        */
extern int   StFinalSector;      /* @0x80146CA4 : final-sector reached flag         */
extern int   StRingBase;         /* @0x80146CA8 */
extern int   StRingAddr;         /* @0x80146CAC : ring buffer base address          */
extern int   StRingIdx1;         /* @0x80146CB0 : write (CD fill) index             */
extern int   StRingIdx2;         /* @0x80146CB4 : decode index                      */
extern int   StRingIdx3;         /* @0x80146CB8 : read (StGetNext) index            */
extern int   StRingSize;         /* @0x80146CBC : ring slot count                   */
extern int   StStartFrame;       /* @0x80146CC0 : first frame to play               */
/* (Cdinfo @0x80146CC4 is the CDfs control struct -- owned by cdfs.cpp, not the streaming state.) */


/* ---- peer streaming objects ------------------------------------------------------------------- */
extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame); /* C_010 @0x8010885C */
extern int  init_ring_status(int base, unsigned count);                  /* C_008 @0x80108758 */

/* @0x800F8968 (C_002) : reset the ring (indices, flags, per-slot status).
 * W60-A4: moved FIRST -- retail VA order is StClearRing @0x800F8968 <
 * StSetStream @0x800F8FF8 < StSetRing @0x800F99F8. */
extern void StClearRing(void)
{
    StRingIdx3    = 0;
    StRingIdx2    = 0;
    StRingIdx1    = 0;
    StFinalSector = 0;
    init_ring_status(0, (unsigned)StRingSize);
    StCdIntrFlag    = 0;
    Stsector_offset = 0;
    Stframe_no      = 0;
}

/* @0x800F8FF8 (C_005) : arm a streaming read. */
extern void StSetStream(u_long mode, u_long start_frame, u_long end_frame,
                            void (*func1)(), void (*func2)())
{
    StSetMask(1, start_frame, end_frame);
    StEmu_Addr      = 0;
    StFunc1         = (int)func1;
    StRgb24         = (int)(mode & 1);
    CChannel        = 0;
    StCHANNEL       = 0;
    Stsector_offset = 0;
    Stframe_no      = 0;
    StFunc2         = (int)func2;
}

/* @0x800F99F8 (CDROM) : install the caller's ring buffer and clear it. */
extern void StSetRing(u_long *ring_addr, u_long ring_size)
{
    StRingAddr = (int)ring_addr;
    StRingSize = (int)ring_size;
    StClearRing();
}
