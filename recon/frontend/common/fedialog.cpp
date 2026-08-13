/* frontend/common/fedialog.cpp -- RECONSTRUCTED (NFS4 menu/item widget hierarchy; C++ TU)
 *   56 fns across 9 classes: tMenuNFS4(+TwoPlayer/Bottom) menu containers, tMenuBlank, tMenuOptions,
 *   tMenuItemGoToMenuNFS4Button, tMenuItemNFS4LeftRightChoice, tMenuItemOptions{LeftRightChoice,
 *   TwoItemChoice}, + free MenuNFS4_DrawTextBox. Member defs; base ctors via init-lists; manual _vf.
 */
#include "fedialog.h"

/* ---- FEDialog.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
tDialogBase  *DialogVisibilityList[8];   /* @0x80052b38  (bss(zero)) */


/* ---- tDialogBase::ShouldTimeOut  [FEDIALOG.CPP:73-76] SLD-VERIFIED ---- */

short tDialogBase::ShouldTimeOut()

{
  /* MATCH 2026-08-03 (15->PASS): keep the expired case as the inner positive
     return and the zero case as the tail.  The ticks array view exposes its
     address pseudo, so GCC fills the outer branch delay with %hi(ticks)
     instead of preloading the zero result. */
  if (0 < this->timeOutTicks) {
    if (this->timeOutTicks <= ticks[0] - this->startTicks) {
      return 1;
    }
  }
  return 0;
}



/* ---- tDialogBase::InitializeClass  [FEDIALOG.CPP:83-84] SLD-VERIFIED ---- */

void tDialogBase::InitializeClass()

{
  this->HideAllDialogs();
  return;
}



/* ---- tDialogBase::DrawAllDialogs  [FEDIALOG.CPP:90-101] SLD-VERIFIED ---- */

/* MATCH 2026-08-03: SLD's sole local is short i.  Expressing the old-ABI
   virtual-call adjustment directly as object + delta is significant here:
   routing it through fPermShapes.fFilename - 0x14 exposed the call-argument
   target to GCC's expand_binop and reversed the otherwise-commutative addu. */

void tDialogBase::DrawAllDialogs()

{
  short sVar1;
  __vtbl_ptr_type (*pa_Var2) [10];
  tDialogBase **pptVar5;
  short i;
  
  i = 0;
  while (DialogVisibilityList[i] != (tDialogBase *)0x0) {
    if (7 < i) break;
    pptVar5 = DialogVisibilityList + i;
    sVar1 = (*pptVar5)->ShouldTimeOut();
    if ((sVar1 != 0) && ((*pptVar5)->Hide(), *pptVar5 == (tDialogBase *)0x0)) {
      return;
    }
    pa_Var2 = ((*pptVar5))->_vf;
    (*pa_Var2[1][1].pfn)((char *)*pptVar5 + pa_Var2[1][1].delta);
    i = i + 1;
  }
  return;
}



/* ---- tDialogBase::HideAllDialogs  [FEDIALOG.CPP:107-111] SLD-VERIFIED ---- */

void tDialogBase::HideAllDialogs()

{
  short i;
  
  for (i = 0; i < 8; i++) {
    DialogVisibilityList[i] = (tDialogBase *)0x0;
  }
  return;
}



/* ---- tDialogBase::GetTopMostDialog  [FEDIALOG.CPP:117-120] SLD-VERIFIED ---- */

int tDialogBase::GetTopMostDialog()

{
  return (int)DialogVisibilityList[0];
}



/* ---- tDialogBase::Display  [FEDIALOG.CPP:126-154] SLD-VERIFIED ---- */

void tDialogBase::Display()

{
  short i;
  
  i = 7;
  if (this->currentlyOn == 0) {
    this->currentlyOn = 1;
    this->fFullyOpen = 0;
    this->ReturnValue = this->fDefault;
    do {
      DialogVisibilityList[i] = DialogVisibilityList[i - 1];
      i = i - 1;
    } while (0 < i);
    DialogVisibilityList[0] = this;
    this->ShouldTimeOut();
    (DialogVisibilityList[0])->ShouldTimeOut();
    this->startTicks = ticks[0];
    AudioCmn_PlayFESFX(0xf);
    this->fFullyOpen = 0;
    this->fFadeText = 0x80;
  }
  return;
}



/* ---- tDialogBase::Hide  [FEDIALOG.CPP:159-181] SLD-VERIFIED ---- */

void tDialogBase::Hide()

