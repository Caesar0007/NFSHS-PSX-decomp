/* frontend/common/fetourn.cpp -- RECONSTRUCTED (tournament manager + list iterator; C++ TU)
 *   tTournamentManager (28 methods) + tListIteratorTournament:tListIterator (7) + free
 *   tournPointsCompare. 5 in_a0(this-lost) fns rebuilt from m2c; phantoms via m2c oracle.
 */
#include "fetourn.h"

/* ---- link-harness owned-global definition (extern-declared, never defined) ---- */
long gTrackFinishBill, gTrackFinishBonus; long gTrackFinishPrizes[64];  /* fetourn.obj-owned race-finish accounting (BSS) */

/* ---- anonymous .rodata constants Ghidra named gFEData_<addr> (NOT in SYM; part of the blob
   "SML\0WGSBTR%c%02d" @0x80011658) -- materialized byte-exact + symbol-split as Ghidra saw them:
   the SML trophy-size letters + the "WGSB" trophy-file 4-byte magic. ---- */
static char gFEData_80011658 = 'S', gFEData_80011659 = 'M', gFEData_8001165a = 'L';
static int  gFEData_8001165c = 0x42534757;   /* "WGSB" (LE) trophy-file magic */


/* ---- tTournamentManager::Initialize  [FETOURN.CPP:36-82] ---- */

void tTournamentManager::Initialize()

{
  short i;

  this->fMoney = 20000;
  this->fCurrentTrack = 0;
  this->fNumTiers = '\0';
  this->fDefinition = (tTournamentDefinition *)0x0;
  this->fTournamentList[0] = 0;
  this->fTrackList[0] = 0;
  for (i = 0; i < 6; i++) {
    this->fRanking[i] = '\0';
  }
  for (i = 0; i < 0x40; i++) {
    this->fBestPlacement[i] = '\a';
  }
  for (i = 0; i < 3; i++) {
    this->fTierFinishPrize[i] = 6;
    this->fTierFinishPrizeChange[i] = 0;
  }
  { /* MATCH: a `long` temp forces the WORD load of fNumCars -- assigning the expression
       straight into the char slot lets gcc narrow the load to `lbu` (retail has `lw`). */
    long numCars = carManager.fNumCars;
    frontEnd.garageCar[0] = numCars - 1;
    frontEnd.garageCar[1] = frontEnd.garageCar[0]; }
  return;
}



/* ---- tTournamentManager::LoadDescription  [FETOURN.CPP:89-139] ---- */

void tTournamentManager::LoadDescription()

{
  short sVar1;
  void *src;
  tTournamentDefinition *ptVar2;
  uint uVar3;
  short sVar4;
  uint uVar5;
  short track;
  uint uVar6;
  char *data;
  void *src_00;
  short tourney;
  uint uVar7;
  short tier;
  int iVar8;
  char filename [80];
  char *input;
  
  sprintf(filename,"%s%s",Paths_Paths[0x25],"tourn.trn");
  this->ReleaseDescription();
  src = (void *)loadfileadr(filename,0x10);
  blockmove(src,this->fFinishPoints,6);
  this->fNumTiers = *(char *)((int)src + 6);
  ptVar2 = reservememadr("Tourney",0x2924,0);
  tier = 0;
  this->fDefinition = ptVar2;
  src_00 = (void *)((int)src + 7);
  if (this->fNumTiers != '\0') {
    do {
      blockmove(src_00,this->fDefinition->fTiers + tier,0xc);
      ptVar2 = this->fDefinition;
      uVar7 = (uint)ptVar2->fTiers[tier].fTournOffset;
      src_00 = (void *)((int)src_00 + 0xc);
      tourney = (short)uVar7;
      if (uVar7 < uVar7 + ptVar2->fTiers[tier].fNumTournaments) {
        do {
          blockmove(src_00,ptVar2->fTournaments + tourney,0x54);
          ptVar2 = this->fDefinition;
          uVar6 = (uint)ptVar2->fTournaments[tourney].fTrackOffset;
          src_00 = (void *)((int)src_00 + 0x54);
          track = (short)uVar6;
          if (uVar6 < uVar6 + ptVar2->fTournaments[tourney].fNumTracks) {
            do {
              blockmove(src_00,ptVar2->fTracks + track,0x28);
              track = track + 1;
              ptVar2 = this->fDefinition;
              src_00 = (void *)((int)src_00 + 0x28);
            } while (track < (int)(uVar6 + ptVar2->fTournaments[tourney].fNumTracks));
          }
          tourney = tourney + 1;
          ptVar2 = this->fDefinition;
        } while (tourney < (int)(uVar7 + ptVar2->fTiers[tier].fNumTournaments));
      }
      tier = tier + 1;
    } while (tier < (int)(uint)(byte)this->fNumTiers);
  }
  purgememadr(src);
  return;
}



/* ---- tTournamentManager::ReleaseDescription  [FETOURN.CPP:145-149] ---- */

void tTournamentManager::ReleaseDescription()

{
  
  if (this->fDefinition != (tTournamentDefinition *)0x0) {
    purgememadr(this->fDefinition);
    this->fDefinition = (tTournamentDefinition *)0x0;
  }
  return;
}



/* ---- tTournamentManager::UpdateTrackList  [FETOURN.CPP:195-209] ---- */
void tTournamentManager::UpdateTrackList(short tier,short tournament)
{
  tTourneyInfo *currentTourney;
  short numTracks;
  short trackOffset;
  short i;

  currentTourney = this->fDefinition->fTournaments +
                   (this->fDefinition->fTiers[tier].fTournOffset + tournament);
  numTracks = currentTourney->fNumTracks;
  trackOffset = currentTourney->fTrackOffset;
  i = 0;
  if (numTracks != 0) {
    do {
      this->fTrackList[i] = (signed char)this->fDefinition->fTracks[trackOffset++].fTrackNumber + 0xd5;
      i = i + 1;
    } while (i < numTracks);
  }
  this->fTrackList[numTracks] = 0;
  return;
}

