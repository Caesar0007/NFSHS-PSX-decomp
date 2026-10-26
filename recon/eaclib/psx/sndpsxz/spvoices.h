#ifndef _SNDPSXZ_SPVOICES_H_
#define _SNDPSXZ_SPVOICES_H_

struct SNDPLAYOPTS;

extern int SNDSTRM_create(struct SNDPLAYOPTS *priority, int numReq, int pktArg, char *objbuf, int memsize);
extern int SNDSTRM_destroy(int s); /* spvoices */
extern int SNDSTRM_queuefile(unsigned int s, int name, char *filename, int off);
extern int SNDSTRM_purge(int s); /* @0x800E9C58 (fwd: destroy calls it) */

#endif /* _SNDPSXZ_SPVOICES_H_ */
