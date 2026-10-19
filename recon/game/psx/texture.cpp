/* game/psx/texture.cpp -- RECONSTRUCTED (NFS4 PSX texture/palette/CLUT/PMX loading; C++ TU)
 *   24 fns (Texture_): palette sharing, CLUT alloc, PMX texture load, VRAM blit. No GTE.
 */
#include "texture_types.h"
#include "texture_externs.h"

/* ---- Texture.obj-OWNED globals (.bss; zero in NFS4.EXE) -- DEFINED here (self-contained;
   storage=EXT in SYM = external linkage, owned by THIS TU, not extern-from-elsewhere) ---- */
Draw_tPixMap    *gMenuPixmap[8];         /* @0x80120fd0 */
Draw_tPixMap     gMenuPixmapAlloc[8];    /* @0x80120ff0 */
int              Texture_CarColor;       /* @0x8013db08 */
Texture_pal8bit *Texture_palCopy;        /* @0x8013db0c */
int              Texture_palNum;         /* @0x8013db10 */
int              Texture_gNum4bitPal;    /* @0x8013db14 */
int              Texture_gNum8bitPal;    /* @0x8013db18 */
Draw_tPixMap   **Texture_gP4bitPmx;      /* @0x8013db1c */
Draw_tPixMap   **Texture_gP8bitPmx;      /* @0x8013db20 */
char           **Texture_gPalette4bit;   /* @0x8013db24 */
char           **Texture_gPalette8bit;   /* @0x8013db28 */
short           *gFreePal4;              /* @0x8013db2c */
int              gNbFreePal4;            /* @0x8013db30 */
short           *gFreePal8;              /* @0x8013db34 */
int              gNbFreePal8;            /* @0x8013db38 */


/* ---- Texture_InitPaletteSharing__Fv  [TEXTURE.CPP:64-70] SLD-VERIFIED ---- */
void Texture_InitPaletteSharing(void)

{
  Texture_gNum4bitPal = 0;
  Texture_gNum8bitPal = 0;
  Texture_gP4bitPmx = reservememadr("pshare 4",0x800,0x10);
  Texture_gP8bitPmx = reservememadr("pshare 8",0x100,0x10);
  Texture_gPalette4bit = reservememadr("pal 4bit",0x800,0x10);
  Texture_gPalette8bit = reservememadr("pal 8bit",0x100,0x10);
}

/* ---- Texture_DeInitPaletteSharing__Fv  [TEXTURE.CPP:74-78] SLD-VERIFIED ---- */
void Texture_DeInitPaletteSharing(void)

{
  purgememadr(Texture_gP4bitPmx);
  purgememadr(Texture_gP8bitPmx);
  purgememadr(Texture_gPalette4bit);
  purgememadr(Texture_gPalette8bit);
}

/* ---- Texture_ResetPaletteSharing__Fv  [TEXTURE.CPP:84-86] SLD-VERIFIED ---- */
void Texture_ResetPaletteSharing(void)

{
  Texture_gNum4bitPal = 0;
  Texture_gNum8bitPal = 0;
}

/* ---- Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi [TEXTURE.CPP:90-139; full SLD open] ---- */
/* 2026-10-18: retail records a separate for-local i and body-local j/indata/
 * checkdata in each palette arm. Restoring those actual owners lets ordinary
 * compare loops use the literal palette lengths and real global counts;
 * no count/num capture or mechanical goto label is needed. Earlier flat-set
 * allocation/rotation misses do not establish source-object necessity. */
int Texture_CheckForSharedPalette(int test,char *data,Draw_tPixMap *pmx,int bpp)

{
  if (test == 0) {
    return 0;
  }
  if (bpp != 0) {
    for (int i = 0; i < Texture_gNum8bitPal; i++) {
      int j;
      int *indata;
      int *checkdata;

      indata = (int *)data;
      checkdata = (int *)Texture_gPalette8bit[i];
      j = 0;
      for (; j < 0x80; j++) {
        if (*indata++ != *checkdata++) break;
      }
      if (j == 0x80) {
        *pmx = *Texture_gP8bitPmx[i];
        return 1;
      }
    }
  }
  else {
    for (int i = 0; i < Texture_gNum4bitPal; i++) {
      int j;
      int *indata;
      int *checkdata;

      indata = (int *)data;
      checkdata = (int *)Texture_gPalette4bit[i];
      j = 0;
      for (; j < 8; j++) {
        if (*indata++ != *checkdata++) break;
      }
      if (j == 8) {
        *pmx = *Texture_gP4bitPmx[i];
        return 1;
      }
    }
  }
  return 0;
}

