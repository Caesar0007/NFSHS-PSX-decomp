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
int  gSemiTransText = 0;            /* @0x8005160c */


/* ---- FETextRender_SetFont  [FETEXTRENDER.CPP:72-88] SLD-VERIFIED ---- */

void FETextRender_SetFont(int size)

{
  char *f1;
  
  if (currentSize != size) {
    currentSize = (short)size;
    f1 = font12;
    if ((currentSize != 0) && (f1 = fontTitle, currentSize != 3)) {
      f1 = font18;
    }
    Font_SwitchFont(f1);
  }
  return;
}



/* ---- FETextRender_FullTextRGB  [FETEXTRENDER.CPP:94-127] SLD-VERIFIED ---- */

void FETextRender_FullTextRGB(char *sMenuText,short x,short y,int col,char size,short justify)

{
  short sVar1;
  char buffer [128];
  int iVar2;
  
  FETextRender_SetFont((u_int)(u_char)size);
  if ((u_char)size == 0) {
    sprintf(buffer,"%s",sMenuText);
    s_lower(buffer);
    sMenuText = buffer;
  }
  if (((justify == 1) || (justify == 4)) || (justify == 6)) {
    iVar2 = textpixels(sMenuText);
    sVar1 = (short)iVar2;
  }
  else {
    if ((justify != 2) && (justify != 5)) goto FETextFullRGB_setSemiTrans;
    iVar2 = textpixels(sMenuText);
    sVar1 = (short)(iVar2 / 2);
  }
  x = x - sVar1;
FETextFullRGB_setSemiTrans:
  iVar2 = 1;
  if (gSemiTransText != 0) {
    iVar2 = 0xf;
  }
  Font_TextColor(iVar2);
  Font_TextTint(col);
  Font_TextXY(sMenuText,(int)x,(int)y);
  if ((u_short)(justify - 3U) < 3) {
    Font_TextTint(0);
    Font_TextXY(sMenuText,x + 2,y + 1);
  }
  return;
}



/* ---- FETextRender_FullText  [FETEXTRENDER.CPP:136-139] SLD-FLAG:NONMONO ---- */
void FETextRender_FullText(char *sMenuText,short x,short y,tMenuTextType textType,tMenuTextState textState,
               short justify)

{
  
  FETextRender_FullTextRGB(sMenuText,x,y,
             kRGBVals[(u_char)textDefinitions[textType][textState + textState_NumStates]],
             textDefinitions[textType][0],justify);
  return;
}



/* ---- FETextRender_FullTextFade  [FETEXTRENDER.CPP:144-147] SLD-VERIFIED ---- */
void FETextRender_FullTextFade(int fade,char *sMenuText,short x,short y,tMenuTextType textType,
               tMenuTextState textState,short justify)

