/* SimpleMem.obj's exact source-visible type surface: the minimal common-game
 * declarations plus the allocator class owned by this translation unit. */
#ifndef NFS4_GAME_COMMON_SIMPLEMEM_TYPES_H
#define NFS4_GAME_COMMON_SIMPLEMEM_TYPES_H

#include "game_common_min_types.h"

/* Canonical EAC memory API used by SimpleMem's inline allocation helpers. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
}

struct SimpleMem {
    void *heap;
    void *freeMem;
    int freeMemSize;

    /* Track_Init's inline size tuple and raw allocation recover this ctor.
     * The constant allocation-label formal's spelling is inferred; no default
     * label/overload or original identity for the separate string holder is
     * asserted. Source/native receipt: simplemem_ctor_restore_20261023. */
    SimpleMem(int size, char *label)
    {
        heap = reservememadr(label,size,0);
        freeMem = heap;
        if (heap == 0) size = 0;
        freeMemSize = size;
    }

    void *Alloc(int len, int feign);
    void *FeignAlloc(int len);
    void ResizeToFit();
    /* Inline in the original allocator class: Track_DeInit's `delete
       Track_mem` expands to this exact heap cleanup before object deletion. */
    ~SimpleMem() { purgememadr(heap); freeMem = (void *)0x0; }
};

#endif
