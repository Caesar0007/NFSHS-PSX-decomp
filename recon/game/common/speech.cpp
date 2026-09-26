/* game/common/speech.cpp -- RECONSTRUCTED (NFS4 PSX cop speech/dispatch engine; C++ TU)
 *   101 fns across 7 classes (Speech + Speaker/MobileSpeaker/DispatchSpeaker hierarchy +
 *   CarBank/CarBankName/LocationBank helpers) + 4 free C entry points (Speech_AllocateRAM__FlPc/
 *   PurgeRAM/HandleRequest/Server). Retail nested-class linkage is retained by
 *   the exact owner declarations in speech_types.h. Virtual dispatch via _vf[31]. GTE-free.
 */
#include "speech_types.h"
#include "speech_externs.h"

#define SPCHEVNT_IN_SPEECH_OBJ 1
extern "C" {
#include "spchevnt.c"
}
#undef SPCH_AddEvent

/* retail: this object's .rodata opens with the unreferenced "SimpleMem" tag (0x80055B54); its vtables' 8-byte,
 * section-relative alignment proves the section starts there.  An unused inline leaves exactly that behind. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* Speech static data precedes this TU's literal pools in retail.  Keep the
 * demangled source names while binding the compiler-emitted ABI labels.
 * Storage receipt: this TU is retail -G8 plus -fconserve-space.  Together,
 * .data=0x460 and .sdata=0x2f8 both link byte-exact; all 102 text gates retain
 * their result.  Build wiring is intentionally kept out of this source file. */
Speech *Speech::fgSpeech = 0;
Speech::Speaker *Speech::fgUndefined = 0;

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

void Speech::CarBankName::SetCar(int carIndex)

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
bool Speech::CarBank::Check(char *name,int id,CarBankName *bankname)

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

  match = false;
  for (int i = 0; i < this->fCarCount; i++) {
    if (carbank[i].Check(name,id,&bankname[i])) {
      match = true;
    }
  }
  return match;
}

/* ---- SetCar__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:301-373] SLD-VERIFIED ---- */
void Speech::Speaker::SetCar(Car_tObj *car)

{
  /* SYM-INLINE-LOCAL: Colour = SetColour */
  int carcolour;
  
  carcolour = 1 << car->carInfo->SpeechColour;
  if (this->GetCarBank(car->carIndex)->Full() == -1) {
    this->ClearCar();
  }
  else {
    if (Speech::MultiplePerps())
      this->SetColour(carcolour);
    else
      this->SetColour(carcolour | 0x78020);
    if (Speech::Dispatch()->KnownPerp(car))
      this->fCar = this->GetCarBank(car->carIndex)->Model();
    else
      this->fCar = this->GetCarBank(car->carIndex)->Full();
  }
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
  
  d = Speech_gLocationDescription[GameSetup_gData.track];
  match = 0;
  if (d == (Speech_tLocationDescription *)0x0) {
    match = 0;
  }
  else {
    for (int i = 0; i < this->fLocationCount; i = i + 1) {
      if (strncmp(name,d->name,strlen((u_long)d->name)) == 0) {
        locationbank[i].Set(d->start,d->end,id,d->name);
        match = 1;
      }
      d = d + 1;
    }
  }
  return match;
}

/* retail Distance records no locals and no inline scopes: the minimum is a macro (both operands are
   computed first; gcc cross-jumps the three minimum tails into one) */
#define SPEECH_MIN(a, b) ((a) < (b) ? (a) : (b))

/* ---- Distance__Q26Speech12LocationBanki  [SPEECH.CPP:567-587] SLD-VERIFIED ---- */
int Speech::LocationBank::Distance(int slice)

{
  if (fStartSlice > fEndSlice) {
    if (slice < fStartSlice && slice > fEndSlice)
      return SPEECH_MIN(fStartSlice - slice, slice - fEndSlice);
    return 0;
  }
  if (slice < fStartSlice)
    return SPEECH_MIN(fStartSlice - slice, slice + gNumSlices - fEndSlice);
  if (slice > fEndSlice)
    return SPEECH_MIN(slice - fEndSlice, fStartSlice + gNumSlices - slice);
  return 0;
}

/* ---- FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki  [SPEECH.CPP:594-618] SLD-VERIFIED ---- */
Speech::LocationBank *Speech::FindClosestLocationTo(LocationBank *bank,int slice)

{
  if (this->fLocationCount != 0) {
    LocationBank *closestbank = (LocationBank *)0x0;
    int closestdistance = 10000;

    for (int i = 0; i < this->fLocationCount; i++) {
      LocationBank *locationbank = &bank[i];
      int distance;

      if (locationbank->BankId() == -1)
        continue;
      distance = locationbank->Distance(slice);
      if (distance < closestdistance) {
        closestdistance = distance;
        closestbank = locationbank;
      }
    }
    return closestbank;
  }
  else
    return (LocationBank *)0x0;
}

