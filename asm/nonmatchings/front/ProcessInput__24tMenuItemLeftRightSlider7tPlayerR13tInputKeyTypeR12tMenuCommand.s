.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xA8

glabel ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 15384 80024B84 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15388 80024B88 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1538C 80024B8C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 15390 80024B90 0000828C */  lw         $v0, 0x0($a0)
    /* 15394 80024B94 00000000 */  nop
    /* 15398 80024B98 01004230 */  andi       $v0, $v0, 0x1
    /* 1539C 80024B9C 1F004014 */  bnez       $v0, .L80024C1C
    /* 153A0 80024BA0 2180C000 */   addu      $s0, $a2, $zero
    /* 153A4 80024BA4 0000038E */  lw         $v1, 0x0($s0)
    /* 153A8 80024BA8 00080224 */  addiu      $v0, $zero, 0x800
    /* 153AC 80024BAC 05006210 */  beq        $v1, $v0, .L80024BC4
    /* 153B0 80024BB0 00100224 */   addiu     $v0, $zero, 0x1000
    /* 153B4 80024BB4 0B006210 */  beq        $v1, $v0, .L80024BE4
    /* 153B8 80024BB8 00000000 */   nop
    /* 153BC 80024BBC 07930008 */  j          .L80024C1C
    /* 153C0 80024BC0 00000000 */   nop
  .L80024BC4:
    /* 153C4 80024BC4 1C00838C */  lw         $v1, 0x1C($a0)
    /* 153C8 80024BC8 00000000 */  nop
    /* 153CC 80024BCC 0C00628C */  lw         $v0, 0xC($v1)
    /* 153D0 80024BD0 00000000 */  nop
    /* 153D4 80024BD4 28004484 */  lh         $a0, 0x28($v0)
    /* 153D8 80024BD8 2C00428C */  lw         $v0, 0x2C($v0)
    /* 153DC 80024BDC FF920008 */  j          .L80024BFC
    /* 153E0 80024BE0 00000000 */   nop
  .L80024BE4:
    /* 153E4 80024BE4 1C00838C */  lw         $v1, 0x1C($a0)
    /* 153E8 80024BE8 00000000 */  nop
    /* 153EC 80024BEC 0C00628C */  lw         $v0, 0xC($v1)
    /* 153F0 80024BF0 00000000 */  nop
    /* 153F4 80024BF4 20004484 */  lh         $a0, 0x20($v0)
    /* 153F8 80024BF8 2400428C */  lw         $v0, 0x24($v0)
  .L80024BFC:
    /* 153FC 80024BFC 00000000 */  nop
    /* 15400 80024C00 09F84000 */  jalr       $v0
    /* 15404 80024C04 21206400 */   addu      $a0, $v1, $a0
    /* 15408 80024C08 15000424 */  addiu      $a0, $zero, 0x15
    /* 1540C 80024C0C 40000524 */  addiu      $a1, $zero, 0x40
    /* 15410 80024C10 01000224 */  addiu      $v0, $zero, 0x1
    /* 15414 80024C14 89E5010C */  jal        AudioCmn_PlayFESFXVol__Fii
    /* 15418 80024C18 000002AE */   sw        $v0, 0x0($s0)
  .L80024C1C:
    /* 1541C 80024C1C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 15420 80024C20 1800B08F */  lw         $s0, 0x18($sp)
    /* 15424 80024C24 0800E003 */  jr         $ra
    /* 15428 80024C28 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
