/* game/common/speech.cpp -- RECONSTRUCTED (NFS4 PSX cop speech/dispatch engine; C++ TU)
 *   101 fns across 7 classes (Speech + Speaker/MobileSpeaker/DispatchSpeaker hierarchy +
 *   CarBank/CarBankName/LocationBank helpers) + 4 free C entry points (Speech_AllocateRAM__FlPc/
 *   PurgeRAM/HandleRequest/Server). Methods emitted free-fn-with-explicit-this `Class_method`
 *   (structs carry no member-fn protos). Virtual dispatch via _vf[31]. GTE-free.
 */
#include "../../nfs4_types.h"
#include "speech_externs.h"

/* ---- speech.obj OWNED globals (EXT; SYM Globals.jsonl tu=Speech.obj, @0x80111a44+) ---- */
Speech_tCarDescription      Speech_gCarDescription[15];
Speech_tLocationDescription Speech_gLocationDescription00[13];
Speech_tLocationDescription Speech_gLocationDescription02[14];
Speech_tLocationDescription Speech_gLocationDescription03[13];
Speech_tLocationDescription Speech_gLocationDescription04[9];
Speech_tLocationDescription Speech_gLocationDescription05[14];
Speech_tLocationDescription Speech_gLocationDescription06[11];
Speech_tLocationDescription Speech_gLocationDescription07[11];
Speech_tLocationDescription *Speech_gLocationDescription[11];
Speech_tCallSignDescription Speech_gCallSignDescription[1];
Speech_tMobileVoiceAttr     Speech_gCopAttr[9];
/* Speech::fgSpeech static-member singleton (active engine instance; $gp+0x838=0x8013cd84) */
Speech            *Speech_fgSpeech;
/* Speech::fgUndefined static-member buffer (cfront fn-local static _6Speech.fgUndefined,
   756 B @0x8013cd88). NOT zero scratch -- it is a packed bank-name lookup table: slot[0]
   is a runtime Speaker* (0 in image), followed by 3-/4-char model abbreviations + full names
   compared in Speech_CarBankName (strncmp vs +0x2c4/+0x2cc/+0x2d4/+0x2dc). Bytes verified
   byte-exact vs NFS4.EXE .data. All bytes <=0x7f -> fit signed char, no narrowing. */
char Speech_fgUndefined[756] = {
    0x00,0x00,0x00,0x00,0x42,0x4d,0x57,0x5a,0x00,0x00,0x00,0x00,
    0x62,0x6d,0x77,0x7a,0x33,0x2e,0x00,0x00,0x62,0x6d,0x77,0x2e,
    0x00,0x00,0x00,0x00,0x7a,0x33,0x2e,0x00,0x48,0x53,0x56,0x54,
    0x00,0x00,0x00,0x00,0x73,0x65,0x64,0x61,0x6e,0x2e,0x00,0x00,
    0x46,0x4f,0x52,0x44,0x00,0x00,0x00,0x00,0x43,0x4d,0x52,0x4f,
    0x00,0x00,0x00,0x00,0x63,0x68,0x76,0x63,0x61,0x6d,0x2e,0x00,
    0x63,0x68,0x65,0x76,0x72,0x6f,0x2e,0x00,0x63,0x61,0x6d,0x2e,
    0x00,0x00,0x00,0x00,0x54,0x52,0x41,0x4d,0x00,0x00,0x00,0x00,
    0x70,0x6f,0x6e,0x74,0x2e,0x00,0x00,0x00,0x41,0x44,0x42,0x37,
    0x00,0x00,0x00,0x00,0x61,0x73,0x74,0x6f,0x6e,0x2e,0x00,0x00,
    0x4a,0x58,0x4b,0x52,0x00,0x00,0x00,0x00,0x6a,0x61,0x67,0x2e,
    0x00,0x00,0x00,0x00,0x42,0x4d,0x57,0x4d,0x00,0x00,0x00,0x00,
    0x62,0x6d,0x77,0x6d,0x35,0x2e,0x00,0x00,0x6d,0x35,0x2e,0x00,
    0x43,0x4f,0x52,0x56,0x00,0x00,0x00,0x00,0x63,0x68,0x76,0x63,
    0x6f,0x72,0x2e,0x00,0x63,0x6f,0x72,0x76,0x2e,0x00,0x00,0x00,
    0x50,0x39,0x39,0x33,0x00,0x00,0x00,0x00,0x70,0x6f,0x72,0x39,
    0x31,0x31,0x2e,0x00,0x70,0x6f,0x72,0x73,0x63,0x2e,0x00,0x00,
    0x44,0x49,0x41,0x42,0x00,0x00,0x00,0x00,0x6c,0x61,0x6d,0x64,
    0x69,0x61,0x2e,0x00,0x6c,0x61,0x6d,0x62,0x2e,0x00,0x00,0x00,
    0x64,0x69,0x61,0x2e,0x00,0x00,0x00,0x00,0x4d,0x43,0x46,0x31,
    0x00,0x00,0x00,0x00,0x6d,0x63,0x6c,0x61,0x72,0x2e,0x00,0x00,
    0x58,0x39,0x39,0x33,0x00,0x00,0x00,0x00,0x58,0x43,0x46,0x31,
    0x00,0x00,0x00,0x00,0x73,0x70,0x6f,0x72,0x74,0x2e,0x00,0x00,
    0x63,0x61,0x62,0x2e,0x00,0x00,0x00,0x00,0x62,0x61,0x6f,0x76,
    0x2e,0x00,0x00,0x00,0x74,0x75,0x6e,0x2e,0x00,0x00,0x00,0x00,
    0x73,0x63,0x72,0x76,0x2e,0x00,0x00,0x00,0x74,0x77,0x72,0x2e,
    0x00,0x00,0x00,0x00,0x62,0x72,0x67,0x2e,0x00,0x00,0x00,0x00,
    0x66,0x72,0x6d,0x2e,0x00,0x00,0x00,0x00,0x70,0x69,0x6b,0x65,
    0x2e,0x00,0x00,0x00,0x6c,0x74,0x75,0x6e,0x2e,0x00,0x00,0x00,
    0x69,0x63,0x65,0x63,0x2e,0x00,0x00,0x00,0x6d,0x61,0x72,0x2e,
    0x00,0x00,0x00,0x00,0x62,0x61,0x79,0x2e,0x00,0x00,0x00,0x00,
    0x72,0x61,0x72,0x63,0x2e,0x00,0x00,0x00,0x6c,0x74,0x68,0x2e,
    0x00,0x00,0x00,0x00,0x72,0x75,0x69,0x6e,0x2e,0x00,0x00,0x00,
    0x73,0x70,0x66,0x6c,0x2e,0x00,0x00,0x00,0x74,0x62,0x72,0x67,
    0x2e,0x00,0x00,0x00,0x62,0x67,0x64,0x72,0x2e,0x00,0x00,0x00,
    0x6f,0x76,0x65,0x72,0x2e,0x00,0x00,0x00,0x66,0x6c,0x64,0x2e,
    0x00,0x00,0x00,0x00,0x73,0x74,0x75,0x6e,0x2e,0x00,0x00,0x00,
    0x68,0x74,0x6f,0x75,0x2e,0x00,0x00,0x00,0x6f,0x67,0x74,0x2e,
    0x00,0x00,0x00,0x00,0x74,0x72,0x6e,0x78,0x2e,0x00,0x00,0x00,
    0x6c,0x73,0x70,0x2e,0x00,0x00,0x00,0x00,0x68,0x73,0x76,0x2e,
    0x00,0x00,0x00,0x00,0x70,0x65,0x6e,0x74,0x2e,0x00,0x00,0x00,
    0x77,0x66,0x72,0x6d,0x2e,0x00,0x00,0x00,0x6f,0x77,0x65,0x6c,
    0x2e,0x00,0x00,0x00,0x74,0x6f,0x6c,0x6c,0x2e,0x00,0x00,0x00,
    0x6f,0x62,0x77,0x6d,0x2e,0x00,0x00,0x00,0x76,0x69,0x6c,0x6c,
    0x2e,0x00,0x00,0x00,0x6f,0x6d,0x75,0x73,0x2e,0x00,0x00,0x00,
    0x6b,0x6e,0x67,0x6d,0x2e,0x00,0x00,0x00,0x68,0x70,0x69,0x6e,
    0x2e,0x00,0x00,0x00,0x61,0x72,0x63,0x68,0x2e,0x00,0x00,0x00,
    0x6d,0x65,0x64,0x69,0x2e,0x00,0x00,0x00,0x66,0x61,0x72,0x6d,
    0x2e,0x00,0x00,0x00,0x61,0x6c,0x6c,0x2e,0x00,0x00,0x00,0x00,
    0x64,0x69,0x73,0x2e,0x00,0x00,0x00,0x00,0x63,0x65,0x6e,0x2e,
    0x00,0x00,0x00,0x00,0x63,0x6f,0x6e,0x74,0x2e,0x00,0x00,0x00,
    0x68,0x71,0x2e,0x00,0x63,0x6f,0x75,0x2e,0x00,0x00,0x00,0x00,
    0x32,0x30,0x2e,0x00,0x32,0x35,0x2e,0x00,0x33,0x31,0x2e,0x00,
    0x33,0x37,0x2e,0x00,0x33,0x38,0x2e,0x00,0x34,0x33,0x2e,0x00,
    0x34,0x35,0x2e,0x00,0x34,0x36,0x2e,0x00,0x35,0x32,0x2e,0x00,
    0x32,0x31,0x37,0x2e,0x00,0x00,0x00,0x00,0x32,0x32,0x33,0x2e,
    0x00,0x00,0x00,0x00,0x33,0x31,0x36,0x2e,0x00,0x00,0x00,0x00,
    0x33,0x33,0x32,0x2e,0x00,0x00,0x00,0x00,0x33,0x35,0x35,0x2e,
    0x00,0x00,0x00,0x00,0x33,0x37,0x31,0x2e,0x00,0x00,0x00,0x00,
    0x6a,0x3a,0x69,0x64,0x5c,0x00,0x00,0x00,0x6a,0x3a,0x63,0x61,
    0x72,0x73,0x5c,0x00,0x6a,0x3a,0x63,0x69,0x64,0x5c,0x00,0x00,
    0x6a,0x3a,0x63,0x6c,0x69,0x70,0x2e,0x00,0x66,0x72,0x65,0x00,
    0x67,0x65,0x72,0x00,0x62,0x72,0x74,0x00,0x65,0x6e,0x67,0x00,
};
/* gSpeechBankPool: in-race speech bank pool head (STAT void*, MEMORY-POOL-OVERLAY w/ CF_DVLC) */
void              *gSpeechBankPool;
/* @0x8013d06c: packed language-suffix table (4-byte stride, 3-char codes; bytes verified vs
   NFS4.EXE). Read in StartUp via switch(GameSetup_gData.languageSpeech) -> "%szzzz%s.viv". */
static char        gSpeechLangSuffix[4][4] = { "fre", "ger", "brt", "eng" };

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
extern "C" {
void Speech_AllocateRAM__FlPc(int numBytes,char *message);
void Speech_PurgeRAM__FPc(void *memPtr);
void Speech_HandleRequest__Fllll(long bank,long localoffset,long size,long event);
void SetCar__Q26Speech11CarBankNamei(u_int *param_1,int carIndex);
bool Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(u_int *param_1,char *param_2,u_int id,u_long *bankname);
void SetCar__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car);
void CountLocations__6Speech(int param_1);
u_int CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(int param_1,int *locationbank,char *name,int id);
int Distance__Q26Speech12LocationBanki(LocationBank *pThis,int slice);
void * FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki(Speech *pThis,LocationBank *bank,int slice);
void FindLocation__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car);
bool CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(u_int param_1,u_int *bank,char *name,u_int id);
u_int CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(int param_1,char *name,u_int id,u_int bn);
int CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(int param_1,void *header,u_int bn,int *hoffset,int *hsize);
void LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(int param_1,void *header,u_int bn,void *hoffset,int param_5);
u_int * Speech_ct(u_int *param_1);
void Reset__6Speech(void);
void Speech_dt(void *param_1,u_int __in_chrg);
u_int BankPatch__6SpeechlP8Car_tObj(int param_1,int bank,int car);
int SubmitRequest__6Speechlll(int param_1,int localoffset,u_int size);
void Report__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *cop);
void Deny__Q26Speech7Speaker(Speaker *pThis);
void Grant__Q26Speech7Speaker(Speaker *pThis);
void Ready__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *wing);
void Engage__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *perp);
void Lose__Q26Speech7Speaker(Speaker *pThis);
void Accident__Q26Speech7Speakeri(Speaker *pThis,int slice);
void Catch__Q26Speech7Speakeri(Speaker *pThis,int ticket);
void RoadBlock__Q26Speech7Speaker(Speaker *pThis);
void SpikeBelt__Q26Speech7Speaker(Speaker *pThis);
void Backup__Q26Speech7Speaker(Speaker *pThis);
void ReportBlockade__Q26Speech7Speaker(Speaker *pThis);
void Roger__Q26Speech7Speaker(Speaker *pThis);
void Bullhorn__Q26Speech7Speaker(Speaker *pThis);
void Purge__Q26Speech7Speaker(Speaker *pThis);
void Promote__Q26Speech7Speaker(Speaker *pThis);
void Speech_Server__Fv(void);
void SetDelayedStatus__6SpeechPQ26Speech7Speakeri(Speech *pThis,Speaker *sub,int delay);
void Activate__Q26Speech15DispatchSpeakeri(int param_1,u_int seedupdatecount);
int Dispatch__6Speech(void);
void Roger__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
void StatusReply__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
void Status__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
void Status__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car);
void * KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car);
void AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car);
void Report__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *perp);
void Accident__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int slice);
void Deny__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
void Grant__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
void Ready__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *carObj);
int PickVoice__6SpeechP8Car_tObj(Speech *pThis,Car_tObj *carObj);
void GetVoice__6SpeechP8Car_tObj(Car_tObj *carObj);
void Activate__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *carObj);
void ReActivate__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
Speaker * FindMobile__6SpeechP8Car_tObj(Speech *pThis,Car_tObj *carObj);
int Mobile__6SpeechP8Car_tObj(Car_tObj *carObj);
int CalcMph__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *perp);
void SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp);
int DistToPerp__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Report__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp);
void Engage__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp);
void Lose__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Accident__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int slice);
void Catch__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int ticket);
void RoadBlock__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void SpikeBelt__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Backup__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Roger__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Bullhorn__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void Purge__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void ReportBlockade__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
Car_tObj * Perp__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
int Unit__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
CallSignBank * CallSign__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
LocationBank * FindClosestLocationTo__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int slice);
CarBank * GetCarBank__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int carIndex);
Car_tObj * CarObj__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
void * IsSuper__Q26Speech13MobileSpeaker(MobileSpeaker *pThis);
CallSignBank * CallSign__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
LocationBank * FindClosestLocationTo__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int slice);
CarBank * GetCarBank__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int carIndex);
void PurgeStatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
Speaker * StatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
int StatusCount__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis);
LocationBank * FindClosestLocationTo__Q26Speech7Speakeri(Speaker *pThis,int slice);
CarBank * GetCarBank__Q26Speech7Speakeri(Speaker *pThis,int carIndex);
Car_tObj * Perp__Q26Speech7Speaker(Speaker *pThis);
void ReActivate__Q26Speech7Speaker(Speaker *pThis);
Car_tObj * CarObj__Q26Speech7Speaker(Speaker *pThis);
int DistToPerp__Q26Speech7Speaker(Speaker *pThis);
void PurgeStatusSub__Q26Speech7Speaker(Speaker *pThis);
Speaker * StatusSub__Q26Speech7Speaker(Speaker *pThis);
int StatusCount__Q26Speech7Speaker(Speaker *pThis);
void * IsSuper__Q26Speech7Speaker(Speaker *pThis);
void ClearPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car);
void * KnownPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car);
int Unit__Q26Speech7Speaker(Speaker *pThis);
void Status__Q26Speech7Speaker(Speaker *pThis);


/* ---- Speech_AllocateRAM__FlPc  [SPEECH.CPP:169-170] SLD-VERIFIED ---- */
void Speech_AllocateRAM__FlPc(int numBytes,char *message)

{
  reservememadr(message,numBytes,0);
  return;
}

/* ---- Speech_PurgeRAM__FPc  [SPEECH.CPP:174-175] SLD-VERIFIED ---- */
void Speech_PurgeRAM__FPc(void *memPtr)

{
  purgememadr(memPtr);
  return;
}

/* ---- Speech_HandleRequest__Fllll  [SPEECH.CPP:179-180] SLD-VERIFIED ---- */
void Speech_HandleRequest__Fllll(long bank,long localoffset,long size,long event)

{
  SubmitRequest__6Speechlll(bank,localoffset,size);
  return;
}

/* ---- SetCar__Q26Speech11CarBankNamei  [SPEECH.CPP:234-246] SLD-VERIFIED ---- */
void SetCar__Q26Speech11CarBankNamei(u_int *param_1,int carIndex)

{
  char*game;
  Speech_tCarDescription * d;
  int iVar1;
  int iVar2;
  char *pcVar3;
  Speech_tCarDescription *pSVar4;
  
  pSVar4 = Speech_gCarDescription;
  iVar1 = GameSetup_gData.carInfo[carIndex].carType;
  pcVar3 = Speech_gCarDescription[0].game;
  while ((pcVar3 != (char *)0x0 &&
         (iVar2 = strncmp(GameSetup_gCarNames[iVar1],pSVar4->game,4), iVar2 != 0)
         )) {
    pSVar4 = pSVar4 + 1;
    pcVar3 = pSVar4->game;
  }
  *param_1 = pSVar4->full;
  param_1[1] = pSVar4->make;
  param_1[2] = pSVar4->model;
  return;
}

/* ---- Check__Q26Speech7CarBankPciPQ26Speech11CarBankName  [SPEECH.CPP:257-275] SLD-VERIFIED ---- */
bool Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(u_int *param_1,char *param_2,u_int id,u_long *bankname)

{
  CarBankName *pThis;  /* folded receiver temp (SYM REG `this`) */
  int match;
  char * name;
  bool bVar1;
  long lVar2;
  int iVar3;
  bool bVar4;
  
  bVar4 = false;
  bVar1 = false;
  if (*bankname != 0) {
    lVar2 = strlen(*bankname);
    iVar3 = strncmp(param_2,(char *)*bankname,lVar2);
    bVar1 = iVar3 == 0;
  }
  if (bVar1) {
    *param_1 = id;
    bVar4 = true;
  }
  bVar1 = false;
  if (bankname[1] != 0) {
    lVar2 = strlen(bankname[1]);
    iVar3 = strncmp(param_2,(char *)bankname[1],lVar2);
    bVar1 = iVar3 == 0;
  }
  if (bVar1) {
    param_1[1] = id;
    bVar4 = true;
  }
  bVar1 = false;
  if (bankname[2] != 0) {
    lVar2 = strlen(bankname[2]);
    iVar3 = strncmp(param_2,(char *)bankname[2],lVar2);
    bVar1 = iVar3 == 0;
  }
  if (bVar1) {
    param_1[2] = id;
    bVar4 = true;
  }
  return bVar4;
}

/* ---- CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName  [SPEECH.CPP:281-295] SLD-VERIFIED ---- */
u_int
CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName(int param_1,int carbank,u_int name,u_int id,int bankname)

{
  int match;
  int i;
  int iVar1;
  int iVar2;
  u_int uVar3;
  
  iVar2 = 0;
  uVar3 = 0;
  if (0 < *(int *)(param_1 + 0x37c)) {
    do {
      iVar1 = Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(carbank,name,id,bankname);
      if (iVar1 != 0) {
        uVar3 = 1;
      }
      carbank = carbank + 0xc;
      iVar2 = iVar2 + 1;
      bankname = bankname + 0xc;
    } while (iVar2 < *(int *)(param_1 + 0x37c));
  }
  return uVar3;
}

/* ---- SetCar__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:301-373] SLD-VERIFIED ---- */
void SetCar__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car)