{
  tDialogBase **dst;
  short i;

  if (this->currentlyOn != 0) {
    this->currentlyOn = 0;
    for (i = 0; i < 8; i++) {
      dst = DialogVisibilityList + i;
      if (*dst == this) {
        this->currentlyOn = 0;
        *dst = (tDialogBase *)0x0;
        blockmove(DialogVisibilityList + i + 1,dst,(7 - i) * 4);
        DialogVisibilityList[7] = (tDialogBase *)0x0;
        AudioCmn_PlayFESFX(0x12);
      }
    }
  }
  return;
}



/* ---- tDialogBase::Draw  [FEDIALOG.CPP:200-210] SLD-VERIFIED ---- */

void tDialogBase::Draw()

{
  PSXDrawTransSquare(0,(int)this->left,(int)this->top,4,(int)this->height,4);
  PSXDrawTransSquare(0,(this->left + this->width) - 4,(int)this->top,4,(int)this->height,4);
  PSXDrawTransSquare(0,this->left + 4,(int)this->top,this->width + -8,2,4);
  PSXDrawTransSquare(0,this->left + 4,(this->top + this->height) - 2,this->width + -8,2,4);
  PSXDrawTransSquare(0,this->left + 4,this->top + 2,this->width + -8,this->height + -4,2);
  FeDraw_SetABRMode(0);
  return;
}



/* ---- tDialogBase::ProcessInput  [FEDIALOG.CPP:217-245] SLD-VERIFIED ---- */

void tDialogBase::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  
  if (keyval != kInput_KeyType_AlreadyProcessed) {
    this->Hide();
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  return;
}



/* ---- tDialogHelp::AddItem  [FEDIALOG.CPP:260-265] SLD-VERIFIED ---- */

void tDialogHelp::AddItem(short textID,short controllerID)

{
  char *pcVar1;
  
  if (this->numItems < 7) {
    pcVar1 = TextSys_Word((int)textID);
    this->text[this->numItems] = pcVar1;
    this->cont[this->numItems] = (int)controllerID;
    this->numItems = this->numItems + 1;
  }
  return;
}



/* ---- tDialogHelp::CalculateDimensions  [FEDIALOG.CPP:286-451] SLD-VERIFIED ---- */

/* MATCH: the oracle initializes the WHOLE 18-byte helpArray[0] with a single
   lwl/lwr-block copy from a named .rodata template at 0x80010244 (autoGenerate=1,
   all 4 items {text=0,button=0} -- verified byte-exact against rom/nfs4-f.exe
   @foff 0xa44: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00). The prior
   recon hand-unrolled this as a masked-word alignment copy (tp1/uVar10/puVar8) --
   that shape is a Ghidra artifact of the byte-address computation, not a real
   source construct; a plain aggregate-initialized local template + struct-assign
   reproduces the exact lwl/lwr/swl/swr sequence. */
static const tHelpData kHelpArrayTemplate /* @0x80010244 */ =
     { 1, { {0,0}, {0,0}, {0,0}, {0,0} } };

void tDialogHelp::CalculateDimensions()

