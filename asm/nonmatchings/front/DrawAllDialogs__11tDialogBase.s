.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawAllDialogs__11tDialogBase, 0xD0

glabel DrawAllDialogs__11tDialogBase
    /* 8F20 80018720 0580033C */  lui        $v1, %hi(_front_data_orgend)
    /* 8F24 80018724 382B628C */  lw         $v0, %lo(_front_data_orgend)($v1)
    /* 8F28 80018728 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8F2C 8001872C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8F30 80018730 21880000 */  addu       $s1, $zero, $zero
    /* 8F34 80018734 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 8F38 80018738 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8F3C 8001873C 26004010 */  beqz       $v0, .L800187D8
    /* 8F40 80018740 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8F44 80018744 382B7224 */  addiu      $s2, $v1, %lo(_front_data_orgend)
  .L80018748:
    /* 8F48 80018748 00141100 */  sll        $v0, $s1, 16
    /* 8F4C 8001874C 031C0200 */  sra        $v1, $v0, 16
    /* 8F50 80018750 08006228 */  slti       $v0, $v1, 0x8
    /* 8F54 80018754 20004010 */  beqz       $v0, .L800187D8
    /* 8F58 80018758 80100300 */   sll       $v0, $v1, 2
    /* 8F5C 8001875C 21805200 */  addu       $s0, $v0, $s2
    /* 8F60 80018760 0000048E */  lw         $a0, 0x0($s0)
    /* 8F64 80018764 B261000C */  jal        ShouldTimeOut__11tDialogBase
    /* 8F68 80018768 00000000 */   nop
    /* 8F6C 8001876C 00140200 */  sll        $v0, $v0, 16
    /* 8F70 80018770 08004010 */  beqz       $v0, .L80018794
    /* 8F74 80018774 00000000 */   nop
    /* 8F78 80018778 0000048E */  lw         $a0, 0x0($s0)
    /* 8F7C 8001877C 4162000C */  jal        Hide__11tDialogBase
    /* 8F80 80018780 00000000 */   nop
    /* 8F84 80018784 0000028E */  lw         $v0, 0x0($s0)
    /* 8F88 80018788 00000000 */  nop
    /* 8F8C 8001878C 12004010 */  beqz       $v0, .L800187D8
    /* 8F90 80018790 00000000 */   nop
  .L80018794:
    /* 8F94 80018794 0000038E */  lw         $v1, 0x0($s0)
    /* 8F98 80018798 00000000 */  nop
    /* 8F9C 8001879C 6000628C */  lw         $v0, 0x60($v1)
    /* 8FA0 800187A0 00000000 */  nop
    /* 8FA4 800187A4 58004484 */  lh         $a0, 0x58($v0)
    /* 8FA8 800187A8 5C00428C */  lw         $v0, 0x5C($v0)
    /* 8FAC 800187AC 00000000 */  nop
    /* 8FB0 800187B0 09F84000 */  jalr       $v0
    /* 8FB4 800187B4 21206400 */   addu      $a0, $v1, $a0
    /* 8FB8 800187B8 01002326 */  addiu      $v1, $s1, 0x1
    /* 8FBC 800187BC 00140300 */  sll        $v0, $v1, 16
    /* 8FC0 800187C0 83130200 */  sra        $v0, $v0, 14
    /* 8FC4 800187C4 21105200 */  addu       $v0, $v0, $s2
    /* 8FC8 800187C8 0000428C */  lw         $v0, 0x0($v0)
    /* 8FCC 800187CC 00000000 */  nop
    /* 8FD0 800187D0 DDFF4014 */  bnez       $v0, .L80018748
    /* 8FD4 800187D4 21886000 */   addu      $s1, $v1, $zero
  .L800187D8:
    /* 8FD8 800187D8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 8FDC 800187DC 1800B28F */  lw         $s2, 0x18($sp)
    /* 8FE0 800187E0 1400B18F */  lw         $s1, 0x14($sp)
    /* 8FE4 800187E4 1000B08F */  lw         $s0, 0x10($sp)
    /* 8FE8 800187E8 0800E003 */  jr         $ra
    /* 8FEC 800187EC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel DrawAllDialogs__11tDialogBase
