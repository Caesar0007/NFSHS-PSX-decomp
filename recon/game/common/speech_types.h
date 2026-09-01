/* Speech.obj's exact source-visible delta over the shared AudioClc graph. */
#ifndef NFS4_GAME_COMMON_SPEECH_TYPES_H
#define NFS4_GAME_COMMON_SPEECH_TYPES_H

#define NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#define NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#define NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#define NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#define NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#define NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#include "audioclc_types.h"
#undef NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#undef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#undef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#undef forceFocus_t
#undef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#undef NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#undef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES

/* Speech.obj uses GameSetup storage without retaining its completed tag. */
#define GameSetup_tData AudioClc_GameSetupCodegenView

typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct SPCHNFSType_POSITION { u_long flags; };
struct SPCHNFSType_DISTANCE { u_long flags; };
struct SPCHNFSType_COLOUR { u_long flags; };
struct SPCHNFSType_ACCIDENT { u_long flags; };
struct SPCHNFSType_AMBULANCE { u_long flags; };
struct SPCHNFSType_PURS_UPDT { u_long flags; };
struct SPCHNFSType_ARREST { u_long flags; };
struct SPCHNFSType_vs_RDBLK_SSTRP { u_long flags; };
struct SPCHNFSType_PERP_NAME { u_long flags; };
struct SPCHNFSType_CONFIRM { u_long flags; };
struct SPCHNFSType_SPIKE_BELT_SIDE { u_long flags; };
struct SPCHNFSType_REVINTRO { u_long flags; };
struct SPCHNFSType_vs_KMH_MPH { u_long flags; };
struct SPCHNFSType_VOICE { u_long flags; };

struct CarBankName;
struct MobileSpeaker;
struct DispatchSpeaker;

struct CarBank {
    int fFull, fMake, fModel;
    CarBank() : fFull(-1), fMake(-1), fModel(-1) {}
    bool Check(char *name, int id, CarBankName *bankname)
      asm("Check__Q26Speech7CarBankPciPQ26Speech11CarBankName");
};

struct LocationBank {
    int fStartSlice, fEndSlice, fBankId;
    char *fName;
    LocationBank() : fBankId(-1) {}
    inline void Set(int start, int end, int bankid, char *name) {
        fBankId = bankid;
        fStartSlice = start;
        fEndSlice = end;
        fName = name;
    }
    int Distance(int slice) asm("Distance__Q26Speech12LocationBanki");
};

struct CallSignBank {
    int fAllUnits, fDispatch;
    int fMobile[15];
    inline void SetAllUnits(int bankid) { fAllUnits = bankid; }
    inline void SetDispatch(int bankid) { fDispatch = bankid; }
    inline void SetMobile(int unit, int bankid) { fMobile[unit] = bankid; }
};

