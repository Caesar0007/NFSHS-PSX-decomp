/* game/psx/udff.cpp -- RECONSTRUCTED (NFS4 PSX UDFF file reader; C++ TU)
 *   4 fns: Udff_Opena, Udff_Close, Udff_GetInt, Udff_GetBuffer.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "udff_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag);
void Udff_Close(Udff_tInfo *handle);
int Udff_GetInt(Udff_tInfo *handle);
void Udff_GetBuffer(Udff_tInfo *handle,char *mem,int size);


/* ---- Udff_Opena__FPcT0i  [UDFF.CPP:21-76] SLD-VERIFIED ---- */
Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag)

{
  Udff_tInfo *addr;
  char *pcVar1;
  Udff_tInfo *newHandle;
  
  addr = reservememadr("udffhandle",0xc,0x10);
  if (addr != (Udff_tInfo *)0x0) {
    if (name == (char *)0x0) {
      if (mem != (char *)0x0) {
        addr->type = UDFF_MEMORY;
        addr->handle = 0;
        addr->memPtr = mem;
        return addr;
      }
    }
    else if (mem == (char *)0x0) {
      addr->type = UDFF_FILE;
      pcVar1 = (char *)loadfileadrz(name,(void *)0x0);
      addr->memPtr = pcVar1;
      addr->handle = (int)pcVar1;
      if (pcVar1 != (char *)0x0) {
        return addr;
      }
      purgememadr(addr);
      return (Udff_tInfo *)0x0;
    }
    if (addr != (Udff_tInfo *)0x0) {
      purgememadr(addr);
    }
  }
  return (Udff_tInfo *)0x0;
}

/* ---- Udff_Close__FP10Udff_tInfo  [UDFF.CPP:84-100] SLD-VERIFIED ---- */
void Udff_Close(Udff_tInfo *handle)

{
  
  if (handle != (Udff_tInfo *)0x0) {
    if ((handle->type == UDFF_FILE) && ((void *)handle->handle != (void *)0x0)) {
      purgememadr((void *)handle->handle);
    }
    purgememadr(handle);
  }
  return;
}

/* ---- Udff_GetInt__FP10Udff_tInfo  [UDFF.CPP:105-123] SLD-VERIFIED ---- */
int Udff_GetInt(Udff_tInfo *handle)

{
  int value;
  int iVar1;
  
  iVar1 = *(int *)handle->memPtr;
  handle->memPtr = (char *)((int)handle->memPtr + 4);
  return iVar1;
}

/* ---- Udff_GetBuffer__FP10Udff_tInfoPci  [UDFF.CPP:203-218] SLD-VERIFIED ---- */
void Udff_GetBuffer(Udff_tInfo *handle,char *mem,int size)

{
  int value;
  
  memcpy(mem,handle->memPtr,size);
  handle->memPtr = handle->memPtr + size;
  return;
}

/* end of udff.cpp */
