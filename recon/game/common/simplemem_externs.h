/* simplemem_externs.h -- extern decls for game/psx/simplemem.cpp (NFS4 PSX SimpleMem allocator). */
#ifndef SIMPLEMEM_EXTERNS_H
#define SIMPLEMEM_EXTERNS_H

/* Exact resize.h entry-point type only. The allocator owner does not use
 * eac_types.h's transform structures, which are absent from its retail type
 * surface. Source/native receipt: simplemem_ctor_restore_20261023. */
extern "C" {
void *resizememadr(void *userptr, int newsize);
}

#endif
