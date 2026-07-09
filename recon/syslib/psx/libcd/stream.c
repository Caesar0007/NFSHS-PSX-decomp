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
#define ST_BSS __attribute__((section(".bss")))

int   StFunc1          ST_BSS;   /* @0x80144874 : per-sector "VLC ready" callback   */
int   StFunc2          ST_BSS;   /* @0x80144878 : per-frame "frame ready" callback  */
int   StMode           ST_BSS;   /* @0x801489CC : RGB24/mono streaming flag         */
int   StEmu_Addr       ST_BSS;   /* @0x80146C7C : emulated-stream source (0 = CD)   */
int   StCdIntrFlag     ST_BSS;   /* @0x80146C80 */
int   CChannel         ST_BSS;   /* @0x80146C84 : current channel                   */
int   StCHANNEL        ST_BSS;   /* @0x80146C88 : selected channel                  */
int   Stframe_no       ST_BSS;   /* @0x80146C8C : current frame number              */
int   StRgb24          ST_BSS;   /* @0x80146C90 : RGB24 mode                        */
int   StEndFrame       ST_BSS;   /* @0x80146C94 : last frame to play (0 = endless)  */
int   StSTART_FLAG     ST_BSS;   /* @0x80146C98 : start-frame gating enabled        */
int   StEmu_Idx        ST_BSS;   /* @0x80146C9C : emulated-stream sector index      */
short Stsector_offset  ST_BSS;   /* @0x80146CA0 : sector offset within frame        */
int   StFinalSector    ST_BSS;   /* @0x80146CA4 : final-sector reached flag         */
int   StRingBase       ST_BSS;   /* @0x80146CA8 */
int   StRingAddr       ST_BSS;   /* @0x80146CAC : ring buffer base address          */
int   StRingIdx1       ST_BSS;   /* @0x80146CB0 : write (CD fill) index             */
int   StRingIdx2       ST_BSS;   /* @0x80146CB4 : decode index                      */
int   StRingIdx3       ST_BSS;   /* @0x80146CB8 : read (StGetNext) index            */
int   StRingSize       ST_BSS;   /* @0x80146CBC : ring slot count                   */
int   StStartFrame     ST_BSS;   /* @0x80146CC0 : first frame to play               */
/* (Cdinfo @0x80146CC4 is the CDfs control struct -- owned by cdfs.cpp, not the streaming state.) */


/* ---- peer streaming objects ------------------------------------------------------------------- */
extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame); /* C_010 @0x8010885C */
extern int  init_ring_status(int base, unsigned count);                  /* C_008 @0x80108758 */

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

/* @0x800F8968 (C_002) : reset the ring (indices, flags, per-slot status). */
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

/* @0x800F99F8 (CDROM) : install the caller's ring buffer and clear it. */
extern void StSetRing(u_long *ring_addr, u_long ring_size)
{
    StRingAddr = (int)ring_addr;
    StRingSize = (int)ring_size;
    StClearRing();
}
