.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetRuleSettings, 0x1C0

glabel iSPCH_GetRuleSettings
    /* FBBCC 8010B3CC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* FBBD0 8010B3D0 4000B6AF */  sw         $s6, 0x40($sp)
    /* FBBD4 8010B3D4 21B00000 */  addu       $s6, $zero, $zero
    /* FBBD8 8010B3D8 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* FBBDC 8010B3DC 4800BEAF */  sw         $fp, 0x48($sp)
    /* FBBE0 8010B3E0 4400B7AF */  sw         $s7, 0x44($sp)
    /* FBBE4 8010B3E4 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* FBBE8 8010B3E8 3800B4AF */  sw         $s4, 0x38($sp)
    /* FBBEC 8010B3EC 3400B3AF */  sw         $s3, 0x34($sp)
    /* FBBF0 8010B3F0 3000B2AF */  sw         $s2, 0x30($sp)
    /* FBBF4 8010B3F4 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* FBBF8 8010B3F8 2800B0AF */  sw         $s0, 0x28($sp)
    /* FBBFC 8010B3FC 5000A4AF */  sw         $a0, 0x50($sp)
    /* FBC00 8010B400 5400A5AF */  sw         $a1, 0x54($sp)
    /* FBC04 8010B404 5800A6AF */  sw         $a2, 0x58($sp)
    /* FBC08 8010B408 07008780 */  lb         $a3, 0x7($a0)
    /* FBC0C 8010B40C 21A8C002 */  addu       $s5, $s6, $zero
    /* FBC10 8010B410 502C040C */  jal        iSPCH_GetRuleDataAddr
    /* FBC14 8010B414 2400A7AF */   sw        $a3, 0x24($sp)
    /* FBC18 8010B418 5400A78F */  lw         $a3, 0x54($sp)
    /* FBC1C 8010B41C 01001424 */  addiu      $s4, $zero, 0x1
    /* FBC20 8010B420 2000A2AF */  sw         $v0, 0x20($sp)
    /* FBC24 8010B424 0400F724 */  addiu      $s7, $a3, 0x4
  .L8010B428:
    /* FBC28 8010B428 2400A78F */  lw         $a3, 0x24($sp)
    /* FBC2C 8010B42C 00000000 */  nop
    /* FBC30 8010B430 4300E018 */  blez       $a3, .L8010B540
    /* FBC34 8010B434 21900000 */   addu      $s2, $zero, $zero
    /* FBC38 8010B438 21F0E002 */  addu       $fp, $s7, $zero
    /* FBC3C 8010B43C 2000B18F */  lw         $s1, 0x20($sp)
  .L8010B440:
    /* FBC40 8010B440 00000000 */  nop
    /* FBC44 8010B444 00002292 */  lbu        $v0, 0x0($s1)
    /* FBC48 8010B448 00000000 */  nop
    /* FBC4C 8010B44C 1000A2AF */  sw         $v0, 0x10($sp)
    /* FBC50 8010B450 01002392 */  lbu        $v1, 0x1($s1)
    /* FBC54 8010B454 21980000 */  addu       $s3, $zero, $zero
    /* FBC58 8010B458 0F006330 */  andi       $v1, $v1, 0xF
    /* FBC5C 8010B45C 1400A3AF */  sw         $v1, 0x14($sp)
    /* FBC60 8010B460 01002292 */  lbu        $v0, 0x1($s1)
    /* FBC64 8010B464 00000000 */  nop
    /* FBC68 8010B468 02110200 */  srl        $v0, $v0, 4
    /* FBC6C 8010B46C 1800A2AF */  sw         $v0, 0x18($sp)
    /* FBC70 8010B470 0C000224 */  addiu      $v0, $zero, 0xC
    /* FBC74 8010B474 05008216 */  bne        $s4, $v0, .L8010B48C
    /* FBC78 8010B478 21206000 */   addu      $a0, $v1, $zero
    /* FBC7C 8010B47C 2B008014 */  bnez       $a0, .L8010B52C
    /* FBC80 8010B480 21300000 */   addu      $a2, $zero, $zero
    /* FBC84 8010B484 262D0408 */  j          .L8010B498
    /* FBC88 8010B488 07000224 */   addiu     $v0, $zero, 0x7
  .L8010B48C:
    /* FBC8C 8010B48C 27009414 */  bne        $a0, $s4, .L8010B52C
    /* FBC90 8010B490 07000224 */   addiu     $v0, $zero, 0x7
    /* FBC94 8010B494 0000C68F */  lw         $a2, 0x0($fp)
  .L8010B498:
    /* FBC98 8010B498 23105200 */  subu       $v0, $v0, $s2
    /* FBC9C 8010B49C 01000324 */  addiu      $v1, $zero, 0x1
    /* FBCA0 8010B4A0 04804300 */  sllv       $s0, $v1, $v0
    /* FBCA4 8010B4A4 04000324 */  addiu      $v1, $zero, 0x4
    /* FBCA8 8010B4A8 1800A28F */  lw         $v0, 0x18($sp)
    /* FBCAC 8010B4AC 1000A58F */  lw         $a1, 0x10($sp)
    /* FBCB0 8010B4B0 0A004314 */  bne        $v0, $v1, .L8010B4DC
    /* FBCB4 8010B4B4 1380023C */   lui       $v0, %hi(gSentenceRuleTest)
    /* FBCB8 8010B4B8 5400A78F */  lw         $a3, 0x54($sp)
    /* FBCBC 8010B4BC 80100400 */  sll        $v0, $a0, 2
    /* FBCC0 8010B4C0 21104700 */  addu       $v0, $v0, $a3
    /* FBCC4 8010B4C4 0000428C */  lw         $v0, 0x0($v0)
    /* FBCC8 8010B4C8 00000000 */  nop
    /* FBCCC 8010B4CC 16004010 */  beqz       $v0, .L8010B528
    /* FBCD0 8010B4D0 00000000 */   nop
  .L8010B4D4:
    /* FBCD4 8010B4D4 4A2D0408 */  j          .L8010B528
    /* FBCD8 8010B4D8 21980002 */   addu      $s3, $s0, $zero
  .L8010B4DC:
    /* FBCDC 8010B4DC 9870428C */  lw         $v0, %lo(gSentenceRuleTest)($v0)
    /* FBCE0 8010B4E0 00000000 */  nop
    /* FBCE4 8010B4E4 08004010 */  beqz       $v0, .L8010B508
    /* FBCE8 8010B4E8 00000000 */   nop
    /* FBCEC 8010B4EC 5000A78F */  lw         $a3, 0x50($sp)
    /* FBCF0 8010B4F0 00000000 */  nop
    /* FBCF4 8010B4F4 0000E494 */  lhu        $a0, 0x0($a3)
    /* FBCF8 8010B4F8 09F84000 */  jalr       $v0
    /* FBCFC 8010B4FC 00000000 */   nop
    /* FBD00 8010B500 432D0408 */  j          .L8010B50C
    /* FBD04 8010B504 00000000 */   nop
  .L8010B508:
    /* FBD08 8010B508 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8010B50C:
    /* FBD0C 8010B50C 03004014 */  bnez       $v0, .L8010B51C
    /* FBD10 8010B510 00000000 */   nop
    /* FBD14 8010B514 4A2D0408 */  j          .L8010B528
    /* FBD18 8010B518 21980000 */   addu      $s3, $zero, $zero
  .L8010B51C:
    /* FBD1C 8010B51C EDFF401C */  bgtz       $v0, .L8010B4D4
    /* FBD20 8010B520 00000000 */   nop
    /* FBD24 8010B524 25A8B002 */  or         $s5, $s5, $s0
  .L8010B528:
    /* FBD28 8010B528 25B0D302 */  or         $s6, $s6, $s3
  .L8010B52C:
    /* FBD2C 8010B52C 2400A78F */  lw         $a3, 0x24($sp)
    /* FBD30 8010B530 01005226 */  addiu      $s2, $s2, 0x1
    /* FBD34 8010B534 2A104702 */  slt        $v0, $s2, $a3
    /* FBD38 8010B538 C1FF4014 */  bnez       $v0, .L8010B440
    /* FBD3C 8010B53C 02003126 */   addiu     $s1, $s1, 0x2
  .L8010B540:
    /* FBD40 8010B540 01009426 */  addiu      $s4, $s4, 0x1
    /* FBD44 8010B544 0D00822A */  slti       $v0, $s4, 0xD
    /* FBD48 8010B548 B7FF4014 */  bnez       $v0, .L8010B428
    /* FBD4C 8010B54C 0400F726 */   addiu     $s7, $s7, 0x4
    /* FBD50 8010B550 5800A78F */  lw         $a3, 0x58($sp)
    /* FBD54 8010B554 FF00C232 */  andi       $v0, $s6, 0xFF
    /* FBD58 8010B558 0000F5A0 */  sb         $s5, 0x0($a3)
    /* FBD5C 8010B55C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* FBD60 8010B560 4800BE8F */  lw         $fp, 0x48($sp)
    /* FBD64 8010B564 4400B78F */  lw         $s7, 0x44($sp)
    /* FBD68 8010B568 4000B68F */  lw         $s6, 0x40($sp)
    /* FBD6C 8010B56C 3C00B58F */  lw         $s5, 0x3C($sp)
    /* FBD70 8010B570 3800B48F */  lw         $s4, 0x38($sp)
    /* FBD74 8010B574 3400B38F */  lw         $s3, 0x34($sp)
    /* FBD78 8010B578 3000B28F */  lw         $s2, 0x30($sp)
    /* FBD7C 8010B57C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* FBD80 8010B580 2800B08F */  lw         $s0, 0x28($sp)
    /* FBD84 8010B584 0800E003 */  jr         $ra
    /* FBD88 8010B588 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel iSPCH_GetRuleSettings
