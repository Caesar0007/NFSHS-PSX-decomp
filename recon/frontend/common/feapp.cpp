/* frontend/common/feapp.cpp -- RECONSTRUCTED (NFS4 FE application core; C++ TU)
 *   14 fns: tFEApplication ctor/dtor + dialog setup, FE main loop, video/movie cycling.
 *   Member defs; base ctors via init-lists; manual _vf vtable init.
 */
#define FEAPP_DEFINE_DIALOG_CTORS
#include "../../lib/nfs4_new.h"
#include "feapp.h"

extern int ticks_array[] __asm__("ticks");

typedef struct tPsyQPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tPsyQPrimTag;

/* ---- FEApp.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; types match the
   feapp_externs.h decls all FE TUs consume). FEApp = the global FE application pointer. ---- */
u_long          gLargestUnused[1];   /* @0x800514b8; SYM-CARRIER: gLargestUnused -- ULONG[1] forces retail value-load addressing */
tFEApplication *FEApp;            /* @0x800514c0  global FE application pointer */
extern int Draw_gDoVSync_arr[] asm("Draw_gDoVSync");

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

inline tDialogHelp::tDialogHelp()
{
  *(void **)&_vf = (void *)tDialogHelp_vtable;
  variant = -1;
  timeOutTicks = 0x578;
}

inline tDialogMessageStringWithTimeout::tDialogMessageStringWithTimeout()
{
  *(void **)&_vf = (void *)tDialogMessageStringWithTimeout_vtable;
  timeOutTicks = 0x480;
}

inline tDialogNoInputMessage::tDialogNoInputMessage()
{
  *(void **)&_vf = (void *)tDialogNoInputMessage_vtable;
}


/* ---- tFEApplication::ctor  [FEAPP.CPP:89-95] SLD-VERIFIED ---- */

tFEApplication::tFEApplication()