{
  int carcolour;
  int *piVar1;
  int iVar2;
  int Colour;
  u_int uVar3;
  
  uVar3 = 1 << car->carInfo->SpeechColour;
  piVar1 = (int *)(*(*pThis->_vf)[0x1c].pfn)
                            ((int)&(pThis->fPosition).flags + (int)(*pThis->_vf)[0x1c].delta,
                             car->carIndex);
  if (*piVar1 == -1) {
    pThis->fCar = 0;
    (pThis->fColour).flags = 0;
  }
  else {
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) != 0) {
      (pThis->fColour).flags = uVar3;
    }
    else {
      (pThis->fColour).flags = uVar3 | 0x78020;
    }
    iVar2 = Dispatch__6Speech();
    iVar2 = (**(int (**)(...))(*(int *)(iVar2 + 0x4c) + 0x94))
                      (iVar2 + *(short *)(*(int *)(iVar2 + 0x4c) + 0x90),car);
    if (iVar2 != 0) {
      iVar2 = (*(*pThis->_vf)[0x1c].pfn)
                        ((int)&(pThis->fPosition).flags + (int)(*pThis->_vf)[0x1c].delta,car->carIndex
                        );
      pThis->fCar = *(int *)(iVar2 + 8);
    }
    else {
      piVar1 = (int *)(*(*pThis->_vf)[0x1c].pfn)
                                ((int)&(pThis->fPosition).flags + (int)(*pThis->_vf)[0x1c].delta,
                                 car->carIndex);
      pThis->fCar = *piVar1;
    }
  }
  return;
}

/* ---- CountLocations__6Speech  [SPEECH.CPP:521-534] SLD-VERIFIED ---- */
void CountLocations__6Speech(int param_1)

{
  Speech_tLocationDescription * d;
  char *pcVar1;
  Speech_tLocationDescription *pSVar2;
  
  *(u_int *)(param_1 + 0x360) = 0;
  pSVar2 = Speech_gLocationDescription[GameSetup_gData.track];
  if (pSVar2 != (Speech_tLocationDescription *)0x0) {
    pcVar1 = pSVar2->name;
    while (pcVar1 != (char *)0x0) {
      pSVar2 = pSVar2 + 1;
      if (0xf < *(int *)(param_1 + 0x360)) {
        return;
      }
      *(int *)(param_1 + 0x360) = *(int *)(param_1 + 0x360) + 1;
      pcVar1 = pSVar2->name;
    }
  }
  return;
}

/* ---- CheckLocationBank__6SpeechPQ26Speech12LocationBankPci  [SPEECH.CPP:539-561] SLD-VERIFIED ---- */
u_int CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(int param_1,int *locationbank,char *name,int id)

{
  int match;
  Speech_tLocationDescription * d;
  int i;
  int bankid;
  short sVar1;
  short sVar2;
  long lVar3;
  int iVar4;
  char *pcVar5;
  Speech_tLocationDescription *pSVar6;
  short *psVar7;
  int iVar8;
  u_int uVar9;
  
  pSVar6 = Speech_gLocationDescription[GameSetup_gData.track];
  uVar9 = 0;
  if (pSVar6 == (Speech_tLocationDescription *)0x0) {
    uVar9 = 0;
  }
  else {
    psVar7 = &pSVar6->end;
    for (iVar8 = 0; iVar8 < *(int *)(param_1 + 0x360); iVar8 = iVar8 + 1) {
      lVar3 = strlen((u_long)pSVar6->name);
      iVar4 = strncmp(name,pSVar6->name,lVar3);
      if (iVar4 == 0) {
        sVar1 = psVar7[-1];
        sVar2 = *psVar7;
        pcVar5 = pSVar6->name;
        uVar9 = 1;
        locationbank[2] = id;
        *locationbank = (int)sVar1;
        locationbank[1] = (int)sVar2;
        locationbank[3] = (int)pcVar5;
      }
      psVar7 = psVar7 + 4;
      pSVar6 = pSVar6 + 1;
      locationbank = locationbank + 4;
    }
  }
  return uVar9;
}

/* ---- Distance__Q26Speech12LocationBanki  [SPEECH.CPP:567-587] SLD-VERIFIED ---- */
int Distance__Q26Speech12LocationBanki(LocationBank *pThis,int slice)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  iVar4 = pThis->fStartSlice;
  iVar2 = pThis->fEndSlice;
  if (iVar2 < iVar4) {
    if ((iVar4 <= slice) || (iVar1 = slice - iVar2, slice <= iVar2)) {
      return 0;
    }
  }
  else {
    if (iVar4 <= slice) {
      iVar3 = slice - iVar2;
      if (slice <= iVar2) {
        return 0;
      }
      iVar1 = (iVar4 + gNumSlices) - slice;
      goto Distance_clampMin;
    }
    iVar1 = (slice + gNumSlices) - iVar2;
  }
  iVar3 = iVar4 - slice;
Distance_clampMin:
  if (iVar3 < iVar1) {
    iVar1 = iVar3;
  }
  return iVar1;
}

/* ---- FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki  [SPEECH.CPP:594-618] SLD-VERIFIED ---- */
void * FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki(Speech *pThis,LocationBank *bank,int slice)

{
  int iVar1;
  int distance;
  LocationBank *locationbank;
  LocationBank *this_00;
  int i;
  int iVar2;
  int closestdistance;
  int iVar3;
  LocationBank *closestbank;
  LocationBank *pLVar4;
  
  if (pThis->fLocationCount == 0) {
    pLVar4 = (LocationBank *)0x0;
  }
  else {
    pLVar4 = (LocationBank *)0x0;
    iVar3 = 10000;
    for (iVar2 = 0; iVar2 < pThis->fLocationCount; iVar2 = iVar2 + 1) {
      this_00 = bank + iVar2;
      if ((this_00->fBankId != -1) && (iVar1 = Distance__Q26Speech12LocationBanki(this_00,slice), iVar1 < iVar3)
         ) {
        iVar3 = iVar1;
        pLVar4 = this_00;
      }
    }
  }
  return pLVar4;
}

/* ---- FindLocation__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:624-788] SLD-VERIFIED ---- */
void FindLocation__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car)

{
  int slice;
  int actual;
  int reg_zero;
  int carPos_x;
  int loc_x_diff;
  int best_dist;
  LocationBank *this_00;
  int carPos_z;
  int loc_idx;
  int loc_x;
  int loc_z_diff;
  int loc_z;
  int loc_radius;
  int distance;
  int iVar1;
  LocationBank *location;
  double reg_f12_13;
  double reg_f14_15;
  
  carPos_x = fixedmult(car->currentSpeed,0x50000);
  if (carPos_x / 0x60000 < 0) {
    iVar1 = fixedmult(car->currentSpeed,0x50000);
    if (-1 < (int)(car->N).simRoadInfo.slice + iVar1 / 0x60000) goto FindLoc_noWrapCalc;
    iVar1 = fixedmult(car->currentSpeed,0x50000);
    iVar1 = (int)(car->N).simRoadInfo.slice + iVar1 / 0x60000 + gNumSlices;
  }
  else {
    loc_x_diff = fixedmult(car->currentSpeed,0x50000);
    if ((int)(car->N).simRoadInfo.slice + loc_x_diff / 0x60000 < gNumSlices) {
FindLoc_noWrapCalc:
      iVar1 = fixedmult(car->currentSpeed,0x50000);
      iVar1 = (int)(car->N).simRoadInfo.slice + iVar1 / 0x60000;
    }
    else {
      best_dist = fixedmult(car->currentSpeed,0x50000);
      iVar1 = ((int)(car->N).simRoadInfo.slice + best_dist / 0x60000) - gNumSlices;
    }
  }
  this_00 = (LocationBank *)
            (*(*pThis->_vf)[0x1d].pfn)
                      ((int)&(pThis->fPosition).flags + (int)(*pThis->_vf)[0x1d].delta,iVar1);
  if (this_00 == (LocationBank *)0x0) {
    (pThis->fDistance).flags = 0;
    (pThis->fPosition).flags = 0;
    pThis->fLocation = *(int *)(reg_zero + 8);
    return;
  }
  carPos_z = Distance__Q26Speech12LocationBanki(this_00,(int)(car->N).simRoadInfo.slice);
  iVar1 = Distance__Q26Speech12LocationBanki(this_00,iVar1);
  loc_idx = 4;
  if (iVar1 == 0) {
    (pThis->fDistance).flags = 0;
    goto FindLoc_assignIdx;
  }
  __floatsidf(iVar1);
  loc_z_diff = __ltdf2(reg_f12_13,reg_f14_15);
  if (loc_z_diff < 0) {
    (pThis->fDistance).flags = 0;
    if (iVar1 + 2 < carPos_z) {
      (pThis->fPosition).flags = 9;
    }
    if (iVar1 + -2 < carPos_z) {
      (pThis->fPosition).flags = 8;
      goto FindLoc_assignAndReturn;
    }
FindLoc_setIdxDefault:
    loc_idx = 2;
  }
  else {
    if (GameSetup_gData.measurement == 1) {
      if (iVar1 < 0xa6) {
        (pThis->fDistance).flags = 8;
        if (iVar1 + -2 < carPos_z) {
          (pThis->fPosition).flags = 0x10;
          goto FindLoc_assignAndReturn;
        }
      }
      else {
        loc_radius = 0x10;
        (pThis->fDistance).flags = 0x10;
        if (iVar1 + -2 < carPos_z) {
FindLoc_setRadiusReturn:
          (pThis->fPosition).flags = loc_radius;
          goto FindLoc_assignAndReturn;
        }
      }
      goto FindLoc_setIdxDefault;
    }
    if (iVar1 < 0x86) {
      (pThis->fDistance).flags = 1;
      if (carPos_z <= iVar1 + -2) goto FindLoc_setIdxDefault;
      loc_idx = 0x10;
    }
    else {
      loc_radius = 2;
      if (iVar1 < 0x10c) {
        (pThis->fDistance).flags = 2;
        if (carPos_z <= iVar1 + -2) goto FindLoc_setRadiusReturn;
        loc_idx = 0x10;
      }
      else {
        (pThis->fDistance).flags = 4;
        loc_idx = 0x10;
        if (carPos_z <= iVar1 + -2) goto FindLoc_setIdxDefault;
      }
    }
  }
FindLoc_assignIdx:
  (pThis->fPosition).flags = loc_idx;
FindLoc_assignAndReturn:
  pThis->fLocation = this_00->fBankId;
  return;
}

/* ---- CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci  [SPEECH.CPP:852-884] SLD-VERIFIED ---- */
bool CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(u_int param_1,u_int *bank,char *name,u_int id)

{
  CallSignBank *pThis;  /* folded receiver temp (SYM REG `this`) */
  int match;
  Speech_tCallSignDescription * d;
  int dispatchName;
  int bankid;
  int i;
  int unit;
  long lVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  bool bVar5;
  Speech_tCallSignDescription *pSVar6;
  
  lVar1 = strlen((u_long)Speech_gCallSignDescription[0].AllUnits);
  pSVar6 = Speech_gCallSignDescription;
  iVar2 = strncmp(name,Speech_gCallSignDescription[0].AllUnits,lVar1);
  if (iVar2 == 0) {
    *bank = id;
  }
  iVar3 = GameSetup_gData.track % 5;
  lVar1 = strlen((u_long)Speech_gCallSignDescription[0].Dispatch[iVar3]);
  iVar3 = strncmp(name,Speech_gCallSignDescription[0].Dispatch[iVar3],lVar1);
  iVar4 = 0;
  if (iVar3 == 0) {
    bank[1] = id;
  }
  bVar5 = iVar3 == 0 || iVar2 == 0;
  for (; iVar4 < 0xf; iVar4 = iVar4 + 1) {
    lVar1 = strlen((u_long)pSVar6->Mobile[0]);
    iVar2 = strncmp(name,pSVar6->Mobile[0],lVar1);
    if (iVar2 == 0) {
      bank[2] = id;
      bVar5 = true;
    }
    bank = bank + 1;
    pSVar6 = (Speech_tCallSignDescription *)pSVar6->Dispatch;
  }
  return bVar5;
}

/* ---- CheckMultiBank__6SpeechPciPQ26Speech11CarBankName  [SPEECH.CPP:889-924] SLD-VERIFIED ---- */
u_int CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(int param_1,char *name,u_int id,u_int bn)

{
  int iVar1;
  u_int uVar2;
  
  iVar1 = strncmp(name,(char *)(Speech_fgUndefined + 0x2c4),5);
  if (iVar1 == 0) {
    iVar1 = param_1 + 0x31c;
    name = name + 5;
CheckMBank_callSign:
    uVar2 = CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(param_1,iVar1,name,id);
  }
  else {
    iVar1 = strncmp(name,(char *)(Speech_fgUndefined + 0x2cc),7);
    if (iVar1 == 0) {
      name = name + 7;
      iVar1 = param_1 + 0x6c;
CheckMBank_carBank:
      uVar2 = CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName(param_1,iVar1,name,id,bn);
      return uVar2;
    }
    iVar1 = strncmp(name,"j:location\\",0xb);
    if (iVar1 == 0) {
      iVar1 = param_1 + 0x1d8;
    }
    else {
      iVar1 = strncmp(name,(char *)(Speech_fgUndefined + 0x2d4),6);
      if (iVar1 == 0) {
        iVar1 = param_1 + 0x2d8;
        name = name + 6;
        goto CheckMBank_callSign;
      }
      iVar1 = strncmp(name,"j:ccars\\",8);
      if (iVar1 == 0) {
        name = name + 8;
        iVar1 = param_1;
        goto CheckMBank_carBank;
      }
      iVar1 = strncmp(name,"j:clocaton\\",0xb);
      if (iVar1 != 0) {
        iVar1 = strncmp(name,(char *)(Speech_fgUndefined + 0x2dc),7);
        if (iVar1 == 0) {
          *(u_int *)(param_1 + 0x374) = id;
        }
        else {
          iVar1 = strncmp(name,"j:silenc.",9);
          if (iVar1 != 0) {
            return 1;
          }
          *(u_int *)(param_1 + 0x378) = id;
        }
        return 1;
      }
      iVar1 = param_1 + 0xd8;
    }
    uVar2 = CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(param_1,iVar1,name + 0xb,id);
  }
  return uVar2;
}

/* ---- CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3  [SPEECH.CPP:931-984] SLD-VERIFIED ---- */
int CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(int param_1,void *header,u_int bn,int *hoffset,int *hsize)

{
  Speech *pThis;  /* folded receiver temp (SYM REG `this`) */
  int bcount;
  int bsize;
  long offset;
  long size;
  int filecount;
  char * c;
  char * p;
  int b;
  int a;
  int i;
  char * name;
  u_char uVar1;
  u_char uVar2;
  u_char uVar3;
  u_char uVar4;
  char cVar5;
  bool bVar6;
  void *pvVar7;
  int iVar8;
  char *pcVar9;
  char *pcVar10;
  char *pcVar11;
  char *pcVar12;
  int iVar13;
  int iVar14;
  int iVar15;
  int local_30;
  int local_2c;
  
  iVar13 = 0;
  pvVar7 = locatebigentry(header,"j:eventdat\\event.dat",0,&local_30,(int)&local_2c);
  pcVar11 = (char *)((int)header + 0x10);
  if (pvVar7 == (void *)0x0) {
    iVar15 = 0;
  }
  else {
    pcVar9 = (char *)((int)header + 0xf);
    uVar1 = *(u_char *)((int)header + 8);
    uVar2 = *(u_char *)((int)header + 9);
    uVar3 = *(u_char *)((int)header + 10);
    uVar4 = *(u_char *)((int)header + 0xb);
    iVar15 = local_2c;
    for (iVar14 = 0; iVar14 < ((u_int)(((u_int)(((u_int)(uVar1) << 8 | (u_char)(uVar2))) << 8 | (u_char)(uVar3))) << 8 | (u_char)(uVar4));
        iVar14 = iVar14 + 1) {
      pcVar12 = pcVar11 + 8;
      local_30 = ((u_int)(((u_int)(((u_int)(*pcVar11) << 8 | (u_char)(pcVar9[2]))) << 8 | (u_char)(pcVar9[3]))) << 8 | (u_char)(pcVar9[4]));
      pcVar10 = pcVar9 + 8;
      local_2c = ((u_int)(((u_int)(((u_int)(pcVar9[5]) << 8 | (u_char)(pcVar9[6]))) << 8 | (u_char)(pcVar9[7]))) << 8 | (u_char)(pcVar9[8]));
      cVar5 = *pcVar12;
      pcVar11 = pcVar12;
      while (cVar5 != '\0') {
        pcVar11 = pcVar11 + 1;
        pcVar10 = pcVar10 + 1;
        cVar5 = *pcVar11;
      }
      bVar6 = false;
      if (((pcVar10[-3] == '.') && (pcVar10[-2] == 'h')) && (pcVar10[-1] == 'd')) {
        bVar6 = *pcVar10 == 'r';
      }
      if (bVar6) {
        if (*hoffset == 0) {
          *hoffset = local_30;
        }
        *hsize = (local_30 + local_2c) - *hoffset;
        iVar8 = CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(param_1,pcVar12,iVar13,bn);
        if (iVar8 != 0) {
          iVar13 = iVar13 + 1;
          iVar15 = iVar15 + local_2c;
        }
      }
      pcVar9 = pcVar10 + 1;
      pcVar11 = pcVar11 + 1;
    }
  }
  *(int *)(param_1 + 0x370) = iVar13;
  return iVar15;
}

/* ---- LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell  [SPEECH.CPP:990-1102] SLD-VERIFIED ---- */
void LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(int param_1,void *header,u_int bn,void *hoffset,int param_5)

