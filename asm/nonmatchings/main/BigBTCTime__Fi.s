.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BigBTCTime__Fi, 0x320

glabel BigBTCTime__Fi
    /* C87B0 800D7FB0 DC18828F */  lw         $v0, %gp_rel(D_8013DE28)($gp)
    /* C87B4 800D7FB4 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* C87B8 800D7FB8 3400B3AF */  sw         $s3, 0x34($sp)
    /* C87BC 800D7FBC 21988000 */  addu       $s3, $a0, $zero
    /* C87C0 800D7FC0 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* C87C4 800D7FC4 4800BEAF */  sw         $fp, 0x48($sp)
    /* C87C8 800D7FC8 4400B7AF */  sw         $s7, 0x44($sp)
    /* C87CC 800D7FCC 4000B6AF */  sw         $s6, 0x40($sp)
    /* C87D0 800D7FD0 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* C87D4 800D7FD4 3800B4AF */  sw         $s4, 0x38($sp)
    /* C87D8 800D7FD8 3000B2AF */  sw         $s2, 0x30($sp)
    /* C87DC 800D7FDC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* C87E0 800D7FE0 AF004014 */  bnez       $v0, .L800D82A0
    /* C87E4 800D7FE4 2800B0AF */   sw        $s0, 0x28($sp)
    /* C87E8 800D7FE8 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C87EC 800D7FEC 00000000 */  nop
    /* C87F0 800D7FF0 AB004014 */  bnez       $v0, .L800D82A0
    /* C87F4 800D7FF4 00000000 */   nop
    /* C87F8 800D7FF8 A9006006 */  bltz       $s3, .L800D82A0
    /* C87FC 800D7FFC 00000000 */   nop
    /* C8800 800D8000 D413828F */  lw         $v0, %gp_rel(D_8013D920)($gp)
    /* C8804 800D8004 00000000 */  nop
    /* C8808 800D8008 05006212 */  beq        $s3, $v0, .L800D8020
    /* C880C 800D800C 00000000 */   nop
    /* C8810 800D8010 1480023C */  lui        $v0, %hi(ticks)
    /* C8814 800D8014 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C8818 800D8018 D41393AF */  sw         $s3, %gp_rel(D_8013D920)($gp)
    /* C881C 800D801C D81382AF */  sw         $v0, %gp_rel(D_8013D924)($gp)
  .L800D8020:
    /* C8820 800D8020 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C8824 800D8024 00000000 */  nop
    /* C8828 800D8028 3C006284 */  lh         $v0, 0x3C($v1)
    /* C882C 800D802C 3E007784 */  lh         $s7, 0x3E($v1)
    /* C8830 800D8030 02005224 */  addiu      $s2, $v0, 0x2
    /* C8834 800D8034 21F04002 */  addu       $fp, $s2, $zero
    /* C8838 800D8038 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C883C 800D803C 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C8840 800D8040 2000B7AF */  sw         $s7, 0x20($sp)
    /* C8844 800D8044 80034384 */  lh         $v1, 0x380($v0)
    /* C8848 800D8048 94034284 */  lh         $v0, 0x394($v0)
    /* C884C 800D804C 00000000 */  nop
    /* C8850 800D8050 01004224 */  addiu      $v0, $v0, 0x1
    /* C8854 800D8054 2400A2AF */  sw         $v0, 0x24($sp)
    /* C8858 800D8058 0B00622A */  slti       $v0, $s3, 0xB
    /* C885C 800D805C 05004014 */  bnez       $v0, .L800D8074
    /* C8860 800D8060 01007624 */   addiu     $s6, $v1, 0x1
    /* C8864 800D8064 00C81534 */  ori        $s5, $zero, 0xC800
    /* C8868 800D8068 601380AF */  sw         $zero, %gp_rel(D_8013D8AC)($gp)
    /* C886C 800D806C 40600308 */  j          .L800D8100
    /* C8870 800D8070 00641424 */   addiu     $s4, $zero, 0x6400
  .L800D8074:
    /* C8874 800D8074 1480023C */  lui        $v0, %hi(ticks)
    /* C8878 800D8078 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C887C 800D807C D813838F */  lw         $v1, %gp_rel(D_8013D924)($gp)
    /* C8880 800D8080 00000000 */  nop
    /* C8884 800D8084 23104300 */  subu       $v0, $v0, $v1
    /* C8888 800D8088 40004228 */  slti       $v0, $v0, 0x40
    /* C888C 800D808C 13004010 */  beqz       $v0, .L800D80DC
    /* C8890 800D8090 2120C003 */   addu      $a0, $fp, $zero
    /* C8894 800D8094 40801600 */  sll        $s0, $s6, 1
    /* C8898 800D8098 21300002 */  addu       $a2, $s0, $zero
    /* C889C 800D809C 2000A58F */  lw         $a1, 0x20($sp)
    /* C88A0 800D80A0 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C88A4 800D80A4 0E000724 */   addiu     $a3, $zero, 0xE
    /* C88A8 800D80A8 21200000 */  addu       $a0, $zero, $zero
    /* C88AC 800D80AC 2128C003 */  addu       $a1, $fp, $zero
    /* C88B0 800D80B0 21380002 */  addu       $a3, $s0, $zero
    /* C88B4 800D80B4 2000A68F */  lw         $a2, 0x20($sp)
    /* C88B8 800D80B8 0E000224 */  addiu      $v0, $zero, 0xE
    /* C88BC 800D80BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* C88C0 800D80C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C88C4 800D80C4 1800A0AF */  sw         $zero, 0x18($sp)
    /* C88C8 800D80C8 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C88CC 800D80CC 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C88D0 800D80D0 601380AF */  sw         $zero, %gp_rel(D_8013D8AC)($gp)
    /* C88D4 800D80D4 A8600308 */  j          .L800D82A0
    /* C88D8 800D80D8 00000000 */   nop
  .L800D80DC:
    /* C88DC 800D80DC 6013828F */  lw         $v0, %gp_rel(D_8013D8AC)($gp)
    /* C88E0 800D80E0 00000000 */  nop
    /* C88E4 800D80E4 05004014 */  bnez       $v0, .L800D80FC
    /* C88E8 800D80E8 C8001524 */   addiu     $s5, $zero, 0xC8
    /* C88EC 800D80EC ABE5010C */  jal        AudioCmn_PlayWrongWaySFX__Fv
    /* C88F0 800D80F0 00000000 */   nop
    /* C88F4 800D80F4 01000224 */  addiu      $v0, $zero, 0x1
    /* C88F8 800D80F8 601382AF */  sw         $v0, %gp_rel(D_8013D8AC)($gp)
  .L800D80FC:
    /* C88FC 800D80FC 64001424 */  addiu      $s4, $zero, 0x64
  .L800D8100:
    /* C8900 800D8100 21905602 */  addu       $s2, $s2, $s6
    /* C8904 800D8104 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C8908 800D8108 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C890C 800D810C FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* C8910 800D8110 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* C8914 800D8114 66660A3C */  lui        $t2, (0x66666667 >> 16)
    /* C8918 800D8118 67664A35 */  ori        $t2, $t2, (0x66666667 & 0xFFFF)
    /* C891C 800D811C FFFF4626 */  addiu      $a2, $s2, -0x1
    /* C8920 800D8120 2138E002 */  addu       $a3, $s7, $zero
    /* C8924 800D8124 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C8928 800D8128 18006A02 */  mult       $s3, $t2
    /* C892C 800D812C 0000718D */  lw         $s1, 0x0($t3)
    /* C8930 800D8130 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C8934 800D8134 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C8938 800D8138 21202002 */  addu       $a0, $s1, $zero
    /* C893C 800D813C 0000238E */  lw         $v1, 0x0($s1)
    /* C8940 800D8140 0000A28C */  lw         $v0, 0x0($a1)
    /* C8944 800D8144 24186900 */  and        $v1, $v1, $t1
    /* C8948 800D8148 24104800 */  and        $v0, $v0, $t0
    /* C894C 800D814C 25186200 */  or         $v1, $v1, $v0
    /* C8950 800D8150 000023AE */  sw         $v1, 0x0($s1)
    /* C8954 800D8154 34002326 */  addiu      $v1, $s1, 0x34
    /* C8958 800D8158 0000A28C */  lw         $v0, 0x0($a1)
    /* C895C 800D815C 24402802 */  and        $t0, $s1, $t0
    /* C8960 800D8160 000063AD */  sw         $v1, 0x0($t3)
    /* C8964 800D8164 24104900 */  and        $v0, $v0, $t1
    /* C8968 800D8168 25104800 */  or         $v0, $v0, $t0
    /* C896C 800D816C 0000A2AC */  sw         $v0, 0x0($a1)
    /* C8970 800D8170 C3171300 */  sra        $v0, $s3, 31
    /* C8974 800D8174 1180053C */  lui        $a1, %hi(D_80111008)
    /* C8978 800D8178 0810A524 */  addiu      $a1, $a1, %lo(D_80111008)
    /* C897C 800D817C 1000B5AF */  sw         $s5, 0x10($sp)
    /* C8980 800D8180 10600000 */  mfhi       $t4
    /* C8984 800D8184 83800C00 */  sra        $s0, $t4, 2
    /* C8988 800D8188 23800202 */  subu       $s0, $s0, $v0
    /* C898C 800D818C 80101000 */  sll        $v0, $s0, 2
    /* C8990 800D8190 21105000 */  addu       $v0, $v0, $s0
    /* C8994 800D8194 40100200 */  sll        $v0, $v0, 1
    /* C8998 800D8198 23106202 */  subu       $v0, $s3, $v0
    /* C899C 800D819C 80180200 */  sll        $v1, $v0, 2
    /* C89A0 800D81A0 21186200 */  addu       $v1, $v1, $v0
    /* C89A4 800D81A4 80180300 */  sll        $v1, $v1, 2
    /* C89A8 800D81A8 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C89AC 800D81AC 21286500 */   addu      $a1, $v1, $a1
    /* C89B0 800D81B0 280034AE */  sw         $s4, 0x28($s1)
    /* C89B4 800D81B4 2A000012 */  beqz       $s0, .L800D8260
    /* C89B8 800D81B8 1C0034AE */   sw        $s4, 0x1C($s1)
    /* C89BC 800D81BC 01000224 */  addiu      $v0, $zero, 0x1
    /* C89C0 800D81C0 04000216 */  bne        $s0, $v0, .L800D81D4
    /* C89C4 800D81C4 00000000 */   nop
    /* C89C8 800D81C8 2400AC8F */  lw         $t4, 0x24($sp)
    /* C89CC 800D81CC 76600308 */  j          .L800D81D8
    /* C89D0 800D81D0 23904C02 */   subu      $s2, $s2, $t4
  .L800D81D4:
    /* C89D4 800D81D4 23905602 */  subu       $s2, $s2, $s6
  .L800D81D8:
    /* C89D8 800D81D8 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C89DC 800D81DC 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C89E0 800D81E0 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* C89E4 800D81E4 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* C89E8 800D81E8 80101000 */  sll        $v0, $s0, 2
    /* C89EC 800D81EC 21105000 */  addu       $v0, $v0, $s0
    /* C89F0 800D81F0 80100200 */  sll        $v0, $v0, 2
    /* C89F4 800D81F4 1180053C */  lui        $a1, %hi(D_80111008)
    /* C89F8 800D81F8 0810A524 */  addiu      $a1, $a1, %lo(D_80111008)
    /* C89FC 800D81FC 21284500 */  addu       $a1, $v0, $a1
    /* C8A00 800D8200 21304002 */  addu       $a2, $s2, $zero
    /* C8A04 800D8204 2138E002 */  addu       $a3, $s7, $zero
    /* C8A08 800D8208 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* C8A0C 800D820C 0000718D */  lw         $s1, 0x0($t3)
    /* C8A10 800D8210 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C8A14 800D8214 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C8A18 800D8218 21202002 */  addu       $a0, $s1, $zero
    /* C8A1C 800D821C 0000238E */  lw         $v1, 0x0($s1)
    /* C8A20 800D8220 0000028D */  lw         $v0, 0x0($t0)
    /* C8A24 800D8224 24186A00 */  and        $v1, $v1, $t2
    /* C8A28 800D8228 24104900 */  and        $v0, $v0, $t1
    /* C8A2C 800D822C 25186200 */  or         $v1, $v1, $v0
    /* C8A30 800D8230 000023AE */  sw         $v1, 0x0($s1)
    /* C8A34 800D8234 34002326 */  addiu      $v1, $s1, 0x34
    /* C8A38 800D8238 0000028D */  lw         $v0, 0x0($t0)
    /* C8A3C 800D823C 24482902 */  and        $t1, $s1, $t1
    /* C8A40 800D8240 000063AD */  sw         $v1, 0x0($t3)
    /* C8A44 800D8244 24104A00 */  and        $v0, $v0, $t2
    /* C8A48 800D8248 25104900 */  or         $v0, $v0, $t1
    /* C8A4C 800D824C 000002AD */  sw         $v0, 0x0($t0)
    /* C8A50 800D8250 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C8A54 800D8254 1000B5AF */   sw        $s5, 0x10($sp)
    /* C8A58 800D8258 280034AE */  sw         $s4, 0x28($s1)
    /* C8A5C 800D825C 1C0034AE */  sw         $s4, 0x1C($s1)
  .L800D8260:
    /* C8A60 800D8260 2120C003 */  addu       $a0, $fp, $zero
    /* C8A64 800D8264 40801600 */  sll        $s0, $s6, 1
    /* C8A68 800D8268 21300002 */  addu       $a2, $s0, $zero
    /* C8A6C 800D826C 2000A58F */  lw         $a1, 0x20($sp)
    /* C8A70 800D8270 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C8A74 800D8274 0E000724 */   addiu     $a3, $zero, 0xE
    /* C8A78 800D8278 21200000 */  addu       $a0, $zero, $zero
    /* C8A7C 800D827C 2128C003 */  addu       $a1, $fp, $zero
    /* C8A80 800D8280 21380002 */  addu       $a3, $s0, $zero
    /* C8A84 800D8284 2000A68F */  lw         $a2, 0x20($sp)
    /* C8A88 800D8288 0E000224 */  addiu      $v0, $zero, 0xE
    /* C8A8C 800D828C 1000A2AF */  sw         $v0, 0x10($sp)
    /* C8A90 800D8290 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8A94 800D8294 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8A98 800D8298 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8A9C 800D829C 1C00A0AF */   sw        $zero, 0x1C($sp)
  .L800D82A0:
    /* C8AA0 800D82A0 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* C8AA4 800D82A4 4800BE8F */  lw         $fp, 0x48($sp)
    /* C8AA8 800D82A8 4400B78F */  lw         $s7, 0x44($sp)
    /* C8AAC 800D82AC 4000B68F */  lw         $s6, 0x40($sp)
    /* C8AB0 800D82B0 3C00B58F */  lw         $s5, 0x3C($sp)
    /* C8AB4 800D82B4 3800B48F */  lw         $s4, 0x38($sp)
    /* C8AB8 800D82B8 3400B38F */  lw         $s3, 0x34($sp)
    /* C8ABC 800D82BC 3000B28F */  lw         $s2, 0x30($sp)
    /* C8AC0 800D82C0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* C8AC4 800D82C4 2800B08F */  lw         $s0, 0x28($sp)
    /* C8AC8 800D82C8 0800E003 */  jr         $ra
    /* C8ACC 800D82CC 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel BigBTCTime__Fi
