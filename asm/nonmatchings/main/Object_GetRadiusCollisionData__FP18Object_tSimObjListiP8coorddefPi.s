.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi, 0x10C

glabel Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
    /* 957E8 800A4FE8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 957EC 800A4FEC 21108000 */  addu       $v0, $a0, $zero
    /* 957F0 800A4FF0 2120A000 */  addu       $a0, $a1, $zero
    /* 957F4 800A4FF4 21284000 */  addu       $a1, $v0, $zero
    /* 957F8 800A4FF8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 957FC 800A4FFC 2190C000 */  addu       $s2, $a2, $zero
    /* 95800 800A5000 1800A627 */  addiu      $a2, $sp, 0x18
    /* 95804 800A5004 2400B1AF */  sw         $s1, 0x24($sp)
    /* 95808 800A5008 2188E000 */  addu       $s1, $a3, $zero
    /* 9580C 800A500C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 95810 800A5010 C593020C */  jal        GetSimObj__FiP18Object_tSimObjListPi
    /* 95814 800A5014 2000B0AF */   sw        $s0, 0x20($sp)
    /* 95818 800A5018 21804000 */  addu       $s0, $v0, $zero
    /* 9581C 800A501C 2D000012 */  beqz       $s0, .L800A50D4
    /* 95820 800A5020 00000000 */   nop
    /* 95824 800A5024 13000292 */  lbu        $v0, 0x13($s0)
    /* 95828 800A5028 00000000 */  nop
    /* 9582C 800A502C 80004230 */  andi       $v0, $v0, 0x80
    /* 95830 800A5030 1D004010 */  beqz       $v0, .L800A50A8
    /* 95834 800A5034 1180023C */   lui       $v0, %hi(gSimObjAnims)
    /* 95838 800A5038 0E000386 */  lh         $v1, 0xE($s0)
    /* 9583C 800A503C 605D4224 */  addiu      $v0, $v0, %lo(gSimObjAnims)
    /* 95840 800A5040 80180300 */  sll        $v1, $v1, 2
    /* 95844 800A5044 21186200 */  addu       $v1, $v1, $v0
    /* 95848 800A5048 0000628C */  lw         $v0, 0x0($v1)
    /* 9584C 800A504C 00000000 */  nop
    /* 95850 800A5050 15004014 */  bnez       $v0, .L800A50A8
    /* 95854 800A5054 00000000 */   nop
    /* 95858 800A5058 1800A38F */  lw         $v1, 0x18($sp)
    /* 9585C 800A505C 12000592 */  lbu        $a1, 0x12($s0)
    /* 95860 800A5060 C0100300 */  sll        $v0, $v1, 3
    /* 95864 800A5064 23104300 */  subu       $v0, $v0, $v1
    /* 95868 800A5068 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 9586C 800A506C B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 95870 800A5070 00110200 */  sll        $v0, $v0, 4
    /* 95874 800A5074 21186200 */  addu       $v1, $v1, $v0
    /* 95878 800A5078 4000648C */  lw         $a0, 0x40($v1)
    /* 9587C 800A507C 2393020C */  jal        FindObjInstanceFromSerialNum__FP5Groupi
    /* 95880 800A5080 00000000 */   nop
    /* 95884 800A5084 21204000 */  addu       $a0, $v0, $zero
    /* 95888 800A5088 01000524 */  addiu      $a1, $zero, 0x1
    /* 9588C 800A508C 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 95890 800A5090 B0E0468C */  lw         $a2, %lo(D_8011E0B0)($v0)
    /* 95894 800A5094 1C00A227 */  addiu      $v0, $sp, 0x1C
    /* 95898 800A5098 21380002 */  addu       $a3, $s0, $zero
    /* 9589C 800A509C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 958A0 800A50A0 4BD0010C */  jal        Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
    /* 958A4 800A50A4 1400A2AF */   sw        $v0, 0x14($sp)
  .L800A50A8:
    /* 958A8 800A50A8 0000088E */  lw         $t0, 0x0($s0)
    /* 958AC 800A50AC 0400098E */  lw         $t1, 0x4($s0)
    /* 958B0 800A50B0 08000A8E */  lw         $t2, 0x8($s0)
    /* 958B4 800A50B4 000048AE */  sw         $t0, 0x0($s2)
    /* 958B8 800A50B8 040049AE */  sw         $t1, 0x4($s2)
    /* 958BC 800A50BC 08004AAE */  sw         $t2, 0x8($s2)
    /* 958C0 800A50C0 0C000286 */  lh         $v0, 0xC($s0)
    /* 958C4 800A50C4 00000000 */  nop
    /* 958C8 800A50C8 C0110200 */  sll        $v0, $v0, 7
    /* 958CC 800A50CC 36940208 */  j          .L800A50D8
    /* 958D0 800A50D0 000022AE */   sw        $v0, 0x0($s1)
  .L800A50D4:
    /* 958D4 800A50D4 000020AE */  sw         $zero, 0x0($s1)
  .L800A50D8:
    /* 958D8 800A50D8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 958DC 800A50DC 2800B28F */  lw         $s2, 0x28($sp)
    /* 958E0 800A50E0 2400B18F */  lw         $s1, 0x24($sp)
    /* 958E4 800A50E4 2000B08F */  lw         $s0, 0x20($sp)
    /* 958E8 800A50E8 21100000 */  addu       $v0, $zero, $zero
    /* 958EC 800A50EC 0800E003 */  jr         $ra
    /* 958F0 800A50F0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
