#include "../../lib/libfns.h"
/* unpack_externs.h -- externs referenced by unpack.cpp
 *   UNPACK.C is the game-side PSX decompression dispatch (GAME/PSX/UNPACK.C).
 *   It forwards to the EA eaclib (EACPSXZ.LIB) codec backends by magic byte. */
#ifndef UNPACK_EXTERNS_H
#define UNPACK_EXTERNS_H

/* This module's own exported fns are UNMANGLED in the SYM (C source compiled here
 * as C++); declare them extern "C" so the definitions keep C linkage and match. */
#ifdef __cplusplus
extern "C" {
#endif
long unpackz(void *src, void *dst);
long unpack(void *src, void *dst);
long unpacksizez(void *src);
long unpacksize(void *src);
#ifdef __cplusplus
}
#endif

/* eaclib EACPSXZ codec backends (EXT symbols; sigs from the call sites + SYM) */
  /* RefPack  0x10FB/0x11FB/0x90FB/0x91FB */
  /* Huffman  0x30FB/0x32FB/0x34FB        */
  /* BTree    0x46FB/0x47FB               */
                     /* read n-byte big-endian field        */

#endif /* UNPACK_EXTERNS_H */
