/* game/common/aidatarecord.cpp -- RECONSTRUCTED (AIDataRecord_t collection + 4 record classes).
 *   AccTable / CurveSpeedTable / TrackCurve / BestLine record tables over a shared
 *   AIDataRecord_t base (real inheritance, real C++ virtuals since 2026-09-19).
 *   21 explicit definitions +5 generated dtors; SYM attributes CarTracking::Get and those dtors to AIDATARECORD.H.
 *   NOT original source; SYM-faithful, recompilable C++.  vs disasm-v4.txt.
 */
#include "aidatarecord_types.h"
#include "aidatarecord_externs.h"

/* Retail aidatarecord.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- aidatarecord.obj-owned globals (.bss zero) ---- */
AIDataRecord_BestLine_t *AIDataRecord_BestLine;   /* @0x8013c5a0 */
AIDataRecord_TrackCurve_t *AIDataRecord_TrackCurve;   /* @0x8013c5a4 */
AIDataRecord_WhichRecord_t AIDataRecord_WhichRecord;   /* @0x8013c5a8 */
AIDataRecord_RecordMethod_t AIDataRecord_RecordMethod;   /* @0x8013c5ac */
static AIDataRecord_t *recordCollection[24];   /* @0x8013df64; SYM STAT */


/* ---- __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc  AIDataRecord_t::ctor ---- */
#line 31 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_t::AIDataRecord_t(AIDataRecord_WhichRecord_t whichIsThis,char *preBuffer)
{
  this->AddRecordToCollection();
  this->preAllocatedBuffer_ = preBuffer;
  this->recordMethod_ = 0;
  return;
}

/* ---- ___14AIDataRecord_t  AIDataRecord_t::dtor ---- */
#line 62 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_t::~AIDataRecord_t()
{

  this->SaveAndPurge();
  this->RemoveRecordFromCollection();
}

/* ---- AddRecordToCollection__14AIDataRecord_t ---- */
#line 76 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_t::AddRecordToCollection()
{
  for (int recordLoop = 0; recordLoop < 0x18; recordLoop++) {

    if (recordCollection[recordLoop] == (AIDataRecord_t *)0x0) {

      recordCollection[recordLoop] = this;
      return 1;
    }
  }

  return 0;
}

/* ---- RemoveRecordFromCollection__14AIDataRecord_t ---- */
#line 90 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_t::RemoveRecordFromCollection()
{
  for (int recordLoop = 0; recordLoop < 0x18; recordLoop++) {

    if (recordCollection[recordLoop] == this) {

      recordCollection[recordLoop] = (AIDataRecord_t *)0x0;
      return 1;
    }
  }
  return 0;
}

/* ---- StartUp1__14AIDataRecord_t ---- */
#line 103 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_t::StartUp1(void)
{

  AIDataRecord_WhichRecord = NORECORD_R;
  AIDataRecord_RecordMethod = NORMAL_M;
  for (int recordLoop = 0x17; recordLoop >= 0; recordLoop--) {
    recordCollection[recordLoop] = (AIDataRecord_t *)0x0;
  }
  AIDataRecord_BestLine = new AIDataRecord_BestLine_t((AIDataRecord_WhichRecord_t)5);
  AIDataRecord_TrackCurve = new AIDataRecord_TrackCurve_t((AIDataRecord_WhichRecord_t)6);
  return;
}

/* ---- StartUp2__14AIDataRecord_t ---- */
#line 138 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_t::StartUp2(void)
{

  for (int recordLoop = 0; recordLoop < 0x18; recordLoop++) {
    if (recordCollection[recordLoop] != (AIDataRecord_t *)0x0) {
      recordCollection[recordLoop]->Setup();
    }
  }
  return;
}

/* ---- CleanUp1__14AIDataRecord_t COVERED-SLD-PASS ---- */
#line 151 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_t::CleanUp1(void)
{
  if (AIDataRecord_BestLine != (AIDataRecord_BestLine_t *)0x0)
  {
    delete AIDataRecord_BestLine;
    AIDataRecord_BestLine = (AIDataRecord_BestLine_t *)0x0;
  }
  if (AIDataRecord_TrackCurve != (AIDataRecord_TrackCurve_t *)0x0)
  {
    delete AIDataRecord_TrackCurve;
    AIDataRecord_TrackCurve = (AIDataRecord_TrackCurve_t *)0x0;
  }
}

/* ---- CleanUp2__14AIDataRecord_t ---- */
#line 165 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_t::CleanUp2(void)
{
  return;
}

/* ---- Setup__14AIDataRecord_t ---- */
#line 169 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_t::Setup()
{
  if (this->preAllocatedBuffer_ != (char *)0x0) {
    this->dataBuffer_ = this->PreAllocatedBuffer();
  } else if (this->Load() == 0) {
    this->SetDataBuffer((char *)reservememadr(this->Name(),this->BufferSize(),0));
  }
}

/* ---- Load__14AIDataRecord_t ---- */
#line 224 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_t::Load()
{
  if (this->RecordMethod() == NORMAL_M) {
    this->SetDataBuffer((char *)loadpackadrz(this->Name(),(void *)0x0));
  }
  if (this->DataBuffer() != (char *)0x0) {
    return 1;
  }
  return 0;
}

