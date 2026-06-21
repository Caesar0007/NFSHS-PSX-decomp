.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__26tListIteratorDoubleIndexed7tPlayer, 0x50

glabel TextValue__26tListIteratorDoubleIndexed7tPlayer
    /* 149B8 800241B8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 149BC 800241BC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 149C0 800241C0 21808000 */  addu       $s0, $a0, $zero
    /* 149C4 800241C4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 149C8 800241C8 0C00028E */  lw         $v0, 0xC($s0)
    /* 149CC 800241CC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 149D0 800241D0 10004484 */  lh         $a0, 0x10($v0)
    /* 149D4 800241D4 1400428C */  lw         $v0, 0x14($v0)
    /* 149D8 800241D8 00000000 */  nop
    /* 149DC 800241DC 09F84000 */  jalr       $v0
    /* 149E0 800241E0 21200402 */   addu      $a0, $s0, $a0
    /* 149E4 800241E4 FF004230 */  andi       $v0, $v0, 0xFF
    /* 149E8 800241E8 40100200 */  sll        $v0, $v0, 1
    /* 149EC 800241EC 0000038E */  lw         $v1, 0x0($s0)
    /* 149F0 800241F0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 149F4 800241F4 1000B08F */  lw         $s0, 0x10($sp)
    /* 149F8 800241F8 21104300 */  addu       $v0, $v0, $v1
    /* 149FC 800241FC 00004284 */  lh         $v0, 0x0($v0)
    /* 14A00 80024200 0800E003 */  jr         $ra
    /* 14A04 80024204 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__26tListIteratorDoubleIndexed7tPlayer
