#ifndef _SNDPSXZ_SSYSSERV_H_
#define _SNDPSXZ_SSYSSERV_H_

struct SndGlobalServerStateView;

extern struct SndGlobalServerStateView *iSNDserveraddclient(void (*cb)(void)); /* @0x8010479C */
extern void iSNDserverremoveclient(void (*cb)(void)); /* @0x801047CC */
extern void SNDSYS_service(void); /* ssysserv */ /* @0x80104878 */

#endif /* _SNDPSXZ_SSYSSERV_H_ */
