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
  short sVar1;
  
  if ((this->timeOutTicks < 1) || (sVar1 = 1, ticks - this->startTicks < this->timeOutTicks)) {
    sVar1 = 0;
  }
  return sVar1;
}



/* ---- tDialogBase::InitializeClass  [FEDIALOG.CPP:83-84] SLD-VERIFIED ---- */

int tDialogBase::InitializeClass()

{
  int iVar1;
  
  iVar1 = this->HideAllDialogs();
  return iVar1;
}



/* ---- tDialogBase::DrawAllDialogs  [FEDIALOG.CPP:90-101] SLD-VERIFIED ---- */

int tDialogBase::DrawAllDialogs()

{
  short sVar1;
  __vtbl_ptr_type (*pa_Var2) [10];
  tDialogBase *ptVar3;
  int iVar4;
  tDialogBase **pptVar5;
  int i;
  
  i = 0;
  ptVar3 = DialogVisibilityList[0];
  while( true ) {
    if (ptVar3 == (tDialogBase *)0x0) {
      return 0;
    }
    iVar4 = (int)(short)i;
    if (7 < iVar4) break;
    pptVar5 = DialogVisibilityList + iVar4;
    sVar1 = (*pptVar5)->ShouldTimeOut();
    if ((sVar1 != 0) && ((*pptVar5)->Hide(), *pptVar5 == (tDialogBase *)0x0)) {
      return 0;
    }
    pa_Var2 = ((*pptVar5))->_vf;
    (*pa_Var2[1][1].pfn)(((*pptVar5))->fPermShapes.fFilename + pa_Var2[1][1].delta + -0x14);
    i = i + 1;
    ptVar3 = *(tDialogBase **)((int)DialogVisibilityList + (i * 0x10000 >> 0xe));
  }
  return iVar4 * 4;
}



/* ---- tDialogBase::HideAllDialogs  [FEDIALOG.CPP:107-111] SLD-VERIFIED ---- */

int tDialogBase::HideAllDialogs()

{
  int iVar1;
  short i;
  
  i = 0;
  iVar1 = 0;
  do {
    *(u_int *)((int)DialogVisibilityList + (iVar1 >> 0xe)) = 0;
    i = i + 1;
    iVar1 = i * 0x10000;
  } while (i * 0x10000 >> 0x10 < 8);
  return iVar1;
}



/* ---- tDialogBase::GetTopMostDialog  [FEDIALOG.CPP:117-120] SLD-VERIFIED ---- */

int tDialogBase::GetTopMostDialog()

{
  return (int)DialogVisibilityList[0];
}



/* ---- tDialogBase::Display  [FEDIALOG.CPP:126-154] SLD-VERIFIED ---- */

void tDialogBase::Display()

{
  short shift_idx;
  int i;
  
  i = 7;
  if (this->currentlyOn == 0) {
    this->currentlyOn = 1;
    this->fFullyOpen = 0;
    this->ReturnValue = this->fDefault;
    do {
      shift_idx = (short)i;
      i = i + -1;
      DialogVisibilityList[shift_idx] = DialogVisibilityList[shift_idx + -1];
    } while (0 < i * 0x10000);
    DialogVisibilityList[0] = this;
    this->ShouldTimeOut();
    (DialogVisibilityList[0])->ShouldTimeOut();
    this->startTicks = ticks;
    AudioCmn_PlayFESFX(0xf);
    this->fFullyOpen = 0;
    this->fFadeText = 0x80;
  }
  return;
}



/* ---- tDialogBase::Hide  [FEDIALOG.CPP:159-181] SLD-VERIFIED ---- */

void tDialogBase::Hide()

{
  int iVar1;
  tDialogBase **dst;
  int i;
  
  i = 0;
  if (this->currentlyOn != 0) {
    this->currentlyOn = 0;
    iVar1 = 0;
    do {
      iVar1 = iVar1 >> 0x10;
      dst = DialogVisibilityList + iVar1;
      if (*dst == this) {
        this->currentlyOn = 0;
        *dst = (tDialogBase *)0x0;
        blockmove(DialogVisibilityList + iVar1 + 1,dst,(7 - iVar1) * 4);
        DialogVisibilityList[7] = (tDialogBase *)0x0;
        AudioCmn_PlayFESFX(0x12);
      }
      i = i + 1;
      iVar1 = i * 0x10000;
    } while (i * 0x10000 >> 0x10 < 8);
  }
  return;
}



