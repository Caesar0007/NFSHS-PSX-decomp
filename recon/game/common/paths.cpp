/* game/common/paths.cpp -- RECONSTRUCTED (NFS4 path/directory-prefix table init; game-c TU)
 *   1 fn: Paths_StartUp -- fills Paths_Paths[0..0x31] with burnPath, then sets [0x24]/[0x20] = fePath.
 *   Owns globals Paths_Paths[50] + Paths_File (EXT, referenced by FE modules).
 */
#include "../../nfs4_types.h"

/* EXT data owned by paths.obj */
char *Paths_Paths[50];   /* @0x80116468 */
char *Paths_File;        /* @0x8013d2e8 */
extern char burnPath[];  /* @0x8013d2e0 .sdata  .asciz "z"  */
extern char fePath[];    /* @0x8013d2e4 .sdata  "" (4 zero bytes) */


/* ---- Paths_StartUp  [PATHS.CPP:47-101] SLD-VERIFIED ---- */
void Paths_StartUp(void)

{
  int dirCounter;
  char *scan;
  int deadfrm[5];  /* MATCH: unused frame filler — SYM shows scan as class AUTO @-8 (0x18 frame in the oracle); 20 dead bytes reproduce it */

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
