.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ClearOldEvents, 0x11C

glabel iSPCH_ClearOldEvents
    /* D7D28 800E7528 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D7D2C 800E752C 2400B5AF */  sw         $s5, 0x24($sp)
    /* D7D30 800E7530 21A88000 */  addu       $s5, $a0, $zero
    /* D7D34 800E7534 1400B1AF */  sw         $s1, 0x14($sp)
    /* D7D38 800E7538 21880000 */  addu       $s1, $zero, $zero
    /* D7D3C 800E753C 1580023C */  lui        $v0, %hi(gVoxEvents)
    /* D7D40 800E7540 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D7D44 800E7544 21984000 */  addu       $s3, $v0, $zero
    /* D7D48 800E7548 60806326 */  addiu      $v1, $s3, %lo(gVoxEvents)
    /* D7D4C 800E754C 00111500 */  sll        $v0, $s5, 4
    /* D7D50 800E7550 23105500 */  subu       $v0, $v0, $s5
    /* D7D54 800E7554 80100200 */  sll        $v0, $v0, 2
    /* D7D58 800E7558 21104300 */  addu       $v0, $v0, $v1
    /* D7D5C 800E755C 2000B4AF */  sw         $s4, 0x20($sp)
    /* D7D60 800E7560 21A06000 */  addu       $s4, $v1, $zero
    /* D7D64 800E7564 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* D7D68 800E7568 2800B6AF */  sw         $s6, 0x28($sp)
    /* D7D6C 800E756C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D7D70 800E7570 1000B0AF */  sw         $s0, 0x10($sp)
    /* D7D74 800E7574 0C00528C */  lw         $s2, 0xC($v0)
    /* D7D78 800E7578 0A005694 */  lhu        $s6, 0xA($v0)
    /* D7D7C 800E757C 21808002 */  addu       $s0, $s4, $zero
    /* D7D80 800E7580 040080AE */  sw         $zero, 0x4($s4)
  .L800E7584:
    /* D7D84 800E7584 21003512 */  beq        $s1, $s5, .L800E760C
    /* D7D88 800E7588 00000000 */   nop
    /* D7D8C 800E758C 08000296 */  lhu        $v0, 0x8($s0)
    /* D7D90 800E7590 00000000 */  nop
    /* D7D94 800E7594 1D004010 */  beqz       $v0, .L800E760C
    /* D7D98 800E7598 00000000 */   nop
    /* D7D9C 800E759C 0C00038E */  lw         $v1, 0xC($s0)
    /* D7DA0 800E75A0 0A000496 */  lhu        $a0, 0xA($s0)
    /* D7DA4 800E75A4 2B107200 */  sltu       $v0, $v1, $s2
    /* D7DA8 800E75A8 05004014 */  bnez       $v0, .L800E75C0
    /* D7DAC 800E75AC 00000000 */   nop
    /* D7DB0 800E75B0 0F007214 */  bne        $v1, $s2, .L800E75F0
    /* D7DB4 800E75B4 2B109600 */   sltu      $v0, $a0, $s6
    /* D7DB8 800E75B8 0D004010 */  beqz       $v0, .L800E75F0
    /* D7DBC 800E75BC 00000000 */   nop
  .L800E75C0:
    /* D7DC0 800E75C0 1000048E */  lw         $a0, 0x10($s0)
    /* D7DC4 800E75C4 A59B030C */  jal        func_800E6E94
    /* D7DC8 800E75C8 00000000 */   nop
    /* D7DCC 800E75CC FF004230 */  andi       $v0, $v0, 0xFF
    /* D7DD0 800E75D0 0E004014 */  bnez       $v0, .L800E760C
    /* D7DD4 800E75D4 00000000 */   nop
    /* D7DD8 800E75D8 080000A6 */  sh         $zero, 0x8($s0)
    /* D7DDC 800E75DC 6080628E */  lw         $v0, %lo(gVoxEvents)($s3)
    /* D7DE0 800E75E0 00000000 */  nop
    /* D7DE4 800E75E4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7DE8 800E75E8 839D0308 */  j          .L800E760C
    /* D7DEC 800E75EC 608062AE */   sw        $v0, %lo(gVoxEvents)($s3)
  .L800E75F0:
    /* D7DF0 800E75F0 1000028E */  lw         $v0, 0x10($s0)
    /* D7DF4 800E75F4 00000000 */  nop
    /* D7DF8 800E75F8 09004380 */  lb         $v1, 0x9($v0)
    /* D7DFC 800E75FC 64000224 */  addiu      $v0, $zero, 0x64
    /* D7E00 800E7600 02006214 */  bne        $v1, $v0, .L800E760C
    /* D7E04 800E7604 01000224 */   addiu     $v0, $zero, 0x1
    /* D7E08 800E7608 040082AE */  sw         $v0, 0x4($s4)
  .L800E760C:
    /* D7E0C 800E760C 01003126 */  addiu      $s1, $s1, 0x1
    /* D7E10 800E7610 1000222A */  slti       $v0, $s1, 0x10
    /* D7E14 800E7614 DBFF4014 */  bnez       $v0, .L800E7584
    /* D7E18 800E7618 3C001026 */   addiu     $s0, $s0, 0x3C
    /* D7E1C 800E761C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* D7E20 800E7620 2800B68F */  lw         $s6, 0x28($sp)
    /* D7E24 800E7624 2400B58F */  lw         $s5, 0x24($sp)
    /* D7E28 800E7628 2000B48F */  lw         $s4, 0x20($sp)
    /* D7E2C 800E762C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D7E30 800E7630 1800B28F */  lw         $s2, 0x18($sp)
    /* D7E34 800E7634 1400B18F */  lw         $s1, 0x14($sp)
    /* D7E38 800E7638 1000B08F */  lw         $s0, 0x10($sp)
    /* D7E3C 800E763C 0800E003 */  jr         $ra
    /* D7E40 800E7640 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSPCH_ClearOldEvents
