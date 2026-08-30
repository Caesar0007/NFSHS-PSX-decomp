#ifndef NFS4_LIBCD_STREAM_INTERNAL_H
#define NFS4_LIBCD_STREAM_INTERNAL_H

/* Internal libcd streaming declarations shared by PsyQ's one-function
 * C_00x archive members.  Canonical member ownership comes from PsyQ 4.3
 * INDEX.tsv; retail SYM retains no type payload for these vendor objects. */
typedef unsigned long  u_long;
typedef unsigned short u_short;
typedef unsigned char  u_char;

extern int StFunc1;
extern int StFunc2;
extern int StMode;
extern int StEmu_Addr;
extern int StCdIntrFlag;
extern int CChannel;
extern int StCHANNEL;
extern int Stframe_no;
extern int StRgb24;
extern int StEndFrame;
extern int StSTART_FLAG;
extern int StEmu_Idx;
extern short Stsector_offset;
extern int StFinalSector;
extern int StRingBase;
extern int StRingAddr;
extern int StRingIdx1;
extern int StRingIdx2;
extern int StRingIdx3;
extern int StRingSize;
extern int StStartFrame;

extern void StClearRing(void);
extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame);
extern void init_ring_status(int base, unsigned count);

#endif
