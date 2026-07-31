/* game/psx/texture.cpp -- RECONSTRUCTED (NFS4 PSX texture/palette/CLUT/PMX loading; C++ TU)
 *   26 fns (Texture_ + FETexture_): palette sharing, CLUT alloc, PMX texture load, VRAM blit. No GTE.
 */
#include "../../nfs4_types.h"
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
  return;
}

/* ---- Texture_DeInitPaletteSharing__Fv  [TEXTURE.CPP:74-78] SLD-VERIFIED ---- */
void Texture_DeInitPaletteSharing(void)

{
  purgememadr(Texture_gP4bitPmx);
  purgememadr(Texture_gP8bitPmx);
  purgememadr(Texture_gPalette4bit);
  purgememadr(Texture_gPalette8bit);
  return;
}

/* ---- Texture_ResetPaletteSharing__Fv  [TEXTURE.CPP:84-86] SLD-VERIFIED ---- */
void Texture_ResetPaletteSharing(void)

{
  Texture_gNum4bitPal = 0;
  Texture_gNum8bitPal = 0;
  return;
}

/* ---- Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi  [TEXTURE.CPP:90-139] SLD-VERIFIED ---- */
int Texture_CheckForSharedPalette(int test,char *data,Draw_tPixMap *pmx,int bpp)