{
  Speech *pThis;  /* folded receiver temp (SYM REG `this`) */
  long hsize;
  char * data;
  long offset;
  long size;
  int id;
  int dt;
  int filecount;
  char * c;
  char * hdata;
  void * banknames;
  char * p;
  int b;
  int i;
  char * name;
  int namelen;
  char cVar1;
  bool bVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  u_int *puVar6;
  char *pcVar7;
  char *pcVar8;
  char *pcVar9;
  int iVar10;
  u_char *puVar11;
  u_int uVar12;
  void *local_48;
  int local_44;
  int local_40;
  int local_3c;
  int local_38;
  void *local_34;
  u_int *local_30;
  int local_2c;
  
  local_40 = 0;
  local_3c = 0;
  iVar10 = *(int *)(param_1 + 0x36c) + *(int *)(param_1 + 0x370) * 4;
  locatebigentry(header,"j:eventdat\\event.dat",0,(int *)&local_48,(int)&local_44);
  FILE_readsync(*(int *)(param_1 + 0x368),local_48,iVar10,local_44,100);   /* oracle 0x85248: +size(local_44) +prio(0x64) */
  SPCH_ResolveData(iVar10);
  pcVar8 = (char *)((int)header + 0x10);
  puVar11 = (u_char *)(iVar10 + local_44);
  local_38 = ((u_int)(((u_int)(((u_int)(*(u_char *)((int)header + 8)) << 8 | (u_char)(*(u_char *)((int)header + 9)))) << 8 | (u_char)(*(u_char *)((int)header + 10)))) << 8 | (u_char)(*(u_char *)((int)header + 0xb)));
  local_34 = reservememadr("spch temp",param_5,0x10);
  uVar12 = 100;
  FILE_readsync(*(int *)(param_1 + 0x368),hoffset,(int)local_34,param_5,uVar12);   /* oracle 0x852c0: +size(param_5=$s3) +prio(uVar12=0x64) */
  local_30 = reservememadr("spch temp",*(int *)(param_1 + 0x370) << 2,0x10)
  ;
  iVar10 = 0;
  puVar6 = local_30;
  if (0 < *(int *)(param_1 + 0x370)) {
    do {
      *puVar6 = 0;
      *(u_int *)(iVar10 * 4 + *(int *)(param_1 + 0x36c)) = 0;
      iVar10 = iVar10 + 1;
      puVar6 = puVar6 + 1;
    } while (iVar10 < *(int *)(param_1 + 0x370));
  }
  pcVar7 = (char *)((int)header + 0xf);
  for (local_2c = 0; local_2c < local_38; local_2c = local_2c + 1) {
    systemtask(0);
    pcVar9 = pcVar8 + 8;
    iVar10 = 0;
    local_48 = (void *)((u_int)(((u_int)(((u_int)(*pcVar8) << 8 | (u_char)(pcVar7[2]))) << 8 | (u_char)(pcVar7[3]))) << 8 | (u_char)(pcVar7[4]));
    local_44 = ((u_int)(((u_int)(((u_int)(pcVar7[5]) << 8 | (u_char)(pcVar7[6]))) << 8 | (u_char)(pcVar7[7]))) << 8 | (u_char)(pcVar7[8]));
    pcVar7 = pcVar7 + 8;
    cVar1 = *pcVar9;
    pcVar8 = pcVar9;
    while (cVar1 != '\0') {
      iVar10 = iVar10 + 1;
      pcVar8 = pcVar8 + 1;
      pcVar7 = pcVar7 + 1;
      cVar1 = *pcVar8;
    }
    bVar3 = false;
    if (4 < iVar10) {
      bVar2 = false;
      if (((pcVar7[-3] == '.') && (pcVar7[-2] == 'h')) && (pcVar7[-1] == 'd')) {
        bVar2 = *pcVar7 == 'r';
      }
      if ((bVar2) && (iVar4 = CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(param_1,pcVar9,local_40,bn), iVar4 != 0)) {
        bVar3 = true;
      }
      if (bVar3) {
        local_40 = local_40 + 1;
        memcpy(puVar11,(u_char *)(((int)local_34 + (int)local_48) - (int)hoffset),local_44);
        iVar10 = SPCH_AddBank(puVar11);
        puVar11 = puVar11 + local_44;
        local_30[iVar10] = pcVar9;
      }
      else {
        bVar3 = false;
        if (((pcVar7[-3] == '.') && (pcVar7[-2] == 'd')) && (pcVar7[-1] == 'a')) {
          bVar3 = *pcVar7 == 't';
        }
        if (bVar3) {
          iVar4 = local_3c * 4;
          if (((local_3c < *(int *)(param_1 + 0x370)) && ((char *)local_30[local_3c] != (char *)0x0)
              ) && (iVar5 = strncmp(pcVar9,(char *)local_30[local_3c],iVar10 + -3), iVar5 == 0))
          {
            local_3c = local_3c + 1;
            *(void **)(iVar4 + *(int *)(param_1 + 0x36c)) = local_48;
          }
          else {
            iVar4 = 0;
            puVar6 = local_30;
            if (0 < *(int *)(param_1 + 0x370)) {
              do {
                if ((char *)*puVar6 != (char *)0x0) {
                  iVar5 = strncmp(pcVar9,(char *)*puVar6,iVar10 + -3);
                  if (iVar5 == 0) {
                    *(void **)(iVar4 * 4 + *(int *)(param_1 + 0x36c)) = local_48;
                    local_3c = iVar4 + 1;
                  }
                }
                iVar4 = iVar4 + 1;
                puVar6 = puVar6 + 1;
              } while (iVar4 < *(int *)(param_1 + 0x370));
            }
          }
        }
      }
    }
    pcVar7 = pcVar7 + 1;
    pcVar8 = pcVar8 + 1;
  }
  purgememadr(local_34);
  purgememadr(local_30);
  return;
}

/* ---- __6Speech  [SPEECH.CPP:1110-1228] SLD-VERIFIED ---- */
u_int * Speech_ct(u_int *param_1)

{
  CarBank *pThis;  /* folded receiver temp (SYM REG `this`) */
  int numracers;
  int numhumancops;
  int bn;
  int banksize;
  char * SpeechLanguage;
  int filename;
  char * header;
  long hoffset;
  long hsize;
  int i;
  bool bVar1;
  u_int *puVar2;
  u_int *puVar3;
  void *pvVar4;
  GameSetup_tData *pGVar5;
  int iVar6;
  void *pvVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  u_int uVar11;
  u_char *puVar12;
  u_char auStack_f8 [112];
  char acStack_88 [104];
  u_int local_20;
  u_int local_1c;
  
  iVar8 = 8;
  puVar2 = param_1 + 2;
  puVar3 = param_1;
  do {
    *puVar3 = 0xffffffff;
    puVar2[-1] = 0xffffffff;
    *puVar2 = 0xffffffff;
    puVar2 = puVar2 + 3;
    iVar8 = iVar8 + -1;
    puVar3 = puVar3 + 3;
  } while (iVar8 != -1);
  puVar2 = param_1 + 0x1b;
  iVar8 = 8;
  puVar3 = param_1 + 0x1d;
  do {
    *puVar2 = 0xffffffff;
    puVar3[-1] = 0xffffffff;
    *puVar3 = 0xffffffff;
    puVar3 = puVar3 + 3;
    iVar8 = iVar8 + -1;
    puVar2 = puVar2 + 3;
  } while (iVar8 != -1);
  puVar2 = param_1 + 0x36;
  iVar8 = 0xf;
  puVar3 = puVar2;
  do {
    puVar3[2] = 0xffffffff;
    iVar8 = iVar8 + -1;
    puVar3 = puVar3 + 4;
  } while (iVar8 != -1);
  puVar3 = param_1 + 0x76;
  iVar8 = 0xf;
  do {
    puVar3[2] = 0xffffffff;
    iVar8 = iVar8 + -1;
    puVar3 = puVar3 + 4;
  } while (iVar8 != -1);
  pvVar4 = __builtin_new(0x64);
  *(void ***)((int)pvVar4 + 0x4c) = (void**)Speaker_vtable;
  *(u_int *)((int)pvVar4 + 0x48) = 0;
  *(void ***)((int)pvVar4 + 0x4c) = (void**)DispatchSpeaker_vtable;
  param_1[0xe8] = pvVar4;
  puVar3 = param_1;
  for (iVar8 = 0; iVar10 = 0, iVar8 < 4; iVar8 = iVar8 + 1) {
    pvVar4 = __builtin_new(0x68);
    *(void ***)((int)pvVar4 + 0x4c) = (void**)Speaker_vtable;
    *(u_int *)((int)pvVar4 + 0x48) = 0;
    *(void ***)((int)pvVar4 + 0x4c) = (void**)MobileSpeaker_vtable;
    *(u_int *)((int)pvVar4 + 0x60) = 0;
    puVar3[0xe4] = pvVar4;
    puVar3 = puVar3 + 1;
  }
  iVar9 = 0;
  pGVar5 = &GameSetup_gData;
  param_1[0xd9] = 0;
  param_1[0xdb] = 0;
  iVar8 = 0;
  if (0 < GameSetup_gData.numCars) {
    do {
      iVar6 = pGVar5->carInfo[0].carClass;
      if ((iVar6 == 1) || (iVar6 == 2)) {
        iVar8 = iVar8 + 1;
      }
      else if (iVar6 == 0x41) {
        iVar10 = iVar10 + 1;
      }
      iVar9 = iVar9 + 1;
      pGVar5 = (GameSetup_tData *)((pGVar5->controllerData).shockImpact + 1);
    } while (iVar9 < GameSetup_gData.numCars);
  }
  if ((iVar10 == 0) && (1 < iVar8)) {
    param_1[0xe2] = 1;
  }
  else {
    param_1[0xe2] = 0;
  }
  iVar8 = 0;
  gettick();
  bVar1 = 0 < GameSetup_gData.numCars;
  param_1[0xdf] = GameSetup_gData.numCars;
  if (bVar1) {
    puVar12 = auStack_f8;
    do {
      SetCar__Q26Speech11CarBankNamei((u_int *)puVar12,iVar8);
      iVar8 = iVar8 + 1;
      puVar12 = puVar12 + 0xc;
    } while (iVar8 < (int)param_1[0xdf]);
  }
  CountLocations__6Speech(param_1);
  param_1[0xdc] = 0;
  iVar8 = 0;
  if (GameSetup_gData.languageSpeech == 2) {
    uVar11 = (u_int)gSpeechLangSuffix[0] /* @0x8013d06c "fre" */;
  }
  else if (GameSetup_gData.languageSpeech < 3) {
    if (GameSetup_gData.languageSpeech == 1) {
      uVar11 = (u_int)gSpeechLangSuffix[1] /* @0x8013d070 "ger" */;
    }
    else {
      uVar11 = (u_int)gSpeechLangSuffix[3] /* @0x8013d078 "eng" */;
    }
  }
  else if (GameSetup_gData.languageSpeech == 6) {
    uVar11 = (u_int)gSpeechLangSuffix[2] /* @0x8013d074 "brt" */;
  }
  else {
    uVar11 = (u_int)gSpeechLangSuffix[3] /* @0x8013d078 "eng" */;
  }
  sprintf(acStack_88,"%szzzz%s.viv",Paths_Paths[0x1d],uVar11);
  pvVar4 = (void *)loadbigfileheader(acStack_88,(void *)0x10);
  local_20 = 0;
  local_1c = 0;
  if (pvVar4 != (void *)0x0) {
    iVar8 = CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(param_1,pvVar4,auStack_f8,&local_20,&local_1c);
  }
  if (0 < iVar8) {
    pvVar7 = reservememadr("spch index",param_1[0xdc] * 4 + iVar8,0);
    param_1[0xdb] = pvVar7;
  }
  if (param_1[0xdb] != 0) {
    uVar11 = SPCH_GetSampleDataRate(0x2b11,0x10,2);
    SPCH_Init(Speech_HandleRequest__Fllll,0x12345678,uVar11);
    SPCH_InitBankMem(Speech_AllocateRAM__FlPc,
               Speech_PurgeRAM__FPc,param_1[0xdc]);
    iVar8 = FILE_opensync(acStack_88,1,100,(int)(param_1 + 0xda));
    param_1[0xd9] = (u_int)(iVar8 != 0);
    LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(param_1,pvVar4,auStack_f8,local_20,local_1c);
  }
  if (pvVar4 != (void *)0x0) {
    purgememadr(pvVar4);
  }
  gettick();
  return param_1;
}

/* ---- Reset__6Speech  [SPEECH.CPP:1248-1261] SLD-VERIFIED ---- */
void Reset__6Speech(void)

{
  MobileSpeaker *pThis;  /* folded receiver temp (SYM REG `this`) */
  int i;
  int *piVar1;
  bool bVar2;
  u_int uVar3;
  u_int uVar4;
  int iVar5;
  int iVar6;
  u_int uVar7;
  
  if (((int)Speech_fgSpeech) != 0) {
    iVar6 = 0;
    iVar5 = ((int)Speech_fgSpeech);
    while (bVar2 = iVar6 < 4, iVar6 = iVar6 + 1, bVar2) {
      piVar1 = (int *)(iVar5 + 0x390);
      iVar5 = iVar5 + 4;
      *(u_int *)(*piVar1 + 0x60) = 0;
    }
    SPCH_ClearEventQueue();
    randtemp = fastRandom * randSeed;
    fastRandom = randtemp & 0xffff;
    iSPCH_EACseedrandom((randtemp & 0xffff00) >> 8);
    uVar3 = fastRandom * randSeed;
    uVar4 = (uVar3 & 0xffff) * randSeed;
    randtemp = (uVar4 & 0xffff) * randSeed;
    uVar7 = (randtemp & 0xffff00) >> 8;
    fastRandom = randtemp & 0xffff;
    *(u_int *)(((int)Speech_fgSpeech) + 0x380) = ((uVar3 & 0xffff00) >> 8) % 9;
    *(u_int *)(((int)Speech_fgSpeech) + 900) = ((uVar4 & 0xffff00) >> 8) % 6;
    Activate__Q26Speech15DispatchSpeakeri(*(u_int *)(((int)Speech_fgSpeech) + 0x3a0),
               uVar7 + (uVar7 / 7 + (uVar7 - uVar7 / 7 >> 1) >> 2) * -7);
  }
  return;
}

/* ---- _._6Speech  [SPEECH.CPP:1267-1283] SLD-VERIFIED ---- */
void Speech_dt(void *param_1,u_int __in_chrg)

{
  int i;
  u_int *puVar1;
  void *pvVar2;
  int iVar3;
  
  if (*(int *)((int)param_1 + 0x36c) != 0) {
    SPCH_Deinit();
    purgememadr(*(void **)((int)param_1 + 0x36c));
  }
  if (*(int *)((int)param_1 + 0x364) != 0) {
    FILE_closesync(*(int *)((int)param_1 + 0x368),100);   /* oracle 0x85b84/b88: a1=0x64 (was dropped) */
  }
  iVar3 = 0;
  __builtin_delete(*(void **)((int)param_1 + 0x3a0));
  pvVar2 = param_1;
  do {
    puVar1 = (u_int *)((int)pvVar2 + 0x390);
    pvVar2 = (void *)((int)pvVar2 + 4);
    iVar3 = iVar3 + 1;
    __builtin_delete((void *)*puVar1);
  } while (iVar3 < 4);
  if ((__in_chrg & 1) != 0) {
    __builtin_delete(param_1);
  }
  return;
}

/* ---- BankPatch__6SpeechlP8Car_tObj  [SPEECH.CPP:1297-1307] SLD-VERIFIED ---- */
u_int BankPatch__6SpeechlP8Car_tObj(int param_1,int bank,int car)

{
  if (bank == *(int *)(param_1 + 0x378)) {
    return 0x15;
  }
  if (bank != *(int *)(param_1 + 0x374)) {
    return 0xffffffff;
  }
  if (car == 0) {
    return 0x13;
  }
  return 0x14;
}

/* ---- SubmitRequest__6Speechlll  [SPEECH.CPP:1317-1342] SLD-VERIFIED ---- */
int SubmitRequest__6Speechlll(int param_1,int localoffset,u_int size)

{
  Speech *pThis;  /* folded receiver temp (SYM REG `this`) */
  Car_tObj * car;
  int patch;
  long offset;
  long bank;
  int iVar1;
  int iVar2;
  u_int uVar3;
  
  if (((int)Speech_fgSpeech) == 0) {
    iVar2 = 0;
  }
  else {
    *(u_int *)(*(int *)(((int)Speech_fgSpeech) + 0x3a0) + 0x54) = 0;
    *(u_int *)(*(int *)(((int)Speech_fgSpeech) + 0x3a0) + 0x50) = 0x200;
    uVar3 = *(u_int *)(((int)Speech_fgSpeech) + 0x38c);
    iVar1 = BankPatch__6SpeechlP8Car_tObj(((int)Speech_fgSpeech),param_1,uVar3);
    if ((param_1 < 0) || (*(int *)(((int)Speech_fgSpeech) + 0x370) <= param_1)) {
      iVar2 = 0;
    }
    else {
      iVar2 = *(int *)(param_1 * 4 + *(int *)(((int)Speech_fgSpeech) + 0x36c));
    }
    if (iVar1 < 0) {
      if (iVar2 != 0) {
        CopSpeak_DirectRequest(*(u_int *)(((int)Speech_fgSpeech) + 0x368),iVar2 + localoffset,size,uVar3,0);
      }
      iVar2 = iVar2 + localoffset;
    }
    else {
      CopSpeak_GenericBankRequest(iVar1,uVar3);
      iVar2 = iVar2 + localoffset;
    }
  }
  return iVar2;
}

/* ---- Report__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1352-1356] SLD-VERIFIED ---- */
void Report__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *cop)

{
  return;
}

/* ---- Deny__Q26Speech7Speaker  [SPEECH.CPP:1363-1367] SLD-VERIFIED ---- */
void Deny__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Grant__Q26Speech7Speaker  [SPEECH.CPP:1371-1375] SLD-VERIFIED ---- */
void Grant__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Ready__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1379-1383] SLD-VERIFIED ---- */
void Ready__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *wing)

{
  return;
}

/* ---- Engage__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1394-1398] SLD-VERIFIED ---- */
void Engage__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *perp)

{
  return;
}

/* ---- Lose__Q26Speech7Speaker  [SPEECH.CPP:1402-1406] SLD-VERIFIED ---- */
void Lose__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Accident__Q26Speech7Speakeri  [SPEECH.CPP:1410-1414] SLD-VERIFIED ---- */
void Accident__Q26Speech7Speakeri(Speaker *pThis,int slice)

{
  return;
}

/* ---- Catch__Q26Speech7Speakeri  [SPEECH.CPP:1418-1422] SLD-VERIFIED ---- */
void Catch__Q26Speech7Speakeri(Speaker *pThis,int ticket)

{
  return;
}

/* ---- RoadBlock__Q26Speech7Speaker  [SPEECH.CPP:1426-1430] SLD-VERIFIED ---- */
void RoadBlock__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- SpikeBelt__Q26Speech7Speaker  [SPEECH.CPP:1434-1438] SLD-VERIFIED ---- */
void SpikeBelt__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Backup__Q26Speech7Speaker  [SPEECH.CPP:1442-1446] SLD-VERIFIED ---- */
void Backup__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- ReportBlockade__Q26Speech7Speaker  [SPEECH.CPP:1450-1454] SLD-VERIFIED ---- */
void ReportBlockade__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Roger__Q26Speech7Speaker  [SPEECH.CPP:1459-1463] SLD-VERIFIED ---- */
void Roger__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Bullhorn__Q26Speech7Speaker  [SPEECH.CPP:1467-1471] SLD-VERIFIED ---- */
void Bullhorn__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Purge__Q26Speech7Speaker  [SPEECH.CPP:1475-1479] SLD-VERIFIED ---- */
void Purge__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- Promote__Q26Speech7Speaker  [SPEECH.CPP:1490-1503] SLD-VERIFIED ---- */
void Promote__Q26Speech7Speaker(Speaker *pThis)

{
  Speaker * Sub;
  Speaker *pSVar1;
  int iVar2;
  Speaker *Super;
  Speaker *pSVar3;
  
  int cont;

  pSVar1 = (Speaker *)Dispatch__6Speech();
  do {
    pSVar3 = pSVar1;
    pSVar1 = pSVar3->fSub;
    cont = pSVar1 != (Speaker *)0x0 && pSVar1 != pThis;
  } while (cont);
  pSVar3->fSub = pThis->fSub;
  iVar2 = Dispatch__6Speech();
  pThis->fSub = *(Speaker **)(iVar2 + 0x48);
  iVar2 = Dispatch__6Speech();
  *(Speaker **)(iVar2 + 0x48) = pThis;
  return;
}

/* ---- Speech_Server__Fv  [SPEECH.CPP:1539-1540] SLD-VERIFIED ---- */
void Speech_Server__Fv(void)

{
  int iVar1;
  
  iVar1 = Dispatch__6Speech();
  (**(int (**)(...))(*(int *)(iVar1 + 0x4c) + 0x14))(iVar1 + *(short *)(*(int *)(iVar1 + 0x4c) + 0x10));
  return;
}

/* ---- SetDelayedStatus__6SpeechPQ26Speech7Speakeri  [SPEECH.CPP:1546-1548] SLD-VERIFIED ---- */
void SetDelayedStatus__6SpeechPQ26Speech7Speakeri(Speech *pThis,Speaker *sub,int delay)

{
  int iVar1;
  
  iVar1 = ((int)Speech_fgSpeech);
  *(Speaker **)(*(int *)(((int)Speech_fgSpeech) + 0x3a0) + 0x54) = sub;
  *(int *)(*(int *)(iVar1 + 0x3a0) + 0x50) = delay;
  return;
}

/* ---- Activate__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:1554-1571] SLD-VERIFIED ---- */
void Activate__Q26Speech15DispatchSpeakeri(int param_1,u_int seedupdatecount)

{
  Speaker *pThis;  /* folded receiver temp (SYM REG `this`) */
  int i;
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar1 = (**(int (**)(...))(*(int *)(param_1 + 0x4c) + 0xf4))
                    (param_1 + *(short *)(*(int *)(param_1 + 0x4c) + 0xf0));
  iVar3 = 1;
  iVar2 = param_1 + 4;
  *(u_int *)(param_1 + 0x38) = *(u_int *)(iVar1 + 4);
  iVar1 = GameSetup_gData.track;
  *(u_int *)(param_1 + 0x1c) = 0xff;
  *(u_int *)(param_1 + 0x20) = 0xf;
  *(u_int *)(param_1 + 0x48) = 0;
  *(u_int *)(param_1 + 0x18) = iVar1 & 1;
  do {
    *(u_int *)(iVar2 + 0x5c) = 0;
    iVar3 = iVar3 + -1;
    iVar2 = iVar2 + -4;
  } while (-1 < iVar3);
  *(u_int *)(param_1 + 0x50) = 0x200;
  *(u_int *)(param_1 + 0x54) = 0;
  *(u_int *)(param_1 + 0x58) = seedupdatecount;
  *(u_int *)(param_1 + 0x44) = 0;
  return;
}

