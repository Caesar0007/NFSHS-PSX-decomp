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
  blockmove(ptVar1->fTracks +
             (uint)ptVar1->fTournaments
                   [(uint)ptVar1->fTiers[this->fTier].fTournOffset + this->fTournament].fTrackOffset
             + this->fCurrentTrack,track,0x28);
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
      if ((ushort)((ushort)carInfo.fUpgrades & (ushort)(1 << (uVar1 & 0x1f))) != 0) {
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

void tTournamentManager::UpdateTrackFinishPoints()

{
  short sVar1;
  int *piVar2;
  tTournamentManager *ptVar3;
  int iVar4;
  int i;
  int iVar5;
  short k;
  short sVar6;
  short numCompetitors;
  Car_tStats *dummyCars;
  Car_tStats *pCVar7;
  
  sVar1 = this->GetNumCompetitors();
  sVar6 = 0;
  i = this->fTier;
  pCVar7 = Cars_gNewCarStatsList;
  if (this->fDefinition->fTournaments
      [(uint)this->fDefinition->fTiers[i].fTournOffset + this->fTournament].fKnockout == '\0') {
    iVar5 = 0;
    ptVar3 = this;
    if (0 < sVar1) {
      do {
        if ((pCVar7->finalPosition - 1U < 6) && (pCVar7->finalFinishType == 2)) {
          ptVar3->fCompetitors[0].fPoints =
               ptVar3->fCompetitors[0].fPoints +
               (ushort)this->fFinishPoints[pCVar7->finalPosition + -1];
        }
        iVar5 = iVar5 + 1;
        pCVar7 = pCVar7 + 1;
        ptVar3 = (tTournamentManager *)&ptVar3->fNumRacers;
      } while (iVar5 < sVar1);
    }
    iVar5 = 5;
    piVar2 = (int *)((int)&this->fTier + 1);
    do {
      *(uchar *)((int)piVar2 + 0x237) = (uchar)iVar5;
      iVar5 = iVar5 + -1;
      piVar2 = (int *)((int)piVar2 + -1);
    } while (-1 < iVar5);
    qsort(this->fRanking,(int)sVar1,1,
               tournPointsCompare);
    ptVar3 = this;
    iVar5 = 0;
    do {
      iVar4 = iVar5 + 1;
      this->fCompetitors[ptVar3->fRanking[0]].fPosition = (uchar)iVar4;
      ptVar3 = (tTournamentManager *)((int)this->fTierList + iVar5 + -0x1b);
      iVar5 = iVar4;
    } while (iVar4 < 6);
  }
  else {
    iVar5 = 0;
    ptVar3 = this;
    if (0 < sVar1) {
      do {
        if (ptVar3->fCompetitors[0].fEliminated == 0) {
          if ((Cars_gNewCarStatsList[sVar6].finalPosition - 1U < 6) &&
             (Cars_gNewCarStatsList[sVar6].finalFinishType == 2)) {
            if (Cars_gNewCarStatsList[sVar6].finalPosition < this->fNumRacers) {
              ptVar3->fCompetitors[0].fPoints = ptVar3->fCompetitors[0].fPoints + 1;
            }
            else {
              ptVar3->fCompetitors[0].fEliminated = 1;
            }
            ptVar3->fCompetitors[0].fPosition = (uchar)Cars_gNewCarStatsList[sVar6].finalPosition;
          }
          sVar6 = sVar6 + 1;
        }
        iVar5 = iVar5 + 1;
        ptVar3 = (tTournamentManager *)&ptVar3->fNumRacers;
      } while (iVar5 < sVar1);
    }
    this->fNumRacers = this->fNumRacers + -1;
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
  int openClassAdjust[6][7];
  int *piVar1;
  int *piVar2;
  int *piVar3;
  long lVar4;
  int *piVar5;
  tTournamentDefinition *ptVar6;
  long carPrice;
  int iVar7;
  int iVar8;
  int iVar9;
  long result;
  int iVar10;
  tTourneyInfo *currentTourney;
  tCarInfo carInfo;
  int aiStack_c0 [42];
  
  iVar10 = 0;
  piVar1 = (int *)gTrackFinishPrizes;
  piVar2 = aiStack_c0;
  do {
    piVar5 = piVar2;
    piVar3 = piVar1;
    iVar7 = piVar3[1];
    iVar8 = piVar3[2];
    iVar9 = piVar3[3];
    *piVar5 = *piVar3;
    piVar5[1] = iVar7;
    piVar5[2] = iVar8;
    piVar5[3] = iVar9;
    piVar1 = piVar3 + 4;
    piVar2 = piVar5 + 4;
  } while (piVar3 + 4 != gTrackFinishPrizes + 0x28);
  iVar7 = piVar3[5];
  piVar5[4] = gTrackFinishPrizes[0x28];
  piVar5[5] = iVar7;
  lVar4 = 0;
  if ((ushort)position < 6) {
    ptVar6 = this->fDefinition;
    iVar7 = (uint)ptVar6->fTiers[this->fTier].fTournOffset + this->fTournament;
    if ((ptVar6->fTournaments[iVar7].fOpponentCarClass == '\n') &&
       (GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0),
       carInfo.fCarClass < 7)) {
      if ((carInfo.fUpgrades & 1) != 0) {
        carInfo.fPrices[0] = carInfo.fPrices[0] + carInfo.fPrices[1];
      }
      if ((carInfo.fUpgrades & 2) != 0) {
        carInfo.fPrices[0] = carInfo.fPrices[0] + carInfo.fPrices[2];
      }
      if ((carInfo.fUpgrades & 4) != 0) {
        carInfo.fPrices[0] = carInfo.fPrices[0] + carInfo.fPrices[3];
      }
      iVar10 = fixedmult(*(int *)((int)aiStack_c0 +
                                  ((int)((uint)(ushort)position << 0x10) >> 0xe) +
                                  (uint)carInfo.fCarClass * 0x18),carInfo.fPrices[0]);
    }
    lVar4 = iVar10 + *(int *)((int)this->fDefinition->fTracks
                                   [(uint)ptVar6->fTournaments[iVar7].fTrackOffset +
                                    this->fCurrentTrack].fPrize +
                             ((int)((uint)(ushort)position << 0x10) >> 0xe));
  }
  return lVar4;
}



/* ---- tTournamentManager::GetTournamentFinishPrize  [FETOURN.CPP:897-905] ---- */
long tTournamentManager::GetTournamentFinishPrize(short position)
{
  tTournamentDefinition *def;

  if (5 < (ushort)position) {
    return 0;
  }
  def = this->fDefinition;
  return def->fTournaments[def->fTiers[this->fTier].fTournOffset + this->fTournament].fPrize[position];
}

/* ---- tTournamentManager::GetAwardInformation  [FETOURN.CPP:913-914] ---- */

void tTournamentManager::GetAwardInformation(tAwardInformation &info_r)

{
  tAwardInformation *info = &info_r;   /* R-ref param; alias keeps body codegen-identical */
  int *src_walk;
  long tourn_money;
  uint flags_pack;
  int activate_class;
  short tu1;
  byte tc2;
  byte tu3;
  
  src_walk = (int *)&(this->fAwards).fMoney;
  do {
    tourn_money = src_walk[1];
    flags_pack = src_walk[2];
    activate_class = src_walk[3];
    info->fMoney = *src_walk;
    info->fTournMoney = tourn_money;
    info->fActivateFlags = (short)flags_pack;
    info->fActivateTrack = (char)(flags_pack >> 0x10);
    *((char*)info + 0xb) = (char)(flags_pack >> 0x18);
    info->fActivateCarClass = activate_class;
    src_walk = src_walk + 4;
    info = (tAwardInformation *)&info->fActivateCar;
  } while (src_walk != &(this->fAwards).fCompletedBonusMoney);
  *(int *)info = *src_walk;
  return;
}



/* ---- tTournamentManager::UpdateAwardInformation  [FETOURN.CPP:920-949] ---- */

void tTournamentManager::UpdateAwardInformation()

{
  ushort uVar1;
  int iVar2;
  tCarInfo *ptVar3;
  int iVar4;
  long bill;
  long bonus;
  
  this->CalcTrackFinishDamageBill(true,bill,bonus);   /* now takes long& */
  iVar2 = this->fMoney - bill;
  this->fMoney = iVar2;
  iVar4 = (this->fAwards).fMoney;
  iVar2 = iVar2 + bonus;
  this->fMoney = iVar2;
  iVar2 = iVar2 + iVar4;
  iVar4 = (this->fAwards).fTournMoney;
  uVar1 = (this->fAwards).fActivateFlags;
  this->fMoney = iVar2;
  this->fMoney = iVar2 + iVar4;
  if ((uVar1 & 2) != 0) {
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
               (short)ptVar3->fColorOrder[(byte)(this->fAwards).fAwardCarColor],0);
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
  char cVar1;
  uint uVar2;
  int showplace;
  int iVar3;
  char trophySizeLetter [3];
  char trophyPlacementLetter [4];
  void *tp1;
  
  trophySizeLetter[0] = gFEData_80011658;
  trophySizeLetter[1] = gFEData_80011659;
  trophySizeLetter[2] = gFEData_8001165a;
  cVar1 = tournamentManager.fBestPlacement[tourn->fTournamentID];
  tp1 = trophyPlacementLetter + 3;
  uVar2 = (uint)tp1 & 3;
  *(uint *)((int)tp1 - uVar2) =
       *(uint *)((int)tp1 - uVar2) & -1 << (uVar2 + 1) * 8 | (uint)gFEData_8001165c >> (3 - uVar2) * 8;
  *(int *)trophyPlacementLetter = gFEData_8001165c;
  if (place == -1) {
    iVar3 = 0;
    if ((int)cVar1 - 1U < 3) {
      iVar3 = (int)cVar1;
    }
    place = (int)(short)iVar3;
  }
  sprintf(buffer,"TR%c%02d%c",(uint)(byte)trophySizeLetter[size],(uint)tourn->fTrophyID,
             (uint)(byte)trophyPlacementLetter[place]);
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
  : _base_tListIterator((short *)0x0, valPtr)
{

  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorTournament_vtable;
  this->fTournamentManager = tournManager;
  return;
}



/* ---- tListIteratorTournament::dtor  [FETOURN.CPP:1115-1115] ---- */

tListIteratorTournament::~tListIteratorTournament()

{
  (this->_base_tListIterator)._vf = (__vtbl_ptr_type (*)[6])tListIteratorTournament_vtable;
  tListIterator_dtor(&this->_base_tListIterator);
  return;
}



/* ---- tListIteratorTournament::Value  [FETOURN.CPP:1119-1120] ---- */

int tListIteratorTournament::Value(tPlayer arg1)

{
  return (uint)(byte)*(this->_base_tListIterator).fValue;
}



/* ---- tListIteratorTournament::TextValue  [FETOURN.CPP:1124-1130] ---- */

int tListIteratorTournament::TextValue(tPlayer player_id)

{
  short tournIndex;
  tTournamentDefinition *ptVar1;

  ptVar1 = this->fTournamentManager->fDefinition;
  return (signed char)ptVar1->fTournaments
         [(uint)(byte)*(this->_base_tListIterator).fValue +
          (uint)ptVar1->fTiers[(byte)frontEnd.tier].fTournOffset].fTournamentID + 0x341;
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
    pcVar4 = (this->_base_tListIterator).fValue;
    *pcVar4 = *pcVar4 + '\x01';
    pbVar5 = (byte *)(this->_base_tListIterator).fValue;
    if (ptVar3->fTiers[uVar2].fNumTournaments <= *pbVar5) {
      *pbVar5 = 0;
    }
    iVar1 = (int)this->ValidTournament(*(this->_base_tListIterator).fValue) ^ 1;
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
    puVar5 = (uchar *)(this->_base_tListIterator).fValue;
    uVar1 = *puVar5;
    if (uVar1 == '\0') {
      uVar1 = ptVar4->fTiers[uVar3].fNumTournaments;
    }
    *puVar5 = uVar1 - 1;
    iVar2 = (int)this->ValidTournament(*(this->_base_tListIterator).fValue) ^ 1;
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
