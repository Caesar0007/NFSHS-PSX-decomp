/* textsys_externs.h -- extern decls for game/psx/textsys.cpp (NFS4 PSX text/word system). */
#ifndef TEXTSYS_EXTERNS_H
#define TEXTSYS_EXTERNS_H

/* ---- libc + harvested + SYM ---- */
extern "C" {
int sprintf(char *buffer, const char *format, ...);
void *loadfileadr(char *filename, int memory_class);
int purgememadr(void *ptr);
}

extern char       *Paths_Paths[];

extern char *wordFile;            /* word-data blob (char*) */
extern char *langFileName[6];     /* per-language filenames (dims 1 6) */

#endif
