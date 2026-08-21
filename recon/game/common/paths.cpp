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
  char *frontPath;
  char **pathTable;
  int deadfrm[5];  /* MATCH: unused frame filler — SYM shows scan as class AUTO @-8 (0x18 frame in the oracle); 20 dead bytes reproduce it */

  scan = burnPath;
  dirCounter = 0x31;
  do {
    Paths_Paths[dirCounter] = scan;
    dirCounter = dirCounter + -1;
  } while (-1 < dirCounter);
  pathTable = Paths_Paths;
  frontPath = fePath;
  pathTable[0x24] = frontPath;
  pathTable[0x20] = frontPath;
  return;
}

/* end of paths.cpp */
