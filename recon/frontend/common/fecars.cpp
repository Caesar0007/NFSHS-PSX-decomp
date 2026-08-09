/* frontend/common/fecars.cpp -- RECONSTRUCTED (NFS4 car manager + list iterators; C++ TU)
 *   46 fns across 3 classes: tCarManager (32; garage/stock/pinkslip car economy + save/load),
 *   tListIteratorCar (8; :tListIterator), tListIteratorCarColor (6; :tListIterator).
 *   Member defs; base ctors via init-lists; manual _vf vtable for the iterator virtuals.
 */
#include "fecars.h"

/* ---- FECars.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
char         cars_disableBonuses;   /* @0x80051540  (bss(zero)) */
char         gCarSelected[2][50];   /* @0x80051544  (bss(zero)) */


/* ---- tCarManager::Initialize  [FECARS.CPP:77-94] SLD-VERIFIED ---- */

void tCarManager::Initialize()

{
  short i;
  short j;

  this->fNumCars = 0;
  this->fCars = (tCarInfo *)0x0;
  for (j = 0; j < 2; j++) {
    for (i = 0; i < 0x20; i++) {
      /* INDEX-FIRST spelling: `(idx) + (char*)this + K` emits retail's `addu v0,a0,v0`
         (base as rs); the natural `this->fCarGarage[j][i]` / `base[idx]` forms all emit
         `addu v0,v0,a0` AND let LICM hoist `this + j*128` instead of just `j*128`. */
      *(signed char *)((j * 128 + i * 4) + (char *)this + 8) = -1;
      *(signed char *)((j * 128 + i * 4) + (char *)this + 264) = -1;
    }
  }
  for (i = 0; i < 0x30; i++) {
    this->fAvailableCars[i] = '\0';
    this->fViewableCars[i] = '\0';
  }
  return;
}



/* ---- tCarManager::GetCarFromID  [FECARS.CPP:101-109] SLD-VERIFIED ----
   🏆 SEALED W54-A3 (2026-08-09) 26 -> PASS 20/20, and the twin GetCarFromSimID with it.
   The Ghidra-shaped `if(fNumCars){ p=fCars; do{...}while(i<fNumCars); }` reloaded fNumCars
   EVERY iteration (loop.c declines the savings-1/life-1 invariant hoist on a bottom-tested
   hand-written do/while) and kept the walker in $v1.  Retail = the NATURAL top-tested
   INDEX-FORM `for (i = 0; i < fNumCars; i++) ... fCars[i] ...`:
     - jump.c's duplicate_loop_exit_test makes the guard load ($a2); loop.c hoists the bottom
       test's load into the preheader; cse2 rewrites that hoisted load as a COPY of the guard's
       pseudo -> retail's `addu a1,a2,zero` (a copy no source-level cached local can produce:
       every hand-cached `numCars` local copy-props away).
     - strength reduction turns `fCars[i]` into a giv whose INITIAL VALUE `lw a0,4(a0)` is
       emitted in the PREHEADER (i.e. AFTER the guard) and bumped `addiu a0,a0,204` in the
       loop -> retail's walker in $a0 (clobbering `this`) and `return &fCars[i]` = `move v0,a0`.
   LAW: an "oracle copies a guard value into a 2nd register" + "our loop reloads the bound"
   pair is the LICM->cse2 hoisted-load-becomes-copy signature; the fix is the top-tested
   index form, never a hand-cached local. */

tCarInfo * tCarManager::GetCarFromID(short carID)

{
  u_int i;

  for (i = 0; i < this->fNumCars; i++) {
    if ((int)(signed char)this->fCars[i].fCarID == (int)carID) {
      return &this->fCars[i];
    }
  }
  return (tCarInfo *)0x0;
}



/* ---- tCarManager::GetCarFromSimID  [FECARS.CPP:116-124] SLD-VERIFIED ---- */

tCarInfo * tCarManager::GetCarFromSimID(short carID)

{
  u_int i;

  for (i = 0; i < this->fNumCars; i++) {
    if ((u_short)this->fCars[i].fSimNumber == carID) {
      return &this->fCars[i];
    }
  }
  return (tCarInfo *)0x0;
}



/* ---- tCarManager::CheapestCarStockPrice  [FECARS.CPP:161-175] SLD-VERIFIED ---- */

long tCarManager::CheapestCarStockPrice()

{
  int carPrice;
  u_int i;
  int returnprice;

  returnprice = 10000000;
  for (i = 0; i < this->fNumCars; i++) {
    carPrice = this->fCars[i].fPrices[0];
    if ((0 < carPrice) && (carPrice < returnprice)) {
      returnprice = carPrice;
    }
  }
  return returnprice;
}



/* ---- tCarManager::CalcUsedPrice  [FECARS.CPP:191-223] SLD-VERIFIED ----
   W54-A3 (2026-08-09) 77 -> 2 diffs, count-exact 67/67.  Corrections applied:
   (1) 🔴 REAL BUG FIXED: the garage fCarID was read through a plain `char` (UNSIGNED on this
       build) so `cVar1 != -1` folded to ALWAYS-TRUE and gcc DELETED the guard entirely --
       retail has `lb` + `li v0,-1` + `beq` (a used car with an empty garage slot would have
       been priced).  `(signed char)` restores both the lb and the test.
   (2) ONE variable for the price accumulator AND the result (retail keeps both in $s0):
       `result = 0` in the guard's delay slot, then `lw s0,32(a0)` overwrites it with fPrices[0].
   (3) branch polarity: retail tests `fExoticCar != 0` FIRST (beqz to the non-exotic arm), and
       the exotic arm is `result * 3 / 4` (the signed div-by-4 expansion), non-exotic `>> 1`.
   (4) address shape: NATURAL member form `fCarGarage[0][n]` (gives retail's base-first
       `addu v0,s2,v0`); the flat byte-offset form emits `addu v0,v0,s2` here (+4 diffs).
   RESIDUAL 2 (1 insn) = the `jal` delay slot: retail rematerializes `addu a0,s2,zero` (the
   `this` arg copy), OURS has `nop` because cse DELETED the redundant arg copy -- it can prove
   $a0 still holds `this` (no call precedes it, nothing writes $a0).  MECHANISM PROVEN: an
   empty asm clobbering "$4" invalidates $a0 in cse's table and gates PASS 67/67 -- but that
   names a hard register, so it is NOT landed here (policy call for the orchestrator).
   FALSIFIED source angles: local `tCarManager *mgr = this` (2), implicit `GetCarFromID(...)`
   (2), `(*this).GetCarFromID` (2), a fenced pointer local (2), flat byte-offset reads (6),
   early-return chain (80, wrecks the shared return-staging block). */

