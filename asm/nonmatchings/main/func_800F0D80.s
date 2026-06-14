.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F0D80, 0xD4

glabel func_800F0D80
    /* E1580 800F0D80 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E1584 800F0D84 1800B0AF */  sw         $s0, 0x18($sp)
    /* E1588 800F0D88 2180C000 */  addu       $s0, $a2, $zero
    /* E158C 800F0D8C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E1590 800F0D90 1800048E */  lw         $a0, 0x18($s0)
    /* E1594 800F0D94 ACB0030C */  jal        FILE_completeop
    /* E1598 800F0D98 00000000 */   nop
    /* E159C 800F0D9C 21204000 */  addu       $a0, $v0, $zero
    /* E15A0 800F0DA0 0800028E */  lw         $v0, 0x8($s0)
    /* E15A4 800F0DA4 4419878F */  lw         $a3, %gp_rel(D_8013DE90)($gp)
    /* E15A8 800F0DA8 21104400 */  addu       $v0, $v0, $a0
    /* E15AC 800F0DAC 080002AE */  sw         $v0, 0x8($s0)
    /* E15B0 800F0DB0 2A108700 */  slt        $v0, $a0, $a3
    /* E15B4 800F0DB4 05004014 */  bnez       $v0, .L800F0DCC
    /* E15B8 800F0DB8 63000524 */   addiu     $a1, $zero, 0x63
    /* E15BC 800F0DBC 0C00028E */  lw         $v0, 0xC($s0)
    /* E15C0 800F0DC0 00000000 */  nop
    /* E15C4 800F0DC4 0A004010 */  beqz       $v0, .L800F0DF0
    /* E15C8 800F0DC8 00000000 */   nop
  .L800F0DCC:
    /* E15CC 800F0DCC 1C00048E */  lw         $a0, 0x1C($s0)
    /* E15D0 800F0DD0 0BB1030C */  jal        FILE_close
    /* E15D4 800F0DD4 21300002 */   addu      $a2, $s0, $zero
    /* E15D8 800F0DD8 1A004010 */  beqz       $v0, .L800F0E44
    /* E15DC 800F0DDC 180002AE */   sw        $v0, 0x18($s0)
    /* E15E0 800F0DE0 21204000 */  addu       $a0, $v0, $zero
    /* E15E4 800F0DE4 0F80053C */  lui        $a1, %hi(func_800F0D24)
    /* E15E8 800F0DE8 8FC30308 */  j          .L800F0E3C
    /* E15EC 800F0DEC 240DA524 */   addiu     $a1, $a1, %lo(func_800F0D24)
  .L800F0DF0:
    /* E15F0 800F0DF0 2000028E */  lw         $v0, 0x20($s0)
    /* E15F4 800F0DF4 2800038E */  lw         $v1, 0x28($s0)
    /* E15F8 800F0DF8 21104400 */  addu       $v0, $v0, $a0
    /* E15FC 800F0DFC 21186400 */  addu       $v1, $v1, $a0
    /* E1600 800F0E00 200002AE */  sw         $v0, 0x20($s0)
    /* E1604 800F0E04 63000224 */  addiu      $v0, $zero, 0x63
    /* E1608 800F0E08 280003AE */  sw         $v1, 0x28($s0)
    /* E160C 800F0E0C 1000A2AF */  sw         $v0, 0x10($sp)
    /* E1610 800F0E10 1400B0AF */  sw         $s0, 0x14($sp)
    /* E1614 800F0E14 1C00048E */  lw         $a0, 0x1C($s0)
    /* E1618 800F0E18 2000058E */  lw         $a1, 0x20($s0)
    /* E161C 800F0E1C 2800068E */  lw         $a2, 0x28($s0)
    /* E1620 800F0E20 3BB1030C */  jal        FILE_read
    /* E1624 800F0E24 00000000 */   nop
    /* E1628 800F0E28 06004010 */  beqz       $v0, .L800F0E44
    /* E162C 800F0E2C 180002AE */   sw        $v0, 0x18($s0)
    /* E1630 800F0E30 21204000 */  addu       $a0, $v0, $zero
    /* E1634 800F0E34 0F80053C */  lui        $a1, %hi(func_800F0D80)
    /* E1638 800F0E38 800DA524 */  addiu      $a1, $a1, %lo(func_800F0D80)
  .L800F0E3C:
    /* E163C 800F0E3C 93AF030C */  jal        FILE_callbackop
    /* E1640 800F0E40 00000000 */   nop
  .L800F0E44:
    /* E1644 800F0E44 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E1648 800F0E48 1800B08F */  lw         $s0, 0x18($sp)
    /* E164C 800F0E4C 0800E003 */  jr         $ra
    /* E1650 800F0E50 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800F0D80
