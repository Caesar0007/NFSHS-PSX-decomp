.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_IdentMatrix__FP6MATRIX, 0x1C

glabel Flare_IdentMatrix__FP6MATRIX
    /* BC5F8 800CBDF8 00100224 */  addiu      $v0, $zero, 0x1000
    /* BC5FC 800CBDFC 000082AC */  sw         $v0, 0x0($a0)
    /* BC600 800CBE00 040080AC */  sw         $zero, 0x4($a0)
    /* BC604 800CBE04 080082AC */  sw         $v0, 0x8($a0)
    /* BC608 800CBE08 0C0080AC */  sw         $zero, 0xC($a0)
    /* BC60C 800CBE0C 0800E003 */  jr         $ra
    /* BC610 800CBE10 100082AC */   sw        $v0, 0x10($a0)
endlabel Flare_IdentMatrix__FP6MATRIX
