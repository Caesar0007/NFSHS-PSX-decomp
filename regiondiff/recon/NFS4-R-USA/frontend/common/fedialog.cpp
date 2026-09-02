/* frontend/common/fedialog.cpp -- RECONSTRUCTED (NFS4 menu/item widget hierarchy; C++ TU)
 *   56 fns across 9 classes: tMenuNFS4(+TwoPlayer/Bottom) menu containers, tMenuBlank, tMenuOptions,
 *   tMenuItemGoToMenuNFS4Button, tMenuItemNFS4LeftRightChoice, tMenuItemOptions{LeftRightChoice,
 *   TwoItemChoice}, + free MenuNFS4_DrawTextBox. Member defs; base ctors via init-lists; manual _vf.
 */
#include "fedialog.h"

/* ---- FEDialog.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
static tDialogBase *DialogVisibilityList[8];   /* @0x80052b38  (bss(zero)); SYM STAT */

extern tTexture_ShapeInfo *gHelpShapesA[] asm("gHelpShapes");

/* Draw's 8c record has no `buttonY` local.  Retail nevertheless shares this
   expression across the two controller-button calls; this inline boundary
   preserves that CSE without inventing a caller local.  The body is proven,
   while the original helper/macro spelling is not recoverable. */
static inline int DialogHelpButtonY(short item)
{
  return (item - 1) * 0xf + 0xf;
}

static inline void DialogHelpAnimateOpen(tDialogHelp *dialog)
{
  /* SLD opens an outer inline scope at 0x80019034 (retail line 140), exactly
     where the tick is materialized, and an inner scope at 0x80019068 (line
     146), exactly where the opening body begins.  The caller's 8c record has
     neither `currentTicks` nor `openHeight`; keeping them inside this proven
     inline boundary restores that scope while preserving retail allocation. */
  long currentTicks = ticks[0];

  dialog->width = dialog->width + 0x14;
  dialog->height = dialog->height + 10;
  if ((u_int)(currentTicks - dialog->startTicks) < 0x32) {
    int openHeight = gHelpShapesA[0][0x2a].height;

    dialog->width =
         gHelpShapesA[0][0x2a].width * 2 +
         (short)((u_int)(((int)dialog->width -
                          (short)(gHelpShapesA[0][0x2a].width * 2)) *
                         (currentTicks - dialog->startTicks)) / 0x32);
    dialog->height =
         openHeight * 2 +
         (short)((u_int)(((int)dialog->height -
                          (short)(openHeight * 2)) *
                         (currentTicks - dialog->startTicks)) / 0x32);
  }
}

static inline void DialogHelpPositionAndClamp(tDialogHelp *dialog,
                                              tTexture_ShapeInfo *shape)
{
  /* The caller's complete 8c record has no shape pointer.  Passing shape 3
     through this zero-local inline boundary makes GCC evaluate the argument
     before the centering expressions, reproducing retail's early base load.
     SYM does not retain the private helper/macro spelling, only the absence of
     a caller local; the body and resulting 359-instruction allocation are
     byte-exact. */
  dialog->left = (short)((screenwidth - dialog->width) / 2);
  dialog->top = (short)((0xf0 - dialog->height) / 2);
  if ((int)dialog->width < shape->width + 0x14) {
    dialog->width = shape->width + 0x14;
  }
}

/* CalculateDimensions' 8c record names only `ticks`.  This inline expression
   keeps the retail subtraction grouping without introducing a caller local. */
static inline int DialogMessageTickAge(int value)
{
  return value + -0x32;
}

static inline int DialogMessageHalfWidth(tDialogMessageString *dialog)
{
  /* Draw's 8c record names only `col` and `r`.  This zero-local boundary
     preserves retail's width-before-left load order without a halfw carrier. */
  return (int)((u_int)(u_short)dialog->width << 0x10) >> 0x11;
}

/* The zero-local 8c record and nested line-1 SLD scopes prove an inline source
   boundary around this clamp.  Its behavior and allocation are exact; the
   original unexported helper/macro spelling is not recoverable from SYM. */
