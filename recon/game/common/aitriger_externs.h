/* game/common/aitriger_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_aitriger_EXTERNS_H_
#define _GAME_COMMON_aitriger_EXTERNS_H_
struct Sim_tSimGlobalVar;
extern Sim_tSimGlobalVar simGlobal;
/* Owner SYM: gameTicks INT@4; the caller does not emit its body. */
#define AITRIGGER_GAME_TICKS (*(int *)((char *)&simGlobal + 4))

extern "C" int fixeddiv(...);
extern "C" void qsort(...);

#endif /* _GAME_COMMON_aitriger_EXTERNS_H_ */
