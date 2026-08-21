/* udff_externs.h -- extern decls for game/psx/udff.cpp (NFS4 PSX UDFF file reader). */
#ifndef UDFF_EXTERNS_H
#define UDFF_EXTERNS_H

/* ---- libc + harvested eaclib ---- */
extern "C" {
char *loadfileadrz(char *name, void *destination);
void *memcpy(void *destination, const void *source, unsigned int size);
int purgememadr(void *ptr);
void *reservememadr(const char *name, int size, int memory_class);
}

#endif
