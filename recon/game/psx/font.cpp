/* game/psx/font.cpp -- RECONSTRUCTED (NFS4 PSX text/font rasterizer; C++ TU)
 *   15 fns: Font_TextColor/TextTint/SetABR (state), Font_Blit (glyph blit), Font_ComputeColors
 *   (packed-colour math), Font_textbsearch + Font_Getcharacter (char-table lookup), Font_Set/
 *   ReSetBlitter (blit fn-ptr), Font_SwitchFont/LoadFont/DeInit/ExitFromGame (lifecycle),
 *   Font_TextXY (string layout), Font_GetUVWH (glyph UV/size).  Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "font_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int font_clutx;
int font_cluty;
u_char gFontSpaceWidth;
u_long font_abr;
u_long font_tint;
u_short font_currentTPage;
u_short gFontClut;

/* gCurrentBlitter @0x8013ddec : font.obj-owned glyph-blit fn-ptr (STAT PTR FCN VOID).  BSS;
 *   Font_SetBlitter assigns it, Font_ReSetBlitter resets it to Font_Blit, Font_TextXY calls it. */
fn_void *gCurrentBlitter;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Font_TextColor(int color);
void Font_TextTint(int rgb);
void Font_SetABR(int abr);
void Font_Blit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6);
void Font_ComputeColors(int colour,int forecolour,int backcolour,char in_game);
charactertbl * Font_Getcharacter(int targetindex);
void Font_SetBlitter(fn_void *blitter);
void Font_ReSetBlitter(void);
void Font_SwitchFont(char *f1);
void Font_DeInit(void);
void Font_ExitFromGame(void);
int Font_LoadFont(char *f1,int x,int y,char in_game);
void Font_TextXY(char *string,int x,int y);
void Font_GetUVWH(char code,int *u,int *v,int *w,int *h,int *yoff);


/* ---- Font_TextColor__Fi  [FONT.CPP:83-85] SLD-VERIFIED ---- */
void Font_TextColor(int color)

{
  shpfontclut.shapex = (short)((u_int)(u_short)font_clutx + color * 0x10);
  gFontClut = shpfontclut.shapey << 6 | (u_int)shpfontclut.shapex >> 4 & 0x3f;
  return;
}

/* ---- Font_TextTint__Fi  [FONT.CPP:89-90] SLD-VERIFIED ---- */
void Font_TextTint(int rgb)

{
  font_tint = rgb & 0xffffffU | 0x66000000;
  return;
}

/* ---- Font_SetABR__Fi  [FONT.CPP:96-101] SLD-FLAG:NONMONO ---- */
void Font_SetABR(int abr)

{
  int y;
  int val;

  font_abr = abr;
  val = *(int *)((*(int *)((u_char *)&(currentfont) + 136)) + 0xc);
  y = (val << 4) >> 20;
  font_currentTPage =
       GetTPage(*(u_char *)(*(int *)((u_char *)&(currentfont) + 136)) & 3,abr,
                  (val << 0x14) >> 0x14,
                  y);
  return;
}

/* ---- Font_Blit__FiiPviiP12charactertbli  [FONT.CPP:128-152] SLD-FLAG:NONMONO ---- */
void Font_Blit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6)

{
  int fontClut;
  u_int uVar1;
  int dv;
  int iVar2;
  int height;
  int pkt_addr24;
  int width;
  int loc_8;
  u_char uv_x;
  u_char uv_y;
  u_long tu3;
  u_char *prev_pkt;
  u_char *sprt;
  
  sprt = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  iVar2 = *(int *)((int)src + 0xc);
  uv_x = ch->width;
  uv_y = ch->height;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x14;
  *(u_int *)prev_pkt = *(u_int *)prev_pkt & 0xff000000 | pkt_addr24;
  sprt[3] = 4;
  tu3 = font_tint;
  *(int *)(sprt + 8) = y << 0x10 | x;
  *(u_long *)(sprt + 4) = tu3;
  fontClut = (int)gFontClut;
  *(u_int *)(sprt + 0x10) = (u_int)uv_y << 0x10 | (u_int)uv_x;
  uVar1 = fontClut << 0x10 | (((iVar2 << 4) >> 0x14) + v & 0xffU) << 8 | u;
  *(u_int *)(sprt + 0xc) = uVar1;
  SetSemiTrans(sprt,1);
  return;   /* Font_Blit is void per disasm-v3 (Ghidra void-return mis-infer) */
}

