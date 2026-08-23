/* skidmark_externs.h -- externs for game/psx/skidmark.cpp (NFS4 PSX tyre skid-mark system) */
#ifndef _GAME_PSX_SKIDMARK_EXTERNS_H_
#define _GAME_PSX_SKIDMARK_EXTERNS_H_

#include "skidmark_types.h"

/* ---- module globals (gp-relative .bss) ---- */
// [owned->defined in skidmark.cpp] extern Skidmark_Chunk *gSm;        /* 0x8013dac8  ring of skid-mark chunks */
// [owned->defined in skidmark.cpp] extern int             gCountSm;   /* 0x8013dacc  # chunks allocated this frame */
// [owned->defined in skidmark.cpp] extern int             gUseSm;     /* 0x8013dad0  index of current chunk */
// [owned->defined in skidmark.cpp] extern int             gMaxSChunk; /* 0x8013dad4  chunk cap (0x10, or 8 in link mode) */

/* ---- eaclib EACPSXZ fixed-point / trig / memory helpers ---- */
          /* 16.16 atan2 -> brads */
            /* cos(brads), 16.16 */
            /* sin(brads), 16.16 */
          /* 16.16 fixed-point multiply */

/* ---- game globals / sibling helpers ---- */
/* GameSetup_tData is a foreign completed owner absent from Skidmark.obj's
 * retail type graph.  Only commMode (word 3) is used here. */
extern int GameSetup_gData[];                  /* 0x801131ec */
extern void  Draw_kCtrlSkidmark(Draw_tCtrlSkidmark *fskid);   /* DrawW: queue skid render */

extern "C" {
int   intatan(int dx, int dz);
int   fastintcos(int angle);
int   fastintsin(int angle);
int   fixedmult(int a, int b);
void *reservememadr(const char *name, int size, int memory_class);
int   purgememadr(void *ptr);
}

/* ---- this module (forward decls for intra-TU calls) ---- */
extern Skidmark_Chunk *Skidmark_CheckChunk(coorddef *skidpt, int newsegs, int slice);
extern void  CalcStartSegment(Skidmark_Segment *r1, Skidmark_Segment *r2, coorddef *cp,
                              coorddef *pt1, coorddef *pt2, int tireWidth);
extern void  CalcOneSegment(Skidmark_Segment *r1, coorddef *cp, coorddef *pt1,
                            coorddef *pt2, int tireWidth);

#endif
