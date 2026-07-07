/* frontend/common/fevideowall.cpp -- RECONSTRUCTED (video-wall helper class; C++ TU)
 *   standalone class tVideoWall ; 12 methods (no ctor/dtor/statics).
 *   Initialize rebuilt from m2c (Ghidra lost this->in_a0); Draw phantoms (DrawShapeExtended
 *   icon shape/coords, CalcFadeVal arg) resolved via m2c oracle.
 */
#include "fevideowall.h"


/* ---- tVideoWall::Initialize  [FEVIDEOWALL.CPP:59-88] ---- */
void tVideoWall::Initialize
               (tTVConfig *tvs,tTexture_ShapeInfo *shapes,short firstTV,
               short numTVs,short *tvOrdering,short flip_axis)

{
  short i;

  i = 0;
  this->fTVs = tvs;
  this->fFirstTVShape = firstTV;
  this->fTVShapes = shapes;
  this->fOffsetY = 0;
  this->fOffsetX = 0;
  this->fTransitionDirection = 0;
  this->fAvailableTextID = -1;
  this->fNumTVs = numTVs;
  this->fAvailable = 1;
  this->fAvailableBright = 0;
  this->fValid = 1;
  this->fIconShapes = (tTexture_ShapeInfo *)0x0;
  this->tvOrder = tvOrdering;
  this->fTVTicks = ticks;
  this->fFlipAxis = flip_axis;
  if (0 < this->fNumTVs) {
    do {
      this->fTVs[i].state = tv_StateOff;
      i = i + 1;
    } while (i < this->fNumTVs);
  }
  this->fUpdated = 0;
  return;
}

/* ---- tVideoWall::UpdateImages  [FEVIDEOWALL.CPP:95-114] ---- */
void tVideoWall::UpdateImages()

{
  short i_2;

  i_2 = 0;
  if (0 < this->fNumTVs) {
    do {
      InitTV(this->fTVs + i_2,this->fTVShapes,(short)(this->fFirstTVShape + i_2));
      this->fTVs[i_2].x = this->fTVs[i_2].x + this->fOffsetX;
      this->fTVs[i_2].y = this->fTVs[i_2].y + this->fOffsetY;
      if (0 < this->fFlipAxis) {
        this->fTVs[i_2].flags = this->fTVs[i_2].flags | 4;
        this->fTVs[i_2].flip_axis = this->fFlipAxis;
      }
      if ((this->fValid == 0) || (this->fAvailable == 0)) {
        this->fTVs[i_2].flags = this->fTVs[i_2].flags | 0x28;
      }
      i_2 = i_2 + 1;
    } while (i_2 < this->fNumTVs);
  }
  this->fUpdated = 1;
  return;
}



/* ---- tVideoWall::SetAvailableText  [FEVIDEOWALL.CPP:121-126] ---- */
void tVideoWall::SetAvailableText(short textID,short x,short y)

{
  this->fAvailableTextID = textID;
  this->fAvailableX = x;
  this->fAvailableY = y;
  this->fAvailableBright = 0;
  this->fAvailable = 1;
  return;
}



/* ---- tVideoWall::SetAvailableIcon  [FEVIDEOWALL.CPP:134-139] ---- */
void tVideoWall::SetAvailableIcon(short icon,short numFrames,short x,short y,
               tTexture_ShapeInfo *iconImages)

{
  this->fIcon = icon;
  this->fIconFrames = numFrames;
  this->fIconX = x;
  this->fIconShapes = iconImages;
  this->fIconY = y;
  return;
}



/* ---- tVideoWall::SetOffset  [FEVIDEOWALL.CPP:146-148] ---- */
void tVideoWall::SetOffset(short x,short y)

{
  this->fOffsetX = x;
  this->fOffsetY = y;
  return;
}



/* ---- tVideoWall::SetAvailable  [FEVIDEOWALL.CPP:154-155] ---- */
void tVideoWall::SetAvailable(short avail)

{
  this->fAvailable = avail;
  return;
}



/* ---- tVideoWall::SetValid  [FEVIDEOWALL.CPP:162-163] ---- */
void tVideoWall::SetValid(short valid)

{
  this->fValid = valid;
  return;
}



/* ---- tVideoWall::UpdateTransition  [FEVIDEOWALL.CPP:170-197] ---- */
void tVideoWall::UpdateTransition()