{
  int newWidth;
  tMenu *menu;
  short i;
  tPlayer player;
  tHelpData helpArray [1];

  helpArray[0] = kHelpArrayTemplate;
  FETextRender_SetFont(0);
  this->numItems = 0;
  this->AddItem(0x59,0);
  player = (tPlayer)0;
  if (this->specificPlayer != -1) {
    player = (tPlayer)this->specificPlayer;
  }
  if (helpArray[this->variant].autoGenerate != '\0') {
    bool showLeftRight;
    bool showCross;
    tMenu *scanMenu;

    showLeftRight = false;
    showCross = false;
    menu = FEApp->fCurrentMenu[player];
    scanMenu = menu;
    i = 0;
    while (true) {
      if (scanMenu->fItemList[i] == (tMenuItem *)0x0) {
        break;
      }
      if (((scanMenu->fItemList[i]->fFlags ^ 1) & 1) != 0) {
        if ((scanMenu->fItemList[i]->fFlags & 0x400) != 0) {
          showLeftRight = true;
        }
        else {
          showCross = true;
        }
      }
      i = i + 1;
    }
    if (1 < menu->GetNumberEnabledItems()) {
      this->AddItem(0x52,0x50);
    }
    if (showLeftRight) {
      this->AddItem(0x53,0xa0);
    }
    if (showCross) {
      bool hasSpecialFlags;

      hasSpecialFlags = false;
      if ((menu->fFlags & 0x10000) == 0) {
        if ((menu->fFlags & 0x20000) != 0) {
          hasSpecialFlags = true;
        }
      }
      else {
        hasSpecialFlags = true;
      }
      if (hasSpecialFlags) {
        this->AddItem(0x56,0x4000);
      }
      else {
        this->AddItem(0x55,0x4000);
      }
    }
    if (0 < FEApp->backDepth[player]) {
      this->AddItem(0x54,0x1000);
    }
    if (menu->fOptionsMenu != (tMenu *)0x0) {
      this->AddItem(0x57,-0x8000);
    }
    if ((menu->fFlags & 0x800) != 0) {
      this->AddItem(0x58,8);
    }
    else {
      bool canContinue;

      canContinue = false;
      if (((menu->fNextMenu != (tMenu *)0x0) || ((menu->fFlags & 0x400) != 0)) ||
          (menu->fOnButtonPress != (void *)0x0)) {
        canContinue = true;
      }
      if ((!canContinue) && ((menu->fFlags & 4) == 0)) {
        goto CalcDim_helpArrFetch;
      }
      this->AddItem(0x56,8);
    }
  }
CalcDim_helpArrFetch:
  i = 0;
  while (helpArray[this->variant].items[i].text != 0) {
    this->AddItem(helpArray[this->variant].items[i].text,
                  helpArray[this->variant].items[i].button);
    i = i + 1;
  }
  this->helpcontrollers = 0;
  PAD_update();
  {
    PAD_COMMON *pad = &gPadinfo.buf[0];
    if (pad->nopad == '\0') {
      short controllerFlags;

      controllerFlags = this->helpcontrollers | 1;
      if (pad->ID == '#') {
        controllerFlags = this->helpcontrollers | 2;
      }
      this->helpcontrollers = controllerFlags;
    }
  }
  {
    PAD_COMMON *pad = &gPadinfo.buf[4];
    if (pad->nopad == '\0') {
      short controllerFlags;

      controllerFlags = this->helpcontrollers | 1;
      if (pad->ID == '#') {
        controllerFlags = this->helpcontrollers | 2;
      }
      this->helpcontrollers = controllerFlags;
    }
  }
  i = 0;
  this->width = 0;
  if (0 < this->numItems) {
    do {
      newWidth = textpixels(this->text[i]);
      if (this->width < newWidth) {
        this->width = (short)newWidth;
      }
      i = i + 1;
    } while (i < this->numItems);
  }
  if (this->helpcontrollers == 3) {
    this->lefttext = 0x46;
    this->width = this->width + 0x46;
  }
  else {
    this->lefttext = 0x28;
    this->width = this->width + 0x28;
  }
  if (this->numItems < 2) {
    this->height = 0;
  }
  else {
    this->height = this->numItems * 0xf;
  }
  this->left = (short)((screenwidth - this->width) / 2);
  this->top = (short)((0xf0 - this->height) / 2);
  if ((int)this->width < gHelpShapes[3].width + 0x14) {
    this->width = gHelpShapes[3].width + 0x14;
  }
  this->width = this->width + 0x14;
  this->height = this->height + 10;
  if ((u_int)(ticks[0] - this->startTicks) < 0x32) {
    this->width =
         gHelpShapes[0x2a].width * 2 +
         (short)((u_int)(((int)this->width -
                         (((int)gHelpShapes[0x2a].width << 0x11) >> 0x10)) *
                        (ticks[0] - this->startTicks)) / 0x32);
    this->height =
         gHelpShapes[0x2a].height * 2 +
         (short)((u_int)(((int)this->height -
                         (((int)gHelpShapes[0x2a].height << 0x11) >> 0x10)) *
                        (ticks[0] - this->startTicks)) / 0x32);
  }
  this->top = 0x14;
  this->left = 0x1f9 - this->width;
  return;
}



/* ---- tDialogHelp::Draw  [FEDIALOG.CPP:459-546] SLD-VERIFIED ---- */
/* MATCH: PASS. The 4th arg is written `(i-1)*0xf +
   this->top + 0x13` (mul-first reassociation) so the multiply lands in the
   retail destination register.  More importantly, the pad-65, pad-35, and
   special-control arms retain their separate natural DrawPSXButton calls;
   gcc cross-jump-merges their common tails only after each arm computes
   `(i-1)`, reproducing both `j` delay-slot fills and the retail block order.
   A single explicit goto-shared call instead hoists the prefix and costs ten
   diffs.  `int buttonY` in the two-button arm remains load-bearing.  The
   two-stage tick materialization preserves retail's load/copy pair.  Keeping
   the tick live through the letter-count division, and initializing the loop
   index and stack-buffer cursor first, reproduces its allocation and schedule. */

void tDialogHelp::Draw()

