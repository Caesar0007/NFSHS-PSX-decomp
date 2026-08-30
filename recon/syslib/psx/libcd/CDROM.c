/* libcd.lib(CDROM.obj): StSetRing and the main streaming state block. */
#include "stream_internal.h"

/* Complete contiguous retail BSS run @0x80146C7C..0x80146CC4. */
__asm__("\t.globl\tStEmu_Addr\n\t.globl\tStCdIntrFlag\n"
        "\t.globl\tCChannel\n\t.globl\tStCHANNEL\n"
        "\t.globl\tStframe_no\n\t.globl\tStRgb24\n"
        "\t.globl\tStEndFrame\n\t.globl\tStSTART_FLAG\n"
        "\t.globl\tStEmu_Idx\n\t.globl\tStsector_offset\n"
        "\t.globl\tStFinalSector\n\t.globl\tStRingBase\n"
        "\t.globl\tStRingAddr\n\t.globl\tStRingIdx1\n"
        "\t.globl\tStRingIdx2\n\t.globl\tStRingIdx3\n"
        "\t.globl\tStRingSize\n\t.globl\tStStartFrame\n"
        "\t.section\t.bss.st_80146C7C,\"aw\",@nobits\n\t.align\t2\n"
        "StEmu_Addr:\n\t.space\t4\n"
        "StCdIntrFlag:\n\t.space\t4\n"
        "CChannel:\n\t.space\t4\n"
        "StCHANNEL:\n\t.space\t4\n"
        "Stframe_no:\n\t.space\t4\n"
        "StRgb24:\n\t.space\t4\n"
        "StEndFrame:\n\t.space\t4\n"
        "StSTART_FLAG:\n\t.space\t4\n"
        "StEmu_Idx:\n\t.space\t4\n"
        "Stsector_offset:\n\t.space\t4\n"
        "StFinalSector:\n\t.space\t4\n"
        "StRingBase:\n\t.space\t4\n"
        "StRingAddr:\n\t.space\t4\n"
        "StRingIdx1:\n\t.space\t4\n"
        "StRingIdx2:\n\t.space\t4\n"
        "StRingIdx3:\n\t.space\t4\n"
        "StRingSize:\n\t.space\t4\n"
        "StStartFrame:\n\t.space\t4\n\t.text");

extern void StSetRing(u_long *ring_addr, u_long ring_size)
{
    StRingAddr = (int)ring_addr;
    StRingSize = (int)ring_size;
    StClearRing();
}
