#ifndef _SNDPSXZ_SCLCPTCH_H_
#define _SNDPSXZ_SCLCPTCH_H_

extern int iSNDdetunetolinear(int detune); /* @0x80101900 */
extern int iSNDcalcpitch(int note); /* @0x801019BC */

extern unsigned char sndcents[256];

#endif /* _SNDPSXZ_SCLCPTCH_H_ */