/* ---- Texture_AddSharedPalette__FPcP12Draw_tPixMapi  [TEXTURE.CPP:143-156] SLD-VERIFIED ---- */
void Texture_AddSharedPalette(char *ptr_to_data,Draw_tPixMap *ptr_to_pmx,int bpp)

{
  /* MATCH: plain index form with the count re-read at each subscript (no
   * palslot/pmxslot temps, no cached `n`) -- gcc CSEs the count load and the
   * common `n*4` scaling exactly like the oracle. */
  if (bpp == 0) {
    Texture_gPalette4bit[Texture_gNum4bitPal] = ptr_to_data;
    Texture_gP4bitPmx[Texture_gNum4bitPal] = ptr_to_pmx;
    Texture_gNum4bitPal = Texture_gNum4bitPal + 1;
    return;
  }
  if (bpp == 1) {
    Texture_gPalette8bit[Texture_gNum8bitPal] = ptr_to_data;
    Texture_gP8bitPmx[Texture_gNum8bitPal] = ptr_to_pmx;
    Texture_gNum8bitPal = Texture_gNum8bitPal + 1;
  }
  return;
}

/* ---- Texture_InitClut__Fv  [TEXTURE.CPP:182-215] SLD-VERIFIED ---- */
void Texture_InitClut(void)

{
  /* MATCH (w40-a10, 16 -> PASS): the SYM `8c` block for this function lists
   * EXACTLY TWO named REG locals -- `x` ($7) and `y` ($5) -- and NOTHING else.
   * The w39 body carried invented `clut` and `cbase` locals SHARED across all
   * three loop nests, which fused three independent compiler temps into one
   * pseudo each and mis-coloured loop 1 (retail keeps loop 1's clut in $v1 and
   * ORs cbase into it IN PLACE so the rotated `sll $v1,$a1,6` fills the
   * back-edge delay slot; the shared local forced a fresh $v0 dest + a `nop`).
   * Writing every clut/cbase as an INLINE EXPRESSION -- the SYM-faithful shape
   * -- gives each nest its own temp and reproduces retail exactly.
   * (Intermediate evidence: a loop-1-private `clut1` alone = 8 diffs; adding
   * per-loop `cbase2`/`cbase3` = PASS; per-loop `y` copies REGRESS (26-35), so
   * `y` really is the one shared counter the SYM names.  The w39 note's
   * "source-hoisted cbase" lever and its 49-54-diff rotation dead end were
   * both artifacts of the shared locals.) */
  int x;
  int y;

  x = 0;
  gNbFreePal4 = 0;
  do {
    y = 0;
    for (; y < 0x78; y++) {
      gFreePal4[gNbFreePal4++] = (u_short)(y * 0x40) | ((u_short)(x >> 4) & 0x3f);
    }
    x = x + 0x10;
  } while (x < 0x100);
  x = 0;
  do {
    y = 0;
    for (; y < 0x20; y++) {
      gFreePal4[gNbFreePal4++] = (u_short)(0x2000 + y * 0x40) | ((u_short)(x >> 4) & 0x3f);
    }
    x = x + 0x10;
  } while (x < 0x80);
  x = 0;
  gNbFreePal8 = 0;
  do {
    y = 0;
    for (; y < 8; y++) {
      gFreePal8[gNbFreePal8++] = (u_short)(0x1e00 + y * 0x40) | ((u_short)(x >> 4) & 0x3f);
    }
    x = x + 0x100;
  } while (x < 0x100);
  return;
}

/* ---- Texture_GetClutId__FiPiT1  [TEXTURE.CPP:221-254] SLD-VERIFIED ---- */
void Texture_GetClutId(int bpp,int *xclut,int *yclut)

