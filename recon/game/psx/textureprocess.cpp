/* game/psx/textureprocess.cpp -- RECONSTRUCTED (NFS4 PSX color-CLUT + fog + world-color; C++ TU)
 *   16 fns: TextureProcess_* (translucency/CLUT depth-color), Fog_* (keyframe fog triggers),
 *   CV_* (world-color vertex processing). No GTE.
 */
#include "../../nfs4_types.h"
#include "textureprocess_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
BWorldSm_Pos *fogslicePos;
FogKey *Fog_gHeadKey;
TP_ZPaletteSystem TP_gZPaletteSystem;
int Fog_gNumKeys;
int gZDepth;

/* Fog_MakeTrackPathName function-local static string buffer (SYM STAT fogstrspc) */
static char fogstrspc[256];


/* ---- TextureProcess_TransColorCheck__FPci  [TEXTUREPROCESS.CPP:47-62] SLD-VERIFIED ---- */
int TextureProcess_TransColorCheck(char *data,int numentry)

{
  u_short uVar1;
  int translucent_flag;

  translucent_flag = 0;
  while (1) {
    numentry = numentry - 1;
    if (numentry == -1) break;
    uVar1 = *(u_short *)data;
    data = (char *)((int)data + 2);
    translucent_flag = translucent_flag | (0x8000 < uVar1);
  }
  return translucent_flag;
}

/* ---- TextureProcess_ColorClut__FiiPciii  [TEXTUREPROCESS.CPP:356-410] SLD-FLAG:NONMONO ---- */
void TextureProcess_ColorClut(int level,int maxlevel,char *data,int numentry,int cx,int cy)
{
  short newdata [256];
  CTrackSpec *spec;              /* MATCH: the oracle materializes
                                  * la $v1,TrackSpec_gSpec ONCE and parks it in
                                  * $fp across the whole loop (lw 0x10, lbu
                                  * 0x14/0x15/0x16 off it); direct
                                  * TrackSpec_gSpec.fogspec.X references emit a
                                  * fresh fused %hi/%lo per access. */
  char *sourcedata;
  short *p;
  int contrasttemp;
  int j;
  u_short color;
  int r;
  int g;
  int b;
  int temp;

  sourcedata = data;
  j = 0;
  /* MATCH: the contrast read goes through the GLOBAL directly and `spec` is
   * assigned AFTER it -- cse then turns `spec = &TrackSpec_gSpec` into a plain
   * register COPY of the address already materialized for the contrast load
   * (oracle: la $v1,TrackSpec_gSpec; lw 0x10($v1); addu $fp,$v1,$zero).
   * `p = newdata` must come LAST: its luid decides whether sched1 issues the
   * addiu before or after the mflo. */
  contrasttemp = (TrackSpec_gSpec.fogspec.contrast * level) / (maxlevel + -1);
  spec = &TrackSpec_gSpec;
  p = newdata;
  /* MATCH: exit-in-the-middle -- numentry is re-loaded from its arg slot at the
   * top of every iteration and the back edge is an unconditional `j`. */
  while (1) {
    if (!(j < numentry)) break;
    color = *(u_short *)sourcedata;
    if (color == 0) {
      *p = 0;
    }
    else {
      b = (color >> 7) & 0xf8;
      g = (color >> 2) & 0xf8;
      r = (color & 0x1f) * 8;
      /* MATCH: one variable per channel (raw value then clamped result share
       * $s1/$s2/$s0) and the `= 0` default as the if-ARM so it lands in the
       * bltz delay slot. */
      temp = r - fixedmult(r - spec->fogspec.color.r,contrasttemp);
      if (temp < 0) { r = 0; } else { r = temp; if (0xff < r) { r = 0xff; } }
      temp = g - fixedmult(g - spec->fogspec.color.g,contrasttemp);
      if (temp < 0) { g = 0; } else { g = temp; if (0xff < g) { g = 0xff; } }
      temp = b - fixedmult(b - spec->fogspec.color.b,contrasttemp);
      if (temp < 0) { b = 0; } else { b = temp; if (0xff < b) { b = 0xff; } }
      if (b < 8) { b = 8; }                          /* keep a minimum blue so the pixel stays visible */
      /* MATCH: narrow each channel to 5 bits as its OWN statement (assigned back
       * into the channel var) before composing -- folding the shift+mask into
       * the compose expression lets gcc reassociate it to (b<<7)&0x7c00. */
      b = (b >> 3) & 0x1f;
      g = (g >> 3) & 0x1f;
      r = (r >> 3) & 0x1f;
      *p = (short)((color & 0x8000) | (b << 10) | (g << 5) | r);
    }
    sourcedata = sourcedata + 2;
    p = p + 1;
    j = j + 1;
  }
  {
    RECT r;                          /* SYM names the blit rect `r`, block-scoped (shadows the loop's int r) */
    r.x = (short)cx;
    r.w = (short)numentry;
    r.y = (short)cy;
    r.h = 1;
    LoadImage(&r,(u_long *)newdata);
  }
}

