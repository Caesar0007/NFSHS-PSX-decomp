.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tScreenPinkSlipsCarSelect, 0x44

glabel ___25tScreenPinkSlipsCarSelect
    /* 2FED0 8003F6D0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2FED4 8003F6D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FED8 8003F6D8 21808000 */  addu       $s0, $a0, $zero
    /* 2FEDC 8003F6DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2FEE0 8003F6E0 2188A000 */  addu       $s1, $a1, $zero
    /* 2FEE4 8003F6E4 A0030426 */  addiu      $a0, $s0, 0x3A0
    /* 2FEE8 8003F6E8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2FEEC 8003F6EC 1E98000C */  jal        ___7tScreen
    /* 2FEF0 8003F6F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 2FEF4 8003F6F4 21200002 */  addu       $a0, $s0, $zero
    /* 2FEF8 8003F6F8 24EB000C */  jal        ___16tScreenCarSelect
    /* 2FEFC 8003F6FC 21282002 */   addu      $a1, $s1, $zero
    /* 2FF00 8003F700 1800BF8F */  lw         $ra, 0x18($sp)
    /* 2FF04 8003F704 1400B18F */  lw         $s1, 0x14($sp)
    /* 2FF08 8003F708 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FF0C 8003F70C 0800E003 */  jr         $ra
    /* 2FF10 8003F710 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___25tScreenPinkSlipsCarSelect
