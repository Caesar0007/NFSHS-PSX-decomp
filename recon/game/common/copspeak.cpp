/* game/common/copspeak.cpp -- RECONSTRUCTED (NFS4 PSX cop-radio speech/SFX system; C++ TU)
 *   27 free fns (CopSpeak_*): radio static, request queue, async SFX load/play, server pump.
 *   Full SYM-locals applied. GTE-free.
 */
#include "../../nfs4_types.h"
#include "copspeak_externs.h"

/* ---- copspeak.obj OWNED globals (EXT; SYM Globals.jsonl; $gp state @0x8013d07c..0x8013d0f8) ----
 * SYM v3 VAs (2026-07-12): gBank @0x80111ea4, gRequest @0x80111ee4, gCurrent @0x80111f04,
 * gQueue @0x80111f24 (64*32B, ends exactly at gMusicStat @0x80112724). ALL image-verified
 * genuinely zero at load -> the zero-init defs below are byte-correct, NOT a data-mat gap. */
CopSpeak_tBank     Copspeak_gBank[4];
CopSpeak_tRequest  CopSpeak_gRequest;
CopSpeak_tRequest  CopSpeak_gCurrent;
CopSpeak_tRequest  CopSpeak_gQueue[64];
SNDSTREAMSTATUS    CopSpeak_gMusicStat;
int                cdsectorreseek;
char               CopSpeak_gHandleCount;
int                CopSpeak_gQueueHead;
int                CopSpeak_gQueuePlay;
int                CopSpeak_gSpchHandle;
int                CopSpeak_gNumTrackSfx;
int                CopSpeak_gQueueLoad;
int                CopSpeak_gQueueReady;
int                CopSpeak_gWrongWay;
char              *CopSpeak_gBuffer;
short              CopSpeak_gBufferLow;
short              CopSpeak_gBufferStart;
short              CopSpeak_gBufferEnd;
short              CopSpeak_gBufferHigh;
int                CopSpeak_gStaticHandle[2];
signed char        CopSpeak_gStaticPatch[2];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void CopSpeak_RadioStaticInit(void);
void CopSpeak_RadioStaticActive(int noise);
void CopSpeak_RadioStaticSquelch(void);
void CopSpeak_InitRequest(CopSpeak_tRequest *r);
void CopSpeak_SilenceCop(Car_tObj *car,int playerIndex);
void CopSpeak_Alloc(CopSpeak_tRequest *r);
void CopSpeak_Free(CopSpeak_tRequest *r);
void CopSpeak_ReadyNextRequest(void);
void CopSpeak_Cancel(void);
void CopSpeak_Stop(void);
void CopSpeak_CleanUp(void);
void CopSpeak_InitVars(void);
void CopSpeak_DirectRequest(int filehandle,long offset,long size,Car_tObj *car,char *name);
void CopSpeak_GenericBankRequest(int patch,Car_tObj *car);
void CopSpeak_StartUp(void);
int CopSpeak_GetEnginePatch(int type,int timbre);
int CopSpeak_Play(CopSpeak_tRequest *r,int handle);
void CopSpeak_Skip(void);
int CopSpeak_Request(CopSpeak_tRequest *r);
int CopSpeak_BankVolume(CopSpeak_tRequest *r);
void CopSpeak_LoadNextRequest(void);
void CopSpeak_PlayNextRequest(void);
void CopSpeak_Flush(void);
void CopSpeak_Server(void);
int CopSpeak_SfxQueued(void);
void CopSpeak_ShowQueue(void);
void CopSpeak_Debug(void);


/* ---- CopSpeak_RadioStaticInit__Fv  [COPSPEAK.CPP:198-203] SLD-VERIFIED ---- */
void CopSpeak_RadioStaticInit(void)

{
  int i;

  for (i = 0; i < 2; i = i + 1) {
    CopSpeak_gStaticHandle[i] = -1;
    *(signed char *)(CopSpeak_gStaticPatch + i) = -1;
  }
  return;
}

/* ---- CopSpeak_RadioStaticActive__Fi  [COPSPEAK.CPP:210-252] SLD-VERIFIED ---- */
void CopSpeak_RadioStaticActive(int noise)

{
  int numpatches = 3;

  if (noise > 0x60) {
    numpatches = 4;
  }
  {
    int i;

    for (i = 0; i < 2; i++) {
      if (CopSpeak_gStaticPatch[i] == -1) {
        CopSpeak_gStaticPatch[i] =
            (u_int)random() % (u_int)numpatches;
      }
      {
        int *handle = &CopSpeak_gStaticHandle[i];

        if (*handle == -1) {
          int bhandle = AudioCmn_GetAsyncSfx
              (2,CopSpeak_gStaticPatch[i] + 0x2f,false);

          if (bhandle >= 0) {
            SNDPLAYOPTS playopts;

            SNDplaysetdef(&playopts);
            playopts.bhandle = (u_char)bhandle;
            playopts.patnum = 0;
            playopts.vol =
                (u_char)(gMasterFENarrationLevel *
                         ((noise << 7) + noise) >> 0xe);
            *handle = SNDplay(&playopts);
            CopSpeak_gStaticPatch[i] = -1;
            if (*handle < 0) {
              AudioClc_SndError(*handle);
            }
          }
        }
        else if (SNDover(*handle) != 0) {
          *handle = -1;
        }
      }
    }
  }
}