/* ---- TextureProcess_DepthColorCluts__FPci  [TEXTUREPROCESS.CPP:422-462] SLD-VERIFIED ---- */
int TextureProcess_DepthColorCluts(char *data,int numentry)
{
  int i;
  int cx;
  int cy;
  int ret;

  DrawSync(0);
  i = 0;
  while (1) {
    if (!(i < 0x10)) break;
    Texture_GetClutId(0x10 < numentry,&cx,&cy);
    gClutDepth[TP_gZPaletteSystem.numdepthclut][i] = (short)((cy << 6) | ((cx >> 4) & 0x3f));
    TextureProcess_ColorClut(i,0x10,data,numentry,cx,cy);
    i = i + 1;
  }
  ret = TP_gZPaletteSystem.numdepthclut++;
  return ret;
}

/* ---- Fog_CheckRange__FiP6FogKey  [TEXTUREPROCESS.CPP:639-661] SLD-VERIFIED ---- */
FogKey * Fog_CheckRange(int currentslice,FogKey *fkey)

{
  FogKey *keynext;
  int iVar2;
  int iVar3;

  keynext = fkey->next;
  iVar2 = (int)fkey->slice;
  iVar3 = (int)keynext->slice;
  /* MATCH: direct returns (no result funnel) -- the oracle stages 0/fkey straight
   * into $v0 in the branch delay slots; a funnel local takes $a2 + a tail copy. */
  if (iVar3 < iVar2) {
    /* MATCH: `||` short-circuit -- both arms fall into ONE `return fkey` block
     * (oracle beqz/beqz both target .L800E0BC4); split returns duplicate it. */
    if ((iVar2 <= currentslice) || (currentslice < iVar3)) {
      return fkey;
    }
    goto ret0;
  }
  if (currentslice < iVar2) {
    goto ret0;
  }
  if (currentslice < iVar3) {
    return fkey;
  }
ret0:
  return (FogKey *)0x0;
}

/* ---- Fog_FindKey__FiP6FogKey  [TEXTUREPROCESS.CPP:665-695] SLD-VERIFIED ---- */
FogKey * Fog_FindKey(int currentslice,FogKey *fkey)

{
  FogKey *pFVar1;
  
  if (fkey == (FogKey *)0x0) {
    fkey = Fog_gHeadKey;
  }
  pFVar1 = Fog_CheckRange(currentslice,fkey);
  if (pFVar1 == (FogKey *)0x0) {
    if (currentslice < fkey->slice) {
      do {
        fkey = fkey->prev;
        pFVar1 = Fog_CheckRange(currentslice,fkey);
      } while (pFVar1 == (FogKey *)0x0);
    }
    else {
      do {
        fkey = fkey->next;
        pFVar1 = Fog_CheckRange(currentslice,fkey);
      } while (pFVar1 == (FogKey *)0x0);
    }
  }
  return fkey;
}

/* ---- Fog_AllocKey__Fv  [TEXTUREPROCESS.CPP:716-726] SLD-VERIFIED ---- */
FogKey * Fog_AllocKey(void)

