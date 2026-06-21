.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12tDialogYesNo, 0xB8

glabel __12tDialogYesNo
    /* A28C 80019A8C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A290 80019A90 1000B0AF */  sw         $s0, 0x10($sp)
    /* A294 80019A94 1400BFAF */  sw         $ra, 0x14($sp)
    /* A298 80019A98 0898000C */  jal        __7tScreen
    /* A29C 80019A9C 21808000 */   addu      $s0, $a0, $zero
    /* A2A0 80019AA0 21100002 */  addu       $v0, $s0, $zero
    /* A2A4 80019AA4 0180033C */  lui        $v1, %hi(_vt_11tDialogBase)
    /* A2A8 80019AA8 B0056324 */  addiu      $v1, $v1, %lo(_vt_11tDialogBase)
    /* A2AC 80019AAC 600043AC */  sw         $v1, 0x60($v0)
    /* A2B0 80019AB0 20010324 */  addiu      $v1, $zero, 0x120
    /* A2B4 80019AB4 800043A4 */  sh         $v1, 0x80($v0)
    /* A2B8 80019AB8 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* A2BC 80019ABC 640043A4 */  sh         $v1, 0x64($v0)
    /* A2C0 80019AC0 0180033C */  lui        $v1, %hi(_vt_20tDialogMessageString)
    /* A2C4 80019AC4 F0046324 */  addiu      $v1, $v1, %lo(_vt_20tDialogMessageString)
    /* A2C8 80019AC8 600043AC */  sw         $v1, 0x60($v0)
    /* A2CC 80019ACC 80000324 */  addiu      $v1, $zero, 0x80
    /* A2D0 80019AD0 8C0043AC */  sw         $v1, 0x8C($v0)
    /* A2D4 80019AD4 0180033C */  lui        $v1, %hi(D_800103D0)
    /* A2D8 80019AD8 D0036324 */  addiu      $v1, $v1, %lo(D_800103D0)
    /* A2DC 80019ADC 600043AC */  sw         $v1, 0x60($v0)
    /* A2E0 80019AE0 0180033C */  lui        $v1, %hi(_vt_12tDialogYesNo)
    /* A2E4 80019AE4 70036324 */  addiu      $v1, $v1, %lo(_vt_12tDialogYesNo)
    /* A2E8 80019AE8 700040AC */  sw         $zero, 0x70($v0)
    /* A2EC 80019AEC 6E0040A4 */  sh         $zero, 0x6E($v0)
    /* A2F0 80019AF0 820040A4 */  sh         $zero, 0x82($v0)
    /* A2F4 80019AF4 7E0040A4 */  sh         $zero, 0x7E($v0)
    /* A2F8 80019AF8 7C0040A4 */  sh         $zero, 0x7C($v0)
    /* A2FC 80019AFC 6C0040A4 */  sh         $zero, 0x6C($v0)
    /* A300 80019B00 6A0040A4 */  sh         $zero, 0x6A($v0)
    /* A304 80019B04 680040A4 */  sh         $zero, 0x68($v0)
    /* A308 80019B08 660040A4 */  sh         $zero, 0x66($v0)
    /* A30C 80019B0C 880040A4 */  sh         $zero, 0x88($v0)
    /* A310 80019B10 780040AC */  sw         $zero, 0x78($v0)
    /* A314 80019B14 940040AC */  sw         $zero, 0x94($v0)
    /* A318 80019B18 840040AC */  sw         $zero, 0x84($v0)
    /* A31C 80019B1C 780040AC */  sw         $zero, 0x78($v0)
    /* A320 80019B20 780040AC */  sw         $zero, 0x78($v0)
    /* A324 80019B24 9C0040AC */  sw         $zero, 0x9C($v0)
    /* A328 80019B28 600043AC */  sw         $v1, 0x60($v0)
    /* A32C 80019B2C 8A0040A4 */  sh         $zero, 0x8A($v0)
    /* A330 80019B30 980040AC */  sw         $zero, 0x98($v0)
    /* A334 80019B34 1400BF8F */  lw         $ra, 0x14($sp)
    /* A338 80019B38 1000B08F */  lw         $s0, 0x10($sp)
    /* A33C 80019B3C 0800E003 */  jr         $ra
    /* A340 80019B40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __12tDialogYesNo
