/* game/common/AITUNE_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AITUNE_EXTERNS_H_
#define _GAME_COMMON_AITUNE_EXTERNS_H_
/* The owner aggregate is known; its body is not recorded in AITUNE.obj. */
struct GameSetup_tData;
extern GameSetup_tData GameSetup_gData;
/* Owner SYM: track INT@60; no guessed sixteen-word array extent. */
#define AITUNE_TRACK (*(int *)((char *)&GameSetup_gData + 60))

/* The slice body is not emitted in AITUNE.obj; only its loaded pointer and a
 * proven byte access are source-visible here. */
extern int (*BWorldSm_slices)[8];

#endif /* _GAME_COMMON_AITUNE_EXTERNS_H_ */
