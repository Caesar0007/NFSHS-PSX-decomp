/* game/common/group.cpp -- RECONSTRUCTED (NFS4 PSX SerializedGroup container layer; C++ TU)
 *   6 SerializedGroup METHODS (real members -> oracle method-mangling `__15SerializedGroup...`):
 *   LocateNextGroupType/LocateGroupType/LocateGroupNum/LocateCreateGroupType/CreateLiteGroup/
 *   CreateLiteGroupDataSize. `this` lands in $a0 exactly like the old explicit `this_` arg, so
 *   the bodies are byte-identical to the flattened free-fn form. Full SYM-locals applied. GTE-free.
 */
#include "../../nfs4_types.h"
#include "group_externs.h"


/* ---- LocateNextGroupType__15SerializedGroupi  [GROUP.CPP:44-58] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateNextGroupType(int type)

{
  SerializedGroup *next;
  int zero;      /* codegen device: `== ^ zero` (runtime 0, not folded) reserves
                    $v0 for the result so next->m_type loads into $v1 -> byte-match.
                    Logically a no-op; do NOT simplify to `if (next->m_type==type)`
                    (reverts to a 10-diff v0/v1 coloring miss). permuter-derived. */

  next = (SerializedGroup *)((int)this + this->m_length);
  zero = 0;
  if ((next->m_type == type) ^ zero) {
    return next;
  }
  return (SerializedGroup *)0x0;
}

/* ---- LocateGroupType__15SerializedGroupii  [GROUP.CPP:63-99] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateGroupType(int type,int index)

{
  int param_1 = (int)this;
  u_int uVar2;     /* unused; declaration order (uVar2, piVar3, newLen, iVar4, iVar5)
                      sets gcc's pseudo numbering to the matching allocation -- do NOT
                      remove or reorder (reverts to a 28-diff miss). */
  int *piVar3;
  int newLen;      /* function-scope split temp (NOT block-local) -- see align below */
  int iVar4;
  int iVar5;

  iVar5 = 0;
  piVar3 = (int *)(param_1 + 0x10);
  iVar4 = *(int *)(param_1 + 0xc);
  for (iVar4 = iVar4 + -1; iVar4 != -1; iVar4 = iVar4 + -1) {
    if (*piVar3 == type) {
      if (iVar5 == index) {
        return (SerializedGroup *)piVar3;
      }
      iVar5 = iVar5 + 1;
    }
    if ((piVar3[1] & 3) != 0) {
      newLen = piVar3[1] + 4;          /* split temp keeps piVar3[1] in $v0 so the align
                                          emits `(len+4) - (len&3)` like the oracle, not
                                          the reassociated `len - ((len&3) - 4)`. */
      piVar3[1] = newLen - (piVar3[1] & 3);
    }
    piVar3 = (int *)((int)piVar3 + piVar3[1]);
  }
  return (SerializedGroup *)0x0;
}

/* ---- LocateGroupNum__15SerializedGroupi  [GROUP.CPP:103-116] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateGroupNum(int index)

{
  int param_1 = (int)this;
  SerializedGroup *pThis;  /* folded receiver temp (SYM REG `this`) */
  int numElems;
  char * group;
  int i;
  int iVar1;
  int iVar2;

  iVar2 = param_1 + 0x10;
  if (*(int *)(param_1 + 0xc) <= index) {
    return (SerializedGroup *)0;
  }
  iVar1 = 0;
  if (0 < index) {
    do {
      iVar1 = iVar1 + 1;
      iVar2 = iVar2 + *(int *)(iVar2 + 4);
    } while (iVar1 < index);
  }
  return (SerializedGroup *)iVar2;
}

/* ---- LocateCreateGroupType__15SerializedGroupiP9SimpleMemi  [GROUP.CPP:120-134] SLD-VERIFIED ---- */
void *
SerializedGroup::LocateCreateGroupType(int type,SimpleMem *mem_,int index)

{
  int param_1 = (int)this;
  int mem = (int)mem_;
  int iVar1;
  u_int uVar2;

  iVar1 = (int)((SerializedGroup *)param_1)->LocateGroupType(type,index);
  if (iVar1 == 0) {
    uVar2 = 0;
  }
  else {
    uVar2 = (u_int)((SerializedGroup *)param_1)->LocateGroupType(type,index);
    uVar2 = (u_int)((SerializedGroup *)param_1)->CreateLiteGroup((SerializedGroup *)uVar2,(SimpleMem *)mem);
  }
  return (void *)uVar2;
}

/* ---- CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem  [GROUP.CPP:168-181] SLD-VERIFIED ---- */
Group * SerializedGroup::CreateLiteGroup(SerializedGroup *source_,SimpleMem *mem_)

{
  int param_1 = (int)this; (void)param_1;
  int source = (int)source_;
  int mem = (int)mem_;
  SerializedGroup *pThis;  /* folded receiver temp (SYM REG `this`) */
  int newLen;
  Group * ret;
  u_int *puVar1;
  int n;

  n = *(int *)(source + 4) + -0xc;
  puVar1 = (u_int *)((SimpleMem *)mem)->Alloc(n,0);
  *puVar1 = *(u_int *)(source + 0xc);
  blockmove((void *)(source + 0x10),puVar1 + 1,n);
  return (Group *)puVar1;
}

/* ---- CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi  [GROUP.CPP:186-199] SLD-VERIFIED ---- */
Group *
SerializedGroup::CreateLiteGroupDataSize(SerializedGroup *source_,SimpleMem *mem_,int dataSize)

{
  int param_1 = (int)this; (void)param_1;
  int source = (int)source_;
  int mem = (int)mem_;
  SerializedGroup *pThis;  /* folded receiver temp (SYM REG `this`) */
  int newLen;
  Group * ret;
  u_int *puVar1;

  puVar1 = (u_int *)((SimpleMem *)mem)->Alloc(dataSize + 4,0);
  *puVar1 = 0;
  blockmove((void *)(source + 0x10),puVar1 + 1,dataSize + 4);
  return (Group *)puVar1;
}

/* end of group.cpp */
