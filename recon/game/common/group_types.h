/* Group.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_GROUP_TYPES_H
#define NFS4_GAME_COMMON_GROUP_TYPES_H

#include "simplemem_types.h"

struct Group;

struct SerializedGroup {
    int m_type, m_length, dummy, m_num_elements;

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

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#endif
