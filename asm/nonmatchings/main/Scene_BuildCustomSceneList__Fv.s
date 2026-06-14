.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Scene_BuildCustomSceneList__Fv, 0xA0

glabel Scene_BuildCustomSceneList__Fv
    /* A67E4 800B5FE4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A67E8 800B5FE8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* A67EC 800B5FEC 1800B2AF */  sw         $s2, 0x18($sp)
    /* A67F0 800B5FF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* A67F4 800B5FF4 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* A67F8 800B5FF8 1000B0AF */   sw        $s0, 0x10($sp)
    /* A67FC 800B5FFC BC0E828F */  lw         $v0, %gp_rel(gGameSceneList)($gp)
    /* A6800 800B6000 00000000 */  nop
    /* A6804 800B6004 18004010 */  beqz       $v0, .L800B6068
    /* A6808 800B6008 FFFF1224 */   addiu     $s2, $zero, -0x1
    /* A680C 800B600C 10005124 */  addiu      $s1, $v0, 0x10
    /* A6810 800B6010 0800528C */  lw         $s2, 0x8($v0)
    /* A6814 800B6014 0400428C */  lw         $v0, 0x4($v0)
    /* A6818 800B6018 1480013C */  lui        $at, %hi(Object_customSliceNum)
    /* A681C 800B601C D4D232AC */  sw         $s2, %lo(Object_customSliceNum)($at)
    /* A6820 800B6020 11004018 */  blez       $v0, .L800B6068
    /* A6824 800B6024 21800000 */   addu      $s0, $zero, $zero
  .L800B6028:
    /* A6828 800B6028 0000238E */  lw         $v1, 0x0($s1)
    /* A682C 800B602C 00000000 */  nop
    /* A6830 800B6030 03006228 */  slti       $v0, $v1, 0x3
    /* A6834 800B6034 05004010 */  beqz       $v0, .L800B604C
    /* A6838 800B6038 00000000 */   nop
    /* A683C 800B603C 03006004 */  bltz       $v1, .L800B604C
    /* A6840 800B6040 21202002 */   addu      $a0, $s1, $zero
    /* A6844 800B6044 8196020C */  jal        Object_AddCustomObject__FP9SceneElemi
    /* A6848 800B6048 01000524 */   addiu     $a1, $zero, 0x1
  .L800B604C:
    /* A684C 800B604C BC0E828F */  lw         $v0, %gp_rel(gGameSceneList)($gp)
    /* A6850 800B6050 00000000 */  nop
    /* A6854 800B6054 0400428C */  lw         $v0, 0x4($v0)
    /* A6858 800B6058 01001026 */  addiu      $s0, $s0, 0x1
    /* A685C 800B605C 2A100202 */  slt        $v0, $s0, $v0
    /* A6860 800B6060 F1FF4014 */  bnez       $v0, .L800B6028
    /* A6864 800B6064 5C003126 */   addiu     $s1, $s1, 0x5C
  .L800B6068:
    /* A6868 800B6068 21104002 */  addu       $v0, $s2, $zero
    /* A686C 800B606C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* A6870 800B6070 1800B28F */  lw         $s2, 0x18($sp)
    /* A6874 800B6074 1400B18F */  lw         $s1, 0x14($sp)
    /* A6878 800B6078 1000B08F */  lw         $s0, 0x10($sp)
    /* A687C 800B607C 0800E003 */  jr         $ra
    /* A6880 800B6080 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Scene_BuildCustomSceneList__Fv
