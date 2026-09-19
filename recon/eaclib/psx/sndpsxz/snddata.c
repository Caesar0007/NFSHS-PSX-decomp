/* eaclib/psx/sndpsxz/snddata.c -- DATA MATERIALIZATION (#75) for the EA PSX audio engine.
 *   NOT original source.  Real initial bytes read from NFS4.EXE (PS-X EXE, t_addr=0x80010000,
 *   file_off = VA - 0x80010000 + 0x800).  This TU DEFINES the audio globals that the eacpsxz code
 *   refers to via `extern`.  Only the INITIALIZED .data/rodata symbols live here; the zero-init
 *   BSS region (sndgs[] @0x80147860, voice table @0x801479f0, DMA queue, mem managers, SPU reg
 *   ptr cache) is materialized separately in sndbss.cpp.
 *
 *   These symbols are each loaded independently in the binary (one lui/lw per symbol, no
 *   cross-symbol offset arithmetic), so they are faithfully reproduced as independent globals.
 */

/* ---- additive PRNG state (srandom.c).  One real six-word object: the oracle materializes
 *      &sndseed once and reaches the five lagged words at fixed +4..+20 displacements. */
extern unsigned int sndseed[6] = {
    0xf22d0e56u, 0x883126e9u, 0xc624dd2fu,
    0x0702c49cu, 0x9e353f7du, 0x6fdf3b64u
};

/* ---- SPU memory/voice limit block (slimits.cpp).  Mutable: SNDsetlimits overwrites.
 *      sndpsxlimits, then the 4 DAT_ words; only DAT_801234e4 (SPU ctx size) is non-zero (0x2000). */
extern int sndpsxlimits  = 0;        /* @0x801234D4 */
extern int DAT_801234d8  = 0;        /* @0x801234D8 */
extern int DAT_801234dc  = 0;        /* @0x801234DC */
extern int DAT_801234e0  = 0;        /* @0x801234E0 */
extern int DAT_801234e4  = 0x2000;   /* @0x801234E4 : default SPU context size */

/* ---- small in-image runtime counters/flags (.data, initial 0; mutated at runtime). */
/* (2026-09-19) the rolling allocation id @0x80136DEC is salloc.obj data and is defined there */
extern char DAT_801371cc = 0;   /* @0x801371CC : rolling key-group counter (stagpat)            */
/* (2026-09-19) the output-caps init-once flag @0x80134A68 is ssysinit.obj data and is defined there */