{
  int i;
  i = 0;
  do {
    this->gotName[i] = 0;
    this->needName[i] = 0;
    this->speechToPlay[i] = -1;
    i = i + 1;
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
  Draw_gDoVSync_arr[0] = 1;
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
    screen = *(int *)((char *)this + off + 0xc);
    if (screen != 0) {
      (**(int (**)(...))(*(int *)(screen + 0x60) + 0x3c))
                (screen + *(short *)(*(int *)(screen + 0x60) + 0x38));
    }
    i = i + 1;
    *(u_int *)((char *)this + off + 0xc) = 0;
  } while (i < 2);
  AudioMus_StopSong(1000);
  Draw_gDoVSync_arr[0] = 0;
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
 *  - the compound `x += 5 + difference` makes gcc form retail's `v1=x+5` before the subtract,
 *    but shortens x's global-alloc live length and initially swapped x/y ($s2/$s3).  GCC 2.8.1
 *    flow/global-alloc dumps identify the exact dial: y needs one more weighted reference.
 *    Duplicating the existing y-=8 in two pad[4].ID arms supplies that reference-family step;
 *    jump.c cross-jumps the identical updates back to one instruction and folds the condition
 *    into the immediately following pad-ID test.  Final output is byte-exact (254/254). */

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
      if (gPadinfo.buf[4].ID == '#') {
        y = y - 8;
      }
      else {
        y = y - 8;
      }
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
    x += 5 + (iVar4 - uVar3);
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
  short i;
  u_char saveFPlayer;
  short height;
  char buffer [32];
  DRAWENV *drenv;
  DR_AREA *daprim;
  RECT r;

  saveFPlayer = this->fPlayer;
  FeAudio_systemtask(0);
  Draw_StartFrameRender();
  Draw_StartRenderingView(Draw_gPlayer1View);
  /* MATCH: retail keeps these adjacent format strings as distinct symbols.  Expressing both as
     bigBuf offsets lets GCC common their base into a long-lived saved register (152 diffs). */
  sprintf(buffer,D_80010044,largestunused());
  FETextRender_FullText(buffer,0x100,0xd7,textType_FramedInfo,textState_Selected,0);
  sprintf(buffer,D_80010048,AudioMus_Buffered(),AudioMus_Threshold());
  FETextRender_FullText(buffer,0x10,0xd7,textType_FramedInfo,textState_Hilighted,0);
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  if (this->fCurrentMenu[1] != (tMenu *)0x0) {
    height = (short)(((u_int)screenheight + ((u_int)screenheight >> 0x1f)) >> 1);
  }
  else {
    height = (short)screenheight;
  }
  tDialogBase::DrawAllDialogs();
  this->DrawHelpIcons();
  if ((gPadinfo.buf[0].nopad != '\0') || (gPadinfo.buf[4].nopad != '\0')) {
    tGlobalMenuDefs *globalMenuDefs = menuDefs[0];
    (globalMenuDefs->itemMainTwoPlayerRace).fFlags
         = (globalMenuDefs->itemMainTwoPlayerRace).fFlags | 1;
    tMenuCommand emptycommand;
    tInputKeyType JustOneToPass = kInput_KeyType_Up;
    if ((tMenuItemGoToMenuNFS4Button *)
        this->fCurrentMenu[0]->fItemList[this->fCurrentMenu[0]->fCurrentItem] ==
        &globalMenuDefs->itemMainTwoPlayerRace) {
      (&globalMenuDefs->menuMain)->ProcessInput(kPlayerOne,JustOneToPass,emptycommand);
    }
  }
  else {
    (menuDefs[0]->itemMainTwoPlayerRace).fFlags
         = (menuDefs[0]->itemMainTwoPlayerRace).fFlags & 0xfffffffe;
  }
  if (gPadinfo.buf[0].nopad != '\0') {
    tGlobalMenuDefs *globalMenuDefs = menuDefs[0];
    (globalMenuDefs->itemMainOnePlayerRace).fFlags
         = (globalMenuDefs->itemMainOnePlayerRace).fFlags | 1;
    tMenuCommand emptycommand;
    tInputKeyType JustOneToPass = kInput_KeyType_Down;
    if ((tGlobalMenuDefs *)this->fCurrentMenu[0]->fItemList[this->fCurrentMenu[0]->fCurrentItem]
        == globalMenuDefs) {
      (&globalMenuDefs->menuMain)->ProcessInput(kPlayerOne,JustOneToPass,emptycommand);
    }
  }
  else {
    (menuDefs[0]->itemMainOnePlayerRace).fFlags
         = (menuDefs[0]->itemMainOnePlayerRace).fFlags & 0xfffffffe;
  }
  {
  u_char **packetCell = (u_char **)0x1f800004;
  daprim = (DR_AREA *)*packetCell;
  r.x = 0;
  r.y = *(short *)((char *)drenv + 2);
  r.w = 0x200;
  r.h = (short)screenheight;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  *packetCell = (u_char *)daprim + 0xc;
  SetDrawArea(daprim,&r);
  }
  for (i = 1; i >= 0; i--) {
    this->fPlayer = (char)i;
    this->fYOffset = (u_char)this->fPlayer * height;
    if (this->fCurrentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
      (*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[10].pfn)
                ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                 (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[10].delta);
    }
    if (this->fParentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
      (*(*this->fParentMenu[(u_char)this->fPlayer]->_vf)[10].pfn)
                ((char *)this->fParentMenu[(u_char)this->fPlayer] +
                 (*this->fParentMenu[(u_char)this->fPlayer]->_vf)[10].delta);
    }
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->UpdateTransition();
    }
    if ((this->fCurrentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) &&
       ((*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[8].pfn)
                ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                 (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[8].delta) != 0)) {
      (*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[9].pfn)
                ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                 (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[9].delta);
    }
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(false);
    }
    if (this->fCurrentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
      if ((this->waitingForOtherPlayer[(u_char)this->fPlayer] == 0) ||
          (((*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[7].pfn)
                ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                 (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[7].delta) == 0) &&
           ((*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[8].pfn)
                ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                 (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[8].delta) == 0))) {
        (*(*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[9].pfn)
                  ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                   (*this->fCurrentMenu[(u_char)this->fPlayer]->_vf)[9].delta);
      }
      if (this->fParentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
        (*(*this->fParentMenu[(u_char)this->fPlayer]->_vf)[9].pfn)
                  ((char *)this->fParentMenu[(u_char)this->fPlayer] +
                   (*this->fParentMenu[(u_char)this->fPlayer]->_vf)[9].delta);
      }
    }
    /* MATCH (W60-A10): the WHOLE 10-diff residual of this fn is ONE window --
       retail builds the FULL scratchpad constant 0x1F800004 into a caller-saved
       temp (`lui t0,8064; ori t0,t0,4`) and uses it at displacement 0 for BOTH
       the join-block read (`lw a0,0(t0)`) and the store (`sw v0,0(t0)`), with
       reorg stealing that `lui` into the preceding `beqz` delay slot.  Ours
       instead folds the address per access: `lui a0,8064; lw a0,4(a0)` +
       `lui at,8064; sw v0,4(at)` + a `nop` in the slot.  Same insn COUNT
       (393/393), so it is a pure address-materialisation shape.
       ROOT CAUSE of every failed cure: an explicit `u_char **cell =
       (u_char **)0x1f800004;` local IS the right shape (it is exactly what the
       FIRST packet block above uses, and that block matches), but HERE the
       block sits inside the `for (i = 1; i >= 0; i--)` loop, so loop.c hoists
       the loop-invariant address into the preheader -> it needs a CALLEE-saved
       reg -> +1 saved reg, +8 frame bytes and a whole s-band rotation.
       FALSIFIED (all measured, base = 10):
         join-read + cell local 89 (394, s7 added) . cell in both arms 39 (390,
         cross-jump merged the arms) . cell before the guard 39 . store-only
         cell 39/66 . join-read on the bare macro 58 . fn-scope cell reused
         from the first block 80 . fn-scope re-assigned 57 . fn-scope 2nd cell
         10 (inert) / 14 . anti-cross-jump void fence in one/both arms 42
         (count restored to 393, coloring worse) . identity(opacity) fence on
         the cell to defeat the LICM hoist 55 (394) . volatile cell 115 .
         fenced store-only cell 66.
       => the missing device is a SELECTIVE anti-LICM that leaves the pseudo
       block-local (09G goto-back-edge class), or the local-alloc handout
       itself.  Do not re-run the list above.

       W60-A10 ROUND 2 (parasite-eve-2 idiom corpus, DECOMPILATION_LEARNINGS.md):
       three more cures from another team's catalog, all falsified here --
       "ptr = (u8*)&global; ptr += 4" two-step address (their shared-%hi-base
       lever) 89 (394); pointer-TO-volatile `u_char *volatile *cell` (their
       indexed-volatile-array lever, which is NOT the same as a volatile
       VARIABLE) 89 (394); the two-step cell on the STORE only 70 (395); a
       pointer-to-volatile cell on the store only 34 (393, count-exact but a
       worse basin).  Their "Reload a global (not the local pointer) to fill a
       branch delay with lui" law is the right FAMILY -- retail's `lui t0,8064`
       IS a delay-slot fill -- but it prescribes what we already do (name the
       global), so the residual is upstream of the spelling.

       W62-A15 -- NAMED ANGLE, sharpened by a same-wave POSITIVE CONTROL.  The
       device this fn's whole falsification list is reaching for DOES work and
       is proven this wave in a sibling TU: screentracks.cpp's
       tScreenTrackSelect::DrawBackground carries
           u_char **packetPtrSlot = &Render_gPacketPtr;
       and its cc1plus output is retail's shape verbatim --
           li $10,0x1f800000 ; ori $10,$10,0x0004 ; ... lw $fp,0($10)
           ... sw $v1,0($10)
       i.e. the FULL literal in ONE caller-saved temp with displacement 0 at
       BOTH the read and the write, which is exactly what is missing here.
       The only structural difference between the two sites is that
       screentracks' block is straight-line while ours sits inside
       `for (i = 1; i >= 0; i--)`, so loop.c hoists the invariant address into
       the preheader and the pseudo must go callee-saved.  That isolates the
       blocker to ONE named question instead of a spelling search:
         WANTED = a SELECTIVE anti-LICM that leaves the address pseudo
         block-local.  13C's "LICM TIPS AT N OCCURRENCES (drop one
         occurrence)" is the closest catalogued handle and is the next thing
         to price: our block has exactly TWO in-loop occurrences of the cell
         (the join read and the store) and retail rematerialises at both, so
         the target is to keep combine_movables BELOW its tipping point rather
         than to fight the hoist after it happens.
       Do NOT re-run the 17 spellings above -- every one is downstream of the
       hoist.  Working control to diff against: screentracks.cpp
       DrawBackground (+ its W62-A15 TEXT_MOVES row).

       W64-A16 -- THE LICM BLOCKER IS SOLVED; THE RESIDUAL IS A NEW, SMALLER ONE.
       Recipe (measured, NOT landed because 14 > this basin's 10):
         (1) a FUNCTION-SCOPE `u_char **pc;` -- a block-scope declaration inside
             the for body plants a NOTE_INSN_BLOCK_BEG, which switches OFF
             jump.c:2296 duplicate_loop_exit_test and re-rotates the whole loop
             (55 diffs, bltz-vs-bgez); decl POSITION inside the fn decl list is
             completely inert (5 positions x 2 types all 28);
         (2) the ARM-DUPLICATED assignment `pc = (u_char **)0x1f800004;` in BOTH
             arms of the fCurrentScreen if/else -- two SETs in the loop, so
             loop.c never builds a movable (13C/loop.c scan_loop) and the final
             cross_jump merges the two `li` back into one at the join;
         (3) the read at the JOIN, the store through `*pc`;
         (4) a read-only fence `__asm__("" : : "r"(daprim));` right after the
             join read -- WITHOUT it daprim loses $a0 to the extra pseudo and
             pays two `addu a0,tN,zero` copies (28 diffs @395).
       Result: 14 diffs @393/393 with the ENTIRE address window byte-exact --
       `lui t0,8064` stolen into the beqz slot, `lui t0/ori t0,t0,4/lw a0,0(t0)`
       at the join and `sw v0,0(t0)`, i.e. every diff this block was ever about
       is gone.  The 14 that remain are TWO new facts: (a) fYOffset lands $a1
       for us and $a2 for retail, with retail materialising `addiu a1,sp,56`
       earlier; (b) reorg fills the SetDrawArea jal slot with our packet store
       where retail fills it with the palette store (our packet store is emitted
       last).  Fence position x operand-count is a PLATEAU at 14 (read/after-r.x
       = 14, after-r.y = 19, after-r.h = 24; 1/2/3 operands identical).
       FALSIFIED here, all reverted: the struct-view alias dial (a one-member
       `typedef struct { u_char *pkt; }` at 0x1f800004 to flip MEM_IN_STRUCT_P,
       14D/15C) is EXACTLY INERT -- 14 with it, 14 without, so w63-A16's
       "find a struct view of *cell" ask is answered NO; the same struct view in
       the pre-fence basin is 54@393 and at base 0x1F800000 (offset 4) 55@394;
       splitting the comma-expression to put the packet store between the two
       prim-tag statements costs +7 insns (69@400) because the shared palette
       load is lost, and a 3-way comma with the store in the middle is the same
       69@400 (store first = 26@393); ONE shared fn-scope cell for BOTH packet
       blocks 58; two short-lived cells 89 (cse merges them); block-1 written
       with the literal macro instead of its own cell is EXACTLY 10 -- i.e. the
       `packetCell` local there is cosmetic, cse commons the constant address by
       itself in a straight-line block.
       => NAMED ANGLE (replaces the w63 one): in the 14-diff basin, make daprim's
       block-local qty win $a0 in the FIRST packet block too and give retail's
       `addiu a1,sp,56` its early position -- an ordering question inside one
       basic block, not an address-materialisation one.  Harnesses:
       scratchpad/w64a16/rw{,2,3,4,5,6,7,8,9,10}.py.
       W67-A8 LAND-VS-HOLD DECISION (2026-08-15, re-gated: this body 10 @393/393):
       the banked 14-basin buys the byte-exact address window at 14 diffs, same
       insn count, and its residual is the named serving-order angle above.  By
       the gate bar (10 < 14 at equal count) the 14-basin stays BANKED, not
       landed; revisit only when the serving-order angle has an instrument. */
    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    else {
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    {
    r.x = 0;
    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;
    r.w = 0x200;
    r.h = height;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = (u_char *)daprim + 0xc;
    SetDrawArea(daprim,&r);
    }
  }
  this->fPlayer = saveFPlayer;
  Draw_StopRenderingView(Draw_gPlayer1View);
  Draw_StopFrameRender();
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



