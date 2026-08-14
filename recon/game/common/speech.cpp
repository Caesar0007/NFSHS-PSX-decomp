/* game/common/speech.cpp -- RECONSTRUCTED (NFS4 PSX cop speech/dispatch engine; C++ TU)
 *   101 fns across 7 classes (Speech + Speaker/MobileSpeaker/DispatchSpeaker hierarchy +
 *   CarBank/CarBankName/LocationBank helpers) + 4 free C entry points (Speech_AllocateRAM__FlPc/
 *   PurgeRAM/HandleRequest/Server). Methods emitted free-fn-with-explicit-this `Class_method`
 *   (structs carry no member-fn protos). Virtual dispatch via _vf[31]. GTE-free.
 */
#include "../../nfs4_types.h"
#include "speech_externs.h"

/* ---- speech.obj OWNED globals (EXT; SYM Globals.jsonl tu=Speech.obj, @0x80111a44+) ----
 * Byte-exact from image 2026-07-12 (were bare zero-init defs — real .data: car speech-bank
 * names + per-track location records + dispatch/mobile callsigns). String pointers restored
 * as literals (gcc pooling reproduces the shared-address layout). */
Speech_tCarDescription      Speech_gCarDescription[15] = {   /* @0x80111a44 */
    { "BMWZ", "bmwz3.", "bmw.", "z3." },
    { "HSVT", "sedan.", "sedan.", "sedan." },
    { "FORD", "sedan.", "sedan.", "sedan." },
    { "CMRO", "chvcam.", "chevro.", "cam." },
    { "TRAM", "pont.", "pont.", "pont." },
    { "ADB7", "aston.", "aston.", "aston." },
    { "JXKR", "jag.", "jag.", "jag." },
    { "BMWM", "bmwm5.", "bmw.", "m5." },
    { "CORV", "chvcor.", "chevro.", "corv." },
    { "P993", "por911.", "porsc.", "porsc." },
    { "DIAB", "lamdia.", "lamb.", "dia." },
    { "MCF1", "mclar.", "mclar.", "mclar." },
    { "X993", "por911.", "porsc.", "porsc." },
    { "XCF1", "chvcor.", "chevro.", "corv." },
    { 0, "sport.", "sport.", "sport." }
};
Speech_tLocationDescription Speech_gLocationDescription00[13] = {   /* @0x80111b34 */
    { "cab.", 45, 56 }, { "cab.", 70, 76 }, { "baov.", 188, 191 }, { "tun.", 250, 260 },
    { "scrv.", 304, 340 }, { "twr.", 480, 483 }, { "brg.", 588, 600 }, { "frm.", 660, 666 },
    { "tun.", 690, 699 }, { "pike.", 794, 847 }, { "ltun.", 855, 910 }, { "icec.", 911, 950 },
    { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription02[14] = {   /* @0x80111b9c */
    { "mar.", 1061, 20 }, { "bay.", 110, 130 }, { "rarc.", 185, 188 }, { "scrv.", 236, 260 },
    { "lth.", 305, 318 }, { "ruin.", 456, 470 }, { "spfl.", 616, 618 }, { "brg.", 632, 638 },
    { "tbrg.", 639, 656 }, { "brg.", 657, 662 }, { "ltun.", 806, 839 }, { "tun.", 959, 975 },
    { "bgdr.", 990, 1025 }, { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription03[13] = {   /* @0x80111c0c */
    { "over.", 57, 59 }, { "over.", 96, 99 }, { "over.", 139, 142 }, { "tun.", 156, 165 },
    { "fld.", 222, 260 }, { "brg.", 264, 274 }, { "stun.", 365, 416 }, { "htou.", 545, 551 },
    { "rarc.", 661, 662 }, { "ruin.", 679, 705 }, { "tun.", 869, 877 }, { "ogt.", 914, 929 },
    { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription04[9] = {   /* @0x80111c74 */
    { "trnx.", 1, 2 }, { "lsp.", 94, 96 }, { "cab.", 162, 163 }, { "hsv.", 170, 300 },
    { "pent.", 305, 309 }, { "tun.", 465, 474 }, { "brg.", 575, 593 }, { "ltun.", 693, 709 },
    { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription05[14] = {   /* @0x80111cbc */
    { "ogt.", 4, 8 }, { "wfrm.", 35, 109 }, { "tun.", 240, 250 }, { "ruin.", 251, 325 },
    { "tun.", 326, 338 }, { "fld.", 366, 452 }, { "owel.", 569, 572 }, { "over.", 681, 682 },
    { "toll.", 711, 713 }, { "toll.", 741, 743 }, { "obwm.", 875, 889 }, { "vill.", 890, 925 },
    { "over.", 1066, 1069 }, { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription06[11] = {   /* @0x80111d2c */
    { "fld.", 17, 45 }, { "omus.", 118, 120 }, { "kngm.", 265, 275 }, { "vill.", 330, 398 },
    { "scrv.", 570, 627 }, { "stun.", 637, 657 }, { "hpin.", 705, 742 }, { "over.", 760, 765 },
    { "arch.", 818, 821 }, { "ltun.", 940, 1017 }, { 0, 0, 0 }
};
Speech_tLocationDescription Speech_gLocationDescription07[11] = {   /* @0x80111d84 */
    { "scrv.", 32, 74 }, { "over.", 116, 158 }, { "ltun.", 249, 301 }, { "over.", 330, 334 },
    { "medi.", 348, 426 }, { "frm.", 515, 536 }, { "farm.", 537, 538 }, { "frm.", 540, 577 },
    { "vill.", 627, 720 }, { "tun.", 767, 785 }, { 0, 0, 0 }
};
Speech_tLocationDescription *Speech_gLocationDescription[11] = {   /* @0x80111ddc */
    Speech_gLocationDescription00, Speech_gLocationDescription02, Speech_gLocationDescription02,
    Speech_gLocationDescription03, Speech_gLocationDescription04, Speech_gLocationDescription05,
    Speech_gLocationDescription06, Speech_gLocationDescription07, Speech_gLocationDescription02,
    Speech_gLocationDescription02, Speech_gLocationDescription02
};
Speech_tCallSignDescription Speech_gCallSignDescription[1] = {{   /* @0x80111e08 */
    "all.",
    { "dis.", "cen.", "cont.", "hq.", "cou." },
    { "20.", "25.", "31.", "37.", "38.", "43.", "45.", "46.", "52.", "217.", "223.", "316.", "332.", "355.", "371." }
}};
Speech_tMobileVoiceAttr     Speech_gCopAttr[9] = {   /* @0x80111e5c : {voice, pitch} */
    { 1, 0 }, { 2, 0 }, { 4, 0 }, { 1, 5 }, { 2, 5 }, { 4, 5 }, { 1, -5 }, { 2, -5 }, { 4, -5 }
};
/* Speech::fgSpeech static-member singleton (active engine instance; $gp+0x838=0x8013cd84) */
Speech            *Speech_fgSpeech;
/* Speech::fgUndefined static-member (cfront fn-local static _6Speech.fgUndefined; SYM-confirmed
   scalar Speaker* @0x8013cd88 -- oracle sdata dump (asm/data/sdata_8013C54C.sdata.s) shows it as
   ONE `.word 0x00000000`, NOT an array; 3 speech fns (Dispatch/FindMobile/Mobile) reach it via
   %gp_rel, which only applies to a true <=4B scalar (methodology 3.12 #6). nfs3.cpp's non-owner
   extern (_6Speech_fgUndefined) confirms the ownership + gp-rel-only-for-owner split. The 752
   bytes previously bundled into this symbol as a fake "array" are really a SEPARATE run of
   discrete per-string rodata dlabels the linker placed contiguously after it (D_8013CD8C.. =
   "BMWZ"/"bmwz3."/... car-abbreviation strings, ending in the 4 strings CheckMultiBank__6Speech...
   strncmp's against: "j:id\", "j:cars\", "j:cid\", "j:clip."). Preserved verbatim below as an
   opaque byte blob (Speech_gBankNameStrings) so any other absolute-VA pointer into this region
   keeps byte-exact content; CheckMultiBank's 4 named comparisons now use the literal strings
   directly (matches the oracle's per-dlabel D_8013D04C.."j:id\" family, confirmed via disasm). */
Speaker *Speech_fgUndefined;
static const unsigned char Speech_gBankNameStrings[752] = {
    0x42,0x4d,0x57,0x5a,0x00,0x00,0x00,0x00,
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

static inline int Speech_ReadBE32(char *p)
{
  int a = (u_char)p[0];
  int b = (u_char)p[1];
  int c = (u_char)p[2];
  int d = (u_char)p[3];

  return (((a << 8 | b) << 8 | c) << 8 | d);
}

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
int CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(Speech *pThis,char *header,CarBankName *bn,long *hoffset,long *hsize);
void LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(Speech *pThis,char *header,CarBankName *bn,long hoffset,long hsize);
void Reset__6Speech(void);
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
int GetVoice__6SpeechP8Car_tObj(Car_tObj *carObj);
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
  char *game;
  Speech_tCarDescription *d;

  game = GameSetup_gCarNames[GameSetup_gData.carInfo[carIndex].carType];
  d = Speech_gCarDescription;
  while ((d->game != (char *)0x0 &&
         strncmp(game,d->game,4) != 0)) {
    d = d + 1;
  }
  *param_1 = d->full;
  param_1[1] = d->make;
  param_1[2] = d->model;
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
  int carbankWalk;
  int banknameWalk;

  iVar2 = 0;
  uVar3 = 0;
  if (0 < *(int *)(param_1 + 0x37c)) {
    banknameWalk = bankname;
    carbankWalk = carbank;
    do {
      iVar1 = Check__Q26Speech7CarBankPciPQ26Speech11CarBankName(carbankWalk,name,id,banknameWalk);
      if (iVar1 != 0) {
        uVar3 = 1;
      }
      banknameWalk = banknameWalk + 0xc;
      carbankWalk = carbankWalk + 0xc;
      iVar2 = iVar2 + 1;
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
    {
      int *dispatchThis = (int *)Dispatch__6Speech();
      iVar2 = (**(int (**)(...))(*(int *)((int)dispatchThis + 0x4c) + 0x94))
                        ((int)dispatchThis + *(short *)(*(int *)((int)dispatchThis + 0x4c) + 0x90),car);
    }
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
        /* MATCH: store the halfwords DIRECTLY -- the `short sVar1/sVar2` temps
           made gcc keep them in HImode pseudos and widen with `lhu; sll 16; sra
           16` (oracle: a single `lh`); and `locationbank[0]` (not `*locationbank`)
           keeps ONE induction pointer instead of a 2nd strength-reduced giv. */
        /* MATCH: grouped int temps -> oracle's 3 batched loads then 4 stores
           (`lh v0; lh v1; lw a0; li s4,1; sw...`); interleaved load/store pairs
           each eat a load-delay nop. [catalog load-3/store-3] */
        int t0 = psVar7[-1];
        int t1 = *psVar7;
        int t2 = (int)pSVar6->name;
        /* W57-A8 3.12#1 INDEX FORM: the SYM says `locationbank` is a REGPARM that
           STAYS in $a1 (never mutated) -- retail indexes it and lets gcc strength-
           reduce to ONE giv ($s0, stride 16, field offsets 0/4/8/12). The old
           `locationbank = locationbank + 4` walk produced TWO givs (a base-at-+12
           walker with negative displacements PLUS a second one at +0), costing an
           extra insn and a whole extra saved reg ($fp). 42 -> 2 diffs. */
        uVar9 = 1;
        locationbank[iVar8 * 4 + 2] = id;
        locationbank[iVar8 * 4] = t0;
        locationbank[iVar8 * 4 + 1] = t1;
        locationbank[iVar8 * 4 + 3] = t2;
      }
      psVar7 = psVar7 + 4;
      pSVar6 = pSVar6 + 1;
    }
  }
  return uVar9;
}

/* ---- Distance__Q26Speech12LocationBanki  [SPEECH.CPP:567-587] SLD-VERIFIED ---- */
int Distance__Q26Speech12LocationBanki(LocationBank *pThis,int slice)

{
  int start;
  int end;
  int forward;
  int backward;

  start = pThis->fStartSlice;
  end = pThis->fEndSlice;
  if (end < start) {
    if (slice >= start) {
      goto Distance_wrappedZero;
    }
    forward = slice - end;
    if (slice <= end) {
      goto Distance_wrappedZero;
    }
Distance_backward:
    backward = start - slice;
Distance_min:
    if (backward < forward) {
      forward = backward;
    }
    return forward;
Distance_wrappedZero:
    return 0;
  }

  if (slice < start) {
    forward = (slice + gNumSlices) - end;
    goto Distance_backward;
  }
  if (slice > end) {
    backward = slice - end;
    forward = (start + gNumSlices) - slice;
    goto Distance_min;
  }
  return 0;
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
  
  if (pThis->fLocationCount != 0) {
    pLVar4 = (LocationBank *)0x0;
    iVar3 = 10000;
    iVar2 = 0;
    while (1) {
      if (pThis->fLocationCount <= iVar2) break;
      this_00 = bank + iVar2;
      if ((this_00->fBankId != -1) && (iVar1 = Distance__Q26Speech12LocationBanki(this_00,slice), iVar1 < iVar3)
         ) {
        iVar3 = iVar1;
        pLVar4 = this_00;
      }
      iVar2 = iVar2 + 1;
    }
    return pLVar4;
  }
  return (LocationBank *)0x0;
}

/* ---- FindLocation__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:624-788] SLD-VERIFIED ---- */
void FindLocation__Q26Speech7SpeakerP8Car_tObj(Speaker *pThis,Car_tObj *car)

{
  int slice;
  LocationBank *location;

  if (fixedmult(car->currentSpeed,0x50000) / 0x60000 >= 0) {
    int advance = fixedmult(car->currentSpeed,0x50000) / 0x60000;
    if ((int)car->N.simRoadInfo.slice + advance < gNumSlices) {
      slice = fixedmult(car->currentSpeed,0x50000) / 0x60000 + (int)car->N.simRoadInfo.slice;
    }
    else {
      int offset = fixedmult(car->currentSpeed,0x50000) / 0x60000;
      slice = (int)car->N.simRoadInfo.slice + offset - gNumSlices;
    }
  }
  else {
    int advance = fixedmult(car->currentSpeed,0x50000) / 0x60000;
    if ((int)car->N.simRoadInfo.slice + advance < 0) {
      int offset = fixedmult(car->currentSpeed,0x50000) / 0x60000;
      slice = (int)car->N.simRoadInfo.slice + offset + gNumSlices;
    }
    else {
      int offset = fixedmult(car->currentSpeed,0x50000) / 0x60000;
      slice = (int)car->N.simRoadInfo.slice + offset;
    }
  }

  location = (LocationBank *)
            (*(*pThis->_vf)[0x1d].pfn)
                      ((int)&(pThis->fPosition).flags + (int)(*pThis->_vf)[0x1d].delta,slice);
  if (location == (LocationBank *)0x0) {
    (pThis->fDistance).flags = 0;
    (pThis->fPosition).flags = 0;
    /* Retail preserves the null LocationBank::fBankId read at address 8.  A
       one-word aggregate copy prevents C++ null-dereference folding. */
    struct SpeechLocationWord { int value; };
    *(SpeechLocationWord *)&pThis->fLocation = *(SpeechLocationWord *)8;
  }
  else {
    int actual = Distance__Q26Speech12LocationBanki(location,(int)car->N.simRoadInfo.slice);
    int distance = Distance__Q26Speech12LocationBanki(location,slice);

    if (distance == 0) {
      (pThis->fDistance).flags = 0;
      (pThis->fPosition).flags = 4;
    }
    else if ((double)distance < 100.0 / 3.0) {
      (pThis->fDistance).flags = 0;
      if (distance + 2 < actual) {
        (pThis->fPosition).flags = 9;
      }
      if (distance - 2 < actual) {
        (pThis->fPosition).flags = 8;
      }
      else {
        (pThis->fPosition).flags = 2;
      }
    }
    else if (GameSetup_gData.measurement == 1) {
      if (distance < 0xa6) {
        (pThis->fDistance).flags = 8;
        if (distance - 2 < actual) {
          (pThis->fPosition).flags = 0x10;
        }
        else {
          (pThis->fPosition).flags = 2;
        }
      }
      else {
        (pThis->fDistance).flags = 0x10;
        if (distance - 2 < actual) {
          (pThis->fPosition).flags = 0x10;
        }
        else {
          (pThis->fPosition).flags = 2;
        }
      }
    }
    else if (distance < 0x86) {
      (pThis->fDistance).flags = 1;
      if (distance - 2 < actual) {
        (pThis->fPosition).flags = 0x10;
      }
      else {
        (pThis->fPosition).flags = 2;
      }
    }
    else if (distance < 0x10c) {
      (pThis->fDistance).flags = 2;
      if (distance - 2 < actual) {
        (pThis->fPosition).flags = 0x10;
      }
      else {
        (pThis->fPosition).flags = 2;
      }
    }
    else {
      (pThis->fDistance).flags = 4;
      if (distance - 2 < actual) {
        (pThis->fPosition).flags = 0x10;
      }
      else {
        (pThis->fPosition).flags = 2;
      }
    }
    pThis->fLocation = location->fBankId;
  }
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
  /* MATCH: retail sets the match flag INSIDE each branch (`li s3,1` per arm),
     it does NOT build a combined `a==0 || b==0` boolean -- the combined form
     keeps both strncmp results live to the join and rotates the whole s-map.
     80 -> 35 diffs. */
  bVar5 = false;
  iVar2 = strncmp(name,Speech_gCallSignDescription[0].AllUnits,lVar1);
  if (iVar2 == 0) {
    *bank = id;
    bVar5 = true;
  }
  iVar3 = GameSetup_gData.track % 5;
  lVar1 = strlen((u_long)Speech_gCallSignDescription[0].Dispatch[iVar3]);
  iVar3 = strncmp(name,Speech_gCallSignDescription[0].Dispatch[iVar3],lVar1);
  if (iVar3 == 0) {
    bank[1] = id;
    bVar5 = true;
  }
  /* MATCH: `i` is born in the for-init, not before the 2nd guard (oracle sets it
     in the `bnez` delay slot AFTER the guard).  35 -> 34, count now exact. */
  iVar4 = 0;
  while (true) {
    if (0xf <= iVar4) break;
    /* W57-A8 3.12#1 + 07C: BOTH walks are index forms in retail (`bank[i+2]` and
       `Speech_gCallSignDescription[0].Mobile[i]` -> one giv each), and the loop is
       UN-ROTATED (`while(true){ if(N<=i) break; ... }`) -- a `for` lets gcc prove
       entry and rotate the test to the bottom. 34 -> PASS. */
    lVar1 = strlen((u_long)Speech_gCallSignDescription[0].Mobile[iVar4]);
    iVar2 = strncmp(name,Speech_gCallSignDescription[0].Mobile[iVar4],lVar1);
    if (iVar2 == 0) {
      bank[iVar4 + 2] = id;
      bVar5 = true;
    }
    iVar4 = iVar4 + 1;
  }
  return bVar5;
}

/* ---- CheckMultiBank__6SpeechPciPQ26Speech11CarBankName  [SPEECH.CPP:889-924] SLD-VERIFIED ---- */
u_int CheckMultiBank__6SpeechPciPQ26Speech11CarBankName(int param_1,char *name,u_int id,u_int bn)

{
  if (strncmp(name,"j:id\\",5) == 0) {
    return CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(
        param_1,param_1 + 0x31c,name + 5,id);
  }
  if (strncmp(name,"j:cars\\",7) == 0) {
    return CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName(
        param_1,param_1 + 0x6c,name + 7,id,bn);
  }
  if (strncmp(name,"j:location\\",0xb) == 0) {
    return CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(
        param_1,param_1 + 0x1d8,name + 0xb,id);
  }
  if (strncmp(name,"j:cid\\",6) == 0) {
    return CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci(
        param_1,param_1 + 0x2d8,name + 6,id);
  }
  if (strncmp(name,"j:ccars\\",8) == 0) {
    return CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName(
        param_1,param_1,name + 8,id,bn);
  }
  if (strncmp(name,"j:clocaton\\",0xb) == 0) {
    return CheckLocationBank__6SpeechPQ26Speech12LocationBankPci(
        param_1,param_1 + 0xd8,name + 0xb,id);
  }
  if (strncmp(name,"j:clip.",7) == 0) {
    *(u_int *)(param_1 + 0x374) = id;
  }
  else {
    if (strncmp(name,"j:silenc.",9) != 0) {
      return 1;
    }
    *(u_int *)(param_1 + 0x378) = id;
  }
  return 1;
}

/* ---- CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3  [SPEECH.CPP:931-984] SLD-VERIFIED ---- */
int CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(Speech *pThis,char *header,CarBankName *bn,long *hoffset,long *hsize)

{
  int bcount;
  int bsize;
  long offset;
  long size;

  bcount = 0;
  bsize = 0;
  if (locatebigentry(header,"j:eventdat\\event.dat",0,&offset,(int)&size) != 0) {
    int filecount;
    char *c;
    int i;
    int period;

    c = header + 0x10;
    bsize = size;
    filecount = Speech_ReadBE32(header + 8);
    i = 0;
    period = '.';
    while (i < filecount) {
      char *name;
      bool extension;

      offset = Speech_ReadBE32(c);
      size = Speech_ReadBE32(c + 4);
      name = c + 8;
      c = name;
      while (*c != '\0') {
        c++;
      }
      extension = false;
      {
        int h = 'h';
        int hd = 'd';
        int a = (u_char)c[-4];
        int b = (u_char)c[-3];
        int cc = (u_char)c[-2];
        int d = (u_char)c[-1];

        if (((a == period) && (b == h)) && (cc == hd)) {
          extension = d == 'r';
        }
      }
      if (extension) {
        if (*hoffset == 0) {
          *hoffset = offset;
        }
        *hsize = offset + size - *hoffset;
        if (CheckMultiBank__6SpeechPciPQ26Speech11CarBankName((int)pThis,name,bcount,(u_int)bn)) {
          bcount++;
          bsize += size;
        }
      }
      c++;
      i++;
    }
  }
  pThis->fBankCount = bcount;
  return bsize;
}

/* ---- LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell  [SPEECH.CPP:990-1102] SLD-VERIFIED ---- */
/* MATCHING-RECEIPT (2026-08-14): detailed verify_asm 137 -> 133 -> 119 -> 97
 * -> 62 -> 51 -> 31 -> 13 -> 11 -> 9 -> 6, with the final source stream count-
 * and register-exact at 270/270.  IDA's gold allocation and the SLD expose a
 * compiler-created lagging cursor in $s2: retain source `p`, but read the first
 * offset byte from `c` before advancing it.  Named extension constants reproduce
 * both retail comparison webs; the first result needs the priced +2-ref empty
 * fence (allocsim p163 6->8 refs) to land in $v1.  In the fallback, a named
 * `joffset` kept across strncmp is the real $s3 quantity, integer-address addition
 * preserves `addu v0,s3,v0`, and `++j` belongs in the loop condition.
 *
 * The remaining 6 are one pure reorg rotation.  A scratch PER_FN_TEXT_MOVES probe
 * PASSes 270/270: move the first `li $6,16` after `move $5,$19`, move
 * `lbu $2,8($16)` after `lw $3,28($sp)`, then move `addu $16,$16,8` after that
 * lbu.  tools/build.py is orchestrator-owned, so the live tree deliberately keeps
 * the verified source-only 6-diff result.  Failed/reverted basins: removing `p`
 * without the real joffset rotated every saved register (156-299 diffs); an
 * identity fence on the alignment constant perturbed global allocation (84). */
void LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(Speech *pThis,char *header,CarBankName *bn,long hoffset,long hsize)

{
  char *data;
  long offset;
  long size;
  int id;
  int dt;
  int filecount;
  char *c;
  char *hdata;
  char **banknames;
  char *p;

  id = 0;
  dt = 0;
  data = (char *)pThis->fBankOffset + pThis->fBankCount * 4;
  locatebigentry(header,"j:eventdat\\event.dat",0,&offset,(int)&size);
  FILE_readsync(pThis->fFileHandle,offset,data,size,100);
  SPCH_ResolveData(data);
  c = header + 0x10;
  data += size;
  {
    int a = (u_char)header[8];
    header += 8;
    int b = (u_char)header[1];
    int cc = (u_char)header[2];
    int d = (u_char)header[3];

    filecount = (((a << 8 | b) << 8 | cc) << 8 | d);
  }
  hdata = (char *)reservememadr("spch temp",hsize,0x10);
  FILE_readsync(pThis->fFileHandle,hoffset,hdata,hsize,100);
  banknames = (char **)reservememadr("spch temp",pThis->fBankCount << 2,0x10);
  {
    int j;

    for (j = 0; j < pThis->fBankCount; j++) {
        banknames[j] = 0;
        pThis->fBankOffset[j] = 0;
      }
  }
  {
    int i;

    p = c;
    for (i = 0; i < filecount; i++) {
    char *name;
    int namelen;
    bool isheader;
    int firstbyte;

    systemtask(0);
    firstbyte = (u_char)*c;
    c += 8;
    name = c;
    namelen = 0;
    {
      {
        int b = (u_char)p[1];
        int cc = (u_char)p[2];
        int d = (u_char)p[3];

        offset = (((firstbyte << 8 | b) << 8 | cc) << 8 | d);
      }
      {
        int a = (u_char)p[4];
        int b = (u_char)p[5];
        int cc = (u_char)p[6];
        int d = (u_char)p[7];

        size = (((a << 8 | b) << 8 | cc) << 8 | d);
      }
    }
    p += 8;
    while (*c != '\0') {
      namelen++;
      c++;
      p++;
    }
    isheader = false;
    if (namelen >= 5) {
      bool extension = false;
      {
        int h = 'h';
        int hd = 'd';
        int period = '.';
        int a = (u_char)p[-4];
        int b = (u_char)p[-3];
        int cc = (u_char)p[-2];
        int d = (u_char)p[-1];

        if (((a == period) && (b == h)) && (cc == hd)) {
          extension = d == 'r';
        }
      }
      __asm__("" : : "r"(extension), "r"(extension));
      if (extension && CheckMultiBank__6SpeechPciPQ26Speech11CarBankName((int)pThis,name,id,(u_int)bn)) {
        isheader = true;
      }
      if (isheader) {
        id++;
        memcpy(data,hdata + offset - hoffset,size);
        banknames[SPCH_AddBank(data)] = name;
        data += size;
      }
      else {
        bool extension = false;
        {
          int dc = 'd';
          int ac = 'a';
          int period = '.';
          int a = (u_char)p[-4];
          int b = (u_char)p[-3];
          int cc = (u_char)p[-2];
          int d = (u_char)p[-1];

          if (((a == period) && (b == dc)) && (cc == ac)) {
            extension = d == 't';
          }
        }
        if (extension) {
          if ((dt < pThis->fBankCount) && (banknames[dt] != 0) &&
              (strncmp(name,banknames[dt],namelen - 3) == 0)) {
            pThis->fBankOffset[dt++] = offset;
          }
          else {
            int j = 0;

            if (0 < pThis->fBankCount) {
              char **namep = banknames;
              int joffset;

              do {
                joffset = j << 2;
                if ((*namep != 0) && (strncmp(name,*namep,namelen - 3) == 0)) {
                  *(long *)(joffset + (int)pThis->fBankOffset) = offset;
                  dt = j + 1;
                }
                namep++;
              } while (++j < pThis->fBankCount);
            }
          }
        }
      }
    }
    p++;
    c++;
    }
  }
  purgememadr(hdata);
  purgememadr(banknames);
}

} /* extern "C" */

/* ---- __6Speech  [SPEECH.CPP:1110-1228] SLD-VERIFIED ---- */
Speech::Speech()
{
  int numracers;
  int numhumancops;
  CarBankName bn[9];
  int banksize;
  char *SpeechLanguage;
  char filename[100];
  char *header;
  long hoffset;
  long hsize;

  DispatchSpeaker *dispatch = (DispatchSpeaker *)__builtin_new(sizeof(DispatchSpeaker));
  dispatch->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])Speaker_vtable;
  dispatch->_base_Speaker.fSub = 0;
  dispatch->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])DispatchSpeaker_vtable;
  fDispatch = dispatch;

  for (int i = 0; i < 4; i++) {
    MobileSpeaker *mobile = (MobileSpeaker *)__builtin_new(sizeof(MobileSpeaker));
    mobile->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])Speaker_vtable;
    mobile->_base_Speaker.fSub = 0;
    mobile->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])MobileSpeaker_vtable;
    mobile->fCarObj = 0;
    fMobile[i] = mobile;
  }

  fFileOpen = 0;
  fBankOffset = 0;
  numracers = 0;
  numhumancops = 0;
  for (int i = 0; i < GameSetup_gData.numCars; i++) {
    if (GameSetup_gData.carInfo[i].carClass == 1)
      numracers++;
    else if (GameSetup_gData.carInfo[i].carClass == 2)
      numracers++;
    else if (GameSetup_gData.carInfo[i].carClass == 0x41)
      numhumancops++;
  }
  if (numhumancops == 0 && numracers > 1)
    fMultiplePerps = 1;
  else
    fMultiplePerps = 0;

  gettick();
  fCarCount = GameSetup_gData.numCars;
  for (int i = 0; i < fCarCount; i++)
    SetCar__Q26Speech11CarBankNamei((u_int *)&bn[i], i);

  CountLocations__6Speech(this);
  fBankCount = 0;
  banksize = 0;
  switch (GameSetup_gData.languageSpeech) {
  case 2:
    SpeechLanguage = gSpeechLangSuffix[0];
    break;
  case 1:
    SpeechLanguage = gSpeechLangSuffix[1];
    break;
  case 6:
    SpeechLanguage = gSpeechLangSuffix[2];
    break;
  default:
    SpeechLanguage = gSpeechLangSuffix[3];
    break;
  }

  sprintf(filename, "%szzzz%s.viv", Paths_Paths[0x1d], SpeechLanguage);
  header = (char *)loadbigfileheader(filename, (void *)0x10);
  hoffset = 0;
  hsize = 0;
  if (header)
    banksize = CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3(
        this, header, bn, &hoffset, &hsize);
  if (banksize > 0)
    fBankOffset = (long *)reservememadr("spch index", fBankCount * 4 + banksize, 0);
  if (fBankOffset) {
    long rate = SPCH_GetSampleDataRate(0x2b11, 0x10, 2);
    SPCH_Init(Speech_HandleRequest__Fllll, 0x12345678, rate);
    SPCH_InitBankMem(Speech_AllocateRAM__FlPc, Speech_PurgeRAM__FPc, fBankCount);
    fFileOpen = FILE_opensync(filename, 1, 100, (int)&fFileHandle) != 0;
    LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell(this, header, bn, hoffset, hsize);
  }
  if (header)
    purgememadr(header);
  gettick();
}