long tCarManager::CalcUsedPrice(short garageNumber)

{
  signed char carID;
  u_char upgrades;
  tCarInfo *carInfo;
  long result;

  result = 0;
  if ((u_int)garageNumber >= this->fNumCars) {
    carID = (signed char)this->fCarGarage[0][(int)garageNumber - (int)this->fNumCars].fCarID;
    if (carID != -1) {
      carInfo = this->GetCarFromID((short)carID);
      if (carInfo != (tCarInfo *)0x0) {
        upgrades = this->fCarGarage[0][(int)garageNumber - (int)this->fNumCars].fUpgrades;
        result = carInfo->fPrices[0];
        if ((upgrades & 1) != 0) {
          result = result + carInfo->fPrices[1];
        }
        if ((upgrades & 2) != 0) {
          result = result + carInfo->fPrices[2];
        }
        if ((upgrades & 4) != 0) {
          result = result + carInfo->fPrices[3];
        }
        if (carInfo->fExoticCar != '\0') {
          result = result * 3 / 4;
        }
        else {
          result = result >> 1;
        }
      }
    }
  }
  return result;
}



/* ---- tCarManager::PurchaseCar  [FECARS.CPP:230-255] SLD-VERIFIED ---- */

long tCarManager::PurchaseCar(short carModel,short color,short playerNum)

{
  /* SYM: locals = short i (REG $4), tCarInfo *carInfo (REG $6) */
  tCarInfo *carInfo;
  short i;

  carInfo = carManager.GetCarFromID(carModel);

  for (i = 0; i < 32; i++) {
    /* MATCH: char is UNSIGNED on this build -> (signed char) restores the
       oracle's lb/bgez (a plain `< 0` folds to false and gcc DELETES the body) */
    if ((signed char)this->fCarGarage[playerNum][i].fCarID < 0) {
      this->fCarGarage[playerNum][i].fCarID = (char)carModel;
      this->fCarGarage[playerNum][i].fCarColor = (u_char)color;
      this->fCarGarage[playerNum][i].fUpgrades = 0;
      frontEnd.garageCar[playerNum] = i + this->fNumCars;
      return carInfo->fPrices[0];
    }
  }
  return 0;
}



/* ---- tCarManager::SellCar  [FECARS.CPP:262-290] SLD-VERIFIED ----
   W54-A3 (2026-08-09) 128 -> 50 diffs, now COUNT-EXACT 96/96 (was 72/96) -- the
   RemoveFromPinkSlipsList recipe ported verbatim (same body over fCarGarage +8/+0x84 instead
   of fPinkSlipsCars +0x108/+0x184).  Same 🔴 REAL BUG fixed: the shift-loop break test read
   fCarID through a plain (unsigned) `char`, so `< 0` folded FALSE and gcc DELETED the guard --
   24 missing instructions.  Same 5 levers; see the RemoveFromPinkSlipsList receipt above.
   RESIDUAL 50 = the same register rotation + index/base `addu` operand order.  Attack both
   twins together. */

long tCarManager::SellCar(short garageNumber,short playerNum)

{
  char cVar1;
  long result;
  short i;

  result = this->CalcUsedPrice(garageNumber);
  *(signed char *)(((int)garageNumber - (int)this->fNumCars) * 4 + playerNum * 128
                   + (char *)this + 8) = -1;
  for (i = garageNumber - this->fNumCars + 1; i < 0x20; i++) {
    /* MATCH: (signed char) -- plain `char < 0` folds false (unsigned char ABI); retail
       loads the byte TWICE (lb for the test, lbu for the copy). */
    if ((signed char)this->fCarGarage[playerNum][i].fCarID < 0) break;
    this->fCarGarage[playerNum][i - 1].fCarID = this->fCarGarage[playerNum][i].fCarID;
    this->fCarGarage[playerNum][i - 1].fUpgrades = this->fCarGarage[playerNum][i].fUpgrades;
    this->fCarGarage[playerNum][i - 1].fCarColor = this->fCarGarage[playerNum][i].fCarColor;
  }
  { /* own statement: keeps fold from merging the -4 into the +8 displacement */
    int prevSlot = i * 4 - 4;
    *(signed char *)(prevSlot + playerNum * 128 + (char *)this + 8) = -1;
  }
  *(signed char *)(playerNum * 128 + (char *)this + 0x84) = -1;
  if (*(signed char *)(((u_int)(u_char)frontEnd.garageCar[playerNum] - this->fNumCars) * 4
                       + playerNum * 128 + (char *)this + 8) < 0) {
    cVar1 = frontEnd.garageCar[playerNum] - 1;
    if ((u_int)(u_char)frontEnd.garageCar[playerNum] <= this->fNumCars) {
      cVar1 = '\0';
    }
    frontEnd.garageCar[playerNum] = cVar1;
  }
  return result;
}



/* ---- tCarManager::PurchaseUpgrade  [FECARS.CPP:298-327] SLD-VERIFIED ---- */

long tCarManager::PurchaseUpgrade(short garageNumber,short upgradeFlags,short playerNum)

{
  u_char bVar1;
  u_char *slot;
  tCarInfo *carInfo;
  short mask;
  short i;
  long result;

  result = 0;
  carInfo = this->GetCarFromID((short)(signed char)
      this->fCarGarage[playerNum][(int)garageNumber - (int)this->fNumCars].fCarID);
  for (i = 0; i < 3; i++) {
    mask = 1 << i;
    if ((upgradeFlags & mask) != 0) {
      slot = (u_char *)
        (((int)garageNumber - (int)this->fNumCars) * 4 + playerNum * 128 + (char *)this + 9);
      bVar1 = *slot;
      if ((bVar1 & mask) == 0) {
        *slot = mask | bVar1;
        result = result + carInfo->fPrices[i + 1];
      }
    }
  }
  return result;
}



