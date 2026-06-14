.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache, 0x204

glabel DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
    /* B46D8 800C3ED8 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* B46DC 800C3EDC 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* B46E0 800C3EE0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* B46E4 800C3EE4 1800B2AF */  sw         $s2, 0x18($sp)
    /* B46E8 800C3EE8 1480123C */  lui        $s2, %hi(gShadowPixmap)
    /* B46EC 800C3EEC E4D1528E */  lw         $s2, %lo(gShadowPixmap)($s2)
    /* B46F0 800C3EF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* B46F4 800C3EF4 21888000 */  addu       $s1, $a0, $zero
    /* B46F8 800C3EF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* B46FC 800C3EFC 2180A000 */  addu       $s0, $a1, $zero
    /* B4700 800C3F00 03004010 */  beqz       $v0, .L800C3F10
    /* B4704 800C3F04 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* B4708 800C3F08 1280023C */  lui        $v0, %hi(D_80120FD4)
    /* B470C 800C3F0C D40F528C */  lw         $s2, %lo(D_80120FD4)($v0)
  .L800C3F10:
    /* B4710 800C3F10 00000000 */  nop
    /* B4714 800C3F14 06004426 */  addiu      $a0, $s2, 0x6
    /* B4718 800C3F18 B4F9020C */  jal        ChangeTPage__FPUsi
    /* B471C 800C3F1C 02000524 */   addiu     $a1, $zero, 0x2
    /* B4720 800C3F20 1280083C */  lui        $t0, %hi(DrawC_gScreenMat)
    /* B4724 800C3F24 C8F40825 */  addiu      $t0, $t0, %lo(DrawC_gScreenMat)
    /* B4728 800C3F28 00000C8D */  lw         $t4, 0x0($t0)
    /* B472C 800C3F2C 04000D8D */  lw         $t5, 0x4($t0)
    /* B4730 800C3F30 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B4734 800C3F34 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B4738 800C3F38 08000C8D */  lw         $t4, 0x8($t0)
    /* B473C 800C3F3C 0C000D8D */  lw         $t5, 0xC($t0)
    /* B4740 800C3F40 10000E8D */  lw         $t6, 0x10($t0)
    /* B4744 800C3F44 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B4748 800C3F48 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B474C 800C3F4C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B4750 800C3F50 1280083C */  lui        $t0, %hi(DrawC_gScreenMat)
    /* B4754 800C3F54 C8F40825 */  addiu      $t0, $t0, %lo(DrawC_gScreenMat)
    /* B4758 800C3F58 14000C8D */  lw         $t4, 0x14($t0)
    /* B475C 800C3F5C 18000D8D */  lw         $t5, 0x18($t0)
    /* B4760 800C3F60 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B4764 800C3F64 1C000E8D */  lw         $t6, 0x1C($t0)
    /* B4768 800C3F68 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B476C 800C3F6C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B4770 800C3F70 0400028E */  lw         $v0, 0x4($s0)
    /* B4774 800C3F74 0800038E */  lw         $v1, 0x8($s0)
    /* B4778 800C3F78 00000000 */  nop
    /* B477C 800C3F7C 2B104300 */  sltu       $v0, $v0, $v1
    /* B4780 800C3F80 50004010 */  beqz       $v0, .L800C40C4
    /* B4784 800C3F84 00000000 */   nop
    /* B4788 800C3F88 000020CA */  lwc2       $0, 0x0($s1)
    /* B478C 800C3F8C 040021CA */  lwc2       $1, 0x4($s1)
    /* B4790 800C3F90 00000000 */  nop
    /* B4794 800C3F94 00000000 */  nop
    /* B4798 800C3F98 0100184A */  .word 0x4A180001  /* rtps */
    /* B479C 800C3F9C 801F073C */  lui        $a3, (0x1F800004 >> 16)
    /* B47A0 800C3FA0 0400E78C */  lw         $a3, (0x1F800004 & 0xFFFF)($a3)
    /* B47A4 800C3FA4 00000000 */  nop
    /* B47A8 800C3FA8 0800E224 */  addiu      $v0, $a3, 0x8
    /* B47AC 800C3FAC 00004EE8 */  swc2       $14, 0x0($v0)
    /* B47B0 800C3FB0 08002426 */  addiu      $a0, $s1, 0x8
    /* B47B4 800C3FB4 18002326 */  addiu      $v1, $s1, 0x18
    /* B47B8 800C3FB8 10002226 */  addiu      $v0, $s1, 0x10
    /* B47BC 800C3FBC 000080C8 */  lwc2       $0, 0x0($a0)
    /* B47C0 800C3FC0 040081C8 */  lwc2       $1, 0x4($a0)
    /* B47C4 800C3FC4 000062C8 */  lwc2       $2, 0x0($v1)
    /* B47C8 800C3FC8 040063C8 */  lwc2       $3, 0x4($v1)
    /* B47CC 800C3FCC 000044C8 */  lwc2       $4, 0x0($v0)
    /* B47D0 800C3FD0 040045C8 */  lwc2       $5, 0x4($v0)
    /* B47D4 800C3FD4 00000000 */  nop
    /* B47D8 800C3FD8 00000000 */  nop
    /* B47DC 800C3FDC 3000284A */  .word 0x4A280030  /* rtpt */
    /* B47E0 800C3FE0 1000E424 */  addiu      $a0, $a3, 0x10
    /* B47E4 800C3FE4 2000E324 */  addiu      $v1, $a3, 0x20
    /* B47E8 800C3FE8 1800E224 */  addiu      $v0, $a3, 0x18
    /* B47EC 800C3FEC 00008CE8 */  swc2       $12, 0x0($a0)
    /* B47F0 800C3FF0 00006DE8 */  swc2       $13, 0x0($v1)
    /* B47F4 800C3FF4 00004EE8 */  swc2       $14, 0x0($v0)
    /* B47F8 800C3FF8 00000000 */  nop
    /* B47FC 800C3FFC 00000000 */  nop
    /* B4800 800C4000 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* B4804 800C4004 3C0007EA */  swc2       $7, 0x3C($s0)
    /* B4808 800C4008 3C00028E */  lw         $v0, 0x3C($s0)
    /* B480C 800C400C 00000000 */  nop
    /* B4810 800C4010 43100200 */  sra        $v0, $v0, 1
    /* B4814 800C4014 28004324 */  addiu      $v1, $v0, 0x28
    /* B4818 800C4018 2A006004 */  bltz       $v1, .L800C40C4
    /* B481C 800C401C 3C0003AE */   sw        $v1, 0x3C($s0)
    /* B4820 800C4020 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* B4824 800C4024 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* B4828 800C4028 00000000 */  nop
    /* B482C 800C402C FDFF4224 */  addiu      $v0, $v0, -0x3
    /* B4830 800C4030 2A104300 */  slt        $v0, $v0, $v1
    /* B4834 800C4034 23004014 */  bnez       $v0, .L800C40C4
    /* B4838 800C4038 FF00053C */   lui       $a1, (0xFFFFFF >> 16)
    /* B483C 800C403C FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* B4840 800C4040 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* B4844 800C4044 0400078E */  lw         $a3, 0x4($s0)
    /* B4848 800C4048 0000048E */  lw         $a0, 0x0($s0)
    /* B484C 800C404C 2800E224 */  addiu      $v0, $a3, 0x28
    /* B4850 800C4050 040002AE */  sw         $v0, 0x4($s0)
    /* B4854 800C4054 21106000 */  addu       $v0, $v1, $zero
    /* B4858 800C4058 80100200 */  sll        $v0, $v0, 2
    /* B485C 800C405C 21208200 */  addu       $a0, $a0, $v0
    /* B4860 800C4060 0000E38C */  lw         $v1, 0x0($a3)
    /* B4864 800C4064 0000828C */  lw         $v0, 0x0($a0)
    /* B4868 800C4068 24186600 */  and        $v1, $v1, $a2
    /* B486C 800C406C 24104500 */  and        $v0, $v0, $a1
    /* B4870 800C4070 25186200 */  or         $v1, $v1, $v0
    /* B4874 800C4074 0000E3AC */  sw         $v1, 0x0($a3)
    /* B4878 800C4078 0000828C */  lw         $v0, 0x0($a0)
    /* B487C 800C407C 2428E500 */  and        $a1, $a3, $a1
    /* B4880 800C4080 24104600 */  and        $v0, $v0, $a2
    /* B4884 800C4084 25104500 */  or         $v0, $v0, $a1
    /* B4888 800C4088 000082AC */  sw         $v0, 0x0($a0)
    /* B488C 800C408C 8C00038E */  lw         $v1, 0x8C($s0)
    /* B4890 800C4090 09000224 */  addiu      $v0, $zero, 0x9
    /* B4894 800C4094 0300E2A0 */  sb         $v0, 0x3($a3)
    /* B4898 800C4098 2E000224 */  addiu      $v0, $zero, 0x2E
    /* B489C 800C409C 0400E3AC */  sw         $v1, 0x4($a3)
    /* B48A0 800C40A0 0700E2A0 */  sb         $v0, 0x7($a3)
    /* B48A4 800C40A4 0000428E */  lw         $v0, 0x0($s2)
    /* B48A8 800C40A8 0400438E */  lw         $v1, 0x4($s2)
    /* B48AC 800C40AC 0800448E */  lw         $a0, 0x8($s2)
    /* B48B0 800C40B0 0C00458E */  lw         $a1, 0xC($s2)
    /* B48B4 800C40B4 0C00E2AC */  sw         $v0, 0xC($a3)
    /* B48B8 800C40B8 1400E3AC */  sw         $v1, 0x14($a3)
    /* B48BC 800C40BC 1C00E4AC */  sw         $a0, 0x1C($a3)
    /* B48C0 800C40C0 2400E5AC */  sw         $a1, 0x24($a3)
  .L800C40C4:
    /* B48C4 800C40C4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* B48C8 800C40C8 1800B28F */  lw         $s2, 0x18($sp)
    /* B48CC 800C40CC 1400B18F */  lw         $s1, 0x14($sp)
    /* B48D0 800C40D0 1000B08F */  lw         $s0, 0x10($sp)
    /* B48D4 800C40D4 0800E003 */  jr         $ra
    /* B48D8 800C40D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
