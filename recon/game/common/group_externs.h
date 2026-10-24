/* group_externs.h -- cross-TU decls for game/common/group.cpp (NFS4 SerializedGroup container).
 *   SerializedGroup/SimpleMem are declared by group_types.h. The six container
 *   methods are real C++ members; only the external byte mover is declared here. */
#ifndef GROUP_EXTERNS_H
#define GROUP_EXTERNS_H

/* Exact blkmov.h public signature, without its unrelated eac_types.h transform
 * bodies: retail group.obj contains none. simplemem_ctor_restore_20261023. */
extern "C" {
void blockmove(void *src, void *dst, int n);
}

#endif /* GROUP_EXTERNS_H */