/* ---- FreeHelpShapeCluts__Fv  [@0x80013ff4] ---- RECONSTRUCTED 2026-06-12 (Ghidra @NFS4.EXE.c:2489).
 *  Free fn in FEApp.obj (sits among tFEApplication methods; already called @feapp.cpp:591), skipped
 *  from the original pass. Releases the 0x3b help-shape CLUTs. func_0x800df9a4 = Texture_MenuReleaseClutId. */
extern tTexture_ShapeInfo *gHelpShapes[];          /* @0x80052a64; unsized-array view (sec.3.15): materialise &gHelpShapes into a genreg, shared across the loop loads */
void Texture_MenuReleaseClutId(short clutID);      /* @0x800df9a4 */

static void FreeHelpShapeCluts(void)
{
  int i;
  for (i = 0; i < 0x3b; i++) {
    if (gHelpShapes[0][i].clutID != 0) {
      Texture_MenuReleaseClutId((short)gHelpShapes[0][i].clutID);
      gHelpShapes[0][i].clutID = 0;
    }
  }
}



/* ---- tFEApplication::RunDemoVideo  [FEAPP.CPP:483-554] SLD-VERIFIED ---- */

/* MATCH (W65, 79->PASS): SYM names only the 40-byte buffer and static
   currentVideo; the decompiler's boolean/result/vtable/screen temporaries
   were all compiler values.  DisplayLoadingText is a static tScreen member
   (its body never uses `this`, and retail prepares no $a0).  Base-first
   virtual adjustments and the post-largestunused staging below reproduce
   the hidden temporaries of the original native C++ virtual call. */

