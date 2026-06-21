/* frontend/common/fescreen.cpp -- RECONSTRUCTED (tScreen BASE class; C++ TU)
 *   27 methods of tScreen (the FE screen base): ctor/dtor, async shape (perm+swap) load/upload/
 *   free pipeline, screen-fade transitions, loading-text, and the virtual-dispatch entrypoints
 *   (Draw->DrawBackground/DrawForeground, Initialize/PreLoad->GetShapeInfo) via the manual _vf
 *   vtable. tShapeInformation& ref params per mangled names. Phantoms (lost DrawShapeExtended
 *   coords, void DisplayLoadingText, PreLoad numSwapShapes/swapFileName coalescing) m2c-resolved.
 */
#include "fescreen.h"

/* ---- FEScreen.obj globals -- gCurrentShapes is DEFINED in front_data.data.s (.data @0x800517cc,
 *      absolute-addressed by the oracle, NOT small-data/gp-rel); declared extern via the header so
 *      this TU emits the oracle's absolute lui/%lo store, not a -G4 small-common gp-rel store. ---- */


/* ---- tScreen::DisplayLoadingText  [FESCREEN.CPP:36-67] SLD-VERIFIED ---- */

void tScreen::DisplayLoadingText()

{
  u_char oldIsBg;
  char *string;
  int iVar2;
  int i;
  
  iVar2 = Draw_gPlayer1View;
  if (_7tScreen_fSuppressLoadingText == 0) {
    i = 0;
    oldIsBg = Draw_gView[Draw_gPlayer1View].drawenv[0].isbg;
    Draw_gView[Draw_gPlayer1View].drawenv[1].isbg = '\0';
    Draw_gView[iVar2].drawenv[0].isbg = '\0';
    do {
      Draw_StartFrameRender();
      Draw_StartRenderingView(Draw_gPlayer1View);
      FETextRender_MenuTextPositionedJustify(0x27d,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo);
      string = TextSys_Word(0x27d);
      iVar2 = textpixels(string);
      PSXDrawSquare(0,0x1e0,0xdc,-5 - iVar2,7);
      Draw_StopRenderingView(Draw_gPlayer1View);
      Draw_StopFrameRender();
      iVar2 = Draw_gPlayer1View;
      i = i + 1;
    } while (i * 0x10000 >> 0x10 < 2);
    Draw_gView[Draw_gPlayer1View].drawenv[1].isbg = oldIsBg;
    Draw_gView[iVar2].drawenv[0].isbg = oldIsBg;
  }
  else {
    _7tScreen_fSuppressLoadingText = 0;
  }
  return;
}



/* ---- tScreen::GoNonInterlaced  [FESCREEN.CPP:144-173] SLD-VERIFIED ---- */

void tScreen::GoNonInterlaced()

{
  int iVar1;
  int iVar2;
  short sVar3;
  
  iVar1 = Draw_gPlayer1View;
  screenheight = 0xf0;
  gEnviro[0].disp.isinter = '\0';
  gEnviro[1].disp.isinter = '\0';
  gEnviro[0].disp.disp.y = 0x100;
  gEnviro[1].disp.disp.y = 0;
  gEnviro[0].disp.disp.h = 0xf0;
  gEnviro[0].disp.screen.h = 0xf0;
  gEnviro[1].disp.screen.h = 0xf0;
  Draw_gView[Draw_gPlayer1View].drawenv[0].dfe = '\0';
  iVar2 = Draw_gPlayer1View;
  Draw_gView[iVar1].drawenv[0].clip.y = 0;
  Draw_gView[iVar1].drawenv[0].clip.h = 0xf0;
  Draw_gView[iVar1].drawenv[0].ofs[0] = 0;
  Draw_gView[iVar1].drawenv[0].ofs[1] = 0;
  sVar3 = (short)screenheight;
  Draw_gView[iVar2].drawenv[1].clip.y = 0x100;
  Draw_gView[iVar2].drawenv[1].ofs[0] = 0;
  Draw_gView[iVar2].drawenv[1].ofs[1] = 0x100;
  Draw_gView[iVar2].drawenv[1].dfe = '\0';
  Draw_gView[iVar2].drawenv[1].clip.h = sVar3;
  DrawSync(0);
  VSync(0);
  return;
}



