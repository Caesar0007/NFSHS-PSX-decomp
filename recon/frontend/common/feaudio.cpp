/* frontend/common/feaudio.cpp -- RECONSTRUCTED (NFS4 front-end audio / commentary; C++ TU)
 *   10 free Feaudio_* fns (commentary VIV streaming, speech levels, language select).
 */
#include "feaudio.h"

/* ---- Feaudio.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero) ---- */
int          gStopCommentaryNow;   /* @0x800514c8  (bss(zero)) */
char         gCurrentVIV = -1;   /* @0x800514cc */
char *allLanguages[6] = {"zEngl","zGerm","zFren","zSpan","zItal","zSwed"};   /* @0x800514d0 .rodata prefixes */
SPEECHINFO   ginfo;   /* @0x800514e8  (bss(zero)) */
/* speechfileHeader declared (unsized-array form) in feaudio_externs.h; accessed [0] so the value-load
   into an arg reg is non-gp + separate v0 scratch (matches oracle lui v0; lw a0,(v0)); §3.15-CORRECTION */
char         currentSpeechViv[40];   /* @0x80051510  (bss(zero)) */
int          commentaryActualLevel;   /* @0x80051538  (bss(zero)) */


/* ---- FEAudio_StartLoadPatch  [FEAUDIO.CPP:43-64] SLD-VERIFIED ---- */

int FEAudio_StartLoadPatch(SPEECHINFO *info)

{
  int iVar1;
  char *pcVar2;
  int offset;
  int length;
  
  asyncidle();
  FeAudio_LocateBigfile(speechfileHeader[0],info->name,&offset,&length);
  if (offset == 0) {
    return 0;
  }
  if (length == 0) {
    return 0;
  }
  if (info->sSpeechData != (char *)0x0) {
    purgememadr(info->sSpeechData);
    info->sSpeechData = (char *)0x0;
  }
  pcVar2 = FeAudio_StartBigfileRead("",offset,length,&info->vivHandle);
  info->sSpeechData = pcVar2;
  iVar1 = 1;
  info->areLoading = '\x01';
  info->playNextOne = '\0';
  return iVar1;
}



/* ---- Feaudio_StartPatch  [FEAUDIO.CPP:68-121] SLD-VERIFIED ---- */

void Feaudio_StartPatch(SPEECHINFO *info)

{
  int iVar1;
  char *pcVar2;
  SNDPLAYOPTS playopts;
  
  if (info->sSpeechData != (char *)0x0) {
    iVar1 = SNDbankadd(&info->nHandle,info->sSpeechData);
    if (iVar1 == 7) {
      iVar1 = SNDbankheadersize(info->nHandle);
      pcVar2 = reservememadr((char *)(bigBuf + 0x104),iVar1,0x10);
      info->pBankHeader = pcVar2;
      SNDbankheadercopy(pcVar2,info->nHandle);
      if (info->sSpeechData != (char *)0x0) {
        purgememadr(info->sSpeechData);
        info->sSpeechData = (char *)0x0;
      }
    }
    else {
      pcVar2 = info->sSpeechData;
      info->sSpeechData = (char *)0x0;
      info->lastSpeechData = pcVar2;
    }
    SNDplaysetdef(&playopts);
    playopts.bhandle = (char)info->nHandle;
    playopts.patnum = 0;
    playopts.vol = (char)commentaryActualLevel;
    iVar1 = SNDplay(&playopts);
    info->nSoundHandle = iVar1;
    info->soundIsPlaying = '\x01';
    if (info->multiplay != 0) {
      if ((u_char)info->name[2] < 0x7a) {
        gCurrentVIV = gCurrentVIV + '\x01';
        info->name[2] = info->name[2] + '\x01';
        FEAudio_StartLoadPatch(info);
      }
      else {
        info->areLoading = '\0';
        info->playNextOne = '\0';
      }
    }
  }
  return;
}



/* ---- FeAudio_systemtask  [FEAUDIO.CPP:124-204] SLD-VERIFIED ---- */

