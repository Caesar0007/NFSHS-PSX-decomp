/* frontend/common/fescreen.cpp -- RECONSTRUCTED (tScreen BASE class; C++ TU)
 *   27 methods of tScreen (the FE screen base): ctor/dtor, async shape (perm+swap) load/upload/
 *   free pipeline, screen-fade transitions, loading-text, and the virtual-dispatch entrypoints
 *   (Draw->DrawBackground/DrawForeground, Initialize/PreLoad->GetShapeInfo) via the manual _vf
 *   vtable. tShapeInformation& ref params per mangled names. Phantoms (lost DrawShapeExtended
 *   coords, void DisplayLoadingText, PreLoad numSwapShapes/swapFileName coalescing) m2c-resolved.
 */
#include "fescreen.h"

/* ---- FEScreen.obj globals ---- */
int tScreen::fSuppressLoadingText;   /* @0x800517c8 (deferred, declared first via the class) */
tTexture_ShapeInfo *gCurrentShapes;   /* @0x800517cc; SYM EXT */


/* ---- tScreen::DisplayLoadingText  [FESCREEN.CPP:36-67] SLD-VERIFIED ---- */

void tScreen::DisplayLoadingText()

{
  /* SYM 8c: exactly TWO locals -- oldIsBg (class REG $12 = $s2, type INT) and
     i (class REG $10 = $s0, type SHORT); no `string`/`iVar2` temporaries.
     SLD statements: 37 / 40 / 43 47 48 / 51 53 59 60 63 64 65 / 66 67.
     Line 47 and line 66 are each ONE chained assignment (drawenv[0].isbg =
     drawenv[1].isbg = V), which is why retail computes the view address once
     and emits the two `sb`s back to back, [1] before [0].  Line 60 is one
     statement: the two calls nest inside PSXDrawSquare's 4th argument. */
  int oldIsBg;
  short i;

  if (tScreen::fSuppressLoadingText != 0) {                               /* 37 */
    tScreen::fSuppressLoadingText = 0;                                    /* 40 */
  }
  else {
    oldIsBg = Draw_gView[Draw_gPlayer1View].drawenv[0].isbg;              /* 43 */
    Draw_gView[Draw_gPlayer1View].drawenv[0].isbg =
      Draw_gView[Draw_gPlayer1View].drawenv[1].isbg = '\0';               /* 47 */
    for (i = 0; i < 2; i = i + 1) {                                       /* 48 */
      Draw_StartFrameRender();                                            /* 51 */
      Draw_StartRenderingView(Draw_gPlayer1View);                         /* 53 */
      FETextRender_MenuTextPositionedJustify(0x27d,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo); /* 59 */
      PSXDrawSquare(0,0x1e0,0xdc,-textpixels(TextSys_Word(0x27d)) - 5,7); /* 60 */
      Draw_StopRenderingView(Draw_gPlayer1View);                          /* 63 */
      Draw_StopFrameRender();                                             /* 64 */
    }
    Draw_gView[Draw_gPlayer1View].drawenv[0].isbg =
      Draw_gView[Draw_gPlayer1View].drawenv[1].isbg = (u_char)oldIsBg;    /* 66 */
  }
  return;
}



/* ---- tScreen::GoNonInterlaced  [FESCREEN.CPP:144-173] SLD-VERIFIED ---- */

/* MATCH (2026-08-03, 11->1; source-only W79 2->PASS 52/52): retail does not write literal 240 to every
   halfword. It stores `screenheight = 240`, reloads the low half once for
   the three gEnviro heights/first drawenv height, then reloads it for the
   second drawenv. GCC 2.8.0's scheduler otherwise moves the first load below
   the two hardware-environment stores; a shared typed environment view fixes
   that ordering. A `u_short` carrier restores retail's $a1/$a2 allocation and
   removes GCC's redundant post-lhu `andi`.
   W79 removes the output-less fence: GCC treats it as implicitly volatile, so
   its scheduling barrier pulled the independent ra save four slots early.
   Restoring the exact SLD statement order supplies the needed height lifetime
   naturally: gEnviro[0] y/h/screen.h (153-155), isinter (156), gEnviro[1]
   y/screen.h (157-158), isinter (159), then the view setup (161).  The lhu
   stays before both byte stores while the ra save sinks to retail's
   slot.  No asm/post-cc1 aid; strict_branch clean. */

void tScreen::GoNonInterlaced()

