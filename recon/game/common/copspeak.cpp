/* game/common/copspeak.cpp -- RECONSTRUCTED (NFS4 PSX cop-radio speech/SFX system; C++ TU)
 *   27 free fns (CopSpeak_*): radio static, request queue, async SFX load/play, server pump.
 *   Full SYM-locals applied. GTE-free.
 */
#include "../../nfs4_types.h"
#include "copspeak_externs.h"

/* ---- copspeak.obj OWNED globals (EXT; SYM Globals.jsonl; $gp state @0x8013d07c..0x8013d0f8) ---- */
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
char               CopSpeak_gStaticPatch[2];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void CopSpeak_RadioStaticInit(void);
void CopSpeak_RadioStaticActive(int noise);
void CopSpeak_RadioStaticSquelch(void);
void CopSpeak_InitRequest(CopSpeak_tRequest *r);
void CopSpeak_SilenceCop(Car_tObj *car,int playerIndex);
void CopSpeak_Alloc(int r);
void CopSpeak_Free(int r);
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
int CopSpeak_BankVolume(int r);
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
  int *piVar3;
  int i;

  i = 0;
  piVar3 = CopSpeak_gStaticHandle;
  do {
    *piVar3 = -1;
    *(signed char *)(CopSpeak_gStaticPatch + i) = -1;
    i = i + 1;
    piVar3 = piVar3 + 1;
  } while (i < 2);
  return;
}

/* ---- CopSpeak_RadioStaticActive__Fi  [COPSPEAK.CPP:210-252] SLD-VERIFIED ---- */
void CopSpeak_RadioStaticActive(int noise)