{
  short id;

  /* MATCH: direct global decrement + index (no newNb4/newNb8/freelist/count
   * scaffolding) -- the oracle zeroes `id` before the bpp branch and both arms
   * cross-jump into one shared `base + idx*2; lhu` tail. */
  id = 0;
  if (bpp == 0) {
    if (gNbFreePal4 != 0) {
      gNbFreePal4 = gNbFreePal4 - 1;
      id = gFreePal4[gNbFreePal4];
    }
  }
  else {
    if (gNbFreePal8 != 0) {
      gNbFreePal8 = gNbFreePal8 - 1;
      id = gFreePal8[gNbFreePal8];
    }
  }
  *xclut = (id & 0x3f) << 4;
  *yclut = (int)(id << 0x10) >> 0x16;
  return;
}

/* ---- Texture_MenuReleaseClutId__Fs  [TEXTURE.CPP:304-320] SLD-VERIFIED ---- */
void Texture_MenuReleaseClutId(short id)

{
  int yclut;

  yclut = (int)((u_int)(u_short)id << 0x10) >> 0x16;
  if (yclut < 0x1e8) {
    gFreePal8[gNbFreePal8++] = id;
    return;
  }
  gFreePal4[gNbFreePal4++] = id;
  return;
}

/* ---- Texture_ColorCarPalette__FPcT0i  [TEXTURE.CPP:327-334] SLD-VERIFIED ---- */
void Texture_ColorCarPalette(char *from,char *to,int numentry)

{
  numentry = numentry + -1;
  from = from + Texture_CarColor * 0x20;
  if (numentry != -1) {
    do {
      *(short *)to = *(short *)from;
      from = from + 2;
      numentry = numentry + -1;
      to = (char *)((int)to + 2);
    } while (numentry != -1);
  }
  return;
}

/* ---- Texture_CopyPalette__FPciii  [TEXTURE.CPP:339-352] SLD-VERIFIED ---- */
/* SYM locals (no separate 'slot' local -- fold the address inline, SYM order i/dest/source).
 * `zero` is a runtime-zero device (permuter-derived, cf. methodology sec 3.13 "^ zero"):
 * a typed 0-holder shared by the counter init AND the initial-guard compare is what pins
 * i/dest onto the oracle's t0/t1 pair instead of the reverse coloring. Pin-free (plain C). */
void Texture_CopyPalette(char *data,int width,int x,int y)

{
  int i;
  short *dest;
  short *source;
  u_char zero; /* SYM-CODEGEN-CARRIER: zero -- pins retail's counter/destination coloring */

  zero = 0;
  i = zero;
  (Texture_palCopy + Texture_palNum)->x = x;
  (Texture_palCopy + Texture_palNum)->y = y;
  dest = (Texture_palCopy + Texture_palNum)->pal;
  source = (short *)data;
  if (zero < width) {
    do {
      *dest = *source;
      source = source + 1;
      i = i + 1;
      dest = dest + 1;
    } while (i < width);
  }
  Texture_palNum = Texture_palNum + 1;
  return;
}

/* ---- Texture_ProcessPaletteCopy__FP15Texture_pal8bitii  [TEXTURE.CPP:356-378] SLD-VERIFIED ---- */
void Texture_ProcessPaletteCopy(Texture_pal8bit *palCopy,int palStart,int palNum)

{
  RECT r;
  int i;
  short tmpPal [16];

  /* MATCH: INDEX form palCopy[i].* everywhere and NO `src` walker -- a walking
   * `src` pointer makes gcc build a SECOND induction variable for `src->pal`
   * (= src+8), costing an extra saved reg and 4 insns.  With the index form
   * loop.c strength-reduces to the oracle's single $s0 walker (+0x208/iter) and
   * rematerializes `s0+8` in the back-edge delay slot.  `i = i + 1` LAST (after
   * the LoadImage call) is what puts the increment in the oracle's slot. */
  if (palCopy != (Texture_pal8bit *)0x0) {
    i = palStart;
    r.w = 0x10;
    r.h = 1;
    if (i < palNum) {
      do {
        Texture_ColorCarPalette((char *)palCopy[i].pal,(char *)tmpPal,0x10);
        r.x = (short)palCopy[i].x;
        r.y = (short)palCopy[i].y;
        LoadImage(&r,(u_long *)tmpPal);
        i = i + 1;
      } while (i < palNum);
    }
  }
  return;
}