{
  /* Retail's function block has no locals. Const use-site snapshots preserve
     the six omitted pointer/height value webs and all 52 instructions. The
     one remaining named carrier is viewTable: direct inlining costs 26 diffs,
     while a const declaration at either site swaps $a1/$a2 (18 diffs).
     Its private original spelling remains unrecoverable from SYM. */
  /* SYM-CODEGEN-CARRIER: viewTable, tested against the raw byte oracle. */
  Draw_tView *viewTable;
  /* SYM-CODEGEN-CARRIER: playerViewIndex -- inlining the index address: 8 schedule diffs. */
  int *playerViewIndex;
  screenheight = 0xf0;
  dflip *const displayEnv = gEnviro;
  const u_short displayHeight = *(u_short *)&screenheight;
  gEnviro[0].disp.disp.y = 0x100;
  gEnviro[0].disp.disp.h = displayHeight;
  gEnviro[0].disp.screen.h = displayHeight;
  displayEnv[0].disp.isinter = '\0';
  gEnviro[1].disp.disp.y = 0;
  gEnviro[1].disp.screen.h = displayHeight;
  displayEnv[1].disp.isinter = '\0';
  viewTable = Draw_gView;
  playerViewIndex = &Draw_gPlayer1View;
  Draw_tView *const frontView = viewTable + *playerViewIndex;
  frontView->drawenv[0].dfe = '\0';
  Draw_tView *const backView = viewTable + *playerViewIndex;
  frontView->drawenv[0].clip.y = 0;
  frontView->drawenv[0].clip.h = displayHeight;
  frontView->drawenv[0].ofs[0] = 0;
  frontView->drawenv[0].ofs[1] = 0;
  const short viewHeight = (short)screenheight;
  backView->drawenv[1].clip.y = 0x100;
  backView->drawenv[1].ofs[0] = 0;
  backView->drawenv[1].ofs[1] = 0x100;
  backView->drawenv[1].dfe = '\0';
  backView->drawenv[1].clip.h = viewHeight;
  DrawSync(0);
  VSync(0);
  return;
}



/* ---- tScreen::DrawBackgroundImage  [FESCREEN.CPP:185-197] SLD-VERIFIED ---- */
/* Retail SLD separates drawFlags.flip_axis, custom_shapes, loop head,
   first draw, flip guard and second draw across relative lines 4/5/7/9/10/11. */

void tScreen::DrawBackgroundImage(int startShape,int numShapes,tTexture_ShapeInfo *shapes,int flip_axis)

{
  /* SYM ORDER (W86-S2): the 8c Def rows read drawFlags, i. */
  tDrawShapeExtended drawFlags;
  int i;
  drawFlags.flip_axis = (short)flip_axis;
  drawFlags.custom_shapes = shapes;

  for (i = startShape; i < startShape + numShapes; i = i + 1) {

    DrawShapeExtended(i,0x200,0,0,(int)this->fScreenFadeVal,0,&drawFlags);
    if (0 < flip_axis)
      DrawShapeExtended(i,0x260,0,0,(int)this->fScreenFadeVal,0,&drawFlags);
  }
}



/* ---- tScreen::AsyncLoadPermanentShapeFile  [FESCREEN.CPP:201-202] SLD-VERIFIED ---- */

void tScreen::AsyncLoadPermanentShapeFile(char *fileName)

{
  this->AsyncLoadShapeFile(fileName,this->fPermShapes);
}



/* ---- tScreen::AsyncLoadSwapShapeFile  [FESCREEN.CPP:206-214] SLD-VERIFIED ---- */

void tScreen::AsyncLoadSwapShapeFile(char *fileName)

{
  char buffer [32];

  if (fileName != 0) {

    sprintf(buffer,"z%s",fileName);
    this->AsyncLoadShapeFile(buffer,this->fSwapShapes);
  } else {
    this->AsyncLoadShapeFile((char *)0x0,this->fSwapShapes);
  }
}



/* ---- tScreen::IsShapeFileLoaded  [FESCREEN.CPP:218-270] SLD-VERIFIED ---- */

bool tScreen::IsShapeFileLoaded(tShapeInformation &shapes)

