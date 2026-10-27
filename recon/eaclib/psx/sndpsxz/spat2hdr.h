#ifndef _SNDPSXZ_SPAT2HDR_H_
#define _SNDPSXZ_SPAT2HDR_H_

#include "sndattrpriv.h"
#include "sndfmtpriv.h"

extern int SNDattributessetdef(SndPatchAttributeBlock *attr); /* @0x801035B0 */
extern int iSNDpatchtohdr(unsigned char *sampleData, SNDSAMPLEFORMAT *format, SndPatchAttributeBlock *attr, int *extraOut); /* @0x801035E4 (returns 0) */ /* spat2hdr */

#endif /* _SNDPSXZ_SPAT2HDR_H_ */
