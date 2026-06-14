.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseCops__15AIHigh_BTC_Perp, 0xC4

glabel ReleaseCops__15AIHigh_BTC_Perp
    /* 4FEB4 8005F6B4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 4FEB8 8005F6B8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4FEBC 8005F6BC 21908000 */  addu       $s2, $a0, $zero
    /* 4FEC0 8005F6C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4FEC4 8005F6C4 21880000 */  addu       $s1, $zero, $zero
    /* 4FEC8 8005F6C8 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4FECC 8005F6CC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4FED0 8005F6D0 38CD5324 */  addiu      $s3, $v0, %lo(highLevelAIObjs)
    /* 4FED4 8005F6D4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4FED8 8005F6D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4FEDC 8005F6DC DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 4FEE0 8005F6E0 2000BFAF */  sw         $ra, 0x20($sp)
  .L8005F6E4:
    /* 4FEE4 8005F6E4 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4FEE8 8005F6E8 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4FEEC 8005F6EC 00000000 */  nop
    /* 4FEF0 8005F6F0 2A102202 */  slt        $v0, $s1, $v0
    /* 4FEF4 8005F6F4 16004010 */  beqz       $v0, .L8005F750
    /* 4FEF8 8005F6F8 00000000 */   nop
    /* 4FEFC 8005F6FC 0000038E */  lw         $v1, 0x0($s0)
    /* 4FF00 8005F700 00000000 */  nop
    /* 4FF04 8005F704 6002628C */  lw         $v0, 0x260($v1)
    /* 4FF08 8005F708 00000000 */  nop
    /* 4FF0C 8005F70C 00024230 */  andi       $v0, $v0, 0x200
    /* 4FF10 8005F710 0C004010 */  beqz       $v0, .L8005F744
    /* 4FF14 8005F714 00000000 */   nop
    /* 4FF18 8005F718 91006290 */  lbu        $v0, 0x91($v1)
    /* 4FF1C 8005F71C 00000000 */  nop
    /* 4FF20 8005F720 08004010 */  beqz       $v0, .L8005F744
    /* 4FF24 8005F724 00000000 */   nop
    /* 4FF28 8005F728 5402628C */  lw         $v0, 0x254($v1)
    /* 4FF2C 8005F72C 00000000 */  nop
    /* 4FF30 8005F730 80100200 */  sll        $v0, $v0, 2
    /* 4FF34 8005F734 21105300 */  addu       $v0, $v0, $s3
    /* 4FF38 8005F738 0000448C */  lw         $a0, 0x0($v0)
    /* 4FF3C 8005F73C C874010C */  jal        ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
    /* 4FF40 8005F740 21284002 */   addu      $a1, $s2, $zero
  .L8005F744:
    /* 4FF44 8005F744 04001026 */  addiu      $s0, $s0, 0x4
    /* 4FF48 8005F748 B97D0108 */  j          .L8005F6E4
    /* 4FF4C 8005F74C 01003126 */   addiu     $s1, $s1, 0x1
  .L8005F750:
    /* 4FF50 8005F750 0000428E */  lw         $v0, 0x0($s2)
    /* 4FF54 8005F754 00000000 */  nop
    /* 4FF58 8005F758 5C0740AC */  sw         $zero, 0x75C($v0)
    /* 4FF5C 8005F75C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 4FF60 8005F760 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4FF64 8005F764 1800B28F */  lw         $s2, 0x18($sp)
    /* 4FF68 8005F768 1400B18F */  lw         $s1, 0x14($sp)
    /* 4FF6C 8005F76C 1000B08F */  lw         $s0, 0x10($sp)
    /* 4FF70 8005F770 0800E003 */  jr         $ra
    /* 4FF74 8005F774 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ReleaseCops__15AIHigh_BTC_Perp
