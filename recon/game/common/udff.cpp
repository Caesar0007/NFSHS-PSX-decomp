/* game/psx/udff.cpp -- RECONSTRUCTED (NFS4 PSX UDFF file reader; C++ TU)
 *   4 fns: Udff_Opena, Udff_Close, Udff_GetInt, Udff_GetBuffer.
 *   GTE-free. Full SYM-locals applied.
 */
#include "udff_types.h"
#include "udff_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag);
void Udff_Close(Udff_tInfo *handle);
int Udff_GetInt(Udff_tInfo *handle);
void Udff_GetBuffer(Udff_tInfo *handle,char *mem,int size);


/* ---- Udff_Opena__FPcT0i  [UDFF.CPP:21-76] SLD-VERIFIED ---- */
Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag)

{
  /* MATCH: SYM has one real local (`newHandle` in $s0).  The source-level
     labels preserve retail's distinct invalid-argument/file-load purge paths
     and shared success return without reconstructed assembly. */
  Udff_tInfo *newHandle;

  newHandle = reservememadr("udffhandle",0xc,0x10);
  if (newHandle == (Udff_tInfo *)0x0) {
    return (Udff_tInfo *)0x0;
  }
  if (name != (char *)0x0) {
    goto haveName;
  }
  if (mem == (char *)0x0) {
    goto purge;
  }
  newHandle->type = UDFF_MEMORY;
  goto memoryHandle;

haveName:
  if (mem == (char *)0x0) {
    goto fileHandle;
  }

purge:
  if (newHandle != (Udff_tInfo *)0x0) {
    purgememadr(newHandle);
  }
  return (Udff_tInfo *)0x0;

memoryHandle:
  newHandle->handle = 0;
  newHandle->memPtr = mem;
  goto success;

fileHandle:
  newHandle->type = UDFF_FILE;
  newHandle->memPtr = (char *)loadfileadrz(name,(void *)0x0);
  newHandle->handle = (int)newHandle->memPtr;
  if (newHandle->memPtr != (char *)0x0) {
    goto success;
  }
  purgememadr(newHandle);
  return (Udff_tInfo *)0x0;

success:
  return newHandle;
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
  
  value = *(int *)handle->memPtr;
  handle->memPtr = (char *)((int)handle->memPtr + 4);
  return value;
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
