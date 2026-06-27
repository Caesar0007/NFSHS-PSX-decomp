/* game/psx/audio.cpp -- RECONSTRUCTED (NFS4 PSX sound driver init + bank load; C++ TU)
 *   6 fns: Audio_InitDriver/DeInitDriver/CleanUp/FECleanUp, AudioCmn_AddBank/LoadBank.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "audio_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int Audio_direct3davail;
void *Audio_gHeap;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Audio_InitDriver(int buffersize,int spusize);
void Audio_DeInitDriver(void);
void Audio_CleanUp(void);
void Audio_FECleanUp(void);
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum);
int AudioCmn_LoadBank(char *filename,int BankNum);


/* ---- Audio_InitDriver__Fii  [AUDIO.CPP:58-78] SLD-VERIFIED ---- */
void Audio_InitDriver(int buffersize,int spusize)

{
  SndBnk_t *pSVar1;
  int i;
  SNDSYSOPTS opts;
  
  i = 0;
  pSVar1 = gSndBnk;
  do {
    pSVar1->bnkID = i;
    pSVar1->pdata = (char *)0x0;
    i = i + 1;
    pSVar1 = pSVar1 + 1;
  } while (i < 7);
  if ((AudioCmn_kAudioOn != 0) || (AudioCmn_kAudioStreamingOn != 0)) {
    SNDSYS_getopts(&opts);
    opts.set.maxbanks = 0x30;
    SNDSYS_setopts(&opts);
    SNDSYS_vectortoreal();
    Audio_gHeap = reservememadr("audio heap",0x1000,0);
    SNDSYS_init(Audio_gHeap,0x1000);
    AudioCmn_InitReverb();
  }
  if (0 < buffersize) {
    AudioMus_SysStartUp(buffersize,spusize,"amus");
  }
  Audio_direct3davail = 0;
  return;
}

/* ---- Audio_DeInitDriver__Fv  [AUDIO.CPP:84-91] SLD-VERIFIED ---- */
void Audio_DeInitDriver(void)

{
  
  AudioMus_SysCleanUp();
  if ((AudioCmn_kAudioOn != 0) || (AudioCmn_kAudioStreamingOn != 0)) {
    SNDSYS_restore();
    purgememadr(Audio_gHeap);
  }
  return;
}

/* ---- Audio_CleanUp__Fv  [AUDIO.CPP:133-144] SLD-VERIFIED ---- */
void Audio_CleanUp(void)

{
  int iVar1;

  iVar1 = 0;
  do {
    if (gSndBnk[iVar1].pdata != (char *)0x0) {
      purgememadr(gSndBnk[iVar1].pdata);
      gSndBnk[iVar1].pdata = (char *)0x0;
    }
    iVar1 = iVar1 + 1;
  } while (iVar1 < 7);
  return;
}

/* ---- Audio_FECleanUp__Fv  [AUDIO.CPP:151-158] SLD-VERIFIED ---- */
void Audio_FECleanUp(void)

{
  SNDbankremove(-1);
  if (gSndBnk[0].pdata != (char *)0x0) {
    purgememadr(gSndBnk[0].pdata);
    gSndBnk[0].pdata = (char *)0x0;
  }
  return;
}

/* ---- AudioCmn_AddBank__FPciT0i  [AUDIO.CPP:167-213] SLD-VERIFIED ---- */
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum)

{
  char cVar1;
  int iVar2;
  char *p;
  int check;
  char *pool_name;
  char *ptemp;
  char *destBuf;
  int bhandle;
  
  bhandle = -1;
  destBuf = (char *)0x0;
  pool_name = filename;
  if (*filename != '\0') {
    cVar1 = *filename;
    do {
      if (cVar1 == '\\') {
        pool_name = filename + 1;
      }
      filename = filename + 1;
      cVar1 = *filename;
    } while (cVar1 != '\0');
  }
  iVar2 = SNDbankadd(&bhandle,pdata);
  if (iVar2 == 7) {
    iVar2 = SNDbankheadersize(bhandle);
    destBuf = reservememadr(pool_name,iVar2,0);
    SNDbankheadercopy(destBuf,bhandle);
    iVar2 = SNDbankheadersize(bhandle);
    size = size - iVar2;
  }
  else {
    AudioClc_SndError(iVar2);
  }
  purgememadr(pdata);
  gSndBnk[BankNum].pdata = destBuf;
  gSndBnk[BankNum].bnkID = bhandle;
  return size;
}

/* ---- AudioCmn_LoadBank__FPci  [AUDIO.CPP:217-230] SLD-VERIFIED ---- */
int AudioCmn_LoadBank(char *filename,int BankNum)

{
  char *pdata_00;
  int iVar1;
  char bankdata [80];

  strcpy(bankdata,filename);
  strcat(bankdata,".bnk");
  pdata_00 = (char *)loadfileadrz(bankdata,(void *)0x10);
  if (pdata_00 == (char *)0x0) {
    return 0;
  }
  iVar1 = filesize(bankdata);
  return AudioCmn_AddBank(filename,iVar1,pdata_00,BankNum);
}

/* end of audio.cpp */