/* ---- CopSpeak_RadioStaticSquelch__Fv  [COPSPEAK.CPP:259-267] SLD-VERIFIED ---- */
void CopSpeak_RadioStaticSquelch(void)

{
  int i;
  int iVar1;
  int *ph;

  i = 0;
  iVar1 = -1;
  ph = CopSpeak_gStaticHandle;
  do {
    if (*ph != iVar1) {
      SNDstop(*ph);
      *ph = iVar1;
    }
    i = i + 1;
    ph = ph + 1;
  } while (i < 2);
  return;
}

/* ---- CopSpeak_InitRequest__FP17CopSpeak_tRequest  [COPSPEAK.CPP:276-285] SLD-VERIFIED ---- */
void CopSpeak_InitRequest(CopSpeak_tRequest *r)

{
  r->buffer = -1;
  r->phrase = -1;
  r->car = (Car_tObj *)0x0;
  r->offset = 0;
  r->size = 0;
  r->player = '\0';
  r->sfx = '\0';
  r->bank = '\x02';
  r->noise = '\0';
  return;
}

/* ---- CopSpeak_SilenceCop__FP8Car_tObji  [COPSPEAK.CPP:295-306] SLD-VERIFIED ---- */
void CopSpeak_SilenceCop(Car_tObj *car,int playerIndex)

{
  if ((car == (Car_tObj *)0x0) ||
     (((u_char)CopSpeak_gCurrent.player == playerIndex && (car == CopSpeak_gCurrent.car)))) {
    if (CopSpeak_gSpchHandle != -1) {
      SNDvol(CopSpeak_gSpchHandle,0);
    }
    CopSpeak_RadioStaticSquelch();
  }
  return;
}

/* ---- CopSpeak_Alloc__FP17CopSpeak_tRequest  [COPSPEAK.CPP:312-337] SLD-VERIFIED ---- */
void CopSpeak_Alloc(CopSpeak_tRequest *r)

{
  if (CopSpeak_gQueueReady == CopSpeak_gQueueLoad) {
    CopSpeak_gBufferLow = 0;
    CopSpeak_gBufferHigh = 0;
    CopSpeak_gBufferStart = 0;
    CopSpeak_gBufferEnd = 0x7ffc;
  }
  if (r->size <= (int)CopSpeak_gBufferEnd - (int)CopSpeak_gBufferStart) {
    r->buffer = (int)CopSpeak_gBufferStart;
    CopSpeak_gBufferStart = CopSpeak_gBufferStart + (short)r->size;
    return;
  }
  if (r->size <= (int)CopSpeak_gBufferLow) {
    CopSpeak_gBufferHigh = CopSpeak_gBufferStart;
    CopSpeak_gBufferEnd = CopSpeak_gBufferLow;
    CopSpeak_gBufferLow = 0;
    r->buffer = 0;
    CopSpeak_gBufferStart = (u_short)r->size;
    return;
  }
  r->buffer = 0xffffffff;
  return;
}

/* ---- CopSpeak_Free__FP17CopSpeak_tRequest  [COPSPEAK.CPP:344-361] SLD-VERIFIED ---- */
void CopSpeak_Free(CopSpeak_tRequest *r)

{
  int iVar1;
  int iVar2;

  iVar1 = r->buffer;
  if ((-1 < iVar1) && (iVar2 = r->size, 0 < iVar2)) {
    if (CopSpeak_gBufferHigh != 0) {
      if (iVar1 + iVar2 == (int)CopSpeak_gBufferHigh) {
        CopSpeak_gBufferHigh = 0;
        CopSpeak_gBufferEnd = 0x7ffc;
      }
    }
    else if (iVar1 + iVar2 == (int)CopSpeak_gBufferStart) {
      CopSpeak_gBufferStart = 0;
      r->buffer = 0xffffffff;
      return;
    }
    else {
      CopSpeak_gBufferLow = (short)r->buffer + (short)r->size;
    }
    r->buffer = 0xffffffff;
  }
  return;
}

/* ---- CopSpeak_ReadyNextRequest__Fv  [COPSPEAK.CPP:367-533] SLD-VERIFIED ---- */
void CopSpeak_ReadyNextRequest(void)