extern "C" {

/* ---- Reset__6Speech  [SPEECH.CPP:1248-1261] SLD-VERIFIED ---- */
void Reset__6Speech(void)

{
  int iVar5;
  int iVar6;
  
  if (((int)Speech_fgSpeech) != 0) {
    iVar6 = 0;
    iVar5 = ((int)Speech_fgSpeech);
    while (true) {
      if (iVar6 >= 4) {
        break;
      }
      iVar6 = iVar6 + 1;
      *(u_int *)(*(int *)(iVar5 + 0x390) + 0x60) = 0;
      iVar5 = iVar5 + 4;
    }
    SPCH_ClearEventQueue();
    randtemp = fastRandom * randSeed;
    fastRandom = randtemp & 0xffff;
    iSPCH_EACseedrandom((randtemp & 0xffff00) >> 8);
    Speech *speech = Speech_fgSpeech;
    DispatchSpeaker *dispatch = speech->fDispatch;
    speech->fCopCount =
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 9;
    speech->fSuperCount =
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 6;
    Activate__Q26Speech15DispatchSpeakeri((int)dispatch,
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 7);
  }
  return;
}

} /* extern "C" */

/* ---- _._6Speech  [SPEECH.CPP:1267-1283] SLD-VERIFIED ---- */
Speech::~Speech()
{
  if (fBankOffset != 0) {
    SPCH_Deinit();
    purgememadr(fBankOffset);
  }
  if (fFileOpen != 0)
    FILE_closesync(fFileHandle, 100);
  delete fDispatch;
  for (int i = 0; i < 4; i++)
    delete fMobile[i];
}