/* ---- Texture_LoadImage__FP4RECTPUl  [TEXTURE.CPP:393-396] SLD-VERIFIED ---- */
void Texture_LoadImage(RECT *imgrect,u_long *p)

{
  if ((imgrect->w & 1U) != 0) {
    imgrect->h = imgrect->h | 1;
  }
  LoadImage(imgrect,p);
  return;
}

/* ---- Texture_Vramf__FP8shapetbliiii [TEXTURE.CPP:406-457; full source/SYM/SLD open] ---- */
/* 2026-10-18: direct signed division, real type/next fields and conditional
 * link selection remove rowpix/rowround/kind/nextshp without changing107words.
 * Keep the separate range predicates and two source calls: GCC merges their
 * actual call site. Historical full probes/backups: build/nc12/texture_vramf_source_20261018.
 * SOURCE-REVIEW-UNRESOLVED: deadfrm is an existing artificial frame filler,
 * not a recovered source object. Without it the frame is64, not retail80.
 * Ordinary division alone does not recover the16bytes; actual RECT aggregate
 * assignment gives72 plus extra instructions. Recover the real producer.
 * The first shapex raw-word view also remains a source-shape question: typed
 * assignment after these capture removals still hoists another saved register
 * and adds two compiler rows. No fake-use/qualifier/asm replacement is added. */
void Texture_Vramf(shapetbl *shp,int x,int y,int clutx,int cluty)

{
  RECT r;
  int deadfrm[4]; /* SOURCE-REVIEW-UNRESOLVED: artificial padding, absent from retail. */

  if (shp != (shapetbl *)0x0) {
    do {
      if (((u_int)shp->type & 0xf7) != 0x23) {
        if (0x22 < ((u_int)shp->type & 0xf7)) {
          if (((u_int)shp->type & 0xf7) < 0x44) {
            if (0x3f < ((u_int)shp->type & 0xf7)) {
              *(u_int *)((char *)shp + 0xc) =
                  (*(u_int *)((char *)shp + 0xc) & 0xfffff000) | (x & 0xfff);
              shp->shapey = y;
              shp->type |= 8;
              r.x = (short)x;
              r.y = (short)y;
              r.w = (short)((shp->width * shapedepth(shp) + 15) / 16);
              r.h = shp->height;
              Texture_LoadImage(&r,(u_long *)&shp->data);
            }
          }
        }
      }
      else if (-1 < clutx) {
        shp->shapex = clutx;
        shp->shapey = cluty;
        shp->type |= 8;
        r.x = (short)clutx;
        r.y = (short)cluty;
        r.w = shp->width;
        r.h = 1;
        Texture_LoadImage(&r,(u_long *)&shp->data);
      }
      shp = (shp->next != 0) ? (shapetbl *)((char *)shp + shp->next) : (shapetbl *)0;
    } while (shp != (shapetbl *)0x0);
  }
  return;
}

/* ---- Texture_Vramcf__FP8shapetbliiii [TEXTURE.CPP:468-507; full SLD open] ---- */
/* 2026-10-18: retail owns rowbytes at the root and r/height/s in the guarded
 * correction body. Direct byte-row and coordinate expressions remove the
 * unrecorded h/rowall/off/ybot captures. Keep arithmetic right shifts: signed
 * division or an unsigned shift changes the measured compiler stream. */
void Texture_Vramcf(shapetbl *shp,int x,int y,int clutx,int cluty)

{
  int rowbytes;

  rowbytes = ((shp->width * shapedepth(shp) + 15) & ~15) >> 3;
  if (((rowbytes & 2) != 0) && (((u_short)shp->height & 1) == 0)) {
    RECT r;
    int height;
    char *s;

    height = (short)shp->height;
    s = &shp->data + (height - 1) * rowbytes;
    r.y = y + height - 2;
    r.x = (short)x;
    r.w = 1;
    r.h = 2;
    LoadImage(&r,(u_long *)(s - 2));
    r.x = (short)x + 1;
    r.y = y + height - 1;
    r.w = (rowbytes >> 1) - 1;
    r.h = 1;
    LoadImage(&r,(u_long *)(s + 2));
    shp->height = shp->height - 1;
    Texture_Vramf(shp,x,y,clutx,cluty);
    shp->height = height;
  }
  else {
    Texture_Vramf(shp,x,y,clutx,cluty);
  }
  return;
}

