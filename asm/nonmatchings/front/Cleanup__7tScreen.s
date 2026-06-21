.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__7tScreen, 0x4C

glabel Cleanup__7tScreen
    /* 169A0 800261A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 169A4 800261A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 169A8 800261A8 21808000 */  addu       $s0, $a0, $zero
    /* 169AC 800261AC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 169B0 800261B0 6697000C */  jal        AsyncLoadPermanentShapeFile__7tScreenPc
    /* 169B4 800261B4 21280000 */   addu      $a1, $zero, $zero
    /* 169B8 800261B8 21200002 */  addu       $a0, $s0, $zero
    /* 169BC 800261BC 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 169C0 800261C0 21280000 */   addu      $a1, $zero, $zero
    /* 169C4 800261C4 21200002 */  addu       $a0, $s0, $zero
    /* 169C8 800261C8 2599000C */  jal        FreeShapes__7tScreenR17tShapeInformation
    /* 169CC 800261CC 21280002 */   addu      $a1, $s0, $zero
    /* 169D0 800261D0 21200002 */  addu       $a0, $s0, $zero
    /* 169D4 800261D4 2599000C */  jal        FreeShapes__7tScreenR17tShapeInformation
    /* 169D8 800261D8 28008524 */   addiu     $a1, $a0, 0x28
    /* 169DC 800261DC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 169E0 800261E0 1000B08F */  lw         $s0, 0x10($sp)
    /* 169E4 800261E4 0800E003 */  jr         $ra
    /* 169E8 800261E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__7tScreen
