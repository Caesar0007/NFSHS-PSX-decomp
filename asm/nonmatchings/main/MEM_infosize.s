.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MEM_infosize, 0x28

glabel MEM_infosize
    /* D5808 800E5008 1480023C */  lui        $v0, %hi(memclass)
    /* D580C 800E500C 00E94224 */  addiu      $v0, $v0, %lo(memclass)
    /* D5810 800E5010 0F008430 */  andi       $a0, $a0, 0xF
    /* D5814 800E5014 80200400 */  sll        $a0, $a0, 2
    /* D5818 800E5018 21208200 */  addu       $a0, $a0, $v0
    /* D581C 800E501C 0000828C */  lw         $v0, 0x0($a0)
    /* D5820 800E5020 00000000 */  nop
    /* D5824 800E5024 3000428C */  lw         $v0, 0x30($v0)
    /* D5828 800E5028 0800E003 */  jr         $ra
    /* D582C 800E502C 00000000 */   nop
endlabel MEM_infosize
