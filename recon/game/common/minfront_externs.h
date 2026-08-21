/* minfront_externs.h */
#ifndef MINFRONT_EXTERNS_H
#define MINFRONT_EXTERNS_H
extern char bigBuf[];
extern "C" void *reservememadr(char *name, int size, int alignment);
extern "C" void resizememadr(void *mem, int size);
#endif
