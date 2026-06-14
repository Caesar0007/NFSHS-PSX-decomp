.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__21tPListIteratorIndexed7tPlayer, 0x50

glabel TextValue__21tPListIteratorIndexed7tPlayer
    /* 97A40 800A7240 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97A44 800A7244 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97A48 800A7248 21808000 */  addu       $s0, $a0, $zero
    /* 97A4C 800A724C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 97A50 800A7250 0800028E */  lw         $v0, 0x8($s0)
    /* 97A54 800A7254 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 97A58 800A7258 10004484 */  lh         $a0, 0x10($v0)
    /* 97A5C 800A725C 1400428C */  lw         $v0, 0x14($v0)
    /* 97A60 800A7260 00000000 */  nop
    /* 97A64 800A7264 09F84000 */  jalr       $v0
    /* 97A68 800A7268 21200402 */   addu      $a0, $s0, $a0
    /* 97A6C 800A726C FF004230 */  andi       $v0, $v0, 0xFF
    /* 97A70 800A7270 40100200 */  sll        $v0, $v0, 1
    /* 97A74 800A7274 0000038E */  lw         $v1, 0x0($s0)
    /* 97A78 800A7278 1400BF8F */  lw         $ra, 0x14($sp)
    /* 97A7C 800A727C 1000B08F */  lw         $s0, 0x10($sp)
    /* 97A80 800A7280 21104300 */  addu       $v0, $v0, $v1
    /* 97A84 800A7284 00004284 */  lh         $v0, 0x0($v0)
    /* 97A88 800A7288 0800E003 */  jr         $ra
    /* 97A8C 800A728C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__21tPListIteratorIndexed7tPlayer