/* ---- Dispatch__6Speech  [SPEECH.CPP:1578-1586] SLD-VERIFIED ---- */
int Dispatch__6Speech(void)

{
  Speaker *result;
  
  if ((((int)Speech_fgSpeech) != 0) && (*(int *)(((int)Speech_fgSpeech) + 0x36c) != 0)) {
    return *(int *)(((int)Speech_fgSpeech) + 0x3a0);
  }
  return (*(int *)&(Speech_fgUndefined));
}

/* ---- Roger__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1592-1629] SLD-VERIFIED ---- */
void Roger__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  bool bVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [31];
  int iVar4;
  Car_tObj *pCVar5;
  Speaker *pSVar6;
  SPCHNFSType_CONFIRM *pSVar7;
  SPCHNFSType_CONFIRM *reg_a1;
  SPCHNFSType_PERP_NAME *reg_a2;
  SPCHNFSType_CONFIRM *reg_a3;
  
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  pSVar6 = (pThis->_base_Speaker).fSub;
  bVar1 = false;
  if (((pSVar6 == (Speaker *)0x0) ||
      (iVar2 = (*(*pSVar6->_vf)[0x1b].pfn)
                         ((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x1b].delta),
      iVar2 == 0)) || ((((pThis->_base_Speaker).fSub)->fBlockade).flags != 0)) {
    bVar1 = true;
  }
  if (bVar1) {
    pSVar7 = &(pThis->_base_Speaker).fConfirm;
    SPCHNFS_D_A_CONFIRM(pSVar7);
  }
  else {
    pSVar6 = (pThis->_base_Speaker).fSub;
    if ((pSVar6->fArrest).flags == 0) {
      if ((pSVar6->fUpdate).flags == 0) {
        pSVar7 = &(pThis->_base_Speaker).fConfirm;
        SPCHNFS_D_A_CONFIRM(pSVar7);
        SPCH_PlaySpeech(pSVar7,(int)reg_a1,(int)reg_a2,(int)reg_a3);
        pSVar6 = (pThis->_base_Speaker).fSub;
        pa_Var3 = pSVar6->_vf;
        pCVar5 = (Car_tObj *)
                 (*(*pa_Var3)[0x1b].pfn)
                           ((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x1b].delta);
        SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
        reg_a1 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
        pSVar7 = (SPCHNFSType_CONFIRM *)&(pThis->_base_Speaker).fColour;
        SPCHNFS_D_C_PERP_LOST_CONFIRM((SPCHNFSType_COLOUR *)pSVar7,(int)reg_a1);
      }
      else {
        pCVar5 = (Car_tObj *)
                 (*(*pSVar6->_vf)[0x1b].pfn)
                           ((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x1b].delta);
        SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
        pa_Var3 = (pThis->_base_Speaker)._vf;
        iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
        pSVar6 = (pThis->_base_Speaker).fSub;
        pa_Var3 = pSVar6->_vf;
        iVar4 = (*(*pa_Var3)[0x11].pfn)
                          ((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x11].delta);
        pSVar6 = (pThis->_base_Speaker).fSub;
        (pThis->_base_Speaker).fTo = *(int *)(iVar2 + iVar4 * 4 + 8);
        pa_Var3 = pSVar6->_vf;
        iVar2 = (*(*pa_Var3)[0x18].pfn)
                          ((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x18].delta);
        pSVar7 = (SPCHNFSType_CONFIRM *)&(pThis->_base_Speaker).fColour;
        if (iVar2 < 0x280000) {
          reg_a3 = &(pThis->_base_Speaker).fConfirm;
          reg_a1 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
          reg_a2 = (SPCHNFSType_PERP_NAME *)(pThis->_base_Speaker).fTo;
          SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM((SPCHNFSType_COLOUR *)pSVar7,(int)reg_a1,(int)reg_a2,reg_a3,
                     &(pThis->_base_Speaker).fPerpName);
        }
        else {
          reg_a3 = &(pThis->_base_Speaker).fConfirm;
          reg_a1 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
          reg_a2 = (SPCHNFSType_PERP_NAME *)(pThis->_base_Speaker).fTo;
          SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM((SPCHNFSType_COLOUR *)pSVar7,(int)reg_a1,(int)reg_a2,reg_a3,
                     &(pThis->_base_Speaker).fPerpName);
        }
      }
    }
    else {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
      pSVar6 = (pThis->_base_Speaker).fSub;
      pa_Var3 = pSVar6->_vf;
      iVar4 = (*(*pa_Var3)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x11].delta)
      ;
      reg_a1 = &(pThis->_base_Speaker).fConfirm;
      pSVar7 = *(SPCHNFSType_CONFIRM **)(iVar2 + iVar4 * 4 + 8);
      reg_a2 = &(pThis->_base_Speaker).fPerpName;
      (pThis->_base_Speaker).fTo = (int)pSVar7;
      SPCHNFS_D_C_PERP_APPREHENSION_REPLY((int)pSVar7,reg_a1,reg_a2);
    }
  }
  SPCH_PlaySpeech(pSVar7,(int)reg_a1,(int)reg_a2,(int)reg_a3);
  return;
}

/* ---- StatusReply__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1636-1713] SLD-VERIFIED ---- */
void StatusReply__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  bool bVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [31];
  int iVar4;
  int *piVar5;
  Car_tObj *car;
  Speaker *pSVar6;
  u_long uVar7;
  SPCHNFSType_CONFIRM *CONFIRM;
  void *ctx;
  DispatchSpeaker *pDVar8;
  SPCHNFSType_DISTANCE *pSVar9;
  __vtbl_ptr_type (*reg_a1) [31];
  int reg_a2;
  SPCHNFSType_REVINTRO *REVINTRO;
  int reg_a3;
  Speaker *Blocker;
  Speaker *pSVar10;
  
  pSVar6 = (pThis->_base_Speaker).fSub;
  bVar1 = false;
  if ((pSVar6 == (Speaker *)0x0) ||
     (iVar2 = (*(*pSVar6->_vf)[0x1b].pfn)
                        ((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x1b].delta),
     iVar2 == 0)) {
    bVar1 = true;
  }
  iVar2 = ((int)Speech_fgSpeech);
  if (bVar1) {
    return;
  }
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  pSVar6 = (pThis->_base_Speaker).fSub;
  pSVar10 = (Speaker *)0x0;
  if ((pSVar6->fBlockade).flags == 0) {
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
    pSVar6 = (pThis->_base_Speaker).fSub;
    pa_Var3 = pSVar6->_vf;
    iVar4 = (*(*pa_Var3)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x11].delta);
    ctx = *(void **)(iVar2 + iVar4 * 4 + 8);
    iVar2 = (pThis->_base_Speaker).fFrom;
    (pThis->_base_Speaker).fTo = (int)ctx;
  }
  else {
    if (*(int *)(iVar2 + 0x388) != 0) {
      (*(*pSVar6->_vf)[0xd].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0xd].delta);
      return;
    }
    pSVar10 = pSVar6->fSub;
    bVar1 = false;
    if (pSVar10 != (Speaker *)0x0) {
      bVar1 = (pSVar10->fBlockade).flags != 0;
    }
    if (bVar1) {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
      pSVar6 = (pThis->_base_Speaker).fSub;
      reg_a1 = pSVar6->_vf;
      iVar4 = (*(*reg_a1)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*reg_a1)[0x11].delta);
      (pThis->_base_Speaker).fTo = *(int *)(iVar2 + iVar4 * 4 + 8);
      pSVar6 = pSVar10;
    }
    else {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      piVar5 = (int *)(*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
      (pThis->_base_Speaker).fTo = *piVar5;
    }
    (*(*pSVar6->_vf)[0xd].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0xd].delta);
    CONFIRM = &(pThis->_base_Speaker).fConfirm;
    *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
    SPCHNFS_D_A_CONFIRM(CONFIRM);
    SPCH_PlaySpeech(CONFIRM,(int)reg_a1,reg_a2,reg_a3);
    ctx = (void *)(pThis->_base_Speaker).fTo;
    iVar2 = (pThis->_base_Speaker).fFrom;
    pSVar10 = pSVar6;
  }
  REVINTRO = &(pThis->_base_Speaker).fReverse;
  SPCHNFS_D_C_INTRO_CALL((int)ctx,iVar2,REVINTRO);
  SPCH_PlaySpeech(ctx,iVar2,(int)REVINTRO,reg_a3);
  pSVar6 = (pThis->_base_Speaker).fSub;
  pa_Var3 = pSVar6->_vf;
  car = (Car_tObj *)
        (*(*pa_Var3)[0x19].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x19].delta);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
  pSVar6 = (pThis->_base_Speaker).fSub;
  uVar7 = (pSVar6->fBlockade).flags;
  pDVar8 = pThis;
  if (uVar7 == 1) {
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
    iVar4 = (*(*pSVar10->_vf)[0x11].pfn)
                      ((int)&(pSVar10->fPosition).flags + (int)(*pSVar10->_vf)[0x11].delta);
    pSVar9 = &(pThis->_base_Speaker).fDistance;
    reg_a3 = *(int *)(iVar2 + iVar4 * 4 + 8);
    iVar2 = (pThis->_base_Speaker).fLocation;
    (pThis->_base_Speaker).fSpikeSide.flags = 4;
    (pThis->_base_Speaker).fWing = reg_a3;
    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,iVar2,pSVar9,reg_a3,&(pThis->_base_Speaker).fSpikeSide);
  }
  else {
    if (uVar7 != 2) {
      if (pSVar6->fSub != (Speaker *)0x0) {
        pa_Var3 = (pThis->_base_Speaker)._vf;
        iVar2 = (*(*pa_Var3)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var3)[0x1e].delta + -0x5c);
        pSVar6 = ((pThis->_base_Speaker).fSub)->fSub;
        pa_Var3 = pSVar6->_vf;
        iVar4 = (*(*pa_Var3)[0x11].pfn)
                          ((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0x11].delta);
        pSVar9 = &(pThis->_base_Speaker).fDistance;
        iVar4 = *(int *)(iVar2 + iVar4 * 4 + 8);
        iVar2 = (pThis->_base_Speaker).fLocation;
        (pThis->_base_Speaker).fWing = iVar4;
        SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(pSVar9,(SPCHNFSType_POSITION *)pThis,iVar2,iVar4);
        SPCH_PlaySpeech(pSVar9,(int)pDVar8,iVar2,iVar4);
        pSVar6 = (pThis->_base_Speaker).fSub;
        pa_Var3 = pSVar6->_vf;
        (*(*pa_Var3)[0xe].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pa_Var3)[0xe].delta);
        pSVar6 = ((pThis->_base_Speaker).fSub)->fSub;
        pThis->fStatusCount = 0x140;
        pThis->fUpdateCount = pThis->fUpdateCount + 1;
        pThis->fStatusSub = pSVar6;
      }
      goto StatusReply_subFetch;
    }
    iVar2 = (pThis->_base_Speaker).fLocation;
    pSVar9 = &(pThis->_base_Speaker).fDistance;
    SPCHNFS_D_C_RDBLK_CONFIRMED((SPCHNFSType_POSITION *)pThis,iVar2,pSVar9);
  }
  SPCH_PlaySpeech(pDVar8,iVar2,(int)pSVar9,reg_a3);
  pSVar6 = (pThis->_base_Speaker).fSub;
  if (pSVar10 != pSVar6) {
    (*(*pSVar6->_vf)[0xe].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0xe].delta);
  }
StatusReply_subFetch:
  pSVar10 = (pThis->_base_Speaker).fSub;
  pSVar6 = pSVar10->fSub;
  bVar1 = false;
  if (pSVar6 != (Speaker *)0x0) {
    bVar1 = (pSVar6->fBlockade).flags != 0;
  }
  if (bVar1) {
    (pSVar10->fBlockade).flags = 0;
  }
  return;
}

/* ---- Status__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1718-1848] SLD-VERIFIED ---- */
void Status__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  short sVar1;
  bool bVar2;
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  int tu5;
  int iVar5;
  Car_tObj *pCVar6;
  u_long uVar7;
  int (*tstr8)(...);
  Speaker *pSVar8;
  DispatchSpeaker *pDVar9;
  u_int uVar10;
  int dist;
  void *ctx;
  SPCHNFSType_PURS_UPDT *PURS_UPDT;
  SPCHNFSType_REVINTRO *REVINTRO;
  int reg_a3;
  
  pSVar8 = (pThis->_base_Speaker).fSub;
  bVar2 = false;
  if ((pSVar8 == (Speaker *)0x0) ||
     (dist = (int)(*pSVar8->_vf)[0x1b].delta,
     iVar3 = (*(*pSVar8->_vf)[0x1b].pfn)((int)&(pSVar8->fPosition).flags + dist), iVar3 == 0)) {
    bVar2 = true;
  }
  if (bVar2) {
    return;
  }
  pSVar8 = (pThis->_base_Speaker).fSub;
  pa_Var4 = pSVar8->_vf;
  iVar3 = (*(*pa_Var4)[0x19].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x19].delta);
  if ((*(u_int *)(iVar3 + 0x260) & 0x200) != 0) {
    pSVar8 = (pThis->_base_Speaker).fSub;
    pa_Var4 = pSVar8->_vf;
    iVar3 = (*(*pa_Var4)[0x18].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x18].delta);
    pSVar8 = (pThis->_base_Speaker).fSub;
    if (pSVar8->fHavePerp == 0) {
      if (iVar3 < 0x640000) {
        pa_Var4 = pSVar8->_vf;
        sVar1 = (*pa_Var4)[6].delta;
        tu5 = (*(*pa_Var4)[0x1b].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x1b].delta)
        ;
        (*(*pa_Var4)[6].pfn)((int)&(pSVar8->fPosition).flags + (int)sVar1,tu5);
      }
    }
    else if (0x15e0000 < iVar3) {
      pSVar8->fHavePerp = 0;
      (((pThis->_base_Speaker).fSub)->fUpdate).flags = 0;
      pSVar8 = (pThis->_base_Speaker).fSub;
      pa_Var4 = pSVar8->_vf;
      (*(*pa_Var4)[2].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[2].delta);
    }
  }
  if (pThis->fStatusSub != (Speaker *)0x0) {
    iVar3 = pThis->fStatusCount + -1;
    pThis->fStatusCount = iVar3;
    if (iVar3 != 0) {
      return;
    }
    pDVar9 = (DispatchSpeaker *)pThis->fStatusSub;
    if (pDVar9 == pThis) {
      StatusReply__Q26Speech15DispatchSpeaker(pThis);
      return;
    }
    pSVar8 = (pThis->_base_Speaker).fSub;
    bVar2 = false;
    if (pSVar8 != (Speaker *)0x0) {
      bVar2 = pDVar9 == (DispatchSpeaker *)pSVar8->fSub;
    }
    if (bVar2) {
      pa_Var4 = (pDVar9->_base_Speaker)._vf;
      (*(*pa_Var4)[2].pfn)((int)pDVar9->fPerp + (*pa_Var4)[2].delta + -0x5c);
      return;
    }
    pa_Var4 = (pDVar9->_base_Speaker)._vf;
    (*(*pa_Var4)[2].pfn)((int)pDVar9->fPerp + (*pa_Var4)[2].delta + -0x5c);
    *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
    pa_Var4 = (pThis->_base_Speaker)._vf;
    (*(*pa_Var4)[0xe].pfn)((int)pThis->fPerp + (*pa_Var4)[0xe].delta + -0x5c);
    return;
  }
  if (0 < pThis->fStatusCount) {
    pThis->fStatusCount = pThis->fStatusCount + -1;
    return;
  }
  pSVar8 = (pThis->_base_Speaker).fSub;
  bVar2 = false;
  if ((pSVar8->fBlockade).flags == 0) {
    bVar2 = (pSVar8->fArrest).flags == 0;
  }
  if (!bVar2) {
    return;
  }
  pSVar8 = pSVar8->fSub;
  bVar2 = false;
  if (pSVar8 != (Speaker *)0x0) {
    iVar3 = (*(*pSVar8->_vf)[0x1b].pfn)
                      ((int)&(pSVar8->fPosition).flags + (int)(*pSVar8->_vf)[0x1b].delta);
    pSVar8 = (pThis->_base_Speaker).fSub;
    pa_Var4 = pSVar8->_vf;
    iVar5 = (*(*pa_Var4)[0x1b].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x1b].delta);
    bVar2 = iVar3 != iVar5;
  }
  if (bVar2) {
    Promote__Q26Speech7Speaker(((pThis->_base_Speaker).fSub)->fSub);
  }
  uVar10 = pThis->fUpdateCount & 3;
  if (uVar10 == 1) {
DispStatus_updateCount1:
    pSVar8 = (pThis->_base_Speaker).fSub;
    uVar7 = 1;
  }
  else {
    if (uVar10 < 2) {
      if (uVar10 != 0) goto DispStatus_fetchSpeechCtx;
    }
    else {
      if (uVar10 != 2) {
        if (uVar10 != 3) goto DispStatus_fetchSpeechCtx;
        pSVar8 = (pThis->_base_Speaker).fSub;
        pa_Var4 = pSVar8->_vf;
        iVar3 = (*(*pa_Var4)[0x14].pfn)
                          ((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x14].delta);
        if ((iVar3 != 0) && (pThis->fUpdateCount == 7)) {
          (((pThis->_base_Speaker).fSub)->fUpdate).flags = 0;
          pSVar8 = (pThis->_base_Speaker).fSub;
          sVar1 = (*pSVar8->_vf)[2].delta;
          tstr8 = (*pSVar8->_vf)[2].pfn;
call_subspeaker_vf: /* @0x80096aa0 */
          (*tstr8)((int)&(pSVar8->fPosition).flags + (int)sVar1);
          pThis->fUpdateCount = pThis->fUpdateCount + 1;
          return;
        }
        pSVar8 = (pThis->_base_Speaker).fSub;
        pa_Var4 = pSVar8->_vf;
        iVar3 = (*(*pa_Var4)[0x18].pfn)
                          ((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x18].delta);
        if (iVar3 < 0x140000) {
          pSVar8 = (pThis->_base_Speaker).fSub;
          sVar1 = (*pSVar8->_vf)[0xf].delta;
          tstr8 = (*pSVar8->_vf)[0xf].pfn;
          goto call_subspeaker_vf;
        }
        goto DispStatus_updateCount1;
      }
      pSVar8 = (pThis->_base_Speaker).fSub;
      pa_Var4 = pSVar8->_vf;
      bVar2 = false;
      iVar3 = (*(*pa_Var4)[0x18].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x18].delta)
      ;
      if (iVar3 < 0x280000) {
        pSVar8 = (pThis->_base_Speaker).fSub;
        pa_Var4 = pSVar8->_vf;
        pCVar6 = (Car_tObj *)
                 (*(*pa_Var4)[0x19].pfn)
                           ((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x19].delta);
        iVar3 = CalcMph__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar6);
        if (0x32 < iVar3) {
          pSVar8 = (pThis->_base_Speaker).fSub;
          pa_Var4 = pSVar8->_vf;
          pCVar6 = (Car_tObj *)
                   (*(*pa_Var4)[0x1b].pfn)
                             ((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x1b].delta);
          iVar3 = CalcMph__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar6);
          bVar2 = 0x32 < iVar3;
        }
      }
      if (bVar2) {
        (((pThis->_base_Speaker).fSub)->fUpdate).flags = 8;
        goto DispStatus_fetchSpeechCtx;
      }
    }
    pSVar8 = (pThis->_base_Speaker).fSub;
    uVar7 = 0x26;
  }
  (pSVar8->fUpdate).flags = uVar7;
