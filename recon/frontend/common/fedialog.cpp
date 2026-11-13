/* frontend/common/fedialog.cpp -- RECONSTRUCTED (NFS4 menu/item widget hierarchy; C++ TU)
 *   56 fns across 9 classes: tMenuNFS4(+TwoPlayer/Bottom) menu containers, tMenuBlank, tMenuOptions,
 *   tMenuItemGoToMenuNFS4Button, tMenuItemNFS4LeftRightChoice, tMenuItemOptions{LeftRightChoice,
 *   TwoItemChoice}, + free MenuNFS4_DrawTextBox. Member defs; base ctors via init-lists; real virtuals.
 */
#define NFS4_FEDIALOG_DIRECT
#include "fedialog_types.h"
#include "fedialog_externs.h"

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly.  FE_Ticks lives in fedialog_externs.h: an inline defined
   in a header records its pair at the CALLER's line (retail), one defined earlier in this .cpp at 1. */



/* ---- FEDialog.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
static tDialogBase *DialogVisibilityList[8];   /* @0x80052b38  (bss(zero)); SYM STAT */


/* ---- tDialogBase::ShouldTimeOut  [FEDIALOG.CPP:73-76] SLD-VERIFIED ---- */




/* ---- tDialogYesNoTri::dtor  [FEDIALOG.CPP:294 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



/* ---- tDialogYesNoMem::dtor  [FEDIALOG.CPP:284 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



/* ---- tDialogYesNo::dtor  [FEDIALOG.CPP:275 decl] SLD-FLAG:NO_SLD ---- */

extern "C" { void ___7tScreen(void *); }




extern "C" {
void ___7tScreen(void *);
}
/* ---- tDialogNoInputMessage::dtor  [FEDIALOG.CPP:233 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



/* ---- tDialogBackUpOnly::dtor  [FEDIALOG.CPP:223 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



/* ---- tDialogMessageString::dtor  [FEDIALOG.CPP:204 decl] SLD-FLAG:NO_SLD ---- */




/* ---- tDialogHelp::dtor  [FEDIALOG.CPP:174 decl] SLD-FLAG:NO_SLD ---- */

/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



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




/* end of fedialog.cpp */
#line 70 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
short tDialogBase::ShouldTimeOut()


{
  if (0 < timeOutTicks && timeOutTicks <= FE_Ticks() - startTicks)
    return 1;
  else return 0;
}


/* ---- tDialogBase::InitializeClass  [FEDIALOG.CPP:83-84] SLD-VERIFIED ---- */

#line 80 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::InitializeClass()


{
  HideAllDialogs();
}



/* ---- tDialogBase::DrawAllDialogs  [FEDIALOG.CPP:90-101] SLD-VERIFIED ---- */

/* MATCH (2026-08-26 and scope follow-up): 52/52 with SYM's sole local `short i`
   now owned by its retail inner function-spanning block. The nested
   timeout -> Hide -> null-slot return control flow naturally preserves the
   short call-result truncation, eliminating the old sVar1 carrier.  Expressing
   the old-ABI virtual-call adjustment directly as object + delta is also
   significant: routing it through fPermShapes.fFilename - 0x14 reverses the
   otherwise-commutative addu. */

      /* ABI-neutral spelling of the original virtual `Draw()` call; retail SYM
         records no source vtable or array-slot pointer locals. */
#line 87 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::DrawAllDialogs()


{
  { short i; i = 0; while (DialogVisibilityList[i] != (tDialogBase *)0x0) { if (7 < i) break;

      if ((short)DialogVisibilityList[i]->ShouldTimeOut() != 0) {

        DialogVisibilityList[i]->Hide();
        if (DialogVisibilityList[i] == (tDialogBase *)0x0) {
          return;
        }
      }
      DialogVisibilityList[i]->Draw();
      i++; } } }



/* ---- tDialogBase::HideAllDialogs  [FEDIALOG.CPP:107-111] SLD-VERIFIED ---- */