{
  int elapsed = (ticks - this->fTVTicks) >> 3;
  short i;

  if (0 < this->fTransitionDirection) {
    if (this->fValid != 0) {
      short sVar1 = (short)elapsed;
      i = 0;
      if (0 < sVar1) {
        do {
          if ((int)this->fNumTVs <= i) {
            return;
          }
          if (((this->fTVs[this->tvOrder[i]].state == tv_StateOff) && (this->fValid != 0))
             && (this->fAvailable != 0)) {
            TurnOnTV(this->fTVs + this->tvOrder[i]);
          }
          i = i + 1;
        } while (i < sVar1);
      }
    }
    else {
      this->fTVTicks = ticks;
    }
  }
  else {
    short sVar1 = (short)elapsed;
    i = 0;
    if (0 < sVar1) {
      do {
        if ((int)this->fNumTVs <= i) break;
        if (this->fTVs[this->tvOrder[i]].state == tv_StateOn) {
          TurnOffTV(this->fTVs + this->tvOrder[i]);
        }
        i = i + 1;
      } while (i < sVar1);
    }
    if (this->fNumTVs <= sVar1) {
      this->fTransitionDirection = 0;
    }
  }
  return;
}



/* ---- tVideoWall::Draw  [FEVIDEOWALL.CPP:205-254] ---- */
void tVideoWall::Draw()

{
  int textColor;
  char *sMenuText;
  int iVar2;
  short i;
  tDrawShapeExtended drawFlags;
  
  if ((this->fAvailable != 0) || (this->fValid == 0)) {
    this->fAvailableBright = this->fAvailableBright + -4;
  }
  else {
    this->fAvailableBright = this->fAvailableBright + 4;
  }
  if (0x40 < this->fAvailableBright) {
    this->fAvailableBright = 0x40;
  }
  else {
    if (this->fAvailableBright < 0) {
      this->fAvailableBright = 0;
    }
  }
  if (((this->fValid == 0) || (this->fAvailable == 0)) || (this->fAvailableBright != 0)) {
    i = 0;
    if (0 < this->fNumTVs) {
      do {
        DrawTVLines(this->fTVs + i);
        i = i + 1;
      } while (i < this->fNumTVs);
    }
    if (0 < this->fAvailableBright) {
      textColor = CalcFadeVal(0xbebe,0x80 - this->fAvailableBright);
      if ((this->fIconShapes != (tTexture_ShapeInfo *)0x0) && (0 < this->fIconFrames)) {
        drawFlags.tint[0] = 0xbebe;
        drawFlags.custom_shapes = this->fIconShapes;
        iVar2 = (int)this->fIconFrames;
        DrawShapeExtended(this->fIcon + (ticks >> 4) % iVar2,0x611,this->fIconX,this->fIconY,
                   0x80 - this->fAvailableBright,1,&drawFlags);
      }
      if (-1 < this->fAvailableTextID) {
        FETextRender_SetABR(1,true);
        sMenuText = TextSys_Word((int)this->fAvailableTextID);
        FETextRender_FullTextRGB(sMenuText,this->fAvailableX,this->fAvailableY,textColor,'\x03',2);
        FETextRender_SetABR(0,false);
      }
    }
  }
  if ((((this->fUpdated != 0) || (this->fValid == 0)) || (this->fAvailable == 0)) &&
     (0 < this->fNumTVs)) {
    i = 0;
    do {
      DrawTV(this->fTVs + i);
      i = i + 1;
    } while (i < this->fNumTVs);
  }
  return;
}



/* ---- tVideoWall::TurnOff  [FEVIDEOWALL.CPP:261-265] ---- */
void tVideoWall::TurnOff()

{
  if (this->fTransitionDirection != -1) {
    this->fTransitionDirection = -1;
    this->fTVTicks = ticks;
  }
  return;
}



/* ---- tVideoWall::TurnOffInstant  [FEVIDEOWALL.CPP:273-280] ---- */
void tVideoWall::TurnOffInstant()

{
  short i;

  this->TurnOff();
  if (0 < this->fNumTVs) {
    i = 0;
    do {
      TurnOffTV(this->fTVs + i);
      i = i + 1;
    } while (i < this->fNumTVs);
  }
  return;
}



/* ---- tVideoWall::TurnOn  [FEVIDEOWALL.CPP:286] ---- */
void tVideoWall::TurnOn()

{
  if (this->fTransitionDirection != 1) {
    this->fTransitionDirection = 1;
    this->fTVTicks = ticks;
  }
  return;
}



/* end of fevideowall.cpp */