DispStatus_fetchSpeechCtx:
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  pa_Var4 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var4)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var4)[0x1e].delta + -0x5c);
  pSVar8 = (pThis->_base_Speaker).fSub;
  pa_Var4 = pSVar8->_vf;
  iVar5 = (*(*pa_Var4)[0x11].pfn)((int)&(pSVar8->fPosition).flags + (int)(*pa_Var4)[0x11].delta);
  ctx = *(void **)(iVar3 + iVar5 * 4 + 8);
  iVar3 = (pThis->_base_Speaker).fFrom;
  REVINTRO = &(pThis->_base_Speaker).fReverse;
  (pThis->_base_Speaker).fTo = (int)ctx;
  SPCHNFS_D_C_INTRO_CALL((int)ctx,iVar3,REVINTRO);
  SPCH_PlaySpeech(ctx,iVar3,(int)REVINTRO,reg_a3);
  PURS_UPDT = &((pThis->_base_Speaker).fSub)->fUpdate;
  SPCHNFS_D_C_IN_PURS_NEAR_PERP(PURS_UPDT);
  SPCH_PlaySpeech(PURS_UPDT,iVar3,(int)REVINTRO,reg_a3);
  pSVar8 = (pThis->_base_Speaker).fSub;
  pThis->fStatusCount = 0x60;
  pThis->fStatusSub = pSVar8;
  pThis->fUpdateCount = pThis->fUpdateCount + 1;
  return;
}

/* ---- Status__Q26Speech13MobileSpeaker  [SPEECH.CPP:1853-1948] SLD-VERIFIED ---- */
void Status__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Speaker * Sub;
  bool bVar1;
  bool bVar2;
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var3) [31];
  int iVar4;
  Car_tObj *pCVar5;
  u_int *puVar6;
  Speaker *pSVar7;
  u_long uVar8;
  SPCHNFSType_VOICE *pSVar9;
  SPCHNFSType_VOICE *pSVar10;
  SPCHNFSType_COLOUR *COLOUR;
  SPCHNFSType_vs_KMH_MPH *vs_KMH_MPH;
  int iVar11;
  SPCHNFSType_REVINTRO *REVINTRO;
  MobileSpeaker *pMVar12;
  u_int uVar13;
  
  pa_Var3 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var3)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
  if (iVar4 == 0) {
    return;
  }
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  if ((pThis->_base_Speaker).fArrest.flags == 1) {
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
    pSVar10 = &pThis->fVoice;
    iVar4 = *(int *)(iVar4 + 4);
    vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fFrom;
    pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = iVar4;
    pSVar9 = pSVar10;
    SPCHNFS_C_A_INTRO(pSVar10,iVar4,(int)vs_KMH_MPH,(SPCHNFSType_REVINTRO *)pMVar12);
    SPCH_PlaySpeech(pSVar9,iVar4,(int)vs_KMH_MPH,(int)pMVar12);
    pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fPerpName;
    SPCHNFS_C_D_PERP_APPREHENSION(pSVar10,(SPCHNFSType_PERP_NAME *)pCVar5);
  }
  else {
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x19].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x19].delta);
    bVar1 = false;
    if ((*(u_int *)(iVar4 + 0x260) & 0x200) != 0) {
      bVar1 = (pThis->_base_Speaker).fUpdate.flags == 0;
    }
    bVar2 = false;
    if (bVar1) {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &pThis->fVoice;
      iVar4 = *(int *)(iVar4 + 4);
      iVar11 = (pThis->_base_Speaker).fFrom;
      REVINTRO = &(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = iVar4;
      pSVar9 = pSVar10;
      SPCHNFS_C_A_INTRO(pSVar10,iVar4,iVar11,REVINTRO);
      SPCH_PlaySpeech(pSVar9,iVar4,iVar11,(int)REVINTRO);
      pa_Var3 = (pThis->_base_Speaker)._vf;
      pCVar5 = (Car_tObj *)
               (*(*pa_Var3)[0x1b].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
      FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pThis->fCarObj);
      COLOUR = &(pThis->_base_Speaker).fColour;
      iVar4 = (pThis->_base_Speaker).fCar;
      pMVar12 = pThis;
      SPCHNFS_C_D_PERP_LOST(pSVar10,COLOUR,iVar4,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
                 &(pThis->_base_Speaker).fDistance,&(pThis->_base_Speaker).fPerpName);
      SPCH_PlaySpeech(pSVar10,(int)COLOUR,iVar4,(int)pMVar12);
      iVar4 = Dispatch__6Speech();
      uVar13 = *(u_int *)(iVar4 + 0x48);
      iVar4 = Dispatch__6Speech();
      *(MobileSpeaker **)(iVar4 + 0x48) = pThis;
      iVar4 = Dispatch__6Speech();
      (**(int (**)(...))(*(int *)(iVar4 + 0x4c) + 0x74))
                (iVar4 + *(short *)(*(int *)(iVar4 + 0x4c) + 0x70));
      iVar4 = Dispatch__6Speech();
      *(u_int *)(iVar4 + 0x48) = uVar13;
      return;
    }
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x14].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x14].delta);
    if (((iVar4 != 0) && ((pThis->_base_Speaker).fUpdate.flags == 0)) &&
       (pSVar7 = (pThis->_base_Speaker).fSub, pSVar7 != (Speaker *)0x0)) {
      iVar4 = (*(*pSVar7->_vf)[0x19].pfn)
                        ((int)&(pSVar7->fPosition).flags + (int)(*pSVar7->_vf)[0x19].delta);
      bVar2 = (*(u_int *)(iVar4 + 0x260) & 0x40) == 0;
    }
    if (bVar2) {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      puVar6 = (u_int *)
               (*(*pa_Var3)[0x1e].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &pThis->fVoice;
      pCVar5 = (Car_tObj *)*puVar6;
      vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fFrom;
      pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = (int)pCVar5;
      pSVar9 = pSVar10;
      SPCHNFS_C_A_INTRO(pSVar10,(int)pCVar5,(int)vs_KMH_MPH,(SPCHNFSType_REVINTRO *)pMVar12);
      SPCH_PlaySpeech(pSVar9,(int)pCVar5,(int)vs_KMH_MPH,(int)pMVar12);
      SPCHNFS_S_C_SUPER_COP_CRITICISM(pSVar10);
    }
    else {
      bVar1 = false;
      iVar4 = Dispatch__6Speech();
      if (*(int *)(iVar4 + 0x48) != 0) {
        iVar4 = Dispatch__6Speech();
        bVar1 = *(MobileSpeaker **)(*(int *)(iVar4 + 0x48) + 0x48) == pThis;
      }
      if (bVar1) {
        SPCHNFS_C_C_NEW_OFFICER_ENGAGING(&pThis->fVoice,(pThis->_base_Speaker).fFrom);
        iVar4 = Dispatch__6Speech();
        iVar11 = *(int *)(*(int *)(iVar4 + 0x48) + 0x4c);
        (**(int (**)(...))(iVar11 + 0x74))(*(int *)(iVar4 + 0x48) + (int)*(short *)(iVar11 + 0x70));
        return;
      }
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &pThis->fVoice;
      iVar4 = *(int *)(iVar4 + 4);
      vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fFrom;
      pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = iVar4;
      pSVar9 = pSVar10;
      SPCHNFS_C_A_INTRO(pSVar10,iVar4,(int)vs_KMH_MPH,(SPCHNFSType_REVINTRO *)pMVar12);
      SPCH_PlaySpeech(pSVar9,iVar4,(int)vs_KMH_MPH,(int)pMVar12);
      pa_Var3 = (pThis->_base_Speaker)._vf;
      pCVar5 = (Car_tObj *)
               (*(*pa_Var3)[0x1b].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
      pa_Var3 = (pThis->_base_Speaker)._vf;
      pCVar5 = (Car_tObj *)
               (*(*pa_Var3)[0x19].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x19].delta);
      FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
      pCVar5 = pThis->fPerp;
      SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(pThis,pCVar5);
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x18].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x18].delta);
      if (iVar4 < 0x280000) {
        pa_Var3 = (pThis->_base_Speaker)._vf;
        iVar4 = (*(*pa_Var3)[0x1b].pfn)
                          ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
        if (0x40 < *(u_short *)(iVar4 + 0x17c)) {
          SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(pSVar10);
          goto DispStatus_playSpeechReturn;
        }
        uVar8 = (pThis->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fLocation;
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
          SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC(pSVar10,(SPCHNFSType_POSITION *)pThis,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12);
          pCVar5 = (Car_tObj *)pThis;
          goto DispStatus_playSpeechReturn;
        }
        if (uVar8 != 8) {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fCar;
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
          SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(pSVar10,(SPCHNFSType_COLOUR *)pCVar5,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,(SPCHNFSType_POSITION *)pThis,
                     (pThis->_base_Speaker).fLocation);
          goto DispStatus_playSpeechReturn;
        }
      }
      else if ((pThis->_base_Speaker).fHavePerp == 0) {
        uVar8 = (pThis->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fLocation;
          SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC(pSVar10,(SPCHNFSType_POSITION *)pThis,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,&(pThis->_base_Speaker).fColour,(pThis->_base_Speaker).fCar);
          pCVar5 = (Car_tObj *)pThis;
          goto DispStatus_playSpeechReturn;
        }
        if (uVar8 != 8) {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fCar;
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fPerpName;
          SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(pSVar10,(SPCHNFSType_COLOUR *)pCVar5,(int)vs_KMH_MPH,
                     (SPCHNFSType_PERP_NAME *)pMVar12);
          goto DispStatus_playSpeechReturn;
        }
      }
      else {
        uVar8 = (pThis->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fLocation;
          SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC(pSVar10,(SPCHNFSType_POSITION *)pThis,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,&(pThis->_base_Speaker).fColour,(pThis->_base_Speaker).fCar,
                     &(pThis->_base_Speaker).fPerpName);
          pCVar5 = (Car_tObj *)pThis;
          goto DispStatus_playSpeechReturn;
        }
        if (uVar8 != 8) {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fCar;
          SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS(pSVar10,(SPCHNFSType_COLOUR *)pCVar5,(int)vs_KMH_MPH,
                     (SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
                     &(pThis->_base_Speaker).fDistance);
          pMVar12 = pThis;
          goto DispStatus_playSpeechReturn;
        }
      }
      pCVar5 = (Car_tObj *)pThis->fSpeed;
      vs_KMH_MPH = &pThis->fSpeedType;
      SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(pSVar10,(int)pCVar5,vs_KMH_MPH);
    }
  }
DispStatus_playSpeechReturn:
  SPCH_PlaySpeech(pSVar10,(int)pCVar5,(int)vs_KMH_MPH,(int)pMVar12);
  return;
}

/* ---- ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1954-1958] SLD-VERIFIED ---- */
void ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (pThis->fPerp[i] == car) {
      pThis->fPerp[i] = (Car_tObj *)0x0;
    }
    i = i + 1;
  } while (i < 2);
  return;
}

/* ---- KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1964-1969] SLD-VERIFIED ---- */
void * KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (pThis->fPerp[i] != car) {
      i = i + 1;
    }
    else {
      return (void *)0x1;
    }
  } while (i < 2);
  return (void *)0x0;
}

/* ---- AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1976-1980] SLD-VERIFIED ---- */
void AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (pThis->fPerp[i] == (Car_tObj *)0x0) {
      pThis->fPerp[i] = car;
    }
    i = i + 1;
  } while (i < 2);
  return;
}

/* ---- Report__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1990-2031] SLD-VERIFIED ---- */
void Report__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *perp)

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  int iVar4;
  int *piVar5;
  Speaker *pSVar6;
  SPCHNFSType_CONFIRM *CONFIRM;
  void *ctx;
  SPCHNFSType_COLOUR *COLOUR;
  int reg_a2;
  SPCHNFSType_REVINTRO *REVINTRO;
  DispatchSpeaker *param2;
  int reg_a3;
  
  bVar1 = false;
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x12].pfn)((int)pThis->fPerp + (*pa_Var2)[0x12].delta + -0x5c);
  if (iVar3 != 0) {
    bVar1 = (pThis->_base_Speaker).fSub != (Speaker *)0x0;
  }
  if (bVar1) {
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      pa_Var2 = (pThis->_base_Speaker)._vf;
      iVar3 = (*(*pa_Var2)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var2)[0x1e].delta + -0x5c);
      pSVar6 = (pThis->_base_Speaker).fSub;
      pa_Var2 = pSVar6->_vf;
      iVar4 = (*(*pa_Var2)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pa_Var2)[0x11].delta)
      ;
      iVar3 = *(int *)(iVar3 + iVar4 * 4 + 8);
      CONFIRM = &(pThis->_base_Speaker).fConfirm;
      (pThis->_base_Speaker).fTo = iVar3;
      SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(CONFIRM,iVar3);
      SPCH_PlaySpeech(CONFIRM,iVar3,reg_a2,reg_a3);
    }
  }
  else {
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      pa_Var2 = (pThis->_base_Speaker)._vf;
      piVar5 = (int *)(*(*pa_Var2)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var2)[0x1e].delta + -0x5c);
      ctx = (void *)*piVar5;
      iVar3 = (pThis->_base_Speaker).fFrom;
      REVINTRO = &(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = (int)ctx;
      SPCHNFS_D_C_INTRO_CALL((int)ctx,iVar3,REVINTRO);
      SPCH_PlaySpeech(ctx,iVar3,(int)REVINTRO,reg_a3);
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
      FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
      COLOUR = &(pThis->_base_Speaker).fColour;
      iVar3 = (pThis->_base_Speaker).fCar;
      iVar4 = (pThis->_base_Speaker).fLocation;
      param2 = pThis;
      SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(COLOUR,iVar3,(SPCHNFSType_POSITION *)pThis,iVar4,&(pThis->_base_Speaker).fDistance);
      SPCH_PlaySpeech(COLOUR,iVar3,(int)param2,iVar4);
    }
    AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj(pThis,perp);
    pThis->fStatusCount = 0x2a0;
  }
  return;
}

/* ---- Accident__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:2039-2043] SLD-VERIFIED ---- */
void Accident__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int slice)

{
  return;
}

/* ---- Deny__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2049-2073] SLD-VERIFIED ---- */
void Deny__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  int iVar3;
  Speaker *pSVar4;
  void *ctx;
  SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP;
  SPCHNFSType_REVINTRO *REVINTRO;
  int reg_a3;
  
  if ((pThis->_base_Speaker).fSub != (Speaker *)0x0) {
    *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
    pa_Var1 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var1)[0x1e].pfn)((int)pThis->fPerp + (*pa_Var1)[0x1e].delta + -0x5c);
    pSVar4 = (pThis->_base_Speaker).fSub;
    pa_Var1 = pSVar4->_vf;
    iVar3 = (*(*pa_Var1)[0x11].pfn)((int)&(pSVar4->fPosition).flags + (int)(*pa_Var1)[0x11].delta);
    ctx = *(void **)(iVar2 + iVar3 * 4 + 8);
    iVar2 = (pThis->_base_Speaker).fFrom;
    REVINTRO = &(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = (int)ctx;
    SPCHNFS_D_C_INTRO_CALL((int)ctx,iVar2,REVINTRO);
    SPCH_PlaySpeech(ctx,iVar2,(int)REVINTRO,reg_a3);
    pSVar4 = (pThis->_base_Speaker).fSub;
    vs_RDBLK_SSTRP = &pSVar4->fBlockade;
    if ((pSVar4->fBlockade).flags == 0) {
      SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY();
    }
    else {
      SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(vs_RDBLK_SSTRP);
    }
    SPCH_PlaySpeech(vs_RDBLK_SSTRP,iVar2,(int)REVINTRO,reg_a3);
    (((pThis->_base_Speaker).fSub)->fBlockade).flags = 0;
  }
  return;
}

/* ---- Grant__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2079-2098] SLD-VERIFIED ---- */
void Grant__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  int *piVar1;
  Speaker *pSVar2;
  SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP;
  SPCHNFSType_CONFIRM *CONFIRM;
  int reg_a2;
  int reg_a3;
  
  pSVar2 = (pThis->_base_Speaker).fSub;
  if (((pSVar2 != (Speaker *)0x0) && (pSVar2 != (Speaker *)0xffffffec)) &&
     (piVar1 = (int *)(((int)Speech_fgSpeech) + 0x388), *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0,
     *piVar1 == 0)) {
    CONFIRM = &(pThis->_base_Speaker).fConfirm;
    vs_RDBLK_SSTRP = &((pThis->_base_Speaker).fSub)->fBlockade;
    SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(vs_RDBLK_SSTRP,CONFIRM);
    SPCH_PlaySpeech(vs_RDBLK_SSTRP,(int)CONFIRM,reg_a2,reg_a3);
  }
  return;
}

/* ---- Ready__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:2104-2123] SLD-VERIFIED ---- */
void Ready__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *pThis,Car_tObj *carObj)

{
  int Blockade;
  Speaker *pSVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int src_pos;
  Speaker *pSVar3;
  Speaker *Wing;
  
  int doSwap;

  pSVar1 = (Speaker *)Mobile__6SpeechP8Car_tObj(carObj);
  pSVar3 = (pThis->_base_Speaker).fSub;
  doSwap = pSVar3 != (Speaker *)0x0 && pSVar1 != pSVar3;
  if (doSwap) {
    (pSVar1->fBlockade).flags = (pSVar3->fBlockade).flags;
    pSVar3 = (pThis->_base_Speaker).fSub;
    pa_Var2 = pSVar3->_vf;
    src_pos = (*(*pa_Var2)[0x1b].pfn)((int)&(pSVar3->fPosition).flags + (int)(*pa_Var2)[0x1b].delta)
    ;
    (*(*pSVar1->_vf)[6].pfn)((int)&(pSVar1->fPosition).flags + (int)(*pSVar1->_vf)[6].delta,src_pos)
    ;
  }
  pThis->fStatusSub = &pThis->_base_Speaker;
  pThis->fStatusCount = 0x80;
  return;
}

/* ---- PickVoice__6SpeechP8Car_tObj  [SPEECH.CPP:2144-2150] SLD-VERIFIED ---- */
int PickVoice__6SpeechP8Car_tObj(Speech *pThis,Car_tObj *carObj)

{
  int iVar1;
  
  if ((carObj->carFlags & 0x40U) != 0) {
    iVar1 = pThis->fSuperCount;
    pThis->fSuperCount = iVar1 + 1;
    return iVar1 % 6;
  }
  if ((carObj->carFlags & 0x80U) == 0) {
    iVar1 = pThis->fCopCount;
    pThis->fCopCount = iVar1 + 1;
    return iVar1 % 9;
  }
  return 0;
}

/* ---- GetVoice__6SpeechP8Car_tObj  [SPEECH.CPP:2156-2157] SLD-VERIFIED ---- */
void GetVoice__6SpeechP8Car_tObj(Car_tObj *carObj)

{
  PickVoice__6SpeechP8Car_tObj((Speech *)((int)Speech_fgSpeech),carObj);
  return;
}

/* ---- Activate__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2163-2189] SLD-VERIFIED ---- */
void Activate__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *carObj)

{
  Speech_tMobileVoiceAttr * a;
  int reg_v0;
  int Voice;
  u_long uVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  int unit;
  
  pThis->fCarObj = carObj;
  GetVoice__6SpeechP8Car_tObj(carObj);
  pThis->fUnit = reg_v0;
  if ((carObj->carFlags & 0x40U) == 0) {
    uVar1 = Speech_gCopAttr[reg_v0].voice;
  }
  else {
    pThis->fUnit = reg_v0 + 9;
    uVar1 = 8;
  }
  (pThis->fVoice).flags = uVar1;
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1e].delta);
  (pThis->_base_Speaker).fFrom = *(int *)(iVar3 + pThis->fUnit * 4 + 8);
  iVar3 = GameSetup_gData.track;
  (pThis->_base_Speaker).fConfirm.flags = 0xff;
  (pThis->_base_Speaker).fPerpName.flags = 0xf;
  (pThis->_base_Speaker).fBlockade.flags = 0;
  (pThis->_base_Speaker).fArrest.flags = 0;
  (pThis->_base_Speaker).fUpdate.flags = 0;
  pThis->fPerp = (Car_tObj *)0x0;
  (pThis->_base_Speaker).fSub = (Speaker *)0x0;
  (pThis->_base_Speaker).fHavePerp = 0;
  (pThis->_base_Speaker).fReverse.flags = iVar3 & 1;
  return;
}

