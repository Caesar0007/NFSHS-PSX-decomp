/* game/common/speech.h — reconstructed from game/common/speech.cpp, game/common/speech.h (102 fns) */
#ifndef _GAME_COMMON_SPEECH_H_
#define _GAME_COMMON_SPEECH_H_
#include "../../nfs4_types.h"

int StatusCount__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :56 */
void * StatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :57 */
void PurgeStatusSub__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :58 */
void * GetCarBank__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int carIndex);   /* :65 */
void * FindClosestLocationTo__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int slice);   /* :69 */
void * CallSign__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :73 */
BOOL IsSuper__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :106 */
void * CarObj__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :114 */
void * GetCarBank__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int carIndex);   /* :122 */
void * FindClosestLocationTo__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int slice);   /* :126 */
void * CallSign__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :130 */
int Unit__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :134 */
void * Perp__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :147 */
char * Speech_AllocateRAM__FlPc(long numBytes, char *message);   /* :169 */
void Speech_PurgeRAM__FPc(char *memPtr);   /* :174 */
long Speech_HandleRequest__Fllll(long bank, long localoffset, long size, long event);   /* :179 */
void SetCar__Q26Speech11CarBankNamei(CarBankName *self, int carIndex);   /* :234 */
BOOL Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(CarBank *self, char *name, int id, CarBankName *bankname);   /* :257 */
BOOL CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName(Speech *self, CarBank *carbank, char *name, int id, CarBankName *bankname);   /* :281 */
void SetCar__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :301 */
void CountLocations__6Speech(Speech *self);   /* :521 */
BOOL CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(Speech *self, LocationBank *locationbank, char *name, int id);   /* :539 */
int Distance__Q26Speech12LocationBanki(LocationBank *self, int slice);   /* :567 */
void * FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki(Speech *self, LocationBank *bank, int slice);   /* :594 */
void FindLocation__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :624 */
BOOL CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(Speech *self, CallSignBank *bank, char *name, int id);   /* :852 */
BOOL CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(Speech *self, char *name, int id, CarBankName *bn);   /* :889 */
int CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(Speech *self, char *header, CarBankName *bn, long *hoffset, long *hsize);   /* :931 */
void LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(Speech *self, char *header, CarBankName *bn, long hoffset, long hsize);   /* :990 */
void * __6Speech(Speech *self);   /* :1110 */
void Reset__6Speech(void);   /* :1248 */
void ___6Speech(Speech *self, int __in_chrg);   /* :1267 */
int BankPatch__6SpeechlP8Car_tObj(Speech *self, long bank, Car_tObj *car);   /* :1297 */
long SubmitRequest__6Speechlll(long bank, long localoffset, long size);   /* :1317 */
void Report__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *cop);   /* :1352 */
void Deny__Q26Speech7Speaker(Speaker *self);   /* :1363 */
void Grant__Q26Speech7Speaker(Speaker *self);   /* :1371 */
void Ready__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *wing);   /* :1379 */
void Engage__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *perp);   /* :1394 */
void Lose__Q26Speech7Speaker(Speaker *self);   /* :1402 */
void Accident__Q26Speech7Speakeri(Speaker *self, int slice);   /* :1410 */
void Catch__Q26Speech7Speakeri(Speaker *self, int ticket);   /* :1418 */
void RoadBlock__Q26Speech7Speaker(Speaker *self);   /* :1426 */
void SpikeBelt__Q26Speech7Speaker(Speaker *self);   /* :1434 */
void Backup__Q26Speech7Speaker(Speaker *self);   /* :1442 */
void ReportBlockade__Q26Speech7Speaker(Speaker *self);   /* :1450 */
void Roger__Q26Speech7Speaker(Speaker *self);   /* :1459 */
void Bullhorn__Q26Speech7Speaker(Speaker *self);   /* :1467 */
void Purge__Q26Speech7Speaker(Speaker *self);   /* :1475 */
void Promote__Q26Speech7Speaker(Speaker *self);   /* :1490 */
void Speech_Server__Fv(void);   /* :1539 */
void SetDelayedStatus__6SpeechPQ26Speech7Speakeri(Speech *self, Speaker *sub, int delay);   /* :1546 */
void Activate__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int seedupdatecount);   /* :1554 */
void * Dispatch__6Speech(void);   /* :1578 */
void Roger__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1592 */
void StatusReply__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1636 */
void Status__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1718 */
void Status__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :1853 */
void ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1954 */
BOOL KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1964 */
void AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1976 */
void Report__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *perp);   /* :1990 */
void Accident__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int slice);   /* :2039 */
void Deny__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :2049 */
void Grant__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :2079 */
void Ready__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *carObj);   /* :2104 */
int PickVoice__6SpeechP8Car_tObj(Speech *self, Car_tObj *carObj);   /* :2144 */
int GetVoice__6SpeechP8Car_tObj(Car_tObj *carObj);   /* :2156 */
void Activate__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *self, Car_tObj *carObj);   /* :2163 */
void ReActivate__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2199 */
void * FindMobile__6SpeechP8Car_tObj(Speech *self, Car_tObj *carObj);   /* :2218 */
void * Mobile__6SpeechP8Car_tObj(Car_tObj *carObj);   /* :2244 */
int CalcMph__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *perp);   /* :2256 */
void SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *self, Car_tObj *perp);   /* :2263 */
int DistToPerp__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2281 */
void Report__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *self, Car_tObj *perp);   /* :2295 */
void Engage__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *self, Car_tObj *perp);   /* :2331 */
void Lose__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2463 */
void Accident__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int slice);   /* :2544 */
void Catch__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int ticket);   /* :2554 */
void RoadBlock__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2627 */
void SpikeBelt__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2656 */
void Backup__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2685 */
void Roger__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2711 */
void Bullhorn__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2741 */
void Purge__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2754 */
void ReportBlockade__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2843 */

/* ---- header-defined (inline / class) functions ---- */
void Status__Q26Speech7Speaker(Speaker *self);   /* :264 */
int Unit__Q26Speech7Speaker(Speaker *self);   /* :323 */
BOOL KnownPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :328 */
void ClearPerp__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :329 */
BOOL IsSuper__Q26Speech7Speaker(Speaker *self);   /* :331 */
int StatusCount__Q26Speech7Speaker(Speaker *self);   /* :332 */
void * StatusSub__Q26Speech7Speaker(Speaker *self);   /* :333 */
void PurgeStatusSub__Q26Speech7Speaker(Speaker *self);   /* :334 */
int DistToPerp__Q26Speech7Speaker(Speaker *self);   /* :335 */
void * CarObj__Q26Speech7Speaker(Speaker *self);   /* :336 */
void ReActivate__Q26Speech7Speaker(Speaker *self);   /* :337 */
void * Perp__Q26Speech7Speaker(Speaker *self);   /* :338 */
void * GetCarBank__Q26Speech7Speakeri(Speaker *self, int carIndex);   /* :362 */
void * FindClosestLocationTo__Q26Speech7Speakeri(Speaker *self, int slice);   /* :366 */
void * CallSign__Q26Speech7Speaker(Speaker *self);   /* :370 */

#endif /* _GAME_COMMON_SPEECH_H_ */
