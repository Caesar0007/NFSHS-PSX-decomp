/* Group.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_GROUP_TYPES_H
#define NFS4_GAME_COMMON_GROUP_TYPES_H

#include "simplemem_types.h"

struct Group;

struct SerializedGroup {
    int m_type, m_length, dummy, m_num_elements;

    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
    /* Inferred total-length getter: retail's material argument has a receiver
       pair. Its enclosing caller ownership and original spelling remain open;
       the 16-byte header subtraction belongs to the payload-length argument. */
    inline int GetLength() { return m_length; }

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