void FeAudio_systemtask(int x)

{
  int ti1;
  int rd_status;
  u_int snd_over;
  int tu3;
  int i;
  int iVar1;
  u_int tu1;
  
  systemtask(x);
  if ((ginfo.areLoading != '\0') &&
     (rd_status = getasyncreadstatus(ginfo.vivHandle), tu1 = (*(u_int*)((char*)&ginfo + 16)),
     rd_status != 0)) {
    (*(u_short*)((char*)&ginfo + 16)) = (*(u_short*)((char*)&ginfo + 16)) & 0xff00;
    (*(u_char*)((char*)&ginfo + 19)) = (u_char)((tu1) >> 24);
    ginfo.playNextOne = '\x01';
  }
  if ((ginfo.soundIsPlaying != '\0') &&
     (snd_over = SNDover(ginfo.nSoundHandle), snd_over != 0)) {
    SNDautovol((void *)ginfo.nSoundHandle,0,-1);
    SNDbankremove(ginfo.nHandle);
    if (ginfo.lastSpeechData != (char *)0x0) {
      purgememadr(ginfo.lastSpeechData);
      ginfo.lastSpeechData = (char *)0x0;
    }
    if (ginfo.pBankHeader != (char *)0x0) {
      purgememadr(ginfo.pBankHeader);
      ginfo.pBankHeader = (char *)0x0;
    }
    if (ginfo.areLoading != '\0') {
      while (i = getasyncreadstatus(ginfo.vivHandle), i == 0) {
        systemtask(0);
      }
      ginfo.areLoading = '\0';
      ginfo.soundIsPlaying = '\0';
      ginfo.playNextOne = '\x01';
    }
    ginfo.soundIsPlaying = '\0';
    ginfo.nHandle = 0;
    if (((*(u_int*)((char*)&ginfo + 16)) & 0xff00ff) == 0) {
      gStopCommentaryNow = 1;
    }
  }
  if (gStopCommentaryNow != 0) {
    gCurrentVIV = -1;
    if (ginfo.areLoading != '\0') {
      while (iVar1 = getasyncreadstatus(ginfo.vivHandle), iVar1 == 0) {
        systemtask(0);
      }
    }
    if (ginfo.soundIsPlaying != '\0') {
      SNDautovol((void *)ginfo.nSoundHandle,0,-1);
      SNDbankremove(ginfo.nHandle);
    }
    AudioMus_Volume(gMasterMusicLevel * 0x46 >> 7);
    if (ginfo.sSpeechData != (char *)0x0) {
      purgememadr(ginfo.sSpeechData);
      ginfo.sSpeechData = (char *)0x0;
    }
    if (ginfo.lastSpeechData != (char *)0x0) {
      purgememadr(ginfo.lastSpeechData);
      ginfo.lastSpeechData = (char *)0x0;
    }
    if (ginfo.pBankHeader != (char *)0x0) {
      purgememadr(ginfo.pBankHeader);
      ginfo.pBankHeader = (char *)0x0;
    }
    (*(u_int*)((char*)&ginfo + 16)) = (*(u_int*)((char*)&ginfo + 16)) & 0xff000000;
    gStopCommentaryNow = 0;
  }
  if ((ginfo.playNextOne != '\0') && ((*(u_short*)((char*)&ginfo + 16)) == 0)) {
    Feaudio_StartPatch(&ginfo);
    ginfo.playNextOne = '\0';
  }
  return;
}



/* ---- FeAudio_AsyncPlayCommentary  [FEAUDIO.CPP:210-231] SLD-VERIFIED ---- */

short FeAudio_AsyncPlayCommentary(char *name)

