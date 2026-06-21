.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeVideoWall__16tScreenCarSelect, 0xB8

glabel InitializeVideoWall__16tScreenCarSelect
    /* 2C4D0 8003BCD0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 2C4D4 8003BCD4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 2C4D8 8003BCD8 21888000 */  addu       $s1, $a0, $zero
    /* 2C4DC 8003BCDC 2000B0AF */  sw         $s0, 0x20($sp)
    /* 2C4E0 8003BCE0 04033026 */  addiu      $s0, $s1, 0x304
    /* 2C4E4 8003BCE4 21200002 */  addu       $a0, $s0, $zero
    /* 2C4E8 8003BCE8 24012526 */  addiu      $a1, $s1, 0x124
    /* 2C4EC 8003BCEC 0A000224 */  addiu      $v0, $zero, 0xA
    /* 2C4F0 8003BCF0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2C4F4 8003BCF4 0580023C */  lui        $v0, %hi(D_80051F84)
    /* 2C4F8 8003BCF8 841F4224 */  addiu      $v0, $v0, %lo(D_80051F84)
    /* 2C4FC 8003BCFC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2C500 8003BD00 96000224 */  addiu      $v0, $zero, 0x96
    /* 2C504 8003BD04 2800BFAF */  sw         $ra, 0x28($sp)
    /* 2C508 8003BD08 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2C50C 8003BD0C 2800268E */  lw         $a2, 0x28($s1)
    /* 2C510 8003BD10 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 2C514 8003BD14 21380000 */   addu      $a3, $zero, $zero
    /* 2C518 8003BD18 21200002 */  addu       $a0, $s0, $zero
    /* 2C51C 8003BD1C F8000524 */  addiu      $a1, $zero, 0xF8
    /* 2C520 8003BD20 40010624 */  addiu      $a2, $zero, 0x140
    /* 2C524 8003BD24 63DA000C */  jal        SetAvailableText__10tVideoWallsss
    /* 2C528 8003BD28 50000724 */   addiu     $a3, $zero, 0x50
    /* 2C52C 8003BD2C 21200002 */  addu       $a0, $s0, $zero
    /* 2C530 8003BD30 1C000524 */  addiu      $a1, $zero, 0x1C
    /* 2C534 8003BD34 0A000624 */  addiu      $a2, $zero, 0xA
    /* 2C538 8003BD38 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 2C53C 8003BD3C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2C540 8003BD40 0000228E */  lw         $v0, 0x0($s1)
    /* 2C544 8003BD44 36010724 */  addiu      $a3, $zero, 0x136
    /* 2C548 8003BD48 6ADA000C */  jal        SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
    /* 2C54C 8003BD4C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 2C550 8003BD50 3A002296 */  lhu        $v0, 0x3A($s1)
    /* 2C554 8003BD54 00000000 */  nop
    /* 2C558 8003BD58 01004230 */  andi       $v0, $v0, 0x1
    /* 2C55C 8003BD5C 05004010 */  beqz       $v0, .L8003BD74
    /* 2C560 8003BD60 00000000 */   nop
    /* 2C564 8003BD64 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2C568 8003BD68 21200002 */   addu      $a0, $s0, $zero
    /* 2C56C 8003BD6C 01000224 */  addiu      $v0, $zero, 0x1
    /* 2C570 8003BD70 840322AE */  sw         $v0, 0x384($s1)
  .L8003BD74:
    /* 2C574 8003BD74 2800BF8F */  lw         $ra, 0x28($sp)
    /* 2C578 8003BD78 2400B18F */  lw         $s1, 0x24($sp)
    /* 2C57C 8003BD7C 2000B08F */  lw         $s0, 0x20($sp)
    /* 2C580 8003BD80 0800E003 */  jr         $ra
    /* 2C584 8003BD84 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InitializeVideoWall__16tScreenCarSelect
