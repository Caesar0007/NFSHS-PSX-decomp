#ifndef _SNDPSXZ_SNDFMTPRIV_H_
#define _SNDPSXZ_SNDFMTPRIV_H_

/* Private four-byte sample-format record shared by the stream parser and packet
 * player. Its natural field layout is 2+1+1 bytes; all known stream/output views
 * have the word aligned, and size is checked below. */
typedef struct SNDSAMPLEFORMAT {
    unsigned short samplerate;
    unsigned char channels;
    unsigned char samplerep;
} SNDSAMPLEFORMAT;
typedef char SNDSAMPLEFORMAT_size_check[(sizeof(SNDSAMPLEFORMAT) == 4) ? 1 : -1];

#endif /* _SNDPSXZ_SNDFMTPRIV_H_ */
