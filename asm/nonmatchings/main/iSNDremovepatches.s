.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDremovepatches, 0x7C

glabel iSNDremovepatches
    /* D6DF8 800E65F8 E0F7BD27 */  addiu      $sp, $sp, -0x820
    /* D6DFC 800E65FC 1808B2AF */  sw         $s2, 0x818($sp)
    /* D6E00 800E6600 21908000 */  addu       $s2, $a0, $zero
    /* D6E04 800E6604 1408B1AF */  sw         $s1, 0x814($sp)
    /* D6E08 800E6608 2188A000 */  addu       $s1, $a1, $zero
    /* D6E0C 800E660C FFFF0324 */  addiu      $v1, $zero, -0x1
    /* D6E10 800E6610 1008B0AF */  sw         $s0, 0x810($sp)
    /* D6E14 800E6614 FF001024 */  addiu      $s0, $zero, 0xFF
    /* D6E18 800E6618 0808A227 */  addiu      $v0, $sp, 0x808
    /* D6E1C 800E661C 1C08BFAF */  sw         $ra, 0x81C($sp)
  .L800E6620:
    /* D6E20 800E6620 000043AC */  sw         $v1, 0x0($v0)
    /* D6E24 800E6624 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* D6E28 800E6628 FDFF0106 */  bgez       $s0, .L800E6620
    /* D6E2C 800E662C F8FF4224 */   addiu     $v0, $v0, -0x8
    /* D6E30 800E6630 0900201A */  blez       $s1, .L800E6658
    /* D6E34 800E6634 21800000 */   addu      $s0, $zero, $zero
    /* D6E38 800E6638 21204002 */  addu       $a0, $s2, $zero
  .L800E663C:
    /* D6E3C 800E663C 21280002 */  addu       $a1, $s0, $zero
    /* D6E40 800E6640 6DF9030C */  jal        iSNDbankremovepat
    /* D6E44 800E6644 1000A627 */   addiu     $a2, $sp, 0x10
    /* D6E48 800E6648 01001026 */  addiu      $s0, $s0, 0x1
    /* D6E4C 800E664C 2A101102 */  slt        $v0, $s0, $s1
    /* D6E50 800E6650 FAFF4014 */  bnez       $v0, .L800E663C
    /* D6E54 800E6654 21204002 */   addu      $a0, $s2, $zero
  .L800E6658:
    /* D6E58 800E6658 1C08BF8F */  lw         $ra, 0x81C($sp)
    /* D6E5C 800E665C 1808B28F */  lw         $s2, 0x818($sp)
    /* D6E60 800E6660 1408B18F */  lw         $s1, 0x814($sp)
    /* D6E64 800E6664 1008B08F */  lw         $s0, 0x810($sp)
    /* D6E68 800E6668 21100000 */  addu       $v0, $zero, $zero
    /* D6E6C 800E666C 0800E003 */  jr         $ra
    /* D6E70 800E6670 2008BD27 */   addiu     $sp, $sp, 0x820
endlabel iSNDremovepatches
