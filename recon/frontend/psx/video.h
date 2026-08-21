/* frontend/psx/video.h - reconstructed (declarations for VIDEO.CPP) */
#ifndef _FRONTEND_PSX_VIDEO_H_
#define _FRONTEND_PSX_VIDEO_H_
#include "video_types.h"

int        VIDEO_create(int width, int height, int fps, int streambuffersize, int memtype);
void       VIDEO_destroy(int handle);
void       VIDEO_spoolfile(int handle, char *fname);
void       VIDEO_startplayback(int handle);
void       VIDEO_abortplayback(int handle);
enum VIDEOSTATE VIDEO_state(int handle);
int        VIDEO_updateframexy(int handle, int x, int y);
void       videoupdatetime(struct VIDEOSTRUCT *vid);
int        videodecode(struct VIDEOSTRUCT *vid, struct STREAMCHUNKHDR *chunk, int x, int y);

#endif /* _FRONTEND_PSX_VIDEO_H_ */
