/* frontend/common/feaudio.cpp -- RECONSTRUCTED (NFS4 front-end audio / commentary; C++ TU)
 *   10 free Feaudio_* fns (commentary VIV streaming, speech levels, language select).
 */
#include "feaudio.h"

/* ---- FEAudio_StartLoadPatch  [FEAUDIO.CPP:43-64] SLD-VERIFIED ---- */

int FEAudio_StartLoadPatch(SPEECHINFO *info)

{
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
  info->sSpeechData = FeAudio_StartBigfileRead("",offset,length,&info->vivHandle);
  info->areLoading = '\x01';
  info->playNextOne = '\0';
  return 1;
}



/* ---- Feaudio_StartPatch  [FEAUDIO.CPP:68-121] SLD-VERIFIED ---- */

void Feaudio_StartPatch(SPEECHINFO *info)

{
  SNDPLAYOPTS playopts;
  
  if (info->sSpeechData != (char *)0x0) {
    if (SNDbankadd(&info->nHandle,info->sSpeechData) == 7) {
      info->pBankHeader = reservememadr((char *)(bigBuf + 0x104),
                                       SNDbankheadersize(info->nHandle),0x10);
      SNDbankheadercopy(info->pBankHeader,info->nHandle);
      if (info->sSpeechData != (char *)0x0) {
        purgememadr(info->sSpeechData);
        info->sSpeechData = (char *)0x0;
      }
    }
    else {
      info->lastSpeechData = info->sSpeechData;
      info->sSpeechData = (char *)0x0;
    }
    SNDplaysetdef(&playopts);
    playopts.bhandle = (char)info->nHandle;
    playopts.patnum = 0;
    playopts.vol = (char)commentaryActualLevel;
    info->nSoundHandle = SNDplay(&playopts);
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
  systemtask(x);
  if ((ginfo.areLoading != '\0') &&
     (getasyncreadstatus(ginfo.vivHandle) != 0)) {
    ginfo.areLoading = '\0';
    ginfo.playNextOne = '\x01';
  }
  if ((ginfo.soundIsPlaying != '\0') &&
     (SNDover(ginfo.nSoundHandle) != 0)) {
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
      while (getasyncreadstatus(ginfo.vivHandle) == 0) {
        systemtask(0);
      }
      ginfo.areLoading = '\0';
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
      while (getasyncreadstatus(ginfo.vivHandle) == 0) {
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
    ginfo.soundIsPlaying = '\0';
    ginfo.playNextOne = '\0';
    gStopCommentaryNow = 0;
    ginfo.areLoading = '\0';
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
  commentaryActualLevel = gMasterFENarrationLevel * 0x6e >> 7;
  if (0x5a < commentaryActualLevel) {
    commentaryActualLevel = 0x5a;
  }
  strncpy(ginfo.name,name,4);
  ginfo.nHandle = 0;
  ginfo.nSoundHandle = 0;
  ginfo.multiplay = (int)(*name != 'c');
  ginfo.areLoading = '\0';
  ginfo.soundIsPlaying = '\0';
  ginfo.playNextOne = '\0';
  ginfo.pBankHeader = (char *)0x0;
  ginfo.sSpeechData = (char *)0x0;
  ginfo.lastSpeechData = (char *)0x0;
  ginfo.vivHandle = 0;
  gCurrentVIV = -1;
  if (FEAudio_StartLoadPatch(&ginfo) != 0) {
    AudioMus_Volume(gMasterMusicLevel * 0x23 >> 7);
  }
  return 1;
}



/* ---- FeAudio_AsyncPlaySpeech  [FEAUDIO.CPP:235-247] SLD-VERIFIED ---- */

short FeAudio_AsyncPlaySpeech(int type,int index)

{
  char vivname [5];
  
  if (type == 2) {
    sprintf(vivname,(char *)(bigBuf + 0x110),99,index);
  }
  else if (type == 0) {
    sprintf(vivname,(char *)(bigBuf + 0x118),0x61,index + 0x61);
  }
  else {
    sprintf(vivname,(char *)(bigBuf + 0x118),type + 0x61,index + 0x30);
  }
  return FeAudio_AsyncPlayCommentary(vivname);
}



/* ---- FeAudio_StartBigfileRead  [FEAUDIO.CPP:253-269] SLD-VERIFIED ---- */

char * FeAudio_StartBigfileRead(char *fname,int offset,int length,int *vivHandle)

{
  char *streamBuffer;

  if (length == 0) {
    return (char *)0x0;
  }
  streamBuffer = reservememadr((char *)(bigBuf + 0x120),length,0);
  if (streamBuffer == (char *)0x0) {
    return (char *)0x0;
  }
  setasyncfile(fname);
  *vivHandle = asyncloadsegment((char *)offset,streamBuffer,length);
  return streamBuffer;
}



/* ---- FeAudio_LocateBigfile  [FEAUDIO.CPP:274-302] SLD-VERIFIED ---- */

void FeAudio_LocateBigfile(LUMPYHEAD *bigfileHeader,char *name,int *offset,int *length)

{
  char *tempChar;
  FILEINFO *info;
  u_int i;
  
  *offset = 0;
  *length = 0;
  if (bigfileHeader != (LUMPYHEAD *)0x0) {
    info = (FILEINFO *)(bigfileHeader + 1);
    i = 1;
    if (bigfileHeader->num != 0) {
      do {
        if (strcmp(name,info->name) == 0) {
          *offset = info->offset << 0x18 | (info->offset & 0xff00) << 8 |
                    (info->offset & 0xff0000) >> 8 | (info->offset & 0xff000000) >> 0x18;
          *length = info->length << 0x18 | (info->length & 0xff00) << 8 |
                    (info->length & 0xff0000) >> 8 | (info->length & 0xff000000) >> 0x18;
          return;
        }
        tempChar = info->name;
        if (*tempChar != '\0') {
          do {
            tempChar = tempChar + 1;
          } while (*tempChar != '\0');
        }
        info = (FILEINFO *)(tempChar + 1);
      } while (i++ < bigfileHeader->num);
    }
  }
  return;
}



/* ---- FeAudio_InitViv  [FEAUDIO.CPP:305-347] SLD-VERIFIED ---- */

LUMPYHEAD * FeAudio_InitViv(char *fname)

{
  /* PASS (109/109): the direct four-mask byte-swap form matches the retail
     scheduler exactly.  This is the source idiom preserved by the matched
     NFS2 PC implementation; the former carrier/fence reconstruction did not. */
  int vivHandle;
  LUMPYHEAD lumpHead;
  LUMPYHEAD *bigfileHeader;

  setasyncfile(fname);
  vivHandle = asyncloadsegment((char *)0x0,&lumpHead,0x10);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);

  lumpHead.type = ((lumpHead.type & 0xff) << 24) |
                  ((lumpHead.type & 0xff00) << 8) |
                  ((lumpHead.type & 0xff0000) >> 8) |
                  ((lumpHead.type & 0xff000000) >> 24);
  lumpHead.hlen = ((lumpHead.hlen & 0xff) << 24) |
                  ((lumpHead.hlen & 0xff00) << 8) |
                  ((lumpHead.hlen & 0xff0000) >> 8) |
                  ((lumpHead.hlen & 0xff000000) >> 24);
  lumpHead.num = ((lumpHead.num & 0xff) << 24) |
                 ((lumpHead.num & 0xff00) << 8) |
                 ((lumpHead.num & 0xff0000) >> 8) |
                 ((lumpHead.num & 0xff000000) >> 24);

  bigfileHeader = reservememadr("lumpyhead",lumpHead.hlen + 0x20,0);
  if (bigfileHeader == (LUMPYHEAD *)0x0) {
    return (LUMPYHEAD *)0x0;
  }
  vivHandle = asyncloadsegment((char *)0x0,bigfileHeader,lumpHead.hlen + 0x20);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);

  bigfileHeader->type = ((bigfileHeader->type & 0xff) << 24) |
                        ((bigfileHeader->type & 0xff00) << 8) |
                        ((bigfileHeader->type & 0xff0000) >> 8) |
                        ((bigfileHeader->type & 0xff000000) >> 24);
  bigfileHeader->hlen = ((bigfileHeader->hlen & 0xff) << 24) |
                        ((bigfileHeader->hlen & 0xff00) << 8) |
                        ((bigfileHeader->hlen & 0xff0000) >> 8) |
                        ((bigfileHeader->hlen & 0xff000000) >> 24);
  bigfileHeader->num = ((bigfileHeader->num & 0xff) << 24) |
                       ((bigfileHeader->num & 0xff00) << 8) |
                       ((bigfileHeader->num & 0xff0000) >> 8) |
                       ((bigfileHeader->num & 0xff000000) >> 24);
  return bigfileHeader;
}


/* ---- Feaudio.obj-owned globals [FEAUDIO.CPP:349-357] SYM/SLD-VERIFIED ----
 * Their original source position is between FeAudio_InitViv (ends line 347)
 * and FeAudio_InitCommentary (starts line 360). This source order emits the
 * retail .rodata sequence: "lumpyhead", the six language prefixes, "000",
 * then "%s%s.viv". */
SPEECHINFO   ginfo;                     /* @0x800514e8 */
LUMPYHEAD   *speechfileHeader[1];       /* @0x8005150c; SYM-CARRIER: speechfileHeader */
char         currentSpeechViv[40];      /* @0x80051510 */
int          commentaryActualLevel;     /* @0x80051538 */
int          gStopCommentaryNow = 0;    /* @0x800514c8 */
signed char  gCurrentVIV = -1;          /* @0x800514cc; SYM CHAR; SYM-TYPE-OVERRIDE: gCurrentVIV */
char *allLanguages[6] = {"zEngl","zGerm","zFren","zSpan","zItal","zSwed"}; /* @0x800514d0 */



/* ---- FeAudio_InitCommentary  [FEAUDIO.CPP:360-377] SLD-VERIFIED ---- */

void FeAudio_InitCommentary(int language,int arg1)

{
  /* SYM-CODEGEN-CARRIER: arg1 -- the `__Fii` mangling proves two source
     arguments. SYM/m2c expose only `language` because the trailing int is
     unused and therefore has no surviving parameter record or machine use. */
  strcpy(ginfo.name,"000");
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
  /* The volatile value read keeps the language pointer load at the call site,
     matching retail while leaving the Paths_Paths %hi free to schedule early. */
  sprintf(currentSpeechViv,"%s%s.viv",Paths_Paths[0x26],
          *(char * *)&allLanguages[language]);  /* H11: dest was "" (oracle 0x800160EC $a0=$s0=&currentSpeechViv @0x80051510) */
  speechfileHeader[0] = FeAudio_InitViv(currentSpeechViv);  /* H11: arg was "" (oracle 0x8001615C $a0=$s0) */
  return;
}



/* ---- FeAudio_DeInitCommentary  [FEAUDIO.CPP:385-386] SLD-VERIFIED ---- */

void FeAudio_DeInitCommentary(void)

{
  if (speechfileHeader[0] != (LUMPYHEAD *)0x0) {
    purgememadr(speechfileHeader[0]);
    speechfileHeader[0] = (LUMPYHEAD *)0x0;
  }
  return;
}



/* end of feaudio.cpp */
