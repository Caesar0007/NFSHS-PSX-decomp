/* game/common/fastrand.cpp -- RECONSTRUCTED (NFS4 PSX fast PRNG state init; C++ TU)
 *   2 free fns: FastRandom_CleanUp(void) + FastRandom_StartUp(u_int). GTE-free.
 */
#include "../../nfs4_types.h"
#include "fastrand_externs.h"

/* ---- fastrand.obj OWNED globals (PRNG state; EXT; SYM Globals.jsonl, $gp+0xbb0..0xbbc) ---- */
u_int fastRandom;     /* 0x8013d0fc [$gp+0xbb0] */
u_int randtemp;       /* 0x8013d100 [$gp+0xbb4] */
u_int randSeed;       /* 0x8013d104 [$gp+0xbb8] */
u_int numRandCalls;   /* 0x8013d108 [$gp+0xbbc] */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void FastRandom_CleanUp(void);
void FastRandom_StartUp(u_int seeder);


/* ---- FastRandom_CleanUp__Fv  [FASTRAND.CPP:13-14] SLD-VERIFIED ---- */
void FastRandom_CleanUp(void)

{
  return;
}

/* ---- FastRandom_StartUp__FUi  [FASTRAND.CPP:18-33] SLD-VERIFIED ---- */
void FastRandom_StartUp(u_int seeder)

{
  int seedIterations;
  int iVar1;

  randSeed = 0x75bcd15;
  fastRandom = 0x3ade68b1;
  iVar1 = 0;
  seedIterations = (int)(seeder % 500);
  if (0 < seedIterations) {
    do {
      randtemp = fastRandom * 0x75bcd15;
      iVar1 = iVar1 + 1;
      fastRandom = randtemp & 0xffff;
    } while (iVar1 < seedIterations);
  }
  return;
}

/* end of fastrand.cpp */
