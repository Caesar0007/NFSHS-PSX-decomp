/* game/common/chunk_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_CHUNK_EXTERNS_H_
#define _GAME_COMMON_CHUNK_EXTERNS_H_
/* chunk.obj's SYM graph contains the four component GameSetup records but not
 * the 2600-byte owner record.  The only field used here is the word at +0x0c. */
extern int GameSetup_gData[4];
#define CHUNK_COMMMODE GameSetup_gData[3]

/* ---- Group.obj: SerializedGroup container ops are real MEMBER functions
        (declared in struct SerializedGroup, nfs4_types.h) -> call as
        group->LocateGroupType(...); no free-fn externs needed here. ---- */

#endif /* _GAME_COMMON_CHUNK_EXTERNS_H_ */