/* ---- tScreen::DrawBackgroundImage  [FESCREEN.CPP:185-197] SLD-VERIFIED ---- */

void tScreen::DrawBackgroundImage(int startShape,int numShapes,tTexture_ShapeInfo *shapes,int flip_axis)

{
  int i;
  tDrawShapeExtended drawFlags;
  
  drawFlags.flip_axis = (short)flip_axis;
  if (startShape < startShape + numShapes) {
    i = startShape;
    drawFlags.custom_shapes = shapes;
    do {
      DrawShapeExtended(i,0x200,0,0,(int)this->fScreenFadeVal,0,&drawFlags);
      if (0 < flip_axis) {
        DrawShapeExtended(i,0x260,0,0,(int)this->fScreenFadeVal,0,&drawFlags);
      }
      i = i + 1;
    } while (i < startShape + numShapes);
  }
  return;
}



/* ---- tScreen::AsyncLoadPermanentShapeFile  [FESCREEN.CPP:201-202] SLD-VERIFIED ---- */

void tScreen::AsyncLoadPermanentShapeFile(char *fileName)

{
  this->AsyncLoadShapeFile(fileName,this->fPermShapes);
  return;
}



/* ---- tScreen::AsyncLoadSwapShapeFile  [FESCREEN.CPP:206-214] SLD-VERIFIED ---- */

void tScreen::AsyncLoadSwapShapeFile(char *fileName)

{
  char *name;
  char buffer [32];

  if (fileName != 0) {
    sprintf(buffer,"z%s",fileName);
    name = buffer;
    this->AsyncLoadShapeFile(name,this->fSwapShapes);
  }
  else {
    this->AsyncLoadShapeFile((char *)0x0,this->fSwapShapes);
  }
  return;
}



/* ---- tScreen::IsShapeFileLoaded  [FESCREEN.CPP:218-270] SLD-VERIFIED ---- */

void * tScreen::IsShapeFileLoaded(tShapeInformation &shapes)

{
  int iVar1;
  char *pcVar2;
  void *pvVar3;
  tShapeInformation *buf;
  
  if (shapes.async_handle == 0) {
    pvVar3 = (void *)0x1;
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
      pvVar3 = (void *)0x0;
    }
  }
  else {
    buf = &shapes;
    iVar1 = getasyncreadstatus(shapes.async_handle);
    if (iVar1 < 1) {
      if (iVar1 == -1) {
        pvVar3 = getasyncreadadr(shapes.async_handle,buf);
        if (pvVar3 != (void *)0x0) {
          purgememadr(pvVar3);
        }
        this->AsyncLoadShapeFile(shapes.fFilename,shapes);
        pvVar3 = (void *)0x0;
      }
      else {
        pvVar3 = (void *)0x0;
        if (iVar1 == -2) {
          this->AsyncLoadShapeFile(shapes.fFilename,shapes);
          pvVar3 = (void *)0x0;
        }
      }
    }
    else {
      pcVar2 = shapes.fDestFile;
      if (pcVar2 == (char *)0x0) {
        pcVar2 = getasyncreadadr(shapes.async_handle,buf);
      }
      shapes.fFile = pcVar2;
      shapes.async_handle = 0;
      pvVar3 = (void *)0x1;
      if ((shapes.fFile != (char *)0x0) && (pvVar3 = (void *)0x1, shapes.fLoadCancelled != 0)) {
        if (shapes.fDestFile == (char *)0x0) {
          purgememadr(shapes.fFile);
        }
        shapes.fFile = (char *)0x0;
        pvVar3 = (void *)0x1;
      }
    }
  }
  return pvVar3;
}



/* ---- tScreen::UploadPermanentShapes  [FESCREEN.CPP:284-286] SLD-VERIFIED ---- */

void tScreen::UploadPermanentShapes(int numPermanentShapes)

