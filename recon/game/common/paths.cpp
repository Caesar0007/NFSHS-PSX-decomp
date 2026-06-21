/* game/common/paths.cpp -- RECONSTRUCTED (NFS4 path/directory-prefix table init; game-c TU)
 *   1 fn: Paths_StartUp -- fills Paths_Paths[0..0x31] with "z" then clears [0x24]/[0x20].
 *   Owns globals Paths_Paths[50] + Paths_File (EXT, referenced by FE modules).
 */
#include "../../nfs4_types.h"

/* EXT data owned by paths.obj */
char *Paths_Paths[50];   /* @0x80116468 */
char *Paths_File;        /* @0x8013d2e8 */


/* ---- Paths_StartUp  [PATHS.CPP:47-101] SLD-VERIFIED ---- */
void Paths_StartUp(void)

{
  int dirCounter;
  char *scan;

  scan = "z";
  dirCounter = 0x31;
  do {
    Paths_Paths[dirCounter] = scan;
    dirCounter = dirCounter + -1;
  } while (-1 < dirCounter);
  Paths_Paths[0x24] = "";
  Paths_Paths[0x20] = "";
  return;
}

/* end of paths.cpp */