/* ---- Texture_GetTranslucencyMode__FP8shapetbl [TEXTURE.CPP:514-532; full SLD still open] ---- */
/* MATCH (w40-a10, 4 -> PASS): `return 0` must be the loop's POST-EXIT
   * fall-through (`if (shp == 0) break;` + a trailing `return 0;`), NOT an
   * inline early-return inside the guard.  Written inline, gcc's post-reload
   * cross-jump pass merges the two `jr ra` tails (`move v0,0; jr ra` and the
   * bare `jr ra`), leaving `move v0,0; j <shared tail>`; reorg then EAGER-
   * STEALS that `move` into the `beqz $a0` delay slot -- 28 insns vs the
   * oracle's 30, with the oracle's separate `.L800DFF08: jr ra; addu v0,zero,
   * zero` block gone.  As the post-loop block it stays its own return block
   * and dbr fills its OWN `jr ra` slot with the `move`.  (This REFUTES the
   * catalog's "dual `jr ra` tails always cross-jump-merge" negative for this
   * shape; `goto ret0;`+label and the `else { return 0; }` arm PASS too, the
   * `return 0` position is what matters, not the spelling.  A named `zero`
   * local instead regresses to 9.)
   * NOTE the clamp must stay IN PLACE (`if (abr == 3) abr = 2;` then one
   * return): jump-opt splits it into the oracle's own `bne v0,a3,.L800DFF10;
   * jr ra; addiu v0,2` tail.  Explicit two-return spellings measured
   * 14/16/19. */
/* 2026-10-18: retail owns USHORT abr in the 'k' branch, not at function
 * scope. Its actual declaration restores all local/type/home/owner records
 * and the full eight-boundary region tree without changing any of30words.
 * Exact original spelling and complete SLD attribution remain unsealed. */
int Texture_GetTranslucencyMode(shapetbl *shp)

{
  while( true ) {
    if (shp == (shapetbl *)0x0) break;
    if (*(char *)shp == 'k') {
      u_short abr;
      abr = (u_short)shp->width >> 5 & 3;
      if (abr == 3) { abr = 2; }
      return abr;
    }
    if ((*(u_int *)shp & 0xffffff00) != 0) {
      shp = (shapetbl *)((int)&(*(u_int *)((char *)shp + 0x0)) + ((int)*(u_int *)shp >> 8));
    }
    else {
      shp = (shapetbl *)0x0;
    }
  }
  return 0;
}

/* ---- Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap  [TEXTURE.CPP:538-667] SLD-FLAG:NONMONO ---- */
/* 2026-10-18: the real transposed bitfield with ordinary true/false assignment
 * arms reproduces the masked-word/Boolean sequence without an fl capture or
 * byte-offset view. Direct Boolean assignment and reusing rotated as the mask
 * do not produce the same compiler stream on this shape. Full SLD is open. */
void Texture_LoadPmx(char *f,char *n,int ctrl,int rx,int ry,int cx,int cy,Draw_tPixMap *pmx)