/* ---- SaveAndPurge__14AIDataRecord_t ---- */
#line 242 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_t::SaveAndPurge()
{
  if (this->DataBuffer() != (char *)0x0) {
    if (this->preAllocatedBuffer_ == (char *)0x0) {
      purgememadr(this->DataBuffer());
    }
    this->SetDataBuffer((char *)0x0);
    return 1;
  }
  return 0;
}

/* ---- __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t  AccTable::ctor ---- */
#line 392 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_AccTable_t::AIDataRecord_AccTable_t(char *preBuffer,int scale,
          AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,preBuffer)
{
  this->numElements_ = 0x70;
  this->bSize_ = 0xe0;
  this->scale_ = scale;
  sprintf(this->name_,"%s%s.acc",Paths_Paths[5],
          (char *)Cars_gHumanRaceCarList[0] + 0x240);
  return;
}

/* ---- Get__23AIDataRecord_AccTable_ti ---- */
#line 402 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_AccTable_t::Get(int speed)
{
  return (int)*(short *)(this->dataBuffer_ + speed * 2) << 8;
}

/* ---- Setup__23AIDataRecord_AccTable_t COVERED-SLD-PASS ----
 * One mutable table value preserves27 words,all supplied owners and full covered SLD.
 * SOURCE-REVIEW-UNRESOLVED: the remaining tableAcceleration identity/name is not in SYM.
 * Two readonly captures were not required;original declaration/producer text stays open.
 * Receipts:build/nc12/acc_20261026/. */
#line 407 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_AccTable_t::Setup()
{
  this->AIDataRecord_t::Setup();
  for (int loop = 0; loop < 0x70; loop++) {


    int tableAcceleration = this->Get(loop);

    tableAcceleration = fixedmult(tableAcceleration,this->scale_);

    *(short *)(this->dataBuffer_ + loop * 2) = (short)(tableAcceleration >> 8);
  }
}

/* ---- __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t  BestLine::ctor ---- */
#line 456 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_BestLine_t::AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  this->bSize_ = this->numElements_ = gNumSlices;
  if (this->RecordMethod() == NORMAL_M) {
    sprintf(this->name_,"%sTr%02d.qbe",
            Paths_Paths[12],GameSetup_gData.track);
  } else {
    sprintf(this->name_,"%sTr%02d.bes",Paths_Paths[13],GameSetup_gData.track);
  }
}

/* ---- __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t  TrackCurve::ctor ---- */
#line 534 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_TrackCurve_t::AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  this->bSize_ = (this->numElements_ = gNumSlices) + 1;
  if (this->RecordMethod() == NORMAL_M) {
    sprintf(this->name_,"%sTr%02d.qcr",
            Paths_Paths[10],GameSetup_gData.track);
  } else {
    sprintf(this->name_,"%sTr%02d.crv",Paths_Paths[11],GameSetup_gData.track);
  }
}

/* ---- Get__25AIDataRecord_TrackCurve_ti ---- */
#line 545 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_TrackCurve_t::Get(int slice)
{
  return (u_int)(u_char)this->dataBuffer_[slice];
}

/* ---- __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t  CurveSpeedTable::ctor ---- */
#line 615 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
AIDataRecord_CurveSpeedTable_t::AIDataRecord_CurveSpeedTable_t(char *carName,
          AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  this->numElements_ = 0x100;
  this->bSize_ = 0x100;
  if (this->RecordMethod() == NORMAL_M) {
    sprintf(this->name_,"%s%s.qcs",Paths_Paths[4],carName);
  }
  else {
    sprintf(this->name_,"%s%s.csp",Paths_Paths[5],carName);
    /* retail keeps an UNREFERENCED "%sTr%02d%c.ctk" (0x8005541C) after ".csp": a compiled-out record kind */
    if (0) sprintf((char *)0,"%sTr%02d%c.ctk");
  }
  return;
}

/* ---- Get__30AIDataRecord_CurveSpeedTable_ti ---- */
#line 628 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
int AIDataRecord_CurveSpeedTable_t::Get(int curve)
{

  if (curve < 0)
    curve = -curve;
  if (0xff < curve) {
    curve = 0xff;
  }
  return (u_int)(u_char)this->dataBuffer_[curve] << 0x10;
}

/* ---- Upgrade__30AIDataRecord_CurveSpeedTable_ti ---- */
#line 679 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
void AIDataRecord_CurveSpeedTable_t::Upgrade(int handlingUpgrade)
{
  for (int curveLoop = 0; curveLoop < this->NumElements(); curveLoop++) {
    this->dataBuffer_[curveLoop] =
        fixedmult(this->Get(curveLoop), handlingUpgrade) / 0x10000;
  }
}

/* ---- Get__26AIDataRecord_CarTracking_ti  [@0x8006d50c] COVERED-SLD-PASS ---- */
/* Always0. SYM attributes this definition to AIDATARECORD.H; physical header placement/key-function emission remains unproved. */
#line 190 "C:/nfs4/GAME/COMMON/AIDATARECORD.H"
int AIDataRecord_CarTracking_t::Get(int slice)
{

  return 0;
}

/* The object ends with the five compiler-SYNTHESIZED derived destructors (0x8006D514..0x8006D5B4, the deferred-inline
 * batch, reverse class order) -- they have no source. */

/* end of aidatarecord.cpp */

/* The three deferred destructor end records constrain the terminal context to765.
 * At EOF the selected compiler uses the preceding logical line;no executable work
 * or generated debug record is rewritten. Original literal footer text is unproved. */
#line 766 "C:/nfs4/GAME/COMMON/AIDATARECORD.CPP"
