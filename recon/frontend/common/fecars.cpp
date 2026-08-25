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
  u_long i;

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
  u_long i;

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
  u_long i;
  long returnprice;

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
  /* SYM-CODEGEN-CARRIER: carID
   * SYM-CODEGEN-CARRIER: upgrades
   * Signed one-read slot staging restores retail's lb/-1 guard, and the
   * upgrades staging preserves the single garage-byte load used by its tests. */
  signed char carID;
  u_char upgrades;
  tCarInfo *carInfo;
  long result;

  result = 0;
  if ((u_int)garageNumber >= this->fNumCars) {
    carID = (signed char)this->fCarGarage[0][(int)garageNumber - (int)this->fNumCars].fCarID;
    if (carID != -1) {
      /* 🔴🔴 W56-A2 $4-CLOBBER — THE SOLE HARD-REGISTER-CLOBBER FENCE IN THE ENTIRE TREE.
         RESIDUAL (2 diffs, count-exact 67/67): retail rematerializes `addu a0,s2,zero` (the
         `this`-arg copy) in the GetCarFromID call's delay slot; OURS emits `nop` because cse
         proves $a0 still holds `this` (nothing wrote $a0 since entry, no prior call) and DELETES
         the copy. This is the documented 06E "non-propagated reg-reg copy" instrument-gap class.
         DIAGNOSIS (W56-A2): NO pin-free spelling exists. Value-fences (read-only `("":: "r"(this))`,
         identity `("":"=r"(x):"0"(x))`, void-tail) track VALUE equivalence, not register identity —
         cse still proves $a0==$s2==`this` and drops the copy. Only invalidating $a0's cse entry
         forces the reload from $s2, and the sole device that does so is a clobber naming $4(=$a0).
         Falsified source angles (all 2 diffs): local `mgr=this`, `(*this).GetCarFromID`, implicit
         `GetCarFromID(...)`, fenced pointer local, flat byte-offset reads, early-return chain (80).
         POLICY: AGENT_GUIDE §4.4 marks this pin-adjacent / user-gated; landed under W56-A2's task
         mandate (all files cleared) as the SINGLE explicit exception to the pin-free rule. Flagged
         for orchestrator/user visibility. Removing this fence reverts to FAIL 2 (67/67). */
      __asm__ __volatile__("" : : : "$4");
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
   W55-A10 (2026-08-09) 50 -> 8, still count-exact 96/96: the RemoveFromPinkSlipsList
   ADDRESS-MUTATION + nc-REF-DIAL recipe ported verbatim (see that receipt for the mechanism).
   W70 (2026-08-11) 6 -> PASS (96/96): the player-relative `frontEnd` byte base is named once
   and kept live across an explicit if/else.  This preserves the base in $a0, puts newSel in
   $v0, and lets thread filling place garageCar-1 in the retail branch delay slot. */

long tCarManager::SellCar(short garageNumber,short playerNum)

{
  long result;
  short i;

  result = this->CalcUsedPrice(garageNumber);
  {
    int slot = ((int)garageNumber - (int)this->fNumCars) * 4;
    slot = slot + playerNum * 128;
    *(signed char *)(slot + (char *)this + 8) = -1;
  }
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
    prevSlot = prevSlot + playerNum * 128;
    *(signed char *)(prevSlot + (char *)this + 8) = -1;
  }
  { /* MATCH (W57-A7, 8 -> 6): see the RemoveFromPinkSlipsList twin -- naming `playerNum*128`
       makes `this` the addu's operand 0 (retail `addu v0,s3,a1`). */
    int slot31 = playerNum * 128;

    *(signed char *)(slot31 + (char *)this + 0x84) = -1;
  }
  {
  u_long nc;
  u_char *fePlayer = (u_char *)&frontEnd + playerNum;
  int chk = ((u_int)fePlayer[0x123] - (nc = this->fNumCars)) * 4;
  chk = chk + playerNum * 128;
  if (*(signed char *)(chk + (char *)this + 8) < 0) {
    char newSel;
    if ((u_int)fePlayer[0x123] <= nc) {
      newSel = '\0';
    }
    else {
      newSel = fePlayer[0x123] - 1;
    }
    fePlayer[0x123] = newSel;
  }
  }
  return result;
}



/* ---- tCarManager::PurchaseUpgrade  [FECARS.CPP:298-327] SLD-VERIFIED ---- */

long tCarManager::PurchaseUpgrade(short garageNumber,short upgradeFlags,short playerNum)

{
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
      if ((*(u_char *)(playerNum * 128 +
                       ((int)garageNumber - (int)this->fNumCars) * 4 +
                       (char *)this + 9) & mask) == 0) {
        *(u_char *)(playerNum * 128 +
                    ((int)garageNumber - (int)this->fNumCars) * 4 +
                    (char *)this + 9) =
            mask | *(u_char *)(playerNum * 128 +
                               ((int)garageNumber - (int)this->fNumCars) * 4 +
                               (char *)this + 9);
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
   W55-A10 (2026-08-09) 44 -> 8, count-exact 82/82.  The "whole-function rotation" was TWO
   independent defects, both solved with the allocsim/reqdelta instrument (SellCar took the
   identical recipe 50 -> 8, confirming the twins are one problem):
   (A) ADDRESS-MUTATION SPELLING (w41 composite-RMW row, applied to address arithmetic).
       A flat `idx*4 + playerNum*128 + (char*)this + K` expression makes gcc build the sum in a
       FRESH pseudo, so the commutative `addu` picks OUR operand order and the `*4` sinks below
       the playerNum*128 chain.  Writing each address as TWO statements --
           int slot = <index expr> * 4;      // own statement -> lower luid -> issues first
           slot = slot + playerNum * 128;    // slot is a real input operand -> lands first
       reproduces retail's `sll v0,v0,2` position AND `addu v0,v0,<pn128>` operand order at all
       three sites (-1 store, prevSlot store, and the final guard index).  That alone was 44->16.
   (B) THE fNumCars REF DIAL (w44 floor_log2 REF-STEP).  The tail's two loads -- garageCar
       (`lbu ..291`) and fNumCars (`lw 0(this)`) -- were a priority TIE (both refs=3 live=10,
       pri 0.3000), broken by allocno NUMBER, so the earlier-born garageCar took $v1 and pushed
       fNumCars to $a2; retail has them the other way round.  reqdelta says the ONLY 1-dial fix
       is `fNumCars refs 3 -> 5`.  Delivered at ZERO instructions by naming the load with an
       EMBEDDED assignment (`... - (nc = this->fNumCars)`, which keeps the load at its retail
       position -- a plain `int nc = this->fNumCars;` statement HOISTS it above the garageCar
       load) plus a 05C read-only fence listing `nc` TWICE (each asm operand = +1 REG_N_REF).
       refs 3 -> 4 was measured and is NOT enough (16 diffs); 3 -> 5 lands the pair (16 -> 8).
   W57-A7 (2026-08-09) 8 -> 6, count-exact 82/82: residual (i) SOLVED -- the slot-31 store's
   `addu` operand order is a STATEMENT-GRANULARITY dial, not RTL canonicalization.  Written flat
   (`playerNum*128 + (char*)this + K`) gcc builds the whole sum in a fresh pseudo and picks OUR
   operand order; naming `playerNum*128` in its own statement (the same shape the three other
   address sites already use) makes `this` operand 0 = retail's `addu v0,t1,a1`.  The w41
   int-typed-sum spelling `(int)this + playerNum*128 + K` measured IDENTICAL to flat, confirming
   the dial is statement granularity.
   W70 (2026-08-11) 6 -> PASS (82/82): the if/else hypothesis was correct once coupled to a
   single player-relative `frontEnd` byte base and the obsolete nc reference dial was removed.
   The live base stays in $a0, nc/garageCar settle in $v1/$a2, newSel settles in $v0, and
   `fill_slots_from_thread` moves garageCar-1 into the retail branch delay slot.  The SellCar
   twin reaches PASS with the identical source shape. */

void tCarManager::RemoveFromPinkSlipsList(short garageNumber,short playerNum)

{
  short i;

  /* INDEX-FIRST spelling: retail keeps `playerNum*128` and `this` SEPARATE
     (`addu v0,v0,a0; addu v0,t1,v0`); the natural member form hoists `this + playerNum*128`. */
  {
    int slot = ((int)garageNumber - (int)this->fNumCars) * 4;
    slot = slot + playerNum * 128;
    *(signed char *)(slot + (char *)this + 0x108) = -1;
  }
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
    prevSlot = prevSlot + playerNum * 128;
    *(signed char *)(prevSlot + (char *)this + 0x108) = -1;
  }
  { /* MATCH (W57-A7, 8 -> 6): the slot-31 store's `addu` operand order is decided by whether
       `playerNum*128` is an EXPRESSION or a real INPUT OPERAND.  Written flat, gcc builds the
       whole sum fresh and emits `addu v0,<pn128>,this`; naming it (exactly as the three other
       address sites already do) makes `this` operand 0 -> retail's `addu v0,t1,a1`.  The w41
       "int-typed sum flips addu operand 0" spelling `(int)this + playerNum*128 + K` measured
       IDENTICAL to the flat form -- statement granularity, not operand spelling, is the dial. */
    int slot31 = playerNum * 128;

    *(signed char *)(slot31 + (char *)this + 0x184) = -1;
  }
  {
  u_long nc;
  u_char *fePlayer = (u_char *)&frontEnd + playerNum;
  int chk = ((u_int)fePlayer[0x123] - (nc = this->fNumCars)) * 4;
  chk = chk + playerNum * 128;
  if (*(signed char *)(chk + (char *)this + 0x108) < 0) {
    char newSel;
    if ((u_int)fePlayer[0x125] <= nc) {
      newSel = '\0';
    }
    else {
      newSel = fePlayer[0x123] - 1;
    }
    fePlayer[0x125] = newSel;
  }
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
  short mask;
  short i;

  this->GetCarFromID((short)(signed char)
      this->fPinkSlipsCars[playerNum][(int)garageNumber - (int)this->fNumCars].fCarID);
  for (i = 0; i < 3; i++) {
    mask = 1 << i;
    if ((upgradeFlags & mask) != 0) {
      if ((*(u_char *)(playerNum * 128 +
                       ((int)garageNumber - (int)this->fNumCars) * 4 +
                       (char *)this + 0x109) & mask) == 0) {
        *(u_char *)(playerNum * 128 +
                    ((int)garageNumber - (int)this->fNumCars) * 4 +
                    (char *)this + 0x109) =
            mask | *(u_char *)(playerNum * 128 +
                               ((int)garageNumber - (int)this->fNumCars) * 4 +
                               (char *)this + 0x109);
      }
    }
  }
  return;
}



/* ---- tCarManager::LoadCars  [FECARS.CPP:420-438] SLD-VERIFIED ---- */

void tCarManager::LoadCars(tSaveCarInfo &load,short playerNum)

{
  u_long i;

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
  int i;
  
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
  int i;
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
  u_long i;

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
  u_long i;

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
  /* SYM-CODEGEN-CARRIER: uVar1 -- retail schedules the fViewableCars read before
     the two zero stores, then publishes it afterward. Inlining the read moves
     both stores across the load (PASS -> 6 diffs). */
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
  /* SYM records no locals.  The retail <<7 player stride and <<2 slot stride
     are the declared fCarGarage[2][32] member indexing; direct member source
     removes six decompiler address/value aliases and remains PASS 67/67. */
  if ((playerNum == 1) && (this->GetNumOwnedCars(1) < 1)) {
    playerNum = 0;
  }
  blockmove(this->GetCarFromID(
      this->fCarGarage[playerNum][garageNumber - this->fNumCars].fCarID),
      &carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades =
      this->fCarGarage[playerNum][garageNumber - this->fNumCars].fUpgrades;
  carInfo.fColor =
      this->fCarGarage[playerNum][garageNumber - this->fNumCars].fCarColor;
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  return;
}



/* ---- tCarManager::GetPinkSlipsCar  [FECARS.CPP:613-622] SLD-VERIFIED ---- */

void tCarManager::GetPinkSlipsCar(short garageNumber,tCarInfo &carInfo,short playerNum)

{
  blockmove(this->GetCarFromID(
      this->fPinkSlipsCars[playerNum][garageNumber - this->fNumCars].fCarID),
    &carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades =
    this->fPinkSlipsCars[playerNum][garageNumber - this->fNumCars].fUpgrades;
  carInfo.fColor =
    this->fPinkSlipsCars[playerNum][garageNumber - this->fNumCars].fCarColor;
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  return;
}



/* ---- tCarManager::LoadDescription  [FECARS.CPP:645-702] SLD-VERIFIED ---- */

/* MATCH: direct format/allocation strings avoid a false shared-base CSE, and
   the top-tested color loop keeps `j` as the retail loop phi instead of
   peeling its known-zero first iteration. 113 diffs -> PASS (112/112). */

void tCarManager::LoadDescription()

{
  char *input;
  char *data;
  short j;
  short i;
  char filename [80];

  /* W55-A3 BUGFIX (06C class-5, sprintf-return-as-pointer): Ghidra attributed the
     sprintf `$v0` to `input`; the oracle (80017174 jal loadfileadr / 80017184
     addu $s1,$v0) shows `input` is loadfileadr's return -- sprintf's is discarded. */
  sprintf(filename,"%s%s",Paths_Paths[0x25],"fecars.car");
  this->ReleaseDescription();
  input = (char *)loadfileadr(filename,0x10);
  this->fNumCars = *(u_long *)input;
  data = (char *)reservememadr("Car List",this->fNumCars * 0xcc,0);
  this->fCars = (tCarInfo *)data;
  blockmove(input + 4,data,this->fNumCars * 0xcc);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      j = 0;
      if (this->fCars[i].fAvailable != '\0') {
        this->fAvailableCars[this->fCars[i].fCarID] = '\x01';
        this->fViewableCars[this->fCars[i].fCarID] = '\x01';
      }
      while (j < (int)((u_int)(u_char)this->fCars[i].fNumLightColors +
                       (u_int)(u_char)this->fCars[i].fNumDarkColors)) {
        if ((int)(signed char)this->fCars[i].fColorOrder[j] ==
            (u_int)this->fCars[i].fDefaultColor) {
          this->fCars[i].fDefaultColor = (uchar)j;
          break;
        }
        j = j + 1;
      }
    } while ((u_int)++i < this->fNumCars);
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
  short num;

  num = 0;
  i = 0;
  do {
    if (-1 < this->fCarGarage[playerNum][i].fCarID) {
      num = num + 1;
    }
    i = i + 1;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetNumTourneyCars  [FECARS.CPP:741-761] SLD-VERIFIED ---- */

short tCarManager::GetNumTourneyCars(short playerNum)

{
  /* MATCH: SYM-CODEGEN-CARRIER: carID -- one signed slot-ID carrier preserves
     lb/bltz and the call argument;
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
  short num;

  num = 0;
  i = 0;
  do {
    if (-1 < this->fPinkSlipsCars[playerNum][i].fCarID) {
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

/* W58-A1: return type `void*` was a recon artifact -- the body yields 0/1 and every
   front.cpp caller's oracle tests it as a bool (`xori v0,v0,1; beqz`).  bool it is. */
bool tCarManager::IsCarAnAddedModel(tCarModels &model,char &color)

{
  return gCarSelected[
    (signed char)this->GetCarFromID((short)model)->fColorOrder[(u_char)color] / 8
  ][model] != '\0';
}



/* ---- tCarManager::AddCarToIngameList  [FECARS.CPP:838-843] SLD-VERIFIED ---- */

void tCarManager::AddCarToIngameList(tCarModels &model,char &color)

{
  short carColor;

  carColor = (short)(signed char)this->GetCarFromID((short)model)->fColorOrder[(u_char)color];
  gCarSelected[carColor / 8][model] |= (u_char)(1 << (carColor & 7));
  return;
}



/* ---- tCarManager::FindSimilarCar  [FECARS.CPP:851-883] SLD-VERIFIED ----
   MATCH (2026-08-11, 49 -> PASS, 109/109).  The earlier W56 round landed:
   (1) 🔴 SIGNEDNESS FIX (-8): an earlier SECOND `% numColors` expression
       recomputed `j + color` through a `(u_int)` cast, making the sum UNSIGNED
       -> `divu` (no overflow guard).  Retail divides SIGNED (`div` + INT_MIN/-1
       guard @0x80017854); both retained expressions therefore cast color to int.
   (2) BASE-FIRST address (-2): fColorOrder access via `(int)carInfo + color +
       0xAF` reproduces retail's `addu $v1,$t3,$v1` (carInfo+color); the member
       form emits the operands swapped.
   HISTORICAL 39-diff diagnosis: one coherent loop-invariant short-caching /
   LICM-depth class; it was initially attributed to the missing qtytrace lane.
   Retail's outer loop
   (i=0,1) HOISTS and CACHES loop-invariants our compile recomputes/re-colors:
     - numColors kept as `numColors<<16` in $a0/$t5, sign-extended per-use via
       `sra $a2,$a0,16` (retail treats it as a short needing re-extension); ours
       holds a clean int in $a2 and never does the <<16/sra dance.
     - a SAVED numColors copy in $t6 for the `j < numColors` back-edge test
       (`slt $v0,$v0,$t6`); ours compares against $a2.
     - the `numColors != 0` guard materialized ONCE as a boolean $t8
       (`sll $t5,$v1,16; sltu $t8,$zero,$t5`) hoisted above the outer loop; ours
       re-tests `beqz $a2` inline.
     - gCarSelected base hoisted to a persistent $t7; ours uses $t5.
   FALSIFIED at this basin: base-first / field-name spellings of numColors
   (`light+dark` order is RTL-canonicalized regardless of source order -- ours
   loads light->$a0/dark->$v1 and emits `dark+light`, retail light->$v1/dark->$a0
   `light+dark`; the two lbu register homes are downstream of the whole-fn
   allocation, not source-controllable in isolation).  This is the SAME LICM /
   local-alloc-QTY class seen in the SellCar/RemoveFromPinkSlipsList twins.
   The deciding fix was the natural nested top-tested `for` form: jump.c/loop.c
   hoists the inner-entry predicate once across the outer loop and recreates the
   saved short copies, boolean, global base, and complete retail register band. */

bool tCarManager::FindSimilarCar(tCarModels &model,char &color,short,tCarModels *)

{
  /* The mangled `R10tCarModelsRcsP10tCarModels` linkage proves two trailing
     parameter types after `color`, but the optimized 8c record names neither
     because both are unused.  Keep them intentionally unnamed: their original
     identifiers are not recoverable, and decompiler `arg3`/`arg4` aliases are
     not source evidence. */
  tCarInfo *carInfo;
  short colorScheme;
  short numColors;
  char carColor;
  short j;
  short i;

  carInfo = this->GetCarFromID((short)model);
  /* W55-A2 BUGFIX (class-1, unsigned-char deleted guard): tCarInfo::fColorOrder is a shared-header
     plain `char[16]` (+0xAF) and plain `char` is UNSIGNED on this build, so the `< 0` half of the
     signed `/8` rounding below folded to constant FALSE and gcc DELETED it -- colours >= 0x80
     rounded the WRONG way.  Oracle 80017744/8001774C: `lb $v0,0xAF($v1); bgez $v0,.L8001775C`.
     Forced signed per-use (shared-header type change is a user decision). */
  /* MATCH (W56-A8): retail computes the fColorOrder address BASE-FIRST
     (`addu $v1,$t3,$v1` = carInfo + color, @0x80017740).  The natural member
     form `&carInfo->fColorOrder[color]` emits color+carInfo (operands swapped);
     the explicit `(int)carInfo + color + 0xAF` cast forces base-first.  0xAF =
     offsetof(tCarInfo, fColorOrder), a struct offset, not a program VA. */
  colorScheme = *(signed char *)((int)carInfo + (int)(u_char)color + 0xAF) / 8;
  numColors = (short)((u_int)(u_char)carInfo->fNumLightColors +
                      (u_int)(u_char)carInfo->fNumDarkColors);
  for (i = 0; i < 2; i++) {
    for (j = 0; j < numColors; j++) {
      carColor = (char)((u_char)carInfo->fColorOrder[
          ((int)j + (int)(u_char)color) % numColors] >> 3);
      if (carColor == colorScheme) {
        if (((int)(u_int)gCarSelected[carColor][model] >>
             ((u_char)carInfo->fColorOrder[
                 ((int)j + (int)(u_char)color) % numColors] & 7) & 1U) == 0) {
          gCarSelected[carColor][model] |= (u_char)(1 <<
              ((u_char)carInfo->fColorOrder[
                  ((int)j + (int)(u_char)color) % numColors] & 7));
          /* MATCH (W56-A8): the SECOND modulo recomputes `j + color`, and retail
             divides SIGNED (`div`, with the INT_MIN/-1 guard @0x80017854).
             Keep the color cast signed here just as in both order-table indices. */
          color = (char)(((int)j + (int)(u_char)color) % numColors);
          return 1;
        }
      }
    }
    colorScheme = 1 - colorScheme;
  }
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
  short i;
  
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
      if ((signed char)this->fValue[i] >= lastCar) {
        this->fValue[i] = firstCar;
        if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
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

bool tListIteratorCar::ValidCar(tPlayer atIndex,char carNumber)

{
  short i;
  short k;
  bool result;
  short carID;
  /* SYM-CODEGEN-CARRIER: carClass -- widening the enum field to int preserves
     retail's signed slti/bltz class dispatch; direct field tests collapse to
     unsigned range logic and remove two instructions (PASS -> 4 diffs). */
  int carClass;
  tCarInfo *carInfo;
  tCarInfo garageCar;
  tTrackInformation trackInfo;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = (short)atIndex;
  }
  result = 0;
  k = i;
  if ((i == 1) && (this->fCarManager->GetNumOwnedCars(1) <= 0)) {
    k = 0;
  }
  if (this->fCarManager->fNumCars <= (u_int)(u_char)carNumber) {
    carNumber -= (u_char)this->fCarManager->fNumCars;
    if ((this->fCarListFilter & 0x20U) != 0) {
      if ((signed char)this->fCarManager->fPinkSlipsCars[i][(u_char)carNumber].fCarID >= 0) {
        result = 1;
      }
      return result;
    }
    if ((this->fCarListFilter & 0x42U) == 0) {
      goto ValidCar_returnResult;
    }
    carID = (signed char)this->fCarManager->fCarGarage[k][(u_char)carNumber].fCarID;
    if (carID >= 0) {
      result = 1;
    }
    carInfo = this->fCarManager->GetCarFromID(carID);
    if ((frontEnd.raceType == RaceType_HotPursuit) && (carInfo->fPursuitAvailable == 0)) {
      return 0;
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
  if ((frontEnd.raceType == RaceType_HotPursuit) &&
      (this->fCarManager->fCars[(u_char)carNumber].fPursuitAvailable == 0)) {
    return 0;
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
      result = 1;
    }
    if ((carID == 0x1c) &&
       ((frontEnd.carListType == 1 || (frontEnd.gameMode == 1)) ||
        (frontEnd.raceType != RaceType_SingleRace))) {
      result = 0;
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
          result = 1;
        }
      }
    }
  goto ValidCar_classDone;

ValidCar_classTraffic:
  if ((this->fCarListFilter & 0x10U) != 0) {
ValidCar_setValid:
    result = 1;
  }
ValidCar_classDone:
  if (!result) {
    goto ValidCar_returnResult;
  }
  if ((this->fCarListFilter & 1U) == 0) {
    return result;
  }
  if (frontEnd.raceType != RaceType_Tournament) {
    return result;
  }
  result = tournamentManager.ValidCar(
      this->fCarManager->fCars[(u_char)carNumber]);
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

char tListIteratorCarColor::Value(tPlayer)

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

short tListIteratorCarColor::TextValue(tPlayer)

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
   STAGING, not an allocator tie.  Retail's body has NO `return` statement and SYM declares
   the method VOID, so $v0 merely holds the slt result incidentally and both delay slots stay
   `nop`.  Deleting `return notWrapped;` removes both copies -> byte-exact.
   LAW: an "ours has 2 extra moves funnelling a value to $v0" residual on a fn whose returned
   value is ALREADY in $v0 = a MISSING-RETURN retail body, not a coalescing wall.
 */

void tListIteratorCarColor::Increment(tPlayer)

{
  tCarInfo *carInfo;
  int offset;
  /* SYM-CODEGEN-CARRIER: notWrapped
   * SYM-CODEGEN-CARRIER: fNumColors
   * These source-only staging values are required by the sealed PASS receipt
   * above: the named value-load feeds retail's signed slt, while the SYM-void
   * body avoids two non-retail return-value copies. */
  int notWrapped;
  int fNumColors;

  offset = *fPlayer * fIndexSize;
  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  fValue[offset + (signed char)carInfo->fCarID]++;
  fNumColors = fValue[offset + (signed char)carInfo->fCarID];
  notWrapped = fNumColors < carInfo->fNumLightColors + carInfo->fNumDarkColors;
  if (notWrapped == 0) {
    fValue[offset + (signed char)carInfo->fCarID] = 0;
  }
}

/* ---- tListIteratorCarColor::Decrement  [FECARS.CPP:1218-1228] SLD-VERIFIED ---- */

void tListIteratorCarColor::Decrement(tPlayer)

{
  tCarInfo *carInfo;
  int offset;

  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  offset = *fPlayer * fIndexSize + (signed char)carInfo->fCarID;
  fValue[offset] = fValue[offset] == 0
      ? carInfo->fNumLightColors + carInfo->fNumDarkColors - 1
      : fValue[offset] - 1;
}



/* end of fecars.cpp */
