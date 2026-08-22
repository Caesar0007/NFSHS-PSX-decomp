/* souffle_externs.h -- extern decls for game/psx/souffle.cpp (NFS4 PSX wind/dust particle). */
#ifndef SOUFFLE_EXTERNS_H
#define SOUFFLE_EXTERNS_H

/* ---- libc + harvested + SYM ---- */
extern int               simGlobal[2];             /* 0x8011e0ac */
#define SOUFFLE_GAME_TICKS simGlobal[1]
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */
extern int               Replay_ReplayInterface[2];
#define SOUFFLE_REPLAY_SPEED Replay_ReplayInterface[1]
extern void Sfx_Add(Souffle_tISouffle *);
extern void Sfx_BuildSouffleFacet(DRender_tView *, Souffle_tISouffle *);
extern void Sfx_Transform(coorddef *worldpt, SVECTOR *campt, coorddef *t);

extern Souffle_tISouffle *gISouffle;     /* ->type/cycle */
extern int gCISouffle;
extern int gTMoveSouffle;
extern int gWindDir;

extern "C" int random(...);
extern "C" int fastintcos(...);
extern "C" int fastintsin(...);
extern "C" int fixedmult(...);
extern "C" void *reservememadr(...);
extern "C" int purgememadr(...);

#endif