{
  /* SYM ORDER (W86-S2): the 8c Def rows read result, async_status, bogus. */
  bool result;
  int async_status;
  char *bogus;

  /* MATCH: ONE result var (retail's $s1, set to 1 in the entry branch's delay
     slot) with a single return -- the per-arm `pvVar3 = 0` funnel Ghidra
     produced duplicates the tail.  getasyncreadadr takes ONE arg (the oracle
     sets only $a0).  SYM-CONFORM (2026-08-16, PASS retained): the three
     retail locals are `BOOL result`, `int async_status`, and `char *bogus`;
     BOOL is the four-byte EA typedef, not native C++ bool. */
  result = 1;
  if (shapes.async_handle != 0) {
    async_status = getasyncreadstatus(shapes.async_handle);
    if (0 < async_status) {
      if (shapes.fDestFile == (char *)0x0) {
        shapes.fFile = (char *)getasyncreadadr(shapes.async_handle);
      }
      else {
        shapes.fFile = shapes.fDestFile;
      }
      shapes.async_handle = 0;
      if ((shapes.fFile != (char *)0x0) && (shapes.fLoadCancelled != 0)) {
        if (shapes.fDestFile == (char *)0x0) {
          purgememadr(shapes.fFile);
        }
        shapes.fFile = (char *)0x0;
      }
    }
    else {
      if (async_status == -1) {
        bogus = (char *)getasyncreadadr(shapes.async_handle);
        if (bogus != (char *)0x0) {
          purgememadr(bogus);
        }
        this->AsyncLoadShapeFile(shapes.fFilename,shapes);
        result = 0;
      }
      else if (async_status == -2) {
        this->AsyncLoadShapeFile(shapes.fFilename,shapes);
        result = 0;
      }
      else {
        result = 0;
      }
    }
    }
  else {
    if (shapes.fLoadCancelled != 0) {
      if (shapes.fFile != (char *)0x0) {
        if (shapes.fDestFile == (char *)0x0) {
          purgememadr(shapes.fFile);
        }
        shapes.fFile = (char *)0x0;
      }
      shapes.fLoadCancelled = 0;
      this->AsyncLoadShapeFile(shapes.fFilename,shapes);
      this->IsShapeFileLoaded(shapes);
      result = 0;
    }
    }
  return result;
}




/* ---- tScreen::UploadPermanentShapes  [FESCREEN.CPP:284-286] SLD-VERIFIED ---- */

void tScreen::UploadPermanentShapes(int numPermanentShapes)

{
  this->UploadShapes(this->fPermShapes,0,0,(short)numPermanentShapes,0);
  gCurrentShapes = (this->fPermShapes).fShapes;
}



/* ---- tScreen::UploadSwapShapes  [FESCREEN.CPP:290-292] SLD-VERIFIED ---- */

void tScreen::UploadSwapShapes(int numSwapShapes)

{

  this->UploadShapes(this->fSwapShapes,0,0,(short)numSwapShapes,0);
}



/* ---- tScreen::GetShapeInfo  [FESCREEN.CPP:321-326] SLD-VERIFIED ---- */

void tScreen::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{



  numPermShapes = numSwapShapes = 0;
  *permFileName = *swapFileName = (char *)0x0;
}



/* ---- tScreen::ctor  [FESCREEN.CPP:332-337] SLD-VERIFIED ---- */

tScreen::tScreen()