{
  CopSpeak_tRequest *r;
  int ok;

  r = &CopSpeak_gQueue[CopSpeak_gQueueReady];
  ok = true;
  if (r->buffer >= 0) {
    int status;
    CopSpeak_tBankHeader *bnk;

    status = FILE_opstatus(r->ophandle);
    if (status == 0) {
      return;
    }
    ok = status == 1;
    status = FILE_completeop(r->ophandle);
    CopSpeak_gHandleCount--;
    if (status != r->size) {
      ok = false;
    }
    bnk = (CopSpeak_tBankHeader *)(CopSpeak_gBuffer + r->buffer);
    if (bnk->id != 0x6c4b4e42) {
      ok = false;
    }
    if ((bnk->ver != 4) && (bnk->ver != 2)) {
      ok = false;
    }
    if (!ok) {
      if ((r->sfx != 0) && (*(signed char *)&r->bank >= 0)) {
        AudioCmn_LoadAsyncSfx(*(signed char *)&r->bank,r->phrase,0,0);
      }
      bnk->id = 0x4c494146;
      r->ophandle = FILE_read(r->filehandle,(void *)r->offset,
                              CopSpeak_gBuffer + r->buffer,r->size,0,(void *)0x0);
      CopSpeak_gHandleCount++;
      FILE_operror(r->ophandle);
    }
    else {
      if (*(signed char *)&r->bank >= 0) {
        if ((r->sfx != 0) || (r->phrase >= 0)) {
          if (AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,r->phrase,true) == -1) {
            AudioCmn_LoadAsyncSfx(*(signed char *)&r->bank,r->phrase,
                                  CopSpeak_gBuffer + r->buffer,r->size);
          }
        }
        else {
          if (AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,r->offset + 0x4000,true) == -1) {
            AudioCmn_LoadAsyncSfx(*(signed char *)&r->bank,r->offset + 0x4000,
                                  CopSpeak_gBuffer + r->buffer,r->size);
          }
        }
      }
      bnk->id = 0x4c494146;
      CopSpeak_Free(r);
    }
  }
  else {
    if ((r->sfx != 0) || ((r->phrase >= 0) && (*(signed char *)&r->bank >= 0))) {
      AudioCmn_LoadAsyncSfx(*(signed char *)&r->bank,r->phrase,0,0);
    }
  }
  if (ok) {
    CopSpeak_gQueueReady =
        CopSpeak_gQueueReady < 0x3f ? CopSpeak_gQueueReady + 1 : 0;
  }
  return;
}

/* ---- CopSpeak_Cancel__Fv  [COPSPEAK.CPP:539-574] SLD-VERIFIED ---- */
void CopSpeak_Cancel(void)

{
  if (CopSpeak_gQueueReady != CopSpeak_gQueueLoad) {
    do {
      CopSpeak_ReadyNextRequest();
      systemtask(0);
    } while (CopSpeak_gQueueReady != CopSpeak_gQueueLoad);
  }
  if (CopSpeak_gSpchHandle != -1) {
    SNDstop(CopSpeak_gSpchHandle);
  }
  CopSpeak_RadioStaticSquelch();
  CopSpeak_gSpchHandle = 0xffffffff;
  CopSpeak_InitRequest(&CopSpeak_gCurrent);
  CopSpeak_gQueueHead = 0;
  CopSpeak_gQueueLoad = 0;
  CopSpeak_gQueueReady = 0;
  CopSpeak_gQueuePlay = 0;
  CopSpeak_gBufferLow = 0;
  CopSpeak_gBufferHigh = 0;
  CopSpeak_gBufferStart = 0;
  CopSpeak_gBufferEnd = 0x7ffc;
  return;
}

/* ---- CopSpeak_Stop__Fv  [COPSPEAK.CPP:582-583] SLD-VERIFIED ---- */
void CopSpeak_Stop(void)

{
  CopSpeak_Cancel();
  return;
}

/* ---- CopSpeak_CleanUp__Fv  [COPSPEAK.CPP:592-620] SLD-VERIFIED ---- */
void CopSpeak_CleanUp(void)

{
  int i;
  CopSpeak_tBank *pCVar1;
  int iVar2;
  
  CopSpeak_Stop();
  iVar2 = 0;
  do {
    pCVar1 = Copspeak_gBank + iVar2;
    if (pCVar1->FileOpen != 0) {
      FILE_closesync(pCVar1->FileHandle,100);   /* oracle 0x89b10/b14: a1=0x64 (was dropped) */
      pCVar1->FileOpen = 0;
    }
    if (pCVar1->Index != (CopSpeak_tFileIndex *)0x0) {
      purgememadr(pCVar1->Index);
      pCVar1->Index = (CopSpeak_tFileIndex *)0x0;
    }
    iVar2 = iVar2 + 1;
  } while (iVar2 < 4);
  if (((int)CopSpeak_gBuffer) != 0) {
    CopSpeak_gBuffer = (char *)0;
  }
  return;
}

/* ---- CopSpeak_InitVars__Fv  [COPSPEAK.CPP:628-649] SLD-VERIFIED ---- */
void CopSpeak_InitVars(void)