#line 104 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::HideAllDialogs()


{
  for (short i = 0; i < 8; i++) {

    DialogVisibilityList[i] = (tDialogBase *)0x0;
  }
}



/* ---- tDialogBase::GetTopMostDialog  [FEDIALOG.CPP:117-120] SLD-VERIFIED ---- */

#line 114 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
tDialogBase *tDialogBase::GetTopMostDialog()


{


  return DialogVisibilityList[0];
}



/* ---- tDialogBase::Display  [FEDIALOG.CPP:126-154] SLD-VERIFIED ---- */

  /* SYM: `i` owns only the visibility-list shift, not the following setup. */
#line 123 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::Display()


{
  if (currentlyOn != 0)
    return; currentlyOn = 1;

  fFullyOpen = 0;
  ReturnValue = fDefault;








  for (short i = 7; i > 0; )
  {
    DialogVisibilityList[i] = DialogVisibilityList[i - 1];
    i--; }


  DialogVisibilityList[0] = this;
  ShouldTimeOut();
  DialogVisibilityList[0]->ShouldTimeOut();
  startTicks = FE_Ticks();
  AudioCmn_PlayFESFX(0xf);

  fFullyOpen = 0;
  fFadeText = 0x80;
}


/* ---- tDialogBase::Hide  [FEDIALOG.CPP:159-181] SLD-VERIFIED ---- */

  /* SYM: `i` lives in the block opened after the currentlyOn early-out and
     reset, at retail offset +0x28. */
#line 156 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::Hide()


{
  if (currentlyOn == 0)
    return; currentlyOn = 0;

  for (short i = 0; i < 8; i++) {

    if (DialogVisibilityList[i] == this) {

      currentlyOn = 0;
      DialogVisibilityList[i] = (tDialogBase *)0x0;
      blockmove(&DialogVisibilityList[i + 1],



                &DialogVisibilityList[i],(7 - i) * 4);
      DialogVisibilityList[7] = (tDialogBase *)0x0;



      AudioCmn_PlayFESFX(0x12);
    }
  }
}


/* ---- tDialogBase::Draw  [FEDIALOG.CPP:200-210] SLD-VERIFIED ---- */

#line 197 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::Draw()


{

  PSXDrawTransSquare(0,left,top,4,height,4);
  PSXDrawTransSquare(0,(left + width) - 4,top,4,height,4);
  PSXDrawTransSquare(0,left + 4,top,width + -8,2,4);
  PSXDrawTransSquare(0,left + 4,(top + height) - 2,width + -8,2,4);


  PSXDrawTransSquare(0,left + 4,top + 2,width + -8,height + -4,2);

  FeDraw_SetABRMode(0);
}



/* ---- tDialogBase::ProcessInput  [FEDIALOG.CPP:217-245] SLD-VERIFIED ---- */

#line 214 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBase::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &)


{






















  /* The first and third ABI parameters are unnamed in retail SYM and
     unused here; their types remain in the mangled method signature. */
  if (keyval != kInput_KeyType_AlreadyProcessed) {

    Hide();
    keyval = kInput_KeyType_AlreadyProcessed;
  }
}



/* ---- tDialogHelp::AddItem  [FEDIALOG.CPP:260-265] SLD-VERIFIED ---- */

#line 257 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogHelp::AddItem(short textID,short controllerID)


