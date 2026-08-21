/* group_externs.h -- cross-TU decls for game/common/group.cpp (NFS4 SerializedGroup container).
 *   Types (SerializedGroup, SimpleMem) live in nfs4_types.h. The 6 SerializedGroup methods are
 *   emitted as free fns w/ explicit int `this` (object.obj convention); cross-TU callees below. */
#ifndef GROUP_EXTERNS_H
#define GROUP_EXTERNS_H

extern "C" void blockmove(void *source, void *destination, int size);

#endif /* GROUP_EXTERNS_H */
