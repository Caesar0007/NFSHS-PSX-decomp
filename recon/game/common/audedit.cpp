/* game/common/audedit.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained. Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++. */
#define NFS4_TU_AUDEDIT   /* owner key: CAudioList keep retail's C-style typedef form (2nd TPDEF at the definition) */
/* (INV-A3) NFS4_EAC_MATRIXTDEF_CXX_ALIAS dropped: the 2nd matrixtdef TPDEF is the ObjectFinishedSignAnim ctor field walk */
#include "audedit_types.h"
#include "audedit_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x800557DC): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- audedit.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
CAudioList   *gGameAudioList;   /* @0x8013c730  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AudList_PurgeAudio(void);
void AudList_LoadAudioFile(int AudioFileIndex);


/* ---- AudList_PurgeAudio__Fv  [@0x8007b52c] ---- */

#line 1141 "C:/nfs4/GAME/COMMON/AUDEDIT.CPP"
void AudList_PurgeAudio(void)
{
  if (gGameAudioList != (CAudioList *)0x0) {
    purgememadr(gGameAudioList); }
}

/* ---- AudList_LoadAudioFile__Fi  [@0x8007b554] ---- */
/* Raw calls: Track_MakeTrackPathName("") @0x8007B568, then
 * sprintf(fname,"%s%02d.aud",path,AudioFileIndex) @0x8007B580.
 * Both varargs were once missing in the reconstruction (H40). */

#line 1147 "C:/nfs4/GAME/COMMON/AUDEDIT.CPP"
void AudList_LoadAudioFile(int AudioFileIndex)
{
  char fname [128];


  sprintf(fname,"%s%02d.aud",Track_MakeTrackPathName(""),AudioFileIndex);











  gGameAudioList = (CAudioList *)loadfileadrz(fname,(void *)0x0); return;
}
