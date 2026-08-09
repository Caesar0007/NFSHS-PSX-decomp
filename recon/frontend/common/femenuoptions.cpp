/* frontend/common/femenuoptions.cpp -- RECONSTRUCTED (options-menu widget hierarchy; C++ TU)
 *   83 fns across 16 classes (tOptionsMenu, tInsideBox family, tMenuItem sliders/choices/sliding
 *   menus, tUserNameMenuItem, tMemoryCardMenuItem) + 7 free helpers (flares, boxes, stick-range,
 *   cheat-check) + data. Member defs; deep tMenuItem/tMenu inheritance; manual _vf dispatch.
 */
#include "../../lib/nfs4_new.h"
#include "femenuoptions.h"

/* EXT/STAT data owned by FeMenuOptions.obj (byte-exact from retail binary) */
/* PulsateYellow: storage in front_data.data.s @0x800515ac; declared extern int[] in
 * femenuoptions_externs.h (store-[] lever §3.12 #5 -> addr in genreg not $at). */
extern int fHelpText[];       /* @0x800515b0, storage in front_data.data.s */
static int flareextra = 0;     /* file-static */

typedef struct tPsyQPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tPsyQPrimTag;


/* permuter-found register-materialization lever (score-0, iter 289): routing the
 * ticks[0] read through an inline pointer-arg helper (vs a direct array index)
 * changes how gcc schedules the two live copies of `ticks` needed by the signed
 * %128 idiom below -- verified byte-exact via verify_asm, not just permuter score. */
static inline int inline_fn(int *arg0)
{
  return arg0[0];
}

/* ---- CalcPulsateYellow  [FEMENUOPTIONS.CPP:77-82] SLD-VERIFIED ---- */
void CalcPulsateYellow(void)
{
  int pulsateval;

  pulsateval = inline_fn(ticks) % 0x80;
  if (0x40 < pulsateval) {
    pulsateval = 0x80 - pulsateval;
  }
  PulsateYellow[0] = CalcFadeVal(0xbebe,pulsateval);
  return;
}

/* ---- DrawLeftFlare  [FEMENUOPTIONS.CPP:86-108] SLD-VERIFIED ---- */

void DrawLeftFlare(int y,int fSelFade,int fFadeVal,int &flareextra)

{
  int iVar1;
  int iVar2;
  int x;
  int index;
  int flare_intensity;
  int glintFade;
  
  /* MATCH: write through the reference directly (oracle keeps the value in $v0:
     `lw v0; addiu v0,v0,1|5; sw v0`), no held temp -- the `+5` store is gated on
     `flareextra != 0` exactly as the oracle's `beqz v0,skip-the-store`. */
  if (fSelFade == 0x80) {
    flareextra = flareextra + 1;
  }
  else if (flareextra != 0) {
    flareextra = flareextra + 5;
  }
  if (0x3c < flareextra) {
    flareextra = 0;
  }
  /* NEAR-MISS 26 (was 74; length now EXACT 87/87).  W56-A5 landed FOUR fixes:
     (1) the triangle-clamp arms do a SIGNED /2 each (`srl;addu;sra`) laid out as
     an if/else with the constant-on-left test `0x1e < flareextra` -> the oracle's
     `slti;bnez` polarity (else=flareextra/2 out-of-line, 0x3c-flareextra inline);
     (2) DrawShapeExtended arg5/6 are `glintFade` + `(glintFade!=0)` (REAL bug: the
     old code passed flare_intensity + (flare_intensity!=0) and left glintFade dead
     -> `sw s3,0x10(sp)`, unsigned `sltu`); (3) the Flare arg3 half is
     `(flare_intensity + ((u_int)iVar2>>31))>>1` (`srl;addu` not `sra;subu`);
     (4) the increment writes through the reference directly (oracle keeps it in
     $v0).  RESIDUAL = a pure local-alloc numbering/coalescing swap in the multiply
     chain: retail chains /2->+20->product1 IN PLACE in $s1 then product2->$s2,
     flare_intensity->$s1; ours splits $s1/v0/t1/$s1/$s2.  §4.6 qtytrace gap. */
  if (0x1e < flareextra) {
    iVar2 = (0x3c - flareextra) / 2;
  }
  else {
    iVar2 = flareextra / 2;
  }
  iVar2 = (iVar2 + 0x14) * fSelFade * (0x80 - fFadeVal);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0x7f;
  }
  flare_intensity = iVar2 >> 7;
  glintFade = 0x80 - fSelFade;
  if (0x80 - fSelFade < fFadeVal) {
    glintFade = fFadeVal;
  }
  if (0 < flare_intensity) {
    x = TextSys_WordX(0x1de);
    iVar1 = (flare_intensity << 1) >> 0x1f;
    index = (flare_intensity << 1) / 3 + iVar1;
    Flare_2DHalo(x,y + 5,(flare_intensity + ((u_int)iVar2 >> 0x1f)) >> 1,index - iVar1,0x17);
    DrawShapeExtended(0,0,x - 3,y - 1,glintFade,(u_int)(glintFade != 0),(tDrawShapeExtended *)0x0);
  }
  return;
}



/* ---- SubtractiveBox  [FEMENUOPTIONS.CPP:115-148] SLD-VERIFIED ---- */

void SubtractiveBox(int x,int y,int w,int h,int col1,int col2,int col3,int col4)