extern "C" {

/* ---- BankPatch__6SpeechlP8Car_tObj  [SPEECH.CPP:1297-1307] SLD-VERIFIED ---- */
u_int BankPatch__6SpeechlP8Car_tObj(int param_1,int bank,int car)

{
  if (bank == *(int *)(param_1 + 0x378)) {
    return 0x15;
  }
  if (bank == *(int *)(param_1 + 0x374)) {
    if (car == 0) {
      return 0x13;
    }
    return 0x14;
  }
  return 0xffffffff;
}

/* ---- SubmitRequest__6Speechlll  [SPEECH.CPP:1317-1342] SLD-VERIFIED ---- */
int SubmitRequest__6Speechlll(int bank,int localoffset,u_int size)

{
  Car_tObj *car;
  int patch;
  long offset;

  if (Speech_fgSpeech != 0) {
    Speech_fgSpeech->fDispatch->fStatusSub = 0;
    Speech_fgSpeech->fDispatch->fStatusCount = 0x200;
    car = Speech_fgSpeech->fSpeakerCar;
    patch = BankPatch__6SpeechlP8Car_tObj((int)Speech_fgSpeech,bank,(int)car);
    {
      Speech *pThis = Speech_fgSpeech;
      /* MATCHED 100% (61/61).  The SLD's nested `bank` local is a distinct
         conditional destination: reading bankStart in the condition makes gcc
         expand the COND_EXPR through the retail $v0 temporary.  The pin-free,
         zero-insn read/write fence must follow the assignment; there it prevents
         cse from merging bankStart back into the parameter while leaving the
         BankPatch result copy available for the preceding branch delay slot. */
      long bankStart = bank;
      bankStart = (bankStart >= 0 && bankStart < pThis->fBankCount) ? pThis->fBankOffset[bankStart] : 0;
      __asm__("" : "=r"(bankStart) : "0"(bankStart));
      offset = bankStart;
    }
    if (patch >= 0) {
      CopSpeak_GenericBankRequest(patch,car);
      return offset + localoffset;
    }
    else {
      if (offset != 0) {
        Speech *pThis = Speech_fgSpeech;
        int requestFile = pThis->fFileHandle;
        Car_tObj *requestCar = car;
        CopSpeak_DirectRequest(requestFile,offset + localoffset,size,requestCar,0);
      }
      return offset + localoffset;
    }
  }
  return 0;
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
  Speaker *Super;
  Speaker *Sub;
  int cont;
  int iVar2;

  Super = (Speaker *)Dispatch__6Speech();
  for (;;) {
    Sub = Super->fSub;
    cont = Sub != (Speaker *)0x0 && Sub != pThis;
    if (!cont) break;
    Super = Sub;
  }
  Super->fSub = pThis->fSub;
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
  if ((int)Speech_fgSpeech != 0) {
    if (*(int *)(((int)Speech_fgSpeech) + 0x36c) != 0) {
      goto Dispatch_useValue;
    }
  }
  return (int)Speech_fgUndefined;
Dispatch_useValue:
  return *(int *)(((int)Speech_fgSpeech) + 0x3a0);
}

/* ---- Roger__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1592-1629] SLD-VERIFIED ---- */
void Roger__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  bool bVar1;
  int iVar2;
  Car_tObj *pCVar5;
  SPCHNFSType_CONFIRM *pSVar7;
  SPCHNFSType_CONFIRM *reg_a1;
  SPCHNFSType_PERP_NAME *reg_a2;
  SPCHNFSType_CONFIRM *reg_a3;
  
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  bVar1 = false;
  if ((((pThis->_base_Speaker).fSub == (Speaker *)0x0) ||
      (iVar2 = (*(*(pThis->_base_Speaker).fSub->_vf)[0x1b].pfn)
                         ((int)&((pThis->_base_Speaker).fSub->fPosition).flags +
                          (int)(*(pThis->_base_Speaker).fSub->_vf)[0x1b].delta),
      iVar2 == 0)) || ((((pThis->_base_Speaker).fSub)->fBlockade).flags != 0)) {
    bVar1 = true;
  }
  if (bVar1) {
    pSVar7 = &(pThis->_base_Speaker).fConfirm;
    SPCHNFS_D_A_CONFIRM(pSVar7);
  }
  else {
    Speaker *sub = (pThis->_base_Speaker).fSub;

    if ((sub->fArrest).flags != 0) {
      int *bank = (int *)
          ((int)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags +
                      (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta) +
           (*(*(pThis->_base_Speaker).fSub->_vf)[0x11].pfn)
                     ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                      (int)(*(pThis->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
      reg_a1 = &(pThis->_base_Speaker).fConfirm;
      reg_a2 = &(pThis->_base_Speaker).fPerpName;
      SPCHNFS_D_C_PERP_APPREHENSION_REPLY(
          (pThis->_base_Speaker).fTo = bank[2],reg_a1,reg_a2);
    }
    else if ((sub->fUpdate).flags == 0) {
      pSVar7 = &(pThis->_base_Speaker).fConfirm;
      SPCHNFS_D_A_CONFIRM(pSVar7);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      pCVar5 = (Car_tObj *)
               (*(*(pThis->_base_Speaker).fSub->_vf)[0x1b].pfn)
                         ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                          (int)(*(pThis->_base_Speaker).fSub->_vf)[0x1b].delta);
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
      reg_a1 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
      pSVar7 = (SPCHNFSType_CONFIRM *)&(pThis->_base_Speaker).fColour;
      SPCHNFS_D_C_PERP_LOST_CONFIRM((SPCHNFSType_COLOUR *)pSVar7,(int)reg_a1);
    }
    else {
      pCVar5 = (Car_tObj *)
               (*(*sub->_vf)[0x1b].pfn)
                         ((int)&(sub->fPosition).flags + (int)(*sub->_vf)[0x1b].delta);
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
      {
        int *bank = (int *)
            ((int)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags +
                        (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta) +
             (*(*(pThis->_base_Speaker).fSub->_vf)[0x11].pfn)
                       ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                        (int)(*(pThis->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
        (pThis->_base_Speaker).fTo = bank[2];
      }
      iVar2 = (*(*(pThis->_base_Speaker).fSub->_vf)[0x18].pfn)
                        ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                         (int)(*(pThis->_base_Speaker).fSub->_vf)[0x18].delta);
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
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- StatusReply__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1636-1713] SLD-VERIFIED ---- */
void StatusReply__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  Speaker *Blocker;
  bool invalid = false;
  int context;
  int from;
  SPCHNFSType_REVINTRO *reverse;

  if (((pThis->_base_Speaker).fSub == (Speaker *)0x0) ||
      ((*(*(pThis->_base_Speaker).fSub->_vf)[0x1b].pfn)
         ((int)&((pThis->_base_Speaker).fSub->fPosition).flags +
          (int)(*(pThis->_base_Speaker).fSub->_vf)[0x1b].delta) == 0)) {
    invalid = true;
  }
  if (invalid) {
    return;
  }

  Speech_fgSpeech->fSpeakerCar = 0;
  Blocker = (Speaker *)0x0;
  if ((pThis->_base_Speaker).fSub->fBlockade.flags != 0) {
    if (Speech_fgSpeech->fMultiplePerps != 0) {
      (*(*(pThis->_base_Speaker).fSub->_vf)[0xd].pfn)
        ((int)&((pThis->_base_Speaker).fSub->fPosition).flags +
         (*(pThis->_base_Speaker).fSub->_vf)[0xd].delta);
      return;
    }
    Speaker *candidate = (pThis->_base_Speaker).fSub->fSub;
    bool hasBlocker = false;
    if (candidate != (Speaker *)0x0) {
      hasBlocker = candidate->fBlockade.flags != 0;
    }
    Blocker = candidate;
    if (hasBlocker) {
      CallSignBank *bank = (CallSignBank *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
        ((int)pThis + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      Speaker *sub = (pThis->_base_Speaker).fSub;
      (pThis->_base_Speaker).fTo = bank->fMobile[(*(*sub->_vf)[0x11].pfn)
        ((int)&sub->fPosition.flags + (*sub->_vf)[0x11].delta)];
    }
    else {
      Blocker = (pThis->_base_Speaker).fSub;
      int *bank = (int *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
        ((int)pThis + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      (pThis->_base_Speaker).fTo = *bank;
    }
    (*(*Blocker->_vf)[0xd].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0xd].delta);
    Speech_fgSpeech->fSpeakerCar = 0;
    SPCHNFS_D_A_CONFIRM(&(pThis->_base_Speaker).fConfirm);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    context = (pThis->_base_Speaker).fTo;
    from = (pThis->_base_Speaker).fFrom;
    reverse = &(pThis->_base_Speaker).fReverse;
  }
  else {
    CallSignBank *bank = (CallSignBank *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
      ((int)pThis + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
    Speaker *sub = (pThis->_base_Speaker).fSub;
    context = bank->fMobile[(*(*sub->_vf)[0x11].pfn)
      ((int)&sub->fPosition.flags + (*sub->_vf)[0x11].delta)];
    from = (pThis->_base_Speaker).fFrom;
    reverse = &(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = context;
  }

  SPCHNFS_D_C_INTRO_CALL(context,from,reverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  {
    Speaker *sub = (pThis->_base_Speaker).fSub;
    Car_tObj *car = (Car_tObj *)(*(*sub->_vf)[0x19].pfn)
      ((int)&sub->fPosition.flags + (*sub->_vf)[0x19].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
  }

  if ((pThis->_base_Speaker).fSub->fBlockade.flags == 1) {
    CallSignBank *bank = (CallSignBank *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
      ((int)pThis + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
    int wing = bank->fMobile[(*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];
    int location = (pThis->_base_Speaker).fLocation;
    SPCHNFSType_DISTANCE *distance = &(pThis->_base_Speaker).fDistance;
    (pThis->_base_Speaker).fSpikeSide.flags = 4;
    (pThis->_base_Speaker).fWing = wing;
    /* NEAR-MISS 5 (ours 268 / oracle 269) -- same class as SubmitRequest above:
       retail stages the loaded value in $v1 and COPIES it into the $a3 call-arg
       (`addu a3,v1,zero`); ours colours `wing` straight into $a3 because
       local-alloc's qty_phys_copy_sugg (and, for a global allocno, global.c's
       find_reg copy-preference OVERRIDE) hands the pseudo the very arg register
       it is copied into.  MEASURED (W55-A16): passing the re-read field
       `(pThis->_base_Speaker).fWing` as arg4 instead of `wing` DOES move the load
       to $v1 and makes the count EXACT 269/269 -- but the arg then becomes a
       RELOAD `lw a3,64(s1)` (6 diffs, a net regression), because expand_call's
       stack-arg store `sw v0,16(sp)` is emitted BEFORE arg4 and cse conservatively
       invalidates the s1-based MEM across it.  Keeping the 5-diff form.
       W59-A4: the 09G "make the copy a GLOBAL allocno" route is also falsified here --
       an identity fence on `wing` AFTER the fWing store gives 15, and the same fence
       placed right after `wing` is computed gives 9 (it DOES move the load to $v1 as
       predicted, but rotates the surrounding arg block).  Both worse than 5; the
       dial remains local-alloc copy-preference (06E), not a fence placement. */
    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)pThis,
      location,distance,wing,
      &(pThis->_base_Speaker).fSpikeSide);
  }
  else {
    if ((pThis->_base_Speaker).fSub->fBlockade.flags != 2) {
      goto StatusReply_backup;
    }
    SPCHNFS_D_C_RDBLK_CONFIRMED((SPCHNFSType_POSITION *)pThis,
      (pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fDistance);
  }

StatusReply_play:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  if (Blocker != (pThis->_base_Speaker).fSub) {
    Speaker *sub = (pThis->_base_Speaker).fSub;
    (*(*sub->_vf)[0xe].pfn)
      ((int)&sub->fPosition.flags + (*sub->_vf)[0xe].delta);
  }
  goto StatusReply_subFetch;

StatusReply_backup:
  if ((pThis->_base_Speaker).fSub->fSub != (Speaker *)0x0) {
    {
      CallSignBank *bank = (CallSignBank *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
        ((int)pThis + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      Speaker *sub = (pThis->_base_Speaker).fSub->fSub;
      (pThis->_base_Speaker).fWing = bank->fMobile[(*(*sub->_vf)[0x11].pfn)
        ((int)&sub->fPosition.flags + (*sub->_vf)[0x11].delta)];
    }
    SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(&(pThis->_base_Speaker).fDistance,
      (SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
      (pThis->_base_Speaker).fWing);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    {
      Speaker *sub = (pThis->_base_Speaker).fSub;
      (*(*sub->_vf)[0xe].pfn)
        ((int)&sub->fPosition.flags + (*sub->_vf)[0xe].delta);
    }
    Speaker *statusSub = (pThis->_base_Speaker).fSub->fSub;
    pThis->fStatusCount = 0x140;
    pThis->fUpdateCount = pThis->fUpdateCount + 1;
    pThis->fStatusSub = statusSub;
  }

StatusReply_subFetch:
  {
    Speaker *sub = (pThis->_base_Speaker).fSub;
    Speaker *child = sub->fSub;
    bool blocked = false;
    if (child != (Speaker *)0x0) {
      blocked = child->fBlockade.flags != 0;
    }
    if (blocked) {
      sub->fBlockade.flags = 0;
    }
  }
}

/* ---- Status__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1718-1848] SLD-VERIFIED ---- */
void Status__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  int tu5;
  int uVar10;
  int dist;
  SPCHNFSType_PURS_UPDT *PURS_UPDT;
  
  bool initialInvalid = false;
  if (((pThis->_base_Speaker).fSub == (Speaker *)0x0) ||
     (dist = (int)(*(pThis->_base_Speaker).fSub->_vf)[0x1b].delta,
     (*(*(pThis->_base_Speaker).fSub->_vf)[0x1b].pfn)
       ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + dist) == 0)) {
    initialInvalid = true;
  }
  if (!initialInvalid) {
  {
    __vtbl_ptr_type (*initialVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int car = (*(*initialVf)[0x19].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*initialVf)[0x19].delta);

    if ((*(u_int *)(car + 0x260) & 0x200) != 0) {
    __vtbl_ptr_type (*perpVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int perpDistance = (*(*perpVf)[0x18].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*perpVf)[0x18].delta);
    Speaker *branchSub = (pThis->_base_Speaker).fSub;

    if (branchSub->fHavePerp != 0) {
      if (0x15e0000 < perpDistance) {
        branchSub->fHavePerp = 0;
        (((pThis->_base_Speaker).fSub)->fUpdate).flags = 0;
        __vtbl_ptr_type (*clearVf)[31] = (pThis->_base_Speaker).fSub->_vf;
        (*(*clearVf)[2].pfn)
          ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*clearVf)[2].delta);
      }
    }
    else if (perpDistance < 0x640000) {
        __vtbl_ptr_type (*nearVf)[31] = branchSub->_vf;
        __vtbl_ptr_type *nearEntry = &(*nearVf)[6];
        int nearThis = (int)&branchSub->fPosition.flags + (int)nearEntry->delta;
        tu5 = (*(*nearVf)[0x1b].pfn)((int)&(branchSub->fPosition).flags + (int)(*nearVf)[0x1b].delta)
        ;
        (*nearEntry->pfn)(nearThis,tu5);
    }
    }
  }
  if (pThis->fStatusSub != (Speaker *)0x0) {
    if (pThis->fStatusCount-- == 1) {
      Speaker *statusSub = pThis->fStatusSub;

      if (statusSub == &pThis->_base_Speaker) {
        StatusReply__Q26Speech15DispatchSpeaker(pThis);
      }
      else {
        bool isCurrentSub = false;

        if ((pThis->_base_Speaker).fSub != (Speaker *)0x0) {
          isCurrentSub = statusSub == (pThis->_base_Speaker).fSub->fSub;
        }
        if (isCurrentSub) {
          __vtbl_ptr_type (*statusVf)[31] = statusSub->_vf;
          (*(*statusVf)[2].pfn)
            ((int)&statusSub->fPosition.flags + (int)(*statusVf)[2].delta);
        }
        else {
          __vtbl_ptr_type (*statusVf)[31] = statusSub->_vf;
          (*(*statusVf)[2].pfn)
            ((int)&statusSub->fPosition.flags + (int)(*statusVf)[2].delta);
          *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
          __vtbl_ptr_type (*dispatchVf)[31] = (pThis->_base_Speaker)._vf;
          (*(*dispatchVf)[0xe].pfn)
            ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*dispatchVf)[0xe].delta);
        }
      }
    }
    return;
  }
  if (0 < pThis->fStatusCount) {
    pThis->fStatusCount = pThis->fStatusCount + -1;
    return;
  }
  bool canUpdate = false;
  if (((pThis->_base_Speaker).fSub->fBlockade).flags == 0) {
    canUpdate = ((pThis->_base_Speaker).fSub->fArrest).flags == 0;
  }
  if (!canUpdate) {
    return;
  }
  Speaker *nestedSpeaker = (pThis->_base_Speaker).fSub->fSub;
  bool nestedDifferent = false;
  if (nestedSpeaker != (Speaker *)0x0) {
    int nestedPosition = (*(*nestedSpeaker->_vf)[0x1b].pfn)
                      ((int)&(nestedSpeaker->fPosition).flags + (int)(*nestedSpeaker->_vf)[0x1b].delta);
    __vtbl_ptr_type (*currentVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int currentPosition = (*(*currentVf)[0x1b].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*currentVf)[0x1b].delta);
    nestedDifferent = nestedPosition != currentPosition;
  }
  if (nestedDifferent) {
    Promote__Q26Speech7Speaker(((pThis->_base_Speaker).fSub)->fSub);
  }
  uVar10 = pThis->fUpdateCount & 3;
  if (uVar10 == 1) {
    goto DispStatus_updateCount1;
  }
  if (uVar10 < 2) {
    if (uVar10 == 0) goto DispStatus_updateCount38;
    goto DispStatus_fetchSpeechCtx;
  }
  if (uVar10 == 2) goto DispStatus_updateCount2;
  if (uVar10 == 3) goto DispStatus_updateCount3;
  goto DispStatus_fetchSpeechCtx;
DispStatus_updateCount2:
  {
    bool fastEnough = false;

    __vtbl_ptr_type (*distanceVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int updateDistance = (*(*distanceVf)[0x18].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*distanceVf)[0x18].delta);
    if (updateDistance < 0x280000) {
      __vtbl_ptr_type (*carVf)[31] = (pThis->_base_Speaker).fSub->_vf;
      Car_tObj *car = (Car_tObj *)(*(*carVf)[0x19].pfn)
        ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*carVf)[0x19].delta);
      int carSpeed = CalcMph__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
      if (0x32 < carSpeed) {
        __vtbl_ptr_type (*positionVf)[31] = (pThis->_base_Speaker).fSub->_vf;
        Car_tObj *position = (Car_tObj *)(*(*positionVf)[0x1b].pfn)
          ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*positionVf)[0x1b].delta);
        int positionSpeed = CalcMph__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,position);
        fastEnough = 0x32 < positionSpeed;
      }
    }
    if (fastEnough) {
      (((pThis->_base_Speaker).fSub)->fUpdate).flags = 8;
      goto DispStatus_fetchSpeechCtx;
    }
    goto DispStatus_updateCount38;
  }
DispStatus_updateCount38:
  ((pThis->_base_Speaker).fSub->fUpdate).flags = 0x26;
  goto DispStatus_fetchSpeechCtx;
DispStatus_updateCount3:
    {
    __vtbl_ptr_type (*checkVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int ready = (*(*checkVf)[0x14].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*checkVf)[0x14].delta);
    if ((ready != 0) && (pThis->fUpdateCount == 7)) {
      (((pThis->_base_Speaker).fSub)->fUpdate).flags = 0;
      __vtbl_ptr_type (*resetVf)[31] = (pThis->_base_Speaker).fSub->_vf;
      (*(*resetVf)[2].pfn)
        ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*resetVf)[2].delta);
      pThis->fUpdateCount = pThis->fUpdateCount + 1;
      return;
    }
    __vtbl_ptr_type (*case3DistanceVf)[31] = (pThis->_base_Speaker).fSub->_vf;
    int case3Distance = (*(*case3DistanceVf)[0x18].pfn)
      ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*case3DistanceVf)[0x18].delta);
    if (case3Distance < 0x140000) {
      __vtbl_ptr_type (*nearVf)[31] = (pThis->_base_Speaker).fSub->_vf;
      (*(*nearVf)[0xf].pfn)
        ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*nearVf)[0xf].delta);
      pThis->fUpdateCount = pThis->fUpdateCount + 1;
      return;
    }
    goto DispStatus_updateCount1;
    }
DispStatus_updateCount1:
  ((pThis->_base_Speaker).fSub->fUpdate).flags = 1;
DispStatus_fetchSpeechCtx:
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  __vtbl_ptr_type (*dispatchVf)[31] = (pThis->_base_Speaker)._vf;
  int speechTable = (*(*dispatchVf)[0x1e].pfn)
    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*dispatchVf)[0x1e].delta);
  __vtbl_ptr_type (*speakerVf)[31] = (pThis->_base_Speaker).fSub->_vf;
  int speechIndex = (*(*speakerVf)[0x11].pfn)
    ((int)&((pThis->_base_Speaker).fSub->fPosition).flags + (int)(*speakerVf)[0x11].delta);
  int speechEntry = speechTable;
  speechEntry += speechIndex * 4;
  int speechContext = *(int *)(speechEntry + 8);
  (pThis->_base_Speaker).fTo = speechContext;
  SPCHNFS_D_C_INTRO_CALL(speechContext,(pThis->_base_Speaker).fFrom,
                         &(pThis->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  PURS_UPDT = &((pThis->_base_Speaker).fSub)->fUpdate;
  SPCHNFS_D_C_IN_PURS_NEAR_PERP(PURS_UPDT);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  pThis->fStatusCount = 0x60;
  pThis->fStatusSub = (pThis->_base_Speaker).fSub;
  pThis->fUpdateCount = pThis->fUpdateCount + 1;
  }
  return;
}

/* ---- Status__Q26Speech13MobileSpeaker  [SPEECH.CPP:1853-1948] SLD-VERIFIED ---- */
/* MATCH: 90 -> 14 diffs (358/358).  IDA/SLD recovered the shared s0 boolean
   lifetimes, direct Dispatch virtual call, far-subbranch order, and speed/look
   cross-jump layout.  The remaining 14 are four call-argument scheduling
   choices; clean direct/named/ordering forms are neutral or worse.  qtytrace
   is currently blocked because the instrumented cc1plus ICEs earlier in this
   TU at SetCar. */
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
    pSVar9 = pSVar10;
    /* MATCH: fold `fTo = *(iVar4+4)` INTO the a1 arg so the store lands in the
       jal delay slot (`sw a1,60(s1)`) and a1 loads direct; keep a2(fFrom)/a3(fReverse)
       inline so gcc loads a1,a2,a3 in order -- the split temp+store form forced a
       `lw a2/t0 then move a2->a1,t0->a2` arg shuffle. [W55-A16 idiom] */
    SPCHNFS_C_A_INTRO(pSVar10,(pThis->_base_Speaker).fTo = *(int *)(iVar4 + 4),(int)(pThis->_base_Speaker).fFrom,(SPCHNFSType_REVINTRO *)&(pThis->_base_Speaker).fReverse);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
    if (bVar1) {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &pThis->fVoice;
      pSVar9 = pSVar10;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,(pThis->_base_Speaker).fTo = *(int *)(iVar4 + 4),(pThis->_base_Speaker).fFrom,&(pThis->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      iVar4 = Dispatch__6Speech();
      uVar13 = *(u_int *)(iVar4 + 0x48);
      iVar4 = Dispatch__6Speech();
      *(MobileSpeaker **)(iVar4 + 0x48) = pThis;
      {
        DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
        __vtbl_ptr_type (*dispatchVf)[31] = (dispatchThis->_base_Speaker)._vf;
        (*(*dispatchVf)[0xe].pfn)
                  ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                   (int)(*dispatchVf)[0xe].delta);
      }
      iVar4 = Dispatch__6Speech();
      *(u_int *)(iVar4 + 0x48) = uVar13;
      return;
    }
    bVar2 = false;
    pa_Var3 = (pThis->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x14].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x14].delta);
    if (((iVar4 != 0) && ((pThis->_base_Speaker).fUpdate.flags == 0)) &&
       (pSVar7 = (pThis->_base_Speaker).fSub, pSVar7 != (Speaker *)0x0)) {
      u_int maskedFlags;

      iVar4 = (*(*pSVar7->_vf)[0x19].pfn)
                        ((int)&(pSVar7->fPosition).flags + (int)(*pSVar7->_vf)[0x19].delta);
      maskedFlags = *(u_int *)(iVar4 + 0x260) & 0x40;
      bVar2 = maskedFlags < 1;
    }
    if (bVar2) {
      pa_Var3 = (pThis->_base_Speaker)._vf;
      puVar6 = (u_int *)
               (*(*pa_Var3)[0x1e].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &pThis->fVoice;
      pCVar5 = (Car_tObj *)*puVar6;
      pSVar9 = pSVar10;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,(pThis->_base_Speaker).fTo = (int)pCVar5,(int)(pThis->_base_Speaker).fFrom,(SPCHNFSType_REVINTRO *)&(pThis->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
      pSVar9 = pSVar10;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,(pThis->_base_Speaker).fTo = *(int *)(iVar4 + 4),(int)(pThis->_base_Speaker).fFrom,(SPCHNFSType_REVINTRO *)&(pThis->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
          int nearLocation;

          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fCar;
          pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fDistance;
          nearLocation = (pThis->_base_Speaker).fLocation;
          SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(pSVar10,(SPCHNFSType_COLOUR *)pCVar5,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,(SPCHNFSType_POSITION *)pThis,
                     nearLocation);
          goto DispStatus_playSpeechReturn;
        }
      }
      else if ((pThis->_base_Speaker).fHavePerp != 0) {
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
      else {
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
          goto DispStatus_lookReplyStatus;
        }
      }
DispStatus_speedReply:
      pCVar5 = (Car_tObj *)pThis->fSpeed;
      vs_KMH_MPH = &pThis->fSpeedType;
      SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(pSVar10,(int)pCVar5,vs_KMH_MPH);
      goto DispStatus_playSpeechReturn;
DispStatus_lookReplyStatus:
      pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
      vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(pThis->_base_Speaker).fCar;
      pMVar12 = (MobileSpeaker *)&(pThis->_base_Speaker).fPerpName;
      SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(pSVar10,(SPCHNFSType_COLOUR *)pCVar5,(int)vs_KMH_MPH,
                 (SPCHNFSType_PERP_NAME *)pMVar12);
    }
  }
