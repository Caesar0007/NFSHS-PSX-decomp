.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii, 0x1C0

glabel Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
    /* 9C7A4 800ABFA4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 9C7A8 800ABFA8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9C7AC 800ABFAC 21888000 */  addu       $s1, $a0, $zero
    /* 9C7B0 800ABFB0 2400BFAF */  sw         $ra, 0x24($sp)
    /* 9C7B4 800ABFB4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 9C7B8 800ABFB8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 9C7BC 800ABFBC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9C7C0 800ABFC0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9C7C4 800ABFC4 6004248E */  lw         $a0, 0x460($s1)
    /* 9C7C8 800ABFC8 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 9C7CC 800ABFCC F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 9C7D0 800ABFD0 00000000 */  nop
    /* 9C7D4 800ABFD4 18008200 */  mult       $a0, $v0
    /* 9C7D8 800ABFD8 21A0A000 */  addu       $s4, $a1, $zero
    /* 9C7DC 800ABFDC 2198C000 */  addu       $s3, $a2, $zero
    /* 9C7E0 800ABFE0 7405238E */  lw         $v1, 0x574($s1)
    /* 9C7E4 800ABFE4 12800000 */  mflo       $s0
    /* 9C7E8 800ABFE8 09006104 */  bgez       $v1, .L800AC010
    /* 9C7EC 800ABFEC 21900000 */   addu      $s2, $zero, $zero
    /* 9C7F0 800ABFF0 0700001A */  blez       $s0, .L800AC010
    /* 9C7F4 800ABFF4 00000000 */   nop
    /* 9C7F8 800ABFF8 C406258E */  lw         $a1, 0x6C4($s1)
    /* 9C7FC 800ABFFC 08002486 */  lh         $a0, 0x8($s1)
    /* 9C800 800AC000 EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 9C804 800AC004 0100A524 */   addiu     $a1, $a1, 0x1
    /* 9C808 800AC008 0D004010 */  beqz       $v0, .L800AC040
    /* 9C80C 800AC00C 00000000 */   nop
  .L800AC010:
    /* 9C810 800AC010 7405228E */  lw         $v0, 0x574($s1)
    /* 9C814 800AC014 00000000 */  nop
    /* 9C818 800AC018 0A004018 */  blez       $v0, .L800AC044
    /* 9C81C 800AC01C 00000000 */   nop
    /* 9C820 800AC020 08000106 */  bgez       $s0, .L800AC044
    /* 9C824 800AC024 00000000 */   nop
    /* 9C828 800AC028 C406258E */  lw         $a1, 0x6C4($s1)
    /* 9C82C 800AC02C 08002486 */  lh         $a0, 0x8($s1)
    /* 9C830 800AC030 EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 9C834 800AC034 FFFFA524 */   addiu     $a1, $a1, -0x1
    /* 9C838 800AC038 02004014 */  bnez       $v0, .L800AC044
    /* 9C83C 800AC03C 00000000 */   nop
  .L800AC040:
    /* 9C840 800AC040 01001224 */  addiu      $s2, $zero, 0x1
  .L800AC044:
    /* 9C844 800AC044 02004012 */  beqz       $s2, .L800AC050
    /* 9C848 800AC048 00000000 */   nop
    /* 9C84C 800AC04C 23801000 */  negu       $s0, $s0
  .L800AC050:
    /* 9C850 800AC050 1D00001A */  blez       $s0, .L800AC0C8
    /* 9C854 800AC054 07001024 */   addiu     $s0, $zero, 0x7
  .L800AC058:
    /* 9C858 800AC058 21286002 */  addu       $a1, $s3, $zero
    /* 9C85C 800AC05C 08002486 */  lh         $a0, 0x8($s1)
    /* 9C860 800AC060 6004268E */  lw         $a2, 0x460($s1)
    /* 9C864 800AC064 BCCC010C */  jal        AIWorld_IsDriveableLaneInSliceRange__Fiiii
    /* 9C868 800AC068 21380002 */   addu      $a3, $s0, $zero
    /* 9C86C 800AC06C 05004014 */  bnez       $v0, .L800AC084
    /* 9C870 800AC070 0A00022A */   slti      $v0, $s0, 0xA
    /* 9C874 800AC074 03004010 */  beqz       $v0, .L800AC084
    /* 9C878 800AC078 00000000 */   nop
    /* 9C87C 800AC07C 16B00208 */  j          .L800AC058
    /* 9C880 800AC080 01001026 */   addiu     $s0, $s0, 0x1
  .L800AC084:
    /* 9C884 800AC084 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 9C888 800AC088 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 9C88C 800AC08C 40111400 */  sll        $v0, $s4, 5
    /* 9C890 800AC090 21104300 */  addu       $v0, $v0, $v1
    /* 9C894 800AC094 1F004290 */  lbu        $v0, 0x1F($v0)
    /* 9C898 800AC098 F9FF0326 */  addiu      $v1, $s0, -0x7
    /* 9C89C 800AC09C C0130200 */  sll        $v0, $v0, 15
    /* 9C8A0 800AC0A0 18006200 */  mult       $v1, $v0
    /* 9C8A4 800AC0A4 42100200 */  srl        $v0, $v0, 1
    /* 9C8A8 800AC0A8 12400000 */  mflo       $t0
    /* 9C8AC 800AC0AC 04006018 */  blez       $v1, .L800AC0C0
    /* 9C8B0 800AC0B0 21200201 */   addu      $a0, $t0, $v0
    /* 9C8B4 800AC0B4 0100023C */  lui        $v0, (0x18000 >> 16)
    /* 9C8B8 800AC0B8 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
    /* 9C8BC 800AC0BC 21208200 */  addu       $a0, $a0, $v0
  .L800AC0C0:
    /* 9C8C0 800AC0C0 51B00208 */  j          .L800AC144
    /* 9C8C4 800AC0C4 21108000 */   addu      $v0, $a0, $zero
  .L800AC0C8:
    /* 9C8C8 800AC0C8 06001024 */  addiu      $s0, $zero, 0x6
  .L800AC0CC:
    /* 9C8CC 800AC0CC 21286002 */  addu       $a1, $s3, $zero
    /* 9C8D0 800AC0D0 08002486 */  lh         $a0, 0x8($s1)
    /* 9C8D4 800AC0D4 6004268E */  lw         $a2, 0x460($s1)
    /* 9C8D8 800AC0D8 BCCC010C */  jal        AIWorld_IsDriveableLaneInSliceRange__Fiiii
    /* 9C8DC 800AC0DC 21380002 */   addu      $a3, $s0, $zero
    /* 9C8E0 800AC0E0 05004014 */  bnez       $v0, .L800AC0F8
    /* 9C8E4 800AC0E4 0400022A */   slti      $v0, $s0, 0x4
    /* 9C8E8 800AC0E8 04004014 */  bnez       $v0, .L800AC0FC
    /* 9C8EC 800AC0EC 06000324 */   addiu     $v1, $zero, 0x6
    /* 9C8F0 800AC0F0 33B00208 */  j          .L800AC0CC
    /* 9C8F4 800AC0F4 FFFF1026 */   addiu     $s0, $s0, -0x1
  .L800AC0F8:
    /* 9C8F8 800AC0F8 06000324 */  addiu      $v1, $zero, 0x6
  .L800AC0FC:
    /* 9C8FC 800AC0FC 1480043C */  lui        $a0, %hi(BWorldSm_slices)
    /* 9C900 800AC100 C0C7848C */  lw         $a0, %lo(BWorldSm_slices)($a0)
    /* 9C904 800AC104 40111400 */  sll        $v0, $s4, 5
    /* 9C908 800AC108 21104400 */  addu       $v0, $v0, $a0
    /* 9C90C 800AC10C 1E004290 */  lbu        $v0, 0x1E($v0)
    /* 9C910 800AC110 23187000 */  subu       $v1, $v1, $s0
    /* 9C914 800AC114 C0130200 */  sll        $v0, $v0, 15
    /* 9C918 800AC118 18006200 */  mult       $v1, $v0
    /* 9C91C 800AC11C 42100200 */  srl        $v0, $v0, 1
    /* 9C920 800AC120 12400000 */  mflo       $t0
    /* 9C924 800AC124 06006018 */  blez       $v1, .L800AC140
    /* 9C928 800AC128 21200201 */   addu      $a0, $t0, $v0
    /* 9C92C 800AC12C 0100023C */  lui        $v0, (0x18000 >> 16)
    /* 9C930 800AC130 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
    /* 9C934 800AC134 21108200 */  addu       $v0, $a0, $v0
    /* 9C938 800AC138 51B00208 */  j          .L800AC144
    /* 9C93C 800AC13C 23100200 */   negu      $v0, $v0
  .L800AC140:
    /* 9C940 800AC140 23100400 */  negu       $v0, $a0
  .L800AC144:
    /* 9C944 800AC144 2400BF8F */  lw         $ra, 0x24($sp)
    /* 9C948 800AC148 2000B48F */  lw         $s4, 0x20($sp)
    /* 9C94C 800AC14C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 9C950 800AC150 1800B28F */  lw         $s2, 0x18($sp)
    /* 9C954 800AC154 1400B18F */  lw         $s1, 0x14($sp)
    /* 9C958 800AC158 1000B08F */  lw         $s0, 0x10($sp)
    /* 9C95C 800AC15C 0800E003 */  jr         $ra
    /* 9C960 800AC160 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
