/* game/common/speech_class.h -- class Speech (SPEECH.CPP) with its nested classes, shared by every surface that
 * constructs it or names its static members.  Needs only u_long and an (incomplete) Car_tObj. */
#ifndef NFS4_GAME_COMMON_SPEECH_CLASS_H
#define NFS4_GAME_COMMON_SPEECH_CLASS_H

struct Car_tObj;

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

struct Speech {
    /* the nested classes: retail manglings are Q26Speech7Speaker, Q26Speech13MobileSpeaker, ... */
    struct CarBankName;

    struct CarBank {
        int fFull, fMake, fModel;
        CarBank() : fFull(-1), fMake(-1), fModel(-1) {}
        bool Check(char *name, int id, CarBankName *bankname);
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
        int Distance(int slice);
    };

    struct CallSignBank {
        int fAllUnits, fDispatch;
        int fMobile[15];
        inline void SetAllUnits(int bankid) { fAllUnits = bankid; }
        inline void SetDispatch(int bankid) { fDispatch = bankid; }
        inline int Dispatch() { return fDispatch; }
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
        Speaker() { fSub = 0; }   /* inline: retail stores the Speaker table, zeroes fSub, then stores the derived table */
        Speaker *Sub() { return fSub; }   /* inline accessor: proven by DispatchSpeaker::Status' Engage(Perp()) evaluation order */
#include "speech_speaker_virtuals.inc"
        void SetCar(Car_tObj *car);
        void FindLocation(Car_tObj *car);
        int CalcMph(Car_tObj *perp);
        void Promote();
        inline void ClearCar() {
            fCar = 0;
            fColour.flags = 0;
        }
        inline void SetColour(int Colour);
        inline void SetBlockade(int Blockade) { fBlockade.flags = Blockade; }
        /* inline setters: retail's SYM shows one zero-length `this` pair per field reset (e.g. Purge's five at +1a0) */
        inline void SetArrest(int Arrest) { fArrest.flags = Arrest; }
        inline void SetUpdate(int Update) { fUpdate.flags = Update; }
        inline void SetSub(Speaker *Sub) { fSub = Sub; }
        inline void SetTo(int to) { fTo = to; }
        inline int To() { return fTo; }
        inline int From() { return fFrom; }
        inline SPCHNFSType_REVINTRO *Reverse() { return &fReverse; }
        inline SPCHNFSType_POSITION *Position() { return &fPosition; }
        inline SPCHNFSType_SPIKE_BELT_SIDE *SpikeSide() { return &fSpikeSide; }
        inline void SetSpikeSide(int side) { fSpikeSide.flags = side; }
        inline int BlockadeFlags() { return fBlockade.flags; }
        inline int Car() { return fCar; }
        inline SPCHNFSType_vs_RDBLK_SSTRP *BlockadeSlot() { return &fBlockade; }
        inline SPCHNFSType_CONFIRM *Confirm() { return &fConfirm; }
        inline bool HasDifferentSub(Speaker *Wing) {
            return fSub != 0 && Wing != fSub;
        }
        inline int Location() { return fLocation; }
        inline SPCHNFSType_DISTANCE *Distance() { return &fDistance; }
        inline SPCHNFSType_COLOUR *Colour() { return &fColour; }

        /* The retail class declared these operations virtual.  The reconstructed
           layout keeps the recovered PsyQ vtable explicit, so these zero-local
           bridges preserve ordinary source-level virtual call sites without
           inventing receiver/vtable temporaries in their callers. */
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
        void SetCar(int carIndex);
    };

    /* declaration ORDER is retail evidence: tables are emitted Mobile, Dispatch, Speaker = reverse of Speaker, Dispatch, Mobile */
    struct DispatchSpeaker : public Speaker {
        /* inline ctor: retail's Speech::Speech() shows it expanded in place */
        DispatchSpeaker() {}
        inline void ClearSpeaker();   /* defined after struct Speech (inner Speech inline) */
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

    struct MobileSpeaker : public Speaker {
        /* inline ctor: retail's Speech::Speech() shows it expanded in place */
        MobileSpeaker() { fCarObj = 0; }
        SPCHNFSType_VOICE fVoice;
        SPCHNFSType_vs_KMH_MPH fSpeedType;
        int fSpeed, fUnit;
        Car_tObj *fCarObj, *fPerp;
        inline void SetPerp(Car_tObj *perp) { fPerp = perp; }
        /* retail: `Speech::fgSpeech->fSpeakerCar = fCarObj` is an inline on the mobile that calls an inner
           Speech inline with parameter `carObj` (Bullhorn's nested pair records carObj/$2 and the Speech this) */
        inline void MakeSpeaker();   /* defined after struct Speech so the inner Speech inline is expanded */
        inline SPCHNFSType_VOICE *Voice() { return &fVoice; }
        inline void SetSpeedType(int type) { fSpeedType.flags = type; }
        inline void ClearCarObj() { fCarObj = 0; }
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
    bool CheckCarBank(CarBank *carbank, char *name, int id, CarBankName *bankname);
    void CountLocations();
    bool CheckLocationBank(LocationBank *locationbank, char *name, int id);
    bool CheckCallSignBank(CallSignBank *bank, char *name, int id);
    bool CheckMultiBank(char *name, int id, CarBankName *bn);
    inline long BankOffset(long bank) {
        return bank >= 0 && bank < fBankCount ? fBankOffset[bank] : 0;
    }
    inline int FileHandle() { return fFileHandle; }
    inline void SetSpeakerCar(Car_tObj *carObj) { fSpeakerCar = carObj; }
    static inline int MultiplePerps() { return fgSpeech->fMultiplePerps; }
    /* bank accessors: retail's one-line Speaker accessors are each a single inline-call pair -- a member on
       the instance (`this` only) or a forwarding member (`this` + `slice`) */
    inline CallSignBank *MobileCallSign() { return &fCallSignBank.Mobile; }
    inline CallSignBank *DispatchCallSign() { return &fCallSignBank.Dispatch; }
    inline LocationBank *ClosestMobileLocation(int slice) { return FindClosestLocationTo(fLocationBank.Mobile, slice); }
    inline LocationBank *ClosestDispatchLocation(int slice) { return FindClosestLocationTo(fLocationBank.Dispatch, slice); }
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
    LocationBank *FindClosestLocationTo(LocationBank *bank, int slice);
    int CalculateBankSize(char *header, CarBankName *bn, long *hoffset, long *hsize);
    void LoadBankHeaders(char *header, CarBankName *bn, long hoffset, long hsize);
    void SetDelayedStatus(Speaker *sub, int delay);
    int PickVoice(Car_tObj *carObj);
    Speaker *FindMobile(Car_tObj *carObj);
    static void Reset();
    static long SubmitRequest(long bank, long localoffset, long size);
    static Speaker *Dispatch();
    static int GetVoice(Car_tObj *carObj);
    static Speaker *Mobile(Car_tObj *carObj);
    static Speech *fgSpeech;
    static Speaker *fgUndefined;
    Speech();
    ~Speech();
};

inline void Speech::MobileSpeaker::MakeSpeaker() { fgSpeech->SetSpeakerCar(fCarObj); }
inline void Speech::DispatchSpeaker::ClearSpeaker() { fgSpeech->SetSpeakerCar(0); }


#endif