/* ---- ReActivate__Q26Speech13MobileSpeaker  [SPEECH.CPP:2199-2212] SLD-VERIFIED ---- */
void ReActivate__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  int reg_v0;
  int Voice;
  int tu2;
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  int unit;
  Speech_tMobileVoiceAttr *a;
  
  a = (Speech_tMobileVoiceAttr *)pThis->fCarObj;
  GetVoice__6SpeechP8Car_tObj((Car_tObj *)a);
  pThis->fUnit = reg_v0;
  if ((pThis->fCarObj->carFlags & 0x40U) == 0) {
    tu2 = Speech_gCopAttr[reg_v0].voice;
  }
  else {
    pThis->fUnit = reg_v0 + 9;
    tu2 = 8;
  }
  (pThis->fVoice).flags = tu2;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
  (pThis->_base_Speaker).fFrom = *(int *)(iVar2 + pThis->fUnit * 4 + 8);
  return;
}

/* ---- FindMobile__6SpeechP8Car_tObj  [SPEECH.CPP:2218-2237] SLD-VERIFIED ---- */
Speaker * FindMobile__6SpeechP8Car_tObj(Speech *pThis,Car_tObj *carObj)

{
  MobileSpeaker **ppMVar1;
  int iVar2;
  Speech *pSVar3;
  int iVar4;
  int i;
  
  pSVar3 = pThis;
  for (iVar4 = 0; iVar2 = 0, iVar4 < 4; iVar4 = iVar4 + 1) {
    ppMVar1 = pSVar3->fMobile;
    pSVar3 = (Speech *)&(pSVar3->fCarBank).Mobile[0].fMake;
    if (carObj == (*ppMVar1)->fCarObj) {
      return &(*ppMVar1)->_base_Speaker;
    }
  }
  while( true ) {
    if (3 < iVar2) {
      return (Speaker *)(*(int *)&(Speech_fgUndefined));
    }
    if (pThis->fMobile[0]->fCarObj == (Car_tObj *)0x0) break;
    pThis = (Speech *)&(pThis->fCarBank).Mobile[0].fMake;
    iVar2 = iVar2 + 1;
  }
  Activate__Q26Speech13MobileSpeakerP8Car_tObj(pThis->fMobile[0],carObj);
  return &pThis->fMobile[0]->_base_Speaker;
}

/* ---- Mobile__6SpeechP8Car_tObj  [SPEECH.CPP:2244-2250] SLD-VERIFIED ---- */
int Mobile__6SpeechP8Car_tObj(Car_tObj *carObj)

{
  Speaker *pSVar1;

  pSVar1 = (Speaker *)(*(int *)&(Speech_fgUndefined));
  if ((((int)Speech_fgSpeech) != 0) && (*(int *)(((int)Speech_fgSpeech) + 0x36c) != 0)) {
    pSVar1 = FindMobile__6SpeechP8Car_tObj((Speech *)((int)Speech_fgSpeech),carObj);
  }
  return (int)pSVar1;
}

/* ---- CalcMph__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:2256-2257] SLD-VERIFIED ---- */
int CalcMph__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *perp)

{
  int iVar1;
  int iVar2;

  iVar1 = (perp->linearVel_ch).z;
  iVar1 = __builtin_abs(iVar1);
  iVar2 = fixedmult(0x23ca5,iVar1);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xffff;
  }
  return iVar2 >> 0x10;
}

/* ---- SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2263-2272] SLD-VERIFIED ---- */
void SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  int a;
  int iVar1;
  
  if (GameSetup_gData.measurement == 1) {
    (pThis->fSpeedType).flags = 1;
    iVar1 = (perp->linearVel_ch).z;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    iVar1 = fixedmult(0x39999,iVar1);
    if (iVar1 / 0xa0000 + -3 < 0) {
MSSetSpeed_zeroPath:
      iVar1 = 0;
      goto MSSetSpeed_assignReturn;
    }
    iVar1 = (perp->linearVel_ch).z;
    a = 0x39999;
  }
  else {
    (pThis->fSpeedType).flags = 2;
    iVar1 = (perp->linearVel_ch).z;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    iVar1 = fixedmult(0x23ca5,iVar1);
    if (iVar1 / 0xa0000 + -3 < 0) goto MSSetSpeed_zeroPath;
    iVar1 = (perp->linearVel_ch).z;
    a = 0x23ca5;
  }
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  iVar1 = fixedmult(a,iVar1);
  iVar1 = iVar1 / 0xa0000 + -3;
MSSetSpeed_assignReturn:
  pThis->fSpeed = iVar1;
  return;
}

/* ---- DistToPerp__Q26Speech13MobileSpeaker  [SPEECH.CPP:2281-2286] SLD-VERIFIED ---- */
int DistToPerp__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  short sVar1;
  int d;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  int iVar4;
  int z;
  int (*pcVar5)(...);
  int x;
  int iVar6;
  
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var2)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
  if (*(int *)(iVar3 + 0xa0) - *(int *)(iVar4 + 0xa0) < 1) {
    pa_Var2 = (pThis->_base_Speaker)._vf;
    iVar3 = (*(*pa_Var2)[0x1b].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    sVar1 = (*pa_Var2)[0x19].delta;
    pcVar5 = (*pa_Var2)[0x19].pfn;
  }
  else {
    pa_Var2 = (pThis->_base_Speaker)._vf;
    iVar3 = (*(*pa_Var2)[0x19].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    sVar1 = (*pa_Var2)[0x1b].delta;
    pcVar5 = (*pa_Var2)[0x1b].pfn;
  }
  iVar4 = (*pcVar5)((int)&(pThis->_base_Speaker).fPosition.flags + (int)sVar1);
  iVar6 = *(int *)(iVar3 + 0xa0) - *(int *)(iVar4 + 0xa0);
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var2)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
  if (*(int *)(iVar3 + 0xa8) - *(int *)(iVar4 + 0xa8) < 1) {
    pa_Var2 = (pThis->_base_Speaker)._vf;
    iVar3 = (*(*pa_Var2)[0x1b].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    sVar1 = (*pa_Var2)[0x19].delta;
    pcVar5 = (*pa_Var2)[0x19].pfn;
  }
  else {
    pa_Var2 = (pThis->_base_Speaker)._vf;
    iVar3 = (*(*pa_Var2)[0x19].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    sVar1 = (*pa_Var2)[0x1b].delta;
    pcVar5 = (*pa_Var2)[0x1b].pfn;
  }
  iVar4 = (*pcVar5)((int)&(pThis->_base_Speaker).fPosition.flags + (int)sVar1);
  iVar3 = *(int *)(iVar3 + 0xa8) - *(int *)(iVar4 + 0xa8);
  if (iVar3 < iVar6) {
    iVar6 = iVar6 + (iVar3 >> 2);
  }
  else {
    iVar6 = iVar3 + (iVar6 >> 2);
  }
  return iVar6;
}

/* ---- Report__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2295-2316] SLD-VERIFIED ---- */
void Report__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  Speaker * Sub;
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_COLOUR *COLOUR;
  int ID_UNIT1;
  SPCHNFSType_REVINTRO *REVINTRO;
  SPCHNFSType_DISTANCE *DISTANCE;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
  VOICE = &pThis->fVoice;
  iVar2 = *(int *)(iVar2 + 4);
  ID_UNIT1 = (pThis->_base_Speaker).fFrom;
  REVINTRO = &(pThis->_base_Speaker).fReverse;
  (pThis->_base_Speaker).fTo = iVar2;
  ctx = VOICE;
  SPCHNFS_C_A_INTRO(VOICE,iVar2,ID_UNIT1,REVINTRO);
  SPCH_PlaySpeech(ctx,iVar2,ID_UNIT1,(int)REVINTRO);
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
  SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(pThis,perp);
  COLOUR = &(pThis->_base_Speaker).fColour;
  DISTANCE = &(pThis->_base_Speaker).fDistance;
  iVar2 = (pThis->_base_Speaker).fCar;
  SPCHNFS_C_D_PERP_SIGHTED(VOICE,COLOUR,iVar2,DISTANCE,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
             &(pThis->_base_Speaker).fPerpName);
  SPCH_PlaySpeech(VOICE,(int)COLOUR,iVar2,(int)DISTANCE);
  iVar2 = Dispatch__6Speech();
  *(MobileSpeaker **)(iVar2 + 0x48) = pThis;
  return;
}

/* ---- Engage__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2331-2450] SLD-VERIFIED ---- */
void Engage__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  Car_tObj * car;
  short sVar1;
  bool bVar2;
  Car_tObj *carObj;
  Car_tObj *pCVar3;
  int iVar4;
  MobileSpeaker *pMVar5;
  MobileSpeaker *pMVar6;
  int iVar7;
  u_int *puVar8;
  int iVar9;
  int tu10;
  int tu11;
  Speaker *SubChain;
  __vtbl_ptr_type (*pa_Var10) [31];
  SPCHNFSType_VOICE *pSVar11;
  SPCHNFSType_VOICE *pSVar12;
  SPCHNFSType_COLOUR *pSVar13;
  SPCHNFSType_COLOUR *COLOUR;
  SPCHNFSType_REVINTRO *pSVar14;
  Speaker *Sub;
  u_int uVar15;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var10 = (pThis->_base_Speaker)._vf;
  (pThis->_base_Speaker).fHavePerp = 1;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var10)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  if (perp == pCVar3) {
    bVar2 = false;
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      iVar4 = Dispatch__6Speech();
      iVar4 = (**(int (**)(...))(*(int *)(iVar4 + 0x4c) + 0xac))
                        (iVar4 + *(short *)(*(int *)(iVar4 + 0x4c) + 0xa8));
      bVar2 = iVar4 < 0x160;
    }
    if (!bVar2) {
      return;
    }
    pa_Var10 = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*pa_Var10)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    pa_Var10 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var10)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1e].delta);
    pSVar12 = &pThis->fVoice;
    iVar4 = *(int *)(iVar4 + 4);
    iVar7 = (pThis->_base_Speaker).fFrom;
    pSVar14 = &(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = iVar4;
    pSVar11 = pSVar12;
    SPCHNFS_C_A_INTRO(pSVar12,iVar4,iVar7,pSVar14);
    SPCH_PlaySpeech(pSVar11,iVar4,iVar7,(int)pSVar14);
    pa_Var10 = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*pa_Var10)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    pSVar13 = &(pThis->_base_Speaker).fColour;
    COLOUR = (SPCHNFSType_COLOUR *)(pThis->_base_Speaker).fCar;
    SPCHNFS_C_C_PERP_REAQUIRED(pSVar12,pSVar13,(int)COLOUR,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
               &(pThis->_base_Speaker).fDistance);
MSEngage_emitSpeech:
    SPCH_PlaySpeech(pSVar12,(int)pSVar13,(int)COLOUR,(int)pThis);
    return;
  }
  pa_Var10 = (pThis->_base_Speaker)._vf;
  pThis->fPerp = perp;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var10)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  pa_Var10 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var10)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x19].delta);
  if ((*(u_int *)(iVar4 + 0x260) & 0x200) == 0) {
    pMVar5 = (MobileSpeaker *)Dispatch__6Speech();
    do {
      pMVar6 = pMVar5;
      pMVar5 = (MobileSpeaker *)(pMVar6->_base_Speaker).fSub;
      if (pMVar5 == (MobileSpeaker *)0x0) goto MSEngage_dispatchCheck;
    } while (pMVar5 != pThis);
    (pMVar6->_base_Speaker).fSub = (pThis->_base_Speaker).fSub;
    (pThis->_base_Speaker).fSub = (Speaker *)0x0;
  }
MSEngage_dispatchCheck:
  iVar4 = Dispatch__6Speech();
  bVar2 = false;
  if (*(MobileSpeaker **)(iVar4 + 0x48) == pThis) {
    pa_Var10 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var10)[0x19].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x19].delta);
    if ((*(u_int *)(iVar4 + 0x260) & 0x200) == 0) {
      return;
    }
    iVar4 = Dispatch__6Speech();
    (**(int (**)(...))(*(int *)(iVar4 + 0x4c) + 0xc))(iVar4 + *(short *)(*(int *)(iVar4 + 0x4c) + 8),perp)
    ;
    *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
    pa_Var10 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var10)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1e].delta);
    pa_Var10 = (pThis->_base_Speaker)._vf;
    (pThis->_base_Speaker).fTo = *(int *)(iVar4 + 4);
    pCVar3 = (Car_tObj *)
             (*(*pa_Var10)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    pSVar12 = &pThis->fVoice;
    COLOUR = &(pThis->_base_Speaker).fColour;
    pSVar13 = (SPCHNFSType_COLOUR *)(pThis->_base_Speaker).fTo;
    pMVar5 = (MobileSpeaker *)(pThis->_base_Speaker).fCar;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(pSVar12,(int)pSVar13,COLOUR,(int)pMVar5,&(pThis->_base_Speaker).fDistance,
               (SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fConfirm);
    pThis = pMVar5;
    goto MSEngage_emitSpeech;
  }
  pa_Var10 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var10)[0x14].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x14].delta);
  if (((iVar4 != 0) &&
      (pa_Var10 = (pThis->_base_Speaker)._vf,
      iVar4 = (*(*pa_Var10)[0x1b].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta),
      (*(u_int *)(iVar4 + 0x260) & 4) != 0)) && (iVar4 = Dispatch__6Speech(), *(int *)(iVar4 + 0x48) != 0)) {
    iVar4 = Dispatch__6Speech();
    iVar7 = *(int *)(*(int *)(iVar4 + 0x48) + 0x4c);
    iVar4 = (**(int (**)(...))(iVar7 + 0xcc))(*(int *)(iVar4 + 0x48) + (int)*(short *)(iVar7 + 200));
    bVar2 = (*(u_int *)(iVar4 + 0x260) & 0x40) == 0;
  }
  if (bVar2) {
    iVar4 = Dispatch__6Speech();
    (pThis->_base_Speaker).fSub = *(Speaker **)(iVar4 + 0x48);
    iVar4 = Dispatch__6Speech();
    *(MobileSpeaker **)(iVar4 + 0x48) = pThis;
    if ((pThis->_base_Speaker).fBlockade.flags != 0) {
      return;
    }
    pa_Var10 = (pThis->_base_Speaker)._vf;
    puVar8 = (u_int *)
             (*(*pa_Var10)[0x1e].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1e].delta);
    pSVar12 = &pThis->fVoice;
    pSVar13 = (SPCHNFSType_COLOUR *)*puVar8;
    COLOUR = (SPCHNFSType_COLOUR *)(pThis->_base_Speaker).fFrom;
    pMVar5 = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = (int)pSVar13;
    pSVar11 = pSVar12;
    SPCHNFS_C_A_INTRO(pSVar12,(int)pSVar13,(int)COLOUR,(SPCHNFSType_REVINTRO *)pMVar5);
    SPCH_PlaySpeech(pSVar11,(int)pSVar13,(int)COLOUR,(int)pMVar5);
    SPCHNFS_S_C_SUPER_COP_ARRIVAL(pSVar12);
    pThis = pMVar5;
    goto MSEngage_emitSpeech;
  }
  bVar2 = false;
  iVar4 = Dispatch__6Speech();
  iVar7 = Dispatch__6Speech();
  if (*(int *)(iVar7 + 0x48) != 0) {
    iVar7 = Dispatch__6Speech();
    iVar9 = *(int *)(*(int *)(iVar7 + 0x48) + 0x4c);
    iVar7 = (**(int (**)(...))(iVar9 + 0xdc))(*(int *)(iVar7 + 0x48) + (int)*(short *)(iVar9 + 0xd8));
    if (iVar7 != 0) {
      iVar7 = Dispatch__6Speech();
      iVar9 = *(int *)(*(int *)(iVar7 + 0x48) + 0x4c);
      iVar7 = (**(int (**)(...))(iVar9 + 0xdc))(*(int *)(iVar7 + 0x48) + (int)*(short *)(iVar9 + 0xd8));
      if ((*(u_int *)(iVar7 + 0x260) & 4) == 0) {
        pa_Var10 = (pThis->_base_Speaker)._vf;
        iVar7 = (*(*pa_Var10)[0x1b].pfn)
                          ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
        bVar2 = (*(u_int *)(iVar7 + 0x260) & 4) != 0;
      }
    }
  }
  if (bVar2) {
    iVar4 = Dispatch__6Speech();
    (pThis->_base_Speaker).fSub = *(Speaker **)(iVar4 + 0x48);
    iVar4 = Dispatch__6Speech();
    *(MobileSpeaker **)(iVar4 + 0x48) = pThis;
  }
  else {
    do {
      iVar7 = iVar4;
      iVar4 = *(int *)(iVar7 + 0x48);
    } while (iVar4 != 0);
    *(MobileSpeaker **)(iVar7 + 0x48) = pThis;
  }
  if ((pThis->_base_Speaker).fBlockade.flags != 0) {
    return;
  }
  bVar2 = false;
  iVar4 = Dispatch__6Speech();
  iVar4 = (**(int (**)(...))(*(int *)(iVar4 + 0x4c) + 0x94))
                    (iVar4 + *(short *)(*(int *)(iVar4 + 0x4c) + 0x90),perp);
  if (iVar4 != 0) {
    iVar4 = Dispatch__6Speech();
    iVar4 = (**(int (**)(...))(*(int *)(iVar4 + 0x4c) + 0xac))
                      (iVar4 + *(short *)(*(int *)(iVar4 + 0x4c) + 0xa8));
    if (0x17f < iVar4) goto MSEngage_validateAndProceed;
  }
  bVar2 = true;
MSEngage_validateAndProceed:
  if (!bVar2) {
    return;
  }
  pa_Var10 = (pThis->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var10)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1e].delta);
  pSVar12 = &pThis->fVoice;
  iVar4 = *(int *)(iVar4 + 4);
  iVar7 = (pThis->_base_Speaker).fFrom;
  pSVar14 = &(pThis->_base_Speaker).fReverse;
  (pThis->_base_Speaker).fTo = iVar4;
  pSVar11 = pSVar12;
  SPCHNFS_C_A_INTRO(pSVar12,iVar4,iVar7,pSVar14);
  SPCH_PlaySpeech(pSVar11,iVar4,iVar7,(int)pSVar14);
  pa_Var10 = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var10)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  pa_Var10 = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var10)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(pThis,pCVar3);
  iVar4 = Dispatch__6Speech();
  iVar7 = *(int *)(iVar4 + 0x4c);
  pa_Var10 = (pThis->_base_Speaker)._vf;
  sVar1 = *(short *)(iVar7 + 0x90);
  tu10 = (*(*pa_Var10)[0x1b].pfn)
                   ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  iVar4 = (**(int (**)(...))(iVar7 + 0x94))(iVar4 + sVar1,tu10);
  if (iVar4 == 0) {
    pSVar13 = &(pThis->_base_Speaker).fColour;
    iVar4 = (pThis->_base_Speaker).fCar;
    pMVar5 = pThis;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(pSVar12,pSVar13,iVar4,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
               &(pThis->_base_Speaker).fDistance,pThis->fSpeed,&pThis->fSpeedType,&(pThis->_base_Speaker).fPerpName)
    ;
  }
  else {
    pSVar13 = &(pThis->_base_Speaker).fColour;
    pMVar5 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
    iVar4 = (pThis->_base_Speaker).fCar;
    SPCHNFS_C_D_PERP_SIGHTED(pSVar12,pSVar13,iVar4,(SPCHNFSType_DISTANCE *)pMVar5,(SPCHNFSType_POSITION *)pThis,
               (pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fPerpName);
  }
  SPCH_PlaySpeech(pSVar12,(int)pSVar13,iVar4,(int)pMVar5);
  iVar4 = Dispatch__6Speech();
  uVar15 = *(u_int *)(iVar4 + 0x48);
  iVar4 = Dispatch__6Speech();
  *(MobileSpeaker **)(iVar4 + 0x48) = pThis;
  iVar4 = Dispatch__6Speech();
  iVar7 = *(int *)(iVar4 + 0x4c);
  pa_Var10 = (pThis->_base_Speaker)._vf;
  sVar1 = *(short *)(iVar7 + 8);
  tu11 = (*(*pa_Var10)[0x1b].pfn)
                   ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  (**(int (**)(...))(iVar7 + 0xc))(iVar4 + sVar1,tu11);
  iVar4 = Dispatch__6Speech();
  *(u_int *)(iVar4 + 0x48) = uVar15;
  return;
}

