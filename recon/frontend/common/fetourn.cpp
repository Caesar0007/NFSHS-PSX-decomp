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
  int iVar1;
  short i;
  int iVar2;
  
  iVar2 = 0;
  this->fMoney = 20000;
  this->fCurrentTrack = 0;
  this->fNumTiers = '\0';
  this->fDefinition = (tTournamentDefinition *)0x0;
  this->fTournamentList[0] = 0;
  this->fTrackList[0] = 0;
  iVar1 = 0;
  do {
    this->fRanking[iVar1 >> 0x10] = '\0';
    iVar2 = iVar2 + 1;
    iVar1 = iVar2 * 0x10000;
  } while (iVar2 * 0x10000 >> 0x10 < 6);
  iVar2 = 0;
  iVar1 = 0;
  do {
    this->fBestPlacement[iVar1 >> 0x10] = '\a';
    iVar2 = iVar2 + 1;
    iVar1 = iVar2 * 0x10000;
  } while (iVar2 * 0x10000 >> 0x10 < 0x40);
  iVar1 = 0;
  do {
    iVar2 = iVar1 << 0x10;
    iVar1 = iVar1 + 1;
    iVar2 = iVar2 >> 0xf;
    *(u_short *)((int)this->fTierFinishPrize + iVar2) = 6;
    *(u_short *)((int)this->fTierFinishPrizeChange + iVar2) = 0;
  } while (iVar1 * 0x10000 >> 0x10 < 3);
  frontEnd.garageCar[0] = (signed char)carManager.fNumCars + -1;
  frontEnd.garageCar[1] = frontEnd.garageCar[0];
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
  iVar8 = 0;
  this->fDefinition = ptVar2;
  src_00 = (void *)((int)src + 7);
  if (this->fNumTiers != '\0') {
    do {
      sVar1 = (short)iVar8;
      blockmove(src_00,this->fDefinition->fTiers + sVar1,0xc);
      ptVar2 = this->fDefinition;
      uVar7 = (uint)ptVar2->fTiers[sVar1].fTournOffset;
      src_00 = (void *)((int)src_00 + 0xc);
      uVar3 = uVar7;
      if (uVar7 < uVar7 + ptVar2->fTiers[sVar1].fNumTournaments) {
        do {
          sVar4 = (short)uVar3;
          blockmove(src_00,ptVar2->fTournaments + sVar4,0x54);
          ptVar2 = this->fDefinition;
          uVar6 = (uint)ptVar2->fTournaments[sVar4].fTrackOffset;
          src_00 = (void *)((int)src_00 + 0x54);
          uVar5 = uVar6;
          if (uVar6 < uVar6 + ptVar2->fTournaments[sVar4].fNumTracks) {
            do {
              blockmove(src_00,ptVar2->fTracks + (short)uVar5,0x28);
              uVar5 = uVar5 + 1;
              ptVar2 = this->fDefinition;
              src_00 = (void *)((int)src_00 + 0x28);
            } while ((int)(uVar5 * 0x10000) >> 0x10 <
                     (int)(uVar6 + ptVar2->fTournaments[sVar4].fNumTracks));
          }
          uVar3 = uVar3 + 1;
          ptVar2 = this->fDefinition;
        } while ((int)(uVar3 * 0x10000) >> 0x10 <
                 (int)(uVar7 + ptVar2->fTiers[sVar1].fNumTournaments));
      }
      iVar8 = iVar8 + 1;
    } while (iVar8 * 0x10000 >> 0x10 < (int)(uint)(byte)this->fNumTiers);
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



/* ---- tTournamentManager::StartNewTournament  [FETOURN.CPP:264-324] ---- */

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
  this->fNumRacers = (int)sVar2;
  iVar9 = 0;
  iVar7 = (uint)ptVar8->fTiers[this->fTier].fTournOffset + this->fTournament;
  if (0 < sVar2) {
    iVar3 = 0;
    do {
      iVar3 = iVar3 >> 0x10;
      this->fCompetitors[iVar3].fPoints = 0;
      this->fCompetitors[iVar3].fEliminated = 0;
      this->fCompetitors[iVar3].fIsPlayerCar = '\0';
      if (iVar3 == 0) {
        this->fCompetitors[0].fPersonality = kPersonalityNemesis;
      }
      else {
        this->fCompetitors[iVar3].fPersonality =
             (uint)ptVar8->fTournaments[iVar7].fPersonalities[iVar3 + -1];
      }
      if ((short)iVar9 == 0) {
        this->fCompetitors[0].fPosition = (uchar)this->fNumRacers;
      }
      else {
        this->fCompetitors[(short)iVar9].fPosition = (uchar)iVar9;
      }
      iVar9 = iVar9 + 1;
      iVar3 = iVar9 * 0x10000;
    } while (iVar9 * 0x10000 >> 0x10 < this->fNumRacers);
  }
  iVar9 = 0;
  if (ptVar8->fTournaments[iVar7].fNumTracks != '\0') {
    iVar3 = 0;
    do {
      iVar3 = iVar3 >> 0x10;
      iVar5 = (uint)ptVar8->fTournaments[iVar7].fTrackOffset + iVar3;
      ptVar6 = this->fDefinition;
      bVar1 = ptVar6->fTracks[iVar5].fDirection;
      this->fDirection[iVar3] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fDirection[iVar3] = (byte)iVar4 & 1;
      }
      bVar1 = ptVar6->fTracks[iVar5].fMirrored;
      this->fMirror[iVar3] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fMirror[iVar3] = (byte)iVar4 & 1;
      }
      bVar1 = ptVar6->fTracks[iVar5].fTimeOfDay;
      this->fTimeOfDay[iVar3] = bVar1;
      if (1 < bVar1) {
        iVar4 = rand();
        this->fTimeOfDay[iVar3] = (byte)iVar4 & 1;
      }
      bVar1 = ptVar6->fTracks[iVar5].fWeather;
      this->fWeather[iVar3] = bVar1;
      if (1 < bVar1) {
        iVar5 = rand();
        this->fWeather[iVar3] = (byte)iVar5 & 1;
      }
      iVar9 = iVar9 + 1;
      iVar3 = iVar9 * 0x10000;
    } while (iVar9 * 0x10000 >> 0x10 < (int)(uint)ptVar8->fTournaments[iVar7].fNumTracks);
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
  byte bVar1;
  byte bVar2;
  int result;
  int iVar3;
  Car_tStats *dummyCars;
  
  bVar1 = *p2;
  bVar2 = *p1;
  iVar3 = (uint)tournamentManager.fCompetitors[bVar1].fPoints -
          (uint)tournamentManager.fCompetitors[bVar2].fPoints;
  if ((iVar3 == 0) &&
     (iVar3 = (int)tournamentManager.fCompetitors[bVar1].fIsPlayerCar -
              (int)tournamentManager.fCompetitors[bVar2].fIsPlayerCar, iVar3 == 0)) {
    iVar3 = Cars_gNewCarStatsList[bVar2].finalPosition - Cars_gNewCarStatsList[bVar1].finalPosition;
  }
  return iVar3;
}