DispStatus_playSpeechReturn:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
/* MATCH: 36 -> 11 diffs (103/104).  Distinct short-lived speech arguments
   recover every tail register, the SLD Speech* local plus the first empty
   barrier recover the retail prologue, and the pin-free pSVar6 fence recovers
   fSub=$v1.  Remaining named angle: retail keeps the first virtual result in
   $v0, forcing the second vtable into $a1 and delaying v0->s0 into jalr's slot;
   gcc currently copies to s0 early and consequently assigns that vtable $v0.
   qtytrace is blocked by the preceding SetCar instrumented-compiler ICE. */
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
  Speech *speech;
  
  speech = Speech_fgSpeech;
  bVar1 = false;
  __asm__("" : : "i"(0));
  *(u_int *)((int)speech + 0x38c) = 0;
  /* W57-A8 5.0c commutative-addu: fold the -0x5c into the BASE term so the
     just-loaded delta stays operand 2 (`addu a0,s1,a0` like retail, not
     `addu a0,a0,s1`). All four vf-thunk arg sites. 42 -> 36 diffs. */
  iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x12].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x12].delta);
  if (iVar3 != 0) {
    bVar1 = (pThis->_base_Speaker).fSub != (Speaker *)0x0;
  }
  if (bVar1) {
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      int sightedTo;

      iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      pSVar6 = (pThis->_base_Speaker).fSub;
      __asm__("" : "=r"(pSVar6) : "0"(pSVar6));
      iVar4 = (*(*pSVar6->_vf)[0x11].pfn)((int)&(pSVar6->fPosition).flags + (int)(*pSVar6->_vf)[0x11].delta)
      ;
      iVar3 = iVar3 + iVar4 * 4;
      sightedTo = *(int *)(iVar3 + 8);
      CONFIRM = &(pThis->_base_Speaker).fConfirm;
      (pThis->_base_Speaker).fTo = sightedTo;
      SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(CONFIRM,sightedTo);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
  }
  else {
    if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
      int introFrom;

      piVar5 = (int *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)(((int)pThis->fPerp + -0x5c) + (*(pThis->_base_Speaker)._vf)[0x1e].delta);
      ctx = (void *)*piVar5;
      introFrom = (pThis->_base_Speaker).fFrom;
      REVINTRO = &(pThis->_base_Speaker).fReverse;
      (pThis->_base_Speaker).fTo = (int)ctx;
      SPCHNFS_D_C_INTRO_CALL((int)ctx,introFrom,REVINTRO);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
      FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
      int pursuitCar;

      COLOUR = &(pThis->_base_Speaker).fColour;
      pursuitCar = (pThis->_base_Speaker).fCar;
      iVar4 = (pThis->_base_Speaker).fLocation;
      param2 = pThis;
      SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(COLOUR,pursuitCar,(SPCHNFSType_POSITION *)pThis,iVar4,&(pThis->_base_Speaker).fDistance);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
    /* MATCH: retail SLD line 2060 owns BOTH vtable calls AND the index scale +
       load (one fused statement); line 2061 owns only the INTRO_CALL args, with
       `fTo = ctx` written as the arg-0 assignment (oracle `sw a0,60(s1)` in the
       jal delay slot).  Splitting the calls into iVar2/iVar3 statements and
       storing fTo separately cost 21 diffs. [05A LAW: SLD = statement order]
       The arg-0 term order also matters: base FIRST (`addu a0,s1,a0`). */
    {
      /* MATCH: the computed base needs its OWN (block-scoped) variable -- gcc then
         coalesces `bank` with the 1st call's result pseudo and mutates it IN PLACE
         (oracle `addu s0,s0,v0; lw a0,8(s0)`).  As an anonymous sub-expression
         (`*(void**)(A + B*4 + 8)`) the address lands in the scaled temp instead
         (`addu v0,v0,s0`).  Same shape the PASSing sibling Roger uses. [3.12 #14] */
      int *bank = (int *)((int)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                   ((int)&(pThis->_base_Speaker).fPosition.flags +
                    (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta) +
         (*(*(pThis->_base_Speaker).fSub->_vf)[0x11].pfn)
                   ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                    (int)(*(pThis->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
      ctx = (void *)bank[2];
    }
    iVar2 = (pThis->_base_Speaker).fFrom;
    REVINTRO = &(pThis->_base_Speaker).fReverse;
    SPCHNFS_D_C_INTRO_CALL((pThis->_base_Speaker).fTo = (int)ctx,iVar2,REVINTRO);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    pSVar4 = (pThis->_base_Speaker).fSub;
    vs_RDBLK_SSTRP = &pSVar4->fBlockade;
    /* MATCH: retail's FALL-THROUGH arm is the RDBLK one (oracle `beqz v1` +
       `addiu a0,v0,20` in the slot); the `flags == 0` spelling puts
       DENIED_REPLY first and flips the branch polarity. */
    if ((pSVar4->fBlockade).flags != 0) {
      SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(vs_RDBLK_SSTRP);
    }
    else {
      SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY();
    }
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    (((pThis->_base_Speaker).fSub)->fBlockade).flags = 0;
  }
  return;
}

/* ---- Grant__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2079-2098] SLD-VERIFIED ---- */
void Grant__Q26Speech15DispatchSpeaker(DispatchSpeaker *pThis)

{
  Speaker *pSVar1;
  SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP;
  SPCHNFSType_CONFIRM *CONFIRM;

  pSVar1 = (pThis->_base_Speaker).fSub;
  if (pSVar1 == (Speaker *)0x0) {
    return;
  }
  vs_RDBLK_SSTRP = &pSVar1->fBlockade;
  if (vs_RDBLK_SSTRP == (SPCHNFSType_vs_RDBLK_SSTRP *)0x0) {
    return;
  }
  *(u_int *)(((int)Speech_fgSpeech) + 0x38c) = 0;
  if (*(int *)(((int)Speech_fgSpeech) + 0x388) != 0) {
    return;
  }
  CONFIRM = &(pThis->_base_Speaker).fConfirm;
  SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(&(pThis->_base_Speaker).fSub->fBlockade,CONFIRM);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
  if ((carObj->carFlags & 0x40U) != 0) {
    return pThis->fSuperCount++ % 6;
  }
  if ((carObj->carFlags & 0x80U) != 0) {
    return 0;
  }
  return pThis->fCopCount++ % 9;
}

/* ---- GetVoice__6SpeechP8Car_tObj  [SPEECH.CPP:2156-2157] SLD-VERIFIED ---- */
int GetVoice__6SpeechP8Car_tObj(Car_tObj *carObj)

{
  return PickVoice__6SpeechP8Car_tObj((Speech *)((int)Speech_fgSpeech),carObj);
}

/* ---- Activate__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2163-2189] SLD-VERIFIED ---- */
void Activate__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *carObj)

{
  Speech_tMobileVoiceAttr *a;
  int Voice;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  /* MATCH: as in ReActivate, branch-local fVoice assignments keep the merged voice value in
     v0; the scoped pFrom below preserves the virtual-call result as the address-add base. */

  pThis->fCarObj = carObj;
  Voice = GetVoice__6SpeechP8Car_tObj(carObj);
  pThis->fUnit = Voice;
  a = &Speech_gCopAttr[Voice];
  if ((carObj->carFlags & 0x40U) != 0) {
    pThis->fUnit = Voice + 9;
    (pThis->fVoice).flags = 8;
  }
  else {
    (pThis->fVoice).flags = a->voice;
  }
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x1e].delta);
  {
    int *pFrom = (int *)(iVar3 + pThis->fUnit * 4 + 8);
    (pThis->_base_Speaker).fFrom = *pFrom;
  }
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
  Speech_tMobileVoiceAttr *a;
  int Voice;
  __vtbl_ptr_type (*pa_Var1) [31];
  int unit;

  Voice = GetVoice__6SpeechP8Car_tObj(pThis->fCarObj);
  pThis->fUnit = Voice;
  a = &Speech_gCopAttr[Voice];
  if ((pThis->fCarObj->carFlags & 0x40U) != 0) {
    pThis->fUnit = Voice + 9;
    (pThis->fVoice).flags = 8;
  }
  else {
    (pThis->fVoice).flags = a->voice;
  }
  pa_Var1 = (pThis->_base_Speaker)._vf;
  unit = (*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
  {
    int *pFrom = (int *)(unit + pThis->fUnit * 4 + 8);
    (pThis->_base_Speaker).fFrom = *pFrom;
  }
  return;
}

/* ---- FindMobile__6SpeechP8Car_tObj  [SPEECH.CPP:2218-2237] SLD-VERIFIED ---- */
Speaker * FindMobile__6SpeechP8Car_tObj(Speech *pThis,Car_tObj *carObj)

{
  for (int i = 0; i < 4; i++) {
    MobileSpeaker *mobile = pThis->fMobile[i];

    if (carObj == mobile->fCarObj) {
      return &mobile->_base_Speaker;
    }
  }

  for (int i = 0; i < 4; i++) {
    MobileSpeaker *mobile = pThis->fMobile[i];

    if (mobile->fCarObj == (Car_tObj *)0x0) {
      Activate__Q26Speech13MobileSpeakerP8Car_tObj(mobile,carObj);
      return &pThis->fMobile[i]->_base_Speaker;
    }
  }

  return Speech_fgUndefined;
}

/* ---- Mobile__6SpeechP8Car_tObj  [SPEECH.CPP:2244-2250] SLD-VERIFIED ---- */
int Mobile__6SpeechP8Car_tObj(Car_tObj *carObj)

{
  Speaker *pSVar1;

  if ((int)Speech_fgSpeech != 0) {
    if (*(int *)(((int)Speech_fgSpeech) + 0x36c) != 0) {
      goto Mobile_findIt;
    }
  }
  pSVar1 = Speech_fgUndefined;
  return (int)pSVar1;
Mobile_findIt:
  pSVar1 = FindMobile__6SpeechP8Car_tObj((Speech *)((int)Speech_fgSpeech),carObj);
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
/* MATCH: SYM has no named locals.  The duplicated ternary expressions are
   the retail source shape: gcc keeps the shared division reciprocal in s0,
   re-evaluates fixedmult only on the nonnegative path, and shares the store. */
#define MOBILE_SPEAKER_SPEED(perp, scale) \
  (fixedmult((scale), __builtin_abs((perp)->linearVel_ch.z)) / 0xa0000 - 3)

void SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  if (GameSetup_gData.measurement == 1) {
    (pThis->fSpeedType).flags = 1;
    pThis->fSpeed = MOBILE_SPEAKER_SPEED(perp, 0x39999) < 0
        ? 0 : MOBILE_SPEAKER_SPEED(perp, 0x39999);
  }
  else {
    (pThis->fSpeedType).flags = 2;
    pThis->fSpeed = MOBILE_SPEAKER_SPEED(perp, 0x23ca5) < 0
        ? 0 : MOBILE_SPEAKER_SPEED(perp, 0x23ca5);
  }
  return;
}
#undef MOBILE_SPEAKER_SPEED

/* ---- DistToPerp__Q26Speech13MobileSpeaker  [SPEECH.CPP:2281-2286] SLD-VERIFIED ---- */
/* MATCH: SYM lists exactly x=$s2, z=$v1, d=$v0.  Expanding the virtual
   coordinate accesses at each source occurrence preserves the retail call
   duplication; signed difference tests produce its subu/blez arm shape. */
#define MOBILE_SPEAKER_COORD(pThis, slot, offset) \
  (*(int *)(((*(*(pThis->_base_Speaker)._vf)[slot].pfn) \
      ((int)&(pThis->_base_Speaker).fPosition.flags + \
       (int)(*(pThis->_base_Speaker)._vf)[slot].delta)) + (offset)))

int DistToPerp__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  int x;
  int z;
  int d;

  if (MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa0) -
      MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa0) > 0) {
    x = MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa0) -
        MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa0);
  }
  else {
    x = MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa0) -
        MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa0);
  }
  if (MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa8) -
      MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa8) > 0) {
    z = MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa8) -
        MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa8);
  }
  else {
    z = MOBILE_SPEAKER_COORD(pThis, 0x1b, 0xa8) -
        MOBILE_SPEAKER_COORD(pThis, 0x19, 0xa8);
  }
  if (z < x) {
    d = x + (z >> 2);
  }
  else {
    d = z + (x >> 2);
  }
  return d;
}
#undef MOBILE_SPEAKER_COORD