/* ---- Font_ComputeColors__Fiiic  [FONT.CPP:168-255] SLD-VERIFIED ----
 * SYM (one fn-scope block, fsize 88): i $t2, r $v0, g $v1, b $a0, fr $t8, fg $t4,
 * fb $a3, br $a2, bg $a1, bb $a0, rgb $v0 (= THE result variable), opaque $s5,
 * fclr AUTO -0x40 (= sp+0x18), bclr AUTO -0x38 (= sp+0x20), fr1 $v1, fg1 $v0, fb1 $s0.
 * Oracle evidence: `opaque = forecolour & 0xff000000` is hoisted to the prologue ($s5);
 * gcc LICMs (fr1<<10)|(fg1<<5) -> $s2, that|0x8000 -> $s3 and fb1 -> $s0 out of the loop,
 * which is why `rgb` is NOT materialised before the loop; the clut walker $t7 is the
 * strength-reduced &shpfontclut.data[i]; the literal 15 is CSE'd between `15 - i` and
 * `colour == 15` ($s1); both `if (rgb == 0) rgb = 0x400;` tails cross-jump into one
 * block (.L800CB62C) while the i<8 / i<12 / i<4 arms branch straight to the store.
 * Divides are SIGNED (mult + magic + sign fixup), not unsigned.
 */
void Font_ComputeColors(int colour,int forecolour,int backcolour,char in_game)

{
  int i;
  int r;
  int g;
  int b;
  int fr;
  int fg;
  int fb;
  int br;
  int bg;
  int bb;
  int rgb;
  int opaque;
  CVECTOR fclr;
  CVECTOR bclr;
  int fr1;
  int fg1;
  int fb1;

  opaque = forecolour & 0xff000000;
  shpfontclut.type = 0x23;
  shpfontclut.next = 0;
  shpfontclut.width = 0x10;
  shpfontclut.height = 1;
  shpfontclut.centerx = 0;
  shpfontclut.centery = 0;
  shpfontclut.shapex = (short)font_clutx;
  shpfontclut.shapey = (short)font_cluty;
  *(long *)&fclr = forecolour;
  *(long *)&bclr = backcolour;
  r = fclr.r;
  g = fclr.g;
  b = fclr.b;
  fr1 = (r * 31) / 255;
  fg1 = (g * 31) / 255;
  fb1 = (b * 31) / 255;
  for (i = 0; i < 16; i++) {
    if ((in_game != 0) && (opaque == 0)) {
      if (i < 8) {
        rgb = 0;
      }
      else if (i < 12) {
        rgb = 0x8000 | fr1 << 10 | fg1 << 5 | fb1;
      }
      else {
        rgb = fr1 << 10 | fg1 << 5 | fb1;
        if (rgb == 0) {
          rgb = 0x400;
        }
      }
    }
    else {
      fr = (fclr.r * i * 31) / 3825;
      fg = (fclr.g * i * 31) / 3825;
      fb = (fclr.b * i * 31) / 3825;
      br = (bclr.r * (15 - i) * 31) / 3825;
      bg = (bclr.g * (15 - i) * 31) / 3825;
      bb = (bclr.b * (15 - i) * 31) / 3825;
      if (i < 4) {
        rgb = 0;
      }
      else {
        rgb = (fr + br) << 10 | (fg + bg) << 5 | (fb + bb);
        if (colour == 0xf) {
          rgb = rgb | 0x8000;
        }
        if (rgb == 0) {
          rgb = 0x400;
        }
      }
    }
    shpfontclut.data[i] = (short)rgb;
  }
  Texture_Vramf((shapetbl *)&shpfontclut,font_clutx,font_cluty,font_clutx + colour * 0x10,
                font_cluty);
  DrawSync(0);
  return;
}
/* ---- Font_textbsearch__FiPcUlUl  [FONT.CPP:262-280] SLD-VERIFIED ---- */
charactertbl *
Font_textbsearch(int key,char *base,u_long nmemb,u_long size)