{
  __vtbl_ptr_type (*pa_Var3) [10];
  short i;
  short j;
  char buffer [80];
  char *bufferPtr;
  short y;
  long ticks;
  int numLetters;
  long firstTick;
  
  pa_Var3 = this->_vf;
  (*pa_Var3[1][0].pfn)((char *)this + pa_Var3[1][0].delta);
  firstTick = this->startTicks;
  {
    long loadedTicks = ::ticks[0];
    ticks = loadedTicks;
    __asm__("" : "+r"(loadedTicks));
  }
  if (firstTick + 0x32 <= ticks) {
    i = 0;
    bufferPtr = buffer;
    numLetters = (ticks - firstTick - 0x32) / 3;
    __asm__("" : : "r"(ticks));
    for (; i < this->numItems; i++) {
      if (i == 0) {
        y = this->top + 4;
      }
      else {
        y = this->top + (i - 1) * 0xf + 0x13;
      }
      if (i > 0) {
        int control = this->cont[i];
        if (this->helpcontrollers == 2) goto DialogHelpDraw_pad35;
        if (this->helpcontrollers < 3) goto DialogHelpDraw_pad65;
        if (this->helpcontrollers == 3) goto DialogHelpDraw_specialButtons;
DialogHelpDraw_pad65:
        FeTools_DrawPSXButton(0x41,(u_short)control,this->left + 0x14,
                   (i - 1) * 0xf + this->top + 0x13);
        goto DialogHelpDraw_buttonsDone;
DialogHelpDraw_pad35:
        FeTools_DrawPSXButton(0x23,(u_short)control,this->left + 0x14,
                   (i - 1) * 0xf + this->top + 0x13);
        goto DialogHelpDraw_buttonsDone;
DialogHelpDraw_specialButtons:
        if ((control == 0xa0) || (control == 0x50) || (control == 0x40))
          goto DialogHelpDraw_pad65Special;
        {
          int buttonY = (i - 1) * 0xf + 0xf;
          FeTools_DrawPSXButton(0x41,(u_short)control,this->left + 0x14,
                     this->top + buttonY + 4);
          FeTools_DrawPSXButton(0x23,(u_short)control,this->left + 0x28,
                     this->top + buttonY + 4);
          goto DialogHelpDraw_buttonsDone;
        }
DialogHelpDraw_pad65Special:
        FeTools_DrawPSXButton(0x41,(u_short)control,this->left + 0x14,
                   (i - 1) * 0xf + this->top + 0x13);
DialogHelpDraw_buttonsDone:;
      }
      if (numLetters < (int)strlen(this->text[i])) {
        j = 0;
        if (numLetters > 0) {
          do {
            bufferPtr[j] = this->text[i][j];
            j = j + 1;
          } while (j < numLetters);
        }
        bufferPtr[numLetters] = '\0';
        FETextRender_FullText(bufferPtr,this->left + this->lefttext,y,
                             i == 0 ? textType_PopUpTitle : textType_PopUpText,
                             textState_Selected,0);
      }
      else {
        FETextRender_FullText(this->text[i],this->left + this->lefttext,y,
                             i == 0 ? textType_PopUpTitle : textType_PopUpText,
                             textState_Selected,0);
      }
    }
  }
  tDialogBase::Draw();
  return;
}



/* ---- tDialogMessageString::CalculateDimensions  [FEDIALOG.CPP:551-600] SLD-VERIFIED ---- */
/* MATCH: 115->94 (W56-A9) + CORRECTNESS FIX. Was reading an UNINITIALIZED local
   `int ticks;` (shadowed the global `extern int ticks[]`); replaced with the
   global element `ticks[0]` at each use. SYM 8c: fsize=24, mask=$80010000
   (only s0+ra), `ticks`=REG $08=t0 (caller-saved). The cached-local form forced
   ticks into callee-saved s1 (+8 frame -> fsize 32); `ticks[0]` inline lets gcc
   reload it (caller-saved) -> frame now matches (-24). REMAINING 94, two floors:
   (a) ticks lands in v0 (reloaded late) vs the SYM's t0 (loaded early) -> a
       register-coloring cascade through the whole body (allocno reg-choice, the
       s4.6 de-prioritized class; not reqdelta-priceable).
   (b) A2-OWNED TYPE: `gHelpShapes[].width`/`.height` (tTexture_ShapeInfo in
       nfs4_types.h) read `lhu`+sll/sra sign-extend (3 insns) where the oracle
       uses `lh` (1 insn) -> the field should be signed `short`. A `*(short*)&`
       cast at the site is codegen-NEUTRAL (gcc rematerializes the field by its
       declared type); the fix must be in nfs4_types.h (A2). REPORTED. */

void tDialogMessageString::CalculateDimensions()