/* ---- Report__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2295-2316] SLD-VERIFIED ---- */
void Report__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  Speaker * Sub;
  Car_tObj *carObj;
  __vtbl_ptr_type (*pa_Var1) [31];
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  int ID_UNIT1;
  SPCHNFSType_REVINTRO *REVINTRO;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var1 = (pThis->_base_Speaker)._vf;
  pThis->_base_Speaker.fTo =
      *(int *)((*(*pa_Var1)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags +
                     (int)(*pa_Var1)[0x1e].delta) + 4);
  VOICE = &pThis->fVoice;
  ID_UNIT1 = (pThis->_base_Speaker).fFrom;
  REVINTRO = &(pThis->_base_Speaker).fReverse;
  ctx = VOICE;
  SPCHNFS_C_A_INTRO(VOICE,pThis->_base_Speaker.fTo,ID_UNIT1,REVINTRO);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,perp);
  SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(pThis,perp);
  {
    int reportCar = (pThis->_base_Speaker).fCar;
    int reportLocation = (pThis->_base_Speaker).fLocation;
    SPCHNFS_C_D_PERP_SIGHTED(VOICE,&(pThis->_base_Speaker).fColour,
               reportCar,&(pThis->_base_Speaker).fDistance,
               (SPCHNFSType_POSITION *)pThis,reportLocation,
               &(pThis->_base_Speaker).fPerpName);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  *(MobileSpeaker **)(Dispatch__6Speech() + 0x48) = pThis;
  return;
}

