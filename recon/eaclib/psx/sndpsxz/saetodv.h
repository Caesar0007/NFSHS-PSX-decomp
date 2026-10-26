#ifndef _SNDPSXZ_SAETODV_H_
#define _SNDPSXZ_SAETODV_H_

extern int iSNDabs(int a); /* @0x8010AEDC */
extern void iSNDatodlrv(int angle, int level, int *out_l, int *out_r, int prevL, int prevR); /* @0x8010AEF4 */

#endif /* _SNDPSXZ_SAETODV_H_ */
