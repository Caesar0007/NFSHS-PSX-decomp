.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__14tPListIterator7tPlayer, 0x50

glabel TextValue__14tPListIterator7tPlayer
    /* 97854 800A7054 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97858 800A7058 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9785C 800A705C 21808000 */  addu       $s0, $a0, $zero
    /* 97860 800A7060 1400BFAF */  sw         $ra, 0x14($sp)
    /* 97864 800A7064 0800028E */  lw         $v0, 0x8($s0)
    /* 97868 800A7068 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 9786C 800A706C 10004484 */  lh         $a0, 0x10($v0)
    /* 97870 800A7070 1400428C */  lw         $v0, 0x14($v0)
    /* 97874 800A7074 00000000 */  nop
    /* 97878 800A7078 09F84000 */  jalr       $v0
    /* 9787C 800A707C 21200402 */   addu      $a0, $s0, $a0
    /* 97880 800A7080 FF004230 */  andi       $v0, $v0, 0xFF
    /* 97884 800A7084 40100200 */  sll        $v0, $v0, 1
    /* 97888 800A7088 0000038E */  lw         $v1, 0x0($s0)
    /* 9788C 800A708C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 97890 800A7090 1000B08F */  lw         $s0, 0x10($sp)
    /* 97894 800A7094 21104300 */  addu       $v0, $v0, $v1
    /* 97898 800A7098 00004284 */  lh         $v0, 0x0($v0)
    /* 9789C 800A709C 0800E003 */  jr         $ra
    /* 978A0 800A70A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextValue__14tPListIterator7tPlayer
