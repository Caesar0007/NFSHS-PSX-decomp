#include "screenmemcard.h"

extern tFEApplication *A_FEApp[] __asm__("FEApp");
#define FEApp A_FEApp[0]

extern int A_GRIDMEMCARD_STARTX[] __asm__("GRIDMEMCARD_STARTX");
extern int A_GRIDMEMCARD_STARTY[] __asm__("GRIDMEMCARD_STARTY");
extern int A_MEMCARD_DELTAX[] __asm__("MEMCARD_DELTAX");
extern int A_MEMCARD_DELTAY[] __asm__("MEMCARD_DELTAY");
extern int A_EXTRAYATTOP[] __asm__("EXTRAYATTOP");
extern int A_GRIDMEMCARDGOURAUDBIT_X[] __asm__("GRIDMEMCARDGOURAUDBIT_X");
extern int A_GRIDMEMCARDGOURAUDBIT_Y[] __asm__("GRIDMEMCARDGOURAUDBIT_Y");
extern int A_GRIDMEMCARD_WIDTH[] __asm__("GRIDMEMCARD_WIDTH");
extern int A_GRIDMEMCARD_HEIGHT[] __asm__("GRIDMEMCARD_HEIGHT");
extern int A_MEMCARDICONOFFX[] __asm__("MEMCARDICONOFFX");
extern int A_MEMCARDICONOFFY[] __asm__("MEMCARDICONOFFY");
extern int A_kMemCardMessageX[] __asm__("kMemCardMessageX");
extern int A_kMemCardMessageY[] __asm__("kMemCardMessageY");
extern int A_kMemCardMessage1X[] __asm__("kMemCardMessage1X");
extern int A_kMemCardMessage1Y[] __asm__("kMemCardMessage1Y");
extern int A_kMemCardMessageH[] __asm__("kMemCardMessageH");
extern int A_kMemCardMessageH1[] __asm__("kMemCardMessageH1");

#define GRIDMEMCARD_STARTX A_GRIDMEMCARD_STARTX[0]
#define GRIDMEMCARD_STARTY A_GRIDMEMCARD_STARTY[0]
#define MEMCARD_DELTAX A_MEMCARD_DELTAX[0]
#define MEMCARD_DELTAY A_MEMCARD_DELTAY[0]
#define EXTRAYATTOP A_EXTRAYATTOP[0]
#define GRIDMEMCARDGOURAUDBIT_X A_GRIDMEMCARDGOURAUDBIT_X[0]
#define GRIDMEMCARDGOURAUDBIT_Y A_GRIDMEMCARDGOURAUDBIT_Y[0]
#define GRIDMEMCARD_WIDTH A_GRIDMEMCARD_WIDTH[0]
#define GRIDMEMCARD_HEIGHT A_GRIDMEMCARD_HEIGHT[0]
#define MEMCARDICONOFFX A_MEMCARDICONOFFX[0]
#define MEMCARDICONOFFY A_MEMCARDICONOFFY[0]
#define kMemCardMessageX A_kMemCardMessageX[0]
#define kMemCardMessageY A_kMemCardMessageY[0]
#define kMemCardMessage1X A_kMemCardMessage1X[0]
#define kMemCardMessage1Y A_kMemCardMessage1Y[0]
#define kMemCardMessageH A_kMemCardMessageH[0]
#define kMemCardMessageH1 A_kMemCardMessageH1[0]

void tScreenMemcard::Initialize()
{
  tFEApplication *feApp;
  uint msgId;

  GRIDMEMCARD_STARTX = 0xee;
  GRIDMEMCARD_STARTY = 0x32;
  MEMCARD_DELTAX = 0x40;
  MEMCARD_DELTAY = 0x1b;
  kMemCardMessageH1 = 0;
  kMemCardMessageH = 0x14;
  EXTRAYATTOP = 0;
  GRIDMEMCARD_WIDTH = 0xc0;
  GRIDMEMCARD_HEIGHT = 0x9b;
  GRIDMEMCARDGOURAUDBIT_X = 4;
  GRIDMEMCARDGOURAUDBIT_Y = 4;
  MEMCARDICONOFFX = 0x12;
  MEMCARDICONOFFY = 6;
  kMemCardMessage1Y = 0x18;
  kMemCardMessageX = 0x150;
  kMemCardMessage1X = 0x150;
  this->fScreenFadeReadyTick = 0;
  kMemCardMessageY = 0xbc;
  fMemIcon = (char (*)[15][3][192])reservememadr("records",0x21c0,0);
  feApp = FEApp;
  this->checkingstart = 0;
  this->memcardanimframe = 0;
  this->count = 0;
  msgId = 0x288;
  this->player = feApp->fInputPlayer;
  this->card = this->player * 4 + 1;
  if (this->player != 0) {
    msgId = 0x28a;
  }
  {
    int i = 0;
    tGlobalMenuDefs *menus = menuDefs[0];
    (menus->itemLoadGame).fTextDescription = msgId;
    (menus->itemSaveGame).fFlags |= 1;
    (menus->itemLoadGame).fFlags |= 1;
    do {
      this->goticon[i] = '\0';
      this->numicon[i] = '\0';
      this->numblock[i] = '\0';
      this->fFadeIcon[i] = 0x80;
      this->fMemIconClutId[i] = 0;
      i = i + 1;
    } while (i < 0xf);
  }
  this->fInitedMemCard = 0;
  this->fGetNewIcons = 0;
  this->fReadyToGetNewIcons = 0;
  this->theNFS4icon = -1;
  this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
  this->tScreen::Initialize();
}
