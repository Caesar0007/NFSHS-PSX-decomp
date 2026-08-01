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
FogKey *Fog_gCurrentKey;
FogKey *D_8013DB84;
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
  int start;

  if (Fog_gNumKeys != 1) {
    BWorldSm_FindClosestQuadRez(&gCView.cview.translation,fogslicePos + player,1);
    currentslice = fogslicePos[player].slice;
    /* MATCH (w40-a10, 4 -> PASS): the slot ADDRESS must be its own named
     * pointer local.  Written as two separate `Fog_gCurrentKeyArr[player]`
     * expressions, cse still shares the address but the `lui/addiu %hi/%lo`
     * pair belongs to the CALL-ARGUMENT statement, so sched1 gives it the
     * longer path-to-jal priority (lui->addiu->addu->lw->jal = 4) and hoists
     * it ABOVE the `lh $s1,0($s0)` / `sll $s0,$s2,2` pair (priority 2/3).
     * Binding the address to `slot` in its own statement moves the
     * materialization into that statement's luid slot, restoring retail's
     * lh / sll / lui / addiu / addu / lw order. */
    {
      FogKey **slot = &Fog_gCurrentKeyArr[player];
      key = Fog_FindKey(currentslice,*slot);
      *slot = key;
    }
    /* MATCH: NO cached `nextkey` local -- the oracle re-reads key->next (and
     * key->slice / key->distance) at each use; only `nextslice` is a real
     * variable (it is mutated by += numslices).  The interpolating arm is the
     * FALL-THROUGH (oracle `beq key->distance,next->distance` branches away to
     * the plain-copy arm).
     * MATCH (w39-a10, 15 -> 4): the two `TrackSpec_gSpec.fogspec.start = ...`
     * stores DO funnel through a shared `start` local -- retail's else arm is
     * literally empty (`beq $a1,$v1,.L800E0EA8` jumps straight at the single
     * `sw $a1,%lo(D_80123294)($v0)` with the `lui` in its delay slot, $a1
     * already holding key->distance from the compare).  With two separate store
     * statements our build cannot cross-jump them: the if-arm stores $a1 via a
     * `lui $v1` rematerialised in the mflo delay slot while the else arm stores
     * $a0 via the beq-slot `lui $v0`.  (The w38 note claiming the funnel costs
     * 36 diffs was measured on an older body and is WRONG -- re-verified.)
     * (w39's "residual 4 = scheduling tie" note is now CLOSED -- see the
     * slot-pointer MATCH note below.) */
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
      start = key->distance + final_dist;
    }
    else {
      start = key->distance;
    }
    TrackSpec_gSpec.fogspec.start = start;
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
  int openval;
  
  openval = 1;
  i = 0x1f;
  openkey_walk = openkeys;
  openkey_walk = openkey_walk + 0x1f;
  Fog_gNumKeys = 0;
  Fog_gHeadKey = (FogKey *)0x0;
  do {
    *openkey_walk = openval;
    i = i + -1;
    openkey_walk = openkey_walk + -1;
  } while (-1 < i);
  num_player = Fog_ReadFogKeys();
  if (num_player == 0) {
    Fog_AddKey(0,TrackSpec_gSpec.fogspec.start);
  }
  num_player = 1;
  /* MATCH (w39-a10, 35 -> 4).  Four levers:
   *  (1) PER-ELEMENT gp-rel split of Fog_gCurrentKey (see the header): retail's
   *      .sdata really does carry two separate 4-byte dlabels, and only two
   *      distinct <=G4 objects can produce the oracle's per-element
   *      `%gp_rel(Fog_gCurrentKey)` / `%gp_rel(D_8013DB84)` stores.  Fog_Update
   *      keeps the runtime index and uses the unsized asm-label array view.
   *  (2) SPLIT the openkeys base init (`p = openkeys; p = p + 0x1f;`): the
   *      fused `openkeys + 0x1f` folds the +124 into the %lo reloc (2 insns),
   *      retail emits the discrete third `addiu $v0,$v0,0x7C`.
   *  (3) `openval = 1;` as a real local: the store value is a LICM-hoisted
   *      constant, and loop.c appends its hoisted `li` AFTER the preheader
   *      statements, so ours came out last where retail has it first.
   *  (4) `slice_off = 0;` before the zero-trip guard, `k = slice_off;` inside
   *      it, and the counter increment AFTER the call (not before).
   * w40-a10 (4 -> 2): the residual was NOT an allocno tie -- it was the LOOP
   * FORM.  A natural rotated `for (k = 0; k < num_player; k++)` with the
   * byte offset written as the INDEX EXPRESSION `k * 0x84` gets loop.c to
   * strength-reduce the offset into a giv, and THAT ordering hands the
   * counter $s0 and the giv $s1 (= retail) plus retail's exact schedule
   * (`addiu $s0,$s0,1` before the jal, `addiu $s1,$s1,0x84` in the bnez
   * delay slot).  Every explicit-guard + do-while spelling puts the
   * FIRST-INITIALIZED variable in $s1 (longer live range -> lower allocno
   * priority), so the retail `addu $s0,$zero,$zero; addu $s1,$s0,$zero`
   * init pair is unreachable that way (measured 8/12/14/14/28).
   * RESIDUAL 2 = the zero-trip GUARD OPCODE: ours `blez $s2`, retail
   * `beqz $s2`.  gcc's rotation guard IS the duplicated loop-exit test, so
   * its opcode is fixed by the comparison: signed `k < n` folds to `blez`,
   * `k != n` folds to `beqz` but then the bottom test is a 1-insn `bne`
   * (13 diffs), and an UNSIGNED bound gives `beqz` + `sltu` (2 diffs, the
   * same trade).  A source-level `if (num_player != 0)` around the `for`
   * keeps BOTH guards (59 vs 57 insns).  Mechanism named; a single-opcode
   * residual. */
  Fog_gCurrentKey = Fog_gHeadKey;
  D_8013DB84 = Fog_gHeadKey;
  if (GameSetup_gData.commMode == 1) {
    num_player = 2;
  }
  fogslicePos = reservememadr("fog pos",num_player * 0x84,0);
  /* MATCH: plain base+offset off fogslicePos (oracle re-reads the gp-rel
   * pointer each iteration and does `addu a1,a1,slice_off`). */
  for (k = 0; k < num_player; k = k + 1) {
    BWorldSm_SetSlice(0,(BWorldSm_Pos *)((char *)fogslicePos + k * 0x84));
  }
  slice_off = 0;
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
   * feeds memset's fill arg (oracle: addu a1,s0,zero).
   *
   * FLOOR, QUANTIFIED (72 diffs, COUNT-EXACT 130/130, w39-a10): the body is
   * structurally identical to retail -- same insns, same $s0/$s1 reference
   * counts (22/16 both sides) -- and the ONLY residual is one uniform
   * $s0<->$s1 swap: retail puts `contrast` in $s0 and `weather` in $s1, we do
   * the reverse.  cc1's `-dl`/`-dg` dumps pin it to a RAZOR-EDGE
   * allocno_compare tie (priority = floor_log2(refs)*refs/live_length*10000):
   *     weather  (pseudo 81): 14 refs / 114 insns -> 3684
   *     contrast (pseudo 85): 11 refs /  90 insns -> 3666
   * i.e. 0.5% apart; ONE extra insn inside weather's live range (but before
   * contrast's first def) or one fewer insn of contrast's range flips it.
   * PROVEN by an experiment, NOT adopted: inserting a redundant `color.cd = 0;`
   * before `contrast = 0;` (dead -- the memset zeroes it) flips the pair and
   * takes the function to 3 diffs, the whole body then matching.  That is pure
   * scaffolding (a real extra `sb`, 131 vs 130 insns), so the honest 72-diff
   * form is kept.  Also measured and rejected: memset(&color,contrast,4) (CSE
   * folds the ref back to a literal), a `final_contrast = contrast` copy before
   * the call (regmove propagates it away), a `wthr` copy of the param (+3
   * insns), brightness/uVar1 retyping, decl-order permutations, moving
   * `brightness = 0` ahead of the memset (27 diffs / +3 insns) -- all no-ops or
   * worse.  A 1-insn allocno razor edge with no zero-cost source lever; the
   * C++ permuter is unavailable, so this needs the permuter fix or a retail
   * RTL-level difference we have not found.
   * w40-a10 RE-CHECK (dumps re-run, numbers CONFIRMED unchanged: 81 = 14 refs
   * / 114 insns, 85 = 11 refs / 90 insns, alloc order `83 89 81 85 80 82 84`;
   * track/night already land on retail's $s2/$s3, so ONLY the 81<->85 pair is
   * wrong).  Two more zero-cost ref dials tried and FALSIFIED, both because
   * cc1 folds them before life analysis (the catalog's "copies of a computed
   * value do NOT dial" rule): (a) `brightness = (short)contrast;` instead of
   * `brightness = 0;` -- copy-propagated back to a literal, refs stay 11
   * (lreg dump identical); (b) the embedded-assignment LUID lever
   * `memset(&color, contrast = 0, 4);` -- same, 72 diffs, refs/lengths
   * unchanged.  The arithmetic bound is exact: contrast needs refs>=12
   * (3*12/90 = .400) or live_length<=89 (33/89 = .3708) to beat weather's
   * .36842, and its live range CANNOT start later than the memset (it must
   * cross that call to earn a callee-saved reg at all -- `memset` first then
   * `contrast = 0` leaves it in a caller-saved temp).  Reducing weather's 14
   * refs is possible only by breaking cse's reuse of weather's register as
   * the constant 1 in the three `bne $s3,$s1` night tests -- which requires
   * testing `night` BEFORE `weather` and so contradicts the oracle's
   * track/weather/night compare order at every arm.  FLOOR (STRONG). */
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