{
  
  this->UploadShapes(this->fPermShapes,0,0,(short)numPermanentShapes,0);
  gCurrentShapes = (this->fPermShapes).fShapes;
  return;
}



/* ---- tScreen::UploadSwapShapes  [FESCREEN.CPP:290-292] SLD-VERIFIED ---- */

void tScreen::UploadSwapShapes(int numSwapShapes)

{
  this->UploadShapes(this->fSwapShapes,0,0,(short)numSwapShapes,0);
  return;
}



/* ---- tScreen::GetShapeInfo  [FESCREEN.CPP:321-326] SLD-VERIFIED ---- */

void tScreen::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  numSwapShapes = 0;
  numPermShapes = 0;
  *swapFileName = (char *)0x0;
  *permFileName = (char *)0x0;
  return;
}



/* ---- tScreen::ctor  [FESCREEN.CPP:332-337] SLD-VERIFIED ---- */

tScreen::tScreen()

{
  
  *(void **)&(this->_vf) = (void *)tScreen_vtable;
  (this->fPermShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  this->InitializeShapes(this->fPermShapes,0);
  (this->fSwapShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  this->InitializeShapes(this->fSwapShapes,0);
  this->fScreenFadeVal = 0;
  return;
}



/* ---- tScreen::dtor  [FESCREEN.CPP:341-341] SLD-VERIFIED ---- */

tScreen::~tScreen()

{
  *(void **)&(this->_vf) = (void *)tScreen_vtable;
  return;
}



/* ---- tScreen::Initialize  [FESCREEN.CPP:345-377] SLD-VERIFIED ---- */

void tScreen::Initialize()

{
  bool bVar1;
  void *pvVar2;
  short numPermShapes;
  short numSwapShapes;
  char *permFileName;
  char *swapFileName;
  
  this->DisplayLoadingText();
  (*(*this->_vf)[5].pfn)((char *)this + (*this->_vf)[5].delta);
  (*(*this->_vf)[1].pfn)
            ((char *)this + (*this->_vf)[1].delta,&numPermShapes,
             &numSwapShapes,&permFileName,&swapFileName);
  do {
    FeAudio_systemtask(0);
    pvVar2 = this->IsShapeFileLoaded(this->fPermShapes);
    if ((this->fPermShapes).fFile != (char *)0x0) {
      this->UploadPermanentShapes((int)numPermShapes);
    }
    bVar1 = false;
    if (pvVar2 != (void *)0x0) {
      pvVar2 = this->IsShapeFileLoaded(this->fSwapShapes);
      bVar1 = pvVar2 != (void *)0x0;
    }
    if ((this->fSwapShapes).fFile != (char *)0x0) {
      this->UploadSwapShapes((int)numSwapShapes);
    }
  } while (!bVar1);
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
  return;
}



/* ---- tScreen::Draw  [FESCREEN.CPP:397-401] SLD-VERIFIED ---- */

void tScreen::Draw(bool drawBackground)

{
  int delta;
  int (*pfn)(...);

  if (drawBackground != 0) {
    delta = (*this->_vf)[2].delta;
    pfn = (*this->_vf)[2].pfn;
  }
  else {
    delta = (*this->_vf)[3].delta;
    pfn = (*this->_vf)[3].pfn;
  }
  (*pfn)((char *)this + delta);
  return;
}



/* ---- tScreen::AsyncLoadShapeFile  [FESCREEN.CPP:409-451] SLD-VERIFIED ---- */

void tScreen::AsyncLoadShapeFile(char *name,tShapeInformation &data)

{
  u_int uVar1;
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
        uVar1 = asyncloadfileat(buffer,data.fDestFile);
        data.async_handle = uVar1;
      }
      else {
        uVar1 = asyncloadfile(buffer,(void *)0x10);
        data.async_handle = uVar1;
      }
    }
  }
  return;
}



/* ---- tScreen::CancelAsyncLoad  [FESCREEN.CPP:459-479] SLD-VERIFIED ---- */

void tScreen::CancelAsyncLoad(tShapeInformation &data)