void tFEApplication::RunDemoVideo()

{
  static int currentVideo;
  char buffer [40];

  if ((tMenuNFS4 *)this->fCurrentMenu[0] == &menuDefs[0]->menuMain) {
    AudioMus_StopSong(0x78);
    FeAudio_systemtask(0);
    (*(*this->fCurrentMenu[0]->_vf)[5].pfn)
              ((char *)this->fCurrentMenu[0] + (*this->fCurrentMenu[0]->_vf)[5].delta);
    (this->fCurrentScreen[0])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
    while (((*(*this->fCurrentMenu[0]->_vf)[7].pfn)
                   ((char *)this->fCurrentMenu[0] +
                    (*this->fCurrentMenu[0]->_vf)[7].delta) == 0) ||
           ((*(*this->fCurrentScreen[0]->_vf)[8].pfn)
                   ((char *)this->fCurrentScreen[0] +
                    (*this->fCurrentScreen[0]->_vf)[8].delta) == 0)) {
      this->Redraw();
      FeAudio_systemtask(0);
    }
    (*(*this->fCurrentScreen[0]->_vf)[7].pfn)
              ((char *)this->fCurrentScreen[0] + (*this->fCurrentScreen[0]->_vf)[7].delta);
    Audio_FECleanUp();
    Audio_DeInitDriver();
    PSXFront_FreeDrawMemory();
    FeTools_deinit();
    FreeHelpShapeCluts();
    gLargestUnused[0] = largestunused();
    play_movie((u_char)(currentVideo + 1));
    gLargestUnused[0] = largestunused();
    PSXFront_AllocateDrawMemory();
    FeTools_init();
    tScreen::DisplayLoadingText();
    Audio_InitDriver(0xd800,0x18000);
    AudioCmn_LoadFESamples();
    LoadAllHelpShapes();
    this->UpdateMusic();
    AudioMus_Volume((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
    {
      /* These spell the hidden evaluation temporaries of a native virtual
         call; they are not additional semantic source state.  Loading both
         before publishing `largest` permits retail's load/load/store order. */
      int largest = largestunused();
      tMenu *menu = this->fCurrentMenu[0];
      __vtbl_ptr_type (*vtbl)[11] = menu->_vf;

      gLargestUnused[0] = largest;
      (*(*vtbl)[2].pfn)((char *)menu + (*vtbl)[2].delta);
    }
    (*(*this->fCurrentScreen[0]->_vf)[6].pfn)
              ((char *)this->fCurrentScreen[0] + (*this->fCurrentScreen[0]->_vf)[6].delta);
    (*(*this->fCurrentMenu[0]->_vf)[6].pfn)
              ((char *)this->fCurrentMenu[0] + (*this->fCurrentMenu[0]->_vf)[6].delta);
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

/* PARTIAL (2026-08-09): restoring the per-player input pass as its structured
 * for-loop, and testing player two by truth value, reduces 404 -> 354 diffs.
 * The frame remains the retail 408 bytes and the command-array base now receives
 * retail $s7; the two-instruction size residual is still allocator/source shape. */
/* PARTIAL (2026-08-11): 60 -> 3 diffs.  The explicit player-two comparison paired
 * with removal of the artificial one-use enum local restores the retail lifetime;
 * the case-4 memory fence preserves retail's second current-menu load; and narrow
 * identity/read fences around the case-3 depth/flag sequence restore its exact
 * load/store order.  A one-site unsized-array view of scalar `ticks` restores the
 * retail final load destination ($v0) without changing the earlier scalar accesses.
 * A scalar `ticksValue` plus a post-load read-only fence keeps the address live just
 * long enough for retail's `$t0` base / `$v0` value split (7 -> 3).  Remaining is
 * only the post-dialog `lw tick` schedule and its avoidable load-delay nop.  Splitting
 * the dialog declaration, a post-call value funnel, chained tick stores, and a
 * pre-call tick carrier were neutral; fencing function- or block-scope `tick`
 * rotates the whole `$t0/$t1` scratch band (255) and was rejected. */

tAppCommand tFEApplication::MainLoop(tMenu *newMenu)

{
  short stackBackupPin;
  bool wasSubMenu;
  bool needToSetChildMenu;
  bool doRedraw;
  u_long ticksAtLastInput [2];
  u_long tick;
  short inputStartPlayer;
  short inputEndPlayer;
  short i;
  int demoLoopLastInputTick;
  char string [80];
  PinkSlipsErrorCode err;
  int player;
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
  {
  tMenuCommand command [2];
  tInputKeyType keyVal [2];
  tCarInfo carInfo;
  u_long ticks_l351;
  do {
    tick = ticks;
    doRedraw = true;
    this->fPlayer = '\0';
    while ((u_char)this->fPlayer < 2) {
      if (this->fTransitionToMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
        ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
        wasSubMenu = 0;
        if (ptVar17 != (tMenu *)0x0) {
          iVar10 = (*(*ptVar17->_vf)[7].pfn)
                           ((char *)ptVar17 + (*ptVar17->_vf)[7].delta);
          if (iVar10 != 0) {
            tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
            if (ptVar18 != (tScreen *)0x0) {
              iVar10 = (*(*ptVar18->_vf)[8].pfn)
                               ((char *)ptVar18 + (*ptVar18->_vf)[8].delta);
              wasSubMenu = (u_int)(iVar10 != 0);
            }
          }
          if (wasSubMenu == 0) goto MainLoop_subMenuDetect;
          ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
          wasSubMenu = 0;
          if (ptVar17 != (tMenu *)0x0) {
            wasSubMenu =
                 ((bool (*)(...))(*ptVar17->_vf)[8].pfn)
                           ((char *)ptVar17 + (*ptVar17->_vf)[8].delta);
          }
        }
        pa_Var11 = this->fTransitionToMenu[(u_char)this->fPlayer]->_vf;
        iVar10 = (*(*pa_Var11)[8].pfn)
                           ((char *)this->fTransitionToMenu[(u_char)this->fPlayer] +
                            (*pa_Var11)[8].delta);
        if (iVar10 != 0) {
          this->fParentMenu[(u_char)this->fPlayer] = this->fCurrentMenu[(u_char)this->fPlayer];
        }
        else {
          this->fParentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
        }
        this->fCurrentMenu[(u_char)this->fPlayer] = this->fTransitionToMenu[(u_char)this->fPlayer];
        pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
        (*(*pa_Var11)[2].pfn)
                  ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                   (*pa_Var11)[2].delta);
        this->fTransitionToMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
        if ((wasSubMenu != 0) && (this->fTransitionToScreen[0] == (tScreen *)0x0)) {
          doRedraw = false;
          this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + -1;
        }
        else {
          pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
          (*(*pa_Var11)[6].pfn)
                    ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                     (*pa_Var11)[6].delta);
          if (needToSetChildMenu) {
            this_tMenu_l92 = (tMenu *)(u_int)(u_char)this->fPlayer;
            this->SetMenu(1,this->fCurrentMenu[(int)this_tMenu_l92]->fChildMenu);
            needToSetChildMenu = false;
          }
        }
        demoLoopLastInputTick = ticks;
      }
MainLoop_subMenuDetect:
      if ((u_char)this->fPlayer == kPlayerTwo) {
        ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
        if ((ptVar17 != (tMenu *)0x0) &&
            ((*(*ptVar17->_vf)[7].pfn)
                 ((char *)ptVar17 + (*ptVar17->_vf)[7].delta) != 0) &&
            ((int)((u_int)(u_short)stackBackupPin << 0x10) < 0)) {
          ptVar17 = this->fParentMenu[(u_char)this->fPlayer];
          if ((ptVar17 == (tMenu *)0x0) ||
              ((*(*ptVar17->_vf)[7].pfn)
                   ((char *)ptVar17 + (*ptVar17->_vf)[7].delta) != 0)) {
          this->fCurrentMenu[(u_char)this->fPlayer] = (tMenu *)0x0;
          tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
          if (ptVar18 != (tScreen *)0x0) {
            (*(*ptVar18->_vf)[7].pfn)
                      ((char *)ptVar18 + (*ptVar18->_vf)[7].delta);
          }
          this->fCurrentScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
          }
        }
      }
      if (this->fTransitionToScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
        tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
        if (ptVar18 != (tScreen *)0x0) {
          iVar10 = (*(*ptVar18->_vf)[8].pfn)
                             ((char *)ptVar18 + (*ptVar18->_vf)[8].delta);
          if ((iVar10 == 0) || (this->fTransitionToMenu[(u_char)this->fPlayer] != (tMenu *)0x0))
          goto MainLoop_perPlayerFlagCheck;
          tScreen *currentScreen = this->fCurrentScreen[(u_char)this->fPlayer];
          if (currentScreen != (tScreen *)0x0) {
            (*(*currentScreen->_vf)[7].pfn)
                      ((char *)currentScreen + (*currentScreen->_vf)[7].delta);
          }
        }
        this->fCurrentScreen[(u_char)this->fPlayer] = this->fTransitionToScreen[(u_char)this->fPlayer];
        gLargestUnused[0] = largestunused();
        pa_Var12 = this->fCurrentScreen[(u_char)this->fPlayer]->_vf;
        (*(*pa_Var12)[6].pfn)
                  ((char *)this->fCurrentScreen[(u_char)this->fPlayer] +
                   (*pa_Var12)[6].delta);
        this->fTransitionToScreen[(u_char)this->fPlayer] = (tScreen *)0x0;
        (this->fCurrentScreen[(u_char)this->fPlayer])->TransitionOn(kScreen_TransitionTypeScreen,
                   (tMenu *)0x0);
      }
MainLoop_perPlayerFlagCheck:
      bool perPlayer = false;
      if (this->fCurrentMenu[(u_char)this->fPlayer] != (tMenu *)0x0) {
        inputEndPlayer = (tPlayer)(u_char)this->fPlayer;
        inputStartPlayer = inputEndPlayer;
        u_int menuFlags = this->fCurrentMenu[(u_char)this->fPlayer]->fFlags;
        if (((menuFlags & 0x10) != 0) ||
           ((frontEnd.gameMode == kPlayerTwo && ((menuFlags & 8) == 0)))) {
          perPlayer = true;
        }
        if (perPlayer) {
          inputStartPlayer = kPlayerOne;
          inputEndPlayer = kPlayerTwo;
        }
        this_tMenu_l139 = this->fCurrentMenu[(u_char)this->fPlayer];
        u_int inputFlags = this_tMenu_l139->fFlags;
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
                                ((char *)this_tMenu_l139 +
                                 (*this_tMenu_l139->_vf)[7].delta), iVar10 != 0)) &&
           (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0)) {
          iVar10 = (*(*this->fCurrentScreen[(u_char)this->fPlayer]->_vf)[8].pfn)
                             ((char *)this->fCurrentScreen[(u_char)this->fPlayer] +
                              (*this->fCurrentScreen[(u_char)this->fPlayer]->_vf)[8].delta);
          wasSubMenu = iVar10 != 0;
        }
        if (wasSubMenu) {
          u_long debounce;
          pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
          debounce = (*(*pa_Var11)[4].pfn)
                                  ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                                   (*pa_Var11)[4].delta);
          for (i = inputStartPlayer; i <= inputEndPlayer; i++) {
          command[i].type = kMenu_Command_None;
          keyVal[i] = FEInput_GetKeyFromPlayer((tPlayer)i,debounce);
          if (keyVal[i] != kInput_KeyType_NoKey) {
            this->fInputPlayer = (char)i;
          }
          if ((0xf < ticks - ticksAtLastInput[i]) ||
             ((debounce & keyVal[i]) == kInput_KeyType_NoKey)) {
            this->fLastKeyPressed[i] = keyVal[i];
          }
          if (keyVal[i] != kInput_KeyType_NoKey) {
            tDialogBase *dialog = (tDialogBase *)tDialogBase::GetTopMostDialog();
            demoLoopLastInputTick = tick;
            ticksAtLastInput[i] = tick;
            /* MATCH: retail schedules the AUTO tick load before the dialog-result
             * move and feeds both stores without a load-use nop.  This pin-free,
             * zero-insn boundary reproduces that grouping (3 diffs -> PASS). */
            __asm__("" : : "i"(0));
            this_tDialogBase_l181 = (tDialogBase *)&this->helpPopup;
            if ((keyVal[i] == 4) && (this_tDialogBase_l181->currentlyOn != 0)) {
              keyVal[i] = kInput_KeyType_AlreadyProcessed;
              this_tDialogBase_l181->Hide();
            }
            if (dialog != 0) {
              if (keyVal[i] != kInput_KeyType_Circle) {
                (*(*dialog->_vf)[9].pfn)
                          ((char *)dialog + (*dialog->_vf)[9].delta,i,keyVal + i,command + i);
              }
            }
            tScreen *ptVar18 = this->fCurrentScreen[(u_char)this->fPlayer];
            if (ptVar18 != (tScreen *)0x0) {
              (*(*ptVar18->_vf)[9].pfn)
                        ((char *)ptVar18 + (*ptVar18->_vf)[9].delta,i,
                         keyVal + i,command + i);
            }
            if (keyVal[i] != kInput_KeyType_AlreadyProcessed) {
              pa_Var11 = this->fCurrentMenu[(u_char)this->fPlayer]->_vf;
              (*(*pa_Var11)[3].pfn)
                        ((char *)this->fCurrentMenu[(u_char)this->fPlayer] +
                         (*pa_Var11)[3].delta,i,keyVal + i,command + i);
            }
          }
          iVar10 = command[i].type;
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
                    command[i].nextMenu);
            continue;
          case 3:
            AudioCmn_PlayFESFX(0);
            this->backList[(u_char)this->fPlayer][this->backDepth[(u_char)this->fPlayer]] =
                 this->fCurrentMenu[(u_char)this->fPlayer];
            iVar10 = this->backDepth[(u_char)this->fPlayer];
            __asm__("" : "+r"(iVar10));
            needToSetChildMenu = true;
            __asm__("" : : "r"(needToSetChildMenu));
            this->backDepth[(u_char)this->fPlayer] = iVar10 + 1;
            stackBackupPin = (short)this->backDepth[(u_char)this->fPlayer];
            this->SetMenu((u_short)(u_char)this->fPlayer,
                    command[i].nextMenu);
            this->backDepth[1] = 0;
            break;
          case 4:
            /* BUG FIX (w59-a10 BRANCH-TARGET AUDIT).  This guard used to read
               `if (cond) goto MainLoop_doBack;` -- it gated PASS 1123/1123
               (verify_asm is branch-target lenient) but BOTH of its branch words
               were wrong: insn 700 `bnez v1` = 14600099 (ours) vs 1460001E
               (retail) and insn 710 `bgtz v0` = 1C40008F vs 1C400014.  Ours
               jumped 153 insns forward straight to AudioCmn_PlayFESFX (doBack);
               retail jumps only 30 forward, to .L80014E10 -- i.e. past the
               waitingForOtherPlayer handling and INTO the fPlayer==0 stack-pair
               block.  A real behaviour bug: with a pending back-request our
               build skipped the whole two-player stack-pair / player-1 unwind
               (and the `backDepth < 1` noBack test) and always played the back
               SFX.  The retail shape is a NEGATED guard around just the
               waitingForOtherPlayer block; instruction layout is unchanged. */
            if (!(((this->fPlayer == '\0') &&
                   ((int)stackBackupPin < this->backDepth[(u_char)this->fPlayer])) ||
                  ((this->fPlayer == '\x01') &&
                   (0 < this->backDepth[(u_char)this->fPlayer])))) {
              if (this->waitingForOtherPlayer[(u_char)this->fPlayer] != 0) {
                this->waitingForOtherPlayer[(u_char)this->fPlayer] = 0;
                break;
              }
              this->waitingForOtherPlayer[1 - (u_char)this->fPlayer] = 0;
              this->waitingForOtherPlayer[(u_char)this->fPlayer] = 0;
            }
            if (this->fPlayer == '\0') {
              if ((this->backDepth[(u_char)this->fPlayer] == (int)stackBackupPin) &&
                  (this->fCurrentMenu[1] != (tMenu *)0x0)) {
                ptVar17 = this->fParentMenu[0];
                if (ptVar17 != (tMenu *)0x0) {
                  (*(*ptVar17->_vf)[5].pfn)
                            ((char *)ptVar17 + (*ptVar17->_vf)[5].delta);
                }
                ptVar17 = this->fParentMenu[1];
                if (ptVar17 != (tMenu *)0x0) {
                  (*(*ptVar17->_vf)[5].pfn)
                            ((char *)ptVar17 + (*ptVar17->_vf)[5].delta);
                }
                ptVar17 = this->fCurrentMenu[1];
                pa_Var11 = ptVar17->_vf;
                stackBackupPin = -1;
                (*(*pa_Var11)[5].pfn)
                          ((char *)ptVar17 + (*pa_Var11)[5].delta);
                (this->fCurrentScreen[1])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
                this->backDepth[1] = 0;
                goto MainLoop_afterStackPair;
              }
            }
            if ((this->fPlayer == '\x01') &&
                (this->backDepth[(u_char)this->fPlayer] < 1) &&
                (this->fCurrentMenu[1] != (tMenu *)0x0)) {
              __asm__("" : : : "memory");
              ptVar17 = this->fCurrentMenu[1];
              this->backDepth[0] = stackBackupPin + -1;
              pa_Var11 = ptVar17->_vf;
              (*(*pa_Var11)[5].pfn)((char *)ptVar17 + (*pa_Var11)[5].delta);
              ptVar17 = this->fParentMenu[0];
              if (ptVar17 != (tMenu *)0x0) {
                (*(*ptVar17->_vf)[5].pfn)
                          ((char *)ptVar17 + (*ptVar17->_vf)[5].delta);
              }
              ptVar17 = this->fParentMenu[1];
              if (ptVar17 != (tMenu *)0x0) {
                (*(*ptVar17->_vf)[5].pfn)
                          ((char *)ptVar17 + (*ptVar17->_vf)[5].delta);
              }
              (this->fCurrentScreen[1])->TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
              stackBackupPin = -1;
              this->SetMenu(0,this->backList[0][this->backDepth[0]]);
            }
MainLoop_afterStackPair:
            if (this->backDepth[(u_char)this->fPlayer] < 1) goto MainLoop_noBack;
MainLoop_doBack:
            AudioCmn_PlayFESFX(1);
            this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + -1;
            this->SetMenu((u_short)(u_char)this->fPlayer,
                    this->backList[(u_int)(u_char)this->fPlayer]
                                  [this->backDepth[(u_char)this->fPlayer]]);
            ptVar17 = this->fCurrentMenu[(u_char)this->fPlayer];
            pa_Var11 = ptVar17->_vf;
            iVar10 = (*(*pa_Var11)[8].pfn)
                               ((char *)ptVar17 +
                                (*pa_Var11)[8].delta);
            if (iVar10 != 0) {
              this->backDepth[(u_char)this->fPlayer] = this->backDepth[(u_char)this->fPlayer] + 1;
            }
            break;
MainLoop_noBack:
            if ((u_char)this->fPlayer != 1) break;
            AudioCmn_PlayFESFX(1);
            continue;
          case 6:
            iVar10 = 1 - (u_int)(u_char)this->fPlayer;
            if (this->waitingForOtherPlayer[iVar10] == 0) {
              this->waitingForOtherPlayer[(u_char)this->fPlayer] = 1;
              break;
            }
            this->waitingForOtherPlayer[iVar10] = 0;
            if (frontEnd.raceType != '\x06') goto MainLoop_carInfoStockGarage;
            AudioMus_StopSong(400);
            Init_Memcard(false,1);
            err = PinkSlipsNoError;
            player = 0;
            do {
              if ((2 <= player) || (err != PinkSlipsNoError)) break;
              this_tDialogMessageString_l311 =
                   (tDialogMessageString *)&FEApp->NoInputMemCardDialog;
              this_tDialogMessageString_l311->string = TextSys_Word(player + 0x295);
              ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Display();
              while (true) {
                if (((FEApp->NoInputMemCardDialog).fFullyOpen ^ 1) == 0) break;
                FEApp->Redraw();
              }
              err = SavePinkSlipsCarsWithErrorDialogs((short)player,0,(u_short)(u_char)frontEnd.pinkSlipsCar[player]);
              if ((err != PinkSlipsNoError) && (player == 1)) {
                sprintf(string,TextSys_Word(0x297),PlayerName(0),1);
                (FEApp->NoInputMemCardDialog).string = string;
                SavePinkSlipsCarsWithErrorDialogs(0,1,-1);
              }
              ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
              player++;
            } while (true);
            DeInit_Memcard();
            if (err == PinkSlipsNoError) goto MainLoop_carInfoPinkSlips;
            this->UpdateMusic();
            AudioMus_Volume((int)((u_int)(u_char)frontEnd.musicVolume * 0x23) >> 6);
            continue;
          case 5:
          case 7:
MainLoop_carInfoPinkSlips:
            if (frontEnd.raceType != '\x06') {
MainLoop_carInfoStockGarage:
              if (frontEnd.carListType == '\0') {
                carManager.GetStockCar((u_short)(u_char)frontEnd.playerCar[(u_char)this->fPlayer],carInfo)
                ;
              }
              else {
                carManager.GetGarageCar((u_short)(u_char)frontEnd.garageCar[(u_char)this->fPlayer],carInfo,
                           (u_short)(u_char)this->fPlayer);
              }
            }
            else {
              carManager.GetPinkSlipsCar((u_short)(u_char)frontEnd.pinkSlipsCar[(u_char)this->fPlayer],
                         carInfo,(u_short)(u_char)this->fPlayer);
            }
MainLoop_carInfoApplied:
            if (carInfo.fEnginePatch != 0) {
              AudioCmn_PlayFESFX((u_int)carInfo.fEnginePatch);
            }
            ticks_l351 = ticks;
            while (true) {
              if ((u_int)(ticks - ticks_l351) >= 0x100) break;
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
          ;
          __asm__("" : : "r"(&command[0]));
          }
        }
      }
MainLoop_nextPlayer:
      this->fPlayer = this->fPlayer + '\x01';
    }
    if (doRedraw) {
      this->Redraw();
    }
    if (0xf00 < (int)(tick - demoLoopLastInputTick)) {
      this->RunDemoVideo();
      int ticksValue = ticks;
      __asm__("" : : "r"(ticksValue));
      demoLoopLastInputTick = ticksValue;
    }
  } while( true );
  }
}



