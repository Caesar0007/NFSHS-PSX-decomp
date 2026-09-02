/* game/common/minfront.cpp -- RECONSTRUCTED (src C:\nfs4\GAME\COMMON\MINFRONT.CPP; MinFront.obj).
 *   SINGLE-FUNCTION TU: MinFront_ParseOptions__Fv @0x800128f0 is the only .text symbol the
 *   SYM attributes to MinFront.obj (its FILE block holds exactly one `8c Function start`;
 *   everything else in the block is type metadata).  The minimal front-end option-stream
 *   allocator: reserves a 0x2000 scratch block out of bigBuf+0xc, writes a 0-terminator and
 *   shrinks the reservation to the 4 bytes actually used.
 *
 *   SYM-EXACT (W86-S6 audit, methodology sec 0 rule 8 / sec 3.8b):
 *     ret     FCN PTR INT          -> `int *`
 *     params  (none; __Fv)
 *     locals  1 x `94 Def class REG type PTR INT name stream` at $00000010 = $s0,
 *             in the function's single `90 Block start line = 1` block
 *     frame   fsize 24, retreg 31, mask $80010000 (ra + s0), maskoffs -4
 *     SLD     lines 781-805 of MINFRONT.CPP
 *   No AUTO/ARG/STAT records exist, so there is nothing else to name.
 *
 *   (The previous header here was a copy-paste of frontend/common/fecars.cpp's banner and
 *   described a 46-function car-manager TU that has never lived in this file.)
 */
#include "minfront.h"


/* ---- MinFront_ParseOptions  [MINFRONT.CPP:781-805] SLD-VERIFIED ---- */

int * MinFront_ParseOptions(void)

{
  int *stream;
  
  stream = reservememadr((char *)(bigBuf + 0xc),0x2000,0x10);
  *stream = 0;
  resizememadr(stream,4);
  return stream;
}



/* end of minfront.cpp */