/* ---- tCarManager::RemoveFromPinkSlipsList  [FECARS.CPP:332-357] SLD-VERIFIED ----
   W54-A3 (2026-08-09) 109 -> 44 diffs, now COUNT-EXACT 82/82 (was 71/82).  Landed:
   (1) 🔴 REAL BUG FIXED: the shift-loop's break test read fCarID through a plain `char`
       (UNSIGNED here) so `< 0` folded FALSE and gcc DELETED the guard -- the compaction loop
       ran to the end of the 32-slot list over empty entries.  Retail loads the byte TWICE
       (`lb` for the test, `lbu` for the copy) -> `(signed char)` on the test only.
   (2) the whole body is the natural shift-down loop over `fPinkSlipsCars[playerNum][i]`
       (short `i`); the -1 stores need `*(signed char *)&...` (else `li 255`).
   (3) TWO WIDTHS of fNumCars are retail-correct and come for free from the C types: the first
       store's `(int)garageNumber - (int)fNumCars` is `lw`, while the loop-init
       `short i = garageNumber - fNumCars + 1` narrows to HImode -> retail's `lhu`.
   (4) FLAT INDEX-FIRST address spelling at the 4 non-loop sites -- the natural member form
       hoists `this + playerNum*128` into one reg; retail keeps `playerNum*128` and `this`
       separate (`addu v0,v0,a0; addu v0,t1,v0`).
   (5) `int prevSlot = i * 4 - 4;` as its OWN statement -- otherwise fold merges the -4 into
       the 0x108 displacement (`sb v1,260(v0)`), while retail has an explicit `addiu v0,v0,-4`.
   RESIDUAL 44 = a whole-function register rotation plus the two index/base `addu` operand
   orders (ours puts playerNum*128 first, retail the index).  FALSIFIED: swapping the source
   term order in the flat expressions (46 / 44 / compile error) -- the operand order is
   canonicalized, so it is an evaluation-ORDER consequence, not a spelling one.
   NEXT ANGLE: the SellCar twin shares this exact body shape -- port the recipe there first,
   then re-attack the rotation with allocsim/qtyprio. */

void tCarManager::RemoveFromPinkSlipsList(short garageNumber,short playerNum)

{
  char cVar1;
  short i;

  /* INDEX-FIRST spelling: retail keeps `playerNum*128` and `this` SEPARATE
     (`addu v0,v0,a0; addu v0,t1,v0`); the natural member form hoists `this + playerNum*128`. */
  *(signed char *)(((int)garageNumber - (int)this->fNumCars) * 4 + playerNum * 128
                   + (char *)this + 0x108) = -1;
  for (i = garageNumber - this->fNumCars + 1; i < 0x20; i++) {
    /* MATCH: (signed char) -- plain `char < 0` folds false (unsigned char ABI); retail
       loads the byte TWICE (lb for the test, lbu for the copy). */
    if ((signed char)this->fPinkSlipsCars[playerNum][i].fCarID < 0) break;
    this->fPinkSlipsCars[playerNum][i - 1].fCarID = this->fPinkSlipsCars[playerNum][i].fCarID;
    this->fPinkSlipsCars[playerNum][i - 1].fUpgrades = this->fPinkSlipsCars[playerNum][i].fUpgrades;
    this->fPinkSlipsCars[playerNum][i - 1].fCarColor = this->fPinkSlipsCars[playerNum][i].fCarColor;
  }
  { /* own statement: keeps fold from merging the -4 into the 0x108 displacement
       (retail has an explicit `addiu v0,v0,-4` on the index chain) */
    int prevSlot = i * 4 - 4;
    *(signed char *)(prevSlot + playerNum * 128 + (char *)this + 0x108) = -1;
  }
  *(signed char *)(playerNum * 128 + (char *)this + 0x184) = -1;
  if (*(signed char *)(((u_int)(u_char)frontEnd.garageCar[playerNum] - this->fNumCars) * 4
                       + playerNum * 128 + (char *)this + 0x108) < 0) {
    cVar1 = frontEnd.garageCar[playerNum] - 1;
    if ((u_int)(u_char)frontEnd.pinkSlipsCar[playerNum] <= this->fNumCars) {
      cVar1 = '\0';
    }
    frontEnd.pinkSlipsCar[playerNum] = cVar1;
  }
  return;
}



/* ---- tCarManager::AddToPinkSlipsList  [FECARS.CPP:361-383] SLD-VERIFIED ---- */

void tCarManager::AddToPinkSlipsList(short carModel,short color,short playerNum)

{
  /* SYM: sole local = short i (REG $8); leaf fn (fsize 0, mask 0) */
  short i;

  for (i = 0; i < 32; i++) {
    /* MATCH: (signed char) — plain `char < 0` folds false (unsigned char ABI) */
    if ((signed char)this->fPinkSlipsCars[playerNum][i].fCarID < 0) {
      this->fPinkSlipsCars[playerNum][i].fCarID = (char)carModel;
      this->fPinkSlipsCars[playerNum][i].fCarColor = (u_char)color;
      this->fPinkSlipsCars[playerNum][i].fUpgrades = 0;
      frontEnd.pinkSlipsCar[playerNum] = i + this->fNumCars;
      return;
    }
  }
}



/* ---- tCarManager::AddUpgradesToPinkSlipsList  [FECARS.CPP:387-412] SLD-VERIFIED ----
   🏆 SEALED W54-A3 (2026-08-09) 43 -> PASS 54/54.  Four independent corrections:
   (1) the pink-slip fCarID read is `lb` = (signed char) (plain `char` is UNSIGNED in this build);
   (2) `mask` is a SHORT variable -- `1 << i` kept unnarrowed in a pseudo and re-narrowed per use
       (`sll 16` alone for the nonzero test, `sll;sra` before the byte AND) -- a u_int mask can
       never emit those;
   (3) top-tested `for (i = 0; i < 3; i++)` short counter (retail's addiu-into-a-fresh-pseudo +
       copy-back, and reorg's duplicated `addiu v0,a2,1` in the bnez slot);
   (4) ADDRESS SHAPE IS PER SITE: the PRE-CALL read wants the NATURAL member form
       `fPinkSlipsCars[playerNum][n].fCarID` (gives retail's `addu v0,v0,s1; addu v0,s2,v0`),
       while the IN-LOOP slot wants the FLAT BYTE-OFFSET form -- the natural member form there
       lets LICM hoist `this + playerNum*128 + 264` into a saved reg (+1 insn, 15 diffs).
   Falsified for the pre-call site: 4 index/base association spellings (2-4 diffs each). */

void tCarManager::AddUpgradesToPinkSlipsList(short garageNumber,short upgradeFlags,short playerNum)

