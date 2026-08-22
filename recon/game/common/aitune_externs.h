/* game/common/AITUNE_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AITUNE_EXTERNS_H_
#define _GAME_COMMON_AITUNE_EXTERNS_H_
extern int GameSetup_gData[16];
#define AITUNE_TRACK GameSetup_gData[15]

/* The slice body is not emitted in AITUNE.obj; only its loaded pointer and a
 * proven byte access are source-visible here. */
extern int (*BWorldSm_slices)[8];

#endif /* _GAME_COMMON_AITUNE_EXTERNS_H_ */