/* ---- tTournamentManager::GetTrackList  [FETOURN.CPP:234-236] ---- */

short * tTournamentManager::GetTrackList(short tier,short tournament)

{
  
  this->UpdateTrackList(tier,tournament);
  return this->fTrackList;
}



/* ---- tTournamentManager::GetTrackToRace  [FETOURN.CPP:243-249] ---- */

void tTournamentManager::GetTrackToRace(tTrackInfo &track_r)

{
  tTrackInfo *track = &track_r;   /* R-ref param; alias keeps the pointer-form body codegen-identical */
  tTournamentDefinition *ptVar1;
  
  ptVar1 = this->fDefinition;
  /* Retail adds fTrackOffset and fCurrentTrack before the single 40-byte
     scale.  Writing the tournament lookup as index+base also preserves its
     offset-first MIPS addu operand order. */
  blockmove(ptVar1->fTracks +
             ((uint)(((uint)ptVar1->fTiers[this->fTier].fTournOffset + this->fTournament)
                       + ptVar1->fTournaments)->fTrackOffset
              + this->fCurrentTrack),track,0x28);
  track->fDirection = this->fDirection[this->fCurrentTrack];
  track->fMirrored = this->fMirror[this->fCurrentTrack];
  track->fTimeOfDay = this->fTimeOfDay[this->fCurrentTrack];
  track->fWeather = this->fWeather[this->fCurrentTrack];
  return;
}



/* ---- tTournamentManager::StartNewTournament  [FETOURN.CPP:264-324] ----
   W55-A10 (2026-08-09) 39 -> 20 diffs, now COUNT-EXACT 142/142 (was 141/142).  Three fixes:
   (1) 🔴 SHARED-HEADER SHAPE: `fNumRacers` is a 4-BYTE field in retail -- every access here is
       a word (`sll 16; sra 16; sw v0,16(s3)` for the store, `lw v1,16(s3)` for the loop bound),
       but nfs4_types.h models +0x10 as `short fNumRacers, fPadNumRacers;`.  Forced per-use with
       `*(int *)&this->fNumRacers` (store + loop bound); the real fix is a header type change,
       which is a USER decision (the `fPadNumRacers` sibling suggests the split was invented).
   (2) BRANCH POLARITY of the two `i == 0` selects: retail's guards are `beqz`, i.e. the i!=0
       arm is the FALL-THROUGH and the i==0 arm is out-of-line -- write them as `if (i != 0)`.
   W57-A4 (2026-08-09) 20 -> 0, SEALED.  Two more:
   (3) 🏆 TERNARY-FOR-A-TWO-ARM STORE TO ONE ADDRESS: both `i==0` selects are written as
       ONE assignment with a COND_EXPR value (`fCompetitors[i].fX = (i != 0) ? A : B;`), not
       as if/else with a store in each arm.  gcc materializes `&fCompetitors[i]` ONCE before
       the branch and both arms store through that register; the if/else form re-derives the
       address inside the i==0 arm, where cse then const-folds `i`->0 and re-anchors on
       `this` (`280(s3)`/`294(s3)` instead of retail's `280(v1)`/`294(a0)`).  The emitted
       code is still two stores + a `j` (gcc duplicates the store per arm), so this is a
       CSE-scope lever, not a shape change.  NOTE: this does NOT contradict catalog 08E
       ("COND_EXPR arm-order is jump.c-canonicalized") -- the arm ORDER is invariant, the
       ADDRESS-CSE SCOPE is not.
   (4) split accumulation `iVar5 = tourn->fTrackOffset; iVar5 = iVar5 + i;` (not the fused
       `= fTrackOffset + i`) so the loaded value and the sum share one pseudo -> retail's
       `lbu v1,2(s4); addu v1,v1,a0` instead of `lbu v0; addu v1,v0,a0`.  (07A reuse-an-
       existing-pseudo.)  `fNumRacers` is now a real `int` in nfs4_types.h (W56-A2), so the
       `*(int *)&` casts are gone. */

void tTournamentManager::StartNewTournament(byte tier,byte tournament)

{
  byte bVar1;
  short sVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  tTournamentDefinition *ptVar6;
  int iVar7;
  tTournamentDefinition *ptVar8;
  tTrackInfo *track;
  short i;
  int iVar9;
  tTourneyInfo *tourn;
  
  this->fTier = (uint)tier;
  this->fTournament = (uint)tournament;
  this->fCurrentTrack = 0;
  sVar2 = this->GetNumCompetitors();
  ptVar8 = this->fDefinition;
  /* MATCH (W55-A10): retail stores a FULL WORD here (`sll 16; sra 16; sw v0,16(s3)`), i.e.
     fNumRacers is a 4-byte field in the original -- our shared header models it as
     `short fNumRacers, fPadNumRacers;` (a USER-owned nfs4_types.h change), so force the
     word store per-use.  The sign-extend comes from `(int)sVar2` for free. */
  *(int *)&this->fNumRacers = (int)sVar2;
  i = 0;
  iVar7 = (uint)ptVar8->fTiers[this->fTier].fTournOffset + this->fTournament;
  tourn = ptVar8->fTournaments + iVar7;
  if (0 < sVar2) {
    do {
      this->fCompetitors[i].fPoints = 0;
      this->fCompetitors[i].fEliminated = 0;
      this->fCompetitors[i].fIsPlayerCar = '\0';
      /* MATCH (W55-A10): retail's guards are `beqz` -- the i!=0 arm is the FALL-THROUGH and
         the i==0 arm sits OUT-OF-LINE.  Writing the tests as `i != 0` (not `i == 0`) picks
         that polarity/block order. */
      this->fCompetitors[i].fPersonality =
          (i != 0) ? (uint)tourn->fPersonalities[i + -1] : (uint)kPersonalityNemesis;
      this->fCompetitors[i].fPosition = (i != 0) ? (uchar)i : (uchar)this->fNumRacers;
      i = i + 1;
    } while (i < *(int *)&this->fNumRacers);
  }
  i = 0;
  if (tourn->fNumTracks != '\0') {
    do {
      iVar5 = (uint)tourn->fTrackOffset;
      iVar5 = iVar5 + i;
      ptVar6 = this->fDefinition;
      track = ptVar6->fTracks + iVar5;
      bVar1 = track->fDirection;
      this->fDirection[i] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fDirection[i] = (byte)iVar4 & 1;
      }
      bVar1 = track->fMirrored;
      this->fMirror[i] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fMirror[i] = (byte)iVar4 & 1;
      }
      bVar1 = track->fTimeOfDay;
      this->fTimeOfDay[i] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fTimeOfDay[i] = (byte)iVar4 & 1;
      }
      bVar1 = track->fWeather;
      this->fWeather[i] = bVar1;
      if (1 < bVar1) {
        iVar5 = rand();
        this->fWeather[i] = (byte)iVar5 & 1;
      }
      i = i + 1;
    } while (i < (int)(uint)tourn->fNumTracks);
  }
  this->fCompetitors[0].fIsPlayerCar = '\x01';
  return;
}



