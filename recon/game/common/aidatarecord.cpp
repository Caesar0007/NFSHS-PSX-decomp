/* game/common/aidatarecord.cpp -- RECONSTRUCTED (AIDataRecord_t collection + 4 record classes).
 *   AccTable / CurveSpeedTable / TrackCurve / BestLine record tables over a shared
 *   AIDataRecord_t base (composition-modeled inheritance, manual _vf vtable dispatch).
 *   21 standalone fns; the trivial CarTracking::Get + 5 empty dtors were inlined in EA's build.
 *   NOT original source; SYM-faithful, recompilable C++.  vs disasm-v4.txt.
 */
#include "../../nfs4_types.h"
#include "aidatarecord_externs.h"


/* ---- aidatarecord.obj-owned globals (.bss zero) ---- */
AIDataRecord_BestLine_t *AIDataRecord_BestLine;   /* @0x8013c5a0 */
AIDataRecord_TrackCurve_t *AIDataRecord_TrackCurve;   /* @0x8013c5a4 */
int          AIDataRecord_WhichRecord;   /* @0x8013c5a8 */
int          AIDataRecord_RecordMethod;   /* @0x8013c5ac */
AIDataRecord_t *recordCollection[24];   /* @0x8013df64 */


/* ---- __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc  AIDataRecord_t::ctor ---- */
AIDataRecord_t::AIDataRecord_t(AIDataRecord_WhichRecord_t whichIsThis,char *preBuffer)
{
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_t_vtable;
  this->AddRecordToCollection();
  this->preAllocatedBuffer_ = preBuffer;
  this->recordMethod_ = 0;
  return;
}

/* ---- ___14AIDataRecord_t  AIDataRecord_t::dtor ---- */
AIDataRecord_t::~AIDataRecord_t()
{
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_t_vtable;
  this->SaveAndPurge();
  this->RemoveRecordFromCollection();
  return;
}

/* ---- AddRecordToCollection__14AIDataRecord_t ---- */
int AIDataRecord_t::AddRecordToCollection()
{
  int recordLoop;
  AIDataRecord_t **ppAVar1;
  int iVar2;

  iVar2 = 0;
  ppAVar1 = recordCollection;
  do {
    iVar2 = iVar2 + 1;
    if (*ppAVar1 != (AIDataRecord_t *)0x0) {
      ppAVar1 = ppAVar1 + 1;
      continue;
    }
    *ppAVar1 = this;
    return 1;
  } while (iVar2 < 0x18);
  return 0;
}

/* ---- RemoveRecordFromCollection__14AIDataRecord_t ---- */
int AIDataRecord_t::RemoveRecordFromCollection()
{
  int recordLoop;
  AIDataRecord_t **ppAVar1;
  int iVar2;

  iVar2 = 0;
  ppAVar1 = recordCollection;
  do {
    iVar2 = iVar2 + 1;
    if (*ppAVar1 != this) {
      ppAVar1 = ppAVar1 + 1;
      continue;
    }
    *ppAVar1 = (AIDataRecord_t *)0x0;
    return 1;
  } while (iVar2 < 0x18);
  return 0;
}

/* ---- StartUp1__14AIDataRecord_t ---- */
void AIDataRecord_t::StartUp1(void)
{
  int recordLoop;
  AIDataRecord_t **ppAVar1;
  int iVar2;

  iVar2 = 0x17;
  ppAVar1 = recordCollection + iVar2;
  AIDataRecord_WhichRecord = 0;
  AIDataRecord_RecordMethod = 0;
  do {
    *ppAVar1 = (AIDataRecord_t *)0x0;
    iVar2 = iVar2 + -1;
    ppAVar1 = ppAVar1 + -1;
  } while (-1 < iVar2);
  AIDataRecord_BestLine = new AIDataRecord_BestLine_t((AIDataRecord_WhichRecord_t)5);
  AIDataRecord_TrackCurve = new AIDataRecord_TrackCurve_t((AIDataRecord_WhichRecord_t)6);
  return;
}

/* ---- StartUp2__14AIDataRecord_t ---- */
void AIDataRecord_t::StartUp2(void)
{
  int recordLoop;
  AIDataRecord_t *pAVar1;
  AIDataRecord_t **ppAVar2;
  int iVar3;

  iVar3 = 0;
  ppAVar2 = recordCollection;
  do {
    pAVar1 = *ppAVar2;
    if (pAVar1 != (AIDataRecord_t *)0x0) {
      (*(*pAVar1->_vf)[2].pfn)((char *)pAVar1 + (*pAVar1->_vf)[2].delta);
    }
    iVar3 = iVar3 + 1;
    ppAVar2 = ppAVar2 + 1;
  } while (iVar3 < 0x18);
  return;
}

