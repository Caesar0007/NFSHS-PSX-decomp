.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _add_mant_d, 0xAC

glabel _add_mant_d
    /* F7770 80106F70 F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* F7774 80106F74 21488000 */  addu       $t1, $a0, $zero
    /* F7778 80106F78 02440500 */  srl        $t0, $a1, 16
    /* F777C 80106F7C 1400A5AF */  sw         $a1, 0x14($sp)
    /* F7780 80106F80 FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* F7784 80106F84 021C0700 */  srl        $v1, $a3, 16
    /* F7788 80106F88 1C00A7AF */  sw         $a3, 0x1C($sp)
    /* F778C 80106F8C FFFFE730 */  andi       $a3, $a3, 0xFFFF
    /* F7790 80106F90 2120A700 */  addu       $a0, $a1, $a3
    /* F7794 80106F94 0000A5AF */  sw         $a1, 0x0($sp)
    /* F7798 80106F98 0100053C */  lui        $a1, (0x10000 >> 16)
    /* F779C 80106F9C 24108500 */  and        $v0, $a0, $a1
    /* F77A0 80106FA0 1800A6AF */  sw         $a2, 0x18($sp)
    /* F77A4 80106FA4 0400A8AF */  sw         $t0, 0x4($sp)
    /* F77A8 80106FA8 0C00A3AF */  sw         $v1, 0xC($sp)
    /* F77AC 80106FAC 0800A7AF */  sw         $a3, 0x8($sp)
    /* F77B0 80106FB0 03004010 */  beqz       $v0, .L80106FC0
    /* F77B4 80106FB4 0000A4AF */   sw        $a0, 0x0($sp)
    /* F77B8 80106FB8 01000225 */  addiu      $v0, $t0, 0x1
    /* F77BC 80106FBC 0400A2AF */  sw         $v0, 0x4($sp)
  .L80106FC0:
    /* F77C0 80106FC0 0400A28F */  lw         $v0, 0x4($sp)
    /* F77C4 80106FC4 00000000 */  nop
    /* F77C8 80106FC8 21384300 */  addu       $a3, $v0, $v1
    /* F77CC 80106FCC 2410E500 */  and        $v0, $a3, $a1
    /* F77D0 80106FD0 03004010 */  beqz       $v0, .L80106FE0
    /* F77D4 80106FD4 0400A7AF */   sw        $a3, 0x4($sp)
    /* F77D8 80106FD8 0100C624 */  addiu      $a2, $a2, 0x1
    /* F77DC 80106FDC 1800A6AF */  sw         $a2, 0x18($sp)
  .L80106FE0:
    /* F77E0 80106FE0 00140700 */  sll        $v0, $a3, 16
    /* F77E4 80106FE4 FFFF8430 */  andi       $a0, $a0, 0xFFFF
    /* F77E8 80106FE8 1800A38F */  lw         $v1, 0x18($sp)
    /* F77EC 80106FEC 2000A58F */  lw         $a1, 0x20($sp)
    /* F77F0 80106FF0 25104400 */  or         $v0, $v0, $a0
    /* F77F4 80106FF4 1400A2AF */  sw         $v0, 0x14($sp)
    /* F77F8 80106FF8 21186500 */  addu       $v1, $v1, $a1
    /* F77FC 80106FFC 1800A3AF */  sw         $v1, 0x18($sp)
    /* F7800 80107000 1400A28F */  lw         $v0, 0x14($sp)
    /* F7804 80107004 1800A38F */  lw         $v1, 0x18($sp)
    /* F7808 80107008 000022AD */  sw         $v0, 0x0($t1)
    /* F780C 8010700C 040023AD */  sw         $v1, 0x4($t1)
    /* F7810 80107010 21102001 */  addu       $v0, $t1, $zero
    /* F7814 80107014 0800E003 */  jr         $ra
    /* F7818 80107018 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel _add_mant_d
    /* F781C 8010701C 00000000 */  nop
