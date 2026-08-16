/* frontend/common/fetextrender.cpp -- RECONSTRUCTED (front-end text renderer; C++ TU)
 *   17 free fns (ns nfs4::FRONTEND::COMMON::FETextRender): SetFont, FullText/FullTextRGB/
 *   FullTextFade, MenuText{Positioned,Fade,PositionedJustify(+Fade)}, WordWrap* family
 *   (RGB/Justify/Fade/Height), Title, SetABR. + textDefinitions[6][14] / gSemiTransText data.
 */
#include "fetextrender.h"

/* EXT data owned by FETextRender.obj, byte-exact from retail binary */
char textDefinitions[14][6] = {   /* @0x800515b8 (ARY ARY CHAR, SYM dims 14x6 -> 14 rows x 6 cols; same 84 bytes, row-stride 6) */
  {3,0,0,9,9,9},
  {0,0,0,10,10,9},
  {0,0,0,20,17,9},
  {0,0,0,9,9,9},
  {0,0,0,16,20,9},
  {0,0,0,20,20,20},
  {0,0,0,16,20,9},
  {0,0,0,17,17,17},
  {0,0,0,15,15,9},
  {0,0,0,9,9,9},
  {0,0,0,15,10,9},
  {0,0,0,6,20,9},
  {1,0,0,16,20,9},
  {3,2,0,9,9,9},
};
BOOL gSemiTransText __attribute__((section(".data"))) = 0;
extern int gSemiTransText_arr[] asm("gSemiTransText");


/* ---- FETextRender_SetFont  [FETEXTRENDER.CPP:72-88] SLD-VERIFIED ---- */

void FETextRender_SetFont(int size)

{
  if (currentSize != size) {
    currentSize = (short)size;
    switch (currentSize) {
    case 0:
      Font_SwitchFont(font12[0]);
      break;
    case 3:
      Font_SwitchFont(fontTitle[0]);
      break;
    default:
      Font_SwitchFont(font18[0]);
      break;
    }
  }
  return;
}



/* ---- FETextRender_FullTextRGB  [FETEXTRENDER.CPP:94-127] SLD-VERIFIED ---- */

void FETextRender_FullTextRGB(char *sMenuText,short x,short y,int col,char size,short justify)

{
  char *str;
  char buffer [128];
  
  str = sMenuText;
  FETextRender_SetFont((u_int)(u_char)size);
  if ((u_char)size == 0) {
    sprintf(buffer,"%s",str);
    s_lower(buffer);
    str = buffer;
  }
  if (((justify == 1) || (justify == 4)) || (justify == 6)) {
    x = x - (short)textpixels(str);
  }
  else if ((justify == 2) || (justify == 5)) {
    x = x - (short)(textpixels(str) / 2);
  }
  Font_TextColor(gSemiTransText_arr[0] != 0 ? 0xf : 1);
  Font_TextTint(col);
  Font_TextXY(str,(int)x,(int)y);
  if ((u_short)(justify - 3U) < 3) {
    Font_TextTint(0);
    Font_TextXY(str,x + 2,y + 1);
  }
  return;
  return;
}



/* ---- FETextRender_FullText  [FETEXTRENDER.CPP:136-139] SLD-FLAG:NONMONO ----
   SYM-CONFORM (2026-08-16, PASS retained): restored the original `textcol`
   local.  The same audit restored `x`/`y` in MenuTextFade and the exact
   `RECT r` + `short offset` stack/register declarations in Title; all three
   remain byte-identical to retail. */
void FETextRender_FullText(char *sMenuText,short x,short y,tMenuTextType textType,tMenuTextState textState,
               short justify)

{
  
  int textcol = kRGBVals[(u_char)textDefinitions[textType][textState + textState_NumStates]];
  FETextRender_FullTextRGB(sMenuText,x,y,textcol,textDefinitions[textType][0],justify);
  return;
}



/* ---- FETextRender_FullTextFade  [FETEXTRENDER.CPP:144-147] SLD-VERIFIED ---- */
void FETextRender_FullTextFade(int fade,char *sMenuText,short x,short y,tMenuTextType textType,
               tMenuTextState textState,short justify)

{
  FETextRender_FullTextRGB(
      sMenuText,x,y,
      CalcFadeVal(kRGBVals[(u_char)textDefinitions[textType][textState + textState_NumStates]],fade),
      textDefinitions[textType][0],justify);
  return;
}



