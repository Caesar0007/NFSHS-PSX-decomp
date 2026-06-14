.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDpitchmult, 0xE8

glabel SNDpitchmult
    /* D8708 800E7F08 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D870C 800E7F0C 1800B0AF */  sw         $s0, 0x18($sp)
    /* D8710 800E7F10 21808000 */  addu       $s0, $a0, $zero
    /* D8714 800E7F14 1480023C */  lui        $v0, %hi(sndgs)
    /* D8718 800E7F18 2400B3AF */  sw         $s3, 0x24($sp)
    /* D871C 800E7F1C 60785324 */  addiu      $s3, $v0, %lo(sndgs)
    /* D8720 800E7F20 2800BFAF */  sw         $ra, 0x28($sp)
    /* D8724 800E7F24 2000B2AF */  sw         $s2, 0x20($sp)
    /* D8728 800E7F28 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D872C 800E7F2C 3C006282 */  lb         $v0, 0x3C($s3)
    /* D8730 800E7F30 00000000 */  nop
    /* D8734 800E7F34 03004014 */  bnez       $v0, .L800E7F44
    /* D8738 800E7F38 2190A000 */   addu      $s2, $a1, $zero
    /* D873C 800E7F3C F59F0308 */  j          .L800E7FD4
    /* D8740 800E7F40 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E7F44:
    /* D8744 800E7F44 4DA9030C */  jal        iSNDenteraudio
    /* D8748 800E7F48 00000000 */   nop
    /* D874C 800E7F4C 71FB030C */  jal        iSNDgetchan
    /* D8750 800E7F50 21200002 */   addu      $a0, $s0, $zero
    /* D8754 800E7F54 21884000 */  addu       $s1, $v0, $zero
    /* D8758 800E7F58 1B002006 */  bltz       $s1, .L800E7FC8
    /* D875C 800E7F5C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D8760 800E7F60 1000A2AF */  sw         $v0, 0x10($sp)
    /* D8764 800E7F64 21202002 */  addu       $a0, $s1, $zero
  .L800E7F68:
    /* D8768 800E7F68 D3FB030C */  jal        iSNDpatchkey
    /* D876C 800E7F6C 1000A527 */   addiu     $a1, $sp, 0x10
    /* D8770 800E7F70 15004010 */  beqz       $v0, .L800E7FC8
    /* D8774 800E7F74 00000000 */   nop
    /* D8778 800E7F78 1000A48F */  lw         $a0, 0x10($sp)
    /* D877C 800E7F7C 9400638E */  lw         $v1, 0x94($s3)
    /* D8780 800E7F80 40100400 */  sll        $v0, $a0, 1
    /* D8784 800E7F84 21104400 */  addu       $v0, $v0, $a0
    /* D8788 800E7F88 C0100200 */  sll        $v0, $v0, 3
    /* D878C 800E7F8C 21104400 */  addu       $v0, $v0, $a0
    /* D8790 800E7F90 80100200 */  sll        $v0, $v0, 2
    /* D8794 800E7F94 21806200 */  addu       $s0, $v1, $v0
    /* D8798 800E7F98 60000296 */  lhu        $v0, 0x60($s0)
    /* D879C 800E7F9C 00000000 */  nop
    /* D87A0 800E7FA0 09005210 */  beq        $v0, $s2, .L800E7FC8
    /* D87A4 800E7FA4 00000000 */   nop
    /* D87A8 800E7FA8 6F06040C */  jal        iSNDcalcpitch
    /* D87AC 800E7FAC 600012A6 */   sh        $s2, 0x60($s0)
    /* D87B0 800E7FB0 1000A48F */  lw         $a0, 0x10($sp)
    /* D87B4 800E7FB4 62000596 */  lhu        $a1, 0x62($s0)
    /* D87B8 800E7FB8 E5FF030C */  jal        iSNDplatformpitch
    /* D87BC 800E7FBC 00000000 */   nop
    /* D87C0 800E7FC0 DA9F0308 */  j          .L800E7F68
    /* D87C4 800E7FC4 21202002 */   addu      $a0, $s1, $zero
  .L800E7FC8:
    /* D87C8 800E7FC8 5BA9030C */  jal        iSNDleaveaudio
    /* D87CC 800E7FCC 00000000 */   nop
    /* D87D0 800E7FD0 21102002 */  addu       $v0, $s1, $zero
  .L800E7FD4:
    /* D87D4 800E7FD4 2800BF8F */  lw         $ra, 0x28($sp)
    /* D87D8 800E7FD8 2400B38F */  lw         $s3, 0x24($sp)
    /* D87DC 800E7FDC 2000B28F */  lw         $s2, 0x20($sp)
    /* D87E0 800E7FE0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D87E4 800E7FE4 1800B08F */  lw         $s0, 0x18($sp)
    /* D87E8 800E7FE8 0800E003 */  jr         $ra
    /* D87EC 800E7FEC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SNDpitchmult
