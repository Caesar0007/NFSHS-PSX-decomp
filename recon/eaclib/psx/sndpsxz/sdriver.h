#ifndef _SNDPSXZ_SDRIVER_H_
#define _SNDPSXZ_SDRIVER_H_

extern int iSNDstop(unsigned int chan); /* @0x800FFE90 */
extern int iSNDplatformpitch(int chan, int pitch);
extern int iSNDplatformfxlevel(unsigned int chan, int bus, int fxon); /* @0x80100058; sdriver (3-arg) */
extern int iSNDvol(int chan, int level); /* @0x801000F8; sdriver */

#endif /* _SNDPSXZ_SDRIVER_H_ */
