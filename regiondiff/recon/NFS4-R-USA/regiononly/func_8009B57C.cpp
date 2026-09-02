#define CopSpeak_Server CopSpeak_Server_base
#include "../../../../recon/game/common/copspeak.cpp"
#undef CopSpeak_Server

static inline int CopSpeak_WrappedPlay(int play)
{
  return play - 0x40;
}

extern "C" void func_8009B57C(void)
{
  CopSpeak_tRequest *next;

  if (CopSpeak_gSpchHandle != -1) {
    if (CopSpeak_gCurrent.phrase == -1) {
      AudioCmn_GetAsyncSfx((signed char)CopSpeak_gCurrent.bank,
                           CopSpeak_gCurrent.offset + 0x4000,true);
    }
    else {
      AudioCmn_GetAsyncSfx((signed char)CopSpeak_gCurrent.bank,
                           CopSpeak_gCurrent.phrase,true);
    }
    if (SNDtimeremaining(CopSpeak_gSpchHandle) < 5) {
      if (CopSpeak_gQueuePlay != CopSpeak_gQueueHead) {
        CopSpeak_tRequest *r = &CopSpeak_gQueue[CopSpeak_gQueuePlay];

        if (((signed char)r->bank == 3) && (r->phrase == 0x13) &&
            (CopSpeak_gCurrent.car == (Car_tObj *)0x0)) {
          r->phrase = 0x14;
        }
      }
      CopSpeak_gSpchHandle = -1;
      CopSpeak_InitRequest(&CopSpeak_gCurrent);
    }
  }

  {
    int i;

    for (i = CopSpeak_gQueuePlay; i != CopSpeak_gQueueHead;
         i = i < 0x3f ? i + 1 : 0) {
      if ((CopSpeak_gQueue[i].sfx == 0) &&
          ((signed char)CopSpeak_gQueue[i].bank != 3) &&
          ((signed char)CopSpeak_gQueue[i].bank >= 0)) {
        if (CopSpeak_gQueue[i].phrase == -1) {
          AudioCmn_GetAsyncSfx((signed char)CopSpeak_gQueue[i].bank,
                               CopSpeak_gQueue[i].offset + 0x4000,true);
        }
        else {
          AudioCmn_GetAsyncSfx((signed char)CopSpeak_gQueue[i].bank,
                               CopSpeak_gQueue[i].phrase,true);
        }
      }
    }
  }

  if (CopSpeak_gQueueReady != CopSpeak_gQueueLoad) {
    CopSpeak_ReadyNextRequest();
  }

  next = (CopSpeak_tRequest *)0x0;
  if (CopSpeak_gSpchHandle != -1) {
    next = &CopSpeak_gCurrent;
  }
  else if ((CopSpeak_gQueuePlay != CopSpeak_gQueueReady) &&
           (CopSpeak_gQueuePlay != CopSpeak_gQueueHead)) {
    next = &CopSpeak_gQueue[CopSpeak_gQueuePlay < 0x3f ?
                            CopSpeak_gQueuePlay + 1 : 0];
  }

  if ((next != (CopSpeak_tRequest *)0x0) && (next->noise != 0)) {
    int noise = 0x30;

    if (next->car != (Car_tObj *)0x0) {
      int carNoise = *(short *)((char *)next->car + 0x8e) + 0x20;

      noise = 0x7f;
      if (carNoise < 0x80) {
        noise = carNoise;
      }
    }
    CopSpeak_RadioStaticActive(noise);
  }
  else {
    CopSpeak_RadioStaticSquelch();
  }

  if (((((((CopSpeak_gQueueReady == CopSpeak_gQueueHead) ||
            (CopSpeak_gQueue[CopSpeak_gQueueReady].sfx != 0)) ||
           (CopSpeak_gQueue[CopSpeak_gQueueReady].car !=
            CopSpeak_gQueue[CopSpeak_gQueuePlay].car)) ||
          ((signed char)CopSpeak_gQueue[CopSpeak_gQueuePlay].bank < 0)) ||
         (CopSpeak_gQueue[CopSpeak_gQueuePlay].sfx != 0)) ||
        (0x10 < ((CopSpeak_gQueueReady -
                  CopSpeak_WrappedPlay(CopSpeak_gQueuePlay)) & 0x3f))) &&
      ((CopSpeak_gQueuePlay != CopSpeak_gQueueReady) &&
       (CopSpeak_gQueuePlay != CopSpeak_gQueueHead))) {
    CopSpeak_PlayNextRequest();
  }
  CopSpeak_LoadNextRequest();
}
