/* game/common/speech_class.h -- class Speech (SPEECH.CPP) with its nested classes, shared by every surface that
 * constructs it or names its static members. Needs u_long, u_char and an (incomplete) Car_tObj. */
#ifndef NFS4_GAME_COMMON_SPEECH_CLASS_H
#define NFS4_GAME_COMMON_SPEECH_CLASS_H
#ifndef NFS4_SPEECH_STRIP   /* speech.obj (speech_types.h) defines it LINK_STRIPPED: its standalone copies of the inline Speaker/MobileSpeaker/DispatchSpeaker members go to .text.strip */
#define NFS4_SPEECH_STRIP
#endif
extern "C" int strlen(...);   /* PsyQ4.3 STRINGS.H: declare these before the inline name comparisons (late/implicit declarations are not a portable C++ interface) */
extern "C" int strncmp(char *, char *, int);
struct Car_tObj;
#include "shared/SPCHNFSType_POSITION.h"
#include "shared/SPCHNFSType_DISTANCE.h"
#include "shared/SPCHNFSType_COLOUR.h"
#include "shared/SPCHNFSType_ACCIDENT.h"
#include "shared/SPCHNFSType_AMBULANCE.h"
#include "shared/SPCHNFSType_PURS_UPDT.h"
#include "shared/SPCHNFSType_ARREST.h"
#include "shared/SPCHNFSType_vs_RDBLK_SSTRP.h"
#include "shared/SPCHNFSType_PERP_NAME.h"
#include "shared/SPCHNFSType_CONFIRM.h"
#include "shared/SPCHNFSType_SPIKE_BELT_SIDE.h"
#include "shared/SPCHNFSType_REVINTRO.h"
#include "shared/SPCHNFSType_vs_KMH_MPH.h"
#include "shared/SPCHNFSType_VOICE.h"

struct Speech {
    /* the nested classes: retail manglings are Q26Speech7Speaker, Q26Speech13MobileSpeaker, ... */
    inline long BankOffset(long bank) {
        return bank >= 0 && bank < fBankCount ? fBankOffset[bank] : 0;
    }
    inline int FileHandle() { return fFileHandle; }
    inline void SetSpeakerCar(Car_tObj *carObj) { fSpeakerCar = carObj; }
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
    typedef struct CarBank {
        int fFull, fMake, fModel;
        CarBank() : fFull(-1), fMake(-1), fModel(-1) {}
        bool Check(char *name, int id, CarBankName *bankname);
        /* getters: Speaker::SetCar reads them through GetCarBank()'s temporary (variable-free pairs) */
        inline int Full() { return fFull; }
        inline int Model() { return fModel; }
    } CarBank;

    typedef struct LocationBank {
        int fStartSlice, fEndSlice, fBankId;
        char *fName;
        LocationBank() : fBankId(-1) {}
        inline void Set(int start, int end, int bankid, char *name) {
            fBankId = bankid;
            fStartSlice = start;
            fEndSlice = end;
            fName = name;
        }
        inline int BankId() { return fBankId; }   /* FindClosestLocationTo: one pair on `locationbank` */
        int Distance(int slice);
    } LocationBank;

    typedef struct CallSignBank {
        int fAllUnits, fDispatch;
        int fMobile[15];
        inline void SetAllUnits(int bankid) { fAllUnits = bankid; }
        inline void SetDispatch(int bankid) { fDispatch = bankid; }
        inline int Dispatch() { return fDispatch; }
        inline int AllUnits() { return fAllUnits; }
        inline void SetMobile(int unit, int bankid) { fMobile[unit] = bankid; }
        inline int Mobile(int unit) { return fMobile[unit]; }
    } CallSignBank;

    struct { CarBank Mobile[9], Dispatch[9]; } fCarBank;
    struct { LocationBank Mobile[16], Dispatch[16]; } fLocationBank;
    struct { CallSignBank Mobile, Dispatch; } fCallSignBank;
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
        Speaker() NFS4_SPEECH_STRIP;   /* inline: retail stores the Speaker table, zeroes fSub, then stores the derived table */
        inline Speaker *Sub() NFS4_SPEECH_STRIP;   /* inline accessor: proven by DispatchSpeaker::Status' Engage(Perp()) evaluation order */
#include "speech_speaker_virtuals.inc"
        void SetCar(Car_tObj *car);
        void FindLocation(Car_tObj *car);
        int CalcMph(Car_tObj *perp);
        void Promote();




