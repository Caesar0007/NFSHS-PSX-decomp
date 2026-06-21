/* game/common/group.h — reconstructed from game/common/group.cpp (6 fns) */
#ifndef _GAME_COMMON_GROUP_H_
#define _GAME_COMMON_GROUP_H_
#include "../../nfs4_types.h"

/* Canonical plain-typed prototypes — the single cross-TU source of truth for the
 * SerializedGroup container methods (emitted free-fn w/ explicit SerializedGroup* `this`).
 * C++ mangling = name + PARAM types only, so these param types must match every caller's
 * extern (chunk_externs.h / track_externs.h) AND group.cpp's definitions for the whole-tree
 * link to resolve. Demangled originals kept in the trailing comments. */
SerializedGroup *LocateNextGroupType(SerializedGroup *thisGroup, int type);                                 /* LocateNextGroupType__15SerializedGroupi  :44 */
SerializedGroup *LocateGroupType(SerializedGroup *thisGroup, int type, int index);                          /* LocateGroupType__15SerializedGroupii  :63 */
SerializedGroup *LocateGroupNum(SerializedGroup *thisGroup, int index);                                     /* LocateGroupNum__15SerializedGroupi  :103 */
void            *LocateCreateGroupType(SerializedGroup *thisGroup, int type, SimpleMem *mem, int index);    /* LocateCreateGroupType__15SerializedGroupiP9SimpleMemi  :120 */
Group           *CreateLiteGroup(SerializedGroup *thisGroup, SerializedGroup *source, SimpleMem *mem);      /* CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem  :168 */
Group           *CreateLiteGroupDataSize(SerializedGroup *thisGroup, SerializedGroup *source, SimpleMem *mem, int dataSize); /* CreateLiteGroupDataSize__…i  :186 */

#endif /* _GAME_COMMON_GROUP_H_ */
