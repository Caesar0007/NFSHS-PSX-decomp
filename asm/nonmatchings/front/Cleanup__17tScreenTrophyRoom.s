.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__17tScreenTrophyRoom, 0x30

glabel Cleanup__17tScreenTrophyRoom
    /* 312E8 80040AE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 312EC 80040AEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 312F0 80040AF0 21808000 */  addu       $s0, $a0, $zero
    /* 312F4 80040AF4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 312F8 80040AF8 2599000C */  jal        FreeShapes__7tScreenR17tShapeInformation
    /* 312FC 80040AFC 64000526 */   addiu     $a1, $s0, 0x64
    /* 31300 80040B00 6898000C */  jal        Cleanup__7tScreen
    /* 31304 80040B04 21200002 */   addu      $a0, $s0, $zero
    /* 31308 80040B08 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3130C 80040B0C 1000B08F */  lw         $s0, 0x10($sp)
    /* 31310 80040B10 0800E003 */  jr         $ra
    /* 31314 80040B14 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__17tScreenTrophyRoom