{
  u_char bVar1;
  u_char *slot;
  short mask;
  short i;

  this->GetCarFromID((short)(signed char)
      this->fPinkSlipsCars[playerNum][(int)garageNumber - (int)this->fNumCars].fCarID);
  for (i = 0; i < 3; i++) {
    mask = 1 << i;
    if ((upgradeFlags & mask) != 0) {
      slot = (u_char *)
        (((int)garageNumber - (int)this->fNumCars) * 4 + playerNum * 128 + (char *)this + 0x109);
      bVar1 = *slot;
      if ((bVar1 & mask) == 0) {
        *slot = mask | bVar1;
      }
    }
  }
  return;
}



/* ---- tCarManager::LoadCars  [FECARS.CPP:420-438] SLD-VERIFIED ---- */

void tCarManager::LoadCars(tSaveCarInfo &load,short playerNum)

{
  u_int i;

  blockmove(&load,this->fCarGarage[playerNum],0x80);
  if (playerNum == 0) {
    i = 0;
    if (this->fNumCars != 0) {
      do {
        this->fAvailableCars[i] = load.fSaveAvailable[i];
        this->fViewableCars[i] = load.fSaveViewable[i];
        i = i + 1;
      } while (i < this->fNumCars);
    }
  }
  return;
}



/* ---- tCarManager::SaveCars  [FECARS.CPP:445-459] SLD-VERIFIED ---- */

void tCarManager::SaveCars(tSaveCarInfo &save)

