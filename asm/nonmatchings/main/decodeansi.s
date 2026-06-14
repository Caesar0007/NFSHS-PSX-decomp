.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching decodeansi, 0x18

glabel decodeansi
    /* F71AC 801069AC 0000838C */  lw         $v1, 0x0($a0)
    /* F71B0 801069B0 00000000 */  nop
    /* F71B4 801069B4 00006290 */  lbu        $v0, 0x0($v1)
    /* F71B8 801069B8 01006324 */  addiu      $v1, $v1, 0x1
    /* F71BC 801069BC 0800E003 */  jr         $ra
    /* F71C0 801069C0 000083AC */   sw        $v1, 0x0($a0)
endlabel decodeansi
