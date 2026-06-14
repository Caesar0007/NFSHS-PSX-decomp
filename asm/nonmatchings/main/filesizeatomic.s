.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching filesizeatomic, 0x64

glabel filesizeatomic
    /* D5E08 800E5608 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D5E0C 800E560C 1800B0AF */  sw         $s0, 0x18($sp)
    /* D5E10 800E5610 21808000 */  addu       $s0, $a0, $zero
    /* D5E14 800E5614 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D5E18 800E5618 0000A48C */  lw         $a0, 0x0($a1)
    /* D5E1C 800E561C 01000524 */  addiu      $a1, $zero, 0x1
    /* D5E20 800E5620 21300002 */  addu       $a2, $s0, $zero
    /* D5E24 800E5624 2AAA030C */  jal        FILE_opensync
    /* D5E28 800E5628 1000A727 */   addiu     $a3, $sp, 0x10
    /* D5E2C 800E562C 03004014 */  bnez       $v0, .L800E563C
    /* D5E30 800E5630 FFFF1026 */   addiu     $s0, $s0, -0x1
    /* D5E34 800E5634 97950308 */  j          .L800E565C
    /* D5E38 800E5638 21100000 */   addu      $v0, $zero, $zero
  .L800E563C:
    /* D5E3C 800E563C 1000A48F */  lw         $a0, 0x10($sp)
    /* D5E40 800E5640 69AA030C */  jal        FILE_sizesync
    /* D5E44 800E5644 21280002 */   addu      $a1, $s0, $zero
    /* D5E48 800E5648 21280002 */  addu       $a1, $s0, $zero
    /* D5E4C 800E564C 1000A48F */  lw         $a0, 0x10($sp)
    /* D5E50 800E5650 54AA030C */  jal        FILE_closesync
    /* D5E54 800E5654 21804000 */   addu      $s0, $v0, $zero
    /* D5E58 800E5658 21100002 */  addu       $v0, $s0, $zero
  .L800E565C:
    /* D5E5C 800E565C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D5E60 800E5660 1800B08F */  lw         $s0, 0x18($sp)
    /* D5E64 800E5664 0800E003 */  jr         $ra
    /* D5E68 800E5668 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel filesizeatomic
