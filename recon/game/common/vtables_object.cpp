/* game/common/vtables_object.cpp -- #75: Object*Anim vtables (4). Real nfs4-f.exe bytes;
 * object.cpp models these classes as FLAT C fns (Class_Draw/Class_dt) -> pfns ref those names.
 * __vtbl_ptr_type; null-delimited size. @0xVA breadcrumbs. Self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */
/* flat fns defined in game/common/object.cpp: */
int ObjectMultiAnim_Draw(ObjectMultiAnim*,DRender_tView*,Draw_DCache*,int);
int ObjectSignAnim_Draw(ObjectSignAnim*,DRender_tView*,Draw_DCache*,int);
int ObjectFinishedMultiAnim_Draw(ObjectFinishedMultiAnim*,DRender_tView*,Draw_DCache*,int);
int ObjectFinishedSignAnim_Draw(ObjectFinishedSignAnim*,DRender_tView*,Draw_DCache*,int);
void ObjectAnim_dt(ObjectAnim*,int);
extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim*,int);
extern "C" void ___14ObjectSignAnim(ObjectSignAnim*,int);
extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim*,int);
extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim*,int);

__vtbl_ptr_type ObjectAnim_vtable[3] = {   /* @0x800560e8 */
  {0, 0, (int (*)(...))0},                           /* @0x800560e8  null */
  {0, 0, (int (*)(...))&ObjectAnim_dt},              /* @0x800560f0  _._10ObjectAnim */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x800560f8  __pure_virtual */
};
__vtbl_ptr_type ObjectMultiAnim_vtable[3] = {   /* @0x800560b8 */
  {0, 0, (int (*)(...))0},                           /* @0x800560b8  null */
  {0, 0, (int (*)(...))&___15ObjectMultiAnim},         /* @0x800560c0  _._15ObjectMultiAnim */
  {0, 0, (int (*)(...))&ObjectMultiAnim_Draw},       /* @0x800560c8  Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectSignAnim_vtable[3] = {   /* @0x80056088 */
  {0, 0, (int (*)(...))0},                           /* @0x80056088  null */
  {0, 0, (int (*)(...))&___14ObjectSignAnim},          /* @0x80056090  _._14ObjectSignAnim */
  {0, 0, (int (*)(...))&ObjectSignAnim_Draw},        /* @0x80056098  Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectFinishedMultiAnim_vtable[3] = {   /* @0x800560d0 */
  {0, 0, (int (*)(...))0},                           /* @0x800560d0  null */
  {0, 0, (int (*)(...))&___23ObjectFinishedMultiAnim}, /* @0x800560d8  _._23ObjectFinishedMultiAnim */
  {0, 0, (int (*)(...))&ObjectFinishedMultiAnim_Draw}, /* @0x800560e0  Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectFinishedSignAnim_vtable[3] = {   /* @0x800560a0 */
  {0, 0, (int (*)(...))0},                           /* @0x800560a0  null */
  {0, 0, (int (*)(...))&___22ObjectFinishedSignAnim},  /* @0x800560a8  _._22ObjectFinishedSignAnim */
  {0, 0, (int (*)(...))&ObjectFinishedSignAnim_Draw}, /* @0x800560b0  Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei */
};
