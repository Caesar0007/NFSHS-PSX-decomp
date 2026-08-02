/* frontend/common/feapp.cpp -- RECONSTRUCTED (NFS4 FE application core; C++ TU)
 *   14 fns: tFEApplication ctor/dtor + dialog setup, FE main loop, video/movie cycling.
 *   Member defs; base ctors via init-lists; manual _vf vtable init.
 */
#include "../../lib/nfs4_new.h"
#include "feapp.h"

/* ---- FEApp.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; types match the
   feapp_externs.h decls all FE TUs consume). FEApp = the global FE application pointer. ---- */
int             currentVideo;     /* FE play-movie index (SYM STAT; externed as shared int) */
int             gLargestUnused;   /* @0x800514b8  largest unused heap block (SYM u_long, extern int) */
tFEApplication *FEApp;            /* @0x800514c0  global FE application pointer */


/* ---- tFEApplication::ctor  [FEAPP.CPP:89-95] SLD-VERIFIED ---- */

tFEApplication::tFEApplication()

{
  tFEApplication *ptVar1;
  int i;
  tDialogMessageString *this_tDialogMessageString;
  tDialogMessageStringWithTimeout *this_tDialogMessageStringWithTimeout;
  tDialogHelp *this_tDialogHelp;
  tDialogNoInputMessage *this_tDialogNoInputMessage;
  
  this_tDialogMessageString = &this->messagePopup;
  this_tDialogHelp = &this->helpPopup;
  /* MATCH: each tDialog* member is a REAL tScreen-derived subobject; the flattened field-init
   * below (Ghidra-decompiled from the fully-inlined tDialogBase/tDialogMessageString/etc ctors)
   * is missing the ONE non-inlined base call every level shares: tScreen::tScreen() (sets
   * fPermShapes/fSwapShapes/fScreenFadeVal + an initial _vf=tScreen_vtable that every
   * subsequent store here overwrites). Oracle calls `jal __7tScreen` once per subobject before
   * touching any of its fields -- reproduce via placement-new onto the tScreen slice. */
  new ((tScreen *)&this->messagePopup) tScreen();
  *(void **)&((this->messagePopup)._vf) = (void *)tDialogBase_vtable;
  (this->messagePopup).currentlyOn = 0;
  (this->messagePopup).reservedheight = 0;
  (this->messagePopup).MaxH = 0;
  (this->messagePopup).OffsetY = 0;
  (this->messagePopup).OffsetX = 0;
  (this->messagePopup).height = 0;
  (this->messagePopup).width = 0;
  (this->messagePopup).top = 0;
  (this->messagePopup).left = 0;
  (this->messagePopup).MaxW = 0x120;
  (this->messagePopup).specificPlayer = -1;
  (this->messagePopup).fDefault = 0;
  (this->messagePopup).timeOutTicks = 0;
  *(void **)&((this->messagePopup)._vf) = (void *)tDialogMessageString_vtable;
  (this->messagePopup).Centerit = 0;
  (this->messagePopup).fFullyOpen = 0;
  (this->messagePopup).timeOutTicks = 0;
  (this->messagePopup).fFadeText = 0x80;
  this_tDialogMessageStringWithTimeout = &this->MemCardDialog;
  new ((tScreen *)&this->helpPopup) tScreen();
  *(void **)&((this->helpPopup)._vf) = (void *)tDialogBase_vtable;
  *(void **)&((this->helpPopup)._vf) = (void *)tDialogHelp_vtable;
  (this->helpPopup).currentlyOn = 0;
  (this->helpPopup).reservedheight = 0;
  (this->helpPopup).MaxH = 0;
  (this->helpPopup).OffsetY = 0;
  (this->helpPopup).OffsetX = 0;
  (this->helpPopup).height = 0;
  (this->helpPopup).width = 0;
  (this->helpPopup).top = 0;
  (this->helpPopup).left = 0;
  (this->helpPopup).MaxW = 0x120;
  (this->helpPopup).specificPlayer = -1;
  (this->helpPopup).fDefault = 0;
  (this->helpPopup).timeOutTicks = 0;
  (this->helpPopup).variant = -1;
  (this->helpPopup).timeOutTicks = 0x578;
  this_tDialogNoInputMessage = &this->NoInputMemCardDialog;
  /* @0x800130B8/BC/C0: three _vf stores to MemCardDialog (this+0x238): tDialogBase, tDialogMessageString,
   * then the FINAL = tDialogMessageStringWithTimeout vtable @0x80010098. The recon mis-decoded the absolute
   * VA 0x80010098 (0x80010000+0x98) as a runtime `bigBuf + 0x98` pointer, leaving _vf pointing at garbage
   * (wrong virtual dispatch). Adversarially verified: the 0x80010550 the audit suggested was helpPopup's
   * tDialogHelp vtable, mis-attributed (M10). */
  new ((tScreen *)&this->MemCardDialog) tScreen();
  *(void **)&((this->MemCardDialog)._vf) = (void *)tDialogBase_vtable;
  *(void **)&((this->MemCardDialog)._vf) = (void *)tDialogMessageString_vtable;
  *(void **)&((this->MemCardDialog)._vf) = (void *)tDialogMessageStringWithTimeout_vtable;
  (this->MemCardDialog).currentlyOn = 0;
  (this->MemCardDialog).reservedheight = 0;
  (this->MemCardDialog).MaxH = 0;
  (this->MemCardDialog).OffsetY = 0;
  (this->MemCardDialog).OffsetX = 0;
  (this->MemCardDialog).height = 0;
  (this->MemCardDialog).width = 0;
  (this->MemCardDialog).top = 0;
  (this->MemCardDialog).left = 0;
  (this->MemCardDialog).MaxW = 0x120;
  (this->MemCardDialog).specificPlayer = -1;
  (this->MemCardDialog).fDefault = 0;
  (this->MemCardDialog).timeOutTicks = 0;
  (this->MemCardDialog).Centerit = 0;
  (this->MemCardDialog).fFullyOpen = 0;
  (this->MemCardDialog).timeOutTicks = 0;
  (this->MemCardDialog).fFadeText = 0x80;
  (this->MemCardDialog).timeOutTicks = 0x480;
  i = 0;
  new ((tScreen *)&this->NoInputMemCardDialog) tScreen();
  *(void **)&((this->NoInputMemCardDialog)._vf) = (void *)tDialogBase_vtable;
  (this->NoInputMemCardDialog).currentlyOn = 0;
  (this->NoInputMemCardDialog).reservedheight = 0;
  (this->NoInputMemCardDialog).MaxH = 0;
  (this->NoInputMemCardDialog).OffsetY = 0;
  (this->NoInputMemCardDialog).OffsetX = 0;
  (this->NoInputMemCardDialog).height = 0;
  (this->NoInputMemCardDialog).width = 0;
  (this->NoInputMemCardDialog).top = 0;
  (this->NoInputMemCardDialog).left = 0;
  (this->NoInputMemCardDialog).MaxW = 0x120;
  (this->NoInputMemCardDialog).specificPlayer = -1;
  (this->NoInputMemCardDialog).fDefault = 0;
  (this->NoInputMemCardDialog).timeOutTicks = 0;
  *(void **)&((this->NoInputMemCardDialog)._vf) = (void *)tDialogMessageString_vtable;
  (this->NoInputMemCardDialog).Centerit = 0;
  (this->NoInputMemCardDialog).fFullyOpen = 0;
  (this->NoInputMemCardDialog).timeOutTicks = 0;
  (this->NoInputMemCardDialog).fFadeText = 0x80;
  *(void **)&((this->NoInputMemCardDialog)._vf) = (void *)tDialogNoInputMessage_vtable;
  ptVar1 = this;
  do {
    ptVar1->gotName[0] = 0;
    ptVar1->needName[0] = 0;
    ptVar1->speechToPlay[0] = -1;
    i = i + 1;
    ptVar1 = (tFEApplication *)ptVar1->fCurrentMenu;
  } while (i < 2);
  return;
}



