.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_create, 0x114

glabel SNDPKTPLAY_create
    /* F30FC 801028FC 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F3100 80102900 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* F3104 80102904 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F3108 80102908 1800B2AF */  sw         $s2, 0x18($sp)
    /* F310C 8010290C 21908000 */  addu       $s2, $a0, $zero
    /* F3110 80102910 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F3114 80102914 2198A000 */  addu       $s3, $a1, $zero
    /* F3118 80102918 2400B5AF */  sw         $s5, 0x24($sp)
    /* F311C 8010291C 21A8C000 */  addu       $s5, $a2, $zero
    /* F3120 80102920 2800B6AF */  sw         $s6, 0x28($sp)
    /* F3124 80102924 21B0E000 */  addu       $s6, $a3, $zero
    /* F3128 80102928 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F312C 8010292C 2000B4AF */  sw         $s4, 0x20($sp)
    /* F3130 80102930 1400B1AF */  sw         $s1, 0x14($sp)
    /* F3134 80102934 03004014 */  bnez       $v0, .L80102944
    /* F3138 80102938 1000B0AF */   sw        $s0, 0x10($sp)
    /* F313C 8010293C 7A0A0408 */  j          .L801029E8
    /* F3140 80102940 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L80102944:
    /* F3144 80102944 21880000 */  addu       $s1, $zero, $zero
    /* F3148 80102948 1580023C */  lui        $v0, %hi(sndpps)
    /* F314C 8010294C 74854324 */  addiu      $v1, $v0, %lo(sndpps)
  .L80102950:
    /* F3150 80102950 0000628C */  lw         $v0, 0x0($v1)
    /* F3154 80102954 00000000 */  nop
    /* F3158 80102958 06004010 */  beqz       $v0, .L80102974
    /* F315C 8010295C 80A01100 */   sll       $s4, $s1, 2
    /* F3160 80102960 01003126 */  addiu      $s1, $s1, 0x1
    /* F3164 80102964 FAFF201A */  blez       $s1, .L80102950
    /* F3168 80102968 04006324 */   addiu     $v1, $v1, 0x4
    /* F316C 8010296C 7A0A0408 */  j          .L801029E8
    /* F3170 80102970 F7FF0224 */   addiu     $v0, $zero, -0x9
  .L80102974:
    /* F3174 80102974 21202002 */  addu       $a0, $s1, $zero
    /* F3178 80102978 8710040C */  jal        iSNDplatformpacketplaycreate
    /* F317C 8010297C 21284002 */   addu      $a1, $s2, $zero
    /* F3180 80102980 18004004 */  bltz       $v0, .L801029E4
    /* F3184 80102984 00000000 */   nop
    /* F3188 80102988 6E10040C */  jal        iSNDplatformpacketoverhead
    /* F318C 8010298C 21804002 */   addu      $s0, $s2, $zero
    /* F3190 80102990 6E10040C */  jal        iSNDplatformpacketoverhead
    /* F3194 80102994 21904202 */   addu      $s2, $s2, $v0
    /* F3198 80102998 23986202 */  subu       $s3, $s3, $v0
    /* F319C 8010299C C0FF6326 */  addiu      $v1, $s3, -0x40
    /* F31A0 801029A0 AAAA023C */  lui        $v0, (0xAAAAAAAB >> 16)
    /* F31A4 801029A4 ABAA4234 */  ori        $v0, $v0, (0xAAAAAAAB & 0xFFFF)
    /* F31A8 801029A8 19006200 */  multu      $v1, $v0
    /* F31AC 801029AC 1580033C */  lui        $v1, %hi(sndpps)
    /* F31B0 801029B0 74856324 */  addiu      $v1, $v1, %lo(sndpps)
    /* F31B4 801029B4 21188302 */  addu       $v1, $s4, $v1
    /* F31B8 801029B8 000072AC */  sw         $s2, 0x0($v1)
    /* F31BC 801029BC 180050AE */  sw         $s0, 0x18($s2)
    /* F31C0 801029C0 1C0055AE */  sw         $s5, 0x1C($s2)
    /* F31C4 801029C4 200056AE */  sw         $s6, 0x20($s2)
    /* F31C8 801029C8 10400000 */  mfhi       $t0
    /* F31CC 801029CC 02190800 */  srl        $v1, $t0, 4
    /* F31D0 801029D0 080043A6 */  sh         $v1, 0x8($s2)
    /* F31D4 801029D4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* F31D8 801029D8 000043AE */  sw         $v1, 0x0($s2)
    /* F31DC 801029DC 7A0A0408 */  j          .L801029E8
    /* F31E0 801029E0 21102002 */   addu      $v0, $s1, $zero
  .L801029E4:
    /* F31E4 801029E4 FAFF0224 */  addiu      $v0, $zero, -0x6
  .L801029E8:
    /* F31E8 801029E8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F31EC 801029EC 2800B68F */  lw         $s6, 0x28($sp)
    /* F31F0 801029F0 2400B58F */  lw         $s5, 0x24($sp)
    /* F31F4 801029F4 2000B48F */  lw         $s4, 0x20($sp)
    /* F31F8 801029F8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F31FC 801029FC 1800B28F */  lw         $s2, 0x18($sp)
    /* F3200 80102A00 1400B18F */  lw         $s1, 0x14($sp)
    /* F3204 80102A04 1000B08F */  lw         $s0, 0x10($sp)
    /* F3208 80102A08 0800E003 */  jr         $ra
    /* F320C 80102A0C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SNDPKTPLAY_create
