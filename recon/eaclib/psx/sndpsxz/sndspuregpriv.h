/* Private view of register-base pointers latched in the sndpd system-state block. */
#ifndef _SNDPSXZ_SNDSPUREGPRIV_H_
#define _SNDPSXZ_SNDSPUREGPRIV_H_

struct SndSpuRegisterBases {
    volatile unsigned int *address_4fc; /* iSNDinit calls it `delay`; DMA transfer uses the same slot as DPCR */
    volatile unsigned int *dma4_madr; /* +0x500 */
    volatile unsigned int *dma4_bcr;  /* +0x504 */
    volatile unsigned int *dma4_chcr; /* +0x508 */
    volatile unsigned int *dpcr;      /* +0x50C */
    volatile unsigned char *voice_base;   /* +0x510: SPU voice-register byte base */
    volatile unsigned char *control_base; /* +0x514: SPU control-register byte base */
};
typedef char SndSpuRegisterBases_size_check[(sizeof(struct SndSpuRegisterBases) == 0x1C) ? 1 : -1];

/* Displacement view into the larger sndpd state object; preceding bytes are intentionally opaque. */
struct SndSpuRegisterBasesStateView {
    unsigned char reserved_000_4FB[0x4FC];
    struct SndSpuRegisterBases registers;
};
typedef char SndSpuRegisterBasesStateView_size_check[(sizeof(struct SndSpuRegisterBasesStateView) == 0x518) ? 1 : -1];

/* Displacement view of the two CD-input volume registers in the SPU control block. */
struct SndSpuCdVolumeRegisterView {
    unsigned char opaque_000_1AF[0x1B0];
    unsigned short cd_volume_left;  /* +0x1B0 */
    unsigned short cd_volume_right; /* +0x1B2 */
};
typedef char SndSpuCdVolumeRegisterView_size_check[(sizeof(struct SndSpuCdVolumeRegisterView) == 0x1B4) ? 1 : -1];

/* Shared portion of the SPU control-register block used during system initialization. */
struct SndSpuControlRegisterView {
    unsigned char opaque_000_17F[0x180];
    volatile short master_volume_left;         /* +0x180 */
    volatile short master_volume_right;        /* +0x182 */
    unsigned char opaque_184_1A9[0x26];
    volatile unsigned short control;            /* +0x1AA */
    unsigned char opaque_1AC_1AD[2];
    volatile unsigned short status;             /* +0x1AE */
};
typedef char SndSpuControlRegisterView_size_check[(sizeof(struct SndSpuControlRegisterView) == 0x1B0) ? 1 : -1];

#endif /* _SNDPSXZ_SNDSPUREGPRIV_H_ */
