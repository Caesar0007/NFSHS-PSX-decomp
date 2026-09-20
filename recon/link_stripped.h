/* recon/link_stripped.h -- retail's final link removed UNREFERENCED FUNCTIONS from the objects it linked and kept their
 * data (proof: libcd SYS.obj is PsyQ 4.3's object minus CdLastCom/CdComstr/CdIntstr/CdMix, every other function at its
 * exact size; libapi PAD.obj keeps 16 of its 768 text bytes and all of its data).  A function the link removed is written
 * in full, in its original place, and tagged on its PROTOTYPE:
 *     extern int CdLastCom(void) LINK_STRIPPED;
 * The tag only names the input section; the recon linker script discards that section, so the rest of the object closes
 * up exactly like retail.  Every tagged function must be listed, with its evidence, in linkers/link_stripped.json
 * (checked by tools/gen_ld.py); a call from kept code to a tagged function fails the link. */
#ifndef NFS4_LINK_STRIPPED_H
#define NFS4_LINK_STRIPPED_H
#define LINK_STRIPPED __attribute__((section(".text.strip")))
/* Read-only data retail does NOT have although the SDK object does: the image keeps a stripped function's literals when
 * live data follows them in the object's .rdata, but the section's dead TAIL is gone (libgpu SYS.obj: "LoadImage2" is the
 * last string in retail, the SDK object goes on with "StoreImage2" and "MoveImage2").  Such a literal is spelled as a named
 * array in a discarded input section. */
#define LINK_STRIPPED_RODATA __attribute__((section(".rodata.strip")))
/* Uninitialised storage retail does not have: a function-static that is declared and never referenced.  Evidence
 * (scratchpad/psyq_pipe/stat_small.py): every uninitialised function-static of the game has a retail `name.NN` label
 * (12 of 12: strspc, resethud, corrPt, lastX ...); aih_btccop's `sayLose`, the only one no code touches, has a debug
 * record and NO label -- no storage was allocated for it. */
#define LINK_STRIPPED_BSS __attribute__((section(".bss.strip")))
/* A Sony HAND-ASSEMBLY routine the final link removed: the SDK object's own instruction lines, in `.text.strip`. */
#define ASM_LINK_STRIPPED(name, body)                                          \
    __asm__("\t.section .text.strip,\"ax\",@progbits\n\t.set\tnoreorder\n\t.set noreorder\n" /* tab form = for maspsx (consumed), space form = for gas */ \
            "\t.globl " #name "\n\t.type " #name ",@function\n" #name ":\n"    \
            body                                                               \
            "\t.size " #name ",.-" #name "\n\t.set reorder\n\t.set at\n\t.text\n")
#endif
