/* game/common/vtables_aistate.cpp -- #75 data-materialization: AIHigh-family vtables (12).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type (size=_vf[4]); pfn VAs symbolicated. @0xVA breadcrumbs.
 * NOT original layout (the obj owned each in its rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

static int _vtdtor_AIState_Base(AIState_Base *p){ p->~AIState_Base(); return 0; }
static int _vtdtor_AIState_Chase(AIState_Chase *p){ p->~AIState_Chase(); return 0; }
static int _vtdtor_AIState_Cruise(AIState_Cruise *p){ p->~AIState_Cruise(); return 0; }
static int _vtdtor_AIState_Donuts(AIState_Donuts *p){ p->~AIState_Donuts(); return 0; }
static int _vtdtor_AIState_GotoSlice(AIState_GotoSlice *p){ p->~AIState_GotoSlice(); return 0; }
static int _vtdtor_AIState_Idle(AIState_Idle *p){ p->~AIState_Idle(); return 0; }
static int _vtdtor_AIState_NonActive(AIState_NonActive *p){ p->~AIState_NonActive(); return 0; }
static int _vtdtor_AIState_None(AIState_None *p){ p->~AIState_None(); return 0; }
static int _vtdtor_AIState_Normal(AIState_Normal *p){ p->~AIState_Normal(); return 0; }
static int _vtdtor_AIState_Offroad(AIState_Offroad *p){ p->~AIState_Offroad(); return 0; }
static int _vtdtor_AIState_Purgatory(AIState_Purgatory *p){ p->~AIState_Purgatory(); return 0; }
static int _vtdtor_AIState_RovingTraffic(AIState_RovingTraffic *p){ p->~AIState_RovingTraffic(); return 0; }

__vtbl_ptr_type AIState_None_vtable[4] = {   /* @0x80054e1c */
  {0, 0, (int (*)(...))0},                           /* @0x80054e1c  null */
  {0, 0, (int (*)(...))&AIState_None::Execute},      /* @0x80054e24  Execute__12AIState_None */
  {0, 0, (int (*)(...))&_vtdtor_AIState_None},       /* @0x80054e2c  ~AIState_None */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80054e34  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Cruise_vtable[4] = {   /* @0x80055500 */
  {0, 0, (int (*)(...))0},                           /* @0x80055500  null */
  {0, 0, (int (*)(...))&AIState_Cruise::Execute},    /* @0x80055508  Execute__14AIState_Cruise */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Cruise},     /* @0x80055510  ~AIState_Cruise */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055518  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_GotoSlice_vtable[4] = {   /* @0x80055520 */
  {0, 0, (int (*)(...))0},                           /* @0x80055520  null */
  {0, 0, (int (*)(...))&AIState_GotoSlice::Execute}, /* @0x80055528  Execute__17AIState_GotoSlice */
  {0, 0, (int (*)(...))&_vtdtor_AIState_GotoSlice},  /* @0x80055530  ~AIState_GotoSlice */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055538  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Donuts_vtable[4] = {   /* @0x80055540 */
  {0, 0, (int (*)(...))0},                           /* @0x80055540  null */
  {0, 0, (int (*)(...))&AIState_Donuts::Execute},    /* @0x80055548  Execute__14AIState_Donuts */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Donuts},     /* @0x80055550  ~AIState_Donuts */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055558  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_RovingTraffic_vtable[4] = {   /* @0x80055560 */
  {0, 0, (int (*)(...))0},                           /* @0x80055560  null */
  {0, 0, (int (*)(...))&AIState_RovingTraffic::Execute}, /* @0x80055568  Execute__21AIState_RovingTraffic */
  {0, 0, (int (*)(...))&_vtdtor_AIState_RovingTraffic}, /* @0x80055570  ~AIState_RovingTraffic */
  {0, 0, (int (*)(...))&AIState_RovingTraffic::TestForRelease}, /* @0x80055578  TestForRelease__21AIState_RovingTraffic */
};
__vtbl_ptr_type AIState_Purgatory_vtable[4] = {   /* @0x80055580 */
  {0, 0, (int (*)(...))0},                           /* @0x80055580  null */
  {0, 0, (int (*)(...))&AIState_Purgatory::Execute}, /* @0x80055588  Execute__17AIState_Purgatory */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Purgatory},  /* @0x80055590  ~AIState_Purgatory */
  {0, 0, (int (*)(...))&AIState_Purgatory::TestForRelease}, /* @0x80055598  TestForRelease__17AIState_Purgatory */
};
__vtbl_ptr_type AIState_NonActive_vtable[4] = {   /* @0x800555a0 */
  {0, 0, (int (*)(...))0},                           /* @0x800555a0  null */
  {0, 0, (int (*)(...))&AIState_NonActive::Execute}, /* @0x800555a8  Execute__17AIState_NonActive */
  {0, 0, (int (*)(...))&_vtdtor_AIState_NonActive},  /* @0x800555b0  ~AIState_NonActive */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x800555b8  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Offroad_vtable[4] = {   /* @0x800555c0 */
  {0, 0, (int (*)(...))0},                           /* @0x800555c0  null */
  {0, 0, (int (*)(...))&AIState_Offroad::Execute},   /* @0x800555c8  Execute__15AIState_Offroad */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Offroad},    /* @0x800555d0  ~AIState_Offroad */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x800555d8  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Chase_vtable[4] = {   /* @0x800555e0 */
  {0, 0, (int (*)(...))0},                           /* @0x800555e0  null */
  {0, 0, (int (*)(...))&AIState_Chase::Execute},     /* @0x800555e8  Execute__13AIState_Chase */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Chase},      /* @0x800555f0  ~AIState_Chase */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x800555f8  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Idle_vtable[4] = {   /* @0x80055600 */
  {0, 0, (int (*)(...))0},                           /* @0x80055600  null */
  {0, 0, (int (*)(...))&AIState_Idle::Execute},      /* @0x80055608  Execute__12AIState_Idle */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Idle},       /* @0x80055610  ~AIState_Idle */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055618  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Normal_vtable[4] = {   /* @0x80055620 */
  {0, 0, (int (*)(...))0},                           /* @0x80055620  null */
  {0, 0, (int (*)(...))&AIState_Normal::Execute},    /* @0x80055628  Execute__14AIState_Normal */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Normal},     /* @0x80055630  ~AIState_Normal */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055638  TestForRelease__12AIState_Base */
};
__vtbl_ptr_type AIState_Base_vtable[4] = {   /* @0x80055640 */
  {0, 0, (int (*)(...))0},                           /* @0x80055640  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80055648  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIState_Base},       /* @0x80055650  ~AIState_Base */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80055658  TestForRelease__12AIState_Base */
};