/* ---- CleanUp1__14AIDataRecord_t ---- */
void AIDataRecord_t::CleanUp1(void)
{
  __vtbl_ptr_type (*pa_Var1) [3];

  if (AIDataRecord_BestLine != (AIDataRecord_BestLine_t *)0x0) {
    pa_Var1 = AIDataRecord_BestLine->_vf;
    (*(*pa_Var1)[1].pfn)((char *)AIDataRecord_BestLine + (*pa_Var1)[1].delta,3);
    AIDataRecord_BestLine = (AIDataRecord_BestLine_t *)0x0;
  }
  if (AIDataRecord_TrackCurve != (AIDataRecord_TrackCurve_t *)0x0) {
    pa_Var1 = AIDataRecord_TrackCurve->_vf;
    (*(*pa_Var1)[1].pfn)((char *)AIDataRecord_TrackCurve + (*pa_Var1)[1].delta,3);
    AIDataRecord_TrackCurve = (AIDataRecord_TrackCurve_t *)0x0;
  }
  return;
}

/* ---- CleanUp2__14AIDataRecord_t ---- */
void AIDataRecord_t::CleanUp2(void)
{
  return;
}

/* ---- Setup__14AIDataRecord_t ---- */
void AIDataRecord_t::Setup()
{
  char *pcVar1;
  int iVar2;

  pcVar1 = this->preAllocatedBuffer_;
  if (pcVar1 != (char *)0x0) {
    this->dataBuffer_ = pcVar1;
    return;
  }
  iVar2 = this->Load();
  if (iVar2 != 0) {
    return;
  }
  this->dataBuffer_ = reservememadr(this->name_,this->bSize_,0);
  return;
}

/* ---- Load__14AIDataRecord_t ---- */
int AIDataRecord_t::Load()
{
  char *pcVar1;

  if (this->recordMethod_ == 0) {
    pcVar1 = (char *)loadpackadrz(this->name_,(void *)0x0);
    this->dataBuffer_ = pcVar1;
  }
  return (u_int)(this->dataBuffer_ != (char *)0x0);
}

/* ---- SaveAndPurge__14AIDataRecord_t ---- */
int AIDataRecord_t::SaveAndPurge()
{
  int iVar1;

  iVar1 = 0;
  if (this->dataBuffer_ != (char *)0x0) {
    if (this->preAllocatedBuffer_ == (char *)0x0) {
      purgememadr(this->dataBuffer_);
    }
    this->dataBuffer_ = (char *)0x0;
    iVar1 = 1;
  }
  return iVar1;
}

/* ---- __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t  AccTable::ctor ---- */
AIDataRecord_AccTable_t::AIDataRecord_AccTable_t(char *preBuffer,int scale,
          AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,preBuffer)
{
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_AccTable_t_vtable;
  this->numElements_ = 0x70;
  this->bSize_ = 0xe0;
  this->scale_ = scale;
  sprintf(this->name_,D_800553B8,D_8011647C[0],
          (char *)Cars_gHumanRaceCarList[0] + 0x240);
  return;
}

/* ---- Get__23AIDataRecord_AccTable_ti ---- */
int AIDataRecord_AccTable_t::Get(int speed)
{
  return (int)*(short *)(this->dataBuffer_ + speed * 2) << 8;
}

/* ---- Setup__23AIDataRecord_AccTable_t ---- */
void AIDataRecord_AccTable_t::Setup()
{
  int loop;
  int iVar1;
  int speed;

  this->AIDataRecord_t::Setup();
  speed = 0;
 loopTop:
  if (speed < 0x70) {
    iVar1 = this->Get(speed);
    iVar1 = fixedmult(iVar1,this->scale_);
    *(short *)(this->dataBuffer_ + speed * 2) = (short)(iVar1 >> 8);
    speed = speed + 1;
    goto loopTop;
  }
  return;
}

/* ---- ___23AIDataRecord_AccTable_t  AccTable::dtor ---- */
AIDataRecord_AccTable_t::~AIDataRecord_AccTable_t()
{
  int recordLoop;
  int curveLoop;
  return;
}

/* ---- __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t  BestLine::ctor ---- */
AIDataRecord_BestLine_t::AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  int iVar1;

  iVar1 = gNumSlices;
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_BestLine_t_vtable;
  this->numElements_ = iVar1;
  this->bSize_ = iVar1;
  if (this->recordMethod_ == 0) {
    sprintf(this->name_,D_800553C4,D_80116498[0],D_80113228[0]);
  }
  else {
    sprintf(this->name_,D_800553D4,D_8011649C[0],D_80113228[0]);
  }
  return;
}

/* ---- ___23AIDataRecord_BestLine_t  BestLine::dtor  [@0x8006d574] ---- */
/* Compiler-synthesized: empty body -> implicit cleanup of the AIDataRecord_t
 * base subobject calls its dtor (jal ___14AIDataRecord_t). Real inheritance
 * (not composition) is required for gcc to emit this bare form -- composition
 * synthesized a DELETING dtor variant the oracle lacks (see nfs4_types.h). */
