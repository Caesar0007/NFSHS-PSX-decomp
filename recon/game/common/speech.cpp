/* game/common/speech.cpp -- RECONSTRUCTED (NFS4 PSX cop speech/dispatch engine; C++ TU)
 *   101 fns across 7 classes (Speech + Speaker/MobileSpeaker/DispatchSpeaker hierarchy +
 *   CarBank/CarBankName/LocationBank helpers) + 4 free C entry points (Speech_AllocateRAM__FlPc/
 *   PurgeRAM/HandleRequest/Server). Retail nested-class linkage is retained by
 *   the exact owner declarations in speech_types.h. Virtual dispatch via _vf[31]. GTE-free.
 */
#include "speech_types.h"
#include "speech_externs.h"

/* Speech static data precedes this TU's literal pools in retail.  Keep the
 * demangled source names while binding the compiler-emitted ABI labels.
 * Storage receipt: this TU is retail -G8 plus -fconserve-space.  Together,
 * .data=0x460 and .sdata=0x2f8 both link byte-exact; all 102 text gates retain
 * their result.  Build wiring is intentionally kept out of this source file. */
Speech *Speech_fgSpeech __asm__("_6Speech_fgSpeech") = 0;
Speaker *Speech_fgUndefined __asm__("_6Speech_fgUndefined") = 0;

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

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
extern "C" {
char *Speech_AllocateRAM(long numBytes,char *message) asm("Speech_AllocateRAM__FlPc");
void Speech_PurgeRAM(char *memPtr) asm("Speech_PurgeRAM__FPc");
long Speech_HandleRequest(long bank,long localoffset,long size,long event)
  asm("Speech_HandleRequest__Fllll");
void Speech_Server(void) asm("Speech_Server__Fv");
CallSignBank *Speech_Speaker_CallSign(Speaker *self) asm("CallSign__Q26Speech7Speaker");
LocationBank *Speech_Speaker_FindClosestLocationTo(Speaker *self, int slice) asm("FindClosestLocationTo__Q26Speech7Speakeri");
CarBank *Speech_Speaker_GetCarBank(Speaker *self, int carIndex) asm("GetCarBank__Q26Speech7Speakeri");
Car_tObj *Speech_Speaker_Perp(Speaker *self) asm("Perp__Q26Speech7Speaker");
void Speech_Speaker_ReActivate(Speaker *self) asm("ReActivate__Q26Speech7Speaker");
Car_tObj *Speech_Speaker_CarObj(Speaker *self) asm("CarObj__Q26Speech7Speaker");
int Speech_Speaker_DistToPerp(Speaker *self) asm("DistToPerp__Q26Speech7Speaker");
void Speech_Speaker_PurgeStatusSub(Speaker *self) asm("PurgeStatusSub__Q26Speech7Speaker");
Speaker *Speech_Speaker_StatusSub(Speaker *self) asm("StatusSub__Q26Speech7Speaker");
int Speech_Speaker_StatusCount(Speaker *self) asm("StatusCount__Q26Speech7Speaker");
bool Speech_Speaker_IsSuper(Speaker *self) asm("IsSuper__Q26Speech7Speaker");
void Speech_Speaker_ClearPerp(Speaker *self, Car_tObj *car) asm("ClearPerp__Q26Speech7SpeakerP8Car_tObj");
bool Speech_Speaker_KnownPerp(Speaker *self, Car_tObj *car) asm("KnownPerp__Q26Speech7SpeakerP8Car_tObj");
int Speech_Speaker_Unit(Speaker *self) asm("Unit__Q26Speech7Speaker");
void Speech_Speaker_Status(Speaker *self) asm("Status__Q26Speech7Speaker");


/* ---- Speech_AllocateRAM__FlPc  [SPEECH.CPP:169-170] SLD-VERIFIED ---- */
char *Speech_AllocateRAM(long numBytes,char *message)

{
  return (char *)reservememadr(message,numBytes,0);
}

/* ---- Speech_PurgeRAM__FPc  [SPEECH.CPP:174-175] SLD-VERIFIED ---- */
void Speech_PurgeRAM(char *memPtr)

{
  purgememadr(memPtr);
  return;
}

/* ---- Speech_HandleRequest__Fllll  [SPEECH.CPP:179-180] SLD-VERIFIED ---- */
long Speech_HandleRequest(long bank,long localoffset,long size,long event)

{
  return Speech::SubmitRequest(bank,localoffset,size);
}

/* ---- SetCar__Q26Speech11CarBankNamei  [SPEECH.CPP:234-246] SLD-VERIFIED ---- */
} /* extern "C" */

void CarBankName::SetCar(int carIndex)

{
  char *game;
  Speech_tCarDescription *d;

  game = GameSetup_gCarNames[GameSetup_gData.carInfo[carIndex].carType];
  d = Speech_gCarDescription;
  while ((d->game != (char *)0x0 &&
         strncmp(game,d->game,4) != 0)) {
    d = d + 1;
  }
  this->fFull = d->full;
  this->fMake = d->make;
  this->fModel = d->model;
  return;
}

/* ---- Check__Q26Speech7CarBankPciPQ26Speech11CarBankName  [SPEECH.CPP:257-275] SLD-VERIFIED ---- */
bool CarBank::Check(char *name,int id,CarBankName *bankname)

{
  bool match;
  
  match = false;
  if (bankname->Full(name)) {
    this->fFull = id;
    match = true;
  }
  if (bankname->Make(name)) {
    this->fMake = id;
    match = true;
  }
  if (bankname->Model(name)) {
    this->fModel = id;
    match = true;
  }
  return match;
}

/* ---- CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName  [SPEECH.CPP:281-295] SLD-VERIFIED ---- */
bool Speech::CheckCarBank(CarBank *carbank,char *name,int id,CarBankName *bankname)

{
  bool match;
  int i;

  match = false;
  for (i = 0; i < this->fCarCount; i++) {
    if (carbank[i].Check(name,id,&bankname[i])) {
      match = true;
    }
  }
  return match;
}

inline void Speaker::SetColour(int Colour)
{
  if (Speech_fgSpeech->fMultiplePerps != 0) {
    this->fColour.flags = Colour;
  }
  else {
    this->fColour.flags = Colour | 0x78020;
  }
}

/* ---- SetCar__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:301-373] SLD-VERIFIED ---- */
void Speaker::SetCar(Car_tObj *car)

{
  /* SYM-INLINE-LOCAL: Colour = SetColour */
  int carcolour;
  
  carcolour = 1 << car->carInfo->SpeechColour;
  if (this->VirtualGetCarBank(car->carIndex)->fFull == -1) {
    this->ClearCar();
  }
  else {
    this->SetColour(carcolour);
    if (Speech::Dispatch()->VirtualKnownPerp(car)) {
      this->fCar = this->VirtualGetCarBank(car->carIndex)->fModel;
    }
    else {
      this->fCar = this->VirtualGetCarBank(car->carIndex)->fFull;
    }
  }
  return;
}

/* ---- CountLocations__6Speech  [SPEECH.CPP:521-534] SLD-VERIFIED ---- */
void Speech::CountLocations()

{
  Speech_tLocationDescription *d;
  
  this->fLocationCount = 0;
  d = Speech_gLocationDescription[GameSetup_gData.track];
  if (d != (Speech_tLocationDescription *)0x0) {
    while (d->name != (char *)0x0) {
      d = d + 1;
      if (0xf < this->fLocationCount) {
        return;
      }
      this->fLocationCount = this->fLocationCount + 1;
    }
  }
  return;
}

/* ---- CheckLocationBank__6SpeechPQ26Speech12LocationBankPci  [SPEECH.CPP:539-561] SLD-VERIFIED ----
 * SOURCE PASS 65/65 (2026-08-24).  SYM records only `match`, description `d`,
 * and loop `i`.  The nested SLD `bankid`/`name` records belong to the inlined
 * `LocationBank::Set`; evaluating its arguments before the four member stores
 * naturally reproduces retail's three-load/four-store batch. */
bool Speech::CheckLocationBank(LocationBank *locationbank,char *name,int id)

{
  /* SYM-INLINE-LOCAL: bankid = Set
     SYM-INLINE-LOCAL: name = Set */
  bool match;
  Speech_tLocationDescription * d;
  int i;
  
  d = Speech_gLocationDescription[GameSetup_gData.track];
  match = 0;
  if (d == (Speech_tLocationDescription *)0x0) {
    match = 0;
  }
  else {
    for (i = 0; i < this->fLocationCount; i = i + 1) {
      if (strncmp(name,d->name,strlen((u_long)d->name)) == 0) {
        match = 1;
        locationbank[i].Set(d->start,d->end,id,d->name);
      }
      d = d + 1;
    }
  }
  return match;
}

/* ---- Distance__Q26Speech12LocationBanki  [SPEECH.CPP:567-587] SLD-VERIFIED ---- */
int LocationBank::Distance(int slice)

{
  /* SYM-CODEGEN-CARRIER: start -- optimized field snapshot; its retail source
     spelling is not recoverable from the zero-local SLD record.
     SYM-CODEGEN-CARRIER: end -- paired optimized field snapshot.
     SYM-CODEGEN-CARRIER: forward -- cross-branch circular-distance quantity.
     SYM-CODEGEN-CARRIER: backward -- shared minimum-tail quantity.
     Receipt: removing all four gives 36/37 instructions and 19 diffs; keeping
     only forward/backward gives 39/37 and 26 diffs; this form is 37/37. */
  int start;
  int end;
  int forward;
  int backward;

  start = this->fStartSlice;
  end = this->fEndSlice;
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
LocationBank *Speech::FindClosestLocationTo(LocationBank *bank,int slice)

{
  int distance;
  LocationBank *locationbank;
  int i;
  int closestdistance;
  LocationBank *closestbank;
  
  if (this->fLocationCount != 0) {
    closestbank = (LocationBank *)0x0;
    closestdistance = 10000;
    i = 0;
    while (1) {
      if (this->fLocationCount <= i) break;
      locationbank = &bank[i];
      if (locationbank->fBankId != -1) {
        distance = locationbank->Distance(slice);
        if (distance < closestdistance) {
          closestdistance = distance;
          closestbank = locationbank;
        }
      }
      i++;
    }
    return closestbank;
  }
  return (LocationBank *)0x0;
}

/* ---- FindLocation__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:624-788] SLD-VERIFIED ---- */
void Speaker::FindLocation(Car_tObj *car)

{
  int slice;
  LocationBank *location;

  /* SYM-CODEGEN-CARRIER: advance
     SYM-CODEGEN-CARRIER: offset
     These single-use spellings preserve retail GCC's quantity lifetimes;
     direct substitution makes the function two instructions longer and
     changes 92 oracle instructions. */
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
            (*(*this->_vf)[0x1d].pfn)
                      ((int)&(this->fPosition).flags + (int)(*this->_vf)[0x1d].delta,slice);
  if (location == (LocationBank *)0x0) {
    (this->fDistance).flags = 0;
    (this->fPosition).flags = 0;
    /* Retail preserves the null LocationBank::fBankId read at address 8. */
    *(SPCHNFSType_POSITION *)&this->fLocation = *(SPCHNFSType_POSITION *)8;
  }
  else {
    int actual = location->Distance((int)car->N.simRoadInfo.slice);
    int distance = location->Distance(slice);

    if (distance == 0) {
      (this->fDistance).flags = 0;
      (this->fPosition).flags = 4;
    }
    else if ((double)distance < 100.0 / 3.0) {
      (this->fDistance).flags = 0;
      if (distance + 2 < actual) {
        (this->fPosition).flags = 9;
      }
      if (distance - 2 < actual) {
        (this->fPosition).flags = 8;
      }
      else {
        (this->fPosition).flags = 2;
      }
    }
    else if (GameSetup_gData.measurement == 1) {
      if (distance < 0xa6) {
        (this->fDistance).flags = 8;
        if (distance - 2 < actual) {
          (this->fPosition).flags = 0x10;
        }
        else {
          (this->fPosition).flags = 2;
        }
      }
      else {
        (this->fDistance).flags = 0x10;
        if (distance - 2 < actual) {
          (this->fPosition).flags = 0x10;
        }
        else {
          (this->fPosition).flags = 2;
        }
      }
    }
    else if (distance < 0x86) {
      (this->fDistance).flags = 1;
      if (distance - 2 < actual) {
        (this->fPosition).flags = 0x10;
      }
      else {
        (this->fPosition).flags = 2;
      }
    }
    else if (distance < 0x10c) {
      (this->fDistance).flags = 2;
      if (distance - 2 < actual) {
        (this->fPosition).flags = 0x10;
      }
      else {
        (this->fPosition).flags = 2;
      }
    }
    else {
      (this->fDistance).flags = 4;
      if (distance - 2 < actual) {
        (this->fPosition).flags = 0x10;
      }
      else {
        (this->fPosition).flags = 2;
      }
    }
    this->fLocation = location->fBankId;
  }
  return;
}

/* ---- CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci  [SPEECH.CPP:852-884] SLD-VERIFIED ---- */
bool Speech::CheckCallSignBank(CallSignBank *bank,char *name,int id)

{
  /* SYM-INLINE-LOCAL: bankid = SetAllUnits
     SYM-INLINE-LOCAL: bankid = SetDispatch
     SYM-INLINE-LOCAL: unit = SetMobile
     SYM-INLINE-LOCAL: bankid = SetMobile */
  bool match;
  Speech_tCallSignDescription * d;
  int dispatchName;
  int i;
  
  d = Speech_gCallSignDescription;
  /* MATCH: retail sets the match flag INSIDE each branch (`li s3,1` per arm),
     it does NOT build a combined `a==0 || b==0` boolean -- the combined form
     keeps both strncmp results live to the join and rotates the whole s-map.
     80 -> 35 diffs. */
  match = false;
  if (strncmp(name,d->AllUnits,strlen((u_long)d->AllUnits)) == 0) {
    bank->SetAllUnits(id);
    match = true;
  }
  dispatchName = GameSetup_gData.track % 5;
  if (strncmp(name,d->Dispatch[dispatchName],
              strlen((u_long)d->Dispatch[dispatchName])) == 0) {
    bank->SetDispatch(id);
    match = true;
  }
  /* MATCH: `i` is born in the for-init, not before the 2nd guard (oracle sets it
     in the `bnez` delay slot AFTER the guard).  35 -> 34, count now exact. */
  i = 0;
  while (true) {
    if (0xf <= i) break;
    /* W57-A8 3.12#1 + 07C: BOTH walks are index forms in retail (`bank[i+2]` and
       `Speech_gCallSignDescription[0].Mobile[i]` -> one giv each), and the loop is
       UN-ROTATED (`while(true){ if(N<=i) break; ... }`) -- a `for` lets gcc prove
       entry and rotate the test to the bottom. 34 -> PASS. */
    if (strncmp(name,d->Mobile[i],strlen((u_long)d->Mobile[i])) == 0) {
      bank->SetMobile(i,id);
      match = true;
    }
    i = i + 1;
  }
  return match;
}

/* ---- CheckMultiBank__6SpeechPciPQ26Speech11CarBankName  [SPEECH.CPP:889-924] SLD-VERIFIED ---- */
bool Speech::CheckMultiBank(char *name,int id,CarBankName *bn)

{
  if (strncmp(name,"j:id\\",5) == 0) {
    return this->CheckCallSignBank(&this->fCallSignBank.Dispatch,name + 5,id);
  }
  if (strncmp(name,"j:cars\\",7) == 0) {
    return this->CheckCarBank(this->fCarBank.Dispatch,name + 7,id,bn);
  }
  if (strncmp(name,"j:location\\",0xb) == 0) {
    return this->CheckLocationBank(this->fLocationBank.Dispatch,name + 0xb,id);
  }
  if (strncmp(name,"j:cid\\",6) == 0) {
    return this->CheckCallSignBank(&this->fCallSignBank.Mobile,name + 6,id);
  }
  if (strncmp(name,"j:ccars\\",8) == 0) {
    return this->CheckCarBank(this->fCarBank.Mobile,name + 8,id,bn);
  }
  if (strncmp(name,"j:clocaton\\",0xb) == 0) {
    return this->CheckLocationBank(this->fLocationBank.Mobile,name + 0xb,id);
  }
  if (strncmp(name,"j:clip.",7) == 0) {
    this->fBlpClpBank = id;
  }
  else {
    if (strncmp(name,"j:silenc.",9) != 0) {
      return 1;
    }
    this->fStaticBank = id;
  }
  return 1;
}

/* ---- CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3  [SPEECH.CPP:931-984] SLD-VERIFIED ---- */
int Speech::CalculateBankSize(char *header,CarBankName *bn,long *hoffset,long *hsize)

{
  /* The line-15/22/33 SLD scopes are the four inline member expansions below.
     ReadBE32 is expanded once for filecount and twice for each directory row;
     IsHeader is expanded for the four trailing filename characters.  Fully
     inlined function names have no surviving linkage, so these spellings are
     source-shape inferences; the receiver/locals and byte operations are
     proved by SYM plus the exact retail instruction stream.
     SYM-INLINE-THIS: ReadBE32
     SYM-INLINE-THIS: ReadBE32
     SYM-INLINE-THIS: ReadBE32
     SYM-INLINE-LOCAL: p = ReadBE32
     SYM-INLINE-LOCAL: p = ReadBE32
     SYM-INLINE-LOCAL: a = ReadBE32
     SYM-INLINE-LOCAL: a = ReadBE32
     SYM-INLINE-LOCAL: a = ReadBE32
     SYM-INLINE-LOCAL: b = ReadBE32
     SYM-INLINE-LOCAL: b = ReadBE32
     SYM-INLINE-LOCAL: b = ReadBE32
     SYM-INLINE-LOCAL: c = ReadBE32
     SYM-INLINE-LOCAL: c = ReadBE32
     SYM-INLINE-LOCAL: c = ReadBE32
     SYM-INLINE-LOCAL: d = ReadBE32
     SYM-INLINE-LOCAL: d = ReadBE32
     SYM-INLINE-LOCAL: d = ReadBE32
     SYM-INLINE-THIS: IsHeader
     SYM-INLINE-LOCAL: a = IsHeader
     SYM-INLINE-LOCAL: b = IsHeader
     SYM-INLINE-LOCAL: c = IsHeader
     SYM-INLINE-LOCAL: d = IsHeader */
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

    c = header + 0x10;
    bsize = size;
    filecount = this->ReadBE32(header + 8);
    i = 0;
    while (i < filecount) {
      char *name;

      offset = this->ReadBE32(c);
      size = this->ReadBE32(c + 4);
      name = c + 8;
      c = name;
      while (*c != '\0') {
        c++;
      }
      if (this->IsHeader((u_char)c[-4], (u_char)c[-3],
                         (u_char)c[-2], (u_char)c[-1], '.', 'h', 'd')) {
        if (*hoffset == 0) {
          *hoffset = offset;
        }
        *hsize = offset + size - *hoffset;
        if (this->CheckMultiBank(name,bcount,bn)) {
          bcount++;
          bsize += size;
        }
      }
      c++;
      i++;
    }
  }
  this->fBankCount = bcount;
  return bsize;
}

extern "C" {

/* ---- LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell  [SPEECH.CPP:990-1102] SLD-VERIFIED ----
 * MATCH, strict source-only PASS 270/270 (2026-08-24). */
/* MATCHING-RECEIPT (2026-08-14): detailed verify_asm 137 -> 133 -> 119 -> 97
 * -> 62 -> 51 -> 31 -> 13 -> 11 -> 9 -> 6, with the final source stream count-
 * and register-exact at 270/270.  IDA's gold allocation and the SLD expose a
 * compiler-created lagging cursor in $s2: retain source `p`, but read the first
 * offset byte from `c` before advancing it.  Inline suffix predicates reproduce
 * both retail comparison webs; the first result needs the priced +2-ref empty
 * fence (allocsim p163 6->8 refs) to land in $v1.  In the fallback, direct
 * `banknames[j]`/`fBankOffset[j]` indexing plus `++j` in the loop condition
 * produces the retail induction webs without extra source walkers.
 *
 * Follow-up (2026-08-24): a persistent reserve string plus a short tied alias,
 * tied header/hsize/alignment call operands, and a read-only hsize fence after
 * the bank-name zeroing loop price the retail saved-register handout exactly and
 * reduce the source-only residual 6 -> 4.  Tying the alignment output directly
 * to literal input `"3"(0x10)` then births `li a2,16` at reload time and fixes
 * the call-argument group, reducing 4 -> 2.  Fresh sched2 dumps show the final
 * lbu and stack lw at equal priority in T-31; GCC's dependency/LUID tie selects
 * the stack load first in reverse scheduling, yielding their remaining forward
 * swap.  The late fence is a measured global-
 * allocation live-range dial; placing it at function tail spills hsize (16), and
 * omitting it leaves the s2/s3 handout swapped (20).  Splitting the operand fence
 * can place `li a2,16` exactly, but perturbs later local allocation and grows the
 * stream to 272/273 instructions (76-117 diffs), so those basins were reverted.
 * A tied `+m(size)` lands the retail lw/lbu order at 270/270, but swaps the
 * header/string saved webs (36); bounded late-ref pricing reached 22/16/6/4 but
 * never PASS, while any second asm node grew the stream to 272-274.  All were
 * reverted.
 *
 * W77-root strict closure: promote size to a tied dataSize output; the
 * user-authorized zero-byte $2 clobber forces retail $v1.  Replacing the tied
 * header output with two read-only header references recovers the $s0/$s1
 * handout, and ordering the header increment before the data update gives the
 * retail ready-list order.  Detailed strict gate PASS 270/270; no post-cc1
 * rewrite. */
} /* extern "C" */