{
  int cmp;
  int iVar1;
  charactertbl *ch;
  charactertbl *p;
  int lim;
  
  while( true ) {
    if (nmemb == 0) {
      return (charactertbl *)0x0;
    }
    p = (charactertbl *)(base + ((int)nmemb >> 1) * size);
    iVar1 = geti(p,2);
    if (key == iVar1) break;
    if (0 < key - iVar1) {
      base = (char *)(p->index + size);
      nmemb = nmemb - 1;
    }
    nmemb = (int)nmemb >> 1;
  }
  return p;
}

/* ---- Font_Getcharacter__Fi  [FONT.CPP:286-299] SLD-VERIFIED ---- */
charactertbl * Font_Getcharacter(int targetindex)

{
  u_int base_00;
  int probe_idx;
  charactertbl *ch;
  charactertbl *p;
  u_char *base;

  base = (u_char *)&(currentfont);
  base_00 = (*(int *)(base + 132));
  p = (charactertbl *)((*(int *)(base + 132)) + (targetindex + -0x20) * 0xb);
  probe_idx = geti(p,2);
  if (probe_idx == targetindex) {
    return p;
  }
  return Font_textbsearch(targetindex,(char *)base_00,(*(int *)(base + 116)),0xb);
}

/* ---- Font_SetBlitter__FPFiiPviiP12charactertbli_v  [FONT.CPP:305-306] SLD-VERIFIED ---- */
void Font_SetBlitter(fn_void *blitter)

{
  gCurrentBlitter = blitter;
  return;
}

/* ---- Font_ReSetBlitter__Fv  [FONT.CPP:311-312] SLD-VERIFIED ---- */
void Font_ReSetBlitter(void)

{
  gCurrentBlitter = Font_Blit;
  return;
}

/* ---- Font_SwitchFont__FPc  [FONT.CPP:317-329] SLD-VERIFIED ---- */
void Font_SwitchFont(char *f1)

{
  charactertbl *pcVar1;
  u_char *base;
  u_char *pv1;
  int c_val;
  int abr_val;

  setfont(f1);
  base = (u_char *)&(currentfont);
  pv1 = *(u_char **)(base + 136);
  abr_val = font_abr;
  *(u_int *)(base + 0x94) = 0;
  *(u_int *)(base + 0x98) = 0;
  *(u_int *)(base + 0x9c) = 0;
  c_val = *(int *)(pv1 + 0xc);
  {
    int arg3 = (c_val << 4) >> 0x14;
    int arg2 = (c_val << 0x14) >> 0x14;
    font_currentTPage = GetTPage(*(u_char *)pv1 & 3,abr_val,arg2,arg3);
  }
  pcVar1 = Font_Getcharacter(0x20);
  gFontSpaceWidth = pcVar1->advance;
  return;
}

/* ---- Font_DeInit__Fv  [FONT.CPP:333-338] SLD-VERIFIED ---- */
void Font_DeInit(void)

{
  if (font_clutx != -1) {
    Texture_MenuReleaseClutId((short)font_cluty << 6 | (u_short)(font_clutx >> 4) & 0x3f);
  }
  font_clutx = -1;
  font_cluty = -1;
  return;
}

/* ---- Font_ExitFromGame__Fv  [FONT.CPP:342-344] SLD-VERIFIED ---- */
void Font_ExitFromGame(void)

{
  font_clutx = -1;
  font_cluty = -1;
  return;
}

/* ---- Font_LoadFont__FPciic  [FONT.CPP:348-399] SLD-VERIFIED ----
 * SYM (fsize 56, ra+s0-s6): f1 $s3, x $s5, y $s6, in_game $s4 CHAR; block locals
 * shp $s2 (PTR shapetbl), i $s0, l $s1.  Both nibble-swap loops and the colour loop
 * are plain index-form `for`s -- the oracle's `addu a0,s0,s2` / `addiu s1,s1,4`
 * walkers are gcc strength reduction, not source pointers.
 */
int Font_LoadFont(char *f1,int x,int y,char in_game)