/* ---- Engage__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2331-2450] SLD-VERIFIED ---- */
void Engage__Q26Speech13MobileSpeakerP8Car_tObj(MobileSpeaker *pThis,Car_tObj *perp)

{
  Car_tObj * car;
  bool bVar2;
  bool bVar3;
  bool bVar4;
  bool bVar5;
  Car_tObj *carObj;
  Car_tObj *pCVar3;
  int initialCarState;
  int dispatchRoot;
  int dispatchCarState;
  int dispatchIntro;
  int superCheck;
  int superCarState;
  int superDispatch;
  int superState;
  int dispatchTail;
  int knownPerp;
  int dispatchCount;
  int introTable;
  int dispatchSpeaker;
  int dispatchResult;
  int carId;
  int savedDispatch;
  int sameCount;
  int sameIntro;
  MobileSpeaker *pMVar5;
  MobileSpeaker *pMVar6;
  int iVar7;
  u_int *puVar8;
  int iVar9;
  __vtbl_ptr_type (*pa_Var10) [31];
  SPCHNFSType_VOICE *pSVar11;
  SPCHNFSType_VOICE *pSVar12;
  SPCHNFSType_COLOUR *pSVar13;
  SPCHNFSType_COLOUR *COLOUR;
  SPCHNFSType_REVINTRO *pSVar14;
  Speaker *SubChain;
  u_int uVar15;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  pa_Var10 = (pThis->_base_Speaker)._vf;
  (pThis->_base_Speaker).fHavePerp = 1;
  pCVar3 = (Car_tObj *)
           (*(*pa_Var10)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var10)[0x1b].delta);
  if (perp == pCVar3) goto MSEngage_samePerp;
  {
  __vtbl_ptr_type (*setCarVf)[31] = (pThis->_base_Speaker)._vf;
  pThis->fPerp = perp;
  pCVar3 = (Car_tObj *)
           (*(*setCarVf)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*setCarVf)[0x1b].delta);
  }
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  {
  __vtbl_ptr_type (*stateVf)[31] = (pThis->_base_Speaker)._vf;
  initialCarState = (*(*stateVf)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*stateVf)[0x19].delta);
  }
  if ((*(u_int *)(initialCarState + 0x260) & 0x200) == 0) {
    Speaker *next;
    SubChain = (Speaker *)Dispatch__6Speech();
MSEngage_unlinkLoop:
    next = SubChain->fSub;
    if (next == (Speaker *)0x0) goto MSEngage_dispatchCheck;
    if (next != &pThis->_base_Speaker) {
      SubChain = next;
      goto MSEngage_unlinkLoop;
    }
    SubChain->fSub = (pThis->_base_Speaker).fSub;
    (pThis->_base_Speaker).fSub = (Speaker *)0x0;
  }
MSEngage_dispatchCheck:
  dispatchRoot = Dispatch__6Speech();
  if (*(MobileSpeaker **)(dispatchRoot + 0x48) == pThis) {
    {
    __vtbl_ptr_type (*dispatchStateVf)[31] = (pThis->_base_Speaker)._vf;
    dispatchCarState = (*(*dispatchStateVf)[0x19].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*dispatchStateVf)[0x19].delta);
    }
    if ((*(u_int *)(dispatchCarState + 0x260) & 0x200) == 0) {
      return;
    }
    {
      DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
      __vtbl_ptr_type (*engageVf)[31] = (dispatchThis->_base_Speaker)._vf;
      (*(*engageVf)[1].pfn)
                ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                 (int)(*engageVf)[1].delta,perp);
    }
    *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
    {
    __vtbl_ptr_type (*introVf)[31] = (pThis->_base_Speaker)._vf;
    dispatchIntro = (*(*introVf)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*introVf)[0x1e].delta);
    }
    (pThis->_base_Speaker).fTo = *(int *)(dispatchIntro + 4);
    {
    __vtbl_ptr_type (*positionVf)[31] = (pThis->_base_Speaker)._vf;
    pCVar3 = (Car_tObj *)
             (*(*positionVf)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*positionVf)[0x1b].delta);
    }
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
    int replyTo = (pThis->_base_Speaker).fTo;
    int replyCar = (pThis->_base_Speaker).fCar;
    int replyLocation = (pThis->_base_Speaker).fLocation;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(&pThis->fVoice,replyTo,
               &(pThis->_base_Speaker).fColour,replyCar,
               &(pThis->_base_Speaker).fDistance,(SPCHNFSType_POSITION *)pThis,
               replyLocation,&(pThis->_base_Speaker).fConfirm);
    goto MSEngage_emitSpeech;
  }
  bVar2 = false;
  {
  __vtbl_ptr_type (*superCheckVf)[31] = (pThis->_base_Speaker)._vf;
  superCheck = (*(*superCheckVf)[0x14].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*superCheckVf)[0x14].delta);
  }
  if (superCheck != 0) {
    {
    __vtbl_ptr_type (*superPositionVf)[31] = (pThis->_base_Speaker)._vf;
    superCarState = (*(*superPositionVf)[0x1b].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*superPositionVf)[0x1b].delta);
    }
    if ((*(u_int *)(superCarState + 0x260) & 4) != 0) {
      superDispatch = Dispatch__6Speech();
      if (*(int *)(superDispatch + 0x48) != 0) {
        int dispatchVtable;

        superDispatch = Dispatch__6Speech();
        dispatchVtable = *(int *)(*(int *)(superDispatch + 0x48) + 0x4c);
        superState = (**(int (**)(...))(dispatchVtable + 0xcc))
                    (*(int *)(superDispatch + 0x48) + (int)*(short *)(dispatchVtable + 200));
        {
          u_int superFlag = *(u_int *)(superState + 0x260) & 0x40;
          bVar2 = superFlag < 1;
        }
      }
    }
  }
  if (bVar2) {
    superDispatch = Dispatch__6Speech();
    (pThis->_base_Speaker).fSub = *(Speaker **)(superDispatch + 0x48);
    superDispatch = Dispatch__6Speech();
    *(MobileSpeaker **)(superDispatch + 0x48) = pThis;
    if ((pThis->_base_Speaker).fBlockade.flags != 0) {
      return;
    }
    __vtbl_ptr_type (*superIntroVf)[31] = (pThis->_base_Speaker)._vf;
    puVar8 = (u_int *)
             (*(*superIntroVf)[0x1e].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*superIntroVf)[0x1e].delta);
    pSVar13 = (SPCHNFSType_COLOUR *)*puVar8;
    COLOUR = (SPCHNFSType_COLOUR *)(pThis->_base_Speaker).fFrom;
    pMVar5 = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
    (pThis->_base_Speaker).fTo = (int)pSVar13;
    SPCHNFSType_VOICE *superVoice = &pThis->fVoice;
    SPCHNFS_C_A_INTRO(superVoice,(int)pSVar13,(int)COLOUR,(SPCHNFSType_REVINTRO *)pMVar5);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    SPCHNFS_S_C_SUPER_COP_ARRIVAL(superVoice);
    pThis = pMVar5;
    goto MSEngage_emitSpeech;
  }
    bVar3 = false;
    pSVar12 = (SPCHNFSType_VOICE *)Dispatch__6Speech();
    iVar7 = Dispatch__6Speech();
    if (*(int *)(iVar7 + 0x48) != 0) {
      DispatchSpeaker *chainDispatch = (DispatchSpeaker *)Dispatch__6Speech();
      Speaker *chainSub = (chainDispatch->_base_Speaker).fSub;
      __vtbl_ptr_type (*chainVf)[31] = chainSub->_vf;
      iVar7 = (*(*chainVf)[0x1b].pfn)
                    ((int)&chainSub->fPosition.flags + (int)(*chainVf)[0x1b].delta);
      if (iVar7 != 0) {
        iVar7 = Dispatch__6Speech();
        iVar9 = *(int *)(*(int *)(iVar7 + 0x48) + 0x4c);
        iVar7 = (**(int (**)(...))(iVar9 + 0xdc))(*(int *)(iVar7 + 0x48) + (int)*(short *)(iVar9 + 0xd8));
        if ((*(u_int *)(iVar7 + 0x260) & 4) == 0) {
          __vtbl_ptr_type (*pursuitVf)[31] = (pThis->_base_Speaker)._vf;
          iVar7 = (*(*pursuitVf)[0x1b].pfn)
                            ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pursuitVf)[0x1b].delta);
          {
            u_int pursuitFlag = *(u_int *)(iVar7 + 0x260) & 4;
            bVar3 = 0 < pursuitFlag;
          }
        }
      }
    }
    if (bVar3) {
      savedDispatch = Dispatch__6Speech();
      (pThis->_base_Speaker).fSub = *(Speaker **)(savedDispatch + 0x48);
      savedDispatch = Dispatch__6Speech();
      *(MobileSpeaker **)(savedDispatch + 0x48) = pThis;
    }
    else {
MSEngage_tailLoop:
      pMVar6 = (MobileSpeaker *)*(int *)((int)pSVar12 + 0x48);
      if (pMVar6 == (MobileSpeaker *)0x0) goto MSEngage_tailEnd;
      pSVar12 = (SPCHNFSType_VOICE *)pMVar6;
      goto MSEngage_tailLoop;
MSEngage_tailEnd:
      *(MobileSpeaker **)((int)pSVar12 + 0x48) = pThis;
    }
  if ((pThis->_base_Speaker).fBlockade.flags != 0) {
    return;
  }
  bVar4 = false;
  {
    DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
    __vtbl_ptr_type (*knownVf)[31] = (dispatchThis->_base_Speaker)._vf;
    knownPerp = (*(*knownVf)[0x12].pfn)
                    ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                     (int)(*knownVf)[0x12].delta,perp);
  }
  if (knownPerp != 0) {
    DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
    __vtbl_ptr_type (*countVf)[31] = (dispatchThis->_base_Speaker)._vf;
    dispatchCount = (*(*countVf)[0x15].pfn)
                      ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                       (int)(*countVf)[0x15].delta);
    if (0x17f < dispatchCount) goto MSEngage_validateAndProceed;
  }
  bVar4 = true;
