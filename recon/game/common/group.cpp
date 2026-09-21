/* game/common/group.cpp -- RECONSTRUCTED (NFS4 PSX SerializedGroup container layer; C++ TU)
 *   6 SerializedGroup METHODS (real members -> oracle method-mangling `__15SerializedGroup...`):
 *   LocateNextGroupType/LocateGroupType/LocateGroupNum/LocateCreateGroupType/CreateLiteGroup/
 *   CreateLiteGroupDataSize. `this` lands in $a0 exactly like the old explicit `this_` arg, so
 *   the bodies are byte-identical to the flattened free-fn form. Full SYM-locals applied. GTE-free.
 */
#include "group_types.h"
#include "group_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055FC4).  The retail SYM shows the
 * object saw the track / Group header family, whose unused inline leaves the literal behind in every such object
 * (tools/psyq_pipe/simplemem_bysym.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- LocateNextGroupType__15SerializedGroupi  [GROUP.CPP:44-58] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateNextGroupType(int type)

{
  SerializedGroup *group;

  group = (SerializedGroup *)((int)this + this->m_length);
  if (group->m_type != type) {
    return (SerializedGroup *)0x0;
  }
  return group;
}

/* ---- LocateGroupType__15SerializedGroupii  [GROUP.CPP:63-99] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateGroupType(int type,int index)

{
  SerializedGroup *group;
  int numElems;
  int count;

  count = 0;
  group = (SerializedGroup *)((int)this + 0x10);
  numElems = this->m_num_elements;
  for (numElems = numElems + -1; numElems != -1; numElems = numElems + -1) {
    if (group->m_type == type) {
      if (count == index) {
        return (SerializedGroup *)group;
      }
      count = count + 1;
    }
    if ((group->m_length & 3) != 0) {
      group->m_length += 4 - (group->m_length & 3);
    }
    group = (SerializedGroup *)((int)group + group->m_length);
  }
  return (SerializedGroup *)0x0;
}

/* ---- LocateGroupNum__15SerializedGroupi  [GROUP.CPP:103-116] SLD-VERIFIED ---- */
SerializedGroup * SerializedGroup::LocateGroupNum(int index)

{
  int numElems;
  char * group;

  numElems = this->m_num_elements;
  group = (char *)this + 0x10;
  if (numElems <= index) {
    return (SerializedGroup *)0;
  }
  for (int i = 0; i < index; i++) {
    group = group + ((SerializedGroup *)group)->m_length;
  }
  return (SerializedGroup *)group;
}

/* ---- LocateCreateGroupType__15SerializedGroupiP9SimpleMemi  [GROUP.CPP:120-134] SLD-VERIFIED ---- */
Group *
SerializedGroup::LocateCreateGroupType(int type,SimpleMem *mem,int index)

{
  return LocateGroupType(type,index) == 0
      ? (Group *)0
      : CreateLiteGroup(LocateGroupType(type,index),mem);
}

/* ---- CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem  [GROUP.CPP:168-181] SLD-VERIFIED ---- */
Group * SerializedGroup::CreateLiteGroup(SerializedGroup *source,SimpleMem *mem)

{
  int newLen;
  Group * ret;

  newLen = source->m_length - 0xc;
  ret = (Group *)mem->Alloc(newLen,0);
  ret->m_num_elements = source->m_num_elements;
  blockmove(source + 1,ret + 1,newLen);
  return ret;
}

/* ---- CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi  [GROUP.CPP:186-199] SLD-VERIFIED ---- */
Group *
SerializedGroup::CreateLiteGroupDataSize(SerializedGroup *source,SimpleMem *mem,int dataSize)

{
  int newLen;
  Group * ret;

  newLen = dataSize + 4;
  ret = (Group *)mem->Alloc(newLen,0);
  ret->m_num_elements = 0;
  blockmove(source + 1,ret + 1,newLen);
  return ret;
}

/* end of group.cpp */
