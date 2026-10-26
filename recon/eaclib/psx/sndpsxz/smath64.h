#ifndef _SNDPSXZ_SMATH64_H_
#define _SNDPSXZ_SMATH64_H_

struct SNDu64Value { unsigned int lo, hi; };

extern struct SNDu64Value *iSNDmulu64(struct SNDu64Value *out, unsigned int a, unsigned int b); /* @0x80103424 */
extern int iSNDdivu64(struct SNDu64Value value, unsigned int div); /* @0x801034C0 */

#endif /* _SNDPSXZ_SMATH64_H_ */
