#include "common.h"

INCLUDE_ASM("asm/nonmatchings/front", VIDEO_create__Fiiiii);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_destroy__Fi);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_spoolfile__FiPc);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_startplayback__Fi);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_abortplayback__Fi);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_state__Fi);
INCLUDE_ASM("asm/nonmatchings/front", VIDEO_updateframexy__Fiii);
INCLUDE_ASM("asm/nonmatchings/front", videoupdatetime__FP11VIDEOSTRUCT);
INCLUDE_ASM("asm/nonmatchings/front", videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii);