{
  /* SYM-driven local set (rule 8): shpptr=$s0 x=$s5 y=$s6 u=$a0 v=$a1 h=$fp
   * bpp=$s4 clutptr=$s1, and the AUTO spill slots w@sp+24 rotated@sp+28
   * bshapex@32 bshapey@36 bwidth@40 bheight@44 bpp_real@48 bwidthclut@52.
   * The earlier reconstruction folded all of these into inline expressions and
   * came out 316 diffs; materializing them as real C locals (with bshapex/
   * bshapey/clutptr as the 12-bit `shapex`/`shapey`/`next` BITFIELDS rather
   * than hand-rolled shifts and a `paloff` int) is the whole match. */
  shapetbl *shpptr;
  int x;
  int y;
  int u;
  int v;
  int w;
  int h;
  int rotated;
  int bpp;
  int bshapex;
  int bshapey;
  int bwidth;
  int bheight;

  if (f != (char *)0x0) {
    shpptr = (shapetbl *)locateshapez(f,n);
  }
  else {
    shpptr = (shapetbl *)n;
  }
  if (shpptr != (shapetbl *)0x0) {
    int bpp_real;

    bshapex = shpptr->shapex;
    bshapey = shpptr->shapey;
    bpp = shpptr->type & 3;
    bpp_real = bpp;
    bwidth = shpptr->width;
    bheight = shpptr->height;
    if (((ctrl & 8U) != 0) && (bpp_real != 0)) {
      bpp = 0;
    }
    if (shpptr->transposed) {
      rotated = 1;
    }
    else {
      rotated = 0;
    }
    if (rx == -1) {
      x = 0;
      y = 0xa0;
      shpptr->width = 1;
      shpptr->height = 1;
    }
    else {
      x = shpptr->shapex + rx;
      y = shpptr->shapey + ry;
    }
    w = shpptr->width;
    h = shpptr->height;
    if ((ctrl & 1U) == 0) {
      w = w + -1;
      h = h + -1;
    }
    if (bpp != 2) {
      shapetbl *clutptr;
      int bwidthclut;

      clutptr = (shapetbl *)((int)shpptr + (*(int *)shpptr >> 8));
      bwidthclut = clutptr->width;
      if (bpp == 0) {
        clutptr->width = 0x10;
      }
      else {
        clutptr->width = 0x100;
      }
      if (Texture_CheckForSharedPalette(ctrl & 0x40,&clutptr->data,pmx,bpp) == 0) {
        if (cx == -1) {
          Texture_GetClutId(bpp,&cx,&cy);
        }
        else if (cx == -3) {
          pmx->pad2 = (u_short)TextureProcess_DepthColorCluts(&clutptr->data,clutptr->width);
        }
        else if (cx == -2) {
          cy = 0xa0;
          cx = 0;
          clutptr->width = 1;
        }
        if ((ctrl & 2U) != 0) {
          pmx->flag = (u_short)(TextureProcess_TransColorCheck(&clutptr->data,clutptr->width) << 1);
        }
        if (((ctrl & 8U) != 0) && (bpp_real != 0)) {
          if (Texture_palCopy != (Texture_pal8bit *)0x0) {
            Texture_CopyPalette(&clutptr->data,bwidthclut,cx,cy);
          }
          if ((ctrl & 0x10U) != 0) {
            Texture_ColorCarPalette(&clutptr->data,&clutptr->data,0x10);
          }
        }
        /* MATCH: GetClut arm FIRST -- the oracle keeps two separate
         * `sh v0,2(s2)` stores (the fall-through one sits in a `j`'s delay
         * slot); with the 0xffff arm first gcc cross-jumps them into one. */
        if (0 <= cx) {
          pmx->clut = GetClut(cx,cy);
        }
        else {
          pmx->clut = 0xffff;
        }
        if ((ctrl & 0x40U) != 0) {
          Texture_AddSharedPalette(&clutptr->data,pmx,bpp);
        }
      }
      if ((ctrl & 0x20U) != 0) {
        Texture_Vramcf(shpptr,x,y,-1,-1);
      }
      else {
        Texture_Vramcf(shpptr,x,y,cx,cy);
      }
      clutptr->width = (short)bwidthclut;
    }
    else {
      Texture_Vramcf(shpptr,x,y,0,0);
    }
    pmx->tpage = GetTPage(bpp,Texture_GetTranslucencyMode(shpptr),x,y);
    u = x % 0x40;
    v = y % 0x100;
    if (bpp == 0) {
      u = u * 4;
    }
    if (bpp == 1) {
      u = u << 1;
    }
    if (rotated != 0) {
      pmx->u0 = u;
      pmx->v0 = v + h;
      pmx->u1 = u;
      pmx->v1 = v;
      pmx->u2 = u + w;
      pmx->v2 = v + h;
      pmx->u3 = u + w;
      pmx->v3 = v;
    }
    else {
      pmx->u0 = u;
      pmx->v0 = v;
      pmx->u1 = u + w;
      pmx->v1 = v;
      pmx->u2 = u;
      pmx->v2 = v + h;
      pmx->u3 = u + w;
      pmx->v3 = v + h;
    }
    shpptr->width = (short)bwidth;
    shpptr->height = (short)bheight;
    shpptr->shapex = bshapex;
    shpptr->shapey = bshapey;
  }
  return;
}