/* ---- tTournamentManager::IsTournamentFinished  [FETOURN.CPP:337-344] ---- */
short tTournamentManager::IsTournamentFinished()
{
  tTournamentDefinition *def;
  tTourneyInfo *currentTourney;

  def = this->fDefinition;
  currentTourney = def->fTournaments + (def->fTiers[this->fTier].fTournOffset + this->fTournament);
  if (this->fCurrentTrack >= (int)currentTourney->fNumTracks) goto ret1;
  if (currentTourney->fKnockout == '\0') goto ret0;
  if (this->fCurrentTrack <= (int)this->fCompetitors[0].fPoints) goto ret0;
ret1:
  return 1;
ret0:
  return 0;
}

/* ---- (free)::free  [FETOURN.CPP:349-365] ---- */

int tournPointsCompare(char *p1,char *p2)

{
  u_char bVar1;
  u_char bVar2;
  tTournamentManager *tm;
  tCompetitor *comps;
  tCompetitor *c1;
  tCompetitor *c2;
  Car_tStats *cars;
  int result;

  tm = &tournamentManager;
  comps = tm->fCompetitors;
  cars = Cars_gNewCarStatsList;
  bVar1 = *p2;
  bVar2 = *p1;
  c1 = comps + bVar1;
  c2 = comps + bVar2;
  result = (u_int)c1->fPoints - (u_int)c2->fPoints;
  if ((result == 0) &&
     (result = (int)c1->fIsPlayerCar - (int)c2->fIsPlayerCar, result == 0)) {
    result = cars[bVar2].finalPosition - cars[bVar1].finalPosition;
  }
  return result;
}



/* ---- tTournamentManager::UpdateTournFinishMoney  [FETOURN.CPP:370-398] ---- */

void tTournamentManager::UpdateTournFinishMoney()

