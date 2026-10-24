/* game/common/simplemem.cpp -- RECONSTRUCTED (NFS4 PSX SimpleMem allocator class; C++ TU)
 *   3 SimpleMem methods [Alloc, FeignAlloc, ResizeToFit] as real members -> oracle
 *   method mangling __9SimpleMem...; this lands in $a0 like the old explicit pThis. GTE-free.
 */
#include "simplemem_types.h"
#include "simplemem_externs.h"

/* Unreferenced "SimpleMem" literal verified [@0x800565C0]; producer unknown.
 * SourceRecoveryUnresolved: the holder below is a reconstruction placeholder,
 * not proof of an original class-name method, macro or constructor default. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- Alloc__9SimpleMemii [@0x800b7250] covered SLD requires native comparison ---- */
#line 9 "C:/nfs4/GAME/COMMON/SIMPLEMEM.CPP"
void * SimpleMem::Alloc(int len,int feign)
{
  void *ret;



  len = len + 3;
  len = len & ~3;

  if (this->freeMemSize < len) {

    return (void *)0x0;
  }




  ret = this->freeMem;


  if (feign == 0) {

    this->freeMem = (u_char *)((int)ret + len);
    this->freeMemSize = this->freeMemSize - len;
  }






  return ret;
}

/* ---- FeignAlloc__9SimpleMemi [@0x800b729c] covered SLD requires native comparison ---- */
#line 44 "C:/nfs4/GAME/COMMON/SIMPLEMEM.CPP"
void * SimpleMem::FeignAlloc(int len)
{
  return this->Alloc(len,1);
}

/* ---- ResizeToFit__9SimpleMem [@0x800b72bc] covered SLD requires native comparison ---- */
#line 56 "C:/nfs4/GAME/COMMON/SIMPLEMEM.CPP"
void SimpleMem::ResizeToFit()
{
  long newSize = (int)this->freeMem;
  newSize -= (int)this->heap;



  this->freeMem = (u_char *)0x0;
  resizememadr(this->heap,newSize);
}
