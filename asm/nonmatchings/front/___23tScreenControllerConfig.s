.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tScreenControllerConfig, 0x44

glabel ___23tScreenControllerConfig
    /* 3610C 8004590C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 36110 80045910 1000B0AF */  sw         $s0, 0x10($sp)
    /* 36114 80045914 21808000 */  addu       $s0, $a0, $zero
    /* 36118 80045918 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3611C 8004591C 2188A000 */  addu       $s1, $a1, $zero
    /* 36120 80045920 B8000426 */  addiu      $a0, $s0, 0xB8
    /* 36124 80045924 1800BFAF */  sw         $ra, 0x18($sp)
    /* 36128 80045928 1E98000C */  jal        ___7tScreen
    /* 3612C 8004592C 02000524 */   addiu     $a1, $zero, 0x2
    /* 36130 80045930 21200002 */  addu       $a0, $s0, $zero
    /* 36134 80045934 1E98000C */  jal        ___7tScreen
    /* 36138 80045938 21282002 */   addu      $a1, $s1, $zero
    /* 3613C 8004593C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 36140 80045940 1400B18F */  lw         $s1, 0x14($sp)
    /* 36144 80045944 1000B08F */  lw         $s0, 0x10($sp)
    /* 36148 80045948 0800E003 */  jr         $ra
    /* 3614C 8004594C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___23tScreenControllerConfig