{
  int i;
  int l;
  shapetbl *shp;

  setfont(f1);
  shp = (shapetbl *)(*(int *)((u_char *)&(currentfont) + 136));
  l = ((int)shp->width * (int)shp->height) / 2;
  for (i = 0; i < l; i++) {
    (&shp->data)[i] = ((&shp->data)[i] & 0xf) << 4 | (&shp->data)[i] >> 4;
  }
  if (font_clutx == -1) {
    Texture_GetClutId(1,&font_clutx,&font_cluty);
  }
  Texture_Vramf(shp,x,y,font_clutx,font_cluty);
  waitdraw();
  shp->next = (int)&shpfontclut - (int)shp;
  for (i = 0; i < l; i++) {
    (&shp->data)[i] = ((&shp->data)[i] & 0xf) << 4 | (&shp->data)[i] >> 4;
  }
  for (i = 0; i < 0x10; i++) {
    Font_ComputeColors(i,colourRGB[i],0,in_game);
  }
  Font_ReSetBlitter();
  Font_SwitchFont(f1);
  resizememadr(f1,(*(int *)((u_char *)&(currentfont) + 136)) - (int)(f1 + -0x10));
  Font_TextTint(0x808080);
  Font_TextColor(2);
  return y + shp->height;
}
/* ---- Font_TextXY__FPcii  [FONT.CPP:414-453] SLD-VERIFIED ----
 * SYM locals (fn block): str $s4, ch $s1, code $s3; inner block (line ~431): u $s0;
 * tail block (line ~450): dr_mode $a0.  Params x -> $s2, y -> $s6 (REGPARM copies).
 * SLD: 419 code=-1 | 421 while | 423 code=*str++ | 425 if | 433/434 geti | 436-439 blit
 * call | 442 x+=advance | 446 space path (textually LAST => the `else` arm) | 449-453 tail.
 * The scratchpad packet/palette reads live ONLY in the tail block (oracle .L800CBB5C).
 */
void Font_TextXY(char *string,int x,int y)

{
  charactertbl *ch;
  int code;
  char *str;
  u_char *cfbase;

  cfbase = (u_char *)&(currentfont);
  str = string;
  code = -1;
  while (code != 0) {
    code = *(u_char *)str;
    str = str + 1;
    if (0x20 < code) {
      ch = Font_Getcharacter(code);
      if (ch != (charactertbl *)0x0) {
        int u;

        u = geti(ch->u,2);
        /* `char` is UNSIGNED on this build -> (signed char) forces the oracle's `lb` */
        (*gCurrentBlitter)(x + *(signed char *)&ch->xoffset,
                           y + *(signed char *)&ch->yoffset,
                           *(void **)(cfbase + 136),
                           u,geti(ch->v,2),(charactertbl *)ch,
                           *(int *)(cfbase + 120));
        x = x + *(signed char *)&ch->advance;
      }
    }
    else {
      x = x + (u_int)gFontSpaceWidth;
    }
  }
  {
    DR_MODE *dr_mode;
    u_int *pal;
    int tpage;

    dr_mode = (DR_MODE *)Render_gPacketPtr;
    pal = (u_int *)Render_gPalettePtr;
    tpage = (int)font_currentTPage;
    *(u_int *)dr_mode = *pal & 0xffffff | *(u_int *)dr_mode & 0xff000000;
    Render_gPacketPtr = (u_char *)dr_mode + 0xc;
    *pal = *pal & 0xff000000 | (u_int)dr_mode & 0xffffff;
    SetDrawMode(dr_mode,0,0,tpage,(RECT *)0x0);
  }
  return;
}
/* ---- Font_GetUVWH__FcPiN41  [FONT.CPP:541-549] SLD-VERIFIED ----
 * SYM (fsize 48, ra+s0-s5): code $a0 CHAR, u $s1, v $s2, w $s3, h $s4 (ARG), yoff $s5
 * (ARG); one block local: ch $s0.  The Ghidra leftover locals (fclr/bclr/width/...)
 * were dead but their AUTO slots inflated the frame to 64. */
void Font_GetUVWH(char code,int *u,int *v,int *w,int *h,int *yoff)

{
  charactertbl *ch;

  ch = Font_Getcharacter((u_int)(u_char)code);
  *u = geti(ch->u,2);
  *v = ((*(int *)((*(int *)((u_char *)&(currentfont) + 136)) + 0xc) << 0x14) >> 0x14) +
       geti(ch->v,2);
  *w = (u_int)ch->width;
  *h = (u_int)ch->height;
  *yoff = *(signed char *)&ch->yoffset;
  return;
}
/* end of font.cpp */