void Speech::LoadBankHeaders(char *header,CarBankName *bn,long hoffset,long hsize)

{
  /* SYM-CODEGEN-CARRIER: reserveArg -- persistent literal web required by
     the two reserve calls in the exact saved-register allocation.
     SYM-CODEGEN-CARRIER: reserveCallArg -- tied short-lived call alias.
     SYM-CODEGEN-CARRIER: reserveBytes -- tied hsize allocator input.
     SYM-CODEGEN-CARRIER: alignment -- tied literal 0x10 allocator input.
     SYM-CODEGEN-CARRIER: dataSize -- tied copy of size forced to retail $v1.
     SYM-CODEGEN-CARRIER: extension -- the twice-priced suffix result is a
     distinct retail quantity; folding it into isheader gives 266/270.
     SYM-CODEGEN-CARRIER: isheader -- retail keeps a separate $s0 accepted-bank
     flag; merging it with extension removes four instructions.
     SYM-INLINE-THIS: IsHeader
     SYM-INLINE-LOCAL: a = IsHeader
     SYM-INLINE-LOCAL: b = IsHeader
     SYM-INLINE-LOCAL: c = IsHeader
     SYM-INLINE-LOCAL: d = IsHeader
     SYM-INLINE-THIS: IsData
     SYM-INLINE-LOCAL: a = IsData
     SYM-INLINE-LOCAL: b = IsData
     SYM-INLINE-LOCAL: c = IsData
     SYM-INLINE-LOCAL: d = IsData */
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
  data = (char *)this->fBankOffset + this->fBankCount * 4;
  locatebigentry(header,"j:eventdat\\event.dat",0,&offset,(int)&size);
  FILE_readsync(this->fFileHandle,offset,data,size,100);
  SPCH_ResolveData((VoxEventDat *)data);
  c = header + 0x10;
  {
    char *reserveArg = "spch temp";
    char *reserveCallArg = reserveArg;
    long reserveBytes = hsize;
    int alignment;

    long dataSize;
    /* Price the retail saved-register webs and force the tied size value into
     * $v1 without emitting an instruction; the duplicate header reads are
     * intentional allocator inputs. */
    __asm__("" : "=r"(dataSize), "=r"(reserveCallArg),
                   "=r"(reserveBytes), "=r"(alignment)
               : "0"(size), "1"(reserveCallArg), "2"(reserveBytes),
                 "3"(0x10), "r"(header), "r"(header)
               : "$2");
    {
      int a = (u_char)header[8];
      header += 8;
      data += dataSize;
      int b = (u_char)header[1];
      int c = (u_char)header[2];
      int d = (u_char)header[3];

      filecount = (((a << 8 | b) << 8 | c) << 8 | d);
    }
    hdata = (char *)reservememadr(reserveCallArg,reserveBytes,alignment);
    FILE_readsync(this->fFileHandle,hoffset,hdata,hsize,100);
    banknames = (char **)reservememadr(reserveArg,this->fBankCount << 2,0x10);
  }
  {
    int j;

    for (j = 0; j < this->fBankCount; j++) {
        banknames[j] = 0;
        this->fBankOffset[j] = 0;
      }
  }
  __asm__("" : : "r"(hsize));
  {
    int i;

    p = c;
    for (i = 0; i < filecount; i++) {
    char *name;
    int namelen;
    bool isheader;
    int a;

    systemtask(0);
    a = (u_char)*c;
    c += 8;
    name = c;
    namelen = 0;
    {
      {
        int b = (u_char)p[1];
        int c = (u_char)p[2];
        int d = (u_char)p[3];

        offset = (((a << 8 | b) << 8 | c) << 8 | d);
      }
      {
        int a = (u_char)p[4];
        int b = (u_char)p[5];
        int c = (u_char)p[6];
        int d = (u_char)p[7];

        size = (((a << 8 | b) << 8 | c) << 8 | d);
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
      bool extension = this->IsHeader((u_char)p[-4], (u_char)p[-3],
                                      (u_char)p[-2], (u_char)p[-1],
                                      '.', 'h', 'd');
      __asm__("" : : "r"(extension), "r"(extension));
      if (extension && this->CheckMultiBank(name,id,bn)) {
        isheader = true;
      }
      if (isheader) {
        id++;
        memcpy(data,hdata + offset - hoffset,size);
        banknames[SPCH_AddBank((VoxBank *)data)] = name;
        data += size;
      }
      else {
        if (this->IsData((u_char)p[-4], (u_char)p[-3],
                         (u_char)p[-2], (u_char)p[-1], '.', 'd', 'a')) {
          if ((dt < this->fBankCount) && (banknames[dt] != 0) &&
              (strncmp(name,banknames[dt],namelen - 3) == 0)) {
            this->fBankOffset[dt++] = offset;
          }
          else {
            int j = 0;

            if (0 < this->fBankCount) {
              do {
                if ((banknames[j] != 0) &&
                    (strncmp(name,banknames[j],namelen - 3) == 0)) {
                  this->fBankOffset[j] = offset;
                  dt = j + 1;
                }
              } while (++j < this->fBankCount);
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

  /* SYM-CODEGEN-CARRIER: dispatch -- materializes the result of the implicit
     DispatchSpeaker construction represented explicitly by this recovered
     class model.  Re-reading fDispatch adds two instructions and changes 14. */
  DispatchSpeaker *dispatch =
      (DispatchSpeaker *)__builtin_new(sizeof(DispatchSpeaker));
  dispatch->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])Speaker_vtable;
  dispatch->_base_Speaker.fSub = 0;
  dispatch->_base_Speaker._vf = (__vtbl_ptr_type (*)[31])DispatchSpeaker_vtable;
  fDispatch = dispatch;

  for (int i = 0; i < 4; i++) {
    /* SYM-CODEGEN-CARRIER: mobile -- materializes the result of the implicit
       MobileSpeaker construction.  Re-reading fMobile[i] adds four
       instructions and changes 28 instructions. */
    MobileSpeaker *mobile =
        (MobileSpeaker *)__builtin_new(sizeof(MobileSpeaker));
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
    bn[i].SetCar(i);

  this->CountLocations();
  fBankCount = 0;
  banksize = 0;
  switch (GameSetup_gData.languageSpeech) {
  case 2:
    SpeechLanguage = "fre";
    break;
  case 1:
    SpeechLanguage = "ger";
    break;
  case 6:
    SpeechLanguage = "brt";
    break;
  default:
    SpeechLanguage = "eng";
    break;
  }

  sprintf(filename, "%szzzz%s.viv", Paths_Paths[0x1d], SpeechLanguage);
  header = (char *)loadbigfileheader(filename, (void *)0x10);
  hoffset = 0;
  hsize = 0;
  if (header)
    banksize = this->CalculateBankSize(header, bn, &hoffset, &hsize);
  if (banksize > 0)
    fBankOffset = (long *)reservememadr("spch index", fBankCount * 4 + banksize, 0);
  if (fBankOffset) {
    SPCH_Init(Speech_HandleRequest, 0x12345678,
              SPCH_GetSampleDataRate(0x2b11, 0x10, 2));
    SPCH_InitBankMem(Speech_AllocateRAM, Speech_PurgeRAM, fBankCount);
    fFileOpen = FILE_opensync(filename, 1, 100, (int)&fFileHandle) != 0;
    this->LoadBankHeaders(header, bn, hoffset, hsize);
  }
  if (header)
    purgememadr(header);
  gettick();
}

/* ---- Reset__6Speech  [SPEECH.CPP:1248-1261] SLD-VERIFIED ---- */
void Speech::Reset(void)

{
  int i;
  
  if (Speech_fgSpeech != (Speech *)0x0) {
    i = 0;
    while (true) {
      if (i >= 4)
        break;
      Speech_fgSpeech->fMobile[i]->fCarObj = (Car_tObj *)0x0;
      i++;
    }
    SPCH_ClearEventQueue();
    randtemp = fastRandom * randSeed;
    fastRandom = randtemp & 0xffff;
    iSPCH_EACseedrandom((randtemp & 0xffff00) >> 8);
    Speech_fgSpeech->fCopCount =
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 9;
    Speech_fgSpeech->fSuperCount =
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 6;
    Speech_fgSpeech->fDispatch->Activate(
        (randtemp = fastRandom * randSeed,
         fastRandom = randtemp & 0xffff,
         (randtemp & 0xffff00) >> 8) % 7);
  }
  return;
}

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

/* ---- BankPatch__6SpeechlP8Car_tObj  [SPEECH.CPP:1297-1307] SLD-VERIFIED ---- */
int Speech::BankPatch(long bank,Car_tObj *car)

{
  if (bank == this->fStaticBank) {
    return 0x15;
  }
  if (bank == this->fBlpClpBank) {
    if (car == (Car_tObj *)0) {
      return 0x13;
    }
    return 0x14;
  }
  return 0xffffffff;
}

/* ---- SubmitRequest__6Speechlll  [SPEECH.CPP:1317-1342] SLD-VERIFIED ----
 * W63-A10 DUAL-LANE SEAL (gate PASS 61/61 + psyqproof REAL=0).  The gate had
 * read PASS since W59 but the PRODUCTION lane scored REAL=1 on word 43 and
 * brdist.py flagged branch 6 at distance -2 where retail has +8: our
 * `beq $16,$0` guard (the `offset != 0` test) jumped BACKWARD onto the FIRST
 * arm's copy of the return tail instead of forward onto its OWN copy.  Both
 * are semantically identical (each tail is `addu v0,s0,s2; j <epilogue>`), so
 * verify_asm -- which normalises every branch TARGET -- could never see it.
 * MECHANISM (gcc-2.8.1 jump.c, read off the -dj/-dJ dumps of this fn):
 *   the final `jump_optimize (insns, cross_jump=1, ...)` (toplev.c:3548)
 *   pairs the two `j <epilogue>` insns via the jump_chain loop (jump.c:2148)
 *   and calls find_cross_jump(e1=2nd j, e2=1st j, minimum=2).  The walk back
 *   from e1 matches ONE insn (the shared `addu v0,s0,s2`, minimum 2->1) and
 *   then hits the CODE_LABEL that ends the inner `if (offset != 0)`; jump.c
 *   2568-2573 spends a FREE `--minimum` on any CODE_LABEL in stream 1, so
 *   minimum reaches 0 and do_cross_jump fires on a ONE-insn tail: it plants a
 *   label before the first arm's `addu`, redirects the 2nd `j` there and
 *   DELETES our `addu`; jump tensioning then folds the `beq` onto that same
 *   label, and reorg re-steals the first arm's `addu` back into the delay
 *   slot -- which is why the instruction STREAM still matches retail exactly
 *   and only the branch WORD differs.
 * CURE (zero insns, pin-free): a void fence between that label and the
 *   duplicated tail.  jump.c:2632-2635 sets `lose = 1` for an ASM_OPERANDS
 *   with MEM_VOLATILE_P, so the match dies BEFORE the label bonus is reached
 *   and neither arm is cross-jumped.  61/61 unchanged, TU 99/102 unchanged.
 * FALSIFIED first (both left word 43 at 1200fffd): the same fence placed
 *   after `CopSpeak_GenericBankRequest` in the THEN arm (it sits outside the
 *   compared range -- the walk from the 2nd `j` never reaches it), and
 *   dropping the `else` so both returns are at statement level.
 * REUSABLE: any function with N duplicated `return <expr>;` tails where one
 *   of them is preceded by an end-of-inner-if label is exposed to this
 *   gate-invisible redirect.  brdist.py is the screen; the fence is the cure. */
/* ---- SubmitRequest__6Speechlll ---- */
long Speech::SubmitRequest(long bank,long localoffset,long size)

{
  /* SYM-INLINE-THIS: BankOffset
     SYM-INLINE-LOCAL: bank = BankOffset
     SYM-INLINE-THIS: FileHandle
     The helper spellings are source-shape inferences: SYM proves their
     receivers/parameter scopes and the retail body proves their operations,
     but fully inlined functions have no surviving linkage name. */
  Car_tObj *car;
  int patch;
  long offset;

  if (Speech_fgSpeech != 0) {
    Speech_fgSpeech->fDispatch->fStatusSub = 0;
    Speech_fgSpeech->fDispatch->fStatusCount = 0x200;
    car = Speech_fgSpeech->fSpeakerCar;
    patch = Speech_fgSpeech->BankPatch(bank,car);
    offset = Speech_fgSpeech->BankOffset(bank);
    __asm__("" : "=r"(offset) : "0"(offset));
    if (patch >= 0) {
      CopSpeak_GenericBankRequest(patch,car);
      return offset + localoffset;
    }
    else {
      if (offset != 0) {
        CopSpeak_DirectRequest(Speech_fgSpeech->FileHandle(),
                               offset + localoffset,size,car,0);
      }
      /* MATCH: cross_jump un-merger -- see the header block.  jump.c's free
         `--minimum` for the end-of-if CODE_LABEL lets do_cross_jump redirect
         this arm's one-insn return tail onto the other arm's copy; a volatile
         asm here makes find_cross_jump lose before that.  Zero insns. */
      /* W85-S2: an INERT zero-insn fence was deleted here -- measured 102/102
         PASS alone and as the pair {SubmitRequest, MobileSpeaker::Lose}. */
      return offset + localoffset;
    }
  }
  return 0;
}

/* ---- Report__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1352-1356] SLD-VERIFIED ---- */
void Speaker::Report(Car_tObj *cop)

{
  return;
}

/* ---- Deny__Q26Speech7Speaker  [SPEECH.CPP:1363-1367] SLD-VERIFIED ---- */
void Speaker::Deny()

{
  return;
}

/* ---- Grant__Q26Speech7Speaker  [SPEECH.CPP:1371-1375] SLD-VERIFIED ---- */
void Speaker::Grant()

{
  return;
}

/* ---- Ready__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1379-1383] SLD-VERIFIED ---- */
void Speaker::Ready(Car_tObj *wing)

{
  return;
}

/* ---- Engage__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1394-1398] SLD-VERIFIED ---- */
void Speaker::Engage(Car_tObj *perp)

{
  return;
}

/* ---- Lose__Q26Speech7Speaker  [SPEECH.CPP:1402-1406] SLD-VERIFIED ---- */
void Speaker::Lose()

{
  return;
}

/* ---- Accident__Q26Speech7Speakeri  [SPEECH.CPP:1410-1414] SLD-VERIFIED ---- */
void Speaker::Accident(int slice)

{
  return;
}

/* ---- Catch__Q26Speech7Speakeri  [SPEECH.CPP:1418-1422] SLD-VERIFIED ---- */
void Speaker::Catch(int ticket)

{
  return;
}

/* ---- RoadBlock__Q26Speech7Speaker  [SPEECH.CPP:1426-1430] SLD-VERIFIED ---- */
void Speaker::RoadBlock()

{
  return;
}

/* ---- SpikeBelt__Q26Speech7Speaker  [SPEECH.CPP:1434-1438] SLD-VERIFIED ---- */
void Speaker::SpikeBelt()

{
  return;
}

/* ---- Backup__Q26Speech7Speaker  [SPEECH.CPP:1442-1446] SLD-VERIFIED ---- */
void Speaker::Backup()

{
  return;
}

/* ---- ReportBlockade__Q26Speech7Speaker  [SPEECH.CPP:1450-1454] SLD-VERIFIED ---- */
void Speaker::ReportBlockade()

{
  return;
}

/* ---- Roger__Q26Speech7Speaker  [SPEECH.CPP:1459-1463] SLD-VERIFIED ---- */
void Speaker::Roger()

{
  return;
}

/* ---- Bullhorn__Q26Speech7Speaker  [SPEECH.CPP:1467-1471] SLD-VERIFIED ---- */
void Speaker::Bullhorn()

{
  return;
}

/* ---- Purge__Q26Speech7Speaker  [SPEECH.CPP:1475-1479] SLD-VERIFIED ---- */
void Speaker::Purge()

{
  return;
}

/* ---- Promote__Q26Speech7Speaker  [SPEECH.CPP:1490-1503] SLD-VERIFIED ---- */
void Speaker::Promote()

{
  Speaker *Super;
  Speaker *Sub;
  /* SYM-CODEGEN-CARRIER: cont -- GCC's materialized conjunction reproduces
     the retail loop; the direct disjunction is four instructions shorter and
     changes 14 oracle instructions. */
  int cont;

  Super = (Speaker *)Speech::Dispatch();
  for (;;) {
    Sub = Super->fSub;
    cont = Sub != (Speaker *)0x0 && Sub != this;
    if (!cont) break;
    Super = Sub;
  }
  Super->fSub = this->fSub;
  this->fSub = Speech::Dispatch()->fSub;
  Speech::Dispatch()->fSub = this;
}

/* ---- Speech_Server__Fv  [SPEECH.CPP:1539-1540] SLD-VERIFIED ---- */
extern "C" {

void Speech_Server(void)

{
  Speech::Dispatch()->VirtualStatus();
}

/* ---- SetDelayedStatus__6SpeechPQ26Speech7Speakeri  [SPEECH.CPP:1546-1548] SLD-VERIFIED ---- */
} /* extern "C" */

void Speech::SetDelayedStatus(Speaker *sub,int delay)

{
  Speech_fgSpeech->fDispatch->fStatusSub = sub;
  Speech_fgSpeech->fDispatch->fStatusCount = delay;
}

/* ---- Activate__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:1554-1571] SLD-VERIFIED ---- */
void DispatchSpeaker::Activate(int seedupdatecount)

{
  int i;
  /* SYM-CODEGEN-CARRIER: iVar1 -- holds the inlined virtual CallSign result,
     then is reused for GameSetup.track.  Direct member chaining grows the
     function from 39 to 43 instructions and changes 60 instructions. */
  int iVar1;

  iVar1 = (int)(this->_base_Speaker).VirtualCallSign();
  i = 1;
  (this->_base_Speaker).fFrom = ((CallSignBank *)iVar1)->fDispatch;
  iVar1 = GameSetup_gData.track;
  (this->_base_Speaker).fConfirm.flags = 0xff;
  (this->_base_Speaker).fPerpName.flags = 0xf;
  (this->_base_Speaker).fSub = (Speaker *)0x0;
  (this->_base_Speaker).fReverse.flags = iVar1 & 1;
  for (; i >= 0; i--)
    this->fPerp[i] = (Car_tObj *)0x0;
  this->fStatusCount = 0x200;
  this->fStatusSub = (Speaker *)0x0;
  this->fUpdateCount = seedupdatecount;
  (this->_base_Speaker).fHavePerp = 0;
}

/* ---- Dispatch__6Speech  [SPEECH.CPP:1578-1586] SLD-VERIFIED ---- */
Speaker *Speech::Dispatch(void)

{
  Speaker *result;

  if (Speech_fgSpeech != (Speech *)0x0) {
    if (Speech_fgSpeech->fBankOffset != (long *)0x0) {
      goto Dispatch_useValue;
    }
  }
  result = Speech_fgUndefined;
  return result;
Dispatch_useValue:
  result = &Speech_fgSpeech->fDispatch->_base_Speaker;
  return result;
}

/* ---- Roger__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1592-1629] SLD-VERIFIED ---- */
void DispatchSpeaker::Roger()

{
  /* SYM-CODEGEN-CARRIER: invalid -- retail's optimized SYM has no ordinary
     local rows, so this source spelling is not recoverable.  The two-stage
     boolean shape is nevertheless required: folding the condition directly
     into the second `if` emits 152/157 instructions and 11 diffs. */
  bool invalid;
  /* SYM-CODEGEN-CARRIER: ID_CAR -- semantic name/type follow the canonical
     SPCHNFS_D_C_IN_PURS_* prototype.  A direct fCar argument moves its load
     into the jal delay slot (12 count-exact diffs across the two arms).
     SYM-CODEGEN-CARRIER: ID_UNIT -- the corresponding fTo staging statement
     is independently required for the same retail argument-setup order. */
  int ID_CAR;
  int ID_UNIT;
  
  Speech_fgSpeech->fSpeakerCar = (Car_tObj *)0x0;
  invalid = false;
  if (((this->_base_Speaker).fSub == (Speaker *)0x0 ||
      ((*(*(this->_base_Speaker).fSub->_vf)[0x1b].pfn)
                         ((int)&((this->_base_Speaker).fSub->fPosition).flags +
                          (int)(*(this->_base_Speaker).fSub->_vf)[0x1b].delta) == 0)) ||
      (((this->_base_Speaker).fSub)->fBlockade).flags != 0) {
    invalid = true;
  }
  if (invalid) {
    SPCHNFS_D_A_CONFIRM(&(this->_base_Speaker).fConfirm);
  }
  else {
    if (((this->_base_Speaker).fSub->fArrest).flags != 0) {
      /* SYM-CODEGEN-CARRIER: bank -- both scoped instances make GCC coalesce
         the first virtual result with the computed table base and mutate it
         in place.  Anonymous address expressions stay 157/157 but use $v0
         rather than retail's $s0 at both sites (8 diffs). */
      int *bank = (int *)
          ((int)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                     ((int)&(this->_base_Speaker).fPosition.flags +
                      (int)(*(this->_base_Speaker)._vf)[0x1e].delta) +
           (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
                     ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                      (int)(*(this->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
      SPCHNFS_D_C_PERP_APPREHENSION_REPLY(
          (this->_base_Speaker).fTo = bank[2],
          &(this->_base_Speaker).fConfirm,
          &(this->_base_Speaker).fPerpName);
    }
    else if (((this->_base_Speaker).fSub->fUpdate).flags == 0) {
      SPCHNFS_D_A_CONFIRM(&(this->_base_Speaker).fConfirm);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      this->_base_Speaker.SetCar((Car_tObj *)
          (*(*(this->_base_Speaker).fSub->_vf)[0x1b].pfn)
                    ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                     (int)(*(this->_base_Speaker).fSub->_vf)[0x1b].delta));
      SPCHNFS_D_C_PERP_LOST_CONFIRM(&(this->_base_Speaker).fColour,
                                    (this->_base_Speaker).fCar);
    }
    else {
      this->_base_Speaker.SetCar((Car_tObj *)
          (*(*(this->_base_Speaker).fSub->_vf)[0x1b].pfn)
                    ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                     (int)(*(this->_base_Speaker).fSub->_vf)[0x1b].delta));
      {
        int *bank = (int *)
            ((int)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                       ((int)&(this->_base_Speaker).fPosition.flags +
                        (int)(*(this->_base_Speaker)._vf)[0x1e].delta) +
             (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
                       ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                        (int)(*(this->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
        (this->_base_Speaker).fTo = bank[2];
      }
      if ((*(*(this->_base_Speaker).fSub->_vf)[0x18].pfn)
              ((int)&(this->_base_Speaker).fSub->fPosition.flags +
               (int)(*(this->_base_Speaker).fSub->_vf)[0x18].delta) < 0x280000) {
        ID_CAR = (this->_base_Speaker).fCar;
        ID_UNIT = (this->_base_Speaker).fTo;
        SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM(&(this->_base_Speaker).fColour,
                   ID_CAR,ID_UNIT,&(this->_base_Speaker).fConfirm,
                   &(this->_base_Speaker).fPerpName);
      }
      else {
        ID_CAR = (this->_base_Speaker).fCar;
        ID_UNIT = (this->_base_Speaker).fTo;
        SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM(&(this->_base_Speaker).fColour,
                   ID_CAR,ID_UNIT,&(this->_base_Speaker).fConfirm,
                   &(this->_base_Speaker).fPerpName);
      }
    }
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- StatusReply__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1636-1713] SLD-VERIFIED ----
 * MATCH 269/269 (W69).  SYM: 40-byte frame, `this` in $s1, `Blocker` in $s2,
 * saved mask $80070000 ($s0-$s2).  The former 5-diff/268-insn residual was the
 * delete_noop_moves copy-preference case documented at the
 * SPCHNFS_D_C_SPBLT_CONFIRMED call below; its non-volatile zero-insn preference
 * killer restores retail's surviving `addu a3,v1,zero`. */
void DispatchSpeaker::StatusReply()

{
  Speaker *Blocker;
  /* SYM-CODEGEN-CARRIER: invalid -- returning directly from the guard shrinks
     269 to 266 instructions and leaves seven branch/materialization diffs. */
  bool invalid = false;
  /* SYM-CODEGEN-CARRIER: context -- assigning fTo in both arms and reloading it
     at the macro call preserves count but changes six load/store sites. */
  int context;
  /* SYM-CODEGEN-CARRIER: from -- passing fFrom directly shrinks 269 to 268 and
     leaves three load-placement diffs. */
  int from;
  /* SYM-CODEGEN-CARRIER: reverse -- passing &fReverse directly shrinks 269 to
     268 and leaves five argument-setup diffs. */
  SPCHNFSType_REVINTRO *reverse;

  if (((this->_base_Speaker).fSub == (Speaker *)0x0) ||
      ((*(*(this->_base_Speaker).fSub->_vf)[0x1b].pfn)
         ((int)&((this->_base_Speaker).fSub->fPosition).flags +
          (int)(*(this->_base_Speaker).fSub->_vf)[0x1b].delta) == 0)) {
    invalid = true;
  }
  if (invalid) {
    return;
  }

  Speech_fgSpeech->fSpeakerCar = 0;
  Blocker = (Speaker *)0x0;
  if ((this->_base_Speaker).fSub->fBlockade.flags != 0) {
    if (Speech_fgSpeech->fMultiplePerps != 0) {
      (*(*(this->_base_Speaker).fSub->_vf)[0xd].pfn)
        ((int)&((this->_base_Speaker).fSub->fPosition).flags +
         (*(this->_base_Speaker).fSub->_vf)[0xd].delta);
      return;
    }
    /* SYM-CODEGEN-CARRIER: candidate -- assigning the SYM-named Blocker directly
       preserves count but changes ten load/copy sites and delays the `$s2` move. */
    Speaker *candidate = (this->_base_Speaker).fSub->fSub;
    /* SYM-CODEGEN-CARRIER: hasBlocker -- a direct compound predicate shrinks
       269 to 268 instructions and leaves 19 allocation/branch diffs. */
    bool hasBlocker = false;
    if (candidate != (Speaker *)0x0) {
      hasBlocker = candidate->fBlockade.flags != 0;
    }
    Blocker = candidate;
    if (hasBlocker) {
      (this->_base_Speaker).fTo =
        ((CallSignBank *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
          ((int)this + (*(this->_base_Speaker)._vf)[0x1e].delta))->fMobile[
        (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
          ((int)&(this->_base_Speaker).fSub->fPosition.flags +
           (*(this->_base_Speaker).fSub->_vf)[0x11].delta)];
    }
    else {
      Blocker = (this->_base_Speaker).fSub;
      (this->_base_Speaker).fTo =
        *(int *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
          ((int)this + (*(this->_base_Speaker)._vf)[0x1e].delta);
    }
    (*(*Blocker->_vf)[0xd].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0xd].delta);
    Speech_fgSpeech->fSpeakerCar = 0;
    SPCHNFS_D_A_CONFIRM(&(this->_base_Speaker).fConfirm);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    context = (this->_base_Speaker).fTo;
    from = (this->_base_Speaker).fFrom;
    reverse = &(this->_base_Speaker).fReverse;
  }
  else {
    context = ((CallSignBank *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
      ((int)this + (*(this->_base_Speaker)._vf)[0x1e].delta))->fMobile[
      (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
      ((int)&(this->_base_Speaker).fSub->fPosition.flags +
       (*(this->_base_Speaker).fSub->_vf)[0x11].delta)];
    from = (this->_base_Speaker).fFrom;
    reverse = &(this->_base_Speaker).fReverse;
    (this->_base_Speaker).fTo = context;
  }

  SPCHNFS_D_C_INTRO_CALL(context,from,reverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  {
    this->_base_Speaker.FindLocation(
      (Car_tObj *)(*(*(this->_base_Speaker).fSub->_vf)[0x19].pfn)
        ((int)&(this->_base_Speaker).fSub->fPosition.flags +
         (*((this->_base_Speaker).fSub->_vf))[0x19].delta));
  }

  if ((this->_base_Speaker).fSub->fBlockade.flags == 1) {
    /* SYM-CODEGEN-CARRIER: wing -- the measured W69 non-volatile preference
       killer below is required for retail's surviving `$v1` -> `$a3` copy. */
    int wing = ((CallSignBank *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
      ((int)this + (*(this->_base_Speaker)._vf)[0x1e].delta))->fMobile[
      (*(*Blocker->_vf)[0x11].pfn)
      ((int)&Blocker->fPosition.flags + (*Blocker->_vf)[0x11].delta)];
    /* SYM-CODEGEN-CARRIER: location -- passing fLocation directly preserves
       count but moves the load across the `$a3` copy, leaving six diffs. */
    int location = (this->_base_Speaker).fLocation;
    (this->_base_Speaker).fSpikeSide.flags = 4;
    (this->_base_Speaker).fWing = wing;
    /* *** MATCH (W69) -- THE 12A PREFERENCE-KILLER IN ITS NON-VOLATILE FORM.
       The seal is the one-line `__asm__("" : "=r"(wing) : "0"(wing) : "$7");`
       sitting immediately before the SPCHNFS_D_C_SPBLT_CONFIRMED call below.
       ZERO INSNS.  DO NOT DELETE OR "SIMPLIFY" IT: it is the only thing
       standing between this function and the 5-diff near-miss documented below.
       It is NOT a register pin (no `register T x asm("$N")` binding); it is the
       13B identity launder carrying a 12A hard-register clobber, and it emits
       nothing (empty template + matching "0" constraint = a reg-reg tie gcc
       coalesces away).  BOTH halves are load-bearing and BOTH were measured:
         launder alone, no clobber ................ 15 diffs
         clobber alone, volatile (no output) ...... 12 diffs   (W68's 14@269 class)
         launder + clobber, NON-volatile .......... PASS 269/269
       The clobber may be spelled "$7" or "a3" (both PASS); adding "memory"
       is also PASS but is noise -- keep the minimal form.
       WHY NON-VOLATILE IS THE WHOLE TRICK (this is the W68/20A closure, solved):
       an output-LESS asm is implicitly volatile => a sched1 BARRIER, and retail
       hoists the call's $a0/$a2 arg setup (`addu a0,s1,zero`, `addiu a2,s1,4`)
       from the call site all the way ABOVE the index chain; a barrier anywhere
       inside wing's live range traps them below it.  Giving the asm an OUTPUT
       (here wing itself, matched back to its own input) drops MEM_VOLATILE_P,
       so the insn is an ordinary schedulable RTL node: the clobber still makes
       $a3 conflict with wing's quantity -- denying local-alloc's
       qty_phys_copy_sugg, so wing takes $v1 and retail's surviving copy
       `addu a3,v1,zero` MINTS -- while sched1 remains free to hoist a0/a2.
       W68's structural law ("any RTL fence inside the range blocks the hoists")
       was right about VOLATILE fences only; the non-volatile launder is the
       device 13B had been asking for across four waves.
       POSITION IS A DIAL, and only P5 wins (all five measured, W69):
         P1 after the wing load ....... 7 @270   P2 after `location` .... 7 @270
         P3 after `distance` .......... 7 @270   P4 after `flags = 4` ... 10 @269
         P5 after the fWing store ..... PASS     (volatile controls at the same
         five positions: 10 / 12 / 12 / 14 / 12 -- never better than the 5-diff
         no-fence baseline, exactly as W68 recorded.)
       FENCE-FREE ANGLES RE-SWEPT THIS WAVE, ALL INERT AT EXACTLY 5 @268 (so the
       "source-level preference change" 20A asked for still does not exist, but
       it is no longer needed): `unsigned int wing`; a `pos` local for arg0 taken
       before the wing statement; `(int)wing` cast at the call; wing+call wrapped
       in one inner block (13A block anchor); the fWing store spelled through an
       int-pun lvalue (14D alias dial); a read-back `wing = fWing;` after the
       store (w43 case-2).  Two were WORSE: the index-term-first address spelling
       of the fMobile read and a `volatile int` read of the same slot both give
       7 @268 (they only re-order the `addu`).  Hoisting the location/distance
       declarations above the CallSign call is catastrophic (208 @273 -- the two
       locals then live across the virtual call and buy an extra callee-saved
       register plus a bigger frame).
       ---- the historical near-miss receipt this seal retires ----
       NEAR-MISS 5 (ours 268 / oracle 269) -- same class as SubmitRequest above:
       retail stages the loaded value in $v1 and COPIES it into the $a3 call-arg
       (`addu a3,v1,zero`); ours colours `wing` straight into $a3 because
       local-alloc's qty_phys_copy_sugg (and, for a global allocno, global.c's
       find_reg copy-preference OVERRIDE) hands the pseudo the very arg register
       it is copied into.  MEASURED (W55-A16): passing the re-read field
       `(this->_base_Speaker).fWing` as arg4 instead of `wing` DOES move the load
       to $v1 and makes the count EXACT 269/269 -- but the arg then becomes a
       RELOAD `lw a3,64(s1)` (6 diffs, a net regression), because expand_call's
       stack-arg store `sw v0,16(sp)` is emitted BEFORE arg4 and cse conservatively
       invalidates the s1-based MEM across it.  Keeping the 5-diff form.
       W59-A4: the 09G "make the copy a GLOBAL allocno" route is also falsified here --
       an identity fence on `wing` AFTER the fWing store gives 15, and the same fence
       placed right after `wing` is computed gives 9 (it DOES move the load to $v1 as
       predicted, but rotates the surrounding arg block).  Both worse than 5; the
       dial remains local-alloc copy-preference (06E), not a fence placement.
       W61-A10: the 12D DEAD-PSEUDO STAGING route (which SEALED Status's LOOK arm in
       this same TU on this wave) is FALSIFIED here -- staging the value into the
       fn-scope `context` gives 15@268, into `from` gives 11@268; neither
       materialises retail's `addu a3,v1,zero` copy, both stay ONE SHORT.  Staging
       works when retail needs a FRESH register for a stack arg; it does not defeat
       a copy-preference onto an arg register that is genuinely the value's only
       consumer.  Route unchanged (06E copy-preference / 12A preference killer).
       W62-A9 (13B copy devices) -- the residual is now QUANTIFIED, not just named.
       A read-only fence on `wing` placed AFTER the call DOES mint retail's missing
       copy and makes the count EXACT 269/269 (`addu a3,s0,zero`), so the copy device
       IS the right family -- but any post-call reference extends the live range
       ACROSS the call, so the value is forced CALLEE-saved ($s0) where retail keeps
       it caller-saved ($v1, dead at the copy): 8 diffs, worse than 5.  A `wingArg`
       copy carrier plus an identity launder does the same at 14@269.  Read-only
       fences on `wing` before/after the fWing store, with 1, 2 and 3 operands, are
       ALL 15@268 -- the floor_log2 ref-step is inert here because this is a hard-reg
       PREFERENCE, not a priority (12A).  Moving the fWing store to just before the
       call: 5 (inert).
       => THE EXACT WANTED DEVICE (13B's 4-witness request, sharpened by a witness):
       mint the copy WITHOUT adding a reference after the call.  Every device that
       mints it today also lengthens the range past the call and therefore buys the
       wrong register CLASS.
       W63-A10 (three more families, all real gate runs, all INERT at exactly
       5@268 -- they supersede nothing, they CLOSE the pseudo-shape axis):
         decl split `int wing; wing = ...` (12D's decl-with-init demote) 5;
         a named `wingIdx` for the CallSign call result + the array read 5;
         both together 5;
         a FUNCTION-SCOPE `int wing;` swept through ALL SIX positions of the
         local declaration list (before Blocker / after Blocker / after invalid /
         after context / after from / after reverse) -- 5 at every position.
       The 13A decl-order dial reaches allocno NUMBER, and the number is not the
       decider here: local-alloc's copy suggestion hands the pseudo $a3 whatever
       its number, its scope, or how its value is spelled.  The residual is
       exactly and only the 12A hard-reg PREFERENCE; nothing below the
       preference-killer instrument will move it.
       W68 (this session, 3 new angles, all real gate runs):
         (1) overlap-blocked carrier (`int wingSent = wing;` BEFORE the fWing
             store, call passes wingSent -- live ranges overlap so local-alloc
             cannot tie): 5@268 INERT -- cse copy-propagates wingSent:=wing
             before allocation ever sees the copy.
         (2) assignment-as-argument (`CALL(..., fWing = wing, ...)`, no separate
             store stmt -- hoping expand_assignment(want_value) returns a
             protected copy): 5@268 INERT -- 2.8 returns the source pseudo.
         (3) 🏆 ZERO-INSN a3-CLOBBER (`__asm__("" ::: "$7")` between the load
             and the store -- the wanted 12A preference killer, adds NO
             references to wing): MINTS THE COPY, count EXACT 269/269, wing
             lands in $v1 exactly as retail -- but the volatile asm is a
             SCHED BARRIER: retail's a0/a2 call-arg hoists land BETWEEN the
             index chain and the lw (inside wing's range), so they cannot
             cross the fence: 14@269, worse.  STRUCTURAL CLOSURE of the asm
             axis: ANY RTL fence inside [lw..sw] blocks exactly those hoists;
             a fence outside the range does not deny the preference.  The
             remaining wanted device must deny $a3 with ZERO RTL between the
             load and the store -- i.e. at the SOURCE/preference level, not
             via an inserted insn.  Keeping the 5-diff form.
             [W69 RESOLUTION: the premise "ANY RTL fence inside [lw..sw]" was
             true only for VOLATILE fences; a NON-VOLATILE asm (one with an
             output) is not a sched barrier, denies the preference just the
             same, and seals the function -- see the MATCH block at the top.] */
    __asm__("" : "=r"(wing) : "0"(wing) : "$7");  /* W69 seal -- see MATCH above */
    SPCHNFS_D_C_SPBLT_CONFIRMED((SPCHNFSType_POSITION *)this,
      location,&(this->_base_Speaker).fDistance,wing,
      &(this->_base_Speaker).fSpikeSide);
  }
  else {
    if ((this->_base_Speaker).fSub->fBlockade.flags != 2) {
      goto StatusReply_backup;
    }
    SPCHNFS_D_C_RDBLK_CONFIRMED((SPCHNFSType_POSITION *)this,
      (this->_base_Speaker).fLocation,&(this->_base_Speaker).fDistance);
  }

StatusReply_play:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  if (Blocker != (this->_base_Speaker).fSub) {
    (*(*(this->_base_Speaker).fSub->_vf)[0xe].pfn)
      ((int)&(this->_base_Speaker).fSub->fPosition.flags +
       (*(this->_base_Speaker).fSub->_vf)[0xe].delta);
  }
  goto StatusReply_subFetch;

StatusReply_backup:
  if ((this->_base_Speaker).fSub->fSub != (Speaker *)0x0) {
    (this->_base_Speaker).fWing =
      ((CallSignBank *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
        ((int)this + (*(this->_base_Speaker)._vf)[0x1e].delta))->fMobile[
        (*(*(this->_base_Speaker).fSub->fSub->_vf)[0x11].pfn)
          ((int)&(this->_base_Speaker).fSub->fSub->fPosition.flags +
           (*(this->_base_Speaker).fSub->fSub->_vf)[0x11].delta)];
    SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(&(this->_base_Speaker).fDistance,
      (SPCHNFSType_POSITION *)this,(this->_base_Speaker).fLocation,
      (this->_base_Speaker).fWing);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    (*(*(this->_base_Speaker).fSub->_vf)[0xe].pfn)
      ((int)&(this->_base_Speaker).fSub->fPosition.flags +
       (*(this->_base_Speaker).fSub->_vf)[0xe].delta);
    /* SYM-CODEGEN-CARRIER: statusSub -- direct assignment preserves count but
       changes 12 instructions by moving the child fetch ahead of the counters. */
    Speaker *statusSub = (this->_base_Speaker).fSub->fSub;
    this->fStatusCount = 0x140;
    this->fUpdateCount = this->fUpdateCount + 1;
    this->fStatusSub = statusSub;
  }

StatusReply_subFetch:
  {
    /* SYM-CODEGEN-CARRIER: blocked -- a direct child predicate shrinks 269 to
       268 instructions and leaves 13 branch/value-flow diffs. */
    bool blocked = false;
    if ((this->_base_Speaker).fSub->fSub != (Speaker *)0x0) {
      blocked = (this->_base_Speaker).fSub->fSub->fBlockade.flags != 0;
    }
    if (blocked) {
      (this->_base_Speaker).fSub->fBlockade.flags = 0;
    }
  }
}

/* ---- Status__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1718-1848] SLD-VERIFIED ---- */
void DispatchSpeaker::Status()

{
  int dist;
  
  /* SYM-CODEGEN-CARRIER: initialInvalid -- expressing the positive guard
     directly shortens retail's 366-instruction body to 363 and leaves 7
     branch/value-flow diffs. */
  bool initialInvalid = false;
  if (((this->_base_Speaker).fSub == (Speaker *)0x0) ||
     (dist = (int)(*(this->_base_Speaker).fSub->_vf)[0x1b].delta,
     (*(*(this->_base_Speaker).fSub->_vf)[0x1b].pfn)
       ((int)&((this->_base_Speaker).fSub->fPosition).flags + dist) == 0)) {
    initialInvalid = true;
  }
  if (!initialInvalid) {
  {
    if (((this->_base_Speaker).fSub->VirtualCarObj()->carFlags & 0x200) != 0) {
    /* SYM-CODEGEN-CARRIER: perpVf -- replacing this explicit virtual-call
       expansion with VirtualDistToPerp is count-exact but leaves 26 allocation
       and receiver-order diffs.
       SYM-CODEGEN-CARRIER: perpDistance -- the one virtual result is reused by
       mutually exclusive far/near tests; removing it would duplicate an
       observable virtual call, while SYM cannot recover its spelling. */
    __vtbl_ptr_type (*perpVf)[31] = (this->_base_Speaker).fSub->_vf;
    int perpDistance = (*(*perpVf)[0x18].pfn)
      ((int)&((this->_base_Speaker).fSub->fPosition).flags + (int)(*perpVf)[0x18].delta);

    if ((this->_base_Speaker).fSub->fHavePerp != 0) {
      if (0x15e0000 < perpDistance) {
        (this->_base_Speaker).fSub->fHavePerp = 0;
        (((this->_base_Speaker).fSub)->fUpdate).flags = 0;
        (this->_base_Speaker).fSub->VirtualStatus();
      }
    }
    else if (perpDistance < 0x640000) {
        /* SYM-CODEGEN-CARRIER: engageEntry -- the canonical nested
           VirtualEngage(VirtualPerp()) spelling shortens 366 to 364 and causes
           160 function-wide allocation diffs.
           SYM-CODEGEN-CARRIER: engageThis -- folding the adjusted receiver is
           count-exact but leaves 34 diffs. */
        __vtbl_ptr_type *engageEntry =
            &(*(this->_base_Speaker).fSub->_vf)[6];
        int engageThis =
            (int)(this->_base_Speaker).fSub + engageEntry->delta;
        (*engageEntry->pfn)(engageThis,
            (this->_base_Speaker).fSub->VirtualPerp());
    }
    }
  }
  if (this->fStatusSub != (Speaker *)0x0) {
    if (this->fStatusCount-- == 1) {
      if (this->fStatusSub == &this->_base_Speaker) {
        this->StatusReply();
      }
      else {
        /* SYM-CODEGEN-CARRIER: isCurrentSub -- a direct compound comparison
           shortens 366 to 364 and leaves 16 branch/value-flow diffs. */
        bool isCurrentSub = false;

        if ((this->_base_Speaker).fSub != (Speaker *)0x0) {
          isCurrentSub =
              this->fStatusSub == (this->_base_Speaker).fSub->fSub;
        }
        if (isCurrentSub) {
          this->fStatusSub->VirtualStatus();
        }
        else {
          this->fStatusSub->VirtualStatus();
          Speech_fgSpeech->fSpeakerCar = (Car_tObj *)0x0;
          (this->_base_Speaker).VirtualRoger();
        }
      }
    }
    return;
  }
  if (0 < this->fStatusCount) {
    this->fStatusCount = this->fStatusCount + -1;
    return;
  }
  /* SYM-CODEGEN-CARRIER: canUpdate -- direct blockade/arrest early returns
     shorten 366 to 365 and leave 5 normalized-Boolean diffs. */
  bool canUpdate = false;
  if (((this->_base_Speaker).fSub->fBlockade).flags == 0) {
    canUpdate = ((this->_base_Speaker).fSub->fArrest).flags == 0;
  }
  if (!canUpdate) {
    return;
  }
  /* SYM-CODEGEN-CARRIER: nestedDifferent -- folding the two virtual Perp
     results into the guard shortens 366 to 364 and leaves 6 comparison diffs. */
  bool nestedDifferent = false;
  if ((this->_base_Speaker).fSub->fSub != (Speaker *)0x0) {
    nestedDifferent =
        (this->_base_Speaker).fSub->fSub->VirtualPerp() !=
        (this->_base_Speaker).fSub->VirtualPerp();
  }
  if (nestedDifferent) {
    ((this->_base_Speaker).fSub)->fSub->Promote();
  }
  switch (this->fUpdateCount & 3) {
  case 0:
    goto DispStatus_updateCount38;
  case 1:
    goto DispStatus_updateCount1;
  case 2:
    goto DispStatus_updateCount2;
  case 3:
    goto DispStatus_updateCount3;
  default:
    goto DispStatus_fetchSpeechCtx;
  }
DispStatus_updateCount2:
  {
    /* SYM-CODEGEN-CARRIER: fastEnough -- direct nested early-exit control flow
       shortens 366 to 365 and leaves 5 normalized-Boolean diffs. */
    bool fastEnough = false;

    if ((this->_base_Speaker).fSub->VirtualDistToPerp() < 0x280000) {
      if (0x32 < this->_base_Speaker.CalcMph(
                     (this->_base_Speaker).fSub->VirtualCarObj())) {
        fastEnough = 0x32 < this->_base_Speaker.CalcMph(
            (this->_base_Speaker).fSub->VirtualPerp());
      }
    }
    if (fastEnough) {
      (((this->_base_Speaker).fSub)->fUpdate).flags = 8;
      goto DispStatus_fetchSpeechCtx;
    }
    goto DispStatus_updateCount38;
  }
DispStatus_updateCount38:
  ((this->_base_Speaker).fSub->fUpdate).flags = 0x26;
  goto DispStatus_fetchSpeechCtx;
DispStatus_updateCount3:
    {
    if ((this->_base_Speaker).fSub->VirtualIsSuper() &&
        (this->fUpdateCount == 7)) {
      (((this->_base_Speaker).fSub)->fUpdate).flags = 0;
      (this->_base_Speaker).fSub->VirtualStatus();
      this->fUpdateCount = this->fUpdateCount + 1;
      return;
    }
    if ((this->_base_Speaker).fSub->VirtualDistToPerp() < 0x140000) {
      (this->_base_Speaker).fSub->VirtualBullhorn();
      this->fUpdateCount = this->fUpdateCount + 1;
      return;
    }
    goto DispStatus_updateCount1;
    }
DispStatus_updateCount1:
  ((this->_base_Speaker).fSub->fUpdate).flags = 1;
DispStatus_fetchSpeechCtx:
  Speech_fgSpeech->fSpeakerCar = (Car_tObj *)0x0;
  /* SYM-CODEGEN-CARRIER: callSign -- folding the virtual CallSign result into
     fMobile indexing shortens 366 to 364 and leaves 38 receiver/allocation
     diffs; the typed pointer restores its semantic role. */
  CallSignBank *callSign = (this->_base_Speaker).VirtualCallSign();
  (this->_base_Speaker).fTo = callSign->fMobile[
      (this->_base_Speaker).fSub->VirtualUnit()];
  SPCHNFS_D_C_INTRO_CALL((this->_base_Speaker).fTo,
                         (this->_base_Speaker).fFrom,
                         &(this->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  SPCHNFS_D_C_IN_PURS_NEAR_PERP(
      &((this->_base_Speaker).fSub)->fUpdate);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  this->fStatusCount = 0x60;
  this->fStatusSub = (this->_base_Speaker).fSub;
  this->fUpdateCount = this->fUpdateCount + 1;
  }
  return;
}

/* ---- Status__Q26Speech13MobileSpeaker  [SPEECH.CPP:1853-1948] SLD-VERIFIED ----
 * W61-A10: 14 -> 8 by SOURCE (two levers below).  A historical production
 * experiment used four PER_FN_TEXT_MOVES rows; those are not part of the strict
 * source-only closure described below.
 *
 * LEVER 1 -- CSE-CONSTANT-CAPTURE ESCAPE (kills the x2 `addu a1,s1,v0`).
 *   cc1 emits `li $2,8` at the HEAD of the `uVar8 != 8` block (the compare needs a
 *   register: MIPS `beq`/`bne` have no immediate form), and cse then rewrites the
 *   *following* `&fColour` address `(plus $17 (const_int 8))` into `addu $5,$17,$2`
 *   -- a register reuse retail does not make.  Proof it is cse and not maspsx: the
 *   raw cc1 .s carries `addu $5,$17,$2` at the two captured sites and
 *   `addu $5,$17,8` at the third (`$L943`, a JOIN target, so the constant is not in
 *   cse's table there).  The first cure hoisted `pCVar5 = &fColour;` above the
 *   guard.  The final strict closure instead sinks it behind the zero-byte
 *   barrier below; its $2 clobber ends the stale constant live range and retains
 *   the immediate `addiu a1,s1,8` form.
 *   FALSIFIED first (all neutral at 14): `(char *)this + 8`, a block-local colour
 *   pointer, the address inline in the call, colour-assigned-last, and an identity
 *   fence on pCVar5 (16, worse).
 *
 * LEVER 2 -- DEAD-PSEUDO STAGING (12D) on the LOOK_PERP_REPLY_LOC arm.
 *   Retail loads fCar into a FRESH register before materialising &fColour, so the
 *   stack-arg copy survives into the jal delay slot; ours reused $v0 for both and
 *   emitted the loads in the wrong order.  Do NOT add a variable: the guard variable
 *   `uVar8` is DEAD on this arm (its compare already branched), so retail's carrier
 *   is uVar8 itself -- `uVar8 = fCar;` staged before the two address setups gives
 *   count-exact 358 and reduces the site to one line relocation.
 *   FALSIFIED: staging into iVar4 (13 @359, one insn LONG), iVar11 (28), uVar13
 *   (33 @359), pCVar5 (43 @361), a fresh block-local (60), and a `{ }`-scoped local
 *   (60); swapping the pMVar12/vs_KMH_MPH setup order is inert (14).
 *
 * W77-root follow-up (2026-08-24): ordering each dead-uVar8 fCar stage AFTER
 * its distance/location setup fixes both load-order rows naturally, 8 -> 4 at
 * exact 358/358.  The duplicated final 4 are closed by making an arm-local
 * voice alias, passing it through a zero-instruction `+r` barrier that clobbers
 * $2, and only then forming &fColour.  Reorg puts `move a0,s0` in both beq delay
 * slots, while cse can no longer turn the address into `addu a1,s1,v0`.
 * Strict source-only result: PASS 358/358. */
void MobileSpeaker::Status()

{
  Speaker * Sub;
  /* SYM-CODEGEN-CARRIER: condition -- the function reuses one staged Boolean
     across mutually exclusive retail tests; keeping the shared quantity
     preserves the exact 358-instruction control-flow form. */
  bool condition;
  /* SYM-CODEGEN-CARRIER: superReady -- this staged result carries the retail
     bit-test idiom into the super-cop arm; folding its maskedFlags producer
     grows the function to 359 instructions and leaves 5 diffs. */
  bool superReady;
  Car_tObj *carObj;
  /* SYM-CODEGEN-CARRIER: pa_Var3 -- this shared vtable-result carrier is part
     of the exact virtual-call source shape throughout the function; SYM emits
     only nested inline this quantities and cannot recover its spelling. */
  __vtbl_ptr_type (*pa_Var3) [31];
  /* SYM-CODEGEN-CARRIER: iVar4 -- the shared virtual/result carrier feeds the
     retail branch and call setup sequence; replacement must be priced per
     phase because its declaration position controls local allocation. */
  int iVar4;
  /* SYM-CODEGEN-CARRIER: colourArg -- these two arm-local-looking assignments
     must remain on the shared carrier: together with branchVoice and the $2
     clobber they prevent stale-constant CSE, as proven in the header receipt. */
  Car_tObj *colourArg;
  /* SYM-CODEGEN-CARRIER: superBank -- folding this one-use virtual bank result
     into the intro argument shortens the body to 357 instructions and leaves
     3 load/address-order diffs. */
  u_int *superBank;
  /* SYM-CODEGEN-CARRIER: uVar8 -- this update-mode quantity is intentionally
     reused as retail's dead-pseudo fCar stage in two reply arms; the exhaustive
     failed-carrier ladder and exact 358/358 result are recorded above. */
  u_long uVar8;
  /* SYM-CODEGEN-CARRIER: branchVoice -- the tied arm-local voice carrier plus
     zero-byte $2 clobber supplies retail's branch-slot receiver copies and
     blocks the stale constant capture documented above. */
  SPCHNFSType_VOICE *branchVoice;
  /* SYM-CODEGEN-CARRIER: pSVar10 -- this shared primary voice carrier spans
     the mutually exclusive speech arms and preserves retail's saved-register
     allocation; the branch-only copy is isolated in branchVoice. */
  SPCHNFSType_VOICE *pSVar10;
  /* SYM-CODEGEN-CARRIER: vs_KMH_MPH -- the phrase-value carrier deliberately
     shares location, fCar, and speed-type phases; changing the carrier/order
     is one of the inert or worse setup-order levers recorded above. */
  SPCHNFSType_vs_KMH_MPH *vs_KMH_MPH;
  /* SYM-CODEGEN-CARRIER: pMVar12 -- the shared phrase pointer carries distance
     and perp-name arguments through retail's stack-argument schedule. */
  MobileSpeaker *pMVar12;
  /* SYM-CODEGEN-CARRIER: savedDispatch -- reusing uVar8 for this save/restore
     grows the body to 360 instructions and leaves 88 allocation diffs. */
  u_int savedDispatch;
  
  pa_Var3 = (this->_base_Speaker)._vf;
  iVar4 = (*(*pa_Var3)[0x1b].pfn)
                    ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
  if (iVar4 == 0) {
    return;
  }
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  if ((this->_base_Speaker).fArrest.flags == 1) {
    pa_Var3 = (this->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x1e].pfn)
                      ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
    pSVar10 = &this->fVoice;
    /* MATCH: fold `fTo = *(iVar4+4)` INTO the a1 arg so the store lands in the
       jal delay slot (`sw a1,60(s1)`) and a1 loads direct; keep a2(fFrom)/a3(fReverse)
       inline so gcc loads a1,a2,a3 in order -- the split temp+store form forced a
       `lw a2/t0 then move a2->a1,t0->a2` arg shuffle. [W55-A16 idiom] */
    SPCHNFS_C_A_INTRO(pSVar10,(this->_base_Speaker).fTo = *(int *)(iVar4 + 4),(int)(this->_base_Speaker).fFrom,(SPCHNFSType_REVINTRO *)&(this->_base_Speaker).fReverse);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    SPCHNFS_C_D_PERP_APPREHENSION(
      pSVar10,&(this->_base_Speaker).fPerpName);
  }
  else {
    pa_Var3 = (this->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x19].pfn)
                      ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x19].delta);
    condition = false;
    if ((*(u_int *)(iVar4 + 0x260) & 0x200) != 0) {
      condition = (this->_base_Speaker).fUpdate.flags == 0;
    }
    if (condition) {
      pa_Var3 = (this->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x1e].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &this->fVoice;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,(this->_base_Speaker).fTo = *(int *)(iVar4 + 4),(this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      pa_Var3 = (this->_base_Speaker)._vf;
      this->_base_Speaker.SetCar((Car_tObj *)
        (*(*pa_Var3)[0x1b].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*pa_Var3)[0x1b].delta));
      this->_base_Speaker.FindLocation(this->fCarObj);
      iVar4 = (this->_base_Speaker).fCar;
      SPCHNFS_C_D_PERP_LOST(pSVar10,&(this->_base_Speaker).fColour,
                 iVar4,(SPCHNFSType_POSITION *)this,(this->_base_Speaker).fLocation,
                 &(this->_base_Speaker).fDistance,&(this->_base_Speaker).fPerpName);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      iVar4 = Speech::Dispatch();
      savedDispatch = *(u_int *)(iVar4 + 0x48);
      iVar4 = Speech::Dispatch();
      *(MobileSpeaker **)(iVar4 + 0x48) = this;
      {
        /* SYM-CODEGEN-CARRIER: dispatchThis -- the result must be evaluated
           once and then reused for its vtable, delta, and receiver address;
           the retail binary cannot identify a unique original spelling. */
        DispatchSpeaker *dispatchThis = (DispatchSpeaker *)Speech::Dispatch();
        (*(*(dispatchThis->_base_Speaker)._vf)[0xe].pfn)
                  ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                   (int)(*(dispatchThis->_base_Speaker)._vf)[0xe].delta);
      }
      iVar4 = Speech::Dispatch();
      *(u_int *)(iVar4 + 0x48) = savedDispatch;
      return;
    }
    superReady = false;
    pa_Var3 = (this->_base_Speaker)._vf;
    iVar4 = (*(*pa_Var3)[0x14].pfn)
                      ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x14].delta);
    if (((iVar4 != 0) && ((this->_base_Speaker).fUpdate.flags == 0)) &&
       ((this->_base_Speaker).fSub != (Speaker *)0x0)) {
      /* SYM-CODEGEN-CARRIER: maskedFlags -- folding the mask into the Boolean
         grows the function to 359 instructions and changes five bit-test
         instructions (srl/xori/andi versus andi/sltiu). */
      u_int maskedFlags;

      iVar4 = (*(*(this->_base_Speaker).fSub->_vf)[0x19].pfn)
        ((int)&(this->_base_Speaker).fSub->fPosition.flags +
         (int)(*(this->_base_Speaker).fSub->_vf)[0x19].delta);
      maskedFlags = *(u_int *)(iVar4 + 0x260) & 0x40;
      superReady = maskedFlags < 1;
    }
    if (superReady) {
      pa_Var3 = (this->_base_Speaker)._vf;
      superBank = (u_int *)
               (*(*pa_Var3)[0x1e].pfn)
                         ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &this->fVoice;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,
        (this->_base_Speaker).fTo = *superBank,
        (int)(this->_base_Speaker).fFrom,
        (SPCHNFSType_REVINTRO *)&(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_S_C_SUPER_COP_CRITICISM(pSVar10);
    }
    else {
      condition = false;
      iVar4 = Speech::Dispatch();
      if (*(int *)(iVar4 + 0x48) != 0) {
        iVar4 = Speech::Dispatch();
        condition = *(MobileSpeaker **)(*(int *)(iVar4 + 0x48) + 0x48) == this;
      }
      if (condition) {
        SPCHNFS_C_C_NEW_OFFICER_ENGAGING(&this->fVoice,(this->_base_Speaker).fFrom);
        iVar4 = Speech::Dispatch();
        (**(int (**)(...))
          (*(int *)(*(int *)(iVar4 + 0x48) + 0x4c) + 0x74))
          (*(int *)(iVar4 + 0x48) +
           (int)*(short *)
             (*(int *)(*(int *)(iVar4 + 0x48) + 0x4c) + 0x70));
        return;
      }
      pa_Var3 = (this->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x1e].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1e].delta);
      pSVar10 = &this->fVoice;
      /* MATCH: fTo store folded into a1 arg (delay-slot sw); a2/a3 inline. [W55-A16] */
      SPCHNFS_C_A_INTRO(pSVar10,(this->_base_Speaker).fTo = *(int *)(iVar4 + 4),(int)(this->_base_Speaker).fFrom,(SPCHNFSType_REVINTRO *)&(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      pa_Var3 = (this->_base_Speaker)._vf;
      this->_base_Speaker.SetCar((Car_tObj *)
        (*(*pa_Var3)[0x1b].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*pa_Var3)[0x1b].delta));
      pa_Var3 = (this->_base_Speaker)._vf;
      this->_base_Speaker.FindLocation((Car_tObj *)
        (*(*pa_Var3)[0x19].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*pa_Var3)[0x19].delta));
      this->SetSpeed(this->fPerp);
      pa_Var3 = (this->_base_Speaker)._vf;
      iVar4 = (*(*pa_Var3)[0x18].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x18].delta);
      if (iVar4 < 0x280000) {
        pa_Var3 = (this->_base_Speaker)._vf;
        iVar4 = (*(*pa_Var3)[0x1b].pfn)
                          ((int)&(this->_base_Speaker).fPosition.flags + (int)(*pa_Var3)[0x1b].delta);
        if (0x40 < *(u_short *)(iVar4 + 0x17c)) {
          SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(pSVar10);
          goto DispStatus_playSpeechReturn;
        }
        uVar8 = (this->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fLocation;
          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;
          SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC(pSVar10,(SPCHNFSType_POSITION *)this,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12);
          goto DispStatus_playSpeechReturn;
        }
        /* MATCH strict closure: the tied voice alias supplies the branch-slot
           receiver copy.  The user-authorized last-resort $2 clobber ends the
           compare constant's live range, so &fColour may follow as addiu. */
        if (uVar8 != 8) {
          /* SYM-CODEGEN-CARRIER: nearLocation -- passing fLocation directly is
             count-exact but changes four address/stack-argument instructions. */
          int nearLocation;

          branchVoice = pSVar10;
          __asm__("" : "+r"(branchVoice) : : "$2");
          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fCar;
          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;
          nearLocation = (this->_base_Speaker).fLocation;
          SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(branchVoice,(SPCHNFSType_COLOUR *)colourArg,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,(SPCHNFSType_POSITION *)this,
                     nearLocation);
          goto DispStatus_playSpeechReturn;
        }
      }
      else if ((this->_base_Speaker).fHavePerp != 0) {
        uVar8 = (this->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fLocation;
          uVar8 = (this->_base_Speaker).fCar;
          SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC(pSVar10,(SPCHNFSType_POSITION *)this,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,&(this->_base_Speaker).fColour,(int)uVar8,
                     &(this->_base_Speaker).fPerpName);
          goto DispStatus_playSpeechReturn;
        }
        /* MATCH strict closure, second duplicated STS arm; see first site. */
        if (uVar8 != 8) {
          branchVoice = pSVar10;
          __asm__("" : "+r"(branchVoice) : : "$2");
          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fCar;
          SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS(branchVoice,(SPCHNFSType_COLOUR *)colourArg,(int)vs_KMH_MPH,
                     (SPCHNFSType_POSITION *)this,(this->_base_Speaker).fLocation,
                     &(this->_base_Speaker).fDistance);
          goto DispStatus_playSpeechReturn;
        }
      }
      else {
        uVar8 = (this->_base_Speaker).fUpdate.flags;
        if (uVar8 == 1) {
          /* MATCH lever 2 (12D dead-pseudo staging): uVar8 is dead on this arm and
             is retail's carrier for fCar -- staging it here (NOT a new local) gives
             the fresh register the stack-arg copy needs. [W61-A10] */
          pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fDistance;
          vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fLocation;
          uVar8 = (this->_base_Speaker).fCar;
          SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC(pSVar10,(SPCHNFSType_POSITION *)this,(int)vs_KMH_MPH,
                     (SPCHNFSType_DISTANCE *)pMVar12,&(this->_base_Speaker).fColour,(int)uVar8);
          goto DispStatus_playSpeechReturn;
        }
        if (uVar8 != 8) {
          goto DispStatus_lookReplyStatus;
        }
      }
DispStatus_speedReply:
      vs_KMH_MPH = &this->fSpeedType;
      SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(
        pSVar10,this->fSpeed,vs_KMH_MPH);
      goto DispStatus_playSpeechReturn;
DispStatus_lookReplyStatus:
      vs_KMH_MPH = (SPCHNFSType_vs_KMH_MPH *)(this->_base_Speaker).fCar;
      pMVar12 = (MobileSpeaker *)&(this->_base_Speaker).fPerpName;
      SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(
        pSVar10,&(this->_base_Speaker).fColour,(int)vs_KMH_MPH,
                 (SPCHNFSType_PERP_NAME *)pMVar12);
    }
  }
DispStatus_playSpeechReturn:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1954-1958] SLD-VERIFIED ---- */
void DispatchSpeaker::ClearPerp(Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (this->fPerp[i] == car) {
      this->fPerp[i] = (Car_tObj *)0x0;
    }
    i = i + 1;
  } while (i < 2);
  return;
}

/* ---- KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1964-1969] SLD-VERIFIED ---- */
bool DispatchSpeaker::KnownPerp(Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (this->fPerp[i] != car) {
      i = i + 1;
    }
    else {
      return 1;
    }
  } while (i < 2);
  return 0;
}

/* ---- AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1976-1980] SLD-VERIFIED ---- */
void DispatchSpeaker::AddPerp(Car_tObj *car)

{
  int i;

  i = 0;
  do {
    if (this->fPerp[i] == (Car_tObj *)0x0) {
      this->fPerp[i] = car;
    }
    i = i + 1;
  } while (i < 2);
  return;
}

/* ---- Report__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1990-2031] SLD-VERIFIED ----
 * PASS (104/104): the direct, combined bank-address expression keeps the first
 * virtual result live through the second call and sinks its v0->s0 copy into
 * that call's delay slot.  This supersedes the historical near-miss analysis below.
 * NEAR-MISS 11, ours 103 / oracle 104 (W60-A9).  Retail keeps the second vf-thunk's
 * receiver in a FRESH register ($a1: `lw a1,76(v1); lh a0,136(a1); lw v1,140(a1)`)
 * and defers the first call's result copy `addu s0,v0,zero` into the SECOND jalr's
 * DELAY SLOT (so it still captures the FIRST result -- delay slots run before the
 * call lands, S3.1); ours reuses $v0 for the receiver and emits the copy right after
 * the first call.  Semantics identical.
 * FALSIFIED (W60-A9): rewriting the `iVar3 = pfnA(); iVar4 = pfnB(); iVar3 += iVar4*4;`
 * chain as Roger's single-expression form `pfnA() + pfnB()*4` -- 13@101 with the
 * fenced pSVar6 hoisted, 15@103 keeping the statement order, 14@100 without the
 * identity fence.  All three LOSE insns (ours already runs short), so the missing
 * insn is retail's extra receiver register, not the expression shape.
 * W61-A10 MECHANISM (read before re-trying) + SIX more falsifications.
 *   The whole residual is ONE decision: which register holds the second vf-thunk's
 *   RECEIVER (`pSVar6->_vf`).  Retail cannot use $v0 there because $v0 still carries
 *   the FIRST call's result (retail defers the `addu s0,v0,zero` copy all the way
 *   into the second jalr's DELAY SLOT, where it still reads the pre-call $v0, S3.1),
 *   so find_reg's caller-saved scan v0,v1,a0,a1 lands on $a1 -- v1 = pSVar6, a0 =
 *   the arg -- and the pfn then reuses the dying $v1.  Ours copies v0->s0 straight
 *   after the first call, which FREES $v0 before the receiver load, so cc1 takes it
 *   and reorg can no longer sink the copy (the receiver load clobbers $v0).  The two
 *   facts are circular: the allocator runs first, reorg second.
 *   FALSIFIED, all INERT at exactly 11@103 (so the receiver pseudo is a LOCAL qty
 *   reached by block_alloc's numeric scan -- no fence dial touches it):
 *   a named `__vtbl_ptr_type (*subVf)[31]` local for the receiver with and without an
 *   identity fence; a read-only fence on iVar3 (1 and 2 operands); an identity fence
 *   on iVar3; the named receiver local + the iVar3 read-only fence together.
 *   NEXT ANGLE: the dial has to make $v0 UNAVAILABLE at the receiver load, i.e. keep
 *   the first result's pseudo in $v0 across it -- an allocsim/reqdelta job on the
 *   iVar3 allocno, or the 12A "hard-reg preference killer" instrument, not a fence.
 * W62-A9 re-gated 11@103 and applied the 13B copy devices.  SEVEN more
 * falsifications, all measured in the CURRENT basin (this TU has had structural
 * landings since W60-A9, so they supersede the stale numbers above): the
 * SYM-driven single-expression form (the 8c block declares NO named locals at
 * all -- every temp is anonymous) 17@101; the half-expression form 15@103; a
 * `pa_Var2` receiver carrier 11 (inert); the same carrier with a 13B identity
 * launder 11 (inert); the sum written product-first `iVar4*4 + iVar3` 11 (inert);
 * a read-only fence on iVar4 after the sum 16@104; dropping the pSVar6 launder
 * 16@102.  MECHANISM CONFIRMED BY EXHAUSTION: reorg cannot sink the
 * `addu s0,v0,zero` copy because OUR arg insn `addu a0,v1,a0` is still eligible
 * for the jalr slot -- retail's is not, because retail's pfn load `lw v1,140(a1)`
 * clobbers v1 AFTER it.  Everything is downstream of the receiver's register;
 * route unchanged (12A hard-reg preference killer).
 * W63-A10 re-gated 11@103 and CLASSIFIED the blocker, which retires two whole
 * device families here:
 *  - THE W63 FOREIGN-OPERAND FENCE (`asm("" : : "r"(neighbour))`, the wave's
 *    named unblock for THIS function) is INERT at exactly 11@103 in all NINE
 *    placements tried: operand iVar3 / pSVar6 / pThis, each with and without a
 *    named `__vtbl_ptr_type (*subVf)[31]` receiver local, plus x2, x3 and a
 *    two-operand form.  This is an independent witness for the A16 correction:
 *    REG_LIVE_LENGTH is a SERVING-ORDER (QTY_CMP_PRI) dial, and this residual is
 *    not a serving-order loss -- our receiver is served while $v0 is simply FREE,
 *    so it takes the lowest free reg.  Retail's $a1 requires $v0, $v1 AND $a0 all
 *    UNAVAILABLE across the receiver's window; only the first call's result can
 *    occupy $v0 there, and its copy-to-$s0 is emitted by expand immediately after
 *    the call.  PROVEN NOT A SCHEDULER QUESTION: compiling the TU with
 *    -fno-schedule-insns and with -fno-schedule-insns2 leaves `move $16,$2`
 *    glued to the call in both, so sched1 never moved it and there is nothing to
 *    stop.  This is 13A's UNREACHABILITY TRIAGE: change qty STRUCTURE, not a dial.
 *  - THE CARRIER-IDENTITY dial that sealed Lose in this same TU is also inert
 *    here: carrying the first result / the CallSign result in reg_a2, reg_a3,
 *    iVar4 or any pairing of them is 11@103 (except iVar4<->iVar3 swapped, 93@105).
 *  - SPLITTING the copy so it is emitted AFTER the receiver load (`int bankRes =
 *    call(); ... iVar3 = bankRes;` with and without a launder, with and without
 *    the named subVf) is 16-18 @102 -- it goes ONE SHORTER, i.e. the two pseudos
 *    coalesce and an insn is lost; the structural change we need has to ADD
 *    retail's extra nop, not remove one.
 * NEXT: the only structure that can work is one where a caller-saved pseudo
 * genuinely holds a live value in $v0 across the receiver load.  That is the
 * 12A preference/availability instrument (or an allocsim/reqdelta reading of the
 * receiver's qty window), not a fence and not a spelling. */
/* SUPERSEDED RECEIPT: 36 -> 11 diffs (103/104).  Distinct short-lived speech arguments
   recover every tail register, the SLD Speech* local plus the first empty
   barrier recover the retail prologue, and the pin-free pSVar6 fence recovers
   fSub=$v1.  Remaining named angle: retail keeps the first virtual result in
   $v0, forcing the second vtable into $a1 and delaying v0->s0 into jalr's slot;
   gcc currently copies to s0 early and consequently assigns that vtable $v0.
   qtytrace is blocked by the preceding SetCar instrumented-compiler ICE. */
void DispatchSpeaker::Report(Car_tObj *perp)

{
  /* SYM-CODEGEN-CARRIER: hasSub -- folding the two-stage predicate into one
     condition shortens retail's 104-instruction body to 100 and leaves 18
     control-flow/allocation diffs. */
  bool hasSub;
  /* SYM-CODEGEN-CARRIER: pursuitLocation -- passing fLocation directly is
     count-exact but changes six call-setup/delay-slot instructions. */
  int pursuitLocation;
  /* SYM-CODEGEN-CARRIER: speech -- storing through Speech_fgSpeech directly
     grows the body to 105 instructions and leaves 3 load/nop diffs. */
  Speech *speech;
  
  speech = Speech_fgSpeech;
  hasSub = false;
  __asm__("" : : "i"(0));
  *(u_int *)((int)speech + 0x38c) = 0;
  /* W57-A8 5.0c commutative-addu: fold the -0x5c into the BASE term so the
     just-loaded delta stays operand 2 (`addu a0,s1,a0` like retail, not
     `addu a0,a0,s1`). All four vf-thunk arg sites. 42 -> 36 diffs. */
  if ((*(*(this->_base_Speaker)._vf)[0x12].pfn)
        (((int)this->fPerp + -0x5c) +
         (*(this->_base_Speaker)._vf)[0x12].delta) != 0) {
    hasSub = (this->_base_Speaker).fSub != (Speaker *)0x0;
  }
  if (hasSub) {
    if (Speech_fgSpeech->fMultiplePerps == 0) {
      /* SYM-CODEGEN-CARRIER: bank -- inlining the combined bank expression is
         count-exact but reverses the addu destination and changes four
         instructions around the final load. */
      int *bank;

      bank = (int *)((int)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
        (((int)this->fPerp + -0x5c) +
         (*(this->_base_Speaker)._vf)[0x1e].delta) +
        (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
        ((int)&(this->_base_Speaker).fSub->fPosition.flags +
         (int)(*(this->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
      SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(
        &(this->_base_Speaker).fConfirm,
        (this->_base_Speaker).fTo = bank[2]);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
  }
  else {
    if (Speech_fgSpeech->fMultiplePerps == 0) {
      SPCHNFS_D_C_INTRO_CALL(
        (this->_base_Speaker).fTo =
          *(int *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
            (((int)this->fPerp + -0x5c) +
             (*(this->_base_Speaker)._vf)[0x1e].delta),
        (this->_base_Speaker).fFrom,
        &(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      this->_base_Speaker.SetCar(perp);
      this->_base_Speaker.FindLocation(perp);
      /* SYM-CODEGEN-CARRIER: pursuitCar -- passing fCar directly is
         count-exact but changes six call-setup/delay-slot instructions. */
      int pursuitCar;

      pursuitCar = (this->_base_Speaker).fCar;
      pursuitLocation = (this->_base_Speaker).fLocation;
      SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(
        &(this->_base_Speaker).fColour,pursuitCar,
        (SPCHNFSType_POSITION *)this,pursuitLocation,
        &(this->_base_Speaker).fDistance);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    this->AddPerp(perp);
    this->fStatusCount = 0x2a0;
  }
  return;
}

/* ---- Accident__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:2039-2043] SLD-VERIFIED ---- */
void DispatchSpeaker::Accident(int slice)

{
  return;
}

/* ---- Deny__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2049-2073] SLD-VERIFIED ---- */
void DispatchSpeaker::Deny()

{
  /* SYM-CODEGEN-CARRIER: vs_RDBLK_SSTRP -- retaining the blockade address as
     one pseudo gives retail's a0/v0/v1 branch-and-delay-slot layout; spelling
     the receiver/field expression directly is count-exact but costs 10 diffs. */
  SPCHNFSType_vs_RDBLK_SSTRP *vs_RDBLK_SSTRP;
  
  if ((this->_base_Speaker).fSub != (Speaker *)0x0) {
    Speech_fgSpeech->fSpeakerCar = (Car_tObj *)0x0;
    /* MATCH: retail SLD line 2060 owns BOTH vtable calls AND the index scale +
       load (one fused statement); line 2061 owns only the INTRO_CALL args, with
       `fTo = bank[2]` written as the arg-0 assignment (oracle `sw a0,60(s1)` in the
       jal delay slot).  Splitting the calls into iVar2/iVar3 statements and
       storing fTo separately cost 21 diffs. [05A LAW: SLD = statement order]
       The arg-0 term order also matters: base FIRST (`addu a0,s1,a0`). */
    {
      /* SYM-CODEGEN-CARRIER: bank -- this scoped computed base coalesces with
         the first virtual result and mutates in place; the anonymous address
         expression moves the add into the scaled temporary and loses PASS. */
      /* MATCH: the computed base needs its OWN (block-scoped) variable -- gcc then
         coalesces `bank` with the 1st call's result pseudo and mutates it IN PLACE
         (oracle `addu s0,s0,v0; lw a0,8(s0)`).  As an anonymous sub-expression
         (`*(void**)(A + B*4 + 8)`) the address lands in the scaled temp instead
         (`addu v0,v0,s0`).  Same shape the PASSing sibling Roger uses. [3.12 #14] */
      int *bank = (int *)((int)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                   ((int)&(this->_base_Speaker).fPosition.flags +
                    (int)(*(this->_base_Speaker)._vf)[0x1e].delta) +
         (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
                   ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                    (int)(*(this->_base_Speaker).fSub->_vf)[0x11].delta) * 4);
      SPCHNFS_D_C_INTRO_CALL((this->_base_Speaker).fTo = bank[2],
                            (this->_base_Speaker).fFrom,
                            &(this->_base_Speaker).fReverse);
    }
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    vs_RDBLK_SSTRP = &(this->_base_Speaker).fSub->fBlockade;
    /* MATCH: retail's FALL-THROUGH arm is the RDBLK one (oracle `beqz v1` +
       `addiu a0,v0,20` in the slot); the `flags == 0` spelling puts
       DENIED_REPLY first and flips the branch polarity. */
    if (vs_RDBLK_SSTRP->flags != 0) {
      SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(vs_RDBLK_SSTRP);
    }
    else {
      SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY();
    }
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    (((this->_base_Speaker).fSub)->fBlockade).flags = 0;
  }
  return;
}

/* ---- Grant__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2079-2098] SLD-VERIFIED ---- */
void DispatchSpeaker::Grant()

{
  if ((this->_base_Speaker).fSub == (Speaker *)0x0) {
    return;
  }
  if (&(this->_base_Speaker).fSub->fBlockade ==
      (SPCHNFSType_vs_RDBLK_SSTRP *)0x0) {
    return;
  }
  Speech_fgSpeech->fSpeakerCar = (Car_tObj *)0x0;
  if (Speech_fgSpeech->fMultiplePerps != 0) {
    return;
  }
  SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(
      &(this->_base_Speaker).fSub->fBlockade,
      &(this->_base_Speaker).fConfirm);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Ready__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:2104-2123] SLD-VERIFIED ---- */
void DispatchSpeaker::Ready(Car_tObj *carObj)

{
  /* SYM-INLINE-LOCAL: Blockade = SetBlockade */
  Speaker *Wing;

  Wing = Speech::Mobile(carObj);
  if ((this->_base_Speaker).HasDifferentSub(Wing)) {
    Wing->SetBlockade((this->_base_Speaker).fSub->fBlockade.flags);
    Wing->VirtualEngage((this->_base_Speaker).fSub->VirtualPerp());
  }
  this->fStatusSub = &this->_base_Speaker;
  this->fStatusCount = 0x80;
  return;
}

/* ---- PickVoice__6SpeechP8Car_tObj  [SPEECH.CPP:2144-2150] SLD-VERIFIED ---- */
int Speech::PickVoice(Car_tObj *carObj)

{
  if ((carObj->carFlags & 0x40U) != 0) {
    return this->fSuperCount++ % 6;
  }
  if ((carObj->carFlags & 0x80U) != 0) {
    return 0;
  }
  return this->fCopCount++ % 9;
}

/* ---- GetVoice__6SpeechP8Car_tObj  [SPEECH.CPP:2156-2157] SLD-VERIFIED ---- */
int Speech::GetVoice(Car_tObj *carObj)

{
  return Speech_fgSpeech->PickVoice(carObj);
}

/* ---- Activate__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2163-2189] SLD-VERIFIED ---- */
void MobileSpeaker::Activate(Car_tObj *carObj)

{
  Speech_tMobileVoiceAttr *a;
  int Voice;
  /* SYM-CODEGEN-CARRIER: iVar3 -- carries the virtual CallSign result into
     the indexed load, then is naturally reused for GameSetup.track.  Direct
     member chaining is two instructions shorter and changes 22 instructions. */
  int iVar3;
  int unit;
  /* MATCH: as in ReActivate, branch-local fVoice assignments keep the merged voice value in
     v0; the scoped pFrom below preserves the virtual-call result as the address-add base. */

  this->fCarObj = carObj;
  Voice = Speech::GetVoice(carObj);
  this->fUnit = Voice;
  a = &Speech_gCopAttr[Voice];
  if ((carObj->carFlags & 0x40U) != 0) {
    this->fUnit = Voice + 9;
    (this->fVoice).flags = 8;
  }
  else {
    (this->fVoice).flags = a->voice;
  }
  iVar3 = (int)(this->_base_Speaker).VirtualCallSign();
  {
    unit = this->fUnit;
    (this->_base_Speaker).fFrom =
        ((CallSignBank *)iVar3)->fMobile[unit];
  }
  iVar3 = GameSetup_gData.track;
  (this->_base_Speaker).fConfirm.flags = 0xff;
  (this->_base_Speaker).fPerpName.flags = 0xf;
  (this->_base_Speaker).fBlockade.flags = 0;
  (this->_base_Speaker).fArrest.flags = 0;
  (this->_base_Speaker).fUpdate.flags = 0;
  this->fPerp = (Car_tObj *)0x0;
  (this->_base_Speaker).fSub = (Speaker *)0x0;
  (this->_base_Speaker).fHavePerp = 0;
  (this->_base_Speaker).fReverse.flags = iVar3 & 1;
  return;
}

/* ---- ReActivate__Q26Speech13MobileSpeaker  [SPEECH.CPP:2199-2212] SLD-VERIFIED ---- */
void MobileSpeaker::ReActivate()

{
  Speech_tMobileVoiceAttr *a;
  int Voice;
  int unit;

  Voice = Speech::GetVoice(this->fCarObj);
  this->fUnit = Voice;
  a = &Speech_gCopAttr[Voice];
  if ((this->fCarObj->carFlags & 0x40U) != 0) {
    this->fUnit = Voice + 9;
    (this->fVoice).flags = 8;
  }
  else {
    (this->fVoice).flags = a->voice;
  }
  unit = (int)(this->_base_Speaker).VirtualCallSign();
  (this->_base_Speaker).fFrom =
      ((CallSignBank *)unit)->fMobile[this->fUnit];
}

/* ---- FindMobile__6SpeechP8Car_tObj  [SPEECH.CPP:2218-2237] SLD-VERIFIED ---- */
Speaker *Speech::FindMobile(Car_tObj *carObj)

{
  /* SYM-CODEGEN-CARRIER: mobile -- the optimized SYM block retains only each
     loop's `i`; spelling the repeated member access directly is four
     instructions shorter and changes 20 oracle instructions. */
  for (int i = 0; i < 4; i++) {
    MobileSpeaker *mobile = this->fMobile[i];

    if (carObj == mobile->fCarObj) {
      return &mobile->_base_Speaker;
    }
  }

  for (int i = 0; i < 4; i++) {
    MobileSpeaker *mobile = this->fMobile[i];

    if (mobile->fCarObj == (Car_tObj *)0x0) {
      mobile->Activate(carObj);
      return &this->fMobile[i]->_base_Speaker;
    }
  }

  return Speech_fgUndefined;
}

/* ---- Mobile__6SpeechP8Car_tObj  [SPEECH.CPP:2244-2250] SLD-VERIFIED ---- */
Speaker *Speech::Mobile(Car_tObj *carObj)

{
  if (Speech_fgSpeech == (Speech *)0x0 ||
      Speech_fgSpeech->fBankOffset == (long *)0x0)
    return Speech_fgUndefined;
  return Speech_fgSpeech->FindMobile(carObj);
}

/* ---- CalcMph__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:2256-2257] SLD-VERIFIED ---- */
int Speaker::CalcMph(Car_tObj *perp)

{
  return fixedmult(0x23ca5,__builtin_abs(perp->linearVel_ch.z)) / 0x10000;
}

/* ---- SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2263-2272] SLD-VERIFIED ---- */
/* MATCH: SYM has no named locals.  The duplicated ternary expressions are
   the retail source shape: gcc keeps the shared division reciprocal in s0,
   re-evaluates fixedmult only on the nonnegative path, and shares the store. */
#define MOBILE_SPEAKER_SPEED(perp, scale) \
  (fixedmult((scale), __builtin_abs((perp)->linearVel_ch.z)) / 0xa0000 - 3)

void MobileSpeaker::SetSpeed(Car_tObj *perp)

{
  if (GameSetup_gData.measurement == 1) {
    (this->fSpeedType).flags = 1;
    this->fSpeed = MOBILE_SPEAKER_SPEED(perp, 0x39999) < 0
        ? 0 : MOBILE_SPEAKER_SPEED(perp, 0x39999);
  }
  else {
    (this->fSpeedType).flags = 2;
    this->fSpeed = MOBILE_SPEAKER_SPEED(perp, 0x23ca5) < 0
        ? 0 : MOBILE_SPEAKER_SPEED(perp, 0x23ca5);
  }
  return;
}
#undef MOBILE_SPEAKER_SPEED

/* ---- DistToPerp__Q26Speech13MobileSpeaker  [SPEECH.CPP:2281-2286] SLD-VERIFIED ---- */
/* MATCH: SYM lists exactly x=$s2, z=$v1, d=$v0.  Expanding the virtual
   coordinate accesses at each source occurrence preserves the retail call
   duplication; signed difference tests produce its subu/blez arm shape. */
#define MOBILE_SPEAKER_COORD(self, slot, offset) \
  (*(int *)(((*(*(self->_base_Speaker)._vf)[slot].pfn) \
      ((int)&(self->_base_Speaker).fPosition.flags + \
       (int)(*(self->_base_Speaker)._vf)[slot].delta)) + (offset)))

int MobileSpeaker::DistToPerp()

{
  int x;
  int z;
  int d;

  if (MOBILE_SPEAKER_COORD(this, 0x19, 0xa0) -
      MOBILE_SPEAKER_COORD(this, 0x1b, 0xa0) > 0) {
    x = MOBILE_SPEAKER_COORD(this, 0x19, 0xa0) -
        MOBILE_SPEAKER_COORD(this, 0x1b, 0xa0);
  }
  else {
    x = MOBILE_SPEAKER_COORD(this, 0x1b, 0xa0) -
        MOBILE_SPEAKER_COORD(this, 0x19, 0xa0);
  }
  if (MOBILE_SPEAKER_COORD(this, 0x19, 0xa8) -
      MOBILE_SPEAKER_COORD(this, 0x1b, 0xa8) > 0) {
    z = MOBILE_SPEAKER_COORD(this, 0x19, 0xa8) -
        MOBILE_SPEAKER_COORD(this, 0x1b, 0xa8);
  }
  else {
    z = MOBILE_SPEAKER_COORD(this, 0x1b, 0xa8) -
        MOBILE_SPEAKER_COORD(this, 0x19, 0xa8);
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
void MobileSpeaker::Report(Car_tObj *perp)

{
  Speaker * Sub;
  Car_tObj *carObj;
  
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  this->_base_Speaker.fTo =
      *(int *)((*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                    ((int)&(this->_base_Speaker).fPosition.flags +
                     (int)(*(this->_base_Speaker)._vf)[0x1e].delta) + 4);
  SPCHNFS_C_A_INTRO(&this->fVoice,this->_base_Speaker.fTo,
                    (this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  this->_base_Speaker.SetCar(perp);
  this->_base_Speaker.FindLocation(perp);
  this->SetSpeed(perp);
  {
    /* SYM-CODEGEN-CARRIER: reportCar -- direct fCar argument preserves 59
       instructions but changes six words. */
    int reportCar = (this->_base_Speaker).fCar;
    /* SYM-CODEGEN-CARRIER: reportLocation -- direct fLocation argument
       preserves 59 instructions but changes four words. */
    int reportLocation = (this->_base_Speaker).fLocation;
    SPCHNFS_C_D_PERP_SIGHTED(&this->fVoice,&(this->_base_Speaker).fColour,
               reportCar,&(this->_base_Speaker).fDistance,
               (SPCHNFSType_POSITION *)this,reportLocation,
               &(this->_base_Speaker).fPerpName);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  *(MobileSpeaker **)((int)Speech::Dispatch() + 0x48) = this;
  return;
}

/* ---- Engage__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2331-2450] SLD-VERIFIED ---- */
void MobileSpeaker::Engage(Car_tObj *perp)

{
  Car_tObj * car;
  /* SYM-CODEGEN-CARRIER: superReady -- retail materializes the nested
     IsSuper/perp/sub predicate before entering the arrival arm; its masked
     producer must also remain separate (see superFlag below). */
  bool superReady;
  /* SYM-CODEGEN-CARRIER: pursuitReady -- retail normalizes pursuitFlag into a
     Boolean before choosing between dispatch replacement and tail insertion. */
  bool pursuitReady;
  /* SYM-CODEGEN-CARRIER: condition -- retail reuses one staged Boolean for the
     status-limit guard and later KnownPerp result; replacing the first phase
     with direct early returns shortens 467 to 464 and leaves 5 diffs. */
  bool condition;
  /* SYM-CODEGEN-CARRIER: repeatReady -- direct sequential guards remain
     count-exact but change 6 instructions around the zero/slti result web. */
  bool repeatReady;
  Car_tObj *carObj;
  /* SYM-OPTIMIZED: Sub -- the repeated inlined Speaker accessors name their
     receiver Sub in debug data; each aliases the active chain node. */
  
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  (this->_base_Speaker).fHavePerp = 1;
  if (perp == (this->_base_Speaker).VirtualPerp())
    goto MSEngage_samePerp;
  this->fPerp = perp;
  this->_base_Speaker.SetCar((this->_base_Speaker).VirtualPerp());
  if (((this->_base_Speaker).VirtualCarObj()->carFlags & 0x200) == 0) {
    Speaker *SubChain;
    Speaker *Sub;
    SubChain = (Speaker *)Speech::Dispatch();
MSEngage_unlinkLoop:
    Sub = SubChain->fSub;
    if (Sub == (Speaker *)0x0) goto MSEngage_dispatchCheck;
    if (Sub != &this->_base_Speaker) {
      SubChain = Sub;
      goto MSEngage_unlinkLoop;
    }
    SubChain->fSub = (this->_base_Speaker).fSub;
    (this->_base_Speaker).fSub = (Speaker *)0x0;
  }
MSEngage_dispatchCheck:
  if (Speech::Dispatch()->fSub == &this->_base_Speaker) {
    if (((this->_base_Speaker).VirtualCarObj()->carFlags & 0x200) == 0) {
      return;
    }
    Speech::Dispatch()->VirtualReport(perp);
    Speech_fgSpeech->fSpeakerCar = this->fCarObj;
    (this->_base_Speaker).fTo =
        (this->_base_Speaker).VirtualCallSign()->fDispatch;
    this->_base_Speaker.FindLocation(
        (this->_base_Speaker).VirtualPerp());
    /* SYM-CODEGEN-CARRIER: replyTo -- direct fTo changes 6 call-setup
       instructions while preserving the 467-instruction count.
       SYM-CODEGEN-CARRIER: replyCar -- direct fCar likewise leaves 6 diffs.
       SYM-CODEGEN-CARRIER: replyLocation -- direct fLocation leaves 4 diffs. */
    int replyTo = (this->_base_Speaker).fTo;
    int replyCar = (this->_base_Speaker).fCar;
    int replyLocation = (this->_base_Speaker).fLocation;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(&this->fVoice,replyTo,
               &(this->_base_Speaker).fColour,replyCar,
               &(this->_base_Speaker).fDistance,(SPCHNFSType_POSITION *)this,
               replyLocation,&(this->_base_Speaker).fConfirm);
    goto MSEngage_emitSpeech;
  }
  superReady = false;
  if ((this->_base_Speaker).VirtualIsSuper()) {
    if (((this->_base_Speaker).VirtualPerp()->carFlags & 4) != 0) {
      if (Speech::Dispatch()->fSub != (Speaker *)0x0) {
        /* SYM-CODEGEN-CARRIER: superFlag -- folding the mask into the Boolean
           grows 467 to 468 and leaves 5 bit-test diffs. */
        u_int superFlag =
            Speech::Dispatch()->fSub->VirtualCarObj()->carFlags & 0x40;
        superReady = superFlag < 1;
      }
    }
  }
  if (superReady) {
    (this->_base_Speaker).fSub = Speech::Dispatch()->fSub;
    Speech::Dispatch()->fSub = &this->_base_Speaker;
    if ((this->_base_Speaker).fBlockade.flags != 0) {
      return;
    }
    (this->_base_Speaker).fTo =
        (this->_base_Speaker).VirtualCallSign()->fAllUnits;
    SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
                      (this->_base_Speaker).fFrom,
                      &(this->_base_Speaker).fReverse);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    SPCHNFS_S_C_SUPER_COP_ARRIVAL(&this->fVoice);
    goto MSEngage_emitSpeech;
  }
  {
    pursuitReady = false;
    Speaker *SubChain = Speech::Dispatch();
    if (Speech::Dispatch()->fSub != (Speaker *)0x0) {
      if (Speech::Dispatch()->fSub->VirtualPerp() != (Car_tObj *)0x0) {
        if ((Speech::Dispatch()->fSub->VirtualPerp()->carFlags & 4) == 0) {
          /* SYM-CODEGEN-CARRIER: pursuitFlag -- folding this mask into the
             comparison is count-exact but changes 4 bit-test instructions. */
          u_int pursuitFlag =
              (this->_base_Speaker).VirtualPerp()->carFlags & 4;
          pursuitReady = 0 < pursuitFlag;
        }
      }
    }
    if (pursuitReady) {
      (this->_base_Speaker).fSub = Speech::Dispatch()->fSub;
      Speech::Dispatch()->fSub = &this->_base_Speaker;
    }
    else {
MSEngage_tailLoop:
      if (SubChain->fSub == (Speaker *)0x0)
        goto MSEngage_tailEnd;
      SubChain = SubChain->fSub;
      goto MSEngage_tailLoop;
MSEngage_tailEnd:
      SubChain->fSub = &this->_base_Speaker;
    }
  if ((this->_base_Speaker).fBlockade.flags != 0) {
    return;
  }
  condition = false;
  if (Speech::Dispatch()->VirtualKnownPerp(perp)) {
    if (Speech::Dispatch()->VirtualStatusCount() > 0x17f)
      goto MSEngage_validateAndProceed;
  }
  condition = true;
MSEngage_validateAndProceed:
  if (!condition) {
    return;
  }
  (this->_base_Speaker).fTo =
      (this->_base_Speaker).VirtualCallSign()->fDispatch;
  SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
             (this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  this->_base_Speaker.FindLocation((this->_base_Speaker).VirtualPerp());
  this->SetSpeed((this->_base_Speaker).VirtualPerp());
  {
  Speaker *Sub = Speech::Dispatch();
  /* SYM-CODEGEN-CARRIER: knownEntry -- spelling slot 18 directly is
     count-exact but leaves 24 vtable/receiver-order diffs.
     SYM-CODEGEN-CARRIER: knownThis -- folding the adjusted receiver into the
     call is count-exact but leaves 30 diffs. */
  __vtbl_ptr_type *knownEntry = &(*Sub->_vf)[18];
  int knownThis = (int)Sub + knownEntry->delta;
  condition =
      (*knownEntry->pfn)(knownThis,
        (this->_base_Speaker).VirtualPerp());
  }
  if (condition) {
    /* SYM-CODEGEN-CARRIER: sightedCar -- direct fCar is count-exact with
       6 call-setup diffs.
       SYM-CODEGEN-CARRIER: sightedLocation -- direct fLocation is count-exact
       with 4 stack/delay-slot diffs. */
    int sightedCar = (this->_base_Speaker).fCar;
    int sightedLocation = (this->_base_Speaker).fLocation;
    SPCHNFS_C_D_PERP_SIGHTED(&this->fVoice,&(this->_base_Speaker).fColour,
               sightedCar,&(this->_base_Speaker).fDistance,
               (SPCHNFSType_POSITION *)this,sightedLocation,
               &(this->_base_Speaker).fPerpName);
  }
  else {
    /* SYM-CODEGEN-CARRIER: engageCar -- direct fCar is count-exact with
       10 call-setup diffs.
       SYM-CODEGEN-CARRIER: engageLocation -- direct fLocation is count-exact
       with 2 stack-argument diffs.
       SYM-CODEGEN-CARRIER: engageSpeed -- direct fSpeed is count-exact with
       8 call-setup/delay-slot diffs. */
    int engageCar = (this->_base_Speaker).fCar;
    int engageLocation = (this->_base_Speaker).fLocation;
    int engageSpeed = this->fSpeed;
    SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(&this->fVoice,&(this->_base_Speaker).fColour,
               engageCar,(SPCHNFSType_POSITION *)this,engageLocation,
               &(this->_base_Speaker).fDistance,engageSpeed,
               &this->fSpeedType,&(this->_base_Speaker).fPerpName)
    ;
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  SubChain = Speech::Dispatch()->fSub;
  Speech::Dispatch()->fSub = &this->_base_Speaker;
  {
  Speaker *Sub = Speech::Dispatch();
  /* SYM-CODEGEN-CARRIER: reportEntry -- direct slot-1 spelling shortens the
     function to 466 and leaves 7 vtable-entry diffs.
     SYM-CODEGEN-CARRIER: reportThis -- folding the adjusted receiver is
     count-exact but leaves 30 diffs.  These are explicit forms of compiler
     virtual-call quantities; SYM records the source receiver as Sub. */
  __vtbl_ptr_type *reportEntry =
      &(*Sub->_vf)[1];
  int reportThis = (int)Sub + reportEntry->delta;
  carObj = (Car_tObj *)(*(*(this->_base_Speaker)._vf)[27].pfn)
      ((int)&(this->_base_Speaker).fPosition.flags +
       (int)(*(this->_base_Speaker)._vf)[27].delta);
  (*reportEntry->pfn)(reportThis,carObj);
  }
  Speech::Dispatch()->fSub = SubChain;
  }
  return;
MSEngage_samePerp:
  repeatReady = false;
  if (Speech_fgSpeech->fMultiplePerps == 0) {
    repeatReady = Speech::Dispatch()->VirtualStatusCount() < 0x160;
  }
  if (!repeatReady) {
    return;
  }
  {
  this->_base_Speaker.SetCar((this->_base_Speaker).VirtualPerp());
  (this->_base_Speaker).fTo =
      (this->_base_Speaker).VirtualCallSign()->fDispatch;
  SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
             (this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  this->_base_Speaker.FindLocation((this->_base_Speaker).VirtualPerp());
  /* SYM-CODEGEN-CARRIER: reacquiredCar -- direct fCar remains count-exact but
     causes 10 call-setup diffs. */
  int reacquiredCar = (this->_base_Speaker).fCar;
  SPCHNFS_C_C_PERP_REAQUIRED(&this->fVoice,&(this->_base_Speaker).fColour,
             reacquiredCar,(SPCHNFSType_POSITION *)this,(this->_base_Speaker).fLocation,
             &(this->_base_Speaker).fDistance);
  }
MSEngage_emitSpeech:
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Lose__Q26Speech13MobileSpeaker  [SPEECH.CPP:2463-2538] SLD-VERIFIED ----
 * NEAR-MISS 3, ours 214 / oracle 213 -- ours is ONE LONG (W60-A9): we emit an extra
 * `addu a0,s0,zero` and issue `lw a2,48(s1)` one slot later than retail.  Ours-longer
 * with a redundant receiver copy = the "cache a pointer the oracle re-derives" class;
 * try inlining the receiver expression at that call site instead of the cached local
 * (catalog: drop the eager whole-pointer cache).
 * W61-A10 RE-DIAGNOSIS (the "cached pointer" reading is WRONG -- do not chase it):
 * the extra insn is a0 SETUP, not a receiver cache.  Retail's `.L800986BC`
 * `bne $v1,$v0,.L800986D8` carries `addu $a0,$s0,$zero` in its DELAY SLOT, so on the
 * BRANCH-TAKEN path $a0 already holds pSVar7 when control reaches `.L800986F0`
 * (PERP_LOST) -- nothing clobbers it in between (`.L800986D8` only tests $s2 and sets
 * $a1 in its own slot).  Retail's PERP_LOST block therefore opens straight with
 * `addu $a3,$s1,$zero`; ours re-materialises `addu $a0,$s0,$zero` first because our
 * RTL has an independent a0 set in that block that reorg never got to delete.  The
 * second diff (a2/v1 load order) rides on it.  So this is a reorg/`redundant_insn`
 * cross-path question, NOT a source-level pointer-caching one; the source levers to
 * price are the ones that change which insn reorg puts in the `bne` slot.
 * W63-A10 SEALED (DUAL-LANE: gate PASS 213/213 + psyqproof REAL=0).  W61-A10's
 * diagnosis was right and the cure was TWO independent one-liners, both in the
 * `Leader`/PERP_LOST else block:
 *  (1) THE ARM-LOCAL LAUNDERED RECEIVER CARRIER kills the extra `addu a0,s0,zero`.
 *      `SPCHNFSType_VOICE *voiceArg = &this->fVoice;` plus a 13B identity launder,
 *      declared at the TOP of the blockade fallback before the Leader split, used
 *      as PERP_LOST's receiver ONLY -- IDLE_WINGMAN keeps direct `&this->fVoice`.
 *      The launder
 *      makes the carrier a GLOBAL allocno (dies twice => combine_regs refuses,
 *      12E), it wins $a0 outright, and its single defining copy is the one retail
 *      carries in the `bne` delay slot -- so the PERP_LOST block opens on
 *      `addu a3,s1,zero` exactly like retail.  MEASURED LADDER (all real gate runs):
 *      plain unlaundered carrier over all four chain calls 3 (inert); over the
 *      inner IDLE/PERP pair 3 (inert); laundered over all four 11@212 (too long);
 *      laundered inner pair with IDLE ALSO switched to the carrier 4@213;
 *      laundered inner pair with IDLE left on direct fVoice 2@213 <= KEPT; moving
 *      the launder below the old staged fColour assignment gave 25@214; declaring
 *      a laundered carrier inside
 *      the PERP_LOST arm itself 3@214 (too late to reach the branch).
 *      => placement is a dial separate from choice (13B), and the carrier must NOT
 *      be shared with the sibling arm or its live range spans both threads.
 *  (2) THE ARG-EVALUATION-ORDER lever: pass the location through the fn-scope
 *      `iVar3` instead of the Ghidra-invented `reg_a1`.  That flips gcc's emission
 *      order of the two folded field loads to retail's `lw a2,48(s1); lw v1,52(s1)`.
 *      The loads are NOT at their statement positions (combine folds each
 *      single-use `(set pseudo (mem))` into the call-sequence arg move), which is
 *      why every statement-order and barrier lever is INERT here -- MEASURED:
 *      swapping the two reads 2; REVINTRO first 2; location read last 2; a void
 *      barrier between the reads / after REVINTRO / with a3 first 2; a read-only
 *      fence on iVar4 2; an identity launder on iVar4 2.  What DOES move it is
 *      WHICH pseudo carries the value: `iVar3` PASS, `reg_a1` 2, `uVar8` 4, a fresh
 *      block-local `perpLoc` 14, the field inlined at the call 14, and swapping the
 *      two carriers (car via reg_a1, loc via iVar4) 6.  Same family as 13A's
 *      "both allocator layers tie-break by NUMBER": the carrier's declaration
 *      position is the dial, not the statement position. */
void MobileSpeaker::Lose()

{
  Speaker * Sub;
  /* SYM-CODEGEN-CARRIER: useLeader -- folding the staged predicate into the
     branch shortens retail's 213-instruction body to 212 and leaves 5 diffs. */
  bool useLeader;
  /* SYM-CODEGEN-CARRIER: iVar3 -- this shared expression-result quantity is
     allocator-significant.  In the PERP_LOST phase a direct fLocation argument
     leaves 14 diffs, while this declaration-position carrier is byte-exact. */
  int iVar3;
  /* SYM-CODEGEN-CARRIER: perpCar -- passing fCar directly to PERP_LOST is
     count-exact but changes six call-setup/delay-slot instructions. */
  int perpCar;
  /* SYM-CODEGEN-CARRIER: outOfRange -- returning from the comparison directly
     shortens the function to 212 instructions and leaves 5 diffs. */
  int outOfRange;
  /* SYM-CODEGEN-CARRIER: savedDispatch -- folding the saved fSub snapshot into
     direct Dispatch() expressions grows the body to 215 and leaves 32 diffs. */
  u_int savedDispatch;
  Speaker *Leader;
  /* SYM-CODEGEN-CARRIER: dispatchThis -- reusing iVar3 for the virtual receiver
     grows the body to 214 instructions and leaves 17 diffs. */
  DispatchSpeaker *dispatchThis;
  /* SYM-CODEGEN-CARRIER: finalDispatch -- reusing dispatchThis for the final
     virtual receiver grows the body to 215 instructions and leaves 30 diffs. */
  DispatchSpeaker *finalDispatch;
  
  /* SYM-OPTIMIZED: carObj -- the line-1 inline Speech expansion consumes
     `this->fCarObj` directly in fSpeakerCar; no ordinary local survives. */
  if ((*(*(this->_base_Speaker)._vf)[0x1b].pfn)
        ((int)&(this->_base_Speaker).fPosition.flags +
         (int)(*(this->_base_Speaker)._vf)[0x1b].delta) != 0) {
    Speech_fgSpeech->fSpeakerCar = this->fCarObj;
    iVar3 = Speech::Dispatch();
    useLeader = false;
    if (((*(int *)(iVar3 + 0x48) != 0) &&
        (iVar3 = Speech::Dispatch(), *(MobileSpeaker **)(*(int *)(iVar3 + 0x48) + 0x48) == this)) &&
       ((this->_base_Speaker).fBlockade.flags == 0)) {
      useLeader = (this->_base_Speaker).fArrest.flags == 0;
    }
    if (useLeader) {
      iVar3 = Speech::Dispatch();
      Leader = *(Speaker **)(iVar3 + 0x48);
      {
        /* MATCH: retail SLD line 2479 owns BOTH calls + the scale + the load +
           the fTo store = ONE fused statement, and the computed base needs its
           own block-scoped variable so gcc mutates it in place (oracle
           `addu s0,s0,v0; lw v0,8(s0)`). [05A LAW + 3.12 #14]  7 -> 3. */
        /* SYM-CODEGEN-CARRIER: bank -- the block-scoped computed base lets GCC
           mutate it in place (`addu s0,s0,v0; lw v0,8(s0)`); the direct fused
           expression is not byte-exact. */
        int *bank = (int *)
            ((int)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                       ((int)&(this->_base_Speaker).fPosition.flags +
                        (int)(*(this->_base_Speaker)._vf)[0x1e].delta) +
             (**(int (**)(...))(*(int *)((int)Leader + 0x4c) + 0x8c))
                       ((int)Leader + *(short *)(*(int *)((int)Leader + 0x4c) + 0x88)) * 4);
        (this->_base_Speaker).fTo = bank[2];
      }
    }
    else {
      Sub = (Speaker *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*(this->_base_Speaker)._vf)[0x1e].delta);
      Leader = (Speaker *)0x0;
      (this->_base_Speaker).fTo = *(int *)((int)Sub + 4);
    }
    if ((this->_base_Speaker).fArrest.flags != 0) {
      SPCHNFS_C_P_FALSE_ARREST_BULLHORN(&this->fVoice);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    else {
      outOfRange = 0;
      if (((this->_base_Speaker).fBlockade.flags == 0) && (Leader == (Speaker *)0x0)) {
        dispatchThis = (DispatchSpeaker *)Speech::Dispatch();
        iVar3 = (*(*(dispatchThis->_base_Speaker)._vf)[0x15].pfn)
                          ((int)&(dispatchThis->_base_Speaker).fPosition.flags +
                           (int)(*(dispatchThis->_base_Speaker)._vf)[0x15].delta);
        outOfRange = (iVar3 < 0x161) ^ 1;
      }
      if (outOfRange != 0) {
        return;
      }
    }
    iVar3 = (this->_base_Speaker).fTo;
    SPCHNFS_C_A_INTRO(
      &this->fVoice,iVar3,(this->_base_Speaker).fFrom,
      &(this->_base_Speaker).fReverse);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    this->_base_Speaker.SetCar((Car_tObj *)
      (*(*(this->_base_Speaker)._vf)[0x1b].pfn)
        ((int)&(this->_base_Speaker).fPosition.flags +
         (int)(*(this->_base_Speaker)._vf)[0x1b].delta));
    this->_base_Speaker.FindLocation((Car_tObj *)
      (*(*(this->_base_Speaker)._vf)[0x1b].pfn)
        ((int)&(this->_base_Speaker).fPosition.flags +
         (int)(*(this->_base_Speaker)._vf)[0x1b].delta));
    if ((this->_base_Speaker).fArrest.flags != 0) {
      SPCHNFS_C_D_DURING_FALSE_ARREST(
        &this->fVoice,&(this->_base_Speaker).fPerpName);
    }
    else {
      iVar3 = (*(*(this->_base_Speaker)._vf)[0x19].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*(this->_base_Speaker)._vf)[0x19].delta);
      if ((*(u_int *)(iVar3 + 0x260) & 0x200) != 0) {
        SPCHNFS_C_D_ENDGAME(&this->fVoice);
      }
      else {
        if ((this->_base_Speaker).fBlockade.flags == 1) {
          SPCHNFS_C_D_SPBLT_FAILED(
            &this->fVoice,&(this->_base_Speaker).fColour,
            (this->_base_Speaker).fCar);
        }
        else if ((this->_base_Speaker).fBlockade.flags == 2) {
          SPCHNFS_C_D_RDBLK_FAILED(
            &this->fVoice,&(this->_base_Speaker).fColour,
            (this->_base_Speaker).fCar);
        }
        else {
          /* MATCH: arm-local laundered receiver carrier -- see the header block.
             The launder makes it a GLOBAL allocno that wins $a0 outright, so its
             single defining copy is retail's `bne` delay-slot `addu a0,s0,zero`
             and the PERP_LOST block opens on `addu a3,s1,zero`.  Must stay ABOVE
             the fColour assignment and must NOT be shared with the IDLE arm. */
          /* SYM-CODEGEN-CARRIER: voiceArg -- the zero-byte identity carrier is
             required for retail's cross-path a0 allocation; the measured ladder
             and placement constraints are recorded in the function header. */
          SPCHNFSType_VOICE *voiceArg = &this->fVoice;
          /* W85-S2: an INERT zero-insn fence was deleted here -- measured 102/102
             PASS alone and as the pair {SubmitRequest, MobileSpeaker::Lose}. */
          if (Leader != (Speaker *)0x0) {
            SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(&this->fVoice);
          }
          else {
            perpCar = (this->_base_Speaker).fCar;
            iVar3 = (this->_base_Speaker).fLocation;
            SPCHNFS_C_D_PERP_LOST(voiceArg,&(this->_base_Speaker).fColour,
                       perpCar,
                       (SPCHNFSType_POSITION *)this,
                       iVar3,&(this->_base_Speaker).fDistance,
                       &(this->_base_Speaker).fPerpName);
          }
        }
      }
    }
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    (this->_base_Speaker).fBlockade.flags = 0;
    (this->_base_Speaker).fArrest.flags = 0;
    (this->_base_Speaker).fUpdate.flags = 0;
    if (Leader == (Speaker *)0x0) {
      iVar3 = Speech::Dispatch();
      savedDispatch = *(u_int *)(iVar3 + 0x48);
      iVar3 = Speech::Dispatch();
      *(MobileSpeaker **)(iVar3 + 0x48) = this;
      finalDispatch = (DispatchSpeaker *)Speech::Dispatch();
      (*(*(finalDispatch->_base_Speaker)._vf)[0xe].pfn)
                ((int)&(finalDispatch->_base_Speaker).fPosition.flags +
                 (int)(*(finalDispatch->_base_Speaker)._vf)[0xe].delta);
      iVar3 = Speech::Dispatch();
      *(u_int *)(iVar3 + 0x48) = savedDispatch;
    }
  }
  return;
}

/* ---- Accident__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2544-2548] SLD-VERIFIED ---- */
void MobileSpeaker::Accident(int slice)

{
  return;
}

/* ---- Catch__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2554-2621] SLD-VERIFIED ---- */
void MobileSpeaker::Catch(int ticket)

{
  /* The repeated line-14/27 SLD `Speaker *this` scopes are the inline field
     and virtual operations below.  One receipt is retained per expansion.
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualPerp
     SYM-INLINE-THIS: VirtualCallSign
     SYM-INLINE-THIS: VirtualCallSign
     SYM-INLINE-THIS: Location
     SYM-INLINE-THIS: Location
     SYM-INLINE-THIS: Distance
     SYM-INLINE-THIS: Colour
     SYM-INLINE-THIS: VirtualClearPerp */
  /* SYM-OPTIMIZED: carObj -- the nested debug quantity is the direct
     fCarObj RHS consumed by the Speech::fSpeakerCar store; materializing it
     as a C++ local reverses the two retail loads and gives six diffs. */
  /* SYM-OPTIMIZED: Arrest -- the inlined arrest-phrase helper reuses the
     incoming `ticket` value in $s0, so no second source object survives. */

  if ((this->_base_Speaker).VirtualPerp() != 0) {
    Speech_fgSpeech->fSpeakerCar = this->fCarObj;
    if (*(int *)((int)(this->_base_Speaker).VirtualPerp() + 300) < 0) {
      (this->_base_Speaker).fTo =
          (this->_base_Speaker).VirtualCallSign()->fDispatch;
      SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
                        (this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      this->_base_Speaker.FindLocation(
          (this->_base_Speaker).VirtualPerp());
      SPCHNFS_C_D_PERP_CRASH_ROLL(&this->fVoice,(SPCHNFSType_POSITION *)this,
                 (this->_base_Speaker).Location(),
                 (this->_base_Speaker).Distance(),
                 &(this->_base_Speaker).fPerpName);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      (this->_base_Speaker).fAmbulance.flags = 4;
      SPCHNFS_C_D_REQUEST_EMS(&this->fVoice,&(this->_base_Speaker).fAmbulance);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      goto Catch_dispatchCallback;
    }
    else {
      if (*(int *)((int)(this->_base_Speaker).VirtualPerp() + 0x78c) != 0) {
        (this->_base_Speaker).fTo =
            (this->_base_Speaker).VirtualCallSign()->fDispatch;
        SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
                          (this->_base_Speaker).fFrom,&(this->_base_Speaker).fReverse);
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        this->_base_Speaker.SetCar((this->_base_Speaker).VirtualPerp());
        this->_base_Speaker.FindLocation(
            (this->_base_Speaker).VirtualPerp());
        SPCHNFS_C_D_PERP_CRASH_GEN(&this->fVoice,(SPCHNFSType_POSITION *)this,
                 (this->_base_Speaker).Location(),(this->_base_Speaker).Colour(),
                 (this->_base_Speaker).fCar,&(this->_base_Speaker).fDistance,
                 &(this->_base_Speaker).fPerpName);
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        (this->_base_Speaker).fAmbulance.flags = 0x20;
        SPCHNFS_C_D_REQUEST_EMS(&this->fVoice,&(this->_base_Speaker).fAmbulance);
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        goto Catch_dispatchCallback;
      }
      else {
        (this->_base_Speaker).fArrest.flags = ticket;
        if (ticket == 1) {
          SPCHNFS_C_P_ARRESTED(&this->fVoice,&(this->_base_Speaker).fArrest);
        }
        else if (ticket == 2) {
          SPCHNFS_C_P_WARNING(&this->fVoice,&(this->_base_Speaker).fArrest);
        }
        else {
          SPCHNFS_C_P_TICKET(&this->fVoice,&(this->_base_Speaker).fArrest);
        }
        SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
        if (ticket == 1) {
          Speech_fgSpeech->SetDelayedStatus(&this->_base_Speaker,0x60);
        }
        goto Catch_dispatchCallback;
      }
    }
Catch_dispatchCallback:
    Speech::Dispatch()->VirtualClearPerp(this->fPerp);
  }
}

/* ---- RoadBlock__Q26Speech13MobileSpeaker  [SPEECH.CPP:2627-2648] SLD-VERIFIED ---- */
void MobileSpeaker::RoadBlock()

{
  Car_tObj *carObj;
  /* SYM-CODEGEN-CARRIER: ctx -- folding the staged dispatch comparison into
     the condition removes two instructions and leaves six diffs (67/69). */
  SPCHNFSType_VOICE *ctx;
  /* SYM-CODEGEN-CARRIER: dispatch -- reusing ctx for the three Dispatch()
     results adds two instructions and produces ten diffs (71/69). */
  Speaker *dispatch;
  
  dispatch = (Speaker *)Speech::Dispatch();
  ctx = (SPCHNFSType_VOICE *)0;
  if (dispatch->fSub != 0) {
    dispatch = (Speaker *)Speech::Dispatch();
    ctx = (SPCHNFSType_VOICE *)((u_int)ctx <
          ((u_int)dispatch->fSub ^ (u_int)this));
  }
  if (ctx != (SPCHNFSType_VOICE *)0) {
    dispatch = (Speaker *)Speech::Dispatch();
    dispatch = dispatch->fSub;
    (*(*dispatch->_vf)[10].pfn)((int)&dispatch->fPosition.flags + (int)(*dispatch->_vf)[10].delta);
  }
  else {
    this->_base_Speaker.Promote();
    if (Speech_fgSpeech->fMultiplePerps == 0) {
      Speech_fgSpeech->fSpeakerCar = this->fCarObj;
      (this->_base_Speaker).fTo = *(int *)((*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*(this->_base_Speaker)._vf)[0x1e].delta) + 4);
      SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,(this->_base_Speaker).fFrom,
                        &(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_RDBLK(&this->fVoice);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    (this->_base_Speaker).fBlockade.flags = 2;
  }
  return;
}

/* ---- SpikeBelt__Q26Speech13MobileSpeaker  [SPEECH.CPP:2656-2677] SLD-VERIFIED ---- */
void MobileSpeaker::SpikeBelt()

{
  Car_tObj *carObj;
  /* SYM-CODEGEN-CARRIER: ctx -- folding the staged dispatch comparison into
     the condition removes two instructions and leaves six diffs (67/69). */
  SPCHNFSType_VOICE *ctx;
  /* SYM-CODEGEN-CARRIER: dispatch -- reusing ctx for the three Dispatch()
     results adds two instructions and produces ten diffs (71/69). */
  Speaker *dispatch;
  
  dispatch = (Speaker *)Speech::Dispatch();
  ctx = (SPCHNFSType_VOICE *)0;
  if (dispatch->fSub != 0) {
    dispatch = (Speaker *)Speech::Dispatch();
    ctx = (SPCHNFSType_VOICE *)((u_int)ctx <
          ((u_int)dispatch->fSub ^ (u_int)this));
  }
  if (ctx != (SPCHNFSType_VOICE *)0) {
    dispatch = (Speaker *)Speech::Dispatch();
    dispatch = dispatch->fSub;
    (*(*dispatch->_vf)[11].pfn)((int)&dispatch->fPosition.flags + (int)(*dispatch->_vf)[11].delta);
  }
  else {
    this->_base_Speaker.Promote();
    if (Speech_fgSpeech->fMultiplePerps == 0) {
      Speech_fgSpeech->fSpeakerCar = this->fCarObj;
      (this->_base_Speaker).fTo = *(int *)((*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                        ((int)&(this->_base_Speaker).fPosition.flags + (int)(*(this->_base_Speaker)._vf)[0x1e].delta) + 4);
      SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,(this->_base_Speaker).fFrom,
                        &(this->_base_Speaker).fReverse);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_SPBLT(&this->fVoice);
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    (this->_base_Speaker).fBlockade.flags = 1;
  }
  return;
}

/* ---- Backup__Q26Speech13MobileSpeaker  [SPEECH.CPP:2685-2705] SLD-VERIFIED ---- */
void MobileSpeaker::Backup()

{
  Car_tObj *carObj;

  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  (this->_base_Speaker).fTo = *(int *)
      ((*(*(this->_base_Speaker)._vf)[0x1e].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*(this->_base_Speaker)._vf)[0x1e].delta) + 4);
  SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
                    (this->_base_Speaker).fFrom,
                    &(this->_base_Speaker).fReverse);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  this->_base_Speaker.SetCar((Car_tObj *)
      (*(*(this->_base_Speaker)._vf)[0x1b].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*(this->_base_Speaker)._vf)[0x1b].delta));
  this->_base_Speaker.FindLocation((Car_tObj *)
      (*(*(this->_base_Speaker)._vf)[0x19].pfn)
          ((int)&(this->_base_Speaker).fPosition.flags +
           (int)(*(this->_base_Speaker)._vf)[0x19].delta));
  {
    /* SYM-CODEGEN-CARRIER: requestCar -- the staged third argument leaves the
       `this` copy in the jal delay slot.  Passing fCar directly is count-exact
       but reverses those two setup instructions (6 diffs). */
    int requestCar = (this->_base_Speaker).fCar;
    SPCHNFS_C_D_REQUEST_BKUP(&this->fVoice,&(this->_base_Speaker).fColour,
               requestCar,(SPCHNFSType_POSITION *)this,
               (this->_base_Speaker).fLocation,
               &(this->_base_Speaker).fDistance);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  (this->_base_Speaker).fBlockade.flags = 0;
  return;
}

/* ---- Roger__Q26Speech13MobileSpeaker  [SPEECH.CPP:2711-2733] SLD-VERIFIED ----
 * MATCH (W77-root): source-only PASS 94/94; the old W60 TEXT_MOVES row is now
 * inactive (disabled-row and standard objects have identical SHA-256 hashes).
 * Splitting the two virtual-call results exposes the retail boundary after the
 * second jalr.  A tied, zero-byte confirmVoice launder there births the call's
 * a0 copy before the bank-index chain.  Its three extra read operands are the
 * minimum allocator dial: production GCC dumps + allocsim match 4/4 and show
 * p85 at refs/live 8/34 (s1), just ahead of p80 at 20/126 (s2); two operands
 * fall back to the count-exact 48-diff whole-function s1/s2 swap.  Search path:
 * baseline 2 -> desired schedule/wrong allocation 48 -> PASS.  Fixed prototype,
 * split fTo staging, ordinary locals, and an inline wrapper were inert at 2. */
void MobileSpeaker::Roger()

{
  /* SYM-CODEGEN-CARRIER: isStatusSub -- folding the staged predicate into the
     condition shortens the body to 92 instructions and leaves 6 diffs. */
  bool isStatusSub;
  /* SYM-CODEGEN-CARRIER: elseBankBase -- inlining this virtual result is
     count-exact but causes a 50-diff whole-function s1/s2 allocation swap. */
  int elseBankBase;
  /* SYM-CODEGEN-CARRIER: voice -- direct fVoice expressions shorten the body
     to 92 instructions and cause a 50-diff s1/s2 allocation swap. */
  SPCHNFSType_VOICE *voice;
  
  /* SYM-OPTIMIZED: carObj -- the line-1 inline Speech expansion consumes
     `this->fCarObj` directly in fSpeakerCar; no ordinary local survives. */
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  isStatusSub = false;
  if ((this->_base_Speaker).fSub != (Speaker *)0x0) {
    isStatusSub = Speech::Dispatch()->VirtualStatusSub() ==
        (this->_base_Speaker).fSub;
  }
  if (isStatusSub) {
    /* SYM-CODEGEN-CARRIER: bank -- replacing the computed alias with
       bankBase[bankIndex + 2] is count-exact but changes four instructions;
       mutating bankBase instead shortens the body to 92 with 16 diffs. */
    int *bank;
    /* SYM-CODEGEN-CARRIER: bankBase -- folding this first virtual result into
       the sum grows the body to 96 instructions and leaves 78 diffs. */
    int *bankBase;
    /* SYM-CODEGEN-CARRIER: bankIndex -- folding this second virtual result into
       the sum grows the body to 96 instructions and leaves 70 diffs. */
    int bankIndex;
    /* SYM-CODEGEN-CARRIER: confirmVoice -- this zero-byte identity carrier and
       its three priced read operands reproduce retail's s1/s2 allocation; the
       allocator receipt and failed two-operand variant are recorded above. */
    SPCHNFSType_VOICE *confirmVoice;

    voice = &this->fVoice;
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    bankBase = (int *)(*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                   ((int)&(this->_base_Speaker).fPosition.flags +
                    (int)(*(this->_base_Speaker)._vf)[0x1e].delta);
    bankIndex = (*(*(this->_base_Speaker).fSub->_vf)[0x11].pfn)
                   ((int)&(this->_base_Speaker).fSub->fPosition.flags +
                    (int)(*(this->_base_Speaker).fSub->_vf)[0x11].delta);
    confirmVoice = voice;
    __asm__("" : "=r"(confirmVoice)
               : "0"(confirmVoice), "r"(confirmVoice), "r"(confirmVoice),
                 "r"(confirmVoice));
    bank = bankBase + bankIndex;
    SPCHNFS_C_A_CONFIRM(confirmVoice,
      (this->_base_Speaker).fTo = bank[2],
      &(this->_base_Speaker).fConfirm);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    this->_base_Speaker.SetCar((Car_tObj *)
      (*(*(this->_base_Speaker)._vf)[0x1b].pfn)
        ((int)&(this->_base_Speaker).fPosition.flags +
         (int)(*(this->_base_Speaker)._vf)[0x1b].delta));
    SPCHNFS_C_C_IN_PURS_NEAR_PERP(
      voice,&(this->_base_Speaker).fColour,(this->_base_Speaker).fCar);
  }
  else {
    elseBankBase = (*(*(this->_base_Speaker)._vf)[0x1e].pfn)
                      ((int)&(this->_base_Speaker).fPosition.flags +
                       (int)(*(this->_base_Speaker)._vf)[0x1e].delta);
    voice = &this->fVoice;
    SPCHNFS_C_A_CONFIRM(
      voice,
      (this->_base_Speaker).fTo = *(int *)(elseBankBase + 4),
      &(this->_base_Speaker).fConfirm);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Bullhorn__Q26Speech13MobileSpeaker  [SPEECH.CPP:2741-2748] SLD-VERIFIED ---- */
void MobileSpeaker::Bullhorn()

{
  /* SYM-OPTIMIZED: carObj -- the inline fCarObj accessor is consumed directly
     by the assignment to Speech::fSpeakerCar. */
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  SPCHNFS_C_P_BULLHORN_SPEECH(&this->fVoice);
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Purge__Q26Speech13MobileSpeaker  [SPEECH.CPP:2754-2839] SLD-VERIFIED ---- */
void MobileSpeaker::Purge()

{
  Speaker *Chain;
  
  if (this->fCarObj == (Car_tObj *)0x0) {
    return;
  }
  if ((*(u_int *)((int)(this->_base_Speaker).VirtualCarObj() + 0x260) &
       0x200) != 0) {
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
    if ((this->_base_Speaker).VirtualPerp() != (Car_tObj *)0x0 &&
        AudioMus_Threshold() != 0) {
      if (stackSpeedUpEnbabledFlag != 0) {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        AudioMus_StopSong(500);
        AudioMus_PlaySong((char *)0x0);
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 1;
        (this->_base_Speaker).fBlockade.flags = 0;
        goto Purge_resetSpeakerFields;
      }
      AudioMus_StopSong(500);
      AudioMus_PlaySong((char *)0x0);
    }
    (this->_base_Speaker).fBlockade.flags = 0;
Purge_resetSpeakerFields:
    (this->_base_Speaker).fArrest.flags = 0;
    (this->_base_Speaker).fUpdate.flags = 0;
    this->fPerp = (Car_tObj *)0x0;
    (this->_base_Speaker).fSub = (Speaker *)0x0;
    return;
  }

  this->fCarObj = (Car_tObj *)0x0;
  if (Speech::Dispatch()->VirtualStatusSub() == (Speaker *)this) {
    Speech::Dispatch()->VirtualPurgeStatusSub();
  }
  Chain = (Speaker *)Speech::Dispatch();
Purge_findChain:
  if (Chain->fSub == (Speaker *)this) {
    goto Purge_unlinkChain;
  }
  if (Chain->fSub == (Speaker *)0x0) {
    return;
  }
  Chain = Chain->fSub;
  goto Purge_findChain;
Purge_unlinkChain:
  Chain->fSub = (this->_base_Speaker).fSub;
}

/* ---- ReportBlockade__Q26Speech13MobileSpeaker  [SPEECH.CPP:2843-2861] SLD-VERIFIED ---- */
void MobileSpeaker::ReportBlockade()

{
  Car_tObj *carObj;
  /* SYM-CODEGEN-CARRIER: DISTANCE -- staging the arm-dependent fourth macro
     argument preserves retail's addiu/lw/jal order; direct field arguments
     remain 63/63 but move the addiu into the jal delay slot (6 diffs). */
  SPCHNFSType_DISTANCE *DISTANCE;
  
  Speech_fgSpeech->fSpeakerCar = this->fCarObj;
  /* MATCH: re-read `_vf` INLINE at every use (the sibling PASSing fns' idiom).
     A hoisted `pa_Var1 = _vf;` local is a Ghidra artifact: it becomes its own
     pseudo ($v1) so the pfn load can't reuse the vtable base reg -- oracle
     `lw v0,76(s1); lh a0,240(v0); lw v0,244(v0)` (self-temp). 6 -> 0. */
  (this->_base_Speaker).fTo = *(int *)
      ((*(*(this->_base_Speaker)._vf)[0x1e].pfn)
         ((int)&(this->_base_Speaker).fPosition.flags +
          (int)(*(this->_base_Speaker)._vf)[0x1e].delta) + 4);
  carObj = (Car_tObj *)
        (*(*(this->_base_Speaker)._vf)[0x19].pfn)
                  ((int)&(this->_base_Speaker).fPosition.flags +
                   (int)(*(this->_base_Speaker)._vf)[0x19].delta);
  this->_base_Speaker.FindLocation(carObj);
  (this->_base_Speaker).fSpikeSide.flags = 4;
  /* MATCH: keep `&this->fVoice` inside each arm.  Hoisting it above the `if`
     creates a pre-branch pseudo (`addiu s1,s0,80` in the bne delay slot) and
     flips the whole s0<->s1 map.  Arm-local expressions rematerialize the
     address directly in $a0, including the else-arm delay-slot fill. */
  if ((this->_base_Speaker).fBlockade.flags == 2) {
    SPCHNFS_C_A_INTRO(&this->fVoice,(this->_base_Speaker).fTo,
                      (this->_base_Speaker).fFrom,
                      &(this->_base_Speaker).fReverse);
    SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    DISTANCE = &(this->_base_Speaker).fDistance;
    SPCHNFS_W_D_RDBLK_PLC(&this->fVoice,(SPCHNFSType_POSITION *)this,
                          (this->_base_Speaker).fLocation,DISTANCE);
  }
  else {
    DISTANCE = (SPCHNFSType_DISTANCE *)(this->_base_Speaker).fFrom;
    SPCHNFS_W_D_SPBLT_PLC(&this->fVoice,(SPCHNFSType_POSITION *)this,
               &(this->_base_Speaker).fSpikeSide,(int)DISTANCE,
               (this->_base_Speaker).fLocation,&(this->_base_Speaker).fDistance);
  }
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Perp__Q26Speech13MobileSpeaker  [SPEECH.CPP:147-147] SLD-VERIFIED ---- */
Car_tObj *MobileSpeaker::Perp()

{
  return this->fPerp;
}

/* ---- Unit__Q26Speech13MobileSpeaker  [SPEECH.CPP:134-135] SLD-VERIFIED ---- */
int MobileSpeaker::Unit()

{
  return this->fUnit;
}

/* ---- CallSign__Q26Speech13MobileSpeaker  [SPEECH.CPP:130-135] SLD-FLAG:NONMONO ---- */
CallSignBank *MobileSpeaker::CallSign()

{
  return &Speech_fgSpeech->fCallSignBank.Mobile;
}

/* ---- FindClosestLocationTo__Q26Speech13MobileSpeakeri  [SPEECH.CPP:126-131] SLD-FLAG:NONMONO ---- */
LocationBank *MobileSpeaker::FindClosestLocationTo(int slice)

{
  return Speech_fgSpeech->FindClosestLocationTo(
      Speech_fgSpeech->fLocationBank.Mobile,slice);
}

/* ---- GetCarBank__Q26Speech13MobileSpeakeri  [SPEECH.CPP:122-127] SLD-FLAG:NONMONO ---- */
CarBank *MobileSpeaker::GetCarBank(int carIndex)

{
  return &Speech_fgSpeech->fCarBank.Mobile[carIndex];
}

/* ---- CarObj__Q26Speech13MobileSpeaker  [SPEECH.CPP:114-114] SLD-VERIFIED ---- */
Car_tObj *MobileSpeaker::CarObj()

{
  return this->fCarObj;
}

/* ---- IsSuper__Q26Speech13MobileSpeaker  [SPEECH.CPP:106-106] SLD-VERIFIED ---- */
bool MobileSpeaker::IsSuper()

{
  return (u_int)this->fCarObj->carFlags >> 6 & 1;
}

/* ---- CallSign__Q26Speech15DispatchSpeaker  [SPEECH.CPP:73-74] SLD-VERIFIED ---- */
CallSignBank *DispatchSpeaker::CallSign()

{
  return &Speech_fgSpeech->fCallSignBank.Dispatch;
}

/* ---- FindClosestLocationTo__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:69-74] SLD-FLAG:NONMONO ---- */
LocationBank *DispatchSpeaker::FindClosestLocationTo(int slice)

{
  return Speech_fgSpeech->FindClosestLocationTo(
      Speech_fgSpeech->fLocationBank.Dispatch,slice);
}

/* ---- GetCarBank__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:65-70] SLD-FLAG:NONMONO ---- */
CarBank *DispatchSpeaker::GetCarBank(int carIndex)

{
  return &Speech_fgSpeech->fCarBank.Dispatch[carIndex];
}

/* ---- PurgeStatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:58-66] SLD-FLAG:NONMONO ---- */
void DispatchSpeaker::PurgeStatusSub()

{
  this->fStatusSub = (Speaker *)0x0;
  return;
}

/* ---- StatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:57-58] SLD-VERIFIED ---- */
Speaker *DispatchSpeaker::StatusSub()

{
  return this->fStatusSub;
}

/* ---- StatusCount__Q26Speech15DispatchSpeaker  [SPEECH.CPP:56-57] SLD-VERIFIED ---- */
int DispatchSpeaker::StatusCount()

{
  return this->fStatusCount;
}

/* base Speech::Speaker virtual not separately reconstructed (vtable-only ref, surfaced by #75
 * data-materialization); faithful from nfs4-f.exe @0x80099364 = { jr $ra; addiu $v0,$zero,0 }
 * W60-A9: moved here from the file tail to restore retail VA emission order (tu_order_audit
 * inversion: 0x80099364 sits between StatusCount__...DispatchSpeaker and FindClosestLocationTo). */
CallSignBank *Speaker::CallSign()   /* @0x80099364  CallSign__Q26Speech7Speaker -> NULL */
{
  return (CallSignBank *)0;
}

/* ---- FindClosestLocationTo__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
LocationBank *Speaker::FindClosestLocationTo(int slice)

{
  return (LocationBank *)0x0;
}

/* ---- GetCarBank__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
CarBank *Speaker::GetCarBank(int carIndex)

{
  return (CarBank *)0x0;
}

/* ---- Perp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj *Speaker::Perp()

{
  return (Car_tObj *)0x0;
}

/* ---- ReActivate__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speaker::ReActivate()

{
  return;
}

/* ---- CarObj__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj *Speaker::CarObj()

{
  return (Car_tObj *)0x0;
}

/* ---- DistToPerp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speaker::DistToPerp()

{
  return 0x3e80000;
}

/* ---- PurgeStatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speaker::PurgeStatusSub()

{
  return;
}

/* ---- StatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Speaker *Speaker::StatusSub()

{
  return (Speaker *)0x0;
}

/* ---- StatusCount__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speaker::StatusCount()

{
  return 0;
}

/* ---- IsSuper__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
bool Speaker::IsSuper()

{
  return false;
}

/* ---- ClearPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speaker::ClearPerp(Car_tObj *car)

{
  return;
}

/* ---- KnownPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
bool Speaker::KnownPerp(Car_tObj *car)

{
  return false;
}

/* ---- Unit__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speaker::Unit()

{
  return 0;
}

/* ---- Status__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speaker::Status()

{
  return;
}

/* ---- #75 data-materialization: 3 Speech vtables (nested Speech::<Leaf>, flat <Leaf>_<Method> pfns). ---- */
/* Compiler-emitted empty type-name/literal slot between strings and vtables. */
extern const char Speech_vtableTypeName[4] __asm__("D_80055BD0")
    __attribute__((section(".rodata"))) = "";
const __vtbl_ptr_type MobileSpeaker_vtable[31] __asm__("_vt_Q26Speech13MobileSpeaker") = {   /* @0x80055bd4  Speech::MobileSpeaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
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
  {0, 0, (int (*)(...))&Speech_Speaker_KnownPerp},          /* @0x80055c64  KnownPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Speech_Speaker_ClearPerp},          /* @0x80055c6c  ClearPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&IsSuper__Q26Speech13MobileSpeaker},      /* @0x80055c74  IsSuper__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Speech_Speaker_StatusCount},        /* @0x80055c7c  StatusCount__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_StatusSub},          /* @0x80055c84  StatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_PurgeStatusSub},     /* @0x80055c8c  PurgeStatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&DistToPerp__Q26Speech13MobileSpeaker},   /* @0x80055c94  DistToPerp__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&CarObj__Q26Speech13MobileSpeaker},       /* @0x80055c9c  CarObj__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&ReActivate__Q26Speech13MobileSpeaker},   /* @0x80055ca4  ReActivate__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&Perp__Q26Speech13MobileSpeaker},         /* @0x80055cac  Perp__Q26Speech13MobileSpeaker */
  {0, 0, (int (*)(...))&GetCarBank__Q26Speech13MobileSpeakeri},   /* @0x80055cb4  GetCarBank__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&FindClosestLocationTo__Q26Speech13MobileSpeakeri}, /* @0x80055cbc  FindClosestLocationTo__Q26Speech13MobileSpeakeri */
  {0, 0, (int (*)(...))&CallSign__Q26Speech13MobileSpeaker},     /* @0x80055cc4  CallSign__Q26Speech13MobileSpeaker */
};
const __vtbl_ptr_type DispatchSpeaker_vtable[31] __asm__("_vt_Q26Speech15DispatchSpeaker") = {   /* @0x80055ccc  Speech::DispatchSpeaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
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
  {0, 0, (int (*)(...))&Speech_Speaker_Unit},               /* @0x80055d54  Unit__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj},  /* @0x80055d5c  KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj},  /* @0x80055d64  ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Speech_Speaker_IsSuper},            /* @0x80055d6c  IsSuper__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&StatusCount__Q26Speech15DispatchSpeaker}, /* @0x80055d74  StatusCount__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&StatusSub__Q26Speech15DispatchSpeaker},  /* @0x80055d7c  StatusSub__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&PurgeStatusSub__Q26Speech15DispatchSpeaker}, /* @0x80055d84  PurgeStatusSub__Q26Speech15DispatchSpeaker */
  {0, 0, (int (*)(...))&Speech_Speaker_DistToPerp},         /* @0x80055d8c  DistToPerp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_CarObj},             /* @0x80055d94  CarObj__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_ReActivate},         /* @0x80055d9c  ReActivate__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_Perp},               /* @0x80055da4  Perp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&GetCarBank__Q26Speech15DispatchSpeakeri}, /* @0x80055dac  GetCarBank__Q26Speech15DispatchSpeakeri */
  {0, 0, (int (*)(...))&FindClosestLocationTo__Q26Speech15DispatchSpeakeri}, /* @0x80055db4  FindClosestLocationTo__Q26Speech15DispatchSpeakeri */
  {0, 0, (int (*)(...))&CallSign__Q26Speech15DispatchSpeaker},   /* @0x80055dbc  CallSign__Q26Speech15DispatchSpeaker */
};
const __vtbl_ptr_type Speaker_vtable[31] __asm__("_vt_Q26Speech7Speaker") = {   /* @0x80055dc4  Speech::Speaker vtable (#75 data-mat; faithful nfs4-f.exe bytes) */
  {0, 0, (int (*)(...))0},                           /* @0x80055dc4  null */
  {0, 0, (int (*)(...))&Report__Q26Speech7SpeakerP8Car_tObj},             /* @0x80055dcc  Report__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Speech_Speaker_Status},             /* @0x80055dd4  Status__Q26Speech7Speaker */
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
  {0, 0, (int (*)(...))&Speech_Speaker_Unit},               /* @0x80055e4c  Unit__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_KnownPerp},          /* @0x80055e54  KnownPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Speech_Speaker_ClearPerp},          /* @0x80055e5c  ClearPerp__Q26Speech7SpeakerP8Car_tObj */
  {0, 0, (int (*)(...))&Speech_Speaker_IsSuper},            /* @0x80055e64  IsSuper__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_StatusCount},        /* @0x80055e6c  StatusCount__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_StatusSub},          /* @0x80055e74  StatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_PurgeStatusSub},     /* @0x80055e7c  PurgeStatusSub__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_DistToPerp},         /* @0x80055e84  DistToPerp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_CarObj},             /* @0x80055e8c  CarObj__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_ReActivate},         /* @0x80055e94  ReActivate__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_Perp},               /* @0x80055e9c  Perp__Q26Speech7Speaker */
  {0, 0, (int (*)(...))&Speech_Speaker_GetCarBank},         /* @0x80055ea4  GetCarBank__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&Speech_Speaker_FindClosestLocationTo}, /* @0x80055eac  FindClosestLocationTo__Q26Speech7Speakeri */
  {0, 0, (int (*)(...))&Speech_Speaker_CallSign},           /* @0x80055eb4  CallSign__Q26Speech7Speaker */
};

/* end of speech.cpp */