static inline int DialogMessageClampFade(tDialogMessageString *dialog)
{
  int fade = dialog->fFadeText;
  int clamped;

  if (0x80 < fade) {
    fade = 0x80;
  }
  clamped = fade;
  if (clamped < 0) {
    clamped = 0;
  }
  dialog->fFadeText = clamped;
  return clamped;
}

/* SLD opens a separate nested scope at retail line 580 (0x80019500) for this
   animation.  Keeping it inline removes five false caller locals while
   retaining retail's exact shared shape loads and arithmetic schedule. */
static inline void DialogMessageAnimateOpen(tDialogMessageString *dialog, int ticks)
{
  int elapsed = ticks - dialog->startTicks;

  if (elapsed < 0x32) {
    int shapeWidth = gHelpShapes[0x2a].width;
    int shapeHeight = gHelpShapes[0x2a].height;

    dialog->fFullyOpen = 0;
    dialog->width =
         shapeWidth * 2 +
         (short)((((int)dialog->width - (((int)shapeWidth << 0x11) >> 0x10)) * elapsed) / 0x32)
    ;
    dialog->height =
         shapeHeight * 2 +
         (short)((((int)dialog->height - (((int)shapeHeight << 0x11) >> 0x10)) *
                  (ticks - dialog->startTicks))
                        / 0x32);
  }
  else {
    dialog->fFullyOpen = 1;
  }
}

/* Run's 8c record has no boolean local for this predicate, while SLD opens
   nested inline scopes at retail lines 31/32.  The private helper spelling is
   unavailable; this boundary preserves the proven materialized-bool shape. */
static inline bool DialogCanProcessCircle(tFEApplication *app, tPlayer player)
{
  return app->helpPopup.currentlyOn == 0 &&
         app->CurrentMenu(player) != (tMenu *)0x0;
}

/* Draw's retail load selects state 1/2 and then addresses the row-8 palette
   state subarray.  SLD retains no caller temporary for that selection; the
   exact private helper spelling is not recoverable. */
static inline int DialogYesNoTextState(tDialogYesNo *dialog, int item)
{
  if (item == dialog->ReturnValue) {
    return 1;
  }
  return 2;
}

static inline char *DialogTextDefinitionsBase()
{
  /* Keeping the array's unoffset base in its own zero-local inline boundary
     reproduces retail's indexed `lbu +51`; folding the row offset into the
     returned address is byte-different. */
  return (char *)textDefinitions;
}

static inline int DialogYesNoOpenElapsed(tDialogYesNo *dialog)
{
  /* CalculateDimensions' 8c record has no elapsed local.  Repeating this
     zero-local accessor lets GCC share the quantity exactly as retail does. */
  return ticks[0] - dialog->startTicks;
}

extern "C" {
void ___7tScreen(void *);
void ___31tDialogMessageStringWithTimeout(void *thisp) { ___7tScreen(thisp); }
}
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

/* MATCH (2026-08-26): 52/52 with SLD/SYM's sole local `short i`.  The nested
   timeout -> Hide -> null-slot return control flow naturally preserves the
   short call-result truncation, eliminating the old sVar1 carrier.  Expressing
   the old-ABI virtual-call adjustment directly as object + delta is also
   significant: routing it through fPermShapes.fFilename - 0x14 reverses the
   otherwise-commutative addu. */

void tDialogBase::DrawAllDialogs()