{
  int i;
  CopSpeak_tBank *pCVar1;

  for (i = 0; i < 4; i++) {
    Copspeak_gBank[i].FileOpen = 0;
    Copspeak_gBank[i].Index = (CopSpeak_tFileIndex *)0x0;
  }
  CopSpeak_gSpchHandle = 0xffffffff;
  CopSpeak_gBuffer = (char *)0;
  CopSpeak_gQueueHead = 0;
  CopSpeak_gQueueLoad = 0;
  CopSpeak_gQueueReady = 0;
  CopSpeak_gQueuePlay = 0;
  CopSpeak_gWrongWay = 0;
  CopSpeak_gBufferLow = 0;
  CopSpeak_gBufferHigh = 0;
  CopSpeak_gBufferStart = 0;
  CopSpeak_gBufferEnd = 0x7ffc;
  CopSpeak_InitRequest(&CopSpeak_gCurrent);
  return;
}

/* ---- CopSpeak_DirectRequest__FillP8Car_tObjPc  [COPSPEAK.CPP:656-675] SLD-VERIFIED ---- */
void CopSpeak_DirectRequest(int filehandle,long offset,long size,Car_tObj *car,char *name)

{
  int next;
  int iVar1;
  CopSpeak_tRequest *r;
  int iVar2;
  
  iVar1 = CopSpeak_gQueueHead;
  r = CopSpeak_gQueue + CopSpeak_gQueueHead;
  iVar2 = 0;
  if (CopSpeak_gQueueHead < 0x3f) {
    iVar2 = CopSpeak_gQueueHead + 1;
  }
  if (iVar2 != CopSpeak_gQueuePlay) {
    CopSpeak_InitRequest(r);
    CopSpeak_gQueue[iVar1].filehandle = filehandle;
    CopSpeak_gQueue[iVar1].offset = offset;
    CopSpeak_gQueue[iVar1].size = size;
    CopSpeak_gQueue[iVar1].noise = '\x7f';
    r->car = car;
    CopSpeak_gQueueHead = iVar2;
  }
  return;
}

/* ---- CopSpeak_GenericBankRequest__FiP8Car_tObj  [COPSPEAK.CPP:682-695] SLD-VERIFIED ---- */
void CopSpeak_GenericBankRequest(int patch,Car_tObj *car)

{
  int next;
  int iVar1;
  CopSpeak_tRequest *r;
  int iVar2;
  
  iVar1 = CopSpeak_gQueueHead;
  r = CopSpeak_gQueue + CopSpeak_gQueueHead;
  iVar2 = 0;
  if (CopSpeak_gQueueHead < 0x3f) {
    iVar2 = CopSpeak_gQueueHead + 1;
  }
  if ((iVar2 != CopSpeak_gQueuePlay) && (iVar2 != CopSpeak_gQueueReady)) {
    CopSpeak_InitRequest(r);
    CopSpeak_gQueue[iVar1].bank = '\x03';
    CopSpeak_gQueue[iVar1].phrase = patch;
    CopSpeak_gQueue[iVar1].noise = '\x7f';
    r->car = car;
    CopSpeak_gQueueHead = iVar2;
  }
  return;
}

/* ---- CopSpeak_StartUp__Fv  [COPSPEAK.CPP:709-878] SLD-VERIFIED ---- */
void CopSpeak_StartUp(void)

