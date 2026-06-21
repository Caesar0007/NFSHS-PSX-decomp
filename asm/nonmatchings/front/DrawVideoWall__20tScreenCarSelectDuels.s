.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoWall__20tScreenCarSelectDuels, 0x158

glabel DrawVideoWall__20tScreenCarSelectDuels
    /* 2DB64 8003D364 F8FEBD27 */  addiu      $sp, $sp, -0x108
    /* 2DB68 8003D368 F800B2AF */  sw         $s2, 0xF8($sp)
    /* 2DB6C 8003D36C 21908000 */  addu       $s2, $a0, $zero
    /* 2DB70 8003D370 F000B0AF */  sw         $s0, 0xF0($sp)
    /* 2DB74 8003D374 2180A000 */  addu       $s0, $a1, $zero
    /* 2DB78 8003D378 2000A527 */  addiu      $a1, $sp, 0x20
    /* 2DB7C 8003D37C 0001BFAF */  sw         $ra, 0x100($sp)
    /* 2DB80 8003D380 FC00B3AF */  sw         $s3, 0xFC($sp)
    /* 2DB84 8003D384 F400B1AF */  sw         $s1, 0xF4($sp)
    /* 2DB88 8003D388 6000428E */  lw         $v0, 0x60($s2)
    /* 2DB8C 8003D38C 21880000 */  addu       $s1, $zero, $zero
    /* 2DB90 8003D390 68004484 */  lh         $a0, 0x68($v0)
    /* 2DB94 8003D394 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2DB98 8003D398 00000000 */  nop
    /* 2DB9C 8003D39C 09F84000 */  jalr       $v0
    /* 2DBA0 8003D3A0 21204402 */   addu      $a0, $s2, $a0
    /* 2DBA4 8003D3A4 21984000 */  addu       $s3, $v0, $zero
    /* 2DBA8 8003D3A8 00841000 */  sll        $s0, $s0, 16
    /* 2DBAC 8003D3AC 03841000 */  sra        $s0, $s0, 16
    /* 2DBB0 8003D3B0 00241100 */  sll        $a0, $s1, 16
  .L8003D3B4:
    /* 2DBB4 8003D3B4 03240400 */  sra        $a0, $a0, 16
    /* 2DBB8 8003D3B8 21280000 */  addu       $a1, $zero, $zero
    /* 2DBBC 8003D3BC 2130A000 */  addu       $a2, $a1, $zero
    /* 2DBC0 8003D3C0 5C004286 */  lh         $v0, 0x5C($s2)
    /* 2DBC4 8003D3C4 23381000 */  negu       $a3, $s0
    /* 2DBC8 8003D3C8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2DBCC 8003D3CC 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2DBD0 8003D3D0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2DBD4 8003D3D4 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2DBD8 8003D3D8 01002226 */  addiu      $v0, $s1, 0x1
    /* 2DBDC 8003D3DC 21884000 */  addu       $s1, $v0, $zero
    /* 2DBE0 8003D3E0 00140200 */  sll        $v0, $v0, 16
    /* 2DBE4 8003D3E4 03140200 */  sra        $v0, $v0, 16
    /* 2DBE8 8003D3E8 0C004228 */  slti       $v0, $v0, 0xC
    /* 2DBEC 8003D3EC F1FF4014 */  bnez       $v0, .L8003D3B4
    /* 2DBF0 8003D3F0 00241100 */   sll       $a0, $s1, 16
    /* 2DBF4 8003D3F4 5C004286 */  lh         $v0, 0x5C($s2)
    /* 2DBF8 8003D3F8 00000000 */  nop
    /* 2DBFC 8003D3FC 0B004018 */  blez       $v0, .L8003D42C
    /* 2DC00 8003D400 00000000 */   nop
    /* 2DC04 8003D404 5400428E */  lw         $v0, 0x54($s2)
    /* 2DC08 8003D408 00000000 */  nop
    /* 2DC0C 8003D40C 07004010 */  beqz       $v0, .L8003D42C
    /* 2DC10 8003D410 00000000 */   nop
    /* 2DC14 8003D414 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 2DC18 8003D418 04034426 */   addiu     $a0, $s2, 0x304
    /* 2DC1C 8003D41C 21204002 */  addu       $a0, $s2, $zero
    /* 2DC20 8003D420 21280000 */  addu       $a1, $zero, $zero
    /* 2DC24 8003D424 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2DC28 8003D428 2130A000 */   addu      $a2, $a1, $zero
  .L8003D42C:
    /* 2DC2C 8003D42C 3A004296 */  lhu        $v0, 0x3A($s2)
    /* 2DC30 8003D430 00000000 */  nop
    /* 2DC34 8003D434 01004230 */  andi       $v0, $v0, 0x1
    /* 2DC38 8003D438 0E004010 */  beqz       $v0, .L8003D474
    /* 2DC3C 8003D43C 04035026 */   addiu     $s0, $s2, 0x304
    /* 2DC40 8003D440 8403428E */  lw         $v0, 0x384($s2)
    /* 2DC44 8003D444 00000000 */  nop
    /* 2DC48 8003D448 0A004014 */  bnez       $v0, .L8003D474
    /* 2DC4C 8003D44C 00000000 */   nop
    /* 2DC50 8003D450 21200002 */  addu       $a0, $s0, $zero
    /* 2DC54 8003D454 06000524 */  addiu      $a1, $zero, 0x6
    /* 2DC58 8003D458 72DA000C */  jal        SetOffset__10tVideoWallss
    /* 2DC5C 8003D45C 21300000 */   addu      $a2, $zero, $zero
    /* 2DC60 8003D460 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2DC64 8003D464 21200002 */   addu      $a0, $s0, $zero
    /* 2DC68 8003D468 01000224 */  addiu      $v0, $zero, 0x1
    /* 2DC6C 8003D46C 840342AE */  sw         $v0, 0x384($s2)
    /* 2DC70 8003D470 04035026 */  addiu      $s0, $s2, 0x304
  .L8003D474:
    /* 2DC74 8003D474 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 2DC78 8003D478 21200002 */   addu      $a0, $s0, $zero
    /* 2DC7C 8003D47C 21200002 */  addu       $a0, $s0, $zero
    /* 2DC80 8003D480 002C1300 */  sll        $a1, $s3, 16
    /* 2DC84 8003D484 77DA000C */  jal        SetValid__10tVideoWalls
    /* 2DC88 8003D488 032C0500 */   sra       $a1, $a1, 16
    /* 2DC8C 8003D48C 2700A593 */  lbu        $a1, 0x27($sp)
    /* 2DC90 8003D490 75DA000C */  jal        SetAvailable__10tVideoWalls
    /* 2DC94 8003D494 21200002 */   addu      $a0, $s0, $zero
    /* 2DC98 8003D498 EDDA000C */  jal        Draw__10tVideoWall
    /* 2DC9C 8003D49C 21200002 */   addu      $a0, $s0, $zero
    /* 2DCA0 8003D4A0 0001BF8F */  lw         $ra, 0x100($sp)
    /* 2DCA4 8003D4A4 FC00B38F */  lw         $s3, 0xFC($sp)
    /* 2DCA8 8003D4A8 F800B28F */  lw         $s2, 0xF8($sp)
    /* 2DCAC 8003D4AC F400B18F */  lw         $s1, 0xF4($sp)
    /* 2DCB0 8003D4B0 F000B08F */  lw         $s0, 0xF0($sp)
    /* 2DCB4 8003D4B4 0800E003 */  jr         $ra
    /* 2DCB8 8003D4B8 0801BD27 */   addiu     $sp, $sp, 0x108
endlabel DrawVideoWall__20tScreenCarSelectDuels
