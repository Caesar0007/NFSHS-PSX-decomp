/* game/common/input.cpp -- RECONSTRUCTED (NFS4 PSX controller input layer; C++ TU)
 *   8 free fns: Input_StartUp/WingCommandMode/Update/Store/Fetch/Gear/Interface/MainExitKey.
 *   Full SYM-locals applied. Device fn-ptr dispatch via Device_gDeviceList[].devicefunc.
 */
#include "input_types.h"
#include "input_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055FB8): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* ---- input.obj OWNED globals (EXT; SYM names already resolved by Ghidra; Globals.jsonl) ---- */
int             Input_gHandler[184];          /* 0x8013... */
u_long          Input_gDBFlags[8];
u_long          Input_gInterfaceResults[32];
int             Input_gPressTime[2][17];
int             Input_gTime;
Input_tResults  Input_gResults[2];
Input_tResults  Input_gSim;                   /* 0x8013d22c; .flags @+3 = Ghidra bGp00000ce3 */
int             Input_gLookBehind[2];
int             Input_gMode[2];
extern Input_tResults D_8013D228[];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int * Input_StartUp(void);
int Input_WingCommandMode(int player);
void Input_Update(void);
void Input_Store(void);
void Input_Fetch(int humanIndex);
char Input_Gear(char currentGear,int numGears);
int Input_Interface(u_long key,int debounce);
int Input_MainExitKey(void);


/* ---- Input_StartUp__Fv  [INPUT.CPP:55-77] SLD-VERIFIED ---- */
#line 52 "C:/nfs4/GAME/COMMON/INPUT.CPP"
int * Input_StartUp(void)


{
  int * h;
  int i;
  Device_StartUp();


  h = Input_gHandler;
  i = 0xb7;
  do { *h = 0; i = i + -1; h = h + 1; } while (-1 < i);

  for (i = 0; i < 2; i = i + 1) {

    Input_gDBFlags[i] = 0;
    Input_gMode[i] = 0;

    for (int j = 0; j < 0x11; j = j + 1) {
      Input_gPressTime[i][j] = 0; }
  }

  i = 0x1f; h = (int *)Input_gInterfaceResults; h = h + 0x1f;
  do { *h = 0; i = i + -1; h = h + -1; } while (-1 < i);

  return Input_gHandler;
}

/* ---- Input_WingCommandMode__Fi  [INPUT.CPP:84-93] SLD-VERIFIED ---- */
#line 81 "C:/nfs4/GAME/COMMON/INPUT.CPP"
int Input_WingCommandMode(int player)


{
  int *h = Input_gHandler + 0x2d;

  if (player != 0)
    h = h + 0x4c;

  if (((*h == 0) && (h[1] == 0) && (h[2] == 0)) || (Input_gMode[player & 1] != 1))
    return 0;

  return 1; }

/* ---- Input_Update__Fv [INPUT.CPP:104-430; byte868 PASS, SLD tags+blocks exact] ----
 * Retail block list rebuilt (CAMIN2 2026-10-31): the mode arms own their
 * active[17] / active[40]+hactive[17] arrays (gcc reuses the AUTO-136 slot);
 * the fills are count-UP for loops that loop.c reverses (retail's kept
 * count-down biv plus reduced pointer); the held-key scans are plain for
 * loops whose inner `for (int k ...)` keeps the cond scope, which is what
 * stops jump.c from rotating them; `r->flags |= acc << 3` is the last
 * statement of BOTH arms (cross-jumped; gives the reload and the j@261 tag).
 * k = *h in the third scan is inferred from the retail REG $4 k record there.
 * SYM-CODEGEN-CARRIER: devList -- retail rematerializes Device_gDeviceList at
 * every dispatch site (one function-wide REG_EQUIV pseudo that global-alloc
 * spills); direct Device_gDeviceList indexing gives 382 diffs (870/868). It
 * gets no SYM record. */
#line 101 "C:/nfs4/GAME/COMMON/INPUT.CPP"
void Input_Update(void)


