#ifndef _SNDPSXZ_STAGPAT_H_
#define _SNDPSXZ_STAGPAT_H_

#include "sndtimbrepriv.h"
struct SNDResolveEntry;
struct SNDRemoveEntry;
#include "../../../shared/SNDPLAYOPTS.h"

extern void iSNDresetpatch(struct SndTimbre *patch); /* @0x80101ABC */
extern unsigned char *iSNDresettimbre(struct SndTimbre *t, struct SndTimbre *buf); /* @0x80101AC4 */
extern void iSNDresolveheader(struct SndTimbre *hdr, struct SndTimbre *out); /* @0x80101B7C */
extern int iSNDfindfreekey(void); /* @0x80101BFC */
extern int iSNDplaytaggedtimbre(unsigned char *timbre, struct SNDPLAYOPTS *tag, struct SndTimbre *vol, struct SndTimbre *header, int baseNote, int velScale, int pitchOff); /* @0x80101C8C */
extern int iSNDplaytaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, struct SNDPLAYOPTS *tag); /* stagpat */ /* @0x8010218C */
extern int iSNDresolvetaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, unsigned char *bankData, struct SNDResolveEntry *scratch); /* stagpat */ /* @0x801024EC */
extern int iSNDremovetaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, struct SNDRemoveEntry *patch); /* stagpat */ /* @0x801025C0 */

extern signed char snddefaultenvelope[8];
extern unsigned char DAT_801371cc;

#endif /* _SNDPSXZ_STAGPAT_H_ */
