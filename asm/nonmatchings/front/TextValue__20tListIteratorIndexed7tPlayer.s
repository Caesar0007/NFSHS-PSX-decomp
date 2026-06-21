.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__20tListIteratorIndexed7tPlayer, 0x50

glabel TextValue__20tListIteratorIndexed7tPlayer
    /* 147F0 80023FF0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 147F4 80023FF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 147F8 80023FF8 21808000 */  addu       $s0, $a0, $zero
    /* 147FC 80023FFC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 14800 80024000 0C00028E */  lw         $v0, 0xC($s0)
    /* 14804 80024004 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 14808 80024008 10004484 */  lh         $a0, 0x10($v0)
    /* 1480C 8002400C 1400428C */  lw         $v0, 0x14($v0)
    /* 14810 80024010 00000000 */  nop
    /* 14814 80024014 09F84000 */  jalr       $v0
    /* 14818 80024018 21200402 */   addu      $a0, $s0, $a0
    /* 1481C 8002401C FF004230 */  andi       $v0, $v0, 0xFF
    /* 14820 80024020 40100200 */  sll        $v0, $v0, 1
    /* 14824 80024024 0000038E */  lw         $v1, 0x0($s0)
    /* 14828 80024028 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1482C 8002402C 1000B08F */  lw         $s0, 0x10($sp)
    /* 14830 80024030 21104300 */  addu       $v0, $v0, $v1
    /* 14834 80024034 00004284 */  lh         $v0, 0x0($v0)
    /* 14838 80024038 0800E003 */  jr         $ra
    /* 1483C 8002403C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__20tListIteratorIndexed7tPlayer