{
  u_short tpage;
  int pkt_addr24;
  int pkt_addr24_drm;
  DR_MODE *dr_mode;
  short y_plus_h;
  short x_plus_w;
  short x_s;
  short ts2;
  u_char *prim;
  u_char *prev_pkt;
  
  prim = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  x_s = (short)x;
  x_plus_w = x_s + (short)w;
  y_plus_h = y + (short)h;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x24;
  *(u_int *)prev_pkt = *(u_int *)prev_pkt & 0xff000000 | pkt_addr24;
  prim[3] = 8;
  *(int *)(prim + 4) = col1;
  *(int *)(prim + 0xc) = col2;
  *(int *)(prim + 0x14) = col3;
  *(int *)(prim + 0x1c) = col4;
  prim[7] = 0x3a;
  *(short *)(prim + 8) = x_s;
  *(short *)(prim + 10) = y;
  *(short *)(prim + 0x10) = x_plus_w;
  *(short *)(prim + 0x12) = y;
  *(short *)(prim + 0x18) = x_s;
  *(short *)(prim + 0x1a) = y_plus_h;
  *(short *)(prim + 0x20) = x_plus_w;
  *(short *)(prim + 0x22) = y_plus_h;
  dr_mode = (DR_MODE *)Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24_drm = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(u_int *)prev_pkt = *(u_int *)prev_pkt & 0xff000000 | pkt_addr24_drm;
  tpage = GetTPage(2,2,0,0x100);
  SetDrawMode(dr_mode,0,0,(u_int)tpage,(RECT *)0x0);
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionOff  [FEMENUOPTIONS.CPP:168-169] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::TransitionOff()

{
  this->fFadeDir = 0x1e;
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionOn  [FEMENUOPTIONS.CPP:173-179] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::TransitionOn()

{
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x1e;
  this->fSelFade = 0;
  this->fEnableVal = 0;
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionIsFinished  [FEMENUOPTIONS.CPP:183-191] SLD-VERIFIED ---- */

void * tMenuItemGoToMenuButtonFade::TransitionIsFinished()

{
  this->fInTransition = 0;
  if (this->fFadeDir < 0) {
    if (0 < this->fFadeVal) {
      this->fInTransition = 1;
      goto done;
    }
  }
  if (0 < this->fFadeDir) {
    if (this->fFadeVal < 0x80) {
      this->fInTransition = 1;
    }
  }
done:
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemGoToMenuButtonFade::UpdateTransition  [FEMENUOPTIONS.CPP:195-199] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = this->_vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&this->fFlags +
             (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemLeftRightFade::ctor  [FEMENUOPTIONS.CPP:204-210] SLD-VERIFIED ---- */
tMenuItemLeftRightFade::tMenuItemLeftRightFade(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemLeftRightChoice(textDescription,dataPtr)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightFade_vtable;
  this->flareextra = 0;
  this->fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionOff  [FEMENUOPTIONS.CPP:215-218] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::TransitionOff()

{
  this->fInTransition = 1;
  this->fFadeDir = 0x1e;
  this->fFadeVal = 0;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionOn  [FEMENUOPTIONS.CPP:221-227] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::TransitionOn()

{
  this->fInTransition = 1;
  this->fFadeDir = -0x1e;
  this->flareextra = 0;
  this->fSelFade = 0;
  this->fFadeVal = 0x80;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionIsFinished  [FEMENUOPTIONS.CPP:231-241] SLD-VERIFIED ---- */

void * tMenuItemLeftRightFade::TransitionIsFinished()

{
  /* MATCH: plain if/else-if chain of &&-guards.  The `fFadeDir` reload the oracle
     emits at 8001C3F8 is NOT a cache-invalidation trick — it falls out for free:
     the first `&&` clobbers $v0 with fFadeVal, so the second guard's re-read of
     fFadeDir must reload on THAT path only, while the `fFadeDir >= 0` edge jumps
     straight to the shared blez (gcc places the reload inside the outer if). */
  if (this->fFadeDir == 0) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir < 0) && (this->fFadeVal <= 0)) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir > 0) && (this->fFadeVal >= 0x80)) {
    this->fInTransition = 0;
  } else {
    this->fInTransition = 1;
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemLeftRightFade::UpdateTransition  [FEMENUOPTIONS.CPP:245-249] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = this->_vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&this->fFlags +
             (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tOptionsMenu::ctor  [FEMENUOPTIONS.CPP:267-276] SLD-VERIFIED ---- */

tOptionsMenu::tOptionsMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,int firstframe,int numframes,
              tMenuItem *firstItem,...)
  : tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_vf = (__vtbl_ptr_type (*)[11])tOptionsMenu_vtable;
  this->tMenuConstructor(firstItem,(&firstItem + 1));
  this->fScreenFade = 0;
  this->fPrevItem = 0;
  this->fFirstFrame = firstframe;
  this->fNumFrames = numframes;
  return;
}



/* ---- tOptionsMenu::dtor  [FEMENUOPTIONS.CPP:281-281] SLD-VERIFIED ---- */

tOptionsMenu::~tOptionsMenu()

{
  *(void **)&(this->_vf) = (void *)tOptionsMenu_vtable;
  return;
}



/* ---- tOptionsMenu::DebounceKeys  [FEMENUOPTIONS.CPP:286-289] SLD-VERIFIED ---- */

long tOptionsMenu::DebounceKeys()

{
  long lVar1;
  tMenuItem *ptVar2;
  
  ptVar2 = this->fItemList[this->fCurrentItem];
  if ((ptVar2 != (tMenuItem *)0x0) && (((ptVar2->fFlags & 1) ^ 1) != 0)) {
    return (*(*ptVar2->_vf)[2].pfn)((int)ptVar2 + (int)(*ptVar2->_vf)[2].delta);
  }
  return 0;
}



/* ---- tOptionsMenu::TransitionOff  [FEMENUOPTIONS.CPP:293-303] SLD-VERIFIED ---- */

void tOptionsMenu::TransitionOff()

{
  /* MATCH: SYM says the only local is `short i`; `fItemList[i]` on a SHORT counter
     gives the oracle's per-use `sll 16; sra 14` rematerialization (the hand-rolled
     `(i<<16)>>14` on an `int` made gcc strength-reduce i to a 0x10000 stride). */
  short i;

  this->fTransitionDirection = '(';
  this->fScreenFade = 0;
  for (i = 0; this->fItemList[i] != (tMenuItem *)0x0; i++) {
    (*(*this->fItemList[i]->_vf)[7].pfn)
      ((char *)this->fItemList[i] + (int)(*this->fItemList[i]->_vf)[7].delta);
  }
  this->fInMenuTransition = 1;
  return;
}



/* ---- tOptionsMenu::TransitionOn  [FEMENUOPTIONS.CPP:308-320] SLD-VERIFIED ---- */

void tOptionsMenu::TransitionOn()

{
  /* MATCH: see TransitionOff — `short i` + `fItemList[i]`. */
  short i;

  /* MATCH: plain `char` is UNSIGNED here -> `= -0x28` emits `li 216`; the signed
     view restores the oracle's `li -40`. */
  *(signed char *)&this->fTransitionDirection = -0x28;
  this->fInMenuTransition = 1;
  this->fScreenFade = 0x228;
  for (i = 0; this->fItemList[i] != (tMenuItem *)0x0; i++) {
    (*(*this->fItemList[i]->_vf)[8].pfn)
      ((char *)this->fItemList[i] + (int)(*this->fItemList[i]->_vf)[8].delta);
  }
  return;
}



/* ---- tOptionsMenu::TransitionIsFinished  [FEMENUOPTIONS.CPP:325-358] SLD-VERIFIED ---- */

void * tOptionsMenu::TransitionIsFinished()

{
  /* SYM 8c block: the ONLY local is `short i` (REG $s0); the fn returns BOOL.  The
     nested `Block start line=24` carrying a `tFEApplication *this` is an INLINED
     tFEApplication accessor — i.e. the tail reads FEApp->fCurrentScreen inline. */
  short i;

  /* MATCH: if/else-if chain of &&-guards (the oracle reloads fScreenFade for the
     2nd guard because the 1st guard's `lb` clobbered $v0).  fTransitionDirection
     is a SIGNED byte in retail — this build's plain `char` is UNSIGNED, so the
     (signed char) casts are what produce the oracle's `lb`/`bgtz`/`bgez`. */
  if ((0x228 <= this->fScreenFade) && (0 < (signed char)this->fTransitionDirection)) {
    this->fInMenuTransition = 0;
  }
  else if ((this->fScreenFade <= 0) && ((signed char)this->fTransitionDirection < 0)) {
    this->fInMenuTransition = 0;
  }
  else {
    this->fInMenuTransition = 1;
  }
  /* MATCH: the virtual returns `bool`, so `!ret` is gcc's bool-negate `xori v0,v0,1`
     (an `int` compare would emit li+bne instead) -> cast the vtable pfn to a
     bool-returning fn-ptr at the call site.  `short i` + `fItemList[i]` gives the
     oracle's per-use `sll 16; sra 14` index rematerialization. */
  if (this->fInMenuTransition == 0) {
    for (i = 0; this->fItemList[i] != (tMenuItem *)0x0; i++) {
      if (!(*(bool (*)(...))(*this->fItemList[i]->_vf)[9].pfn)
             ((char *)this->fItemList[i] + (int)(*this->fItemList[i]->_vf)[9].delta)) {
        this->fInMenuTransition = 1;
      }
    }
  }
  if (!(*(bool (*)(...))(*FEApp->fCurrentScreen[0]->_vf)[8].pfn)
         ((char *)FEApp->fCurrentScreen[0] +
          (int)(*FEApp->fCurrentScreen[0]->_vf)[8].delta)) {
    this->fInMenuTransition = 1;
  }
  return (void *)(this->fInMenuTransition ^ 1);
}



/* ---- tOptionsMenu::UpdateTransition  [FEMENUOPTIONS.CPP:364-422] SLD-VERIFIED ---- */

void tOptionsMenu::UpdateTransition()

{
  /* SYM 8c block: the ONLY local is `short i` (REG $s0); every other Ghidra temp
     (iVar2/pa_Var3/iVar4/ptVar5/bVar6/sVar7) was a fabrication.  SLD segmentation:
     367 fInMenuTransition / 369 fTransitionDirection / 371 fScreenFade>0 /
     374 clamp-to-0 / 379-380 forward TransitionIsFinished scan / 383-385 goto the
     shared UpdateTransition call / 393-395 count items / 397-400 backward scan /
     403-405 shared call / 407-411 fade-in clamp / 418-419 the not-transitioning
     item loop / 422 the menu's own vtable[7] call. */
  short i;
  tMenuItem *citem;
  tMenuItem *item;
  __vtbl_ptr_type *entry;
  char *adjusted;

  if (this->fInMenuTransition != 0) {
    /* MATCH: `char` is UNSIGNED on this build -> a plain `< 0` folds to false and
       gcc DELETES this entire arm (46 insns).  (signed char) restores the lb. */
    if (*(signed char *)&this->fTransitionDirection < 0) {
      if (0 < this->fScreenFade) {
        this->fScreenFade = this->fScreenFade + *(signed char *)&this->fTransitionDirection;
        if (this->fScreenFade < 0) {
          this->fScreenFade = 0;
        }
      }
      else {
        for (i = 0; this->fItemList[i] != 0; i++) {
          if ((*(*this->fItemList[i]->_vf)[9].pfn)
                ((char *)this->fItemList[i] + (int)(*this->fItemList[i]->_vf)[9].delta) == 0) break;
        }
        citem = this->fItemList[i];
        if (citem == 0) goto feo_done;
        goto feo_callUpdate;
      }
    }
    else {
      for (i = 0; this->fItemList[i] != 0; i++) {
      }
      i = i - 1;
      if (i != -1) {
        while ((*(*this->fItemList[i]->_vf)[9].pfn)
                 ((char *)this->fItemList[i] + (int)(*this->fItemList[i]->_vf)[9].delta) != 0) {
          i = i - 1;
          if (i == -1) break;
        }
        if (i != -1) {
          /* MATCH: BOTH paths that reach the shared UpdateTransition call load the
             item into the SAME variable first, so gcc cross-jump-merges from the
             `lw _vf` (oracle .L8001C9E8) instead of from the index computation —
             which also lets the backward path reuse the `(short)i` extend the
             `i != -1` guard already produced (`sra v1,..` / `sll v0,v1,2`). */
          citem = this->fItemList[i];
feo_callUpdate:
          (*(*citem->_vf)[10].pfn)
            ((char *)citem + (int)(*citem->_vf)[10].delta, 0);
          goto feo_done;
        }
      }
      if (this->fScreenFade < 0x228) {
        this->fScreenFade = this->fScreenFade + *(signed char *)&this->fTransitionDirection;
        if (0x228 < this->fScreenFade) {
          this->fScreenFade = 0x228;
        }
      }
    }
  }
  else {
    /* MATCH: g++ old-ABI virtual-call spelling — ENTRY pointer for the pfn fetch
       (`lw 4(a3)`), delta off the vtable base as a displacement (`lh 80(v0)`). */
    for (i = 0; this->fItemList[i] != 0; i++) {
      item = this->fItemList[i];
      entry = &(*item->_vf)[10];
      adjusted = (char *)item + (int)entry->delta;
      (*entry->pfn)(adjusted,
         this->fInMenuTransition == 0 && (int)i == this->fCurrentItem);
    }
  }
feo_done:
  (*(*this->_vf)[7].pfn)((char *)this + (int)(*this->_vf)[7].delta);
  return;
}



/* ---- tOptionsMenu::Draw  [FEMENUOPTIONS.CPP:426-456] SLD-VERIFIED ---- */

void tOptionsMenu::Draw()

{
  /* SYM 8c block: locals are `short i` (REG $s1) + the AUTO `tDrawShapeExtended
     drawFlags`; the nested `tMenuItem *this` blocks are INLINED accessors. */
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  __vtbl_ptr_type *entry;
  char *adjusted;
  short i;
  bool bVar4;
  tDrawShapeExtended drawFlags;

  CalcPulsateYellow();
  /* MATCH: no local for the head test either — the oracle reuses $v0 for both the
     null test and the flags load (a named ptVar1 parks it in $v1). */
  if ((this->fItemList[this->fCurrentItem] == (tMenuItem *)0x0) ||
      ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0)) {
    this->fCurrentItem = 0;
  }
  /* MATCH: the skip-disabled scans walk `fCurrentItem` (an int field) DIRECTLY —
     no local.  The comma-expression `(i = fCurrentItem, A && B)` form both narrowed
     the load to `lh` (i is short) and forced the `&&` to be materialized as a VALUE
     (`addu v1,zero,zero; sltu/slt; beqz`) instead of the oracle's plain branch;
     it also inflated `i`'s ref count, stealing $s0 from `this`. */
  /* MATCH: EXIT-IN-THE-MIDDLE keeps the oracle's TOP-TEST + unconditional `j`
     back-edge (a plain `while (A && B)` gets loop-ROTATED: peeled entry test +
     bottom-test back-edge, +7 insns). */
  while (1) {
    if ((this->fItemList[this->fCurrentItem]->fFlags & 1) == 0) break;
    if (this->fItemList[this->fCurrentItem + 1] == (tMenuItem *)0x0) break;
    this->fCurrentItem = this->fCurrentItem + 1;
  }
  while (1) {
    if ((this->fItemList[this->fCurrentItem]->fFlags & 1) == 0) break;
    if (this->fCurrentItem <= 0) break;
    this->fCurrentItem = this->fCurrentItem + -1;
  }
  if ((-1 < this->fFirstFrame) && (0 < this->fNumFrames)) {
    drawFlags.tint[0] = 0xcec844;
    DrawShapeExtended(this->fFirstFrame + ((int)(ticks[0] >> 4) % this->fNumFrames),0x410,0x10,0x10,0,0,&drawFlags);
  }
  /* MATCH: `short i` + `fItemList[i]` (per-use sll16/sra14 remat). */
  for (i = 0; this->fItemList[i] != (tMenuItem *)0x0; i++) {
    /* MATCH: the dispatch is spelled the way g++'s own old-ABI virtual call is —
       an ENTRY POINTER for the pfn fetch (`lw 4(t0)`), the delta read off the
       vtable base as a displacement (`lh 40(v0)`), and the this-adjust MUTATING
       the (now dead) receiver register in place (`addu a0,a0,v0`).  Same spelling
       as tMenuItemSlidingMenu::Draw's matched dispatches. */
    ptVar1 = this->fItemList[i];
    entry = &(*ptVar1->_vf)[5];
    adjusted = (char *)ptVar1 + (int)entry->delta;
    bVar4 = false;
    if (this->fInMenuTransition == 0) {
      bVar4 = (int)i == this->fCurrentItem;
    }
    (*entry->pfn)(adjusted,0,0,bVar4);
  }
  return;
}



/* ---- tOptionsMenu::ProcessInput  [FEMENUOPTIONS.CPP:462-504] SLD-VERIFIED ---- */

void tOptionsMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  short sVar1;
  
  sVar1 = this->GetNumberEnabledItems();
  if (sVar1 == 0) {
    this->fCurrentItem = 0;
    if ((keyval != kInput_KeyType_Triangle) && (keyval != kInput_KeyType_Circle)) {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  this->tMenu::ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tInsideBoxMenu::ctor  [FEMENUOPTIONS.CPP:520-528] SLD-VERIFIED ---- */

tInsideBoxMenu::tInsideBoxMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_vf = (__vtbl_ptr_type (*)[11])tInsideBoxMenu_vtable;
  this->tMenuConstructor(firstItem,(&firstItem + 1));
  this->fPrevItem = 0;
  this->fMoving = 0;
  this->fMovingDir = 0;
  return;
}



/* ---- tInsideBoxMenu::dtor  [FEMENUOPTIONS.CPP:532-532] SLD-VERIFIED ---- */

tInsideBoxMenu::~tInsideBoxMenu()

{
  *(void **)&(this->_vf) = (void *)tInsideBoxMenu_vtable;
  return;
}



/* ---- tInsideBoxMenu::ProcessInput  [FEMENUOPTIONS.CPP:537-554] SLD-VERIFIED ---- */

void tInsideBoxMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  tInputKeyType tVar2;
  tMenuItem *ptVar3;
  
  if (this->fMoving != 0) {
    tVar2 = keyval;
    if ((tVar2 != kInput_KeyType_Up) && (tVar2 != kInput_KeyType_Down))
    goto ProcInpFE_keyUpItemZero;
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  tVar2 = keyval;
ProcInpFE_keyUpItemZero:
  if ((tVar2 == kInput_KeyType_Up) && (this->fCurrentItem == 0)) {
    ptVar3 = this->fItemList[0];
    pa_Var1 = ptVar3->_vf;
    (*(*pa_Var1)[3].pfn)((char *)ptVar3 + (int)(*pa_Var1)[3].delta);
  }
  else if ((keyval != kInput_KeyType_Down) ||
          (this->fItemList[this->fCurrentItem + 1] != (tMenuItem *)0x0)) {
    this->tMenu::ProcessInput(fromPlayer,keyval,command);
  }
  return;
}



/* ---- tInsideBoxMenu::Draw  [FEMENUOPTIONS.CPP:558-605] SLD-VERIFIED ---- */

void tInsideBoxMenu::Draw(short x,short y,short w,short slideOffset,short arg5)

{
  __vtbl_ptr_type *entry;
  short i;
  short j;
  tMenuItem *ptVar6;
  char *adjusted;
  bool selected1;
  bool selected2;
  int drawSlide;
  int drawX;
  int drawY;
  int drawW;
  
  if (this->fCurrentItem != this->fPrevItem) {
    if (this->fPrevItem < this->fCurrentItem) {
      this->fMoving = 0x18;
      this->fMovingDir = -4;
    }
    else {
      this->fMoving = -0x18;
      this->fMovingDir = 4;
    }
    this->fPrevItem = (short)this->fCurrentItem;
  }
  if (this->fMoving != 0) {
    this->fMoving = this->fMoving + this->fMovingDir;
    if ((this->fMovingDir < 0) && (this->fMoving < 0)) {
      this->fMoving = 0;
    }
    if ((0 < this->fMovingDir) && (0 < this->fMoving)) {
      this->fMoving = 0;
    }
  }
  j = 0;
  drawSlide = slideOffset;
  drawX = x;
  drawY = y;
  drawW = w;
  do {
    i = (short)((u_short)this->fCurrentItem + (j - 2));
    if ((3 < j) && (this->fItemList[i - 1] == (tMenuItem *)0x0)) {
      return;
    }
    if ((-1 < i) && (ptVar6 = this->fItemList[i], ptVar6 != (tMenuItem *)0x0)) {
      entry = &(*ptVar6->_vf)[10];
      adjusted = (char *)ptVar6 + (int)entry->delta;
      if (this->fMoving == 0) {
        selected1 = i == this->fCurrentItem;
      }
      else {
        selected1 = false;
      }
      (*entry->pfn)(adjusted,selected1);
      ptVar6 = this->fItemList[(short)i];
      entry = &(*ptVar6->_vf)[6];
      adjusted = (char *)ptVar6 + (int)entry->delta;
      if (this->fMoving == 0) {
        selected2 = (int)(short)i == this->fCurrentItem;
      }
      else {
        selected2 = false;
      }
      (*entry->pfn)
                (adjusted,drawX,
                 (int)this->fMoving + drawY + drawSlide + ((short)j + -1) * 0x18 + 5,
                 drawW,selected2);
    }
    j = j + 1;
  } while (j * 0x10000 >> 0x10 < 5);
  return;
}



/* ---- tMenuItemSlidingMenu::ctor  [FEMENUOPTIONS.CPP:612-624] SLD-VERIFIED ---- */
tMenuItemSlidingMenu::tMenuItemSlidingMenu(u_int textDescription,short width,short height,short diffx,
          short diffy,bool fillback)
  : tMenuItem(textDescription)
{
  /* MATCH (LAW 05A — the SLD IS the statement order): retail's body is
     614 fFlags|=0x80 / 615 currMenu / 616 nextMenu / 617 fWidth / 618 fHeight /
     619 fDiffX / 620 fDiffY / 621 fFillback / 622 fSelFade — ONE fFlags OR (the
     recon had it twice), and a TYPED vtable store so gcc can schedule the `sw`. */
  this->fFlags = this->fFlags | 0x80;
  this->currMenu = (tInsideBoxMenu *)0x0;
  this->nextMenu = (tInsideBoxMenu *)0x0;
  this->fWidth = width;
  this->fHeight = height;
  this->fDiffX = diffx;
  this->fDiffY = diffy;
  this->fFillback = fillback;
  this->fSelFade = 0;
  this->_vf = (__vtbl_ptr_type (*)[11])tMenuItemSlidingMenu_vtable;
  /* MATCH (LAW 05A): the SLD attributes a SECOND `fFlags |= 0x80`
     (`lw a0,0(v0); ori a0,a0,128; sw a0,0(v0)`) to line 624 — the ctor's closing
     line — i.e. retail really ORs the bit in twice. */
  this->fFlags = this->fFlags | 0x80;
  /* NEAR-MISS 28 (was 37) — count + structure now byte-for-byte EXACT (42/42).
     Residual = a pure saved-reg rotation: retail homes the three STACK-ARG params
     (diffx/diffy/fillback) in $s1/$s2/$s3 and the two register params
     (width/height) in $s4/$s5; ours is the reverse.  FALSIFIED dials: identity
     fences on diffx/diffy/fillback (PROMOTE) and a read-only fence on
     width/height (DEMOTE) — both inert, these are global allocnos live across
     the base-ctor `jal`, outside a fence's reach. */
  return;
}



/* ---- tMenuItemSlidingMenu::dtor  [FEMENUOPTIONS.CPP:628-628] SLD-VERIFIED ---- */

tMenuItemSlidingMenu::~tMenuItemSlidingMenu()

{
  *(void **)&(this->_vf) = (void *)tMenuItemSlidingMenu_vtable;
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionOff  [FEMENUOPTIONS.CPP:634-641] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::TransitionOff()

{
  this->fFadeDir = 0;
  this->fTransitioningOut = 1;
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    this->fInTransition = 1;
    this->fFadeDir = 0x1e;
    this->fFadeVal = 0;
  }
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionOn  [FEMENUOPTIONS.CPP:648-657] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::TransitionOn()

{
  this->fFadeDir = -0x1e;
  this->fInTransition = 1;
  this->fOpenHeight = 0;
  this->fTransitioningOut = 0;
  this->fFadeVal = 0x80;
  this->fSlideOffset = this->fHeight + (this->fHeight >> 1);
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionIsFinished  [FEMENUOPTIONS.CPP:661-676] SLD-VERIFIED ---- */

void * tMenuItemSlidingMenu::TransitionIsFinished()

{
  /* MATCH: plain if/else-if chain (same shape as tMenuItemLeftRightFade's).  The
     fFadeDir reload at 8001D2E8 is free: the preceding `&&` clobbered $v0 with
     fFadeVal, so only that path reloads while the bgez edge enters mid-block. */
  if ((this->currMenu == (tInsideBoxMenu *)0x0) || (this->nextMenu == (tInsideBoxMenu *)0x0)) {
    this->fFadeDir = 0;
    this->fInTransition = 0;
  } else if (this->fFadeDir == 0) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir < 0) && (this->fFadeVal <= 0)) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir > 0) && (this->fFadeVal >= 0x80)) {
    this->fInTransition = 0;
  } else {
    this->fInTransition = 1;
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemSlidingMenu::UpdateTransition  [FEMENUOPTIONS.CPP:680-690] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = this->_vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)((int)&this->fFlags + (int)(*pa_Var1)[9].delta);
  this->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemSlidingMenu::DebounceKeys  [FEMENUOPTIONS.CPP:696-698] SLD-VERIFIED ---- */

long tMenuItemSlidingMenu::DebounceKeys()

{
  u_int uVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  tInsideBoxMenu *ptVar3;
  
  ptVar3 = this->currMenu;
  uVar1 = 0x600;
  if (ptVar3 != (tInsideBoxMenu *)0x0) {
    pa_Var2 = (ptVar3)->_vf;
    uVar1 = (*(*pa_Var2)[4].pfn)((int)ptVar3 + (*pa_Var2)[4].delta);
    uVar1 = uVar1 | 0x600;
  }
  return uVar1;
}



/* ---- tMenuItemSlidingMenu::Draw  [FEMENUOPTIONS.CPP:705-706] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::Draw(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  
  pa_Var1 = this->_vf;
  (*(*pa_Var1)[5].pfn)((int)&this->fFlags + (int)(*pa_Var1)[5].delta,0,0,selected);
  return;
}



/* ---- tMenuItemSlidingMenu::UpdatefOpenHeight  [FEMENUOPTIONS.CPP:711-769] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::UpdatefOpenHeight(bool selected)

{
  /* NEAR-MISS 26 (was 84) — count EXACT 136/136, structure byte-for-byte.
     Residual = a $v0/$v1/$a2 rotation at three clamp sites (the fadeOut clamp,
     the fade+0x28 clamp and the cur/lim pair).  Landed levers: guard-first
     clamps (no comma-expression conditions), per-block clamp temps, the
     store-forwarded `currMenu` test, and the lim-merged single `sh`.
     FALSIFIED: cur/lim declaration-order swaps (both variants inert).

     SYM 8c block: fsize 0 / mask 0 / NO named locals -- every clamp temp in retail
     is a per-expression compiler temp.  ONE function-scope `iVar1` reused by all
     six clamps is a single long-lived allocno that conflicts with everything and
     loses $v0 at every site (`addiu v1,v0,-4` instead of the oracle's in-place
     `addiu v0,v0,-4`); only the fFadeVal value genuinely flows between blocks. */
  int fade;

  this->fClosing = 0;
  if (this->fOpenHeight == 0) {
    this->fSlideOffset = this->fHeight + (this->fHeight >> 1);
  }
  /* MATCH: the subtraction lives INSIDE the guard (oracle `blez v0` with the
     `addiu v0,v0,-4` IN its delay slot, IN PLACE on the loaded field); hoisting
     it above the test — a comma-expression condition — keeps the loaded value
     live and forces every clamp onto a second register. */
  if ((this->nextMenu != this->currMenu) && (0 < this->fOpenHeight))
  {
    int closeH = this->fOpenHeight + -4;
    if (closeH < 0) {
      closeH = 0;
    }
    this->fOpenHeight = (short)closeH;
    this->fClosing = 1;
    goto UpdfOpenH_currMenuCheck;
  }
  if (this->nextMenu == (tInsideBoxMenu *)0x0) {
    fade = (int)this->fFadeVal;
    if (0x7f < fade) goto feo_fadeCheck;
    if (this->fInTransition != 0) goto UpdfOpenH_currMenuCheck;
  }
  else {
    fade = (int)this->fFadeVal;
feo_fadeCheck:
    if (((0 < fade) && (this->currMenu == (tInsideBoxMenu *)0x0)) &&
       (this->nextMenu != (tInsideBoxMenu *)0x0)) {
      fade = fade + -0x28;
      if (this->fInTransition == 0) {
        if (fade < 0) {
          fade = 0;
        }
        this->fFadeVal = (short)fade;
      }
      if (this->fTransitioningOut == 0) {
        this->currMenu = this->nextMenu;
      }
      goto UpdfOpenH_currMenuCheck;
    }
    this->currMenu = this->nextMenu;
    if ((this->fTransitioningOut != 0) || (this->fInTransition != 0)) goto UpdfOpenH_currMenuCheck;
    /* MATCH: test the JUST-STORED `currMenu` (identical value here) — gcc
       store-forwards it (`beqz v1`), where re-reading `nextMenu` across the
       may-aliasing store costs a reload. */
    if (this->currMenu != (tInsideBoxMenu *)0x0) {
      int fadeOut = this->fFadeVal + -0x28;
      if (fadeOut < 0) {
        fadeOut = 0;
      }
      this->fFadeVal = (short)fadeOut;
      goto UpdfOpenH_currMenuCheck;
    }
    fade = (int)this->fFadeVal;
  }
  /* MATCH: a SECOND int pseudo for the sum (oracle `lh v0,44; addiu v1,v0,40;
     slti v0,v1,129; … li v1,128; sh v1`), clamped IN PLACE — reusing `fade`
     itself makes the load and the sum share one register; a `short` result var
     adds an `addu v1,v0,zero` funnel. */
  {
    int newFade = fade + 0x28;
    if (0x80 < newFade) {
      newFade = 0x80;
    }
    this->fFadeVal = (short)newFade;
  }
UpdfOpenH_currMenuCheck:
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    if (selected != 0) {
      if (this->fClosing == 0) {
        /* MATCH: plain if/else with the store in BOTH arms — gcc cross-jump-merges
           them into the oracle's single `sh v1,40(a0)` and lets `fHeight` load
           STRAIGHT into the merge register (a `short lim` pre-read forces an
           `addu v1,a3,zero` copy and flips the two loads' order). */
        /* MATCH: cur/lim as two int temps, the clamp merged into `lim` so both arms
           share ONE `sh` (oracle `addu v1,a2,zero; sh v1,40`).  NEAR-MISS 26 is a
           pure v0/v1/a2 rotation at three clamp sites (count EXACT 136/136);
           decl-order swaps of cur/lim are inert. */
        int cur = this->fOpenHeight;
        int lim = this->fHeight;
        if (cur < lim) {
          cur = cur + 4;
          if (cur < lim) {
            lim = cur;
          }
          this->fOpenHeight = (short)lim;
        }
        else {
          int slide = this->fSlideOffset + -6;
          if (slide < 0) {
            slide = 0;
          }
          this->fSlideOffset = (short)slide;
        }
      }
      if (selected != 0) {
        return;
      }
    }
    if (0 < this->fOpenHeight) {
      int shrinkH = this->fOpenHeight + -4;
      if (shrinkH < 0) {
        shrinkH = 0;
      }
      this->fOpenHeight = (short)shrinkH;
    }
  }
  return;
}



/* ---- tMenuItemSlidingMenu::Draw  [FEMENUOPTIONS.CPP:777-883] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::Draw(int offx,int offy,bool selected)

{
  int ColText;
  int x;
  int y;
  tTexture_ShapeInfo *shape;
  bool fPlayList;

  /* SYM: fn-scope locals are ONLY ColText/x/y/shape/fPlayList; drawFlags+
     width are scoped to the "if (currMenu!=0||fPlayList)" block; xx/yy/ww/
     hh/drenv/daprim/full/temp/gray/shapetop/shapebottom to the big
     "if (currMenu!=0)" block. The virtual DebounceKeys-flags call, the
     TextSys_WordX/WordY->x/y fusion, `shape` as the ALREADY-OFFSET
     &gHelpShapes[0x1e] pointer (not a base ptr re-indexed each use), the
     shared boxWidth_d (0xdc for a playlist submenu, else fWidth -- computed
     ONCE, reused by the two flare-arrow DrawShapeExtended calls only), and
     the two independent currMenu/fPlayList tests (not one cached flag) are
     all read directly off the raw oracle (asm/nonmatchings/front/
     Draw__20tMenuItemSlidingMenuiib.s). */
  (**(int (**)(...))((int)this->_vf + 0x5c))
            ((int)&this->fFlags + (int)*(short *)((int)this->_vf + 0x58),
             selected);
  ColText = CalcTextFadeSelToHi(textType_Options,this->fSelFade,this->fFadeVal);
  x = TextSys_WordX(this->fTextDescription) + offx;
  y = TextSys_WordY(this->fTextDescription) + offy;
  shape = &gHelpShapes[0x1e];
  fHelpText[0] = -1;
  fPlayList = (tInsideBoxSongMenu *)this->currMenu == &menuDefs->menuPlayListMenu;
  if ((this->fFadeVal != 0x80) && (fPlayList)) {
    DrawLeftFlare(y,(int)this->fSelFade,(int)this->fFadeVal,
               flareextra);
  }
  if ((this->currMenu != (tInsideBoxMenu *)0x0) || (fPlayList)) {
    tDrawShapeExtended drawFlags;
    int width;
    tDrawShapeExtended *drawFlagsPtr;
    int draw;

    width = fPlayList ? 0xdc : (int)this->fWidth;
    drawFlags.tint[0] = CalcFadeVal(0,0xbebe,(int)this->fSelFade,(int)this->fFadeVal);
    drawFlagsPtr = &drawFlags;
    const int right = x + width;
    draw = 1;
    DrawShapeExtended(0x39,0x18,(right - (int)shape->width) - 0xa,(fPlayList ? y + -3 : y + -2),0,draw,drawFlagsPtr);
    DrawShapeExtended(0x3a,0x18,(right - (int)shape->width) - 0xa,(fPlayList ? y + 3 : y + 4),0,draw,drawFlagsPtr);
  }
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    int xx;
    int yy;
    int ww;
    int hh;
    DRAWENV *drenv;
    DR_AREA *daprim;
    RECT full;
    RECT temp;
    int gray;
    tTexture_ShapeInfo *shapetop;
    tTexture_ShapeInfo *shapebottom;

    xx = x + this->fDiffX;
    yy = y + this->fDiffY;
    ww = this->fWidth;
    hh = this->fOpenHeight;
    drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
    full.x = 0;
    full.y = *(short *)((char *)drenv + 2);
    full.h = (short)screenheight;
    full.w = 0x200;
    daprim = (DR_AREA *)Render_gPacketPtr;
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    SetDrawArea(daprim,&full);
    gray = 0x505050;
    SubtractiveBox(xx,yy,ww,hh >> 1,gray,gray,0,0);
    SubtractiveBox(xx,yy + (hh >> 1),ww,hh >> 1,0,0,gray,gray);
    shapetop = gHelpShapes + 0x1f;
    shapebottom = gHelpShapes + 0x20;
    (**(int (**)(...))((int)this->currMenu->_vf + 0x5c))
              ((int)this->currMenu->fItemList + *(short *)((int)this->currMenu->_vf + 0x58) + -0x10,
               xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,ww,
               (int)((u_int)(u_short)this->fSlideOffset << 0x11) >> 0x10,(int)this->fHeight);
    if ((this->fFillback != 0) && (shapetop->height < hh)) {
      DrawShapeExtended(0x1f,0xc,xx,yy,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x1f,8,(xx + ww) - (int)shapetop->width,yy,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x20,0xc,xx,(yy + hh) - (int)shapebottom->height,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x20,8,(xx + ww) - (int)shapebottom->width,(yy + hh) - (int)shapebottom->height,0,0,(tDrawShapeExtended *)0x0);
    }
    PSXDrawSquare(0,xx + shapetop->width + 5,yy,
               ((ww - shapetop->width) - (int)shapebottom->width) + -10,hh);
    if (shapetop->height + shapebottom->height < hh) {
      PSXDrawSquare(0,xx,yy + shapetop->height,ww,
                    (hh - shapetop->height) - (int)shapebottom->height);
    }
    temp.x = (short)xx;
    temp.y = *(short *)((char *)drenv + 2) + (short)yy;
    daprim = (DR_AREA *)Render_gPacketPtr;
    addPrim(Render_gPalettePtr,daprim);
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    temp.w = this->fWidth;
    temp.h = this->fOpenHeight;
    SetDrawArea(daprim,&temp);
    if (fHelpText[0] != -1) {
      FETextRender_FullTextRGB(TextSys_Word(fHelpText[0]),TextSys_WordX(fHelpText[0]),
                               TextSys_WordY(fHelpText[0]),PulsateYellow[0],'\0',2);
    }
    FETextRender_FullTextRGB((char *)TextSys_Word(this->fTextDescription),(short)x,(short)y,ColText,'\0',
                             fPlayList ? 1 : 0);
    DrawShapeExtended(0x1e,8,(x + (int)this->fWidth) - (int)shape->width,y + -2,(int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
    if (this->fFillback != 0) {
      PSXDrawSquare(0,x,y + -2,(int)this->fWidth - (int)shape->width,
                 (int)shape->height);
    }
  }
  return;
}



/* ---- tMenuItemSlidingMenu::ProcessInput  [FEMENUOPTIONS.CPP:890-900] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  tInsideBoxMenu *ptVar2;
  
  if ((this->fOpenHeight == this->fHeight) &&
     (ptVar2 = this->currMenu, ptVar2 != (tInsideBoxMenu *)0x0)) {
    pa_Var1 = (ptVar2)->_vf;
    (*(*pa_Var1)[3].pfn)((int)ptVar2 + (*pa_Var1)[3].delta);
  }
  if (keyval == kInput_KeyType_Down) {
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  this->ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuItemSlidingMenu::SetMenu  [FEMENUOPTIONS.CPP:904-918] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::SetMenu(bool bothmenus,tInsideBoxMenu *menu)

{
  
  this->nextMenu = menu;
  if (bothmenus != 0) {
    this->currMenu = menu;
  }
  if (this->nextMenu == (tInsideBoxMenu *)0x0) {
    this->fFlags = this->fFlags | 1;
    return;
  }
  this->fFlags = this->fFlags & 0xfffffffe;
  return;
}



/* ---- tMenuItemSlidingActivated::UpdatefOpenHeight  [FEMENUOPTIONS.CPP:925-931] SLD-VERIFIED ---- */

int tMenuItemSlidingActivated::UpdatefOpenHeight(bool arg1)

{
  int iVar2;
  int iVar4;

  /* MATCH: store IN each branch (gcc cross-jump-merges the two `sh`s back into
     the oracle's single join store); a shared `sVar1` temp costs an extra reg
     + copy. */
  if (this->fActive != 0) {
    this->fSlideOffset = this->fSlideOffset + -3;
  }
  else {
    this->fSlideOffset = this->fSlideOffset + 3;
  }
  /* MATCH: the fHeight limit is computed BEFORE the fSlideOffset read (oracle
     `lhu 0x26` then `lh 0x2A`) — the reversed order swaps their registers.
     The limit is ONE natural expression (same spelling as TransitionOn): the
     hand-split `<<0x10` intermediate minted an extra named pseudo, which pushed
     the sum off `$v1` and forced a return funnel for uVar3. */
  iVar2 = (int)this->fHeight + ((int)this->fHeight >> 1);
  iVar4 = (int)this->fSlideOffset;
  if (iVar4 < iVar2) {
    iVar2 = iVar4;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  /* MATCH (06A): retail DROPS the result — there is no `return`; $v0 is left
     holding the `slt` of the clamp test incidentally.  An explicit
     `return uVar3;` funnels it through a second register (`addu a2,v0,zero`
     + `addu v0,a2,zero`). */
  this->fSlideOffset = (short)iVar2;
}



/* ---- tMenuItemSlidingActivated::TransitionOff  [FEMENUOPTIONS.CPP:937-944] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::TransitionOff()

{
  this->fFadeDir = 0;
  this->fTransitioningOut = 1;
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    this->fInTransition = 1;
    this->fFadeDir = 0x1e;
    this->fFadeVal = 0;
  }
  return;
}



/* ---- tMenuItemSlidingActivated::TransitionOn  [FEMENUOPTIONS.CPP:949-960] SLD-FLAG:NONMONO ---- */

void tMenuItemSlidingActivated::TransitionOn()

{
  /* MATCH: SYM = no locals; direct member exprs, fSlideOffset BEFORE fOpenHeight
     (oracle keeps pre-sum fHeight copied to a1, stores 0x2A then 0x28-in-jr-slot) */
  this->fFadeDir = -0x1e;
  this->fInTransition = 1;
  this->fActive = 0;
  this->fTransitioningOut = 0;
  this->fFadeVal = 0x80;
  this->fSlideOffset = this->fHeight + (this->fHeight >> 1);
  this->fOpenHeight = this->fHeight;
  return;
}



/* ---- tMenuItemSlidingActivated::TransitionIsFinished  [FEMENUOPTIONS.CPP:964-979] SLD-VERIFIED ---- */

void * tMenuItemSlidingActivated::TransitionIsFinished()

{
  /* MATCH: same if/else-if chain as tMenuItemSlidingMenu::TransitionIsFinished. */
  if ((this->currMenu == (tInsideBoxMenu *)0x0) || (this->nextMenu == (tInsideBoxMenu *)0x0)) {
    this->fFadeDir = 0;
    this->fInTransition = 0;
  } else if (this->fFadeDir == 0) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir < 0) && (this->fFadeVal <= 0)) {
    this->fInTransition = 0;
  } else if ((this->fFadeDir > 0) && (this->fFadeVal >= 0x80)) {
    this->fInTransition = 0;
  } else {
    this->fInTransition = 1;
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemSlidingActivated::UpdateTransition  [FEMENUOPTIONS.CPP:983-986] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = this->_vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&this->fFlags + (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemSlidingActivated::ProcessInput  [FEMENUOPTIONS.CPP:990-1044] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  AudioMus_tSongList *pAVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [11];
  tInsideBoxMenu *ptVar4;
  
  /* MATCH (catalog §B arm-order): the oracle branches AWAY on `== Cross`
     (`beq v1,v0`) and lays the Cross body OUT-OF-LINE at the end, falling
     through into the Triangle test.  The `!=`-first spelling reproduces that
     polarity + block layout; the natural `== Cross` first inlines it. */
  if (keyval != kInput_KeyType_Cross) {
    if ((keyval == kInput_KeyType_Triangle) && (this->fActive != 0)) {
      AudioCmn_PlayFESFX(1);
      this->fActive = 0;
      keyval = kInput_KeyType_AlreadyProcessed;
      AudioMus_StopSong(0x14);
      if (screenAudio->songlist != (AudioMus_tSongList *)0x0) {
        purgememadr(screenAudio->songlist);
      }
      screenAudio->songlist = (AudioMus_tSongList *)0x0;
      AudioMus_SysCleanUp();
      AudioMus_SysStartUp(0xd800,0x18000,"amus");
      AudioMus_PlaySong("zmenu*");
    }
  }
  else if (this->fActive == 0) {
    AudioCmn_PlayFESFX(0);
    this->fActive = 1;
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioMus_StopSong(0x14);
    AudioMus_SysCleanUp();
    AudioMus_SysStartUp(0xc000,0x18000,"ymus");
    AudioMus_PlaySong("game*");
    pAVar1 = AudioMus_GetSongList("*",0);
    screenAudio->songlist = pAVar1;
  }
  if (this->fSlideOffset == 0) {
    iVar2 = this->fActive;
    if (iVar2 == 0) goto SlideActivProc_callBaseProcess;
    ptVar4 = this->currMenu;
    if (ptVar4 != (tInsideBoxMenu *)0x0) {
      pa_Var3 = (ptVar4)->_vf;
      /* MATCH (methodology #11): the vtable `pfn` is `int(*)(...)`, so passing the
         two REFERENCE params through it decays them to BY-VALUE copies (a2/a3 +
         a stack word).  The oracle passes the references themselves (a2=&keyval,
         a3=&command) -> cast the fn-ptr to the real reference signature.  Also
         `(int)ptVar4 + delta` (not fItemList-0x10) to get the oracle's
         `addu a0,currMenu,delta` operand order. */
      ((void (*)(int,tPlayer,tInputKeyType &,tMenuCommand &))(*pa_Var3)[3].pfn)
                ((int)ptVar4 + (*pa_Var3)[3].delta,fromPlayer,keyval,
                 command);
      goto SlideActivProc_getActive;
    }
  }
  else {
SlideActivProc_getActive:
    iVar2 = this->fActive;
  }
  if ((iVar2 != 0) && ((keyval == kInput_KeyType_Up || (keyval == kInput_KeyType_Down)))) {
    keyval = kInput_KeyType_AlreadyProcessed;
  }
SlideActivProc_callBaseProcess:
  ((tMenuItem *)this)->ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuItemLeftRightFade::MyLeftRightDraw  [FEMENUOPTIONS.CPP:1063-1075] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::MyLeftRightDraw(int x,int y)

{
  int ColText;
  char *sMenuText;
  tDrawShapeExtended aCol;
  
  aCol.tint[0] = CalcFadeVal(0xc83c1e,0xbebe,
                            (int)this->fSelFade,(int)this->fFadeVal);
  DrawLeftFlare(y,(int)this->fSelFade,
             (int)this->fFadeVal,this->flareextra);
  ColText = CalcTextFadeSelToHi(textType_Options,
                   this->fSelFade,
                   this->fFadeVal);
  sMenuText = TextSys_Word(this->fTextDescription);
  FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,ColText,'\0',1);
  DrawShapeExtended(0x2e,0x18,x + 0x1a,y + 1,0,0,&aCol);
  DrawShapeExtended(0x2f,0x18,x + 0xc8,y + 1,0,0,&aCol);
  return;
}



/* ---- tMenuItemDisplayLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1085-1102] SLD-VERIFIED ---- */

int tMenuItemDisplayLeftRightChoice::Draw(int offx,int offy,bool selected)

{
  /* SYM 8c block: params this($s3)/offx($s0)/offy($s2) and the ONE named local
     `int ColText` ($s2, reusing offy's reg); x/y are compiler temps.
     MATCH: NO return funnel — retail drops the result ($v0 is the shared `li 2`
     stack arg, and on the fade==0x80 early-out it is the compare's `li 0x80`);
     x stays an int narrowed PER USE, y's narrowing CSEs into its own reg. */
  short sVar1;
  int ColText;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var4) [6];
  tListIterator *ptVar5;
  int x;
  int y;

  if (this->fFadeVal != 0x80) {
    x = TextSys_WordX(this->fTextDescription) + offx;
    y = TextSys_WordY(this->fTextDescription) + offy;
    ColText = CalcTextFadeSelToHi(textType_Options,
                     this->fSelFade,this->fFadeVal);
    this->MyLeftRightDraw((short)x,(short)y);
    ptVar5 = this->fData;
    pa_Var4 = ptVar5->_vf;
    sVar1 = (*(*pa_Var4)[3].pfn)
                      ((char *)ptVar5 + (int)(*pa_Var4)[3].delta,gMenu_SubMenuPlayer);
    sMenuText = TextSys_Word((int)sVar1);
    FETextRender_FullTextRGB(sMenuText,(short)(x + 0x73),(short)y,ColText,'\0',2);
  }
}



/* ---- tMenuItemOnOffLeftRightChoice::TransitionOn  [FEMENUOPTIONS.CPP:1105-1107] SLD-VERIFIED ---- */

void tMenuItemOnOffLeftRightChoice::TransitionOn()

{
  u_int cVar1;
  u_int bSet;
  tListIterator *ptVar2;
  __vtbl_ptr_type (*pa_Var3) [6];

  ptVar2 = this->fData;
  pa_Var3 = ptVar2->_vf;
  cVar1 = (*(u_char (*)(char *, int))(*pa_Var3)[2].pfn)((char *)ptVar2 + (int)(*pa_Var3)[2].delta,0xffffffff);
  bSet = (0 < cVar1);
  this->fOnFade = (u_short)(bSet << 7);
  this->TransitionOn();
  return;
}



/* ---- tMenuItemOnOffLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1111-1140] SLD-VERIFIED ---- */

int tMenuItemOnOffLeftRightChoice::Draw(int offx,int offy,bool selected)

{
  /* MATCH (same family as tMenuItemDisplayLeftRightChoice::Draw): no return
     funnel, in-branch fOnFade stores, x/y plain ints narrowed PER USE, and the
     TextSys_Word results consumed straight into $a0. */
  char cVar1;
  __vtbl_ptr_type (*pa_Var3) [6];
  int x;
  int y;
  tListIterator *ptVar6;
  int ColTextOn;
  int ColTextOff;

  if (this->fFadeVal != 0x80) {
    ptVar6 = this->fData;
    pa_Var3 = ptVar6->_vf;
    cVar1 = (*(*pa_Var3)[2].pfn)
                      ((char *)ptVar6 + (int)(*pa_Var3)[2].delta,0xffffffff);
    /* MATCH: branch polarity — the `!= 0` (+0x20) arm is the FALL-THROUGH. */
    if (cVar1 != '\0') {
      this->fOnFade = this->fOnFade + 0x20;
    }
    else {
      this->fOnFade = this->fOnFade + -0x20;
    }
    if (0x80 < this->fOnFade) {
      this->fOnFade = 0x80;
    }
    if (this->fOnFade < 0) {
      this->fOnFade = 0;
    }
    x = TextSys_WordX(this->fTextDescription) + offx;
    y = TextSys_WordY(this->fTextDescription) + offy;
    CalcOnOffFade(textType_Options,this->fOnFade,
               this->fSelFade,this->fFadeVal,&ColTextOn,&ColTextOff);
    this->MyLeftRightDraw((short)x,(short)y);
    FETextRender_FullTextRGB(TextSys_Word(0x66),(short)(x + 0x37),(short)y,ColTextOn,'\0',0);
    FETextRender_FullTextRGB(TextSys_Word(0x67),(short)(x + 0x9e),(short)y,ColTextOff,'\0',0);
  }
}



/* ---- tMenuItemLeftRightAudioSlider::ctor  [FEMENUOPTIONS.CPP:1152-1156] SLD-VERIFIED ---- */
tMenuItemLeftRightAudioSlider::tMenuItemLeftRightAudioSlider(u_int textDescription,tListIterator *dataPtr,
          int AudioArt)
  : tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightAudioSlider_vtable;
  this->fAudioArt = (short)AudioArt;
  this->flareextra = 0;
  this->fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::dtor  [FEMENUOPTIONS.CPP:1160-1160] SLD-VERIFIED ---- */

tMenuItemLeftRightAudioSlider::~tMenuItemLeftRightAudioSlider()

{
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightAudioSlider_vtable;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::Draw  [FEMENUOPTIONS.CPP:1167-1201] SLD-VERIFIED ---- */

int tMenuItemLeftRightAudioSlider::Draw(int ox,int oy,bool selected)

{
  u_short uVar1;
  int coltext;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var3) [6];
  tListIterator *ptVar4;
  u_int uVar5;
  int iVar6;
  int *rgbVals;
  tDrawShapeExtended tCol;

  /* MATCH: `textDefinitions` is 6 bytes per row in retail (index scaling
     `sll 1; addu` = *3, then *2) — the externs header now carries the true
     [14][6] shape (it used to say [6][14] -> stride 14 -> `sll 3; subu` = *7,
     a real OOB addressing bug).
     Also: read (short)fTextDescription straight off the field (`lh 4(s3)`) —
     the `u_int uVar5` cache forced an `lw` + `sll/sra` pair. */
  coltext = TextSys_WordX(this->fTextDescription);
  this->fX = (short)coltext + (short)ox;
  coltext = TextSys_WordY(this->fTextDescription);
  this->fY = (short)coltext + (short)oy;
  /* MATCH (methodology #16): the oracle completes the `la s1,kRGBVals` BEFORE the
     TextSys_WordFlags call (s1 held across it); the natural in-expression use
     rematerializes the address after the call. */
  rgbVals = kRGBVals;
  coltext = TextSys_WordFlags((int)(short)this->fTextDescription);
  iVar6 = rgbVals[(u_char)textDefinitions[coltext][5]];
  coltext = TextSys_WordFlags((int)(short)this->fTextDescription);
  coltext = rgbVals[(u_char)textDefinitions[coltext][4]];
  DrawLeftFlare((int)this->fY,
             (int)this->fSelFade,
             (int)this->fFadeVal,this->flareextra);
  coltext = CalcFadeVal(coltext,iVar6,
                     (int)this->fSelFade,
                     (int)this->fFadeVal);
  /* MATCH: no return funnel ($v0 incidental) and the fData reload lives INSIDE
     the DrawSlider argument list. */
  if (this->fFadeVal != 0x80) {
    sMenuText = TextSys_Word(this->fTextDescription);
    FETextRender_FullTextRGB(sMenuText,this->fX,this->fY,
               coltext,'\0',1);
    tCol.tint[0] = CalcFadeVal(0x551e00,0xbebe,
                              (int)this->fSelFade,(int)this->fFadeVal);
    if (this->fSelFade != 0) {
      DrawShapeExtended(this->fAudioArt + 1,0x10,0,0,0,0,&tCol);
    }
    ptVar4 = this->fData;
    pa_Var3 = ptVar4->_vf;
    uVar1 = (*(*pa_Var3)[2].pfn)((char *)ptVar4 + (int)(*pa_Var3)[2].delta,0xffffffff)
    ;
    DrawSlider(uVar1 & 0xff,(u_short)(u_char)this->fData->fMinValue,
               (u_short)(u_char)this->fData->fMaxValue,
               this->fX + 0x14,this->fY + 1,
               this->fWidth,this->fHeight,4,4,
               false,0,this->fSelFade,
               this->fFadeVal);
  }
}



/* ---- tMenuItemLeftRightAudioSlider::Percentage  [FEMENUOPTIONS.CPP:1204-1209] SLD-VERIFIED ---- */

int tMenuItemLeftRightAudioSlider::Percentage()

{
  char cVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  u_int uVar3;
  int iVar4;
  tListIterator *ptVar5;
  tListIterator *ptVar6;
  int percent;

  ptVar5 = this->fData;
  pa_Var2 = ptVar5->_vf;
  uVar3 = (*(*pa_Var2)[2].pfn)((char *)ptVar5 + (int)(*pa_Var2)[2].delta,0xffffffff);
  ptVar6 = this->fData;
  /* MATCH: SLD's only source local is `percent` in $s0.  Assign the scaled
     numerator to it before division; the decompiler's iVar6 pseudo kept that
     value in a caller register and displaced the inlined iterator `this`. */
  percent = ((uVar3 & 0xff) - (u_int)(u_char)ptVar6->fMinValue) * 100;
  iVar4 = (u_int)(u_char)ptVar6->fMaxValue - (u_int)(u_char)ptVar6->fMinValue;
  percent = percent / iVar4;
  cVar1 = (*(*ptVar6->_vf)[2].pfn)
                    ((char *)ptVar6 + (int)(*ptVar6->_vf)[2].delta,0xffffffff);
  if ((cVar1 != '\0') && (percent < 100)) {
    percent = percent + 1;
  }
  return percent;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionOff  [FEMENUOPTIONS.CPP:1212-1214] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::TransitionOff()

{
  this->fFadeVal = 0;
  this->fFadeDir = 0x3c;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionOn  [FEMENUOPTIONS.CPP:1217-1220] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::TransitionOn()

{
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x3c;
  this->fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionIsFinished  [FEMENUOPTIONS.CPP:1223-1231] SLD-VERIFIED ---- */

void * tMenuItemLeftRightAudioSlider::TransitionIsFinished()

{
  this->fInTransition = 0;
  if ((this->fFadeDir < 0) && (0 < this->fFadeVal)) {
    this->fInTransition = 1;
  }
  if ((0 < this->fFadeDir) && (this->fFadeVal < 0x80)) {
    this->fInTransition = 1;
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemLeftRightAudioSlider::UpdateTransition  [FEMENUOPTIONS.CPP:1234-1236] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::UpdateTransition(bool selected)

{
  int iVar1;
  
  iVar1 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar1) {
    iVar1 = 0x80;
  }
  if (iVar1 < 0) {
    iVar1 = 0;
  }
  this->fFadeVal = (short)iVar1;
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tInsideBoxSongMenu::ctor  [FEMENUOPTIONS.CPP:1247-1259] SLD-VERIFIED ---- */

tInsideBoxSongMenu::tInsideBoxSongMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
{
  int j;

  new ((tMenu *)this) tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title);
  j = 0;
  *(void **)&(this->_vf) = (void *)tInsideBoxSongMenu_vtable;
  do {
    this->fSelFade[j] = 0;
    this->fOnOffFade[j] = 0;
    j = j + 1;
  } while (j < 5);
  ((tMenu *)this)->tMenuConstructor(firstItem,(&firstItem + 1));
  this->fMoving = 0;
  this->fMovingDir = 0;
  return;
}



/* ---- tInsideBoxSongMenu::dtor  [FEMENUOPTIONS.CPP:1263-1263] SLD-VERIFIED ---- */

tInsideBoxSongMenu::~tInsideBoxSongMenu()

{
  *(void **)&(this->_vf) = (void *)tInsideBoxSongMenu_vtable;
  return;
}



/* ---- tInsideBoxSongMenu::Draw  [FEMENUOPTIONS.CPP:1271-1314] SLD-VERIFIED ---- */

void tInsideBoxSongMenu::Draw(short x,short y,short w,short slideOffset,short maxheight)

{
  short sVar1;
  u_short uVar2;
  short sVar3;
  int iVar4;
  int iVar5;
  tInsideBoxSongMenu *ptVar6;
  __vtbl_ptr_type (*pa_Var7) [11];
  int song;
  int j;
  int drawY;
  
  if (screenAudio->songlist != (AudioMus_tSongList *)0x0) {
    j = 0;
    ptVar6 = this;
    do {
      if (j != 2) {
        iVar4 = ptVar6->fSelFade[0] + -8;
        if (iVar4 < 0) {
          iVar4 = 0;
        }
        ptVar6->fSelFade[0] = (short)iVar4;
      }
      j = j + 1;
      ptVar6 = (tInsideBoxSongMenu *)((int)&(ptVar6)->fFlags + 2);
    } while (j < 5);
    j = this->fSelFade[2] + 8;
    if (0x80 < j) {
      j = 0x80;
    }
    sVar3 = this->fMoving;
    sVar1 = this->fMoving;
    this->fSelFade[2] = (short)j;
    if (sVar3 != 0) {
      uVar2 = sVar1 + this->fMovingDir * 2;
      this->fMoving = uVar2;
      if ((this->fMovingDir < 0) && ((int)((u_int)uVar2 << 0x10) < 0)) {
        this->fMoving = 0;
      }
      if ((0 < this->fMovingDir) && (0 < this->fMoving)) {
        this->fMoving = 0;
      }
    }
    j = 0;
    drawY = -0x28;
    ptVar6 = this;
    do {
      iVar5 = screenAudio->fSelectedSong + j;
      song = iVar5 + -2;
      if ((-1 < song) && (song < screenAudio->songlist->numsongs)) {
        if (*(int *)(frontEnd.checkPointDisplay + iVar5 * 4 + -3) == 0) {
          sVar3 = ptVar6->fOnOffFade[0] + -0x20;
        }
        else {
          sVar3 = ptVar6->fOnOffFade[0] + 0x20;
        }
        ptVar6->fOnOffFade[0] = sVar3;
        if (0x80 < ptVar6->fOnOffFade[0]) {
          ptVar6->fOnOffFade[0] = 0x80;
        }
        if (ptVar6->fOnOffFade[0] < 0) {
          ptVar6->fOnOffFade[0] = 0;
        }
        pa_Var7 = this->_vf;
        (*pa_Var7[1][1].pfn)
                  ((int)this->fItemList + pa_Var7[1][1].delta + -0x10,
                   song * 0x10000 >> 0x10,(int)x,
                   (int)(((u_int)(u_short)slideOffset +
                         (u_int)(u_short)this->fMoving +
                         (int)y + (maxheight + -0x15 >> 1) + drawY) * 0x10000) >> 0x10,(int)w,
                   (int)ptVar6->fOnOffFade[0],(int)ptVar6->fSelFade[0]);
      }
      drawY = drawY + 0x15;
      j = j + 1;
      ptVar6 = (tInsideBoxSongMenu *)((int)&(ptVar6)->fFlags + 2);
    } while (j < 5);
  }
  return;
}



/* ---- tInsideBoxSongMenu::DrawOneSong  [FEMENUOPTIONS.CPP:1317-1340] SLD-VERIFIED ---- */

void tInsideBoxSongMenu::DrawOneSong(short songnum,short x,short y,short w,short fOnOffFade,
               short fSelFade)

{
  /* NEAR-MISS 62 (was 106) — count EXACT 139/139, frame + saved-reg set now
     match the SYM ($807f0000 / 64).  Residual = a 3-way rotation of the param
     homes (retail songnum/x/y -> $s4/$s3/$s2, ours x/y/songnum).  Landed levers:
     the SYM local-budget reduction below, dropping the `*0x10000>>0x10`
     pre-shift idiom (06C #6), and `- K` instead of `+ -K` on the unsigned-`w`
     sums (which emitted `li 65446; addu` instead of `addiu -90`).

     SYM 8c block (06A — the local list IS the allocation budget): mask $807f0000
     = s0-s6 + ra, fsize 64, and the ONLY locals are `Col` (REG $s6), `ColText`
     (REG $s0) and the two AUTO ints ColTextOn/ColTextOff.  The Ghidra-invented
     sVar1/pcVar3/iVar4/iVar5 pseudos cost an eighth saved reg ($s7) + 8 frame
     bytes; drop them and use the params directly. */
  int Col;
  int ColText;
  int ColTextOn;
  int ColTextOff;

  Col = CalcFadeVal(0x551e00,0x28);   /* H13: 2nd arg is the literal 0x28 (oracle 0x8001EC84 $a1=0x28), not x */
  CalcOnOffFade(textType_Options,fOnOffFade,fSelFade,0,&ColTextOn,&ColTextOff);
  ColText = CalcTextFadeSelToHi(textType_Options,fSelFade,0);
  FETextRender_FullTextRGB(*(char **)((int)&screenAudio->songlist[1].currentsong +
             ((int)((u_int)(u_short)songnum << 0x10) >> 10)),
             (short)(x + 3),y + 2,ColText,'\0',0);
  FETextRender_FullTextRGB(*(char **)((int)&screenAudio->songlist[2].numsongs +
             ((int)((u_int)(u_short)songnum << 0x10) >> 10)),
             (short)(x + 2),y + 10,ColText,'\0',0);
  FETextRender_FullTextRGB(TextSys_Word(0x66),
             (short)(x + (u_short)w - 0x5a),y + 6,ColTextOn,'\0',2);
  FETextRender_FullTextRGB(TextSys_Word(0x67),
             (short)(x + (u_short)w - 0x1e),y + 6,ColTextOff,'\0',2);
  PSXDrawSquare(Col,(int)x + (int)w + -0x78,(int)y,2,0x13);
  PSXDrawSquare(Col,(int)x + (int)w + -0x3c,(int)y,2,0x13);
  PSXDrawSquare(Col,(int)x,(int)y,(int)w,1);
  PSXDrawSquare(Col,(int)x,(int)y + 0x13,(int)w,-1);
  return;
}



/* ---- tInsideBoxSongMenu::DebounceKeys  [FEMENUOPTIONS.CPP:1344-1345] SLD-VERIFIED ---- */

long tInsideBoxSongMenu::DebounceKeys()

{
  return 0x1e00;
}



/* ---- tInsideBoxSongMenu::ProcessInput  [FEMENUOPTIONS.CPP:1350-1408] SLD-VERIFIED ---- */

void tInsideBoxSongMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* SYM: FCN VOID, one local (int j). w35-a9 diagnosis confirmed against the
     raw oracle: this fn writes its result THROUGH the keyval reference (not
     a return value) -- the earlier `return 0x1000`/`return -0x7ffb0000`
     were Ghidra fictions (the latter a misread `lui v0,%hi(screenAudio)`
     delay slot feeding the fall-through Up-case address materialize, not a
     constant). Real switch (gcc balance_case_nodes: ==0x400 root + <0x401
     bound test over 0x200/0x400/0x800/0x1000), tDialogYesNo recipe. */
  int j;

  if (screenAudio->songlist == (AudioMus_tSongList *)0x0) {
    return;
  }
  if (keyval == kInput_KeyType_Left) {
    AudioCmn_PlayFESFX(5);
  }
  else if (keyval == kInput_KeyType_Right) {
    AudioCmn_PlayFESFX(6);
  }
  switch (keyval) {
  case kInput_KeyType_Left:
    frontEnd.FEPlayList[screenAudio->fSelectedSong] =
         (u_int)(frontEnd.FEPlayList[screenAudio->fSelectedSong] == 0);
    break;
  case kInput_KeyType_Right:
    frontEnd.FEPlayList[screenAudio->fSelectedSong] =
         (u_int)(frontEnd.FEPlayList[screenAudio->fSelectedSong] == 0);
    break;
  case kInput_KeyType_Up:
    if ((screenAudio->fSelectedSong < 1) || (this->fMoving != 0)) break;
    this->fMoving = -0x15;
    this->fMovingDir = 4;
    j = 4;
    do {
      this->fOnOffFade[j] = this->fOnOffFade[j + -1];
      this->fSelFade[j] = this->fSelFade[j + -1];
      j = j + -1;
    } while (0 < j);
    this->fOnOffFade[0] = 0;
    this->fSelFade[0] = 0;
    screenAudio->fSelectedSong = screenAudio->fSelectedSong + -1;
    AudioCmn_PlayFESFX(3);
    break;
  case kInput_KeyType_Down:
    if ((screenAudio->songlist->numsongs + -1 <= (int)screenAudio->fSelectedSong) ||
       (this->fMoving != 0)) break;
    this->fMoving = 0x15;
    this->fMovingDir = -4;
    j = 0;
    do {
      this->fOnOffFade[j] = this->fOnOffFade[j + 1];
      this->fSelFade[j] = this->fSelFade[j + 1];
      j = j + 1;
    } while (j < 4);
    this->fOnOffFade[4] = 0;
    this->fSelFade[4] = 0;
    screenAudio->fSelectedSong = screenAudio->fSelectedSong + 1;
    AudioCmn_PlayFESFX(4);
    break;
  default:
    return;
  }
  keyval = kInput_KeyType_AlreadyProcessed;
}



/* ---- tMenuItemControllerLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1423-1459] SLD-VERIFIED ---- */

int tMenuItemControllerLeftRightChoice::Draw(int ox,int oy,bool selected)

{
  /* MATCH: (a) BASE-ANCHOR — retail holds `&gHelpShapes[0x1e]` in one saved reg
     ($s5: `lui;lw;addiu +960`), not the array base re-indexed per use;
     (b) ONE tDrawShapeExtended AUTO (the 2nd cost 32 frame bytes);
     (c) no return funnel — $v0 is the last stack arg, incidental;
     (d) `y` is an int MUTATED in place by -3 (`addiu s0,s0,-3`) and reused. */
  tTexture_ShapeInfo *shape;
  short sVar2;
  int x;
  int y;
  int Col;
  int ColText;
  int w;
  char *pcVar6;
  __vtbl_ptr_type (*pa_Var7) [6];
  tListIterator *ptVar8;
  tDrawShapeExtended drawFlags;

  x = TextSys_WordX(this->fTextDescription) + ox;
  y = TextSys_WordY(this->fTextDescription) + oy;
  shape = &gHelpShapes[0x1e];
  Col = CalcFadeVal(0xc83c1e,0xbebe,
                     (int)this->fSelFade,
                     (int)this->fFadeVal);
  ColText = CalcTextFadeSelToHi(textType_Options,
                   this->fSelFade,this->fFadeVal);
  if (this->fFadeVal != 0x80) {
    drawFlags.tint[0] = Col;
    pcVar6 = TextSys_Word(this->fTextDescription);
    FETextRender_FullTextRGB(pcVar6,(short)x,(short)y,ColText,'\0',0);
    ptVar8 = this->fData;
    pa_Var7 = ptVar8->_vf;
    sVar2 = (*(*pa_Var7)[3].pfn)
                      ((char *)ptVar8 + (int)(*pa_Var7)[3].delta,gMenu_SubMenuPlayer);
    pcVar6 = TextSys_Word((int)sVar2);
    FETextRender_FullTextRGB(pcVar6,(short)(x + 0x97),(short)y,ColText,'\0',2);
  }
  drawFlags.tint[0] = CalcFadeVal(0,0xbebe,(int)this->fSelFade,
                            (int)this->fFadeVal);
  DrawShapeExtended(0xa,0x18,(short)x + 0x83,(short)y,0,1,&drawFlags);
  DrawShapeExtended(0xb,0x18,(short)x + 0xa1,(short)y,0,1,&drawFlags);
  /* MATCH: keep the subtraction UN-reassociated — inline, gcc rewrites
     `x - (w - 0xb0)` into `(x + 0xb0) - w`; a temp pins the oracle's
     `addiu a2,a2,-176; subu a2,s1,a2`. */
  w = (int)shape->width - 0xb0;
  DrawShapeExtended(0x1e,8,(short)x - w,(short)y - 3,
             (int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
  PSXDrawSquare(0,(short)x,(short)y - 3,0xb0 - shape->width,(int)shape->height);
}



/* ---- tInsideBoxLeftRightSlider::ctor  [FEMENUOPTIONS.CPP:1465-1469] SLD-VERIFIED ---- */
tInsideBoxLeftRightSlider::tInsideBoxLeftRightSlider(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&(this->_vf) = (void *)tInsideBoxLeftRightSlider_vtable;
  this->fSelFade = 0;
  this->fHeight = 5;
  return;
}



/* ---- tInsideBoxLeftRightSlider::dtor  [FEMENUOPTIONS.CPP:1473-1473] SLD-VERIFIED ---- */

tInsideBoxLeftRightSlider::~tInsideBoxLeftRightSlider()

{
  *(void **)&(this->_vf) = (void *)tInsideBoxLeftRightSlider_vtable;
  return;
}



/* ---- tInsideBoxLeftRightSlider::Draw  [FEMENUOPTIONS.CPP:1480-1493] SLD-VERIFIED ---- */

int tInsideBoxLeftRightSlider::Draw(int x,int y,int w,bool selected)

{
  /* MATCH: no `fSelFade`/`col` return funnel — retail's Draw drops its result
     ($v0 is DrawSlider's, incidental), so the `lh 8(s0)` for the fSelFade arg is
     emitted LATE at the call instead of being hoisted into a saved reg.  Decl
     order coltext-before-col is the s3/s4 assignment. */
  u_short uVar1;
  int coltext;
  int col;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var3) [6];
  tListIterator *ptVar4;
  
  this->fX = (short)x;
  this->fY = (short)y;
  col = CalcFadeVal(0x551e00,0xc83c1e,
                     (int)this->fSelFade);
  coltext = CalcTextFadeUnselToSel(textType_Options,
                      this->fSelFade,0);
  PSXDrawSquare(col,(int)this->fX,(int)this->fY
             ,w,1);
  PSXDrawSquare(col,(int)this->fX,this->fY + 8,
             w,1);
  sMenuText = TextSys_Word(this->fTextDescription);
  FETextRender_FullTextRGB(sMenuText,this->fX + 4,
             this->fY + 10,coltext,'\0',0);
  ptVar4 = this->fData;
  pa_Var3 = ptVar4->_vf;
  uVar1 = (*(*pa_Var3)[2].pfn)((char *)ptVar4 + (int)(*pa_Var3)[2].delta,0xffffffff);
  /* MATCH: the fData reload belongs INSIDE the argument list (a preceding
     `ptVar4 = this->fData;` statement schedules it between the fX and fY reads). */
  DrawSlider(uVar1 & 0xff,(u_short)(u_char)this->fData->fMinValue,
             (u_short)(u_char)this->fData->fMaxValue,
             this->fX + 4,this->fY + 2,
             (short)((u_int)((w + -8) * 0x10000) >> 0x10),this->fHeight,4,
             4,false,0,this->fSelFade,0);
}



/* ---- tInsideBoxTwoWaySlider::ctor  [FEMENUOPTIONS.CPP:1497-1504] SLD-VERIFIED ---- */
tInsideBoxTwoWaySlider::tInsideBoxTwoWaySlider(u_int textDescription,tListIterator *dataPtr,int type)
  : tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&(this->_vf) = (void *)tInsideBoxTwoWaySlider_vtable;
  this->fType = (short)type;
  this->fSelFade = 0;
  this->fHeight = 5;
  this->fActive = 0;
  return;
}



/* ---- tInsideBoxTwoWaySlider::dtor  [FEMENUOPTIONS.CPP:1508-1508] SLD-VERIFIED ---- */

tInsideBoxTwoWaySlider::~tInsideBoxTwoWaySlider()

{
  *(void **)&(this->_vf) = (void *)tInsideBoxTwoWaySlider_vtable;
  return;
}



/* ---- tInsideBoxTwoWaySlider::ProcessInput  [FEMENUOPTIONS.CPP:1512-1536] SLD-VERIFIED ---- */

int tInsideBoxTwoWaySlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* MATCH: plain straight-line ifs reading the `keyval` REFERENCE directly — no
     tVar1 cache, no volatile, no goto.  gcc reloads keyval at the end of the
     Cross body all by itself (partial redundancy across the two `if (keyval==K)`
     statements), and jump-threads the `!fActive` R1 exit straight into the
     Left/Right test.  The tVar1 cache was also what stole $s0 from `keyval`. */
  if (keyval == kInput_KeyType_Cross) {
    AudioCmn_PlayFESFX(0);
    this->fActive = 1;
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  if (keyval == kInput_KeyType_R1) {
    if (this->fActive != 0) {
      AudioCmn_PlayFESFX(1);
      this->fActive = 0;
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  if (this->fActive != 0) {
    keyval = kInput_KeyType_AlreadyProcessed;
    return 1;
  }
  if ((keyval != kInput_KeyType_Left) && (keyval != kInput_KeyType_Right)) {
    return 0x1000;
  }
  keyval = kInput_KeyType_AlreadyProcessed;
  return 1;
}



/* ---- tInsideBoxTwoWaySlider::Draw  [FEMENUOPTIONS.CPP:1543-1573] SLD-VERIFIED ---- */

int tInsideBoxTwoWaySlider::Draw(int x,int y,int w,bool selected)

{
  short sVar1;
  u_short uVar2;
  int col2;
  int col;
  int coltext;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var4) [6];
  tListIterator *ptVar5;
  short fWidth;
  int ww;

  if (this->fActive != 0) {
    this->Calibrate();
  }
  /* MATCH (LAW 05A — the SLD IS the statement order): retail computes `ww` at
     line 1553, BEFORE the 1555 fX/fY + CalcFadeVal group; hoisting it here is
     what puts the `w` param in $s2 and `y` in $s1 like the oracle.
     Also: read fSelFade AT the call — a `short sVar1` copy makes gcc stage it
     `lhu; sll 16; sra 16` (+2) where the oracle has a bare `lh`. */
  ww = (w >> 1) + -4;
  this->fX = (short)x;
  this->fY = (short)y;
  col2 = CalcFadeVal(0x551e00,0xc83c1e,(int)this->fSelFade);
  col = CalcFadeVal(0x551e00,0xbebe,
                   (int)this->fSelFade);
  coltext = CalcTextFadeUnselToSel(textType_Options,
                      this->fSelFade,0);
  PSXDrawSquare(col2,(int)this->fX,(int)this->fY
             ,ww,1);
  PSXDrawSquare(col2,this->fX + ww + 8,
             (int)this->fY,ww,1);
  PSXDrawSquare(col2,(int)this->fX,this->fY + 8,
             ww,1);
  PSXDrawSquare(col2,this->fX + ww + 9,
             this->fY + 8,ww,1);
  PSXDrawSquare(col,this->fX + ww + 3,
             (int)this->fY,2,9);
  sMenuText = TextSys_Word(this->fTextDescription);
  FETextRender_FullTextRGB(sMenuText,this->fX + 4,
             this->fY + 10,coltext,'\0',0);
  ptVar5 = this->fData;
  pa_Var4 = ptVar5->_vf;
  uVar2 = (*(*pa_Var4)[2].pfn)((char *)ptVar5 + (int)(*pa_Var4)[2].delta,0xffffffff);
  /* MATCH (see tInsideBoxLeftRightSlider::Draw): the fData reload belongs INSIDE
     the argument list, and retail drops the result ($v0 = DrawSlider's). */
  fWidth = (short)((u_int)(((w >> 1) + -8) * 0x10000) >> 0x10);
  DrawSlider(uVar2 & 0xff,(u_short)(u_char)this->fData->fMinValue,
             (u_short)(u_char)this->fData->fMaxValue,
             this->fX + 1,this->fY + 2,fWidth,
             this->fHeight,4,4,true,0,
             this->fSelFade,0);
  ptVar5 = this->fData;
  pa_Var4 = ptVar5->_vf;
  uVar2 = (*(*pa_Var4)[2].pfn)((char *)ptVar5 + (int)(*pa_Var4)[2].delta,0xffffffff);
  DrawSlider(uVar2 & 0xff,(u_short)(u_char)this->fData->fMinValue,
             (u_short)(u_char)this->fData->fMaxValue,
             (short)(((u_int)(u_short)this->fX + ww + 10) * 0x10000 >>
                    0x10),this->fY + 2,fWidth,
             this->fHeight,4,4,false,0,this->fSelFade,0);
}



/* ---- GetCurrentStickRange  [FEMENUOPTIONS.CPP:1578-1582] SLD-VERIFIED ---- */

/* MATCH: 5-line retail body — a two-armed TERNARY per axis (the arms funnel into
   the result pseudo via `addu v1,v0,zero`, which an if/else form computes in
   place instead), and an INT return (the `char` return added the oracle-absent
   `andi v0,v0,255`). */
int GetCurrentStickRange(int player)

{
  int range1;
  int range2;

  range1 = 0x80 - (int)gPadinfo.buf[player * 4].data.negcon.twist;
  if (range1 < 1) {
    range1 = (int)gPadinfo.buf[player * 4].data.negcon.twist - 0x80;
  }
  range2 = 0x80 - (int)gPadinfo.buf[player * 4].data.negcon.buttonI;
  if (range2 < 1) {
    range2 = (int)gPadinfo.buf[player * 4].data.negcon.buttonI - 0x80;
  }
  if (range2 < range1) {
    range2 = range1;
  }
  return range2;
}



/* ---- GetCurrentStickRange2  [FEMENUOPTIONS.CPP:1586-1590] SLD-VERIFIED ---- */

/* MATCH: see GetCurrentStickRange — INT return (the `char` return emitted an
   oracle-absent `andi v0,v0,255`) and the field re-read per arm.
   NEAR-MISS 17: residual is a v0/v1 qty-numbering swap (ours loads the axis byte
   into $v1 + the shared `li 128` into $v0; oracle the reverse) plus the one
   funnel copy `addu v1,v0,zero` gcc coalesces away for us. */
int GetCurrentStickRange2(int player)

{
  int range1;
  int range2;

  range1 = 0x80 - (int)gPadinfo.buf[player * 4].data.negcon.buttonII;
  if (range1 < 1) {
    range1 = (int)gPadinfo.buf[player * 4].data.negcon.buttonII - 0x80;
  }
  range2 = 0x80 - (int)gPadinfo.buf[player * 4].data.negcon.leftshift;
  if (range2 < 1) {
    range2 = (int)gPadinfo.buf[player * 4].data.negcon.leftshift - 0x80;
  }
  if (range2 < range1) {
    range2 = range1;
  }
  return range2;
}



/* ---- tInsideBoxTwoWaySlider::Calibrate  [FEMENUOPTIONS.CPP:1595-1678] SLD-VERIFIED ---- */

void tInsideBoxTwoWaySlider::Calibrate()

{
  int range;
  int player;
  tPadModuleState *padInfo;
  tPadModuleState *padBase;
  tScreenControllerConfig *screen;
  tFEApplication *app;

  /* MATCH (12->4): preserve the retail volatile global-pointer load order,
     then expose gPadinfo's base before reading the player byte.  This gives
     GCC the exact screen/a0, app/v1, and pad-base lifetimes; only the dying
     FEApp symbol-address scratch remains a v1-vs-v0 allocation tie. */
  screen = *(tScreenControllerConfig * volatile *)&screenControllerConfig[0];
  app = *(tFEApplication * volatile *)&FEApp;
  /* MATCH: GetCurrentStickRange{,2} return INT (their oracles carry no mask) and
     the CALLER narrows — `range = (u_char)GetCurrentStickRange(...)` is the
     oracle's `andi a1,v0,255` right after each jal. */
  padBase = &gPadinfo;
  player = (u_char)app->fInputPlayer;
  padInfo = (tPadModuleState *)((char *)padBase + player * 0x20);
  fHelpText[0] = GetHelpText(screen);
  switch (this->fType) {
  case 0:
    if (padInfo->buf[0].ID == '#') {
      range = padInfo->buf[0].data.negcon.twist;
      range = (range < 0x80) ? 0x80 - range : range - 0x80;
      if (range < (u_char)frontEnd.deadSpot[player] + 10) {
        range = (u_char)frontEnd.deadSpot[player] + 10;
      }
      frontEnd.steeringRange[player] = (char)range;
    }
    else if ((padInfo->buf[0].ID == 'S') || (padInfo->buf[0].ID == 's')) {
      range = (u_char)GetCurrentStickRange(player);
      if (range < (u_char)frontEnd.J1MIN[player] + 10) {
        range = (u_char)frontEnd.J1MIN[player] + 10;
      }
      frontEnd.J1MAX[player] = (char)range;
    }
    break;
  case 1:
    if (padInfo->buf[0].ID == '#') {
      char value;

      range = padInfo->buf[0].data.negcon.twist;
      range = (range < 0x80) ? 0x80 - range : range - 0x80;
      if ((u_char)frontEnd.steeringRange[player] - 10 < range) {
        range = (u_char)frontEnd.steeringRange[player] - 10;
      }
      value = (char)range;
      if (range < 0) {
        value = 0;
      }
      frontEnd.deadSpot[player] = value;
    }
    else if ((padInfo->buf[0].ID == 'S') || (padInfo->buf[0].ID == 's')) {
      char value;

      range = (u_char)GetCurrentStickRange(player);
      if ((u_char)frontEnd.J1MAX[player] - 10 < range) {
        range = (u_char)frontEnd.J1MAX[player] - 10;
      }
      value = (char)range;
      if (range < 0) {
        value = 0;
      }
      frontEnd.J1MIN[player] = value;
    }
    break;
  case 2:
    if (padInfo->buf[0].ID == '#') {
      char value;

      range = padInfo->buf[0].data.negcon.buttonI;
      value = (char)range;
      if (range < 0) {
        value = 0;
      }
      frontEnd.ImaxRange[player] = value;
    }
    else if ((padInfo->buf[0].ID == 'S') || (padInfo->buf[0].ID == 's')) {
      char value;

      range = (u_char)GetCurrentStickRange2(player);
      if (range < (u_char)frontEnd.J2MIN[player] + 10) {
        range = (u_char)frontEnd.J2MIN[player] + 10;
      }
      frontEnd.J2MAX[player] = (char)range;
      value = (char)range;
      if (range < 0) {
        value = 0;
      }
      frontEnd.J2MAX[player] = value;
    }
    break;
  case 3:
    if (padInfo->buf[0].ID == '#') {
      /* MATCH: the bound is an int carrier.  GCC can then share literal 10
         between the comparison and fallback value, selecting retail's
         `li; slt` pair instead of `slti` followed by a late `li`. */
      int minimum;

      range = padInfo->buf[0].data.negcon.buttonII;
      minimum = 10;
      if (minimum <= range) {
        minimum = range;
      }
      frontEnd.IImaxRange[player] = minimum;
    }
    else if ((padInfo->buf[0].ID == 'S') || (padInfo->buf[0].ID == 's')) {
      char value;

      range = (u_char)GetCurrentStickRange2(player);
      if ((u_char)frontEnd.J2MAX[player] - 10 < range) {
        range = (u_char)frontEnd.J2MAX[player] - 10;
      }
      value = (char)range;
      if (range < 0) {
        value = 0;
      }
      frontEnd.J2MIN[player] = value;
    }
    break;
  }
  return;
}



/* ---- tUserNameMenuItem::ctor  [FEMENUOPTIONS.CPP:1688-1697] SLD-VERIFIED ---- */
tUserNameMenuItem::tUserNameMenuItem(u_int textDescription)
  : tMenuItem(textDescription)
{
  short i;
  
  i = 0;
  *(void **)&(this->_vf) = (void *)tUserNameMenuItem_vtable;
  this->fCurrentRow = 0;
  this->fCurrentColumn = 0;
  do {
    this->fRowList[0][(short)i * 9] = '\0';
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 10);
  this->fData = (char *)0x0;
  return;
}



/* ---- CheckForCheats  [FEMENUOPTIONS.CPP:1701-1708] SLD-VERIFIED ---- */

bool CheckForCheats(char *fData)

{
  int len;

  for (len = strlen(fData); len < 8; len = len + 1) {
    fData[len] = '\0';
  }
  if ((FECheat_ActivateCheat(fData) != 0) ||
      (FECheat_ActivateBonusByCode(fData) != 0)) {
    return true;
  }
  return false;
}



/* ---- tUserNameMenuItem::ProcessInput  [FEMENUOPTIONS.CPP:1712-1849] SLD-VERIFIED ---- */

void tUserNameMenuItem::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* SYM: FCN VOID, REGPARM this($s0)+keyval($s1) only -- fromPlayer/command
     are dead (never read in the body, matching the oracle: $a3/&command is
     never touched). SYM's 8c block shows NO named locals at all: every
     scalar below is a Ghidra-fabricated compiler temp, not a real variable.
     Real switch(keyval) (gcc balance_case_nodes: ==0x400/Down root, <0x401
     bound test over 0x2/Cross+0x200/Up, else 0x800/Left+0x1000/Right) --
     Down and Up share ONE body (Down falls into a tiny header that
     recomputes 0x200 before the Up/Down split-test; Up's own dispatch
     compare already holds 0x200 and jumps straight into the shared test),
     modeled as case Down: <label> ... ; case Up: goto <label>; per the
     tInsideBoxSongMenu recipe. menu_kUserNameRows is read LAZILY inside the
     Down arm only (oracle stages the lui in the shared branch's delay slot,
     not hoisted to function entry). */
  u_char bVar1;
  u_short uVar2;
  short sVar3;
  short sVar4;
  u_int uVar5;
  int iVar7;
  int iVar9;
  int sfxArg;
  u_int uVar10;
  tInputKeyType tVar8;

  tVar8 = keyval;
  switch (tVar8) {
  case kInput_KeyType_Down:
  case kInput_KeyType_Up:
UserNameProcInp_handleUpDown:
    if (tVar8 == kInput_KeyType_Up) {
      uVar2 = this->fCurrentRow - 1;
      this->fCurrentRow = uVar2;
      sfxArg = 3;
      if ((int)((u_int)uVar2 << 0x10) < 0) {
        this->fCurrentRow = menu_kUserNameRows + -1;
      }
    }
    else {
      sVar4 = menu_kUserNameRows;
      sVar3 = this->fCurrentRow + 1;
      this->fCurrentRow = sVar3;
      sfxArg = 4;
      if (sVar4 <= sVar3) {
        this->fCurrentRow = 0;
      }
    }
    AudioCmn_PlayFESFX(sfxArg);
    if (this->fCurrentColumn < 0) {
      this->fCurrentColumn = 0;
    }
UserNameProcInp_markProcessed:
    keyval = kInput_KeyType_AlreadyProcessed;
    break;
  case kInput_KeyType_Left:
    uVar2 = this->fCurrentColumn - 1;
    this->fCurrentColumn = uVar2;
    sfxArg = 3;
    if ((int)((u_int)uVar2 << 0x10) < 0) {
      this->fCurrentColumn = 5;
    }
UserNameProcInp_playSfxAndMarkProcessed:
    AudioCmn_PlayFESFX(sfxArg);
    goto UserNameProcInp_markProcessed;
  case kInput_KeyType_Right:
    sVar4 = this->fCurrentColumn + 1;
    this->fCurrentColumn = sVar4;
    if (5 < sVar4) {
      this->fCurrentColumn = 0;
    }
    AudioCmn_PlayFESFX(4);
    keyval = kInput_KeyType_AlreadyProcessed;
    sVar4 = this->fCurrentColumn;
    iVar9 = this->fCurrentRow * 9;
    iVar7 = 0x2d;
    if (this->fRowList[0][this->fCurrentColumn + iVar9] != '-')
    goto UserNameProcInp_convertAndReturn;
    do {
      this->fCurrentColumn = sVar4 + 1;
      if (5 < (short)(sVar4 + 1)) {
        this->fCurrentColumn = 0;
      }
      sVar4 = this->fCurrentColumn;
    } while (this->fRowList[0][this->fCurrentColumn + iVar9] == '-');
    break;
  case kInput_KeyType_Cross:
    uVar5 = strlen(this->fData);
    bVar1 = this->fRowList[0][(int)this->fCurrentColumn + this->fCurrentRow * 9];
    uVar10 = (u_int)bVar1;
    sVar4 = (short)uVar5;
    if (uVar10 - 0x23 < 2) {
      sfxArg = 0x15;
      if (0 < sVar4) {
        this->fData[sVar4 + -1] = '\0';
        goto UserNameProcInp_playSfxAndMarkProcessed;
      }
      goto UserNameProcInp_markProcessed;
    }
    if ((uVar10 == 0x21) || (uVar10 == 0x40)) {
      if (CheckForCheats(this->fData)) {
        *this->fData = '\0';
        goto UserNameProcInp_skipDashColumns;
      }
      tVar8 = kInput_KeyType_Triangle;
      if ((FEApp->fCurrentMenu[0]->fFlags & 0x100) == 0) {
        tVar8 = kInput_KeyType_Start;
      }
      keyval = tVar8;
    }
    else if ((uVar10 == 0x26) || (uVar10 == 0x5e)) {
      iVar9 = (int)sVar4;
      if (iVar9 < this->fMaxStringLength) {
        this->fData[iVar9] = ' ';
        this->fData[iVar9 + 1] = '\0';
        AudioCmn_PlayFESFX(0x15);
        goto UserNameProcInp_skipDashColumns;
      }
    }
    else {
      iVar7 = (int)sVar4;
      sfxArg = 0x15;
      if (iVar7 < this->fMaxStringLength) {
        this->fData[iVar7] = bVar1;
        this->fData[iVar7 + 1] = '\0';
        goto UserNameProcInp_playSfxAndMarkProcessed;
      }
    }
    AudioCmn_PlayFESFX(1);
    break;
  }
UserNameProcInp_skipDashColumns:
  iVar9 = this->fCurrentRow * 9;
  iVar7 = 0x2d;
  if (this->fRowList[0][this->fCurrentColumn + iVar9] == '-') {
    iVar7 = (u_short)this->fCurrentColumn - 1;
    do {
      this->fCurrentColumn = (short)iVar7;
      if (iVar7 << 0x10 < 0) {
        this->fCurrentColumn = 5;
      }
      iVar7 = (u_short)this->fCurrentColumn - 1;
    } while (this->fRowList[0][this->fCurrentColumn + iVar9] == '-');
  }
UserNameProcInp_convertAndReturn:
  Stattool_SamNelsonsUpperLowerStringConverterForRecords(this->fData);
}



/* ---- SpecialCharacter  [FEMENUOPTIONS.CPP:1853-1869] SLD-VERIFIED ---- */

int SpecialCharacter(char current)

{
  int ret;

  ret = 0;
  switch((u_char)current) {
  case 0xe4:
    ret = 0x51;
    break;
  case 0xf6:
    ret = 0x52;
    break;
  case 0xfc:
    ret = 0x53;
    break;
  case 0xe9:
    ret = 0x54;
    break;
  case 0xe8:
    ret = 0x55;
    break;
  case 0xe1:
    ret = 0x56;
    break;
  case 0xed:
    ret = 0x57;
    break;
  case 0xf3:
    ret = 0x58;
    break;
  case 0xfa:
    ret = 0x59;
    break;
  case 0xf1:
    ret = 0x5a;
    break;
  case 0xe5:
    ret = 0x5b;
  }
  return ret;
}



/* ---- tUserNameMenuItem::Draw  [FEMENUOPTIONS.CPP:1874-1966] SLD-VERIFIED ---- */

int tUserNameMenuItem::Draw(bool selected)

{
  int x;
  int y;
  tTexture_ShapeInfo *shape;
  
  x = TextSys_WordX(this->fTextDescription);
  y = TextSys_WordY(this->fTextDescription);
  shape = &gHelpShapes[0x1e];
  if (this->fFadeVal != 0x80) {
    short j;
    char output[2];
    int ColText;
    int Col;
    tDrawShapeExtended tCol;
    short sl;
    short startx;
    int xx;
    int yy;

    output[1] = '\0';
    ColText = CalcFadeVal(0xbebe,(int)this->fFadeVal);
    Col = CalcFadeVal(0xbebe,(int)this->fFadeVal);
    j = 0;
    FETextRender_FullTextRGB(TextSys_Word(this->fTextDescription),(short)x,(short)y,
                            ColText,'\0',0);
    sl = (short)strlen(this->fData);
    startx = x + 0x4e + this->fMaxStringLength * -10;
    if (0 < sl) {
      do {
        output[0] = this->fData[j];
        FETextRender_FullTextRGB(output,(short)(startx + j * 0x14),(short)(y + 0x11),
                                ColText,'\x01',0);
        __asm__("" : : "r"(this));
        j = j + 1;
      } while (j < sl);
    }
    if (sl < this->fMaxStringLength) {
      for (j = sl; j < this->fMaxStringLength; j = j + 1) {
        PSXDrawSquare(Col,startx + j * 0x14,y + 0x19,0x11,1);
      }
    }
    xx = this->fCurrentColumn * 0x1c + 0x102;
    yy = MENUUSERNAME_STARTY + this->fCurrentRow * 0xf;
    if (this->fFadeVal == 0) {
      tDrawShapeExtended fFlags;
      char current;

      fFlags.tint[0] = PulsateYellow[0];
      current = this->fRowList[0][(int)this->fCurrentColumn + this->fCurrentRow * 9];
      if ((current == '!') || (current == '@')) {
        DrawShapeExtended(0x4e,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
      else if ((u_char)(current - 0x23U) < 2) {
        DrawShapeExtended(0x4f,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
      else if ((current == '&') || (current == '^')) {
        DrawShapeExtended(0x50,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
      else if ((u_char)(current - 0x61U) < 0x1a) {
        DrawShapeExtended((u_char)current - 0x37,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
      else if ((u_char)(current - 0x30U) < 0xa) {
        DrawShapeExtended((u_char)current + 0x14,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
      else {
        int shapetodraw = SpecialCharacter(current);
        DrawShapeExtended(shapetodraw,0x10,xx - 5,yy - 3,0,0,&fFlags);
      }
    }
  }
  DrawShapeExtended(0x1e,8,x + 0x9c - (int)shape->width,y - 3,
                    (int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
  PSXDrawSquare(0,x,y + -3,0x9c - shape->width,(int)shape->height);
  shape = &gHelpShapes[0x21];
  DrawShapeExtended(0x21,8,x + 0x9c - (int)shape->width,y + 0xc,
                    (int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
  PSXDrawSquare(0,x,y + 0xc,0x9c - shape->width,(int)shape->height);
}



/* ---- tUserNameMenuItem::TransitionOff  [FEMENUOPTIONS.CPP:1973-1974] SLD-VERIFIED ---- */

void tUserNameMenuItem::TransitionOff()

{
  this->fFadeDir = 0x1e;
  return;
}



/* ---- tUserNameMenuItem::TransitionOn  [FEMENUOPTIONS.CPP:1978-2013] SLD-VERIFIED ---- */

void tUserNameMenuItem::TransitionOn()

{
  /* SYM 8c block: locals are exactly `short i` (REG $s2) and
     `short NumberOfRows[6]` (AUTO -0x28 = sp+0x10) -- the 6 other Ghidra temps
     and the hand-expanded unaligned store soup were fictions: the table is an
     AGGREGATE INITIALIZER, i.e. gcc's own 12-byte rodata->stack block copy
     (3x lwl/lwr + swl/swr from D_80010A00).  SLD: 1982-1985 the sprintf loop /
     1989 the table / 1990 kUserNameRows / 1992-1994 the row+column scan /
     1996 fCurrentRow-- / 2000-2003 fade+selfade / 2010-2012 the speech. */
  short i;
  /* MATCH: unsized-array asm-label view of the scalar extern.  A scalar extern
     compiles to the single `lh $r,sym` / `sh $r,sym` ASSEMBLER MACRO, which is
     unschedulable (delay-slot poison) and uses the `$at` scratch on stores; the
     array view splits it into a schedulable lui + lh/sh pair like the oracle. */
  extern short menu_kUserNameRowsA[] __asm__("menu_kUserNameRows");

  for (i = 0; i < 10; i++) {
    sprintf(this->fRowList[i],TextSys_Word(i + 0x1fb));
  }

  {
    short NumberOfRows [6] = { 7, 9, 9, 9, 8, 9 };   /* @0x80010A00 */
    short *dst = menu_kUserNameRowsA;   /* MATCH: hoist the store-addr lui before the frontEnd.language lbu */

    dst[0] = NumberOfRows[(u_char)frontEnd.language];
  }

  this->fCurrentRow = 0;
  while ((this->fRowList[this->fCurrentRow][this->fCurrentColumn] != '!') &&
         (this->fRowList[this->fCurrentRow][this->fCurrentColumn] != '@') &&
         (this->fCurrentRow < menu_kUserNameRowsA[0])) {
    this->fCurrentColumn = 0;
    while ((this->fRowList[this->fCurrentRow][this->fCurrentColumn] != '!') &&
           (this->fRowList[this->fCurrentRow][this->fCurrentColumn] != '@') &&
           ((int)this->fCurrentColumn < (int)strlen(this->fRowList[this->fCurrentRow]))) {
      this->fCurrentColumn = this->fCurrentColumn + 1;
    }
    this->fCurrentRow = this->fCurrentRow + 1;
  }
  this->fCurrentRow = this->fCurrentRow - 1;
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x1e;
  this->fSelFade = 0;
  {
    /* MATCH (methodology #16): the oracle keeps &FEApp in a callee-saved reg
       ($s2) ACROSS the FeAudio_AsyncPlaySpeech call and reloads the pointer
       through it; taking the address into a local forces the sN hoist. */
    extern tFEApplication *FEAppA[] __asm__("FEApp");
    if (FEAppA[0]->speechToPlay[this->fPlayer] != -1) {
      FeAudio_AsyncPlaySpeech(2,FEAppA[0]->speechToPlay[this->fPlayer]);
      FEAppA[0]->speechToPlay[this->fPlayer] = -1;
    }
  }
  return;
}



/* ---- tUserNameMenuItem::TransitionIsFinished  [FEMENUOPTIONS.CPP:2018-2028] SLD-VERIFIED ---- */

void * tUserNameMenuItem::TransitionIsFinished()

{
  this->fInTransition = 0;
  if (this->fFadeDir < 0) {
    if (0 < this->fFadeVal) {
      this->fInTransition = 1;
      goto done;
    }
  }
  if (0 < this->fFadeDir) {
    if (this->fFadeVal < 0x80) {
      this->fInTransition = 1;
      goto done;
    }
    if ((*(u_short*)&ginfo[16]) != 0) {
      this->fInTransition = 1;
    }
  }
done:
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tUserNameMenuItem::UpdateTransition  [FEMENUOPTIONS.CPP:2032-2038] SLD-VERIFIED ---- */

void tUserNameMenuItem::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = this->_vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)((int)this + (int)(*pa_Var1)[9].delta);
  this->UpdateTransition(selected);
  return;
}



/* ---- tMemoryCardMenuItem::Draw  [FEMENUOPTIONS.CPP:2048-2085] SLD-VERIFIED ---- */

int tMemoryCardMenuItem::Draw(bool selected)

{
  tTexture_ShapeInfo *shape;
  short sVar2;
  int x;
  int y;
  int iVar4;
  int Col;
  char *sMenuText;
  short fEnableSlide;
  int iVar6;
  int ColText;
  int fEnableFade;
  int amount;
  int fWidth;
  /* SYM AUTO local optimizer-ELIMINATED (disasm: draw passes NULL, slot sp+0x20 unused) */
  tDrawShapeExtended tCol;
  
  /* MATCH: test `(fFlags & 1) != 0` -> oracle `andi;beqz` (branch-when-clear to the
     +8 arm, -8 in the fall-through), not the `== 0` -> `bnez` polarity. */
  if ((this->fFlags & 1) != 0) {
    sVar2 = this->fEnableVal + -8;
  }
  else {
    sVar2 = this->fEnableVal + 8;
  }
  this->fEnableVal = sVar2;
  /* MATCH (05E volatile-test-read): the oracle RE-READS fEnableVal from memory for
     the clamp (`lhu v1` pass-through default + `lh a0` for the compares) rather than
     store-forwarding the just-written value (which emits sll/sra sign-extend). */
  fEnableSlide = *(volatile u_short *)&this->fEnableVal;
  sVar2 = *(volatile short *)&this->fEnableVal;
  if ((sVar2 < 0x100) && (sVar2 < 1)) {
    fEnableSlide = 0;
  }
  else if (0x100 < sVar2) {
    fEnableSlide = 0x100;
  }
  this->fEnableVal = fEnableSlide;
  iVar6 = (int)fEnableSlide;
  fEnableFade = 0x80;
  if ((iVar6 < 0x80) && (fEnableFade = 0, 0 < iVar6)) {
    fEnableFade = iVar6;
  }
  iVar6 = (int)this->fFadeVal;
  if ((iVar6 != 0x80) && (iVar6 = 0, this->fEnableVal != 0)) {
    x = TextSys_WordX(this->fTextDescription);
    y = TextSys_WordY(this->fTextDescription);
    ColText = CalcTextFadeSelToHi(textType_Options,
                       this->fSelFade,
                       this->fFadeVal);
    amount = (int)this->fSelFade;
    Col = CalcFadeVal(0xc83c1e,0xbebe,amount,(int)this->fFadeVal);
    CalcFadeVal(Col,amount);
    iVar6 = CalcFadeVal(ColText,amount);
    if (iVar6 != 0) {
      sMenuText = TextSys_Word(this->fTextDescription);
      FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,iVar6,'\0',0);
    }
    shape = gHelpShapes;
    fWidth = fEnableFade * 0x96;   /* H14: was fWidth (uninitialized); oracle 0x80020A30 __MULT($s3=fEnableFade,0x96) */
    if (fWidth < 0) {
      fWidth = fWidth + 0x7f;
    }
    fWidth = (fWidth >> 7) * (0x80 - this->fFadeVal);
    if (fWidth < 0) {
      fWidth = fWidth + 0x7f;
    }
    DrawShapeExtended(0x1e,8,(x + (fWidth >> 7)) - (int)shape[0x1e].width,y + -3,0,0,(tDrawShapeExtended *)0x0);
    iVar4 = (int)shape[0x1e].width;
    iVar6 = 0;
    if (iVar4 < fWidth >> 7) {
      iVar6 = (int)shape[0x1e].height;
      PSXDrawSquare(0,x,y + -3,(fWidth >> 7) - iVar4,iVar6);
    }
  }
  return iVar6;
}



/* ---- tInsideBoxControllerLeftRightSlider::ProcessInput  [FEMENUOPTIONS.CPP:2088-2094] SLD-VERIFIED ---- */

void tInsideBoxControllerLeftRightSlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  char cVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  tInputKeyType tVar3;
  tListIterator *ptVar4;
  
  tVar3 = keyval;
  if (((tVar3 == kInput_KeyType_Left) || (tVar3 == kInput_KeyType_Right)) &&
     ((tVar3 != kInput_KeyType_Right ||
      (ptVar4 = (this->_base_tInsideBoxLeftRightSlider).fData,
      pa_Var2 = ptVar4->_vf,
      cVar1 = (*(*pa_Var2)[2].pfn)
                        ((char *)ptVar4 + (int)(*pa_Var2)[2].delta,0xffffffff),
      cVar1 != ((this->_base_tInsideBoxLeftRightSlider).fData)->fMaxValue)))) {
    screenControllerConfig[0]->fResetShakeTimeOut = 1;
  }
  ((tMenuItemLeftRightSlider *)this)->ProcessInput(fromPlayer,keyval,command)
  ;
  return;
}



/* end of femenuoptions.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
short _UNK_80010a02, _UNK_80010a06, _UNK_80010a0a;

extern "C" {
void ___25tInsideBoxLeftRightSlider(void *);
void ___35tInsideBoxControllerLeftRightSlider(void *thisp) { ___25tInsideBoxLeftRightSlider(thisp); }
}

extern "C" {
void ___23tMenuItemGoToMenuButton(void *);
void ___27tMenuItemGoToMenuButtonFade(void *thisp) { ___23tMenuItemGoToMenuButton(thisp); }
}

extern "C" {
void ___9tMenuItem(void *);
void ___17tUserNameMenuItem(void *thisp) { ___9tMenuItem(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___34tMenuItemControllerLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___29tMenuItemOnOffLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___31tMenuItemDisplayLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___20tMenuItemSlidingMenu(void *);
void ___25tMenuItemSlidingActivated(void *thisp) { ___20tMenuItemSlidingMenu(thisp); }
}

/* tMemoryCardMenuItem dtor is a delegating thunk to ___23tMenuItemGoToMenuButton
 * (oracle @0x80020BD8: jal ___23tMenuItemGoToMenuButton) -- was missing entirely
 * (gate "NOT IN OBJECT").  Same form as ___27tMenuItemGoToMenuButtonFade. */
extern "C" {
void ___23tMenuItemGoToMenuButton(void *);
void ___19tMemoryCardMenuItem(void *thisp) { ___23tMenuItemGoToMenuButton(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___22tMenuItemLeftRightFade(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

/* cont.34: tMenuItemGoToMenuNFS4Button::Draw(bool) nullsub re-attributed from front.c.
   The class declares Draw(bool) (nfs4_types.h) so the REAL method def mangles to the
   exact oracle symbol Draw__27tMenuItemGoToMenuNFS4Buttonb (0x8001BF40 = jr ra;nop).
   (extern-C free-fn form would clash with the member's mangled symbol.) */
void tMenuItemGoToMenuNFS4Button::Draw(bool /*selected*/) {}  /* @0x8001BF40 */