/* ---- tTournamentManager::UpdateTournFinishMoney  [FETOURN.CPP:370-398] ---- */

void tTournamentManager::UpdateTournFinishMoney()

{
  long lVar1;
  byte i;
  byte bVar2;
  uint uVar3;
  tTourneyInfo *tourn;
  tTourneyInfo *ptVar4;
  
  ptVar4 = this->fDefinition->fTournaments +
           (uint)this->fDefinition->fTiers[this->fTier].fTournOffset + this->fTournament;
  this->fPrevBestPlacement = this->fBestPlacement[ptVar4->fTournamentID];
  if (ptVar4->fKnockout == '\0') {
    bVar2 = 0;
    uVar3 = 0;
    do {
      if (this->fRanking[uVar3] == '\0') {
        lVar1 = this->GetTournamentFinishPrize((ushort)bVar2);
        (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + lVar1;
        if ((int)uVar3 < (int)this->fBestPlacement[ptVar4->fTournamentID]) {
          this->fBestPlacement[ptVar4->fTournamentID] = bVar2 + 1;
        }
      }
      bVar2 = bVar2 + 1;
      uVar3 = (uint)bVar2;
    } while (bVar2 < 6);
  }
  else {
    lVar1 = this->GetTournamentFinishPrize(this->fCompetitors[0].fPosition - 1);
    (this->fAwards).fTournMoney = (this->fAwards).fTournMoney + lVar1;
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
  uint uVar1;
  int iVar2;
  long totalcarprice;
  int damage;
  Car_tStats *dummyCars;
  tCarInfo carInfo;
  
  if (recalculate != 0) {
    GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
    uVar1 = 0;
    iVar2 = 4;
    do {
      if ((ushort)((ushort)carInfo.fUpgrades & (ushort)(1 << (uVar1))) != 0) {
        carInfo.fPrices[0] = carInfo.fPrices[0] + *(int *)((int)carInfo.fPrices + iVar2);
      }
      uVar1 = uVar1 + 1;
      iVar2 = iVar2 + 4;
    } while ((int)uVar1 < 2);
    iVar2 = Cars_gNewCarStatsList[0].finalDamage;
    if (Cars_gNewCarStatsList[0].finalDamage < 0) {
      iVar2 = Cars_gNewCarStatsList[0].finalDamage + 0xffff;
    }
    if ((iVar2 >> 0x10 == 0) && (Cars_gNewCarStatsList[0].finalPosition < 4)) {
      gTrackFinishBill = 0;
      gTrackFinishBonus = carInfo.fPrices[0] / 0x14;
      if (Cars_gNewCarStatsList[0].finalPosition == 2) {
        gTrackFinishBonus = (carInfo.fPrices[0] * 3) / 100;
      }
      else if (Cars_gNewCarStatsList[0].finalPosition == 3) {
        gTrackFinishBonus = carInfo.fPrices[0] / 100;
      }
    }
    else {
      gTrackFinishBonus = 0;
      gTrackFinishBill = (carInfo.fPrices[0] * (iVar2 >> 0x10) * 3) / 10000;
    }
  }
  *bill = gTrackFinishBill;
  *bonus = gTrackFinishBonus;
  return;
}



/* ---- tTournamentManager::UpdateTrackFinishPoints  [FETOURN.CPP:481-553] ---- */

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
void tTournamentManager::UpdateTrackFinishPoints()

{
  int i;
  short k;
  Car_tStats *dummyCars;
  short numCompetitors;
  tCompetitor *comp;
  u_char rankVal;

  numCompetitors = this->GetNumCompetitors();
  k = 0;
  i = this->fTier;
  dummyCars = Cars_gNewCarStatsList;
  if (this->fDefinition->fTournaments
      [(uint)this->fDefinition->fTiers[i].fTournOffset + this->fTournament].fKnockout != '\0') {
    k = 0;
    if (0 < numCompetitors) {
      comp = this->fCompetitors;
      for (i = 0; i < numCompetitors; i = i + 1) {
        if (comp->fEliminated == 0) {
          if ((dummyCars[k].finalPosition - 1U < 6) &&
             (dummyCars[k].finalFinishType == 2)) {
            if (dummyCars[k].finalPosition < this->fNumRacers) {
              comp->fPoints = comp->fPoints + 1;
            }
            else {
              comp->fEliminated = 1;
            }
            comp->fPosition = (uchar)dummyCars[k].finalPosition;
          }
          k = k + 1;
        }
        comp = comp + 1;
      }
    }
    this->fNumRacers = this->fNumRacers + -1;
  }
  else {
    if (0 < numCompetitors) {
      comp = this->fCompetitors;
      for (i = 0; i < numCompetitors; i = i + 1) {
        if ((dummyCars->finalPosition - 1U < 6) && (dummyCars->finalFinishType == 2)) {
          comp->fPoints =
               comp->fPoints +
               (ushort)this->fFinishPoints[dummyCars->finalPosition + -1];
        }
        dummyCars = dummyCars + 1;
        comp = comp + 1;
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
          iVar3 = 0;
          if (ptVar8->fNumTournaments != '\0') {
            iVar6 = 0;
            do {
              iVar3 = iVar3 + 1;
              if (this->fBestPlacement
                  [ptVar7->fTournaments[(uint)ptVar8->fTournOffset + (iVar6 >> 0x10)].fTournamentID]
                  != '\x01') {
                (this->fAwards).fCompletedTier = 0;
              }
              iVar6 = iVar3 * 0x10000;
            } while (iVar3 * 0x10000 >> 0x10 < (int)(uint)ptVar8->fNumTournaments);
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
  int _i;
  short sVar1;
  int iVar2;
  short i;
  short k;
  short sVar3;
  
  sVar1 = this->GetNumCompetitors();
  sVar3 = 0;
  _i = 0;
  if (0 < sVar1) {
    iVar2 = 0;
    do {
      iVar2 = iVar2 >> 0xc;
      if (*(int *)((int)&this->fCompetitors[0].fEliminated + iVar2) == 0) {
        this->fCarLineup[sVar3].isPlayerCar =
             (uint)((&this->fCompetitors[0].fIsPlayerCar)[iVar2] != '\0');
        this->fCarLineup[sVar3].personality =
             *(tPersonalities *)((int)&this->fCompetitors[0].fPersonality + iVar2);
        this->fCarLineup[sVar3].position = (&this->fCompetitors[0].fPosition)[iVar2];
        sVar3 = sVar3 + 1;
      }
      _i = _i + 1;
      iVar2 = _i * 0x10000;
    } while (_i * 0x10000 >> 0x10 < (int)sVar1);
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
  int _i;
  short i;
  short sVar1;
  int iVar2;
  
  sVar1 = this->GetNumCompetitors();
  _i = 0;
  if (0 < sVar1) {
    iVar2 = 0;
    do {
      iVar2 = iVar2 >> 0x10;
      _i = _i + 1;
      if ((ushort)this->fCompetitors[iVar2].fPosition == pos) goto PlayerRank_returnRank;
      iVar2 = _i * 0x10000;
    } while (_i * 0x10000 >> 0x10 < (int)sVar1);
  }
  iVar2 = 0;
PlayerRank_returnRank:
  return (short)iVar2;
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
  tCarInfo *carInfo = &carInfo_r;   /* R-ref param; alias keeps body codegen-identical */
  uchar uVar1;
  byte bVar2;
  void *pvVar3;
  int iVar4;
  tTournamentDefinition *ptVar5;
  byte result;
  void *pvVar6;
  tTourneyInfo *tourney;
  
  ptVar5 = this->fDefinition;
  iVar4 = (uint)ptVar5->fTiers[this->fTier].fTournOffset + this->fTournament;
  uVar1 = ptVar5->fTournaments[iVar4].fOpponentCarClass;
  pvVar6 = (void *)0x1;
  if (uVar1 != '\n') {
    pvVar6 = (void *)(uint)(carInfo->fCarClass == uVar1);
    pvVar3 = FECheat_IsCheatEnabled(cheat_FinishedTournament);
    if ((pvVar3 != (void *)0x0) && (this->fTier == 0)) {
      pvVar6 = (void *)0x1;
    }
  }
  if ((ptVar5->fTournaments[iVar4].fRequiredFlags & 4) == 0) {
    return pvVar6;
  }
  if ((int)carInfo->fCarID == (uint)ptVar5->fTournaments[iVar4].fRequiredCar) {
    bVar2 = ptVar5->fTournaments[iVar4].fRequiredUpgrades;
    if (bVar2 == 1) {
      return pvVar6;
    }
    if (bVar2 < 2) {
      if (bVar2 != 0) {
        return pvVar6;
      }
      if (carInfo->fUpgrades == '\0') {
        return pvVar6;
      }
      return (void *)0x0;
    }
    if (bVar2 == 2) {
      if (carInfo->fUpgrades != '\0') {
        return pvVar6;
      }
      return (void *)0x0;
    }
    if (bVar2 != 3) {
      return pvVar6;
    }
    bVar2 = ptVar5->fTournaments[iVar4].fSpecificUpgrades;
    if ((carInfo->fUpgrades & bVar2) == bVar2) {
      return pvVar6;
    }
  }
  return (void *)0x0;
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
  ushort uVar1;
  tTierInfo *currentTier;
  byte result;
  int iVar2;
  void *pvVar3;
  tTournamentDefinition *ptVar4;
  tTourneyInfo *currentTourn;
  short trackOffset;
  tTournamentManager *ptVar5;
  short numTracks;
  char *data;
  char filename [80];
  char *input;
  
  ptVar5 = this->fTournamentManager;
  ptVar4 = ptVar5->fDefinition;
  iVar2 = (uint)ptVar4->fTiers[(byte)frontEnd.tier].fTournOffset + (uint)(byte)tourn;
  uVar1 = ptVar4->fTournaments[iVar2].fRequiredFlags;
  pvVar3 = (void *)0x1;
  if ((uVar1 & 1) != 0) {
    pvVar3 = (void *)(uint)(ptVar5->fBestPlacement
                            [ptVar4->fTournaments[iVar2].fRequiredTournamentID] < '\x04');
  }
  if (((uVar1 & 2) != 0) &&
     ('\x01' < ptVar5->fBestPlacement[ptVar4->fTournaments[iVar2].fRequiredTournamentID])) {
    pvVar3 = (void *)0x0;
  }
  return pvVar3;
}



/* end of fetourn.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
int _i;