{
  int ok;
  
  commentaryActualLevel = gMasterFENarrationLevel * 0x6e >> 7;
  if (0x5a < commentaryActualLevel) {
    commentaryActualLevel = 0x5a;
  }
  strncpy(ginfo.name,name,4);
  ginfo.nHandle = 0;
  ginfo.nSoundHandle = 0;
  ginfo.areLoading = '\0';
  ginfo.soundIsPlaying = '\0';
  ginfo.playNextOne = '\0';
  ginfo.pBankHeader = (char *)0x0;
  ginfo.sSpeechData = (char *)0x0;
  ginfo.lastSpeechData = (char *)0x0;
  ginfo.vivHandle = 0;
  gCurrentVIV = -1;
  ginfo.multiplay = (int)(*name != 'c');
  ok = FEAudio_StartLoadPatch(&ginfo);
  if (ok != 0) {
    AudioMus_Volume(gMasterMusicLevel * 0x23 >> 7);
  }
  return 1;
}



/* ---- FeAudio_AsyncPlaySpeech  [FEAUDIO.CPP:235-247] SLD-VERIFIED ---- */

short FeAudio_AsyncPlaySpeech(int type,int index)

{
  short sVar1;
  u_char *fmt;
  int iVar2;
  char vivname [5];
  
  if (type == 2) {
    fmt = bigBuf + 0x110;
    iVar2 = 99;
  }
  else if (type == 0) {
    fmt = bigBuf + 0x118;
    iVar2 = 0x61;
    index = index + 0x61;
  }
  else {
    fmt = bigBuf + 0x118;
    iVar2 = type + 0x61;
    index = index + 0x30;
  }
  sprintf(vivname,(char *)fmt,iVar2,index);
  sVar1 = FeAudio_AsyncPlayCommentary(vivname);
  return sVar1;
}



/* ---- FeAudio_StartBigfileRead  [FEAUDIO.CPP:253-269] SLD-VERIFIED ---- */

char * FeAudio_StartBigfileRead(char *fname,int offset,int length,int *vivHandle)

{
  char *streamBuffer;
  int iVar1;

  if (length == 0) {
    return (char *)0x0;
  }
  streamBuffer = reservememadr((char *)(bigBuf + 0x120),length,0);
  if (streamBuffer == (char *)0x0) {
    return (char *)0x0;
  }
  setasyncfile(fname);
  iVar1 = asyncloadsegment((char *)offset,streamBuffer,length);
  *vivHandle = iVar1;
  return streamBuffer;
}



/* ---- FeAudio_LocateBigfile  [FEAUDIO.CPP:274-302] SLD-VERIFIED ---- */

void FeAudio_LocateBigfile(LUMPYHEAD *bigfileHeader,char *name,int *offset,int *length)

{
  bool bVar1;
  int iVar2;
  u_long *tempChar;
  LUMPYHEAD *info;
  u_int i;
  
  *offset = 0;
  *length = 0;
  if (bigfileHeader != (LUMPYHEAD *)0x0) {
    info = bigfileHeader + 1;
    i = 1;
    if (bigfileHeader->num != 0) {
      do {
        tempChar = &info->num;
        iVar2 = strcmp(name,(char *)tempChar);
        if (iVar2 == 0) {
          i = info->type;
          *offset = i << 0x18 | (i & 0xff00) << 8 | (i & 0xff0000) >> 8 | i >> 0x18;
          i = info->len;
          *length = i << 0x18 | (i & 0xff00) << 8 | (i & 0xff0000) >> 8 | i >> 0x18;
          return;
        }
        if ((char)info->num != '\0') {
          tempChar = &info->num;
          do {
            tempChar = (u_long *)((int)tempChar + 1);
          } while (*(char *)tempChar != '\0');
        }
        info = (LUMPYHEAD *)((int)tempChar + 1);
        bVar1 = i < bigfileHeader->num;
        i = i + 1;
      } while (bVar1);
    }
  }
  return;
}



/* ---- FeAudio_InitViv  [FEAUDIO.CPP:305-347] SLD-VERIFIED ---- */

LUMPYHEAD * FeAudio_InitViv(char *fname)

