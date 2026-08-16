/* frontend/common/femenuextended.cpp -- RECONSTRUCTED (NFS4 menu/item widget hierarchy; C++ TU)
 *   56 fns across 9 classes: tMenuNFS4(+TwoPlayer/Bottom) menu containers, tMenuBlank, tMenuOptions,
 *   tMenuItemGoToMenuNFS4Button, tMenuItemNFS4LeftRightChoice, tMenuItemOptions{LeftRightChoice,
 *   TwoItemChoice}, + free MenuNFS4_DrawTextBox. Member defs; base ctors via init-lists; manual _vf.
 */
#include "femenuextended.h"

/* ---- FEMenuExtended.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
static RECT  gHelpPos;   /* @0x80052b58  (bss(zero)); SYM STAT */

typedef struct tPsyQPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tPsyQPrimTag;


/* ---- MenuNFS4_SetHelpPos__FR4RECT  [@0x800?] ---- RECONSTRUCTED 2026-06-12 (Ghidra @NFS4.EXE.c:5887).
 *  SYM-CONFORM: the GCC-v2 spelling above is the linkage key; retail source is
 *  the demangled MenuNFS4_SetHelpPos(RECT&) declaration. */
static void MenuNFS4_SetHelpPos(RECT &r)
{
  gHelpPos.x = r.x;
  gHelpPos.y = r.y;
  gHelpPos.w = r.w;
  gHelpPos.h = r.h;
}



/* ---- MenuNFS4_DrawTextBox  [FEMENUEXTENDED.CPP:66-137] SLD-VERIFIED ---- */
/* MATCH: 6 -> 4 diffs (W56-A9/W66). Removed the fabricated `int maxw` local (NOT in the
   SYM 8c block -- locals are helpText/r/initialWidth/drawOffset/fSelFade/
   drawArrows/reflected/drenv/daprim/temp/textpix/dist($15=s5)/drawFlags/buffer/
   shape/col/ypos); `dist=(max)+0x19` inline is codegen-neutral (293->293) but
   SYM-faithful.  W66 removed the likewise fabricated `RECT *rect` local and uses
   the native RECT& parameter directly; that moves Draw_gPlayer1View's `lui` to
   its retail prologue position with no instruction-count change.  REMAINING 4:
   `addiu s5,v1,25` (dist=max+25) -- oracle fills the CalcTextFadeSelToHi
       jal delay slot with it, ours fills the slot with `addu a2,zero,zero`
       (the 3rd arg 0) and computes dist before the call. Both are reorg
       fill-candidate choices.  Moving the assignment after the call produces the
       exact local sequence but swaps helpText/fSelFade $s1/$s2 (30); a named max
       carrier costs a saved register and a 176-byte frame (136).  Inline helpers,
       declaration-vs-assignment, and comma placement are neutral at 4. */

void MenuNFS4_DrawTextBox(int helpText,RECT &r,int initialWidth,short drawOffset,short fSelFade,
               bool drawArrows,bool reflected)

