/* libcd.lib(C_005.obj): StSetStream and its two callback slots. */
#include "stream_internal.h"

/* The two words form this member's complete retail BSS run @0x80144874. */
__asm__("\t.globl\tStFunc1\n\t.globl\tStFunc2\n"
        "\t.section\t.bss.st_80144874,\"aw\",@nobits\n\t.align\t2\n"
        "StFunc1:\n\t.space\t4\n"
        "StFunc2:\n\t.space\t4\n\t.text");

extern void StSetStream(u_long mode, u_long start_frame, u_long end_frame,
                        void (*func1)(), void (*func2)())
{
    StSetMask(1, start_frame, end_frame);
    StEmu_Addr      = 0;
    StFunc1         = (int)func1;
    StRgb24         = (int)(mode & 1);
    CChannel        = 0;
    StCHANNEL       = 0;
    Stsector_offset = 0;
    Stframe_no      = 0;
    StFunc2         = (int)func2;
}
