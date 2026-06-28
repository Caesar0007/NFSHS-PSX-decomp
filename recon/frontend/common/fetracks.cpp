/* frontend/common/fetracks.cpp -- RECONSTRUCTED (track manager + track iterator; C++ TU)
 *   15 fns: tTrackManager (Initialize/Load+SaveTracks/GetTrack/Load+ReleaseDescription/
 *   Set{Track,Class}Available/GetTrackByID) + tListIteratorTrack : tListIteratorIndexed
 *   (ctor/dtor/TextValue/Increment/Decrement/ValidTrack) + EXT data tables.
 */
#include "fetracks.h"

/* FETracks.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) */
tTrackInformation gTrackInfo_FETrackList = {102, 101u, 116u, 114u, 107u, 46u, 116u, 114u, 107, 107, 0, 0, 0, 0, 0, 0, 7596, -32766, 0, 0, 0, -2147336244};   /* @0x80010fd0 */
tTrackInformation gTrackInfo_Tourney = {116, 111u, 117u, 114u, 110u, 46u, 116u, 114u, 110, 110, 30, 5, 0, 0, 30, 0, 1310, 0, 1310, 0, 0, 1310};   /* @0x8001159c */
short        CountryMeasurement[8] = { 0, 1, 0, 1, 1, 0, 1, 1 };   /* @0x80051610 */
int          tracks_maxTrackIndex;   /* @0x80051620  (bss(zero)) */


/* ---- tTrackManager::Initialize  [FETRACKS.CPP:29-39] SLD-VERIFIED ---- */

void tTrackManager::Initialize()

{
  int iVar1;
  short i;
  int iVar2;
  
  iVar2 = 0;
  this->fNumTracks = 0;
  this->fTracks = (tTrackInformation *)0x0;
  do {
    iVar1 = iVar2 << 0x10;
    iVar2 = iVar2 + 1;
    iVar1 = iVar1 >> 0xe;
    *(u_int *)((int)this->fAvailableTracks + iVar1) = 0;
    *(u_int *)((int)this->fViewableTracks + iVar1) = 0;
  } while (iVar2 * 0x10000 >> 0x10 < 0x10);
  return;
}



/* ---- tTrackManager::LoadTracks  [FETRACKS.CPP:46-59] SLD-VERIFIED ---- */
void tTrackManager::LoadTracks(tSaveTrackInfo &load)
{
  u_long i;

  i = 0;
  do {
    this->fAvailableTracks[i] = (load.fTrackActivated[i] != 0);
    i = i + 1;
  } while (i < 0x10);
  return;
}

/* ---- tTrackManager::SaveTracks  [FETRACKS.CPP:65-77] SLD-VERIFIED ---- */
void tTrackManager::SaveTracks(tSaveTrackInfo &save)
{
  u_int i;

  i = 0;
  do {
    save.fTrackActivated[i] = (u_char)this->fAvailableTracks[i];
    i = i + 1;
  } while (i < 0x10);
  return;
}

/* ---- tTrackManager::GetTrack  [FETRACKS.CPP:84-86] SLD-VERIFIED ---- */

void tTrackManager::GetTrack(short trackNumber,tTrackInformation &trackInfo)

{
  
  blockmove(this->fTracks + trackNumber,&trackInfo,0x30);
  trackInfo.fAvailable = (uchar)this->fAvailableTracks[(signed char)trackInfo.fTrackID];
  return;
}



/* ---- tTrackManager::LoadDescription  [FETRACKS.CPP:94-139] SLD-VERIFIED ---- */

void tTrackManager::LoadDescription()

{
  u_long *addr;
  u_long uVar1;
  tTrackInformation *dst;
  char *pcVar2;
  char *data;
  int iVar3;
  u_long i;
  u_int uVar4;
  char *input;
  char filename [80];
  
  data = filename;
  addr = (u_long *)sprintf(data,"%s%s",Paths_Paths[0x25],"fetrk.trk");
  this->ReleaseDescription();
  loadfileadr(filename,0x10);
  uVar1 = *addr;
  this->fNumTracks = uVar1;
  dst = (tTrackInformation *)reservememadr("Track List",uVar1 * 0x30,0);
  this->fTracks = dst;
  blockmove(addr + 1,dst,this->fNumTracks * 0x30);
  uVar4 = 0;
  if (this->fNumTracks != 0) {
    iVar3 = 0;
    do {
      pcVar2 = this->fTracks->fShapeName + iVar3 + -8;
      if (pcVar2[3] != '\0') {
        this->fAvailableTracks[*pcVar2] = 1;
      }
      pcVar2 = this->fTracks->fShapeName + iVar3 + -8;
      if (pcVar2[4] == '\0') {
        this->fViewableTracks[*pcVar2] = 1;
      }
      uVar4 = uVar4 + 1;
      iVar3 = iVar3 + 0x30;
    } while (uVar4 < this->fNumTracks);
  }
  purgememadr(addr);
  return;
}



/* ---- tTrackManager::ReleaseDescription  [FETRACKS.CPP:145-150] SLD-VERIFIED ---- */

void tTrackManager::ReleaseDescription()

{
  
  if (this->fTracks != (tTrackInformation *)0x0) {
    purgememadr(this->fTracks);
  }
  this->fTracks = (tTrackInformation *)0x0;
  this->fNumTracks = 0;
  return;
}



/* ---- tTrackManager::SetTrackAvailable  [FETRACKS.CPP:157-159] SLD-VERIFIED ---- */

void tTrackManager::SetTrackAvailable(short track,bool avail)

{
  
  this->fAvailableTracks[track] = avail;
  return;
}



