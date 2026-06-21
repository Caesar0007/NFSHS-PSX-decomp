#include "../../lib/libfns.h"
/* unpack_externs.h -- externs referenced by unpack.cpp
 *   UNPACK.C is the game-side PSX decompression dispatch (GAME/PSX/UNPACK.C).
 *   It forwards to the EA eaclib (EACPSXZ.LIB) codec backends by magic byte. */
#ifndef UNPACK_EXTERNS_H
#define UNPACK_EXTERNS_H

/* eaclib EACPSXZ codec backends (EXT symbols; sigs from the call sites + SYM) */
  /* RefPack  0x10FB/0x11FB/0x90FB/0x91FB */
  /* Huffman  0x30FB/0x32FB/0x34FB        */
  /* BTree    0x46FB/0x47FB               */
                     /* read n-byte big-endian field        */

#endif /* UNPACK_EXTERNS_H */