{
  FogKey *pFVar2;
  int *piVar1;
  int i;
  int one;                 /* MATCH: the "slot is free" marker held in a named
                            * local -- the oracle materializes `li a2,1` right
                            * after i=0 and BEFORE the two base addresses; a bare
                            * literal in the compare gets it emitted last. */

  i = 0;
  one = 1;
  pFVar2 = Fog_gBuf;
  piVar1 = openkeys;
  do {
    i = i + 1;
    /* MATCH: if/else with the ADVANCE as the if-arm -- the oracle keeps the
     * found-body INLINE (bne skips it); an early `return` if-arm makes gcc
     * invert the branch and push the found block past the loop exit. */
    if (*piVar1 != one) {
      pFVar2 = pFVar2 + 1;
      piVar1 = piVar1 + 1;
    }
    else {
      *piVar1 = 0;
      return pFVar2;
    }
  } while (i < 0x20);
  return (FogKey *)0x0;
}

/* ---- Fog_AddKey__Fii  [TEXTUREPROCESS.CPP:733-790] SLD-VERIFIED ---- */
void Fog_AddKey(int slice,int distance)

{
  FogKey *newkey;
  FogKey *insertkey;
  FogKey *savenextkey;
  
  newkey = Fog_AllocKey();
  insertkey = Fog_gHeadKey;
  newkey->prev = (FogKey *)0x0;
  newkey->next = (FogKey *)0x0;
  newkey->slice = (short)slice;
  newkey->distance = (short)distance;
  if (insertkey == (FogKey *)0x0) {
    Fog_gHeadKey = newkey;
    newkey->next = newkey;
    newkey->prev = newkey;
  }
  else {
    if (insertkey != insertkey->next) {
      insertkey = Fog_FindKey(slice,(FogKey *)0x0);
    }
    if (insertkey->slice == slice) {
      return;
    }
    savenextkey = insertkey->next;
    insertkey->next = newkey;
    newkey->prev = insertkey;
    newkey->next = savenextkey;
    savenextkey->prev = newkey;
  }
  Fog_gNumKeys = Fog_gNumKeys + 1;
  return;
}

/* ---- Fog_Update__Fi  [TEXTUREPROCESS.CPP:840-884] SLD-VERIFIED ---- */
void Fog_Update(int player)
{
  int currentslice;
  FogKey *key;
  int nextslice;
  int diffslice;
  int diffdistance;
  int final_dist;
  int numslices;

  if (Fog_gNumKeys != 1) {
    BWorldSm_FindClosestQuadRez(&gCView.cview.translation,fogslicePos + player,1);
    currentslice = fogslicePos[player].slice;
    key = Fog_FindKey(currentslice,Fog_gCurrentKey[player]);
    Fog_gCurrentKey[player] = key;
    /* MATCH: NO cached `nextkey` local -- the oracle re-reads key->next (and
     * key->slice / key->distance) at each use; only `nextslice` is a real
     * variable (it is mutated by += numslices).  The interpolating arm is the
     * FALL-THROUGH (oracle `beq key->distance,next->distance` branches away to
     * the plain-copy arm).
     * FLOOR (15 diffs, ours 82/81): the oracle CROSS-JUMPS the two
     * `TrackSpec_gSpec.fogspec.start = ...` stores into one `sw a1,0(v0)` with
     * the `lui` hoisted into the beq delay slot; funnelling both arms through a
     * shared `start` local does merge them (81/81) but rotates key/nextslice/
     * distance one allocno step (36 diffs), so the 2-store form is kept. */
    nextslice = key->next->slice;
    if (key->distance != key->next->distance) {
      if (nextslice < key->slice) {
        numslices = gNumSlices;
        nextslice = nextslice + numslices;
        if ((-1 < currentslice) && (currentslice < key->slice)) {
          currentslice = currentslice + numslices;
        }
      }
      diffdistance = key->next->distance - key->distance;
      diffslice = nextslice - key->slice;
      final_dist = ((currentslice - key->slice) * diffdistance) / diffslice;
      TrackSpec_gSpec.fogspec.start = key->distance + final_dist;
    }
    else {
      TrackSpec_gSpec.fogspec.start = key->distance;
    }
  }
}