{
  int iVar1;
  char *pcVar2;

  if (data.async_handle != 0) {
    iVar1 = getasyncreadstatus(data.async_handle);
    if (iVar1 == 0) {
      data.fLoadCancelled = 1;
    }
    else {
      if (data.fDestFile == (char *)0x0) {
        pcVar2 = getasyncreadadr(data.async_handle);
        data.fFile = pcVar2;
      }
      if (data.fFile != (char *)0x0) {
        if (data.fDestFile == (char *)0x0) {
          purgememadr(data.fFile);
        }
        data.fFile = (char *)0x0;
      }
      data.async_handle = 0;
    }
  }
  return;
}



/* ---- tScreen::InitializeShapes  [FESCREEN.CPP:485-509] SLD-VERIFIED ---- */

void tScreen::InitializeShapes(tShapeInformation &data,u_int numShapes)

{
  tTexture_ShapeInfo *ptVar1;
  u_int uVar2;
  u_int i;
  
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
  if (numShapes != 0) {
    ptVar1 = (tTexture_ShapeInfo *)reservememadr("Shapes",numShapes << 5,0);
    data.fShapes = ptVar1;
    i = 0;
    if (numShapes != 0) {
      uVar2 = 0;
      do {
        i = i + 1;
        data.fShapes[uVar2].clutID = 0;
        uVar2 = i & 0xffff;
      } while ((i & 0xffff) < numShapes);
    }
  }
  return;
}



/* ---- tScreen::FreeShapes  [FESCREEN.CPP:514-555] SLD-VERIFIED ---- */

void tScreen::FreeShapes(tShapeInformation &data)

{
  u_int uVar1;
  int iVar2;
  char *pcVar3;
  int iVar4;
  tShapeInformation *buf;
  
  buf = &data;
  this->CancelAsyncLoad(data);
  uVar1 = data.async_handle;
  do {
    if (uVar1 == 0) {
      if (data.fFile != (char *)0x0) {
        if (data.fDestFile == (char *)0x0) {
          purgememadr(data.fFile);
        }
        data.fFile = (char *)0x0;
      }
      if (data.fShapes != (tTexture_ShapeInfo *)0x0) {
        iVar2 = 0;
        if (data.fNumShapes != 0) {
          iVar4 = 0;
          do {
            if (*(int *)((int)&data.fShapes->clutID + (iVar4 >> 0xb)) != 0) {
              Texture_MenuReleaseClutId(*(short *)((int)&data.fShapes->clutID + (iVar4 >> 0xb)));
            }
            iVar2 = iVar2 + 1;
            iVar4 = iVar2 * 0x10000;
          } while (iVar2 * 0x10000 >> 0x10 < (int)(u_int)data.fNumShapes);
        }
        purgememadr(data.fShapes);
        data.fShapes = (tTexture_ShapeInfo *)0x0;
      }
      return;
    }
    iVar2 = getasyncreadstatus(data.async_handle);
    if ((iVar2 < 1) && (iVar2 != -1)) {
      if (iVar2 == -2) goto FreeShapes_clearHandleAndPump;
    }
    else {
      if (data.fDestFile == (char *)0x0) {
        pcVar3 = getasyncreadadr(data.async_handle,buf);
        data.fFile = pcVar3;
      }
      else {
        data.fFile = (char *)0x0;
      }
FreeShapes_clearHandleAndPump:
      data.async_handle = 0;
    }
    FeAudio_systemtask(0);
    uVar1 = data.async_handle;
  } while( true );
}



/* ---- tScreen::UploadShapes  [FESCREEN.CPP:559-597] SLD-VERIFIED ---- */

void tScreen::UploadShapes(tShapeInformation &data,short x,short y,short numShapes,short index)