{
  u_long i;

  blockmove(this->fCarGarage,&save,0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      save.fSaveAvailable[i] = this->fAvailableCars[i];
      save.fSaveViewable[i] = this->fViewableCars[i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::LoadPinkSlipsCars  [FECARS.CPP:466-477] SLD-VERIFIED ---- */

void tCarManager::LoadPinkSlipsCars(tSaveCarInfo &load,short playerNum)

{
  u_int i;
  
  blockmove(&load,this->fPinkSlipsCars[playerNum],0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      this->fPinkSlipsAvailableCars[playerNum][i] = load.fSaveAvailable[i];
      this->fPinkSlipsViewableCars[playerNum][i] = load.fSaveViewable[i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SavePinkSlipsCars  [FECARS.CPP:483-507] SLD-VERIFIED ---- */

void tCarManager::SavePinkSlipsCars(tSaveCarInfo &save,short playerNum,short withoutCarInGarageNumber)

{
  u_int i;
  tCarInfo carInfo;
  
  if (withoutCarInGarageNumber != -1) {
    this->GetPinkSlipsCar(withoutCarInGarageNumber,carInfo,playerNum);
    this->RemoveFromPinkSlipsList(withoutCarInGarageNumber,playerNum);
  }
  blockmove(this->fPinkSlipsCars[playerNum],&save,0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      save.fSaveAvailable[i] = this->fPinkSlipsAvailableCars[playerNum][i];
      save.fSaveViewable[i] = this->fPinkSlipsViewableCars[playerNum][i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  if (withoutCarInGarageNumber != -1) {
    carManager.AddToPinkSlipsList((short)(signed char)carInfo.fCarID,(u_short)carInfo.fColor,playerNum);
    carManager.AddUpgradesToPinkSlipsList((u_short)(u_char)frontEnd.pinkSlipsCar[playerNum],(u_short)carInfo.fUpgrades,
               playerNum);
  }
  return;
}



/* ---- tCarManager::SetClassAvailable  [FECARS.CPP:514-528] SLD-VERIFIED ---- */

void tCarManager::SetClassAvailable(tCarClassType carClass,bool avail)

{
  u_int i;

  i = 0;
  if (this->fNumCars != 0) {
    do {
      if (((signed char)this->fCars[i].fCarID >= 0) &&
          ((u_char)this->fCars[i].fCarClass == carClass)) {
        this->fAvailableCars[(signed char)this->fCars[i].fCarID] = avail;
        if (avail != 0) {
          this->fViewableCars[(signed char)this->fCars[i].fCarID] = '\x01';
        }
      }
      i = i + 1;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SetCarAvailable  [FECARS.CPP:534-537] SLD-VERIFIED ---- */

void tCarManager::SetCarAvailable(tCarModels carModel,bool avail)

{
  
  this->fAvailableCars[carModel] = avail;
  if (avail != 0) {
    this->fViewableCars[carModel] = '\x01';
  }
  return;
}



/* ---- tCarManager::SetClassViewable  [FECARS.CPP:543-557] SLD-VERIFIED ---- */

void tCarManager::SetClassViewable(tCarClassType carClass,bool view)

{
  u_int i;

  for (i = 0; i < this->fNumCars; i = i + 1) {
    if ((signed char)this->fCars[i].fCarID >= 0) {
      if ((u_char)this->fCars[i].fCarClass == carClass) {
        this->fViewableCars[(signed char)this->fCars[i].fCarID] = view;
      }
    }
    else {
      this->fViewableCars[(signed char)this->fCars[i].fCarID] = '\0';
    }
  }
  return;
}



/* ---- tCarManager::SetCarViewable  [FECARS.CPP:563-566] SLD-VERIFIED ---- */

void tCarManager::SetCarViewable(tCarModels carModel,bool view)

{
  
  this->fViewableCars[carModel] = view;
  if (view == 0) {
    this->fAvailableCars[carModel] = '\x01';
  }
  return;
}



/* ---- tCarManager::GetStockCar  [FECARS.CPP:573-584] SLD-VERIFIED ---- */

void tCarManager::GetStockCar(short carNumber,tCarInfo &carInfo)

{
  uchar uVar1;

  if ((u_int)(int)carNumber >= this->fNumCars) {
    this->GetGarageCar(carNumber,carInfo,0);
  }
  else {
    blockmove(this->fCars + carNumber,&carInfo,0xcc);
    carInfo.fAvailable = this->fAvailableCars[(signed char)carInfo.fCarID];
    uVar1 = this->fViewableCars[(signed char)carInfo.fCarID];
    carInfo.fUpgrades = '\0';
    carInfo.fCountry = '\0';
    carInfo.fViewable = uVar1;
  }
  carInfo.fCarIndex = (uchar)carNumber;
  return;
}



/* ---- tCarManager::GetGarageCar  [FECARS.CPP:591-606] SLD-VERIFIED ---- */

void tCarManager::GetGarageCar(short garageNumber,tCarInfo &carInfo,short playerNum)

{
  uchar uVar1;
  u_short uVar2;
  tCarInfo *src;
  int iVar3;
  u_short uVar4;
  int iVar5;

  uVar4 = (u_short)playerNum;
  if ((playerNum == 1) && (uVar2 = this->GetNumOwnedCars(1), (int)((u_int)uVar2 << 0x10) < 1)) {
    uVar4 = 0;
  }
  iVar3 = (int)garageNumber;
  iVar5 = (int)(uVar4 << 0x10) >> 9;
  src = this->GetCarFromID((short)*(signed char *)((iVar3 - this->fNumCars) * 4 + iVar5 + 8 + (int)this));
  blockmove(src,&carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades = *(uchar *)((iVar3 - this->fNumCars) * 4 + iVar5 + 9 + (int)this);
  uVar1 = *(uchar *)((iVar3 - this->fNumCars) * 4 + iVar5 + 10 + (int)this);
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  carInfo.fColor = uVar1;
  return;
}



/* ---- tCarManager::GetPinkSlipsCar  [FECARS.CPP:613-622] SLD-VERIFIED ---- */

void tCarManager::GetPinkSlipsCar(short garageNumber,tCarInfo &carInfo,short playerNum)

{
  uchar uVar1;
  tCarInfo *src;
  int iVar2;
  int iVar3;
  
  iVar2 = (int)garageNumber;
  iVar3 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  src = this->GetCarFromID((short)*(signed char *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x108 + (int)this)
                    );
  blockmove(src,&carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades = *(uchar *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x109 + (int)this);
  uVar1 = *(uchar *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x10a + (int)this);
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  carInfo.fColor = uVar1;
  return;
}



/* ---- tCarManager::LoadDescription  [FECARS.CPP:645-702] SLD-VERIFIED ---- */

void tCarManager::LoadDescription()

{
  u_long *input;
  tCarInfo *ptVar1;
  int iVar2;
  tCarInfo *ptVar3;
  u_long uVar4;
  char *data;
  int iVar5;
  int j;
  int i;
  char filename [80];
  
  data = filename;
  input = (u_long *)sprintf(data,(char *)(bigBuf + 0x1b4),Paths_Paths[0x25],"fecars.car"
                            );
  this->ReleaseDescription();
  loadfileadr(filename,0x10);
  uVar4 = *input;
  this->fNumCars = uVar4;
  ptVar1 = reservememadr((char *)(bigBuf + 0x1c8),uVar4 * 0xcc,0);
  this->fCars = ptVar1;
  blockmove(input + 1,ptVar1,this->fNumCars * 0xcc);
  i = 0;
  if (this->fNumCars != 0) {
    iVar2 = 0;
    do {
      iVar2 = iVar2 >> 0x10;
      j = 0;
      if (this->fCars[iVar2].fAvailable != '\0') {
        this->fAvailableCars[this->fCars[iVar2].fCarID] = '\x01';
        this->fViewableCars[this->fCars[iVar2].fCarID] = '\x01';
      }
      ptVar3 = this->fCars + iVar2;
      ptVar1 = ptVar3;
      if ((u_int)(u_char)ptVar3->fNumLightColors + (u_int)(u_char)ptVar3->fNumDarkColors != 0) {
        do {
          if ((int)ptVar3->fColorOrder[0] == (u_int)ptVar1->fDefaultColor) {
            ptVar1->fDefaultColor = (uchar)j;
            break;
          }
          ptVar1 = this->fCars + iVar2;
          iVar5 = (j + 1) * 0x10000 >> 0x10;
          ptVar3 = (tCarInfo *)(ptVar1->fShapeName + iVar5 + -8);
          j = j + 1;
        } while (iVar5 < (int)((u_int)(u_char)ptVar1->fNumLightColors +
                              (u_int)(u_char)ptVar1->fNumDarkColors));
      }
      i = i + 1;
      iVar2 = i * 0x10000;
    } while ((u_int)(i * 0x10000 >> 0x10) < this->fNumCars);
  }
  purgememadr(input);
  return;
}



/* ---- tCarManager::ReleaseDescription  [FECARS.CPP:712-717] SLD-VERIFIED ---- */

void tCarManager::ReleaseDescription()

{
  
  if (this->fCars != (tCarInfo *)0x0) {
    purgememadr(this->fCars);
  }
  this->fCars = (tCarInfo *)0x0;
  this->fNumCars = 0;
  return;
}



/* ---- tCarManager::GetNumOwnedCars  [FECARS.CPP:723-735] SLD-VERIFIED ---- */

short tCarManager::GetNumOwnedCars(short playerNum)

{
  int i;
  int iVar2;
  short num;
  int base;

  num = 0;
  i = 0;
  base = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    iVar2 = base + i * 4;
    if (-1 < *(signed char *)((char *)this + iVar2 + 8)) {
      num = num + 1;
    }
    i = i + 1;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetNumTourneyCars  [FECARS.CPP:741-761] SLD-VERIFIED ---- */

short tCarManager::GetNumTourneyCars(short playerNum)

{
  /* MATCH: one signed slot-ID carrier preserves lb/bltz and the call argument;
     natural array indexing lets gcc form the retail s0 strength-reduction walk. */
  signed char carID;
  int i;
  short result;
  tCarInfo carInfo;

  result = 0;
  i = 0;
  do {
    carID = this->fCarGarage[playerNum][i].fCarID;
    if (carID >= 0) {
      carInfo.fCarID = this->fCarGarage[playerNum][i].fCarID;
      carInfo.fUpgrades = this->fCarGarage[playerNum][i].fUpgrades;
      carInfo.fCarClass =
          this->GetCarFromID(carID)->fCarClass;
      if (tournamentManager.ValidCar(carInfo)) {
        result = result + 1;
      }
    }
    i = i + 1;
  } while (i < 0x20);
  return result;
}



/* ---- tCarManager::GetNumPinkSlipsCars  [FECARS.CPP:766-778] SLD-VERIFIED ---- */

short tCarManager::GetNumPinkSlipsCars(short playerNum)

{
  int i;
  int iVar2;
  short num;
  int base;

  num = 0;
  i = 0;
  base = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    iVar2 = base + i * 4;
    if (-1 < *(signed char *)((char *)this + iVar2 + 0x108)) {
      num = num + 1;
    }
    i = i + 1;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetClassList  [FECARS.CPP:787-809] SLD-VERIFIED ---- */

short tCarManager::GetClassList(tCarClassType carClass,short numElements,tCarModels *models)

{
  u_short i;
  short numCars;

  numCars = 0;
  for (i = 0; i < this->fNumCars; i++) {
    if (this->fCars[i].fCarClass == carClass) {
      if ((int)numCars < (int)numElements) {
        models[numCars] = (int)(signed char)this->fCars[i].fCarID;
      }
      numCars = numCars + 1;
    }
  }
  for (i = numCars; (int)i < (int)numElements; i++) {
    models[i] = models[(int)i % (int)numCars];
  }
  return numCars;
}



/* ---- tCarManager::InitializeIngameCarList  [FECARS.CPP:815-821] SLD-VERIFIED ---- */

void tCarManager::InitializeIngameCarList()

{
  short i;
  short j;

  i = 0;
  do {
    j = 0;
    do {
      gCarSelected[i][j] = '\0';
      j = j + 1;
    } while (j < 0x32);
    i = i + 1;
  } while (i < 2);
  return;
}



/* ---- tCarManager::IsCarAnAddedModel  [FECARS.CPP:827-832] SLD-VERIFIED ---- */

void * tCarManager::IsCarAnAddedModel(tCarModels &model,char &color)

{
  tCarInfo *ptVar1;
  int iVar2;
  char *base;
  u_int index;

  ptVar1 = this->GetCarFromID((short)model);
  iVar2 = (int)(signed char)ptVar1->fColorOrder[(u_char)color];
  base = &gCarSelected[0][0];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 7;
  }
  index = (u_int)model + (iVar2 >> 3) * 50;
  return (void *)(u_int)(base[index] != '\0');
}



/* ---- tCarManager::AddCarToIngameList  [FECARS.CPP:838-843] SLD-VERIFIED ---- */

void tCarManager::AddCarToIngameList(tCarModels &model,char &color)

{
  tCarInfo *ptVar1;
  short carColor;

  ptVar1 = this->GetCarFromID((short)model);
  carColor = (short)(signed char)ptVar1->fColorOrder[(u_char)color];
  gCarSelected[carColor / 8][model] |= (u_char)(1 << (carColor & 7));
  return;
}



/* ---- tCarManager::FindSimilarCar  [FECARS.CPP:851-883] SLD-VERIFIED ---- */

int tCarManager::FindSimilarCar(tCarModels &model,char &color,short arg3,tCarModels *arg4)

{
  u_char bVar1;
  tCarInfo *carInfo;
  u_int colorScheme;
  int numColors;
  int iVar5;
  u_int carColor;
  u_int uVar7;
  int iVar8;
  int j;
  int i;
  
  carInfo = this->GetCarFromID((short)model);
  colorScheme = (u_int)carInfo->fColorOrder[(u_char)color];
  if ((int)colorScheme < 0) {
    colorScheme = colorScheme + 7;
  }
  colorScheme = colorScheme >> 3;
  i = 0;
  numColors = (u_int)(u_char)carInfo->fNumLightColors + (u_int)(u_char)carInfo->fNumDarkColors;
  do {
    j = 0;
    if (numColors != 0) {
      do {
        iVar8 = numColors * 0x10000 >> 0x10;
        iVar5 = (int)(short)j + (u_int)(u_char)color;
        carColor = (u_int)((u_char)carInfo->fColorOrder[iVar5 % iVar8] >> 3);
        if (carColor == (int)(short)colorScheme) {
          bVar1 = gCarSelected[carColor][model];
          uVar7 = (u_char)carInfo->fColorOrder[iVar5 % iVar8] & 7;
          if (((int)(u_int)bVar1 >> uVar7 & 1U) == 0) {
            gCarSelected[carColor][model] = bVar1 | (u_char)(1 << uVar7);
            i = (int)(short)j + (u_int)(u_char)color;
            color = (char)(i % iVar8);
            return 1;
          }
        }
        j = j + 1;
      } while (j * 0x10000 >> 0x10 < numColors);
    }
    colorScheme = 1 - colorScheme;
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 2);
  return 1;
}



/* ---- tListIteratorCar::ctor  [FECARS.CPP:890-894] SLD-VERIFIED ---- */
tListIteratorCar::tListIteratorCar(char *valPtr,tCarManager *carManager)
  : tListIterator((short *)0x0, valPtr)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorCar_vtable;
  this->fCarManager = carManager;
  this->fCarListFilter = 1;
  this->fNameLength = cnl_Medium;
  return;
}



/* ---- tListIteratorCar::dtor  [FECARS.CPP:898-898] SLD-VERIFIED ---- */

tListIteratorCar::~tListIteratorCar()

{
  *(void **)&(this->_vf) = (void *)tListIteratorCar_vtable;
  return;
}



/* ---- tListIteratorCar::Value  [FECARS.CPP:902-905] SLD-VERIFIED ---- */

char tListIteratorCar::Value(tPlayer atIndex)

{
  tPlayer i;
  
  i = kPlayerOne;
  if (atIndex != kPlayerBoth) {
    i = atIndex;
  }
  return this->fValue[(short)i];
}



/* ---- tListIteratorCar::TextValue  [FECARS.CPP:909-921] SLD-VERIFIED ---- */

short tListIteratorCar::TextValue(tPlayer atIndex)

{
  /* SYM 8c: locals are exactly `short nameBase[3]` (AUTO -8) and `short i`
     (REG $v1).  nameBase is an AGGREGATE INITIALIZER (bytes @D_80010180) =
     gcc's own 6-byte rodata->stack copy (lwl/lwr + lh / swl/swr + sh). */
  short nameBase [3] = { 0x121, 0x153, 0x185 };   /* @0x80010180 */
  short i;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = atIndex;
  }
  if (this->fCarManager->fNumCars <= (u_int)(u_char)this->fValue[i]) {
    if ((this->fCarListFilter & 0x20) != 0) {
      return nameBase[this->fNameLength] +
             (signed char)this->fCarManager->fPinkSlipsCars[i]
               [(u_int)(u_char)this->fValue[i] - this->fCarManager->fNumCars].fCarID;
    }
    return nameBase[this->fNameLength] +
           (signed char)this->fCarManager->fCarGarage[i]
             [(u_int)(u_char)this->fValue[i] - this->fCarManager->fNumCars].fCarID;
  }
  return nameBase[this->fNameLength] +
         (signed char)this->fCarManager->fCars[(u_int)(u_char)this->fValue[i]].fCarID;
}


/* ---- tListIteratorCar::AdjustPosition  [FECARS.CPP:925-1059] SLD-VERIFIED ---- */

void tListIteratorCar::AdjustPosition(tPlayer atIndex,short direction)

{
  short i;
  char oldValue;
  char oldCountry;
  tCarInfo *carInfo;
  int firstCar;
  int lastCar;
  tOwnedCarInfo *ownedCars;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = (short)atIndex;
  }
  carInfo = (tCarInfo *)0x0;
  oldValue = this->fValue[i];
  if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
    carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
    oldCountry = frontEnd.carCountry[i][(signed char)carInfo->fCarID];
  }
  else {
    oldCountry = 0;
  }
  firstCar = 0;
  if ((this->fCarListFilter & 0x89U) != 0) {
    lastCar = this->fCarManager->fNumCars;
  }
  else if ((this->fCarListFilter & 0x42U) != 0) {
    ownedCars = this->fCarManager->fCarGarage[i];
    firstCar = this->fCarManager->fNumCars;
    if ((i == 1) && (this->fCarManager->GetNumOwnedCars(1) <= 0)) {
      ownedCars = this->fCarManager->fCarGarage[0];
    }
    lastCar = 0;
    while ((signed char)ownedCars[lastCar].fCarID >= 0) {
      lastCar++;
    }
    lastCar += firstCar;
  }
  else {
    ownedCars = this->fCarManager->fPinkSlipsCars[i];
    firstCar = this->fCarManager->fNumCars;
    lastCar = 0;
    while ((signed char)ownedCars[lastCar].fCarID >= 0) {
      lastCar++;
    }
    lastCar += firstCar;
  }
  if ((u_char)this->fValue[i] >= lastCar) {
    this->fValue[i] = lastCar - 1;
  }
  if ((u_char)this->fValue[i] < firstCar) {
    this->fValue[i] = firstCar;
  }
  if (firstCar < lastCar) {
    do {
      if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
        carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
        if (carInfo->fCarClass == 7) {
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] += direction;
          if ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] >= 5) {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
            this->fValue[i]++;
            if ((u_char)this->fValue[i] < lastCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
            }
          }
          else if ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] < 0) {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            this->fValue[i]--;
            if ((u_char)this->fValue[i] >= firstCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            }
          }
        }
        else {
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] =
              ((direction << 16) > 0) ? 0 : 4;
          this->fValue[i] += direction;
          if ((direction << 16) > 0) {
            if ((signed char)this->fValue[i] < lastCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
              goto adjusted_country;
            }
          }
          if ((direction << 16) < 0) {
            if ((signed char)this->fValue[i] >= firstCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            }
          }
adjusted_country:;
        }
      }
      else {
        this->fValue[i] += direction;
      }
      {
        char *value = this->fValue + i;
        if ((signed char)*value >= lastCar) {
          *value = firstCar;
          if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
            carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
          }
        }
      }
      if ((signed char)this->fValue[i] < firstCar) {
        this->fValue[i] = lastCar - 1;
        if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
        }
      }
      if ((oldValue != this->fValue[i]) ||
          (((signed char)this->fValue[i] < (int)this->fCarManager->fNumCars) &&
           ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] != oldCountry))) {
        if ((((int)this->ValidCar(atIndex,this->fValue[i])) ^ 1) != 0) {
          continue;
        }
      }
      break;
    } while (true);
  }
}