{
  char filename[100];
  char *header;
  char *SpeechLanguage;
  
  CopSpeak_InitVars();
  CopSpeak_RadioStaticInit();
  sprintf(filename,"%szzzwzzz.viv",Paths_Paths[0x1c]);
  header = (char *)loadbigfileheader(filename,(void *)0x10);
  if (header != (char *)0x0) {
    CopSpeak_tBank *bank = &Copspeak_gBank[1];
    char *Generic[1];

    bank->Count = 0;
    while (strcmp(GameSetup_gCarNames[bank->Count],"BAD!") != 0) {
      bank->Count++;
    }
    bank->Count = bank->Count * 2 + 1;
    bank->Index = (CopSpeak_tFileIndex *)reservememadr("ocar index",bank->Count * 8,0);
    Generic[0] = "rain.bnk";

    {
      int i;

      for (i = 0; i < 1; i++) {
        if (locatebigentryz(header,Generic[i],0,&bank->Index[i].offset,
                            &bank->Index[i].size) == (void *)0x0) {
          bank->Index[i].offset = 0;
          bank->Index[i].size = 0;
        }
      }
    }

    {
      int i;

      for (i = 0; i < bank->Count - 1; i++) {
        char bankname[16];
        char *timbre[2] = {"lden","ldex"};

        sprintf(bankname,"%.4s%.4s.bnk",GameSetup_gCarNames + i / 2,timbre[i % 2]);
        if (locatebigentryz(header,bankname,0,&bank->Index[i + 1].offset,
                            &bank->Index[i + 1].size) == (void *)0x0) {
          bank->Index[i + 1].offset = 0;
          bank->Index[i + 1].size = 0;
        }
      }
    }

    purgememadr(header);
    bank->FileOpen = FILE_opensync(filename,1,100,bank);
  }

  CopSpeak_gNumTrackSfx = 0;
  sprintf(filename,"%szzzw%s.viv",Paths_Paths[0x1c],
             GameSetup_gTrackNames + GameSetup_gData.track);
  header = (char *)loadbigfileheader(filename,(void *)0x10);
  if (header == (char *)0x0) {
    sprintf(filename,"%szzzwcst.viv",Paths_Paths[0x1c]);
    header = (char *)loadbigfileheader(filename,(void *)0x10);
  }
  if (header != (char *)0x0) {
    CopSpeak_tBank *bank = &Copspeak_gBank[0];

    bank->Count = bigcount(header);
    bank->Index = (CopSpeak_tFileIndex *)reservememadr("trck index",bank->Count << 3,0);
    CopSpeak_gNumTrackSfx = bank->Count;
    {
      int i;

      for (i = 0; i < bank->Count; i++) {
        locatebigentry(header,(char *)0x0,i,&bank->Index[i].offset,
                       &bank->Index[i].size);
      }
    }
    purgememadr(header);
    bank->FileOpen = FILE_opensync(filename,1,100,bank);
  }

  switch (GameSetup_gData.userSetting.language) {
  case 2:
    SpeechLanguage = "fre";
    break;
  case 1:
    SpeechLanguage = "ger";
    break;
  default:
    SpeechLanguage = "eng";
    break;
  }
  sprintf(filename,"%szzzx%s.viv",Paths_Paths[0x1d],SpeechLanguage);
  header = (char *)loadbigfileheader(filename,(void *)0x10);
  if (header != (char *)0x0) {
    CopSpeak_tBank *bank = &Copspeak_gBank[2];
    long offset;
    long size;

    if ((locatebigentryz(header,"oneshots.txt",0,&offset,&size) != (void *)0x0) &&
        (size != 0)) {
      char *list = (char *)reservememadr("copspeak temp",size,0x10);
      char *p;
      int quoted;
      int i;
      char *name;

      bank->FileOpen = FILE_opensync(filename,1,100,bank);
      FILE_readsync(bank->FileHandle,offset,(int)list,size,100);
      p = list;
      quoted = 0;
      bank->Count = 0;
      for (; p < list + size; p++) {
        if (*p == '\"') {
          if (quoted) {
            bank->Count++;
          }
          quoted = !quoted;
        }
      }

      bank->Index = (CopSpeak_tFileIndex *)reservememadr("1sht index",bank->Count << 3,0);
      i = 0;
      name = list;
      p = list;
      quoted = 0;
      for (; p < list + size; p++) {
        if (*p == '\"') {
          if (!quoted) {
            name = p + 1;
          }
          else {
            *p = '\0';
            if (locatebigentryz(header,name,0,&bank->Index[i].offset,
                                &bank->Index[i].size) == (void *)0x0) {
              bank->Index[i].size = 0;
            }
            i++;
          }
          quoted = !quoted;
        }
      }
      purgememadr(list);
    }
    purgememadr(header);
  }
  CopSpeak_gBuffer = Platform_GetDCTBuffer(0x8000,"CopSpeakBuf");
  return;
}

/* ---- CopSpeak_GetEnginePatch__Fii  [COPSPEAK.CPP:885-891] SLD-VERIFIED ---- */
int CopSpeak_GetEnginePatch(int type,int timbre)

{
  int patch;
  int iVar1;
  int t1;

  type = type + type;
  t1 = timbre + 1;
  iVar1 = type + t1;
  if (Copspeak_gBank[1].Index[iVar1].size == 0) {
    iVar1 = timbre + 0x45;
  }
  return iVar1;
}

/* ---- CopSpeak_Play__FP17CopSpeak_tRequesti  [COPSPEAK.CPP:920-974] SLD-VERIFIED ---- */
int CopSpeak_Play(CopSpeak_tRequest *r,int handle)

{
  SNDPLAYOPTS playopts;
  int vol;
  int azimuth;
  int noise;

  azimuth = 0;
  SNDplaysetdef(&playopts);
  if (*(signed char *)&r->bank == '\x03') {
    playopts.bhandle = *(u_char *)&gSndBnk[3].bnkID;
    playopts.patnum = r->phrase;
  }
  else {
    playopts.bhandle = (u_char)handle;
    playopts.patnum = 0;
  }
  vol = 0x30;
  if (r->car != (Car_tObj *)0x0) {
    noise = *(short *)((char *)r->car + 0x8e) + 0x20;
    vol = 0x7f;
    if (noise < 0x80) {
      vol = noise;
    }
  }
  if (r->filehandle == Copspeak_gBank[2].FileHandle) {
    noise = (gMasterFENarrationLevel * 0x81 >> 7) << 1;
    vol = 0x7f;
    if (noise < 0x80) {
      vol = noise;
    }
  }
  else {
    int scaled = 0x80 - (vol >> 2);
    vol = gMasterFENarrationLevel * ((scaled << 7) + scaled) >> 0xe;
  }
  playopts.bend = 0x40;
  playopts.vol = (u_char)vol;
  playopts.use3dpos = Audio_direct3davail != 0;
  if (Audio_direct3davail != 0) {
    playopts.azimuth = (u_short)azimuth;
  }
  else {
    if (gStereoMode != 0) {
      if (azimuth - 0x4000U < 0x8000) {
        playopts.pan = (u_char)((0xbfff - azimuth) >> 8);
      }
      else {
        playopts.pan = (u_char)((u_int)(azimuth + 0x4000) >> 8);
      }
    }
    else {
      playopts.pan = 0x40;
    }
  }
  return SNDplay(&playopts);
}

