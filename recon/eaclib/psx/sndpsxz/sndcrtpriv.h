/* Target C runtime prototypes used by the sndpsxz C translation units. */
#ifndef _SNDPSXZ_SNDCRTPRIV_H_
#define _SNDPSXZ_SNDCRTPRIV_H_

extern void *memcpy(void *dst, const void *src, int n); /* C42 (BIOS thunk) */
extern void *memset(void *dst, int c, int n);           /* C43 (BIOS thunk) */
extern int memcmp(const void *a, const void *b, int n);

#endif /* _SNDPSXZ_SNDCRTPRIV_H_ */