/* ---- tFEApplication::RunPostGame  [FEAPP.CPP:992-1122] SLD-VERIFIED ---- */

tAppCommand tFEApplication::RunPostGame()

{
  tMenuCommand command;
  int ret;
  Car_tStats *dummyCars;
  int i;
  short nBestCarIndex;
  
  if ((frontEnd.raceType != '\x06') &&
     ((frontEnd.raceType != '\0' || (frontEnd.carListType != '\0')))) {
    dummyCars = (Car_tStats *)Cars_gNewCarStatsList;
    StatChk_ClearNewRecords();
    i = 0;
    do {
      Front_ResetPSXController(i,(u_int)(u_char)frontEnd.controlConfig[i]);
      this->gotName[i] = 0;
      this->needName[i] = 0;
      this->speechToPlay[i] = -1;
      i = i + 1;
    } while (i < 2);
    if (StatChk_IsRecordLapTime(dummyCars,Cars_gNumRaceCars,&nBestCarIndex) != 0) {
      if (frontEnd.gameMode == '\x01') {
        this->speechToPlay[nBestCarIndex] = nBestCarIndex ? 8 : 7;
      }
      else {
        this->speechToPlay[nBestCarIndex] = 6;
      }
      this->needName[nBestCarIndex] = 1;
    }
    if ((ret = StatChk_IsTopTime(dummyCars,Cars_gNumRaceCars)) != 0) {
      if (frontEnd.gameMode == '\x01') {
        if ((ret & 3) != 0) {
          this->needName[0] = 1;
          if ((this->speechToPlay[0] != -1) && (nBestCarIndex == 0)) {
            if ((ret & 2) != 0) {
              this->speechToPlay[0] = 10;
            }
            else {
              this->speechToPlay[0] = 0xd;
            }
          }
          else {
            if ((ret & 2) != 0) {
              this->speechToPlay[0] = 1;
            }
            else {
              this->speechToPlay[0] = 4;
            }
          }
        }
        if ((ret & 0xc) != 0) {
          this->needName[1] = 1;
          if ((this->speechToPlay[1] != -1) && (nBestCarIndex == 1)) {
            if ((ret & 8) != 0) {
              this->speechToPlay[1] = 0xb;
            }
            else {
              this->speechToPlay[1] = 0xe;
            }
          }
          else {
            if ((ret & 8) != 0) {
              this->speechToPlay[1] = 2;
            }
            else {
              this->speechToPlay[1] = 5;
            }
          }
        }
      }
      else {
        this->needName[0] = 1;
        if (this->speechToPlay[0] != -1) {
          if ((ret & 2) != 0) {
            this->speechToPlay[0] = 9;
          }
          else {
            this->speechToPlay[0] = 0xc;
          }
        }
        else {
          if ((ret & 2) != 0) {
            this->speechToPlay[0] = 0;
          }
          else {
            this->speechToPlay[0] = 3;
          }
        }
      }
    }
    if (this->needName[0] != 0) {
      tUserNameMenuItem *item = &menuDefs[0]->menuItemUserName1;
      tScreenUserName *screen = screenUserName;
      tOptionsMenu *m = &menuDefs[0]->menuPostGamePlayer1Name;
      item->fData = frontEnd.playerNameList[0];
      item->fPlayer = 0;
      item->fMaxStringLength = 7;
      item->fCurrentRow = 0;
      item->fCurrentColumn = 0;
      screen->callingMenu = m;
      return this->MainLoop((tMenu *)m);
    }
    if (this->needName[1] != 0) {
      tUserNameMenuItem *item = &menuDefs[0]->menuItemUserName2;
      tScreenUserName *screen = screenUserName;
      tOptionsMenu *m = &menuDefs[0]->menuPostGamePlayer2Name;
      item->fPlayer = 1;
      item->fData = frontEnd.playerNameList[4];
      item->fMaxStringLength = 7;
      item->fCurrentRow = 0;
      item->fCurrentColumn = 0;
      screen->callingMenu = m;
      return this->MainLoop((tMenu *)m);
    }
  }
  MenuExtended_PostGameMenu(command);
  return this->MainLoop(command.nextMenu);
}



/* ---- tFEApplication::RunFrontEnd  [FEAPP.CPP:1126-1134] SLD-VERIFIED ---- */

tAppCommand tFEApplication::RunFrontEnd()

{
  tAppCommand tVar1;
  
  tVar1 = this->MainLoop((tMenu*)&menuDefs[0]->menuMain);
  return tVar1;
}

/* end of feapp.cpp */