{
  int i;
  int j;
  int count;             /* MATCH: a NAMED entry-count local -- gcc propagates the
                          * literal into the inner `slti` but keeps the register
                          * for the `beq j,count` full-match test (oracle $t4). */
  int num;
  int *indata;
  int *checkdata;

  if (test == 0) {
    return 0;
  }
  /* MATCH: `i = 0` lives INSIDE each arm -- gcc then knows i==0 at the
   * strength-reduction giv init and emits a bare `lw t2,%gp_rel(table)` instead
   * of `base + i*4`; it still cross-jumps the two zeroings into the bpp branch's
   * delay slot exactly like the oracle. */
  if (bpp != 0) {
    i = 0;
    count = 0x80;
    num = Texture_gNum8bitPal;
    while (1) {
      if (!(i < num)) break;
      indata = (int *)data;
      /* MATCH: INDEX form Texture_gPalette8bit[i] (not a walked `pal` pointer) --
       * loop.c strength-reduces it to the oracle's walking $t2 AND the extra `i`
       * references lift i's allocno above it (oracle i=$t1, walker=$t2). */
      checkdata = (int *)Texture_gPalette8bit[i];
      j = 0;
      /* MATCH: explicit goto-loop -- a `do { if(..) break; j++; } while(j<N)`
       * gets rotated by gcc into an entry-jump + top increment/test; the label
       * form reproduces the oracle's body/increment/bottom-test topology.
       * Compare operand order is load order: *indata first. */
inner8:
      if (*indata++ != *checkdata++) goto done8;
      j = j + 1;
      if (j < 0x80) goto inner8;
done8:
      if (j == count) {
        *pmx = *Texture_gP8bitPmx[i];
        return 1;
      }
      i = i + 1;
    }
  }
  else {
    i = 0;
    count = 8;
    num = Texture_gNum4bitPal;
    while (1) {
      if (!(i < num)) break;
      indata = (int *)data;
      checkdata = (int *)Texture_gPalette4bit[i];
      j = 0;
inner4:
      if (*indata++ != *checkdata++) goto done4;
      j = j + 1;
      if (j < 8) goto inner4;
done4:
      if (j == count) {
        *pmx = *Texture_gP4bitPmx[i];
        return 1;
      }
      i = i + 1;
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
  int clut;
  int idx;
  int x;
  int y;

  x = 0;
  gNbFreePal4 = 0;
  do {
    y = 0;
    clut = 0;
    do {
      y = y + 1;
      idx = gNbFreePal4 + 1;
      gFreePal4[gNbFreePal4] = (u_short)clut | (u_short)(x >> 4) & 0x3f;
      clut = y * 0x40;
      gNbFreePal4 = idx;
    } while (y < 0x78);
    x = x + 0x10;
  } while (x < 0x100);
  x = 0;
  do {
    y = 0;
    clut = 0x2000;
    do {
      y = y + 1;
      idx = gNbFreePal4 + 1;
      gFreePal4[gNbFreePal4] = (u_short)clut | (u_short)(x >> 4) & 0x3f;
      clut = clut + 0x40;
      gNbFreePal4 = idx;
    } while (y < 0x20);
    x = x + 0x10;
  } while (x < 0x80);
  x = 0;
  gNbFreePal8 = 0;
  do {
    y = 0;
    clut = 0x1e00;
    do {
      y = y + 1;
      idx = gNbFreePal8 + 1;
      gFreePal8[gNbFreePal8] = (u_short)clut | (u_short)(x >> 4) & 0x3f;
      gNbFreePal8 = idx;
      clut = clut + 0x40;
    } while (y < 8);
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
  int count;
  short *src;
  short entry;
  
  count = numentry + -1;
  src = (short *)(from + Texture_CarColor * 0x20);
  if (numentry != 0) {
    do {
      entry = *src;
      src = src + 1;
      count = count + -1;
      *(short *)to = entry;
      to = (char *)((int)to + 2);
    } while (count != -1);
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
  short *dest;
  int i;
  short *source;
  u_char zero;
  short entry;

  zero = 0;
  i = zero;
  (Texture_palCopy + Texture_palNum)->x = x;
  (Texture_palCopy + Texture_palNum)->y = y;
  dest = (Texture_palCopy + Texture_palNum)->pal;
  source = (short *)data;
  if (zero < width) {
    do {
      entry = *source;
      source = source + 1;
      i = i + 1;
      *dest = entry;
      dest = dest + 1;
    } while (i < width);
  }
  Texture_palNum = Texture_palNum + 1;
  return;
}

/* ---- Texture_ProcessPaletteCopy__FP15Texture_pal8bitii  [TEXTURE.CPP:356-378] SLD-VERIFIED ---- */
void Texture_ProcessPaletteCopy(Texture_pal8bit *palCopy,int palStart,int palNum)

{
  Texture_pal8bit *src;
  int i;
  RECT r;
  short tmpPal [16];

  if (palCopy != (Texture_pal8bit *)0x0) {
    i = palStart;
    r.w = 0x10;
    r.h = 1;
    if (i < palNum) {
      src = palCopy + i;
      do {
        Texture_ColorCarPalette((char *)src->pal,(char *)tmpPal,0x10);
        r.x = (short)src->x;
        i = i + 1;
        r.y = (short)src->y;
        src = src + 1;
        LoadImage(&r,(u_long *)tmpPal);
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

/* ---- Texture_Vramf__FP8shapetbliiii  [TEXTURE.CPP:406-457] SLD-VERIFIED ---- */
void Texture_Vramf(shapetbl *shp,int x,int y,int clutx,int cluty)

{
  int rowpix;
  int rowround;
  u_int kind;            /* MATCH: UNSIGNED -- the oracle compares with sltu/sltiu */
  shapetbl *nextshp;     /* MATCH: the list advance funnels through a temp that is
                          * then copied into shp (oracle: addu a0,...; addu s0,a0). */
  RECT r;
  int deadfrm[4];        /* MATCH: SYM says fsize=80 with `r` the ONLY named AUTO
                          * (at -0x40 => sp+0x10) and mask=$80ff0000 (ra + s0-s7,
                          * NO $fp).  16 bytes of gcc temp space sit above `r`;
                          * this filler reproduces the frame size. */

  if (shp != (shapetbl *)0x0) {
    do {
      kind = *(u_char *)shp & 0xf7;
      /* MATCH: the TEX arm is the fall-through and is emitted FIRST (the oracle
       * hoists (y&0xfff)<<16 into $s7 BEFORE (cluty&0xfff)<<16 into $s6, which
       * follows the RTL order of the two arm bodies); the CLUT body sits
       * out-of-line at the beq target.  The three range tests must be SEPARATE
       * nested ifs -- as one `&&` chain gcc folds `0x3f<kind && kind<0x44`
       * into `(u)(kind-0x40) < 4` and drops the `0x22<kind` test entirely.
       * The LoadImage call is written in BOTH arms; gcc cross-jumps only the
       * `jal` itself, matching the oracle's per-arm a0/a1 setup. */
      if (kind != 0x23) {
        if (0x22 < kind) { if (kind < 0x44) { if (0x3f < kind) {
          /* MATCH: two real BITFIELD assignments (lw / and ~0xfff / or x&0xfff /
           * and 0xf000ffff / or (y&0xfff)<<16 / sw), NOT one fused
           * `word & 0xf000f000 | ...` expression which collapses to a single
           * `and`.  FLOOR (18 diffs, ours 109/107): our cc1 additionally hoists
           * `x & 0xfff` out of the loop into $fp (+sw/lw fp), which the retail
           * loop.c cost model refused -- it hoists only the two 2-insn
           * `(v&0xfff)<<16` movables and the -0x1000 constant.  Tried: bitfield
           * store order swaps, type-first order, dropping the frame filler,
           * u_char kind -- none suppress the extra savings-1 hoist. */
          shp->shapex = x;
          shp->shapey = y;
          *(u_char *)shp = *(u_char *)shp | 8;
          r.x = (short)x;
          r.y = (short)y;
          rowpix = shp->width * shapedepth(shp);
          rowround = rowpix + 0xf;
          if (rowround < 0) {
            rowround = rowpix + 0x1e;
          }
          r.w = (short)(rowround >> 4);
          r.h = shp->height;
          Texture_LoadImage(&r,(u_long *)&shp->data);
        } } }
      }
      else if (-1 < clutx) {
        shp->shapex = clutx;
        shp->shapey = cluty;
        *(u_char *)shp = *(u_char *)shp | 8;
        r.x = (short)clutx;
        r.y = (short)cluty;
        r.w = shp->width;
        r.h = 1;
        Texture_LoadImage(&r,(u_long *)&shp->data);
      }
      if ((*(u_int *)shp & 0xffffff00) != 0) {
        nextshp = (shapetbl *)((int)shp + ((int)*(u_int *)shp >> 8));
      }
      else {
        nextshp = (shapetbl *)0x0;
      }
      shp = nextshp;
    } while (shp != (shapetbl *)0x0);
  }
  return;
}

/* ---- Texture_Vramcf__FP8shapetbliiii  [TEXTURE.CPP:468-507] SLD-VERIFIED ---- */
void Texture_Vramcf(shapetbl *shp,int x,int y,int clutx,int cluty)

{
  char*s;
  int rowbytes;
  u_short height;
  int h;                 /* MATCH: the sign-extended height lands in a SECOND
                          * variable born exactly where `height` dies (its last
                          * use is the &1 test) -- gcc reuses height's register
                          * for it (oracle: sll/sra back into $s2, and every
                          * later use incl. the restore takes the extended
                          * value).  One `short height` keeps the raw lhu alive. */
  int rowall;
  int off;
  short ybot;
  RECT r;

  /* MATCH: mask INTO rowall (ONE statement) -- the oracle parks the MASKED value
   * in the callee-saved reg and derives BOTH rowbytes and r.w from it. */
  rowall = (shp->width * shapedepth(shp) + 0xf) & 0xfffffff0;
  rowbytes = (int)rowall >> 3;
  /* MATCH: the odd/simple case is the BRANCH TARGET (beqz/bnez skip forward) and
   * the two-blit path is the FALL-THROUGH, with a SECOND textual Vramf call laid
   * out after it -- an `if (simple) {...} else {...}` inverts both. */
  if ((rowbytes & 2) != 0) {
    height = shp->height;
    if ((height & 1) == 0) {
      h = (short)height;
      off = (h + -1) * rowbytes;
      /* MATCH: ONE base pointer (&shp->data + off) reused as s-2 / s+2 -- the
       * SYM names it `s`; separate (char*)shp + 0xe/0x12 + off forms build two
       * independent addu chains. */
      s = &shp->data + off;
      ybot = y + h;
      r.y = ybot + -2;
      r.x = (short)x;
      r.w = 1;
      r.h = 2;
      LoadImage(&r,(u_long *)(s + -2));
      r.x = (short)x + 1;
      r.y = ybot + -1;
      r.w = ((int)rowall >> 4) + -1;
      r.h = 1;
      LoadImage(&r,(u_long *)(s + 2));
      shp->height = shp->height + -1;
      Texture_Vramf(shp,x,y,clutx,cluty);
      shp->height = h;
      return;
    }
  }
  Texture_Vramf(shp,x,y,clutx,cluty);
  return;
}

/* ---- Texture_GetTranslucencyMode__FP8shapetbl  [TEXTURE.CPP:514-532] SLD-VERIFIED ---- */
int Texture_GetTranslucencyMode(shapetbl *shp)

{
  u_int abr;

  while( true ) {
    if (shp == (shapetbl *)0x0) {
      return 0;
    }
    if (*(char *)shp == 'k') {
      abr = (u_short)shp->width >> 5 & 3;
      /* MATCH: clamp-in-place then ONE return -- a ternary/two-return form makes
       * gcc build the value in $v1 and copy it out at a shared tail. */
      if (abr == 3) { abr = 2; }
      return abr;
      /* FLOOR (4 diffs, 28/30): the oracle keeps TWO separate `jr ra` tails --
       * .L800DFF08 `jr ra; addu v0,zero,zero` for `return 0` and .L800DFF10
       * `jr ra; nop` for `return abr`.  gcc-2.8 cross-jump-merges them here and
       * sinks the 0 into the `beqz shp` delay slot.  Tried: while(shp!=0)+trailing
       * return 0 (6), for(;;)+break (6), goto-loop (29), continue-form (27),
       * named ret var (4, identical).  Same class as the catalog's
       * "dual jr ra tails always cross-jump-merge" negative result. */
    }
    if ((*(u_int *)shp & 0xffffff00) != 0) {
      shp = (shapetbl *)((int)&(*(u_int *)((char *)shp + 0x0)) + ((int)*(u_int *)shp >> 8));
    }
    else {
      shp = (shapetbl *)0x0;
    }
  }
}

/* ---- Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap  [TEXTURE.CPP:538-667] SLD-FLAG:NONMONO ---- */
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
    /* MATCH: the masked word goes through its OWN temp before the != 0 test --
     * a direct `(word & 0x4000) != 0` lets gcc fold the single-bit test into
     * `srl 14; andi 1`; the temp keeps the oracle's `andi 0x4000; sltu zero,v0`. */
    { int fl = *(u_int *)((char *)shpptr + 0xc) & 0x4000; rotated = (fl != 0); }
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

/* ---- Texture_InitMenuClut__Fv  [TEXTURE.CPP:743-776] SLD-VERIFIED ---- */
void Texture_InitMenuClut(void)

{
  short *pal4;
  short *pal8;
  int idx;
  u_short clut;
  int y;
  int x;
  
  gFreePal4 = reservememadr("4 bits cluts",0x300,0);
  gFreePal8 = reservememadr("8 bits cluts",0x1180,0);
  pal4 = gFreePal4;
  x = 0;
  gNbFreePal4 = 0;
  do {
    y = 0;
    clut = 0x7a00;
    do {
      y = y + 1;
      idx = gNbFreePal4 + 1;
      pal4[gNbFreePal4] = clut | (u_short)(x + 0x200 >> 4) & 0x3f;
      pal8 = gFreePal8;
      clut = clut + 0x40;
      gNbFreePal4 = idx;
    } while (y < 0x18);
    x = x + 0x10;
  } while (x < 0x100);
  x = 0;
  gNbFreePal8 = 0;
  do {
    y = 0;
    clut = 0x5700;
    do {
      y = y + 1;
      idx = gNbFreePal8 + 1;
      pal8[gNbFreePal8] = clut | (u_short)(x + 0x200 >> 4) & 0x3f;
      gNbFreePal8 = idx;
      clut = clut + 0x40;
    } while (y < 0x8c);
    x = x + 0x100;
  } while (x < 0x100);
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
  Draw_tPixMap **ppDVar1;
  int i;
  
  i = 0;
  ppDVar1 = gMenuPixmap;
  do {
    if (*ppDVar1 != (Draw_tPixMap *)0x0) {
      Texture_MenuReleaseClutId((*ppDVar1)->clut);
    }
    *ppDVar1 = (Draw_tPixMap *)0x0;
    i = i + 1;
    ppDVar1 = ppDVar1 + 1;
  } while (i < 8);
  return;
}

/* ---- Texture_LoadMenuTexture__Fv  [TEXTURE.CPP:811-844] SLD-VERIFIED ---- */
void Texture_LoadMenuTexture(void)

{
  char *shapefile;
  Draw_tPixMap *pmx;
  char *shpfile;
  char name [255];

  if (gMenuPixmap[0] == (Draw_tPixMap *)0x0) {
    sprintf(name,"%sshow.psh",Paths_Paths[0x19]);
    shapefile = (char *)loadfileadr(name,0);
    Texture_ResetPaletteSharing();
    Texture_LoadPmx(shapefile,"show",0,0x380,0x180,-1,-1,gMenuPixmapAlloc);
    gMenuPixmap[0] = gMenuPixmapAlloc;
    Texture_LoadPmx(shapefile,"shad",0,0x380,0x180,-1,-1,gMenuPixmapAlloc + 1);
    gMenuPixmap[1] = gMenuPixmapAlloc + 1;
    Texture_LoadPmx(shapefile,"lgt3",0,0x380,0x180,-1,-1,gMenuPixmapAlloc + 2);
    gMenuPixmap[3] = gMenuPixmapAlloc + 2;
    Texture_LoadPmx(shapefile,"lgta",0,0x380,0x180,-1,-1,gMenuPixmapAlloc + 3);
    gMenuPixmap[4] = gMenuPixmapAlloc + 3;
    Texture_LoadPmx(shapefile,"lgtb",0,0x380,0x180,-1,-1,gMenuPixmapAlloc + 4);
    gMenuPixmap[5] = gMenuPixmapAlloc + 4;
    Texture_LoadPmx(shapefile,"lgtc",0,0x380,0x180,-1,-1,gMenuPixmapAlloc + 5);
    gMenuPixmap[6] = gMenuPixmapAlloc + 5;
    purgememadr(shapefile);
  }
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
  return;
}

/* end of texture.cpp */