/* ---- Texture_CloneUVPmx__FP12Draw_tPixMapiT0  [TEXTURE.CPP:672-707] SLD-VERIFIED ---- */
void Texture_CloneUVPmx(Draw_tPixMap *pmx,int mode,Draw_tPixMap *rpmx)

{
  /* MATCH: each u/v pair is copied as ONE 16-bit unit (oracle: lhu/sh at
   * 0/4/8/0xC) -- the per-byte `t = pmx->vN; rpmx->uM = pmx->uN; rpmx->vM = t;`
   * form emits 3 insns per pair (110 insns vs 88). */
  *rpmx = *pmx;
  switch(mode) {
  case 0:
    *(u_short *)&rpmx->u0 = *(u_short *)&pmx->u1;
    *(u_short *)&rpmx->u1 = *(u_short *)&pmx->u0;
    *(u_short *)&rpmx->u2 = *(u_short *)&pmx->u3;
    *(u_short *)&rpmx->u3 = *(u_short *)&pmx->u2;
    return;
  case 1:
    *(u_short *)&rpmx->u3 = *(u_short *)&pmx->u1;
    *(u_short *)&rpmx->u1 = *(u_short *)&pmx->u3;
    *(u_short *)&rpmx->u2 = *(u_short *)&pmx->u0;
    *(u_short *)&rpmx->u0 = *(u_short *)&pmx->u2;
    return;
  case 2:
    *(u_short *)&rpmx->u0 = *(u_short *)&pmx->u2;
    *(u_short *)&rpmx->u1 = *(u_short *)&pmx->u0;
    *(u_short *)&rpmx->u3 = *(u_short *)&pmx->u1;
    *(u_short *)&rpmx->u2 = *(u_short *)&pmx->u3;
    return;
  case 3:
    *(u_short *)&rpmx->u0 = *(u_short *)&pmx->u3;
    *(u_short *)&rpmx->u1 = *(u_short *)&pmx->u2;
    *(u_short *)&rpmx->u3 = *(u_short *)&pmx->u0;
    *(u_short *)&rpmx->u2 = *(u_short *)&pmx->u1;
    return;
  case 4:
    *(u_short *)&rpmx->u0 = *(u_short *)&pmx->u1;
    *(u_short *)&rpmx->u1 = *(u_short *)&pmx->u3;
    *(u_short *)&rpmx->u3 = *(u_short *)&pmx->u2;
    *(u_short *)&rpmx->u2 = *(u_short *)&pmx->u0;
  }
  return;
}

/* ---- Texture_InitTrackTexture__Fv  [TEXTURE.CPP:726-738] SLD-VERIFIED ---- */
void Texture_InitTrackTexture(void)

{
  gFreePal4 = (short *)Platform_GetDCTBuffer(0x13f0,"4 bit Cluts");
  gFreePal8 = (short *)Platform_GetDCTBuffer(0x10,"8 bit Cluts");
  Texture_InitPaletteSharing();
  TextureProcess_Init();
  Texture_InitClut();
  return;
}

/* ---- Texture_InitMenuClut__Fv [TEXTURE.CPP:743-776; full SLD still open] ---- */
/* 2026-10-18: retail records separate x/y objects in these two initialization
 * regions. Restore those owners before pricing the coordinate expression:
 * canonical PsyQ getClut(x,y) = (y<<6)|((x>>4)&0x3f) then matches without
 * pal4/pal8, clut or cbase. Earlier direct-expression misses were specific
 * to the flattened local set. Literal macro spelling/full SLD remain open. */
void Texture_InitMenuClut(void)

{
  {
    int x;
    int y;

    gFreePal4 = reservememadr("4 bits cluts",0x300,0);
    gFreePal8 = reservememadr("8 bits cluts",0x1180,0);
    x = 0;
    gNbFreePal4 = 0;
    for (; x < 0x100; x += 0x10) {
      y = 0;
      for (; y < 0x18; y++) {
        gFreePal4[gNbFreePal4++] = ((y + 0x1e8) << 6) | (((x + 0x200) >> 4) & 0x3f);
      }
    }
  }
  {
    int x;
    int y;

    x = 0;
    gNbFreePal8 = 0;
    for (; x < 0x100; x += 0x100) {
      y = 0;
      for (; y < 0x8c; y++) {
        gFreePal8[gNbFreePal8++] = ((y + 0x15c) << 6) | (((x + 0x200) >> 4) & 0x3f);
      }
    }
  }
  return;
}