/* ---- tTrackManager::SetClassAvailable  [FETRACKS.CPP:172-180] SLD-VERIFIED ---- */

void tTrackManager::SetClassAvailable(tTrackClassType trackClass,bool avail)

{
  char *pcVar1;
  u_int uVar2;
  u_long i;
  int iVar3;
  
  uVar2 = 0;
  if (this->fNumTracks != 0) {
    iVar3 = 0;
    do {
      pcVar1 = this->fTracks->fShapeName + iVar3 + -8;
      if ((u_char)pcVar1[2] == trackClass) {
        this->fAvailableTracks[*pcVar1] = avail;
      }
      uVar2 = uVar2 + 1;
      iVar3 = iVar3 + 0x30;
    } while (uVar2 < this->fNumTracks);
  }
  return;
}



/* ---- tTrackManager::GetTrackByID  [FETRACKS.CPP:198-209] SLD-VERIFIED ---- */

tTrackInformation * tTrackManager::GetTrackByID(short track)

{
  tTrackInformation *ptVar1;
  u_int uVar2;
  u_long i;
  
  uVar2 = 0;
  if (this->fNumTracks != 0) {
    ptVar1 = this->fTracks;
    do {
      uVar2 = uVar2 + 1;
      if ((int)ptVar1->fTrackID == (int)track) {
        return ptVar1;
      }
      ptVar1 = ptVar1 + 1;
    } while (uVar2 < this->fNumTracks);
  }
  return this->fTracks;
}



/* ---- tListIteratorTrack::ctor  [FETRACKS.CPP:233-235] SLD-VERIFIED ---- */
tListIteratorTrack::tListIteratorTrack(char *valPtr,char *index,tTrackManager *trackManager)
  : tListIteratorIndexed((short *)0x0,valPtr,index)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorTrack_vtable;
  this->fTrackManager = trackManager;
  return;
}



/* ---- tListIteratorTrack::dtor  [FETRACKS.CPP:239-239] SLD-VERIFIED ---- */

tListIteratorTrack::~tListIteratorTrack()

{
  *(void **)&(this->_vf) = (void *)tListIteratorTrack_vtable;
  return;
}



/* ---- tListIteratorTrack::TextValue  [FETRACKS.CPP:243-245] SLD-VERIFIED ---- */

short tListIteratorTrack::TextValue(tPlayer atIndex)

{
  tTrackInformation *trackInfo;
  tTrackInformation *trackEntry;
  u_int uVar1;

  trackInfo = (tTrackInformation *)this->fIndex;
  uVar1 = (u_char)this->fValue[(u_char)trackInfo->fTrackID];
  trackEntry = &this->fTrackManager->fTracks[uVar1];
  return (signed char)trackEntry->fTrackID + 0xd5;
}



/* ---- tListIteratorTrack::Increment  [FETRACKS.CPP:249-255] SLD-VERIFIED ---- */

void tListIteratorTrack::Increment(tPlayer atIndex)

{
  int iVar1;
  char *pcVar2;
  u_char *pbVar3;

  do {
    pcVar2 = this->fValue +
             (u_char)*this->fIndex;
    *pcVar2 = *pcVar2 + '\x01';
    pbVar3 = (u_char *)(this->fValue +
                     (u_char)*this->fIndex);
    if (this->fTrackManager->fNumTracks <= (u_int)*pbVar3) {
      *pbVar3 = 0;
    }
    iVar1 = (int)this->ValidTrack(this->fValue
                             [(u_char)*this->fIndex]) ^ 1;
  } while (iVar1 != 0);
  return;
}



/* ---- tListIteratorTrack::Decrement  [FETRACKS.CPP:259-265] SLD-VERIFIED ---- */

void tListIteratorTrack::Decrement(tPlayer atIndex)

{
  char cVar1;
  int iVar2;
  char *pcVar3;

  do {
    pcVar3 = this->fValue +
             (u_char)*this->fIndex;
    cVar1 = *pcVar3;
    if (cVar1 == '\0') {
      cVar1 = (char)this->fTrackManager->fNumTracks;
    }
    *pcVar3 = cVar1 - 1;
    iVar2 = (int)this->ValidTrack(this->fValue
                             [(u_char)*this->fIndex]) ^ 1;
  } while (iVar2 != 0);
  return;
}



/* ---- tListIteratorTrack::ValidTrack  [FETRACKS.CPP:269-288] SLD-VERIFIED ---- */

void * tListIteratorTrack::ValidTrack(char track)

{
  char cVar1;
  tTrackInformation *trackInfo;
  tTrackInformation *ptVar2;
  tTrackManager *ptVar3;
  u_char result;
  void *pvVar4;
  char *input;
  char filename [80];
  
  ptVar3 = this->fTrackManager;
  ptVar2 = ptVar3->fTracks + (u_char)track;
  cVar1 = ptVar2->fTrackID;
  pvVar4 = (void *)ptVar3->fAvailableTracks[cVar1];
  if (frontEnd.raceType == '\0') {
    pvVar4 = (void *)(u_int)(pvVar4 != (void *)0x0 || ptVar3->fViewableTracks[cVar1] != 0);
  }
  else if (frontEnd.raceType == '\x01') {
    pvVar4 = (void *)(u_int)(pvVar4 != (void *)0x0 || ptVar3->fViewableTracks[cVar1] != 0);
    if (ptVar2->fIsEgg != '\0') {
      pvVar4 = (void *)0x0;
    }
    if (2 < ptVar2->fTrackDifficulty) {
      pvVar4 = (void *)0x0;
    }
  }
  return pvVar4;
}



/* end of fetracks.cpp */
