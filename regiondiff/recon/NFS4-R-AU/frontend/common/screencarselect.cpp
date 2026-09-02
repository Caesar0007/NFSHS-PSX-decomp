#include "screencarselect.h"

extern "C" void func_80012F6C(DRender_tView *, int, int, int, int,
                                unsigned long, float, float);

void DrawCar(tCarInfo &carInfo,short x,short y,float camerax,float cameray,
             char brightness,bool reflection,u_long rotate,tPlayer player)
{
  int the_simcarcolor;
  u_long ticks;
  long signedTicks;
  short carX;
  short carY;

  carX = x;
  ticks = ::ticks[0];
  signedTicks = (long)ticks;
  ticks = signedTicks % 0x800;
  carY = y - 8;
  DrawC_gMenuLights = 0;
  if (ticks < 0x400) {
    DrawC_gMenuLightsDirection = 0;
  }
  else {
    DrawC_gMenuLightsDirection = 1;
  }
  if (-1 < carInfo.fCarID) {
    the_simcarcolor = carInfo.fColor;
    gCarObj[player]->carInfo->carType = (uint)carInfo.fSimNumber;
    gCarObj[player]->carInfo->Country = (uint)carInfo.fCountry;
    gMenuRotate[player] = gMenuRotate[player] + 3;
    gCarObj[player]->carInfo->EngineMods = carInfo.fUpgrades >> 2 & 1;
    gCarObj[player]->carInfo->WeightTransfer = carInfo.fUpgrades >> 1 & 1;
    gCarObj[player]->carInfo->GroundEffects = carInfo.fUpgrades & 1;
    DrawC_MenuColorData((uint)the_simcarcolor,gCarObj[player],player);
    Draw_MenuRenderingView(gCarObj[player],&gCView,(int)carX,(int)carY,player,0,
                           rotate,camerax,cameray,(uint)(byte)brightness,
                           reflection);
  }
  else {
    func_80012F6C(&gCView,(int)carX,(int)carY,player,0,rotate,camerax,cameray);
  }
}