{
  short sVar1;
  short w;
  int fade_or_h;
  int iVar2;
  int tick_age;
  short h;
  
  fade_or_h = 0x80 - (((ticks[0] + -0x32) - this->startTicks) * 0x80) / 100;
  this->fFadeText = fade_or_h;
  if (0x80 < fade_or_h) {
    fade_or_h = 0x80;
  }
  if (fade_or_h < 0) {
    fade_or_h = 0;
  }
  this->fFadeText = fade_or_h;
  if (fade_or_h != 0) {
    this->fFullyOpen = 0;
  }
  sVar1 = this->MaxW;
  this->width = sVar1;
  if (this->MaxH == 0) {
    iVar2 = FETextRender_WordWrapHeight(sVar1 + -0x28,this->string);
    this->height = (short)iVar2;
    if ((short)iVar2 == 8) {
      this->Centerit = 1;
    }
    else {
      this->Centerit = 0;
    }
    w = this->height + 0x10;
  }
  else {
    w = this->MaxH;
    this->Centerit = 0;
  }
  this->height = w;
  iVar2 = ticks[0] - this->startTicks;
  if (iVar2 < 0x32) {
    sVar1 = gHelpShapes[0x2a].width;
    h = gHelpShapes[0x2a].height;
    tick_age = ticks[0] - this->startTicks;
    this->fFullyOpen = 0;
    this->width =
         sVar1 * 2 +
         (short)((((int)this->width - (((int)sVar1 << 0x11) >> 0x10)) * iVar2) / 0x32)
    ;
    this->height =
         h * 2 + (short)((((int)this->height - (((int)h << 0x11) >> 0x10)) * tick_age)
                        / 0x32);
  }
  else {
    this->fFullyOpen = 1;
  }
  this->left =
       this->OffsetX + (short)((screenwidth - this->width) / 2);
  this->top =
       this->OffsetY + (short)((0xf0 - this->height) / 2);
  return;
}



/* ---- tDialogMessageString::Draw  [FEDIALOG.CPP:607-651] SLD-VERIFIED ---- */

void tDialogMessageString::Draw()

{
  __vtbl_ptr_type (*pa_Var1) [10];
  int col;
  int idx;
  RECT r;
  
  (*(this->_vf)[1][0].pfn)((int)this + (this->_vf)[1][0].delta);
  if (ticks[0] < this->startTicks + 0x32) {
    this->fFullyOpen = 0;
  }
  else {
    if (this->fFadeText != 0) {
      this->fFullyOpen = 0;
    }
    col = CalcFadeVal(kRGBVals[(u_char)textDefinitions[8][4]],(int)this->fFadeText);
    r.x = this->left + 0x11;
    r.y = this->top + 10;
    r.w = this->width + -0x14;
    {
      int rh = (u_short)this->reservedheight + 8;
      r.h = this->height - rh;
    }
    FETextRender_SetABR(1,true);
    if (this->Centerit != 0) {
      int halfw = (int)((u_int)(u_short)this->width << 0x10) >> 0x11;

      FETextRender_FullTextRGB(this->string,
                 (short)(((u_int)(u_short)this->left + halfw) * 0x10000
                        >> 0x10),this->top + 8,col,'\0',2);
    }
    else {
      FETextRender_WordWrapTextRGB(this->string,r,col);
    }
    FETextRender_SetABR(0,false);
  }
  this->Draw();
  return;
}



/* ---- tDialogBackUpOnly::ProcessInput  [FEDIALOG.CPP:654-670] SLD-VERIFIED ---- */

void tDialogBackUpOnly::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* SYM: FCN VOID, no locals (the "iVar1" return funnel was a Ghidra fiction --
     the oracle never sets $v0).  SLD: 655 guard / 658 key test / 660 the
     AlreadyProcessed store / 664 Hide() -- so Hide is the ELSE arm (source
     order puts the store BEFORE it), which is what lays it out-of-line. */
  if ((this->specificPlayer == kPlayerBoth) || (fromPlayer == (tPlayer)this->specificPlayer)) {
    if (keyval != kInput_KeyType_Triangle) {
      if (keyval != kInput_KeyType_Circle) {
        keyval = kInput_KeyType_AlreadyProcessed;
      }
    }
    else {
      ((tDialogBase *)this)->Hide();
    }
  }
}