/* ---- CopSpeak_Skip__Fv  [COPSPEAK.CPP:1028-1042] SLD-VERIFIED ---- */
void CopSpeak_Skip(void)

{
  CopSpeak_tRequest *r;
  u_int uVar1;
  int iVar2;

  r = &CopSpeak_gQueue[CopSpeak_gQueueLoad];
  uVar1 = r->sfx;
  r->buffer = -1;
  r->phrase = -1;
  if (uVar1 != 0) {
    AudioCmn_LoadAsyncSfx(*(signed char *)&r->bank,0xffffffff,0,0);
  }
  iVar2 = 0;
  if (CopSpeak_gQueueLoad < 0x3f) {
    iVar2 = CopSpeak_gQueueLoad + 1;
  }
  CopSpeak_gQueueLoad = iVar2;
  return;
}

/* ---- CopSpeak_Request__FP17CopSpeak_tRequest  [COPSPEAK.CPP:1051-1089] SLD-VERIFIED ---- */
int CopSpeak_Request(CopSpeak_tRequest *r)

{
  int head;
  int iVar6;
  int next;
  CopSpeak_tBank *bank;  /* SYM: Def class REG $5 (a1) PTR CopSpeak_tBank name bank */

  head = CopSpeak_gQueueHead;  /* MATCH: single top capture (a3) reused for guard 1 + copy index + return; guard 2 re-reads the global (a1) */
  iVar6 = 0;
  if (head < 0x3f) {
    iVar6 = head + 1;
  }
  if (iVar6 == CopSpeak_gQueuePlay) {
    return -1;
  }
  bank = &Copspeak_gBank[*(signed char *)&r->bank];
  if (((bank->FileOpen == 0) ||
      (bank->Index == (CopSpeak_tFileIndex *)0x0)) || (r->phrase < 0)) {
    return -1;
  }
  if (bank->Count < r->phrase) {
    return -1;
  }
  r->filehandle = bank->FileHandle;
  r->offset = bank->Index[r->phrase].offset;
  r->size = bank->Index[r->phrase].size;
  if (r->size == 0) {
    return -1;
  }
  CopSpeak_gQueue[head] = *r;
  next = 0;
  if (CopSpeak_gQueueHead < 0x3f) {
    next = CopSpeak_gQueueHead + 1;
  }
  CopSpeak_gQueueHead = next;
  return head;
}

/* ---- CopSpeak_BankVolume__FP17CopSpeak_tRequest  [COPSPEAK.CPP:1095-1099] SLD-VERIFIED ---- */
int CopSpeak_BankVolume(CopSpeak_tRequest *r)

{
  if (*(signed char *)&r->bank == '\x02') {
    return gMasterFENarrationLevel;
  }
  return gMasterAmbientLevel;
}

/* ---- CopSpeak_LoadNextRequest__Fv  [COPSPEAK.CPP:1115-1185] SLD-VERIFIED ---- */
void CopSpeak_LoadNextRequest(void)

{
  CopSpeak_tRequest *r;
  CopSpeak_tBankHeader *bnk;

  if (AudioMus_Buffered() < AudioMus_Threshold()) {
    return;
  }
  while (true) {
    if (CopSpeak_gQueueLoad == CopSpeak_gQueueHead) {
      return;
    }
    if (7 < ((CopSpeak_gQueueLoad -
              (*(volatile int *)&CopSpeak_gQueueReady - 0x40)) & 0x3f)) {
      return;
    }
    r = &CopSpeak_gQueue[CopSpeak_gQueueLoad];
    if (*(signed char *)&r->bank < 0) {
      CopSpeak_Skip();
      continue;
    }
    if (*(signed char *)&r->bank == 3) {
      r->buffer = -1;
      CopSpeak_gQueueLoad =
          CopSpeak_gQueueLoad < 0x3f ? CopSpeak_gQueueLoad + 1 : 0;
      continue;
    }

    if ((r->sfx == 0) && (r->phrase >= 0)) {
      if (AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,r->phrase,true) >= 0) {
        r->buffer = -1;
        CopSpeak_gQueueLoad =
            CopSpeak_gQueueLoad < 0x3f ? CopSpeak_gQueueLoad + 1 : 0;
        continue;
      }
    }
    if ((r->sfx == 0) &&
        (AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,
                              r->offset + 0x4000,true) >= 0)) {
      r->buffer = -1;
      CopSpeak_gQueueLoad =
          CopSpeak_gQueueLoad < 0x3f ? CopSpeak_gQueueLoad + 1 : 0;
      continue;
    }

    if ((CopSpeak_gBuffer == (char *)0x0) || (CopSpeak_BankVolume(r) == 0) ||
        (r->size == 0) || (r->size > 0x7ffc)) {
      CopSpeak_Skip();
      continue;
    }
    CopSpeak_Alloc(r);
    if (r->buffer < 0) {
      return;
    }
    bnk = (CopSpeak_tBankHeader *)(CopSpeak_gBuffer + r->buffer);
    bnk->id = 0x4c494146;
    r->ophandle = FILE_read(r->filehandle,(void *)r->offset,
                            CopSpeak_gBuffer + r->buffer,r->size,
                            100,(void *)0x0);
    CopSpeak_gHandleCount++;
    if (FILE_operror(r->ophandle) > 0) {
      continue;
    }
    CopSpeak_gQueueLoad =
        CopSpeak_gQueueLoad < 0x3f ? CopSpeak_gQueueLoad + 1 : 0;
  }
}

