/* game/common/audioeng_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOENG_EXTERNS_H_
#define _GAME_COMMON_AUDIOENG_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern Car_tObj **Cars_gList;
extern GameSetup_tData   GameSetup_gData;
extern SndBnk_t gSndBnk[7];
extern int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
#endif /* _GAME_COMMON_AUDIOENG_EXTERNS_H_ */
