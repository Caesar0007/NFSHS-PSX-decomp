/* frontend/common/fevideowall.cpp -- RECONSTRUCTED (video-wall helper class; C++ TU)
 *   standalone class tVideoWall ; 12 methods (no ctor/dtor/statics).
 *   Initialize rebuilt from m2c (Ghidra lost this->in_a0); Draw phantoms (DrawShapeExtended
 *   icon shape/coords, CalcFadeVal arg) resolved via m2c oracle.
 */
#include "fevideowall.h"



/* ---- tVideoWall::Initialize  [FEVIDEOWALL.CPP:59-88] ---- */
#line 54 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::Initialize
               (tTVConfig *tvs,tTexture_ShapeInfo *shapes,short firstTV,
               short numTVs,short *tvOrdering,short flip_axis)


{
  short i;


  this->fTVs = tvs;
  this->fFirstTVShape = firstTV;
  this->fNumTVs = numTVs;
  this->fTVShapes = shapes;
  this->tvOrder = tvOrdering;

  this->fOffsetY = 0; this->fOffsetX = 0;

  this->fTVTicks = FE_Ticks();
  this->fTransitionDirection = 0;
  this->fFlipAxis = flip_axis;


  this->fAvailableTextID = -1;
  this->fAvailable = 1;
  this->fAvailableBright = 0;
  this->fValid = 1;


  this->fIconShapes = (tTexture_ShapeInfo *)0x0;


  i = 0; if (0 < this->fNumTVs) {
    do { this->fTVs[i].state = tv_StateOff; i = i + 1; } while (i < this->fNumTVs);
  }
  this->fUpdated = 0; return;
}

/* ---- tVideoWall::UpdateImages  [FEVIDEOWALL.CPP:95-114] ---- */
#line 92 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::UpdateImages()


{
  short i;
  i = 0;
  if (0 < this->fNumTVs) {
    do {
      InitTV(this->fTVs + i,this->fTVShapes,(short)(this->fFirstTVShape + i));
      this->fTVs[i].x = this->fTVs[i].x + this->fOffsetX;
      this->fTVs[i].y = this->fTVs[i].y + this->fOffsetY;

      if (0 < this->fFlipAxis) {

        this->fTVs[i].flags = this->fTVs[i].flags | 4;
        this->fTVs[i].flip_axis = this->fFlipAxis;
      }

      if ((this->fValid == 0) || (this->fAvailable == 0)) {
        this->fTVs[i].flags = this->fTVs[i].flags | 0x28;
      } i = i + 1; } while (i < this->fNumTVs);
  }
  this->fUpdated = 1;
}



/* ---- tVideoWall::SetAvailableText  [FEVIDEOWALL.CPP:121-126] ---- */
#line 118 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::SetAvailableText(short textID,short x,short y)


{
  this->fAvailableTextID = textID;
  this->fAvailableX = x;
  this->fAvailableY = y;
  this->fAvailableBright = 0;
  this->fAvailable = 1;
}



/* ---- tVideoWall::SetAvailableIcon  [FEVIDEOWALL.CPP:134-139] ---- */
#line 130 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::SetAvailableIcon(short icon,short numFrames,short x,short y,
               tTexture_ShapeInfo *iconImages)


{
  this->fIconShapes = iconImages;
  this->fIcon = icon;
  this->fIconFrames = numFrames;
  this->fIconX = x;
  this->fIconY = y; return;
}



/* ---- tVideoWall::SetOffset  [FEVIDEOWALL.CPP:146-148] ---- */
#line 143 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::SetOffset(short x,short y)


{
  this->fOffsetX = x;
  this->fOffsetY = y;
}



/* ---- tVideoWall::SetAvailable  [FEVIDEOWALL.CPP:154-155] ---- */
#line 151 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::SetAvailable(short avail)


{
  this->fAvailable = avail;
}



/* ---- tVideoWall::SetValid  [FEVIDEOWALL.CPP:162-163] ---- */
#line 159 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::SetValid(short valid)


{
  this->fValid = valid;
}



/* ---- tVideoWall::UpdateTransition  [FEVIDEOWALL.CPP:170-197] ---- */
  /* MATCH (W69, 67 -> PASS): SYM authenticates only two locals: elapsed
     transition step `i`=$s3 and TV index `j`=$s0, both short.  Bounded for
     loops preserve the retail dual tests without the decompiler's scoped
     count copies; spelling the final comparison i-first fixes load order. */
