/* game/common/fastrand.cpp -- RECONSTRUCTED (NFS4 PSX fast PRNG state init; C++ TU)
 *   2 free fns: FastRandom_CleanUp(void) + FastRandom_StartUp(u_int). GTE-free.
 */
/* ---- fastrand.obj OWNED globals (PRNG state; EXT; SYM Globals.jsonl, $gp+0xbb0..0xbbc) ---- */
unsigned int fastRandom = 0xF874AF01;  /* 0x8013d0fc [$gp+0xbb0] -- retail .sdata init (w63-a19 E5) */
unsigned int randtemp = 0;   /* 0x8013d100 [$gp+0xbb4] */
unsigned int randSeed = 1;   /* 0x8013d104 [$gp+0xbb8] -- retail .sdata init (w63-a19 E5) */
unsigned int numRandCalls = 0;   /* 0x8013d108 [$gp+0xbbc] */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void FastRandom_CleanUp(void);
void FastRandom_StartUp(unsigned int seeder);


/* ---- FastRandom_CleanUp__Fv  [FASTRAND.CPP:13-14] SLD-VERIFIED ---- */
void FastRandom_CleanUp(void)

{
  return;
}

/* ---- FastRandom_StartUp__FUi  [FASTRAND.CPP:18-33] SLD-VERIFIED ---- */
void FastRandom_StartUp(unsigned int seeder)

{
  unsigned int a;
  unsigned int b;
  int seedIterations;
  int i;

  a = 0x75bcd15;
  b = 0x3ade68b1;
  randSeed = a;
  fastRandom = b;
  i = 0;
  seedIterations = (int)(seeder % 500);
  if (0 < seedIterations) {
    do {
      randtemp = fastRandom * 0x75bcd15;
      i = i + 1;
      fastRandom = randtemp & 0xffff;
    } while (i < seedIterations);
  }
  return;
}

/* end of fastrand.cpp */
