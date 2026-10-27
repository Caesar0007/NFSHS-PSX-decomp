#ifndef _SNDPSXZ_SBREMOVE_H_
#define _SNDPSXZ_SBREMOVE_H_

extern int iSNDremovepatches(int bank, int count); /* @0x800E65F8 */
extern void SNDbankremove(int bankId); /* @0x800E6674 */
extern int cSNDbankremove(int bankId, int recurse); /* @0x800E6694 ; a1 always 0 at every call */

#endif /* _SNDPSXZ_SBREMOVE_H_ */