{
  int col;
  
  col = CalcFadeVal(kRGBVals[(u_char)textDefinitions[textType][textState + textState_NumStates]],
                   (int)x);
  FETextRender_FullTextRGB(sMenuText,x,y,col,textDefinitions[textType][0],justify);
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
  int iVar1;
  int iVar2;
  int wordnum;
  
  wordnum = (int)index;
  iVar1 = TextSys_WordX(wordnum);
  iVar2 = TextSys_WordY(wordnum);
  if (textType == textType_Default) {
    textType = (tMenuTextType)TextSys_WordFlags(wordnum);
  }
  FETextRender_MenuTextPositionedJustifyFade(fade,index,(short)iVar1,(short)iVar2,(u_short)(u_char)textDefinitions[textType][1],
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
  char *sMenuText;
  
  if ((justify == 6) || (textType == textType_Title)) {
    FETextRender_Title(index);
  }
  else {
    if (textType == textType_Default) {
      textType = (tMenuTextType)TextSys_WordFlags((int)index);
    }
    sMenuText = TextSys_Word((int)index);
    FETextRender_FullTextFade(fade,sMenuText,x,y,textType,textState,justify);
  }
  return;
}



/* ---- FETextRender_WordWrapTextRGBJustify  [FETEXTRENDER.CPP:216-355] SLD-VERIFIED ---- */

int FETextRender_WordWrapTextRGBJustify(char *str,RECT &r,int col,int justify,int size,bool JustGrabHeight)

{
  char cVar1;
  short sVar2;
  u_int uVar3;
  u_int uVar4;
  short sVar5;
  u_int uVar6;
  int iVar7;
  short sVar8;
  u_int uVar9;
  u_int uVar10;
  char buffer [128];
  char source [512];
  
  sVar2 = r.y;
  FETextRender_SetFont(size);
  if (size == 1) {
    sVar8 = 10;
  }
  else {
    sVar8 = 0x10;
    if ((size < 2) && (size == 0)) {
      sVar8 = 8;
    }
  }
  uVar10 = 0;
  uVar3 = strlen(str);
  iVar7 = 1;
  if (gSemiTransText != 0) {
    iVar7 = 0xf;
  }
  Font_TextColor(iVar7);
  Font_TextTint(col);
  blockmove(str,source,uVar3 + 1);
  if (size == 0) {
    s_lower(source);
  }
  if (0 < (int)uVar3) {
    uVar4 = 0;
    do {
      cVar1 = source[uVar4];
      uVar4 = uVar10;
      while (cVar1 == ' ') {
        uVar4 = uVar4 + 1;
        cVar1 = source[uVar4 & 0xffff];
      }
      uVar10 = uVar4 + ((int)((u_int)(u_short)r.w << 0x10) >> 0x13) + 10;
      uVar9 = uVar4 & 0xffff;
      if ((int)uVar3 < (int)(uVar10 & 0xffff)) {
        uVar10 = uVar3;
      }
      iVar7 = (uVar10 & 0xffff) - uVar9;
      blockmove(source + uVar9,buffer,iVar7 + 1);
      buffer[iVar7] = '\0';
      iVar7 = textpixels(buffer);
      uVar6 = uVar10 & 0xffff;
      if (r.w < (short)iVar7) {
        do {
          if (source[uVar6] == ' ') goto FETextRender_skipTrailSpace;
          do {
            if (uVar6 <= uVar9) break;
            uVar10 = uVar10 - 1;
            uVar6 = uVar10 & 0xffff;
          } while (source[uVar6] != ' ');
          cVar1 = source[uVar10 & 0xffff];
          while (cVar1 == ' ') {
FETextRender_skipTrailSpace:
            if ((uVar10 & 0xffff) <= uVar9) break;
            uVar10 = uVar10 - 1;
            cVar1 = source[uVar10 & 0xffff];
          }
          buffer[((uVar10 & 0xffff) - uVar9) + 1] = '\0';
          iVar7 = textpixels(buffer);
        } while ((r.w < (short)iVar7) && (uVar6 = uVar10 & 0xffff, uVar9 < (uVar10 & 0xffff)));
        uVar6 = uVar10 & 0xffff;
      }
      if (uVar6 == (uVar4 & 0xffff)) {
        buffer[1] = source[uVar6 + 1];
        cVar1 = source[uVar6];
        while ((cVar1 != '\0' && (source[uVar6] != ' '))) {
          uVar10 = uVar10 + 1;
          uVar6 = uVar10 & 0xffff;
          cVar1 = source[uVar6];
        }
        buffer[(uVar10 & 0xffff) - (uVar4 & 0xffff)] = '\0';
      }
      uVar9 = uVar10 & 0xffff;
      cVar1 = source[uVar9];
      while (cVar1 != '\0') {
        if (source[uVar9] == ' ') goto FETextRender_skipLeadSpace;
        uVar10 = uVar10 + 1;
        uVar9 = uVar10 & 0xffff;
        cVar1 = source[uVar9];
      }
      cVar1 = source[uVar10 & 0xffff];
      while (cVar1 == ' ') {
FETextRender_skipLeadSpace:
        uVar10 = uVar10 + 1;
        cVar1 = source[uVar10 & 0xffff];
      }
      buffer[(uVar10 & 0xffff) - (uVar4 & 0xffff)] = '\0';
      iVar7 = textpixels(buffer);
      sVar5 = r.x;
      if ((justify == 1) || (justify == 4)) {
        sVar5 = sVar5 - (short)iVar7;
      }
      else if ((justify == 2) || (justify == 5)) {
        sVar5 = sVar5 - ((short)iVar7 >> 1);
      }
      if (JustGrabHeight == 0) {
        Font_TextXY(buffer,(int)sVar5,(int)r.y);
        if (justify - 3U < 3) {
          Font_TextTint(0);
          Font_TextXY(buffer,sVar5 + 2,r.y + 1);
          Font_TextTint(col);
        }
      }
      r.y = r.y + sVar8;
      uVar4 = uVar10 & 0xffff;
    } while ((int)(uVar10 & 0xffff) < (int)uVar3);
  }
  return (int)r.y - (int)sVar2;
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
  char *str;
  
  str = TextSys_Word((int)index);
  FETextRender_WordWrapTextFade(fade,str,r,state,type);
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
  int h;
  RECT r;
  
  r.h = 500;
  r.x = 0;
  r.y = 0;
  r.w = width;
  h = FETextRender_WordWrapTextRGBJustify(str,r,0,0,0,true);
  return h;
}



/* ---- FETextRender_Title  [FETEXTRENDER.CPP:420-437] SLD-VERIFIED ---- */

void FETextRender_Title(short index)

{
  char *src;
  int iVar1;
  u_short uVar2;
  char upstr [80];
  
  uVar2 = 0;
  if (FEApp->fPlayer == '\x01') {
    uVar2 = 0x69;
  }
  src = TextSys_Word((int)index);
  strcpy(upstr,src);
  s_lower(upstr);
  FETextRender_FullText(upstr,0x30,uVar2 | 0x10,textType_Title,textState_Selected,0);
  iVar1 = textpixels(upstr);
  
  PSXDrawTransSquare(0,0x2b,(int)(short)(uVar2 + 0x12),(iVar1 + 10) * 0x10000 >> 0x10,0xc,2);
  FeDraw_SetABRMode(0);
  return;
}



/* ---- FETextRender_SetABR  [FETEXTRENDER.CPP:441-443] SLD-VERIFIED ---- */

void FETextRender_SetABR(int abr,bool trans)

{
  
  gSemiTransText = trans;
  Font_SetABR(abr);
  return;
}



/* end of fetextrender.cpp */