/* ---- Fog_MakeTrackPathName__FPc  [TEXTUREPROCESS.CPP:1015-1022] SLD-VERIFIED ---- */
char * Fog_MakeTrackPathName(char *ext)

{
  sprintf(fogstrspc,"%sTr%02d%s",Paths_Paths[6],GameSetup_gData.track & 0xf,ext);
  return fogstrspc;
}

/* ---- Fog_ReadFogKeys__Fv  [TEXTUREPROCESS.CPP:1026-1078] SLD-VERIFIED ---- */
int Fog_ReadFogKeys(void)

{
  char *strspc;
  int i;
  u_int *readmem;
  u_int numkeys;

  /* 🔴 CORRECTNESS (raw oracle @0x800E0F18): the three selector tests were
   * INVERTED in the previous reconstruction (`bnez` where the oracle has
   * `beqz`), which also made the third arm provably DEAD (it required
   * Weather!=0 && Weather==0).  The oracle picks:
   *   Time!=0 && Weather!=0 -> literal 1   Time!=0 -> literal 2
   *   Weather!=0            -> literal 3   else    -> literal 4
   * (offsets 0x54=Time, 0x48=Weather; the four literals sit 8 bytes apart at
   * D_8013DB4C/54/5C/64, i.e. in source order).  The literal TEXTS keep their
   * previous order -- verify_asm normalizes the %hi/%lo so the oracle cannot
   * arbitrate which name belongs to which slot; only the CONDITIONS are proven. */
  if (GameSetup_gData.Time != 0) {
    if (GameSetup_gData.Weather != 0) {
      strspc = Fog_MakeTrackPathName("N.fog");
      goto haveext;
    }
  }
  if (GameSetup_gData.Time != 0) {
    strspc = Fog_MakeTrackPathName("W.fog");
    goto haveext;
  }
  if (GameSetup_gData.Weather != 0) {
    strspc = Fog_MakeTrackPathName("S.fog");
    goto haveext;
  }
  strspc = Fog_MakeTrackPathName(".fog");
haveext:
  readmem = (u_int *)loadfileadr(strspc,0);
  if (readmem == (u_int *)0x0) {
    return 0;
  }
  numkeys = *readmem;
  if (0x1f < numkeys) {
    return 0;
  }
  i = 0;
  /* MATCH: exit-in-the-middle (top test + unconditional `j` back edge, the
   * `slt` recomputed in the back-edge delay slot) -- a plain `while (i<numkeys)`
   * rotates into a zero-trip `blez` guard + bottom test. */
  while (1) {
    if (!(i < (int)numkeys)) break;
    /* MATCH: INDEX form off readmem -- loop.c strength-reduces it to the
     * oracle's unbiased walker (`addu s0,s2,zero` + `lw 4(s0)/lw 8(s0)`);
     * an explicit `p = readmem; p += 2` walker makes gcc pre-bias the base by
     * +8 and use -4/0 displacements. */
    Fog_AddKey(readmem[i * 2 + 1],readmem[i * 2 + 2]);
    i = i + 1;
  }
  purgememadr(readmem);
  return 1;
}

/* ---- Fog_InitFogTriggers__Fv  [TEXTUREPROCESS.CPP:1082-1119] SLD-VERIFIED ---- */
void Fog_InitFogTriggers(void)