struct Speaker {
    SPCHNFSType_POSITION fPosition;
    SPCHNFSType_DISTANCE fDistance;
    SPCHNFSType_COLOUR fColour;
    SPCHNFSType_ACCIDENT fAccident;
    SPCHNFSType_AMBULANCE fAmbulance;
    SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
    SPCHNFSType_REVINTRO fReverse;
    SPCHNFSType_CONFIRM fConfirm;
    SPCHNFSType_PERP_NAME fPerpName;
    SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
    SPCHNFSType_PURS_UPDT fUpdate;
    SPCHNFSType_ARREST fArrest;
    int fCar, fLocation, fFrom, fTo, fWing;
    bool fHavePerp;
    Speaker *fSub;
    __vtbl_ptr_type (*_vf)[31];
    void Report(Car_tObj *cop) asm("Report__Q26Speech7SpeakerP8Car_tObj");
    void Deny() asm("Deny__Q26Speech7Speaker");
    void Grant() asm("Grant__Q26Speech7Speaker");
    void Ready(Car_tObj *wing) asm("Ready__Q26Speech7SpeakerP8Car_tObj");
    void Engage(Car_tObj *perp) asm("Engage__Q26Speech7SpeakerP8Car_tObj");
    void Lose() asm("Lose__Q26Speech7Speaker");
    void Accident(int slice) asm("Accident__Q26Speech7Speakeri");
    void Catch(int ticket) asm("Catch__Q26Speech7Speakeri");
    void RoadBlock() asm("RoadBlock__Q26Speech7Speaker");
    void SpikeBelt() asm("SpikeBelt__Q26Speech7Speaker");
    void Backup() asm("Backup__Q26Speech7Speaker");
    void ReportBlockade() asm("ReportBlockade__Q26Speech7Speaker");
    void Roger() asm("Roger__Q26Speech7Speaker");
    void Bullhorn() asm("Bullhorn__Q26Speech7Speaker");
    void Purge() asm("Purge__Q26Speech7Speaker");
    void SetCar(Car_tObj *car) asm("SetCar__Q26Speech7SpeakerP8Car_tObj");
    void FindLocation(Car_tObj *car) asm("FindLocation__Q26Speech7SpeakerP8Car_tObj");
    int CalcMph(Car_tObj *perp) asm("CalcMph__Q26Speech7SpeakerP8Car_tObj");
    void Promote() asm("Promote__Q26Speech7Speaker");
    void Status() asm("Status__Q26Speech7Speaker");
    int Unit() asm("Unit__Q26Speech7Speaker");
    bool KnownPerp(Car_tObj *car) asm("KnownPerp__Q26Speech7SpeakerP8Car_tObj");
    void ClearPerp(Car_tObj *car) asm("ClearPerp__Q26Speech7SpeakerP8Car_tObj");
    bool IsSuper() asm("IsSuper__Q26Speech7Speaker");
    int StatusCount() asm("StatusCount__Q26Speech7Speaker");
    Speaker *StatusSub() asm("StatusSub__Q26Speech7Speaker");
    void PurgeStatusSub() asm("PurgeStatusSub__Q26Speech7Speaker");
    int DistToPerp() asm("DistToPerp__Q26Speech7Speaker");
    Car_tObj *CarObj() asm("CarObj__Q26Speech7Speaker");
    void ReActivate() asm("ReActivate__Q26Speech7Speaker");
    Car_tObj *Perp() asm("Perp__Q26Speech7Speaker");
    CarBank *GetCarBank(int carIndex) asm("GetCarBank__Q26Speech7Speakeri");
    inline void ClearCar() {
        fCar = 0;
        fColour.flags = 0;
    }
    inline void SetColour(int Colour);
    inline void SetBlockade(int Blockade) { fBlockade.flags = Blockade; }
    inline bool HasDifferentSub(Speaker *Wing) {
        return fSub != 0 && Wing != fSub;
    }
    inline int Location() { return fLocation; }
    inline SPCHNFSType_DISTANCE *Distance() { return &fDistance; }
    inline SPCHNFSType_COLOUR *Colour() { return &fColour; }
    LocationBank *FindClosestLocationTo(int slice) asm("FindClosestLocationTo__Q26Speech7Speakeri");
    CallSignBank *CallSign() asm("CallSign__Q26Speech7Speaker");

    /* The retail class declared these operations virtual.  The reconstructed
       layout keeps the recovered PsyQ vtable explicit, so these zero-local
       bridges preserve ordinary source-level virtual call sites without
       inventing receiver/vtable temporaries in their callers. */
    inline void VirtualReport(Car_tObj *car) {
        (*(*_vf)[1].pfn)((int)&fPosition.flags + (int)(*_vf)[1].delta, car);
    }
    inline void VirtualStatus() {
        (*(*_vf)[2].pfn)((int)&fPosition.flags + (int)(*_vf)[2].delta);
    }
    inline void VirtualEngage(Car_tObj *perp) {
        (*(*_vf)[6].pfn)((int)&fPosition.flags + (int)(*_vf)[6].delta, perp);
    }
    inline bool VirtualKnownPerp(Car_tObj *car) {
        return (*(*_vf)[18].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[18].delta, car) != 0;
    }
    inline void VirtualClearPerp(Car_tObj *car) {
        (*(*_vf)[19].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[19].delta, car);
    }
    inline bool VirtualIsSuper() {
        return (*(*_vf)[20].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[20].delta) != 0;
    }
    inline int VirtualStatusCount() {
        return (*(*_vf)[21].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[21].delta);
    }
    inline Car_tObj *VirtualCarObj() {
        return (Car_tObj *)(*(*_vf)[25].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[25].delta);
    }
    inline Car_tObj *VirtualPerp() {
        return (Car_tObj *)(*(*_vf)[27].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[27].delta);
    }
    inline CarBank *VirtualGetCarBank(int carIndex) {
        return (CarBank *)(*(*_vf)[28].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[28].delta, carIndex);
    }
    inline CallSignBank *VirtualCallSign() {
        return (CallSignBank *)(*(*_vf)[30].pfn)
            ((int)&fPosition.flags + (int)(*_vf)[30].delta);
    }
};

