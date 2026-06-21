/* game/common/chunk_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_CHUNK_EXTERNS_H_
#define _GAME_COMMON_CHUNK_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- libc ---- */

/* ---- GameSetup.obj ---- */
extern GameSetup_tData GameSetup_gData;   /* @0x801131ec  (.commMode @0x801131f8) */

/* ---- Group.obj (SerializedGroup container layer; typed convention per track_externs.h;
        group.cpp's int-typed defs reconcile in the #148 END link sweep) ---- */
extern SerializedGroup *LocateGroupType(SerializedGroup *, int, int);
extern void            *LocateCreateGroupType(SerializedGroup *, int, SimpleMem *, int);
extern Group           *CreateLiteGroupDataSize(SerializedGroup *, SerializedGroup *, SimpleMem *, int);

#endif /* _GAME_COMMON_CHUNK_EXTERNS_H_ */
