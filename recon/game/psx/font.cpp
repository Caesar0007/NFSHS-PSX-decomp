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
  u_int uVar1;
  
  uVar1 = (u_int)(u_short)font_clutx + color * 0x10;
  shpfontclut.shapex = (short)uVar1;
  gFontClut = shpfontclut.shapey << 6 | (u_short)(uVar1 >> 4) & 0x3f;
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

/* ---- Font_ComputeColors__Fiiic  [FONT.CPP:168-280] SLD-VERIFIED ---- */
void Font_ComputeColors(int colour,int forecolour,int backcolour,char in_game)

{
  u_int uVar1;
  int fg1;
  cluttbl *pcVar2;
  u_int uVar3;
  u_int uVar4;
  int fr1;
  u_int uVar5;
  int bb;
  int iVar6;
  int bg;
  int br;
  int fb;
  int i;
  int iVar7;
  int fg;
  int fb1;
  int opaque;
  int fr;
  CVECTOR fclr;
  CVECTOR bclr;
  int r;
  int g;
  int b;
  int rgb;
  
  iVar7 = 0;
  fclr.b = (u_char)((u_int)forecolour >> 0x10);
  bb = (int)fclr.b;
  pcVar2 = &shpfontclut;
  shpfontclut.width = 0x10;
  fclr.g = (u_char)((u_int)forecolour >> 8);
  fb = (int)fclr.g;
  shpfontclut.height = 1;
  shpfontclut.centerx = 0;
  shpfontclut.centery = 0;
  (*(int *)&(shpfontclut)) = 0x23;
  shpfontclut.shapex = (short)font_clutx;
  shpfontclut.shapey = (short)font_cluty;
  uVar1 = (u_int)(bb * 0x1f) / 0xff;
  r = forecolour & 0xff;
  uVar5 = ((r * 0x1f) / 0xff) * 0x400;
  uVar3 = ((u_int)(fb * 0x1f) / 0xff) * 0x20;
  rgb = uVar5 | uVar3 | uVar1;
  do {
    if ((in_game == '\0') || ((forecolour & 0xff000000U) != 0)) {
      iVar6 = 0xf - iVar7;
      if (3 < iVar7) {
        uVar4 = ((int)(r * iVar7 * 0x1f) / 0xef1 +
                (int)((backcolour & 0xffU) * iVar6 * 0x1f) / 0xef1) * 0x400 |
                ((int)((u_int)fclr.g * iVar7 * 0x1f) / 0xef1 +
                (int)(((u_int)backcolour >> 8 & 0xff) * iVar6 * 0x1f) / 0xef1) * 0x20 |
                (int)((u_int)fclr.b * iVar7 * 0x1f) / 0xef1 +
                (int)(((u_int)backcolour >> 0x10 & 0xff) * iVar6 * 0x1f) / 0xef1;
        if (colour == 0xf) {
          uVar4 = uVar4 | 0x8000;
        }
        goto FontColors_defaultColor;
      }
      uVar4 = 0;
    }
    else {
      uVar4 = 0;
      if ((7 < iVar7) && (uVar4 = rgb | 0x8000, 0xb < iVar7)) {
        uVar4 = rgb;
FontColors_defaultColor:
        if (uVar4 == 0) {
          uVar4 = 0x400;
        }
      }
    }
    pcVar2->data[0] = (short)uVar4;
    iVar7 = iVar7 + 1;
    pcVar2 = (cluttbl *)((char *)pcVar2 + 2);
    if (0xf < iVar7) {
      Texture_Vramf((shapetbl *)&shpfontclut,font_clutx,font_cluty,font_clutx + colour * 0x10,
                 font_cluty);
      DrawSync(0);
      return;
    }
  } while( true );
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

/* ---- Font_LoadFont__FPciic  [FONT.CPP:348-399] SLD-VERIFIED ---- */
int Font_LoadFont(char *f1,int x,int y,char in_game)

{
  u_int shp_00;
  int iVar1;
  int i;
  int iVar2;
  int l;
  int iVar3;
  long *plVar4;
  shapetbl *shp;
  
  setfont(f1);
  shp_00 = (*(int *)((u_char *)&(currentfont) + 136));
  iVar3 = ((int)*(short *)((*(int *)((u_char *)&(currentfont) + 136)) + 4) * (int)*(short *)((*(int *)((u_char *)&(currentfont) + 136)) + 6)) / 2;
  iVar2 = 0;
  iVar1 = (*(int *)((u_char *)&(currentfont) + 136));
  if (0 < iVar3) {
    do {
      iVar2 = iVar2 + 1;
      *(u_char *)(iVar1 + 0x10) = *(u_char *)(iVar1 + 0x10) << 4 | *(u_char *)(iVar1 + 0x10) >> 4;
      iVar1 = iVar2 + shp_00;
    } while (iVar2 < iVar3);
  }
  if (font_clutx == -1) {
    Texture_GetClutId(1,&font_clutx,&font_cluty);
  }
  iVar2 = 0;
  Texture_Vramf((shapetbl *)shp_00,x,y,font_clutx,font_cluty);
  waitdraw();
  *(u_int *)shp_00 = (u_int)*(u_char *)shp_00 | ((int)&shpfontclut - shp_00) * 0x100;
  iVar1 = shp_00;
  if (0 < iVar3) {
    do {
      iVar2 = iVar2 + 1;
      *(u_char *)(iVar1 + 0x10) = *(u_char *)(iVar1 + 0x10) << 4 | *(u_char *)(iVar1 + 0x10) >> 4;
      iVar1 = iVar2 + shp_00;
    } while (iVar2 < iVar3);
  }
  plVar4 = colourRGB;
  iVar1 = 0;
  do {
    iVar2 = *plVar4;
    plVar4 = plVar4 + 1;
    iVar3 = iVar1 + 1;
    Font_ComputeColors(iVar1,iVar2,0,in_game);
    iVar1 = iVar3;
  } while (iVar3 < 0x10);
  Font_ReSetBlitter();
  Font_SwitchFont(f1);
  resizememadr(f1,(*(int *)((u_char *)&(currentfont) + 136)) - (int)(f1 + -0x10));
  Font_TextTint(0x808080);
  Font_TextColor(2);
  return y + *(short *)(shp_00 + 6);
}

/* ---- Font_TextXY__FPcii  [FONT.CPP:414-453] SLD-VERIFIED ---- */
void Font_TextXY(char *string,int x,int y)

{
  int ch_entry_p;
  int char_w;
  int char_h;
  int tpage_packed;
  DR_MODE *dr_mode;
  int tpage;
  int u;
  charactertbl *ch;
  int code;
  int ch_byte;
  char *str;
  u_char *tp1;
  u_char *p;
  
  ch_byte = -1;
  while (p = Render_gPacketPtr, tp1 = Render_gPalettePtr, ch_byte != 0) {
    ch_byte = (int)(u_char)*string;
    string = string + 1;
    if ((u_int)ch_byte < 0x21) {
      x = x + (u_int)gFontSpaceWidth;
    }
    else {
      ch_entry_p = (int)Font_Getcharacter(ch_byte);
      if (ch_entry_p != 0) {
        char_w = geti((void *)(ch_entry_p + 4),2);
        char_h = geti((void *)(ch_entry_p + 6),2);
        (*gCurrentBlitter)(x + *(char *)(ch_entry_p + 9),y + *(char *)(ch_entry_p + 10),
                           (*(int *)((u_char *)&(currentfont) + 136)),char_w,char_h,ch_entry_p,(*(int *)((u_char *)&(currentfont) + 120)));
        x = x + *(char *)(ch_entry_p + 8);
      }
    }
  }
  tpage = (int)font_currentTPage;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  tpage_packed = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | tpage_packed;
  SetDrawMode((DR_MODE *)p,0,0,tpage,(RECT *)0x0);
  return;
}

/* ---- Font_GetUVWH__FcPiN41  [FONT.CPP:541-549] SLD-VERIFIED ---- */
void Font_GetUVWH(char code,int *u,int *v,int *w,int *h,int *yoff)

{
  int cmp;
  charactertbl *pcVar1;
  int iVar2;
  int fr1;
  int height;
  int i;
  int fg;
  int width;
  charactertbl *ch;
  char *str;
  int opaque;
  int fr;
  CVECTOR fclr;
  CVECTOR bclr;
  
  pcVar1 = Font_Getcharacter((u_int)(u_char)code);
  iVar2 = geti(pcVar1->u,2);
  *u = iVar2;
  iVar2 = geti(pcVar1->v,2);
  *v = ((*(int *)((*(int *)((u_char *)&(currentfont) + 136)) + 0xc) << 0x14) >> 0x14) + iVar2;
  *w = (u_int)pcVar1->width;
  *h = (u_int)pcVar1->height;
  *yoff = (int)pcVar1->yoffset;
  return;
}

/* end of font.cpp */
