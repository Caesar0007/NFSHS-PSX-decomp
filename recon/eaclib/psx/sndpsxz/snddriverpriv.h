/* Private prefix view for the early sound-driver state stored in sndpd. */
#ifndef _SNDPSXZ_SNDDRIVERPRIV_H_
#define _SNDPSXZ_SNDDRIVERPRIV_H_

struct SndDriverBootstrapPrefixView {
    unsigned char opaque_000_001[2];
    unsigned char last_channel_mode; /* sndpd+0x02; last output channel mode applied */
};
typedef char SndDriverBootstrapPrefixView_size_check[(sizeof(struct SndDriverBootstrapPrefixView) == 3) ? 1 : -1];

#endif /* _SNDPSXZ_SNDDRIVERPRIV_H_ */