{
  if (numItems < 7) {

    text[numItems] = TextSys_Word(textID);
    cont[numItems] = controllerID;
    numItems++;
  }
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
      /* SYM-INLINE-THIS: CanContinue
         SYM-INLINE-THIS: HasFlag */
      /* SLD line 45 records the inlined CurrentMenu player argument here.
         Re-reading that accessor is the original source shape: GCC CSEs its
         value with `menu` but retains retail's a0 = s0 pointer copy. */
  /* SYM function-scope set, in 8c Def-record order: helpArray, i, newWidth,
     player.  showLeftRight/showCross/menu belong to the nested autoGenerate
     block (0x80018c60). */
  /* retail FeDialog.obj .rdata opens with an UNREFERENCED "SimpleMem" literal (0x80010238,
   * 12 bytes) right before this function's helpArray template (0x80010244) -- the same
   * dead tag string r3dcar.obj carries; the constant-false call keeps it, no code. */
struct helpKeyData {
    short text, button;
};

struct tHelpData {
    char autoGenerate;
    helpKeyData items[4];
};
#line 283 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogHelp::CalculateDimensions()


{
  if (0) textpixels("SimpleMem");

  tHelpData helpArray [1] = { { 1, { {0,0}, {0,0}, {0,0}, {0,0} } } };
  short i;
  int newWidth;
  tPlayer player;

















  FETextRender_SetFont(0);
  numItems = 0;



  AddItem(0x59,0);

  player = (tPlayer)0;
  if (specificPlayer != -1) {
    player = (tPlayer)specificPlayer;
  }
  if (helpArray[this->variant].autoGenerate != '\0')
  {
    bool showLeftRight; bool showCross; tMenu *menu; showLeftRight = false;
    menu = FEApp->CurrentMenu(player); showCross = false;




    i = 0;
    while (FEApp->CurrentMenu(player)->Item(i) != (tMenuItem *)0x0) {

      if (FEApp->fCurrentMenu[player]->fItemList[i]->IsEnabled())
      {
        if (FEApp->fCurrentMenu[player]->fItemList[i]->LeftRightFlag()) {
          showLeftRight = true;
        }
        else { showCross = true;
        }
      } i++;
    }

    if (1 < menu->GetNumberEnabledItems()) {
      AddItem(0x52,0x50);
    } if (showLeftRight) {
      AddItem(0x53,0xa0);
    } if (showCross)
    {
      if (menu->HasFlag(0x10000) || menu->HasFlag(0x20000)) { /* SYM-INLINE-THIS: HasFlag */
        AddItem(0x56,0x4000);
      }
      else { AddItem(0x55,0x4000);
      }
    }
    if (0 < FEApp->BackDepth(player)) {
      AddItem(0x54,0x1000);
    } if (menu->HasOptionsMenu()) {
      AddItem(0x57,-0x8000);
    }
    if (menu->HasFlag(0x800)) {
      AddItem(0x58,8);
    }
    else { if (menu->CanContinue()) {
        AddItem(0x56,8);
      }
      else if (menu->HasFlag(4)) {
        AddItem(0x56,8);
      }
    }
  }
  i = 0;




  while (helpArray[variant].items[i].text != 0) {
    AddItem(helpArray[variant].items[i].text,



            helpArray[variant].items[i].button);
    i++;
  }
  helpcontrollers = 0;

  PAD_update();
  { if (gPadinfo.buf[0].nopad == '\0') {
      helpcontrollers = helpcontrollers | (gPadinfo.buf[0].ID == '#' ? 2 : 1);
    } } { if (gPadinfo.buf[4].nopad == '\0') {
      helpcontrollers = helpcontrollers | (gPadinfo.buf[4].ID == '#' ? 2 : 1);
    }
  }



  i = 0; width = 0; if (0 < numItems) {
    do {
      newWidth = textpixels(text[i]);
      if (width < newWidth) {
        width = (short)newWidth;
      } i++; } while (i < numItems);
  }
  if (helpcontrollers == 3) {

    width += 0x46;
    lefttext = 0x46;
  }

  else {
    width += 0x28;
    lefttext = 0x28; }


  if (numItems < 2) {
    height = 0;
  }
  else { height = numItems * 0xf;
  }
  left = (short)((screenwidth - width) / 2);
  top = (short)((0xf0 - height) / 2);

  if (width < gHelpShapes[3].width + 0x14) {
    width = gHelpShapes[3].width + 0x14;
  }

  const long currentTicks = ticks[0]; FE_Ticks(); width += 0x14; /* DEVICE (exact-only): the raw read keeps line 139's note before the FE_Ticks pair; cse merges the inline's load (const = no record) */
  height += 10;



  if ((u_int)(currentTicks - startTicks) < 0x32)
  {
    short shapeWidth = gHelpShapes[0x2a].width * 2;
    short shapeHeight = gHelpShapes[0x2a].height * 2;

    width = shapeWidth + (short)((u_int)((width - shapeWidth) * (currentTicks - startTicks)) / 0x32);
    height = shapeHeight + (short)((u_int)((height - shapeHeight) * (currentTicks - startTicks)) / 0x32);
  }












  left = 0x1f9 - width;
  top = 0x14; }



/* ---- tDialogHelp::Draw  [FEDIALOG.CPP:459-546] SLD-VERIFIED ---- */
/* MATCH: PASS.  FRONT15 (2026-11-07): SLD tags 0 and blocks exact; SYM = retail plus one carrier (`by`).
   - `CalculateDimensions(); long ticks = FE_Ticks();` = retail's record-less FE_Ticks pair {1 {1 at +0
     (declaration-initializer inline) and the v0 -> a0 tick copy (no loadedTicks/firstTick carriers, no fences).
   - Early-return guard `if (ticks < startTicks + 0x32) { tDialogBase::Draw(); return; }` (cross-jumped into
     the final call): no kept if/then scope, so the for-scope opens at 29 after numLetters (28) as in retail.
   - `switch (helpcontrollers) { case 1: default: ... case 2: ... case 3: ... }`: gcc's 3-node case tree
     (root 2, case 1 sharing the default body) gives retail's beq 2 / slti 3 -> default / beq 3 dispatch;
     the old goto ladder + 4 LABEL records are gone.  Without `case 1:` (2 nodes) no slti: FAIL 4.
   - SYM-CODEGEN-CARRIER: by -- retail keeps (i-1)*0xf + 0xf in s0 across the two special-arm calls and
     adds 4 after `top`; written inline, fold reassociates 0xf + 4 into 0x13 (FAIL 9: u_int/long casts,
     const local, operand orders all fold); a (short) cast adds sll/sra (FAIL 2); a static inline helper
     adds an inline pair with a param record + a kept switch scope.  `by` is the only extra record.
     Next angle: a tree split_tree cannot see through that expands to the same RTL, record-less. */
#line 456 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogHelp::Draw()


{
  short i;
  short j;
  char buffer [80];
  short y;












  CalculateDimensions(); long ticks = FE_Ticks();




  if (ticks < startTicks + 0x32) { tDialogBase::Draw(); return; }





  int numLetters = (ticks - startTicks - 0x32) / 3;




  for (i = 0; i < numItems; i++) {


    if (i == 0) {
      y = top + 4;
    } else { y = top + (i - 1) * 0xf + 0x13;
    }

    if (i > 0)
    {

      int control = cont[i]; int by;
      switch (helpcontrollers) {
      case 1: default:
        FeTools_DrawPSXButton(0x41,(u_short)control,left + 0x14,

                   (i - 1) * 0xf + top + 0x13);
        break;
      case 2:
        FeTools_DrawPSXButton(0x23,(u_short)control,left + 0x14, (i - 1) * 0xf + top + 0x13);
        break;
      case 3:
        if ((control != 0xa0) && (control != 0x50) && (control != 0x40)) {

          by = (i - 1) * 0xf + 0xf; FeTools_DrawPSXButton(0x41,(u_short)control,left + 0x14, top + by + 4);
          FeTools_DrawPSXButton(0x23,(u_short)control,left + 0x28, top + by + 4);
        } else {
          FeTools_DrawPSXButton(0x41,(u_short)control,left + 0x14,
                   (i - 1) * 0xf + top + 0x13);
        } break; }
    }



    if (numLetters < (int)strlen(text[i])) {
      j = 0;
      if (numLetters > 0) { do {

          buffer[j] = text[i][j];
          j++; } while (j < numLetters);
      } buffer[numLetters] = '\0';
      FETextRender_FullText(buffer,left + lefttext,y,
                           i == 0 ? textType_PopUpTitle : textType_PopUpText, textState_Selected,0);
    }
    else {
      FETextRender_FullText(text[i],left + lefttext,y,
                           i == 0 ? textType_PopUpTitle : textType_PopUpText,

                           textState_Selected,0);
    }
  }


  tDialogBase::Draw();
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
   cascades.
   FRONT6 (2026-11-01): BYTE+SYM+SLD exact.  The three helper inlines
   (TickAge/ClampFade/AnimateOpen) carried retail-absent param/local records;
   retail = two FE_Ticks() inlines (lines 1/30), record-less clamp temps on
   line 3 and the open animation written in the body (if at 34, '{' own line). */

#line 548 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogMessageString::CalculateDimensions()


{
  int ticks;
  ticks = FE_Ticks(); const int age = ticks - 0x32; /* DEVICE (exact-only): record-less const temp keeps (ticks-50)-startTicks from folding to ticks-(startTicks+50) */ fFadeText = 0x80 - ((age - startTicks) * 0x80) / 100;
  const int fade = (0x80 < fFadeText) ? 0x80 : fFadeText; const int clamped = (fade < 0) ? 0 : fade; /* DEVICE (exact-only): record-less const clamp temps = retail's two register copies, no SYM record */ fFadeText = clamped;
  if (clamped != 0) {
    fFullyOpen = 0;
  }



  width = MaxW;


  if (MaxH == 0) {

    height = FETextRender_WordWrapHeight(MaxW + -0x28,string);
    if (height == 8) {

      Centerit = 1;
    }
    else {

      Centerit = 0;
    }
    height += 0x10;
  }
  else {

    Centerit = 0;
    height = MaxH; }
  ticks = FE_Ticks();



  if (ticks - startTicks < 0x32)
  {
    const short shapeWidth = gHelpShapes[0x2a].width * 2;   /* DEVICE (exact-only): record-less const pair = retail's empty {36 }37 scope */
    const short shapeHeight = gHelpShapes[0x2a].height * 2;

    width = shapeWidth + (short)(((width - shapeWidth) * (ticks - startTicks)) / 0x32);
    height = shapeHeight + (short)(((height - shapeHeight) * (ticks - startTicks)) / 0x32);
    fFullyOpen = 0;
  }
  else {

    fFullyOpen = 1;
  }

  left = OffsetX + (short)((screenwidth - width) / 2);
  top = OffsetY + (short)((0xf0 - height) / 2);
}



/* ---- tDialogMessageString::Draw  [FEDIALOG.CPP:607-651] SLD-VERIFIED ---- */

  /* W65-A3 (calltarget): `this->Draw()` bound to tDialogMessageString::Draw
   * itself -- INFINITE RECURSION.  Retail calls Draw__11tDialogBase; the
   * unqualified name resolves to the derived override that shadows the base's
   * (§3.23c SILENT-SHADOW, here in its same-name-override form).  Explicit
   * base scope binds the call retail makes.  REAL RUNTIME BUG. */
  /* FRONT13 (2026-11-07): BYTE+SYM+SLD exact.  Retail blocks = two root inline pairs and no if/else
   * scopes: the closed-dialog arm is an early return (its base Draw call cross-jumps into the final one),
   * the FE_Ticks read is a record-less root `const` declaration, the colour is TextDefinitionColor(8,4)
   * (pair {22, code on the fFullyOpen line), and the centred x is plain `(u_short)left + ((short)width >> 1)`. */
#line 604 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogMessageString::Draw()


{
  int col;
  RECT r;



  CalculateDimensions(); const int now = FE_Ticks();







  if (now < startTicks + 0x32) {



    fFullyOpen = 0; tDialogBase::Draw(); return;
  }
  if (fFadeText != 0) {
      fFullyOpen = 0;
    }


    col = CalcFadeVal(TextDefinitionColor(8,4),fFadeText);


    r.x = left + 0x11; r.y = top + 10; r.w = width + -0x14; r.h = height - ((u_short)reservedheight + 8);

    FETextRender_SetABR(1,true);
    if (Centerit != 0) {
      FETextRender_FullTextRGB(string,
                 (short)((u_short)left +
                          ((short)width >> 1)),top + 8,col,'\0',2);
    }
    else {

      FETextRender_WordWrapTextRGB(string,r,col);
    }
    FETextRender_SetABR(0,false);


  tDialogBase::Draw();
}




/* ---- tDialogBackUpOnly::ProcessInput  [FEDIALOG.CPP:654-670] SLD-VERIFIED ---- */

/* SYM: FCN VOID, no locals (the "iVar1" return funnel was a Ghidra fiction --
   the oracle never sets $v0).  SLD: 655 guard / 658 key test / 660 the
   AlreadyProcessed store / 664 Hide() -- so Hide is the ELSE arm (source
   order puts the store BEFORE it), which is what lays it out-of-line. */
#line 650 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogBackUpOnly::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &)


{
  if ((specificPlayer == kPlayerBoth) || (fromPlayer == (tPlayer)specificPlayer)) {


    if (keyval != kInput_KeyType_Triangle) { if (keyval != kInput_KeyType_Circle) {

        keyval = kInput_KeyType_AlreadyProcessed;
      }
    }
    else {
      ((tDialogBase *)this)->Hide();
    }
  }

  return; /* DEVICE (exact-only): trailing return places the 14 note; '}' 16 = retail epilogue */

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
  /* FRONT5: CalculateDimensions/ProcessInput are called directly (retail SLD has
     no wrapper-inline blocks at lines 4/48; bytes identical). */
  /* SYM: keyVal, command and debounce all live in the outer-loop block that
     opens at 0x80019848; `i` is one level further in (0x80019858). */
  /* The two SLD `player` entries are inlined formals sharing $s1 with `i`.
     FRONT13 (2026-11-07): BYTE+SYM+SLD exact.  Both `player` records are CurrentMenu(tPlayer) params (715 test,
     717 call); the 715 IsVisible pair has no `this` record (address folded into the load).  `{` on its own
     line after each if gives retail's then-scopes {714/{716/{723. */
#line 681 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
short tDialogInteractive::Run()


{
  fCurrentlyRunning = 1;

  ((tDialogBase *)this)->Display();
  CalculateDimensions();
  ReadyToReturnValue = 0;
  while (ReadyToReturnValue == 0) {
    tInputKeyType keyVal [2];
    tMenuCommand command;

    u_long debounce = -1; command.type = kMenu_Command_None;












    for(int i = 0; i < 2; i++) {

      keyVal[i] = FEInput_GetKeyFromPlayer((tPlayer)i,debounce);
      if (keyVal[i] == kInput_KeyType_NoKey) {
        keyVal[i] = kInput_KeyType_AlreadyProcessed;
      }
      if (keyVal[i] == kInput_KeyType_Circle)
      {
        if (!((tDialogBase *)&FEApp->helpPopup)->IsVisible() && FEApp->CurrentMenu((tPlayer)i) != (tMenu *)0x0)
        {
          FEApp->CurrentMenu((tPlayer)i)->ProcessInput((tPlayer)i,keyVal[i],command);
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }

      if (keyVal[i] != kInput_KeyType_AlreadyProcessed)   /* SYM-INLINE-THIS: IsVisible */
      {
        if (((tDialogBase *)&FEApp->helpPopup)->IsVisible()) {

          ((tDialogBase *)&FEApp->helpPopup)->Hide();
          keyVal[i] = kInput_KeyType_AlreadyProcessed;
        }
      }

      if (keyVal[i] != kInput_KeyType_NoKey) {
        ProcessInput((tPlayer)i,keyVal[i],command);
      } }
    FEApp->Redraw();
  }
  AudioCmn_PlayFESFX(0);
  ((tDialogBase *)this)->Hide();
  FEApp->Redraw();


  fCurrentlyRunning = 0;
  return ReturnValue;
}



/* ---- tDialogYesNo::CalculateDimensions  [FEDIALOG.CPP:748-759] SLD-VERIFIED ---- */

  /* MATCH (2026-08-26): 46/46 and zero named locals, matching SYM.  The
     elapsed accessor replaces the former iVar2 carrier while preserving the
     retail in-place height update and merged trailing store. */
#line 745 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogYesNo::CalculateDimensions()


{
  tDialogMessageString::CalculateDimensions();
  if (MaxH == 0)
  { const int now = FE_Ticks(); /* DEVICE (exact-only): retail reads ticks once on line 3 (one FE_Ticks inline block); const temp, no SYM record */


    if (now - startTicks < 0x32) {
      height = height + (short)(((now - startTicks) * 0xf) / 0x32);
    }
    else { height = height + 0xf;
    } top = OffsetY + (short)((0xf0 - height) / 2);
    reservedheight = 0xf;
  }
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
  Centerit = 0;
  fFullyOpen = 0;
  timeOutTicks = 0;
  fFadeText = 0x80;
}

/* explicit (not synthesized) so that derived constructors store this class's vtable on the way, as retail does */
inline tDialogInteractive::tDialogInteractive()
{
  /* retail zeroes timeOutTicks THREE times in tDialogYesNo's ctor: once per inlined constructor level
     (MessageString, Interactive, YesNo); the vtable stores between them keep gcc from folding the repeats */
  timeOutTicks = 0;
  fCurrentlyRunning = 0;   /* retail zeroes it (+156) BEFORE tDialogYesNo's vtable store: done at this class's level */
}


#line 765 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
tDialogYesNo::tDialogYesNo() : tDialogInteractive() {
  ReturnValue = 0;
  ReadyToReturnValue = 0;
}



/* ---- tDialogYesNo::Draw  [FEDIALOG.CPP:773-815] SLD-VERIFIED ---- */
/* MATCH (2026-08-26): exact 98/98 and declaration-clean against SYM's sole
   locals `i`, `x`, `y`, and `col`.  CalculateDimensionsVirtual removes the raw
   vtable alias.  natural `yesnowords[i]` produces the retail pointer induction.  The SLD/IDA
   statement shape `y = top + height - 11` remains one expression, scheduling
   the subtraction in SetABR's delay slot and the short cast in TextSys_Word's
   delay slot.
   FRONT13 (2026-11-07): SYM records + blocks exact.  Retail's FE_Ticks pair is a root SIBLING of the
   if-scope (record-less `const int now = FE_Ticks();` declaration: inline code takes the previous note);
   `{` on its own line gives the then-scope {15; one TextStateDef inline (state select + lbu +51 inside,
   kRGBVals outside, kRGBVals expanded first = retail s7/s6) replaces the two helper inlines whose
   params carried retail-absent dialog/item records.  Left: retail tags the kRGBVals/CalcFadeVal part
   one line after the inline code (26/27); every one-statement layout tags both on the `;` line. */

#line 770 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogYesNo::Draw()


{
  int i; int x; int y;
  int col;

  CalculateDimensions();



  if (fFadeText != 0) {
    fFullyOpen = 0;
  } const int now = FE_Ticks();


  if (0x31 < now - startTicks)
  {
    x = left + (((u_short)width << 0x10) >> 0x12);








    for (i = 0; i < 2; i++) {

      const int sel = (i == ReturnValue) ? 1 : 2;
      col = CalcFadeVal(kRGBVals[TextStateDef(8, sel)], fFadeText);

      y = top + height - 0xb;
      FETextRender_SetABR(1,true);
      FETextRender_FullTextRGB(TextSys_Word(yesnowords[i]),x,y,col,'\0',2);



      FETextRender_SetABR(0,false);


      x += ((int)((u_int)(u_short)width << 0x10) >> 0x11);
    }
  }

  tDialogMessageString::Draw();
}



/* ---- tDialogYesNo::ProcessInput  [FEDIALOG.CPP:823-853] SLD-VERIFIED ---- */

/* SLD: 824 player guard / 827 fFullyOpen guard (own line, own block) /
   831 the dispatch (a real switch -- gcc balance_case_nodes builds the
   ==0x800 root + <0x801 bound test tree over 4 case labels) /
   834-836, 838-840, 844-846 the three arms in ascending source order.
   FRONT13 (2026-11-07): BYTE+SYM+SLD exact: both guards are early returns (retail has no player-if
   scope; the fFullyOpen guard's if-scope ends 828 and holds the IsFullyOpen inline pair + its
   tDialogMessageString `this` record); the switch sits at root, epilogue on the fn '}'. */
#line 820 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogYesNo::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command)


{
  if ((specificPlayer != kPlayerBoth) && (fromPlayer != (tPlayer)specificPlayer))
    return;

    if (!IsFullyOpen())
      return;


      switch (keyVal) {

      case kInput_KeyType_Left:
        AudioCmn_PlayFESFX(5);
        ReturnValue = 1;
        break;
      case kInput_KeyType_Right:
        AudioCmn_PlayFESFX(6);
        ReturnValue = 0;
        break;

      case kInput_KeyType_Cross:
      case kInput_KeyType_Start:
        AudioCmn_PlayFESFX(0);
        this->ReadyToReturnValue = 1;
        ((tDialogBase *)this)->Hide();


        break;
      }


}



/* ---- tDialogYesNoMem::ProcessInput  [FEDIALOG.CPP:859-901] SLD-VERIFIED ---- */

    /* W65-A3 (calltarget): unqualified `this->ProcessInput(...)` bound to THIS
     * override -- INFINITE RECURSION.  Retail calls
     * ProcessInput__12tDialogYesNo...; explicit base scope binds it. REAL BUG. */
#line 855 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogYesNoMem::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command
               )


{
  int card;
  bool fMemCardGone;
  card = CURRENTPLAYER * 4 + 1;

  fMemCardGone = false;



  const int cardEvents = MCRD_handlecardevents(card); /* DEVICE (exact-only): retail tags the call (9) apart from the dispatch (15); the const temp has no SYM record */





  switch (cardEvents) {
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



  CARDINFO_def *const cardInfo = MCRD_getcard(card); /* DEVICE (exact-only): call 30 / test 31 as retail; const temp, no SYM record */
  if (cardInfo->status == -1) {

    fMemCardGone = true;
  }

  if (fMemCardGone) {

    ReadyToReturnValue = 1;
    ReturnValue = -1;
  }
  else {
    tDialogYesNo::ProcessInput(fromPlayer,keyVal,command);
  }
}



/* ---- tDialogYesNoTri::ProcessInput  [FEDIALOG.CPP:909-916] SLD-VERIFIED ---- */

#line 905 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogYesNoTri::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyVal,tMenuCommand &command
               )


{
  if (keyVal == kInput_KeyType_Triangle) {

    ReadyToReturnValue = 1;
    ReturnValue = -1;
  }
  else {
    tDialogYesNo::ProcessInput(fromPlayer,keyVal,command);
  }
}



/* ---- tDialogNoInputMessage::ProcessInput  [FEDIALOG.CPP:921-931] SLD-VERIFIED ---- */

#line 917 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.CPP"
void tDialogNoInputMessage::ProcessInput(tPlayer,tInputKeyType &,
               tMenuCommand &)


{









}
