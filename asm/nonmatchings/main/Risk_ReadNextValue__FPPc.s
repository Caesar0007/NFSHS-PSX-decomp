.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Risk_ReadNextValue__FPPc, 0xE0

glabel Risk_ReadNextValue__FPPc
    /* 826FC 80091EFC D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* 82700 80091F00 1C01B3AF */  sw         $s3, 0x11C($sp)
    /* 82704 80091F04 21988000 */  addu       $s3, $a0, $zero
    /* 82708 80091F08 1401B1AF */  sw         $s1, 0x114($sp)
    /* 8270C 80091F0C 21880000 */  addu       $s1, $zero, $zero
    /* 82710 80091F10 1801B2AF */  sw         $s2, 0x118($sp)
    /* 82714 80091F14 2F001224 */  addiu      $s2, $zero, 0x2F
    /* 82718 80091F18 2001BFAF */  sw         $ra, 0x120($sp)
    /* 8271C 80091F1C 1001B0AF */  sw         $s0, 0x110($sp)
    /* 82720 80091F20 0000708E */  lw         $s0, 0x0($s3)
  .L80091F24:
    /* 82724 80091F24 00000000 */  nop
    /* 82728 80091F28 00000492 */  lbu        $a0, 0x0($s0)
    /* 8272C 80091F2C B047020C */  jal        IsNumChar__Fc
    /* 82730 80091F30 00000000 */   nop
    /* 82734 80091F34 FF004230 */  andi       $v0, $v0, 0xFF
    /* 82738 80091F38 10004014 */  bnez       $v0, .L80091F7C
    /* 8273C 80091F3C 00000000 */   nop
    /* 82740 80091F40 00000392 */  lbu        $v1, 0x0($s0)
    /* 82744 80091F44 00000000 */  nop
    /* 82748 80091F48 F6FF7214 */  bne        $v1, $s2, .L80091F24
    /* 8274C 80091F4C 01001026 */   addiu     $s0, $s0, 0x1
    /* 82750 80091F50 00000292 */  lbu        $v0, 0x0($s0)
    /* 82754 80091F54 00000000 */  nop
    /* 82758 80091F58 F2FF4310 */  beq        $v0, $v1, .L80091F24
    /* 8275C 80091F5C 01001026 */   addiu     $s0, $s0, 0x1
    /* 82760 80091F60 2F000324 */  addiu      $v1, $zero, 0x2F
  .L80091F64:
    /* 82764 80091F64 00000292 */  lbu        $v0, 0x0($s0)
    /* 82768 80091F68 00000000 */  nop
    /* 8276C 80091F6C FDFF4314 */  bne        $v0, $v1, .L80091F64
    /* 82770 80091F70 01001026 */   addiu     $s0, $s0, 0x1
    /* 82774 80091F74 C9470208 */  j          .L80091F24
    /* 82778 80091F78 00000000 */   nop
  .L80091F7C:
    /* 8277C 80091F7C 1000B227 */  addiu      $s2, $sp, 0x10
  .L80091F80:
    /* 82780 80091F80 00000492 */  lbu        $a0, 0x0($s0)
    /* 82784 80091F84 B047020C */  jal        IsNumChar__Fc
    /* 82788 80091F88 00000000 */   nop
    /* 8278C 80091F8C FF004230 */  andi       $v0, $v0, 0xFF
    /* 82790 80091F90 06004010 */  beqz       $v0, .L80091FAC
    /* 82794 80091F94 21105102 */   addu      $v0, $s2, $s1
    /* 82798 80091F98 00000392 */  lbu        $v1, 0x0($s0)
    /* 8279C 80091F9C 01001026 */  addiu      $s0, $s0, 0x1
    /* 827A0 80091FA0 01003126 */  addiu      $s1, $s1, 0x1
    /* 827A4 80091FA4 E0470208 */  j          .L80091F80
    /* 827A8 80091FA8 000043A0 */   sb        $v1, 0x0($v0)
  .L80091FAC:
    /* 827AC 80091FAC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 827B0 80091FB0 21109100 */  addu       $v0, $a0, $s1
    /* 827B4 80091FB4 40AC030C */  jal        atoi
    /* 827B8 80091FB8 000040A0 */   sb        $zero, 0x0($v0)
    /* 827BC 80091FBC 000070AE */  sw         $s0, 0x0($s3)
    /* 827C0 80091FC0 2001BF8F */  lw         $ra, 0x120($sp)
    /* 827C4 80091FC4 1C01B38F */  lw         $s3, 0x11C($sp)
    /* 827C8 80091FC8 1801B28F */  lw         $s2, 0x118($sp)
    /* 827CC 80091FCC 1401B18F */  lw         $s1, 0x114($sp)
    /* 827D0 80091FD0 1001B08F */  lw         $s0, 0x110($sp)
    /* 827D4 80091FD4 0800E003 */  jr         $ra
    /* 827D8 80091FD8 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel Risk_ReadNextValue__FPPc
