.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpacketirqcallback, 0x28

glabel iSNDpacketirqcallback
    /* F419C 8010399C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F41A0 801039A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* F41A4 801039A4 E10D040C */  jal        iSNDpacketgetirq
    /* F41A8 801039A8 00000000 */   nop
    /* F41AC 801039AC 2F0E040C */  jal        iSNDpacketsetirq
    /* F41B0 801039B0 00000000 */   nop
    /* F41B4 801039B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* F41B8 801039B8 00000000 */  nop
    /* F41BC 801039BC 0800E003 */  jr         $ra
    /* F41C0 801039C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDpacketirqcallback
