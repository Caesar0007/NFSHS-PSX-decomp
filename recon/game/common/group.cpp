/* game/common/group.cpp -- RECONSTRUCTED (NFS4 PSX SerializedGroup container layer; C++ TU)
 *   6 SerializedGroup METHODS (real members -> oracle method-mangling `__15SerializedGroup...`):
 *   LocateNextGroupType/LocateGroupType/LocateGroupNum/LocateCreateGroupType/CreateLiteGroup/
 *   CreateLiteGroupDataSize. `this` lands in $a0 exactly like the old explicit `this_` arg, so
 *   the bodies are byte-identical to the flattened free-fn form. Full SYM-locals applied. GTE-free.
 */
#include "group_types.h"
#include "group_externs.h"

/* SourceRecoveryUnresolved: reconstruction-only emitter for retail's unreferenced
 * SimpleMem tag. Its original source/header producer is NOT established by SYM;
 * this helper name is not supplied or exempted as a recovered inline function. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- LocateNextGroupType__15SerializedGroupi [@0x8009c128] covered SLD requires native comparison ---- */
#line 42 "C:/nfs4/GAME/COMMON/GROUP.CPP"
SerializedGroup * SerializedGroup::LocateNextGroupType(int type)

{
  SerializedGroup *group;

  group = (SerializedGroup *)((char *)this + this->m_length);

  if (group->m_type != type) {
    return (SerializedGroup *)0x0;
  }






  return group;
}

/* ---- LocateGroupType__15SerializedGroupii [@0x8009c150] covered SLD requires native comparison ---- */
#line 61 "C:/nfs4/GAME/COMMON/GROUP.CPP"
SerializedGroup * SerializedGroup::LocateGroupType(int type,int index)

{
  int count; int numElems; SerializedGroup *group; count = 0;
  group = (SerializedGroup *)this->GetData();
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
    group = (SerializedGroup *)((char *)group + group->m_length); }






  return (SerializedGroup *)0x0;
}

/* ---- LocateGroupNum__15SerializedGroupi [@0x8009c1c0] covered SLD requires native comparison ---- */
#line 101 "C:/nfs4/GAME/COMMON/GROUP.CPP"
SerializedGroup * SerializedGroup::LocateGroupNum(int index)

{
  int numElems; char *group; numElems = this->m_num_elements;

  if (numElems <= index) {
    return (SerializedGroup *)0;
  }
  group = (char *)this->GetData();

  for (int i = 0; i < index; i++) {

    group = group + ((SerializedGroup *)group)->m_length;
  }

  return (SerializedGroup *)group;
}

/* ---- LocateCreateGroupType__15SerializedGroupiP9SimpleMemi [@0x8009c204] covered SLD requires native comparison ---- */
/* SourceRecoveryUnresolved: groupFound names the first lookup's actual truth
   result (producer121, test123). Its original identifier/primitive spelling
   is absent from optimized SYM; this is not a uniquely recovered declaration.
   Plain predicate staging preserves supplied records; a pointer stage's
   header/type-copy order remains unresolved. No qualifier/fake-use dial.
   Receipt: build/nc12/group_final_observer_20261023/findings-proof.json. */
#line 117 "C:/nfs4/GAME/COMMON/GROUP.CPP"
Group *
SerializedGroup::LocateCreateGroupType(int type,SimpleMem *mem,int index)

{
  bool groupFound = LocateGroupType(type,index) != 0;

  if (groupFound) {




    return CreateLiteGroup(LocateGroupType(type,index),mem);
  }




  return (Group *)0;
}

/* ---- CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem [@0x8009c27c] covered SLD requires native comparison ---- */
#line 166 "C:/nfs4/GAME/COMMON/GROUP.CPP"
Group * SerializedGroup::CreateLiteGroup(SerializedGroup *source,SimpleMem *mem)

{
  int newLen;
  Group *ret;

  newLen = source->GetDataLength() + sizeof(Group);
  ret = (Group *)mem->Alloc(newLen,0);
  ret->m_num_elements = source->m_num_elements;


  blockmove(source->GetData(),ret->GetData(),newLen);



  return ret;
}

/* ---- CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi [@0x8009c2e4] covered SLD requires native comparison ---- */
#line 183 "C:/nfs4/GAME/COMMON/GROUP.CPP"
Group *
SerializedGroup::CreateLiteGroupDataSize(SerializedGroup *source,SimpleMem *mem,int dataSize)

{
  int newLen;
  Group *ret;

  newLen = dataSize + 4;
  ret = (Group *)mem->Alloc(newLen,0);
  ret->m_num_elements = 0;


  blockmove(source->GetData(),ret->GetData(),newLen);



  return ret;
}
