/* group_externs.h -- cross-TU decls for game/common/group.cpp (NFS4 SerializedGroup container).
 *   SerializedGroup/SimpleMem are declared by group_types.h. The six container
 *   methods are real C++ members; only the external byte mover is declared here. */
#ifndef GROUP_EXTERNS_H
#define GROUP_EXTERNS_H

/* eacpsxz public byte-move API; this C++ TU needs C linkage. */
extern "C" {
#include "eaclib/psx/eacpsxz/blkmov.h"
}

#endif /* GROUP_EXTERNS_H */
