/* Private callback slots at the tail of the sndpd sound-driver state block. */
#ifndef _SNDPSXZ_SNDHOOKPRIV_H_
#define _SNDPSXZ_SNDHOOKPRIV_H_

struct SndPacketVoiceState;

struct SndDriverHookSlots {
    void (*user_serve)(void);   /* sndpd+0x720 */
    void (*voice_done)(struct SndPacketVoiceState *); /* sndpd+0x724 */
    void (*preload)(void);      /* sndpd+0x728 */
};
typedef char SndDriverHookSlots_size_check[(sizeof(struct SndDriverHookSlots) == 0x0C) ? 1 : -1];

/* The allocator's 0x80 x 4-byte table ends at +0x720; these slots complete the 0x72C-byte sndpd block. */
struct SndDriverHookStateView {
    unsigned char reserved_000_71F[0x720];
    struct SndDriverHookSlots hooks;
};
typedef char SndDriverHookStateView_size_check[(sizeof(struct SndDriverHookStateView) == 0x72C) ? 1 : -1];

#endif /* _SNDPSXZ_SNDHOOKPRIV_H_ */
