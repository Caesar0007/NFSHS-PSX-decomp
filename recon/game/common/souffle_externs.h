/* souffle_externs.h -- extern decls for game/psx/souffle.cpp (NFS4 PSX wind/dust particle). */
#ifndef SOUFFLE_EXTERNS_H
#define SOUFFLE_EXTERNS_H

/* ---- libc + harvested + SYM ---- */
/* real sizes (SYM: Sim_tSimGlobalVar 24 bytes, tReplayInterface 32 bytes): souffle.obj is a
 * -G8 object ("souffle" literal in retail .sdata) and both are accessed absolutely, which
 * only holds if their declared size exceeds 8. */
struct Sched_tSchedule;
#include "shared/Sim_tSimGlobalVar.h"
extern Sim_tSimGlobalVar simGlobal;   /* 0x8011e0ac (real type; was an int view) */
#define SOUFFLE_GAME_TICKS simGlobal.gameTicks
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */
#include "shared/tReplayInterface.h"
extern tReplayInterface   Replay_ReplayInterface;   /* real type; was an int[8] view */
#define SOUFFLE_REPLAY_SPEED Replay_ReplayInterface.speed
extern void Sfx_Add(Souffle_tISouffle *);
extern void Sfx_BuildSouffleFacet(DRender_tView *, Souffle_tISouffle *);
extern void Sfx_Transform(coorddef *worldpt, SVECTOR *campt, coorddef *t);

extern Souffle_tISouffle *gISouffle;     /* ->type/cycle */
extern int gCISouffle;
extern int gTMoveSouffle;
extern int gWindDir;

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_math.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/random.h"
}

#endif