/* ---- tListIteratorCar::Increment  [FECARS.CPP:1062-1063] SLD-VERIFIED ---- */

void tListIteratorCar::Increment(tPlayer atIndex)

{
  this->AdjustPosition(atIndex,1);
  return;
}



/* ---- tListIteratorCar::Decrement  [FECARS.CPP:1067-1068] SLD-VERIFIED ---- */

void tListIteratorCar::Decrement(tPlayer atIndex)

{
  this->AdjustPosition(atIndex,-1);
  return;
}



/* ---- tListIteratorCar::ValidCar  [FECARS.CPP:1072-1168] SLD-VERIFIED ---- */

void * tListIteratorCar::ValidCar(tPlayer atIndex,char carNumber)

{
  short i;
  short k;
  void *result;
  short carID;
  int carClass;
  tCarInfo *carInfo;
  tCarInfo garageCar;
  tTrackInformation trackInfo;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = (short)atIndex;
  }
  result = (void *)0;
  k = i;
  if ((i == 1) && (this->fCarManager->GetNumOwnedCars(1) <= 0)) {
    k = 0;
  }
  if (this->fCarManager->fNumCars <= (u_int)(u_char)carNumber) {
    carNumber -= (u_char)this->fCarManager->fNumCars;
    if ((this->fCarListFilter & 0x20U) != 0) {
      if ((signed char)this->fCarManager->fPinkSlipsCars[i][(u_char)carNumber].fCarID >= 0) {
        result = (void *)1;
      }
      return result;
    }
    if ((this->fCarListFilter & 0x42U) == 0) {
      goto ValidCar_returnResult;
    }
    carID = (signed char)this->fCarManager->fCarGarage[k][(u_char)carNumber].fCarID;
    if (carID >= 0) {
      result = (void *)1;
    }
    carInfo = this->fCarManager->GetCarFromID(carID);
    if ((frontEnd.raceType == 1) && (carInfo->fPursuitAvailable == 0)) {
      return (void *)0;
    }
    if (!result) {
      goto ValidCar_returnResult;
    }
    if ((this->fCarListFilter & 0x40U) == 0) {
      return result;
    }
    this->fCarManager->GetGarageCar((short)((u_char)carNumber +
                                            (u_short)this->fCarManager->fNumCars),garageCar,0);
    result = tournamentManager.ValidCar(garageCar);
    /* MATCH: the common result tail lets gcc cross-jump this call with the
       stock-car tournament call below. */
    goto ValidCar_returnResult;
  }
  carID = (signed char)this->fCarManager->fCars[(u_char)carNumber].fCarID;
  if (carID < 0) {
    goto ValidCar_returnResult;
  }
  if (this->fCarManager->fViewableCars[carID] == 0) {
    goto ValidCar_returnResult;
  }
  if ((frontEnd.raceType == 1) &&
      (this->fCarManager->fCars[(u_char)carNumber].fPursuitAvailable == 0)) {
    return (void *)0;
  }
  /* MATCH: retail re-derives the base-car address here and lowers the three
     class arms as an out-of-line dispatch; caching carInfo keeps the wrong CFG. */
  carClass = this->fCarManager->fCars[(u_char)carNumber].fCarClass;
  if (carClass == 7) {
    goto ValidCar_classCop;
  }
  if (carClass < 8) {
    goto ValidCar_classNormal;
  }
  if (carClass == 8) {
    goto ValidCar_classTraffic;
  }
  goto ValidCar_classDone;