/* ---- tFEApplication::dtor  [FEAPP.CPP:101-102] SLD-VERIFIED ---- */

tFEApplication::~tFEApplication()

{
  
  return;
}



/* ---- tFEApplication::PerformMenuInitialization  [FEAPP.CPP:105-122] SLD-VERIFIED ---- */

void tFEApplication::PerformMenuInitialization()

{
  tDialogBase *this_00;
  extern void InitializeClass_noarg() asm("InitializeClass__11tDialogBase");

  this->fCurrentMusic = 0;
  this_00 = (tDialogBase *)((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
  AudioMus_Volume((int)this_00);
  InitializeClass_noarg();
  Clock_SystemStartUp();
  Draw_gDoVSync = 1;
  FETextRender_SetABR(0,false);
  return;
}



/* ---- tFEApplication::PerformMenuDestruction  [FEAPP.CPP:126-145] SLD-VERIFIED ---- */

void tFEApplication::PerformMenuDestruction()

{
  int off;
  int screen;
  short i;

  Clock_SystemCleanUp();
  i = 0;
  do {
    off = (i << 0x10) >> 0xe;
    screen = *(int *)((int)this->fCurrentScreen + off);
    if (screen != 0) {
      (**(int (**)(...))(*(int *)(screen + 0x60) + 0x3c))
                (screen + *(short *)(*(int *)(screen + 0x60) + 0x38));
    }
    i = i + 1;
    *(u_int *)((int)this->fCurrentScreen + off) = 0;
  } while (i < 2);
  AudioMus_StopSong(1000);
  Draw_gDoVSync = 0;
  FETextRender_SetABR(0,false);
  return;
}



/* ---- tFEApplication::DrawHelpIcons  [FEAPP.CPP:151-219] SLD-VERIFIED ---- */
/* MATCH (2026-07-27, 254 diffs [~0%] -> 4 diffs, count-exact 254==254):
 *  - SYM `8c Function start` gives Col/x/y as REAL named REG locals ($s5/$s3/$s2), NOT
 *    literal-folded values. Recon had inlined 0x786e14 at 4 call sites (fresh li each time,
 *    can't survive a jal in a caller-saved reg) -- named `Col` forces ONE materialization
 *    reused across every intervening call, matching the oracle's $s5 reuse.
 *  - SYM types Col/x/y INT (not the recon's `short x`); per-statement narrow-then-widen
 *    masking from a `short` local doesn't match -- only the ARGUMENT boundary (an actual
 *    short parameter) truncates, and the plain `(short)((u_int)(y*0x10000)>>0x10)` idiom in
 *    the old recon was a hand-rolled (and wrong-codegen, multiply-based) substitute for a
 *    bare int-arg-to-short-param truncation; removed, arguments now pass x/y directly.
 *  - if/else ARM ORDER inverted (De Morgan `A||B then/else` -> `!A&&!B then/else`) to match
 *    the oracle's physical block layout: the vertical/string path is the FALL-THROUGH block,
 *    the horizontal/icon path is the branch target reached from both short-circuit tests --
 *    opposite of what the literal `if(fCurrentMenu[0]==0||VertHelp==0)` phrasing produced.
 *  - vertical-path loop split the load from the decrement (`i=strlen(s); i=i-1; while(-1<i)`)
 *    -- classic §3.12#15b rotated-loop shape; loop's X-arg passes the (unmodified, still-14)
 *    `x` local, letting gcc constant-propagate + hoist its `(short)x` truncation OUT of the
 *    loop as `lui $s4,0xE ; sra $a1,$s4,16` (only the `sra` re-executes per iteration) --
 *    passing a literal `0xe` there instead defeats this hoist entirely.
 *  - post-loop tail: the y+=8 in the branch delay slot always fires; the two DrawShapeExtended
 *    calls use `x`/`y` (still-live vars from the loop, not fresh literals) -- `x-1`/`y-9` are
 *    increments on the live values, not restated constants.
 *  Residual 4-diff floor: `x = x + 5 + (iVar4 - uVar3);` oracle associates the `+5` onto `x`
 *  FIRST (`v1=x+5` computed once, reused) where ours re-associates onto the difference term
 *  despite identical source parenthesization -- gcc-2.8's tree reassociation picks its own
 *  grouping for a flat +chain regardless of C parens. Every attempt to force it (extra temp,
 *  operand reorder, mutating iVar4 in place) either left it unchanged or REGRESSED into a
 *  uniform x<->y ($s2<->$s3) register swap elsewhere in the function (adding any new pseudo
 *  here recolors the whole head, per catalog row 37) -- accepted as a genuine floor. */

void tFEApplication::DrawHelpIcons()

{
  bool bVar1;
  char *pcVar2;
  int iVar4;
  int uVar3;
  tDrawShapeExtended flags;
  int Col;
  int x;
  int y;
  char string [12];
  char string2 [2];

  Col = 0x786e14;
  x = 0xe;
  flags.tint[0] = Col;
  y = screenheight + -0x19;
  if ((this->fCurrentMenu[0] != (tMenu *)0x0) && (this->fCurrentMenu[0]->VertHelp != 0)) {
    int i;

    string2[1] = '\0';
    pcVar2 = TextSys_Word(0xfc);
    sprintf(string,pcVar2);
    i = strlen(string);
    i = i - 1;
    while (-1 < i) {
      string2[0] = string[i];
      FETextRender_FullTextRGB(string2,x,y,Col,'\0',0);
      y = y - 8;
      i = i - 1;
    }
    y = y + 8;
    if (((gPadinfo.buf[0].nopad == '\0') && (gPadinfo.buf[0].ID != '#')) ||
       ((gPadinfo.buf[4].nopad == '\0' && (gPadinfo.buf[4].ID != '#')))) {
      y = y - 8;
      DrawShapeExtended(0x35,0x18,x,y,0,0,&flags);
    }
    if ((gPadinfo.buf[0].ID == '#') || (gPadinfo.buf[4].ID == '#')) {
      DrawShapeExtended(0x36,0x18,x + -1,y + -9,0,0,&flags);
    }
  }
  else {
    if (((gPadinfo.buf[0].nopad == '\0') && (gPadinfo.buf[0].ID != '#')) ||
       ((gPadinfo.buf[4].nopad == '\0' && (gPadinfo.buf[4].ID != '#')))) {
      DrawShapeExtended(0x35,0x18,x,y,0,0,&flags);
      x = x + 0xe;
    }
    if ((gPadinfo.buf[0].ID == '#') || (gPadinfo.buf[4].ID == '#')) {
      DrawShapeExtended(0x36,0x18,x,y,0,0,&flags);
      x = x + 0xf;
    }
    pcVar2 = TextSys_Word(0xfc);
    FETextRender_FullTextRGB(pcVar2,x,y,Col,'\0',0);
    pcVar2 = TextSys_Word(0xfc);
    iVar4 = textpixels(pcVar2);
    pcVar2 = TextSys_Word(0xfc);
    uVar3 = strlen(pcVar2);
    x = x + 5 + (iVar4 - uVar3);
    bVar1 = false;
    if ((this->fCurrentMenu[0]->fOptionsMenu != (tMenu *)0x0) ||
       ((this->fCurrentMenu[1] != (tMenu *)0x0 &&
        (this->fCurrentMenu[1]->fOptionsMenu != (tMenu *)0x0)))) {
      bVar1 = true;
    }
    if (bVar1) {
      if (((gPadinfo.buf[0].nopad == '\0') && (gPadinfo.buf[0].ID != '#')) ||
         ((gPadinfo.buf[4].nopad == '\0' && (gPadinfo.buf[4].ID != '#')))) {
        DrawShapeExtended(0x37,0x18,x,y,0,0,&flags);
        x = x + 0xe;
      }
      if ((gPadinfo.buf[0].ID == '#') || (gPadinfo.buf[4].ID == '#')) {
        DrawShapeExtended(0x38,0x18,x,y,0,0,&flags);
        x = x + 0xf;
      }
      pcVar2 = TextSys_Word(0xfd);
      FETextRender_FullTextRGB(pcVar2,x,y,Col,'\0',0);
    }
  }
  return;
}



/* ---- tFEApplication::Redraw  [FEAPP.CPP:225-395] SLD-VERIFIED ---- */

void tFEApplication::Redraw()

{
  int i;
  u_char saveFPlayer;
  short height;
  char buffer [32];
  int drenv;
  u_char *daprim;
  RECT r;
  int iVar1;
  int musThresh;
  tMenuCommand emptycommand;
  tInputKeyType JustOneToPass;
  tGlobalMenuDefs *globalMenuDefs;
  tInputKeyType JustOneToPass_l85;
  int curItem;
  u_char *prev_pkt_p1;
  int pkt_addr24_p1;
  int menu_per_player;
  int parentMenu_p;
  tMenu *curMenu;
  int ti8;
  int pa_Var9;
  tMenu *ptVar2;
  u_char bVar2;
  __vtbl_ptr_type (*pa_Var2) [11];
  int ti2;
  int pa_Var3;
  int freeHeap_or_buf;
  int pkt_addr24_p2;

  saveFPlayer = this->fPlayer;
  FeAudio_systemtask(0);
  Draw_StartFrameRender();
  Draw_StartRenderingView(Draw_gPlayer1View);
  iVar1 = largestunused();
  sprintf(buffer,(char *)(bigBuf + 0x44),iVar1);
  FETextRender_FullText(buffer,0x100,0xd7,textType_FramedInfo,textState_Selected,0);
  iVar1 = AudioMus_Buffered();
  musThresh = AudioMus_Threshold();
  sprintf(buffer,(char *)(bigBuf + 0x48),iVar1,musThresh);
  FETextRender_FullText(buffer,0x10,0xd7,textType_FramedInfo,textState_Hilighted,0);
  drenv = (int)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  if (this->fCurrentMenu[1] != (tMenu *)0x0) {
    height = (short)((u_int)(screenheight - (screenheight >> 0x1f)) >> 1);
  }
  else {
    height = (short)screenheight;
  }
  tDialogBase::DrawAllDialogs();
  this->DrawHelpIcons();
  globalMenuDefs = menuDefs[0];
  if ((gPadinfo.buf[0].nopad == '\0') && (gPadinfo.buf[4].nopad == '\0')) {
    (menuDefs[0]->itemMainTwoPlayerRace).fFlags
         = (menuDefs[0]->itemMainTwoPlayerRace).fFlags & 0xfffffffe;
  }
  else {
    (menuDefs[0]->itemMainTwoPlayerRace).fFlags
         = (menuDefs[0]->itemMainTwoPlayerRace).fFlags | 1;
    JustOneToPass = kInput_KeyType_Up;
    if ((tMenuItemGoToMenuNFS4Button *)
        this->fCurrentMenu[0]->fItemList[this->fCurrentMenu[0]->fCurrentItem] ==
        &globalMenuDefs->itemMainTwoPlayerRace) {
      (&globalMenuDefs->menuMain)->ProcessInput(kPlayerOne,JustOneToPass,emptycommand);
    }
  }
  globalMenuDefs = menuDefs[0];
  if (gPadinfo.buf[0].nopad == '\0') {
    (menuDefs[0]->itemMainOnePlayerRace).fFlags
         = (menuDefs[0]->itemMainOnePlayerRace).fFlags & 0xfffffffe;
  }
  else {
    (menuDefs[0]->itemMainOnePlayerRace).fFlags
         = (menuDefs[0]->itemMainOnePlayerRace).fFlags | 1;
    curItem = (int)this->fCurrentMenu[0]->fItemList[this->fCurrentMenu[0]->fCurrentItem];
    JustOneToPass_l85 = kInput_KeyType_Down;
    if ((tGlobalMenuDefs *)curItem == globalMenuDefs) {
      ((tMenuNFS4 *)(curItem + 0xb0))->ProcessInput(kPlayerOne,JustOneToPass_l85,emptycommand);
    }
  }
  daprim = Render_gPacketPtr;
  prev_pkt_p1 = Render_gPalettePtr;
  i = 1;
  r.x = 0;
  r.y = *(short *)(drenv + 2);
  r.w = 0x200;
  r.h = (short)screenheight;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24_p1 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(u_int *)prev_pkt_p1 = *(u_int *)prev_pkt_p1 & 0xff000000 | pkt_addr24_p1;
  SetDrawArea((DR_AREA *)daprim,&r);
  do {
    this->fPlayer = (char)i;
    this->fYOffset = ((u_short)i & 0xff) * height;
    menu_per_player = (int)this->fCurrentMenu[i & 0xff];
    if (menu_per_player != 0) {
      (**(int (**)(...))(*(int *)(menu_per_player + 0x68) + 0x54))
                (menu_per_player + *(short *)(*(int *)(menu_per_player + 0x68) + 0x50));
    }
    parentMenu_p = (int)this->fParentMenu[(u_char)this->fPlayer];
    if (parentMenu_p != 0) {
      (**(int (**)(...))(*(int *)(parentMenu_p + 0x68) + 0x54))
                (parentMenu_p + *(short *)(*(int *)(parentMenu_p + 0x68) + 0x50));
    }
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->UpdateTransition();
    }
    curMenu = this->fCurrentMenu[(u_char)this->fPlayer];
    if ((curMenu != (tMenu *)0x0) &&
       (ti8 = (*(*curMenu->_vf)[8].pfn)((int)curMenu->fItemList + (*curMenu->_vf)[8].delta + -0x10),
       ti8 != 0)) {
      pa_Var9 = (int)this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
      (**(int (**)(...))(pa_Var9 + 0x4c))
                ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                 *(short *)(pa_Var9 + 0x48) + -0x10);
    }
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(false);
    }
    ptVar2 = this->fCurrentMenu[(u_char)this->fPlayer];
    if (ptVar2 != (tMenu *)0x0) {
      bVar2 = false;
      if (this->waitingForOtherPlayer[(u_char)this->fPlayer] == 0) {
Redraw_vtableCallback9:
        pa_Var2 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
        (*(*pa_Var2)[9].pfn)
                  ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                   (*pa_Var2)[9].delta + -0x10);
      }
      else {
        ti2 = (*(*ptVar2->_vf)[7].pfn)((int)ptVar2->fItemList + (*ptVar2->_vf)[7].delta + -0x10);
        if (ti2 == 0) {
          pa_Var3 = (int)this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
          freeHeap_or_buf =
               (**(int (**)(...))(pa_Var3 + 0x44))
                         ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                          *(short *)(pa_Var3 + 0x40) + -0x10);
          bVar2 = freeHeap_or_buf == 0;
        }
        if ((bool)bVar2) goto Redraw_vtableCallback9;
      }
      ptVar2 = this->fParentMenu[(u_char)this->fPlayer];
      if (ptVar2 != (tMenu *)0x0) {
        (*(*ptVar2->_vf)[9].pfn)((int)ptVar2->fItemList + (*ptVar2->_vf)[9].delta + -0x10);
      }
    }
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
    }
    daprim = Render_gPacketPtr;
    prev_pkt_p1 = Render_gPalettePtr;
    r.x = 0;
    r.y = *(short *)(drenv + 2) + this->fYOffset;
    r.w = 0x200;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24_p2 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)prev_pkt_p1 = *(u_int *)prev_pkt_p1 & 0xff000000 | pkt_addr24_p2;
    r.h = height;
    SetDrawArea((DR_AREA *)daprim,&r);
    i = i - 1;
    if (i * 0x10000 < 0) {
      this->fPlayer = saveFPlayer;
      Draw_StopRenderingView(Draw_gPlayer1View);
      Draw_StopFrameRender();
      return;
    }
  } while( true );
}



