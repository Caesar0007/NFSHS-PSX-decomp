#ifndef _SNDPSXZ_SDFX_H_
#define _SNDPSXZ_SDFX_H_

extern void SNDI_mutexalloc(void); /* @0x801001EC */
extern void SNDI_mutexfree(void); /* @0x801001F4 */
extern void SNDI_mutexlock(void); /* @0x801001FC */
extern void SNDI_mutexunlock(void); /* @0x80100204 */
extern unsigned int iSNDpsxfxinit(int mode); /* @0x8010020C */
extern int iSNDplatformfxinit(int reserved, int mode, int depthL, int depthR); /* @0x80100584 */
extern int iSNDplatformfxmasterlevel(int bus, int level); /* sfxlevel */ /* @0x801005BC */

extern unsigned char sndpe[660];

#endif /* _SNDPSXZ_SDFX_H_ */
