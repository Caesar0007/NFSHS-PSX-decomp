/* frontend/common/feaudio.cpp -- RECONSTRUCTED (NFS4 front-end audio / commentary; C++ TU)
 *   10 free Feaudio_* fns (commentary VIV streaming, speech levels, language select).
 */
#include "feaudio.h"

/* ---- Feaudio.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero) ---- */
int          gStopCommentaryNow;   /* @0x800514c8  (bss(zero)) */
signed char  gCurrentVIV = -1;   /* @0x800514cc */
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
     (rd_status = getasyncreadstatus(ginfo.vivHandle), rd_status != 0)) {
    ginfo.areLoading = '\0';
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
  int ok;
  
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
  ok = FEAudio_StartLoadPatch(&ginfo);
  if (ok != 0) {
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
  int vivHandle;
  LUMPYHEAD lumpHead;
  LUMPYHEAD *bigfileHeader;
  char *lumpyName;
  
  setasyncfile(fname);
  vivHandle = asyncloadsegment((char *)0x0,&lumpHead,0x10);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);
  /* MATCH (W66): 0x80010130 contains the real source literal "lumpyhead".
     Naming it before a zero-byte statement boundary lets reorg place its %hi
     in the retail loop-exit delay slot.  The pointer
     is optimized away: no extra SYM local, frame byte, or instruction remains.
     Falsified basins: plain literal 27, no boundary 54, bigBuf base+late offset
     23, explicit header temporaries 25-51, macro-block/inline-helper forms 22-54. */
  lumpyName = "lumpyhead";
  __asm__("" : : "i"(0));
  {
    u_int swappedType = lumpHead.type;
    u_int swappedResult;
    u_int headerLength;
    u_int headerNum;

    swappedResult = swappedType << 0x18 | (swappedType & 0xff00) << 8 |
                    (swappedType & 0xff0000) >> 8;
    swappedType >>= 0x18;
    swappedResult |= swappedType;
    swappedType = swappedResult;

    /* MATCH: fence the computed value before publishing it.  This preserves
       the swap while allowing the hlen/num loads to fill retail's slots.
       Splitting the three high-byte terms from the destructive final shift
       gives the source word retail's a3 handout (12 -> 7 diffs, 110/109).
       The remaining residual is one copy back into the long-lived carrier;
       removing it returns the input to a1 and loses the allocation gain.

       W60-A10 -- THE COUNT-EXACT BASIN, PROBED AND UNWOUND (kept as a receipt).
       Swapping this identity fence for a READ-ONLY fence on the result word
       (`__asm__("" : : "r"(swappedResult));`) deletes the copy and lands the
       body STRUCTURALLY EXACT: 109/109 insns, `sw v1,16(sp)` direct (no
       carrier), and BOTH later loads (`lw a1,28(sp)` hlen, `lw a3,24(sp)` num)
       in retail's slots.  The whole residual collapses to ONE pseudo's home:
       the first swap's SOURCE word gets $a1, retail gives it $a3 (6 renamed
       insns + the load's position inside the `lui a0 / addiu a0` string-address
       pair) => authoritative 12 diffs vs this shape's 7, so it is NOT landed.
       FALSIFIED follow-ups on that basin (all still 12, none reached $a3):
       decl-order x4 (hlen/num first, result first, num first, split decl-init);
       hoisting both header loads into the decl inits (36); a read-only
       fence on the SOURCE word, 1 and 2 operands (27, +1 insn); void-fence removal / re-siting
       (17) and a read-only fence on lumpyName (12); dropping the carrier copy
       and storing swappedResult straight (12); writing the first swap as ONE
       inline expression like its two siblings (12); fence-before-copy (34).
       => the last dial is a local-alloc QTY handout (the AGENT_GUIDE Sec.4.6 /
       06E gap), not a source shape.  Re-attack with the qtytrace lane. */
    __asm__("" : "+r"(swappedType));
    headerLength = lumpHead.hlen;
    headerNum = lumpHead.num;
    lumpHead.type = swappedType;
    lumpHead.hlen = headerLength << 0x18 | (headerLength & 0xff00) << 8 |
                    (headerLength & 0xff0000) >> 8 | headerLength >> 0x18;
    lumpHead.num = headerNum << 0x18 | (headerNum & 0xff00) << 8 |
                   (headerNum & 0xff0000) >> 8 | headerNum >> 0x18;
  }
  bigfileHeader = reservememadr(lumpyName,lumpHead.hlen + 0x20,0);
  if (bigfileHeader == (LUMPYHEAD *)0x0) {
    return (LUMPYHEAD *)0x0;
  }
  vivHandle = asyncloadsegment((char *)0x0,bigfileHeader,lumpHead.hlen + 0x20);
  do {
    systemtask(0);
  } while (getasyncreadstatus(vivHandle) == 0);
  {
    u_int byteMask = 0xff0000;
    u_int headerType = bigfileHeader->type;
    __asm__("" : : "r"(headerType), "r"(byteMask));
    LUMPYHEAD *header = bigfileHeader;
    u_int headerLength = header->hlen;
    u_int headerNum = header->num;

    header->type = headerType << 0x18 | (headerType & 0xff00) << 8 |
                   (headerType & byteMask) >> 8 | headerType >> 0x18;
    header->hlen = headerLength << 0x18 | (headerLength & 0xff00) << 8 |
                   (headerLength & byteMask) >> 8 | headerLength >> 0x18;
    header->num = headerNum << 0x18 | (headerNum & 0xff00) << 8 |
                  (headerNum & byteMask) >> 8 | headerNum >> 0x18;
  }
  return bigfileHeader;
}



/* ---- FeAudio_InitCommentary  [FEAUDIO.CPP:360-377] SLD-VERIFIED ---- */

void FeAudio_InitCommentary(int language,int arg1)

{
  u_int speechName;
  /* These are distinct existing rodata symbols in the retail link, not two
     fields of bigBuf. Keeping their identities prevents a false shared %hi. */
  extern u_int D_8001016C[];
  extern char D_80010170[];

  speechName = D_8001016C[0];
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
  *(u_int *)ginfo.name = speechName;
  /* The volatile value read keeps the language pointer load at the call site,
     matching retail while leaving the Paths_Paths %hi free to schedule early. */
  sprintf(currentSpeechViv,D_80010170,Paths_Paths[0x26],
          *(char * volatile *)&allLanguages[language]);  /* H11: dest was "" (oracle 0x800160EC $a0=$s0=&currentSpeechViv @0x80051510) */
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
