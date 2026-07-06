/* frontend/common/fecars.cpp -- RECONSTRUCTED (NFS4 car manager + list iterators; C++ TU)
 *   46 fns across 3 classes: tCarManager (32; garage/stock/pinkslip car economy + save/load),
 *   tListIteratorCar (8; :tListIterator), tListIteratorCarColor (6; :tListIterator).
 *   Member defs; base ctors via init-lists; manual _vf vtable for the iterator virtuals.
 */
#include "fecars.h"

/* ---- FECars.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) ---- */
char         cars_disableBonuses;   /* @0x80051540  (bss(zero)) */
char         gCarSelected[2][50];   /* @0x80051544  (bss(zero)) */


/* ---- tCarManager::Initialize  [FECARS.CPP:77-94] SLD-VERIFIED ---- */

void tCarManager::Initialize()

{
  int iVar1;
  short sVar2;
  int i;
  short j;
  
  j = 0;
  this->fNumCars = 0;
  this->fCars = (tCarInfo *)0x0;
  do {
    i = 0;
    do {
      iVar1 = i << 0x10;
      i = i + 1;
      iVar1 = (iVar1 >> 0xe) + ((j << 0x10) >> 9);
      (&this->fCarGarage[0][0].fCarID)[iVar1] = -1;
      (&this->fPinkSlipsCars[0][0].fCarID)[iVar1] = -1;
    } while (i * 0x10000 >> 0x10 < 0x20);
    j = j + 1;
    i = 0;
  } while (j * 0x10000 >> 0x10 < 2);
  do {
    sVar2 = (short)i;
    i = i + 1;
    this->fAvailableCars[sVar2] = '\0';
    this->fViewableCars[sVar2] = '\0';
  } while (i * 0x10000 >> 0x10 < 0x30);
  return;
}



/* ---- tCarManager::GetCarFromID  [FECARS.CPP:101-109] SLD-VERIFIED ---- */

tCarInfo * tCarManager::GetCarFromID(short carID)

{
  u_int i;
  tCarInfo *ptVar2;

  i = 0;
  if (this->fNumCars != 0) {
    ptVar2 = this->fCars;
    do {
      i = i + 1;
      if ((int)(signed char)ptVar2->fCarID == (int)carID) {
        return ptVar2;
      }
      ptVar2 = ptVar2 + 1;
    } while (i < this->fNumCars);
  }
  return (tCarInfo *)0x0;
}



/* ---- tCarManager::GetCarFromSimID  [FECARS.CPP:116-124] SLD-VERIFIED ---- */

tCarInfo * tCarManager::GetCarFromSimID(short carID)

{
  u_int i;
  tCarInfo *ptVar2;
  
  i = 0;
  if (this->fNumCars != 0) {
    ptVar2 = this->fCars;
    do {
      i = i + 1;
      if ((u_short)ptVar2->fSimNumber == carID) {
        return ptVar2;
      }
      ptVar2 = ptVar2 + 1;
    } while (i < this->fNumCars);
  }
  return (tCarInfo *)0x0;
}



/* ---- tCarManager::CheapestCarStockPrice  [FECARS.CPP:161-175] SLD-VERIFIED ---- */

long tCarManager::CheapestCarStockPrice()

{
  int carPrice;
  tCarInfo *ptVar2;
  u_int i;
  int returnprice;
  
  returnprice = 10000000;
  i = 0;
  if (this->fNumCars != 0) {
    ptVar2 = this->fCars;
    do {
      carPrice = ptVar2->fPrices[0];
      if ((0 < carPrice) && (carPrice < returnprice)) {
        returnprice = carPrice;
      }
      i = i + 1;
      ptVar2 = ptVar2 + 1;
    } while (i < this->fNumCars);
  }
  return returnprice;
}



/* ---- tCarManager::CalcUsedPrice  [FECARS.CPP:191-223] SLD-VERIFIED ---- */

long tCarManager::CalcUsedPrice(short garageNumber)

{
  char cVar1;
  u_char bVar2;
  tCarInfo *carInfo;
  long result;
  int iVar5;
  u_int uVar6;
  
  uVar6 = (u_int)garageNumber;
  result = 0;
  if (this->fNumCars <= uVar6) {
    cVar1 = *(char *)((int)this + (uVar6 - this->fNumCars) * 4 + 8);
    result = 0;
    if (cVar1 != -1) {
      carInfo = this->GetCarFromID((short)cVar1);
      result = 0;
      if (carInfo != (tCarInfo *)0x0) {
        bVar2 = *(u_char *)((int)this + (uVar6 - this->fNumCars) * 4 + 9);
        iVar5 = carInfo->fPrices[0];
        if ((bVar2 & 1) != 0) {
          iVar5 = iVar5 + carInfo->fPrices[1];
        }
        if ((bVar2 & 2) != 0) {
          iVar5 = iVar5 + carInfo->fPrices[2];
        }
        if ((bVar2 & 4) != 0) {
          iVar5 = iVar5 + carInfo->fPrices[3];
        }
        if (carInfo->fExoticCar == '\0') {
          result = iVar5 >> 1;
        }
        else {
          iVar5 = iVar5 * 3;
          result = iVar5 >> 2;
          if (iVar5 < 0) {
            result = iVar5 + 3 >> 2;
          }
        }
      }
    }
  }
  return result;
}



/* ---- tCarManager::PurchaseCar  [FECARS.CPP:230-255] SLD-VERIFIED ---- */

long tCarManager::PurchaseCar(short carModel,short color,short playerNum)

{
  tCarInfo *carInfo;
  int iVar2;
  int iVar3;
  int i;
  int iVar5;
  
  carInfo = carManager.GetCarFromID(carModel);
  iVar5 = (int)playerNum;
  iVar2 = 0;
  i = 0;
  do {
    iVar2 = iVar2 >> 0xe;
    iVar3 = i + 1;
    if ((&this->fCarGarage[iVar5 * 0x10][0].fCarID)[iVar2] < '\0') {
      (&this->fCarGarage[iVar5 * 0x10][0].fCarID)[iVar2] = (char)carModel;
      (&this->fCarGarage[iVar5 * 0x10][0].fCarColor)[iVar2] = (uchar)color;
      (&this->fCarGarage[iVar5 * 0x10][0].fUpgrades)[iVar2] = '\0';
      frontEnd.garageCar[iVar5] = (char)i + (char)this->fNumCars;
      return carInfo->fPrices[0];
    }
    iVar2 = iVar3 * 0x10000;
    i = iVar3;
  } while (iVar3 * 0x10000 >> 0x10 < 0x20);
  return 0;
}



