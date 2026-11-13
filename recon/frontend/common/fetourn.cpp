/* frontend/common/fetourn.cpp -- RECONSTRUCTED (tournament manager + list iterator; C++ TU)
 *   tTournamentManager (28 methods) + tListIteratorTournament:tListIterator (7) + free
 *   tournPointsCompare. 5 in_a0(this-lost) fns rebuilt from m2c; phantoms via m2c oracle.
 */
#include "fetourn.h"


/* ---- tTournamentManager::Initialize  [FETOURN.CPP:36-82] ---- */

#line 33 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::Initialize()


{
  short i;

  this->fMoney = Tourn_StartMoney;
  this->fCurrentTrack = 0; this->fNumTiers = 0;
  this->fDefinition = NULL;
  this->fTournamentList[0] = 0;
  this->fTrackList[0] = 0;
  for (i = 0; i < Tourn_RacersCount; i++)
  {
    this->fRanking[i] = 0;
  }


  for (i = 0; i < 64; i++) // 64 = tournament array size?
    this->fBestPlacement[i] = 7;


  for (i = 0; i < 3; i++)
  {
    this->fTierFinishPrize[i] = 6;
    this->fTierFinishPrizeChange[i] = 0;
  }






















  frontEnd.garageCar[0] = CarManager_NumCars(carManager) - 1;
  frontEnd.garageCar[1] = CarManager_NumCars(carManager) - 1;
}



/* ---- tTournamentManager::LoadDescription  [FETOURN.CPP:89-139] ---- */

  /* SYM ORDER (W86-S2): the 8c Def rows read input, data, tier, tourney,
     track, filename; the three non-SYM carriers follow the SYM set. */
  /* FRONT6: BYTE+SYM+SLD exact.  tourneyDef carrier removed (this->fDefinition
     read directly); the loop starts trnId/trackId are short, which leaves them
     record-less like retail; the two inner loops are whiles whose condition
     ends on the retail line (multi-line condition: both tests tagged there). */
#line 86 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::LoadDescription()


{
  char *input;
  char *data;
  short tier;
  short tourney;
  short track;
  char filename [80];

  short trackId;
  short trnId;
  sprintf(filename,"%s%s",Paths_Paths[0x25],"tourn.trn");


  this->ReleaseDescription();

  input = (char *)loadfileadr(filename,0x10);
  blockmove(input,this->fFinishPoints,6);


  this->fNumTiers = input[Tourn_TRN_HeaderSize];


  data = input + Tourn_TRN_EntriesStart;

  this->fDefinition = (tTournamentDefinition *)reservememadr("Tourney",sizeof(tTournamentDefinition),0);

  for (tier = 0; tier < (int)(uint)(byte)this->fNumTiers; tier++) {

    blockmove(data,this->fDefinition->fTiers + tier, sizeof(tTierInfo));

    tourney = (short)this->fDefinition->fTiers[tier].fTournOffset;
    trnId = tourney;
    data += sizeof(tTierInfo); while (tourney <
           trnId + this->fDefinition->fTiers[tier].fNumTournaments) {


      blockmove(data, this->fDefinition->fTournaments + tourney, sizeof(tTourneyInfo));

      track = (short)this->fDefinition->fTournaments[tourney].fTrackOffset;
      trackId = track;
      data += sizeof(tTourneyInfo); while (track <
             trackId + this->fDefinition->fTournaments[tourney].fNumTracks) {


        blockmove(data, this->fDefinition->fTracks + track, sizeof(tTrackInfo));

        track = track + 1; data += sizeof(tTrackInfo);
      } tourney = tourney + 1;
    } }

  purgememadr(input);
}



/* ---- tTournamentManager::ReleaseDescription  [FETOURN.CPP:145-149] ---- */

#line 142 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::ReleaseDescription()


{
  if (this->fDefinition != NULL)
  {
    purgememadr(this->fDefinition);
    this->fDefinition = NULL;
  }
}



/* ---- tTournamentManager::UpdateTrackList  [FETOURN.CPP:195-209] ---- */

