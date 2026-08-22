/* game/psx/audio.cpp -- RECONSTRUCTED (NFS4 PSX sound driver init + bank load; C++ TU)
 *   6 fns: Audio_InitDriver/DeInitDriver/CleanUp/FECleanUp, AudioCmn_AddBank/LoadBank.
 *   GTE-free. Full SYM-locals applied.
 */
#include "audio_types.h"
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
  int i;
  SNDSYSOPTS opts;

  i = 0;
  do {
    Audio_gSndBnkWords[i][0] = i;
    Audio_gSndBnkWords[i][2] = 0;
    i = i + 1;
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
  int i;

  i = 0;
  do {
    if (Audio_gSndBnkWords[i][2] != 0) {
      purgememadr((char *)Audio_gSndBnkWords[i][2]);
      Audio_gSndBnkWords[i][2] = 0;
    }
    i = i + 1;
  } while (i < 7);
  return;
}

/* ---- Audio_FECleanUp__Fv  [AUDIO.CPP:151-158] SLD-VERIFIED ---- */
void Audio_FECleanUp(void)

{
  SNDbankremove(-1);
  if (Audio_gSndBnkWords[0][2] != 0) {
    purgememadr((char *)Audio_gSndBnkWords[0][2]);
    Audio_gSndBnkWords[0][2] = 0;
  }
  return;
}

/* ---- AudioCmn_AddBank__FPciT0i  [AUDIO.CPP:167-213] SLD-VERIFIED ---- */
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum)

{
  int check;
  char *ptemp;
  char *p;
  int bhandle;

  ptemp = filename;
  bhandle = -1;
  p = (char *)0x0;
  /* MATCH: the original mutates the filename PARAM in place as the pool name (param home
     reg s0) and walks a FRESH temp (ptemp, v1) -- not the inverse. WHILE loop (not
     if+do-while: the rotated guard re-loads *ptemp in the preheader = the oracle's double
     load). destBuf=0 BEFORE the loop so the loop join blocks cse reusing s1 as the zero
     arg of reservememadr (oracle: addu a2,zero,zero). */
  while (*ptemp != '\0') {
    if (*ptemp == '\\') {
      filename = ptemp + 1;
    }
    ptemp = ptemp + 1;
  }
  check = SNDbankadd(&bhandle,pdata);
  if (check == 7) {
    check = SNDbankheadersize(bhandle);
    p = reservememadr(filename,check,0);
    SNDbankheadercopy(p,bhandle);
    check = SNDbankheadersize(bhandle);
    size = size - check;
  }
  else {
    AudioClc_SndError(check);
  }
  purgememadr(pdata);
  Audio_gSndBnkWords[BankNum][2] = (int)p;
  Audio_gSndBnkWords[BankNum][0] = bhandle;
  return size;
}

/* ---- AudioCmn_LoadBank__FPci  [AUDIO.CPP:217-230] SLD-VERIFIED ---- */
int AudioCmn_LoadBank(char *filename,int BankNum)

{
  char *pdata;
  int iVar1;
  char bankdata [80];

  strcpy(bankdata,filename);
  strcat(bankdata,".bnk");
  pdata = (char *)loadfileadrz(bankdata,(void *)0x10);
  if (pdata == (char *)0x0) {
    return 0;
  }
  iVar1 = filesize(bankdata);
  return AudioCmn_AddBank(filename,iVar1,pdata,BankNum);
}

/* end of audio.cpp */
