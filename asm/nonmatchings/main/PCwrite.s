.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCwrite, 0xC0

glabel PCwrite
    /* F7550 80106D50 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F7554 80106D54 2000B4AF */  sw         $s4, 0x20($sp)
    /* F7558 80106D58 21A08000 */  addu       $s4, $a0, $zero
    /* F755C 80106D5C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F7560 80106D60 2198A000 */  addu       $s3, $a1, $zero
    /* F7564 80106D64 1000B0AF */  sw         $s0, 0x10($sp)
    /* F7568 80106D68 2180C000 */  addu       $s0, $a2, $zero
    /* F756C 80106D6C 1800B2AF */  sw         $s2, 0x18($sp)
    /* F7570 80106D70 21900000 */  addu       $s2, $zero, $zero
    /* F7574 80106D74 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F7578 80106D78 2800B6AF */  sw         $s6, 0x28($sp)
    /* F757C 80106D7C 2400B5AF */  sw         $s5, 0x24($sp)
    /* F7580 80106D80 17000012 */  beqz       $s0, .L80106DE0
    /* F7584 80106D84 1400B1AF */   sw        $s1, 0x14($sp)
    /* F7588 80106D88 00801634 */  ori        $s6, $zero, 0x8000
    /* F758C 80106D8C FFFF1524 */  addiu      $s5, $zero, -0x1
    /* F7590 80106D90 2B10D002 */  sltu       $v0, $s6, $s0
  .L80106D94:
    /* F7594 80106D94 02004010 */  beqz       $v0, .L80106DA0
    /* F7598 80106D98 21880002 */   addu      $s1, $s0, $zero
    /* F759C 80106D9C 00801134 */  ori        $s1, $zero, 0x8000
  .L80106DA0:
    /* F75A0 80106DA0 21200000 */  addu       $a0, $zero, $zero
    /* F75A4 80106DA4 21288002 */  addu       $a1, $s4, $zero
    /* F75A8 80106DA8 21302002 */  addu       $a2, $s1, $zero
    /* F75AC 80106DAC C831040C */  jal        _SN_write
    /* F75B0 80106DB0 21386002 */   addu      $a3, $s3, $zero
    /* F75B4 80106DB4 03005514 */  bne        $v0, $s5, .L80106DC4
    /* F75B8 80106DB8 21904202 */   addu      $s2, $s2, $v0
    /* F75BC 80106DBC 791B0408 */  j          .L80106DE4
    /* F75C0 80106DC0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80106DC4:
    /* F75C4 80106DC4 21986202 */  addu       $s3, $s3, $v0
    /* F75C8 80106DC8 23800202 */  subu       $s0, $s0, $v0
    /* F75CC 80106DCC 2A105100 */  slt        $v0, $v0, $s1
    /* F75D0 80106DD0 03004014 */  bnez       $v0, .L80106DE0
    /* F75D4 80106DD4 00000000 */   nop
    /* F75D8 80106DD8 EEFF0016 */  bnez       $s0, .L80106D94
    /* F75DC 80106DDC 2B10D002 */   sltu      $v0, $s6, $s0
  .L80106DE0:
    /* F75E0 80106DE0 21104002 */  addu       $v0, $s2, $zero
  .L80106DE4:
    /* F75E4 80106DE4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F75E8 80106DE8 2800B68F */  lw         $s6, 0x28($sp)
    /* F75EC 80106DEC 2400B58F */  lw         $s5, 0x24($sp)
    /* F75F0 80106DF0 2000B48F */  lw         $s4, 0x20($sp)
    /* F75F4 80106DF4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F75F8 80106DF8 1800B28F */  lw         $s2, 0x18($sp)
    /* F75FC 80106DFC 1400B18F */  lw         $s1, 0x14($sp)
    /* F7600 80106E00 1000B08F */  lw         $s0, 0x10($sp)
    /* F7604 80106E04 3000BD27 */  addiu      $sp, $sp, 0x30
    /* F7608 80106E08 0800E003 */  jr         $ra
    /* F760C 80106E0C 00000000 */   nop
endlabel PCwrite
