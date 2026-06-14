.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i, 0x128

glabel CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
    /* CF0C4 800DE8C4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CF0C8 800DE8C8 2000B4AF */  sw         $s4, 0x20($sp)
    /* CF0CC 800DE8CC 21A08000 */  addu       $s4, $a0, $zero
    /* CF0D0 800DE8D0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CF0D4 800DE8D4 2198A000 */  addu       $s3, $a1, $zero
    /* CF0D8 800DE8D8 1000B0AF */  sw         $s0, 0x10($sp)
    /* CF0DC 800DE8DC 2180E000 */  addu       $s0, $a3, $zero
    /* CF0E0 800DE8E0 2400BFAF */  sw         $ra, 0x24($sp)
    /* CF0E4 800DE8E4 1800B2AF */  sw         $s2, 0x18($sp)
    /* CF0E8 800DE8E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* CF0EC 800DE8EC 0000038E */  lw         $v1, 0x0($s0)
    /* CF0F0 800DE8F0 0000C48C */  lw         $a0, 0x0($a2)
    /* CF0F4 800DE8F4 0800028E */  lw         $v0, 0x8($s0)
    /* CF0F8 800DE8F8 0800C58C */  lw         $a1, 0x8($a2)
    /* CF0FC 800DE8FC 3800B28F */  lw         $s2, 0x38($sp)
    /* CF100 800DE900 23206400 */  subu       $a0, $v1, $a0
    /* CF104 800DE904 CE96030C */  jal        intatan
    /* CF108 800DE908 23284500 */   subu      $a1, $v0, $a1
    /* CF10C 800DE90C 21884000 */  addu       $s1, $v0, $zero
    /* CF110 800DE910 39C6030C */  jal        intcos
    /* CF114 800DE914 21202002 */   addu      $a0, $s1, $zero
    /* CF118 800DE918 21204002 */  addu       $a0, $s2, $zero
    /* CF11C 800DE91C CA90030C */  jal        fixedmult
    /* CF120 800DE920 23280200 */   negu      $a1, $v0
    /* CF124 800DE924 21202002 */  addu       $a0, $s1, $zero
    /* CF128 800DE928 3AC6030C */  jal        intsin
    /* CF12C 800DE92C 43880200 */   sra       $s1, $v0, 1
    /* CF130 800DE930 21204002 */  addu       $a0, $s2, $zero
    /* CF134 800DE934 CA90030C */  jal        fixedmult
    /* CF138 800DE938 21284000 */   addu      $a1, $v0, $zero
    /* CF13C 800DE93C 0000038E */  lw         $v1, 0x0($s0)
    /* CF140 800DE940 0000648E */  lw         $a0, 0x0($s3)
    /* CF144 800DE944 21187100 */  addu       $v1, $v1, $s1
    /* CF148 800DE948 23186400 */  subu       $v1, $v1, $a0
    /* CF14C 800DE94C 83190300 */  sra        $v1, $v1, 6
    /* CF150 800DE950 000083A6 */  sh         $v1, 0x0($s4)
    /* CF154 800DE954 0400038E */  lw         $v1, 0x4($s0)
    /* CF158 800DE958 0400648E */  lw         $a0, 0x4($s3)
    /* CF15C 800DE95C 43100200 */  sra        $v0, $v0, 1
    /* CF160 800DE960 23186400 */  subu       $v1, $v1, $a0
    /* CF164 800DE964 83190300 */  sra        $v1, $v1, 6
    /* CF168 800DE968 020083A6 */  sh         $v1, 0x2($s4)
    /* CF16C 800DE96C 0800038E */  lw         $v1, 0x8($s0)
    /* CF170 800DE970 0800648E */  lw         $a0, 0x8($s3)
    /* CF174 800DE974 21186200 */  addu       $v1, $v1, $v0
    /* CF178 800DE978 23186400 */  subu       $v1, $v1, $a0
    /* CF17C 800DE97C 83190300 */  sra        $v1, $v1, 6
    /* CF180 800DE980 040083A6 */  sh         $v1, 0x4($s4)
    /* CF184 800DE984 0000038E */  lw         $v1, 0x0($s0)
    /* CF188 800DE988 0000648E */  lw         $a0, 0x0($s3)
    /* CF18C 800DE98C 23187100 */  subu       $v1, $v1, $s1
    /* CF190 800DE990 23186400 */  subu       $v1, $v1, $a0
    /* CF194 800DE994 83190300 */  sra        $v1, $v1, 6
    /* CF198 800DE998 080083A6 */  sh         $v1, 0x8($s4)
    /* CF19C 800DE99C 0400038E */  lw         $v1, 0x4($s0)
    /* CF1A0 800DE9A0 0400648E */  lw         $a0, 0x4($s3)
    /* CF1A4 800DE9A4 00000000 */  nop
    /* CF1A8 800DE9A8 23186400 */  subu       $v1, $v1, $a0
    /* CF1AC 800DE9AC 83190300 */  sra        $v1, $v1, 6
    /* CF1B0 800DE9B0 0A0083A6 */  sh         $v1, 0xA($s4)
    /* CF1B4 800DE9B4 0800038E */  lw         $v1, 0x8($s0)
    /* CF1B8 800DE9B8 0800648E */  lw         $a0, 0x8($s3)
    /* CF1BC 800DE9BC 23186200 */  subu       $v1, $v1, $v0
    /* CF1C0 800DE9C0 23186400 */  subu       $v1, $v1, $a0
    /* CF1C4 800DE9C4 83190300 */  sra        $v1, $v1, 6
    /* CF1C8 800DE9C8 0C0083A6 */  sh         $v1, 0xC($s4)
    /* CF1CC 800DE9CC 2400BF8F */  lw         $ra, 0x24($sp)
    /* CF1D0 800DE9D0 2000B48F */  lw         $s4, 0x20($sp)
    /* CF1D4 800DE9D4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CF1D8 800DE9D8 1800B28F */  lw         $s2, 0x18($sp)
    /* CF1DC 800DE9DC 1400B18F */  lw         $s1, 0x14($sp)
    /* CF1E0 800DE9E0 1000B08F */  lw         $s0, 0x10($sp)
    /* CF1E4 800DE9E4 0800E003 */  jr         $ra
    /* CF1E8 800DE9E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