/* ---- Lose__Q26Speech13MobileSpeaker  [SPEECH.CPP:2463-2538] SLD-VERIFIED ---- */
void Lose__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Speaker * Sub;
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  int iVar4;
  Car_tObj *pCVar5;
  Car_tObj *carObj;
  u_long uVar6;
  SPCHNFSType_VOICE *pSVar7;
  SPCHNFSType_VOICE *VOICE;
  int reg_a1;
  int reg_a2;
  int reg_a3;
  MobileSpeaker *REVINTRO;
  u_int uVar8;
  Speaker *Leader;
  int iVar9;
  
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
  if (iVar3 != 0) {
    *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
    iVar3 = Dispatch__6Speech();
    bVar1 = false;
    if (((*(int *)(iVar3 + 0x48) != 0) &&
        (iVar3 = Dispatch__6Speech(), *(MobileSpeaker **)(*(int *)(iVar3 + 0x48) + 0x48) == pThis)) &&
       ((pThis->_base_Speaker).fBlockade.flags == 0)) {
      bVar1 = (pThis->_base_Speaker).fArrest.flags == 0;
    }
    if (bVar1) {
      iVar3 = Dispatch__6Speech();
      pa_Var2 = (pThis->_base_Speaker)._vf;
      iVar9 = *(int *)(iVar3 + 0x48);
      iVar3 = (*(*pa_Var2)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1e].delta);
      iVar4 = (**(int (**)(...))(*(int *)(iVar9 + 0x4c) + 0x8c))
                        (iVar9 + *(short *)(*(int *)(iVar9 + 0x4c) + 0x88));
      (pThis->_base_Speaker).fTo = *(int *)(iVar3 + iVar4 * 4 + 8);
    }
    else {
      pa_Var2 = (pThis->_base_Speaker)._vf;
      iVar3 = (*(*pa_Var2)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1e].delta);
      iVar9 = 0;
      (pThis->_base_Speaker).fTo = *(int *)(iVar3 + 4);
    }
    if ((pThis->_base_Speaker).fArrest.flags == 0) {
      bVar1 = false;
      if (((pThis->_base_Speaker).fBlockade.flags == 0) && (iVar9 == 0)) {
        iVar3 = Dispatch__6Speech();
        iVar3 = (**(int (**)(...))(*(int *)(iVar3 + 0x4c) + 0xac))
                          (iVar3 + *(short *)(*(int *)(iVar3 + 0x4c) + 0xa8));
        bVar1 = 0x160 < iVar3;
      }
      if (bVar1) {
        return;
      }
    }
    else {
      pSVar7 = &pThis->fVoice;
      SPCHNFS_C_P_FALSE_ARREST_BULLHORN(pSVar7);
      SPCH_PlaySpeech(pSVar7,reg_a1,reg_a2,reg_a3);
    }
    VOICE = &pThis->fVoice;
    iVar3 = (pThis->_base_Speaker).fTo;
    iVar4 = (pThis->_base_Speaker).fFrom;
    REVINTRO = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
    pSVar7 = VOICE;
    SPCHNFS_C_A_INTRO(VOICE,iVar3,iVar4,(SPCHNFSType_REVINTRO *)REVINTRO);
    SPCH_PlaySpeech(pSVar7,iVar3,iVar4,(int)REVINTRO);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    pCVar5 = (Car_tObj *)
             (*(*pa_Var2)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
    pa_Var2 = (pThis->_base_Speaker)._vf;
    pCVar5 = (Car_tObj *)
             (*(*pa_Var2)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
    if ((pThis->_base_Speaker).fArrest.flags == 0) {
      pa_Var2 = (pThis->_base_Speaker)._vf;
      iVar3 = (*(*pa_Var2)[0x19].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
      if ((*(u_int *)(iVar3 + 0x260) & 0x200) == 0) {
        uVar6 = (pThis->_base_Speaker).fBlockade.flags;
        if (uVar6 == 1) {
          iVar4 = (pThis->_base_Speaker).fCar;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          SPCHNFS_C_D_SPBLT_FAILED(VOICE,(SPCHNFSType_COLOUR *)pCVar5,iVar4);
        }
        else if (uVar6 == 2) {
          iVar4 = (pThis->_base_Speaker).fCar;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          SPCHNFS_C_D_RDBLK_FAILED(VOICE,(SPCHNFSType_COLOUR *)pCVar5,iVar4);
        }
        else {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (iVar9 == 0) {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            SPCHNFS_C_D_PERP_LOST(VOICE,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       (pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);
          }
          else {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(VOICE);
          }
        }
      }
      else {
        SPCHNFS_C_D_ENDGAME(VOICE);
      }
    }
    else {
      pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fPerpName;
      SPCHNFS_C_D_DURING_FALSE_ARREST(VOICE,(SPCHNFSType_PERP_NAME *)pCVar5);
    }
    SPCH_PlaySpeech(VOICE,(int)pCVar5,iVar4,(int)REVINTRO);
    (pThis->_base_Speaker).fBlockade.flags = 0;
    (pThis->_base_Speaker).fArrest.flags = 0;
    (pThis->_base_Speaker).fUpdate.flags = 0;
    if (iVar9 == 0) {
      iVar3 = Dispatch__6Speech();
      uVar8 = *(u_int *)(iVar3 + 0x48);
      iVar3 = Dispatch__6Speech();
      *(MobileSpeaker **)(iVar3 + 0x48) = pThis;
      iVar3 = Dispatch__6Speech();
      (**(int (**)(...))(*(int *)(iVar3 + 0x4c) + 0x74))
                (iVar3 + *(short *)(*(int *)(iVar3 + 0x4c) + 0x70));
      iVar3 = Dispatch__6Speech();
      *(u_int *)(iVar3 + 0x48) = uVar8;
    }
  }
  return;
}

/* ---- Accident__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2544-2548] SLD-VERIFIED ---- */
void Accident__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int slice)

{
  return;
}

/* ---- Catch__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2554-2621] SLD-VERIFIED ---- */
void Catch__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int ticket)

{
  int Arrest;
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  Car_tObj *pCVar3;
  u_long uVar4;
  SPCHNFSType_VOICE *pSVar5;
  SPCHNFSType_VOICE *pSVar6;
  MobileSpeaker *pMVar7;
  SPCHNFSType_AMBULANCE *AMBULANCE;
  SPCHNFSType_ARREST *ARREST;
  int reg_a2;
  int iVar8;
  int reg_a3;
  SPCHNFSType_REVINTRO *pSVar9;
  SPCHNFSType_DISTANCE *COLOUR;
  
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
  if (iVar2 == 0) {
    return;
  }
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
  if (*(int *)(iVar2 + 300) < 0) {
    pa_Var1 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var1)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
    pSVar5 = &pThis->fVoice;
    iVar2 = *(int *)(iVar2 + 4);
    iVar8 = (pThis->_base_Speaker).fFrom;
    pSVar9 = &(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = iVar2;
    pSVar6 = pSVar5;
    SPCHNFS_C_A_INTRO(pSVar5,iVar2,iVar8,pSVar9);
    SPCH_PlaySpeech(pSVar6,iVar2,iVar8,(int)pSVar9);
    pa_Var1 = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*pa_Var1)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    COLOUR = &(pThis->_base_Speaker).fDistance;
    iVar2 = (pThis->_base_Speaker).fLocation;
    pMVar7 = pThis;
    SPCHNFS_C_D_PERP_CRASH_ROLL(pSVar5,(SPCHNFSType_POSITION *)pThis,iVar2,COLOUR,&(pThis->_base_Speaker).fPerpName);
    SPCH_PlaySpeech(pSVar5,(int)pMVar7,iVar2,(int)COLOUR);
    uVar4 = 4;
  }
  else {
    pa_Var1 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var1)[0x1b].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
    if (*(int *)(iVar2 + 0x78c) == 0) {
      (pThis->_base_Speaker).fArrest.flags = ticket;
      if (ticket == 1) {
        pSVar6 = &pThis->fVoice;
        ARREST = &(pThis->_base_Speaker).fArrest;
        SPCHNFS_C_P_ARRESTED(pSVar6,ARREST);
      }
      else {
        pSVar6 = &pThis->fVoice;
        if (ticket == 2) {
          ARREST = &(pThis->_base_Speaker).fArrest;
          SPCHNFS_C_P_WARNING(pSVar6,ARREST);
        }
        else {
          ARREST = &(pThis->_base_Speaker).fArrest;
          SPCHNFS_C_P_TICKET(pSVar6,ARREST);
        }
      }
      SPCH_PlaySpeech(pSVar6,(int)ARREST,reg_a2,reg_a3);
      if (ticket == 1) {
        SetDelayedStatus__6SpeechPQ26Speech7Speakeri((Speech *)((int)Speech_fgSpeech),&pThis->_base_Speaker,0x60);
      }
      goto Catch_dispatchCallback;
    }
    pa_Var1 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var1)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
    pSVar5 = &pThis->fVoice;
    iVar2 = *(int *)(iVar2 + 4);
    iVar8 = (pThis->_base_Speaker).fFrom;
    pSVar9 = &(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = iVar2;
    pSVar6 = pSVar5;
    SPCHNFS_C_A_INTRO(pSVar5,iVar2,iVar8,pSVar9);
    SPCH_PlaySpeech(pSVar6,iVar2,iVar8,(int)pSVar9);
    pa_Var1 = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*pa_Var1)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    pa_Var1 = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*pa_Var1)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    COLOUR = (SPCHNFSType_DISTANCE *)&(pThis->_base_Speaker).fColour;
    iVar2 = (pThis->_base_Speaker).fLocation;
    pMVar7 = pThis;
    SPCHNFS_C_D_PERP_CRASH_GEN(pSVar5,(SPCHNFSType_POSITION *)pThis,iVar2,(SPCHNFSType_COLOUR *)COLOUR,
               (pThis->_base_Speaker).fCar,&(pThis->_base_Speaker).fDistance,&(pThis->_base_Speaker).fPerpName);
    SPCH_PlaySpeech(pSVar5,(int)pMVar7,iVar2,(int)COLOUR);
    uVar4 = 0x20;
  }
  pSVar6 = &pThis->fVoice;
  AMBULANCE = &(pThis->_base_Speaker).fAmbulance;
  (pThis->_base_Speaker).fAmbulance.flags = uVar4;
  SPCHNFS_C_D_REQUEST_EMS(pSVar6,AMBULANCE);
  SPCH_PlaySpeech(pSVar6,(int)AMBULANCE,iVar2,(int)COLOUR);
Catch_dispatchCallback:
  iVar2 = Dispatch__6Speech();
  (**(int (**)(...))(*(int *)(iVar2 + 0x4c) + 0x9c))
            (iVar2 + *(short *)(*(int *)(iVar2 + 0x4c) + 0x98),pThis->fPerp);
  return;
}

/* ---- RoadBlock__Q26Speech13MobileSpeaker  [SPEECH.CPP:2627-2648] SLD-VERIFIED ---- */
void RoadBlock__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  Car_tObj *carObj;
  int iVar2;
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_REVINTRO *REVINTRO;
  
  iVar2 = Dispatch__6Speech();
  bVar1 = false;
  if (*(int *)(iVar2 + 0x48) != 0) {
    iVar2 = Dispatch__6Speech();
    bVar1 = *(MobileSpeaker **)(iVar2 + 0x48) != pThis;
  }
  if (bVar1) {
    iVar2 = Dispatch__6Speech();
    iVar3 = *(int *)(*(int *)(iVar2 + 0x48) + 0x4c);
    (**(int (**)(...))(iVar3 + 0x54))(*(int *)(iVar2 + 0x48) + (int)*(short *)(iVar3 + 0x50));
  }
  else {
    Promote__Q26Speech7Speaker(&pThis->_base_Speaker);
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
      pa_Var4 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var4)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var4)[0x1e].delta);
      VOICE = &pThis->fVoice;
      iVar2 = *(int *)(iVar2 + 4);
      iVar3 = (pThis->_base_Speaker).fFrom;
      REVINTRO = &(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = iVar2;
      ctx = VOICE;
      SPCHNFS_C_A_INTRO(VOICE,iVar2,iVar3,REVINTRO);
      SPCH_PlaySpeech(ctx,iVar2,iVar3,(int)REVINTRO);
      SPCHNFS_C_D_REQ_RDBLK(VOICE);
      SPCH_PlaySpeech(VOICE,iVar2,iVar3,(int)REVINTRO);
    }
    (pThis->_base_Speaker).fBlockade.flags = 2;
  }
  return;
}

/* ---- SpikeBelt__Q26Speech13MobileSpeaker  [SPEECH.CPP:2656-2677] SLD-VERIFIED ---- */
void SpikeBelt__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  Car_tObj *carObj;
  int iVar2;
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_REVINTRO *REVINTRO;
  
  iVar2 = Dispatch__6Speech();
  bVar1 = false;
  if (*(int *)(iVar2 + 0x48) != 0) {
    iVar2 = Dispatch__6Speech();
    bVar1 = *(MobileSpeaker **)(iVar2 + 0x48) != pThis;
  }
  if (bVar1) {
    iVar2 = Dispatch__6Speech();
    iVar3 = *(int *)(*(int *)(iVar2 + 0x48) + 0x4c);
    (**(int (**)(...))(iVar3 + 0x5c))(*(int *)(iVar2 + 0x48) + (int)*(short *)(iVar3 + 0x58));
  }
  else {
    Promote__Q26Speech7Speaker(&pThis->_base_Speaker);
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
      pa_Var4 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var4)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var4)[0x1e].delta);
      VOICE = &pThis->fVoice;
      iVar2 = *(int *)(iVar2 + 4);
      iVar3 = (pThis->_base_Speaker).fFrom;
      REVINTRO = &(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = iVar2;
      ctx = VOICE;
      SPCHNFS_C_A_INTRO(VOICE,iVar2,iVar3,REVINTRO);
      SPCH_PlaySpeech(ctx,iVar2,iVar3,(int)REVINTRO);
      SPCHNFS_C_D_REQ_SPBLT(VOICE);
      SPCH_PlaySpeech(VOICE,iVar2,iVar3,(int)REVINTRO);
    }
    (pThis->_base_Speaker).fBlockade.flags = 1;
  }
  return;
}

/* ---- Backup__Q26Speech13MobileSpeaker  [SPEECH.CPP:2685-2705] SLD-VERIFIED ---- */
void Backup__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  Car_tObj *pCVar3;
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_COLOUR *COLOUR;
  int ID_UNIT1;
  SPCHNFSType_REVINTRO *REVINTRO;
  MobileSpeaker *flags;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
  VOICE = &pThis->fVoice;
  iVar2 = *(int *)(iVar2 + 4);
  ID_UNIT1 = (pThis->_base_Speaker).fFrom;
  REVINTRO = &(pThis->_base_Speaker).fReverse;
  (pThis->_base_Speaker).fTo = iVar2;
  ctx = VOICE;
  SPCHNFS_C_A_INTRO(VOICE,iVar2,ID_UNIT1,REVINTRO);
  SPCH_PlaySpeech(ctx,iVar2,ID_UNIT1,(int)REVINTRO);
  pa_Var1 = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var1)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  pa_Var1 = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var1)[0x19].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x19].delta);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  COLOUR = &(pThis->_base_Speaker).fColour;
  iVar2 = (pThis->_base_Speaker).fCar;
  flags = pThis;
  SPCHNFS_C_D_REQUEST_BKUP(VOICE,COLOUR,iVar2,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
             &(pThis->_base_Speaker).fDistance);
  SPCH_PlaySpeech(VOICE,(int)COLOUR,iVar2,(int)flags);
  (pThis->_base_Speaker).fBlockade.flags = 0;
  return;
}

/* ---- Roger__Q26Speech13MobileSpeaker  [SPEECH.CPP:2711-2733] SLD-VERIFIED ---- */
void Roger__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  int iVar2;
  Speaker *pSVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  int iVar5;
  Car_tObj *car;
  Car_tObj *carObj;
  MobileSpeaker *ctx;
  SPCHNFSType_VOICE *ctx_00;
  SPCHNFSType_VOICE *VOICE;
  int reg_a1;
  SPCHNFSType_COLOUR *COLOUR;
  int reg_a2;
  SPCHNFSType_CONFIRM *pSVar6;
  int reg_a3;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  bVar1 = false;
  ctx = pThis;
  if ((pThis->_base_Speaker).fSub != (Speaker *)0x0) {
    iVar2 = Dispatch__6Speech();
    ctx = (MobileSpeaker *)(iVar2 + *(short *)(*(int *)(iVar2 + 0x4c) + 0xb0));
    pSVar3 = (Speaker *)(**(int (**)(...))(*(int *)(iVar2 + 0x4c) + 0xb4))();
    bVar1 = pSVar3 == (pThis->_base_Speaker).fSub;
  }
  if (bVar1) {
    VOICE = &pThis->fVoice;
    SPCH_PlaySpeech(ctx,reg_a1,reg_a2,reg_a3);
    pa_Var4 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var4)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var4)[0x1e].delta);
    pSVar3 = (pThis->_base_Speaker).fSub;
    pa_Var4 = pSVar3->_vf;
    iVar5 = (*(*pa_Var4)[0x11].pfn)((int)&(pSVar3->fPosition).flags + (int)(*pa_Var4)[0x11].delta);
    iVar2 = *(int *)(iVar2 + iVar5 * 4 + 8);
    pSVar6 = &(pThis->_base_Speaker).fConfirm;
    (pThis->_base_Speaker).fTo = iVar2;
    ctx_00 = VOICE;
    SPCHNFS_C_A_CONFIRM(VOICE,iVar2,pSVar6);
    SPCH_PlaySpeech(ctx_00,iVar2,(int)pSVar6,reg_a3);
    pa_Var4 = (pThis->_base_Speaker)._vf;
    car = (Car_tObj *)
          (*(*pa_Var4)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var4)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
    pSVar6 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
    COLOUR = &(pThis->_base_Speaker).fColour;
    SPCHNFS_C_C_IN_PURS_NEAR_PERP(VOICE,COLOUR,(int)pSVar6);
  }
  else {
    pa_Var4 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var4)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var4)[0x1e].delta);
    VOICE = &pThis->fVoice;
    COLOUR = *(SPCHNFSType_COLOUR **)(iVar2 + 4);
    pSVar6 = &(pThis->_base_Speaker).fConfirm;
    (pThis->_base_Speaker).fTo = (int)COLOUR;
    SPCHNFS_C_A_CONFIRM(VOICE,(int)COLOUR,pSVar6);
  }
  SPCH_PlaySpeech(VOICE,(int)COLOUR,(int)pSVar6,reg_a3);
  return;
}

/* ---- Bullhorn__Q26Speech13MobileSpeaker  [SPEECH.CPP:2741-2748] SLD-VERIFIED ---- */
void Bullhorn__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Car_tObj *carObj;
  SPCHNFSType_VOICE *VOICE;
  int reg_a1;
  int reg_a2;
  int reg_a3;
  
  VOICE = &pThis->fVoice;
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  SPCHNFS_C_P_BULLHORN_SPEECH(VOICE);
  SPCH_PlaySpeech(VOICE,reg_a1,reg_a2,reg_a3);
  return;
}