/* ---- tDialogBase::Draw  [FEDIALOG.CPP:200-210] SLD-VERIFIED ---- */

void tDialogBase::Draw()

{
  int abr;
  
  PSXDrawTransSquare(0,(int)this->left,(int)this->top,4,(int)this->height,4);
  PSXDrawTransSquare(0,(this->left + this->width) - 4,(int)this->top,4,(int)this->height,4);
  PSXDrawTransSquare(0,this->left + 4,(int)this->top,this->width + -8,2,4);
  PSXDrawTransSquare(0,this->left + 4,(this->top + this->height) - 2,this->width + -8,2,4);
  abr = this->left + 4;
  PSXDrawTransSquare(0,this->left + 4,this->top + 2,this->width + -8,this->height + -4,2);
  FeDraw_SetABRMode(abr);
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

void tDialogHelp::CalculateDimensions()

{
  u_char *puVar1;
  short sVar2;
  bool bVar3;
  bool showLeftRight;
  bool showCross;
  tTexture_ShapeInfo *ptVar5;
  short sVar6;
  u_short uVar7;
  int newWidth;
  u_int *puVar8;
  int iVar9;
  u_int uVar10;
  tMenu *menu;
  short i;
  int iVar11;
  tPlayer player;
  char acStack_90038 [2];
  short asStack_90036 [294911];
  tHelpData helpArray [1];
  void *tp1;
  
  tp1 = (void *)((int)&helpArray[0].items[0].text + 1);
  uVar10 = (u_int)tp1 & 3;
  *(u_int *)((int)tp1 - uVar10) =
       *(u_int *)((int)tp1 - uVar10) & -1 << (uVar10 + 1) * 8 | 0x00000001U /* @0x80010244 */ >> (3 - uVar10) * 8;
  (*(u_int*)&helpArray[0]) = 0x00000001U /* @0x80010244 */;
  puVar1 = (u_char *)((int)&helpArray[0].items[1].text + 1);
  uVar10 = (u_int)puVar1 & 3;
  puVar8 = (u_int *)(puVar1 + -uVar10);
  *puVar8 = *puVar8 & -1 << (uVar10 + 1) * 8 | 0x00000000U /* @0x80010248 */ >> (3 - uVar10) * 8;
  (*(u_int*)((char*)&helpArray[0].items + 2)) = 0x00000000U /* @0x80010248 */;
  puVar1 = (u_char *)((int)&helpArray[0].items[2].text + 1);
  uVar10 = (u_int)puVar1 & 3;
  puVar8 = (u_int *)(puVar1 + -uVar10);
  *puVar8 = *puVar8 & -1 << (uVar10 + 1) * 8 | 0x00000000U /* @0x8001024c */ >> (3 - uVar10) * 8;
  (*(u_int*)((char*)&helpArray[0].items + 6)) = 0x00000000U /* @0x8001024c */;
  puVar1 = (u_char *)((int)&helpArray[0].items[3].text + 1);
  uVar10 = (u_int)puVar1 & 3;
  puVar8 = (u_int *)(puVar1 + -uVar10);
  *puVar8 = *puVar8 & -1 << (uVar10 + 1) * 8 | 0x00000000U /* @0x80010250 */ >> (3 - uVar10) * 8;
  (*(u_int*)((char*)&helpArray[0].items + 10)) = 0x00000000U /* @0x80010250 */;
  helpArray[0].items[3].button = 0x00000000U /* @0x80010254 */;
  FETextRender_SetFont(0);
  this->numItems = 0;
  this->AddItem(0x59,0);
  iVar9 = (int)this->specificPlayer;
  player = (tPlayer)0;
  if (iVar9 != -1) {
    player = (tPlayer)iVar9;
  }
  showLeftRight = false;
  if (helpArray[this->variant].autoGenerate != '\0') {
    showCross = false;
    menu = FEApp->fCurrentMenu[player];
    i = 0;
    while (puVar8 = *(u_int **)((int)menu->fItemList + ((i << 0x10) >> 0xe)),
          puVar8 != (u_int *)0x0) {
      uVar10 = *puVar8;
      if (((uVar10 ^ 1) & 1) != 0) {
        if ((uVar10 & 0x400) == 0) {
          showCross = true;
        }
        else {
          showLeftRight = true;
        }
      }
      i = i + 1;
    }
    sVar6 = menu->GetNumberEnabledItems();
    if (1 < sVar6) {
      this->AddItem(0x52,0x50);
    }
    if (showLeftRight) {
      this->AddItem(0x53,0xa0);
    }
    if (showCross) {
      bVar3 = false;
      if (((menu->fFlags & 0x10000) != 0) || ((menu->fFlags & 0x20000) != 0)) {
        bVar3 = true;
      }
      if (bVar3) {
        sVar6 = 0x56;
      }
      else {
        sVar6 = 0x55;
      }
      this->AddItem(sVar6,0x4000);
    }
    if (0 < FEApp->backDepth[player]) {
      this->AddItem(0x54,0x1000);
    }
    if (menu->fOptionsMenu != (tMenu *)0x0) {
      this->AddItem(0x57,-0x8000);
    }
    if ((menu->fFlags & 0x800) == 0) {
      bVar3 = false;
      if (((menu->fNextMenu != (tMenu *)0x0) || ((menu->fFlags & 0x400) != 0)) ||
         (menu->fOnButtonPress != (u_char **)0x0)) {
        bVar3 = true;
      }
      if ((!bVar3) && ((menu->fFlags & 4) == 0)) goto CalcDim_helpArrFetch;
      sVar6 = 0x56;
    }
    else {
      sVar6 = 0x58;
    }
    this->AddItem(sVar6,8);
  }
CalcDim_helpArrFetch:
  sVar2 = this->variant;
  i = 0;
  sVar6 = helpArray[this->variant].items[0].text;
  while (sVar6 != 0) {
    iVar9 = (i << 0x10) >> 0xe;
    this->AddItem(*(short *)((int)&helpArray[sVar2].items[0].text + iVar9),
            *(short *)((int)&helpArray[sVar2].items[0].button + iVar9));
    i = i + 1;
    sVar2 = this->variant;
    sVar6 = *(short *)((int)&helpArray[this->variant].items[0].text + (i * 0x10000 >> 0xe));
  }
  this->helpcontrollers = 0;
  PAD_update();
  if (gPadinfo.buf[0].nopad == '\0') {
    uVar7 = this->helpcontrollers | 1;
    if (gPadinfo.buf[0].ID == '#') {
      uVar7 = this->helpcontrollers | 2;
    }
    this->helpcontrollers = uVar7;
  }
  if (gPadinfo.buf[4].nopad == '\0') {
    uVar7 = this->helpcontrollers | 1;
    if (gPadinfo.buf[4].ID == '#') {
      uVar7 = this->helpcontrollers | 2;
    }
    this->helpcontrollers = uVar7;
  }
  sVar6 = this->numItems;
  i = 0;
  this->width = 0;
  if (0 < sVar6) {
    iVar9 = 0;
    do {
      iVar9 = textpixels(*(char **)((int)this->text + (iVar9 >> 0xe)));
      if (this->width < iVar9) {
        this->width = (short)iVar9;
      }
      i = i + 1;
      iVar9 = i * 0x10000;
    } while (i * 0x10000 >> 0x10 < (int)this->numItems);
  }
  if (this->helpcontrollers == 3) {
    newWidth = this->width;
    this->lefttext = 0x46;
    newWidth = newWidth + 0x46;
  }
  else {
    newWidth = this->width;
    this->lefttext = 0x28;
    newWidth = newWidth + 0x28;
  }
  this->width = newWidth;
  if (this->numItems < 2) {
    this->height = 0;
  }
  else {
    this->height = this->numItems * 0xf;
  }
  ptVar5 = gHelpShapes;
  this->left = (short)((screenwidth - this->width) / 2);
  this->top = (short)((0xf0 - this->height) / 2);
  if ((int)this->width < ptVar5[3].width + 0x14) {
    this->width = ptVar5[3].width + 0x14;
  }
  iVar11 = ticks;
  this->width = this->width + 0x14;
  uVar10 = iVar11 - this->startTicks;
  this->height = this->height + 10;
  if (uVar10 < 0x32) {
    sVar6 = gHelpShapes[0x2a].height;
    this->width =
         gHelpShapes[0x2a].width * 2 +
         (short)((((int)this->width - (((int)gHelpShapes[0x2a].width << 0x11) >> 0x10)
                  ) * uVar10) / 0x32);
    this->height =
         sVar6 * 2 +
         (short)((u_int)(((int)this->height - (((int)sVar6 << 0x11) >> 0x10)) *
                       (iVar11 - this->startTicks)) / 0x32);
  }
  this->top = 0x14;
  this->left = 0x1f9 - this->width;
  return;
}



/* ---- tDialogHelp::Draw  [FEDIALOG.CPP:459-546] SLD-VERIFIED ---- */

void tDialogHelp::Draw()

{
  short sVar1;
  short sVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  u_int numLetters;
  int iVar5;
  u_char padType;
  long ticks;
  char *sMenuText;
  short j;
  int iVar6;
  int control;
  int x;
  tMenuTextType textType;
  u_int i;
  short y;
  char acStackY_8070 [32760];
  char buffer [80];
  
  pa_Var3 = this->_vf;
  ticks = (long)pa_Var3[1][0].delta;
  (*pa_Var3[1][0].pfn)(this->fPermShapes.fFilename + ticks + -0x14);
  iVar6 = this->startTicks;
  if (iVar6 + 0x32 <= ticks) {
    iVar6 = ((ticks - iVar6) + -0x32) / 3;
    i = 0;
    iVar5 = 0;
    while (iVar5 >> 0x10 < (int)this->numItems) {
      if (iVar5 >> 0x10 == 0) {
        y = this->top + 4;
      }
      else {
        y = this->top + ((short)((u_int)iVar5 >> 0x10) + -1) * 0xf + 0x13;
      }
      sVar2 = (short)i;
      iVar5 = (int)sVar2;
      if (0 < iVar5) {
        sVar1 = this->helpcontrollers;
        control = this->cont[iVar5];
        if (sVar1 == 2) {
          padType = 0x23;
          iVar5 = iVar5 + -1;
DialogHelpDraw_setupTextPos:
          x = this->left + 0x14;
          iVar5 = iVar5 * 0xf + (int)this->top + 0x13;
        }
        else {
          if ((sVar1 < 3) || (sVar1 != 3)) {
            padType = 0x41;
            iVar5 = iVar5 + -1;
            goto DialogHelpDraw_setupTextPos;
          }
          if (((control == 0xa0) || (control == 0x50)) || (control == 0x40)) {
            padType = 0x41;
            iVar5 = sVar2 + -1;
            goto DialogHelpDraw_setupTextPos;
          }
          iVar5 = (iVar5 + -1) * 0xf + 0xf;
          FeTools_DrawPSXButton(0x41,(u_short)control,this->left + 0x14,
                     this->top + iVar5 + 4);
          padType = 0x23;
          x = this->left + 0x28;
          iVar5 = this->top + iVar5 + 4;
        }
        FeTools_DrawPSXButton(padType,(u_short)control,x,iVar5);
      }
      iVar5 = (int)sVar2;
      numLetters = strlen(this->text[iVar5]);
      textType = textType_PopUpText;
      if (iVar6 < (int)numLetters) {
        j = 0;
        if (0 < iVar6) {
          do {
            sVar2 = (short)j;
            j = j + 1;
            buffer[sVar2] = this->text[iVar5][sVar2];
          } while (j * 0x10000 >> 0x10 < iVar6);
        }
        buffer[iVar6] = '\0';
        sVar2 = this->left + this->lefttext;
        textType = textType_PopUpText;
        sMenuText = buffer;
        if ((i & 0xffff) == 0) {
          textType = textType_PopUpTitle;
        }
      }
      else {
        sVar2 = this->left + this->lefttext;
        if (iVar5 == 0) {
          textType = textType_PopUpTitle;
        }
        sMenuText = this->text[iVar5];
      }
      i = i + 1;
      FETextRender_FullText(sMenuText,sVar2,y,textType,textState_Selected,0);
      iVar5 = i * 0x10000;
    }
  }
  this->Draw();
  return;
}



/* ---- tDialogMessageString::CalculateDimensions  [FEDIALOG.CPP:551-600] SLD-VERIFIED ---- */

void tDialogMessageString::CalculateDimensions()

{
  short sVar1;
  short w;
  int fade_or_h;
  int iVar2;
  int tick_age;
  int ticks;
  short h;
  
  fade_or_h = 0x80 - (((ticks + -0x32) - this->startTicks) * 0x80) / 100;
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
  iVar2 = ticks - this->startTicks;
  if (iVar2 < 0x32) {
    sVar1 = gHelpShapes[0x2a].width;
    h = gHelpShapes[0x2a].height;
    tick_age = ticks - this->startTicks;
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
  RECT r;
  
  pa_Var1 = this->_vf;
  (*pa_Var1[1][0].pfn)
            (this->fPermShapes.fFilename + pa_Var1[1][0].delta + -0x14);
  if (ticks < this->startTicks + 0x32) {
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
    r.h = this->height - (this->reservedheight + 8);
    FETextRender_SetABR(1,true);
    if (this->Centerit == 0) {
      FETextRender_WordWrapTextRGB(this->string,r,col);
    }
    else {
      FETextRender_FullTextRGB(this->string,
                 (short)(((u_int)(u_short)this->left +
                         ((int)((u_int)(u_short)this->width << 0x10) >> 0x11)) * 0x10000
                        >> 0x10),this->top + 8,col,'\0',2);
    }
    FETextRender_SetABR(0,false);
  }
  this->Draw();
  return;
}



/* ---- tDialogBackUpOnly::ProcessInput  [FEDIALOG.CPP:654-670] SLD-VERIFIED ---- */

int tDialogBackUpOnly::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  int iVar1;
  tPlayer tVar2;
  
  tVar2 = (tPlayer)this->specificPlayer;
  iVar1 = -1;
  if ((tVar2 == kPlayerBoth) || (fromPlayer == tVar2)) {
    iVar1 = 4;
    if (keyval == kInput_KeyType_Triangle) {
      ((tDialogBase *)this)->Hide();
    }
    else {
      iVar1 = 1;
      if (keyval != kInput_KeyType_Circle) {
        keyval = kInput_KeyType_AlreadyProcessed;
      }
    }
  }
  return iVar1;
}



/* ---- tDialogInteractive::Run  [FEDIALOG.CPP:684-742] SLD-VERIFIED ---- */

short tDialogInteractive::Run()

{
  short sVar1;
  bool bVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  tInputKeyType tVar4;
  int iVar5;
  int iVar6;
  tInputKeyType *ptVar7;
  int i;
  tPlayer player;
  int iVar8;
  u_long debounce;
  tInputKeyType keyVal [2];
  tMenuCommand command;
  
  this->fCurrentlyRunning = 1;
  ((tDialogBase *)this)->Display();
  pa_Var3 = this->_vf;
  (*pa_Var3[1][0].pfn)
            (this->fPermShapes.fFilename +
             pa_Var3[1][0].delta + -0x14);
  this->ReadyToReturnValue = 0;
  while (this->ReadyToReturnValue == 0) {
    command.type = kMenu_Command_None;
    iVar8 = 0;
    ptVar7 = keyVal;
    for (player = kPlayerOne; player < 2; player = player + kPlayerTwo) {
      tVar4 = FEInput_GetKeyFromPlayer(player,-1);
      *ptVar7 = tVar4;
      if (tVar4 == kInput_KeyType_NoKey) {
        *ptVar7 = kInput_KeyType_AlreadyProcessed;
      }
      if (*ptVar7 == kInput_KeyType_Circle) {
        bVar2 = false;
        if ((FEApp->helpPopup).currentlyOn == 0) {
          bVar2 = *(int *)((int)FEApp->fCurrentMenu + iVar8) != 0;
        }
        if (bVar2) {
          iVar6 = *(int *)((int)FEApp->fCurrentMenu + iVar8);
          iVar5 = *(int *)(iVar6 + 0x68);
          (**(int (**)(...))(iVar5 + 0x1c))(iVar6 + *(short *)(iVar5 + 0x18),player,ptVar7,&command);
          *ptVar7 = kInput_KeyType_AlreadyProcessed;
        }
      }
      tVar4 = kInput_KeyType_AlreadyProcessed;
      if (*ptVar7 != kInput_KeyType_AlreadyProcessed) {
        if ((FEApp->helpPopup).currentlyOn != 0) {
          ((tDialogBase *)(tDialogBase *)&(FEApp->helpPopup))->Hide();
          *ptVar7 = kInput_KeyType_AlreadyProcessed;
        }
        tVar4 = *ptVar7;
      }
      if (tVar4 != kInput_KeyType_NoKey) {
        pa_Var3 = this->_vf;
        (*(*pa_Var3)[9].pfn)
                  (this->fPermShapes.fFilename +
                   (*pa_Var3)[9].delta + -0x14,player,ptVar7,&command);
      }
      ptVar7 = ptVar7 + 1;
      iVar8 = iVar8 + 4;
    }
    FEApp->Redraw();
  }
  AudioCmn_PlayFESFX(0);
  ((tDialogBase *)this)->Hide();
  FEApp->Redraw();
  sVar1 = this->ReturnValue;
  this->fCurrentlyRunning = 0;
  return sVar1;
}



/* ---- tDialogYesNo::CalculateDimensions  [FEDIALOG.CPP:748-759] SLD-VERIFIED ---- */

void tDialogYesNo::CalculateDimensions()

{
  short sVar1;
  int iVar2;
  
  ((tDialogMessageString *)this)->CalculateDimensions();
  if (this->MaxH == 0) {
    iVar2 = ticks - this->startTicks;
    if (iVar2 < 0x32) {
      sVar1 = this->height +
              (short)((iVar2 * 0xf) / 0x32);
    }
    else {
      sVar1 = this->height + 0xf;
    }
    this->height = sVar1;
    sVar1 = this->height;
    this->reservedheight = 0xf;
    this->top =
         this->OffsetY +
         (short)((0xf0 - sVar1) / 2);
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

void tDialogYesNo::Draw()

{
  short sVar1;
  short sVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  char *sMenuText;
  int col;
  int y;
  int i;
  int x;
  tDialogYesNo *ptVar8;
  
  pa_Var3 = this->_vf;
  (*pa_Var3[1][0].pfn)
            (this->fPermShapes.fFilename + pa_Var3[1][0].delta + -0x14);
  if (this->fFadeText != 0) {
    this->fFullyOpen = 0;
  }
  i = 0;
  if (0x31 < ticks - this->startTicks) {
    x = (int)this->left +
            ((int)((u_int)(u_short)this->width
                  << 0x10) >> 0x12);
    ptVar8 = this;
    for (; i < 2; i = i + 1) {
      col = 2;
      if (i == this->ReturnValue) {
        col = 1;
      }
      col = CalcFadeVal(kRGBVals[(u_char)textDefinitions[8][col + 3]],(int)this->fFadeText);
      sVar1 = this->top;
      sVar2 = this->height;
      FETextRender_SetABR(1,true);
      y = ((int)sVar1 + (int)sVar2 + -0xb) * 0x10000;
      sMenuText = TextSys_Word(ptVar8->yesnowords[0]);
      FETextRender_FullTextRGB(sMenuText,(short)x,(short)((u_int)y >> 0x10),col,'\0',2);
      FETextRender_SetABR(0,false);
      ptVar8 = (tDialogYesNo *)
               &(ptVar8)->fPermShapes.fFile;
      x = x + ((int)((u_int)(u_short)this->width << 0x10) >> 0x11);
    }
  }
  ((tDialogMessageString *)this)->Draw();
  return;
}



/* ---- tDialogYesNo::ProcessInput  [FEDIALOG.CPP:823-853] SLD-VERIFIED ---- */

void tDialogYesNo::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command)

{
  tPlayer tVar1;
  tInputKeyType tVar2;
  
  tVar1 = (tPlayer)this->specificPlayer;
  if (((tVar1 == kPlayerBoth) || (fromPlayer == tVar1)) &&
     (this->fFullyOpen == 1)) {
    tVar2 = keyVal;
    if (tVar2 == kInput_KeyType_Left) {
      AudioCmn_PlayFESFX(5);
      this->ReturnValue = 1;
    }
    else {
      if ((int)tVar2 < 0x801) {
        if (tVar2 != kInput_KeyType_Cross) {
          return;
        }
      }
      else {
        if (tVar2 == kInput_KeyType_Right) {
          AudioCmn_PlayFESFX(6);
          this->ReturnValue = 0;
          return;
        }
        if (tVar2 != kInput_KeyType_Start) {
          return;
        }
      }
      AudioCmn_PlayFESFX(0);
      this->ReadyToReturnValue = 1;
      ((tDialogBase *)this)->Hide();
    }
  }
  return;
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