/* ---- tDialogInteractive::Run  [FEDIALOG.CPP:684-742] SLD-VERIFIED ---- */
/* MATCH (2026-08-13, 110 -> 39 -> 27 -> 18 -> 4 -> PASS, 123/123): SYM lexical
   scopes are codegen-significant here.  Declaring debounce and i inside the
   outer loop restores retail's entry-tested outer CFG, s7 stack-base hoist,
   and complete s0..s7 save mask.  The real scoped bool for the Circle path
   reduces 39 -> 27; materializing tDialogBase *helpPopup before testing its
   inherited currentlyOn member reduces 18 -> 4 and matches the SYM's scoped
   implicit-this block.  Finally, the virtual this-adjust source is naturally
   `(char *)this + delta`, producing retail's two addu a0,s3,a0 instructions.
   FALSIFIED: explicit goto entry loops 129 (collapsed allocator); identity
   fence after i=0 21 (blocked strength reduction); void barrier 22; explicit
   key/menu-offset induction locals 40.  No fence or volatile remains. */

short tDialogInteractive::Run()

{
  bool bVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  int iVar5;
  int iVar6;
  tInputKeyType keyVal [2];
  tMenuCommand command;
  
  this->fCurrentlyRunning = 1;
  ((tDialogBase *)this)->Display();
  pa_Var3 = this->_vf;
  (*pa_Var3[1][0].pfn)
            ((char *)this + pa_Var3[1][0].delta);
  this->ReadyToReturnValue = 0;
  while (this->ReadyToReturnValue == 0) {
    u_long debounce = -1;
    int i;

    command.type = kMenu_Command_None;
    i = 0;
    while (i < 2) {
      keyVal[i] = FEInput_GetKeyFromPlayer((tPlayer)i,debounce);
      if (keyVal[i] == kInput_KeyType_NoKey) {
        keyVal[i] = kInput_KeyType_AlreadyProcessed;
      }
      if (keyVal[i] == kInput_KeyType_Circle) {
        bVar2 = false;
        if ((FEApp->helpPopup).currentlyOn == 0) {
          bVar2 = FEApp->fCurrentMenu[i] != (tInsideBoxMenu *)0x0;
        }
        if (bVar2) {
          iVar6 = (int)FEApp->fCurrentMenu[i];
          iVar5 = *(int *)(iVar6 + 0x68);
          (**(int (**)(...))(iVar5 + 0x1c))
              (iVar6 + *(short *)(iVar5 + 0x18),(tPlayer)i,&keyVal[i],&command);
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }
      if (keyVal[i] != kInput_KeyType_AlreadyProcessed) {
        tDialogBase *helpPopup = (tDialogBase *)&FEApp->helpPopup;
        if (helpPopup->currentlyOn != 0) {
          helpPopup->Hide();
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }
      if (keyVal[i] != kInput_KeyType_NoKey) {
        pa_Var3 = this->_vf;
        (*(*pa_Var3)[9].pfn)
                  ((char *)this + (*pa_Var3)[9].delta,
                   (tPlayer)i,&keyVal[i],&command);
      }
      i++;
    }
    FEApp->Redraw();
  }
  AudioCmn_PlayFESFX(0);
  ((tDialogBase *)this)->Hide();
  FEApp->Redraw();
  this->fCurrentlyRunning = 0;
  return this->ReturnValue;
}



/* ---- tDialogYesNo::CalculateDimensions  [FEDIALOG.CPP:748-759] SLD-VERIFIED ---- */

void tDialogYesNo::CalculateDimensions()

{
  
  int iVar2;

  /* MATCH (W55-A15, 20->PASS): retail mutates the FIELD in place in BOTH arms
     (`lhu v0,108(s0); addiu v0,v0,15; sh v0,108(s0)`), so the height read's own
     register is the sum's destination and post-reload cross_jump merges the two
     arms' identical stores into the oracle's single `sh`.  Routing the result
     through a `short sVar1` funnel + one trailing store gives the sum a FRESH
     destination and rotates the whole magic-divide block ($v0/$v1/$a0). */
  ((tDialogMessageString *)this)->CalculateDimensions();
  if (this->MaxH == 0) {
    iVar2 = ticks[0] - this->startTicks;
    if (iVar2 < 0x32) {
      this->height = this->height + (short)((iVar2 * 0xf) / 0x32);
    }
    else {
      this->height = this->height + 0xf;
    }
    this->reservedheight = 0xf;
    this->top =
         this->OffsetY +
         (short)((0xf0 - this->height) / 2);
  }
  return;
}



/* ---- tDialogYesNo::ctor  [FEDIALOG.CPP:765-767] SLD-VERIFIED ---- */

tDialogYesNo::tDialogYesNo()
  : tDialogInteractive()
{
  
  *(void **)&(this->_vf) = (void *)tDialogBase_vtable;
  this->MaxW = 0x120;
  this->specificPlayer = -1;
  *(void **)&(this->_vf) = (void *)tDialogMessageString_vtable;
  this->fFadeText = 0x80;
  *(void **)&(this->_vf) = (void *)tDialogInteractive_vtable;
  this->currentlyOn = 0;
  this->reservedheight = 0;
  this->MaxH = 0;
  this->OffsetY = 0;
  this->OffsetX = 0;
  this->height = 0;
  this->width = 0;
  this->top = 0;
  this->left = 0;
  this->fDefault = 0;
  this->timeOutTicks = 0;
  this->Centerit = 0;
  this->fFullyOpen = 0;
  this->timeOutTicks = 0;
  /* MATCH: oracle emits 3 separate `sw zero,0x78` (timeOutTicks); gcc folds the 2nd of two
   * adjacent identical plain stores. The volatile-cast keeps the redundant store (codegen-
   * neutral: same `sw zero,0x78`). Do NOT "simplify" away or the 3rd store disappears (45 vs 46). */
  *(volatile long *)&this->timeOutTicks = 0;
  this->fCurrentlyRunning = 0;
  *(void **)&(this->_vf) = (void *)tDialogYesNo_vtable;
  this->ReturnValue = 0;
  this->ReadyToReturnValue = 0;
  return;
}



/* ---- tDialogYesNo::Draw  [FEDIALOG.CPP:773-815] SLD-VERIFIED ---- */
/* MATCH: 78 -> 16 -> 12 -> 6 -> 0 (W57-A5/W59/W66), exact 98/98.
   THE LEVER: the two Ghidra locals `sVar1 = this->top; sVar2 = this->height;` were
   fabricated -- they held two field values in TWO callee-saved regs across the
   FETextRender_SetABR call (forcing an extra saved reg, `fp`, + its save/restore, and
   `lhu`+late-extend instead of `lh`).  Reading the fields INLINE in the `y` expression
   makes gcc load-and-add them in one reg pair exactly like retail.  Also moved
   `ptVar8 = this;` after the `x` init (preheader statement order).
   W59 source-authority corrections: retail's SLD/IDA sequence is a natural
   `y = top + height; y -= 11;` followed by a `(short)y` call argument, not the
   Ghidra-derived multiply-by-65536/shift-back expression (16->12).  Explicit
   `rgbBase`/`textBase` loop invariants make LICM emit both address materializations
   before `ptVar8=this`, reuse v0 for their %hi scratch, and seal the whole six-diff
   preheader cluster (12->6).
   W66: the SLD transitions at 0x80019c2c/38/3c/44 recover the last source
   shape: `top + height - 11` was one expression before SetABR.  Keeping the
   subtraction in that expression lets scheduling place the sum before SetABR,
   the subtraction in its delay slot, and the short cast in TextSys_Word's delay
   slot, sealing the final six position-only residuals. */

void tDialogYesNo::Draw()

{
  short sVar1;
  short sVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  char *sMenuText;
  int col;
  int idx;
  int y;
  int i;
  int x;
  tDialogYesNo *ptVar8;
  int *rgbBase;
  char *textBase;
  
  pa_Var3 = this->_vf;
  (*pa_Var3[1][0].pfn)((int)this + pa_Var3[1][0].delta);
  if (this->fFadeText != 0) {
    this->fFullyOpen = 0;
  }
  i = 0;
  if (0x31 < ticks[0] - this->startTicks) {
    x = (int)this->left +
            ((int)((u_int)(u_short)this->width
                  << 0x10) >> 0x12);
    rgbBase = kRGBVals;
    textBase = (char *)textDefinitions;
    ptVar8 = this;
    while( true ) {
      if (2 <= i) break;
      idx = 2;
      if (i == this->ReturnValue) {
        idx = 1;
      }
      col = CalcFadeVal(rgbBase[(u_char)textBase[idx + 0x33]],(int)this->fFadeText);
      y = (int)this->top + (int)this->height - 0xb;
      FETextRender_SetABR(1,true);
      sMenuText = TextSys_Word(ptVar8->yesnowords[0]);
      FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,col,'\0',2);
      FETextRender_SetABR(0,false);
      ptVar8 = (tDialogYesNo *)
               &(ptVar8)->fPermShapes.fFile;
      x = x + ((int)((u_int)(u_short)this->width << 0x10) >> 0x11);
      i = i + 1;
    }
  }
  ((tDialogMessageString *)this)->Draw();
  return;
}



/* ---- tDialogYesNo::ProcessInput  [FEDIALOG.CPP:823-853] SLD-VERIFIED ---- */

void tDialogYesNo::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command)