AIDataRecord_BestLine_t::~AIDataRecord_BestLine_t()
{
}

/* ---- __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t  TrackCurve::ctor ---- */
AIDataRecord_TrackCurve_t::AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  int iVar1;

  iVar1 = gNumSlices;
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_TrackCurve_t_vtable;
  this->numElements_ = iVar1;
  this->bSize_ = iVar1 + 1;
  if (this->recordMethod_ == 0) {
    sprintf(this->name_,D_800553E4,D_80116490[0],D_80113228[0]);
  }
  else {
    sprintf(this->name_,D_800553F4,D_80116494[0],D_80113228[0]);
  }
  return;
}

/* ---- Get__25AIDataRecord_TrackCurve_ti ---- */
int AIDataRecord_TrackCurve_t::Get(int slice)
{
  return (u_int)(u_char)this->dataBuffer_[slice];
}

/* ---- ___25AIDataRecord_TrackCurve_t  TrackCurve::dtor  [@0x8006d554] ---- */
/* Compiler-synthesized: empty body -> implicit cleanup of the AIDataRecord_t
 * base subobject calls its dtor (jal ___14AIDataRecord_t). Real inheritance
 * (not composition) is required for gcc to emit this bare form -- composition
 * synthesized a DELETING dtor variant the oracle lacks (see nfs4_types.h). */
AIDataRecord_TrackCurve_t::~AIDataRecord_TrackCurve_t()
{
}

/* ---- __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t  CurveSpeedTable::ctor ---- */
AIDataRecord_CurveSpeedTable_t::AIDataRecord_CurveSpeedTable_t(char *carName,
          AIDataRecord_WhichRecord_t whichIsThis)
  : AIDataRecord_t(whichIsThis,(char *)0x0)
{
  this->_vf = (__vtbl_ptr_type (*) [3])AIDataRecord_CurveSpeedTable_t_vtable;
  this->numElements_ = 0x100;
  this->bSize_ = 0x100;
  if (this->recordMethod_ == 0) {
    sprintf(this->name_,D_80055404,D_80116478[0],carName);
  }
  else {
    sprintf(this->name_,D_80055410,D_8011647C[0],carName);
  }
  return;
}

/* ---- Get__30AIDataRecord_CurveSpeedTable_ti ---- */
int AIDataRecord_CurveSpeedTable_t::Get(int curve)
{
  if (curve < 0) {
    curve = -curve;
  }
  if (0xff < curve) {
    curve = 0xff;
  }
  return (u_int)(u_char)this->dataBuffer_[curve] << 0x10;
}

/* ---- Upgrade__30AIDataRecord_CurveSpeedTable_ti ---- */
void AIDataRecord_CurveSpeedTable_t::Upgrade(int handlingUpgrade)
{
  int round;   /* 0xffff hoisted across the loop (pin-free per the no-asm-pin rule) */
  char *pcVar1;
  int iVar1;
  int curve;

  curve = 0;
  round = 0xffff;
 loopTop:
  if (curve < this->numElements_) {
    iVar1 = this->Get(curve);
    iVar1 = fixedmult(iVar1,handlingUpgrade);
    pcVar1 = this->dataBuffer_ + curve;
    if (iVar1 < 0) {
      iVar1 = iVar1 + round;
    }
    *pcVar1 = (char)(iVar1 >> 0x10);
    curve = curve + 1;
    goto loopTop;
  }
  return;
}

/* ---- ___30AIDataRecord_CurveSpeedTable_t  CurveSpeedTable::dtor  [@0x8006d534] ---- */
/* Compiler-synthesized: empty body -> implicit cleanup of the AIDataRecord_t
 * base subobject calls its dtor (jal ___14AIDataRecord_t). Real inheritance
 * (not composition) is required for gcc to emit this bare form -- composition
 * synthesized a DELETING dtor variant the oracle lacks (see nfs4_types.h). */
AIDataRecord_CurveSpeedTable_t::~AIDataRecord_CurveSpeedTable_t()
{
}

/* ---- Get__26AIDataRecord_CarTracking_ti  [@0x8006d50c] ---- */
/* Trivial stub: always returns 0 (record-method not implemented/used). */
int AIDataRecord_CarTracking_t::Get(int i)
{
  return 0;
}

/* ---- ___26AIDataRecord_CarTracking_t  CarTracking::dtor  [@0x8006d514] ---- */
/* Compiler-synthesized: empty body -> implicit cleanup of the AIDataRecord_t
 * base subobject calls its dtor (jal ___14AIDataRecord_t). Real inheritance
 * (not composition) is required for gcc to emit this bare form -- composition
 * synthesized a DELETING dtor variant the oracle lacks (see nfs4_types.h). */
AIDataRecord_CarTracking_t::~AIDataRecord_CarTracking_t()
{
}

/* end of aidatarecord.cpp */