/* ---- tCarManager::SellCar  [FECARS.CPP:262-290] SLD-VERIFIED ---- */

long tCarManager::SellCar(short garageNumber,short playerNum)

{
  u_char bVar1;
  char cVar2;
  long result;
  int iVar4;
  int iVar5;
  int iVar6;
  int i;
  
  result = this->CalcUsedPrice(garageNumber);
  iVar6 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  *(u_char *)((int)this + ((int)garageNumber - this->fNumCars) * 4 + iVar6 + 8) = 0xff;
  i = (u_int)(u_short)garageNumber - (u_int)(u_short)this->fNumCars;
  while (i = i + 1, i * 0x10000 >> 0x10 < 0x20) {
    iVar4 = (int)(short)i;
    if ((&this->fCarGarage[0][iVar4].fCarID)[iVar6] < '\0') break;
    iVar5 = iVar4 * 4 + -4 + iVar6;
    *(char *)((int)((tCarManager *)
                   (((tCarManager *)(((tCarManager *)(this->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + iVar5) =
         (&this->fCarGarage[0][iVar4].fCarID)[iVar6];
    *(uchar *)((int)((tCarManager *)
                    (((tCarManager *)(((tCarManager *)(this->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + iVar5 + 1U) =
         (&this->fCarGarage[0][iVar4].fUpgrades)[iVar6];
    *(uchar *)((int)((tCarManager *)
                    (((tCarManager *)(((tCarManager *)(this->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + -1))->fCarGarage + iVar5 + 2U) =
         (&this->fCarGarage[0][iVar4].fCarColor)[iVar6];
  }
  iVar6 = (int)playerNum;
  (&this->fCarGarage[iVar6 * 0x10 + -1][1].fCarID)[i * 0x10000 >> 0xe] = -1;
  this->fCarGarage[iVar6 * 0x10 + 0xf][1].fCarID = -1;
  bVar1 = frontEnd.garageCar[iVar6];
  if (*(char *)((int)this + ((u_int)bVar1 - this->fNumCars) * 4 + iVar6 * 0x80 + 8) < '\0') {
    cVar2 = bVar1 - 1;
    if ((u_int)bVar1 <= this->fNumCars) {
      cVar2 = '\0';
    }
    frontEnd.garageCar[iVar6] = cVar2;
  }
  return result;
}



/* ---- tCarManager::PurchaseUpgrade  [FECARS.CPP:298-327] SLD-VERIFIED ---- */

long tCarManager::PurchaseUpgrade(short garageNumber,short upgradeFlags,short playerNum)

{
  u_char bVar1;
  tCarInfo *carInfo;
  int iVar3;
  int iVar4;
  u_int mask;
  int i;
  int iVar7;
  long result;
  
  result = 0;
  iVar7 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  carInfo = this->GetCarFromID((short)*(char *)((int)this +
                                             ((int)garageNumber - this->fNumCars) * 4 + iVar7 + 8));
  i = 0;
  iVar3 = 0;
  do {
    mask = 1 << (iVar3 >> 0x10 & 0x1fU);
    if (((u_short)upgradeFlags & mask) != 0) {
      iVar4 = ((int)garageNumber - this->fNumCars) * 4 + iVar7;
      bVar1 = *(u_char *)((int)this + iVar4 + 9);
      if ((u_short)((u_short)bVar1 & (u_short)mask) == 0) {
        *(u_char *)((int)this + iVar4 + 9) = (u_char)mask | bVar1;
        result = result + carInfo->fPrices[(iVar3 >> 0x10) + 1];
      }
    }
    i = i + 1;
    iVar3 = i * 0x10000;
  } while (i * 0x10000 >> 0x10 < 3);
  return result;
}



/* ---- tCarManager::RemoveFromPinkSlipsList  [FECARS.CPP:332-357] SLD-VERIFIED ---- */

void tCarManager::RemoveFromPinkSlipsList(short garageNumber,short playerNum)

{
  char cVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int i;
  
  iVar4 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  *(u_char *)((int)((u_int *)this) + ((int)garageNumber - *((u_int *)this)) * 4 + iVar4 + 0x108) = 0xff;
  i = (u_int)(u_short)garageNumber - (u_int)(u_short)*((u_int *)this);
  while (i = i + 1, i * 0x10000 >> 0x10 < 0x20) {
    iVar2 = (short)i * 4 + iVar4;
    if (*(char *)((int)((u_int *)this) + iVar2 + 0x108) < '\0') break;
    iVar3 = ((short)i + -1) * 4 + iVar4;
    *(u_char *)((int)((u_int *)this) + iVar3 + 0x108) = *(u_char *)((int)((u_int *)this) + iVar2 + 0x108);
    *(u_char *)((int)((u_int *)this) + iVar3 + 0x109) = *(u_char *)((int)((u_int *)this) + iVar2 + 0x109);
    *(u_char *)((int)((u_int *)this) + iVar3 + 0x10a) = *(u_char *)((int)((u_int *)this) + iVar2 + 0x10a);
  }
  iVar4 = (int)playerNum;
  *(u_char *)((int)((u_int *)this) + (i * 0x10000 >> 0xe) + iVar4 * 0x80 + 0x104) = 0xff;
  *(u_char *)(((u_int *)this) + iVar4 * 0x20 + 0x61) = 0xff;
  if ((signed char)((u_int *)this)[iVar4 * 0x20 + ((u_int)(u_char)frontEnd.garageCar[iVar4] - *((u_int *)this)) + 0x42] < '\0') {
    cVar1 = frontEnd.garageCar[iVar4] - 1;
    if ((u_int)(u_char)frontEnd.pinkSlipsCar[iVar4] <= *((u_int *)this)) {
      cVar1 = '\0';
    }
    frontEnd.pinkSlipsCar[iVar4] = cVar1;
  }
  return;
}



/* ---- tCarManager::AddToPinkSlipsList  [FECARS.CPP:361-383] SLD-VERIFIED ---- */

void tCarManager::AddToPinkSlipsList(short carModel,short color,short playerNum)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int i;
  
  iVar3 = (int)playerNum;
  iVar1 = 0;
  i = 0;
  do {
    iVar1 = iVar1 >> 0xe;
    iVar2 = i + 1;
    if ((&this->fPinkSlipsCars[iVar3 * 0x10][0].fCarID)[iVar1] < '\0') {
      (&this->fPinkSlipsCars[iVar3 * 0x10][0].fCarID)[iVar1] = (char)carModel;
      (&this->fPinkSlipsCars[iVar3 * 0x10][0].fCarColor)[iVar1] = (uchar)color;
      (&this->fPinkSlipsCars[iVar3 * 0x10][0].fUpgrades)[iVar1] = '\0';
      frontEnd.pinkSlipsCar[iVar3] = (char)i + (char)this->fNumCars;
      return;
    }
    iVar1 = iVar2 * 0x10000;
    i = iVar2;
  } while (iVar2 * 0x10000 >> 0x10 < 0x20);
  return;
}



/* ---- tCarManager::AddUpgradesToPinkSlipsList  [FECARS.CPP:387-412] SLD-VERIFIED ---- */

void tCarManager::AddUpgradesToPinkSlipsList(short garageNumber,short upgradeFlags,short playerNum)

{
  u_char bVar1;
  int iVar2;
  u_int mask;
  int iVar5;
  u_int i;
  
  iVar5 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  this->GetCarFromID((short)*(char *)((int)this +
                                    ((int)garageNumber - this->fNumCars) * 4 + iVar5 + 0x108));
  i = 0;
  mask = 1;
  do {
    if (((u_short)upgradeFlags & mask) != 0) {
      iVar2 = ((int)garageNumber - this->fNumCars) * 4 + iVar5;
      bVar1 = *(u_char *)((int)this + iVar2 + 0x109);
      if ((u_short)((u_short)bVar1 & (u_short)mask) == 0) {
        *(u_char *)((int)this + iVar2 + 0x109) = (u_char)mask | bVar1;
      }
    }
    i = i + 1;
    mask = 1 << (i & 0x1f);
  } while ((int)(i * 0x10000) >> 0x10 < 3);
  return;
}



/* ---- tCarManager::LoadCars  [FECARS.CPP:420-438] SLD-VERIFIED ---- */

void tCarManager::LoadCars(tSaveCarInfo &load,short playerNum)

{
  u_int i;

  blockmove(&load,this->fCarGarage[playerNum],0x80);
  if (playerNum == 0) {
    i = 0;
    if (this->fNumCars != 0) {
      do {
        this->fAvailableCars[i] = load.fSaveAvailable[i];
        this->fViewableCars[i] = load.fSaveViewable[i];
        i = i + 1;
      } while (i < this->fNumCars);
    }
  }
  return;
}



/* ---- tCarManager::SaveCars  [FECARS.CPP:445-459] SLD-VERIFIED ---- */

void tCarManager::SaveCars(tSaveCarInfo &save)

{
  u_long i;

  blockmove(this->fCarGarage,&save,0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      save.fSaveAvailable[i] = this->fAvailableCars[i];
      save.fSaveViewable[i] = this->fViewableCars[i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::LoadPinkSlipsCars  [FECARS.CPP:466-477] SLD-VERIFIED ---- */

void tCarManager::LoadPinkSlipsCars(tSaveCarInfo &load,short playerNum)

{
  int iVar1;
  u_int i;
  int iVar3;
  
  blockmove(&load,this->fPinkSlipsCars[playerNum],0x80);
  i = 0;
  if (this->fNumCars != 0) {
    iVar3 = playerNum * 0x30;
    iVar1 = iVar3;
    do {
      this->fPinkSlipsAvailableCars[0][iVar1] = load.fSaveAvailable[i];
      this->fPinkSlipsViewableCars[0][iVar1] = load.fSaveViewable[i];
      i = i + 1;
      iVar1 = i + iVar3;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SavePinkSlipsCars  [FECARS.CPP:483-507] SLD-VERIFIED ---- */

void tCarManager::SavePinkSlipsCars(tSaveCarInfo &save,short playerNum,short withoutCarInGarageNumber)

{
  int iVar1;
  u_int i;
  int iVar3;
  tCarInfo carInfo;
  
  if (withoutCarInGarageNumber != -1) {
    this->GetPinkSlipsCar(withoutCarInGarageNumber,carInfo,playerNum);
    this->RemoveFromPinkSlipsList(withoutCarInGarageNumber,playerNum);
  }
  blockmove(this->fPinkSlipsCars[playerNum],&save,0x80);
  i = 0;
  if (this->fNumCars != 0) {
    iVar3 = playerNum * 0x30;
    iVar1 = iVar3;
    do {
      save.fSaveAvailable[i] = this->fPinkSlipsAvailableCars[0][iVar1];
      save.fSaveViewable[i] = this->fPinkSlipsViewableCars[0][iVar1];
      i = i + 1;
      iVar1 = i + iVar3;
    } while (i < this->fNumCars);
  }
  if (withoutCarInGarageNumber != -1) {
    carManager.AddToPinkSlipsList((short)carInfo.fCarID,(u_short)carInfo.fColor,playerNum);
    carManager.AddUpgradesToPinkSlipsList((u_short)(u_char)frontEnd.pinkSlipsCar[playerNum],(u_short)carInfo.fUpgrades,
               playerNum);
  }
  return;
}



/* ---- tCarManager::SetClassAvailable  [FECARS.CPP:514-528] SLD-VERIFIED ---- */

void tCarManager::SetClassAvailable(tCarClassType carClass,bool avail)

{
  u_int i;
  u_int iVar3;
  tCarInfo *carInfo;
  int iVar2;

  i = 0;
  if (this->fNumCars != 0) {
    iVar3 = 0;
    do {
      carInfo = (tCarInfo *)((char *)this->fCars + iVar3);
      iVar2 = (int)(signed char)carInfo->fCarID;
      if ((-1 < iVar2) && ((u_char)carInfo->fCarClass == carClass)) {
        this->fAvailableCars[iVar2] = avail;
        if (avail != 0) {
          this->fViewableCars[iVar2] = '\x01';
        }
      }
      i = i + 1;
      iVar3 = iVar3 + 0xcc;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SetCarAvailable  [FECARS.CPP:534-537] SLD-VERIFIED ---- */

void tCarManager::SetCarAvailable(tCarModels carModel,bool avail)

{
  
  this->fAvailableCars[carModel] = avail;
  if (avail != 0) {
    this->fViewableCars[carModel] = '\x01';
  }
  return;
}



/* ---- tCarManager::SetClassViewable  [FECARS.CPP:543-557] SLD-VERIFIED ---- */

void tCarManager::SetClassViewable(tCarClassType carClass,bool view)

{
  u_int i;
  u_int iVar4;
  tCarInfo *carInfo;
  int iVar2;

  i = 0;
  if (this->fNumCars != 0) {
    iVar4 = 0;
    do {
      carInfo = (tCarInfo *)((char *)this->fCars + iVar4);
      iVar2 = (int)(signed char)carInfo->fCarID;
      if (iVar2 >= 0) {
        if ((u_char)carInfo->fCarClass == carClass) {
          this->fViewableCars[iVar2] = view;
        }
      }
      else {
        this->fViewableCars[iVar2] = '\0';
      }
      i = i + 1;
      iVar4 = iVar4 + 0xcc;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SetCarViewable  [FECARS.CPP:563-566] SLD-VERIFIED ---- */

void tCarManager::SetCarViewable(tCarModels carModel,bool view)

{
  
  this->fViewableCars[carModel] = view;
  if (view == 0) {
    this->fAvailableCars[carModel] = '\x01';
  }
  return;
}



/* ---- tCarManager::GetStockCar  [FECARS.CPP:573-584] SLD-VERIFIED ---- */

void tCarManager::GetStockCar(short carNumber,tCarInfo &carInfo)

{
  uchar uVar1;

  if ((u_int)(int)carNumber >= this->fNumCars) {
    this->GetGarageCar(carNumber,carInfo,0);
    carInfo.fCarIndex = (uchar)carNumber;
  }
  else {
    blockmove(this->fCars + carNumber,&carInfo,0xcc);
    carInfo.fAvailable = this->fAvailableCars[(signed char)carInfo.fCarID];
    uVar1 = this->fViewableCars[(signed char)carInfo.fCarID];
    carInfo.fUpgrades = '\0';
    carInfo.fCountry = '\0';
    carInfo.fViewable = uVar1;
    carInfo.fCarIndex = (uchar)carNumber;
  }
  return;
}



/* ---- tCarManager::GetGarageCar  [FECARS.CPP:591-606] SLD-VERIFIED ---- */

void tCarManager::GetGarageCar(short garageNumber,tCarInfo &carInfo,short playerNum)

{
  uchar uVar1;
  u_short uVar2;
  tCarInfo *src;
  int iVar3;
  u_short uVar4;
  int iVar5;

  uVar4 = (u_short)playerNum;
  if ((playerNum == 1) && (uVar2 = this->GetNumOwnedCars(1), (int)((u_int)uVar2 << 0x10) < 1)) {
    uVar4 = 0;
  }
  iVar3 = (int)garageNumber;
  iVar5 = (int)(uVar4 << 0x10) >> 9;
  src = this->GetCarFromID((short)*(signed char *)((iVar3 - this->fNumCars) * 4 + iVar5 + 8 + (int)this));
  blockmove(src,&carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades = *(uchar *)((iVar3 - this->fNumCars) * 4 + iVar5 + 9 + (int)this);
  uVar1 = *(uchar *)((iVar3 - this->fNumCars) * 4 + iVar5 + 10 + (int)this);
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  carInfo.fColor = uVar1;
  return;
}



/* ---- tCarManager::GetPinkSlipsCar  [FECARS.CPP:613-622] SLD-VERIFIED ---- */

void tCarManager::GetPinkSlipsCar(short garageNumber,tCarInfo &carInfo,short playerNum)

{
  uchar uVar1;
  tCarInfo *src;
  int iVar2;
  int iVar3;
  
  iVar2 = (int)garageNumber;
  iVar3 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  src = this->GetCarFromID((short)*(signed char *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x108 + (int)this)
                    );
  blockmove(src,&carInfo,0xcc);
  carInfo.fAvailable = '\x01';
  carInfo.fViewable = '\x01';
  carInfo.fUpgrades = *(uchar *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x109 + (int)this);
  uVar1 = *(uchar *)((iVar2 - this->fNumCars) * 4 + iVar3 + 0x10a + (int)this);
  carInfo.fCountry = '\0';
  carInfo.fCarIndex = (uchar)garageNumber;
  carInfo.fColor = uVar1;
  return;
}



/* ---- tCarManager::LoadDescription  [FECARS.CPP:645-702] SLD-VERIFIED ---- */

void tCarManager::LoadDescription()

{
  u_long *input;
  tCarInfo *ptVar1;
  int iVar2;
  tCarInfo *ptVar3;
  u_long uVar4;
  char *data;
  int iVar5;
  int j;
  int i;
  char filename [80];
  
  data = filename;
  input = (u_long *)sprintf(data,(char *)(bigBuf + 0x1b4),Paths_Paths[0x25],"fecars.car"
                            );
  this->ReleaseDescription();
  loadfileadr(filename,0x10);
  uVar4 = *input;
  this->fNumCars = uVar4;
  ptVar1 = reservememadr((char *)(bigBuf + 0x1c8),uVar4 * 0xcc,0);
  this->fCars = ptVar1;
  blockmove(input + 1,ptVar1,this->fNumCars * 0xcc);
  i = 0;
  if (this->fNumCars != 0) {
    iVar2 = 0;
    do {
      iVar2 = iVar2 >> 0x10;
      j = 0;
      if (this->fCars[iVar2].fAvailable != '\0') {
        this->fAvailableCars[this->fCars[iVar2].fCarID] = '\x01';
        this->fViewableCars[this->fCars[iVar2].fCarID] = '\x01';
      }
      ptVar3 = this->fCars + iVar2;
      ptVar1 = ptVar3;
      if ((u_int)(u_char)ptVar3->fNumLightColors + (u_int)(u_char)ptVar3->fNumDarkColors != 0) {
        do {
          if ((int)ptVar3->fColorOrder[0] == (u_int)ptVar1->fDefaultColor) {
            ptVar1->fDefaultColor = (uchar)j;
            break;
          }
          ptVar1 = this->fCars + iVar2;
          iVar5 = (j + 1) * 0x10000 >> 0x10;
          ptVar3 = (tCarInfo *)(ptVar1->fShapeName + iVar5 + -8);
          j = j + 1;
        } while (iVar5 < (int)((u_int)(u_char)ptVar1->fNumLightColors +
                              (u_int)(u_char)ptVar1->fNumDarkColors));
      }
      i = i + 1;
      iVar2 = i * 0x10000;
    } while ((u_int)(i * 0x10000 >> 0x10) < this->fNumCars);
  }
  purgememadr(input);
  return;
}



/* ---- tCarManager::ReleaseDescription  [FECARS.CPP:712-717] SLD-VERIFIED ---- */

void tCarManager::ReleaseDescription()

{
  
  if (this->fCars != (tCarInfo *)0x0) {
    purgememadr(this->fCars);
  }
  this->fCars = (tCarInfo *)0x0;
  this->fNumCars = 0;
  return;
}



/* ---- tCarManager::GetNumOwnedCars  [FECARS.CPP:723-735] SLD-VERIFIED ---- */

short tCarManager::GetNumOwnedCars(short playerNum)

{
  int i;
  int iVar2;
  short num;

  num = 0;
  i = 0;
  iVar2 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    if (-1 < *(signed char *)((char *)this + iVar2 + 8)) {
      num = num + 1;
    }
    i = i + 1;
    iVar2 = iVar2 + 4;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetNumTourneyCars  [FECARS.CPP:741-761] SLD-VERIFIED ---- */

short tCarManager::GetNumTourneyCars(short playerNum)

{
  char cVar1;
  tCarInfo *ptVar2;
  void *pvVar3;
  int iVar4;
  int i;
  short result;
  tCarInfo carInfo;
  
  result = 0;
  i = 0;
  iVar4 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    cVar1 = *(signed char *)((char *)this + iVar4 + 8);
    carInfo.fCarID = *(u_char *)((char *)this + iVar4 + 8);
    if (-1 < cVar1) {
      carInfo.fUpgrades = *(u_char *)((char *)this + iVar4 + 9);
      ptVar2 = this->GetCarFromID((short)cVar1);
      carInfo.fCarClass = ptVar2->fCarClass;
      pvVar3 = tournamentManager.ValidCar(carInfo);   /* ValidCar now takes tCarInfo& */
      if (pvVar3 != (void *)0x0) {
        result = result + 1;
      }
    }
    i = i + 1;
    iVar4 = iVar4 + 4;
  } while (i < 0x20);
  return result;
}



/* ---- tCarManager::GetNumPinkSlipsCars  [FECARS.CPP:766-778] SLD-VERIFIED ---- */

short tCarManager::GetNumPinkSlipsCars(short playerNum)

{
  int i;
  int iVar2;
  short num;
  
  num = 0;
  i = 0;
  iVar2 = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    if (-1 < *(signed char *)((char *)this + iVar2 + 0x108)) {
      num = num + 1;
    }
    i = i + 1;
    iVar2 = iVar2 + 4;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetClassList  [FECARS.CPP:787-809] SLD-VERIFIED ---- */

short tCarManager::GetClassList(tCarClassType carClass,short numElements,tCarModels *models)

{
  u_int uVar1;
  int iVar2;
  u_short uVar3;
  u_int i;
  short numCars;
  
  numCars = 0;
  i = 0;
  if (this->fNumCars != 0) {
    uVar1 = 0;
    do {
      if (this->fCars[uVar1].fCarClass == carClass) {
        if ((int)numCars < (int)numElements) {
          models[numCars] = (int)this->fCars[uVar1].fCarID;
        }
        numCars = numCars + 1;
      }
      i = i + 1;
      uVar1 = i & 0xffff;
    } while ((i & 0xffff) < this->fNumCars);
  }
  if ((int)(u_int)(u_short)numCars < (int)numElements) {
    iVar2 = (int)numCars;
    uVar3 = numCars;
    do {
      i = (u_int)uVar3;
      uVar3 = uVar3 + 1;
      models[i] = models[(int)i % iVar2];
    } while ((int)(u_int)uVar3 < (int)numElements);
  }
  return numCars;
}



/* ---- tCarManager::InitializeIngameCarList  [FECARS.CPP:815-821] SLD-VERIFIED ---- */

void tCarManager::InitializeIngameCarList()

{
  short i;
  short j;

  i = 0;
  do {
    j = 0;
    do {
      gCarSelected[i][j] = '\0';
      j = j + 1;
    } while (j < 0x32);
    i = i + 1;
  } while (i < 2);
  return;
}



/* ---- tCarManager::IsCarAnAddedModel  [FECARS.CPP:827-832] SLD-VERIFIED ---- */

void * tCarManager::IsCarAnAddedModel(tCarModels &model,char &color)

{
  tCarInfo *ptVar1;
  int iVar2;
  char *base;
  u_int index;

  ptVar1 = this->GetCarFromID((short)model);
  iVar2 = (int)(signed char)ptVar1->fColorOrder[(u_char)color];
  base = &gCarSelected[0][0];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 7;
  }
  index = (u_int)model + (iVar2 >> 3) * 50;
  return (void *)(u_int)(base[index] != '\0');
}



/* ---- tCarManager::AddCarToIngameList  [FECARS.CPP:838-843] SLD-VERIFIED ---- */

void tCarManager::AddCarToIngameList(tCarModels &model,char &color)

{
  tCarInfo *ptVar1;
  u_int uVar2;
  u_int carColor;

  ptVar1 = this->GetCarFromID((short)model);
  carColor = (u_int)ptVar1->fColorOrder[(u_char)color];
  uVar2 = carColor;
  if ((int)carColor < 0) {
    uVar2 = carColor + 7;
  }
  gCarSelected[(int)uVar2 >> 3][model] =
       gCarSelected[(int)uVar2 >> 3][model] | (u_char)(1 << (carColor & 7));
  return;
}



/* ---- tCarManager::FindSimilarCar  [FECARS.CPP:851-883] SLD-VERIFIED ---- */

int tCarManager::FindSimilarCar(tCarModels &model,char &color,short arg3,tCarModels *arg4)

{
  u_char bVar1;
  tCarInfo *carInfo;
  u_int colorScheme;
  int numColors;
  int iVar5;
  u_int carColor;
  u_int uVar7;
  int iVar8;
  int j;
  int i;
  
  carInfo = this->GetCarFromID((short)model);
  colorScheme = (u_int)carInfo->fColorOrder[(u_char)color];
  if ((int)colorScheme < 0) {
    colorScheme = colorScheme + 7;
  }
  colorScheme = colorScheme >> 3;
  i = 0;
  numColors = (u_int)(u_char)carInfo->fNumLightColors + (u_int)(u_char)carInfo->fNumDarkColors;
  do {
    j = 0;
    if (numColors != 0) {
      do {
        iVar8 = numColors * 0x10000 >> 0x10;
        iVar5 = (int)(short)j + (u_int)(u_char)color;
        carColor = (u_int)((u_char)carInfo->fColorOrder[iVar5 % iVar8] >> 3);
        if (carColor == (int)(short)colorScheme) {
          bVar1 = gCarSelected[carColor][model];
          uVar7 = (u_char)carInfo->fColorOrder[iVar5 % iVar8] & 7;
          if (((int)(u_int)bVar1 >> uVar7 & 1U) == 0) {
            gCarSelected[carColor][model] = bVar1 | (u_char)(1 << uVar7);
            i = (int)(short)j + (u_int)(u_char)color;
            color = (char)(i % iVar8);
            return 1;
          }
        }
        j = j + 1;
      } while (j * 0x10000 >> 0x10 < numColors);
    }
    colorScheme = 1 - colorScheme;
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 2);
  return 1;
}



/* ---- tListIteratorCar::ctor  [FECARS.CPP:890-894] SLD-VERIFIED ---- */
tListIteratorCar::tListIteratorCar(char *valPtr,tCarManager *carManager)
  : tListIterator((short *)0x0, valPtr)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorCar_vtable;
  this->fCarManager = carManager;
  this->fCarListFilter = 1;
  this->fNameLength = cnl_Medium;
  return;
}



/* ---- tListIteratorCar::dtor  [FECARS.CPP:898-898] SLD-VERIFIED ---- */

tListIteratorCar::~tListIteratorCar()

{
  *(void **)&(this->_vf) = (void *)tListIteratorCar_vtable;
  return;
}



/* ---- tListIteratorCar::Value  [FECARS.CPP:902-905] SLD-VERIFIED ---- */

char tListIteratorCar::Value(tPlayer atIndex)

{
  tPlayer i;
  
  i = kPlayerOne;
  if (atIndex != kPlayerBoth) {
    i = atIndex;
  }
  return this->fValue[(short)i];
}



/* ---- tListIteratorCar::TextValue  [FECARS.CPP:909-921] SLD-VERIFIED ---- */

short tListIteratorCar::TextValue(tPlayer atIndex)

{
  u_int *puVar1;
  short sVar2;
  tPlayer i;
  u_int uVar4;
  u_int uVar5;
  int iVar6;
  tCarManager *ptVar7;
  short nameBase [3];
  
  uVar4 = (int)nameBase + 3U & 3;
  puVar1 = (u_int *)(((int)nameBase + 3U) - uVar4);
  *puVar1 = *puVar1 & -1 << (uVar4 + 1) * 8 | (u_int)(*(u_int*)((char*)&bigBuf + 384)) >> (3 - uVar4) * 8;
  (*(u_int*)&nameBase) = (*(u_int*)((char*)&bigBuf + 384));
  nameBase[2] = (*(u_short*)((char*)&bigBuf + 388));
  i = kPlayerOne;
  if (atIndex != kPlayerBoth) {
    i = atIndex;
  }
  iVar6 = (int)(short)i;
  ptVar7 = this->fCarManager;
  uVar4 = (u_int)(u_char)this->fValue[iVar6];
  uVar5 = ptVar7->fNumCars;
  if (uVar4 < uVar5) {
    sVar2 = nameBase[this->fNameLength] + (short)ptVar7->fCars[uVar4].fCarID;
  }
  else if ((this->fCarListFilter & 0x20U) == 0) {
    sVar2 = nameBase[this->fNameLength] +
            (short)*(char *)((int)ptVar7 + (uVar4 - uVar5) * 4 + iVar6 * 0x80 + 8);
  }
  else {
    sVar2 = nameBase[this->fNameLength] +
            (short)*(char *)((int)ptVar7 + (uVar4 - uVar5) * 4 + iVar6 * 0x80 + 0x108);
  }
  return sVar2;
}



/* ---- tListIteratorCar::AdjustPosition  [FECARS.CPP:925-1059] SLD-VERIFIED ---- */

void tListIteratorCar::AdjustPosition(tPlayer atIndex,short direction)

{
  char cVar1;
  char cVar2;
  u_char oldValue;
  u_char bVar4;
  u_short uVar5;
  void *pvVar6;
  u_char *pbVar7;
  tOwnedCarInfo *ownedCars;
  char *pcVar9;
  u_int uVar10;
  int i;
  tCarManager *ptVar12;
  u_int uVar13;
  tCarInfo *carInfo;
  u_long lastCar;
  u_long firstCar;
  u_short uStackX_4;
  char oldCountry;
  
  uVar13 = (u_int)(u_short)direction;
  uStackX_4 = 0;
  if (atIndex != kPlayerBoth) {
    uStackX_4 = (u_short)atIndex;
  }
  carInfo = (tCarInfo *)0x0;
  pbVar7 = (u_char *)(this->fValue + (short)uStackX_4);
  uVar10 = (u_int)*pbVar7;
  oldValue = *pbVar7;
  if (uVar10 < this->fCarManager->fNumCars) {
    carInfo = this->fCarManager->fCars + uVar10;
    oldCountry = frontEnd.carCountry[(short)uStackX_4 * 0x18][carInfo->fCarID];
  }
  else {
    oldCountry = '\0';
  }
  firstCar = 0;
  if ((this->fCarListFilter & 0x89U) == 0) {
    if ((this->fCarListFilter & 0x42U) == 0) {
      pcVar9 = &this->fCarManager->fPinkSlipsCars[0][0].fCarID +
               ((int)((u_int)uStackX_4 << 0x10) >> 9);
      firstCar = this->fCarManager->fNumCars;
      i = 0;
      cVar1 = *pcVar9;
      while (-1 < cVar1) {
        pcVar9 = pcVar9 + 4;
        i = i + 1;
        cVar1 = *pcVar9;
      }
    }
    else {
      i = (int)((u_int)uStackX_4 << 0x10) >> 0x10;
      ptVar12 = this->fCarManager;
      ownedCars = ptVar12->fCarGarage[i * 0x10];
      firstCar = ptVar12->fNumCars;
      if ((i == 1) &&
         (uVar5 = (ptVar12)->GetNumOwnedCars(1), (int)((u_int)uVar5 << 0x10) < 1)) {
        ownedCars = this->fCarManager->fCarGarage[0];
      }
      i = 0;
      if (-1 < ownedCars->fCarID) {
        do {
          ownedCars = ownedCars + 1;
          i = i + 1;
        } while (-1 < ownedCars->fCarID);
        lastCar = i + firstCar;
        goto AdjPos_clampBounds;
      }
    }
    lastCar = i + firstCar;
  }
  else {
    lastCar = this->fCarManager->fNumCars;
  }
AdjPos_clampBounds:
  i = (int)(short)uStackX_4;
  pbVar7 = (u_char *)(this->fValue + i);
  if ((int)lastCar <= (int)(u_int)*pbVar7) {
    *pbVar7 = (char)lastCar - 1;
  }
  pbVar7 = (u_char *)(this->fValue + i);
  if ((int)(u_int)*pbVar7 < (int)firstCar) {
    *pbVar7 = (u_char)firstCar;
  }
  if ((int)firstCar < (int)lastCar) {
    do {
      pbVar7 = (u_char *)(this->fValue + i);
      bVar4 = *pbVar7;
      cVar1 = (char)direction;
      if ((u_int)bVar4 < this->fCarManager->fNumCars) {
        carInfo = this->fCarManager->fCars + bVar4;
        if (carInfo->fCarClass == '\a') {
          frontEnd.carCountry[i * 0x18][carInfo->fCarID] =
               cVar1 + frontEnd.carCountry[i * 0x18][carInfo->fCarID];
          cVar1 = carInfo->fCarID;
          cVar2 = frontEnd.carCountry[i * 0x18][cVar1];
          if (cVar2 < '\x05') {
            if (cVar2 < '\0') {
              frontEnd.carCountry[i * 0x18][cVar1] = '\x04';
              pcVar9 = this->fValue + i;
              *pcVar9 = *pcVar9 + -1;
              uVar10 = (u_int)(u_char)this->fValue[i];
              if ((int)firstCar <= (int)uVar10) {
                ptVar12 = this->fCarManager;
                goto AdjPos_setCountryMark;
              }
            }
          }
          else {
            frontEnd.carCountry[i * 0x18][cVar1] = '\0';
            pcVar9 = this->fValue + i;
            *pcVar9 = *pcVar9 + '\x01';
            uVar10 = (u_int)(u_char)this->fValue[i];
            if ((int)uVar10 < (int)lastCar) {
              ptVar12 = this->fCarManager;
              goto AdjPos_clearCountryMark;
            }
          }
        }
        else {
          if ((int)(uVar13 << 0x10) < 1) {
            frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\x04';
          }
          else {
            frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\0';
          }
          pcVar9 = this->fValue + i;
          *pcVar9 = cVar1 + *pcVar9;
          if (((int)(uVar13 << 0x10) < 1) ||
             (pbVar7 = (u_char *)(this->fValue + i),
             (int)lastCar <= (int)(signed char)*pbVar7)) {
            if (((int)(uVar13 << 0x10) < 0) &&
               (pbVar7 = (u_char *)(this->fValue + i),
               (int)firstCar <= (int)(char)*pbVar7)) {
              uVar10 = (u_int)*pbVar7;
              ptVar12 = this->fCarManager;
AdjPos_setCountryMark:
              carInfo = ptVar12->fCars + uVar10;
              frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\x04';
            }
          }
          else {
            uVar10 = (u_int)*pbVar7;
            ptVar12 = this->fCarManager;
AdjPos_clearCountryMark:
            carInfo = ptVar12->fCars + uVar10;
            frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\0';
          }
        }
      }
      else {
        *pbVar7 = cVar1 + bVar4;
      }
      pbVar7 = (u_char *)(this->fValue + i);
      if ((int)lastCar <= (int)(char)*pbVar7) {
        *pbVar7 = (u_char)firstCar;
        uVar10 = (u_int)(u_char)this->fValue[i];
        if (uVar10 < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + uVar10;
          frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\0';
        }
      }
      pcVar9 = this->fValue + i;
      if ((int)*pcVar9 < (int)firstCar) {
        *pcVar9 = (char)lastCar + -1;
        uVar10 = (u_int)(u_char)this->fValue[i];
        if (uVar10 < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + uVar10;
          frontEnd.carCountry[i * 0x18][carInfo->fCarID] = '\x04';
        }
      }
      pbVar7 = (u_char *)(this->fValue + i);
      bVar4 = *pbVar7;
    } while (((oldValue != bVar4) ||
             (((int)(signed char)bVar4 < (int)this->fCarManager->fNumCars &&
              ((int)frontEnd.carCountry[i * 0x18][carInfo->fCarID] != (u_int)(u_char)oldCountry)))
             ) && (pvVar6 = this->ValidCar(atIndex,*pbVar7), pvVar6 != (void *)0x1));
  }
  return;
}



/* ---- tListIteratorCar::Increment  [FECARS.CPP:1062-1063] SLD-VERIFIED ---- */

void tListIteratorCar::Increment(tPlayer atIndex)

{
  this->AdjustPosition(atIndex,1);
  return;
}



/* ---- tListIteratorCar::Decrement  [FECARS.CPP:1067-1068] SLD-VERIFIED ---- */

void tListIteratorCar::Decrement(tPlayer atIndex)

{
  this->AdjustPosition(atIndex,-1);
  return;
}



/* ---- tListIteratorCar::ValidCar  [FECARS.CPP:1072-1168] SLD-VERIFIED ---- */

void * tListIteratorCar::ValidCar(tPlayer atIndex,char carNumber)

{
  char cVar1;
  u_char bVar2;
  short i;
  u_short uVar4;
  tCarInfo *ptVar5;
  void *pvVar6;
  short carID;
  tCarInfo *carInfo;
  tCarManager *this_00;
  void *result;
  tPlayer tVar9;
  u_int uVar10;
  tPlayer k;
  tCarInfo garageCar;
  tTrackInformation trackInfo;
  
  tVar9 = kPlayerOne;
  if (atIndex != kPlayerBoth) {
    tVar9 = atIndex;
  }
  result = (void *)0x0;
  i = (short)tVar9;
  k = tVar9;
  if ((i == 1) &&
     (carInfo = (tCarInfo *)this->fCarManager,
     uVar4 = ((tCarManager *)carInfo)->GetNumOwnedCars(1), (int)((u_int)uVar4 << 0x10) < 1)
     ) {
    k = kPlayerOne;
  }
  this_00 = this->fCarManager;
  if (this_00->fNumCars <= (u_int)(u_char)carNumber) {
    uVar10 = (u_int)(u_char)carNumber - (u_int)(u_char)this_00->fNumCars;
    if ((this->fCarListFilter & 0x20U) != 0) {
      if ((&this_00->fPinkSlipsCars[0][uVar10 & 0xff].fCarID)[(tVar9 << 0x10) >> 9] < '\0') {
        return (void *)0x0;
      }
      return (void *)0x1;
    }
    if ((this->fCarListFilter & 0x42U) == 0) {
      return (void *)0x0;
    }
    cVar1 = (&this_00->fCarGarage[0][uVar10 & 0xff].fCarID)[(k << 0x10) >> 9];
    result = (void *)(u_int)(-1 < cVar1);
    ptVar5 = (this_00)->GetCarFromID((short)cVar1);
    if ((frontEnd.raceType == '\x01') && (ptVar5->fPursuitAvailable == '\0')) {
      return (void *)0x0;
    }
    if (result == (void *)0x0) {
      return (void *)0x0;
    }
    if ((this->fCarListFilter & 0x40U) == 0) {
      return result;
    }
    (this->fCarManager)->GetGarageCar((short)(((uVar10 & 0xff) + (u_int)(u_short)this->fCarManager->fNumCars) * 0x10000 >>
                      0x10),garageCar,0);
    ptVar5 = &garageCar;
    goto ValidCar_tournValidate;
  }
  cVar1 = this_00->fCars[(u_char)carNumber].fCarID;
  if (cVar1 < 0) {
    return (void *)0x0;
  }
  if (this_00->fViewableCars[cVar1] == '\0') {
    return (void *)0x0;
  }
  if ((frontEnd.raceType == '\x01') && (this_00->fCars[(u_char)carNumber].fPursuitAvailable == '\0'))
  {
    return (void *)0x0;
  }
  ptVar5 = this->fCarManager->fCars;
  bVar2 = ptVar5[(u_char)carNumber].fCarClass;
  carID = (short)cVar1;
  if (bVar2 == 7) {
    if ((this->fCarListFilter & 0xcU) != 0) {
      if (((int)(u_int)ptVar5[(u_char)carNumber].fCountries >>
           ((int)frontEnd.carCountry[i * 0x18][carID] & 0x1fU) & 1U) != 0) {
        trackManager.GetTrack((u_short)(u_char)frontEnd.track[0],trackInfo);
        pvVar6 = FECheat_IsCheatEnabled(cheat_AllCops);
        if (pvVar6 != (void *)0x0) goto ValidCar_filter10Path;
        if ((u_int)(u_char)trackInfo.fCountry == (int)frontEnd.carCountry[i * 0x18][carID]) {
          result = (void *)0x1;
        }
      }
    }
  }
  else if (bVar2 < 8) {
    result = (void *)(u_int)((this->fCarListFilter & 0x81U) != 0);
    if ((carID == 0x1c) &&
       (((frontEnd.carListType == '\x01' || (frontEnd.gameMode == '\x01')) ||
        (frontEnd.raceType != '\0')))) {
      result = (void *)0x0;
    }
  }
  else if ((bVar2 == 8) && ((this->fCarListFilter & 0x10U) != 0)) {
ValidCar_filter10Path:
    result = (void *)0x1;
  }
  if (result == (void *)0x0) {
    return (void *)0x0;
  }
  if ((this->fCarListFilter & 1U) == 0) {
    return result;
  }
  if (frontEnd.raceType != '\x02') {
    return result;
  }
  ptVar5 = this->fCarManager->fCars + (u_char)carNumber;
ValidCar_tournValidate:
  result = tournamentManager.ValidCar(*ptVar5);   /* ValidCar now takes tCarInfo& */
  return result;
}



/* ---- tListIteratorCarColor::ctor  [FECARS.CPP:1176-1181] SLD-VERIFIED ---- */
tListIteratorCarColor::tListIteratorCarColor(char *value,char *player,char *playerCar,int indexSize,
          tCarManager *carManager)
  : tListIterator((short *)0x0, value)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorCarColor_vtable;
  this->fPlayer = player;
  this->fPlayerCar = playerCar;
  this->fIndexSize = indexSize;
  this->fCarManager = carManager;
  return;
}



/* ---- tListIteratorCarColor::dtor  [FECARS.CPP:1185-1185] SLD-VERIFIED ---- */

tListIteratorCarColor::~tListIteratorCarColor()

{
  *(void **)&(this->_vf) = (void *)tListIteratorCarColor_vtable;
  return;
}



/* ---- tListIteratorCarColor::Value  [FECARS.CPP:1189-1196] SLD-VERIFIED ---- */

char tListIteratorCarColor::Value(tPlayer arg1)

{
  int offset;
  tCarInfo *carInfo;

  offset = (int)this->fPlayer;
  carInfo = &this->fCarManager->fCars[(u_char)this->fPlayerCar[*(u_char *)offset]];
  return (u_int)(u_char)this->fValue
                     [(u_int)*(u_char *)offset * this->fIndexSize +
                      (int)(signed char)carInfo->fCarID]
  ;
}



/* ---- tListIteratorCarColor::TextValue  [FECARS.CPP:1200-1201] SLD-VERIFIED ---- */

int tListIteratorCarColor::TextValue(tPlayer arg1)

{
  return 0;
}



/* ---- tListIteratorCarColor::Increment  [FECARS.CPP:1205-1214] SLD-VERIFIED ---- */

int tListIteratorCarColor::Increment(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  char *pcVar3;
  u_char *pbVar4;
  tCarInfo *carInfo;
  
  iVar1 = (u_int)(u_char)*this->fPlayer * this->fIndexSize;
  carInfo = this->fCarManager->fCars + (u_char)this->fPlayerCar[(u_char)*this->fPlayer];
  pcVar3 = this->fValue + iVar1 + carInfo->fCarID;
  *pcVar3 = *pcVar3 + '\x01';
  pbVar4 = (u_char *)(this->fValue + iVar1 + carInfo->fCarID);
  uVar2 = (u_int)((u_int)*pbVar4 <
                (u_int)(u_char)carInfo->fNumLightColors + (u_int)(u_char)carInfo->fNumDarkColors);
  if (uVar2 == 0) {
    *pbVar4 = 0;
  }
  return uVar2;
}



/* ---- tListIteratorCarColor::Decrement  [FECARS.CPP:1218-1228] SLD-VERIFIED ---- */

int tListIteratorCarColor::Decrement(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  u_char *pbVar3;
  tCarInfo *carInfo;

  iVar1 = (u_int)(u_char)*this->fPlayer * this->fIndexSize;
  carInfo = this->fCarManager->fCars + (u_char)this->fPlayerCar[(u_char)*this->fPlayer];
  pbVar3 = (u_char *)(iVar1 + (int)(signed char)carInfo->fCarID + this->fValue);
  uVar2 = (u_int)*pbVar3;
  if (uVar2 == 0) {
    uVar2 = (u_int)(u_char)carInfo->fNumLightColors + (u_int)(u_char)carInfo->fNumDarkColors;
  }
  *pbVar3 = (u_char)(uVar2 - 1);
  return uVar2 - 1;
}



/* end of fecars.cpp */
