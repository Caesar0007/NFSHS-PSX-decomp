.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetClut, 0x18

glabel GetClut
    /* E4C50 800F4450 80110500 */  sll        $v0, $a1, 6
    /* E4C54 800F4454 03210400 */  sra        $a0, $a0, 4
    /* E4C58 800F4458 3F008430 */  andi       $a0, $a0, 0x3F
    /* E4C5C 800F445C 25104400 */  or         $v0, $v0, $a0
    /* E4C60 800F4460 0800E003 */  jr         $ra
    /* E4C64 800F4464 FFFF4230 */   andi      $v0, $v0, 0xFFFF
endlabel GetClut
    /* E4C68 800F4468 00000000 */  nop
    /* E4C6C 800F446C 00000000 */  nop