struct CarBankName {
    char *fFull, *fMake, *fModel;
    inline bool Full(char *name) {
        return fFull != 0 && strncmp(name, fFull, strlen(fFull)) == 0;
    }
    inline bool Make(char *name) {
        return fMake != 0 && strncmp(name, fMake, strlen(fMake)) == 0;
    }
    inline bool Model(char *name) {
        return fModel != 0 && strncmp(name, fModel, strlen(fModel)) == 0;
    }
    void SetCar(int carIndex) asm("SetCar__Q26Speech11CarBankNamei");
};

struct Speech {
    struct { CarBank Mobile[9], Dispatch[9]; } fCarBank;
    struct { LocationBank Mobile[16], Dispatch[16]; } fLocationBank;
    struct { CallSignBank Mobile, Dispatch; } fCallSignBank;
    int fLocationCount;
    bool fFileOpen;
    int fFileHandle;
    long *fBankOffset;
    int fBankCount, fBlpClpBank, fStaticBank, fCarCount, fCopCount;
    int fSuperCount, fMultiplePerps;
    Car_tObj *fSpeakerCar;
    MobileSpeaker *fMobile[4];
    DispatchSpeaker *fDispatch;
    bool CheckCarBank(CarBank *carbank, char *name, int id, CarBankName *bankname)
      asm("CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName");
    void CountLocations();
    bool CheckLocationBank(LocationBank *locationbank, char *name, int id)
      asm("CheckLocationBank__6SpeechPQ26Speech12LocationBankPci");
    bool CheckCallSignBank(CallSignBank *bank, char *name, int id)
      asm("CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci");
    bool CheckMultiBank(char *name, int id, CarBankName *bn)
      asm("CheckMultiBank__6SpeechPciPQ26Speech11CarBankName");
    inline long BankOffset(long bank) {
        return bank >= 0 && bank < fBankCount ? fBankOffset[bank] : 0;
    }
    inline int FileHandle() { return fFileHandle; }
    inline int ReadBE32(char *p) {
        int a = (u_char)p[0];
        int b = (u_char)p[1];
        int c = (u_char)p[2];
        int d = (u_char)p[3];
        return (((a << 8 | b) << 8 | c) << 8 | d);
    }
    inline bool IsHeader(int a, int b, int c, int d, int period,
                         int h, int hd) {
        return a == period && b == h && c == hd && d == 'r';
    }
    inline bool IsData(int a, int b, int c, int d, int period,
                       int dc, int ac) {
        return a == period && b == dc && c == ac && d == 't';
    }
    int BankPatch(long bank, Car_tObj *car);
    LocationBank *FindClosestLocationTo(LocationBank *bank, int slice)
      asm("FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki");
    int CalculateBankSize(char *header, CarBankName *bn, long *hoffset, long *hsize)
      asm("CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3");
    void LoadBankHeaders(char *header, CarBankName *bn, long hoffset, long hsize)
      asm("LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell");
    void SetDelayedStatus(Speaker *sub, int delay)
      asm("SetDelayedStatus__6SpeechPQ26Speech7Speakeri");
    int PickVoice(Car_tObj *carObj);
    Speaker *FindMobile(Car_tObj *carObj);
    static void Reset();
    static long SubmitRequest(long bank, long localoffset, long size);
    static Speaker *Dispatch();
    static int GetVoice(Car_tObj *carObj);
    static Speaker *Mobile(Car_tObj *carObj);
    Speech();
    ~Speech();
};

