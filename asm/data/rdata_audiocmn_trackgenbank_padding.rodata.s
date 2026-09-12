.include "macro.inc"
/* P907: existing native CPE/raw zero bytes, not new source padding.
 * Retained in both lanes and explicitly placed at80055738..8005573C. */
.section .rodata, "a"
    /* 45F38 80055738 00000000 */ .word 0x00000000
