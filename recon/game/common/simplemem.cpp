/* game/psx/simplemem.cpp -- RECONSTRUCTED (NFS4 PSX SimpleMem allocator class; C++ TU)
 *   3 SimpleMem methods [Alloc, FeignAlloc, ResizeToFit] as real members -> oracle
 *   method mangling __9SimpleMem...; this lands in $a0 like the old explicit pThis. GTE-free.
 */
#include "../../nfs4_types.h"
#include "simplemem_externs.h"


/* ---- Alloc__9SimpleMemii  [SIMPLEMEM.CPP:10-40] SLD-VERIFIED ---- */
void * SimpleMem::Alloc(int len,int feign)
{
  void *ret;

  len = (len + 3) & ~3;
  if (len <= this->freeMemSize) {
    ret = this->freeMem;
    if (feign == 0) {
      this->freeMem = (u_char *)((int)ret + len);
      this->freeMemSize = this->freeMemSize - len;
    }
    return ret;
  }
  return (void *)0x0;
}

/* ---- FeignAlloc__9SimpleMemi  [SIMPLEMEM.CPP:45-46] SLD-VERIFIED ---- */
void * SimpleMem::FeignAlloc(int len)
{
  void *pvVar1;

  pvVar1 = this->Alloc(len,1);
  return pvVar1;
}

/* ---- ResizeToFit__9SimpleMem  [SIMPLEMEM.CPP:57-64] SLD-VERIFIED ---- */
void SimpleMem::ResizeToFit()
{
  void *tp1;
  long newSize;
  void *ret;

  tp1 = this->freeMem;
  this->freeMem = (u_char *)0x0;
  resizememadr(this->heap,(int)tp1 - (int)this->heap);
  return;
}

/* end of simplemem.cpp */
