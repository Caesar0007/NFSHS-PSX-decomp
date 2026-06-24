.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching cancelasyncload, 0x70

glabel cancelasyncload
    /* E1DD0 800F15D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1DD4 800F15D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* E1DD8 800F15D8 FDC2030C */  jal        locaterequest
    /* E1DDC 800F15DC 1000B0AF */   sw        $s0, 0x10($sp)
    /* E1DE0 800F15E0 21804000 */  addu       $s0, $v0, $zero
    /* E1DE4 800F15E4 12000012 */  beqz       $s0, .L800F1630
    /* E1DE8 800F15E8 00000000 */   nop
    /* E1DEC 800F15EC 0C00028E */  lw         $v0, 0xC($s0)
    /* E1DF0 800F15F0 00000000 */  nop
    /* E1DF4 800F15F4 0E004014 */  bnez       $v0, .L800F1630
    /* E1DF8 800F15F8 01000224 */   addiu     $v0, $zero, 0x1
    /* E1DFC 800F15FC 1800048E */  lw         $a0, 0x18($s0)
    /* E1E00 800F1600 02B0030C */  jal        FILE_cancelop
    /* E1E04 800F1604 0C0002AE */   sw        $v0, 0xC($s0)
    /* E1E08 800F1608 1800028E */  lw         $v0, 0x18($s0)
    /* E1E0C 800F160C 00000000 */  nop
    /* E1E10 800F1610 07004014 */  bnez       $v0, .L800F1630
    /* E1E14 800F1614 00000000 */   nop
    /* E1E18 800F1618 1400028E */  lw         $v0, 0x14($s0)
    /* E1E1C 800F161C 00000000 */  nop
    /* E1E20 800F1620 03004014 */  bnez       $v0, .L800F1630
    /* E1E24 800F1624 00000000 */   nop
    /* E1E28 800F1628 14C3030C */  jal        cancelrequest
    /* E1E2C 800F162C 21200002 */   addu      $a0, $s0, $zero
  .L800F1630:
    /* E1E30 800F1630 1400BF8F */  lw         $ra, 0x14($sp)
    /* E1E34 800F1634 1000B08F */  lw         $s0, 0x10($sp)
    /* E1E38 800F1638 0800E003 */  jr         $ra
    /* E1E3C 800F163C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel cancelasyncload