struct MobileSpeaker {
    Speaker _base_Speaker;
    SPCHNFSType_VOICE fVoice;
    SPCHNFSType_vs_KMH_MPH fSpeedType;
    int fSpeed, fUnit;
    Car_tObj *fCarObj, *fPerp;
    Car_tObj *Perp() asm("Perp__Q26Speech13MobileSpeaker");
    int Unit() asm("Unit__Q26Speech13MobileSpeaker");
    CallSignBank *CallSign() asm("CallSign__Q26Speech13MobileSpeaker");
    LocationBank *FindClosestLocationTo(int slice)
      asm("FindClosestLocationTo__Q26Speech13MobileSpeakeri");
    CarBank *GetCarBank(int carIndex) asm("GetCarBank__Q26Speech13MobileSpeakeri");
    Car_tObj *CarObj() asm("CarObj__Q26Speech13MobileSpeaker");
    bool IsSuper() asm("IsSuper__Q26Speech13MobileSpeaker");
    void ReActivate() asm("ReActivate__Q26Speech13MobileSpeaker");
    int DistToPerp() asm("DistToPerp__Q26Speech13MobileSpeaker");
    void Accident(int slice) asm("Accident__Q26Speech13MobileSpeakeri");
    void Bullhorn() asm("Bullhorn__Q26Speech13MobileSpeaker");
    void SetSpeed(Car_tObj *perp) asm("SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj");
    void Activate(Car_tObj *carObj) asm("Activate__Q26Speech13MobileSpeakerP8Car_tObj");
    void RoadBlock() asm("RoadBlock__Q26Speech13MobileSpeaker");
    void SpikeBelt() asm("SpikeBelt__Q26Speech13MobileSpeaker");
    void Backup() asm("Backup__Q26Speech13MobileSpeaker");
    void Report(Car_tObj *perp) asm("Report__Q26Speech13MobileSpeakerP8Car_tObj");
    void ReportBlockade() asm("ReportBlockade__Q26Speech13MobileSpeaker");
    void Roger() asm("Roger__Q26Speech13MobileSpeaker");
    void Purge() asm("Purge__Q26Speech13MobileSpeaker");
    void Catch(int ticket) asm("Catch__Q26Speech13MobileSpeakeri");
    void Lose() asm("Lose__Q26Speech13MobileSpeaker");
    void Status() asm("Status__Q26Speech13MobileSpeaker");
    void Engage(Car_tObj *perp) asm("Engage__Q26Speech13MobileSpeakerP8Car_tObj");
};

struct DispatchSpeaker {
    Speaker _base_Speaker;
    int fStatusCount;
    Speaker *fStatusSub;
    int fUpdateCount;
    Car_tObj *fPerp[2];
    CallSignBank *CallSign() asm("CallSign__Q26Speech15DispatchSpeaker");
    LocationBank *FindClosestLocationTo(int slice)
      asm("FindClosestLocationTo__Q26Speech15DispatchSpeakeri");
    CarBank *GetCarBank(int carIndex) asm("GetCarBank__Q26Speech15DispatchSpeakeri");
    void PurgeStatusSub() asm("PurgeStatusSub__Q26Speech15DispatchSpeaker");
    Speaker *StatusSub() asm("StatusSub__Q26Speech15DispatchSpeaker");
    int StatusCount() asm("StatusCount__Q26Speech15DispatchSpeaker");
    void ClearPerp(Car_tObj *car) asm("ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj");
    bool KnownPerp(Car_tObj *car) asm("KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj");
    void Accident(int slice) asm("Accident__Q26Speech15DispatchSpeakeri");
    void Grant() asm("Grant__Q26Speech15DispatchSpeaker");
    void Ready(Car_tObj *carObj) asm("Ready__Q26Speech15DispatchSpeakerP8Car_tObj");
    void AddPerp(Car_tObj *car) asm("AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj");
    void Activate(int seedupdatecount) asm("Activate__Q26Speech15DispatchSpeakeri");
    void Deny() asm("Deny__Q26Speech15DispatchSpeaker");
    void Roger() asm("Roger__Q26Speech15DispatchSpeaker");
    void StatusReply() asm("StatusReply__Q26Speech15DispatchSpeaker");
    void Status() asm("Status__Q26Speech15DispatchSpeaker");
    void Report(Car_tObj *perp) asm("Report__Q26Speech15DispatchSpeakerP8Car_tObj");
};

struct Speech_tCarDescription { char *game, *full, *make, *model; };
struct Speech_tLocationDescription { char *name; short start, end; };
struct Speech_tCallSignDescription {
    char *AllUnits;
    char *Dispatch[5];
    char *Mobile[15];
};
struct Speech_tMobileVoiceAttr { int voice, pitch; };

typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif
