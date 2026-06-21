.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __7tScreen, 0x58

glabel __7tScreen
    /* 16820 80026020 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 16824 80026024 1000B0AF */  sw         $s0, 0x10($sp)
    /* 16828 80026028 21808000 */  addu       $s0, $a0, $zero
    /* 1682C 8002602C 21280002 */  addu       $a1, $s0, $zero
    /* 16830 80026030 21300000 */  addu       $a2, $zero, $zero
    /* 16834 80026034 0180023C */  lui        $v0, %hi(_vt_7tScreen)
    /* 16838 80026038 18144224 */  addiu      $v0, $v0, %lo(_vt_7tScreen)
    /* 1683C 8002603C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 16840 80026040 600002AE */  sw         $v0, 0x60($s0)
    /* 16844 80026044 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 16848 80026048 000000AE */   sw        $zero, 0x0($s0)
    /* 1684C 8002604C 21200002 */  addu       $a0, $s0, $zero
    /* 16850 80026050 28000526 */  addiu      $a1, $s0, 0x28
    /* 16854 80026054 21300000 */  addu       $a2, $zero, $zero
    /* 16858 80026058 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 1685C 8002605C 280000AE */   sw        $zero, 0x28($s0)
    /* 16860 80026060 21100002 */  addu       $v0, $s0, $zero
    /* 16864 80026064 5C0000A6 */  sh         $zero, 0x5C($s0)
    /* 16868 80026068 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1686C 8002606C 1000B08F */  lw         $s0, 0x10($sp)
    /* 16870 80026070 0800E003 */  jr         $ra
    /* 16874 80026074 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __7tScreen
