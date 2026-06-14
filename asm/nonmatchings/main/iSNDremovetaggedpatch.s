.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDremovetaggedpatch, 0xAC

glabel iSNDremovetaggedpatch
    /* F2DC0 801025C0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F2DC4 801025C4 2000B0AF */  sw         $s0, 0x20($sp)
    /* F2DC8 801025C8 21808000 */  addu       $s0, $a0, $zero
    /* F2DCC 801025CC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F2DD0 801025D0 2800B2AF */  sw         $s2, 0x28($sp)
    /* F2DD4 801025D4 2400B1AF */  sw         $s1, 0x24($sp)
    /* F2DD8 801025D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* F2DDC 801025DC 03000292 */  lbu        $v0, 0x3($s0)
    /* F2DE0 801025E0 00000000 */  nop
    /* F2DE4 801025E4 02004230 */  andi       $v0, $v0, 0x2
    /* F2DE8 801025E8 03004010 */  beqz       $v0, .L801025F8
    /* F2DEC 801025EC 2190A000 */   addu      $s2, $a1, $zero
    /* F2DF0 801025F0 7F090408 */  j          .L801025FC
    /* F2DF4 801025F4 08000226 */   addiu     $v0, $s0, 0x8
  .L801025F8:
    /* F2DF8 801025F8 04000226 */  addiu      $v0, $s0, 0x4
  .L801025FC:
    /* F2DFC 801025FC 1000A2AF */  sw         $v0, 0x10($sp)
    /* F2E00 80102600 FD001124 */  addiu      $s1, $zero, 0xFD
    /* F2E04 80102604 1000A427 */  addiu      $a0, $sp, 0x10
  .L80102608:
    /* F2E08 80102608 1400A527 */  addiu      $a1, $sp, 0x14
    /* F2E0C 8010260C 1800A627 */  addiu      $a2, $sp, 0x18
    /* F2E10 80102610 542F040C */  jal        iSNDgettag
    /* F2E14 80102614 1C00A727 */   addiu     $a3, $sp, 0x1C
    /* F2E18 80102618 0A004010 */  beqz       $v0, .L80102644
    /* F2E1C 8010261C 21100000 */   addu      $v0, $zero, $zero
    /* F2E20 80102620 1400A28F */  lw         $v0, 0x14($sp)
    /* F2E24 80102624 00000000 */  nop
    /* F2E28 80102628 F7FF5114 */  bne        $v0, $s1, .L80102608
    /* F2E2C 8010262C 1000A427 */   addiu     $a0, $sp, 0x10
    /* F2E30 80102630 1000A48F */  lw         $a0, 0x10($sp)
    /* F2E34 80102634 562E040C */  jal        iSNDplatformremove
    /* F2E38 80102638 21284002 */   addu      $a1, $s2, $zero
    /* F2E3C 8010263C 82090408 */  j          .L80102608
    /* F2E40 80102640 1000A427 */   addiu     $a0, $sp, 0x10
  .L80102644:
    /* F2E44 80102644 03000392 */  lbu        $v1, 0x3($s0)
    /* F2E48 80102648 00000000 */  nop
    /* F2E4C 8010264C FE006330 */  andi       $v1, $v1, 0xFE
    /* F2E50 80102650 030003A2 */  sb         $v1, 0x3($s0)
    /* F2E54 80102654 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F2E58 80102658 2800B28F */  lw         $s2, 0x28($sp)
    /* F2E5C 8010265C 2400B18F */  lw         $s1, 0x24($sp)
    /* F2E60 80102660 2000B08F */  lw         $s0, 0x20($sp)
    /* F2E64 80102664 0800E003 */  jr         $ra
    /* F2E68 80102668 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDremovetaggedpatch
