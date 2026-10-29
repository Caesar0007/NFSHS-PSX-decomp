/* frontend/common/femission.cpp -- RECONSTRUCTED (academy/mission manager; C++ TU)
 *   standalone class tMissionManager ; 5 methods. LoadDescription phantom (loadfileadr return
 *   lost to sprintf) resolved via m2c oracle.
 */
#include "femission.h"

/* 2026-10-29: retail-derived per-function anchors and ordinary statement
 * layout restore all144 instruction/file tags,provided local owners,ten
 * block records,headers/frames and ends for all five mission methods.
 * Actual frontend overlay G0 recipe and whole ELF/native CPE are unchanged.
 * No source object,qualifier,asm,volatile,scope device or output rewrite.
 * Original macro/comment text is not uniquely proved by coordinate equality.
 * Receipt:build/nc12/femission_anchors_20261029/final-proof.json. */



/* ---- tMissionManager::Initialize  [FEMISSION.CPP:59-72] ---- */
#line 57 "C:/nfs4/FRONTEND/COMMON/FEMISSION.CPP"
void tMissionManager::Initialize()

{


  this->fNumTiers = '\0';
  this->fDefinition = (tAcademyDefinition *)0x0;







  frontEnd.policeTier = '\0';
  frontEnd.policeMission = '\0'; return;
}



/* ---- tMissionManager::LoadDescription  [FEMISSION.CPP:79-133] ---- */
/* SYM 8c @0x8003407c: 4 REG locals input(s2) data(s1) numMissions(s5 ULONG)
   numStages(s3 ULONG) + filename AUTO; mask $803f0000 = 6 saved regs (s0/s4 are
   the blockmove address temps).  MATCH: 79/79.  The retail source advances the
   named data pointer after the tier and mission copies; spelling the later
   sources as repeated expressions introduced an unlisted byte temporary and
   rotated the saved-register allocation (24 diffs). */
#line 77 "C:/nfs4/FRONTEND/COMMON/FEMISSION.CPP"
void tMissionManager::LoadDescription(bool LoadHotPursuit)

{
  char *input; char *data; unsigned long numMissions; unsigned long numStages; char filename[80];




  sprintf(filename,"%s%s",Paths_Paths[0x25],frontEnd.gameMode != '\x01' ? "zHPurs.mis" : "zHPurs2.mis");

  input = (char *)loadfileadr(filename,0x10);


  this->fNumTiers = *input;

  numMissions = *(unsigned long *)(input + 4);

  numStages = *(unsigned long *)(input + 8);



  data = input + 0xc; if (this->fDefinition == (tAcademyDefinition *)0x0) {
    this->fDefinition = (tAcademyDefinition *)reservememadr("Missions",0x3120,0); }

  blockmove(data,this->fDefinition,(uint)(byte)this->fNumTiers << 2);
  data = data + (uint)(byte)this->fNumTiers * 4;
  blockmove(data,this->fDefinition->fMissions,numMissions * 0x14);
  data = data + numMissions * 0x14;
  blockmove(data,this->fDefinition->fStages,numStages * 0x2c);



























  purgememadr(input); return;
}



/* ---- tMissionManager::ReleaseDescription  [FEMISSION.CPP:139-143] ---- */
#line 137 "C:/nfs4/FRONTEND/COMMON/FEMISSION.CPP"
void tMissionManager::ReleaseDescription()

{
  if (this->fDefinition != (tAcademyDefinition *)0x0) {

    purgememadr(this->fDefinition);
    this->fDefinition = (tAcademyDefinition *)0x0;
  } }



/* ---- tMissionManager::GetMissionStages  [FEMISSION.CPP:172-178] ---- */
/* SYM-CONFORM (2026-08-16, PASS retained): restored the sole retail local,
   `tMissionInfo *pMissionInfo`; gcc recreates the former definition/index
   address temporaries without exposing them as source declarations. */
#line 170 "C:/nfs4/FRONTEND/COMMON/FEMISSION.CPP"
short tMissionManager::GetMissionStages(short tier,short mission,tStageInfo **pStages)

{
  tMissionInfo *pMissionInfo;
  pMissionInfo = &this->fDefinition->fMissions[
      (uint)this->fDefinition->fTiers[tier].fMissionOffset + (int)mission];
  *pStages = this->fDefinition->fStages + pMissionInfo->fStageOffset;

  return (short)pMissionInfo->fNumStages;
}



/* ---- tMissionManager::GetMissionToRace  [FEMISSION.CPP:186] ---- */
#line 184 "C:/nfs4/FRONTEND/COMMON/FEMISSION.CPP"
void tMissionManager::GetMissionToRace(tMissionInfo **mission)

{
  tMissionTierInfo *currentTier = &this->fDefinition->fTiers[(byte)frontEnd.policeTier];
  *mission = &this->fDefinition->fMissions[(uint)currentTier->fMissionOffset + (uint)(byte)frontEnd.policeMission]; }



/* end of femission.cpp */