{
  int *openkey_walk;
  int num_player;
  int i;
  int k;
  int slice_off;
  
  i = 0x1f;
  openkey_walk = openkeys + 0x1f;
  Fog_gNumKeys = 0;
  Fog_gHeadKey = (FogKey *)0x0;
  do {
    *openkey_walk = 1;
    i = i + -1;
    openkey_walk = openkey_walk + -1;
  } while (-1 < i);
  num_player = Fog_ReadFogKeys();
  if (num_player == 0) {
    Fog_AddKey(0,TrackSpec_gSpec.fogspec.start);
  }
  num_player = 1;
  /* FLOOR (35 diffs, ours 58/57): the oracle stores these two slots through
   * SEPARATE per-element gp-rel symbols (`%gp_rel(Fog_gCurrentKey)` and
   * `%gp_rel(D_8013DB84)`), i.e. this TU OWNS them as two 4-byte gp objects,
   * while Fog_Update reaches the same storage as a real ARRAY with an absolute
   * base + variable index.  Reproducing that needs the catalog's DUAL-MODEL
   * storage (per-element tentative defs alongside the array) which touches the
   * shared extern header + data materialization -- out of this wave's scope.
   * Everything else in this function matches. */
  Fog_gCurrentKey[0] = Fog_gHeadKey;
  Fog_gCurrentKey[1] = Fog_gHeadKey;
  if (GameSetup_gData.commMode == 1) {
    num_player = 2;
  }
  fogslicePos = reservememadr("fog pos",num_player * 0x84,0);
  k = 0;
  if (num_player != 0) {
    slice_off = k;
    do {
      k = k + 1;
      /* MATCH: plain base+offset off fogslicePos (oracle re-reads the gp-rel
       * pointer each iteration and does `addu a1,a1,slice_off`); the Ghidra
       * `fogslicePos->quadPts + slice_off - 8` form is the same address. */
      BWorldSm_SetSlice(0,(BWorldSm_Pos *)((char *)fogslicePos + slice_off));
      slice_off = slice_off + 0x84;
    } while (k < num_player);
  }
  return;
}

/* ---- Fog_DeInitFogTriggers__Fv  [TEXTUREPROCESS.CPP:1123-1124] SLD-VERIFIED ---- */
void Fog_DeInitFogTriggers(void)

{
  purgememadr(fogslicePos);
  return;
}

/* ---- TextureProcess_Init__Fv  [TEXTUREPROCESS.CPP:1135-1137] SLD-VERIFIED ---- */
void TextureProcess_Init(void)

{
  gZDepth = 0x10;
  TP_gZPaletteSystem.numdepthclut = 0;
  return;
}

/* ---- CV_ProcessWorldColors_FINAL__FiP7CVECTORs  [TEXTUREPROCESS.CPP:1156-1179] SLD-VERIFIED ---- */
void CV_ProcessWorldColors_FINAL(int constrast,CVECTOR *color,short brightness)
{
  int i;
  int r;
  int g;
  int b;
  int temp;

  /* MATCH: NO cached `light` pointer -- the oracle re-materializes
   * %hi/%lo(Chunk_lightTable) at the read group and again at EVERY byte store
   * (a char store may alias the pointer global itself), and strength-reduces
   * the index into a byte-offset giv (+4/iter).  The three source bytes are
   * read UP FRONT into r/g/b because they have to survive the fixedmult calls. */
  i = 0;
  /* MATCH: exit-in-the-middle -- the oracle re-tests Chunk_numLight at the TOP
   * of every iteration and closes with an unconditional `j` back (no rotation,
   * no zero-trip guard); a plain `for` rotates and hoists the bound load. */
  while (1) {
    if (!(i < Chunk_numLight)) break;
    r = Chunk_lightTable[i].r;
    g = Chunk_lightTable[i].g;
    b = Chunk_lightTable[i].b;
    temp = r - fixedmult(r - color->r,constrast);
    if (temp < 0) { r = 0; } else { r = temp; if (0xff < r) { r = 0xff; } }
    temp = g - fixedmult(g - color->g,constrast);
    if (temp < 0) { g = 0; } else { g = temp; if (0xff < g) { g = 0xff; } }
    temp = b - fixedmult(b - color->b,constrast);
    if (temp < 0) { b = 0; } else { b = temp; if (0xff < b) { b = 0xff; } }
    r = r + brightness;
    g = g + brightness;
    b = b + brightness;
    if (0xff < r) { r = 0xff; }
    if (r < 0) { r = 0; }
    if (0xff < g) { g = 0xff; }
    if (g < 0) { g = 0; }
    if (0xff < b) { b = 0xff; }
    if (b < 0) { b = 0; }
    Chunk_lightTable[i].r = (u_char)r;
    Chunk_lightTable[i].g = (u_char)g;
    Chunk_lightTable[i].b = (u_char)b;
    i = i + 1;
  }
}