ValidCar_classNormal:
  if (carClass >= 0) {
    if ((this->fCarListFilter & 0x81U) != 0) {
      result = (void *)1;
    }
    if ((carID == 0x1c) &&
       ((frontEnd.carListType == 1 || (frontEnd.gameMode == 1)) ||
        (frontEnd.raceType != 0))) {
      result = (void *)0;
    }
  }
  goto ValidCar_classDone;

ValidCar_classCop:
    if ((this->fCarListFilter & 0xcU) != 0) {
      if ((this->fCarManager->fCars[(u_char)carNumber].fCountries >>
           (signed char)frontEnd.carCountry[i][carID] & 1U) != 0) {
        trackManager.GetTrack((u_short)(u_char)frontEnd.track[0],trackInfo);
        if (FECheat_IsCheatEnabled(cheat_AllCops)) goto ValidCar_setValid;
        if ((u_char)trackInfo.fCountry == (signed char)frontEnd.carCountry[i][carID]) {
          result = (void *)1;
        }
      }
    }
  goto ValidCar_classDone;

ValidCar_classTraffic:
  if ((this->fCarListFilter & 0x10U) != 0) {
ValidCar_setValid:
    result = (void *)1;
  }
ValidCar_classDone:
  if (!result) {
    goto ValidCar_returnResult;
  }
  if ((this->fCarListFilter & 1U) == 0) {
    return result;
  }
  if (frontEnd.raceType != 2) {
    return result;
  }
  result = tournamentManager.ValidCar(this->fCarManager->fCars[(u_char)carNumber]);
