/* libcd.lib(C_010.obj): StSetMask. */
#include "stream_internal.h"

extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame)
{
    StSTART_FLAG = (int)mask;
    StStartFrame = (int)start_frame;
    StEndFrame = (int)end_frame;
}
