/* udff_externs.h -- extern decls for game/psx/udff.cpp (NFS4 PSX UDFF file reader). */
#ifndef UDFF_EXTERNS_H
#define UDFF_EXTERNS_H

/* ---- libc + harvested eaclib ---- */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
}
extern "C" {
void *memcpy(void *destination, const void *source, unsigned int size);
}

#endif
