/* frontend/common/fetourn.cpp -- RECONSTRUCTED (tournament manager + list iterator; C++ TU)
 *   tTournamentManager (28 methods) + tListIteratorTournament:tListIterator (7) + free
 *   tournPointsCompare. 5 in_a0(this-lost) fns rebuilt from m2c; phantoms via m2c oracle.
 */
#include "fetourn.h"

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
/* MATCH (2026-08-10, 77 -> PASS, 147/147): SYM names the signed SHORT
   counters tier/tourney/track, while SLD 119/122 and 127/130 separate each
   field load from its widened loop-bound value.  Assigning the short first
   and then copying it to uVar7/uVar6 gives retail's direct $s4/$s0 loads and
   $v1 compare copies.  Placing each data-cursor increment after that copy
   lets reorg sink it into the bound branch delay slot.  Together these also
   restore the tournament byte offset in $s1 and the exact saved-reg map. */

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
      tourney = (short)ptVar2->fTiers[tier].fTournOffset;
      uVar7 = (uint)tourney;
      src_00 = (void *)((int)src_00 + 0xc);
      if ((short)uVar7 < (short)uVar7 + ptVar2->fTiers[tier].fNumTournaments) {
        do {
          blockmove(src_00,ptVar2->fTournaments + tourney,0x54);
          ptVar2 = this->fDefinition;
          track = (short)ptVar2->fTournaments[tourney].fTrackOffset;
          uVar6 = (uint)track;
          src_00 = (void *)((int)src_00 + 0x54);
          if ((short)uVar6 < (short)uVar6 + ptVar2->fTournaments[tourney].fNumTracks) {
            do {
              blockmove(src_00,ptVar2->fTracks + track,0x28);
              track = track + 1;
              ptVar2 = this->fDefinition;
              src_00 = (void *)((int)src_00 + 0x28);
            } while (track < (int)((short)uVar6 +
                                    ptVar2->fTournaments[tourney].fNumTracks));
          }
          tourney = tourney + 1;
          ptVar2 = this->fDefinition;
        } while (tourney < (int)((short)uVar7 + ptVar2->fTiers[tier].fNumTournaments));
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

static int tournPointsCompare(char *p1,char *p2)

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
  static long retbill;
  static long retbonus;
  long *bill = &bill_r; long *bonus = &bonus_r;   /* R-ref params; alias keeps body codegen-identical */
  int i;
  short mask;
  long totalcarprice;
  int damage;
  Car_tStats *cars;
  tCarInfo carInfo;

  if (recalculate != 0) {
    cars = Cars_gNewCarStatsList;
    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);
    totalcarprice = carInfo.fPrices[0];
    for (i = 0; i < 2; i++) {
      mask = 1 << i;
      if ((carInfo.fUpgrades & mask) != 0) {
        totalcarprice = totalcarprice + carInfo.fPrices[i + 1];
      }
    }
    damage = cars->finalDamage / 0x10000;
    if ((damage == 0) && (cars->finalPosition < 4)) {
      retbill = 0;
      retbonus = totalcarprice / 0x14;
      if (cars->finalPosition == 2) {
        retbonus = (totalcarprice * 3) / 100;
      }
      else if (cars->finalPosition == 3) {
        retbonus = totalcarprice / 100;
      }
    }
    else {
      retbonus = 0;
      retbill = (totalcarprice * damage * 3) / 10000;
    }
  }
  *bill = retbill;
  *bonus = retbonus;
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
   W60: the IDA-gold cursor spelling `ranking=(uchar*)this+i; ranking[567]=i` makes the
   descending fill decrement its ADDRESS in the branch delay slot and lands 70->68 with no
   instruction-count change.  Remaining one-insn shortfall is the final do-while's retail
   `i+1` temp+copy plus the dummyCars address-of self-temp versus separate-temp allocation.
   FALSIFIED in the new basin: direct `++i` is neutral; an identity-fenced `next` reaches
   134/134 but remains 68 and changes tail scheduling; an explicit final-loop cursor is 76.
   W61: spelling the knockout lookup as pointer addition rather than an array subscript
   restores retail's scaled-offset-first `addu v0,v0,base` and lands 68->66.  allocsim
   matches all 19 current handouts and identifies the remaining rotation as one cascade:
   dummyCars' generated second-arm cursor propagates an $a1 preference; that reserves $a1
   from the first-arm competitor cursor, which in turn occupies $a3 and rotates k/numCars.
   FALSIFIED: branch-head identity fence 74; base live through loop 81; forced distinct
   base/cursor webs 68.
   W65: 66 -> PASS (134/134).  Evaluating the knockout flag before materializing dummyCars
   gives the retail SYM handout k=$a3, numCompetitors=$t0, dummyCars=$t1.  The empty memory
   reference on fCompetitors[i] raises the strength-reduced cursor from 15 to 16 refs, crossing
   GCC's floor_log2 priority boundary and assigning cursor=$a1/finalPosition=$a2 with no emitted
   instruction.  Flat integer address arithmetic preserves both retail add operand orders.  The
   final ranking loop keeps old-i address formation and a distinct next-i web; its byte cursor
   supplies the retail base-first add and +294 store exactly. */
