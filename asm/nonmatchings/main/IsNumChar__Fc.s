.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsNumChar__Fc, 0x3C

glabel IsNumChar__Fc
    /* 826C0 80091EC0 21108000 */  addu       $v0, $a0, $zero
    /* 826C4 80091EC4 D0FF8424 */  addiu      $a0, $a0, -0x30
    /* 826C8 80091EC8 FF008430 */  andi       $a0, $a0, 0xFF
    /* 826CC 80091ECC 0A00842C */  sltiu      $a0, $a0, 0xA
    /* 826D0 80091ED0 03008010 */  beqz       $a0, .L80091EE0
    /* 826D4 80091ED4 FF004430 */   andi      $a0, $v0, 0xFF
    /* 826D8 80091ED8 0800E003 */  jr         $ra
    /* 826DC 80091EDC 01000224 */   addiu     $v0, $zero, 0x1
  .L80091EE0:
    /* 826E0 80091EE0 2D000224 */  addiu      $v0, $zero, 0x2D
    /* 826E4 80091EE4 03008210 */  beq        $a0, $v0, .L80091EF4
    /* 826E8 80091EE8 2B008238 */   xori      $v0, $a0, 0x2B
    /* 826EC 80091EEC 0800E003 */  jr         $ra
    /* 826F0 80091EF0 0100422C */   sltiu     $v0, $v0, 0x1
  .L80091EF4:
    /* 826F4 80091EF4 0800E003 */  jr         $ra
    /* 826F8 80091EF8 01000224 */   addiu     $v0, $zero, 0x1
endlabel IsNumChar__Fc
