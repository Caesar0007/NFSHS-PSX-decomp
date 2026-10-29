/* game/common/paths.cpp -- RECONSTRUCTED (NFS4 path/directory-prefix table init; game-c TU)
 *   1 fn: Paths_StartUp -- fills Paths_Paths[0..0x31] with burnPath, then sets [0x24]/[0x20] = fePath.
 *   Owns globals Paths_Paths[50] + Paths_File (EXT, referenced by FE modules).
 */
#include "game_common_min_types.h"

/* EXT data owned by paths.obj.  SYM records burnPath/fePath as actual arrays,
   not standalone character aliases.  Definition order is the retail .sdata
   order at 0x8013D2E0..0x8013D2EC. */
char *Paths_Paths[50];   /* @0x80116468 */
char burnPath[2] = "z"; /* @0x8013d2e0 */
char fePath[1] = "";    /* @0x8013d2e4 */
char *Paths_File;        /* @0x8013d2e8 */


/* ---- Paths_StartUp  [PATHS.CPP:47-101] SLD-VERIFIED ---- */
void Paths_StartUp(void)

{
  int dirCounter;
  char *scan;
  /* SOURCE-REVIEW-UNRESOLVED: scanFrame has NO supplied retail declaration.
   * This padding array is not original-source recovery or an exemption.
   * Retail scan is AUTO:sp-8, before dirCounter; ours is incorrectly REG:$4.
   * Matched NFS2 paths/Paths_StartUp.c passes &scan to its real file parser.
   * That grounds addressability, NOT this array or a dormant NFS4 parser.
   * Recover the actual stack-home/frame producer and remove scanFrame;
   * do not add a dead parser call, fake address use or replacement padding.
   * Earlier dead-address/alloca/debug controls do not prove object necessity.
   * Evidence:build/nc12/carrier_review_followup_20261029/final-proof.json. */
  int scanFrame[5];
  /* retail paths.obj owns an UNREFERENCED literal "install.psx" (0x80056100, between object.obj's and PauseMenu.obj's
   * read-only data = paths.obj's slot in link order) and Paths_File stays null: the install-file branch of the original
   * (SLD lines 47-101 cover far more source than the surviving loop) was compiled out, leaving only its string. */
  if (0) Paths_File = "install.psx";

  scan = burnPath;
  dirCounter = 0x31;
  do {
    Paths_Paths[dirCounter] = scan;
    dirCounter = dirCounter + -1;
  } while (-1 < dirCounter);
  Paths_Paths[0x24] = fePath;
  Paths_Paths[0x20] = fePath;
  return;
}

/* end of paths.cpp */
