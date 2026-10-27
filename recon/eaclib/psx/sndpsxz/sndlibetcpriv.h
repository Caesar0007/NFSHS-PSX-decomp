/* Evidence-backed libetc interrupt entry points used by sndpsxz. */
#ifndef _SNDPSXZ_SNDLIBETCPRIV_H_
#define _SNDPSXZ_SNDLIBETCPRIV_H_

extern void InterruptCallback(int idx, void (*handler)(void)); /* syslib INTR (real 2-arg sig -- see
                                                                 * INTR_DMA.cpp/INTR_VB.c/drv.cpp);
                                                                 * INTR.obj @0x800F287C. */
typedef void (*SndDmaCallback)(void);
extern SndDmaCallback DMACallback(int ch, SndDmaCallback func); /* libetc INTR.obj @0x800F28AC; real
                                           * arguments are channel and callback pointer. */

#endif /* _SNDPSXZ_SNDLIBETCPRIV_H_ */