/* ---- FETextRender_MenuTextPositioned  [FETEXTRENDER.CPP:152-155] SLD-VERIFIED ---- */
void FETextRender_MenuTextPositioned(short index,short x,short y,tMenuTextState textState,tMenuTextType textType)

{
  
  if (textType == textType_Default) {
    textType = (tMenuTextType)TextSys_WordFlags((int)index);
  }
  FETextRender_MenuTextPositionedJustify(index,x,y,(u_short)(u_char)textDefinitions[textType][1],textState,textType);
  return;
}



/* ---- FETextRender_MenuTextFade  [FETEXTRENDER.CPP:171-179] SLD-VERIFIED ---- */
void FETextRender_MenuTextFade(int fade,short index,tMenuTextState textState,tMenuTextType textType)

{
  int x;
  int y;

  x = TextSys_WordX((int)index);
  y = TextSys_WordY((int)index);
  if (textType == textType_Default) {
    textType = (tMenuTextType)TextSys_WordFlags((int)index);
  }
  FETextRender_MenuTextPositionedJustifyFade(fade,index,(short)x,(short)y,(u_short)(u_char)textDefinitions[textType][1],
             textState,textType);
  return;
}



/* ---- FETextRender_MenuTextPositionedJustify  [FETEXTRENDER.CPP:193-194] SLD-VERIFIED ---- */
void FETextRender_MenuTextPositionedJustify(short index,short x,short y,short justify,tMenuTextState state,tMenuTextType type)

{
  FETextRender_MenuTextPositionedJustifyFade(0,index,x,y,justify,state,type);
  return;
}



/* ---- FETextRender_MenuTextPositionedJustifyFade  [FETEXTRENDER.CPP:198-213] SLD-VERIFIED ---- */
void FETextRender_MenuTextPositionedJustifyFade(int fade,short index,short x,short y,short justify,tMenuTextState textState,
               tMenuTextType textType)

{
  if ((justify == 6) || (textType == textType_Title)) {
    FETextRender_Title(index);
  }
  else {
    if (textType == textType_Default) {
      textType = (tMenuTextType)TextSys_WordFlags((int)index);
    }
    FETextRender_FullTextFade(
        fade,TextSys_Word((int)index),x,y,textType,textState,justify);
  }
  return;
}



/* ---- FETextRender_WordWrapTextRGBJustify  [FETEXTRENDER.CPP:216-355] SLD-VERIFIED ---- */

int FETextRender_WordWrapTextRGBJustify(char *str,RECT &r,int col,int justify,int size,bool JustGrabHeight)

{
  int OriginalY;
  short x;
  unsigned short index1;
  unsigned short index2;
  long strLength;
  char buffer [128];
  char source [512];
  short spacing;

  OriginalY = r.y;
  FETextRender_SetFont(size);
  switch (size) {
  case 0:
    spacing = 8;
    break;
  case 1:
    spacing = 10;
    break;
  case 2:
  default:
    spacing = 0x10;
    break;
  }
  index1 = 0;
  strLength = strlen(str);
  Font_TextColor(gSemiTransText_arr[0] != 0 ? 0xf : 1);
  Font_TextTint(col);
  blockmove(str,source,strLength + 1);
  if (size == 0) {
    s_lower(source);
  }
  if (strLength > 0) {
    do {
      while (source[index1] == ' ') {
        index1++;
      }
      index2 = index1 + (r.w >> 3) + 10;
      if (strLength < index2) {
        index2 = strLength;
      }
      blockmove(source + index1,buffer,index2 - index1 + 1);
      buffer[index2 - index1] = '\0';
      x = textpixels(buffer);
      if (r.w < x) {
        do {
          while ((source[index2] != ' ') && (index1 < index2)) {
            index2--;
          }
          while ((source[index2] == ' ') && (index1 < index2)) {
            index2--;
          }
          buffer[index2 - index1 + 1] = '\0';
          x = textpixels(buffer);
        } while ((r.w < x) && (index1 < index2));
      }
      if (index2 == index1) {
        buffer[1] = source[index2 + 1];
        while ((source[index2] != '\0') && (source[index2] != ' ')) {
          index2++;
        }
        buffer[index2 - index1] = '\0';
      }
      while ((source[index2] != '\0') && (source[index2] != ' ')) {
        index2++;
      }
      while (source[index2] == ' ') {
        index2++;
      }
      buffer[index2 - index1] = '\0';
      {
        /* SYM-CODEGEN-CARRIER: pixels -- collapsing this value into `x`
         * changes the whole-function register handout (FAIL 64 / 289 versus
         * PASS 285), while this scoped carrier preserves retail allocation. */
        short pixels = textpixels(buffer);

        index1 = index2;
        x = r.x;
        if ((justify == 1) || (justify == 4)) {
          x -= pixels;
        }
        else if ((justify == 2) || (justify == 5)) {
          x -= pixels >> 1;
        }
      }
      if (JustGrabHeight == 0) {
        Font_TextXY(buffer,x,r.y);
        if (justify - 3U < 3) {
          Font_TextTint(0);
          Font_TextXY(buffer,x + 2,r.y + 1);
          Font_TextTint(col);
        }
      }
      r.y += spacing;
    } while (index1 < strLength);
  }
  return r.y - OriginalY;
}