/* ---- CV_ColorTracks__Fiii  [TEXTUREPROCESS.CPP:1183-1257] SLD-VERIFIED ---- */
void CV_ColorTracks(int track,int weather,int night)

{
  u_char uVar1;
  short brightness;
  int contrast;
  CVECTOR color;

  /* MATCH: `contrast` is initialized to 0 BEFORE the memset, so its live range
   * crosses that call and it earns a callee-saved reg -- assigning it only
   * inside the branches leaves it in $a0 (the outgoing arg reg).  The same 0
   * feeds memset's fill arg (oracle: addu a1,s0,zero). */
  contrast = 0;
  memset(&color,0,4);
  brightness = 0;
  if (GameSetup_gData.commMode == 1) {
    if (((track == 2) && (weather == 1)) && (night == 1)) {
      contrast = -0x9c80;
      uVar1 = '\x10';
      /* MATCH: the shared "color.g = uVar1; brightness = 0x10" block is laid out
       * at the track==4 site -- this arm JUMPS to it while the track==4 arm FALLS
       * THROUGH into it; hosting the label here inlines a duplicate copy. */
      goto CVColor_setColorG;
    }
    /* MATCH: FLAT per-case chain -- each arm re-tests `track` (the oracle has two
     * separate track==3 tests and two track==4 tests, with the compare constant
     * rematerialized into the intervening delay slots).  A nested
     * `if (track == 3) { ... }` tests it once and comes out 8 insns short. */
    if (((track == 3) && (weather == 0)) && (night == 1)) {
      contrast = -0xf400;
      goto CVColor_emitFinal;
    }
    if (((track == 3) && (weather == 1)) && (night == 1)) {
      contrast = -0x7400;
      /* MATCH: the oracle writes the whole CVECTOR with ONE word store
       * (sw 0x10 -> r=0x10, g=b=cd=0), not four byte stores. */
      *(int *)&color = 0x10;
      brightness = 0x10;
      goto CVColor_emitFinal;
    }
    if (((track == 4) && (weather == 0)) && (night == 1)) {
      contrast = -0x7800;
      goto CVColor_emitFinal;
    }
    if (((track == 4) && (weather == 1)) && (night == 1)) {
      contrast = -0x10000;
      uVar1 = '\x18';
CVColor_setColorG:
      color.g = uVar1;
      brightness = 0x10;
      goto CVColor_emitFinal;
    }
    if (((track == 6) && (weather == 0)) && (night == 1)) {
      contrast = -0x9610;
      brightness = 0x31;
      goto CVColor_emitFinal;
    }
    if (((track == 7) && (weather == 0)) && (night == 1)) {
      contrast = -0xb400;
      brightness = 0x14;
      goto CVColor_emitFinal;
    }
    if (((track != 8) || (weather != 0)) || (night != 1)) {
      if (((track == 10) && (weather == 1)) && (night == 1)) {
        contrast = -0x5400;
      }
      goto CVColor_emitFinal;
    }
  }
  else {
    if (((track != 8) || (weather != 0)) || (night != 1)) goto CVColor_emitFinal;
  }
  contrast = 0x6800;
  brightness = 0x16;
CVColor_emitFinal:
  CV_ProcessWorldColors_FINAL(contrast,&color,brightness);
  return;
}

/* ---- CV_InitColorVertices__Fv  [TEXTUREPROCESS.CPP:1539-1541] SLD-VERIFIED ---- */
void CV_InitColorVertices(void)

{
  CV_ColorTracks(GameSetup_gData.track & 0xf,GameSetup_gData.Weather,GameSetup_gData.Time);
  return;
}

/* end of textureprocess.cpp */