{
  long prize;
  u_char i;
  tTourneyInfo *tourn;

  tourn = &this->fDefinition->fTournaments
      [(u_int)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament];
  this->fPrevBestPlacement = this->fBestPlacement[(signed char)tourn->fTournamentID];
  if (tourn->fKnockout != '\0') {
    prize = this->GetTournamentFinishPrize(this->fCompetitors[0].fPosition - 1);
    (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + prize;
  }
  else {
    for (i = 0; i < 6; i++) {
      if (this->fRanking[i] == '\0') {
        prize = this->GetTournamentFinishPrize((u_short)i);
        (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + prize;
        if ((int)i < (int)(signed char)this->fBestPlacement[(signed char)tourn->fTournamentID]) {
          this->fBestPlacement[(signed char)tourn->fTournamentID] = i + 1;
        }
      }
    }
  }
  return;
}



/* ---- tTournamentManager::UpdateTrackFinishMoney  [FETOURN.CPP:405-414] ---- */

void tTournamentManager::UpdateTrackFinishMoney()

{
  long prize;
  Car_tStats *dummyCars;
  
  if (Cars_gNewCarStatsList[0].finalFinishType == 2) {
    prize = this->GetTrackFinishPrize((short)Cars_gNewCarStatsList[0].finalPosition + -1);
    (this->fAwards).fMoney = (this->fAwards).fMoney + prize;
  }
  return;
}



/* ---- tTournamentManager::CalcTrackFinishDamageBill  [FETOURN.CPP:422-470] ---- */

void tTournamentManager::CalcTrackFinishDamageBill(bool recalculate,long &bill_r,long &bonus_r)

{
  long *bill = &bill_r; long *bonus = &bonus_r;   /* R-ref params; alias keeps body codegen-identical */
  int i;
  short mask;
  long totalcarprice;
  int damage;
  Car_tStats *cars;
  tCarInfo carInfo;

  if (recalculate != 0) {
    cars = Cars_gNewCarStatsList;
    GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
    totalcarprice = carInfo.fPrices[0];
    for (i = 0; i < 2; i++) {
      mask = 1 << i;
      if ((carInfo.fUpgrades & mask) != 0) {
        totalcarprice = totalcarprice + carInfo.fPrices[i + 1];
      }
    }
    damage = cars->finalDamage / 0x10000;
    if ((damage == 0) && (cars->finalPosition < 4)) {
      gTrackFinishBill = 0;
      gTrackFinishBonus = totalcarprice / 0x14;
      if (cars->finalPosition == 2) {
        gTrackFinishBonus = (totalcarprice * 3) / 100;
      }
      else if (cars->finalPosition == 3) {
        gTrackFinishBonus = totalcarprice / 100;
      }
    }
    else {
      gTrackFinishBonus = 0;
      gTrackFinishBill = (totalcarprice * damage * 3) / 10000;
    }
  }
  *bill = gTrackFinishBill;
  *bonus = gTrackFinishBonus;
  return;
}



/* ---- tTournamentManager::UpdateTrackFinishPoints  [FETOURN.CPP:481-553] ----
   W54-A3 (2026-08-09) 103 -> 76 diffs (ours 138 / oracle 134).  Landed corrections:
   (1) the hand-written `if (0 < numCompetitors)` zero-trip guards DUPLICATED the for-loop's
       own guard (two `blez` in a row) -- delete them, the top-tested `for` guards itself;
   (2) INDEX FORM `this->fCompetitors[i]` (not a `comp` pointer walk): retail's giv is anchored
       on `this` with displacement 288/292/294 (fCompetitors at +280), ours anchored at
       `this+294` with NEGATIVE displacements;
   (3) `fNumRacers` is accessed as a WORD by retail (`lw`/`sw`), but nfs4_types.h declares it
       `short` -> `*(long *)&this->fNumRacers` (the header is out of this TU's scope to change);
   (4) branch-polarity: retail's arms are {eliminated=1 = FALL-THROUGH, points++ = branch
       target} -> spell it `if (finalPosition >= fNumRacers) eliminated = 1; else points++;`.
   RESIDUAL 76 (+4 insns): (a) the tournament-address `addu` operand order -- retail
   `addu v0,v0,a1` (offset first, definition second), ours `addu a0,a0,v0`; (b) the
   `for (i=5; -1<i; i--) fRanking[i]=i` loop -- retail strength-reduces the address into a
   giv decremented by 1, ours rematerializes `this+i`; (c) the final ranking loop wants the
   increment-into-a-fresh-pseudo + copy-back shape (`addiu v1,a0,1; addu a0,v1,zero`).
   NEXT ANGLE: flat byte-offset spelling for the knockout read, pointer-walk for the fRanking
   fill, and a `for`-shaped final loop. */

/* REWRITE (w36-a10): SYM 8c gives fsize=24, mask=$80010000 (ra + s0 only --
 * `this` REGPARM lives permanently in s0, EVERY other local is a
 * caller-saved scratch reg since none of them survive across the
 * GetNumCompetitors()/qsort() calls: i REG $4=$a0 (INT), k REG $7=$a3
 * (SHORT), dummyCars REG $9=$t1 (PTR Car_tStats), numCompetitors REG $8=$t0
 * (SHORT). The prior recon fabricated ptVar3 (a manually-incremented
 * `&this->fNumRacers`-based "walk" standing in for `this->fCompetitors[i]`
 * array indexing) and pCVar7 (a second, real, pointer-walk that IS the SYM's
 * `dummyCars`). The byte-fill loop (`*(uchar*)(piVar2+0x237)=iVar5`) writes
 * this->fRanking[0..5] = {0..5} (offsetof(fRanking)=0x237; piVar2 base =
 * &this->fTier+1 = offset 0x5, so target 0x232+iStep+0x5 walks exactly
 * fRanking's 6 bytes) -- an identity-permutation init before qsort sorts it
 * by tournPointsCompare. */
/* W57-A4 (2026-08-09) 76 -> 70.  Landed: ONE fn-scope `Car_tStats *stats = &dummyCars[k]`
   anchor for all four element reads (retail reuses `v1` for the trailing `lbu 132(v1)`;
   four separate `dummyCars[k].` spellings let gcc rematerialize the *160 index chain after
   the if/else join = 6 extra insns).  ⚠️ the anchor MUST be FUNCTION-scope: as a block-local
   inside the `if` it also UN-ROTATED the knockout loop (lost the `blez` zero-trip guard) --
   §3.12 #15's declaration-scope gotcha, second confirmation.
   RESIDUAL 70 (ours 132 / oracle 134): almost entirely a 3-way REGISTER RENAME against the
   SYM map -- SYM says k=$7(a3) numCompetitors=$8(t0) dummyCars=$9(t1); we get k=t0,
   numCompetitors=t1, dummyCars=a1.  dummyCars' `la` is SELF-temp for us (`lui a1;addiu a1`)
   vs retail's SEPARATE temp (`lui v1;addiu t1`) even though Cars_gNewCarStatsList is already
   declared unsized (§3.12 #5 does NOT apply -- it's an address-of, not a value load).
   FALSIFIED: moving `k = 0;` above the GetNumCompetitors() call makes numCompetitors land in
   t0 correctly BUT parks k in a callee-saved s1 across the call (+8 frame, 76 diffs).
   Remaining 2-insn shortfall = the `for (i=5; -1<i; i--) fRanking[i]=i` loop (retail
   decrements the ADDRESS, `addiu v0,v0,-1`; ours recomputes `addu v0,s0,a0`) and the final
   do-while's `i+1` temp+copy.  Next angle = allocno ref-count dial, not spelling. */
void tTournamentManager::UpdateTrackFinishPoints()

{
  int i;
  short k;
  Car_tStats *dummyCars;
  short numCompetitors;
  Car_tStats *stats;
  tCompetitor *comp;
  u_char rankVal;

  numCompetitors = this->GetNumCompetitors();
  k = 0;
  dummyCars = Cars_gNewCarStatsList;
  if (this->fDefinition->fTournaments
      [(uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament].fKnockout
      != '\0') {
    for (i = 0; i < numCompetitors; i = i + 1) {
      if (this->fCompetitors[i].fEliminated == 0) {
        /* MATCH: ONE &dummyCars[k] address, held live across the eliminated/points arms --
           retail reuses `v1` for the trailing `lbu 132(v1)` fPosition read; four separate
           `dummyCars[k].` spellings let gcc rematerialize the *160 index chain after the
           if/else join (6 extra insns). */
        stats = &dummyCars[k];
        if ((stats->finalPosition - 1U < 6) && (stats->finalFinishType == 2)) {
          if (stats->finalPosition >= this->fNumRacers) {
            this->fCompetitors[i].fEliminated = 1;
          }
          else {
            this->fCompetitors[i].fPoints = this->fCompetitors[i].fPoints + 1;
          }
          this->fCompetitors[i].fPosition = (uchar)stats->finalPosition;
        }
        k = k + 1;
      }
    }
    *(long *)&this->fNumRacers = *(long *)&this->fNumRacers + -1;
  }
  else {
    for (i = 0; i < numCompetitors; i = i + 1) {
      if ((dummyCars[i].finalPosition - 1U < 6) && (dummyCars[i].finalFinishType == 2)) {
        this->fCompetitors[i].fPoints =
             this->fCompetitors[i].fPoints +
             (ushort)this->fFinishPoints[dummyCars[i].finalPosition + -1];
      }
    }
    for (i = 5; -1 < i; i = i - 1) {
      this->fRanking[i] = (uchar)i;
    }
    qsort(this->fRanking,(int)numCompetitors,1,
               tournPointsCompare);
    i = 0;
    do {
      rankVal = this->fRanking[i];
      i = i + 1;
      this->fCompetitors[rankVal].fPosition = (uchar)i;
    } while (i < 6);
  }
  return;
}



/* ---- tTournamentManager::AdvanceToNextTrack  [FETOURN.CPP:569-700] ---- */

short tTournamentManager::AdvanceToNextTrack()

{
  byte bVar1;
  short sVar2;
  tTourneyInfo *tourn;
  short i;
  int iVar3;
  tCarInfo *ptVar4;
  void *pvVar5;
  int iVar6;
  tTournamentDefinition *ptVar7;
  tTierInfo *currentTier;
  tTierInfo *ptVar8;
  int numGarageCars;
  tTourneyInfo *currentTourney;
  tTourneyInfo *ptVar9;
  tCarInfo *carInfo;
  
  ptVar9 = this->fDefinition->fTournaments +
           (uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament;
  sVar2 = -1;
  if (this->fCurrentTrack <= (int)(ptVar9->fNumTracks - 1)) {
    (this->fAwards).fMoney = 0;
    (this->fAwards).fTournMoney = 0;
    (this->fAwards).fActivateFlags = 0;
    (this->fAwards).fAwardCar = 0;
    this->UpdateTrackFinishMoney();
    this->UpdateTrackFinishPoints();
    if (this->fCurrentTrack == ptVar9->fNumTracks - 1) {
      this->UpdateTournFinishMoney();
      this->CalcTierFinishPrize();
    }
    iVar3 = this->fCurrentTrack + 1;
    this->fCurrentTrack = iVar3;
    if ((int)(uint)ptVar9->fNumTracks <= iVar3) {
      bVar1 = this->fCompetitors[0].fPosition;
      (this->fAwards).fAwardCarGarageFull = 0;
      (this->fAwards).fCompletedGarageFull = 0;
      if (bVar1 < 4) {
        if ((ptVar9->fActivateFlags & 1) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 1;
          (this->fAwards).fActivateTrack = ptVar9->fActivatedTrack;
        }
        if ((ptVar9->fActivateFlags & 2) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 2;
          (this->fAwards).fActivateCarClass = (uint)ptVar9->fActivatedCarClass;
        }
        if ((ptVar9->fActivateFlags & 4) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 4;
          (this->fAwards).fActivateCar = (uint)ptVar9->fActivatedCar;
        }
        if ((ptVar9->fActivateFlags & 8) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 8;
          (this->fAwards).fActivateTrackClass = (uint)ptVar9->fActivatedTrackClass;
        }
        (this->fAwards).fCompletedTier = 0;
      }
      if (this->fCompetitors[0].fPosition < 2) {
        if (ptVar9->fAwardCar != '\0') {
          ptVar4 = GetCarFromID(&carManager, (ushort)ptVar9->fAwardCarModel);
          (this->fAwards).fAwardCar = 1;
          (this->fAwards).fAwardCarModel = (uint)ptVar9->fAwardCarModel;
          (this->fAwards).fAwardCarColor = ptVar4->fDefaultColor;
          (this->fAwards).fAwardCarUpgrades = ptVar9->fAwardCarUpgrades;
          sVar2 = GetNumOwnedCars(&carManager, 0);
          if (0x1f < sVar2) {
            (this->fAwards).fAwardCarGarageFull = 1;
            (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + ptVar4->fPrices[0];
            (this->fAwards).fAwardCarBonusMoney = ptVar4->fPrices[0];
          }
        }
        if ((ptVar9->fActivateFlags & 0x10) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 0x10;
          (this->fAwards).fActivateCheat = (uint)ptVar9->fActivatedCheat;
        }
        (this->fAwards).fCompletedTier = 0;
        this->fBestPlacement[ptVar9->fTournamentID] = '\x01';
        pvVar5 = FECheat_IsCheatEnabled(this->fTier + cheat_FinishedTournament);
        if (pvVar5 != (void *)0x1) {
          iVar3 = this->fTier;
          (this->fAwards).fCompletedTier = 1;
          ptVar7 = this->fDefinition;
          ptVar8 = ptVar7->fTiers + iVar3;
          i = 0;
          if (ptVar8->fNumTournaments != '\0') {
            do {
              if (this->fBestPlacement
                  [ptVar7->fTournaments[(uint)ptVar8->fTournOffset + i].fTournamentID]
                  != '\x01') {
                (this->fAwards).fCompletedTier = 0;
              }
              i = i + 1;
            } while (i < (int)(uint)ptVar8->fNumTournaments);
          }
          if ((this->fAwards).fCompletedTier != 0) {
            sVar2 = GetNumOwnedCars(&carManager, 0);
            iVar3 = (int)sVar2;
            if ((this->fAwards).fAwardCar != 0) {
              iVar3 = iVar3 + 1;
            }
            FECheat_ActivateBonus(this->fTier + cheat_FinishedTournament);
            (this->fAwards).fCompletedCar = this->fTier + cm_BonusCar1;
            ptVar4 = GetCarFromID(&carManager, (short)(this->fAwards).fCompletedCar);
            SetCarAvailable(&carManager, (this->fAwards).fCompletedCar,true);
            SetCarViewable(&carManager, (this->fAwards).fCompletedCar,true);
            if (iVar3 < 0x20) {
              PurchaseCar(&carManager, (short)(this->fAwards).fCompletedCar,
                         (ushort)ptVar4->fDefaultColor,0);
            }
            else {
              (this->fAwards).fCompletedGarageFull = 1;
              iVar6 = ptVar4->fPrices[0];
              iVar3 = this->fMoney;
              (this->fAwards).fCompletedBonusMoney = iVar6;
              this->fMoney = iVar3 + iVar6;
            }
            (this->fAwards).fCompletedText = (short)this->fTier + 0x3d9;
          }
        }
      }
    }
    sVar2 = (short)this->fCurrentTrack;
  }
  return sVar2;
}



/* ---- tTournamentManager::GetLastTrackRaced  [FETOURN.CPP:706-734] ---- */

short tTournamentManager::GetLastTrackRaced()

{
  tTournamentDefinition *ptVar1;
  
  ptVar1 = this->fDefinition;
  return (short)(signed char)ptVar1->fTracks
                [(uint)(ptVar1->fTournaments +
                       ((uint)ptVar1->fTiers[this->fTier].fTournOffset + this->fTournament))->
                       fTrackOffset + this->fCurrentTrack + -1].fTrackNumber;
}



/* ---- tTournamentManager::SaveTournament  [FETOURN.CPP:744-762] ---- */
void tTournamentManager::SaveTournament(tSaveTournament &save_r)
{
  tSaveTournament *save = &save_r;   /* R-ref param; alias keeps body codegen-identical */
  short i;

  save->fSaveMoney = this->fMoney;
  i = 0;
  do {
    save->fSaveBestPlacement[i] = this->fBestPlacement[i];
    i = i + 1;
  } while (i < 0x40);
  return;
}

/* ---- tTournamentManager::LoadTournament  [FETOURN.CPP:773-791] ---- */
void tTournamentManager::LoadTournament(tSaveTournament &load_r)
{
  tSaveTournament *load = &load_r;   /* R-ref param; alias keeps body codegen-identical */
  short i;

  this->fMoney = load->fSaveMoney;
  i = 0;
  do {
    this->fBestPlacement[i] = load->fSaveBestPlacement[i];
    i = i + 1;
  } while (i < 0x40);
  return;
}

/* ---- tTournamentManager::GetNumCompetitors  [FETOURN.CPP:803-805] ---- */

short tTournamentManager::GetNumCompetitors()

{
  return (short)(this->fDefinition->fTournaments +
                ((uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament))->
                fNumCars;
}



/* ---- tTournamentManager::UpdateCarLineup  [FETOURN.CPP:812-834] ---- */

void tTournamentManager::UpdateCarLineup()

{
  short i;
  short k;
  short numCompetitors;

  numCompetitors = this->GetNumCompetitors();
  k = 0;
  i = 0;
  if (0 < numCompetitors) {
    do {
      if (this->fCompetitors[i].fEliminated == 0) {
        this->fCarLineup[k].isPlayerCar = this->fCompetitors[i].fIsPlayerCar;
        this->fCarLineup[k].personality = this->fCompetitors[i].fPersonality;
        this->fCarLineup[k].position = this->fCompetitors[i].fPosition;
        k = k + 1;
      }
      i = i + 1;
    } while (i < numCompetitors);
  }
  return;
}



/* ---- tTournamentManager::GetTrackFinishPrize  [FETOURN.CPP:844-890] ---- */

long tTournamentManager::GetTrackFinishPrize(short position)

{
  tTourneyInfo *currentTourney;
  long result;
  tCarInfo carInfo;
  long carPrice;
  int openClassAdjust[7][6];

  result = 0;
  memcpy(openClassAdjust,gTrackFinishPrizes,sizeof(openClassAdjust));
  if ((ushort)position < 6) {
    currentTourney = &this->fDefinition->fTournaments[
        this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament];
    if ((currentTourney->fOpponentCarClass == '\n') &&
       (GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0),
       carInfo.fCarClass < 7)) {
      carPrice = carInfo.fPrices[0];
      if ((carInfo.fUpgrades & 1) != 0) {
        carPrice = carPrice + carInfo.fPrices[1];
      }
      if ((carInfo.fUpgrades & 2) != 0) {
        carPrice = carPrice + carInfo.fPrices[2];
      }
      if ((carInfo.fUpgrades & 4) != 0) {
        carPrice = carPrice + carInfo.fPrices[3];
      }
      result += fixedmult(openClassAdjust[carInfo.fCarClass][position],carPrice);
    }
    result = result + this->fDefinition->fTracks[
        currentTourney->fTrackOffset + this->fCurrentTrack].fPrize[position];
  }
  return result;
}



/* ---- tTournamentManager::GetTournamentFinishPrize  [FETOURN.CPP:897-905] ---- */
long tTournamentManager::GetTournamentFinishPrize(short position)
{
  /* SYM: no locals at all -- `this` is the only REG entry; def/tourn are compiler temps */
  if ((ushort)position < 6) {
    tTourneyInfo *tourn = this->fDefinition->fTournaments +
             (this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament);
    return tourn->fPrize[position];
  }
  return 0;
}

/* ---- tTournamentManager::GetAwardInformation  [FETOURN.CPP:913-914] ---- */

void tTournamentManager::GetAwardInformation(tAwardInformation &info_r)

{
  /* Ghidra hand-expanded gcc's own movstrsi block copy of the 68-byte
     tAwardInformation (4 words/iter + 1-word tail) — it is one struct assignment. */
  info_r = this->fAwards;
}



/* ---- tTournamentManager::UpdateAwardInformation  [FETOURN.CPP:920-949] ---- */

void tTournamentManager::UpdateAwardInformation()

{
  tCarInfo *ptVar3;
  long bill;
  long bonus;
  
  this->CalcTrackFinishDamageBill(true,bill,bonus);   /* now takes long& */
  /* SLD names only bill and bonus: the four direct compound updates are
     retail's load/add/store chain; decompiler arithmetic temps lose a store. */
  this->fMoney -= bill;
  this->fMoney += bonus;
  this->fMoney += (this->fAwards).fMoney;
  this->fMoney += (this->fAwards).fTournMoney;
  if (((this->fAwards).fActivateFlags & 2) != 0) {
    FECheat_ActivateBonus((this->fAwards).fActivateCarClass);
  }
  if (((this->fAwards).fActivateFlags & 4) != 0) {
    SetCarAvailable(&carManager, (this->fAwards).fActivateCar,true);
  }
  if (((this->fAwards).fActivateFlags & 1) != 0) {
    SetTrackAvailable(&trackManager,(ushort)(byte)(this->fAwards).fActivateTrack,true);
  }
  if (((this->fAwards).fActivateFlags & 8) != 0) {
    SetClassAvailable(&trackManager,(this->fAwards).fActivateTrackClass,true);
  }
  if (((this->fAwards).fActivateFlags & 0x10) != 0) {
    FECheat_ActivateBonus((this->fAwards).fActivateCheat);
  }
  if (((this->fAwards).fAwardCar != 0) && ((this->fAwards).fAwardCarGarageFull == 0)) {
    ptVar3 = GetCarFromID(&carManager, (short)(this->fAwards).fAwardCarModel);
    PurchaseCar(&carManager, (short)(this->fAwards).fAwardCarModel,
               (short)(signed char)ptVar3->fColorOrder[(byte)(this->fAwards).fAwardCarColor],0);
    PurchaseUpgrade(&carManager, (ushort)(byte)frontEnd.garageCar[0],
               (ushort)(byte)(this->fAwards).fAwardCarUpgrades,0);
  }
  return;
}



/* ---- tTournamentManager::TournPointTotal  [FETOURN.CPP:957-958] ---- */

short tTournamentManager::TournPointTotal(short *p)

{
  return this->fCompetitors[*p].fPoints;
}



/* ---- tTournamentManager::PlayerRanking  [FETOURN.CPP:965-973] ---- */

short tTournamentManager::PlayerRanking(short pos)

{
  short i;
  short numCompetitors;

  numCompetitors = this->GetNumCompetitors();
  for (i = 0; i < numCompetitors; i++) {
    if ((u_short)this->fCompetitors[i].fPosition == pos) {
      return i;
    }
  }
  return 0;
}



/* ---- tTournamentManager::CalcTierFinishPrize  [FETOURN.CPP:979-981] ---- */

void tTournamentManager::CalcTierFinishPrize()

{
  this->fTierFinishPrize[this->fTier] = 7;
  this->fTierFinishPrizeChange[this->fTier] = 0;
  return;
}



/* ---- tTournamentManager::GetTrophyName  [FETOURN.CPP:1040-1056] ---- */

void tTournamentManager::GetTrophyName(tTourneyInfo *tourn,tTrophySize size,char *buffer,int place
               )

{
  /* SYM locals: int showplace (REG $2) + char trophySizeLetter[3] (AUTO -0x18)
     + char trophyPlacementLetter[4] (AUTO -0x10); `place` keeps its own REG $3.
     The two arrays are AGGREGATE INITIALIZERS (rodata->stack copies: 3x lb/sb
     for the 3-byte one, an unaligned lwl/lwr+swl/swr word for the 4-byte one) --
     the Ghidra body had hand-expanded gcc's own unaligned block move. */
  int showplace;
  int best;
  char trophySizeLetter [3] = { 'S', 'M', 'L' };
  /* MATCH: `char` is UNSIGNED on this build -> (signed char) restores the oracle's lb.
     SLD puts this read on line 1042/1043 -- BETWEEN the two array initializers and
     before the guard, i.e. in the entry basic block (sched1 cannot move a load
     across a branch, so an in-branch placement can never reproduce it). */
  best = (signed char)tournamentManager.fBestPlacement
                    [(signed char)tourn->fTournamentID];
  char trophyPlacementLetter [4] = { 'W', 'G', 'S', 'B' };

  if (place == -1) {
    short t = 0;
    if ((u_int)(best - 1U) < 3) {
      t = best;
    }
    showplace = t;
  }
  else {
    showplace = place;
  }
  sprintf(buffer,"TR%c%02d%c",(uint)(byte)trophySizeLetter[size],(uint)tourn->fTrophyID,
             (uint)(byte)trophyPlacementLetter[showplace]);
  return;
}



/* ---- tTournamentManager::ValidCar  [FETOURN.CPP:1063-1102] ---- */

void * tTournamentManager::ValidCar(tCarInfo &carInfo_r)

{
  u_char oppClass;
  tTournamentDefinition *definition;
  tTourneyInfo *tourney;
  void *result;

  definition = this->fDefinition;
  tourney = &definition->fTournaments
      [(u_int)definition->fTiers[this->fTier].fTournOffset + this->fTournament];
  oppClass = tourney->fOpponentCarClass;
  result = (void *)0x1;
  if (oppClass != '\n') {
    result = (void *)(u_int)(carInfo_r.fCarClass == oppClass);
    if ((FECheat_IsCheatEnabled(cheat_FinishedTournament) != 0) && (this->fTier == 0)) {
      result = (void *)0x1;
    }
  }
  if ((tourney->fRequiredFlags & 4) != 0) {
    if ((int)(signed char)carInfo_r.fCarID == (int)tourney->fRequiredCar) {
      switch (tourney->fRequiredUpgrades) {
      case 0:
        if (carInfo_r.fUpgrades != '\0') {
          result = (void *)0x0;
        }
        break;
      case 1:
        break;
      case 2:
        if (carInfo_r.fUpgrades == '\0') {
          result = (void *)0x0;
        }
        break;
      case 3:
        if ((carInfo_r.fUpgrades & tourney->fSpecificUpgrades) !=
            tourney->fSpecificUpgrades) {
          result = (void *)0x0;
        }
        break;
      default:
        break;
      }
    }
    else {
      result = (void *)0x0;
    }
  }
  return result;
}



/* ---- tListIteratorTournament::ctor  [FETOURN.CPP:1109-1111] ---- */
tListIteratorTournament::tListIteratorTournament(char *valPtr,tTournamentManager *tournManager)
  : tListIterator((short *)0x0, valPtr)
{

  *(void **)&(this->_vf) = (void *)tListIteratorTournament_vtable;
  this->fTournamentManager = tournManager;
  return;
}



/* ---- tListIteratorTournament::dtor  [FETOURN.CPP:1115-1115] ---- */

tListIteratorTournament::~tListIteratorTournament()

{
  this->_vf = (__vtbl_ptr_type (*)[6])tListIteratorTournament_vtable;
  return;  /* base ~tListIterator() now implicit (§3.23 inheritance) */
}



/* ---- tListIteratorTournament::Value  [FETOURN.CPP:1119-1120] ---- */

int tListIteratorTournament::Value(tPlayer arg1)

{
  return (uint)(byte)*this->fValue;
}



/* ---- tListIteratorTournament::TextValue  [FETOURN.CPP:1124-1130] ---- */

int tListIteratorTournament::TextValue(tPlayer player_id)

{
  short tournIndex;

  /* MATCH: SYM = one local (tournIndex); the fDefinition chain written TWICE (CSE -> in-place a1) */
  tournIndex = this->fTournamentManager->fDefinition->fTiers[(byte)frontEnd.tier].fTournOffset
      + (byte)*this->fValue;
  return (signed char)this->fTournamentManager->fDefinition->fTournaments[tournIndex]
             .fTournamentID + 0x341;
}



/* ---- tListIteratorTournament::Increment  [FETOURN.CPP:1134-1144] ---- */

void tListIteratorTournament::Increment(tPlayer arg1)

{
  int iVar1;
  uint uVar2;
  tTournamentDefinition *ptVar3;
  char *pcVar4;
  byte *pbVar5;
  tTierInfo *tier;

  uVar2 = (uint)(byte)frontEnd.tier;
  ptVar3 = this->fTournamentManager->fDefinition;
  do {
    pcVar4 = this->fValue;
    *pcVar4 = *pcVar4 + '\x01';
    pbVar5 = (byte *)this->fValue;
    if (ptVar3->fTiers[uVar2].fNumTournaments <= *pbVar5) {
      *pbVar5 = 0;
    }
    iVar1 = (int)this->ValidTournament(*this->fValue) ^ 1;
  } while (iVar1 != 0);
  return;
}



/* ---- tListIteratorTournament::Decrement  [FETOURN.CPP:1148-1158] ---- */

void tListIteratorTournament::Decrement(tPlayer arg1)

{
  uchar uVar1;
  int iVar2;
  uint uVar3;
  tTournamentDefinition *ptVar4;
  uchar *puVar5;
  tTierInfo *tier;

  uVar3 = (uint)(byte)frontEnd.tier;
  ptVar4 = this->fTournamentManager->fDefinition;
  do {
    puVar5 = (uchar *)this->fValue;
    uVar1 = *puVar5;
    if (uVar1 == '\0') {
      uVar1 = ptVar4->fTiers[uVar3].fNumTournaments;
    }
    *puVar5 = uVar1 - 1;
    iVar2 = (int)this->ValidTournament(*this->fValue) ^ 1;
  } while (iVar2 != 0);
  return;
}



/* ---- tListIteratorTournament::ValidTournament  [FETOURN.CPP:1162] ---- */

void * tListIteratorTournament::ValidTournament(char tourn)

{
  u_short flags;
  tTourneyInfo *currentTourn;
  tTournamentDefinition *definition;
  tTournamentManager *tournamentManager;
  void *result;

  tournamentManager = this->fTournamentManager;
  definition = tournamentManager->fDefinition;
  currentTourn = &definition->fTournaments
      [(u_int)definition->fTiers[(u_char)frontEnd.tier].fTournOffset + (u_int)(u_char)tourn];
  flags = currentTourn->fRequiredFlags;
  result = (void *)0x1;
  if ((flags & 1) != 0) {
    result = (void *)(u_int)
        ((signed char)tournamentManager->fBestPlacement[currentTourn->fRequiredTournamentID] < '\x04');
  }
  if (((flags & 2) != 0) &&
     ('\x01' < (signed char)tournamentManager->fBestPlacement[currentTourn->fRequiredTournamentID])) {
    result = (void *)0x0;
  }
  return result;
}



/* end of fetourn.cpp */

/* W55-A2 (class-2): the `int _i;` link-harness definition is GONE.  `_i` was a Ghidra
   PHANTOM LOCAL that the import turned into a real global; its last consumer
   (CalcSplinePosition in screencarselect.cpp) is now a proper function local, so both the
   definition here and the `extern int _i;` decls in front/fetourn/screencarselect/screenpost
   _externs.h have been deleted.  A phantom global loop counter is a real runtime bug
   (cross-TU aliasing) AND it defeats constant propagation. */