{
  int iVar1;
  int iVar2;
  
  if (data.fFile != (char *)0x0) {
    if (numShapes == 0) {
      numShapes = data.fNumShapes;
    }
    iVar2 = 0;
    if (0 < numShapes) {
      iVar1 = (int)index;
      do {
        if (data.fShapes[iVar1].clutID != 0) {
          Texture_MenuReleaseClutId((short)data.fShapes[iVar1].clutID);
          data.fShapes[iVar1].clutID = 0;
        }
        iVar2 = iVar2 + 1;
        iVar1 = iVar2 + index;
      } while (iVar2 < numShapes);
    }
    data.fFlags = data.fFlags & 0xfffe;
    if (0 < numShapes) {
      iVar2 = 0;
      do {
        iVar1 = iVar2 + 1;
        FETexture_LoadPmxAtOffset(data.fFile,iVar2,data.fShapes + iVar2 + index,(int)y,(int)x);
        iVar2 = iVar1;
      } while (iVar1 < numShapes);
    }
    data.fFlags = data.fFlags | 1;
    if (data.fDestFile == (char *)0x0) {
      purgememadr(data.fFile);
    }
    data.fFile = (char *)0x0;
  }
  return;
}



/* ---- tScreen::PreLoad  [FESCREEN.CPP:600-613] SLD-VERIFIED ---- */
void tScreen::PreLoad()
{
  short numPermShapes;
  short numSwapShapes;
  char *permFileName;
  char *swapFileName;

  /* virtual GetShapeInfo (vtbl slot 1) */
  (*(*this->_vf)[1].pfn)((char *)this + (*this->_vf)[1].delta,
                         &numPermShapes,&numSwapShapes,&permFileName,&swapFileName);
  this->InitializeShapes(this->fPermShapes,(u_int)(int)numPermShapes);
  this->InitializeShapes(this->fSwapShapes,(u_int)(int)numSwapShapes);
  this->AsyncLoadPermanentShapeFile(permFileName);
  this->AsyncLoadSwapShapeFile(swapFileName);
  return;
}

/* ---- tScreen::TransitionOff  [FESCREEN.CPP:621-625] SLD-VERIFIED ---- */

int tScreen::TransitionOff(tScreen_TransitionType type,tMenu *arg2)

{
  int iVar1;
  
  iVar1 = ticks;
  this->fScreenFadeVal = 0;
  this->fInternalScreenFadeVal = 0;
  this->fTransitionOff = 1;
  this->fTransitionTicks = iVar1;
  return 1;
}



/* ---- tScreen::TransitionOn  [FESCREEN.CPP:629-633] SLD-VERIFIED ---- */

int tScreen::TransitionOn(tScreen_TransitionType type,tMenu *arg2)

{
  int iVar1;
  
  this->fScreenFadeVal = 0x80;
  iVar1 = ticks;
  this->fInternalScreenFadeVal = 0x80;
  this->fTransitionOff = 0;
  this->fTransitionTicks = iVar1;
  return 0x80;
}



/* ---- tScreen::UpdateTransition  [FESCREEN.CPP:637-646] SLD-VERIFIED ---- */

void tScreen::UpdateTransition()

{
  short sVar1;
  int iVar2;
  int iVar3;

  iVar2 = this->fInternalScreenFadeVal + 0xc;
  if (this->fTransitionOff == 0) {
    iVar2 = this->fInternalScreenFadeVal + -0xc;
  }
  this->fInternalScreenFadeVal = iVar2;
  iVar3 = iVar2;
  if (iVar2 < -0x32) {
    iVar3 = -0x32;
  }
  if (0x96 < iVar3) {
    iVar3 = 0x96;
  }
  this->fInternalScreenFadeVal = iVar3;
  sVar1 = (short)this->fInternalScreenFadeVal;
  this->fScreenFadeVal = sVar1;
  if (sVar1 < 0) {
    this->fScreenFadeVal = 0;
    return;
  }
  if (0x80 < sVar1) {
    this->fScreenFadeVal = 0x80;
  }
  return;
}



/* ---- tScreen::TransitionIsFinished  [FESCREEN.CPP:651-652] SLD-VERIFIED ---- */

int tScreen::TransitionIsFinished()

{
  return ((this->fInternalScreenFadeVal + 0x18U < 0xa7) ^ 1);
}



/* ---- tScreen::ProcessInput  [FESCREEN.CPP:663-665] SLD-VERIFIED ---- */

void tScreen::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  return;
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