/* ---- Texture_InitMenuTexture__Fv  [TEXTURE.CPP:792-795] SLD-VERIFIED ---- */
void Texture_InitMenuTexture(void)

{
  int i;

  i = 7;
  do {
    gMenuPixmap[i] = (Draw_tPixMap *)0x0;
    i = i + -1;
  } while (-1 < i);
  return;
}

/* ---- Texture_CleanupMenuTexture__Fv  [TEXTURE.CPP:799-807] SLD-VERIFIED ---- */
void Texture_CleanupMenuTexture(void)

{
  int i;
  
  i = 0;
  do {
    if (gMenuPixmap[i] != (Draw_tPixMap *)0x0) {
      Texture_MenuReleaseClutId(gMenuPixmap[i]->clut);
    }
    gMenuPixmap[i] = (Draw_tPixMap *)0x0;
    i = i + 1;
  } while (i < 8);
  return;
}

/* ---- Texture_LoadMenuTexture__Fv [TEXTURE.CPP:811-844; full SYM/SLD still open] ---- */
/* SOURCE-REVIEW-UNRESOLVED: retail supplies these five pmx locals, preceded
 * by one empty optimized sibling region. Their names/types/homes/depths and
 * real call/store uses are restored here; that first region's producer remains
 * unknown. No extra first pmx, dummy declaration or empty padding block is
 * added to make the child paths match. Exact original load-macro text is open. */
void Texture_LoadMenuTexture(void)

{
  char name [255];
  char *shpfile;

  if (gMenuPixmap[0] != (Draw_tPixMap *)0x0) {
    return;
  }
  sprintf(name,"%sshow.psh",Paths_Paths[0x19]);
  shpfile = (char *)loadfileadr(name,0);
  Texture_ResetPaletteSharing();
  Texture_LoadPmx(shpfile,"show",0,0x380,0x180,-1,-1,gMenuPixmapAlloc);
  gMenuPixmap[0] = gMenuPixmapAlloc;
  {
    Draw_tPixMap *pmx = gMenuPixmapAlloc + 1;
    Texture_LoadPmx(shpfile,"shad",0,0x380,0x180,-1,-1,pmx);
    gMenuPixmap[1] = pmx;
  }
  {
    Draw_tPixMap *pmx = gMenuPixmapAlloc + 2;
    Texture_LoadPmx(shpfile,"lgt3",0,0x380,0x180,-1,-1,pmx);
    gMenuPixmap[3] = pmx;
  }
  {
    Draw_tPixMap *pmx = gMenuPixmapAlloc + 3;
    Texture_LoadPmx(shpfile,"lgta",0,0x380,0x180,-1,-1,pmx);
    gMenuPixmap[4] = pmx;
  }
  {
    Draw_tPixMap *pmx = gMenuPixmapAlloc + 4;
    Texture_LoadPmx(shpfile,"lgtb",0,0x380,0x180,-1,-1,pmx);
    gMenuPixmap[5] = pmx;
  }
  {
    Draw_tPixMap *pmx = gMenuPixmapAlloc + 5;
    Texture_LoadPmx(shpfile,"lgtc",0,0x380,0x180,-1,-1,pmx);
    gMenuPixmap[6] = pmx;
  }
  purgememadr(shpfile);
  return;
}

/* ---- Texture_KillTrackTexture__Fv  [TEXTURE.CPP:847-851] SLD-VERIFIED ---- */
void Texture_KillTrackTexture(void)

{
  return;
}

/* ---- Texture_KillMenuTexture__Fv  [TEXTURE.CPP:855-858] SLD-VERIFIED ---- */
void Texture_KillMenuTexture(void)

{

  purgememadr(gFreePal4);
  purgememadr(gFreePal8);
}

/* end of texture.cpp */
