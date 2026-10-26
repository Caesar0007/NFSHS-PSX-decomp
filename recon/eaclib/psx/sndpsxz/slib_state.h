/* slib_state.h -- shared byte/address views into the driver state owned by slib.c. */
#ifndef _SNDPSXZ_SLIB_STATE_H_
#define _SNDPSXZ_SLIB_STATE_H_

extern unsigned char sndpdsafeloop[16];
extern unsigned char sndpd[]; /* @0x80147918; unsized byte view preserves the oracle's base-plus-offset materialization. */
extern unsigned char D_801479F0[];
extern unsigned char D_80147A0C[];
extern unsigned char *DAT_80147e28; /* @0x80147E28; stored SPU voice-register base pointer. */
extern unsigned short D_80147E34[];

#endif /* _SNDPSXZ_SLIB_STATE_H_ */