/* ---- tFEApplication::UpdateMusic  [FEAPP.CPP:404-417] SLD-VERIFIED ---- */

void tFEApplication::UpdateMusic()

{
  u_int uVar1;
  
  AudioMus_Volume((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
  uVar1 = this->fCurrentMusic;
  if ((uVar1 & 0x1000) != 0) {
    AudioMus_PlaySong((char *)(bigBuf + 0x50));
  }
  else if ((uVar1 & 0x2000) != 0) {
    AudioMus_PlaySong((char *)(bigBuf + 0x58));
  }
  else if ((uVar1 & 0x4000) != 0) {
    AudioMus_PlaySong((char *)(bigBuf + 0x60));
  }
  else if ((uVar1 & 0x8000) != 0) {
    AudioMus_PlaySong((char *)(bigBuf + 0x6c));
  }
  else {
    AudioMus_StopSong(1000);
  }
  return;
}



/* ---- tFEApplication::SetMenu  [FEAPP.CPP:422-448] SLD-VERIFIED ---- */

void tFEApplication::SetMenu(short i,tMenu *menu)

{
  u_int uVar1;
  int iVar2;

  if (menu != this->fCurrentMenu[i]) {
    if ((i == 0) && (uVar1 = menu->fFlags & 0xf000, uVar1 != this->fCurrentMusic)) {
      this->fCurrentMusic = uVar1;
      this->UpdateMusic();
    }
    if (((*(*menu->_vf)[8].pfn)((int)menu + (*menu->_vf)[8].delta) ^ 1) != 0) {
      iVar2 = (int)this->fCurrentMenu[i];
      this->fTransitionToMenu[i] = menu;
      if ((iVar2 != 0) && (menu != (tMenu *)0x0)) {
        (**(int (**)(...))(*(int *)(iVar2 + 0x68) + 0x2c))
                  (iVar2 + *(short *)(*(int *)(iVar2 + 0x68) + 0x28));
      }
    }
    else {
      this->fTransitionToMenu[i] = menu;
    }
    this->SetScreen(i,menu->fScreen);
  }
  return;
}



/* ---- tFEApplication::SetScreen  [FEAPP.CPP:453-458] SLD-VERIFIED ---- */

void tFEApplication::SetScreen(short i,tScreen *screen)

{
  tScreen *this_00;
  int iVar1;

  /* MATCH (permuter multi-basin re-seed, 2026-06-30): the residual was a base↔this_00 register SWAP —
   * the oracle reuses the dead `this` reg as the `this+i*4` base (addu a0,a0,a1), forcing this_00 into
   * $v0 + an `addu a0,v0,zero` move before the virtual call; ours kept this_00 in $a0 (no move). The
   * winning combo (re-read basin, score 25→0 @iter 490): (1) the `(long long)` cast on the first
   * fCurrentScreen[i] address load shifts how gcc materializes the base; (2) the call RE-READS
   * fCurrentScreen[i] instead of the cached this_00; (3) the `0 != this_00` (operands swapped) compare.
   * No `this` reassignment, so it transcribes cleanly to the method. (Manual base-once / §3.12#14 /
   * char*p all failed; this is the "no floors" proof — an apparent ours-better floor was permuter-reachable.) */
  iVar1 = (int)((u_int)(u_short)i << 0x10) >> 0xe;
  this_00 = *(tScreen **)((long long)((int)this->fCurrentScreen + iVar1));
  if (((screen != this_00) &&
      (*(tScreen **)((int)this->fTransitionToScreen + iVar1) = screen, (tScreen *)0x0 != this_00))
     && (screen != (tScreen *)0x0)) {
    (*(tScreen **)((int)this->fCurrentScreen + iVar1))->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
  }
  return;
}



/* ---- tFEApplication::DisplayHelp  [FEAPP.CPP:463-479] SLD-VERIFIED ---- */

void tFEApplication::DisplayHelp(short variant)

{
  tDialogHelp *this_tDialogHelp;
  
  /* MATCH: store variant through the helpPopup pointer (base = this+0x158) so gcc reuses that
   * same base ($a0) for the Display() call AND the `sh a1,0x90(a0)` store (in the jal delay
   * slot) — not the full `sh a1,0x1E8(this)` offset with a separate base computation. */
  this_tDialogHelp = &this->helpPopup;
  this_tDialogHelp->variant = variant;
  ((tDialogBase *)this_tDialogHelp)->Display();
  return;
}



/* ---- tFEApplication::RunDemoVideo  [FEAPP.CPP:483-554] SLD-VERIFIED ---- */

void tFEApplication::RunDemoVideo()

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  int iVar3;
  __vtbl_ptr_type (*pa_Var4) [10];
  tScreen *this_00;
  char buffer [40];

  if ((tMenuNFS4 *)this->fCurrentMenu[0] == &menuDefs[0]->menuMain) {
    AudioMus_StopSong(0x78);
    FeAudio_systemtask(0);
    pa_Var2 = this->fCurrentMenu[0]->_vf;
    (*(*pa_Var2)[5].pfn)((int)this->fCurrentMenu[0]->fItemList + (*pa_Var2)[5].delta + -0x10);
    (this->fCurrentScreen[0])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
    while( true ) {
      pa_Var2 = this->fCurrentMenu[0]->_vf;
      bVar1 = false;
      iVar3 = (*(*pa_Var2)[7].pfn)
                        ((int)this->fCurrentMenu[0]->fItemList + (*pa_Var2)[7].delta + -0x10);
      if ((iVar3 == 0) ||
         (pa_Var4 = this->fCurrentScreen[0]->_vf,
         iVar3 = (*(*pa_Var4)[8].pfn)
                           ((this->fCurrentScreen[0]->fPermShapes).fFilename +
                            (*pa_Var4)[8].delta + -0x14), iVar3 == 0)) {
        bVar1 = true;
      }
      if (!bVar1) break;
      this->Redraw();
      FeAudio_systemtask(0);
    }
    pa_Var4 = this->fCurrentScreen[0]->_vf;
    (*(*pa_Var4)[7].pfn)
              ((this->fCurrentScreen[0]->fPermShapes).fFilename + (*pa_Var4)[7].delta + -0x14);
    Audio_FECleanUp();
    Audio_DeInitDriver();
    PSXFront_FreeDrawMemory();
    FeTools_deinit();
    FreeHelpShapeCluts();
    gLargestUnused = largestunused();
    this_00 = (tScreen *)(u_int)(u_char)((char)currentVideo + 1U);
    play_movie((char)currentVideo + 1U);
    gLargestUnused = largestunused();
    PSXFront_AllocateDrawMemory();
    FeTools_init();
    (this_00)->DisplayLoadingText();
    Audio_InitDriver(0xd800,0x18000);
    AudioCmn_LoadFESamples();
    LoadAllHelpShapes();
    this->UpdateMusic();
    AudioMus_Volume((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
    gLargestUnused = largestunused();
    pa_Var2 = this->fCurrentMenu[0]->_vf;
    (*(*pa_Var2)[2].pfn)((int)this->fCurrentMenu[0]->fItemList + (*pa_Var2)[2].delta + -0x10);
    pa_Var4 = this->fCurrentScreen[0]->_vf;
    (*(*pa_Var4)[6].pfn)
              ((this->fCurrentScreen[0]->fPermShapes).fFilename + (*pa_Var4)[6].delta + -0x14);
    pa_Var2 = this->fCurrentMenu[0]->_vf;
    (*(*pa_Var2)[6].pfn)((int)this->fCurrentMenu[0]->fItemList + (*pa_Var2)[6].delta + -0x10);
    (this->fCurrentScreen[0])->TransitionOn(kScreen_TransitionTypeScreen,(tMenu *)0x0);
    currentVideo = (currentVideo + 1) % 3;
  }
  return;
}



/* ---- tFEApplication::MainLoop  [FEAPP.CPP:560-985] SLD-VERIFIED ---- */
/* PARTIAL (2026-07-27, w36-a2): baseline FAIL 1730 diffs (ours 1139 / oracle 1123, insn
 * count already close). Reordered the function-scope local declarations to match the SYM
 * `8c Function start` Block-1 list exactly (this,newMenu params; then stackBackupPin,
 * wasSubMenu,needToSetChildMenu,doRedraw,ticksAtLastInput,tick,inputStartPlayer,
 * inputEndPlayer,i,demoLoopLastInputTick,string, then the nested-block SYM locals
 * command/keyVal/debounce/dialog/err/player/carInfo/ticks_l351 in their SYM block order,
 * with the Ghidra-fabricated (non-SYM) temps left AFTER all real SYM locals) -- this is a
 * PURE reorder, no logic/type changes, insn count unaffected (1139==1139) -- dropped to
 * FAIL 1554 diffs, a real but partial improvement (no regression risk: same instruction
 * count, only allocator/scheduling order shifted).
 *
 * ROOT-CAUSE STATE FOR THE NEXT PASS: the dominant residual is `this` REGPARM ($s2 per SYM)
 * getting colored $s3 in our build for the WHOLE function (this cascades into ~500+ of the
 * remaining diff lines, since `this->` is referenced constantly) -- oracle's mask
 * $c0ff0000 confirms all 8 s-regs + fp + ra are saved (matches ours, frame size 408==408
 * exact per SYM fsize), so this is NOT a missing-save/frame-shape bug, purely a coloring
 * PRIORITY tie-break: SYM puts newMenu($s0) and inputStartPlayer($s1) ahead of `this`($s2)
 * in the register-number ordering despite `this` having far higher raw ref-count -- gcc-2.8's
 * global-alloc priority is refs-per-live-length (weighted by loop nesting), not raw refs, so
 * inputStartPlayer's tighter/loopier live range can legitimately outrank `this`'s
 * function-wide range. A `-dg` allocno dump (CC1PLPSX -dg -dl on the preprocessed .i, see
 * scratchpad/rtl_a6.sh for the recipe, swap CC1PSX->CC1PLPSX per the wave briefing) shows
 * MainLoop needs 51 pseudos colored into the saved-reg set with 40-50 PAIRWISE conflicts
 * each (i.e. most locals are simultaneously live across nearly the whole function) -- a
 * saturated coloring problem where the fix is almost certainly a handful of SLD-block-scope
 * corrections (many Ghidra-invented temps below -- ptVar5/ptVar6/pa_Var11/pa_Var12/tVar13/
 * pcVar15/pcVar16/ptVar17/ptVar18/ptVar19/piVar20/cVar8/sVar9/iVar10/iVar4 -- are NOT in the
 * SYM at all and are almost certainly compiler temps that should collapse into direct
 * expressions or the real SYM-named block-scoped `this` pointers seen at VA 0x80014648/
 * 0x8001491c/0x80014af4/0x8001515c, narrowing the live pseudo count) rather than a single
 * lever -- recommend a dedicated SLD-block-by-block pass (per this wave's mission) starting
 * from the `this` register swap, working outward. Function too large (1123 oracle insns,
 * ~4.5x DrawHelpIcons) to safely hand-derive further without regression risk in this pass. */

tAppCommand tFEApplication::MainLoop(tMenu *newMenu)

{
  short stackBackupPin;
  bool wasSubMenu;
  bool needToSetChildMenu;
  bool doRedraw;
  u_long ticksAtLastInput [2];
  u_long tick;
  tPlayer inputStartPlayer;
  tPlayer inputEndPlayer;
  short i;
  int demoLoopLastInputTick;
  char string [80];
  tMenuCommand command [2];
  tInputKeyType keyVal [2];
  int dialog;
  PinkSlipsErrorCode err;
  int player;
  tCarInfo carInfo;
  u_long ticks_l351;
  int iVar10;
  __vtbl_ptr_type (*pa_Var11) [11];
  tMenu *this_tMenu_l92;
  __vtbl_ptr_type (*pa_Var12) [10];
  tMenu *ptVar17;
  tDialogBase *this_tDialogBase_l181;
  tMenu *this_tMenu_l139;
  tDialogMessageString *this_tDialogMessageString_l311;

  stackBackupPin = -1;
  needToSetChildMenu = false;
  memset(ticksAtLastInput,0,8);
  this->fInputPlayer = '\0';
  this->PerformMenuInitialization();
  demoLoopLastInputTick = ticks;
  gFlip = 0;
  this->fPlayer = '\0';
  do {
    this->backDepth[(u_char)this->fPlayer] = 0;
    this->fCurrentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
    this->fCurrentScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
    this->fTransitionToMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
    this->fTransitionToScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
    this->waitingForOtherPlayer[(u_char)this->fPlayer] = 0;
    this->fLastKeyPressed[(u_char)this->fPlayer] = kInput_KeyType_NoKey;
    this->fParentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
    this->fPlayer = this->fPlayer + 1;
  } while ((u_char)this->fPlayer < 2);
  this->SetMenu(0,newMenu);
  tMenuCommand *commandBase;
  tInputKeyType *keyValBase = keyVal;
  do {
    commandBase = command;
    tick = ticks;
    doRedraw = true;
    this->fPlayer = '\0';
    while ((u_char)this->fPlayer < 2) {
      if (this->fTransitionToMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
        ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
        wasSubMenu = 0;
        if (ptVar17 != (tMenu *)0x0) {
          iVar10 = (*(*ptVar17->_vf)[7].pfn)
                             ((int)ptVar17->fItemList + (*ptVar17->_vf)[7].delta + -0x10);
          tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
          if ((iVar10 != 0) &&
             (ptVar18 != (tScreen *)0x0)) {
            iVar10 = (*(*ptVar18->_vf)[8].pfn)
                               ((ptVar18->fPermShapes).fFilename + (*ptVar18->_vf)[8].delta + -0x14)
            ;
            wasSubMenu = (u_int)(iVar10 != 0);
          }
          if (wasSubMenu == 0) goto MainLoop_subMenuDetect;
          ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
          wasSubMenu = 0;
          if (ptVar17 != (tMenu *)0x0) {
            wasSubMenu =
                 (*(*ptVar17->_vf)[8].pfn)
                           ((int)ptVar17->fItemList + (*ptVar17->_vf)[8].delta + -0x10);
          }
        }
        pa_Var11 = this->fTransitionToMenu[(u_char)this->fPlayer]->_vf;
        iVar10 = (*(*pa_Var11)[8].pfn)
                           ((int)this->fTransitionToMenu[(u_char)this->fPlayer]->fItemList +
                            (*pa_Var11)[8].delta + -0x10);
        if (iVar10 != 0) {
          this->fParentMenu[(u_char)this->fPlayer] = this->fCurrentMenu[(u_char)this->fPlayer];
        }
        else {
          this->fParentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
        }
        this->fCurrentMenu[(u_char)this->fPlayer] = this->fTransitionToMenu[(u_char)this->fPlayer];
        pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
        (*(*pa_Var11)[2].pfn)
                  ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                   (*pa_Var11)[2].delta + -0x10);
        this->fTransitionToMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
        if ((wasSubMenu != 0) && (this->fTransitionToScreen[0] == (tScreen *)0x0)) {
          doRedraw = false;
          this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + -1;
        }
        else {
          pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
          (*(*pa_Var11)[6].pfn)
                    ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                     (*pa_Var11)[6].delta + -0x10);
          if (needToSetChildMenu) {
            this_tMenu_l92 = (tMenu *)(u_int)(u_char)this->fPlayer;
            needToSetChildMenu = false;
            this->SetMenu(1,this->fCurrentMenu[(int)this_tMenu_l92]->fChildMenu);
          }
        }
        demoLoopLastInputTick = ticks;
      }
MainLoop_subMenuDetect:
      if ((u_char)this->fPlayer == 1) {
        ptVar17 = this->fCurrentMenu[1];
        if ((((ptVar17 != (tMenu *)0x0) &&
             (iVar10 = (*(*ptVar17->_vf)[7].pfn)
                                 ((int)ptVar17->fItemList + (*ptVar17->_vf)[7].delta + -0x10),
             iVar10 != 0)) && ((int)((u_int)(u_short)stackBackupPin << 0x10) < 0)) &&
           ((ptVar17 = this->fParentMenu[(u_char)this->fPlayer], ptVar17 == (tMenu *)0x0 ||
            (iVar10 = (*(*ptVar17->_vf)[7].pfn)
                                ((int)ptVar17->fItemList + (*ptVar17->_vf)[7].delta + -0x10),
            iVar10 != 0)))) {
          this->fCurrentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
          tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
          if (ptVar18 != (tScreen *)0x0) {
            (*(*ptVar18->_vf)[7].pfn)
                      ((ptVar18->fPermShapes).fFilename + (*ptVar18->_vf)[7].delta + -0x14);
          }
          this->fCurrentScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
        }
      }
      if (this->fTransitionToScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
        tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
        if (ptVar18 != (tScreen *)0x0) {
          iVar10 = (*(*ptVar18->_vf)[8].pfn)
                             ((ptVar18->fPermShapes).fFilename + (*ptVar18->_vf)[8].delta + -0x14);
          if ((iVar10 == 0) || (this->fTransitionToMenu[(u_char)this->fPlayer] != (tMenu *)0x0))
          goto MainLoop_perPlayerFlagCheck;
          tScreen *currentScreen = this->fCurrentScreen[(u_char)this->fPlayer];
          if (currentScreen != (tScreen *)0x0) {
            (*(*currentScreen->_vf)[7].pfn)
                      ((currentScreen->fPermShapes).fFilename + (*currentScreen->_vf)[7].delta + -0x14);
          }
        }
        this->fCurrentScreen[(u_char)this->fPlayer] = this->fTransitionToScreen[(u_char)this->fPlayer];
        gLargestUnused = largestunused();
        pa_Var12 = this->fCurrentScreen[(u_char)this->fPlayer]->_vf;
        (*(*pa_Var12)[6].pfn)
                  ((this->fCurrentScreen[(u_char)this->fPlayer]->fPermShapes).fFilename +
                   (*pa_Var12)[6].delta + -0x14);
        this->fTransitionToScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
        (this->fCurrentScreen[(u_char)this->fPlayer])->TransitionOn(kScreen_TransitionTypeScreen,
                   (tMenu *)0x0);
      }
MainLoop_perPlayerFlagCheck:
      bool perPlayer = false;
      if (this->fCurrentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
        inputStartPlayer = (tPlayer)(u_char)this->fPlayer;
        u_char menuFlags = this->fCurrentMenu[(u_char)this->fPlayer]->fFlags;
        if (((menuFlags & 0x10) != 0) ||
           ((frontEnd.gameMode == '\x01' && ((menuFlags & 8) == 0)))) {
          perPlayer = true;
        }
        inputEndPlayer = inputStartPlayer;
        if (perPlayer) {
          inputStartPlayer = kPlayerOne;
          inputEndPlayer = kPlayerTwo;
        }
        this_tMenu_l139 = this->fCurrentMenu[(u_char)this->fPlayer];
        u_char inputFlags = this_tMenu_l139->fFlags;
        if ((inputFlags & 0x20) != 0) {
          inputStartPlayer = (tPlayer)(u_char)this->fInputPlayer;
          inputEndPlayer = inputStartPlayer;
        }
        if ((inputFlags & 0x40) != 0) {
          inputEndPlayer = kPlayerOne;
          inputStartPlayer = kPlayerOne;
        }
        if ((inputFlags & 0x80) != 0) {
          inputEndPlayer = kPlayerTwo;
          inputStartPlayer = kPlayerTwo;
        }
        wasSubMenu = false;
        if (((this_tMenu_l139 != (tMenu *)0x0) &&
            (iVar10 = (*(*this_tMenu_l139->_vf)[7].pfn)
                                ((int)this_tMenu_l139->fItemList +
                                 (*this_tMenu_l139->_vf)[7].delta + -0x10), iVar10 != 0)) &&
           (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0)) {
          iVar10 = (*(*this->fCurrentScreen[(u_char)this->fPlayer]->_vf)[8].pfn)
                             ((this->fCurrentScreen[(u_char)this->fPlayer]->fPermShapes).fFilename +
                              (*this->fCurrentScreen[(u_char)this->fPlayer]->_vf)[8].delta + -0x14);
          wasSubMenu = iVar10 != 0;
        }
        if (wasSubMenu) {
          u_long debounce;
          pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
          debounce = (*(*pa_Var11)[4].pfn)
                                  ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                                   (*pa_Var11)[4].delta + -0x10);
i = inputStartPlayer;
          MainLoop_perPlayerInputTop:
          if (inputEndPlayer < i) goto MainLoop_nextPlayer;
          commandBase[i].type = kMenu_Command_None;
          keyValBase[i] = FEInput_GetKeyFromPlayer((tPlayer)i,debounce);
          if (keyValBase[i] != kInput_KeyType_NoKey) {
            this->fInputPlayer = (char)i;
          }
          if ((0xf < ticks - ticksAtLastInput[i]) ||
             ((debounce & keyValBase[i]) == kInput_KeyType_NoKey)) {
            this->fLastKeyPressed[i] = keyValBase[i];
          }
          if (keyValBase[i] != kInput_KeyType_NoKey) {
            dialog = tDialogBase::GetTopMostDialog();
            demoLoopLastInputTick = tick;
            ticksAtLastInput[i] = tick;
            if ((keyValBase[i] == 4) && ((this->helpPopup).currentlyOn != 0)) {
              keyValBase[i] = kInput_KeyType_AlreadyProcessed;
              ((tDialogBase *)&this->helpPopup)->Hide();
            }
            if (dialog != 0) {
              if (keyValBase[i] != kInput_KeyType_Circle) {
                (**(int (**)(...))(*(int *)(dialog + 0x60) + 0x4c))
                          (dialog + *(short *)(*(int *)(dialog + 0x60) + 0x48),i,keyValBase + i,
                           commandBase + i);
              }
            }
            tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
            if (ptVar18 != (tScreen *)0x0) {
              (*(*ptVar18->_vf)[9].pfn)
                        ((ptVar18->fPermShapes).fFilename + (*ptVar18->_vf)[9].delta + -0x14,i,
                         keyValBase + i,commandBase + i);
            }
            if (keyValBase[i] != kInput_KeyType_AlreadyProcessed) {
              pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
              (*(*pa_Var11)[3].pfn)
                        ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                         (*pa_Var11)[3].delta + -0x10,i,keyValBase + i,commandBase + i);
            }
          }
          iVar10 = commandBase[i].type;
          if (iVar10 == 0) goto MainLoop_commandSwitchDefault;
          switch(iVar10) {
          case 1:
            AudioCmn_PlayFESFX(0);
            this->backList[(u_char)this->fPlayer][this->backDepth[(u_char)this->fPlayer]] =
                 this->fCurrentMenu[(u_char)this->fPlayer];
            this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + 1;
            goto MainLoop_setMenuAndNext;
          case 2:
            AudioCmn_PlayFESFX(0);
            this->backDepth[(u_char)this->fPlayer] = 0;
MainLoop_setMenuAndNext:
            this->SetMenu((u_short)(u_char)this->fPlayer,
                    commandBase[i].nextMenu);
            i = i + kPlayerTwo;
            goto MainLoop_perPlayerInputTop;
          case 3:
            AudioCmn_PlayFESFX(0);
            this->backList[(u_char)this->fPlayer][this->backDepth[(u_char)this->fPlayer]] =
                 this->fCurrentMenu[(u_char)this->fPlayer];
            needToSetChildMenu = true;
            this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + 1;
            stackBackupPin = (short)this->backDepth[(u_char)this->fPlayer];
            this->SetMenu((u_short)(u_char)this->fPlayer,
                    commandBase[i].nextMenu);
            this->backDepth[1] = 0;
            break;
          case 4:
            if (((this->fPlayer != '\0') || (this->backDepth[0] <= (int)stackBackupPin)) &&
               ((this->fPlayer != '\x01' || (this->backDepth[(u_char)this->fPlayer] < 1)))) {
              wasSubMenu = (u_int)(u_char)this->fPlayer;
              if (this->waitingForOtherPlayer[wasSubMenu] != 0) {
                this->waitingForOtherPlayer[wasSubMenu] = 0;
                break;
              }
              *(u_int *)((int)this + (1 - wasSubMenu) * 4 + 0x230) = 0;
              this->waitingForOtherPlayer[(u_char)this->fPlayer] = 0;
            }
            if (this->fPlayer == '\0') {
              if ((this->backDepth[0] != (int)stackBackupPin) ||
                 (this->fCurrentMenu[1] == (tMenu *)0x0)) {
                goto MainLoop_backoutPath;
              }
              ptVar17 = this->fParentMenu[0];
              if (ptVar17 != (tMenu *)0x0) {
                (*(*ptVar17->_vf)[5].pfn)
                          ((int)ptVar17->fItemList + (*ptVar17->_vf)[5].delta + -0x10);
              }
              ptVar17 = this->fParentMenu[1];
              if (ptVar17 != (tMenu *)0x0) {
                (*(*ptVar17->_vf)[5].pfn)
                          ((int)ptVar17->fItemList + (*ptVar17->_vf)[5].delta + -0x10);
              }
              pa_Var11 = this->fCurrentMenu[1]->_vf;
              stackBackupPin = -1;
              (*(*pa_Var11)[5].pfn)
                        ((int)this->fCurrentMenu[1]->fItemList + (*pa_Var11)[5].delta + -0x10);
              (this->fCurrentScreen[1])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
              this->backDepth[1] = 0;
MainLoop_backDepthCheck:
              if (this->backDepth[(u_char)this->fPlayer] < 1) {
                if ((u_char)this->fPlayer != 1) break;
                AudioCmn_PlayFESFX(1);
                i = i + kPlayerTwo;
                goto MainLoop_perPlayerInputTop;
              }
            }
            else {
MainLoop_backoutPath:
              if (this->fPlayer != '\x01') goto MainLoop_backDepthCheck;
              if (this->backDepth[1] < 1) {
                if (this->fCurrentMenu[1] != (tMenu *)0x0) {
                  ptVar17 = this->fCurrentMenu[1];
                  this->backDepth[0] = stackBackupPin + -1;
                  pa_Var11 = ptVar17->_vf;
                  (*(*pa_Var11)[5].pfn)((int)ptVar17->fItemList + (*pa_Var11)[5].delta + -0x10);
                  ptVar17 = this->fParentMenu[0];
                  if (ptVar17 != (tMenu *)0x0) {
                    (*(*ptVar17->_vf)[5].pfn)
                              ((int)ptVar17->fItemList + (*ptVar17->_vf)[5].delta + -0x10);
                  }
                  ptVar17 = this->fParentMenu[1];
                  if (ptVar17 != (tMenu *)0x0) {
                    (*(*ptVar17->_vf)[5].pfn)
                              ((int)ptVar17->fItemList + (*ptVar17->_vf)[5].delta + -0x10);
                  }
                  stackBackupPin = -1;
                  (this->fCurrentScreen[1])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
                  this->SetMenu(0,this->backList[0][this->backDepth[0]]);
                }
                goto MainLoop_backDepthCheck;
              }
            }
            AudioCmn_PlayFESFX(1);
            this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + -1;
            this->SetMenu((u_short)(u_char)this->fPlayer,
                    this->backList[(u_int)(u_char)this->fPlayer]
                                  [this->backDepth[(u_char)this->fPlayer]]);
            pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
            iVar10 = (*(*pa_Var11)[8].pfn)
                               ((int)this->fCurrentMenu[(u_char)this->fPlayer]->fItemList +
                                (*pa_Var11)[8].delta + -0x10);
            if (iVar10 != 0) {
              this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + 1;
            }
            break;
          case 6:
            iVar10 = 1 - (u_int)(u_char)this->fPlayer;
            if (*(int *)((int)this + iVar10 * 4 + 0x230) == 0) {
              this->waitingForOtherPlayer[(u_char)this->fPlayer] = 1;
              break;
            }
            *(u_int *)((int)this + iVar10 * 4 + 0x230) = 0;
            if (frontEnd.raceType != '\x06') goto MainLoop_carInfoStockGarage;
            AudioMus_StopSong(400);
            Init_Memcard(false,1);
            err = PinkSlipsNoError;
            player = 0;
            while ((player < 2) && (err == PinkSlipsNoError)) {
              (FEApp->NoInputMemCardDialog).string = TextSys_Word(player + 0x295);
              ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Display();
              while ((FEApp->NoInputMemCardDialog).fFullyOpen != 1)
              {
                FEApp->Redraw();
              }
              err = SavePinkSlipsCarsWithErrorDialogs((short)player,0,(u_short)(u_char)frontEnd.pinkSlipsCar[player]);
              if ((err != PinkSlipsNoError) && (player == 1)) {
                sprintf(string,TextSys_Word(0x297),PlayerName(0),1);
                (FEApp->NoInputMemCardDialog).string = string;
                SavePinkSlipsCarsWithErrorDialogs(0,1,-1);
              }
              player = player + 1;
              ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
            }
            DeInit_Memcard();
            if (err == PinkSlipsNoError) goto MainLoop_carInfoPinkSlips;
            this->UpdateMusic();
            AudioMus_Volume((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
            i = i + kPlayerTwo;
            goto MainLoop_perPlayerInputTop;
          case 5:
          case 7:
MainLoop_carInfoPinkSlips:
            if (frontEnd.raceType == '\x06') {
              carManager.GetPinkSlipsCar((u_short)(u_char)frontEnd.pinkSlipsCar[(u_char)this->fPlayer],
                         carInfo,(u_short)(u_char)this->fPlayer);
              goto MainLoop_carInfoApplied;
            }
MainLoop_carInfoStockGarage:
            if (frontEnd.carListType == '\0') {
              carManager.GetStockCar((u_short)(u_char)frontEnd.playerCar[(u_char)this->fPlayer],carInfo)
              ;
            }
            else {
              carManager.GetGarageCar((u_short)(u_char)frontEnd.garageCar[(u_char)this->fPlayer],carInfo,
                         (u_short)(u_char)this->fPlayer);
            }
MainLoop_carInfoApplied:
            ticks_l351 = ticks;
            if (carInfo.fEnginePatch != 0) {
              AudioCmn_PlayFESFX((u_int)carInfo.fEnginePatch);
              ticks_l351 = ticks;
            }
            while ((u_int)(ticks - ticks_l351) < 0x100) {
              FeAudio_systemtask(0);
            }
            GameSetup_gData.replayMode = 0;
            this->PerformMenuDestruction();
            return kApp_Command_StartRace;
          case 8:
            GameSetup_gData.replayMode = 2;
            this->PerformMenuDestruction();
            return kApp_Command_StartReplay;
          }
MainLoop_commandSwitchDefault:
          i = i + kPlayerTwo;
          goto MainLoop_perPlayerInputTop;
        }
      }
MainLoop_nextPlayer:
      this->fPlayer = this->fPlayer + '\x01';
    }
    if (doRedraw) {
      this->Redraw();
    }
    if (0xf00 < tick - demoLoopLastInputTick) {
      this->RunDemoVideo();
      demoLoopLastInputTick = ticks;
    }
  } while( true );
}



/* ---- tFEApplication::RunPostGame  [FEAPP.CPP:992-1122] SLD-VERIFIED ---- */

tAppCommand tFEApplication::RunPostGame()

{
  tGlobalMenuDefs *ptVar1;
  tScreenUserName *ptVar2;
  u_short uVar3;
  void *pvVar4;
  tAppCommand tVar5;
  tUserNameMenuItem *this_tUserNameMenuItem_l112;
  tUserNameMenuItem *this_tUserNameMenuItem_l119;
  int ret;
  tOptionsMenu *m_tOptionsMenu_l112;
  tOptionsMenu *m_tOptionsMenu_l119;
  tScreenUserName *this_tScreenUserName_l112;
  tScreenUserName *this_tScreenUserName_l119;
  tFEApplication *ptVar7;
  int i;
  int iVar8;
  Car_tStats *dummyCars;
  short recordLap;
  tMenuCommand command;
  short nBestCarIndex;
  
  if ((frontEnd.raceType != '\x06') &&
     ((frontEnd.raceType != '\0' || (frontEnd.carListType != '\0')))) {
    StatChk_ClearNewRecords();
    dummyCars = (Car_tStats *)Cars_gNewCarStatsList;
    ptVar7 = this;
    i = 0;
    do {
      iVar8 = i + 1;
      Front_ResetPSXController(i,(u_int)(u_char)frontEnd.controlConfig[i]);
      ptVar7->gotName[0] = 0;
      ptVar7->needName[0] = 0;
      ptVar7->speechToPlay[0] = -1;
      ptVar7 = (tFEApplication *)ptVar7->fCurrentMenu;
      i = iVar8;
    } while (iVar8 < 2);
    pvVar4 = StatChk_IsRecordLapTime(dummyCars,Cars_gNumRaceCars,&recordLap);
    if (pvVar4 != (void *)0x0) {
      if (frontEnd.gameMode == '\x01') {
        ret = 7;
        if (nBestCarIndex != 0) {
          ret = 8;
        }
        this->speechToPlay[nBestCarIndex] = ret;
      }
      else {
        this->speechToPlay[nBestCarIndex] = 6;
      }
      this->needName[nBestCarIndex] = 1;
    }
    uVar3 = StatChk_IsTopTime(dummyCars,Cars_gNumRaceCars);
    if (uVar3 != 0) {
      if (frontEnd.gameMode == '\x01') {
        if ((uVar3 & 3) != 0) {
          this->needName[0] = 1;
          if ((this->speechToPlay[0] == -1) || (nBestCarIndex != 0)) {
            ret = 1;
            if ((uVar3 & 2) == 0) {
              ret = 4;
            }
          }
          else {
            ret = 10;
            if ((uVar3 & 2) == 0) {
              ret = 0xd;
            }
          }
          this->speechToPlay[0] = ret;
        }
        if ((uVar3 & 0xc) != 0) {
          this->needName[1] = 1;
          if ((this->speechToPlay[1] == -1) || (nBestCarIndex != 1)) {
            if ((uVar3 & 8) == 0) {
              this->speechToPlay[1] = 5;
            }
            else {
              this->speechToPlay[1] = 2;
            }
          }
          else if ((uVar3 & 8) == 0) {
            this->speechToPlay[1] = 0xe;
          }
          else {
            this->speechToPlay[1] = 0xb;
          }
        }
      }
      else {
        this->needName[0] = 1;
        if (this->speechToPlay[0] == -1) {
          ret = 3;
          if ((uVar3 & 2) != 0) {
            this->speechToPlay[0] = 0;
            goto RunPostGame_setupNameMenu;
          }
        }
        else {
          ret = 9;
          if ((uVar3 & 2) == 0) {
            ret = 0xc;
          }
        }
        this->speechToPlay[0] = ret;
      }
    }
RunPostGame_setupNameMenu:
    ptVar1 = menuDefs[0];
    if (this->needName[0] != 0) {
      command.nextMenu = (tMenu*)&menuDefs[0]->menuPostGamePlayer1Name;
      (menuDefs[0]->menuItemUserName1).fData = frontEnd.playerNameList[0];
      ptVar2 = screenUserName;
      (ptVar1->menuItemUserName1).fPlayer = 0;
      (ptVar1->menuItemUserName1).fMaxStringLength = 7;
      (ptVar1->menuItemUserName1).fCurrentRow = 0;
      (ptVar1->menuItemUserName1).fCurrentColumn = 0;
      ptVar2->callingMenu = (tOptionsMenu *)command.nextMenu;
      goto RunPostGame_callMainLoop;
    }
    if (this->needName[1] != 0) {
      command.nextMenu = (tMenu*)&menuDefs[0]->menuPostGamePlayer2Name;
      (menuDefs[0]->menuItemUserName2).fPlayer = 1;
      (ptVar1->menuItemUserName2).fData = frontEnd.playerNameList[4];
      ptVar2 = screenUserName;
      (ptVar1->menuItemUserName2).fMaxStringLength = 7;
      (ptVar1->menuItemUserName2).fCurrentRow = 0;
      (ptVar1->menuItemUserName2).fCurrentColumn = 0;
      ptVar2->callingMenu = (tOptionsMenu *)command.nextMenu;
      goto RunPostGame_callMainLoop;
    }
  }
  MenuExtended_PostGameMenu(command);
RunPostGame_callMainLoop:
  tVar5 = this->MainLoop(command.nextMenu);
  return tVar5;
}



/* ---- tFEApplication::RunFrontEnd  [FEAPP.CPP:1126-1134] SLD-VERIFIED ---- */

tAppCommand tFEApplication::RunFrontEnd()

{
  tAppCommand tVar1;
  
  tVar1 = this->MainLoop((tMenu*)&menuDefs[0]->menuMain);
  return tVar1;
}

/* ---- FreeHelpShapeCluts__Fv  [@0x80013ff4] ---- RECONSTRUCTED 2026-06-12 (Ghidra @NFS4.EXE.c:2489).
 *  Free fn in FEApp.obj (sits among tFEApplication methods; already called @feapp.cpp:591), skipped
 *  from the original pass. Releases the 0x3b help-shape CLUTs. func_0x800df9a4 = Texture_MenuReleaseClutId. */
extern tTexture_ShapeInfo *gHelpShapes[];          /* @0x80052a64; unsized-array view (sec.3.15): materialise &gHelpShapes into a genreg, shared across the loop loads */
void Texture_MenuReleaseClutId(short clutID);      /* @0x800df9a4 */

void FreeHelpShapeCluts(void)
{
  int i;
  for (i = 0; i < 0x3b; i++) {
    if (gHelpShapes[0][i].clutID != 0) {
      Texture_MenuReleaseClutId((short)gHelpShapes[0][i].clutID);
      gHelpShapes[0][i].clutID = 0;
    }
  }
}



/* end of feapp.cpp */