{
  int vivHandle;
  int iVar2;
  LUMPYHEAD *bigfileHeader;
  u_int uVar3;
  u_int uVar4;
  u_int uVar5;
  LUMPYHEAD lumpHead;
  
  setasyncfile(fname);
  vivHandle = asyncloadsegment((char *)0x0,&lumpHead,0x10);
  do {
    systemtask(0);
    iVar2 = getasyncreadstatus(vivHandle);
  } while (iVar2 == 0);
  lumpHead.type =
       lumpHead.type << 0x18 | (lumpHead.type & 0xff00) << 8 | (lumpHead.type & 0xff0000) >> 8 |
       lumpHead.type >> 0x18;
  lumpHead.hlen =
       lumpHead.hlen << 0x18 | (lumpHead.hlen & 0xff00) << 8 | (lumpHead.hlen & 0xff0000) >> 8 |
       lumpHead.hlen >> 0x18;
  lumpHead.num = lumpHead.num << 0x18 | (lumpHead.num & 0xff00) << 8 |
                 (lumpHead.num & 0xff0000) >> 8 | lumpHead.num >> 0x18;
  bigfileHeader = reservememadr((char *)(bigBuf + 0x130),lumpHead.hlen + 0x20,0);
  if (bigfileHeader == (LUMPYHEAD *)0x0) {
    bigfileHeader = (LUMPYHEAD *)0x0;
  }
  else {
    vivHandle = asyncloadsegment((char *)0x0,bigfileHeader,lumpHead.hlen + 0x20);
    do {
      systemtask(0);
      iVar2 = getasyncreadstatus(vivHandle);
    } while (iVar2 == 0);
    uVar3 = bigfileHeader->type;
    uVar5 = bigfileHeader->hlen;
    uVar4 = bigfileHeader->num;
    bigfileHeader->type = uVar3 << 0x18 | (uVar3 & 0xff00) << 8 | (uVar3 & 0xff0000) >> 8 | uVar3 >> 0x18
    ;
    bigfileHeader->hlen = uVar5 << 0x18 | (uVar5 & 0xff00) << 8 | (uVar5 & 0xff0000) >> 8 | uVar5 >> 0x18
    ;
    bigfileHeader->num = uVar4 << 0x18 | (uVar4 & 0xff00) << 8 | (uVar4 & 0xff0000) >> 8 | uVar4 >> 0x18;
  }
  return bigfileHeader;
}



/* ---- FeAudio_InitCommentary  [FEAUDIO.CPP:360-377] SLD-VERIFIED ---- */

void FeAudio_InitCommentary(int language,int arg1)

{
  ginfo.nHandle = 0;
  ginfo.multiplay = 1;
  ginfo.nSoundHandle = 0;
  ginfo.areLoading = '\0';
  ginfo.soundIsPlaying = '\0';
  ginfo.playNextOne = '\0';
  ginfo.pBankHeader = (char *)0x0;
  ginfo.sSpeechData = (char *)0x0;
  ginfo.lastSpeechData = (char *)0x0;
  ginfo.vivHandle = 0;
  *(u_int *)ginfo.name = (*(u_int*)((char*)&bigBuf + 364));
  sprintf(currentSpeechViv,(char *)(bigBuf + 0x170),Paths_Paths[0x26],allLanguages[language]);  /* H11: dest was "" (oracle 0x800160EC $a0=$s0=&currentSpeechViv @0x80051510) */
  speechfileHeader[0] = FeAudio_InitViv(currentSpeechViv);  /* H11: arg was "" (oracle 0x8001615C $a0=$s0) */
  return;
}



/* ---- FeAudio_DeInitCommentary  [FEAUDIO.CPP:385-386] SLD-VERIFIED ---- */

void FeAudio_DeInitCommentary(void)

{
  char *tempChar;
  char *streamBuffer;
  u_int i;
  LUMPYHEAD lumpHead;
  char vivname [5];
  
  if (speechfileHeader[0] != (LUMPYHEAD *)0x0) {
    purgememadr(speechfileHeader[0]);
    speechfileHeader[0] = (LUMPYHEAD *)0x0;
  }
  return;
}



/* end of feaudio.cpp */