/* ---- CopSpeak_PlayNextRequest__Fv  [COPSPEAK.CPP:1191-1238] SLD-VERIFIED ---- */
void CopSpeak_PlayNextRequest(void)

{
  int iVar3;
  int iVar4;
  int next;
  CopSpeak_tRequest *r;

  iVar3 = CopSpeak_gQueuePlay;
  r = &CopSpeak_gQueue[iVar3];
  if (*(signed char *)&r->bank >= 0) {
    if (r->sfx == '\0') {
      if (CopSpeak_gSpchHandle != -1) {
        return;
      }
      CopSpeak_gCurrent = *r;
      iVar4 = r->phrase;
      if (iVar4 == -1) {
        iVar4 = r->offset;
        iVar4 = AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,iVar4 + 0x4000,true);
      }
      else {
        iVar4 = AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,iVar4,true);
      }
      if ((-1 < iVar4) || (*(signed char *)&r->bank == '\x03')) {
        CopSpeak_gSpchHandle = CopSpeak_Play(r,iVar4);
      }
    }
    CopSpeak_InitRequest(r);
    iVar3 = CopSpeak_gQueuePlay;
  }
  next = 0;
  if (iVar3 < 0x3f) {
    next = iVar3 + 1;
  }
  CopSpeak_gQueuePlay = next;
  return;
}

/* ---- CopSpeak_Flush__Fv  [COPSPEAK.CPP:1257-1259] SLD-VERIFIED ---- */
void CopSpeak_Flush(void)

{
  int i;
  int iVar1;
  int iVar2;
  CopSpeak_tRequest *pCVar1;

  for (iVar1 = CopSpeak_gQueuePlay; iVar1 != CopSpeak_gQueueHead; iVar1 = iVar2) {
    pCVar1 = &CopSpeak_gQueue[iVar1];
    *(signed char *)&pCVar1->bank = -1;
    iVar2 = 0;
    if (iVar1 < 0x3f) {
      iVar2 = iVar1 + 1;
    }
  }
  return;
}

/* ---- CopSpeak_Server__Fv  [COPSPEAK.CPP:1271-1353] SLD-VERIFIED ---- */
void CopSpeak_Server(void)

