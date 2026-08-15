#include "../../lib/libfns.h"
/* souffle_externs.h -- extern decls for game/psx/souffle.cpp (NFS4 PSX wind/dust particle). */
#ifndef SOUFFLE_EXTERNS_H
#define SOUFFLE_EXTERNS_H

/* ---- libc + harvested + SYM ---- */
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */
extern tReplayInterface Replay_ReplayInterface;
extern void Sfx_Add(Souffle_tISouffle *);
extern void Sfx_BuildSouffleFacet(DRender_tView *, Souffle_tISouffle *);
extern void Sfx_Transform(coorddef *worldpt, SVECTOR *campt, coorddef *t);

extern Souffle_tISouffle *gISouffle;     /* ->type/cycle */
extern int gCISouffle;
extern int gTMoveSouffle;
extern int gWindDir;

#endif