{
  int *h;
  Input_tResults *r;
  u_long acc;
  u_long menukeys;

  int i;
  int j;
  int k; int left; int right; char iactive[32]; Input_tDeviceList *devList; Device_Update();
  devList = Device_gDeviceList;



  for (i = 0; i < 32; i++)
    iactive[i] = 1;

  h = Input_gHandler;
  r = Input_gResults;

  menukeys = 0;

  for (i = 0; i < 2; i++) {
    int mode;

    mode = 0;
    for (j = 0; j < 2; j++) {
      if ((*h != 0) &&
          (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)) {
        mode = j + 1;
      }
      h++; }

    Input_gMode[i] = mode;

    if (mode == 0)
    {
      left = devList[*h & 0xff].devicefunc(*h >> 8); h++;
      right = devList[*h & 0xff].devicefunc(*h >> 8); h++;
      r->steering = (char)((right - left) / 2);
      r->gas = devList[*h & 0xff].devicefunc(*h >> 8); h++;
      r->brake = devList[*h & 0xff].devicefunc(*h >> 8); h++;

      for (j = 0; j < 2; j++) {
        if ((*h != 0) &&
            (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)) {
          r->flags |= (1 << j);
        } else {
          r->flags &= ~(1 << j);
        }
        h++; }
      { char active[17]; r->flags &= 7;
      acc = 0;




      for (int k = 0; k < 17; k++)
        active[k] = 1;

      for (j = 0; j < 17; j++) {

        if (*h != 0)
        {
          if (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)
          {
            Input_gPressTime[i][j]++;

            if (Input_gPressTime[i][j] >= 6) {

              if ((Input_gDBFlags[i] & (1 << j)) == 0) {

                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
            }
            for (int k = 0; k < 17; k++) {

              if (h[k - (j - 17)] == *h) {

                active[k] = 0;
                Input_gPressTime[i][k] = Input_gPressTime[i][j];
              }
            }
          } else {


            Input_gDBFlags[i] &= ~(1 << j);
            Input_gPressTime[i][j] = 0;
          }
        }
        h++;
      }
      for (j = 0; j < 17; j++) {

        if (*h != 0) {

          if (devList[*h & 0xff].devicefunc(*h >> 8) >= 65) {

            if (active[j] != 0)

              if ((Input_gDBFlags[i] & (1 << j)) == 0) {

              acc = j + 1;
              Input_gDBFlags[i] |= (1 << j);
            }
          } else {

            if ((u_int)(Input_gPressTime[i][j] - 1) < 5) {

              if ((Input_gDBFlags[i] & (1 << j)) == 0) {

                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
              Input_gPressTime[i][j] = 0;
            } else {

              Input_gDBFlags[i] &= ~(1 << j);
            }
          }
        } h++; }
        for (int m = 0, k; m < 2; m++) {

          for (j = 0; j < 17; j++) {

            if ((k = *h) != 0) {

              if (devList[k & 0xff].devicefunc(k >> 8) >= 65) {
                Input_gDBFlags[i] |= (1 << j);
              } else {
                Input_gDBFlags[i] &= ~(1 << j);
              }
            }
            h++; }
        }
      }
      r->flags |= (acc << 3);
    }
    else

    { char active[40];



      for (j = 0; j < 40; j++)
        active[j] = 1;

      for (j = 0; j < 40; j++) {
        for (k = 0; k < 17; k++) {
          if (h[j] == h[mode * 17 + k + 23]) {
            active[j] = 0;
          }
        } } for (j = 0; j < 32; j++) {
        for (k = 0; k < 17; k++) {
          if (Input_gHandler[j + 152] == h[mode * 17 + k + 23]) {
            iactive[j] = 0;
          }
        } } left = devList[*h & 0xff].devicefunc(*h >> 8); h++;
      right = devList[*h & 0xff].devicefunc(*h >> 8); h++;

      if ((active[0] != 0) && (active[1] != 0)) {
        r->steering = (char)((right - left) / 2);
      }
      if (active[2] != 0) {
        r->gas = devList[*h & 0xff].devicefunc(*h >> 8);
      }
      h++;
      if (active[3] != 0) {
        r->brake = devList[*h & 0xff].devicefunc(*h >> 8);
      } h++;

      for (j = 0; j < 2; j++) {

        if (active[j + 4] != 0) {
          if ((*h != 0) &&
              (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)) {
            r->flags |= (1 << j);
          } else {
            r->flags &= ~(1 << j);
          }
        }
        h++; }
      { char hactive[17]; r->flags &= 7;
        acc = 0;




        for (int k = 0; k < 17; k++)
          hactive[k] = 1;

        for (j = 0; j < 17; j++) {

          if (*h != 0)
          {
            if ((active[j + 6] != 0) && (devList[*h & 0xff].devicefunc(*h >> 8) >= 65))
            {
              Input_gPressTime[i][j]++;

              if (Input_gPressTime[i][j] >= 6) {

                if ((Input_gDBFlags[i] & (1 << j)) == 0) {

                  acc = j + 1;
                  Input_gDBFlags[i] |= (1 << j);
                }
              }
              for (int k = 0; k < 17; k++) {

                if (h[k - (j - 17)] == *h) {

                  hactive[k] = 0;
                  Input_gPressTime[i][k] = Input_gPressTime[i][j];
                }
              }
            } else {


              Input_gDBFlags[i] &= ~(1 << j);
              Input_gPressTime[i][j] = 0;
            }
          }

          h++;
        }

        for (j = 0; j < 17; j++) {

          if (*h != 0) {
            if ((active[j + 23] != 0) &&
                (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)) {

              if ((Input_gDBFlags[i] & (1 << j)) == 0)

                if (hactive[j] != 0) {

                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
            } else if ((active[j + 23] != 0) &&
                       (Input_gPressTime[i][j] > 0) &&
                       (Input_gPressTime[i][j] < 6)) {

              if ((Input_gDBFlags[i] & (1 << j)) == 0) {

                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
              Input_gPressTime[i][j] = 0;
            } else {

              Input_gDBFlags[i] &= ~(1 << j);
            }
          }
          h++; }
      }

      h += (mode - 1) * 17;

      for (j = 0; j < 17; j++) {

        if (*h != 0) {

          if (devList[*h & 0xff].devicefunc(*h >> 8) >= 65) {

            if ((Input_gDBFlags[i] & (1 << j)) == 0) {

              acc = j + 1;
              Input_gDBFlags[i] |= (1 << j);
            }
          } else {

            Input_gDBFlags[i] &= ~(1 << j);
          }
        }
        h++; }


      r->flags |= (acc << 3);
      h += (2 - mode) * 17;
    }



    right = (u_char)r->flags; switch (((u_char)right) >> 3) {
      case 15:

        r->flags &= 7;
        menukeys |= 0x200000;
        break;
      case 16:

        r->flags &= 7;
        menukeys |= (1 << (i + 26));
        break;
      case 17:

        r->flags &= 7;
        menukeys |= (1 << (i + 28));
        break;
    }




    r++;

    if (GameSetup_gData.numPlayerRaceCars == 1) {

      h += 76;
      i++;
    }
  }





  for (i = 0; i < 32; i++) {

    if ((iactive[i] != 0) && (*h != 0) && (devList[*h & 0xff].devicefunc(*h >> 8) >= 65)) {
      menukeys |= (1 << i);
    }
    h++; }
  Input_gTime += 2;
  Input_gInterfaceResults[Input_gTime & 0x1f] = menukeys;
  Input_gInterfaceResults[(Input_gTime + 1) & 0x1f] = menukeys;
}

/* ---- Input_Store__Fv  [INPUT.CPP:436-450] SLD-VERIFIED ---- */
#line 433 "C:/nfs4/GAME/COMMON/INPUT.CPP"
void Input_Store(void)


{
  if (gSimQueue_BlockSelf != 0) return;


  if (1 < GameSetup_gData.numPlayerRaceCars) {




    if (SimQueue_Put(0,Input_gResults))
      SimQueue_Put(1,&Input_gResults[1]);
  }
  else if (GameSetup_gData.commMode == 0)
    SimQueue_Put(GameSetup_gData.localCar,Input_gResults);
}

/* ---- Input_Fetch__Fi  [INPUT.CPP:456-457] SLD-VERIFIED ---- */
#line 453 "C:/nfs4/GAME/COMMON/INPUT.CPP"
void Input_Fetch(int humanIndex)


{
  SimQueue_GetCurrentInput(humanIndex,&Input_gSim);
}

/* ---- Input_Gear__Fci  [INPUT.CPP:466-479] SLD-VERIFIED ---- */
#line 463 "C:/nfs4/GAME/COMMON/INPUT.CPP"
char Input_Gear(char currentGear,int numGears)


{
  if (Input_gSim.flags >> 3 == 1)
  {
    if ((int)(u_int)currentGear < numGears + -1)
      currentGear = currentGear + 1;
    return currentGear;
  }
  if (Input_gSim.flags >> 3 == 2)
  {
    if (currentGear != 0)
      currentGear = currentGear - 1;
    return currentGear;
  }
  return currentGear;
}

/* ---- Input_Interface__FUli  [INPUT.CPP:488-499] SLD-VERIFIED ---- */
#line 485 "C:/nfs4/GAME/COMMON/INPUT.CPP"
int Input_Interface(u_long key,int debounce)


{
  if (debounce != 0) {


    if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << key & ~Input_gInterfaceResults[simGlobal.time32Hz - 1U & 0x1f]) != 0)
      return 1;
  } else {
    if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << key) != 0)

      return 1;
  }
  return 0; }

/* ---- Input_MainExitKey__Fv  [INPUT.CPP:543-544] SLD-VERIFIED ---- */
#line 540 "C:/nfs4/GAME/COMMON/INPUT.CPP"
int Input_MainExitKey(void)


{
  return Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1;
}

/* end of input.cpp */