{
  short i;
  
  i = 0;
  while (DialogVisibilityList[i] != (tDialogBase *)0x0) {
    if (7 < i) break;
    if ((short)DialogVisibilityList[i]->ShouldTimeOut() != 0) {
      DialogVisibilityList[i]->Hide();
      if (DialogVisibilityList[i] == (tDialogBase *)0x0) {
        return;
      }
    }
    /* ABI-neutral spelling of the original virtual `Draw()` call; retail SYM
       records no source vtable or array-slot pointer locals. */
    (*(*((DialogVisibilityList[i]->_vf) + 1))[1].pfn)
      ((char *)DialogVisibilityList[i] +
       (*((DialogVisibilityList[i]->_vf) + 1))[1].delta);
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

tDialogBase *tDialogBase::GetTopMostDialog()

{
  return DialogVisibilityList[0];
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
  short i;

  if (this->currentlyOn != 0) {
    this->currentlyOn = 0;
    for (i = 0; i < 8; i++) {
      if (DialogVisibilityList[i] == this) {
        this->currentlyOn = 0;
        DialogVisibilityList[i] = (tDialogBase *)0x0;
        blockmove(DialogVisibilityList + i + 1,
                  DialogVisibilityList + i,(7 - i) * 4);
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
  /* SYM-ABI-PARAM: fromPlayer -- the mangled signature proves this
     unused argument even though optimized debug has no parameter row. */
  /* SYM-ABI-PARAM: command -- likewise retained by the retail ABI. */
  if (keyval != kInput_KeyType_AlreadyProcessed) {
    this->Hide();
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  return;
}



/* ---- tDialogHelp::AddItem  [FEDIALOG.CPP:260-265] SLD-VERIFIED ---- */

void tDialogHelp::AddItem(short textID,short controllerID)

{
  if (this->numItems < 7) {
    this->text[this->numItems] = TextSys_Word((int)textID);
    this->cont[this->numItems] = (int)controllerID;
    this->numItems = this->numItems + 1;
  }
  return;
}



/* ---- tDialogHelp::CalculateDimensions  [FEDIALOG.CPP:286-451] SLD-VERIFIED ---- */

/* MATCH: the oracle initializes the WHOLE 18-byte helpArray[0] with a single
   lwl/lwr-block copy from an anonymous .rodata template at 0x80010244 (autoGenerate=1,
   all 4 items {text=0,button=0} -- verified byte-exact against rom/nfs4-f.exe
   @foff 0xa44: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00). The prior
   recon hand-unrolled this as a masked-word alignment copy (tp1/uVar10/puVar8) --
   that shape is a Ghidra artifact of the byte-address computation, not a real
   source construct; a plain aggregate-initialized local
   reproduces the exact lwl/lwr/swl/swr sequence. */
/* REGIONAL (USA retail): every help-text id in this function is base id + 1
   (retail's string table gained one entry ahead of the help block).  TEN
   source AddItem sites but only NINE `li a1,N` words -- the two identical
   AddItem(0x56,8) arms cross-jump-merge into one call, so the per-word audit
   under-counts; all ten sites are shifted (catalog 32B-5). */
void tDialogHelp::CalculateDimensions()

{
  int newWidth;
  tMenu *menu;
  short i;
  tPlayer player;
  tHelpData helpArray [1] = { { 1, { {0,0}, {0,0}, {0,0}, {0,0} } } };

  FETextRender_SetFont(0);
  this->numItems = 0;
  this->AddItem(0x5a,0);
  player = (tPlayer)0;
  if (this->specificPlayer != -1) {
    player = (tPlayer)this->specificPlayer;
  }
  if (helpArray[this->variant].autoGenerate != '\0') {
    bool showLeftRight;
    bool showCross;

    showLeftRight = false;
    showCross = false;
    menu = FEApp->CurrentMenu(player);
    i = 0;
    while (true) {
      /* SLD line 45 records the inlined CurrentMenu player argument here.
         Re-reading that accessor is the original source shape: GCC CSEs its
         value with `menu` but retains retail's a0 = s0 pointer copy. */
      if (FEApp->CurrentMenu(player)->fItemList[i] == (tMenuItem *)0x0) {
        break;
      }
      if (((FEApp->CurrentMenu(player)->fItemList[i]->fFlags ^ 1) & 1) != 0) {
        if ((FEApp->CurrentMenu(player)->fItemList[i]->fFlags & 0x400) != 0) {
          showLeftRight = true;
        }
        else {
          showCross = true;
        }
      }
      i = i + 1;
    }
    if (1 < menu->GetNumberEnabledItems()) {
      this->AddItem(0x53,0x50);
    }
    if (showLeftRight) {
      this->AddItem(0x54,0xa0);
    }
    if (showCross) {
      /* SYM-INLINE-THIS: HasFlag */
      if (menu->HasFlag(0x10000) || menu->HasFlag(0x20000)) {
        this->AddItem(0x57,0x4000);
      }
      else {
        this->AddItem(0x56,0x4000);
      }
    }
    if (0 < FEApp->backDepth[player]) {
      this->AddItem(0x55,0x1000);
    }
    if (menu->fOptionsMenu != (tMenu *)0x0) {
      this->AddItem(0x58,-0x8000);
    }
    if ((menu->fFlags & 0x800) != 0) {
      this->AddItem(0x59,8);
    }
    else {
      /* SYM-INLINE-THIS: CanContinue
         SYM-INLINE-THIS: HasFlag */
      if (menu->CanContinue()) {
        this->AddItem(0x57,8);
      }
      else if (menu->HasFlag(4)) {
        this->AddItem(0x57,8);
      }
    }
  }
  i = 0;
  while (helpArray[this->variant].items[i].text != 0) {
    this->AddItem(helpArray[this->variant].items[i].text,
                  helpArray[this->variant].items[i].button);
    i = i + 1;
  }
  this->helpcontrollers = 0;
  PAD_update();
  {
    if (gPadinfo.buf[0].nopad == '\0') {
      this->helpcontrollers =
          this->helpcontrollers | (gPadinfo.buf[0].ID == '#' ? 2 : 1);
    }
  }
  {
    if (gPadinfo.buf[4].nopad == '\0') {
      this->helpcontrollers =
          this->helpcontrollers | (gPadinfo.buf[4].ID == '#' ? 2 : 1);
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
  DialogHelpPositionAndClamp(this,&gHelpShapesA[0][3]);
  DialogHelpAnimateOpen(this);
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
   diffs.  Duplicating the two-button Y expression directly costs 13 diffs;
   `DialogHelpButtonY` preserves its shared value without a non-SYM local.  The
   two-stage tick materialization preserves retail's load/copy pair.  Keeping
   the tick live through the letter-count division, and initializing the loop
   index and stack-buffer cursor first, reproduces its allocation and schedule. */

void tDialogHelp::Draw()

{
  short i;
  short j;
  char buffer [80];
  /* SYM-CODEGEN-CARRIER: bufferPtr -- direct `buffer[j]`/`buffer` use is
     behaviorally equivalent but measures FAIL 2 (187/187): GCC materializes
     the stack-buffer address two instructions after retail. */
  char *bufferPtr;
  short y;
  long ticks;
  int numLetters;
  /* SYM-CODEGEN-CARRIER: firstTick -- repeating `this->startTicks` directly
     measures FAIL 4 (189/187), inserting two load-delay nops and moving the
     member load past retail's tick-value copy. */
  long firstTick;
  
  /* SYM-INLINE-THIS: CalculateDimensionsVirtual */
  this->CalculateDimensionsVirtual();
  firstTick = this->startTicks;
  {
    /* SYM-CODEGEN-CARRIER: loadedTicks -- direct `ticks = ::ticks[0]`
       measures FAIL 3 (186/187): retail has a separate `v0 -> a0` value copy
       between the global tick load and comparison.  The zero-instruction
       allocation fence preserves that proven quantity without rewriting the
       compiled object. */
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
        FeTools_DrawPSXButton(0x41,(u_short)control,this->left + 0x14,
                   this->top + DialogHelpButtonY(i) + 4);
        FeTools_DrawPSXButton(0x23,(u_short)control,this->left + 0x28,
                   this->top + DialogHelpButtonY(i) + 4);
        goto DialogHelpDraw_buttonsDone;
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
/* MATCH (2026-08-14): PASS, 133/133 instructions (115 -> 94 -> 76 -> 31 ->
   28 -> 19 -> 0).  SLD's `ticks` REG $t0 is the raw global tick value, with a
   second assignment after WordWrapHeight; refreshing it there avoids a
   call-crossing callee-saved lifetime.  Assigning fFadeText before reading its
   clamped working copies reproduces retail's v0/v1 copies.  The final large
   reduction came from promoting the signed shape width/height into separate
   int temporaries and writing width/height directly in each MaxH branch;
   the old short reuse and `w` phi caused lhu/sign-extension and preload
   cascades. */

void tDialogMessageString::CalculateDimensions()

{
  int ticks;
  
  ticks = ::ticks[0];
  this->fFadeText = 0x80 - ((DialogMessageTickAge(ticks) - this->startTicks) * 0x80) / 100;
  if (DialogMessageClampFade(this) != 0) {
    this->fFullyOpen = 0;
  }
  this->width = this->MaxW;
  if (this->MaxH == 0) {
    this->height = FETextRender_WordWrapHeight(this->MaxW + -0x28,this->string);
    if (this->height == 8) {
      this->Centerit = 1;
    }
    else {
      this->Centerit = 0;
    }
    this->height = this->height + 0x10;
  }
  else {
    this->Centerit = 0;
    this->height = this->MaxH;
  }
  ticks = ::ticks[0];
  DialogMessageAnimateOpen(this, ticks);
  this->left =
       this->OffsetX + (short)((screenwidth - this->width) / 2);
  this->top =
       this->OffsetY + (short)((0xf0 - this->height) / 2);
  return;
}



/* ---- tDialogMessageString::Draw  [FEDIALOG.CPP:607-651] SLD-VERIFIED ---- */

void tDialogMessageString::Draw()

{
  int col;
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
    r.h = this->height - ((u_short)this->reservedheight + 8);
    FETextRender_SetABR(1,true);
    if (this->Centerit != 0) {
      FETextRender_FullTextRGB(this->string,
                 (short)(((u_int)(u_short)this->left +
                          DialogMessageHalfWidth(this)) * 0x10000
                        >> 0x10),this->top + 8,col,'\0',2);
    }
    else {
      FETextRender_WordWrapTextRGB(this->string,r,col);
    }
    FETextRender_SetABR(0,false);
  }
  /* W65-A3 (calltarget): `this->Draw()` bound to tDialogMessageString::Draw
   * itself -- INFINITE RECURSION.  Retail calls Draw__11tDialogBase; the
   * unqualified name resolves to the derived override that shadows the base's
   * (§3.23c SILENT-SHADOW, here in its same-name-override form).  Explicit
   * base scope binds the call retail makes.  REAL RUNTIME BUG. */
  this->tDialogBase::Draw();
  return;
}



/* ---- tDialogBackUpOnly::ProcessInput  [FEDIALOG.CPP:654-670] SLD-VERIFIED ---- */

void tDialogBackUpOnly::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &)

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
  /* The two SLD `player` entries are inlined formals sharing $s1 with `i`.
     SYM-INLINE-LOCAL: player = DialogCanProcessCircle */
  tInputKeyType keyVal [2];
  tMenuCommand command;
  
  this->fCurrentlyRunning = 1;
  ((tDialogBase *)this)->Display();
  /* SYM-INLINE-THIS: CalculateDimensionsVirtual */
  this->CalculateDimensionsVirtual();
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
        if (DialogCanProcessCircle(FEApp,(tPlayer)i)) {
          FEApp->CurrentMenu((tPlayer)i)->ProcessInputVirtual(
              (tPlayer)i,keyVal[i],command);
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }
      if (keyVal[i] != kInput_KeyType_AlreadyProcessed) {
        /* SYM-INLINE-THIS: IsVisible */
        if (((tDialogBase *)&FEApp->helpPopup)->IsVisible()) {
          ((tDialogBase *)&FEApp->helpPopup)->Hide();
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }
      if (keyVal[i] != kInput_KeyType_NoKey) {
        /* SYM-INLINE-THIS: ProcessInputVirtual */
        this->ProcessInputVirtual((tPlayer)i,keyVal[i],command);
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
  /* MATCH (2026-08-26): 46/46 and zero named locals, matching SYM.  The
     elapsed accessor replaces the former iVar2 carrier while preserving the
     retail in-place height update and merged trailing store. */
  ((tDialogMessageString *)this)->CalculateDimensions();
  if (this->MaxH == 0) {
    if (DialogYesNoOpenElapsed(this) < 0x32) {
      this->height = this->height +
          (short)((DialogYesNoOpenElapsed(this) * 0xf) / 0x32);
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

/* W66-A3 (link + calltarget): the tDialog family's base ctors are INLINE-ONLY in
 * retail -- there is no `__11tDialogBase` / `__20tDialogMessageString` function
 * anywhere in the image, and this ctor's oracle jal's `__7tScreen` directly with
 * every base body expanded in place.  feapp.cpp / fememcard.cpp / front.cpp all
 * carry the inline definitions; fedialog.cpp did NOT, so gcc had to emit an
 * out-of-line call to a ctor nobody defines -- an undefined symbol at link time
 * that the gate's reloc-name leniency hid (one jal, right position, wrong name).
 * Supplying the definitions here lets the member-init chain inline them and reach
 * `__7tScreen`, exactly like retail; the store list below drops the copies that
 * are now emitted by the inlined bodies. */
inline tDialogBase::tDialogBase()
{
  *(void **)&_vf = (void *)tDialogBase_vtable;
  currentlyOn = 0;
  reservedheight = 0;
  MaxH = 0;
  OffsetY = 0;
  OffsetX = 0;
  height = 0;
  width = 0;
  top = 0;
  left = 0;
  MaxW = 0x120;
  specificPlayer = -1;
  fDefault = 0;
  timeOutTicks = 0;
}

inline tDialogMessageString::tDialogMessageString()
{
  *(void **)&_vf = (void *)tDialogMessageString_vtable;
  Centerit = 0;
  fFullyOpen = 0;
  timeOutTicks = 0;
  fFadeText = 0x80;
}

tDialogYesNo::tDialogYesNo()
  : tDialogInteractive()
{

  *(void **)&(this->_vf) = (void *)tDialogInteractive_vtable;
  /* MATCH: oracle emits 3 separate `sw zero,0x78` (timeOutTicks); gcc folds the 2nd of two
   * adjacent identical plain stores. The volatile-cast keeps the redundant store (codegen-
   * neutral: same `sw zero,0x78`). Do NOT "simplify" away or the 3rd store disappears (45 vs 46). */
  *(long *)&this->timeOutTicks = 0;
  this->fCurrentlyRunning = 0;
  *(void **)&(this->_vf) = (void *)tDialogYesNo_vtable;
  this->ReturnValue = 0;
  this->ReadyToReturnValue = 0;
  return;
}



/* ---- tDialogYesNo::Draw  [FEDIALOG.CPP:773-815] SLD-VERIFIED ---- */
/* MATCH (2026-08-26): exact 98/98 and declaration-clean against SYM's sole
   locals `i`, `x`, `y`, and `col`.  CalculateDimensionsVirtual removes the raw
   vtable alias.  DialogYesNoTextState plus DialogTextDefinitionsBase preserve
   retail's hoisted palette bases and state-1/2 `lbu +51` without caller temps;
   natural `yesnowords[i]` produces the retail pointer induction.  The SLD/IDA
   statement shape `y = top + height - 11` remains one expression, scheduling
   the subtraction in SetABR's delay slot and the short cast in TextSys_Word's
   delay slot. */

void tDialogYesNo::Draw()

{
  int col;
  int y;
  int i;
  int x;
  
  /* SYM-INLINE-THIS: CalculateDimensionsVirtual */
  this->CalculateDimensionsVirtual();
  if (this->fFadeText != 0) {
    this->fFullyOpen = 0;
  }
  i = 0;
  if (0x31 < ticks[0] - this->startTicks) {
    x = (int)this->left +
            ((int)((u_int)(u_short)this->width
                  << 0x10) >> 0x12);
    while( true ) {
      if (2 <= i) break;
      col = CalcFadeVal(
          kRGBVals[(u_char)DialogTextDefinitionsBase()
              [DialogYesNoTextState(this,i) + 0x33]],
          (int)this->fFadeText);
      y = (int)this->top + (int)this->height - 0xb;
      FETextRender_SetABR(1,true);
      FETextRender_FullTextRGB(TextSys_Word(this->yesnowords[i]),
                              (short)x,(short)y,col,'\0',2);
      FETextRender_SetABR(0,false);
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
  int card;
  
  fMemCardGone = false;
  card = CURRENTPLAYER * 4 + 1;
  switch(MCRD_handlecardevents(card)) {
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
  if (MCRD_getcard(card)->status == -1) {
    fMemCardGone = true;
  }
  if (fMemCardGone) {
    this->ReadyToReturnValue = 1;
    this->ReturnValue = -1;
  }
  else {
    /* W65-A3 (calltarget): unqualified `this->ProcessInput(...)` bound to THIS
     * override -- INFINITE RECURSION.  Retail calls
     * ProcessInput__12tDialogYesNo...; explicit base scope binds it. REAL BUG. */
    this->tDialogYesNo::ProcessInput(fromPlayer,keyVal,command);
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
    /* W65-A3 (calltarget): as tDialogYesNoMem -- was infinite recursion. */
    this->tDialogYesNo::ProcessInput(fromPlayer,keyVal,command);
  }
  return;
}



/* ---- tDialogNoInputMessage::ProcessInput  [FEDIALOG.CPP:921-931] SLD-VERIFIED ---- */

void tDialogNoInputMessage::ProcessInput(tPlayer,tInputKeyType &,
               tMenuCommand &)

{
  return;
}



/* ---- tDialogYesNoTri::dtor  [FEDIALOG.CPP:294 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___15tDialogYesNoTri(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogYesNoMem::dtor  [FEDIALOG.CPP:284 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___15tDialogYesNoMem(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogYesNo::dtor  [FEDIALOG.CPP:275 decl] SLD-FLAG:NO_SLD ---- */

extern "C" { void ___7tScreen(void *); }
extern "C" void ___12tDialogYesNo(void *thisp) { ___7tScreen(thisp); }




extern "C" {
void ___7tScreen(void *);
void ___18tDialogInteractive(void *thisp) { ___7tScreen(thisp); }
}
/* ---- tDialogNoInputMessage::dtor  [FEDIALOG.CPP:233 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___21tDialogNoInputMessage(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogBackUpOnly::dtor  [FEDIALOG.CPP:223 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___17tDialogBackUpOnly(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogMessageString::dtor  [FEDIALOG.CPP:204 decl] SLD-FLAG:NO_SLD ---- */

extern "C" void ___20tDialogMessageString(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogHelp::dtor  [FEDIALOG.CPP:174 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___11tDialogHelp(void *thisp) { ___7tScreen(thisp); }



/* ---- tDialogBase::dtor  [FEDIALOG.CPP:132 decl] SLD-FLAG:NO_SLD ----
 * W65-A3 (calltarget): the class no longer DECLARES a dtor (see nfs4_types.h),
 * so gcc synthesises + inlines it at every call site -- which is what makes
 * ~tDialogHelp / ~tDialogMessageString etc. `jal ___7tScreen` like retail.
 * gcc emits NO out-of-line copy for a synthesised dtor (probed: globals,
 * delete, virtual, explicit ~C() call sites -- none emit one), so the
 * standalone symbol is supplied here as a free function with C linkage, the
 * device already in use two blocks up for ___18tDialogInteractive.  Body is
 * byte-identical to the oracle's 8 insns: the arg passes through in $a0 and
 * the ignored `__in_chrg` in $a1 costs nothing. */

extern "C" void ___11tDialogBase(void *thisp) { ___7tScreen(thisp); }



/* end of fedialog.cpp */
