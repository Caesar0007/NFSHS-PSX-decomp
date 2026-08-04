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
  /* SYM: locals = short i (REG $4), tCarInfo *carInfo (REG $6) */
  tCarInfo *carInfo;
  short i;

  carInfo = carManager.GetCarFromID(carModel);

  for (i = 0; i < 32; i++) {
    /* MATCH: char is UNSIGNED on this build -> (signed char) restores the
       oracle's lb/bgez (a plain `< 0` folds to false and gcc DELETES the body) */
    if ((signed char)this->fCarGarage[playerNum][i].fCarID < 0) {
      this->fCarGarage[playerNum][i].fCarID = (char)carModel;
      this->fCarGarage[playerNum][i].fCarColor = (u_char)color;
      this->fCarGarage[playerNum][i].fUpgrades = 0;
      frontEnd.garageCar[playerNum] = i + this->fNumCars;
      return carInfo->fPrices[0];
    }
  }
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
    mask = 1 << (iVar3 >> 0x10);
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
  /* SYM: sole local = short i (REG $8); leaf fn (fsize 0, mask 0) */
  short i;

  for (i = 0; i < 32; i++) {
    /* MATCH: (signed char) — plain `char < 0` folds false (unsigned char ABI) */
    if ((signed char)this->fPinkSlipsCars[playerNum][i].fCarID < 0) {
      this->fPinkSlipsCars[playerNum][i].fCarID = (char)carModel;
      this->fPinkSlipsCars[playerNum][i].fCarColor = (u_char)color;
      this->fPinkSlipsCars[playerNum][i].fUpgrades = 0;
      frontEnd.pinkSlipsCar[playerNum] = i + this->fNumCars;
      return;
    }
  }
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
    mask = 1 << (i);
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
  u_int i;
  
  blockmove(&load,this->fPinkSlipsCars[playerNum],0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      this->fPinkSlipsAvailableCars[playerNum][i] = load.fSaveAvailable[i];
      this->fPinkSlipsViewableCars[playerNum][i] = load.fSaveViewable[i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  return;
}



/* ---- tCarManager::SavePinkSlipsCars  [FECARS.CPP:483-507] SLD-VERIFIED ---- */

void tCarManager::SavePinkSlipsCars(tSaveCarInfo &save,short playerNum,short withoutCarInGarageNumber)

{
  u_int i;
  tCarInfo carInfo;
  
  if (withoutCarInGarageNumber != -1) {
    this->GetPinkSlipsCar(withoutCarInGarageNumber,carInfo,playerNum);
    this->RemoveFromPinkSlipsList(withoutCarInGarageNumber,playerNum);
  }
  blockmove(this->fPinkSlipsCars[playerNum],&save,0x80);
  i = 0;
  if (this->fNumCars != 0) {
    do {
      save.fSaveAvailable[i] = this->fPinkSlipsAvailableCars[playerNum][i];
      save.fSaveViewable[i] = this->fPinkSlipsViewableCars[playerNum][i];
      i = i + 1;
    } while (i < this->fNumCars);
  }
  if (withoutCarInGarageNumber != -1) {
    carManager.AddToPinkSlipsList((short)(signed char)carInfo.fCarID,(u_short)carInfo.fColor,playerNum);
    carManager.AddUpgradesToPinkSlipsList((u_short)(u_char)frontEnd.pinkSlipsCar[playerNum],(u_short)carInfo.fUpgrades,
               playerNum);
  }
  return;
}



/* ---- tCarManager::SetClassAvailable  [FECARS.CPP:514-528] SLD-VERIFIED ---- */

void tCarManager::SetClassAvailable(tCarClassType carClass,bool avail)

{
  u_int i;

  i = 0;
  if (this->fNumCars != 0) {
    do {
      if (((signed char)this->fCars[i].fCarID >= 0) &&
          ((u_char)this->fCars[i].fCarClass == carClass)) {
        this->fAvailableCars[(signed char)this->fCars[i].fCarID] = avail;
        if (avail != 0) {
          this->fViewableCars[(signed char)this->fCars[i].fCarID] = '\x01';
        }
      }
      i = i + 1;
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

  for (i = 0; i < this->fNumCars; i = i + 1) {
    if ((signed char)this->fCars[i].fCarID >= 0) {
      if ((u_char)this->fCars[i].fCarClass == carClass) {
        this->fViewableCars[(signed char)this->fCars[i].fCarID] = view;
      }
    }
    else {
      this->fViewableCars[(signed char)this->fCars[i].fCarID] = '\0';
    }
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
  }
  else {
    blockmove(this->fCars + carNumber,&carInfo,0xcc);
    carInfo.fAvailable = this->fAvailableCars[(signed char)carInfo.fCarID];
    uVar1 = this->fViewableCars[(signed char)carInfo.fCarID];
    carInfo.fUpgrades = '\0';
    carInfo.fCountry = '\0';
    carInfo.fViewable = uVar1;
  }
  carInfo.fCarIndex = (uchar)carNumber;
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
  int base;

  num = 0;
  i = 0;
  base = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    iVar2 = base + i * 4;
    if (-1 < *(signed char *)((char *)this + iVar2 + 8)) {
      num = num + 1;
    }
    i = i + 1;
  } while (i < 0x20);
  return num;
}



/* ---- tCarManager::GetNumTourneyCars  [FECARS.CPP:741-761] SLD-VERIFIED ---- */

short tCarManager::GetNumTourneyCars(short playerNum)

{
  /* MATCH: the retail loop uses lb/bltz for the slot ID, then reloads it with
     lbu only after the empty-slot guard.  Keep the signed test carrier. */
  signed char cVar1;
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
    if (-1 < cVar1) {
      carInfo.fCarID = *(u_char *)((char *)this + iVar4 + 8);
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
  int base;

  num = 0;
  i = 0;
  base = (int)((u_int)(u_short)playerNum << 0x10) >> 9;
  do {
    iVar2 = base + i * 4;
    if (-1 < *(signed char *)((char *)this + iVar2 + 0x108)) {
      num = num + 1;
    }
    i = i + 1;
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
  short carColor;

  ptVar1 = this->GetCarFromID((short)model);
  carColor = (short)(signed char)ptVar1->fColorOrder[(u_char)color];
  gCarSelected[carColor / 8][model] |= (u_char)(1 << (carColor & 7));
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
  /* SYM 8c: locals are exactly `short nameBase[3]` (AUTO -8) and `short i`
     (REG $v1).  nameBase is an AGGREGATE INITIALIZER (bytes @D_80010180) =
     gcc's own 6-byte rodata->stack copy (lwl/lwr + lh / swl/swr + sh). */
  short nameBase [3] = { 0x121, 0x153, 0x185 };   /* @0x80010180 */
  short i;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = atIndex;
  }
  if (this->fCarManager->fNumCars <= (u_int)(u_char)this->fValue[i]) {
    if ((this->fCarListFilter & 0x20) != 0) {
      return nameBase[this->fNameLength] +
             (signed char)this->fCarManager->fPinkSlipsCars[i]
               [(u_int)(u_char)this->fValue[i] - this->fCarManager->fNumCars].fCarID;
    }
    return nameBase[this->fNameLength] +
           (signed char)this->fCarManager->fCarGarage[i]
             [(u_int)(u_char)this->fValue[i] - this->fCarManager->fNumCars].fCarID;
  }
  return nameBase[this->fNameLength] +
         (signed char)this->fCarManager->fCars[(u_int)(u_char)this->fValue[i]].fCarID;
}


/* ---- tListIteratorCar::AdjustPosition  [FECARS.CPP:925-1059] SLD-VERIFIED ---- */

void tListIteratorCar::AdjustPosition(tPlayer atIndex,short direction)

{
  short i;
  char oldValue;
  char oldCountry;
  tCarInfo *carInfo;
  int firstCar;
  int lastCar;
  tOwnedCarInfo *ownedCars;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = (short)atIndex;
  }
  carInfo = (tCarInfo *)0x0;
  oldValue = this->fValue[i];
  if ((u_char)oldValue < this->fCarManager->fNumCars) {
    carInfo = this->fCarManager->fCars + (u_char)oldValue;
    oldCountry = frontEnd.carCountry[i][(signed char)carInfo->fCarID];
  }
  else {
    oldCountry = 0;
  }
  firstCar = 0;
  if ((this->fCarListFilter & 0x89U) != 0) {
    lastCar = this->fCarManager->fNumCars;
  }
  else if ((this->fCarListFilter & 0x42U) != 0) {
    ownedCars = this->fCarManager->fCarGarage[i];
    firstCar = this->fCarManager->fNumCars;
    if ((i == 1) && (this->fCarManager->GetNumOwnedCars(1) <= 0)) {
      ownedCars = this->fCarManager->fCarGarage[0];
    }
    lastCar = 0;
    while ((signed char)ownedCars[lastCar].fCarID >= 0) {
      lastCar++;
    }
    lastCar += firstCar;
  }
  else {
    ownedCars = this->fCarManager->fPinkSlipsCars[i];
    firstCar = this->fCarManager->fNumCars;
    lastCar = 0;
    while ((signed char)ownedCars[lastCar].fCarID >= 0) {
      lastCar++;
    }
    lastCar += firstCar;
  }
  if ((u_char)this->fValue[i] >= lastCar) {
    this->fValue[i] = lastCar - 1;
  }
  if ((u_char)this->fValue[i] < firstCar) {
    this->fValue[i] = firstCar;
  }
  if (firstCar < lastCar) {
    do {
      if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
        carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
        if (carInfo->fCarClass == 7) {
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] += direction;
          if ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] >= 5) {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
            this->fValue[i]++;
            if ((u_char)this->fValue[i] < lastCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
            }
          }
          else if ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] < 0) {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            this->fValue[i]--;
            if ((u_char)this->fValue[i] >= firstCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            }
          }
        }
        else {
          if ((direction << 16) > 0) {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
          }
          else {
            frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
          }
          this->fValue[i] += direction;
          if ((direction << 16) > 0) {
            if ((signed char)this->fValue[i] < lastCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
            }
          }
          else if ((direction << 16) < 0) {
            if ((signed char)this->fValue[i] >= firstCar) {
              carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
              frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
            }
          }
        }
      }
      else {
        this->fValue[i] += direction;
      }
      if ((signed char)this->fValue[i] >= lastCar) {
        this->fValue[i] = firstCar;
        if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 0;
        }
      }
      if ((signed char)this->fValue[i] < firstCar) {
        this->fValue[i] = lastCar - 1;
        if ((u_char)this->fValue[i] < this->fCarManager->fNumCars) {
          carInfo = this->fCarManager->fCars + (u_char)this->fValue[i];
          frontEnd.carCountry[i][(signed char)carInfo->fCarID] = 4;
        }
      }
      if ((oldValue != this->fValue[i]) ||
          (((signed char)this->fValue[i] < (int)this->fCarManager->fNumCars) &&
           ((signed char)frontEnd.carCountry[i][(signed char)carInfo->fCarID] != oldCountry))) {
        if ((((int)this->ValidCar(atIndex,this->fValue[i])) ^ 1) != 0) {
          continue;
        }
      }
      break;
    } while (true);
  }
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
  u_int uVar10;
  tPlayer k;
  tCarInfo garageCar;
  tTrackInformation trackInfo;

  i = 0;
  if (atIndex != kPlayerBoth) {
    i = (short)atIndex;
  }
  result = (void *)0x0;
  k = (tPlayer)i;
  if ((i == 1) &&
     (uVar4 = this->fCarManager->GetNumOwnedCars(1), (int)((u_int)uVar4 << 0x10) < 1)
     ) {
    k = kPlayerOne;
  }
  this_00 = this->fCarManager;
  if (this_00->fNumCars <= (u_int)(u_char)carNumber) {
    uVar10 = (u_int)(u_char)carNumber - (u_int)(u_char)this_00->fNumCars;
    if ((this->fCarListFilter & 0x20U) != 0) {
      if ((&this_00->fPinkSlipsCars[0][uVar10 & 0xff].fCarID)[((int)i << 0x10) >> 9] < '\0') {
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
  carID = (short)(signed char)cVar1;
  if (carID < 0) {
    return (void *)0x0;
  }
  if (this_00->fViewableCars[carID] == '\0') {
    return (void *)0x0;
  }
  if ((frontEnd.raceType == '\x01') && (this_00->fCars[(u_char)carNumber].fPursuitAvailable == '\0'))
  {
    return (void *)0x0;
  }
  ptVar5 = this->fCarManager->fCars;
  bVar2 = ptVar5[(u_char)carNumber].fCarClass;
  if (bVar2 == 7) {
    if ((this->fCarListFilter & 0xcU) != 0) {
      if (((int)(u_int)ptVar5[(u_char)carNumber].fCountries >>
           (signed char)frontEnd.carCountry[i][carID] & 1U) != 0) {
        trackManager.GetTrack((u_short)(u_char)frontEnd.track[0],trackInfo);
        pvVar6 = FECheat_IsCheatEnabled(cheat_AllCops);
        if (pvVar6 != (void *)0x0) goto ValidCar_filter10Path;
        if ((u_int)(u_char)trackInfo.fCountry == (int)(signed char)frontEnd.carCountry[i][carID]) {
          result = (void *)0x1;
        }
      }
    }
  }
  else if ((signed char)bVar2 < 8) {
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



/* ---- tListIteratorCarColor::Increment  [FECARS.CPP:1205-1214] SLD-VERIFIED ----  NATURAL-SOURCE REWRITE (2026-08-04, edgbla-style after the Decrement land): 42 -> 4 diffs,
   count-exact 38/38.  ORACLE FACTS driving the shape: the index expression is evaluated
   TWICE (the u_char store aliases fCarID/*fPlayer, blocking cse of the loads) but the
   *fPlayer * fIndexSize PRODUCT is reused from mflo => the product is a NAMED local computed
   once, with fCarID added INLINE in each expression; fCarID is read with lb = (signed char);
   the compare is SIGNED slt (no u_int casts -- default-unsigned chars promote to int); the
   named fNumColors value-load gives the slt its retail operand.  FALSIFIED: full re-eval
   forms 43-48 (mult redone -- the product must be named), 1/0-early-returns 5@39 (retail
   returns the slt result itself, no li 1/addu 0), V7-inline-value 14, dark+light sum swap 12,
   embedded-assignment 4 (no change), early-return-var polarity 15@39.  RESIDUAL 4 = TWO
   coalescing copies around the bnez: notWrapped's pseudo spans the if => GLOBAL allocno =>
   combine_regs refuses the tie (w47-a2's delete_noop_moves law, seen from the KEEP side --
   retail's slt dest and return pseudo are ONE).  ANGLE: instrumented-cc1 trace on this fn
   (C++ lane; check Mode-A identity first) for the tie refusal; or a shape where the branch
   provably tests the VARIABLE, not the slt temp.
 */

int tListIteratorCarColor::Increment(tPlayer arg1)

{
  tCarInfo *carInfo;
  u_int fNumColors_offset;
  int notWrapped;
  int fNumColors;

  fNumColors_offset = *fPlayer * fIndexSize;
  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  fValue[fNumColors_offset + (signed char)carInfo->fCarID]++;
  fNumColors = fValue[fNumColors_offset + (signed char)carInfo->fCarID];
  notWrapped = fNumColors < carInfo->fNumLightColors + carInfo->fNumDarkColors;
  if (notWrapped == 0) {
    fValue[fNumColors_offset + (signed char)carInfo->fCarID] = 0;
  }
  return notWrapped;
}

/* ---- tListIteratorCarColor::Decrement  [FECARS.CPP:1218-1228] SLD-VERIFIED ---- */

void tListIteratorCarColor::Decrement(tPlayer arg1)

{
  tCarInfo *carInfo;
  u_int fNumColors_offset;
  u_int fNumColors;

  carInfo = &fCarManager->fCars[fPlayerCar[*fPlayer]];
  fNumColors_offset = *fPlayer * fIndexSize + (signed char)carInfo->fCarID;
  fNumColors = fValue[fNumColors_offset];
  fValue[fNumColors_offset] = fNumColors == 0 ? carInfo->fNumLightColors + carInfo->fNumDarkColors - 1 : fNumColors - 1;
}



/* end of fecars.cpp */