/* ---- Purge__Q26Speech13MobileSpeaker  [SPEECH.CPP:2754-2839] SLD-VERIFIED ---- */
void Purge__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  MobileSpeaker *pMVar4;
  MobileSpeaker *pMVar5;
  Speaker *Chain;
  
  if (pThis->fCarObj == (Car_tObj *)0x0) {
    return;
  }
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
  if ((*(u_int *)(iVar3 + 0x260) & 0x200) == 0) {
    pThis->fCarObj = (Car_tObj *)0x0;
    iVar3 = Dispatch__6Speech();
    pMVar4 = (MobileSpeaker *)
             (**(int (**)(...))(*(int *)(iVar3 + 0x4c) + 0xb4))
                       (iVar3 + *(short *)(*(int *)(iVar3 + 0x4c) + 0xb0));
    if (pMVar4 == pThis) {
      iVar3 = Dispatch__6Speech();
      (**(int (**)(...))(*(int *)(iVar3 + 0x4c) + 0xbc))
                (iVar3 + *(short *)(*(int *)(iVar3 + 0x4c) + 0xb8));
    }
    pMVar4 = (MobileSpeaker *)Dispatch__6Speech();
    do {
      pMVar5 = (MobileSpeaker *)(pMVar4->_base_Speaker).fSub;
      if (pMVar5 == pThis) {
        (pMVar4->_base_Speaker).fSub = (pThis->_base_Speaker).fSub;
        return;
      }
      pMVar4 = pMVar5;
    } while (pMVar5 != (MobileSpeaker *)0x0);
    return;
  }
  CopSpeak_Flush();
  if (CopSpeak_gSpchHandle != -1) {
    if (stackSpeedUpEnbabledFlag == 0) {
      SNDstop(CopSpeak_gSpchHandle);
    }
    else {
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
      SNDstop(CopSpeak_gSpchHandle);
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 1;
    }
  }
  pa_Var2 = (pThis->_base_Speaker)._vf;
  bVar1 = false;
  iVar3 = (*(*pa_Var2)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1b].delta);
  if (iVar3 != 0) {
    iVar3 = AudioMus_Threshold();
    bVar1 = iVar3 != 0;
  }
  if (bVar1) {
    if (stackSpeedUpEnbabledFlag != 0) {
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
      AudioMus_StopSong(500);
      AudioMus_PlaySong((char *)0x0);
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 1;
      (pThis->_base_Speaker).fBlockade.flags = 0;
      goto Purge_resetSpeakerFields;
    }
    AudioMus_StopSong(500);
    AudioMus_PlaySong((char *)0x0);
  }
  (pThis->_base_Speaker).fBlockade.flags = 0;
Purge_resetSpeakerFields:
  (pThis->_base_Speaker).fArrest.flags = 0;
  (pThis->_base_Speaker).fUpdate.flags = 0;
  pThis->fPerp = (Car_tObj *)0x0;
  (pThis->_base_Speaker).fSub = (Speaker *)0x0;
  return;
}

/* ---- ReportBlockade__Q26Speech13MobileSpeaker  [SPEECH.CPP:2843-2861] SLD-VERIFIED ---- */
void ReportBlockade__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  Car_tObj *car;
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  int ID_UNIT1;
  SPCHNFSType_SPIKE_BELT_SIDE *SPIKE_BELT_SIDE;
  SPCHNFSType_REVINTRO *REVINTRO;
  SPCHNFSType_DISTANCE *DISTANCE;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
  pa_Var1 = (pThis->_base_Speaker)._vf;
  (pThis->_base_Speaker).fTo = *(int *)(iVar2 + 4);
  car = (Car_tObj *)
        (*(*pa_Var1)[0x19].pfn)((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x19].delta)
  ;
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
  (pThis->_base_Speaker).fSpikeSide.flags = 4;
  VOICE = &pThis->fVoice;
  if ((pThis->_base_Speaker).fBlockade.flags == 2) {
    VOICE = &pThis->fVoice;
    iVar2 = (pThis->_base_Speaker).fTo;
    ID_UNIT1 = (pThis->_base_Speaker).fFrom;
    REVINTRO = &(pThis->_base_Speaker).fReverse;
    ctx = VOICE;
    SPCHNFS_C_A_INTRO(VOICE,iVar2,ID_UNIT1,REVINTRO);
    SPCH_PlaySpeech(ctx,iVar2,ID_UNIT1,(int)REVINTRO);
    SPIKE_BELT_SIDE = (SPCHNFSType_SPIKE_BELT_SIDE *)(pThis->_base_Speaker).fLocation;
    DISTANCE = &(pThis->_base_Speaker).fDistance;
    SPCHNFS_W_D_RDBLK_PLC(VOICE,(SPCHNFSType_POSITION *)pThis,(int)SPIKE_BELT_SIDE,DISTANCE);
  }
  else {
    SPIKE_BELT_SIDE = &(pThis->_base_Speaker).fSpikeSide;
    DISTANCE = (SPCHNFSType_DISTANCE *)(pThis->_base_Speaker).fFrom;
    SPCHNFS_W_D_SPBLT_PLC(VOICE,(SPCHNFSType_POSITION *)pThis,SPIKE_BELT_SIDE,(int)DISTANCE,
               (pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fDistance);
  }
  SPCH_PlaySpeech(VOICE,(int)pThis,(int)SPIKE_BELT_SIDE,(int)DISTANCE);
  return;
}

/* ---- Perp__Q26Speech13MobileSpeaker  [SPEECH.CPP:147-147] SLD-VERIFIED ---- */
Car_tObj * Perp__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  return pThis->fPerp;
}

/* ---- Unit__Q26Speech13MobileSpeaker  [SPEECH.CPP:134-135] SLD-VERIFIED ---- */
int Unit__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  return pThis->fUnit;
}

/* ---- CallSign__Q26Speech13MobileSpeaker  [SPEECH.CPP:130-135] SLD-FLAG:NONMONO ---- */
CallSignBank * CallSign__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  return (CallSignBank *)(((int)Speech_fgSpeech) + 0x2d8);
}

/* ---- FindClosestLocationTo__Q26Speech13MobileSpeakeri  [SPEECH.CPP:126-131] SLD-FLAG:NONMONO ---- */
LocationBank * FindClosestLocationTo__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int slice)

{
  return FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki((Speech *)((int)Speech_fgSpeech),(LocationBank *)(((int)Speech_fgSpeech) + 0xd8),slice);
}

/* ---- GetCarBank__Q26Speech13MobileSpeakeri  [SPEECH.CPP:122-127] SLD-FLAG:NONMONO ---- */
CarBank * GetCarBank__Q26Speech13MobileSpeakeri(MobileSpeaker *pThis,int carIndex)

{
  return (CarBank *)(((int)Speech_fgSpeech) + carIndex * 0xc);
}

/* ---- CarObj__Q26Speech13MobileSpeaker  [SPEECH.CPP:114-114] SLD-VERIFIED ---- */
Car_tObj * CarObj__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  return pThis->fCarObj;
}

/* ---- IsSuper__Q26Speech13MobileSpeaker  [SPEECH.CPP:106-106] SLD-VERIFIED ---- */
void * IsSuper__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  return (void *)((u_int)pThis->fCarObj->carFlags >> 6 & 1);
}

/* ---- CallSign__Q26Speech15DispatchSpeaker  [SPEECH.CPP:73-74] SLD-VERIFIED ---- */
CallSignBank * CallSign__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  return (CallSignBank *)(((int)Speech_fgSpeech) + 0x31c);
}

/* ---- FindClosestLocationTo__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:69-74] SLD-FLAG:NONMONO ---- */
LocationBank * FindClosestLocationTo__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int slice)

{
  return FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki((Speech *)((int)Speech_fgSpeech),(LocationBank *)(((int)Speech_fgSpeech) + 0x1d8),slice);
}

/* ---- GetCarBank__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:65-70] SLD-FLAG:NONMONO ---- */
CarBank * GetCarBank__Q26Speech15DispatchSpeakeri(DispatchSpeaker *pThis,int carIndex)

{
  int off;

  off = carIndex * 0xc + 0x6c;
  return (CarBank *)(((int)Speech_fgSpeech) + off);
}

/* ---- PurgeStatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:58-66] SLD-FLAG:NONMONO ---- */
void PurgeStatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  pThis->fStatusSub = (Speaker *)0x0;
  return;
}

/* ---- StatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:57-58] SLD-VERIFIED ---- */
Speaker * StatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  return pThis->fStatusSub;
}

/* ---- StatusCount__Q26Speech15DispatchSpeaker  [SPEECH.CPP:56-57] SLD-VERIFIED ---- */
int StatusCount__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  return pThis->fStatusCount;
}

/* ---- FindClosestLocationTo__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
LocationBank * FindClosestLocationTo__Q26Speech7Speakeri(Speaker *pThis,int slice)

{
  return (LocationBank *)0x0;
}

/* ---- GetCarBank__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
CarBank * GetCarBank__Q26Speech7Speakeri(Speaker *pThis,int carIndex)

{
  return (CarBank *)0x0;
}

/* ---- Perp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj * Perp__Q26Speech7Speaker(Speaker *pThis)

{
  return (Car_tObj *)0x0;
}

/* ---- ReActivate__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void ReActivate__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- CarObj__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj * CarObj__Q26Speech7Speaker(Speaker *pThis)

{
  return (Car_tObj *)0x0;
}

/* ---- DistToPerp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int DistToPerp__Q26Speech7Speaker(Speaker *pThis)

{
  return 0x3e80000;
}

/* ---- PurgeStatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void PurgeStatusSub__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* ---- StatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Speaker * StatusSub__Q26Speech7Speaker(Speaker *pThis)

{
  return (Speaker *)0x0;
}

/* ---- StatusCount__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int StatusCount__Q26Speech7Speaker(Speaker *pThis)

{
  return 0;
}

/* ---- IsSuper__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void * IsSuper__Q26Speech7Speaker(Speaker *pThis)

{
  return (void *)0x0;
}

/* ---- ClearPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void ClearPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car)

{
  return;
}

/* ---- KnownPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void * KnownPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car)

{
  return (void *)0x0;
}

/* ---- Unit__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Unit__Q26Speech7Speaker(Speaker *pThis)

{
  return 0;
}

/* ---- Status__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Status__Q26Speech7Speaker(Speaker *pThis)

{
  return;
}

/* base Speech::Speaker virtual not separately reconstructed (vtable-only ref, surfaced by #75
 * data-materialization); faithful from nfs4-f.exe @0x80099364 = { jr $ra; addiu $v0,$zero,0 } */
CallSignBank * CallSign__Q26Speech7Speaker(Speaker *pThis)   /* @0x80099364  CallSign__Q26Speech7Speaker -> NULL */
{
  return (CallSignBank *)0;
}

/* ---- #75 data-materialization: 3 Speech vtables (nested Speech::<Leaf>, flat <Leaf>_<Method> pfns). ---- */
__vtbl_ptr_type Speaker_vtable[31] = {   /* @0x80055dc4  Speech::Speaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
  {0, 0, (int (*)(...))0},                           /* @0x80055dc4  null */
  {0, 0, (int (*)(...))&Report__Q26Speech7SpeakerP8Car_tObj},             /* @0x80055dcc  Report__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Status__Q26Speech7Speaker},             /* @0x80055dd4  Status__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Deny__Q26Speech7Speaker},               /* @0x80055ddc  Deny__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Grant__Q26Speech7Speaker},              /* @0x80055de4  Grant__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Ready__Q26Speech7SpeakerP8Car_tObj},              /* @0x80055dec  Ready__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Engage__Q26Speech7SpeakerP8Car_tObj},             /* @0x80055df4  Engage__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Lose__Q26Speech7Speaker},               /* @0x80055dfc  Lose__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Accident__Q26Speech7Speakeri},           /* @0x80055e04  Accident__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&Catch__Q26Speech7Speakeri},              /* @0x80055e0c  Catch__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&RoadBlock__Q26Speech7Speaker},          /* @0x80055e14  RoadBlock__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&SpikeBelt__Q26Speech7Speaker},          /* @0x80055e1c  SpikeBelt__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Backup__Q26Speech7Speaker},             /* @0x80055e24  Backup__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&ReportBlockade__Q26Speech7Speaker},     /* @0x80055e2c  ReportBlockade__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Roger__Q26Speech7Speaker},              /* @0x80055e34  Roger__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Bullhorn__Q26Speech7Speaker},           /* @0x80055e3c  Bullhorn__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Purge__Q26Speech7Speaker},              /* @0x80055e44  Purge__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Unit__Q26Speech7Speaker},               /* @0x80055e4c  Unit__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&KnownPerp__Q26Speech7SpeakerP8Car_tObj},          /* @0x80055e54  KnownPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&ClearPerp__Q26Speech7SpeakerP8Car_tObj},          /* @0x80055e5c  ClearPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&IsSuper__Q26Speech7Speaker},            /* @0x80055e64  IsSuper__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&StatusCount__Q26Speech7Speaker},        /* @0x80055e6c  StatusCount__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&StatusSub__Q26Speech7Speaker},          /* @0x80055e74  StatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&PurgeStatusSub__Q26Speech7Speaker},     /* @0x80055e7c  PurgeStatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&DistToPerp__Q26Speech7Speaker},         /* @0x80055e84  DistToPerp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&CarObj__Q26Speech7Speaker},             /* @0x80055e8c  CarObj__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&ReActivate__Q26Speech7Speaker},         /* @0x80055e94  ReActivate__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Perp__Q26Speech7Speaker},               /* @0x80055e9c  Perp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&GetCarBank__Q26Speech7Speakeri},         /* @0x80055ea4  GetCarBank__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&FindClosestLocationTo__Q26Speech7Speakeri}, /* @0x80055eac  FindClosestLocationTo__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&CallSign__Q26Speech7Speaker},           /* @0x80055eb4  CallSign__Q26Speech7Speaker */
};
__vtbl_ptr_type MobileSpeaker_vtable[31] = {   /* @0x80055bd4  Speech::MobileSpeaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
  {0, 0, (int (*)(...))0},                           /* @0x80055bd4  null */
  {0, 0, (int (*)(...))&Report__Q26Speech13MobileSpeakerP8Car_tObj},       /* @0x80055bdc  Report__Q26Speech13MobileSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Status__Q26Speech13MobileSpeaker},       /* @0x80055be4  Status__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Deny__Q26Speech7Speaker},               /* @0x80055bec  Deny__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Grant__Q26Speech7Speaker},              /* @0x80055bf4  Grant__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Ready__Q26Speech7SpeakerP8Car_tObj},              /* @0x80055bfc  Ready__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Engage__Q26Speech13MobileSpeakerP8Car_tObj},       /* @0x80055c04  Engage__Q26Speech13MobileSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Lose__Q26Speech13MobileSpeaker},         /* @0x80055c0c  Lose__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Accident__Q26Speech13MobileSpeakeri},     /* @0x80055c14  Accident__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&Catch__Q26Speech13MobileSpeakeri},        /* @0x80055c1c  Catch__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&RoadBlock__Q26Speech13MobileSpeaker},    /* @0x80055c24  RoadBlock__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&SpikeBelt__Q26Speech13MobileSpeaker},    /* @0x80055c2c  SpikeBelt__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Backup__Q26Speech13MobileSpeaker},       /* @0x80055c34  Backup__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&ReportBlockade__Q26Speech13MobileSpeaker}, /* @0x80055c3c  ReportBlockade__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Roger__Q26Speech13MobileSpeaker},        /* @0x80055c44  Roger__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Bullhorn__Q26Speech13MobileSpeaker},     /* @0x80055c4c  Bullhorn__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Purge__Q26Speech13MobileSpeaker},        /* @0x80055c54  Purge__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Unit__Q26Speech13MobileSpeaker},         /* @0x80055c5c  Unit__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&KnownPerp__Q26Speech7SpeakerP8Car_tObj},          /* @0x80055c64  KnownPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&ClearPerp__Q26Speech7SpeakerP8Car_tObj},          /* @0x80055c6c  ClearPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&IsSuper__Q26Speech13MobileSpeaker},      /* @0x80055c74  IsSuper__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&StatusCount__Q26Speech7Speaker},        /* @0x80055c7c  StatusCount__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&StatusSub__Q26Speech7Speaker},          /* @0x80055c84  StatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&PurgeStatusSub__Q26Speech7Speaker},     /* @0x80055c8c  PurgeStatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&DistToPerp__Q26Speech13MobileSpeaker},   /* @0x80055c94  DistToPerp__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&CarObj__Q26Speech13MobileSpeaker},       /* @0x80055c9c  CarObj__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&ReActivate__Q26Speech13MobileSpeaker},   /* @0x80055ca4  ReActivate__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Perp__Q26Speech13MobileSpeaker},         /* @0x80055cac  Perp__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&GetCarBank__Q26Speech13MobileSpeakeri},   /* @0x80055cb4  GetCarBank__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&FindClosestLocationTo__Q26Speech13MobileSpeakeri}, /* @0x80055cbc  FindClosestLocationTo__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&CallSign__Q26Speech13MobileSpeaker},     /* @0x80055cc4  CallSign__Q26Speech13MobileSpeaker */
};
__vtbl_ptr_type DispatchSpeaker_vtable[31] = {   /* @0x80055ccc  Speech::DispatchSpeaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
  {0, 0, (int (*)(...))0},                           /* @0x80055ccc  null */
  {0, 0, (int (*)(...))&Report__Q26Speech15DispatchSpeakerP8Car_tObj},     /* @0x80055cd4  Report__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Status__Q26Speech15DispatchSpeaker},     /* @0x80055cdc  Status__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&Deny__Q26Speech15DispatchSpeaker},       /* @0x80055ce4  Deny__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&Grant__Q26Speech15DispatchSpeaker},      /* @0x80055cec  Grant__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&Ready__Q26Speech15DispatchSpeakerP8Car_tObj},      /* @0x80055cf4  Ready__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Engage__Q26Speech7SpeakerP8Car_tObj},             /* @0x80055cfc  Engage__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Lose__Q26Speech7Speaker},               /* @0x80055d04  Lose__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Accident__Q26Speech15DispatchSpeakeri},   /* @0x80055d0c  Accident__Q26Speech15DispatchSpeakeri */
  {0, 0, (int (*)(...))&Catch__Q26Speech7Speakeri},              /* @0x80055d14  Catch__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&RoadBlock__Q26Speech7Speaker},          /* @0x80055d1c  RoadBlock__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&SpikeBelt__Q26Speech7Speaker},          /* @0x80055d24  SpikeBelt__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Backup__Q26Speech7Speaker},             /* @0x80055d2c  Backup__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&ReportBlockade__Q26Speech7Speaker},     /* @0x80055d34  ReportBlockade__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Roger__Q26Speech15DispatchSpeaker},      /* @0x80055d3c  Roger__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&Bullhorn__Q26Speech7Speaker},           /* @0x80055d44  Bullhorn__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Purge__Q26Speech7Speaker},              /* @0x80055d4c  Purge__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Unit__Q26Speech7Speaker},               /* @0x80055d54  Unit__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj},  /* @0x80055d5c  KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj},  /* @0x80055d64  ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&IsSuper__Q26Speech7Speaker},            /* @0x80055d6c  IsSuper__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&StatusCount__Q26Speech15DispatchSpeaker}, /* @0x80055d74  StatusCount__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&StatusSub__Q26Speech15DispatchSpeaker},  /* @0x80055d7c  StatusSub__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&PurgeStatusSub__Q26Speech15DispatchSpeaker}, /* @0x80055d84  PurgeStatusSub__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&DistToPerp__Q26Speech7Speaker},         /* @0x80055d8c  DistToPerp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&CarObj__Q26Speech7Speaker},             /* @0x80055d94  CarObj__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&ReActivate__Q26Speech7Speaker},         /* @0x80055d9c  ReActivate__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Perp__Q26Speech7Speaker},               /* @0x80055da4  Perp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&GetCarBank__Q26Speech15DispatchSpeakeri}, /* @0x80055dac  GetCarBank__Q26Speech15DispatchSpeakeri */
  {0, 0, (int (*)(...))&FindClosestLocationTo__Q26Speech15DispatchSpeakeri}, /* @0x80055db4  FindClosestLocationTo__Q26Speech15DispatchSpeakeri */
  {0, 0, (int (*)(...))&CallSign__Q26Speech15DispatchSpeaker},   /* @0x80055dbc  CallSign__Q26Speech15DispatchSpeaker */
};

/* end of speech.cpp */
}
