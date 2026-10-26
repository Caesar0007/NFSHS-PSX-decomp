#ifndef _SNDPSXZ_SDMEMMAN_H_
#define _SNDPSXZ_SDMEMMAN_H_

extern void iSNDpsxmemconstrain(unsigned int *size, int *avail); /* @0x8010A550 */
extern unsigned char *iSNDpsxmalloc(int size); /* @0x8010A5CC */
extern int iSNDpsxfree(unsigned char *ptr); /* sdmemman */

#endif /* _SNDPSXZ_SDMEMMAN_H_ */
