.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_InitPersistentData__FP15SerializedGroup, 0x1DC

glabel Track_InitPersistentData__FP15SerializedGroup
    /* AAE2C 800BA62C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AAE30 800BA630 2400BEAF */  sw         $fp, 0x24($sp)
    /* AAE34 800BA634 21F0A003 */  addu       $fp, $sp, $zero
    /* AAE38 800BA638 1800B2AF */  sw         $s2, 0x18($sp)
    /* AAE3C 800BA63C 21908000 */  addu       $s2, $a0, $zero
    /* AAE40 800BA640 2800BFAF */  sw         $ra, 0x28($sp)
    /* AAE44 800BA644 2000B4AF */  sw         $s4, 0x20($sp)
    /* AAE48 800BA648 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* AAE4C 800BA64C 1400B1AF */  sw         $s1, 0x14($sp)
    /* AAE50 800BA650 1000B0AF */  sw         $s0, 0x10($sp)
    /* AAE54 800BA654 0C00428E */  lw         $v0, 0xC($s2)
    /* AAE58 800BA658 21800000 */  addu       $s0, $zero, $zero
    /* AAE5C 800BA65C 940F80AF */  sw         $zero, %gp_rel(gObjDefOffsetsGroup)($gp)
    /* AAE60 800BA660 40110200 */  sll        $v0, $v0, 5
    /* AAE64 800BA664 C2100200 */  srl        $v0, $v0, 3
    /* AAE68 800BA668 07004224 */  addiu      $v0, $v0, 0x7
    /* AAE6C 800BA66C C2100200 */  srl        $v0, $v0, 3
    /* AAE70 800BA670 C0100200 */  sll        $v0, $v0, 3
    /* AAE74 800BA674 23E8A203 */  subu       $sp, $sp, $v0
    /* AAE78 800BA678 0C00428E */  lw         $v0, 0xC($s2)
    /* AAE7C 800BA67C 00000000 */  nop
    /* AAE80 800BA680 0B004018 */  blez       $v0, .L800BA6B0
    /* AAE84 800BA684 1000B327 */   addiu     $s3, $sp, 0x10
    /* AAE88 800BA688 21886002 */  addu       $s1, $s3, $zero
  .L800BA68C:
    /* AAE8C 800BA68C 21204002 */  addu       $a0, $s2, $zero
    /* AAE90 800BA690 7070020C */  jal        LocateGroupNum__15SerializedGroupi
    /* AAE94 800BA694 21280002 */   addu      $a1, $s0, $zero
    /* AAE98 800BA698 000022AE */  sw         $v0, 0x0($s1)
    /* AAE9C 800BA69C 0C00428E */  lw         $v0, 0xC($s2)
    /* AAEA0 800BA6A0 01001026 */  addiu      $s0, $s0, 0x1
    /* AAEA4 800BA6A4 2A100202 */  slt        $v0, $s0, $v0
    /* AAEA8 800BA6A8 F8FF4014 */  bnez       $v0, .L800BA68C
    /* AAEAC 800BA6AC 04003126 */   addiu     $s1, $s1, 0x4
  .L800BA6B0:
    /* AAEB0 800BA6B0 21204002 */  addu       $a0, $s2, $zero
    /* AAEB4 800BA6B4 08000524 */  addiu      $a1, $zero, 0x8
    /* AAEB8 800BA6B8 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AAEBC 800BA6BC 21300000 */   addu      $a2, $zero, $zero
    /* AAEC0 800BA6C0 0C00528E */  lw         $s2, 0xC($s2)
    /* AAEC4 800BA6C4 21880000 */  addu       $s1, $zero, $zero
    /* AAEC8 800BA6C8 0580023C */  lui        $v0, %hi(jtbl_80056690)
    /* AAECC 800BA6CC 90665424 */  addiu      $s4, $v0, %lo(jtbl_80056690)
    /* AAED0 800BA6D0 21806002 */  addu       $s0, $s3, $zero
  .L800BA6D4:
    /* AAED4 800BA6D4 2A103202 */  slt        $v0, $s1, $s2
    /* AAED8 800BA6D8 3B004010 */  beqz       $v0, .L800BA7C8
    /* AAEDC 800BA6DC 00000000 */   nop
    /* AAEE0 800BA6E0 0000028E */  lw         $v0, 0x0($s0)
    /* AAEE4 800BA6E4 00000000 */  nop
    /* AAEE8 800BA6E8 0000428C */  lw         $v0, 0x0($v0)
    /* AAEEC 800BA6EC 00000000 */  nop
    /* AAEF0 800BA6F0 FEFF4324 */  addiu      $v1, $v0, -0x2
    /* AAEF4 800BA6F4 2500622C */  sltiu      $v0, $v1, 0x25
    /* AAEF8 800BA6F8 30004010 */  beqz       $v0, .L800BA7BC
    /* AAEFC 800BA6FC 80100300 */   sll       $v0, $v1, 2
    /* AAF00 800BA700 21105400 */  addu       $v0, $v0, $s4
    /* AAF04 800BA704 0000428C */  lw         $v0, 0x0($v0)
    /* AAF08 800BA708 00000000 */  nop
    /* AAF0C 800BA70C 08004000 */  jr         $v0
    /* AAF10 800BA710 00000000 */   nop
  jlabel .L800BA714
    /* AAF14 800BA714 0000048E */  lw         $a0, 0x0($s0)
    /* AAF18 800BA718 00000000 */  nop
    /* AAF1C 800BA71C 0400858C */  lw         $a1, 0x4($a0)
    /* AAF20 800BA720 840F868F */  lw         $a2, %gp_rel(Track_materials)($gp)
    /* AAF24 800BA724 A6E7020C */  jal        Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
    /* AAF28 800BA728 F0FFA524 */   addiu     $a1, $a1, -0x10
    /* AAF2C 800BA72C F0E90208 */  j          .L800BA7C0
    /* AAF30 800BA730 04001026 */   addiu     $s0, $s0, 0x4
  jlabel .L800BA734
    /* AAF34 800BA734 0000048E */  lw         $a0, 0x0($s0)
    /* AAF38 800BA738 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AAF3C 800BA73C 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* AAF40 800BA740 21288000 */   addu      $a1, $a0, $zero
    /* AAF44 800BA744 44FA010C */  jal        BWorldSm_Init__FP5Group
    /* AAF48 800BA748 21204000 */   addu      $a0, $v0, $zero
    /* AAF4C 800BA74C F0E90208 */  j          .L800BA7C0
    /* AAF50 800BA750 04001026 */   addiu     $s0, $s0, 0x4
  jlabel .L800BA754
    /* AAF54 800BA754 0000048E */  lw         $a0, 0x0($s0)
    /* AAF58 800BA758 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AAF5C 800BA75C 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* AAF60 800BA760 21288000 */   addu      $a1, $a0, $zero
    /* AAF64 800BA764 780F82AF */  sw         $v0, %gp_rel(gPersistMidgroundObjInst)($gp)
    /* AAF68 800BA768 F0E90208 */  j          .L800BA7C0
    /* AAF6C 800BA76C 04001026 */   addiu     $s0, $s0, 0x4
  jlabel .L800BA770
    /* AAF70 800BA770 0000048E */  lw         $a0, 0x0($s0)
    /* AAF74 800BA774 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AAF78 800BA778 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* AAF7C 800BA77C 21288000 */   addu      $a1, $a0, $zero
    /* AAF80 800BA780 740F82AF */  sw         $v0, %gp_rel(gPersistObjInst)($gp)
    /* AAF84 800BA784 F0E90208 */  j          .L800BA7C0
    /* AAF88 800BA788 04001026 */   addiu     $s0, $s0, 0x4
  jlabel .L800BA78C
    /* AAF8C 800BA78C 0000048E */  lw         $a0, 0x0($s0)
    /* AAF90 800BA790 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AAF94 800BA794 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* AAF98 800BA798 21288000 */   addu      $a1, $a0, $zero
    /* AAF9C 800BA79C 700F82AF */  sw         $v0, %gp_rel(gPersistObjDef)($gp)
    /* AAFA0 800BA7A0 F0E90208 */  j          .L800BA7C0
    /* AAFA4 800BA7A4 04001026 */   addiu     $s0, $s0, 0x4
  jlabel .L800BA7A8
    /* AAFA8 800BA7A8 0000048E */  lw         $a0, 0x0($s0)
    /* AAFAC 800BA7AC 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AAFB0 800BA7B0 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* AAFB4 800BA7B4 21288000 */   addu      $a1, $a0, $zero
    /* AAFB8 800BA7B8 940F82AF */  sw         $v0, %gp_rel(gObjDefOffsetsGroup)($gp)
  jlabel .L800BA7BC
    /* AAFBC 800BA7BC 04001026 */  addiu      $s0, $s0, 0x4
  .L800BA7C0:
    /* AAFC0 800BA7C0 B5E90208 */  j          .L800BA6D4
    /* AAFC4 800BA7C4 01003126 */   addiu     $s1, $s1, 0x1
  .L800BA7C8:
    /* AAFC8 800BA7C8 940F828F */  lw         $v0, %gp_rel(gObjDefOffsetsGroup)($gp)
    /* AAFCC 800BA7CC 00000000 */  nop
    /* AAFD0 800BA7D0 03004010 */  beqz       $v0, .L800BA7E0
    /* AAFD4 800BA7D4 00000000 */   nop
    /* AAFD8 800BA7D8 72E9020C */  jal        CalcObjDefPtrs__Fv
    /* AAFDC 800BA7DC 00000000 */   nop
  .L800BA7E0:
    /* AAFE0 800BA7E0 21E8C003 */  addu       $sp, $fp, $zero
    /* AAFE4 800BA7E4 2800BF8F */  lw         $ra, 0x28($sp)
    /* AAFE8 800BA7E8 2400BE8F */  lw         $fp, 0x24($sp)
    /* AAFEC 800BA7EC 2000B48F */  lw         $s4, 0x20($sp)
    /* AAFF0 800BA7F0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* AAFF4 800BA7F4 1800B28F */  lw         $s2, 0x18($sp)
    /* AAFF8 800BA7F8 1400B18F */  lw         $s1, 0x14($sp)
    /* AAFFC 800BA7FC 1000B08F */  lw         $s0, 0x10($sp)
    /* AB000 800BA800 0800E003 */  jr         $ra
    /* AB004 800BA804 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Track_InitPersistentData__FP15SerializedGroup