        inline void SetColour(int Colour) NFS4_SPEECH_STRIP;
        inline void SetBlockade(int Blockade) NFS4_SPEECH_STRIP;
        /* inline setters: retail's SYM shows one zero-length `this` pair per field reset (e.g. Purge's five at +1a0) */
        inline void SetArrest(int Arrest) NFS4_SPEECH_STRIP;
        inline void SetUpdate(int Update) NFS4_SPEECH_STRIP;
        inline void SetSub(Speaker *Sub) NFS4_SPEECH_STRIP;
        inline void SetTo(int to) NFS4_SPEECH_STRIP;
        inline int To() NFS4_SPEECH_STRIP;
        inline int From() NFS4_SPEECH_STRIP;
        inline void SetFrom(int from) NFS4_SPEECH_STRIP;
        inline void SetConfirm(int confirm) NFS4_SPEECH_STRIP;
        inline void SetPerpName(int name) NFS4_SPEECH_STRIP;
        inline void SetHavePerp(bool have) NFS4_SPEECH_STRIP;
        inline void SetReverse(int reverse) NFS4_SPEECH_STRIP;
        inline SPCHNFSType_REVINTRO *Reverse() NFS4_SPEECH_STRIP;
        inline void SetPosition(int position) NFS4_SPEECH_STRIP;
        inline void SetDistance(int distance) NFS4_SPEECH_STRIP;
        inline void SetLocation(LocationBank *location) NFS4_SPEECH_STRIP;
        inline SPCHNFSType_POSITION *Position() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_PERP_NAME *PerpName() NFS4_SPEECH_STRIP;
        inline void SetAmbulance(int ambulance) NFS4_SPEECH_STRIP;
        inline SPCHNFSType_AMBULANCE *Ambulance() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_ARREST *Arrest() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_SPIKE_BELT_SIDE *SpikeSide() NFS4_SPEECH_STRIP;
        inline void SetSpikeSide(int side) NFS4_SPEECH_STRIP;
        inline int BlockadeFlags() NFS4_SPEECH_STRIP;
        inline void SetWing(int wing) NFS4_SPEECH_STRIP;
        inline int Wing() NFS4_SPEECH_STRIP;
        inline int ArrestFlags() NFS4_SPEECH_STRIP;
        inline int UpdateFlags() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_PURS_UPDT *Update() NFS4_SPEECH_STRIP;
        inline bool HavePerp() NFS4_SPEECH_STRIP;
        inline int Car() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_vs_RDBLK_SSTRP *BlockadeSlot() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_CONFIRM *Confirm() NFS4_SPEECH_STRIP;



        inline int Location() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_DISTANCE *Distance() NFS4_SPEECH_STRIP;
        inline SPCHNFSType_COLOUR *Colour() NFS4_SPEECH_STRIP;






