/* frontend/psx/video.h - reconstructed (declarations for VIDEO.CPP) */
#ifndef _FRONTEND_PSX_VIDEO_H_
#define _FRONTEND_PSX_VIDEO_H_
#include "../../nfs4_types.h"   /* VIDEOSTRUCT(64B), STREAMCHUNKHDR(8B), VIDEOSTATE - video.obj-owned */

int        VIDEO_create(int width, int height, int fps, int streambuffersize, int memtype);
void       VIDEO_destroy(int handle);
void       VIDEO_spoolfile(int handle, char *fname);
void       VIDEO_startplayback(int handle);
void       VIDEO_abortplayback(int handle);
VIDEOSTATE VIDEO_state(int handle);
int        VIDEO_updateframexy(int handle, int x, int y);
void       videoupdatetime(VIDEOSTRUCT *vid);
int        videodecode(VIDEOSTRUCT *vid, STREAMCHUNKHDR *chunk, int x, int y);

#endif /* _FRONTEND_PSX_VIDEO_H_ */
