/* game/common/vtables_object.cpp -- #75: Object*Anim vtables (4). Real nfs4-f.exe bytes;
 * Draw entries use their real methods; deleting destructors remain reconstructed flat helpers.
 * __vtbl_ptr_type; null-delimited size. @0xVA breadcrumbs. Self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */
/* functions defined in game/common/object.cpp: */
extern "C" void ___10ObjectAnim(ObjectAnim*,int);
extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim*,int);
extern "C" void ___14ObjectSignAnim(ObjectSignAnim*,int);
extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim*,int);
extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim*,int);

/* SYM-GLOBAL-CARRIER: ObjectAnim_vtable
   Retail proves this base table at 0x800560e8; SYM retains `_vt.*` records only
   for the four derived Object*Anim tables. */
__vtbl_ptr_type ObjectAnim_vtable[3] = {   /* @0x800560e8 */
  {0, 0, (int (*)(...))0},                           /* @0x800560e8  null */
  {0, 0, (int (*)(...))&___10ObjectAnim},            /* @0x800560f0  _._10ObjectAnim */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x800560f8  __pure_virtual */
};
__vtbl_ptr_type ObjectMultiAnim_vtable[3] = {   /* @0x800560b8 */
  {0, 0, (int (*)(...))0},                           /* @0x800560b8  null */
  {0, 0, (int (*)(...))&___15ObjectMultiAnim},         /* @0x800560c0  _._15ObjectMultiAnim */
  {0, 0, (int (*)(...))&ObjectMultiAnim::Draw},      /* @0x800560c8  Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectSignAnim_vtable[3] = {   /* @0x80056088 */
  {0, 0, (int (*)(...))0},                           /* @0x80056088  null */
  {0, 0, (int (*)(...))&___14ObjectSignAnim},          /* @0x80056090  _._14ObjectSignAnim */
  {0, 0, (int (*)(...))&ObjectSignAnim::Draw},       /* @0x80056098  Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectFinishedMultiAnim_vtable[3] = {   /* @0x800560d0 */
  {0, 0, (int (*)(...))0},                           /* @0x800560d0  null */
  {0, 0, (int (*)(...))&___23ObjectFinishedMultiAnim}, /* @0x800560d8  _._23ObjectFinishedMultiAnim */
  {0, 0, (int (*)(...))&ObjectFinishedMultiAnim::Draw}, /* @0x800560e0  Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei */
};
__vtbl_ptr_type ObjectFinishedSignAnim_vtable[3] = {   /* @0x800560a0 */
  {0, 0, (int (*)(...))0},                           /* @0x800560a0  null */
  {0, 0, (int (*)(...))&___22ObjectFinishedSignAnim},  /* @0x800560a8  _._22ObjectFinishedSignAnim */
  {0, 0, (int (*)(...))&ObjectFinishedSignAnim::Draw}, /* @0x800560b0  Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei */
};