ValidCar_returnResult:
  return result;
}



/* ---- tListIteratorCarColor::ctor  [FECARS.CPP:1176-1181] SLD-VERIFIED ---- */
tListIteratorCarColor::tListIteratorCarColor(char *value,char *player,char *playerCar,int indexSize,
          tCarManager *carManager)
  : tListIterator((short *)0x0, value)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorCarColor_vtable;
  this->fPlayer = player;
  this->fPlayerCar = playerCar;
  this->fIndexSize = indexSize;
  this->fCarManager = carManager;
  return;
}



/* ---- tListIteratorCarColor::dtor  [FECARS.CPP:1185-1185] SLD-VERIFIED ---- */

tListIteratorCarColor::~tListIteratorCarColor()

{
  *(void **)&(this->_vf) = (void *)tListIteratorCarColor_vtable;
  return;
}



/* ---- tListIteratorCarColor::Value  [FECARS.CPP:1189-1196] SLD-VERIFIED ---- */

char tListIteratorCarColor::Value(tPlayer arg1)

{
  int offset;
  tCarInfo *carInfo;

  offset = (int)this->fPlayer;
  carInfo = &this->fCarManager->fCars[(u_char)this->fPlayerCar[*(u_char *)offset]];
  return (u_int)(u_char)this->fValue
                     [(u_int)*(u_char *)offset * this->fIndexSize +
                      (int)(signed char)carInfo->fCarID]
  ;
}



/* ---- tListIteratorCarColor::TextValue  [FECARS.CPP:1200-1201] SLD-VERIFIED ---- */

int tListIteratorCarColor::TextValue(tPlayer arg1)

{
  return 0;
}



/* ---- tListIteratorCarColor::Increment  [FECARS.CPP:1205-1214] SLD-VERIFIED ----  NATURAL-SOURCE REWRITE (2026-08-04, edgbla-style after the Decrement land): 42 -> 4 diffs,
   count-exact 38/38.  ORACLE FACTS driving the shape: the index expression is evaluated
   TWICE (the u_char store aliases fCarID/*fPlayer, blocking cse of the loads) but the
   *fPlayer * fIndexSize PRODUCT is reused from mflo => the product is a NAMED local computed
   once, with fCarID added INLINE in each expression; fCarID is read with lb = (signed char);
   the compare is SIGNED slt (no u_int casts -- default-unsigned chars promote to int); the
   named fNumColors value-load gives the slt its retail operand.  FALSIFIED: full re-eval
   forms 43-48 (mult redone -- the product must be named), 1/0-early-returns 5@39 (retail
   returns the slt result itself, no li 1/addu 0), V7-inline-value 14, dark+light sum swap 12,
   embedded-assignment 4 (no change), early-return-var polarity 15@39.
   🏆 SEALED W54-A3 (2026-08-09) 4 -> PASS 38/38: the residual TWO coalescing copies
   (`addu v1,v0,zero` in the bnez slot + `addu v0,v1,zero` in the jr slot) were RETURN-VALUE
   STAGING, not an allocator tie.  Retail's body has NO `return` statement at all -- an
   int-declared virtual override that FALLS OFF THE END, so $v0 holds the slt result
   incidentally and both delay slots stay `nop`.  Deleting `return notWrapped;` (keeping the
   int return type the vtable needs) removes both copies -> byte-exact.
   LAW: an "ours has 2 extra moves funnelling a value to $v0" residual on a fn whose returned
   value is ALREADY in $v0 = a MISSING-RETURN retail body, not a coalescing wall.
 */

int tListIteratorCarColor::Increment(tPlayer arg1)

{
  tCarInfo *carInfo;
  u_int fNumColors_offset;
  int notWrapped;
  int fNumColors;

  fNumColors_offset = *fPlayer * fIndexSize;
  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  fValue[fNumColors_offset + (signed char)carInfo->fCarID]++;
  fNumColors = fValue[fNumColors_offset + (signed char)carInfo->fCarID];
  notWrapped = fNumColors < carInfo->fNumLightColors + carInfo->fNumDarkColors;
  if (notWrapped == 0) {
    fValue[fNumColors_offset + (signed char)carInfo->fCarID] = 0;
  }
}

/* ---- tListIteratorCarColor::Decrement  [FECARS.CPP:1218-1228] SLD-VERIFIED ---- */

void tListIteratorCarColor::Decrement(tPlayer arg1)

{
  tCarInfo *carInfo;
  u_int fNumColors_offset;
  u_int fNumColors;

  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  fNumColors_offset = *fPlayer * fIndexSize + (signed char)carInfo->fCarID;
  fNumColors = fValue[fNumColors_offset];
  fValue[fNumColors_offset] = fNumColors == 0 ? carInfo->fNumLightColors + carInfo->fNumDarkColors - 1 : fNumColors - 1;
}



/* end of fecars.cpp */