{
  (this->fPermShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  this->InitializeShapes(this->fPermShapes,0);
  (this->fSwapShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  this->InitializeShapes(this->fSwapShapes,0);
  this->fScreenFadeVal = 0;
}



/* ---- tScreen::dtor  [FESCREEN.CPP:341-341] SLD-VERIFIED ---- */

tScreen::~tScreen()

{
}



/* ---- tScreen::Initialize  [FESCREEN.CPP:345-377] SLD-VERIFIED ---- */

void tScreen::Initialize()

{
  /* MATCH: IDA's retail allocation and the raw call site show no implicit
     `this` setup for GoNonInterlaced; that routine also reads no object state.
     Calling its class-qualified symbol through the static-member-shaped alias
     removes the spurious a0 copy and leaves both final stores based on s1.
     Probe: 6 -> PASS 61/61. */
  /* SYM 8c: the ONLY local is `shapesLoaded` (class REG $10 = $s0, type BOOL);
     `this` is REGPARM $11 = $s1 and the frame carries just $s0/$s1/$ra
     (mask $80030000, fsize 56).  So there is NO separate pvVar2 -- ONE variable
     holds both the perm-file result and the &&-combined flag, which is why gcc
     reuses $s0. `BOOL` is the retail spelling and aliases `int`; the explicit
     cast from the currently misdeclared `void *` return preserves retail's raw
     move exactly. */
  /* SYM ORDER (W86-S2): the 8c Def rows read numPermShapes, numSwapShapes,
     permFileName, swapFileName, shapesLoaded. */
  short numPermShapes;
  short numSwapShapes;
  char *permFileName;
  char *swapFileName;
  bool shapesLoaded;

  this->DisplayLoadingText();
  this->PreLoad();
  this->GetShapeInfo(numPermShapes,numSwapShapes,&permFileName,&swapFileName);
  do {
    FeAudio_systemtask(0);
    shapesLoaded = this->IsShapeFileLoaded(this->fPermShapes);        /* 363 */
    if ((this->fPermShapes).fFile != (char *)0x0) {                   /* 364 */
      this->UploadPermanentShapes((int)numPermShapes);                /* 365 */
    }
    /* SLD line 367 is ONE statement -- retail's `&&` funnel ($v1 default 0, the
       call, sltu into $v1) whose result is copied back into $s0 at 368. */
    shapesLoaded = shapesLoaded && this->IsShapeFileLoaded(this->fSwapShapes) != 0;
    if ((this->fSwapShapes).fFile != (char *)0x0) {                   /* 368 */
      this->UploadSwapShapes((int)numSwapShapes);                     /* 369 */
    }
  } while (!shapesLoaded);
  (this->fPermShapes).fNumShapes = numPermShapes;
  (this->fSwapShapes).fNumShapes = numSwapShapes;
  this->GoNonInterlaced();
  return;
}



/* ---- tScreen::Cleanup  [FESCREEN.CPP:385-392] SLD-VERIFIED ---- */

void tScreen::Cleanup()

{
  
  this->AsyncLoadPermanentShapeFile((char *)0x0);
  this->AsyncLoadSwapShapeFile((char *)0x0);


  this->FreeShapes(this->fPermShapes);
  this->FreeShapes(this->fSwapShapes);
}



/* ---- tScreen::Draw  [FESCREEN.CPP:397-401] SLD-VERIFIED ---- */

void tScreen::Draw(bool drawBackground)

{
  if (drawBackground != 0) {
    this->DrawBackground();
  } else {
    this->DrawForeground();
  }
}



/* ---- tScreen::AsyncLoadShapeFile  [FESCREEN.CPP:409-451] SLD-VERIFIED ---- */

void tScreen::AsyncLoadShapeFile(char *name,tShapeInformation &data)

{
  char buffer [128];
  
  if ((name == (char *)0x0) && (data.async_handle != 0)) {
    cancelasyncload(data.async_handle);
    data.async_handle = 0;
  }
  this->CancelAsyncLoad(data);
  if (data.fFile != (char *)0x0) {
    if (data.fDestFile == (char *)0x0) {
      purgememadr(data.fFile);
    }
    data.fFile = (char *)0x0;
  }
  data.fFlags = data.fFlags & 0xfffe;
  if (name != (char *)0x0) {
    sprintf(data.fFilename,"%s",name);
    sprintf(buffer,"%s%s.psh",Paths_Paths[0x20],name);
    if (data.fLoadCancelled == 0) {
      data.fLoadCancelled = 0;
      if (data.fDestFile != (char *)0x0) {
        data.async_handle = asyncloadfileat(buffer,data.fDestFile);
      }
      else {
        data.async_handle = asyncloadfile(buffer,(void *)0x10);
      }
    }
  }
  return;
}



/* ---- tScreen::CancelAsyncLoad  [FESCREEN.CPP:459-479] SLD-VERIFIED ---- */
/* The inner purge is unbraced in the retail line partition. The status
   call/compare pair alone remains ambiguous: an explicit const snapshot
   aligns its two SLD tags but creates two non-retail debug scopes. */

void tScreen::CancelAsyncLoad(tShapeInformation &data)

{


  if (data.async_handle != 0) {

    if (getasyncreadstatus(data.async_handle) == 0) {

      data.fLoadCancelled = 1;
    }
    else {

      if (data.fDestFile == (char *)0x0) {
        data.fFile = getasyncreadadr(data.async_handle);
      }
      if (data.fFile != (char *)0x0) {

        if (data.fDestFile == (char *)0x0)
          purgememadr(data.fFile);
        data.fFile = (char *)0x0;
      }
      data.async_handle = 0;
    }
  }
}



/* ---- tScreen::InitializeShapes  [FESCREEN.CPP:485-509] SLD-VERIFIED ---- */
/* Retail SLD places the loop head on +23 and its final store/function end
   on +24. The compact closing brace records that line span, not a claim
   that the original punctuation or non-emitting comments are known. */

void tScreen::InitializeShapes(tShapeInformation &data,u_int numShapes)

{
  u_short i;



  if (data.fShapes != (tTexture_ShapeInfo *)0x0) {


    purgememadr(data.fShapes);
    data.fShapes = (tTexture_ShapeInfo *)0x0;
  }


  data.fFlags = 0;
  data.fNumShapes = (u_short)numShapes;
  data.async_handle = 0;
  data.fFile = (char *)0x0;
  data.fDestFile = (char *)0x0;
  data.fLoadCancelled = 0;

  if (numShapes == 0) return;

  data.fShapes = (tTexture_ShapeInfo *)reservememadr("Shapes",numShapes << 5,0);
  for (i = 0; i < numShapes; i = i + 1)
    data.fShapes[i].clutID = 0; }



/* ---- tScreen::FreeShapes  [FESCREEN.CPP:514-555] SLD-VERIFIED ---- */

void tScreen::FreeShapes(tShapeInformation &data)

{
  /* SYM ORDER (W86-S2): the 8c Def rows read i, async_status. */
  short i;
  int async_status;

  this->CancelAsyncLoad(data);
  /* MATCH: a plain top-tested `while` -- gcc rotates it (entry test + bottom
     bne) and LICMs the -1/-2 sentinels into callee-saved regs, which the
     do{}while(true)+early-return shape does not.  SYM-CONFORM (2026-08-16):
     restored the original `int async_status` name; PASS remains 88/88. */
  while (data.async_handle != 0) {
    async_status = getasyncreadstatus(data.async_handle);
    if ((0 < async_status) || (async_status == -1)) {
      if (data.fDestFile == (char *)0x0) {
        data.fFile = getasyncreadadr(data.async_handle);
      }
      else {
        data.fFile = (char *)0x0;
      }
      data.async_handle = 0;
    }
    else if (async_status == -2) {
      data.async_handle = 0;
    }
    FeAudio_systemtask(0);
  }
  if (data.fFile != (char *)0x0) {
    if (data.fDestFile == (char *)0x0) {
      purgememadr(data.fFile);
    }
    data.fFile = (char *)0x0;
  }
  if (data.fShapes != (tTexture_ShapeInfo *)0x0) {
    if (data.fNumShapes != 0) {
      i = 0;
      do {
        if (*(int *)&data.fShapes[i].clutID != 0) {
          Texture_MenuReleaseClutId(data.fShapes[i].clutID);
        }
        i = i + 1;
      } while (i < (int)(u_int)data.fNumShapes);
    }
    purgememadr(data.fShapes);
    data.fShapes = (tTexture_ShapeInfo *)0x0;
  }
  return;
}



/* ---- tScreen::UploadShapes  [FESCREEN.CPP:559-597] SLD-VERIFIED ---- */

void tScreen::UploadShapes(tShapeInformation &data,short x,short y,short numShapes,short index)

{
  /* SYM 8c: the ONLY local is `i` (class REG $10 = $s0) -- ONE counter shared by
     BOTH loops, indexed as [i + index]; the two-variable iVar1/iVar2 walk cost a
     second induction pseudo.  SLD statements: 563 571 572 / 576 578 580 581 583 /
     585 / 588 589 / 591 594 595 596 597. */
  int i;

  if (data.fFile != (char *)0x0) {                                       /* 563 */
    if (numShapes == 0) {                                                /* 571 */
      numShapes = data.fNumShapes;                                       /* 572 */
    }
    for (i = 0; i < numShapes; i = i + 1) {                              /* 576 */
      if (data.fShapes[i + index].clutID != 0) {                         /* 578 */
        Texture_MenuReleaseClutId((short)data.fShapes[i + index].clutID); /* 580 */
        data.fShapes[i + index].clutID = 0;                              /* 581 */
      }
    }
    data.fFlags = data.fFlags & 0xfffe;                                   /* 585 */
    for (i = 0; i < numShapes; i = i + 1) {                               /* 588 */
      FETexture_LoadPmxAtOffset(data.fFile,i,&data.fShapes[i + index],(int)y,(int)x); /* 589 */
    }
    data.fFlags = data.fFlags | 1;                                        /* 591 */
    if (data.fDestFile == (char *)0x0) {                                  /* 594 */
      purgememadr(data.fFile);                                            /* 595 */
    }
    data.fFile = (char *)0x0;                                             /* 596 */
  }
  return;
}



/* ---- tScreen::PreLoad  [FESCREEN.CPP:600-613] SLD-VERIFIED ---- */
/* GetShapeInfo is the virtual slot-1 dispatch; native SYM owns the four
   outgoing shape-count and filename stack locals. */
void tScreen::PreLoad()
{
  short numPermShapes;
  short numSwapShapes;
  char *permFileName;
  char *swapFileName;
  this->GetShapeInfo(numPermShapes,numSwapShapes,&permFileName,&swapFileName);


  this->InitializeShapes(this->fPermShapes,(u_int)(int)numPermShapes);
  this->InitializeShapes(this->fSwapShapes,(u_int)(int)numSwapShapes);


  this->AsyncLoadPermanentShapeFile(permFileName);
  this->AsyncLoadSwapShapeFile(swapFileName);
}

/* ---- tScreen::TransitionOff  [FESCREEN.CPP:621-625] SYM/SLD-REVIEWED; emitted partitions open (P889 SLD_RECEIPT.md) ---- */
/* Both transition setters have two zero-length nested retail scopes. Their
 * compile-time constant names below describe values, not original spelling. */

void tScreen::TransitionOff(tScreen_TransitionType type,tMenu *)

{
  /* ABI type/arity retained; this unused parameter's original name is
     unknown because optimized SYM has no corresponding named record. */
  {
    const int fade = 0;
    {
      const int transitionOff = 1;
      this->fInternalScreenFadeVal = this->fScreenFadeVal = fade;
      this->fTransitionOff = transitionOff;
      this->fTransitionTicks = ticks;
      return;
    }
  }
}



/* ---- tScreen::TransitionOn  [FESCREEN.CPP:629-633] SYM/SLD-REVIEWED; emitted partitions open (P889 SLD_RECEIPT.md) ---- */

void tScreen::TransitionOn(tScreen_TransitionType type,tMenu *)

{
  /* ABI type/arity retained; this unused parameter's original name is
     unknown because optimized SYM has no corresponding named record. */
  {
    const int fade = 0x80;
    {
      const int transitionOff = 0;
      this->fInternalScreenFadeVal = this->fScreenFadeVal = fade;
      this->fTransitionOff = transitionOff;
      this->fTransitionTicks = ticks;
      return;
    }
  }
}



/* ---- tScreen::UpdateTransition  [FESCREEN.CPP:637-646] SLD-VERIFIED ---- */

void tScreen::UpdateTransition()

{
  const int transitionValue = this->fInternalScreenFadeVal +
      (this->fTransitionOff == 0 ? -0xc : 0xc);
  this->fInternalScreenFadeVal = transitionValue;
  const int lowerClamped = transitionValue < -0x32 ? -0x32 : transitionValue;
  const int fadeValue = 0x96 < lowerClamped ? 0x96 : lowerClamped;
  this->fInternalScreenFadeVal = fadeValue;
  this->fScreenFadeVal = (short)this->fInternalScreenFadeVal;
  if (this->fScreenFadeVal < 0) {
    this->fScreenFadeVal = 0;
    return;
  }
  if (0x80 < this->fScreenFadeVal) {
    this->fScreenFadeVal = 0x80;
  }
  return;
}



/* ---- tScreen::TransitionIsFinished  [FESCREEN.CPP:651-652] SLD-VERIFIED ---- */

bool tScreen::TransitionIsFinished()

{
  return ((this->fInternalScreenFadeVal + 0x18U < 0xa7) ^ 1);
}



/* ---- tScreen::ProcessInput  [FESCREEN.CPP:663-665] SLD-VERIFIED ---- */

void tScreen::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  ; /* Original body has no emitted operation; retain its source statement line. */
}



/* ---- tScreen::DrawForeground  [FESCREEN.H:97] SLD-HDR-INLINE ---- */

void tScreen::DrawForeground()

{
  return;
}



/* ---- tScreen::DrawBackground  [FESCREEN.H:96] SLD-HDR-INLINE ---- */

void tScreen::DrawBackground()

{
  
  return;
}



/* end of fescreen.cpp */
