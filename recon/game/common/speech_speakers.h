/* game/common/speech_speakers.h -- Speech::DispatchSpeaker / Speech::MobileSpeaker (retail: defined in SPEECH.CPP, after
 * SPEECH.H forward-declared them inside class Speech; no other retail object records either class).  Included by
 * speech_types.h only. */
#ifndef NFS4_GAME_COMMON_SPEECH_SPEAKERS_H
#define NFS4_GAME_COMMON_SPEECH_SPEAKERS_H
struct Speech::DispatchSpeaker : public Speech::Speaker {
    /* no user constructor: retail's Speech::Speech() expands only the base Speaker() pair for `new DispatchSpeaker`
       (MobileSpeaker's user constructor adds a body block after that pair) */
    inline void ClearSpeaker() NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline: its blocks record line 1) */
    int fStatusCount;
    Speaker *fStatusSub;
    int fUpdateCount;
    Car_tObj *fPerp[2];
    CallSignBank *CallSign();
    LocationBank *FindClosestLocationTo(int slice);
    CarBank *GetCarBank(int carIndex);
    void PurgeStatusSub();
    Speaker *StatusSub();
    int StatusCount();
    void ClearPerp(Car_tObj *car);
    bool KnownPerp(Car_tObj *car);
    void Accident(int slice);
    void Grant();
    void Ready(Car_tObj *carObj);
    void AddPerp(Car_tObj *car);
    void Activate(int seedupdatecount);
    void Deny();
    void Roger();
    void StatusReply();
    void Status();
    void Report(Car_tObj *perp);
};
struct Speech::MobileSpeaker : public Speech::Speaker {
    MobileSpeaker() NFS4_SPEECH_STRIP;   /* inline ctor: retail's Speech::Speech() shows it expanded in place */
    SPCHNFSType_VOICE fVoice;
    SPCHNFSType_vs_KMH_MPH fSpeedType;
    int fSpeed, fUnit;
    Car_tObj *fCarObj, *fPerp;
    inline void SetPerp(Car_tObj *car) NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail same-file inline: its nests record line 1) */
    /* retail: `Speech::fgSpeech->fSpeakerCar = fCarObj` is an inline on the mobile that calls an inner
       Speech inline with parameter `carObj` (Bullhorn's nested pair records carObj/$2 and the Speech this) */
    inline void MakeSpeaker() NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline: its blocks record line 1) */
    inline void DelayStatus(int delay) NFS4_SPEECH_STRIP;   /* Catch: `this` pair around Speech::SetDelayedStatus (defined in speech.cpp) */
    inline SPCHNFSType_VOICE *Voice() NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline) */
    inline void SetVoice(int Voice) NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline: its blocks record line 1) */
    inline void SetSpeedType(int type) NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline) */
    inline int Speed() NFS4_SPEECH_STRIP;
    inline SPCHNFSType_vs_KMH_MPH *SpeedType() NFS4_SPEECH_STRIP;
    inline void ClearCarObj() NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail SPEECH.CPP inline) */
    inline bool IsCar(Car_tObj *carObj) NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail same-file inline: its nests record line 1) */   /* FindMobile's two loops each call one inline on fMobile[i]: (this, carObj) and (this) */
    inline bool IsFree() NFS4_SPEECH_STRIP;   /* defined in speech.cpp (retail same-file inline: its nests record line 1) */
    Car_tObj *Perp();
    int Unit();
    CallSignBank *CallSign();
    LocationBank *FindClosestLocationTo(int slice);
    CarBank *GetCarBank(int carIndex);
    Car_tObj *CarObj();
    bool IsSuper();
    void ReActivate();
    int DistToPerp();
    void Accident(int slice);
    void Bullhorn();
    void SetSpeed(Car_tObj *perp);
    void Activate(Car_tObj *carObj);
    void RoadBlock();
    void SpikeBelt();
    void Backup();
    void Report(Car_tObj *perp);
    void ReportBlockade();
    void Roger();
    void Purge();
    void Catch(int ticket);
    void Lose();
    void Status();
    void Engage(Car_tObj *perp);
};
inline Speech::MobileSpeaker::MobileSpeaker() { fCarObj = 0; } inline int Speech::MobileSpeaker::Speed() { return fSpeed; } inline SPCHNFSType_vs_KMH_MPH *Speech::MobileSpeaker::SpeedType() { return &fSpeedType; }
#endif