{
  CopSpeak_tRequest *next;
  
  if (CopSpeak_gSpchHandle != -1) {
    if (CopSpeak_gCurrent.phrase == -1) {
      AudioCmn_GetAsyncSfx((signed char)CopSpeak_gCurrent.bank,
                           CopSpeak_gCurrent.offset + 0x4000,true);
    }
    else {
      AudioCmn_GetAsyncSfx((signed char)CopSpeak_gCurrent.bank,
                           CopSpeak_gCurrent.phrase,true);
    }
    if (SNDtimeremaining(CopSpeak_gSpchHandle) < 5) {
      if (CopSpeak_gQueuePlay != CopSpeak_gQueueHead) {
        CopSpeak_tRequest *r = &CopSpeak_gQueue[CopSpeak_gQueuePlay];

        if (((signed char)r->bank == 3) && (r->phrase == 0x13) &&
            (CopSpeak_gCurrent.car == (Car_tObj *)0x0)) {
          r->phrase = 0x14;
        }
      }
      CopSpeak_gSpchHandle = -1;
      CopSpeak_InitRequest(&CopSpeak_gCurrent);
    }
  }

  {
    int i;

    for (i = CopSpeak_gQueuePlay; i != CopSpeak_gQueueHead;
         i = i < 0x3f ? i + 1 : 0) {
      if ((CopSpeak_gQueue[i].sfx == 0) &&
          ((signed char)CopSpeak_gQueue[i].bank != 3) &&
          ((signed char)CopSpeak_gQueue[i].bank >= 0)) {
        if (CopSpeak_gQueue[i].phrase == -1) {
          AudioCmn_GetAsyncSfx((signed char)CopSpeak_gQueue[i].bank,
                               CopSpeak_gQueue[i].offset + 0x4000,true);
        }
        else {
          AudioCmn_GetAsyncSfx((signed char)CopSpeak_gQueue[i].bank,
                               CopSpeak_gQueue[i].phrase,true);
        }
      }
    }
  }

  if (CopSpeak_gQueueReady != CopSpeak_gQueueLoad) {
    CopSpeak_ReadyNextRequest();
  }

  next = (CopSpeak_tRequest *)0x0;
  if (CopSpeak_gSpchHandle != -1) {
    next = &CopSpeak_gCurrent;
  }
  else {
    if ((CopSpeak_gQueuePlay != CopSpeak_gQueueReady) && (CopSpeak_gQueuePlay != CopSpeak_gQueueHead)) {
      next = &CopSpeak_gQueue[CopSpeak_gQueuePlay < 0x3f ?
                              CopSpeak_gQueuePlay + 1 : 0];
    }
  }

  if ((next != (CopSpeak_tRequest *)0x0) && (next->noise != 0)) {
    int noise = 0x30;

    if (next->car != (Car_tObj *)0x0) {
      int carNoise = *(short *)((char *)next->car + 0x8e) + 0x20;

      noise = 0x7f;
      if (carNoise < 0x80) {
        noise = carNoise;
      }
    }
    CopSpeak_RadioStaticActive(noise);
  }
  else {
    CopSpeak_RadioStaticSquelch();
  }

  if ((((CopSpeak_gQueueReady == CopSpeak_gQueueHead) || (CopSpeak_gQueue[CopSpeak_gQueueReady].sfx != 0)) ||
      (CopSpeak_gQueue[CopSpeak_gQueueReady].car != CopSpeak_gQueue[CopSpeak_gQueuePlay].car)) &&
     ((CopSpeak_gQueuePlay != CopSpeak_gQueueReady && (CopSpeak_gQueuePlay != CopSpeak_gQueueHead)))) {
    CopSpeak_PlayNextRequest();
  }
  CopSpeak_LoadNextRequest();
  return;
}

/* ---- CopSpeak_SfxQueued__Fv  [COPSPEAK.CPP:1359-1369] SLD-VERIFIED ---- */
int CopSpeak_SfxQueued(void)

{
  int iVar1;
  int iVar2;
  int iVar3;
  CopSpeak_tRequest *pEntry;

  iVar3 = 0;
  iVar2 = CopSpeak_gQueuePlay;
  while (iVar1 = iVar2, iVar1 != CopSpeak_gQueueHead) {
    pEntry = CopSpeak_gQueue + iVar1;
    if ((0 <= *(signed char *)&pEntry->bank) && (pEntry->sfx != '\0')) {
      iVar3 = iVar3 + 1;
    }
    iVar2 = 0;
    if (iVar1 < 0x3f) {
      iVar2 = iVar1 + 1;
    }
  }
  return iVar3;
}

/* ---- CopSpeak_ShowQueue__Fv  [COPSPEAK.CPP:1377-1404] SLD-VERIFIED ---- */
void CopSpeak_ShowQueue(void)

{
  int chkQ = CopSpeak_gQueuePlay;
  char bufferstat[66] = "\0";

  if (chkQ != CopSpeak_gQueueHead) {
    do {
      if ((signed char)CopSpeak_gQueue[chkQ].bank == -1) {
        strcat(bufferstat,"x");
      }
      else if (CopSpeak_gQueue[chkQ].sfx != 0) {
        strcat(bufferstat,"s");
      }
      else if ((signed char)CopSpeak_gQueue[chkQ].bank == 3) {
        strcat(bufferstat,".");
      }
      else if (CopSpeak_gQueue[chkQ].phrase >= 0) {
        strcat(bufferstat,"n");
      }
      else if (CopSpeak_gQueue[chkQ].car == (Car_tObj *)0x0) {
        strcat(bufferstat,"D");
      }
      else {
        sprintf(bufferstat,"%s%d",bufferstat,CopSpeak_gQueue[chkQ].car->carIndex);
      }
      if ((chkQ == CopSpeak_gQueueReady) || (chkQ == CopSpeak_gQueueLoad)) {
        strcat(bufferstat,"|");
      }
      chkQ = chkQ < 0x3f ? chkQ + 1 : 0;
    } while (chkQ != CopSpeak_gQueueHead);
  }
  if (strlen((u_long)bufferstat) != 0) {
    Font_TextXY(bufferstat,10,6);
    Hud_FBuildF4(1,8,9,textpixels(bufferstat) + 5,9,0x190505,0,0);
  }
  return;
}

/* ---- CopSpeak_Debug__Fv  [COPSPEAK.CPP:1509-1510] SLD-VERIFIED ---- */
void CopSpeak_Debug(void)

{
  CopSpeak_ShowQueue();
  return;
}

/* end of copspeak.cpp */
