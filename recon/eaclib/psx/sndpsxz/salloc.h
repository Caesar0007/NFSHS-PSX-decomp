#ifndef _SNDPSXZ_SALLOC_H_
#define _SNDPSXZ_SALLOC_H_

extern int iSNDischanreserved(int chan, int count); /* @0x800FE724 */
extern int iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out); /* salloc */
extern void iSNDfreechan(int chan); /* salloc */
extern int iSNDgetchan(unsigned int tag); /* salloc */

/* Rolling allocation ID counter, owned by sdata.c. Keep an unsized extern view here: a tentative
 * definition would move it to small common, while retail addresses the symbol absolutely. */
extern int DAT_80136dec[];
extern signed char sndchanreserved[]; /* chosen-channel scratch list; storage is emitted by salloc.c */

#endif /* _SNDPSXZ_SALLOC_H_ */