#line 167 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::UpdateTransition()


{
  short i;
  short j;

  i = (FE_Ticks() - this->fTVTicks) >> 3;
  if (0 < this->fTransitionDirection)
  {
    if (this->fValid != 0) {

      for (j = 0; (j < i) && (j < this->fNumTVs); j = j + 1) {
        if (((this->fTVs[this->tvOrder[j]].state == tv_StateOff) && (this->fValid != 0))
           && (this->fAvailable != 0)) {
          TurnOnTV(this->fTVs + this->tvOrder[j]);
        } }
    }

    else { this->fTVTicks = FE_Ticks();
    }
  }
  else {
    for (j = 0; (j < i) && (j < this->fNumTVs); j = j + 1) {

      if (this->fTVs[this->tvOrder[j]].state == tv_StateOn) {
        TurnOffTV(this->fTVs + this->tvOrder[j]);
      } }
    if (i >= this->fNumTVs) {

      this->fTransitionDirection = 0; } } return; }



/* ---- tVideoWall::Draw  [FEVIDEOWALL.CPP:205-254] ---- */
#line 202 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::Draw()


{
  short i;
  long textColor;
  tDrawShapeExtended drawFlags;
  

  if ((this->fAvailable != 0) || (this->fValid == 0)) {
    this->fAvailableBright = this->fAvailableBright + -4;
  } else { this->fAvailableBright = this->fAvailableBright + 4;
  } if (0x40 < this->fAvailableBright) {
    this->fAvailableBright = 0x40;
  } else { if (this->fAvailableBright < 0) {
      this->fAvailableBright = 0;
    }
  }

  if (((this->fValid == 0) || (this->fAvailable == 0)) || (this->fAvailableBright != 0))
  { i = 0;
    if (0 < this->fNumTVs) {
      do { DrawTVLines(this->fTVs + i); i = i + 1; } while (i < this->fNumTVs);
    }
    if (0 < this->fAvailableBright)
    {
      textColor = CalcFadeVal(0xbebe,0x80 - this->fAvailableBright);

      if ((this->fIconShapes != (tTexture_ShapeInfo *)0x0) && (0 < this->fIconFrames))
      {
        drawFlags.tint[0] = 0xbebe;
        drawFlags.custom_shapes = this->fIconShapes;
        DrawShapeExtended(this->fIcon + (FE_Ticks() >> 4) % (int)this->fIconFrames,
                   0x611,this->fIconX,this->fIconY,


                   0x80 - this->fAvailableBright,1,&drawFlags);
      }

      if (-1 < this->fAvailableTextID) {

        FETextRender_SetABR(1,true);
        FETextRender_FullTextRGB(TextSys_Word((int)this->fAvailableTextID), this->fAvailableX,this->fAvailableY,textColor,'\x03',2);
        FETextRender_SetABR(0,false);
      }
    }
  }

  if (((this->fUpdated != 0) || (this->fValid == 0)) || (this->fAvailable == 0)) {


    i = 0; if (0 < this->fNumTVs) {
      do { DrawTV(this->fTVs + i); i = i + 1; } while (i < this->fNumTVs); } } return; }



/* ---- tVideoWall::TurnOff  [FEVIDEOWALL.CPP:261-265] ---- */
#line 258 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::TurnOff()


{
  if (this->fTransitionDirection != -1)
  {
    this->fTransitionDirection = -1;
    this->fTVTicks = FE_Ticks(); } return; }



/* ---- tVideoWall::TurnOffInstant  [FEVIDEOWALL.CPP:273-280] ---- */
#line 270 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::TurnOffInstant()


{
  short i;

  this->TurnOff();
  if (0 < this->fNumTVs) {
    i = 0;
    do { TurnOffTV(this->fTVs + i);
      i = i + 1; } while (i < this->fNumTVs); } return; }



/* ---- tVideoWall::TurnOn  [FEVIDEOWALL.CPP:286] ---- */
#line 283 "C:/nfs4/FRONTEND/COMMON/FEVIDEOWALL.CPP"
void tVideoWall::TurnOn()


{
  if (this->fTransitionDirection != 1)
  {
    this->fTransitionDirection = 1;
    this->fTVTicks = FE_Ticks(); } return; }



/* end of fevideowall.cpp */
