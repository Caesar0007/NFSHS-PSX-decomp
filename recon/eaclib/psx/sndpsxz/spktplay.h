#ifndef _SNDPSXZ_SPKTPLAY_H_
#define _SNDPSXZ_SPKTPLAY_H_

struct SNDPLAYOPTS;
struct SndPatchAttributes;
struct SNDSAMPLEFORMAT;
struct PacketPlayerHeader;
union SndPacketSubmitFrameView;

extern int iSNDpacketplayoverhead(int n); /* @0x801028BC */
extern int SNDPKTPLAY_overhead(int n); /* @0x801028D0 */ /* spktplay */
extern int SNDPKTPLAY_create(unsigned char *mem, int memsize, void (*relcb)(unsigned char *),
                              void (*notifycb)(int, unsigned int)); /* @0x801028FC */
extern int SNDPKTPLAY_start(int p, struct SNDSAMPLEFORMAT *rate,
                            struct SndPatchAttributes *hdr,
                            struct SNDPLAYOPTS *params); /* @0x80102A10 */
extern int SNDPKTPLAY_submit(int p, union SndPacketSubmitFrameView *frame); /* @0x80102CFC */
extern int SNDPKTPLAY_submitspace(int p); /* @0x80102E70 */
extern int SNDPKTPLAY_unsafeframesoutstanding(int p); /* @0x80102EC4 */ /* spktplay */
extern int SNDPKTPLAY_framesoutstanding(int p); /* @0x80102EEC */
extern int SNDPKTPLAY_purge(int p, int lo, int hi); /* @0x80102F3C */
extern int SNDPKTPLAY_stop(int p); /* @0x80103118 */
extern int SNDPKTPLAY_destroy(int p); /* @0x801031F4 */
extern unsigned char *iSNDpacketget(int p, int idx, int *out); /* spktplay */ /* @0x80103248 */
extern void iSNDpacketfreeframes(int p, int idx, int bytes); /* spktplay @0x801033C4, real 3-arg sig
                                                                          * (see spktplay.c): a0=p/a1=i/a2=taken;
                                                                          * observed callers discard the result. */ /* @0x801033C4 */

extern struct PacketPlayerHeader *sndpps[];

#endif /* _SNDPSXZ_SPKTPLAY_H_ */
