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
  /* SYM-CODEGEN-CARRIER: scanFrame -- trusted SYM places scan in an AUTO
   * slot at -8 and retail retains a 24-byte leaf frame although all runtime
   * uses are promoted to a0.  This compiler drops scan's home entirely;
   * reserving the equivalent 20-byte local area restores only the retail
   * prologue/epilogue.  Taking &scan in dead source is folded too early;
   * __builtin_alloca adds four unwanted frame-pointer instructions. */
  int scanFrame[5];

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
