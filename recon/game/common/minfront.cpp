/* frontend/common/fecars.cpp -- RECONSTRUCTED (NFS4 car manager + list iterators; C++ TU)
 *   46 fns across 3 classes: tCarManager (32; garage/stock/pinkslip car economy + save/load),
 *   tListIteratorCar (8; :tListIterator), tListIteratorCarColor (6; :tListIterator).
 *   Member defs; base ctors via init-lists; manual _vf vtable for the iterator virtuals.
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