{
  DRAWENV *drenv;
  u_char *daprim;
  RECT temp;
  int dist;
  int textpix;
  tDrawShapeExtended drawFlags;
  char buffer [64];
  tTexture_ShapeInfo *shape;

  dist = initialWidth;
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  drawFlags.tint[0] = CalcFadeVal(0xb54200,0xbebe,(int)fSelFade);
  if (reflected != 0) {
    drawFlags.tint[0] = CalcFadeVal(0,drawFlags.tint[0],0xe0 - r.y);
  }
  DrawShape_SubtractNFS4RectEdges(r);   /* W58-A1: decl is RECT& (was `(...)`) -- same $a0 address */
  if (-1 < helpText) {
    daprim = Render_gPacketPtr;
    temp.x = 0;
    temp.y = *(short *)((char *)drenv + 2);
    temp.w = 0x200;
    temp.h = 0xf0;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
    Render_gPacketPtr = daprim + 0xc;
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    SetDrawArea((DR_AREA *)daprim,&temp);
    FETextRender_SetFont(0);
    sprintf(buffer,"%s",TextSys_Word(helpText));
    s_upper(buffer);
    textpix = textpixels(buffer) - strlen(buffer);
    dist = (textpix >= dist ? textpix : dist) + 0x19;
    {
      int col = CalcTextFadeSelToHi(textType_FlybyHelp,fSelFade,0);
      if (reflected != 0) {
        col = CalcFadeVal(0,col,0xf0 - r.y);
      }
      FETextRender_FullTextRGB((char *)TextSys_Word(helpText),
                 (short)(r.x + drawOffset),r.y + 4,
                 col,'\0',0);
      {
        FETextRender_FullTextRGB((char *)TextSys_Word(helpText),
                   (short)(r.x + drawOffset - dist),r.y + 4,col,'\0',0);
        if (drawArrows != 0) {
          int ypos = r.y + ((int)((u_int)(u_short)r.h << 0x10) >> 0x11);
          if (reflected == 0) {
            ypos = ypos + 2;
          }
          DrawShapeExtended(0xa,0x118,(r.x + drawOffset) - 0xa,ypos,0,0,&drawFlags);
          DrawShapeExtended(0xb,0x118,r.x + drawOffset + textpix + 8,ypos,0,0,&drawFlags);
          DrawShapeExtended(0xa,0x118,((r.x + drawOffset) - dist) - 0xa,ypos,0,0,&drawFlags);
          DrawShapeExtended(0xb,0x118,((r.x + drawOffset) - dist) + textpix + 8,ypos,0,0,&drawFlags);
        }
      }
    }
    daprim = Render_gPacketPtr;
    temp = r;
    temp.y = temp.y + *(short *)((char *)drenv + 2);
    temp.x = temp.x + 2;
    temp.w = temp.w + -4;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
    Render_gPacketPtr = daprim + 0xc;
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    SetDrawArea((DR_AREA *)daprim,&temp);
  }
  temp = r;
  temp.y++;
  temp.h -= 2;
  shape = gHelpShapes + 0x1e;
  temp.w -= 1 + (shape->width >> 1);
  DrawShapeExtended(0x1e,8,(int)temp.x + (int)temp.w,(int)temp.y,0,0,(tDrawShapeExtended *)0x0);
  PSXDrawSquare(0,(int)temp.x,(int)temp.y,(int)temp.w,(int)shape->height);
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::ctor  [FEMENUEXTENDED.CPP:152-160] SLD-FLAG:NONMONO ---- */

tMenuItemGoToMenuNFS4Button::tMenuItemGoToMenuNFS4Button(u_int textDescription,tMenu *newMenu,
              void (*OnButtonPress)(tMenuCommand&),int firstFrame,int numFrames)
  : tMenuItemGoToMenuButton(textDescription,newMenu,OnButtonPress)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemGoToMenuNFS4Button_vtable;
  this->fOffset = 0xe;
  this->fTransitionVal = 0;
  this->fTransitionSpeed = 0;
  this->fEnabledTransitionVal = 0;
  this->fNumFrames = numFrames;
  this->fButtonImage = firstFrame;
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::dtor  [FEMENUEXTENDED.CPP:164-164] SLD-VERIFIED ---- */

tMenuItemGoToMenuNFS4Button::~tMenuItemGoToMenuNFS4Button()

{
  *(void **)&(this->_vf) = (void *)tMenuItemGoToMenuNFS4Button_vtable;
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::Draw  [FEMENUEXTENDED.CPP:168-211] SLD-VERIFIED ---- */

void tMenuItemGoToMenuNFS4Button::Draw(int x,int y,bool selected)

{
  short sVar1;
  short dist;
  RECT rect;
  char buffer [64];
  
  if ((selected == 0) && (this->fOffset + -0xe < 2)) {
    this->fOffset = 0xe;
  }
  else {
    FETextRender_SetFont(0);
    sprintf(buffer,"%s",TextSys_Word(this->fTextDescription));
    s_upper(buffer);
    dist = textpixels(buffer) - strlen(buffer);
    if (dist < 0x8c) {
      dist = 0xa5;
    } else {
      dist = dist + 0x19;
    }
    sVar1 = this->fOffset;
    this->fOffset = sVar1 + -2;
    if (selected == 0) {
      this->fOffset = sVar1 + -4;
    }
    if (this->fOffset < 0) {
      this->fOffset = (u_short)this->fOffset + dist;
    }
  }
  if (((this->fFlags ^ 1) & 1) != 0) {
    this->fEnabledTransitionVal = this->fEnabledTransitionVal + 0xc;
  }
  else {
    this->fEnabledTransitionVal = this->fEnabledTransitionVal - 0xc;
  }
  if (this->fEnabledTransitionVal < 0) {
    this->fEnabledTransitionVal = 0;
  }
  else if (0x80 < this->fEnabledTransitionVal) {
    this->fEnabledTransitionVal = 0x80;
  }
  rect.x = (short)x;
  rect.y = (short)y;
  rect.w = 0x73;
  rect.h = 0xb;
  if (this->fTransitionVal > this->fEnabledTransitionVal) {
    dist = this->fEnabledTransitionVal;
  }
  else {
    dist = this->fTransitionVal;
  }
  rect.w = (short)(rect.w * dist / 0x80);
  MenuNFS4_DrawTextBox(this->fTextDescription,rect,
             0x8c,this->fOffset,
             this->fSelFade,false,0);
  if ((this->fFlags & 0x200) != 0) {
    Font_SetBlitter(FontUpsideDownBlit);
    rect.x = (short)x;
    rect.y = 0x118 - (short)y;
    rect.w = 0x73;
    rect.h = 0xb;
    if (this->fTransitionVal > this->fEnabledTransitionVal) {
      dist = this->fEnabledTransitionVal;
    }
    else {
      dist = this->fTransitionVal;
    }
    rect.w = (short)(rect.w * dist / 0x80);
    MenuNFS4_DrawTextBox(this->fTextDescription,rect
               ,0x8c,this->fOffset,
               this->fSelFade,false,1);
    Font_ReSetBlitter();
  }
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::TransitionOn  [FEMENUEXTENDED.CPP:216-218] SLD-VERIFIED ---- */

void tMenuItemGoToMenuNFS4Button::TransitionOn()

{
  this->fEnabledTransitionVal = 0;
  this->fTransitionSpeed = 0xc;
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::TransitionOff  [FEMENUEXTENDED.CPP:222-223] SLD-VERIFIED ---- */

void tMenuItemGoToMenuNFS4Button::TransitionOff()

{
  this->fTransitionSpeed = -0xc;
  return;
}



/* ---- tMenuItemGoToMenuNFS4Button::TransitionIsFinished  [FEMENUEXTENDED.CPP:227-228] SLD-VERIFIED ---- */

void * tMenuItemGoToMenuNFS4Button::TransitionIsFinished()

{
  return (void *)(u_int)(this->fTransitionSpeed == 0);
}



/* ---- tMenuItemGoToMenuNFS4Button::UpdateTransition  [FEMENUEXTENDED.CPP:232-244] SLD-VERIFIED ---- */

void tMenuItemGoToMenuNFS4Button::UpdateTransition(bool selected)

{
  short sVar1;
  
  sVar1 = this->fTransitionVal + this->fTransitionSpeed;
  this->fTransitionVal = sVar1;
  if (sVar1 < 0) {
    this->fTransitionVal = 0;
  }
  else {
    if (sVar1 < 0x81) goto UpdTrans_callBaseGoToMenu;
    this->fTransitionVal = 0x80;
  }
  this->fTransitionSpeed = 0;
UpdTrans_callBaseGoToMenu:
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::ctor  [FEMENUEXTENDED.CPP:248-254] SLD-VERIFIED ---- */
tMenuItemNFS4LeftRightChoice::tMenuItemNFS4LeftRightChoice(u_int textDescription,tListIterator *dataPtr,
          int firstFrame,int numFrames)
  : tMenuItemLeftRightChoice(textDescription,dataPtr)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemNFS4LeftRightChoice_vtable;
  this->fButtonImage = firstFrame;
  this->fOffset = 0xe;
  this->fTransitionVal = 0;
  this->fTransitionSpeed = 0;
  this->fNumFrames = numFrames;
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::dtor  [FEMENUEXTENDED.CPP:258-258] SLD-VERIFIED ---- */

tMenuItemNFS4LeftRightChoice::~tMenuItemNFS4LeftRightChoice()

{
  *(void **)&(this->_vf) = (void *)tMenuItemNFS4LeftRightChoice_vtable;
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::Draw  [FEMENUEXTENDED.CPP:262-302] SLD-VERIFIED ---- */
/* MATCH 100% (W57-A5, was 117). Five stacked levers, in the order they landed:
   117->95 guard/step/clamp shape copied VERBATIM from the already-PASSing sibling
          tMenuItemGoToMenuNFS4Button::Draw (arm order + field-direct fOffset step);
    95->88 dropped the Ghidra `int iVar5 = selected` copy (a fabricated pseudo costs a
          callee-saved reg + 4 frame bytes);
    88->65 `rect.w = 0x73` stored FIRST then multiplied by the FIELD rect.w (real
          `li v1,115; mult`) -- multiplying by the literal strength-reduces to a
          6-insn shift/add chain (catalog 06D multiply-by-the-VARIABLE);
    65->30 same treatment for the mirrored (fFlags & 0x200) block;
    30->12 the drawArrows flag computed INSIDE the argument list;
    12-> 0 comparison operand order = LOAD order (`enabled > transVal` loads 38 before
          34) + multiply operand order `sVar4 * rect.w` (moves `li 115` after the
          sign-extend, which frees the beqz slot for the oracle's `sll v0,a0,16`). */

void tMenuItemNFS4LeftRightChoice::Draw(int x,int y,bool selected)

{
  short sVar1;
  short dist;
  char *string;
  int iVar2;
  bool bVar3;
  short sVar4;
  RECT rect;
  
  /* MATCH (W57-A5): shape taken VERBATIM from the PASSing sibling
     tMenuItemGoToMenuNFS4Button::Draw -- guard arm order (selected==0 && offset-14<2),
     field-direct offset step (`lh`+`lhu` re-read pair), and the field-direct
     fEnabledTransitionVal step+clamp. */
  if ((selected == 0) && (this->fOffset + -0xe < 2)) {
    this->fOffset = 0xe;
  }
  else {
    FETextRender_SetFont(0);
    string = TextSys_Word(this->fTextDescription);
    iVar2 = textpixels(string);
    dist = 0xa5;
    if (0x8b < (short)iVar2) {
      dist = (short)iVar2 + 0x19;
    }
    sVar1 = this->fOffset;
    this->fOffset = sVar1 + -2;
    if (selected == 0) {
      this->fOffset = sVar1 + -4;
    }
    if (this->fOffset < 0) {
      this->fOffset = (u_short)this->fOffset + dist;
    }
  }
  if (((this->fFlags ^ 1) & 1) != 0) {
    this->fEnabledTransitionVal = this->fEnabledTransitionVal + 0xc;
  }
  else {
    this->fEnabledTransitionVal = this->fEnabledTransitionVal - 0xc;
  }
  if (this->fEnabledTransitionVal < 0) {
    this->fEnabledTransitionVal = 0;
  }
  else if (0x80 < this->fEnabledTransitionVal) {
    this->fEnabledTransitionVal = 0x80;
  }
  /* MATCH (W57-A5): rect.w = 0x73 STORED first, then multiplied by the FIELD
     (`li v1,115; mult` -- 06D multiply-by-the-VARIABLE) instead of by the literal
     (which strength-reduces to a 6-insn shift/add chain); field order per oracle. */
  rect.x = (short)x;
  rect.y = (short)y;
  rect.w = 0x73;
  rect.h = 0xb;
  sVar4 = this->fEnabledTransitionVal;
  if (this->fEnabledTransitionVal > this->fTransitionVal) {
    sVar4 = this->fTransitionVal;
  }
  rect.w = (short)(sVar4 * rect.w / 0x80);
  /* MATCH (W57-A5): the drawArrows flag is computed INSIDE the argument list --
     retail emits the a3/16(sp) arg loads BEFORE the flag's branch. */
  MenuNFS4_DrawTextBox(this->fTextDescription,rect,
             0x8c,this->fOffset,
             this->fSelFade,(selected != 0) || (this->fOffset != 0xe),0);
  if ((this->fFlags & 0x200) != 0) {
    Font_SetBlitter(FontUpsideDownBlit);
    rect.x = (short)x;
    rect.y = 0x118 - (short)y;
    rect.w = 0x73;
    rect.h = 0xb;
    sVar4 = this->fTransitionVal;
    if (this->fTransitionVal > this->fEnabledTransitionVal) {
      sVar4 = this->fEnabledTransitionVal;
    }
    rect.w = (short)(sVar4 * rect.w / 0x80);
    MenuNFS4_DrawTextBox(this->fTextDescription,
               rect,0x8c,this->fOffset,
               this->fSelFade,(selected != 0) || (this->fOffset != 0xe),1);
    Font_ReSetBlitter();
  }
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::TransitionOn  [FEMENUEXTENDED.CPP:307-309] SLD-VERIFIED ---- */

void tMenuItemNFS4LeftRightChoice::TransitionOn()

{
  this->fEnabledTransitionVal = 0;
  this->fTransitionSpeed = 0xc;
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::TransitionOff  [FEMENUEXTENDED.CPP:313-314] SLD-VERIFIED ---- */

void tMenuItemNFS4LeftRightChoice::TransitionOff()

{
  this->fTransitionSpeed = -0xc;
  return;
}



/* ---- tMenuItemNFS4LeftRightChoice::TransitionIsFinished  [FEMENUEXTENDED.CPP:318-319] SLD-VERIFIED ---- */

void * tMenuItemNFS4LeftRightChoice::TransitionIsFinished()

{
  return (void *)(u_int)(this->fTransitionSpeed == 0);
}



/* ---- tMenuItemNFS4LeftRightChoice::UpdateTransition  [FEMENUEXTENDED.CPP:323-335] SLD-VERIFIED ---- */

void tMenuItemNFS4LeftRightChoice::UpdateTransition(bool selected)

{
  short sVar1;
  
  sVar1 = this->fTransitionVal + this->fTransitionSpeed;
  this->fTransitionVal = sVar1;
  if (sVar1 < 0) {
    this->fTransitionVal = 0;
  }
  else {
    if (sVar1 < 0x81) goto UpdTrans_callBaseLRChoice;
    this->fTransitionVal = 0x80;
  }
  this->fTransitionSpeed = 0;
UpdTrans_callBaseLRChoice:
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemOptionsLeftRightChoice::Draw  [FEMENUEXTENDED.CPP:346-374] SLD-VERIFIED ---- */
/* MATCH 100% (W57-A5, was 72). ONE lever: the DrawShapeExtended highlight flag is a
   COND_EXPR `selected ? 0 : 1` written INLINE as the stack argument, NOT the boolean
   `(u_int)(selected == 0)`.  The comparison form emits a single `sltu`/`sltiu` that gcc
   CSEs across both call sites (and drags the &drawFlags / y+6 addresses into callee-saved
   regs with it); the COND_EXPR expands per site with the outgoing 20(sp) arg slot as the
   target, so each arm STORES its constant into the slot (`beqz;sw zero;j;sw s7`) and the
   shared `1` is cse'd out of the earlier FullTextRGB call into s7 -- exactly retail. */

void tMenuItemOptionsLeftRightChoice::Draw(int x,int y,bool selected)

{
  tTexture_ShapeInfo *left;
  short sVar2;
  int col;
  char *pcVar3;
  __vtbl_ptr_type (*pa_Var4) [6];
  tListIterator *ptVar5;
  short y_00;
  RECT r;
  tDrawShapeExtended drawFlags;
  
  left = &gHelpShapes[0x29];
  col = CalcTextFadeSelToHi(textType_Options,
                      this->fSelFade,0);
  pcVar3 = TextSys_Word(this->fTextDescription);
  y_00 = (short)((u_int)((y + 3) * 0x10000) >> 0x10);
  FETextRender_FullTextRGB(pcVar3,(short)((u_int)((x + 0x94) * 0x10000) >> 0x10),y_00,col,'\0',1);
  ptVar5 = this->fData;
  pa_Var4 = ptVar5->_vf;
  sVar2 = (*(*pa_Var4)[3].pfn)((char *)ptVar5 + (int)(*pa_Var4)[3].delta,0xffffffff);
  pcVar3 = TextSys_Word((int)sVar2);
  FETextRender_FullTextRGB(pcVar3,(short)((u_int)((((int)((u_int)(u_short)left->width << 0x10) >> 0x11) + x +
                                   0xd9) * 0x10000) >> 0x10),y_00,col,'\0',2);
  drawFlags.tint[0] =
       CalcFadeVal(0xb54200,0xbebe,
                  (int)this->fSelFade);
  DrawShapeExtended(0xa,0x118,x + 0xa6,y + 6,0,selected ? 0 : 1,
             &drawFlags);
  DrawShapeExtended(0xb,0x118,(x - (int)left->width) + 0x12f,y + 6,0,selected ? 0 : 1,
             &drawFlags);
  r.x = (short)x;
  r.y = (short)y;
  r.w = 0x129;
  r.h = left->height;
  DrawShape_NFS4RoundRectangle(-1,r,(short)selected);
  return;
}



/* ---- tMenuItemOptionsTwoItemChoice::TransitionOn  [FEMENUEXTENDED.CPP:378-379] SLD-VERIFIED ---- */

void tMenuItemOptionsTwoItemChoice::TransitionOn()

{
  u_int cVar1;
  u_int bVar;
  tListIterator *ptVar2;
  __vtbl_ptr_type (*pa_Var3) [6];

  ptVar2 = this->fData;
  pa_Var3 = ptVar2->_vf;
  cVar1 = (u_char)(*(*pa_Var3)[2].pfn)((char *)ptVar2 + (int)(*pa_Var3)[2].delta,0xffffffff);
  bVar = (u_int)(0 < cVar1);
  this->fOnOffFade = bVar << 7;
  return;
}



/* ---- tMenuItemOptionsTwoItemChoice::Draw  [FEMENUEXTENDED.CPP:383-428] SLD-VERIFIED ---- */
/* MATCH 100% (W57-A5, was 87): 87->84 fOnOffFade step arm ORDER (retail's fall-through
   arm is the `!= 0` one); 84->80 the fOnOffFade step written on the FIELD (`lhu;addiu`
   per arm, cross-jumped store) instead of through a short local; 80->59 `left =
   &gHelpShapes[0x29]` placed BEFORE the fData vtable call (its `addiu s3,v1,1312` is
   the jalr delay-slot filler); 59->37 the DrawShapeExtended flag as `selected ? 0 : 1`
   (see OptionsLeftRightChoice) -- note `iVar8 ? 0 : 1` does NOT work, the int copy
   canonicalizes back to a setcc; 37->21 dropped the `int iVar8 = selected` copy;
   21->0 the clamp as a flat nested if/else-if reading the FIELD at each test (the
   Ghidra comma/&& form materializes a real boolean; a short local lets cse remat the
   value in-register instead of retail's `lh`+`lhu` reload pair). */

void tMenuItemOptionsTwoItemChoice::Draw(int x,int y,bool selected)

{
  tTexture_ShapeInfo *left;
  char cVar2;
  short sVar3;
  tListIterator *ptVar4;
  int Col;
  char *pcVar5;
  short sVar6;
  __vtbl_ptr_type (*pa_Var7) [6];
  RECT r;
  tDrawShapeExtended drawFlags;
  int ColTextOn;
  int ColTextOff;
  
  ptVar4 = this->fData;
  pa_Var7 = ptVar4->_vf;
  left = &gHelpShapes[0x29];
  cVar2 = (*(*pa_Var7)[2].pfn)((char *)ptVar4 + (int)(*pa_Var7)[2].delta,0xffffffff);
  if (cVar2 != '\0') {
    this->fOnOffFade = this->fOnOffFade + 0x40;
  }
  else {
    this->fOnOffFade = this->fOnOffFade + -0x40;
  }
  /* MATCH (W57-A5): the clamp re-reads the FIELD (oracle `lh`+`lhu` pair) -- routing the
     stepped value through a short local instead lets cse remat it in-register (sll/sra). */
  /* MATCH/CFG (w65-a1, 04Q class): retail's `blez` for the <1 arm jumps to the
     SHARED negative-clamp block (branch word 36: ours +6 vs retail +4), i.e. the
     low arm and the in-range arm run the SAME `sVar3 = fOnOffFade; if (< 0)
     sVar3 = 0;` code -- which is value-identical to a plain `sVar3 = 0` for
     every v <= 0.  Falsified (both re-gated): folding the two guards into
     `v < 1 || v < 0x80` (and the &&-mirror) loses a branch entirely, 160 insns;
     physically DUPLICATING the arm body is count-exact 161 and also routes
     right, but costs 12 coloring diffs -- only the shared block matches. */
  if (this->fOnOffFade < 1) {
    goto fme_clampLow;
  }
  else if (this->fOnOffFade < 0x80) {
fme_clampLow:
    sVar3 = this->fOnOffFade;
    if (this->fOnOffFade < 0) {
      sVar3 = 0;
    }
  }
  else {
    sVar3 = 0x80;
  }
  this->fOnOffFade = sVar3;
  Col = CalcTextFadeSelToHi(textType_Options,this->fSelFade,0);
  CalcOnOffFade(textType_Options,this->fOnOffFade,
             this->fSelFade,0,ColTextOn,
             ColTextOff);   /* W58-A1: decl is int& (was `(...)`) -- same $a4/$a5 addresses */
  pcVar5 = TextSys_Word(this->fTextDescription);
  sVar6 = (short)((u_int)((y + 3) * 0x10000) >> 0x10);
  FETextRender_FullTextRGB(pcVar5,(short)((u_int)((x + 0x94) * 0x10000) >> 0x10),sVar6,Col,'\0',1);
  pcVar5 = TextSys_Word((int)*(this->fData)->fSelectionList);
  FETextRender_FullTextRGB(pcVar5,(short)((u_int)((x + 0xb0) * 0x10000) >> 0x10),sVar6,ColTextOff,'\0',0);
  pcVar5 = TextSys_Word((int)(this->fData)->fSelectionList[1]);
  FETextRender_FullTextRGB(pcVar5,(short)(((x - (u_int)(u_short)left->width) + 0x126) * 0x10000 >> 0x10),
             sVar6,ColTextOn,'\0',1);
  drawFlags.tint[0] =
       CalcFadeVal(0xb54200,0xbebe,
                  (int)this->fSelFade);
  DrawShapeExtended(0xa,0x118,x + 0xa6,y + 6,0,selected ? 0 : 1,
             &drawFlags);
  DrawShapeExtended(0xb,0x118,(x - (int)left->width) + 0x12f,y + 6,0,selected ? 0 : 1,
             &drawFlags);
  r.x = (short)x;
  r.y = (short)y;
  r.w = 0x129;
  r.h = left->height;
  DrawShape_NFS4RoundRectangle(-1,r,(short)selected);
  return;
}



/* ---- tMenuNFS4::ctor  [FEMENUEXTENDED.CPP:439-444] SLD-VERIFIED ---- */

tMenuNFS4::tMenuNFS4(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
                 tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{

  this->_vf = (__vtbl_ptr_type (*)[11])tMenuNFS4_vtable;
  this->tMenuConstructor(firstItem,(&firstItem + 1));
  return;
}



/* ---- tMenuNFS4::ctor  [FEMENUEXTENDED.CPP:454-455] SLD-VERIFIED ---- */

tMenuNFS4::tMenuNFS4(u_int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu,
              void (*OnButtonPress)(tMenuCommand&),short title)
  : tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  *(void **)&(this->_vf) = (void *)tMenuNFS4_vtable;
  return;
}



/* ---- tMenuNFS4::dtor  [FEMENUEXTENDED.CPP:459-459] SLD-VERIFIED ---- */

tMenuNFS4::~tMenuNFS4()

{
  *(void **)&(this->_vf) = (void *)tMenuNFS4_vtable;
  return;
}



/* ---- tMenuNFS4::Initialize  [FEMENUEXTENDED.CPP:463-476] SLD-VERIFIED ---- */

void tMenuNFS4::Initialize()

{
  short item;
  u_char bVar1;
  tMenuItem *ptVar2;
  u_int *puVar3;

  this->tMenu::Initialize();
  this->fLastItem = (char)this->fCurrentItem;
  ptVar2 = this->fItemList[0];
  this->fInItemTransition = 0;
  this->fInMenuTransition = 0;
  this->fNumItems = '\0';
  if (ptVar2 != (tMenuItem *)0x0) {
    do {
      bVar1 = this->fNumItems + 1;
      this->fNumItems = bVar1;
    } while (this->fItemList[bVar1] != (tMenuItem *)0x0);
  }
  item = 0;
  if ((this->fFlags & 0x200) != 0) {
    while( true ) {
      puVar3 = (u_int *)this->fItemList[item];
      item = item + 1;
      if (puVar3 == (u_int *)0x0) break;
      *puVar3 = *puVar3 | 0x200;
    }
  }
  return;
}



/* ---- tMenuNFS4::ProcessInput  [FEMENUEXTENDED.CPP:481-482] SLD-VERIFIED ---- */

void tMenuNFS4::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  this->tMenu::ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuNFS4::TransitionOff  [FEMENUEXTENDED.CPP:490-493] SLD-VERIFIED ---- */

void tMenuNFS4::TransitionOff()

{
  tMenuItem *ptVar1;
  int iVar2;
  int iVar3;
  short i;

  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    iVar3 = (int)this->fItemList[i];
    iVar2 = *(int *)(iVar3 + 0x18);
    (**(int (**)(...))(iVar2 + 0x3c))(iVar3 + *(short *)(iVar2 + 0x38));
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return;
}



/* ---- tMenuNFS4::TransitionOn  [FEMENUEXTENDED.CPP:497-500] SLD-VERIFIED ---- */

void tMenuNFS4::TransitionOn()

{
  tMenuItem *ptVar1;
  int iVar2;
  int iVar3;
  short i;

  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    iVar3 = (int)this->fItemList[i];
    iVar2 = *(int *)(iVar3 + 0x18);
    (**(int (**)(...))(iVar2 + 0x44))(iVar3 + *(short *)(iVar2 + 0x40));
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return;
}



/* ---- tMenuNFS4::TransitionIsFinished  [FEMENUEXTENDED.CPP:504-511] SLD-VERIFIED ---- */

void * tMenuNFS4::TransitionIsFinished()

{
  tMenuItem *ptVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  void *result;
  short i;

  result = (void *)0x1;
  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    iVar4 = (int)this->fItemList[i];
    iVar2 = *(int *)(iVar4 + 0x18);
    uVar3 = (**(int (**)(...))(iVar2 + 0x4c))(iVar4 + *(short *)(iVar2 + 0x48));
    result = (void *)(u_int)(((u_int)result & uVar3) != 0);
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return result;
}



/* ---- tMenuNFS4::UpdateTransition  [FEMENUEXTENDED.CPP:515-519] SLD-VERIFIED ---- */

void tMenuNFS4::UpdateTransition()

{
  tMenuItem *ptVar1;
  tMenuItem *pItem;
  __vtbl_ptr_type (*pa_Var2) [11];
  short i;

  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pItem = this->fItemList[i];
    pa_Var2 = pItem->_vf;
    (*(*pa_Var2)[10].pfn)
              ((char *)pItem + (int)(*pa_Var2)[10].delta,
               (int)i == this->fCurrentItem);
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return;
}



/* ---- tMenuNFS4::DrawItem  [FEMENUEXTENDED.CPP:523-528] SLD-VERIFIED ---- */

void tMenuNFS4::DrawItem(int item)

{
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  
  ptVar1 = this->fItemList[item];
  pa_Var2 = ptVar1->_vf;
  (*(*pa_Var2)[5].pfn)
            ((char *)ptVar1 + (int)(*pa_Var2)[5].delta,10,item * 0x12 + 0x2b,
             item == this->fCurrentItem);
  return;
}



/* ---- tMenuNFS4::Draw  [FEMENUEXTENDED.CPP:534-556] SLD-VERIFIED ---- */

void tMenuNFS4::Draw()

{
  short index;
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  int iVar3;
  int iVar4;
  short i;
  tDrawShapeExtended drawFlags;

  index = this->fTitle;
  if (-1 < index) {
    FETextRender_Title(index);
  }
  this->tMenu::Initialize();
  ptVar1 = this->fItemList[this->fCurrentItem];
  iVar4 = ptVar1->fButtonImage;
  iVar3 = ptVar1->fNumFrames;
  if ((-1 < iVar4) && (0 < iVar3)) {
    drawFlags.tint[0] = 0xcec844;
    DrawShapeExtended(iVar4 + ((int)(*(int *)&ticks[0] >> 4) % iVar3),0x410,0x10,
                      FEApp->fPlayer != 0 ? 0x79 : 0x10,0,0,&drawFlags);
  }
  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pa_Var2 = this->_vf;
    (*pa_Var2[1][0].pfn)
              ((int)this + pa_Var2[1][0].delta,(int)i);
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return;
}



/* ---- tMenuNFS4TwoPlayer::ctor  [FEMENUEXTENDED.CPP:566-571] SLD-VERIFIED ---- */

tMenuNFS4TwoPlayer::tMenuNFS4TwoPlayer(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
                 tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : tMenuNFS4(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_vf = (__vtbl_ptr_type (*)[11])tMenuNFS4TwoPlayer_vtable;
  this->fChildMenu = (tMenu *)0x0;
  ((tMenu *)this)->tMenuConstructor(firstItem,(&firstItem + 1));
  return;
}



/* ---- tMenuNFS4TwoPlayer::dtor  [FEMENUEXTENDED.CPP:575-575] SLD-VERIFIED ---- */

tMenuNFS4TwoPlayer::~tMenuNFS4TwoPlayer()

{
  *(void **)&(this->_vf) = (void *)tMenuNFS4TwoPlayer_vtable;
  return;
}



/* ---- tMenuNFS4TwoPlayer::DrawItem  [FEMENUEXTENDED.CPP:579-587] SLD-VERIFIED ---- */

void tMenuNFS4TwoPlayer::DrawItem(int item)

{
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  int y;
  
  y = 0x2b;
  if (FEApp->fPlayer == '\x01') {
    y = 0x94;
  }
  ptVar1 = this->fItemList[item];
  pa_Var2 = ptVar1->_vf;
  (*(*pa_Var2)[5].pfn)
            ((char *)ptVar1 + (int)(*pa_Var2)[5].delta,10,y + item * 0x12,
             item == this->fCurrentItem);
  return;
}



/* ---- tMenuNFS4Bottom::ctor  [FEMENUEXTENDED.CPP:607-611] SLD-VERIFIED ---- */

tMenuNFS4Bottom::tMenuNFS4Bottom(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
                 tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : tMenuNFS4(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_vf = (__vtbl_ptr_type (*)[11])tMenuNFS4Bottom_vtable;
  ((tMenu *)this)->tMenuConstructor(firstItem,(&firstItem + 1));
  return;
}



/* ---- tMenuNFS4Bottom::dtor  [FEMENUEXTENDED.CPP:615-615] SLD-VERIFIED ---- */

tMenuNFS4Bottom::~tMenuNFS4Bottom()

{
  *(void **)&(this->_vf) = (void *)tMenuNFS4Bottom_vtable;
  return;
}



/* ---- tMenuNFS4Bottom::Draw  [FEMENUEXTENDED.CPP:636-651] SLD-VERIFIED ---- */

void tMenuNFS4Bottom::Draw()

{
  tMenuItem *ptVar1;
  tMenuItem *pItem;
  __vtbl_ptr_type (*pa_Var2) [11];
  short i;
  RECT r;

  r.x = 0x39;
  r.y = 0xc6;
  r.w = 0x72;
  r.h = 0xb;
  MenuNFS4_SetHelpPos(r);
  i = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pItem = this->fItemList[i];
    pa_Var2 = pItem->_vf;
    (*(*pa_Var2)[5].pfn)
              ((char *)pItem + (int)(*pa_Var2)[5].delta,0,0,
               (int)i == this->fCurrentItem);
    i = i + 1;
    ptVar1 = this->fItemList[i];
  }
  return;
}



/* ---- tMenuBlank::ctor  [FEMENUEXTENDED.CPP:659-663] SLD-VERIFIED ---- */

tMenuBlank::tMenuBlank(u_int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu
              ,void (*OnButtonPress)(tMenuCommand&),short title)
  : tMenuNFS4(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  *(void **)&(this->_vf) = (void *)tMenuBlank_vtable;
  this->fNeverAnyEnabled = 1;
  this->VertHelp = 0;
  return;
}



/* ---- tMenuBlank::dtor  [FEMENUEXTENDED.CPP:667-667] SLD-VERIFIED ---- */

tMenuBlank::~tMenuBlank()

{
  *(void **)&(this->_vf) = (void *)tMenuBlank_vtable;
  return;
}



/* ---- tMenuBlank::Draw  [FEMENUEXTENDED.CPP:671-682] SLD-VERIFIED ---- */

void tMenuBlank::Draw()

{
  __vtbl_ptr_type (*pa_Var1) [11];
  
  if (this->fInMenuTransition != 0) {
    pa_Var1 = this->_vf;
    (*(*pa_Var1)[7].pfn)((int)this + (*pa_Var1)[7].delta);
    this->fTransitionVal =
         this->fTransitionVal + (short)*(signed char *)&this->fTransitionDirection;
  }
  return;
}



/* ---- tMenuBlank::ProcessInput  [FEMENUEXTENDED.CPP:688-700] SLD-VERIFIED ---- */

void tMenuBlank::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  if ((keyval == kInput_KeyType_Up) || (keyval == kInput_KeyType_Down)) {
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  else {
    this->fItemList[0] = (tMenuItem *)0x0;
    ((tMenu *)this)->ProcessInput(fromPlayer,keyval,command);
  }
  return;
}



/* ---- tMenuBlank::Initialize  [FEMENUEXTENDED.CPP:705-706] SLD-VERIFIED ---- */

void tMenuBlank::Initialize()

{
  return;
}



/* ---- tMenuBlank::DebounceKeys  [FEMENUEXTENDED.CPP:720-721] SLD-VERIFIED ---- */

long tMenuBlank::DebounceKeys()

{
  return -1;
}



/* ---- tMenuBlank::TransitionOff  [FEMENUEXTENDED.CPP:728-731] SLD-VERIFIED ---- */

void tMenuBlank::TransitionOff()

{
  this->fTransitionDirection = '\b';
  this->fInMenuTransition = 1;
  this->fTransitionVal = -0x70;
  return;
}



/* ---- tMenuBlank::TransitionOn  [FEMENUEXTENDED.CPP:735-738] SLD-VERIFIED ---- */

void tMenuBlank::TransitionOn()

{
  *(signed char *)&this->fTransitionDirection = -8;
  this->fInMenuTransition = 1;
  this->fTransitionVal = 0;
  return;
}



/* ---- tMenuBlank::TransitionIsFinished  [FEMENUEXTENDED.CPP:742-751] SLD-VERIFIED ---- */

void * tMenuBlank::TransitionIsFinished()

{
  u_int uVar1;
  
  if (0 < *(signed char *)&this->fTransitionDirection) {
    uVar1 = (u_int)(int)this->fTransitionVal >> 0x1f;
  }
  else {
    uVar1 = this->fTransitionVal < -0x6f ^ 1;
  }
  this->fInMenuTransition = uVar1;
  return (void *)(*(volatile BOOL *)&this->fInMenuTransition ^ 1);
}



/* ---- tMenuOptions::ctor  [FEMENUEXTENDED.CPP:762-767] SLD-VERIFIED ---- */

tMenuOptions::tMenuOptions(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,short player,
              tMenuItem *firstItem,...)
  : tMenuNFS4(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_vf = (__vtbl_ptr_type (*)[11])tMenuOptions_vtable;
  ((tMenu *)this)->tMenuConstructor(firstItem,(&firstItem + 1));
  this->fPlayer = player;
  return;
}



/* ---- tMenuOptions::dtor  [FEMENUEXTENDED.CPP:771-771] SLD-VERIFIED ---- */

tMenuOptions::~tMenuOptions()

{
  *(void **)&(this->_vf) = (void *)tMenuOptions_vtable;
  return;
}



/* ---- tMenuOptions::Draw  [FEMENUEXTENDED.CPP:781-852] SLD-VERIFIED ---- */

void tMenuOptions::Draw()

{
  short numItems;
  __vtbl_ptr_type (*pa_Var2) [11];
  u_long deltaTicks;
  long itemY;
  tMenuItem *ptVar5;
  short i;
  int iVar6;
  long y;
  long x;
  long h;
  long w;
  
  numItems = ((tMenu *)this)->GetNumberEnabledItems();
  w = 0x140;
  pa_Var2 = this->_vf;
  (*(*pa_Var2)[7].pfn)((int)this + (*pa_Var2)[7].delta);
  h = numItems * 0x12;
  if (this->fInMenuTransition != 0) {
    deltaTicks = ticks[0] - this->fMenuEnterTicks;
    if (0x20 < deltaTicks) {
      deltaTicks = 0x20;
      this->fInMenuTransition = 0;
      if ((signed char)this->fTransitionDirection < 0) {
        return;
      }
    }
    if (-1 < (signed char)this->fTransitionDirection) {
      w = w * deltaTicks >> 5;
      h = h * deltaTicks >> 5;
    }
    else {
      w = w - (w * deltaTicks >> 5);
      h = h - (h * deltaTicks >> 5);
    }
  }
  else if ((signed char)this->fTransitionDirection < 0) {
    return;
  }
  h = h + 0x12;
  x = (int)(screenwidth - w) >> 1;
  iVar6 = 0xf0 - h;
  y = iVar6 >> 1;
  if (this->fPlayer == 0) {
    y = y - (iVar6 >> 2);
  }
  else if (this->fPlayer == 1) {
    y = y + (iVar6 >> 2);
  }
  if (this->fInMenuTransition == 0) {
    if (-1 < this->fTitle) {
      FETextRender_MenuTextPositionedJustify(this->fTitle,(short)((u_int)((x + ((int)w >> 1)) * 0x10000) >> 0x10),
                 (short)((u_int)((y + 2) * 0x10000) >> 0x10),2,textState_Hilighted,
                 textType_PopUpTitle);
    }
    itemY = y + 0x12;
    i = 0;
    while( true ) {
      ptVar5 = this->fItemList[i];
      if (ptVar5 == (tMenuItem *)0x0) break;
      if (((ptVar5->fFlags ^ 1) & 1) != 0) {
        (*(*ptVar5->_vf)[5].pfn)
                  ((char *)ptVar5 + (int)(*ptVar5->_vf)[5].delta,x + 10,itemY,
                   (int)i == this->fCurrentItem);
        itemY = itemY + 0x12;
      }
      i = i + 1;
    }
  }
  PSXDrawSquare(0,x,y,w,0xc);
  PSXDrawTransSquare(0,x,y + h,w,-2,1);
  PSXDrawTransSquare(0,x,y + 0xc,4,h - 0xe,1);
  PSXDrawTransSquare(0,x + w,y + 0xc,-4,h - 0xe,1);
  PSXDrawTransSquare(0,x,y,w,h,1);
  FeDraw_SetABRMode(0);
  return;
}



/* ---- tMenuOptions::TransitionOff  [FEMENUEXTENDED.CPP:855-859] SLD-VERIFIED ---- */

void tMenuOptions::TransitionOff()

{
  int iVar1;
  
  *(signed char *)&this->fTransitionDirection = -1;
  iVar1 = ticks[0];
  this->fInMenuTransition = 1;
  this->fMenuEnterTicks = iVar1;
  AudioCmn_PlayFESFX(0x12);
  return;
}



/* ---- tMenuOptions::TransitionOn  [FEMENUEXTENDED.CPP:863-874] SLD-VERIFIED ---- */

void tMenuOptions::TransitionOn()

{
  int iVar1;
  tMenuItem *ptVar2;
  tMenuOptions *ptVar3;
  
  ptVar3 = this;
TransitionOn_nextItem:
  ptVar2 = ptVar3->fItemList[0];
  if (ptVar2 == (tMenuItem *)0x0) {
    goto TransitionOn_itemsDone;
  }
  if (((ptVar2->fFlags ^ 1) & 1) != 0) {
    (*(*ptVar2->_vf)[8].pfn)((char *)ptVar2 + (int)(*ptVar2->_vf)[8].delta);
  }
  ptVar3 = (tMenuOptions *)&ptVar3->fTitle;
  goto TransitionOn_nextItem;
TransitionOn_itemsDone:
  this->fTransitionDirection = '\x01';
  iVar1 = ticks[0];
  this->fInMenuTransition = 1;
  this->fMenuEnterTicks = iVar1;
  AudioCmn_PlayFESFX(0xf);
  return;
}



/* ---- tMenuOptions::TransitionIsFinished  [FEMENUEXTENDED.CPP:878-880] SLD-VERIFIED ---- */

void * tMenuOptions::TransitionIsFinished()

{
  u_int uVar1;
  
  uVar1 = (u_int)(ticks[0] - this->fMenuEnterTicks < 0x20);
  this->fInMenuTransition = uVar1;
  return (void *)(uVar1 ^ 1);
}



/* ---- tMenuOptions::ProcessInput  [FEMENUEXTENDED.CPP:884-889] SLD-VERIFIED ---- */

void tMenuOptions::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  if (keyval == kInput_KeyType_Square) {
    keyval = kInput_KeyType_Triangle;
  }
  this->tMenuNFS4::ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuOptions::IsSubMenu  [FEMENUEXTENDED.CPP:893-894] SLD-VERIFIED ---- */

void * tMenuOptions::IsSubMenu()

{
  return (void *)0x1;
}



/* ---- tMenuBlank::UpdateTransition  [FEMENUEXTENDED.CPP:?] SLD-FLAG:NO_SLD ---- */

void tMenuBlank::UpdateTransition()

{
  return;
}



/* ---- tMenuItemOptionsTwoItemChoice::dtor  [FEMENUEXTENDED.CPP:?] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___24tMenuItemLeftRightChoice the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___24tMenuItemLeftRightChoice(void *);
extern "C" void ___29tMenuItemOptionsTwoItemChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }



/* ---- tMenuItemOptionsLeftRightChoice::dtor  [FEMENUEXTENDED.CPP:?] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___24tMenuItemLeftRightChoice the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___24tMenuItemLeftRightChoice(void *);
extern "C" void ___31tMenuItemOptionsLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }



/* ---- tMenuItemGoToMenuNFS4Button::Draw  [FEMENUEXTENDED.CPP:?] SLD-FLAG:NO_SLD ---- */

void tMenuItemGoToMenuNFS4Button::Draw(bool selected)

{
  return;
}

/* end of femenuextended.cpp */
