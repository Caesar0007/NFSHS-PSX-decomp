.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CancelAsyncLoad__7tScreenR17tShapeInformation, 0x98

glabel CancelAsyncLoad__7tScreenR17tShapeInformation
    /* 16B54 80026354 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 16B58 80026358 1000B0AF */  sw         $s0, 0x10($sp)
    /* 16B5C 8002635C 2180A000 */  addu       $s0, $a1, $zero
    /* 16B60 80026360 1400BFAF */  sw         $ra, 0x14($sp)
    /* 16B64 80026364 0C00048E */  lw         $a0, 0xC($s0)
    /* 16B68 80026368 00000000 */  nop
    /* 16B6C 8002636C 1B008010 */  beqz       $a0, .L800263DC
    /* 16B70 80026370 00000000 */   nop
    /* 16B74 80026374 B6C5030C */  jal        getasyncreadstatus
    /* 16B78 80026378 00000000 */   nop
    /* 16B7C 8002637C 03004014 */  bnez       $v0, .L8002638C
    /* 16B80 80026380 01000224 */   addiu     $v0, $zero, 0x1
    /* 16B84 80026384 F7980008 */  j          .L800263DC
    /* 16B88 80026388 240002AE */   sw        $v0, 0x24($s0)
  .L8002638C:
    /* 16B8C 8002638C 0800028E */  lw         $v0, 0x8($s0)
    /* 16B90 80026390 00000000 */  nop
    /* 16B94 80026394 05004014 */  bnez       $v0, .L800263AC
    /* 16B98 80026398 00000000 */   nop
    /* 16B9C 8002639C 0C00048E */  lw         $a0, 0xC($s0)
    /* 16BA0 800263A0 90C5030C */  jal        getasyncreadadr
    /* 16BA4 800263A4 00000000 */   nop
    /* 16BA8 800263A8 040002AE */  sw         $v0, 0x4($s0)
  .L800263AC:
    /* 16BAC 800263AC 0400048E */  lw         $a0, 0x4($s0)
    /* 16BB0 800263B0 00000000 */  nop
    /* 16BB4 800263B4 08008010 */  beqz       $a0, .L800263D8
    /* 16BB8 800263B8 00000000 */   nop
    /* 16BBC 800263BC 0800028E */  lw         $v0, 0x8($s0)
    /* 16BC0 800263C0 00000000 */  nop
    /* 16BC4 800263C4 03004014 */  bnez       $v0, .L800263D4
    /* 16BC8 800263C8 00000000 */   nop
    /* 16BCC 800263CC 5095030C */  jal        purgememadr
    /* 16BD0 800263D0 00000000 */   nop
  .L800263D4:
    /* 16BD4 800263D4 040000AE */  sw         $zero, 0x4($s0)
  .L800263D8:
    /* 16BD8 800263D8 0C0000AE */  sw         $zero, 0xC($s0)
  .L800263DC:
    /* 16BDC 800263DC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 16BE0 800263E0 1000B08F */  lw         $s0, 0x10($sp)
    /* 16BE4 800263E4 0800E003 */  jr         $ra
    /* 16BE8 800263E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CancelAsyncLoad__7tScreenR17tShapeInformation
