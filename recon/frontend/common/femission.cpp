/* frontend/common/femission.cpp -- RECONSTRUCTED (academy/mission manager; C++ TU)
 *   standalone class tMissionManager ; 5 methods. LoadDescription phantom (loadfileadr return
 *   lost to sprintf) resolved via m2c oracle.
 */
#include "femission.h"


/* ---- tMissionManager::Initialize  [FEMISSION.CPP:59-72] ---- */
void tMissionManager::Initialize()

{
  this->fNumTiers = '\0';
  this->fDefinition = (tAcademyDefinition *)0x0;
  frontEnd.policeTier = '\0';
  frontEnd.policeMission = '\0';
  return;
}



/* ---- tMissionManager::LoadDescription  [FEMISSION.CPP:79-133] ---- */
/* SYM 8c @0x8003407c: 4 REG locals data(s1) input(s2) numMissions(s5 ULONG)
   numStages(s3 ULONG) + filename AUTO; mask $803f0000 = 6 saved regs (s0/s4 are
   the blockmove address temps).  W56-A10: numMissions/numStages typed ULONG per
   SYM; ptVar2 Ghidra temp inlined (count unchanged).  RESIDUAL (24, count-exact
   79/79): pure global-allocator priority rotation -- numMissions wants $s5 (lowest
   priority s-reg) but ours hands it $s0, cascading input/base regs.  §4.6
   local-alloc/global-QTY class: de-prioritized until the qtytrace lane exists. */
void tMissionManager::LoadDescription(bool LoadHotPursuit)

{
  byte bVar1;
  char *data;
  char *input;
  unsigned long numStages;
  unsigned long numMissions;
  char filename [80];

  sprintf(filename,"%s%s",Paths_Paths[0x25],
          frontEnd.gameMode != '\x01' ? "zHPurs.mis" : "zHPurs2.mis");
  data = (char *)loadfileadr(filename,0x10);
  this->fNumTiers = *data;
  numMissions = *(unsigned long *)(data + 4);
  numStages = *(unsigned long *)(data + 8);
  input = data + 0xc;
  if (this->fDefinition == (tAcademyDefinition *)0x0) {
    this->fDefinition = (tAcademyDefinition *)reservememadr("Missions",0x3120,0);
  }
  blockmove(input,this->fDefinition,(uint)(byte)this->fNumTiers << 2);
  bVar1 = this->fNumTiers;
  blockmove(input + (uint)bVar1 * 4,this->fDefinition->fMissions,numMissions * 0x14);
  blockmove(input + (uint)bVar1 * 4 + numMissions * 0x14,this->fDefinition->fStages,numStages * 0x2c);
  purgememadr(data);
  return;
}



/* ---- tMissionManager::ReleaseDescription  [FEMISSION.CPP:139-143] ---- */
void tMissionManager::ReleaseDescription()

{
  
  if (this->fDefinition != (tAcademyDefinition *)0x0) {
    purgememadr(this->fDefinition);
    this->fDefinition = (tAcademyDefinition *)0x0;
  }
  return;
}



/* ---- tMissionManager::GetMissionStages  [FEMISSION.CPP:172-178] ---- */
short tMissionManager::GetMissionStages(short tier,short mission,tStageInfo **pStages)

{
  int iVar1;
  tMissionInfo *pMission;
  tAcademyDefinition *ptVar2;

  ptVar2 = this->fDefinition;
  iVar1 = (uint)ptVar2->fTiers[tier].fMissionOffset + (int)mission;
  pMission = &ptVar2->fMissions[iVar1];
  *pStages = ptVar2->fStages + pMission->fStageOffset;
  return (short)pMission->fNumStages;
}



/* ---- tMissionManager::GetMissionToRace  [FEMISSION.CPP:186] ---- */
void tMissionManager::GetMissionToRace(tMissionInfo **mission)

{
  tMissionTierInfo *currentTier;
  uint numStages;
  uint numMissions;
  
  *mission = &this->fDefinition->fMissions[
               (uint)this->fDefinition->fTiers[(byte)frontEnd.policeTier].fMissionOffset +
               (uint)(byte)frontEnd.policeMission];
  return;
}



/* end of femission.cpp */
