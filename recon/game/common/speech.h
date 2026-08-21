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
bool IsSuper__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :106 */
void * CarObj__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :114 */
void * GetCarBank__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int carIndex);   /* :122 */
void * FindClosestLocationTo__Q26Speech13MobileSpeakeri(MobileSpeaker *self, int slice);   /* :126 */
void * CallSign__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :130 */
int Unit__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :134 */
void * Perp__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :147 */
char * Speech_AllocateRAM(long numBytes, char *message);   /* :169 */
void Speech_PurgeRAM(char *memPtr);   /* :174 */
long Speech_HandleRequest(long bank, long localoffset, long size, long event);   /* :179 */
void SetCar__Q26Speech11CarBankNamei(CarBankName *self, int carIndex);   /* :234 */
bool Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(CarBank *self, char *name, int id, CarBankName *bankname);   /* :257 */
void SetCar__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :301 */
int Distance__Q26Speech12LocationBanki(LocationBank *self, int slice);   /* :567 */
void FindLocation__Q26Speech7SpeakerP8Car_tObj(Speaker *self, Car_tObj *car);   /* :624 */
void * __6Speech(Speech *self);   /* :1110 */
void ___6Speech(Speech *self, int __in_chrg);   /* :1267 */
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
void Speech_Server(void);   /* :1539 */
void Activate__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int seedupdatecount);   /* :1554 */
void Roger__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1592 */
void StatusReply__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1636 */
void Status__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :1718 */
void Status__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :1853 */
void ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1954 */
bool KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1964 */
void AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *car);   /* :1976 */
void Report__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *perp);   /* :1990 */
void Accident__Q26Speech15DispatchSpeakeri(DispatchSpeaker *self, int slice);   /* :2039 */
void Deny__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :2049 */
void Grant__Q26Speech15DispatchSpeaker(DispatchSpeaker *self);   /* :2079 */
void Ready__Q26Speech15DispatchSpeakerP8Car_tObj(DispatchSpeaker *self, Car_tObj *carObj);   /* :2104 */
void Activate__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *self, Car_tObj *carObj);   /* :2163 */
void ReActivate__Q26Speech13MobileSpeaker(MobileSpeaker *self);   /* :2199 */
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

/* Header-attributed Speech::Speaker methods are declared on the flattened
   Speaker layout type in nfs4_types.h with their retail nested-class labels. */

#endif /* _GAME_COMMON_SPEECH_H_ */