/* ---- FETextRender_WordWrapTextRGB  [FETEXTRENDER.CPP:359-360] SLD-VERIFIED ---- */

void FETextRender_WordWrapTextRGB(char *str,RECT &r,int Col)

{
  
  FETextRender_WordWrapTextRGBJustify(str,r,Col,0,0,false);
  return;
}



/* ---- FETextRender_WordWrapTextFade  [FETEXTRENDER.CPP:364-371] SLD-VERIFIED ---- */
void FETextRender_WordWrapTextFade(int fade,char *str,RECT &r,tMenuTextState textState,tMenuTextType textType)

{
  
  FETextRender_WordWrapTextRGBJustify(str,r,
            CalcFadeVal(kRGBVals[(u_char)textDefinitions[textType][textState + textState_NumStates]],fade),
            (u_int)(u_char)textDefinitions[textType][1],(u_int)(u_char)textDefinitions[textType][0],false);
  return;
}



/* ---- FETextRender_WordWrapText  [FETEXTRENDER.CPP:375-376] SLD-VERIFIED ---- */
void FETextRender_WordWrapText(char *str,RECT &r,tMenuTextState textState,tMenuTextType textType)

{
  
  FETextRender_WordWrapTextFade(0,str,r,textState,textType);
  return;
}



/* ---- FETextRender_WordWrapFade  [FETEXTRENDER.CPP:380-383] SLD-VERIFIED ---- */
void FETextRender_WordWrapFade(int fade,short index,RECT &r,tMenuTextState state,tMenuTextType type)

{
  FETextRender_WordWrapTextFade(fade,TextSys_Word((int)index),r,state,type);
  return;
}



/* ---- FETextRender_WordWrap  [FETEXTRENDER.CPP:388-389] SLD-VERIFIED ---- */
void FETextRender_WordWrap(short index,RECT &r,tMenuTextState textState,tMenuTextType textType)

{
  
  FETextRender_WordWrapFade(0,index,r,textState,textType);
  return;
}



/* ---- FETextRender_WordWrapHeight  [FETEXTRENDER.CPP:394-397] SLD-VERIFIED ---- */

int FETextRender_WordWrapHeight(short width,char *str)

{
  RECT r;
  
  r.h = 500;
  r.x = 0;
  r.y = 0;
  r.w = width;
  return FETextRender_WordWrapTextRGBJustify(str,r,0,0,0,true);
}



/* ---- FETextRender_Title  [FETEXTRENDER.CPP:420-437] SLD-VERIFIED ---- */

void FETextRender_Title(short index)

{
  char upstr [80];
  RECT r;
  short offset;
  
  offset = 0;
  if (FEApp->fPlayer == '\x01') {
    offset = 0x69;
  }
  strcpy(upstr,TextSys_Word((int)index));
  s_lower(upstr);
  FETextRender_FullText(upstr,0x30,offset | 0x10,textType_Title,textState_Selected,0);
  r.x = 0x2b;
  r.y = offset + 0x12;
  r.w = textpixels(upstr) + 10;
  r.h = 0xc;
  PSXDrawTransSquare(0,r.x,r.y,r.w,r.h,2);
  FeDraw_SetABRMode(0);
  return;
}



/* ---- FETextRender_SetABR  [FETEXTRENDER.CPP:441-443] SLD-VERIFIED ---- */

void FETextRender_SetABR(int abr,bool trans)

{
  
  gSemiTransText_arr[0] = trans;
  Font_SetABR(abr);
  return;
}



/* end of fetextrender.cpp */
