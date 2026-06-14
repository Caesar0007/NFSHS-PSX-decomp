.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache, 0x1E8

glabel DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
    /* B48DC 800C40DC 2400A98F */  lw         $t1, 0x24($sp)
    /* B48E0 800C40E0 00000000 */  nop
    /* B48E4 800C40E4 0400228D */  lw         $v0, 0x4($t1)
    /* B48E8 800C40E8 0800238D */  lw         $v1, 0x8($t1)
    /* B48EC 800C40EC 2000AB8F */  lw         $t3, 0x20($sp)
    /* B48F0 800C40F0 2B104300 */  sltu       $v0, $v0, $v1
    /* B48F4 800C40F4 71004010 */  beqz       $v0, .L800C42BC
    /* B48F8 800C40F8 21508000 */   addu      $t2, $a0, $zero
    /* B48FC 800C40FC 000040C9 */  lwc2       $0, 0x0($t2)
    /* B4900 800C4100 040041C9 */  lwc2       $1, 0x4($t2)
    /* B4904 800C4104 00000000 */  nop
    /* B4908 800C4108 00000000 */  nop
    /* B490C 800C410C 0100184A */  .word 0x4A180001  /* rtps */
    /* B4910 800C4110 801F083C */  lui        $t0, (0x1F800004 >> 16)
    /* B4914 800C4114 0400088D */  lw         $t0, (0x1F800004 & 0xFFFF)($t0)
    /* B4918 800C4118 00000000 */  nop
    /* B491C 800C411C 08000225 */  addiu      $v0, $t0, 0x8
    /* B4920 800C4120 00004EE8 */  swc2       $14, 0x0($v0)
    /* B4924 800C4124 0000A0C8 */  lwc2       $0, 0x0($a1)
    /* B4928 800C4128 0400A1C8 */  lwc2       $1, 0x4($a1)
    /* B492C 800C412C 0000C2C8 */  lwc2       $2, 0x0($a2)
    /* B4930 800C4130 0400C3C8 */  lwc2       $3, 0x4($a2)
    /* B4934 800C4134 0000E4C8 */  lwc2       $4, 0x0($a3)
    /* B4938 800C4138 0400E5C8 */  lwc2       $5, 0x4($a3)
    /* B493C 800C413C 00000000 */  nop
    /* B4940 800C4140 00000000 */  nop
    /* B4944 800C4144 3000284A */  .word 0x4A280030  /* rtpt */
    /* B4948 800C4148 10000425 */  addiu      $a0, $t0, 0x10
    /* B494C 800C414C 20000325 */  addiu      $v1, $t0, 0x20
    /* B4950 800C4150 18000225 */  addiu      $v0, $t0, 0x18
    /* B4954 800C4154 00008CE8 */  swc2       $12, 0x0($a0)
    /* B4958 800C4158 00006DE8 */  swc2       $13, 0x0($v1)
    /* B495C 800C415C 00004EE8 */  swc2       $14, 0x0($v0)
    /* B4960 800C4160 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* B4964 800C4164 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* B4968 800C4168 00000000 */  nop
    /* B496C 800C416C 03004010 */  beqz       $v0, .L800C417C
    /* B4970 800C4170 00000000 */   nop
    /* B4974 800C4174 70100308 */  j          .L800C41C0
    /* B4978 800C4178 3C0020AD */   sw        $zero, 0x3C($t1)
  .L800C417C:
    /* B497C 800C417C 00000000 */  nop
    /* B4980 800C4180 00000000 */  nop
    /* B4984 800C4184 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* B4988 800C4188 3C0027E9 */  swc2       $7, 0x3C($t1)
    /* B498C 800C418C 3C00228D */  lw         $v0, 0x3C($t1)
    /* B4990 800C4190 00000000 */  nop
    /* B4994 800C4194 C3100200 */  sra        $v0, $v0, 3
    /* B4998 800C4198 28004324 */  addiu      $v1, $v0, 0x28
    /* B499C 800C419C 47006004 */  bltz       $v1, .L800C42BC
    /* B49A0 800C41A0 3C0023AD */   sw        $v1, 0x3C($t1)
    /* B49A4 800C41A4 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* B49A8 800C41A8 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* B49AC 800C41AC 00000000 */  nop
    /* B49B0 800C41B0 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* B49B4 800C41B4 2A104300 */  slt        $v0, $v0, $v1
    /* B49B8 800C41B8 40004014 */  bnez       $v0, .L800C42BC
    /* B49BC 800C41BC 00000000 */   nop
  .L800C41C0:
    /* B49C0 800C41C0 04004285 */  lh         $v0, 0x4($t2)
    /* B49C4 800C41C4 00000000 */  nop
    /* B49C8 800C41C8 0D004104 */  bgez       $v0, .L800C4200
    /* B49CC 800C41CC 00000000 */   nop
    /* B49D0 800C41D0 0400A284 */  lh         $v0, 0x4($a1)
    /* B49D4 800C41D4 00000000 */  nop
    /* B49D8 800C41D8 0A004104 */  bgez       $v0, .L800C4204
    /* B49DC 800C41DC FF00053C */   lui       $a1, (0xFFFFFF >> 16)
    /* B49E0 800C41E0 0400C284 */  lh         $v0, 0x4($a2)
    /* B49E4 800C41E4 00000000 */  nop
    /* B49E8 800C41E8 06004104 */  bgez       $v0, .L800C4204
    /* B49EC 800C41EC 00000000 */   nop
    /* B49F0 800C41F0 0400E284 */  lh         $v0, 0x4($a3)
    /* B49F4 800C41F4 00000000 */  nop
    /* B49F8 800C41F8 30004004 */  bltz       $v0, .L800C42BC
    /* B49FC 800C41FC 00000000 */   nop
  .L800C4200:
    /* B4A00 800C4200 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
  .L800C4204:
    /* B4A04 800C4204 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* B4A08 800C4208 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* B4A0C 800C420C 0400288D */  lw         $t0, 0x4($t1)
    /* B4A10 800C4210 0000248D */  lw         $a0, 0x0($t1)
    /* B4A14 800C4214 28000225 */  addiu      $v0, $t0, 0x28
    /* B4A18 800C4218 040022AD */  sw         $v0, 0x4($t1)
    /* B4A1C 800C421C 3C00228D */  lw         $v0, 0x3C($t1)
    /* B4A20 800C4220 0000038D */  lw         $v1, 0x0($t0)
    /* B4A24 800C4224 80100200 */  sll        $v0, $v0, 2
    /* B4A28 800C4228 21208200 */  addu       $a0, $a0, $v0
    /* B4A2C 800C422C 0000828C */  lw         $v0, 0x0($a0)
    /* B4A30 800C4230 24186600 */  and        $v1, $v1, $a2
    /* B4A34 800C4234 24104500 */  and        $v0, $v0, $a1
    /* B4A38 800C4238 25186200 */  or         $v1, $v1, $v0
    /* B4A3C 800C423C 000003AD */  sw         $v1, 0x0($t0)
    /* B4A40 800C4240 0000828C */  lw         $v0, 0x0($a0)
    /* B4A44 800C4244 24280501 */  and        $a1, $t0, $a1
    /* B4A48 800C4248 24104600 */  and        $v0, $v0, $a2
    /* B4A4C 800C424C 25104500 */  or         $v0, $v0, $a1
    /* B4A50 800C4250 000082AC */  sw         $v0, 0x0($a0)
    /* B4A54 800C4254 8C00238D */  lw         $v1, 0x8C($t1)
    /* B4A58 800C4258 09000224 */  addiu      $v0, $zero, 0x9
    /* B4A5C 800C425C 030002A1 */  sb         $v0, 0x3($t0)
    /* B4A60 800C4260 2E000224 */  addiu      $v0, $zero, 0x2E
    /* B4A64 800C4264 040003AD */  sw         $v1, 0x4($t0)
    /* B4A68 800C4268 070002A1 */  sb         $v0, 0x7($t0)
    /* B4A6C 800C426C 02006295 */  lhu        $v0, 0x2($t3)
    /* B4A70 800C4270 06006395 */  lhu        $v1, 0x6($t3)
    /* B4A74 800C4274 0E0002A5 */  sh         $v0, 0xE($t0)
    /* B4A78 800C4278 160003A5 */  sh         $v1, 0x16($t0)
    /* B4A7C 800C427C 1000A28F */  lw         $v0, 0x10($sp)
    /* B4A80 800C4280 00000000 */  nop
    /* B4A84 800C4284 00004594 */  lhu        $a1, 0x0($v0)
    /* B4A88 800C4288 1400A28F */  lw         $v0, 0x14($sp)
    /* B4A8C 800C428C 00000000 */  nop
    /* B4A90 800C4290 00004494 */  lhu        $a0, 0x0($v0)
    /* B4A94 800C4294 1C00A28F */  lw         $v0, 0x1C($sp)
    /* B4A98 800C4298 00000000 */  nop
    /* B4A9C 800C429C 00004394 */  lhu        $v1, 0x0($v0)
    /* B4AA0 800C42A0 1800A28F */  lw         $v0, 0x18($sp)
    /* B4AA4 800C42A4 00000000 */  nop
    /* B4AA8 800C42A8 00004294 */  lhu        $v0, 0x0($v0)
    /* B4AAC 800C42AC 0C0005A5 */  sh         $a1, 0xC($t0)
    /* B4AB0 800C42B0 140004A5 */  sh         $a0, 0x14($t0)
    /* B4AB4 800C42B4 1C0003A5 */  sh         $v1, 0x1C($t0)
    /* B4AB8 800C42B8 240002A5 */  sh         $v0, 0x24($t0)
  .L800C42BC:
    /* B4ABC 800C42BC 0800E003 */  jr         $ra
    /* B4AC0 800C42C0 00000000 */   nop
endlabel DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