        /* The retail class declared these operations virtual.  The reconstructed layout keeps the recovered PsyQ vtable explicit, so these zero-local bridges preserve ordinary source-level virtual call sites without inventing receiver/vtable temporaries in their callers. */
    };
    struct MobileSpeaker; struct DispatchSpeaker;   /* declaration ORDER is retail evidence: tables are emitted Mobile, Dispatch, Speaker = reverse of Speaker, Dispatch, Mobile */

    /* MobileSpeaker / DispatchSpeaker are defined in SPEECH.CPP (speech_speakers.h): only speech.obj records them in retail */







































































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
    static inline int MultiplePerps() { return fgSpeech->fMultiplePerps; }
    /* car-bank lookup: retail's GetCarBank bodies are one inline-call pair with no variables (static inline;
       the index is a register argument, so no parameter row) */
    static inline CarBank *MobileCarBank(int carIndex) { return &fgSpeech->fCarBank.Mobile[carIndex]; }
    static inline CarBank *DispatchCarBank(int carIndex) { return &fgSpeech->fCarBank.Dispatch[carIndex]; }
    /* SubmitRequest: retail shows a variable-free inline pair where the dispatch status is reset, and a second
       one right after the bank offset is taken that emits no instructions; both names are inferred */



    static inline void Idle() {}
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
    inline bool IsHeader(char *ext, int period, int h, int hd) {   /* pointer form (CalculateBankSize): retail's pair records `this` and the four char locals, like ReadBE32 */
        int a = (u_char)ext[0];
        int b = (u_char)ext[1];
        int c = (u_char)ext[2];
        int d = (u_char)ext[3];
        return a == period && b == h && c == hd && d == 'r';
    }
    inline bool IsData(int a, int b, int c, int d, int period,
                       int dc, int ac) {
        return a == period && b == dc && c == ac && d == 't';
    }
    inline bool IsData(char *ext, int period, int dc, int ac) {
        int a = (u_char)ext[0];
        int b = (u_char)ext[1];
        int c = (u_char)ext[2];
        int d = (u_char)ext[3];
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
/* one definition for every includer (header-truth phase 2b) */




inline Speech::Speaker::Speaker() { fSub = 0; } inline Speech::Speaker *Speech::Speaker::Sub() { return fSub; } inline void Speech::Speaker::SetColour(int Colour) { fColour.flags = Colour; } inline void Speech::Speaker::SetBlockade(int Blockade) { fBlockade.flags = Blockade; } inline void Speech::Speaker::SetArrest(int Arrest) { fArrest.flags = Arrest; } inline void Speech::Speaker::SetUpdate(int Update) { fUpdate.flags = Update; } inline void Speech::Speaker::SetSub(Speaker *Sub) { fSub = Sub; } inline void Speech::Speaker::SetTo(int to) { fTo = to; } inline int Speech::Speaker::To() { return fTo; } inline int Speech::Speaker::From() { return fFrom; } inline void Speech::Speaker::SetFrom(int from) { fFrom = from; } inline void Speech::Speaker::SetConfirm(int confirm) { fConfirm.flags = confirm; } inline void Speech::Speaker::SetPerpName(int name) { fPerpName.flags = name; } inline void Speech::Speaker::SetHavePerp(bool have) { fHavePerp = have; } inline void Speech::Speaker::SetReverse(int reverse) { fReverse.flags = reverse; } inline SPCHNFSType_REVINTRO *Speech::Speaker::Reverse() { return &fReverse; } inline void Speech::Speaker::SetPosition(int position) { fPosition.flags = position; } inline void Speech::Speaker::SetDistance(int distance) { fDistance.flags = distance; } inline void Speech::Speaker::SetLocation(LocationBank *location) { fLocation = location->BankId(); } inline SPCHNFSType_POSITION *Speech::Speaker::Position() { return &fPosition; }   /* Speaker's inline members, defined out of the class so speech.obj can tag its standalone copies (NFS4_SPEECH_STRIP) */
inline SPCHNFSType_PERP_NAME *Speech::Speaker::PerpName() { return &fPerpName; } inline void Speech::Speaker::SetAmbulance(int ambulance) { fAmbulance.flags = ambulance; } inline SPCHNFSType_AMBULANCE *Speech::Speaker::Ambulance() { return &fAmbulance; } inline SPCHNFSType_ARREST *Speech::Speaker::Arrest() { return &fArrest; } inline SPCHNFSType_SPIKE_BELT_SIDE *Speech::Speaker::SpikeSide() { return &fSpikeSide; } inline void Speech::Speaker::SetSpikeSide(int side) { fSpikeSide.flags = side; } inline int Speech::Speaker::BlockadeFlags() { return fBlockade.flags; } inline void Speech::Speaker::SetWing(int wing) { fWing = wing; } inline int Speech::Speaker::Wing() { return fWing; } inline int Speech::Speaker::ArrestFlags() { return fArrest.flags; } inline int Speech::Speaker::UpdateFlags() { return fUpdate.flags; } inline SPCHNFSType_PURS_UPDT *Speech::Speaker::Update() { return &fUpdate; } inline bool Speech::Speaker::HavePerp() { return fHavePerp; } inline int Speech::Speaker::Car() { return fCar; } inline SPCHNFSType_vs_RDBLK_SSTRP *Speech::Speaker::BlockadeSlot() { return &fBlockade; } inline SPCHNFSType_CONFIRM *Speech::Speaker::Confirm() { return &fConfirm; } inline int Speech::Speaker::Location() { return fLocation; } inline SPCHNFSType_DISTANCE *Speech::Speaker::Distance() { return &fDistance; } inline SPCHNFSType_COLOUR *Speech::Speaker::Colour() { return &fColour; }



/* the speech object's creation (NFS3.CPP): a header inline -- retail records its variable-free scopes at the
   caller's line in Nfs2_GameModuleStartUp (a same-.cpp inline clamps them to line 1) */
static inline void Speech_Create(void)
{
  if (Speech::fgSpeech == 0) Speech::fgSpeech = new Speech;
}
/* the shared undefined speaker (NFS3.CPP Nfs2_SystemNLibStartUp): retail's two extra variable-free scopes opened
   at the function start around this creation are this header inline's (name inferred) */
static inline void Speech_CreateUndefined(void)
{
  if (Speech::fgUndefined == 0) Speech::fgUndefined = ({ new Speech::Speaker; });
}


#endif