{
  /* SLD: 824 player guard / 827 fFullyOpen guard (own line, own block) /
     831 the dispatch (a real switch -- gcc balance_case_nodes builds the
     ==0x800 root + <0x801 bound test tree over 4 case labels) /
     834-836, 838-840, 844-846 the three arms in ascending source order. */
  if ((this->specificPlayer == kPlayerBoth) || (fromPlayer == (tPlayer)this->specificPlayer)) {
    if ((this->fFullyOpen ^ 1) == 0) {   /* xori;bnez -- same idiom as fememcard.cpp */
      switch (keyVal) {
      case kInput_KeyType_Left:
        AudioCmn_PlayFESFX(5);
        this->ReturnValue = 1;
        break;
      case kInput_KeyType_Right:
        AudioCmn_PlayFESFX(6);
        this->ReturnValue = 0;
        break;
      case kInput_KeyType_Cross:
      case kInput_KeyType_Start:
        AudioCmn_PlayFESFX(0);
        this->ReadyToReturnValue = 1;
        ((tDialogBase *)this)->Hide();
        break;
      }
    }
  }
}



/* ---- tDialogYesNoMem::ProcessInput  [FEDIALOG.CPP:859-901] SLD-VERIFIED ---- */

void tDialogYesNoMem::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command
               )

