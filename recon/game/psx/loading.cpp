/* game/psx/loading.cpp -- RECONSTRUCTED (NFS4 PSX load-screen + progress bar; C++ TU)
 *   3 fns: Loading_DrawLoadingScreen (per-track load image + language banner),
 *   Loading_UpdateLoadingScreen (per-checkpoint progress-bar tiles), Loading_GetInitialMemory
 *   (record largest free block). No GTE.
 */
#include "loading_types.h"
#include "loading_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
char *smallShapeFile = 0;   /* @0x8013d9d0  W67-A4: explicit =0 -- retail emits this
    cell BEFORE the "back" literal @0x8013d9d4, so it cannot have been tentative
    (16E =0 discriminator).  DO NOT strip the =0. */

/* SYM-GLOBAL-CARRIER: D_8013D9D4
   W67-A4: retail keeps the <=8-byte "back" literal in .sdata @0x8013d9d4 (-G8
   build, 18C).  Materialized as a NAMED .sdata array (the sim.cpp/w66a6
   section-attribute device; >G4 so the address form stays absolute and the
   reloc-name-lenient gate is unchanged).  Whole-TU g_value 8 also gates clean
   here (3/3 PASS 2x, w67a4) if the orchestrator prefers the wiring route. */
static char D_8013D9D4[] __attribute__((section(".sdata"), aligned(4))) = "back";

int totalAvailMem;   /* tentative: retail emits it AFTER the literal (17B). */


/* ---- Loading_DrawLoadingScreen__Fv  [LOADING.CPP:15-51] SLD-VERIFIED ---- */
void Loading_DrawLoadingScreen(void)

{
  shapetbl *s;
  char *f;
  char *g;
  int language;
  char name [255];

  language = Loading_GameSetupWords[56];
  sprintf(name,"%sLoad%d%c.qps",Paths_Paths[0x19],Loading_GameSetupWords[15],Loading_GameSetupWords[11] + 0x61);
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
/* PASS (w39-a4, 62/62).  Two levers, in this order:
 *   (1) `max = 0x17` hoisted BEFORE the `if(checkpoint==1..)` block + an `if(i<max)`
 *       entry guard around the do-while (banked w38);
 *   (2) the remaining 4-diff "commutative reassociation" was NOT a floor (the old
 *       in-source note claiming so was wrong): the oracle groups the X arg as
 *       `invariant + (i + 0x8e)` (`addiu $a1,$s0,0x8E; addu $a1,$s1,$a1`
 *       @0x800DB290/94).  Explicit parentheses do NOT reach it (they perturb loop.c's
 *       hoist: 6 diffs) and hoisting the multiply into a named local is much worse
 *       (29 diffs -- loop.c then can't build the `sll/addu/sll/subu` *0x17 chain in
 *       the oracle's place).  The lever is a NAMED TEMP for the *inner* term only
 *       (`y = i + 0x8e;`), leaving the invariant inline.  Catalog: "const-multiply
 *       reassociation needs a NAMED TEMP, not parens" -- applied to the ADDEND side. */
void Loading_UpdateLoadingScreen(int checkpoint)

{
  shapetbl *tile; /* SYM-CODEGEN-CARRIER: tile -- nested call is 44 diffs, 64/62 */
  int i;
  int max;
  int y; /* SYM-CODEGEN-CARRIER: y -- required for retail addend reassociation */
  char name [255];

  max = 0x17;
  if ((checkpoint == 1) && (smallShapeFile == (char *)0x0)) {
    sprintf(name,"%sLoadb.psh",Paths_Paths[0x19]);
    smallShapeFile = (char *)loadshapeadr(name,(void *)0x10);
  }
  i = 0;
  if (i < max) {
    do {
      tile = locateshapez(smallShapeFile,D_8013D9D4);   /* "back" */
      y = i + 0x8e;
      Draw_DrawDirectScreen(tile,(checkpoint + -1) * 0x17 + y,0xc0);
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