MSEngage_validateAndProceed:
  if (!bVar4) {
    return;
  }
  {
  __vtbl_ptr_type (*introVf)[31] = (pThis->_base_Speaker)._vf;
  introTable = (*(*introVf)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*introVf)[0x1e].delta);
  }
  (pThis->_base_Speaker).fTo = *(int *)(introTable + 4);
  pSVar12 = &pThis->fVoice;
  pSVar11 = pSVar12;
  SPCHNFS_C_A_INTRO(pSVar12,(pThis->_base_Speaker).fTo,
             (pThis->_base_Speaker).fFrom,&(pThis->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  {
  __vtbl_ptr_type (*locationVf)[31] = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*locationVf)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*locationVf)[0x1b].delta);
  }
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  {
  __vtbl_ptr_type (*speedVf)[31] = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*speedVf)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*speedVf)[0x1b].delta);
  }
  SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj(pThis,pCVar3);
  {
  DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
  __vtbl_ptr_type (*dispatchVf)[31] = (dispatchThis->_base_Speaker)._vf;
  __vtbl_ptr_type *knownEntry = &(*dispatchVf)[0x12];
  int knownThis = (int)&(dispatchThis->_base_Speaker).fPosition.flags +
                  (int)knownEntry->delta;
  __vtbl_ptr_type (*dispatchPositionVf)[31] = (pThis->_base_Speaker)._vf;
  Car_tObj *dispatchPosition = (Car_tObj *)(*(*dispatchPositionVf)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags +
                     (int)(*dispatchPositionVf)[0x1b].delta);
  dispatchResult = (*knownEntry->pfn)(knownThis,dispatchPosition);
  }
  if (dispatchResult != 0) {
    int sightedCar = (pThis->_base_Speaker).fCar;
    int sightedLocation = (pThis->_base_Speaker).fLocation;
    SPCHNFS_C_D_PERP_SIGHTED(pSVar12,&(pThis->_base_Speaker).fColour,
               sightedCar,&(pThis->_base_Speaker).fDistance,
               (SPCHNFSType_POSITION *)pThis,sightedLocation,
               &(pThis->_base_Speaker).fPerpName);
  }
  else {
    int engageCar = (pThis->_base_Speaker).fCar;
    int engageLocation = (pThis->_base_Speaker).fLocation;
    int engageSpeed = pThis->fSpeed;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(pSVar12,&(pThis->_base_Speaker).fColour,
               engageCar,(SPCHNFSType_POSITION *)pThis,engageLocation,
               &(pThis->_base_Speaker).fDistance,engageSpeed,
               &pThis->fSpeedType,&(pThis->_base_Speaker).fPerpName)
    ;
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  savedDispatch = Dispatch__6Speech();
  pSVar12 = (SPCHNFSType_VOICE *)*(u_int *)(savedDispatch + 0x48);
  savedDispatch = Dispatch__6Speech();
  *(MobileSpeaker **)(savedDispatch + 0x48) = pThis;
  {
  int temp_v0_21 = Dispatch__6Speech();
  int temp_v0_22 = *(int *)(temp_v0_21 + 0x4c);
  int temp_a1_4 = *(int *)((int)pThis + 0x4c);
  int temp_s1_2 = temp_v0_22 + 8;
  int temp_s0_3 = temp_v0_21 + *(short *)(temp_v0_22 + 8);
  pCVar3 = (Car_tObj *)(**(int (**)(...))(temp_a1_4 + 0xdc))
                    ((int)pThis + *(short *)(temp_a1_4 + 0xd8));
  (**(int (**)(...))(temp_s1_2 + 4))(temp_s0_3,pCVar3);
  }
  savedDispatch = Dispatch__6Speech();
  *(u_int *)(savedDispatch + 0x48) = (u_int)pSVar12;
  return;
MSEngage_samePerp:
  bVar5 = false;
  if (*(int *)(((int)Speech_fgSpeech) + 0x388) == 0) {
    DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
    __vtbl_ptr_type (*sameCountVf)[31] = (dispatchThis->_base_Speaker)._vf;
    sameCount = (*(*sameCountVf)[0x15].pfn)
                      ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                       (int)(*sameCountVf)[0x15].delta);
    bVar5 = sameCount < 0x160;
  }
  if (!bVar5) {
    return;
  }
  {
  SPCHNFSType_VOICE *sameVoice;
  {
  __vtbl_ptr_type (*samePositionVf)[31] = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*samePositionVf)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*samePositionVf)[0x1b].delta);
  }
  SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  {
  __vtbl_ptr_type (*sameIntroVf)[31] = (pThis->_base_Speaker)._vf;
  sameIntro = (*(*sameIntroVf)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*sameIntroVf)[0x1e].delta);
  }
  (pThis->_base_Speaker).fTo = *(int *)(sameIntro + 4);
  sameVoice = &pThis->fVoice;
  SPCHNFS_C_A_INTRO(sameVoice,(pThis->_base_Speaker).fTo,
             (pThis->_base_Speaker).fFrom,&(pThis->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  {
  __vtbl_ptr_type (*sameLocationVf)[31] = (pThis->_base_Speaker)._vf;
  pCVar3 = (Car_tObj *)
           (*(*sameLocationVf)[0x1b].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*sameLocationVf)[0x1b].delta);
  }
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
  pSVar13 = &(pThis->_base_Speaker).fColour;
  COLOUR = (SPCHNFSType_COLOUR *)(pThis->_base_Speaker).fCar;
  SPCHNFS_C_C_PERP_REAQUIRED(sameVoice,pSVar13,(int)COLOUR,(SPCHNFSType_POSITION *)pThis,(pThis->_base_Speaker).fLocation,
             &(pThis->_base_Speaker).fDistance);
  }
MSEngage_emitSpeech:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
  int reg_a1;
  int reg_a2;
  int reg_a3;
  MobileSpeaker *REVINTRO;
  u_int uVar8;
  Speaker *Leader;
  DispatchSpeaker *dispatchThis;
  DispatchSpeaker *finalDispatch;
  
  iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*(pThis->_base_Speaker)._vf)[0x1b].delta);
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
      Leader = *(Speaker **)(iVar3 + 0x48);
      {
        /* MATCH: retail SLD line 2479 owns BOTH calls + the scale + the load +
           the fTo store = ONE fused statement, and the computed base needs its
           own block-scoped variable so gcc mutates it in place (oracle
           `addu s0,s0,v0; lw v0,8(s0)`). [05A LAW + 3.12 #14]  7 -> 3. */
        int *bank = (int *)
            ((int)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags +
                        (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta) +
             (**(int (**)(...))(*(int *)((int)Leader + 0x4c) + 0x8c))
                       ((int)Leader + *(short *)(*(int *)((int)Leader + 0x4c) + 0x88)) * 4);
        (pThis->_base_Speaker).fTo = bank[2];
      }
    }
    else {
      Sub = (Speaker *)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta);
      Leader = (Speaker *)0x0;
      (pThis->_base_Speaker).fTo = *(int *)((int)Sub + 4);
    }
    if ((pThis->_base_Speaker).fArrest.flags != 0) {
      pSVar7 = &pThis->fVoice;
      SPCHNFS_C_P_FALSE_ARREST_BULLHORN(pSVar7);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    else {
      reg_a1 = 0;
      if (((pThis->_base_Speaker).fBlockade.flags == 0) && (Leader == (Speaker *)0x0)) {
        dispatchThis = (DispatchSpeaker *)Dispatch__6Speech();
        iVar3 = (*(*(dispatchThis->_base_Speaker)._vf)[0x15].pfn)
                          ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                           (int)(*(dispatchThis->_base_Speaker)._vf)[0x15].delta);
        reg_a1 = (iVar3 < 0x161) ^ 1;
      }
      if (reg_a1 != 0) {
        return;
      }
    }
    pSVar7 = &pThis->fVoice;
    iVar3 = (pThis->_base_Speaker).fTo;
    iVar4 = (pThis->_base_Speaker).fFrom;
    REVINTRO = (MobileSpeaker *)&(pThis->_base_Speaker).fReverse;
    SPCHNFS_C_A_INTRO(pSVar7,iVar3,iVar4,(SPCHNFSType_REVINTRO *)REVINTRO);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    pCVar5 = (Car_tObj *)
             (*(*(pThis->_base_Speaker)._vf)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*(pThis->_base_Speaker)._vf)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
    pCVar5 = (Car_tObj *)
             (*(*(pThis->_base_Speaker)._vf)[0x1b].pfn)
                       ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*(pThis->_base_Speaker)._vf)[0x1b].delta);
    FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar5);
    if ((pThis->_base_Speaker).fArrest.flags != 0) {
      pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fPerpName;
      SPCHNFS_C_D_DURING_FALSE_ARREST(pSVar7,(SPCHNFSType_PERP_NAME *)pCVar5);
    }
    else {
      iVar3 = (*(*(pThis->_base_Speaker)._vf)[0x19].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*(pThis->_base_Speaker)._vf)[0x19].delta);
      if ((*(u_int *)(iVar3 + 0x260) & 0x200) != 0) {
        SPCHNFS_C_D_ENDGAME(pSVar7);
      }
      else {
        uVar6 = (pThis->_base_Speaker).fBlockade.flags;
        if (uVar6 == 1) {
          iVar4 = (pThis->_base_Speaker).fCar;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          SPCHNFS_C_D_SPBLT_FAILED(pSVar7,(SPCHNFSType_COLOUR *)pCVar5,iVar4);
        }
        else if (uVar6 == 2) {
          iVar4 = (pThis->_base_Speaker).fCar;
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          SPCHNFS_C_D_RDBLK_FAILED(pSVar7,(SPCHNFSType_COLOUR *)pCVar5,iVar4);
        }
        else {
          pCVar5 = (Car_tObj *)&(pThis->_base_Speaker).fColour;
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(pSVar7);
          }
          else {
            iVar4 = (pThis->_base_Speaker).fCar;
            REVINTRO = pThis;
            reg_a1 = (pThis->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(pSVar7,(SPCHNFSType_COLOUR *)pCVar5,iVar4,(SPCHNFSType_POSITION *)pThis,
                       reg_a1,&(pThis->_base_Speaker).fDistance,
                       &(pThis->_base_Speaker).fPerpName);
          }
        }
      }
    }
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    (pThis->_base_Speaker).fBlockade.flags = 0;
    (pThis->_base_Speaker).fArrest.flags = 0;
    (pThis->_base_Speaker).fUpdate.flags = 0;
    if (Leader == (Speaker *)0x0) {
      iVar3 = Dispatch__6Speech();
      uVar8 = *(u_int *)(iVar3 + 0x48);
      iVar3 = Dispatch__6Speech();
      *(MobileSpeaker **)(iVar3 + 0x48) = pThis;
      finalDispatch = (DispatchSpeaker *)Dispatch__6Speech();
      (*(*(finalDispatch->_base_Speaker)._vf)[0xe].pfn)
                ((int)&(finalDispatch->_base_Speaker).fPosition.flags +
                 (int)(*(finalDispatch->_base_Speaker)._vf)[0xe].delta);
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
  __vtbl_ptr_type (*pa_Var1) [31];
  int iVar2;
  Car_tObj *pCVar3;

  pa_Var1 = (pThis->_base_Speaker)._vf;
  iVar2 = (*(*pa_Var1)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
  if (iVar2 != 0) {
    *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
    pa_Var1 = (pThis->_base_Speaker)._vf;
    iVar2 = (*(*pa_Var1)[0x1b].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
    if (*(int *)(iVar2 + 300) < 0) {
      pa_Var1 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var1)[0x1e].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
      (pThis->_base_Speaker).fTo = *(int *)(iVar2 + 4);
      SPCHNFS_C_A_INTRO(&pThis->fVoice,(pThis->_base_Speaker).fTo,
                        (pThis->_base_Speaker).fFrom,&(pThis->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      pa_Var1 = (pThis->_base_Speaker)._vf;
      pCVar3 = (Car_tObj *)(*(*pa_Var1)[0x1b].pfn)
                         ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
      FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
      {
        SPCHNFSType_DISTANCE *distance = &(pThis->_base_Speaker).fDistance;
        iVar2 = (pThis->_base_Speaker).fLocation;
        SPCHNFS_C_D_PERP_CRASH_ROLL(&pThis->fVoice,(SPCHNFSType_POSITION *)pThis,
                   iVar2,distance,&(pThis->_base_Speaker).fPerpName);
      }
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      (pThis->_base_Speaker).fAmbulance.flags = 4;
      SPCHNFS_C_D_REQUEST_EMS(&pThis->fVoice,&(pThis->_base_Speaker).fAmbulance);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      goto Catch_dispatchCallback;
    }
    else {
      pa_Var1 = (pThis->_base_Speaker)._vf;
      iVar2 = (*(*pa_Var1)[0x1b].pfn)
                        ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
      if (*(int *)(iVar2 + 0x78c) != 0) {
        pa_Var1 = (pThis->_base_Speaker)._vf;
        iVar2 = (*(*pa_Var1)[0x1e].pfn)
                          ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1e].delta);
        (pThis->_base_Speaker).fTo = *(int *)(iVar2 + 4);
        SPCHNFS_C_A_INTRO(&pThis->fVoice,(pThis->_base_Speaker).fTo,
                          (pThis->_base_Speaker).fFrom,&(pThis->_base_Speaker).fReverse);
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        pa_Var1 = (pThis->_base_Speaker)._vf;
        pCVar3 = (Car_tObj *)(*(*pa_Var1)[0x1b].pfn)
                           ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
        SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
        pa_Var1 = (pThis->_base_Speaker)._vf;
        pCVar3 = (Car_tObj *)(*(*pa_Var1)[0x1b].pfn)
                           ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var1)[0x1b].delta);
        FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,pCVar3);
        {
          SPCHNFSType_DISTANCE *colour = (SPCHNFSType_DISTANCE *)&(pThis->_base_Speaker).fColour;
          iVar2 = (pThis->_base_Speaker).fLocation;
          SPCHNFS_C_D_PERP_CRASH_GEN(&pThis->fVoice,(SPCHNFSType_POSITION *)pThis,
                   iVar2,(SPCHNFSType_COLOUR *)colour,(pThis->_base_Speaker).fCar,
                   &(pThis->_base_Speaker).fDistance,&(pThis->_base_Speaker).fPerpName);
        }
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        (pThis->_base_Speaker).fAmbulance.flags = 0x20;
        SPCHNFS_C_D_REQUEST_EMS(&pThis->fVoice,&(pThis->_base_Speaker).fAmbulance);
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        goto Catch_dispatchCallback;
      }
      else {
        (pThis->_base_Speaker).fArrest.flags = ticket;
        if (ticket == 1) {
          SPCHNFS_C_P_ARRESTED(&pThis->fVoice,&(pThis->_base_Speaker).fArrest);
        }
        else if (ticket == 2) {
          SPCHNFS_C_P_WARNING(&pThis->fVoice,&(pThis->_base_Speaker).fArrest);
        }
        else {
          SPCHNFS_C_P_TICKET(&pThis->fVoice,&(pThis->_base_Speaker).fArrest);
        }
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        if (ticket == 1) {
          SetDelayedStatus__6SpeechPQ26Speech7Speakeri((Speech *)((int)Speech_fgSpeech),&pThis->_base_Speaker,0x60);
        }
        goto Catch_dispatchCallback;
      }
    }