/* ---- FindLocation__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:624-788] SLD-VERIFIED ---- */
void Speech::Speaker::FindLocation(Car_tObj *car)

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
            this->FindClosestLocationTo(slice);
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
  {
    int i = 0;

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

    c = header + 0x10;
    bsize = size;
    filecount = this->ReadBE32(header + 8);
    for (int i = 0; i < filecount; i++) {
      char *name;

      offset = this->ReadBE32(c);
      size = this->ReadBE32(c + 4);
      name = c + 8;
      c = name;
      while (*c != '\0') {
        c++;
      }
      if (this->IsHeader(c - 4, '.', 'h', 'd')) {
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
  DispatchSpeaker *dispatch = new DispatchSpeaker;
  fDispatch = dispatch;

  for (int i = 0; i < 4; i++) {
    /* SYM-CODEGEN-CARRIER: mobile -- materializes the result of the implicit
       MobileSpeaker construction.  Re-reading fMobile[i] adds four
       instructions and changes 28 instructions. */
    MobileSpeaker *mobile = new MobileSpeaker;
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
  if (Speech::fgSpeech == (Speech *)0x0) {
    return;
  }
  for (int i = 0; i < 4; i++) {
    Speech::fgSpeech->fMobile[i]->ClearCarObj();
  }
  SPCH_ClearEventQueue();
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  iSPCH_EACseedrandom((randtemp & 0xffff00) >> 8);
  Speech::fgSpeech->fCopCount =
      (randtemp = fastRandom * randSeed,
       fastRandom = randtemp & 0xffff,
       (randtemp & 0xffff00) >> 8) % 9;
  Speech::fgSpeech->fSuperCount =
      (randtemp = fastRandom * randSeed,
       fastRandom = randtemp & 0xffff,
       (randtemp & 0xffff00) >> 8) % 6;
  Speech::fgSpeech->fDispatch->Activate(
      (randtemp = fastRandom * randSeed,
       fastRandom = randtemp & 0xffff,
       (randtemp & 0xffff00) >> 8) % 7);
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
  if (Speech::fgSpeech != 0) {
    Car_tObj *car;
    int patch;
    long offset;

    Speech::ResetStatus();
    car = Speech::fgSpeech->fSpeakerCar;
    patch = Speech::fgSpeech->BankPatch(bank,car);
    offset = Speech::fgSpeech->BankOffset(bank);
    Speech::Idle();
    if (patch >= 0) {
      CopSpeak_GenericBankRequest(patch,car);
    }
    else if (offset != 0) {
      CopSpeak_DirectRequest(Speech::fgSpeech->FileHandle(),
                             offset + localoffset,size,car,0);
    }
    return offset + localoffset;
  }
  else
    return 0;
}

/* ---- Report__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1352-1356] SLD-VERIFIED ---- */
void Speech::Speaker::Report(Car_tObj *cop)

{
  return;
}

/* ---- Deny__Q26Speech7Speaker  [SPEECH.CPP:1363-1367] SLD-VERIFIED ---- */
void Speech::Speaker::Deny()

{
  return;
}

/* ---- Grant__Q26Speech7Speaker  [SPEECH.CPP:1371-1375] SLD-VERIFIED ---- */
void Speech::Speaker::Grant()

{
  return;
}

/* ---- Ready__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1379-1383] SLD-VERIFIED ---- */
void Speech::Speaker::Ready(Car_tObj *wing)

{
  return;
}

/* ---- Engage__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:1394-1398] SLD-VERIFIED ---- */
void Speech::Speaker::Engage(Car_tObj *perp)

{
  return;
}

/* ---- Lose__Q26Speech7Speaker  [SPEECH.CPP:1402-1406] SLD-VERIFIED ---- */
void Speech::Speaker::Lose()

{
  return;
}

/* ---- Accident__Q26Speech7Speakeri  [SPEECH.CPP:1410-1414] SLD-VERIFIED ---- */
void Speech::Speaker::Accident(int slice)

{
  return;
}

/* ---- Catch__Q26Speech7Speakeri  [SPEECH.CPP:1418-1422] SLD-VERIFIED ---- */
void Speech::Speaker::Catch(int ticket)

{
  return;
}

/* ---- RoadBlock__Q26Speech7Speaker  [SPEECH.CPP:1426-1430] SLD-VERIFIED ---- */
void Speech::Speaker::RoadBlock()

{
  return;
}

/* ---- SpikeBelt__Q26Speech7Speaker  [SPEECH.CPP:1434-1438] SLD-VERIFIED ---- */
void Speech::Speaker::SpikeBelt()

{
  return;
}

/* ---- Backup__Q26Speech7Speaker  [SPEECH.CPP:1442-1446] SLD-VERIFIED ---- */
void Speech::Speaker::Backup()

{
  return;
}

/* ---- ReportBlockade__Q26Speech7Speaker  [SPEECH.CPP:1450-1454] SLD-VERIFIED ---- */
void Speech::Speaker::ReportBlockade()

{
  return;
}

/* ---- Roger__Q26Speech7Speaker  [SPEECH.CPP:1459-1463] SLD-VERIFIED ---- */
void Speech::Speaker::Roger()

{
  return;
}

/* ---- Bullhorn__Q26Speech7Speaker  [SPEECH.CPP:1467-1471] SLD-VERIFIED ---- */
void Speech::Speaker::Bullhorn()

{
  return;
}

/* ---- Purge__Q26Speech7Speaker  [SPEECH.CPP:1475-1479] SLD-VERIFIED ---- */
void Speech::Speaker::Purge()

{
  return;
}

/* ---- Promote__Q26Speech7Speaker  [SPEECH.CPP:1490-1503] SLD-VERIFIED ---- */
void Speech::Speaker::Promote()

{
  Speaker *Super;

  Super = Speech::Dispatch();
  while (Super->Sub() != 0 && Super->Sub() != this)
    Super = Super->Sub();
  Super->SetSub(this->Sub());
  this->SetSub(Speech::Dispatch()->Sub());
  Speech::Dispatch()->SetSub(this);
}

/* ---- Speech_Server__Fv  [SPEECH.CPP:1539-1540] SLD-VERIFIED ---- */
extern "C" {

void Speech_Server(void)

{
  Speech::Dispatch()->Status();
}

/* ---- SetDelayedStatus__6SpeechPQ26Speech7Speakeri  [SPEECH.CPP:1546-1548] SLD-VERIFIED ---- */
} /* extern "C" */

void Speech::SetDelayedStatus(Speaker *sub,int delay)

{
  Speech::fgSpeech->fDispatch->fStatusSub = sub;
  Speech::fgSpeech->fDispatch->fStatusCount = delay;
}

/* ---- Activate__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:1554-1571] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Activate(int seedupdatecount)

{
  this->SetFrom(this->CallSign()->Dispatch());
  this->SetReverse(GameSetup_gData.track & 1);
  this->SetConfirm(0xff);
  this->SetPerpName(0xf);
  this->SetSub((Speaker *)0x0);
  for (int i = 1; i >= 0; i--) {
    this->fPerp[i] = (Car_tObj *)0x0;
  }
  this->fStatusCount = 0x200;
  this->fStatusSub = (Speaker *)0x0;
  this->fUpdateCount = seedupdatecount;
  this->SetHavePerp(0);
}

/* ---- Dispatch__6Speech  [SPEECH.CPP:1578-1586] SLD-VERIFIED ---- */
Speech::Speaker *Speech::Dispatch(void)

{
  Speaker *result;

  if (Speech::fgSpeech == (Speech *)0x0 || Speech::fgSpeech->fBankOffset == (long *)0x0)
    result = Speech::fgUndefined;
  else
    result = (Speaker *)Speech::fgSpeech->fDispatch;

  return result;
}

/* ---- Roger__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1592-1629] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Roger()

{
  this->ClearSpeaker();
  if (this->Sub() == 0 || this->Sub()->Perp() == 0 || this->Sub()->BlockadeFlags() != 0) {
    SPCHNFS_D_A_CONFIRM(this->Confirm());
    SPCH_PlaySpeech();
  }
  else if (this->Sub()->ArrestFlags() != 0) {
    this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
    SPCHNFS_D_C_PERP_APPREHENSION_REPLY(this->To(),this->Confirm(),this->PerpName());
    SPCH_PlaySpeech();
  }
  else if (this->Sub()->UpdateFlags() == 0) {
    SPCHNFS_D_A_CONFIRM(this->Confirm());
    SPCH_PlaySpeech();
    this->SetCar(this->Sub()->Perp());
    SPCHNFS_D_C_PERP_LOST_CONFIRM(this->Colour(),this->Car());
    SPCH_PlaySpeech();
  }
  else {
    this->SetCar(this->Sub()->Perp());
    this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
    if (this->Sub()->DistToPerp() < 0x280000)
      SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM(this->Colour(),this->Car(),this->To(),this->Confirm(),
                                            this->PerpName());
    else
      SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM(this->Colour(),this->Car(),this->To(),this->Confirm(),
                                            this->PerpName());
    SPCH_PlaySpeech();
  }
}

/* ---- StatusReply__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1636-1713] SLD-VERIFIED ----
 * SYM CLEAN (2026-09-26): accessor spelling from retail's pairs (Sub()/Sub()->Sub(), SetTo/SetWing on the
 * call-sign temporary, Position/Location/Distance/Wing/SpikeSide).  Byte-exact without the former W69 `__asm__`
 * launder: the spike arm stores the wing through SetWing() and reads it back through Wing(), and the backup
 * arm fetches Sub()->Sub() (a copy-propagated local) before the counter stores. */
void Speech::DispatchSpeaker::StatusReply()

{
  Speaker *Blocker;

  if (this->Sub() == 0 || this->Sub()->Perp() == 0)
    return;
  this->ClearSpeaker();
  Blocker = 0;
  if (this->Sub()->BlockadeFlags() != 0) {
    if (Speech::MultiplePerps()) {
      this->Sub()->ReportBlockade();
      return;
    }
    else {
      if (this->Sub()->Sub() != 0 && this->Sub()->Sub()->BlockadeFlags() != 0) {
        Blocker = this->Sub()->Sub();
        this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
      }
      else {
        Blocker = this->Sub();
        this->SetTo(this->CallSign()->AllUnits());
      }
      Blocker->ReportBlockade();
      this->ClearSpeaker();
      SPCHNFS_D_A_CONFIRM(this->Confirm());
      SPCH_PlaySpeech();
      SPCHNFS_D_C_INTRO_CALL(this->To(),this->From(),this->Reverse());
      SPCH_PlaySpeech();
    }
  }
  else {
    this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
    SPCHNFS_D_C_INTRO_CALL(this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
  }
  this->FindLocation(this->Sub()->CarObj());
  if (this->Sub()->BlockadeFlags() == 1) {
    this->SetWing(this->CallSign()->Mobile(Blocker->Unit()));
    this->SetSpikeSide(4);
    SPCHNFS_D_C_SPBLT_CONFIRMED(this->Position(),this->Location(),this->Distance(),this->Wing(),
                                this->SpikeSide());
    SPCH_PlaySpeech();
    if (Blocker != this->Sub())
      this->Sub()->Roger();
  }
  else if (this->Sub()->BlockadeFlags() == 2) {
    SPCHNFS_D_C_RDBLK_CONFIRMED(this->Position(),this->Location(),this->Distance());
    SPCH_PlaySpeech();
    if (Blocker != this->Sub())
      this->Sub()->Roger();
  }
  else if (this->Sub()->Sub() != 0) {
    this->SetWing(this->CallSign()->Mobile(this->Sub()->Sub()->Unit()));
    SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(this->Distance(),this->Position(),this->Location(),this->Wing());
    SPCH_PlaySpeech();
    this->Sub()->Roger();
    Speaker *next = this->Sub()->Sub();
    this->fStatusCount = 0x140;
    this->fUpdateCount++;
    this->fStatusSub = next;
  }
  if (this->Sub()->Sub() != 0 && this->Sub()->Sub()->BlockadeFlags() != 0)
    this->Sub()->SetBlockade(0);
}

/* ---- Status__Q26Speech15DispatchSpeaker  [SPEECH.CPP:1718-1848] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Status()

{
  if (this->Sub() == 0 || this->Sub()->Perp() == 0)
    return;
  if ((this->Sub()->CarObj()->carFlags & 0x200) != 0) {
    int dist = this->Sub()->DistToPerp();

    if (this->Sub()->HavePerp()) {
      if (dist > 0x15e0000) {
        this->Sub()->SetHavePerp(0);
        this->Sub()->SetUpdate(0);
        this->Sub()->Status();
      }
    }
    else if (dist < 0x640000)
      this->Sub()->Engage(this->Sub()->Perp());
  }
  if (this->fStatusSub != 0) {
    if (this->fStatusCount-- == 1) {
      if (this->fStatusSub == this)
        this->StatusReply();
      else if (this->Sub() != 0 && this->fStatusSub == this->Sub()->Sub())
        this->fStatusSub->Status();
      else {
        this->fStatusSub->Status();
        this->ClearSpeaker();
        this->Roger();
      }
    }
  }
  else if (this->fStatusCount > 0)
    this->fStatusCount--;
  else if (this->Sub()->BlockadeFlags() == 0 && this->Sub()->ArrestFlags() == 0) {
    if (this->Sub()->Sub() != 0 && this->Sub()->Sub()->Perp() != this->Sub()->Perp())
      this->Sub()->Sub()->Promote();
    switch (this->fUpdateCount & 3) {
    case 2:
      if (this->Sub()->DistToPerp() < 0x280000 && this->CalcMph(this->Sub()->CarObj()) > 0x32 &&
          this->CalcMph(this->Sub()->Perp()) > 0x32) {
        this->Sub()->SetUpdate(8);
        break;
      }
    case 0:
      this->Sub()->SetUpdate(0x26);
      break;
    case 3:
      if (this->Sub()->IsSuper() && this->fUpdateCount == 7) {
        this->Sub()->SetUpdate(0);
        this->Sub()->Status();
        this->fUpdateCount++;
        return;
      }
      else if (this->Sub()->DistToPerp() < 0x140000) {
        this->Sub()->Bullhorn();
        this->fUpdateCount++;
        return;
      }
    case 1:
      this->Sub()->SetUpdate(1);
      break;
    }
    this->ClearSpeaker();
    this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
    SPCHNFS_D_C_INTRO_CALL(this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    SPCHNFS_D_C_IN_PURS_NEAR_PERP(this->Sub()->Update());
    SPCH_PlaySpeech();
    this->fStatusCount = 0x60;
    this->fStatusSub = this->Sub();
    this->fUpdateCount++;
  }
}

/* ---- Status__Q26Speech13MobileSpeaker  [SPEECH.CPP:1853-1948] SLD-VERIFIED ----
 * SYM CLEAN (2026-09-26): accessor spelling from retail's pairs, as in Lose.  PlaySpeech sits in each arm
 * (gcc cross-jumps them into one call) and the two arms that skip it simply end, so the if-chain spans
 * the function as in retail.  The former carriers and both `__asm__` register clobbers are gone. */
void Speech::MobileSpeaker::Status()

{
  if (this->Perp() == 0)
    return;
  this->MakeSpeaker();
  if (this->ArrestFlags() == 1) {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    SPCHNFS_C_D_PERP_APPREHENSION(this->Voice(),this->PerpName());
    SPCH_PlaySpeech();
  }
  else if ((*(u_int *)((int)this->CarObj() + 0x260) & 0x200) != 0 && this->UpdateFlags() == 0) {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    this->SetCar(this->Perp());
    this->FindLocation(this->fCarObj);
    SPCHNFS_C_D_PERP_LOST(this->Voice(),this->Colour(),this->Car(),this->Position(),this->Location(),
                          this->Distance(),this->PerpName());
    SPCH_PlaySpeech();
    Speaker *saved = Speech::Dispatch()->Sub();

    Speech::Dispatch()->SetSub(this);
    Speech::Dispatch()->Roger();
    Speech::Dispatch()->SetSub(saved);
  }
  else if (this->IsSuper() && this->UpdateFlags() == 0 && this->Sub() != 0 &&
           (*(u_int *)((int)this->Sub()->CarObj() + 0x260) & 0x40) == 0) {
    this->SetTo(this->CallSign()->AllUnits());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    SPCHNFS_S_C_SUPER_COP_CRITICISM(this->Voice());
    SPCH_PlaySpeech();
  }
  else if (Speech::Dispatch()->Sub() != 0 && Speech::Dispatch()->Sub()->Sub() == this) {
    SPCHNFS_C_C_NEW_OFFICER_ENGAGING(this->Voice(),this->From());
    Speech::Dispatch()->Sub()->Roger();
  }
  else {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    this->SetCar(this->Perp());
    this->FindLocation(this->CarObj());
    this->SetSpeed(this->fPerp);
    if (this->DistToPerp() < 0x280000) {
      if (*(u_short *)((int)this->Perp() + 0x17c) > 0x40)
        SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(this->Voice());
      else if (this->UpdateFlags() == 1)
        SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC(this->Voice(),this->Position(),this->Location(),this->Distance());
      else if (this->UpdateFlags() == 8)
        SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(this->Voice(),this->Speed(),this->SpeedType());
      else
        SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(this->Voice(),this->Colour(),this->Car(),this->Distance(),
                                              this->Position(),this->Location());
    }
    else if (this->HavePerp()) {
      if (this->UpdateFlags() == 1)
        SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC(this->Voice(),this->Position(),this->Location(),this->Distance(),
                                                this->Colour(),this->Car(),this->PerpName());
      else if (this->UpdateFlags() == 8)
        SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(this->Voice(),this->Speed(),this->SpeedType());
      else
        SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS(this->Voice(),this->Colour(),this->Car(),this->Position(),
                                                this->Location(),this->Distance());
    }
    else {
      if (this->UpdateFlags() == 1)
        SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC(this->Voice(),this->Position(),this->Location(),this->Distance(),
                                                this->Colour(),this->Car());
      else if (this->UpdateFlags() == 8)
        SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(this->Voice(),this->Speed(),this->SpeedType());
      else
        SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(this->Voice(),this->Colour(),this->Car(),this->PerpName());
    }
    SPCH_PlaySpeech();
  }
}

/* ---- ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1954-1958] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::ClearPerp(Car_tObj *car)

{

  for (int i = 0; i < 2; i++) {
    if (this->fPerp[i] == car) {
      this->fPerp[i] = (Car_tObj *)0x0;
    }
  }
  return;
}

/* ---- KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1964-1969] SLD-VERIFIED ---- */
bool Speech::DispatchSpeaker::KnownPerp(Car_tObj *car)

{
  for (int i = 0; i < 2; i++) {
    if (this->fPerp[i] == car) {
      return 1;
    }
  }
  return 0;
}

/* ---- AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:1976-1980] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::AddPerp(Car_tObj *car)

{

  for (int i = 0; i < 2; i++) {
    if (this->fPerp[i] == (Car_tObj *)0x0) {
      this->fPerp[i] = car;
    }
  }
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
void Speech::DispatchSpeaker::Report(Car_tObj *perp)

{
  this->ClearSpeaker();
  if (this->KnownPerp(perp) && this->Sub() != 0) {
    if (!Speech::MultiplePerps()) {
      this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
      SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(this->Confirm(),this->To());
      SPCH_PlaySpeech();
    }
  }
  else {
    if (!Speech::MultiplePerps()) {
      this->SetTo(this->CallSign()->AllUnits());
      SPCHNFS_D_C_INTRO_CALL(this->To(),this->From(),this->Reverse());
      SPCH_PlaySpeech();
      this->SetCar(perp);
      this->FindLocation(perp);
      SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(this->Colour(),this->Car(),this->Position(),this->Location(),
                                      this->Distance());
      SPCH_PlaySpeech();
    }
    this->AddPerp(perp);
    this->fStatusCount = 0x2a0;
  }
}

/* ---- Accident__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:2039-2043] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Accident(int slice)

{
  return;
}

/* ---- Deny__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2049-2073] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Deny()

{
  if (this->Sub() == (Speaker *)0x0) {
    return;
  }
  this->ClearSpeaker();
  this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
  SPCHNFS_D_C_INTRO_CALL(this->To(),this->From(),this->Reverse());
  SPCH_PlaySpeech();
  if (this->Sub()->BlockadeSlot()->flags != 0) {
    SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(this->Sub()->BlockadeSlot());
  }
  else {
    SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY();
  }
  SPCH_PlaySpeech();
  this->Sub()->SetBlockade(0);
  return;
}

/* ---- Grant__Q26Speech15DispatchSpeaker  [SPEECH.CPP:2079-2098] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Grant()

{
  if (this->Sub() == (Speaker *)0x0) {
    return;
  }
  if (this->Sub()->BlockadeSlot() == (SPCHNFSType_vs_RDBLK_SSTRP *)0x0) {
    return;
  }
  this->ClearSpeaker();
  if (Speech::MultiplePerps() == 0) {
    SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(this->Sub()->BlockadeSlot(),this->Confirm());
    SPCH_PlaySpeech();
  }
  return;
}

/* ---- Ready__Q26Speech15DispatchSpeakerP8Car_tObj  [SPEECH.CPP:2104-2123] SLD-VERIFIED ---- */
void Speech::DispatchSpeaker::Ready(Car_tObj *carObj)

{
  Speaker *Wing;

  Wing = Speech::Mobile(carObj);
  if (this->Sub() != (Speaker *)0x0 && Wing != this->Sub()) {
    Wing->SetBlockade(this->Sub()->BlockadeSlot()->flags);
    Wing->Engage(this->Sub()->Perp());
  }
  this->fStatusSub = (Speaker *)this;
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
  return Speech::fgSpeech->PickVoice(carObj);
}

/* ---- Activate__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2163-2189] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Activate(Car_tObj *carObj)

{
  Speech_tMobileVoiceAttr *a;

  this->fCarObj = carObj;
  this->fUnit = Speech::GetVoice(carObj);
  a = &Speech_gCopAttr[this->fUnit];
  if ((carObj->carFlags & 0x40U) != 0) {
    this->fUnit = this->fUnit + 9;
    this->SetVoice(8);
  }
  else {
    this->SetVoice(a->voice);
  }
  this->SetFrom(this->CallSign()->Mobile(this->fUnit));
  this->SetReverse(GameSetup_gData.track & 1);
  this->SetConfirm(0xff);
  this->SetPerpName(0xf);
  this->SetBlockade(0);
  this->SetArrest(0);
  this->SetUpdate(0);
  this->SetPerp((Car_tObj *)0x0);
  this->SetSub((Speaker *)0x0);
  this->SetHavePerp(0);
  return;
}

/* ---- ReActivate__Q26Speech13MobileSpeaker  [SPEECH.CPP:2199-2212] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::ReActivate()

{
  Speech_tMobileVoiceAttr *a;

  this->fUnit = Speech::GetVoice(this->fCarObj);
  a = &Speech_gCopAttr[this->fUnit];
  if ((this->fCarObj->carFlags & 0x40U) != 0) {
    this->fUnit = this->fUnit + 9;
    this->SetVoice(8);
  }
  else {
    this->SetVoice(a->voice);
  }
  this->SetFrom(this->CallSign()->Mobile(this->fUnit));
}

/* ---- FindMobile__6SpeechP8Car_tObj  [SPEECH.CPP:2218-2237] SLD-VERIFIED ---- */
Speech::Speaker *Speech::FindMobile(Car_tObj *carObj)

{
  for (int i = 0; i < 4; i++) {
    if (fMobile[i]->IsCar(carObj))
      return fMobile[i];
  }

  for (int i = 0; i < 4; i++) {
    if (fMobile[i]->IsFree()) {
      fMobile[i]->Activate(carObj);
      return fMobile[i];
    }
  }

  return fgUndefined;
}

/* ---- Mobile__6SpeechP8Car_tObj  [SPEECH.CPP:2244-2250] SLD-VERIFIED ---- */
Speech::Speaker *Speech::Mobile(Car_tObj *carObj)

{
  if (Speech::fgSpeech == (Speech *)0x0 ||
      Speech::fgSpeech->fBankOffset == (long *)0x0)
    return Speech::fgUndefined;
  return Speech::fgSpeech->FindMobile(carObj);
}

/* ---- CalcMph__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:2256-2257] SLD-VERIFIED ---- */
int Speech::Speaker::CalcMph(Car_tObj *perp)

{
  return fixedmult(0x23ca5,__builtin_abs(perp->linearVel_ch.z)) / 0x10000;
}

/* ---- SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2263-2272] SLD-VERIFIED ---- */
/* MATCH: SYM has no named locals.  The duplicated ternary expressions are
   the retail source shape: gcc keeps the shared division reciprocal in s0,
   re-evaluates fixedmult only on the nonnegative path, and shares the store. */
#define MOBILE_SPEAKER_SPEED(perp, scale) \
  (fixedmult((scale), __builtin_abs((perp)->linearVel_ch.z)) / 0xa0000 - 3)

void Speech::MobileSpeaker::SetSpeed(Car_tObj *perp)

{
  if (GameSetup_gData.measurement == 1) {
    this->SetSpeedType(1);
    this->fSpeed = MOBILE_SPEAKER_SPEED(perp, 0x39999) < 0
        ? 0 : MOBILE_SPEAKER_SPEED(perp, 0x39999);
  }
  else {
    this->SetSpeedType(2);
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
/* a coordinate of the car a virtual accessor returns (CarObj / Perp) */
#define MOBILE_SPEAKER_COORD(self, getter, offset) \
  (*(int *)((int)self->getter() + (offset)))

int Speech::MobileSpeaker::DistToPerp()

{
  int x;
  int z;
  int d;

  if (MOBILE_SPEAKER_COORD(this, CarObj, 0xa0) -
      MOBILE_SPEAKER_COORD(this, Perp, 0xa0) > 0) {
    x = MOBILE_SPEAKER_COORD(this, CarObj, 0xa0) -
        MOBILE_SPEAKER_COORD(this, Perp, 0xa0);
  }
  else {
    x = MOBILE_SPEAKER_COORD(this, Perp, 0xa0) -
        MOBILE_SPEAKER_COORD(this, CarObj, 0xa0);
  }
  if (MOBILE_SPEAKER_COORD(this, CarObj, 0xa8) -
      MOBILE_SPEAKER_COORD(this, Perp, 0xa8) > 0) {
    z = MOBILE_SPEAKER_COORD(this, CarObj, 0xa8) -
        MOBILE_SPEAKER_COORD(this, Perp, 0xa8);
  }
  else {
    z = MOBILE_SPEAKER_COORD(this, Perp, 0xa8) -
        MOBILE_SPEAKER_COORD(this, CarObj, 0xa8);
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
void Speech::MobileSpeaker::Report(Car_tObj *perp)

{
  this->MakeSpeaker();
  this->SetTo(this->CallSign()->Dispatch());
  SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
  SPCH_PlaySpeech();
  this->MakeSpeaker();
  this->SetCar(perp);
  this->FindLocation(perp);
  this->SetSpeed(perp);
  SPCHNFS_C_D_PERP_SIGHTED(this->Voice(),this->Colour(),this->Car(),this->Distance(),this->Position(),
                           this->Location(),this->PerpName());
  SPCH_PlaySpeech();
  Speech::Dispatch()->SetSub(this);
}

/* ---- Engage__Q26Speech13MobileSpeakerP8Car_tObj  [SPEECH.CPP:2331-2450] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Engage(Car_tObj *perp)

{
  this->MakeSpeaker();
  this->SetHavePerp(1);
  if (perp != this->Perp()) {
    this->SetPerp(perp);
    this->SetCar(this->Perp());
    if ((this->CarObj()->carFlags & 0x200) == 0) {
      Speaker *SubChain = Speech::Dispatch();

      while (SubChain->Sub() != 0) {
        if (SubChain->Sub() == this) {
          SubChain->SetSub(this->Sub());
          this->SetSub(0);
          break;
        }
        SubChain = SubChain->Sub();
      }
    }
    if (Speech::Dispatch()->Sub() == this) {
      if ((this->CarObj()->carFlags & 0x200) != 0) {
        Speech::Dispatch()->Report(perp);
        this->MakeSpeaker();
        this->SetTo(this->CallSign()->Dispatch());
        this->FindLocation(this->Perp());
        SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(this->Voice(),this->To(),this->Colour(),this->Car(),
                                               this->Distance(),this->Position(),this->Location(),
                                               this->Confirm());
        SPCH_PlaySpeech();
      }
    }
    else if (this->IsSuper() && (this->Perp()->carFlags & 4) != 0 && Speech::Dispatch()->Sub() != 0 &&
             (Speech::Dispatch()->Sub()->CarObj()->carFlags & 0x40) == 0) {
      this->SetSub(Speech::Dispatch()->Sub());
      Speech::Dispatch()->SetSub(this);
      if (this->BlockadeFlags() == 0) {
        this->SetTo(this->CallSign()->AllUnits());
        SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
        SPCH_PlaySpeech();
        SPCHNFS_S_C_SUPER_COP_ARRIVAL(this->Voice());
        SPCH_PlaySpeech();
      }
    }
    else {
      Speaker *SubChain = Speech::Dispatch();

      if (Speech::Dispatch()->Sub() != 0 && Speech::Dispatch()->Sub()->Perp() != 0 &&
          (Speech::Dispatch()->Sub()->Perp()->carFlags & 4) == 0 && (this->Perp()->carFlags & 4) != 0) {
        this->SetSub(Speech::Dispatch()->Sub());
        Speech::Dispatch()->SetSub(this);
      }
      else {
        while (SubChain->Sub() != 0)
          SubChain = SubChain->Sub();
        SubChain->SetSub(this);
      }
      if (this->BlockadeFlags() == 0) {
        if (!Speech::Dispatch()->KnownPerp(perp) || Speech::Dispatch()->StatusCount() <= 0x17f) {
          this->SetTo(this->CallSign()->Dispatch());
          SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
          SPCH_PlaySpeech();
          this->FindLocation(this->Perp());
          this->SetSpeed(this->Perp());
          if (Speech::Dispatch()->KnownPerp(this->Perp()))
            SPCHNFS_C_D_PERP_SIGHTED(this->Voice(),this->Colour(),this->Car(),this->Distance(),
                                     this->Position(),this->Location(),this->PerpName());
          else
            SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(this->Voice(),this->Colour(),this->Car(),this->Position(),
                                             this->Location(),this->Distance(),this->Speed(),
                                             this->SpeedType(),this->PerpName());
          SPCH_PlaySpeech();
          SubChain = Speech::Dispatch()->Sub();
          Speech::Dispatch()->SetSub(this);
          Speech::Dispatch()->Report(this->Perp());
          Speech::Dispatch()->SetSub(SubChain);
        }
      }
    }
  }
  else if (!Speech::MultiplePerps() && Speech::Dispatch()->StatusCount() < 0x160) {
    this->SetCar(this->Perp());
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    this->FindLocation(this->Perp());
    SPCHNFS_C_C_PERP_REAQUIRED(this->Voice(),this->Colour(),this->Car(),this->Position(),this->Location(),
                               this->Distance());
    SPCH_PlaySpeech();
  }
}

/* ---- Lose__Q26Speech13MobileSpeaker  [SPEECH.CPP:2463-2538] SLD-VERIFIED ----
 * SYM CLEAN (2026-09-26): written with the Speaker/MobileSpeaker accessor inlines that retail's pairs record
 * (Sub/SetSub on the Dispatch() temporary, SetTo, Voice, To/From/Reverse, Colour/Car/Position/Location/Distance/
 * PerpName, ArrestFlags/BlockadeFlags).  The former carrier spelling (voiceArg launder, iVar3, outOfRange,
 * savedDispatch) is no longer needed for the bytes; `saved` below is copy-propagated away, so like retail it
 * leaves no debug record. */
void Speech::MobileSpeaker::Lose()

{
  Speaker *Leader;

  if (this->Perp() == 0)
    return;
  this->MakeSpeaker();
  if (Speech::Dispatch()->Sub() != 0 && Speech::Dispatch()->Sub()->Sub() == this &&
      this->BlockadeFlags() == 0 && this->ArrestFlags() == 0) {
    Leader = Speech::Dispatch()->Sub();
    this->SetTo(this->CallSign()->Mobile(Leader->Unit()));
  }
  else {
    Leader = 0;
    this->SetTo(this->CallSign()->Dispatch());
  }
  if (this->ArrestFlags() != 0) {
    SPCHNFS_C_P_FALSE_ARREST_BULLHORN(this->Voice());
    SPCH_PlaySpeech();
  }
  else if (this->BlockadeFlags() == 0 && this->ArrestFlags() == 0 && Leader == 0 && Speech::Dispatch()->StatusCount() > 0x160)
    return;
  SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
  SPCH_PlaySpeech();
  this->SetCar(this->Perp());
  this->FindLocation(this->Perp());
  if (this->ArrestFlags() != 0)
    SPCHNFS_C_D_DURING_FALSE_ARREST(this->Voice(),this->PerpName());
  else if ((*(u_int *)((int)this->CarObj() + 0x260) & 0x200) != 0)
    SPCHNFS_C_D_ENDGAME(this->Voice());
  else if (this->BlockadeFlags() == 1)
    SPCHNFS_C_D_SPBLT_FAILED(this->Voice(),this->Colour(),this->Car());
  else if (this->BlockadeFlags() == 2)
    SPCHNFS_C_D_RDBLK_FAILED(this->Voice(),this->Colour(),this->Car());
  else if (Leader != 0)
    SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(this->Voice());
  else
    SPCHNFS_C_D_PERP_LOST(this->Voice(),this->Colour(),this->Car(),this->Position(),this->Location(),
                          this->Distance(),this->PerpName());
  SPCH_PlaySpeech();
  this->SetBlockade(0);
  this->SetArrest(0);
  this->SetUpdate(0);
  if (Leader == 0) {
    Speaker *saved = Speech::Dispatch()->Sub();

    Speech::Dispatch()->SetSub(this);
    Speech::Dispatch()->Roger();
    Speech::Dispatch()->SetSub(saved);
  }
}

/* ---- Accident__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2544-2548] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Accident(int slice)

{
  return;
}

/* ---- Catch__Q26Speech13MobileSpeakeri  [SPEECH.CPP:2554-2621] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Catch(int ticket)

{
  /* Retail records one inline pair per accessor below (To/From/Reverse/Position/Location/Distance/PerpName/
     Ambulance/Arrest on Speaker, Voice on MobileSpeaker, Dispatch on the call-sign temporary), MakeSpeaker at
     body level after the early return, and SetArrest's `Arrest` = ticket. */
  if (this->Perp() == 0)
    return;
  this->MakeSpeaker();
  if (*(int *)((int)this->Perp() + 300) < 0) {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    this->FindLocation(this->Perp());
    SPCHNFS_C_D_PERP_CRASH_ROLL(this->Voice(),this->Position(),this->Location(),this->Distance(),
                                this->PerpName());
    SPCH_PlaySpeech();
    this->SetAmbulance(4);
    SPCHNFS_C_D_REQUEST_EMS(this->Voice(),this->Ambulance());
    SPCH_PlaySpeech();
  }
  else if (*(int *)((int)this->Perp() + 0x78c) != 0) {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    this->SetCar(this->Perp());
    this->FindLocation(this->Perp());
    SPCHNFS_C_D_PERP_CRASH_GEN(this->Voice(),this->Position(),this->Location(),this->Colour(),
                               this->Car(),this->Distance(),this->PerpName());
    SPCH_PlaySpeech();
    this->SetAmbulance(0x20);
    SPCHNFS_C_D_REQUEST_EMS(this->Voice(),this->Ambulance());
    SPCH_PlaySpeech();
  }
  else {
    this->SetArrest(ticket);
    if (ticket == 1)
      SPCHNFS_C_P_ARRESTED(this->Voice(),this->Arrest());
    else if (ticket == 2)
      SPCHNFS_C_P_WARNING(this->Voice(),this->Arrest());
    else
      SPCHNFS_C_P_TICKET(this->Voice(),this->Arrest());
    SPCH_PlaySpeech();
    if (ticket == 1)
      this->DelayStatus(0x60);
  }
  Speech::Dispatch()->ClearPerp(this->fPerp);
}

/* ---- RoadBlock__Q26Speech13MobileSpeaker  [SPEECH.CPP:2627-2648] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::RoadBlock()

{

  
  if (Speech::Dispatch()->Sub() != 0 && Speech::Dispatch()->Sub() != (Speaker *)this) {
    Speech::Dispatch()->Sub()->RoadBlock();
  }
  else {
    this->Promote();
    if (Speech::MultiplePerps() == 0) {
      this->MakeSpeaker();
      this->SetTo(this->CallSign()->Dispatch());
      SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),
                        this->Reverse());
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_RDBLK(this->Voice());
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    this->SetBlockade(2);
  }
  return;
}

/* ---- SpikeBelt__Q26Speech13MobileSpeaker  [SPEECH.CPP:2656-2677] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::SpikeBelt()

{

  
  if (Speech::Dispatch()->Sub() != 0 && Speech::Dispatch()->Sub() != (Speaker *)this) {
    Speech::Dispatch()->Sub()->SpikeBelt();
  }
  else {
    this->Promote();
    if (Speech::MultiplePerps() == 0) {
      this->MakeSpeaker();
      this->SetTo(this->CallSign()->Dispatch());
      SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),
                        this->Reverse());
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
      SPCHNFS_C_D_REQ_SPBLT(this->Voice());
      SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
    }
    this->SetBlockade(1);
  }
  return;
}

/* ---- Backup__Q26Speech13MobileSpeaker  [SPEECH.CPP:2685-2705] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Backup()

{
  this->MakeSpeaker();
  this->SetTo(this->CallSign()->Dispatch());
  SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
  SPCH_PlaySpeech();
  this->SetCar(this->Perp());
  this->FindLocation(this->CarObj());
  SPCHNFS_C_D_REQUEST_BKUP(this->Voice(),this->Colour(),this->Car(),this->Position(),
                           this->Location(),this->Distance());
  SPCH_PlaySpeech();
  this->SetBlockade(0);
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
void Speech::MobileSpeaker::Roger()

{
  this->MakeSpeaker();
  if (this->Sub() != 0 && Speech::Dispatch()->StatusSub() == this->Sub()) {
    SPCH_PlaySpeech();
    this->SetTo(this->CallSign()->Mobile(this->Sub()->Unit()));
    SPCHNFS_C_A_CONFIRM(this->Voice(),this->To(),this->Confirm());
    SPCH_PlaySpeech();
    this->SetCar(this->Perp());
    SPCHNFS_C_C_IN_PURS_NEAR_PERP(this->Voice(),this->Colour(),this->Car());
    SPCH_PlaySpeech();
  }
  else {
    this->SetTo(this->CallSign()->Dispatch());
    SPCHNFS_C_A_CONFIRM(this->Voice(),this->To(),this->Confirm());
    SPCH_PlaySpeech();
  }
}

/* ---- Bullhorn__Q26Speech13MobileSpeaker  [SPEECH.CPP:2741-2748] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Bullhorn()

{
  /* SYM-OPTIMIZED: carObj -- the inline fCarObj accessor is consumed directly
     by the assignment to Speech::fSpeakerCar. */
  this->MakeSpeaker();
  SPCHNFS_C_P_BULLHORN_SPEECH(this->Voice());
  SPCH_PlaySpeech(); /* void(void) per spchevnt.c:350; oracle: no arg setup at any of 17 call-site fns (2026-07-11) */
  return;
}

/* ---- Purge__Q26Speech13MobileSpeaker  [SPEECH.CPP:2754-2839] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::Purge()

{
  Speaker *Chain;
  
  if (this->fCarObj == (Car_tObj *)0x0) {
    return;
  }
  if ((*(u_int *)((int)this->CarObj() + 0x260) &
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
    if (this->Perp() != (Car_tObj *)0x0 &&
        AudioMus_Threshold() != 0) {
      if (stackSpeedUpEnbabledFlag != 0) {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        AudioMus_StopSong(500);
        AudioMus_PlaySong((char *)0x0);
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 1;
      }
      else {
        AudioMus_StopSong(500);
        AudioMus_PlaySong((char *)0x0);
      }
    }
    this->SetBlockade(0);
    this->SetArrest(0);
    this->SetUpdate(0);
    this->SetPerp((Car_tObj *)0x0);
    this->SetSub((Speaker *)0x0);
    return;
  }

  this->fCarObj = (Car_tObj *)0x0;
  if (Speech::Dispatch()->StatusSub() == (Speaker *)this) {
    Speech::Dispatch()->PurgeStatusSub();
  }
  Chain = (Speaker *)Speech::Dispatch();
  while (Chain->Sub() != (Speaker *)this) {
    if (Chain->Sub() == (Speaker *)0x0) {
      return;
    }
    Chain = Chain->Sub();
  }
  Chain->SetSub(this->Sub());
}

/* ---- ReportBlockade__Q26Speech13MobileSpeaker  [SPEECH.CPP:2843-2861] SLD-VERIFIED ---- */
void Speech::MobileSpeaker::ReportBlockade()

{
  this->MakeSpeaker();
  this->SetTo(this->CallSign()->Dispatch());
  this->FindLocation(this->CarObj());
  this->SetSpikeSide(4);
  if (this->BlockadeFlags() == 2) {
    SPCHNFS_C_A_INTRO(this->Voice(),this->To(),this->From(),this->Reverse());
    SPCH_PlaySpeech();
    SPCHNFS_W_D_RDBLK_PLC(this->Voice(),this->Position(),this->Location(),this->Distance());
    SPCH_PlaySpeech();
  }
  else {
    SPCHNFS_W_D_SPBLT_PLC(this->Voice(),this->Position(),this->SpikeSide(),this->From(),
                          this->Location(),this->Distance());
    SPCH_PlaySpeech();
  }
  return;
}

/* ---- Perp__Q26Speech13MobileSpeaker  [SPEECH.CPP:147-147] SLD-VERIFIED ---- */
Car_tObj *Speech::MobileSpeaker::Perp()

{
  return this->fPerp;
}

/* ---- Unit__Q26Speech13MobileSpeaker  [SPEECH.CPP:134-135] SLD-VERIFIED ---- */
int Speech::MobileSpeaker::Unit()

{
  return this->fUnit;
}

/* ---- CallSign__Q26Speech13MobileSpeaker  [SPEECH.CPP:130-135] SLD-FLAG:NONMONO ---- */
Speech::CallSignBank *Speech::MobileSpeaker::CallSign()

{
  return Speech::fgSpeech->MobileCallSign();
}

/* ---- FindClosestLocationTo__Q26Speech13MobileSpeakeri  [SPEECH.CPP:126-131] SLD-FLAG:NONMONO ---- */
Speech::LocationBank *Speech::MobileSpeaker::FindClosestLocationTo(int slice)

{
  return Speech::fgSpeech->ClosestMobileLocation(slice);
}

/* ---- GetCarBank__Q26Speech13MobileSpeakeri  [SPEECH.CPP:122-127] SLD-FLAG:NONMONO ---- */
Speech::CarBank *Speech::MobileSpeaker::GetCarBank(int carIndex)

{
  return Speech::MobileCarBank(carIndex);
}

/* ---- CarObj__Q26Speech13MobileSpeaker  [SPEECH.CPP:114-114] SLD-VERIFIED ---- */
Car_tObj *Speech::MobileSpeaker::CarObj()

{
  return this->fCarObj;
}

/* ---- IsSuper__Q26Speech13MobileSpeaker  [SPEECH.CPP:106-106] SLD-VERIFIED ---- */
bool Speech::MobileSpeaker::IsSuper()

{
  return (u_int)this->fCarObj->carFlags >> 6 & 1;
}

/* ---- CallSign__Q26Speech15DispatchSpeaker  [SPEECH.CPP:73-74] SLD-VERIFIED ---- */
Speech::CallSignBank *Speech::DispatchSpeaker::CallSign()

{
  return Speech::fgSpeech->DispatchCallSign();
}

/* ---- FindClosestLocationTo__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:69-74] SLD-FLAG:NONMONO ---- */
Speech::LocationBank *Speech::DispatchSpeaker::FindClosestLocationTo(int slice)

{
  return Speech::fgSpeech->ClosestDispatchLocation(slice);
}

/* ---- GetCarBank__Q26Speech15DispatchSpeakeri  [SPEECH.CPP:65-70] SLD-FLAG:NONMONO ---- */
Speech::CarBank *Speech::DispatchSpeaker::GetCarBank(int carIndex)

{
  return Speech::DispatchCarBank(carIndex);
}

/* ---- PurgeStatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:58-66] SLD-FLAG:NONMONO ---- */
void Speech::DispatchSpeaker::PurgeStatusSub()

{
  this->fStatusSub = (Speaker *)0x0;
  return;
}

/* ---- StatusSub__Q26Speech15DispatchSpeaker  [SPEECH.CPP:57-58] SLD-VERIFIED ---- */
Speech::Speaker *Speech::DispatchSpeaker::StatusSub()

{
  return this->fStatusSub;
}

/* ---- StatusCount__Q26Speech15DispatchSpeaker  [SPEECH.CPP:56-57] SLD-VERIFIED ---- */
int Speech::DispatchSpeaker::StatusCount()

{
  return this->fStatusCount;
}

/* base Speech::Speaker virtual not separately reconstructed (vtable-only ref, surfaced by #75
 * data-materialization); faithful from nfs4-f.exe @0x80099364 = { jr $ra; addiu $v0,$zero,0 }
 * W60-A9: moved here from the file tail to restore retail VA emission order (tu_order_audit
 * inversion: 0x80099364 sits between StatusCount__...DispatchSpeaker and FindClosestLocationTo). */
Speech::CallSignBank *Speech::Speaker::CallSign()   /* @0x80099364  CallSign__Q26Speech7Speaker -> NULL */
{
  return (CallSignBank *)0;
}

/* ---- FindClosestLocationTo__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Speech::LocationBank *Speech::Speaker::FindClosestLocationTo(int slice)

{
  return (LocationBank *)0x0;
}

/* ---- GetCarBank__Q26Speech7Speakeri  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Speech::CarBank *Speech::Speaker::GetCarBank(int carIndex)

{
  return (CarBank *)0x0;
}

/* ---- Perp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj *Speech::Speaker::Perp()

{
  return (Car_tObj *)0x0;
}

/* ---- ReActivate__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speech::Speaker::ReActivate()

{
  return;
}

/* ---- CarObj__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Car_tObj *Speech::Speaker::CarObj()

{
  return (Car_tObj *)0x0;
}

/* ---- DistToPerp__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speech::Speaker::DistToPerp()

{
  return 0x3e80000;
}

/* ---- PurgeStatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speech::Speaker::PurgeStatusSub()

{
  return;
}

/* ---- StatusSub__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
Speech::Speaker *Speech::Speaker::StatusSub()

{
  return (Speaker *)0x0;
}

/* ---- StatusCount__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speech::Speaker::StatusCount()

{
  return 0;
}

/* ---- IsSuper__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
bool Speech::Speaker::IsSuper()

{
  return false;
}

/* ---- ClearPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speech::Speaker::ClearPerp(Car_tObj *car)

{
  return;
}

/* ---- KnownPerp__Q26Speech7SpeakerP8Car_tObj  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
bool Speech::Speaker::KnownPerp(Car_tObj *car)

{
  return false;
}

/* ---- Unit__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
int Speech::Speaker::Unit()

{
  return 0;
}

/* ---- Status__Q26Speech7Speaker  [SPEECH.CPP:?] SLD-FLAG:NO_SLD ---- */
void Speech::Speaker::Status()

{
  return;
}

/* ---- #75 data-materialization: 3 Speech vtables (nested Speech::<Leaf>, flat <Leaf>_<Method> pfns). ---- */
/* Compiler-emitted empty type-name/literal slot between strings and vtables. */
extern const char Speech_vtableTypeName[4] __asm__("D_80055BD0")
    __attribute__((section(".rodata"))) = "";
/* (2026-09-20) the three hand-written 31-slot tables that stood here are gone: the compiler emits them. */

/* end of speech.cpp */
