.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdReset, 0x6C

glabel CdReset
    /* E7FAC 800F77AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E7FB0 800F77B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* E7FB4 800F77B4 21808000 */  addu       $s0, $a0, $zero
    /* E7FB8 800F77B8 02000224 */  addiu      $v0, $zero, 0x2
    /* E7FBC 800F77BC 05000216 */  bne        $s0, $v0, .L800F77D4
    /* E7FC0 800F77C0 1400BFAF */   sw        $ra, 0x14($sp)
    /* E7FC4 800F77C4 3D20040C */  jal        CD_initintr
    /* E7FC8 800F77C8 00000000 */   nop
    /* E7FCC 800F77CC 02DE0308 */  j          .L800F7808
    /* E7FD0 800F77D0 01000224 */   addiu     $v0, $zero, 0x1
  .L800F77D4:
    /* E7FD4 800F77D4 5020040C */  jal        CD_init_80108140
    /* E7FD8 800F77D8 00000000 */   nop
    /* E7FDC 800F77DC 0A004014 */  bnez       $v0, .L800F7808
    /* E7FE0 800F77E0 21100000 */   addu      $v0, $zero, $zero
    /* E7FE4 800F77E4 01000224 */  addiu      $v0, $zero, 0x1
    /* E7FE8 800F77E8 07000216 */  bne        $s0, $v0, .L800F7808
    /* E7FEC 800F77EC 00000000 */   nop
    /* E7FF0 800F77F0 0120040C */  jal        CD_initvol
    /* E7FF4 800F77F4 00000000 */   nop
    /* E7FF8 800F77F8 21184000 */  addu       $v1, $v0, $zero
    /* E7FFC 800F77FC 02006014 */  bnez       $v1, .L800F7808
    /* E8000 800F7800 21100000 */   addu      $v0, $zero, $zero
    /* E8004 800F7804 01000224 */  addiu      $v0, $zero, 0x1
  .L800F7808:
    /* E8008 800F7808 1400BF8F */  lw         $ra, 0x14($sp)
    /* E800C 800F780C 1000B08F */  lw         $s0, 0x10($sp)
    /* E8010 800F7810 0800E003 */  jr         $ra
    /* E8014 800F7814 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CdReset