Catch_dispatchCallback:
    {
      int *dispatchThis = (int *)Dispatch__6Speech();
      int dispatchVf = dispatchThis[0x13];
      (**(int (**)(...))(dispatchVf + 0x9c))
                ((int)dispatchThis + *(short *)(dispatchVf + 0x98),pThis->fPerp);
    }
  }
}

/* ---- RoadBlock__Q26Speech13MobileSpeaker  [SPEECH.CPP:2627-2648] SLD-VERIFIED ---- */
void RoadBlock__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Car_tObj *carObj;
  int iVar2;
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_REVINTRO *REVINTRO;
  Speaker *dispatch;
  
  dispatch = (Speaker *)Dispatch__6Speech();
  ctx = (SPCHNFSType_VOICE *)0;
  if (dispatch->fSub != 0) {
    dispatch = (Speaker *)Dispatch__6Speech();
    ctx = (SPCHNFSType_VOICE *)((u_int)ctx <
          ((u_int)dispatch->fSub ^ (u_int)pThis));
  }
  if (ctx != (SPCHNFSType_VOICE *)0) {
    dispatch = (Speaker *)Dispatch__6Speech();
    dispatch = dispatch->fSub;
    pa_Var4 = dispatch->_vf;
    (*(*pa_Var4)[10].pfn)((int)&dispatch->fPosition.flags + (int)(*pa_Var4)[10].delta);
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
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_RDBLK(VOICE);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    (pThis->_base_Speaker).fBlockade.flags = 2;
  }
  return;
}

/* ---- SpikeBelt__Q26Speech13MobileSpeaker  [SPEECH.CPP:2656-2677] SLD-VERIFIED ---- */
void SpikeBelt__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  Car_tObj *carObj;
  int iVar2;
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [31];
  SPCHNFSType_VOICE *ctx;
  SPCHNFSType_VOICE *VOICE;
  SPCHNFSType_REVINTRO *REVINTRO;
  Speaker *dispatch;
  
  dispatch = (Speaker *)Dispatch__6Speech();
  ctx = (SPCHNFSType_VOICE *)0;
  if (dispatch->fSub != 0) {
    dispatch = (Speaker *)Dispatch__6Speech();
    ctx = (SPCHNFSType_VOICE *)((u_int)ctx <
          ((u_int)dispatch->fSub ^ (u_int)pThis));
  }
  if (ctx != (SPCHNFSType_VOICE *)0) {
    dispatch = (Speaker *)Dispatch__6Speech();
    dispatch = dispatch->fSub;
    pa_Var4 = dispatch->_vf;
    (*(*pa_Var4)[11].pfn)((int)&dispatch->fPosition.flags + (int)(*pa_Var4)[11].delta);
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
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_SPBLT(VOICE);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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
  flags = pThis;
  {
    int requestCar = (pThis->_base_Speaker).fCar;
    int requestLocation = (pThis->_base_Speaker).fLocation;
    SPCHNFS_C_D_REQUEST_BKUP(VOICE,COLOUR,requestCar,(SPCHNFSType_POSITION *)flags,requestLocation,
               &(pThis->_base_Speaker).fDistance);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  (pThis->_base_Speaker).fBlockade.flags = 0;
  return;
}

/* ---- Roger__Q26Speech13MobileSpeaker  [SPEECH.CPP:2711-2733] SLD-VERIFIED ---- */
void Roger__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  int iVar2;
  Car_tObj *car;
  SPCHNFSType_VOICE *ctx_00;
  SPCHNFSType_VOICE *VOICE;
  int reg_a1;
  SPCHNFSType_COLOUR *COLOUR;
  int reg_a2;
  SPCHNFSType_CONFIRM *pSVar6;
  int reg_a3;
  
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  bVar1 = false;
  if ((pThis->_base_Speaker).fSub != (Speaker *)0x0) {
    DispatchSpeaker *dispatchStatus = (DispatchSpeaker *)Dispatch__6Speech();
    Speaker *statusSub = (Speaker *)
        (*(*(dispatchStatus->_base_Speaker)._vf)[0x16].pfn)
                  ((int)&(dispatchStatus->_base_Speaker).fPosition.flags +
                   (int)(*(dispatchStatus->_base_Speaker)._vf)[0x16].delta);
    bVar1 = statusSub == (pThis->_base_Speaker).fSub;
  }
  if (bVar1) {
    int *bank;

    VOICE = &pThis->fVoice;
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    ctx_00 = VOICE;
    do {
      bank = (int *)
          ((int)(*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                     ((int)&(pThis->_base_Speaker).fPosition.flags +
                      (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta) +
           (*(*(pThis->_base_Speaker).fSub->_vf)[0x11].pfn)
                     ((int)&(pThis->_base_Speaker).fSub->fPosition.flags +
                      (int)(*(pThis->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
    } while (0);
    pSVar6 = &(pThis->_base_Speaker).fConfirm;
    do {
      do {
        do {
          do {
            do {
              SPCHNFS_C_A_CONFIRM(ctx_00,
                  (pThis->_base_Speaker).fTo = bank[2],pSVar6);
            } while (0);
          } while (0);
        } while (0);
      } while (0);
    } while (0);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    car = (Car_tObj *)
          (*(*(pThis->_base_Speaker)._vf)[0x1b].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags +
                     (int)(*(pThis->_base_Speaker)._vf)[0x1b].delta);
    SetCar__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
    pSVar6 = (SPCHNFSType_CONFIRM *)(pThis->_base_Speaker).fCar;
    COLOUR = &(pThis->_base_Speaker).fColour;
    SPCHNFS_C_C_IN_PURS_NEAR_PERP(VOICE,COLOUR,(int)pSVar6);
  }
  else {
    iVar2 = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                      ((int)&(pThis->_base_Speaker).fPosition.flags +
                       (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta);
    VOICE = &pThis->fVoice;
    COLOUR = *(SPCHNFSType_COLOUR **)(iVar2 + 4);
    pSVar6 = &(pThis->_base_Speaker).fConfirm;
    (pThis->_base_Speaker).fTo = (int)COLOUR;
    SPCHNFS_C_A_CONFIRM(VOICE,(int)COLOUR,pSVar6);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Bullhorn__Q26Speech13MobileSpeaker  [SPEECH.CPP:2741-2748] SLD-VERIFIED ---- */
void Bullhorn__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  *(Car_tObj **)(((int)Speech_fgSpeech) + 0x38c) = pThis->fCarObj;
  SPCHNFS_C_P_BULLHORN_SPEECH(&pThis->fVoice);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Purge__Q26Speech13MobileSpeaker  [SPEECH.CPP:2754-2839] SLD-VERIFIED ---- */
void Purge__Q26Speech13MobileSpeaker(MobileSpeaker *pThis)

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [31];
  int iVar3;
  MobileSpeaker *pMVar4;
  Speaker *Chain;
  Speaker *next;
  
  if (pThis->fCarObj == (Car_tObj *)0x0) {
    return;
  }
  pa_Var2 = (pThis->_base_Speaker)._vf;
  iVar3 = (*(*pa_Var2)[0x19].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags + (int)(*pa_Var2)[0x19].delta);
  if ((*(u_int *)(iVar3 + 0x260) & 0x200) != 0) {
    CopSpeak_Flush();
    if (CopSpeak_gSpchHandle != -1) {
      if (stackSpeedUpEnbabledFlag != 0) {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        SNDstop(CopSpeak_gSpchHandle);
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 1;
      }
      else {
        SNDstop(CopSpeak_gSpchHandle);
      }
    }
    pa_Var2 = (pThis->_base_Speaker)._vf;
    do {
      bVar1 = false;
    } while (0);
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

  pThis->fCarObj = (Car_tObj *)0x0;
  {
    DispatchSpeaker *dispatchStatus = (DispatchSpeaker *)Dispatch__6Speech();
    pMVar4 = (MobileSpeaker *)
             (*(*(dispatchStatus->_base_Speaker)._vf)[0x16].pfn)
                       ((int)&(dispatchStatus->_base_Speaker).fPosition.flags +
                        (int)(*(dispatchStatus->_base_Speaker)._vf)[0x16].delta);
  }
  if (pMVar4 == pThis) {
    DispatchSpeaker *dispatchPurge = (DispatchSpeaker *)Dispatch__6Speech();
    (*(*(dispatchPurge->_base_Speaker)._vf)[0x17].pfn)
        ((int)&(dispatchPurge->_base_Speaker).fPosition.flags +
         (int)(*(dispatchPurge->_base_Speaker)._vf)[0x17].delta);
  }
  Chain = (Speaker *)Dispatch__6Speech();
Purge_findChain:
  next = Chain->fSub;
  if (next == (Speaker *)pThis) {
    goto Purge_unlinkChain;
  }
  if (next == (Speaker *)0x0) {
    return;
  }
  Chain = next;
  goto Purge_findChain;
Purge_unlinkChain:
  Chain->fSub = (pThis->_base_Speaker).fSub;
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
  /* MATCH: re-read `_vf` INLINE at every use (the sibling PASSing fns' idiom).
     A hoisted `pa_Var1 = _vf;` local is a Ghidra artifact: it becomes its own
     pseudo ($v1) so the pfn load can't reuse the vtable base reg -- oracle
     `lw v0,76(s1); lh a0,240(v0); lw v0,244(v0)` (self-temp). 6 -> 0. */
  iVar2 = (*(*(pThis->_base_Speaker)._vf)[0x1e].pfn)
                    ((int)&(pThis->_base_Speaker).fPosition.flags +
                     (int)(*(pThis->_base_Speaker)._vf)[0x1e].delta);
  (pThis->_base_Speaker).fTo = *(int *)(iVar2 + 4);
  car = (Car_tObj *)
        (*(*(pThis->_base_Speaker)._vf)[0x19].pfn)
                  ((int)&(pThis->_base_Speaker).fPosition.flags +
                   (int)(*(pThis->_base_Speaker)._vf)[0x19].delta);
  FindLocation__Q26Speech7SpeakerP8Car_tObj(&pThis->_base_Speaker,car);
  (pThis->_base_Speaker).fSpikeSide.flags = 4;
  /* MATCH: NO pre-branch `VOICE = &pThis->fVoice;` -- hoisting it above the
     `if` made VOICE a pre-branch pseudo (`addiu s1,s0,80` in the bne delay
     slot) and flipped the WHOLE s0<->s1 map (pThis<->VOICE).  Retail keeps
     VOICE local to the taken arm and rematerializes `&pThis->fVoice` straight
     into $a0 for the else arm (reorg then steals that `addiu a0,s1,80` into
     the bne delay slot).  46 -> 6 diffs. */
  if ((pThis->_base_Speaker).fBlockade.flags == 2) {
    VOICE = &pThis->fVoice;
    iVar2 = (pThis->_base_Speaker).fTo;
    ID_UNIT1 = (pThis->_base_Speaker).fFrom;
    REVINTRO = &(pThis->_base_Speaker).fReverse;
    ctx = VOICE;
    SPCHNFS_C_A_INTRO(VOICE,iVar2,ID_UNIT1,REVINTRO);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    SPIKE_BELT_SIDE = (SPCHNFSType_SPIKE_BELT_SIDE *)(pThis->_base_Speaker).fLocation;
    DISTANCE = &(pThis->_base_Speaker).fDistance;
    SPCHNFS_W_D_RDBLK_PLC(VOICE,(SPCHNFSType_POSITION *)pThis,(int)SPIKE_BELT_SIDE,DISTANCE);
  }
  else {
    SPIKE_BELT_SIDE = &(pThis->_base_Speaker).fSpikeSide;
    DISTANCE = (SPCHNFSType_DISTANCE *)(pThis->_base_Speaker).fFrom;
    SPCHNFS_W_D_SPBLT_PLC(&pThis->fVoice,(SPCHNFSType_POSITION *)pThis,SPIKE_BELT_SIDE,(int)DISTANCE,
               (pThis->_base_Speaker).fLocation,&(pThis->_base_Speaker).fDistance);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
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

/* base Speech::Speaker virtual not separately reconstructed (vtable-only ref, surfaced by #75
 * data-materialization); faithful from nfs4-f.exe @0x80099364 = { jr $ra; addiu $v0,$zero,0 }
 * W60-A9: moved here from the file tail to restore retail VA emission order (tu_order_audit
 * inversion: 0x80099364 sits between StatusCount__...DispatchSpeaker and FindClosestLocationTo). */
CallSignBank * CallSign__Q26Speech7Speaker(Speaker *pThis)   /* @0x80099364  CallSign__Q26Speech7Speaker -> NULL */
{
  return (CallSignBank *)0;
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
