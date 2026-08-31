/* libcd.lib(C_004.obj): data_ready_callback and its private sector words. */
#include "stream_internal.h"

/* Canonical PsyQ 4.3 C_004.obj has one 16-byte BSS section.  Its relocations
 * address the section base and base+4; the final eight bytes are member tail,
 * not separately named storage.  The callback slot at 0x801489E4 belongs to
 * libds/DSCB.obj and is intentionally not duplicated.  SotN's symbol-bearing
 * copy preserves `fp_2` and proves both used words are file-local.  The second
 * original spelling is not retained. */
__asm__("\t.local\tfp_2\n\t.local\tD_801489D4\n"
        "\t.section\t.bss.ds_801489D0,\"aw\",@nobits\n\t.align\t2\n"
        "fp_2:\n\t.space\t4\n"
        "D_801489D4:\n\t.space\t4\n"
        "\t.space\t8\n\t.text");

/* CdlLOC is four byte-sized fields.  Its alignment makes the structure copy
 * take the same block-move expansion used by retail PsyQ. */
typedef struct CdlLOC {
    u_char minute;
    u_char second;
    u_char sector;
    u_char track;
} CdlLOC;
extern CdlLOC fp_2;
extern int D_801489D4; /* saved StHEADER.frameCount; original spelling unknown */

extern void data_ready_callback(void)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx2 << 5));

    slot[0] = 2;
    fp_2 = *(CdlLOC *)(slot + 14);
    D_801489D4 = *(int *)(slot + 4);
    StRingIdx2 = StRingIdx1;
    if (StFunc1 != 0)
        ((void (*)())StFunc1)();
    StFinalSector = 0;
}
