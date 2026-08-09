#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", STREAM_overhead);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_create);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_setfilter);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_destroy);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_setpriority);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_setgreedylevel);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_setgreedystate);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_queuefile);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_queuemem);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_cancelrequest);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_kill);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_get);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_release);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_gettable);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_state);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_isendofstream);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_buffersize);
INCLUDE_ASM("asm/nonmatchings/main", STREAM_bufferusage);
INCLUDE_ASM("asm/nonmatchings/main", validatehandle);
INCLUDE_ASM("asm/nonmatchings/main", inbetween);
INCLUDE_ASM("asm/nonmatchings/main", decbufferusage);
INCLUDE_ASM("asm/nonmatchings/main", getfreerequest);
INCLUDE_ASM("asm/nonmatchings/main", queuerequest);
/* w52-a2 re-attribution: locaterequest's 2nd linked copy @0x800FC4E4 -- an
 * eacpsxz STREAM fn (callers queuerequest/STREAM_cancelrequest), was stray-
 * scaffolded in syslib libcd/stream.c. */
INCLUDE_ASM("asm/nonmatchings/main", func_800FC4E4);
INCLUDE_ASM("asm/nonmatchings/main", freerequest);
INCLUDE_ASM("asm/nonmatchings/main", filterchunk);
INCLUDE_ASM("asm/nonmatchings/main", parsechunks);
INCLUDE_ASM("asm/nonmatchings/main", opencallback);
INCLUDE_ASM("asm/nonmatchings/main", closecallback);
INCLUDE_ASM("asm/nonmatchings/main", readcallback);
INCLUDE_ASM("asm/nonmatchings/main", startnextrequest);
INCLUDE_ASM("asm/nonmatchings/main", restartstream);
