#ifndef _SNDPSXZ_SLIB_H_
#define _SNDPSXZ_SLIB_H_

extern void iSNDcalcvol(int chan); /* spatkey */
extern volatile unsigned char *iSNDpsxkeyon(int mask);
extern volatile unsigned char *iSNDpsxkeyoff(int mask); /* spatkey */
extern unsigned int iSNDpsxeffecton(int mask); /* spatkey */
extern unsigned int iSNDpsxeffectoff(int mask); /* spatkey */
extern volatile unsigned char *iSNDpsxeffectvol(int left, int right); /* spatkey */
extern void iSNDsetvol(int chan, int left, int right); /* spatkey */
extern unsigned char *iSNDsetslot(int chan, unsigned char *addr, int pitch); /* @0x800FF394 */
extern unsigned int iSNDstartvoice(unsigned int chan); /* spatkey */
extern int iSNDplatformoutputcaps(void); /* @0x800FF5A8 -- oracle explicitly zeroes $v0 before return */
extern int iSNDplatformoutputset(void); /* @0x800FF600 */
extern int iSNDinit(void); /* @0x800FF700 */
extern int iSNDrestore(void); /* @0x800FF9A0 */
extern void iSNDserve(void); /* @0x800FFAF4 */ /* slib */

#endif /* _SNDPSXZ_SLIB_H_ */
