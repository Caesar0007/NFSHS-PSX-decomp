/* Group.obj source-visible types; full supplied type-copy/order audit remains open. */
#ifndef NFS4_GAME_COMMON_GROUP_TYPES_H
#define NFS4_GAME_COMMON_GROUP_TYPES_H

#include "simplemem_types.h"

struct Group;

struct SerializedGroup {
    int m_type, m_length, dummy, m_num_elements;

    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
    /* Inferred payload-byte getter: retail SLD assigns the header subtraction
       to this operation, before the caller's entry-count conversion. The
       original accessor spelling is not supplied by the inline records. */
    inline int GetDataLength() { return m_length - sizeof(SerializedGroup); }

    SerializedGroup *LocateNextGroupType(int type);
    SerializedGroup *LocateGroupType(int type, int index);
    SerializedGroup *LocateGroupNum(int index);
    Group *LocateCreateGroupType(int type, SimpleMem *mem, int index);
    Group *CreateLiteGroup(SerializedGroup *source, SimpleMem *mem);
    Group *CreateLiteGroupDataSize(SerializedGroup *source, SimpleMem *mem,
                                   int dataSize);
};

struct Group {
    int m_num_elements;

    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

#include "shared/TCB.h"





#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#endif
