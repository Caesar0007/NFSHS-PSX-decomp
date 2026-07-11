/* game/psx/loading.cpp -- RECONSTRUCTED (NFS4 PSX load-screen + progress bar; C++ TU)
 *   3 fns: Loading_DrawLoadingScreen (per-track load image + language banner),
 *   Loading_UpdateLoadingScreen (per-checkpoint progress-bar tiles), Loading_GetInitialMemory
 *   (record largest free block). No GTE.
 */
#include "../../nfs4_types.h"
#include "loading_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
char *smallShapeFile;
int totalAvailMem;


/* ---- Loading_DrawLoadingScreen__Fv  [LOADING.CPP:15-51] SLD-VERIFIED ---- */
void Loading_DrawLoadingScreen(void)

{
  shapetbl *s;
  char *f;
  char *g;
  int language;
  char name [255];

  language = GameSetup_gData.userSetting.language;
  sprintf(name,"%sLoad%d%c.qps",Paths_Paths[0x19],GameSetup_gData.track,GameSetup_gData.mirrorTrack + 0x61);
  f = (char *)loadshapeadr(name,(void *)0x0);
  sprintf(name,"%sLoada.psh",Paths_Paths[0x19]);
  g = (char *)loadshapeadr(name,(void *)0x0);
  Draw_SetEnvironment(0x200,0xf0,1,0,1,0,0,0);
  s = shapepointer(f,0);
  Draw_DrawDirectScreen(s,0,0);
  s = locateshapez(g,loading_languageNames[language]);
  Draw_DrawDirectScreen(s,(*(int *)((char *)s + 0xc) << 0x14) >> 0x14,
                          (*(int *)((char *)s + 0xc) << 4) >> 0x14);
  purgememadr(f);
  purgememadr(g);
  Draw_SetEnvironment(0x200,0xf0,0,1,0,0,0,0);
  return;
}

/* ---- Loading_UpdateLoadingScreen__Fi  [LOADING.CPP:60-92] SLD-VERIFIED ---- */
/* NEAR-MISS 4 diffs (62/62, improved from 25 baseline): FIXED (a) `max=0x17` moved BEFORE
 * the `if(checkpoint==1..)` block -- oracle materializes the constant once, very early,
 * before any conditional, not after (matches the do-while's guard test too, added a
 * `if(i<max)` entry guard around the do-while per the standard guarded-do-while shape,
 * §3.12 #15a family). Residual 4 diffs = a commutative-add reassociation: oracle groups
 * the DrawDirectScreen offset as `(i+0x8e) + s1invariant`, ours as `(s1invariant+i)+0x8e`
 * -- same value, tried several explicit parenthesizations/operand orders, none reproduced
 * the oracle's exact grouping without perturbing the loop-invariant hoist itself (worse).
 * Accepted near-miss. */
void Loading_UpdateLoadingScreen(int checkpoint)

{
  shapetbl *tile;
  int i;
  int max;
  char name [255];

  max = 0x17;
  if ((checkpoint == 1) && (smallShapeFile == (char *)0x0)) {
    sprintf(name,"%sLoadb.psh",Paths_Paths[0x19]);
    smallShapeFile = (char *)loadshapeadr(name,(void *)0x10);
  }
  i = 0;
  if (i < max) {
    do {
      tile = locateshapez(smallShapeFile,"back");
      Draw_DrawDirectScreen(tile,(checkpoint + -1) * 0x17 + i + 0x8e,0xc0);
      i = i + 1;
    } while (i < max);
  }
  if ((checkpoint == 10) && (smallShapeFile != (char *)0x0)) {
    purgememadr(smallShapeFile);
    smallShapeFile = (char *)0x0;
  }
  return;
}

/* ---- Loading_GetInitialMemory__Fv  [LOADING.CPP:105-106] SLD-VERIFIED ---- */
void Loading_GetInitialMemory(void)

{
  
  totalAvailMem = largestunused();
  return;
}

/* end of loading.cpp */