{
  int numpatches;
  int i;
  int bhandle;
  SNDPLAYOPTS playopts;
  bool bVar1;
  u_int uVar2;
  int iVar3;
  int *piVar4;
  char *pcVar5;
  int iVar6;
  u_int uVar7;
  u_int local_38;
  u_char local_34;
  u_char local_30;
  
  uVar7 = 3;
  if (0x60 < noise) {
    uVar7 = 4;
  }
  iVar6 = 0;
  bVar1 = true;
CopSpkRadioStatic_returnLoop:
  do {
    if (!bVar1) {
      return;
    }
    pcVar5 = CopSpeak_gStaticPatch + iVar6;
    if (*pcVar5 == -1) {
      uVar2 = random();
      if (uVar7 == 0) {
        trap(0x1c00);
      }
      *pcVar5 = (char)(uVar2 % uVar7);
    }
    piVar4 = CopSpeak_gStaticHandle + iVar6;
    if (*piVar4 == -1) {
      iVar3 = AudioCmn_GetAsyncSfx(2,*pcVar5 + 0x2f,false);
      if (-1 < iVar3) {
        SNDplaysetdef(&local_38);
        local_34 = (u_char)iVar3;
        local_38 = 0;
        local_30 = (u_char)(gMasterFENarrationLevel * noise * 0x81 >> 0xe);
        iVar3 = SNDplay(&local_38);
        *piVar4 = iVar3;
        *pcVar5 = -1;
        if (*piVar4 < 0) {
          iVar6 = iVar6 + 1;
          AudioClc_SndError();
          bVar1 = iVar6 < 2;
          goto CopSpkRadioStatic_returnLoop;
        }
      }
    }
    else {
      iVar3 = SNDover(*piVar4);
      if (iVar3 != 0) {
        *piVar4 = -1;
      }
    }
    iVar6 = iVar6 + 1;
    bVar1 = iVar6 < 2;
  } while( true );
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
void CopSpeak_Alloc(int r)

{
  if (CopSpeak_gQueueReady == CopSpeak_gQueueLoad) {
    CopSpeak_gBufferLow = 0;
    CopSpeak_gBufferHigh = 0;
    CopSpeak_gBufferStart = 0;
    CopSpeak_gBufferEnd = 0x7ffc;
  }
  if (*(int *)(r + 0xc) <= (int)CopSpeak_gBufferEnd - (int)CopSpeak_gBufferStart) {
    *(int *)(r + 4) = (int)CopSpeak_gBufferStart;
    CopSpeak_gBufferStart = CopSpeak_gBufferStart + *(short *)(r + 0xc);
    return;
  }
  if (*(int *)(r + 0xc) <= (int)CopSpeak_gBufferLow) {
    CopSpeak_gBufferHigh = CopSpeak_gBufferStart;
    CopSpeak_gBufferEnd = CopSpeak_gBufferLow;
    CopSpeak_gBufferLow = 0;
    *(u_int *)(r + 4) = 0;
    CopSpeak_gBufferStart = *(u_short *)(r + 0xc);
    return;
  }
  *(u_int *)(r + 4) = 0xffffffff;
  return;
}

/* ---- CopSpeak_Free__FP17CopSpeak_tRequest  [COPSPEAK.CPP:344-361] SLD-VERIFIED ---- */
void CopSpeak_Free(int r)

{
  int iVar1;
  int iVar2;
  
  iVar1 = *(int *)(r + 4);
  if ((-1 < iVar1) && (iVar2 = *(int *)(r + 0xc), 0 < iVar2)) {
    if (CopSpeak_gBufferHigh == 0) {
      if (iVar1 + iVar2 == (int)CopSpeak_gBufferStart) {
        CopSpeak_gBufferStart = 0;
        *(u_int *)(r + 4) = 0xffffffff;
        return;
      }
      CopSpeak_gBufferLow = *(short *)(r + 4) + *(short *)(r + 0xc);
    }
    else if (iVar1 + iVar2 == (int)CopSpeak_gBufferHigh) {
      CopSpeak_gBufferHigh = 0;
      CopSpeak_gBufferEnd = 0x7ffc;
    }
    *(u_int *)(r + 4) = 0xffffffff;
  }
  return;
}

/* ---- CopSpeak_ReadyNextRequest__Fv  [COPSPEAK.CPP:367-533] SLD-VERIFIED ---- */
void CopSpeak_ReadyNextRequest(void)

{
  CopSpeak_tRequest * r;
  int ok;
  int status;
  CopSpeak_tBankHeader * bnk;
  char cVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  CopSpeak_tRequest *pCVar7;
  int *piVar8;
  
  iVar3 = CopSpeak_gQueueReady;
  pCVar7 = CopSpeak_gQueue + CopSpeak_gQueueReady;
  bVar2 = true;
  if (CopSpeak_gQueue[CopSpeak_gQueueReady].buffer < 0) {
    if ((CopSpeak_gQueue[CopSpeak_gQueueReady].sfx != '\0') ||
       ((-1 < CopSpeak_gQueue[CopSpeak_gQueueReady].phrase && (-1 < CopSpeak_gQueue[CopSpeak_gQueueReady].bank)))) {
      AudioCmn_LoadAsyncSfx((int)CopSpeak_gQueue[CopSpeak_gQueueReady].bank,CopSpeak_gQueue[CopSpeak_gQueueReady].phrase,0,0);
    }
    goto CopSpeakReady_advanceQueue;
  }
  iVar4 = FILE_opstatus(CopSpeak_gQueue[CopSpeak_gQueueReady].ophandle);
  if (iVar4 == 0) {
    return;
  }
  iVar5 = FILE_completeop(CopSpeak_gQueue[iVar3].ophandle);
  CopSpeak_gHandleCount = CopSpeak_gHandleCount + -1;
  piVar8 = (int *)(((int)CopSpeak_gBuffer) + CopSpeak_gQueue[iVar3].buffer);
  bVar2 = *piVar8 == 0x6c4b4e42 && (iVar5 == CopSpeak_gQueue[iVar3].size && iVar4 == 1);
  if (((char)piVar8[1] != '\x04') && ((char)piVar8[1] != '\x02')) {
    bVar2 = false;
  }
  if (!bVar2) {
    if ((CopSpeak_gQueue[iVar3].sfx != '\0') && (-1 < CopSpeak_gQueue[iVar3].bank)) {
      AudioCmn_LoadAsyncSfx((int)CopSpeak_gQueue[iVar3].bank,CopSpeak_gQueue[iVar3].phrase,0,0);
    }
    *piVar8 = 0x4c494146;
    iVar4 = FILE_read(CopSpeak_gQueue[iVar3].filehandle,(void *)CopSpeak_gQueue[iVar3].offset,
                       ((int)CopSpeak_gBuffer) + CopSpeak_gQueue[iVar3].buffer,CopSpeak_gQueue[iVar3].size,0,
                       (void *)0x0);
    CopSpeak_gQueue[iVar3].ophandle = iVar4;
    CopSpeak_gHandleCount = CopSpeak_gHandleCount + '\x01';
    FILE_operror(CopSpeak_gQueue[iVar3].ophandle);
    goto CopSpeakReady_advanceQueue;
  }
  iVar4 = (int)CopSpeak_gQueue[iVar3].bank;
  if (-1 < iVar4) {
    if ((CopSpeak_gQueue[iVar3].sfx == '\0') && (CopSpeak_gQueue[iVar3].phrase < 0)) {
      iVar4 = AudioCmn_GetAsyncSfx(iVar4,CopSpeak_gQueue[iVar3].offset + 0x4000,true);
      if (iVar4 == -1) {
        cVar1 = CopSpeak_gQueue[iVar3].bank;
        iVar6 = CopSpeak_gQueue[iVar3].size;
        iVar5 = CopSpeak_gQueue[iVar3].buffer;
        iVar4 = CopSpeak_gQueue[iVar3].offset + 0x4000;
CopSpeakReady_loadAsync:
        AudioCmn_LoadAsyncSfx((int)cVar1,iVar4,((int)CopSpeak_gBuffer) + iVar5,iVar6);
      }
    }
    else {
      iVar4 = AudioCmn_GetAsyncSfx(iVar4,CopSpeak_gQueue[iVar3].phrase,true);
      if (iVar4 == -1) {
        cVar1 = CopSpeak_gQueue[iVar3].bank;
        iVar4 = CopSpeak_gQueue[iVar3].phrase;
        iVar5 = CopSpeak_gQueue[iVar3].buffer;
        iVar6 = CopSpeak_gQueue[iVar3].size;
        goto CopSpeakReady_loadAsync;
      }
    }
  }
  *piVar8 = 0x4c494146;
  CopSpeak_Free(pCVar7);
CopSpeakReady_advanceQueue:
  iVar3 = CopSpeak_gQueueReady;
  if ((bVar2) && (iVar3 = 0, CopSpeak_gQueueReady < 0x3f)) {
    iVar3 = CopSpeak_gQueueReady + 1;
  }
  CopSpeak_gQueueReady = iVar3;
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
  pCVar1 = Copspeak_gBank;
  do {
    if (pCVar1->FileOpen != 0) {
      FILE_closesync(pCVar1->FileHandle,100);   /* oracle 0x89b10/b14: a1=0x64 (was dropped) */
      pCVar1->FileOpen = 0;
    }
    if (pCVar1->Index != (CopSpeak_tFileIndex *)0x0) {
      purgememadr(pCVar1->Index);
      pCVar1->Index = (CopSpeak_tFileIndex *)0x0;
    }
    iVar2 = iVar2 + 1;
    pCVar1 = pCVar1 + 1;
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
  long offset;
  long size;
  int filename;
  char * header;
  char * SpeechLanguage;
  CopSpeak_tBank * bank;
  int Generic;
  int i;
  int bankname;
  int timbre;
  char * list;
  char * p;
  int quoted;
  char * name;
  bool bVar1;
  void *pvVar2;
  int iVar3;
  void *pvVar4;
  char *addr;
  int *out_size_ptr;
  char *pcVar5;
  char **ppcVar6;
  int iVar7;
  char *tag;
  char acStack_b8 [104];
  char acStack_50 [16];
  char *local_40 [3];
  void *local_34;
  int local_30 [2];
  
  CopSpeak_InitVars();
  CopSpeak_RadioStaticInit();
  sprintf(acStack_b8,"%szzzwzzz.viv",Paths_Paths[0x1c]);
  pvVar2 = (void *)loadbigfileheader(acStack_b8,(void *)0x10);
  if (pvVar2 != (void *)0x0) {
    Copspeak_gBank[1].Count = 0;
    while (iVar3 = strcmp(GameSetup_gCarNames[Copspeak_gBank[1].Count],"BAD!"),
          iVar3 != 0) {
      Copspeak_gBank[1].Count = Copspeak_gBank[1].Count + 1;
    }
    iVar3 = 0;
    ppcVar6 = local_40 + 2;
    Copspeak_gBank[1].Count = Copspeak_gBank[1].Count * 2 + 1;
    Copspeak_gBank[1].Index =
         reservememadr("ocar index",Copspeak_gBank[1].Count * 8,0);
    local_40[2] = "rain.bnk";
    do {
      pvVar4 = locatebigentryz(pvVar2,*ppcVar6,0,&Copspeak_gBank[1].Index[iVar3].offset,
                          (int)&Copspeak_gBank[1].Index[iVar3].size);
      if (pvVar4 == (void *)0x0) {
        Copspeak_gBank[1].Index[iVar3].offset = 0;
        Copspeak_gBank[1].Index[iVar3].size = 0;
      }
      iVar3 = iVar3 + 1;
      ppcVar6 = ppcVar6 + 1;
    } while (iVar3 < 1);
    iVar7 = 8;
    for (iVar3 = 0; iVar3 < Copspeak_gBank[1].Count + -1; iVar3 = iVar3 + 1) {
      local_40[0] = "lden";
      local_40[1] = "ldex";
      sprintf(acStack_50,"%.4s%.4s.bnk",GameSetup_gCarNames + iVar3 / 2,local_40[iVar3 % 2]);
      out_size_ptr = (int *)((int)&(Copspeak_gBank[1].Index)->offset + iVar7);
      pvVar4 = locatebigentryz(pvVar2,acStack_50,0,out_size_ptr,(int)(out_size_ptr + 1));
      if (pvVar4 == (void *)0x0) {
        Copspeak_gBank[1].Index[iVar3 + 1].offset = 0;
        Copspeak_gBank[1].Index[iVar3 + 1].size = 0;
      }
      iVar7 = iVar7 + 8;
    }
    purgememadr(pvVar2);
    Copspeak_gBank[1].FileOpen =
         FILE_opensync(acStack_b8,1,100,-0x7feee14c);
  }
  CopSpeak_gNumTrackSfx = 0;
  sprintf(acStack_b8,"%szzzw%s.viv",Paths_Paths[0x1c],
             GameSetup_gTrackNames + GameSetup_gData.track);
  pvVar2 = (void *)loadbigfileheader(acStack_b8,(void *)0x10);
  if (pvVar2 == (void *)0x0) {
    sprintf(acStack_b8,"%szzzwcst.viv",Paths_Paths[0x1c]);
    pvVar2 = (void *)loadbigfileheader(acStack_b8,(void *)0x10);
    if (pvVar2 == (void *)0x0) goto CopSpeakStart_langSwitch;
  }
  Copspeak_gBank[0].Count = bigcount(pvVar2);
  Copspeak_gBank[0].Index =
       reservememadr("trck index",Copspeak_gBank[0].Count << 3,0);
  CopSpeak_gNumTrackSfx = Copspeak_gBank[0].Count;
  iVar3 = 0;
  if (0 < Copspeak_gBank[0].Count) {
    do {
      locatebigentry(pvVar2,(char *)0x0,iVar3,&Copspeak_gBank[0].Index[iVar3].offset,
                 (int)&Copspeak_gBank[0].Index[iVar3].size);
      iVar3 = iVar3 + 1;
    } while (iVar3 < Copspeak_gBank[0].Count);
  }
  purgememadr(pvVar2);
  Copspeak_gBank[0].FileOpen =
       FILE_opensync(acStack_b8,1,100,-0x7feee15c);
CopSpeakStart_langSwitch:
  if (GameSetup_gData.userSetting.language == 1) {
    pcVar5 = "ger";
  }
  else if (GameSetup_gData.userSetting.language == 2) {
    pcVar5 = "fre";
  }
  else {
    pcVar5 = "eng";
  }
  sprintf(acStack_b8,"%szzzx%s.viv",Paths_Paths[0x1d],pcVar5);
  pvVar2 = (void *)loadbigfileheader(acStack_b8,(void *)0x10);
  if (pvVar2 != (void *)0x0) {
    pvVar4 = locatebigentryz(pvVar2,"oneshots.txt",0,(int *)&local_34,(int)local_30);
    if ((pvVar4 != (void *)0x0) && (local_30[0] != 0)) {
      addr = reservememadr("copspeak temp",local_30[0],0x10);
      Copspeak_gBank[2].FileOpen =
           FILE_opensync(acStack_b8,1,100,-0x7feee13c);
      FILE_readsync(Copspeak_gBank[2].FileHandle,local_34,(int)addr,local_30[0],100);   /* oracle 0x8a160: +size(local_30[0]) +prio(0x64) */
      bVar1 = false;
      Copspeak_gBank[2].Count = 0;
      for (pcVar5 = addr; pcVar5 < addr + local_30[0]; pcVar5 = pcVar5 + 1) {
        if (*pcVar5 == '\"') {
          if (bVar1) {
            Copspeak_gBank[2].Count = Copspeak_gBank[2].Count + 1;
          }
          bVar1 = !bVar1;
        }
      }
      iVar3 = 0;
      Copspeak_gBank[2].Index =
           reservememadr("1sht index",Copspeak_gBank[2].Count << 3,0);
      bVar1 = false;
      pcVar5 = addr;
      tag = addr;
      if (addr < addr + local_30[0]) {
        do {
          if (*pcVar5 == '\"') {
            if (bVar1) {
              *pcVar5 = '\0';
              pvVar4 = locatebigentryz(pvVar2,tag,0,&Copspeak_gBank[2].Index[iVar3].offset,
                                  (int)&Copspeak_gBank[2].Index[iVar3].size);
              if (pvVar4 == (void *)0x0) {
                Copspeak_gBank[2].Index[iVar3].size = 0;
              }
              iVar3 = iVar3 + 1;
            }
            else {
              tag = pcVar5 + 1;
            }
            bVar1 = (bool)(bVar1 ^ 1);
          }
          pcVar5 = pcVar5 + 1;
        } while (pcVar5 < addr + local_30[0]);
      }
      purgememadr(addr);
    }
    purgememadr(pvVar2);
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
  int iVar1;
  int iVar2;
  int local_28;
  u_char local_24;
  u_char local_21;
  u_char local_20;
  u_char local_1f;
  u_char local_1d;
  u_short local_18;
  
  SNDplaysetdef(&local_28);
  if (*(char *)((int)r + 0x1e) == '\x03') {
    local_24 = (u_char)gSndBnk[3].bnkID;
    local_28 = ((int *)r)[6];
  }
  else {
    local_28 = 0;
    local_24 = handle;
  }
  iVar2 = 0x30;
  if (*(int *)r != 0) {
    iVar1 = *(short *)(*(int *)r + 0x8e) + 0x20;
    iVar2 = 0x7f;
    if (iVar1 < 0x80) {
      iVar2 = iVar1;
    }
  }
  if (((int *)r)[4] == Copspeak_gBank[2].FileHandle) {
    iVar1 = (gMasterFENarrationLevel * 0x81 >> 7) << 1;
    iVar2 = 0x7f;
    if (iVar1 < 0x80) {
      iVar2 = iVar1;
    }
  }
  else {
    iVar2 = gMasterFENarrationLevel * (0x80 - (iVar2 >> 2)) * 0x81 >> 0xe;
  }
  local_1f = 0x40;
  local_20 = (u_char)iVar2;
  local_1d = Audio_direct3davail != 0;
  if (Audio_direct3davail == 0) {
    if (gStereoMode == 0) {
      local_21 = 0x40;
    }
    else {
      local_21 = 0x40;
    }
  }
  else {
    local_18 = 0;
  }
  SNDplay(&local_28);
  return 0;
}

/* ---- CopSpeak_Skip__Fv  [COPSPEAK.CPP:1028-1042] SLD-VERIFIED ---- */
void CopSpeak_Skip(void)

{
  CopSpeak_tRequest * r;
  char cVar1;
  int iVar2;
  
  cVar1 = CopSpeak_gQueue[CopSpeak_gQueueLoad].sfx;
  CopSpeak_gQueue[CopSpeak_gQueueLoad].buffer = -1;
  CopSpeak_gQueue[CopSpeak_gQueueLoad].phrase = -1;
  if (cVar1 != '\0') {
    AudioCmn_LoadAsyncSfx((int)CopSpeak_gQueue[CopSpeak_gQueueLoad].bank,0xffffffff,0,0);
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
  char cVar1;
  CopSpeak_tRequest *pCVar2;
  char cVar3;
  char cVar4;
  char cVar5;
  int iVar6;
  int next;
  int iVar7;
  CopSpeak_tBank *bank;
  int iVar8;
  int iVar9;
  
  iVar6 = CopSpeak_gQueueHead;
  iVar7 = 0;
  if (CopSpeak_gQueueHead < 0x3f) {
    iVar7 = CopSpeak_gQueueHead + 1;
  }
  if (iVar7 != CopSpeak_gQueuePlay) {
    cVar1 = r->bank;
    if ((((Copspeak_gBank[cVar1].FileOpen != 0) &&
         (Copspeak_gBank[cVar1].Index != (CopSpeak_tFileIndex *)0x0)) && (-1 < r->phrase)) &&
       (r->phrase <= Copspeak_gBank[cVar1].Count)) {
      r->filehandle = Copspeak_gBank[cVar1].FileHandle;
      r->offset = Copspeak_gBank[cVar1].Index[r->phrase].offset;
      iVar7 = Copspeak_gBank[cVar1].Index[r->phrase].size;
      r->size = iVar7;
      if (iVar7 != 0) {
        iVar7 = r->buffer;
        iVar8 = r->offset;
        iVar9 = r->size;
        CopSpeak_gQueue[iVar6].car = r->car;
        CopSpeak_gQueue[iVar6].buffer = iVar7;
        CopSpeak_gQueue[iVar6].offset = iVar8;
        CopSpeak_gQueue[iVar6].size = iVar9;
        iVar7 = r->ophandle;
        iVar8 = r->phrase;
        cVar1 = r->player;
        cVar3 = r->sfx;
        cVar4 = r->bank;
        cVar5 = r->noise;
        CopSpeak_gQueue[iVar6].filehandle = r->filehandle;
        CopSpeak_gQueue[iVar6].ophandle = iVar7;
        CopSpeak_gQueue[iVar6].phrase = iVar8;
        pCVar2 = CopSpeak_gQueue + iVar6;
        pCVar2->player = cVar1;
        pCVar2->sfx = cVar3;
        pCVar2->bank = cVar4;
        pCVar2->noise = cVar5;
        iVar7 = 0;
        if (CopSpeak_gQueueHead < 0x3f) {
          iVar7 = CopSpeak_gQueueHead + 1;
        }
        CopSpeak_gQueueHead = iVar7;
        return iVar6;
      }
    }
  }
  return -1;
}

/* ---- CopSpeak_BankVolume__FP17CopSpeak_tRequest  [COPSPEAK.CPP:1095-1099] SLD-VERIFIED ---- */
int CopSpeak_BankVolume(int r)

{
  if (*(char *)(r + 0x1e) != '\x02') {
    return gMasterAmbientLevel;
  }
  return gMasterFENarrationLevel;
}

/* ---- CopSpeak_LoadNextRequest__Fv  [COPSPEAK.CPP:1115-1185] SLD-VERIFIED ---- */
void CopSpeak_LoadNextRequest(void)

{
  CopSpeak_tRequest * r;
  CopSpeak_tBankHeader * bnk;
  int iVar1;
  char cVar2;
  int iVar3;
  int iVar4;
  CopSpeak_tRequest *pCVar5;
  
  iVar3 = AudioMus_Buffered();
  iVar4 = AudioMus_Threshold();
  iVar1 = CopSpeak_gQueueLoad;
  if (iVar3 < iVar4) {
    return;
  }
CopSpeak_loadLoopTop:
  do {
    while( true ) {
      CopSpeak_gQueueLoad = iVar1;
      iVar1 = CopSpeak_gQueueLoad;
      if (CopSpeak_gQueueLoad == CopSpeak_gQueueHead) {
        return;
      }
      if (7 < (CopSpeak_gQueueLoad - (CopSpeak_gQueueReady + -0x40) & 0x3fU)) {
        return;
      }
      pCVar5 = CopSpeak_gQueue + CopSpeak_gQueueLoad;
      iVar3 = (int)CopSpeak_gQueue[CopSpeak_gQueueLoad].bank;
      if (-1 < iVar3) break;
CopSpeak_skipPath:
      CopSpeak_Skip();
      iVar1 = CopSpeak_gQueueLoad;
    }
    if (iVar3 == 3) {
      CopSpeak_gQueue[CopSpeak_gQueueLoad].buffer = -1;
      iVar1 = 0;
      if (CopSpeak_gQueueLoad < 0x3f) {
        iVar1 = CopSpeak_gQueueLoad + 1;
      }
      goto CopSpeak_loadLoopTop;
    }
    if (CopSpeak_gQueue[CopSpeak_gQueueLoad].sfx == '\0') {
      cVar2 = '\0';
      if (CopSpeak_gQueue[CopSpeak_gQueueLoad].phrase < 0) {
CopSpeak_checkBankSfx: /* @0x8009a70c */
        if ((cVar2 != '\0') ||
           (iVar3 = AudioCmn_GetAsyncSfx((int)CopSpeak_gQueue[iVar1].bank,
                               CopSpeak_gQueue[iVar1].offset + 0x4000,true), iVar3 < 0))
        goto CopSpeak_allocGate;
        CopSpeak_gQueue[iVar1].buffer = -1;
      }
      else {
        iVar3 = AudioCmn_GetAsyncSfx(iVar3,CopSpeak_gQueue[CopSpeak_gQueueLoad].phrase,true)
        ;
        if (iVar3 < 0) {
          cVar2 = CopSpeak_gQueue[iVar1].sfx;
          goto CopSpeak_checkBankSfx;
        }
        CopSpeak_gQueue[iVar1].buffer = -1;
      }
      goto CopSpeak_advanceLoad;
    }
CopSpeak_allocGate:
    if ((((((int)CopSpeak_gBuffer) == 0) ||
         (iVar3 = CopSpeak_BankVolume(pCVar5), iVar3 == 0)) ||
        (CopSpeak_gQueue[iVar1].size == 0)) || (0x7ffc < CopSpeak_gQueue[iVar1].size))
    goto CopSpeak_skipPath;
    CopSpeak_Alloc(pCVar5);
    if (CopSpeak_gQueue[iVar1].buffer < 0) {
      return;
    }
    *(u_int *)(((int)CopSpeak_gBuffer) + CopSpeak_gQueue[iVar1].buffer) = 0x4c494146;
    iVar3 = FILE_read(CopSpeak_gQueue[iVar1].filehandle,(void *)CopSpeak_gQueue[iVar1].offset,
                       ((int)CopSpeak_gBuffer) + CopSpeak_gQueue[iVar1].buffer,CopSpeak_gQueue[iVar1].size,100,
                       (void *)0x0);
    CopSpeak_gQueue[iVar1].ophandle = iVar3;
    CopSpeak_gHandleCount = CopSpeak_gHandleCount + '\x01';
    iVar3 = FILE_operror(CopSpeak_gQueue[iVar1].ophandle);
    iVar1 = CopSpeak_gQueueLoad;
    if (iVar3 < 1) {
CopSpeak_advanceLoad: /* @0x8009a7f8 */
      iVar1 = 0;
      if (CopSpeak_gQueueLoad < 0x3f) {
        iVar1 = CopSpeak_gQueueLoad + 1;
      }
    }
  } while( true );
}

/* ---- CopSpeak_PlayNextRequest__Fv  [COPSPEAK.CPP:1191-1238] SLD-VERIFIED ---- */
void CopSpeak_PlayNextRequest(void)

{
  int handle;
  char cVar1;
  CopSpeak_tRequest *pCVar2;
  int iVar3;
  int iVar4;
  CopSpeak_tRequest *r;
  
  iVar3 = CopSpeak_gQueuePlay;
  r = CopSpeak_gQueue + CopSpeak_gQueuePlay;
  if (-1 < CopSpeak_gQueue[CopSpeak_gQueuePlay].bank) {
    if (CopSpeak_gQueue[CopSpeak_gQueuePlay].sfx == '\0') {
      if (CopSpeak_gSpchHandle != -1) {
        return;
      }
      CopSpeak_gCurrent.car = r->car;
      CopSpeak_gCurrent.buffer = CopSpeak_gQueue[CopSpeak_gQueuePlay].buffer;
      CopSpeak_gCurrent.offset = CopSpeak_gQueue[CopSpeak_gQueuePlay].offset;
      CopSpeak_gCurrent.size = CopSpeak_gQueue[CopSpeak_gQueuePlay].size;
      CopSpeak_gCurrent.filehandle = CopSpeak_gQueue[CopSpeak_gQueuePlay].filehandle;
      CopSpeak_gCurrent.ophandle = CopSpeak_gQueue[CopSpeak_gQueuePlay].ophandle;
      CopSpeak_gCurrent.phrase = CopSpeak_gQueue[CopSpeak_gQueuePlay].phrase;
      pCVar2 = CopSpeak_gQueue + CopSpeak_gQueuePlay;
      CopSpeak_gCurrent.player = pCVar2->player;
      CopSpeak_gCurrent.sfx = pCVar2->sfx;
      CopSpeak_gCurrent.bank = pCVar2->bank;
      CopSpeak_gCurrent.noise = pCVar2->noise;
      iVar4 = CopSpeak_gQueue[CopSpeak_gQueuePlay].phrase;
      if (iVar4 == -1) {
        cVar1 = CopSpeak_gQueue[CopSpeak_gQueuePlay].bank;
        iVar4 = CopSpeak_gQueue[CopSpeak_gQueuePlay].offset + 0x4000;
      }
      else {
        cVar1 = CopSpeak_gQueue[CopSpeak_gQueuePlay].bank;
      }
      iVar4 = AudioCmn_GetAsyncSfx((int)cVar1,iVar4,true);
      if ((-1 < iVar4) || (CopSpeak_gQueue[iVar3].bank == '\x03')) {
        CopSpeak_gSpchHandle = CopSpeak_Play(r,iVar4);
      }
    }
    CopSpeak_InitRequest(r);
  }
  iVar3 = 0;
  if (CopSpeak_gQueuePlay < 0x3f) {
    iVar3 = CopSpeak_gQueuePlay + 1;
  }
  CopSpeak_gQueuePlay = iVar3;
  return;
}

/* ---- CopSpeak_Flush__Fv  [COPSPEAK.CPP:1257-1259] SLD-VERIFIED ---- */
void CopSpeak_Flush(void)

{
  int i;
  int iVar1;
  int iVar2;
  
  iVar1 = CopSpeak_gQueuePlay;
  if (CopSpeak_gQueuePlay != CopSpeak_gQueueHead) {
    do {
      CopSpeak_gQueue[iVar1].bank = -1;
      iVar2 = 0;
      if (iVar1 < 0x3f) {
        iVar2 = iVar1 + 1;
      }
      iVar1 = iVar2;
    } while (iVar2 != CopSpeak_gQueueHead);
  }
  return;
}

/* ---- CopSpeak_Server__Fv  [COPSPEAK.CPP:1271-1353] SLD-VERIFIED ---- */
void CopSpeak_Server(void)

{
  int noise;
  CopSpeak_tRequest * next;
  CopSpeak_tRequest * r;
  int i;
  int iVar1;
  int iVar2;
  CopSpeak_tRequest *pCVar3;
  int patch;
  
  if (CopSpeak_gSpchHandle != -1) {
    iVar1 = CopSpeak_gCurrent.phrase;
    if (CopSpeak_gCurrent.phrase == -1) {
      iVar1 = CopSpeak_gCurrent.offset + 0x4000;
    }
    AudioCmn_GetAsyncSfx((int)CopSpeak_gCurrent.bank,iVar1,true);
    iVar1 = SNDtimeremaining(CopSpeak_gSpchHandle);
    if (iVar1 < 5) {
      if ((((CopSpeak_gQueuePlay != CopSpeak_gQueueHead) && (CopSpeak_gQueue[CopSpeak_gQueuePlay].bank == '\x03')) &&
          (CopSpeak_gQueue[CopSpeak_gQueuePlay].phrase == 0x13)) &&
         (CopSpeak_gCurrent.car == (Car_tObj *)0x0)) {
        CopSpeak_gQueue[CopSpeak_gQueuePlay].phrase = 0x14;
      }
      CopSpeak_gSpchHandle = -1;
      CopSpeak_InitRequest(&CopSpeak_gCurrent);
    }
  }
  iVar1 = CopSpeak_gQueuePlay;
  if (CopSpeak_gQueuePlay != CopSpeak_gQueueHead) {
    do {
      if (((CopSpeak_gQueue[iVar1].sfx == '\0') &&
          (iVar2 = (int)CopSpeak_gQueue[iVar1].bank, iVar2 != 3)) && (-1 < iVar2)) {
        patch = CopSpeak_gQueue[iVar1].phrase;
        if (patch == -1) {
          patch = CopSpeak_gQueue[iVar1].offset + 0x4000;
        }
        AudioCmn_GetAsyncSfx(iVar2,patch,true);
      }
      iVar2 = 0;
      if (iVar1 < 0x3f) {
        iVar2 = iVar1 + 1;
      }
      iVar1 = iVar2;
    } while (iVar2 != CopSpeak_gQueueHead);
  }
  if (CopSpeak_gQueueReady != CopSpeak_gQueueLoad) {
    CopSpeak_ReadyNextRequest();
  }
  pCVar3 = (CopSpeak_tRequest *)0x0;
  if (CopSpeak_gSpchHandle == -1) {
    if ((CopSpeak_gQueuePlay != CopSpeak_gQueueReady) && (CopSpeak_gQueuePlay != CopSpeak_gQueueHead)) {
      pCVar3 = CopSpeak_gQueue;
      if (CopSpeak_gQueuePlay < 0x3f) {
        pCVar3 = CopSpeak_gQueue + CopSpeak_gQueuePlay + 1;
      }
    }
  }
  else {
    pCVar3 = &CopSpeak_gCurrent;
  }
  if ((pCVar3 == (CopSpeak_tRequest *)0x0) || (pCVar3->noise == '\0')) {
    CopSpeak_RadioStaticSquelch();
  }
  else {
    iVar1 = 0x30;
    if (pCVar3->car != (Car_tObj *)0x0) {
      iVar2 = *(short *)((int)&(pCVar3->car->N).distToPlayer + 2) + 0x20;
      iVar1 = 0x7f;
      if (iVar2 < 0x80) {
        iVar1 = iVar2;
      }
    }
    CopSpeak_RadioStaticActive(iVar1);
  }
  if ((((CopSpeak_gQueueReady == CopSpeak_gQueueHead) || (CopSpeak_gQueue[CopSpeak_gQueueReady].sfx != '\0')) ||
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
  int chkQ;
  int bufferstat;
  long lVar1;
  int iVar2;
  int iVar3;
  char local_58;
  u_char local_57;
  u_char auStack_56 [70];
  
  iVar2 = CopSpeak_gQueuePlay;
  local_58 = 0;
  local_57 = 0;
  memset(auStack_56,'\0',0x40);
  if (iVar2 != CopSpeak_gQueueHead) {
    do {
      if (CopSpeak_gQueue[iVar2].bank == -1) {
        strcat(&local_58,"x");
      }
      else if (CopSpeak_gQueue[iVar2].sfx == '\0') {
        if (CopSpeak_gQueue[iVar2].bank == '\x03') {
          strcat(&local_58,".");
        }
        else if (CopSpeak_gQueue[iVar2].phrase < 0) {
          if (CopSpeak_gQueue[iVar2].car == (Car_tObj *)0x0) {
            strcat(&local_58,"D");
          }
          else {
            sprintf(&local_58,"%s%d",&local_58,(CopSpeak_gQueue[iVar2].car)->carIndex);
          }
        }
        else {
          strcat(&local_58,"n");
        }
      }
      else {
        strcat(&local_58,"s");
      }
      if ((iVar2 == CopSpeak_gQueueReady) || (iVar2 == CopSpeak_gQueueLoad)) {
        strcat(&local_58,"|");
      }
      iVar3 = 0;
      if (iVar2 < 0x3f) {
        iVar3 = iVar2 + 1;
      }
      iVar2 = iVar3;
    } while (iVar3 != CopSpeak_gQueueHead);
  }
  lVar1 = strlen((u_long)&local_58);
  if (lVar1 != 0) {
    Font_TextXY(&local_58,10,6);
    iVar2 = textpixels(&local_58);
    Hud_FBuildF4(1,8,9,iVar2 + 5,9,0x190505,'\0','\0');
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
