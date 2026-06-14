.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_setpriority, 0x68

glabel SNDSTRM_setpriority
    /* D74F0 800E6CF0 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D74F4 800E6CF4 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D74F8 800E6CF8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D74FC 800E6CFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D7500 800E6D00 2180A000 */  addu       $s0, $a1, $zero
    /* D7504 800E6D04 1400B1AF */  sw         $s1, 0x14($sp)
    /* D7508 800E6D08 2188C000 */  addu       $s1, $a2, $zero
    /* D750C 800E6D0C 03004014 */  bnez       $v0, .L800E6D1C
    /* D7510 800E6D10 1800BFAF */   sw        $ra, 0x18($sp)
    /* D7514 800E6D14 519B0308 */  j          .L800E6D44
    /* D7518 800E6D18 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E6D1C:
    /* D751C 800E6D1C 12A3030C */  jal        iSNDstreamgetstreamptr
    /* D7520 800E6D20 00000000 */   nop
    /* D7524 800E6D24 06004010 */  beqz       $v0, .L800E6D40
    /* D7528 800E6D28 21280002 */   addu      $a1, $s0, $zero
    /* D752C 800E6D2C 0400448C */  lw         $a0, 0x4($v0)
    /* D7530 800E6D30 7EF4030C */  jal        STREAM_setpriority
    /* D7534 800E6D34 21302002 */   addu      $a2, $s1, $zero
    /* D7538 800E6D38 519B0308 */  j          .L800E6D44
    /* D753C 800E6D3C 21100000 */   addu      $v0, $zero, $zero
  .L800E6D40:
    /* D7540 800E6D40 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L800E6D44:
    /* D7544 800E6D44 1800BF8F */  lw         $ra, 0x18($sp)
    /* D7548 800E6D48 1400B18F */  lw         $s1, 0x14($sp)
    /* D754C 800E6D4C 1000B08F */  lw         $s0, 0x10($sp)
    /* D7550 800E6D50 0800E003 */  jr         $ra
    /* D7554 800E6D54 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_setpriority