void tTournamentManager::UpdateTrackFinishPoints()

{
  int i;
  short k;
  Car_tStats *dummyCars;
  short numCompetitors;
  Car_tStats *stats;
  tCompetitor *comp;
  u_char rankVal;
  bool knockout;

  numCompetitors = this->GetNumCompetitors();
  k = 0;
  knockout = (this->fDefinition->fTournaments +
      ((uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament))->fKnockout
      != '\0';
  dummyCars = Cars_gNewCarStatsList;
  if (knockout) {
    for (i = 0; i < numCompetitors; i = i + 1) {
      if (this->fCompetitors[i].fEliminated == 0) {
        /* MATCH: ONE &dummyCars[k] address, held live across the eliminated/points arms --
           retail reuses `v1` for the trailing `lbu 132(v1)` fPosition read; four separate
           `dummyCars[k].` spellings let gcc rematerialize the *160 index chain after the
           if/else join (6 extra insns). */
        stats = (Car_tStats *)((int)k * (int)sizeof(Car_tStats) + (int)dummyCars);
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
      __asm__("" : : "m"(this->fCompetitors[i]));
    }
    *(long *)&this->fNumRacers = *(long *)&this->fNumRacers + -1;
  }
  else {
    u_char *ranking;

    for (i = 0; i < numCompetitors; i = i + 1) {
      if ((dummyCars[i].finalPosition - 1U < 6) && (dummyCars[i].finalFinishType == 2)) {
        this->fCompetitors[i].fPoints =
             this->fCompetitors[i].fPoints +
             (ushort)this->fFinishPoints[dummyCars[i].finalPosition + -1];
      }
    }
    i = 5;
    ranking = (u_char *)this + i;
    do {
      ranking[567] = (uchar)i;
      i = i - 1;
      ranking = ranking - 1;
    } while (-1 < i);
    qsort(this->fRanking,(int)numCompetitors,1,
               tournPointsCompare);
    i = 0;
    do {
      rankVal = this->fRanking[i];
      int next;
      __asm__("" : "=r"(next) : "0"(i + 1), "r"(rankVal));
      char *ranked = (char *)this + rankVal * (int)sizeof(tCompetitor);
      i = next;
      ranked[294] = (uchar)i;
    } while (i < 6);
  }
  return;
}



/* ---- tTournamentManager::AdvanceToNextTrack  [FETOURN.CPP:569-700] ---- */
/* MATCH (W64, 80->PASS): sum fTournOffset+fTournament before the one 84-byte
   scale, then restore the SYM-only locals (currentTourney, tourn, carInfo,
   currentTier, i, numGarageCars).  The tournament IDs are signed chars, the
   normalized cheat result uses its 0/1 XOR test, and the garage-full award arm
   is laid out before PurchaseCar.  Reusing fCompletedBonusMoney for the money
   addition gives retail's single price load; returning fCurrentTrack directly
   preserves its word load despite this function's short return type. */

short tTournamentManager::AdvanceToNextTrack()

{
  tTourneyInfo *currentTourney;
  tTourneyInfo *tourn;
  tCarInfo *carInfo;
  tTierInfo *currentTier;
  short i;
  int numGarageCars;
  
  currentTourney = this->fDefinition->fTournaments +
                   ((uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament);
  if (this->fCurrentTrack <= (int)(currentTourney->fNumTracks - 1)) {
    (this->fAwards).fMoney = 0;
    (this->fAwards).fTournMoney = 0;
    (this->fAwards).fActivateFlags = 0;
    (this->fAwards).fAwardCar = 0;
    this->UpdateTrackFinishMoney();
    this->UpdateTrackFinishPoints();
    if (this->fCurrentTrack == currentTourney->fNumTracks - 1) {
      this->UpdateTournFinishMoney();
      this->CalcTierFinishPrize();
    }
    this->fCurrentTrack = this->fCurrentTrack + 1;
    if ((int)(uint)currentTourney->fNumTracks <= this->fCurrentTrack) {
      (this->fAwards).fAwardCarGarageFull = 0;
      (this->fAwards).fCompletedGarageFull = 0;
      if (this->fCompetitors[0].fPosition < 4) {
        if ((currentTourney->fActivateFlags & 1) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 1;
          (this->fAwards).fActivateTrack = currentTourney->fActivatedTrack;
        }
        if ((currentTourney->fActivateFlags & 2) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 2;
          (this->fAwards).fActivateCarClass = (uint)currentTourney->fActivatedCarClass;
        }
        if ((currentTourney->fActivateFlags & 4) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 4;
          (this->fAwards).fActivateCar = (uint)currentTourney->fActivatedCar;
        }
        if ((currentTourney->fActivateFlags & 8) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 8;
          (this->fAwards).fActivateTrackClass = (uint)currentTourney->fActivatedTrackClass;
        }
        (this->fAwards).fCompletedTier = 0;
      }
      if (this->fCompetitors[0].fPosition < 2) {
        if (currentTourney->fAwardCar != '\0') {
          carInfo = carManager.GetCarFromID((ushort)currentTourney->fAwardCarModel);
          (this->fAwards).fAwardCar = 1;
          (this->fAwards).fAwardCarModel = (uint)currentTourney->fAwardCarModel;
          (this->fAwards).fAwardCarColor = carInfo->fDefaultColor;
          (this->fAwards).fAwardCarUpgrades = currentTourney->fAwardCarUpgrades;
          if (0x1f < carManager.GetNumOwnedCars(0)) {
            (this->fAwards).fAwardCarGarageFull = 1;
            (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + carInfo->fPrices[0];
            (this->fAwards).fAwardCarBonusMoney = carInfo->fPrices[0];
          }
        }
        if ((currentTourney->fActivateFlags & 0x10) != 0) {
          (this->fAwards).fActivateFlags = (this->fAwards).fActivateFlags | 0x10;
          (this->fAwards).fActivateCheat = (uint)currentTourney->fActivatedCheat;
        }
        (this->fAwards).fCompletedTier = 0;
        this->fBestPlacement[(signed char)currentTourney->fTournamentID] = '\x01';
        if (((int)(long)FECheat_IsCheatEnabled(this->fTier + cheat_FinishedTournament) ^ 1) != 0) {
          (this->fAwards).fCompletedTier = 1;
          currentTier = this->fDefinition->fTiers + this->fTier;
          i = 0;
          if (currentTier->fNumTournaments != '\0') {
            do {
              tourn = this->fDefinition->fTournaments + ((uint)currentTier->fTournOffset + i);
              if (this->fBestPlacement[(signed char)tourn->fTournamentID] != '\x01') {
                (this->fAwards).fCompletedTier = 0;
              }
              i = i + 1;
            } while (i < (int)(uint)currentTier->fNumTournaments);
          }
          if ((this->fAwards).fCompletedTier != 0) {
            numGarageCars = carManager.GetNumOwnedCars(0);
            if ((this->fAwards).fAwardCar != 0) {
              numGarageCars = numGarageCars + 1;
            }
            FECheat_ActivateBonus(this->fTier + cheat_FinishedTournament);
            (this->fAwards).fCompletedCar = this->fTier + cm_BonusCar1;
            carInfo = carManager.GetCarFromID((short)(this->fAwards).fCompletedCar);
            carManager.SetCarAvailable((tCarModels)(this->fAwards).fCompletedCar,true);
            carManager.SetCarViewable((tCarModels)(this->fAwards).fCompletedCar,true);
            if (0x1f < numGarageCars) {
              (this->fAwards).fCompletedGarageFull = 1;
              (this->fAwards).fCompletedBonusMoney = carInfo->fPrices[0];
              this->fMoney = this->fMoney + (this->fAwards).fCompletedBonusMoney;
            }
            else {
              carManager.PurchaseCar((short)(this->fAwards).fCompletedCar,
                         (ushort)carInfo->fDefaultColor,0);
            }
            (this->fAwards).fCompletedText = (short)this->fTier + 0x3d9;
          }
        }
      }
    }
    return this->fCurrentTrack;
  }
  return -1;
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
  long result = 0;
  tCarInfo carInfo;
  long carPrice;
  int openClassAdjust[7][6] = {
    {1310, 1310, 1310, 1310, 1310, 1310},
    {1310, 1310, 1310, 1310, 1310, 1310},
    {1966, 1966, 1966, 1966, 1966, 1966},
    {2621, 2621, 2621, 2621, 2621, 2621},
    {1966, 1966, 1966, 1966, 1966, 1966},
    {1966, 1966, 1966, 1966, 1966, 1966},
    {1966, 1966, 1966, 1966, 1966, 1966}
  };

  if ((ushort)position < 6) {
    currentTourney = &this->fDefinition->fTournaments[
        this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament];
    if ((currentTourney->fOpponentCarClass == '\n') &&
       (carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0),
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

void tTournamentManager::GetAwardInformation(tAwardInformation &info)

{
  /* Ghidra hand-expanded gcc's own movstrsi block copy of the 68-byte
     tAwardInformation (4 words/iter + 1-word tail) — it is one struct assignment. */
  info = this->fAwards;
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
    carManager.SetCarAvailable((tCarModels)(this->fAwards).fActivateCar,true);
  }
  if (((this->fAwards).fActivateFlags & 1) != 0) {
    trackManager.SetTrackAvailable((ushort)(byte)(this->fAwards).fActivateTrack,true);
  }
  if (((this->fAwards).fActivateFlags & 8) != 0) {
    trackManager.SetClassAvailable((tTrackClassType)(this->fAwards).fActivateTrackClass,true);
  }
  if (((this->fAwards).fActivateFlags & 0x10) != 0) {
    FECheat_ActivateBonus((this->fAwards).fActivateCheat);
  }
  if (((this->fAwards).fAwardCar != 0) && ((this->fAwards).fAwardCarGarageFull == 0)) {
    ptVar3 = carManager.GetCarFromID((short)(this->fAwards).fAwardCarModel);
    carManager.PurchaseCar((short)(this->fAwards).fAwardCarModel,
               (short)(signed char)ptVar3->fColorOrder[(byte)(this->fAwards).fAwardCarColor],0);
    carManager.PurchaseUpgrade((ushort)(byte)frontEnd.garageCar[0],
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

void * tTournamentManager::ValidCar(tCarInfo &carInfo)

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
    result = (void *)(u_int)(carInfo.fCarClass == oppClass);
    if ((FECheat_IsCheatEnabled(cheat_FinishedTournament) != 0) && (this->fTier == 0)) {
      result = (void *)0x1;
    }
  }
  if ((tourney->fRequiredFlags & 4) != 0) {
    if ((int)(signed char)carInfo.fCarID == (int)tourney->fRequiredCar) {
      switch (tourney->fRequiredUpgrades) {
      case 0:
        if (carInfo.fUpgrades != '\0') {
          result = (void *)0x0;
        }
        break;
      case 1:
        break;
      case 2:
        if (carInfo.fUpgrades == '\0') {
          result = (void *)0x0;
        }
        break;
      case 3:
        if ((carInfo.fUpgrades & tourney->fSpecificUpgrades) !=
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
