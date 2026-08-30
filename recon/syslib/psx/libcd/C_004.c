/* libcd.lib(C_004.obj): data_ready_callback and its private sector words. */
#include "stream_internal.h"

/* Complete C_004.obj retail BSS run @0x801489D0.  The callback slot at
 * 0x801489E4 belongs to libds/DSCB.obj and is intentionally not duplicated. */
__asm__("\t.globl\t_ds_word0\n\t.globl\t_ds_word1\n"
        "\t.section\t.bss.ds_801489D0,\"aw\",@nobits\n\t.align\t2\n"
        "_ds_word0:\n\t.space\t4\n"
        "_ds_word1:\n\t.space\t4\n\t.text");
extern int _ds_word0;
extern int _ds_word1;

/* CdlLOC is four byte-sized fields.  Its alignment makes the structure copy
 * take the same block-move expansion used by retail PsyQ. */
struct _ds_loc {
    u_char minute;
    u_char second;
    u_char sector;
    u_char track;
};

extern void data_ready_callback(void)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx2 << 5));
    struct _ds_loc *dst = (struct _ds_loc *)&_ds_word0;

    slot[0] = 2;
    *dst = *(struct _ds_loc *)(slot + 14);
    _ds_word1 = *(int *)(slot + 4);
    StRingIdx2 = StRingIdx1;
    if (StFunc1 != 0)
        ((void (*)())StFunc1)();
    StFinalSector = 0;
}