{
  bool fMemCardGone;
  int iVar2;
  CARDINFO_def *pCVar3;
  int card;
  
  fMemCardGone = false;
  card = CURRENTPLAYER * 4 + 1;
  iVar2 = MCRD_handlecardevents(card);
  switch(iVar2) {
  case 2:
  case 3:
  case 7:
  case 10:
  case 0xb:
  case 0x10:
  case 0x13:
  case 0x17:
    fMemCardGone = true;
  }
  pCVar3 = MCRD_getcard(card);
  if (pCVar3->status == -1) {
    fMemCardGone = true;
  }
  if (fMemCardGone) {
    this->ReadyToReturnValue = 1;
    this->ReturnValue = -1;
  }
  else {
    this->ProcessInput(fromPlayer,keyVal,command);
  }
  return;
}



/* ---- tDialogYesNoTri::ProcessInput  [FEDIALOG.CPP:909-916] SLD-VERIFIED ---- */

void tDialogYesNoTri::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command
               )

{
  if (keyVal == kInput_KeyType_Triangle) {
    this->ReadyToReturnValue = 1;
    this->ReturnValue = -1;
  }
  else {
    this->ProcessInput(fromPlayer,keyVal,command);
  }
  return;
}



/* ---- tDialogNoInputMessage::ProcessInput  [FEDIALOG.CPP:921-931] SLD-VERIFIED ---- */

void tDialogNoInputMessage::ProcessInput(tPlayer atPlayer,tInputKeyType &keyVal,
               tMenuCommand &command)

{
  return;
}



/* ---- tDialogYesNoTri::dtor  [FEDIALOG.CPP:294 decl] SLD-FLAG:NO_SLD ---- */

tDialogYesNoTri::~tDialogYesNoTri()

{
  return;
}



/* ---- tDialogYesNoMem::dtor  [FEDIALOG.CPP:284 decl] SLD-FLAG:NO_SLD ---- */

tDialogYesNoMem::~tDialogYesNoMem()

{
  return;
}



/* ---- tDialogYesNo::dtor  [FEDIALOG.CPP:275 decl] SLD-FLAG:NO_SLD ---- */

tDialogYesNo::~tDialogYesNo()

{
  return;
}



/* ---- tDialogNoInputMessage::dtor  [FEDIALOG.CPP:233 decl] SLD-FLAG:NO_SLD ---- */

tDialogNoInputMessage::~tDialogNoInputMessage()

{
  return;
}



/* ---- tDialogBackUpOnly::dtor  [FEDIALOG.CPP:223 decl] SLD-FLAG:NO_SLD ---- */

tDialogBackUpOnly::~tDialogBackUpOnly()

{
  return;
}



/* ---- tDialogMessageString::dtor  [FEDIALOG.CPP:204 decl] SLD-FLAG:NO_SLD ---- */

tDialogMessageString::~tDialogMessageString()

{
  return;
}



/* ---- tDialogHelp::dtor  [FEDIALOG.CPP:174 decl] SLD-FLAG:NO_SLD ---- */

tDialogHelp::~tDialogHelp()

{
  return;
}



/* ---- tDialogBase::dtor  [FEDIALOG.CPP:132 decl] SLD-FLAG:NO_SLD ---- */

tDialogBase::~tDialogBase()

{
  return;
}



/* end of fedialog.cpp */

extern "C" {
void ___7tScreen(void *);
void ___31tDialogMessageStringWithTimeout(void *thisp) { ___7tScreen(thisp); }
}

extern "C" {
void ___7tScreen(void *);
void ___18tDialogInteractive(void *thisp) { ___7tScreen(thisp); }
}
