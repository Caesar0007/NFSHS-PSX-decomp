/* game/psx/audio.cpp -- USA regional reconstruction */
#include "audio_types.h"
#include "audio_externs.h"

int Audio_direct3davail;
void *Audio_gHeap;
extern "C" int RDAT_8013D968;

void Audio_InitDriver(int buffersize,int spusize);
void Audio_DeInitDriver(void);
void Audio_CleanUp(void);
void Audio_FECleanUp(void);
int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum);
int AudioCmn_LoadBank(char *filename,int BankNum);

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
    if (RDAT_8013D968 == 0) {
      opts.set.outputchannels = 1;
    }
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
}

void Audio_DeInitDriver(void)
{
  AudioMus_SysCleanUp();
  if ((AudioCmn_kAudioOn != 0) || (AudioCmn_kAudioStreamingOn != 0)) {
    SNDSYS_restore();
    purgememadr(Audio_gHeap);
  }
}

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
}

void Audio_FECleanUp(void)
{
  SNDbankremove(-1);
  if (Audio_gSndBnkWords[0][2] != 0) {
    purgememadr((char *)Audio_gSndBnkWords[0][2]);
    Audio_gSndBnkWords[0][2] = 0;
  }
}

int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum)
{
  int check;
  char *ptemp;
  char *p;
  int bhandle;

  ptemp = filename;
  bhandle = -1;
  p = (char *)0x0;
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

int AudioCmn_LoadBank(char *filename,int BankNum)
{
  char *pdata;
  char bankdata [80];

  strcpy(bankdata,filename);
  strcat(bankdata,".bnk");
  pdata = (char *)loadfileadrz(bankdata,(void *)0x10);
  if (pdata == (char *)0x0) {
    return 0;
  }
  return AudioCmn_AddBank(filename,filesize(bankdata),pdata,BankNum);
}