#line 194 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateTrackList(short tier,short tournament)
{
  tTourneyInfo *currentTourney;
  short numTracks;
  short trackOffset;
  short i; int tierPtr;
  tierPtr = (tierPtr = 0, (int)&this->fDefinition->fTiers[tier]);
  currentTourney = this->fDefinition->fTournaments + (((tTierInfo *)tierPtr)->fTournOffset + tournament);
  numTracks = currentTourney->fNumTracks;
  trackOffset = currentTourney->fTrackOffset;
  i = 0;
  if (numTracks != 0) { do {

      this->fTrackList[i] = (signed char)this->fDefinition->fTracks[trackOffset++].fTrackNumber + 0xD5; // ?
      i = i + 1; } while (i < numTracks);
  } this->fTrackList[numTracks] = 0; return;
}

/* ---- tTournamentManager::GetTrackList  [FETOURN.CPP:234-236] ---- */

#line 231 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short * tTournamentManager::GetTrackList(short tier,short tournament)


{
  this->UpdateTrackList(tier,tournament);
  return this->fTrackList;
}



/* ---- tTournamentManager::GetTrackToRace  [FETOURN.CPP:243-249] ---- */

#line 240 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::GetTrackToRace(tTrackInfo &track)


{ tTourneyInfo *devLocal_tTourneyInfo; /* DEVICE (exact-only): record-less unused local; retail fetourn.obj type record #319 (TPDEF tTourneyInfo) between tTournamentManager and tTournamentManager, inside GetTrackToRace__18tTournamentManagerR10tTrackInfo's record run (locals-before-params, GSDATA_state 7h) */
  blockmove(this->fDefinition->fTracks +
             (this->CurrentTourney()->fTrackOffset + this->fCurrentTrack),&track,sizeof(tTrackInfo));
  track.fDirection = this->fDirection[this->fCurrentTrack];
  track.fMirrored = this->fMirror[this->fCurrentTrack];
  track.fTimeOfDay = this->fTimeOfDay[this->fCurrentTrack];
  track.fWeather = this->fWeather[this->fCurrentTrack]; return;
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


#line 263 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::StartNewTournament(byte tier,byte tournament)
{
  short i;
  tTourneyInfo *tourn;
  tTrackInfo *track;

  this->fTier = tier;
  this->fTournament = tournament;
  this->fCurrentTrack = 0;


  this->fNumRacers = this->GetNumCompetitors();
  tourn = this->CurrentTourney();







  for (i = 0; i < this->fNumRacers; i++) {

    this->fCompetitors[i].fPoints = 0;
    this->fCompetitors[i].fEliminated = 0;
    this->fCompetitors[i].fIsPlayerCar = 0;
    this->fCompetitors[i].fPersonality = (i != 0) ? (tPersonalities)tourn->fPersonalities[i - 1] : kPersonalityNemesis;
    this->fCompetitors[i].fPosition = (i != 0) ? i : this->fNumRacers;



  }




  for (i = 0; i < tourn->fNumTracks; i++) {

    track = &this->fDefinition->fTracks[tourn->fTrackOffset + i];

    this->fDirection[i] = track->fDirection;
    if (this->fDirection[i] > 1) {

      this->fDirection[i] = rand() & 1;
    }
    this->fMirror[i] = track->fMirrored;
    if (this->fMirror[i] > 1) {

      this->fMirror[i] = rand() & 1;
    }
    this->fTimeOfDay[i] = track->fTimeOfDay;
    if (this->fTimeOfDay[i] > 1) {

      this->fTimeOfDay[i] = rand() & 1;
    }
    this->fWeather[i] = track->fWeather;
    if (this->fWeather[i] > 1) {

      this->fWeather[i] = rand() & 1;
    }
  }

  this->fCompetitors[0].fIsPlayerCar = 1;
}



/* ---- tTournamentManager::IsTournamentFinished  [FETOURN.CPP:337-344] ---- */

#line 336 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::IsTournamentFinished()
{
  /* SYM-CODEGEN-CARRIER: currentTourney -- one shared address is required;
     repeating the field chain loses an instruction and changes offsets. */
  tTourneyInfo *currentTourney;
  currentTourney = this->CurrentTourney();
  if (this->fCurrentTrack >= (int)currentTourney->fNumTracks) goto ret1; if (currentTourney->fKnockout == '\0') goto ret0; if (this->fCurrentTrack <= (int)this->fCompetitors[0].fPoints) goto ret0;
ret1: return 1;
ret0: return 0;
}

/* ---- (free)::free  [FETOURN.CPP:349-365] ---- */

#line 346 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
static int tournPointsCompare(char *p1,char *p2)


{
  int result;
  Car_tStats *dummyCars;
  tCompetitor *comps;
  comps = Tournament_Competitors(tournamentManager);
  dummyCars = Cars_NewCarStatsList();
  result = (u_int)comps[(byte)*p2].fPoints - (u_int)comps[(byte)*p1].fPoints;
  if (result == 0) {


    result = (int)comps[(byte)*p2].fIsPlayerCar - (int)comps[(byte)*p1].fIsPlayerCar;


    if (result == 0) {
      result = dummyCars[(byte)*p1].finalPosition - dummyCars[(byte)*p2].finalPosition;
    } }
  return result;
}



/* ---- tTournamentManager::UpdateTournFinishMoney  [FETOURN.CPP:370-398] ---- */

#line 367 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateTournFinishMoney()


{
  u_char i;
  tTourneyInfo *tourn;

  tourn = this->CurrentTourney();
  this->fPrevBestPlacement = this->fBestPlacement[(signed char)tourn->fTournamentID];



  if (tourn->fKnockout != '\0') {
    (this->fAwards).fTournMoney +=
        this->GetTournamentFinishPrize(this->fCompetitors[0].fPosition - 1);
    return; }
  else {
    for (i = 0; i < 6; i++) {


      if (this->fRanking[i] == '\0') {




        (this->fAwards).fTournMoney += this->GetTournamentFinishPrize((u_short)i);


        if ((int)i < (int)(signed char)this->fBestPlacement[(signed char)tourn->fTournamentID]) {
          this->fBestPlacement[(signed char)tourn->fTournamentID] = i + 1;
        }
      } } } return; }



/* ---- tTournamentManager::UpdateTrackFinishMoney  [FETOURN.CPP:405-414] ---- */

#line 402 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateTrackFinishMoney()


{
  Car_tStats *dummyCars;

  dummyCars = Cars_NewCarStatsList();
  if (dummyCars[0].finalFinishType == 2) {



    (this->fAwards).fMoney +=
        this->GetTrackFinishPrize((short)dummyCars[0].finalPosition + -1);
  }
}



/* ---- tTournamentManager::CalcTrackFinishDamageBill  [FETOURN.CPP:422-470] ---- */

    /* SYM SCOPE (W86-S2): `i` is a BLOCK local of this `if` -- its SYM row is at
       block depth 4, below the depth-1 rows (retbill/retbonus/dummyCars/
       carInfo/damage/totalcarprice) that are the function-scope set. */
  /* SYM ORDER (W86-S2): the depth-1 rows read
     retbill, retbonus, dummyCars, carInfo, damage, totalcarprice. */
  /* initialized => .data at this function (retail 0x80051a60/0x80051a64 = 0), not .lcomm */
#line 419 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::CalcTrackFinishDamageBill(bool recalculate,long &bill,long &bonus)


{
  /* SYM-CODEGEN-CARRIER: mask -- the signed-short shift carrier selects the
     retail srav/andi sequence; an inline (1 << i) changes 24 instructions. */
  static long retbill = 0;
  static long retbonus = 0;
  Car_tStats *dummyCars;
  tCarInfo carInfo;
  int damage;
  long totalcarprice;
  short mask;
  if (recalculate != 0)
  { dummyCars = Cars_NewCarStatsList();

    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);

    totalcarprice = carInfo.fPrices[0];
    for (int i = 0; i < 2; i++) {

      mask = 1 << i;
      if ((carInfo.fUpgrades & mask) != 0) {
        totalcarprice = totalcarprice + carInfo.fPrices[i + 1];
      } }

    damage = dummyCars->finalDamage / 0x10000;
    if ((damage == 0) && (dummyCars->finalPosition < 4)) {

      retbill = 0;
      retbonus = totalcarprice / 0x14;

      if (dummyCars->finalPosition == 2) {
        retbonus = (totalcarprice * 3) / 100;
      } else if (dummyCars->finalPosition == 3) {
        retbonus = totalcarprice / 100;
      }
    }
    else {
      retbonus = 0;
      retbill = (totalcarprice * damage * 3) / 10000;
    }
  }

  bill = retbill;
  bonus = retbonus;





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
   gives the retail SYM handout k=$a3, numCompetitors=$t0, dummyCars=$t1.  The fPosition
   store is written in BOTH arms (gcc cross-jumps them back to one store after allocation):
   the duplicate raises the strength-reduced fCompetitors[i] cursor's ref count across GCC's
   floor_log2 priority boundary, assigning cursor=$a1/finalPosition=$a2 as retail does
   (single shared store: 20 diffs).  Flat integer address arithmetic preserves both retail add operand orders.  The
   final ranking loop keeps old-i address formation and a distinct next-i web; its byte cursor
   supplies the retail base-first add and +294 store exactly. */
    /* W85-S5 (device removed): this loop used to launder `i + 1` through an
       inline-asm identity fence and
       then assign `i = next`.  Writing the stored value as `(uchar)(i + 1)`
       and incrementing AFTERWARDS is byte-identical (35/35 PASS) -- retail
       simply materialises the rank as `i+1` at the store and bumps the counter
       after it.  FALSIFIED first (whole-TU re-gated): increment-before-store
       with a `ranked` temp 3; increment-before-store inline 5; a plain
       `int next = i + 1;` local in the old position 3. */
        /* MATCH: ONE &dummyCars[k] address, held live across the eliminated/points arms --
           retail reuses `v1` for the trailing `lbu 132(v1)` fPosition read; four separate
           `dummyCars[k].` spellings let gcc rematerialize the *160 index chain after the
           if/else join (6 extra insns). */
  /* (INV-B I6: unused `comp` removed -- the class field block now supplies this record.) HISTORY: comp emitted the fourth
     supplied tCompetitor typedef copy. Deleting it, even with a completed
     shared definition, loses a supplied ordered-alias sequence. This does NOT
     prove an original named object: recover the actual late type producer.
     The old `next` review entry was stale after W85 removed that object.
     Receipts: build/tmp/v/fetourn_unused_owner_20261102/receipt.json and
     build/tmp/v/tcompetitor_type_private_20261102/receipt.json.
     SYM-CODEGEN-CARRIER: knockout
     SYM-CODEGEN-CARRIER: ranking
     SYM-CODEGEN-CARRIER: stats
     Their original source producers remain unresolved; byte matching is not
     an exemption. Retail supplies only i, k, dummyCars and numCompetitors. */
#line 478 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateTrackFinishPoints()


{
  int i;
  short k;
  Car_tStats *dummyCars;
  short numCompetitors; int stats; bool knockout; numCompetitors = this->GetNumCompetitors();





  k = 0;
  knockout = this->CurrentTourney()->fKnockout
      != '\0'; dummyCars = Cars_NewCarStatsList(); if (knockout) {


    for (i = 0; i < numCompetitors; i = i + 1) {

      if (this->fCompetitors[i].fEliminated == 0) {

        if (((stats = ((k = k, (int)k * (int)sizeof(Car_tStats) + (int)dummyCars) ?: 0) + ((stats = 0) != 0)), ((Car_tStats *)stats)->finalPosition - 1U < 6) && (((Car_tStats *)stats)->finalFinishType == 2)) {

          if (((Car_tStats *)stats)->finalPosition >= this->fNumRacers) {
            this->fCompetitors[i].fEliminated = 1;


            this->fCompetitors[i].fPosition = (uchar)((Car_tStats *)stats)->finalPosition;
          }
          else {

            this->fCompetitors[i].fPoints = this->fCompetitors[i].fPoints + 1;
            this->fCompetitors[i].fPosition = (uchar)((Car_tStats *)stats)->finalPosition;
          }
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
             this->fCompetitors[i].fPoints + (ushort)this->fFinishPoints[dummyCars[i].finalPosition + -1];
      }



    }


    i = 5; do {
      ((u_char *)(((int)this - i) ?: 0))[(i << 1) + 567] = (uchar)i; i = i - 1; } while (-1 < i);
    qsort(this->fRanking,(int)numCompetitors,1,


               tournPointsCompare);




    i = 0;
    do { this->fCompetitors[this->fRanking[i]].fPosition = i + 1; i = i + 1; } while (i < 6); } return; }



/* ---- tTournamentManager::AdvanceToNextTrack  [FETOURN.CPP:569-700] ---- */
/* MATCH (W64, 80->PASS): sum fTournOffset+fTournament before the one 84-byte
   scale, then restore the SYM-only locals (currentTourney, tourn, carInfo,
   currentTier, i, numGarageCars).  The tournament IDs are signed chars, the
   normalized cheat result uses its 0/1 XOR test, and the garage-full award arm
   is laid out before PurchaseCar.  Reusing fCompletedBonusMoney for the money
   addition gives retail's single price load; returning fCurrentTrack directly
   preserves its word load despite this function's short return type. */

            /* SYM SCOPE (W86-S2): `numGarageCars` is a BLOCK local of this
               completed-tier arm -- its SYM row sits at block depth 11, while
               currentTourney/tourn/carInfo/currentTier/i are the depth-1 set. */
#line 566 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::AdvanceToNextTrack()


{
  tTourneyInfo *currentTourney;
  tTourneyInfo *tourn;
  tCarInfo *carInfo;
  tTierInfo *currentTier;
  short i;
  currentTourney = this->CurrentTourney();
  if (this->fCurrentTrack <= (int)(currentTourney->fNumTracks - 1))
  {
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

    if ((int)(uint)currentTourney->fNumTracks <= this->fCurrentTrack)
    {
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
      if (this->fCompetitors[0].fPosition < 2)
      {
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

        if (((int)(long)FECheat_IsCheatEnabled((tCheatCode)(this->fTier + cheat_FinishedTournament)) ^ 1) != 0)
        {

          currentTier = this->fDefinition->fTiers + this->fTier;
          (this->fAwards).fCompletedTier = 1; i = 0;
          if (currentTier->fNumTournaments != '\0') { do {

              tourn = this->fDefinition->fTournaments + ((uint)currentTier->fTournOffset + i);
              if (this->fBestPlacement[(signed char)tourn->fTournamentID] != '\x01') {


                (this->fAwards).fCompletedTier = 0;
              }
              i = i + 1; } while (i < (int)(uint)currentTier->fNumTournaments);
          } if ((this->fAwards).fCompletedTier != 0)
          { int numGarageCars;
            numGarageCars = carManager.GetNumOwnedCars(0);
            if ((this->fAwards).fAwardCar != 0) {
              numGarageCars = numGarageCars + 1;
            }

            FECheat_ActivateBonus((tCheatCode)(this->fTier + cheat_FinishedTournament));
            (this->fAwards).fCompletedCar = (tCarModels)(this->fTier + cm_BonusCar1);
            carInfo = carManager.GetCarFromID((short)(this->fAwards).fCompletedCar);
            carManager.SetCarAvailable((tCarModels)(this->fAwards).fCompletedCar,true);
            carManager.SetCarViewable((tCarModels)(this->fAwards).fCompletedCar,true);

            if (0x1f < numGarageCars) {

              (this->fAwards).fCompletedGarageFull = 1;
              (this->fAwards).fCompletedBonusMoney = carInfo->fPrices[0];
              this->fMoney = this->fMoney + (this->fAwards).fCompletedBonusMoney;
            }
            else { carManager.PurchaseCar((short)(this->fAwards).fCompletedCar, (ushort)carInfo->fDefaultColor,0);
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
/* DEVICE (exact-only): `tourney` is a record-less const pointer on the '{' line so the
   inlined CurrentTourney() code carries retail line 0 while the indexing/load carries the
   return line 28.  Bytes PASS, SYM = retail (REGPARM this + inline this only), SLD 0 tags,
   blocks exact. */

#line 703 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::GetLastTrackRaced()


{ tTourneyInfo *const tourney = this->CurrentTourney();



























  return (short)(signed char)this->fDefinition->fTracks[tourney->fTrackOffset + this->fCurrentTrack + -1].fTrackNumber; }



/* ---- tTournamentManager::SaveTournament  [FETOURN.CPP:744-762] ---- */

#line 743 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::SaveTournament(tSaveTournament &save)
{
  short i;




  save.fSaveMoney = this->fMoney;










  i = 0;
  do { save.fSaveBestPlacement[i] = this->fBestPlacement[i]; i = i + 1; } while (i < 0x40); return;
}

/* ---- tTournamentManager::LoadTournament  [FETOURN.CPP:773-791] ---- */

#line 772 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::LoadTournament(tSaveTournament &load)
{
  short i;


  this->fMoney = load.fSaveMoney;












  i = 0;
  do { this->fBestPlacement[i] = load.fSaveBestPlacement[i]; i = i + 1; } while (i < 0x40); return;
}

/* ---- tTournamentManager::GetNumCompetitors  [FETOURN.CPP:803-805] ---- */


#line 802 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::GetNumCompetitors()
{ tTourneyInfo *devLocal_tTourneyInfo; /* DEVICE (exact-only): record-less unused local; retail fetourn.obj type record #367 (TPDEF tTourneyInfo) between tTournamentManager and tTournamentManager, inside GetNumCompetitors__18tTournamentManager's record run (locals-before-params, GSDATA_state 7h) */

  return this->CurrentTourney()->fNumCars;
}



/* ---- tTournamentManager::UpdateCarLineup  [FETOURN.CPP:812-834] ---- */

  /* SYM-CODEGEN-CARRIER: numCompetitors -- retains the single call result as
     the loop bound; SYM records the independently allocated i and k locals. */
#line 809 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateCarLineup()


{
  short i; short k; short numCompetitors; numCompetitors = this->GetNumCompetitors();


  k = 0;
  i = 0;




  if (0 < numCompetitors) { do {

      if (this->fCompetitors[i].fEliminated == 0) {

        this->fCarLineup[k].isPlayerCar = this->fCompetitors[i].fIsPlayerCar;
        this->fCarLineup[k].personality = this->fCompetitors[i].fPersonality;
        this->fCarLineup[k].position = this->fCompetitors[i].fPosition;
        k = k + 1;
      }



      i = i + 1; } while (i < numCompetitors); } return; }



/* ---- tTournamentManager::GetTrackFinishPrize  [FETOURN.CPP:844-890] ---- */

#line 841 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
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


  if ((ushort)position < 6)
  { currentTourney = this->CurrentTourney();







    if (currentTourney->fOpponentCarClass == '\n') {

      carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);
      if (carInfo.fCarClass < 7) {

        carPrice = carInfo.fPrices[0];
        if ((carInfo.fUpgrades & 1) != 0) {
          carPrice = carPrice + carInfo.fPrices[1];
        } if ((carInfo.fUpgrades & 2) != 0) {
          carPrice = carPrice + carInfo.fPrices[2];
        } if ((carInfo.fUpgrades & 4) != 0) {
          carPrice = carPrice + carInfo.fPrices[3];
        }
        result += fixedmult(openClassAdjust[carInfo.fCarClass][position],carPrice);
      } }
    result = result + this->fDefinition->fTracks[


        currentTourney->fTrackOffset + this->fCurrentTrack].fPrize[position];
  }
  return result;
}



/* ---- tTournamentManager::GetTournamentFinishPrize  [FETOURN.CPP:897-905] ---- */

#line 896 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
long tTournamentManager::GetTournamentFinishPrize(short position)
{
  /* SYM-CODEGEN-CARRIER: tourn -- SYM has no locals here; the shared pointer
     is required for the retail address schedule (inlining changes 14 insns). */
  if ((ushort)position < 6) {

    tTourneyInfo *tourn = this->CurrentTourney();
    return tourn->fPrize[position];
  }
  return 0;
}

/* ---- tTournamentManager::GetAwardInformation  [FETOURN.CPP:913-914] ---- */
/* Ghidra hand-expanded gcc's own movstrsi block copy of the 68-byte
   tAwardInformation (4 words/iter + 1-word tail) -- one struct assignment. */

#line 910 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::GetAwardInformation(tAwardInformation &info)


{
  info = this->fAwards;
}



/* ---- tTournamentManager::UpdateAwardInformation  [FETOURN.CPP:920-949] ---- */

  /* SLD names only bill and bonus: the four direct compound updates are
     retail's load/add/store chain; decompiler arithmetic temps lose a store. */
#line 917 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::UpdateAwardInformation()


{
  /* SYM ORDER (W86-S2): the 8c Def rows read bonus, bill. */
  long bonus;
  long bill; int car;
  this->CalcTrackFinishDamageBill(true,bill,bonus);   /* now takes long& */
  this->fMoney -= bill;
  this->fMoney += bonus;
  this->fMoney += (this->fAwards).fMoney;
  this->fMoney += (this->fAwards).fTournMoney;

  if (((this->fAwards).fActivateFlags & 2) != 0) {
    FECheat_ActivateBonus((tCheatCode)(this->fAwards).fActivateCarClass);
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
    FECheat_ActivateBonus((tCheatCode)(this->fAwards).fActivateCheat);
  }
  if (((this->fAwards).fAwardCar != 0) && ((this->fAwards).fAwardCarGarageFull == 0)) {
    
    car = (car = 0, (int)carManager.GetCarFromID((short)(this->fAwards).fAwardCarModel));
    carManager.PurchaseCar((short)(this->fAwards).fAwardCarModel,(short)(signed char)((tCarInfo *)car)->fColorOrder[(byte)(this->fAwards).fAwardCarColor],0);
    carManager.PurchaseUpgrade((ushort)(byte)frontEnd.garageCar[0], (ushort)(byte)(this->fAwards).fAwardCarUpgrades,0); } return; }



/* ---- tTournamentManager::TournPointTotal  [FETOURN.CPP:957-958] ---- */

#line 954 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::TournPointTotal(short *p)


{
  return this->fCompetitors[*p].fPoints;
}



/* ---- tTournamentManager::PlayerRanking  [FETOURN.CPP:965-973] ---- */

  /* SYM-CODEGEN-CARRIER: numCompetitors -- preserves one GetNumCompetitors
     call and its loop-bound lifetime; the retail debug local is i. */
#line 962 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tTournamentManager::PlayerRanking(short pos)


{
  short i; short numCompetitors; numCompetitors = this->GetNumCompetitors();


  for (i = 0; i < numCompetitors; i++) {
    if ((u_short)this->fCompetitors[i].fPosition == pos) {
      return i;
    }
  } return 0;
}



/* ---- tTournamentManager::CalcTierFinishPrize  [FETOURN.CPP:979-981] ---- */

#line 976 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::CalcTierFinishPrize()


{
  this->fTierFinishPrize[this->fTier] = 7;
  this->fTierFinishPrizeChange[this->fTier] = 0;
}



/* ---- tTournamentManager::GetTrophyName  [FETOURN.CPP:1040-1056] ---- */

/* Const snapshots preserve the pre-branch best-placement load and the
   short branch selection without adding retail-absent SYM locals. */
/* SYM locals: int showplace (REG $2) + char trophySizeLetter[3] (AUTO -0x18)
   + char trophyPlacementLetter[4] (AUTO -0x10); `place` keeps its own REG $3.
   The two arrays are AGGREGATE INITIALIZERS (rodata->stack copies: 3x lb/sb
   for the 3-byte one, an unaligned lwl/lwr+swl/swr word for the 4-byte one) --
   the Ghidra body had hand-expanded gcc's own unaligned block move. */
/* MATCH: `char` is UNSIGNED on this build -> (signed char) restores the oracle's lb.
   SLD puts this read on line 1042/1043 -- BETWEEN the two array initializers and
   before the guard, i.e. in the entry basic block (sched1 cannot move a load
   across a branch, so an in-branch placement can never reproduce it). */
#line 1036 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tTournamentManager::GetTrophyName(tTourneyInfo *tourn,tTrophySize size,char *buffer,int place
               )


{
  int showplace; short t;
  char trophySizeLetter [3] = { 'S', 'M', 'L' }; const int best = Tournament_BestPlacement(tournamentManager, (signed char)tourn->fTournamentID);

  char trophyPlacementLetter [4] = { 'W', 'G', 'S', 'B' };


  if (place == -1) {
    t = (t = 0, (u_int)(best - 1U) < 3 ? (short)best : (short)0);
    showplace = t;

  }
  else {
    showplace = place;
  }
  sprintf(buffer,"TR%c%02d%c",(uint)(byte)trophySizeLetter[size],(uint)tourn->fTrophyID,
             (uint)(byte)trophyPlacementLetter[showplace]); return;
}



/* ---- tTournamentManager::ValidCar  [FETOURN.CPP:1063-1102] ---- */

#line 1060 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
bool tTournamentManager::ValidCar(tCarInfo &carInfo)


{
  tTourneyInfo *tourney = this->CurrentTourney();
  bool result = 1;



  if (tourney->fOpponentCarClass != '\n') {

    result = carInfo.fCarClass == tourney->fOpponentCarClass;


    if ((FECheat_IsCheatEnabled(cheat_FinishedTournament) != 0) && (this->fTier == 0)) {
      result = 1;
    }
  }
  if ((tourney->fRequiredFlags & 4) != 0) {

    if ((int)(signed char)carInfo.fCarID == (int)tourney->fRequiredCar) {


      switch (tourney->fRequiredUpgrades) {
      case 0:

        if (carInfo.fUpgrades != '\0') {
          result = 0;
        } break;
      case 1:
        break;
      case 2:
        if (carInfo.fUpgrades == '\0') {
          result = 0;
        } break;
      case 3:
        if ((carInfo.fUpgrades & tourney->fSpecificUpgrades) != tourney->fSpecificUpgrades) {
          result = 0; } break; default: break; } } else { result = 0;
    }
  }


  return result;
}



/* ---- tListIteratorTournament::ctor  [FETOURN.CPP:1109-1111] ---- */

#line 1108 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
tListIteratorTournament::tListIteratorTournament(char *valPtr,tTournamentManager *tournManager)
  : tListIterator((short *)0x0, valPtr)
{
  this->fTournamentManager = tournManager;
}



/* ---- tListIteratorTournament::dtor  [FETOURN.CPP:1115-1115] ---- */

/* base ~tListIterator() now implicit (§3.23 inheritance) */

#line 1115 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
tListIteratorTournament::~tListIteratorTournament() { }



/* ---- tListIteratorTournament::Value  [FETOURN.CPP:1119-1120] ---- */

#line 1116 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
char tListIteratorTournament::Value(tPlayer)


{
  return (uint)(byte)*this->fValue;
}



/* ---- tListIteratorTournament::TextValue  [FETOURN.CPP:1124-1130] ---- */

#line 1121 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
short tListIteratorTournament::TextValue(tPlayer)


{
  short tournIndex;
  /* SYM/SLD: the offset is initialized first, then the selected value is
     accumulated on the following retail source line. */
  tournIndex = this->fTournamentManager->fDefinition->fTiers[(byte)frontEnd.tier].fTournOffset;
  tournIndex += (byte)*this->fValue;
  return (signed char)this->fTournamentManager->fDefinition->fTournaments[tournIndex].fTournamentID + 0x341;
}



/* ---- tListIteratorTournament::Increment  [FETOURN.CPP:1134-1144] ---- */

#line 1131 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tListIteratorTournament::Increment(tPlayer)


{
  tTierInfo *tier; tier = &this->fTournamentManager->fDefinition->fTiers[(byte)frontEnd.tier];
  do {


    *this->fValue = *this->fValue + 1;

    if (tier->fNumTournaments <= (byte)*this->fValue) {
      *this->fValue = 0;
    }
  } while (!this->ValidTournament(*this->fValue)); return;
}



/* ---- tListIteratorTournament::Decrement  [FETOURN.CPP:1148-1158] ---- */

/* P863 source recovery: SYM 5cbc89 records only tier, not a byte-value
   local. Store each branch's decremented result directly; GCC merges the
   store and fills the nonzero branch's delay slot with the decrement.
   Retail SLD 1153/1154/1156/1158 corroborates guard / wrap load /
   decrement-store / validity test. Exact original spelling is unavailable;
   this source shape and its 36-instruction debug twin are verified. */
#line 1145 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
void tListIteratorTournament::Decrement(tPlayer)


{
  tTierInfo *tier; tier = &this->fTournamentManager->fDefinition->fTiers[(byte)frontEnd.tier];
  do {


    if (*this->fValue == 0) {
      *this->fValue = tier->fNumTournaments - 1;
    } else {
      *this->fValue = *this->fValue - 1;
    }
  } while (!this->ValidTournament(*this->fValue));
}



/* ---- tListIteratorTournament::ValidTournament  [FETOURN.CPP:1162] ---- */

#line 1159 "C:/nfs4/FRONTEND/COMMON/FETOURN.CPP"
bool tListIteratorTournament::ValidTournament(char tourn)


{
  tTierInfo *currentTier;
  tTourneyInfo *currentTourn;
  bool result = 1;

  currentTier = &this->fTournamentManager->fDefinition->fTiers[(u_char)frontEnd.tier];
  currentTourn = &this->fTournamentManager->fDefinition->fTournaments [(u_int)currentTier->fTournOffset + (u_int)(u_char)tourn];

  if ((currentTourn->fRequiredFlags & 1) != 0) { result = (signed char)this->fTournamentManager->fBestPlacement[ currentTourn->fRequiredTournamentID] < '\x04';
  }
  if (((currentTourn->fRequiredFlags & 2) != 0) &&
     ('\x01' < (signed char)this->fTournamentManager->fBestPlacement[ currentTourn->fRequiredTournamentID])) {
    result = 0;
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
