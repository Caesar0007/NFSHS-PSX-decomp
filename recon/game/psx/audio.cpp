/* game/psx/audio.cpp -- RECONSTRUCTED (NFS4 PSX sound driver init + bank load; C++ TU)
 *   6 fns: Audio_InitDriver/DeInitDriver/CleanUp/FECleanUp, AudioCmn_AddBank/LoadBank.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "audio_externs.h"

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
  int memReserve;
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
    memReserve = 0;
    Audio_gHeap = reservememadr("audio heap",0x1000,0);
    SNDSYS_init(Audio_gHeap,0x1000,memReserve);
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
  SndBnk_t *pSVar1;
  int i;
  int iVar2;
  
  iVar2 = 0;
  pSVar1 = gSndBnk;
  do {
    if (pSVar1->pdata != (char *)0x0) {
      purgememadr(pSVar1->pdata);
      pSVar1->pdata = (char *)0x0;
    }
    iVar2 = iVar2 + 1;
    pSVar1 = pSVar1 + 1;
  } while (iVar2 < 7);
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
  char *p;
  char *pdata;
  char bankdata [80];
  
  strcpy(bankdata,filename);
  strcat(bankdata,".bnk");
  pdata_00 = (char *)loadfileadrz(bankdata,(void *)0x10);
  iVar1 = 0;
  if (pdata_00 != (char *)0x0) {
    iVar1 = filesize(bankdata);
    iVar1 = AudioCmn_AddBank(filename,iVar1,pdata_00,BankNum);
  }
  return iVar1;
}

/* end of audio.cpp */
