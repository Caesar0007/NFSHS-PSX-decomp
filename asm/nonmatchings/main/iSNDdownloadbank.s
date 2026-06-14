.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdownloadbank, 0x150

glabel iSNDdownloadbank
    /* F2E6C 8010266C C8F7BD27 */  addiu      $sp, $sp, -0x838
    /* F2E70 80102670 2008B4AF */  sw         $s4, 0x820($sp)
    /* F2E74 80102674 21A08000 */  addu       $s4, $a0, $zero
    /* F2E78 80102678 2808B6AF */  sw         $s6, 0x828($sp)
    /* F2E7C 8010267C 07001624 */  addiu      $s6, $zero, 0x7
    /* F2E80 80102680 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* F2E84 80102684 1008B0AF */  sw         $s0, 0x810($sp)
    /* F2E88 80102688 FF001024 */  addiu      $s0, $zero, 0xFF
    /* F2E8C 8010268C 0808A227 */  addiu      $v0, $sp, 0x808
    /* F2E90 80102690 3408BFAF */  sw         $ra, 0x834($sp)
    /* F2E94 80102694 3008BEAF */  sw         $fp, 0x830($sp)
    /* F2E98 80102698 2C08B7AF */  sw         $s7, 0x82C($sp)
    /* F2E9C 8010269C 2408B5AF */  sw         $s5, 0x824($sp)
    /* F2EA0 801026A0 1C08B3AF */  sw         $s3, 0x81C($sp)
    /* F2EA4 801026A4 1808B2AF */  sw         $s2, 0x818($sp)
    /* F2EA8 801026A8 1408B1AF */  sw         $s1, 0x814($sp)
    /* F2EAC 801026AC 3C08A5AF */  sw         $a1, 0x83C($sp)
  .L801026B0:
    /* F2EB0 801026B0 000043AC */  sw         $v1, 0x0($v0)
    /* F2EB4 801026B4 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* F2EB8 801026B8 FDFF0106 */  bgez       $s0, .L801026B0
    /* F2EBC 801026BC F8FF4224 */   addiu     $v0, $v0, -0x8
    /* F2EC0 801026C0 21F08002 */  addu       $fp, $s4, $zero
    /* F2EC4 801026C4 06008296 */  lhu        $v0, 0x6($s4)
    /* F2EC8 801026C8 00000000 */  nop
    /* F2ECC 801026CC 2E004010 */  beqz       $v0, .L80102788
    /* F2ED0 801026D0 21800000 */   addu      $s0, $zero, $zero
    /* F2ED4 801026D4 04001724 */  addiu      $s7, $zero, 0x4
    /* F2ED8 801026D8 0C001524 */  addiu      $s5, $zero, 0xC
    /* F2EDC 801026DC 21908002 */  addu       $s2, $s4, $zero
    /* F2EE0 801026E0 14001324 */  addiu      $s3, $zero, 0x14
    /* F2EE4 801026E4 21888002 */  addu       $s1, $s4, $zero
  .L801026E8:
    /* F2EE8 801026E8 04008292 */  lbu        $v0, 0x4($s4)
    /* F2EEC 801026EC 00000000 */  nop
    /* F2EF0 801026F0 04005714 */  bne        $v0, $s7, .L80102704
    /* F2EF4 801026F4 00000000 */   nop
    /* F2EF8 801026F8 1400228E */  lw         $v0, 0x14($s1)
    /* F2EFC 801026FC C2090408 */  j          .L80102708
    /* F2F00 80102700 00000000 */   nop
  .L80102704:
    /* F2F04 80102704 0C00428E */  lw         $v0, 0xC($s2)
  .L80102708:
    /* F2F08 80102708 00000000 */  nop
    /* F2F0C 8010270C 16004010 */  beqz       $v0, .L80102768
    /* F2F10 80102710 00000000 */   nop
    /* F2F14 80102714 04008292 */  lbu        $v0, 0x4($s4)
    /* F2F18 80102718 00000000 */  nop
    /* F2F1C 8010271C 06005714 */  bne        $v0, $s7, .L80102738
    /* F2F20 80102720 2110D503 */   addu      $v0, $fp, $s5
    /* F2F24 80102724 1400238E */  lw         $v1, 0x14($s1)
    /* F2F28 80102728 21109302 */  addu       $v0, $s4, $s3
    /* F2F2C 8010272C 21104300 */  addu       $v0, $v0, $v1
    /* F2F30 80102730 D2090408 */  j          .L80102748
    /* F2F34 80102734 140022AE */   sw        $v0, 0x14($s1)
  .L80102738:
    /* F2F38 80102738 0C00438E */  lw         $v1, 0xC($s2)
    /* F2F3C 8010273C 00000000 */  nop
    /* F2F40 80102740 21104300 */  addu       $v0, $v0, $v1
    /* F2F44 80102744 0C0042AE */  sw         $v0, 0xC($s2)
  .L80102748:
    /* F2F48 80102748 21204000 */  addu       $a0, $v0, $zero
    /* F2F4C 8010274C 3C08A58F */  lw         $a1, 0x83C($sp)
    /* F2F50 80102750 3B09040C */  jal        iSNDresolvetaggedpatch
    /* F2F54 80102754 1000A627 */   addiu     $a2, $sp, 0x10
    /* F2F58 80102758 07000324 */  addiu      $v1, $zero, 0x7
    /* F2F5C 8010275C 02004310 */  beq        $v0, $v1, .L80102768
    /* F2F60 80102760 00000000 */   nop
    /* F2F64 80102764 08001624 */  addiu      $s6, $zero, 0x8
  .L80102768:
    /* F2F68 80102768 0400B526 */  addiu      $s5, $s5, 0x4
    /* F2F6C 8010276C 04005226 */  addiu      $s2, $s2, 0x4
    /* F2F70 80102770 04007326 */  addiu      $s3, $s3, 0x4
    /* F2F74 80102774 06008296 */  lhu        $v0, 0x6($s4)
    /* F2F78 80102778 01001026 */  addiu      $s0, $s0, 0x1
    /* F2F7C 8010277C 2A100202 */  slt        $v0, $s0, $v0
    /* F2F80 80102780 D9FF4014 */  bnez       $v0, .L801026E8
    /* F2F84 80102784 04003126 */   addiu     $s1, $s1, 0x4
  .L80102788:
    /* F2F88 80102788 2110C002 */  addu       $v0, $s6, $zero
    /* F2F8C 8010278C 3408BF8F */  lw         $ra, 0x834($sp)
    /* F2F90 80102790 3008BE8F */  lw         $fp, 0x830($sp)
    /* F2F94 80102794 2C08B78F */  lw         $s7, 0x82C($sp)
    /* F2F98 80102798 2808B68F */  lw         $s6, 0x828($sp)
    /* F2F9C 8010279C 2408B58F */  lw         $s5, 0x824($sp)
    /* F2FA0 801027A0 2008B48F */  lw         $s4, 0x820($sp)
    /* F2FA4 801027A4 1C08B38F */  lw         $s3, 0x81C($sp)
    /* F2FA8 801027A8 1808B28F */  lw         $s2, 0x818($sp)
    /* F2FAC 801027AC 1408B18F */  lw         $s1, 0x814($sp)
    /* F2FB0 801027B0 1008B08F */  lw         $s0, 0x810($sp)
    /* F2FB4 801027B4 0800E003 */  jr         $ra
    /* F2FB8 801027B8 3808BD27 */   addiu     $sp, $sp, 0x838
endlabel iSNDdownloadbank
