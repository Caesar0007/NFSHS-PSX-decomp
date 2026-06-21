/* game/common/vtables_aihigh.cpp -- #75 data-materialization: AIHigh-family vtables (14).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type (size=_vf[3]); pfn VAs symbolicated. @0xVA breadcrumbs.
 * NOT original layout (the obj owned each in its rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

static int _vtdtor_AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *p){ p->~AIHigh_BTC_AIPerp(); return 0; }
static int _vtdtor_AIHigh_BTC_Cop(AIHigh_BTC_Cop *p){ p->~AIHigh_BTC_Cop(); return 0; }
static int _vtdtor_AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *p){ p->~AIHigh_BTC_HumanCop(); return 0; }
static int _vtdtor_AIHigh_BTC_HumanPerp(AIHigh_BTC_HumanPerp *p){ p->~AIHigh_BTC_HumanPerp(); return 0; }
static int _vtdtor_AIHigh_BTC_Perp(AIHigh_BTC_Perp *p){ p->~AIHigh_BTC_Perp(); return 0; }
static int _vtdtor_AIHigh_BTC_Wingman(AIHigh_BTC_Wingman *p){ p->~AIHigh_BTC_Wingman(); return 0; }
static int _vtdtor_AIHigh_Base(AIHigh_Base *p){ p->~AIHigh_Base(); return 0; }
static int _vtdtor_AIHigh_BasicCop(AIHigh_BasicCop *p){ p->~AIHigh_BasicCop(); return 0; }
static int _vtdtor_AIHigh_BasicPerp(AIHigh_BasicPerp *p){ p->~AIHigh_BasicPerp(); return 0; }
static int _vtdtor_AIHigh_Cop(AIHigh_Cop *p){ p->~AIHigh_Cop(); return 0; }
static int _vtdtor_AIHigh_Human(AIHigh_Human *p){ p->~AIHigh_Human(); return 0; }
static int _vtdtor_AIHigh_Opponent(AIHigh_Opponent *p){ p->~AIHigh_Opponent(); return 0; }
static int _vtdtor_AIHigh_Player(AIHigh_Player *p){ p->~AIHigh_Player(); return 0; }
static int _vtdtor_AIHigh_Traffic(AIHigh_Traffic *p){ p->~AIHigh_Traffic(); return 0; }

__vtbl_ptr_type AIHigh_Base_vtable[3] = {   /* @0x80054e04 */
  {0, 0, (int (*)(...))0},                           /* @0x80054e04  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054e0c  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Base},        /* @0x80054e14  ~AIHigh_Base */
};
__vtbl_ptr_type AIHigh_BasicPerp_vtable[3] = {   /* @0x80054e6c */
  {0, 0, (int (*)(...))0},                           /* @0x80054e6c  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054e74  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BasicPerp},   /* @0x80054e7c  ~AIHigh_BasicPerp */
};
__vtbl_ptr_type AIHigh_BasicCop_vtable[3] = {   /* @0x80054e9c */
  {0, 0, (int (*)(...))0},                           /* @0x80054e9c  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054ea4  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BasicCop},    /* @0x80054eac  ~AIHigh_BasicCop */
};
__vtbl_ptr_type AIHigh_BTC_Wingman_vtable[3] = {   /* @0x80054ec4 */
  {0, 0, (int (*)(...))0},                           /* @0x80054ec4  null */
  {0, 0, (int (*)(...))&AIHigh_BTC_Wingman::HighExecute}, /* @0x80054ecc  HighExecute__18AIHigh_BTC_Wingman */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_Wingman}, /* @0x80054ed4  ~AIHigh_BTC_Wingman */
};
__vtbl_ptr_type AIHigh_BTC_HumanCop_vtable[3] = {   /* @0x80054ee4 */
  {0, 0, (int (*)(...))0},                           /* @0x80054ee4  null */
  {0, 0, (int (*)(...))&AIHigh_BTC_HumanCop::HighExecute}, /* @0x80054eec  HighExecute__19AIHigh_BTC_HumanCop */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_HumanCop}, /* @0x80054ef4  ~AIHigh_BTC_HumanCop */
};
__vtbl_ptr_type AIHigh_BTC_Cop_vtable[3] = {   /* @0x80054f04 */
  {0, 0, (int (*)(...))0},                           /* @0x80054f04  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054f0c  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_Cop},     /* @0x80054f14  ~AIHigh_BTC_Cop */
};
__vtbl_ptr_type AIHigh_BTC_AIPerp_vtable[3] = {   /* @0x80054fa0 */
  {0, 0, (int (*)(...))0},                           /* @0x80054fa0  null */
  {0, 0, (int (*)(...))&AIHigh_BTC_AIPerp::HighExecute}, /* @0x80054fa8  HighExecute__17AIHigh_BTC_AIPerp */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_AIPerp},  /* @0x80054fb0  ~AIHigh_BTC_AIPerp */
};
__vtbl_ptr_type AIHigh_BTC_HumanPerp_vtable[3] = {   /* @0x80054fc0 */
  {0, 0, (int (*)(...))0},                           /* @0x80054fc0  null */
  {0, 0, (int (*)(...))&AIHigh_BTC_HumanPerp::HighExecute}, /* @0x80054fc8  HighExecute__20AIHigh_BTC_HumanPerp */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_HumanPerp}, /* @0x80054fd0  ~AIHigh_BTC_HumanPerp */
};
__vtbl_ptr_type AIHigh_BTC_Perp_vtable[3] = {   /* @0x80054fe0 */
  {0, 0, (int (*)(...))0},                           /* @0x80054fe0  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054fe8  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_Perp},    /* @0x80054ff0  ~AIHigh_BTC_Perp */
};
__vtbl_ptr_type AIHigh_Player_vtable[3] = {   /* @0x80055098 */
  {0, 0, (int (*)(...))0},                           /* @0x80055098  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x800550a0  __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Player},      /* @0x800550a8  ~AIHigh_Player */
};
__vtbl_ptr_type AIHigh_Human_vtable[3] = {   /* @0x800550c8 */
  {0, 0, (int (*)(...))0},                           /* @0x800550c8  null */
  {0, 0, (int (*)(...))&AIHigh_Human::HighExecute},  /* @0x800550d0  HighExecute__12AIHigh_Human */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Human},       /* @0x800550d8  ~AIHigh_Human */
};
__vtbl_ptr_type AIHigh_Opponent_vtable[3] = {   /* @0x800550f8 */
  {0, 0, (int (*)(...))0},                           /* @0x800550f8  null */
  {0, 0, (int (*)(...))&AIHigh_Opponent::HighExecute}, /* @0x80055100  HighExecute__15AIHigh_Opponent */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Opponent},    /* @0x80055108  ~AIHigh_Opponent */
};
__vtbl_ptr_type AIHigh_Cop_vtable[3] = {   /* @0x80055154 */
  {0, 0, (int (*)(...))0},                           /* @0x80055154  null */
  {0, 0, (int (*)(...))&AIHigh_Cop::HighExecute},    /* @0x8005515c  HighExecute__10AIHigh_Cop */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Cop},         /* @0x80055164  ~AIHigh_Cop */
};
__vtbl_ptr_type AIHigh_Traffic_vtable[3] = {   /* @0x800551b0 */
  {0, 0, (int (*)(...))0},                           /* @0x800551b0  null */
  {0, 0, (int (*)(...))&AIHigh_Traffic::HighExecute}, /* @0x800551b8  HighExecute__14AIHigh_Traffic */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_Traffic},     /* @0x800551c0  ~AIHigh_Traffic */
};
