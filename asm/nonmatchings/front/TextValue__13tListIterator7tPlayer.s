.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__13tListIterator7tPlayer, 0x50

glabel TextValue__13tListIterator7tPlayer
    /* 1463C 80023E3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14640 80023E40 1000B0AF */  sw         $s0, 0x10($sp)
    /* 14644 80023E44 21808000 */  addu       $s0, $a0, $zero
    /* 14648 80023E48 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1464C 80023E4C 0C00028E */  lw         $v0, 0xC($s0)
    /* 14650 80023E50 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 14654 80023E54 10004484 */  lh         $a0, 0x10($v0)
    /* 14658 80023E58 1400428C */  lw         $v0, 0x14($v0)
    /* 1465C 80023E5C 00000000 */  nop
    /* 14660 80023E60 09F84000 */  jalr       $v0
    /* 14664 80023E64 21200402 */   addu      $a0, $s0, $a0
    /* 14668 80023E68 FF004230 */  andi       $v0, $v0, 0xFF
    /* 1466C 80023E6C 40100200 */  sll        $v0, $v0, 1
    /* 14670 80023E70 0000038E */  lw         $v1, 0x0($s0)
    /* 14674 80023E74 1400BF8F */  lw         $ra, 0x14($sp)
    /* 14678 80023E78 1000B08F */  lw         $s0, 0x10($sp)
    /* 1467C 80023E7C 21104300 */  addu       $v0, $v0, $v1
    /* 14680 80023E80 00004284 */  lh         $v0, 0x0($v0)
    /* 14684 80023E84 0800E003 */  jr         $ra
    /* 14688 80023E88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__13tListIterator7tPlayer
