/* SimpleMem.obj's exact source-visible type surface: the minimal common-game
 * declarations plus the allocator class owned by this translation unit. */
#ifndef NFS4_GAME_COMMON_SIMPLEMEM_TYPES_H
#define NFS4_GAME_COMMON_SIMPLEMEM_TYPES_H

#include "game_common_min_types.h"

struct SimpleMem {
    void *heap;
    void *freeMem;
    int freeMemSize;

    void *Alloc(int len, int feign);
    void *FeignAlloc(int len);
    void ResizeToFit();
};

#endif
