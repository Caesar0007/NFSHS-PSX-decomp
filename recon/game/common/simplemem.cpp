/* game/psx/simplemem.cpp -- RECONSTRUCTED (NFS4 PSX SimpleMem allocator class; C++ TU)
 *   3 fns: SimpleMem::Alloc/FeignAlloc/ResizeToFit (explicit-this free-fn forms).
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "simplemem_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void * Alloc(SimpleMem *pThis,int len,int feign);
void * FeignAlloc(SimpleMem *pThis,int len);
void ResizeToFit(SimpleMem *pThis);


/* ---- Alloc  [SIMPLEMEM.CPP:10-40] SLD-VERIFIED ---- */
void * Alloc(SimpleMem *pThis,int len,int feign)

{
  u_int uVar1;
  void *ret;
  
  uVar1 = len + 3U & 0xfffffffc;
  if ((int)uVar1 <= pThis->freeMemSize) {
    ret = pThis->freeMem;
    if (feign == 0) {
      pThis->freeMem = (u_char *)((int)ret + uVar1);
      pThis->freeMemSize = pThis->freeMemSize - uVar1;
    }
    return ret;
  }
  return (void *)0x0;
}

/* ---- FeignAlloc  [SIMPLEMEM.CPP:45-46] SLD-VERIFIED ---- */
void * FeignAlloc(SimpleMem *pThis,int len)

{
  void *pvVar1;
  
  pvVar1 = Alloc(pThis,len,1);
  return pvVar1;
}

/* ---- ResizeToFit  [SIMPLEMEM.CPP:57-64] SLD-VERIFIED ---- */
void ResizeToFit(SimpleMem *pThis)

{
  void *tp1;
  long newSize;
  void *ret;
  
  tp1 = pThis->freeMem;
  pThis->freeMem = (u_char *)0x0;
  resizememadr(pThis->heap,(int)tp1 - (int)pThis->heap);
  return;
}

/* end of simplemem.cpp */
