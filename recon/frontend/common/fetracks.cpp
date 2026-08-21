/* frontend/common/fetracks.cpp -- RECONSTRUCTED (track manager + track iterator; C++ TU)
 *   15 fns: tTrackManager (Initialize/Load+SaveTracks/GetTrack/Load+ReleaseDescription/
 *   Set{Track,Class}Available/GetTrackByID) + tListIteratorTrack : tListIteratorIndexed
 *   (ctor/dtor/TextValue/Increment/Decrement/ValidTrack) + EXT data tables.
 */
#include "fetracks.h"

/* FETracks.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) */
short        CountryMeasurement[8] = { 0, 1, 0, 1, 1, 0, 1, 1 };   /* @0x80051610 */
int          tracks_maxTrackIndex;   /* @0x80051620  (bss(zero)) */


/* ---- tTrackManager::Initialize  [FETRACKS.CPP:29-39] SLD-VERIFIED ---- */

void tTrackManager::Initialize()

{
  short i;
  
  i = 0;
  this->fNumTracks = 0;
  this->fTracks = (tTrackInformation *)0x0;
  do {
    this->fAvailableTracks[i] = 0;
    this->fViewableTracks[i] = 0;
    i = i + 1;
  } while (i < 0x10);
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
  u_long i;

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
  
  sprintf(filename,"%s%s",Paths_Paths[0x25],"fetrk.trk");
  this->ReleaseDescription();
  addr = (u_long *)loadfileadr(filename,0x10);
  uVar1 = *addr;
  this->fNumTracks = uVar1;
  dst = (tTrackInformation *)reservememadr("Track List",uVar1 * 0x30,0);
  this->fTracks = dst;
  blockmove(addr + 1,dst,this->fNumTracks * 0x30);
  uVar4 = 0;
  if (this->fNumTracks != 0) {
    bool one = true;
    iVar3 = 0;
    do {
      pcVar2 = (char *)(iVar3 + (int)this->fTracks);
      if (pcVar2[3] != '\0') {
        this->fAvailableTracks[*(signed char *)pcVar2] = one;
      }
      pcVar2 = (char *)(iVar3 + (int)this->fTracks);
      if (pcVar2[4] == '\0') {
        this->fViewableTracks[*(signed char *)pcVar2] = one;
      }
      iVar3 = iVar3 + 0x30;
      uVar4 = uVar4 + 1;
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
  /* MATCH: the source-level array-index loop lets GCC strength-reduce the
     48-byte record stride while retaining `i` in its SLD register ($a3).
     The track id is explicitly signed because this build defaults plain
     char to unsigned, while retail uses `lb` for the availability index. */
  u_long i;
  
  for (i = 0; i < this->fNumTracks; i++) {
    if (this->fTracks[i].fTrackDifficulty == trackClass) {
      this->fAvailableTracks[(signed char)this->fTracks[i].fTrackID] = avail;
    }
  }
  return;
}



/* ---- tTrackManager::GetTrackByID  [FETRACKS.CPP:198-209] SLD-VERIFIED ---- */

tTrackInformation * tTrackManager::GetTrackByID(short track)

{
  u_long i;
  
  for (i = 0; i < this->fNumTracks; i = i + 1) {
    if ((int)(signed char)this->fTracks[i].fTrackID == (int)track) {
      return &this->fTracks[i];
    }
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
/* SYM-CONFORM: the retail block names exactly `tTrackInformation *trackInfo`
   and native C++ `bool result`.  CC1PLPSX represents bool as four bytes; the
   BOOL spelling in dumpsym is the compiler's boolean base type, not the
   reconstruction's `typedef int BOOL`. */

bool tListIteratorTrack::ValidTrack(char track)

{
  tTrackInformation *trackInfo;
  bool result;
  
  trackInfo = this->fTrackManager->fTracks + (u_char)track;
  result = this->fTrackManager->fAvailableTracks[(signed char)trackInfo->fTrackID];
  switch (frontEnd.raceType) {
  case 0:
    result = (result | this->fTrackManager->fViewableTracks[(signed char)trackInfo->fTrackID]) != 0;
    break;
  case 1:
    result = (result | this->fTrackManager->fViewableTracks[(signed char)trackInfo->fTrackID]) != 0;
    if (trackInfo->fIsEgg != '\0') {
      result = 0;
    }
    if (2 < trackInfo->fTrackDifficulty) {
      result = 0;
    }
    break;
  }
  return result;
}



/* end of fetracks.cpp */
