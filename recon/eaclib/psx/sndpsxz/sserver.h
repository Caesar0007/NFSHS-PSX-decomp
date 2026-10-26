#ifndef _SNDPSXZ_SSERVER_H_
#define _SNDPSXZ_SSERVER_H_

struct SndGlobalServerStateView;

extern void iSNDserver(void); /* sserver */ /* @0x800EA138 */
extern void iSND100hzserver(void); /* @0x800EA254 */
extern void iSNDenteraudio(void); /* sserver */ /* @0x800EA534 */
extern void iSNDleaveaudio(void); /* sserver */ /* @0x800EA56C */
extern struct SndGlobalServerStateView *iSNDserveradd100hzclient(void (*cb)(void));
extern void iSNDserverremove100hzclient(void (*cb)(void));

#endif /* _SNDPSXZ_SSERVER_H_ */
