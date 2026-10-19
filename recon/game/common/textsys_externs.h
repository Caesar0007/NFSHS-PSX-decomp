/* textsys_externs.h -- extern decls for game/psx/textsys.cpp (NFS4 PSX text/word system). */
#ifndef TEXTSYS_EXTERNS_H
#define TEXTSYS_EXTERNS_H

/* ---- libc + harvested + SYM ---- */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
}
extern "C" {
int sprintf(char *buffer, const char *format, ...);
}

extern char       *Paths_Paths[];

extern char *wordFile;            /* word-data blob (char*) */
extern char *langFileName[6];     /* per-language filenames (dims 1 6) */

#endif
