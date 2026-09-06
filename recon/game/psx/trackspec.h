/* game/psx/trackspec.h — reconstructed from game/psx/trackspec.cpp (5 fns) */
#ifndef _GAME_PSX_TRACKSPEC_H_
#define _GAME_PSX_TRACKSPEC_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void TrackSpec_SetDefault(CTrackSpec * spec);   /* SYM 47a55f @0x800e1544 */
void TrackSpec_SetUp(void);   /* SYM 47a591 @0x800e177c */
void read(char ** handle,void * buf,int bytes);   /* SYM 47a5b2 @0x800e17a0 */
void TrackSpec_Read(int spec_num);   /* SYM 47a5cd @0x800e17d0 */
void TrackSpec_Load(int weather,int night);   /* SYM 47a5ed @0x800e18cc */

#endif /* _GAME_PSX_TRACKSPEC_H_ */
