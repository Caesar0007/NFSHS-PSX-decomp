.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_Transform__FP8coorddefP7SVECTORT0, 0x154

glabel Sfx_Transform__FP8coorddefP7SVECTORT0
    /* CD850 800DD050 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* CD854 800DD054 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* CD858 800DD058 21888000 */  addu       $s1, $a0, $zero
    /* CD85C 800DD05C 5000B2AF */  sw         $s2, 0x50($sp)
    /* CD860 800DD060 2190A000 */  addu       $s2, $a1, $zero
    /* CD864 800DD064 4800B0AF */  sw         $s0, 0x48($sp)
    /* CD868 800DD068 2180C000 */  addu       $s0, $a2, $zero
    /* CD86C 800DD06C 1180043C */  lui        $a0, %hi(gWorldMat)
    /* CD870 800DD070 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* CD874 800DD074 5400BFAF */  sw         $ra, 0x54($sp)
    /* CD878 800DD078 9786030C */  jal        TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
    /* CD87C 800DD07C 21280000 */   addu      $a1, $zero, $zero
    /* CD880 800DD080 0000228E */  lw         $v0, 0x0($s1)
    /* CD884 800DD084 0000038E */  lw         $v1, 0x0($s0)
    /* CD888 800DD088 00000000 */  nop
    /* CD88C 800DD08C 23104300 */  subu       $v0, $v0, $v1
    /* CD890 800DD090 83120200 */  sra        $v0, $v0, 10
    /* CD894 800DD094 1000A2A7 */  sh         $v0, 0x10($sp)
    /* CD898 800DD098 0400228E */  lw         $v0, 0x4($s1)
    /* CD89C 800DD09C 0400038E */  lw         $v1, 0x4($s0)
    /* CD8A0 800DD0A0 00000000 */  nop
    /* CD8A4 800DD0A4 23104300 */  subu       $v0, $v0, $v1
    /* CD8A8 800DD0A8 83120200 */  sra        $v0, $v0, 10
    /* CD8AC 800DD0AC 1200A2A7 */  sh         $v0, 0x12($sp)
    /* CD8B0 800DD0B0 0800228E */  lw         $v0, 0x8($s1)
    /* CD8B4 800DD0B4 0800038E */  lw         $v1, 0x8($s0)
    /* CD8B8 800DD0B8 00000000 */  nop
    /* CD8BC 800DD0BC 23104300 */  subu       $v0, $v0, $v1
    /* CD8C0 800DD0C0 83120200 */  sra        $v0, $v0, 10
    /* CD8C4 800DD0C4 1400A2A7 */  sh         $v0, 0x14($sp)
    /* CD8C8 800DD0C8 1000A227 */  addiu      $v0, $sp, 0x10
    /* CD8CC 800DD0CC 000040C8 */  lwc2       $0, 0x0($v0)
    /* CD8D0 800DD0D0 040041C8 */  lwc2       $1, 0x4($v0)
    /* CD8D4 800DD0D4 00000000 */  nop
    /* CD8D8 800DD0D8 00000000 */  nop
    /* CD8DC 800DD0DC 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* CD8E0 800DD0E0 1800A227 */  addiu      $v0, $sp, 0x18
    /* CD8E4 800DD0E4 000059E8 */  swc2       $25, 0x0($v0)
    /* CD8E8 800DD0E8 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* CD8EC 800DD0EC 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* CD8F0 800DD0F0 1800A297 */  lhu        $v0, 0x18($sp)
    /* CD8F4 800DD0F4 00000000 */  nop
    /* CD8F8 800DD0F8 000042A6 */  sh         $v0, 0x0($s2)
    /* CD8FC 800DD0FC 1C00A297 */  lhu        $v0, 0x1C($sp)
    /* CD900 800DD100 00000000 */  nop
    /* CD904 800DD104 020042A6 */  sh         $v0, 0x2($s2)
    /* CD908 800DD108 2000A297 */  lhu        $v0, 0x20($sp)
    /* CD90C 800DD10C 00000000 */  nop
    /* CD910 800DD110 040042A6 */  sh         $v0, 0x4($s2)
    /* CD914 800DD114 00100224 */  addiu      $v0, $zero, 0x1000
    /* CD918 800DD118 2800A2A7 */  sh         $v0, 0x28($sp)
    /* CD91C 800DD11C 3000A2A7 */  sh         $v0, 0x30($sp)
    /* CD920 800DD120 3800A2A7 */  sh         $v0, 0x38($sp)
    /* CD924 800DD124 2800A227 */  addiu      $v0, $sp, 0x28
    /* CD928 800DD128 2E00A0A7 */  sh         $zero, 0x2E($sp)
    /* CD92C 800DD12C 3400A0A7 */  sh         $zero, 0x34($sp)
    /* CD930 800DD130 2A00A0A7 */  sh         $zero, 0x2A($sp)
    /* CD934 800DD134 3600A0A7 */  sh         $zero, 0x36($sp)
    /* CD938 800DD138 2C00A0A7 */  sh         $zero, 0x2C($sp)
    /* CD93C 800DD13C 3200A0A7 */  sh         $zero, 0x32($sp)
    /* CD940 800DD140 3C00A0AF */  sw         $zero, 0x3C($sp)
    /* CD944 800DD144 4000A0AF */  sw         $zero, 0x40($sp)
    /* CD948 800DD148 4400A0AF */  sw         $zero, 0x44($sp)
    /* CD94C 800DD14C 00004C8C */  lw         $t4, 0x0($v0)
    /* CD950 800DD150 04004D8C */  lw         $t5, 0x4($v0)
    /* CD954 800DD154 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* CD958 800DD158 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* CD95C 800DD15C 08004C8C */  lw         $t4, 0x8($v0)
    /* CD960 800DD160 0C004D8C */  lw         $t5, 0xC($v0)
    /* CD964 800DD164 10004E8C */  lw         $t6, 0x10($v0)
    /* CD968 800DD168 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* CD96C 800DD16C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* CD970 800DD170 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* CD974 800DD174 14004C8C */  lw         $t4, 0x14($v0)
    /* CD978 800DD178 18004D8C */  lw         $t5, 0x18($v0)
    /* CD97C 800DD17C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* CD980 800DD180 1C004E8C */  lw         $t6, 0x1C($v0)
    /* CD984 800DD184 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* CD988 800DD188 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* CD98C 800DD18C 5400BF8F */  lw         $ra, 0x54($sp)
    /* CD990 800DD190 5000B28F */  lw         $s2, 0x50($sp)
    /* CD994 800DD194 4C00B18F */  lw         $s1, 0x4C($sp)
    /* CD998 800DD198 4800B08F */  lw         $s0, 0x48($sp)
    /* CD99C 800DD19C 0800E003 */  jr         $ra
    /* CD9A0 800DD1A0 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Sfx_Transform__FP8coorddefP7SVECTORT0
