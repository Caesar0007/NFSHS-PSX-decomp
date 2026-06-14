.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_StoringControllerData__FG15tControllerData, 0x3CC

glabel Replay_StoringControllerData__FG15tControllerData
    /* A48BC 800B40BC AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A48C0 800B40C0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A48C4 800B40C4 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* A48C8 800B40C8 3800B0AF */  sw         $s0, 0x38($sp)
    /* A48CC 800B40CC 4000A4AF */  sw         $a0, 0x40($sp)
    /* A48D0 800B40D0 4400A5AF */  sw         $a1, 0x44($sp)
    /* A48D4 800B40D4 4800A6AF */  sw         $a2, 0x48($sp)
    /* A48D8 800B40D8 80004224 */  addiu      $v0, $v0, 0x80
    /* A48DC 800B40DC 00604228 */  slti       $v0, $v0, 0x6000
    /* A48E0 800B40E0 08004014 */  bnez       $v0, .L800B4104
    /* A48E4 800B40E4 4C00A7AF */   sw        $a3, 0x4C($sp)
    /* A48E8 800B40E8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A48EC 800B40EC B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* A48F0 800B40F0 01000224 */  addiu      $v0, $zero, 0x1
    /* A48F4 800B40F4 A80E82AF */  sw         $v0, %gp_rel(Replay_ReplayMode)($gp)
    /* A48F8 800B40F8 A00E83AF */  sw         $v1, %gp_rel(Replay_Size)($gp)
    /* A48FC 800B40FC 1ED10208 */  j          .L800B4478
    /* A4900 800B4100 00000000 */   nop
  .L800B4104:
    /* A4904 800B4104 13CF020C */  jal        Replay_Compress__FPc
    /* A4908 800B4108 4000A427 */   addiu     $a0, $sp, 0x40
    /* A490C 800B410C 21184000 */  addu       $v1, $v0, $zero
    /* A4910 800B4110 03006230 */  andi       $v0, $v1, 0x3
    /* A4914 800B4114 17004010 */  beqz       $v0, .L800B4174
    /* A4918 800B4118 1000A427 */   addiu     $a0, $sp, 0x10
    /* A491C 800B411C 20006224 */  addiu      $v0, $v1, 0x20
  .L800B4120:
    /* A4920 800B4120 03006888 */  lwl        $t0, 0x3($v1)
    /* A4924 800B4124 00006898 */  lwr        $t0, 0x0($v1)
    /* A4928 800B4128 07006988 */  lwl        $t1, 0x7($v1)
    /* A492C 800B412C 04006998 */  lwr        $t1, 0x4($v1)
    /* A4930 800B4130 0B006A88 */  lwl        $t2, 0xB($v1)
    /* A4934 800B4134 08006A98 */  lwr        $t2, 0x8($v1)
    /* A4938 800B4138 0F006B88 */  lwl        $t3, 0xF($v1)
    /* A493C 800B413C 0C006B98 */  lwr        $t3, 0xC($v1)
    /* A4940 800B4140 030088A8 */  swl        $t0, 0x3($a0)
    /* A4944 800B4144 000088B8 */  swr        $t0, 0x0($a0)
    /* A4948 800B4148 070089A8 */  swl        $t1, 0x7($a0)
    /* A494C 800B414C 040089B8 */  swr        $t1, 0x4($a0)
    /* A4950 800B4150 0B008AA8 */  swl        $t2, 0xB($a0)
    /* A4954 800B4154 08008AB8 */  swr        $t2, 0x8($a0)
    /* A4958 800B4158 0F008BA8 */  swl        $t3, 0xF($a0)
    /* A495C 800B415C 0C008BB8 */  swr        $t3, 0xC($a0)
    /* A4960 800B4160 10006324 */  addiu      $v1, $v1, 0x10
    /* A4964 800B4164 EEFF6214 */  bne        $v1, $v0, .L800B4120
    /* A4968 800B4168 10008424 */   addiu     $a0, $a0, 0x10
    /* A496C 800B416C 6AD00208 */  j          .L800B41A8
    /* A4970 800B4170 1000B027 */   addiu     $s0, $sp, 0x10
  .L800B4174:
    /* A4974 800B4174 20006224 */  addiu      $v0, $v1, 0x20
  .L800B4178:
    /* A4978 800B4178 0000688C */  lw         $t0, 0x0($v1)
    /* A497C 800B417C 0400698C */  lw         $t1, 0x4($v1)
    /* A4980 800B4180 08006A8C */  lw         $t2, 0x8($v1)
    /* A4984 800B4184 0C006B8C */  lw         $t3, 0xC($v1)
    /* A4988 800B4188 000088AC */  sw         $t0, 0x0($a0)
    /* A498C 800B418C 040089AC */  sw         $t1, 0x4($a0)
    /* A4990 800B4190 08008AAC */  sw         $t2, 0x8($a0)
    /* A4994 800B4194 0C008BAC */  sw         $t3, 0xC($a0)
    /* A4998 800B4198 10006324 */  addiu      $v1, $v1, 0x10
    /* A499C 800B419C F6FF6214 */  bne        $v1, $v0, .L800B4178
    /* A49A0 800B41A0 10008424 */   addiu     $a0, $a0, 0x10
    /* A49A4 800B41A4 1000B027 */  addiu      $s0, $sp, 0x10
  .L800B41A8:
    /* A49A8 800B41A8 21280002 */  addu       $a1, $s0, $zero
    /* A49AC 800B41AC 00006880 */  lb         $t0, 0x0($v1)
    /* A49B0 800B41B0 00000000 */  nop
    /* A49B4 800B41B4 000088A0 */  sb         $t0, 0x0($a0)
    /* A49B8 800B41B8 1180043C */  lui        $a0, %hi(D_80117B98)
    /* A49BC 800B41BC 987B8424 */  addiu      $a0, $a0, %lo(D_80117B98)
    /* A49C0 800B41C0 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A49C4 800B41C4 1000A693 */  lbu        $a2, 0x10($sp)
    /* A49C8 800B41C8 B1AA030C */  jal        memcpy
    /* A49CC 800B41CC 21204400 */   addu      $a0, $v0, $a0
    /* A49D0 800B41D0 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A49D4 800B41D4 1000A393 */  lbu        $v1, 0x10($sp)
    /* A49D8 800B41D8 00000000 */  nop
    /* A49DC 800B41DC 21104300 */  addu       $v0, $v0, $v1
    /* A49E0 800B41E0 AC0E82AF */  sw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A49E4 800B41E4 13CF020C */  jal        Replay_Compress__FPc
    /* A49E8 800B41E8 6000A427 */   addiu     $a0, $sp, 0x60
    /* A49EC 800B41EC 21184000 */  addu       $v1, $v0, $zero
    /* A49F0 800B41F0 03006230 */  andi       $v0, $v1, 0x3
    /* A49F4 800B41F4 17004010 */  beqz       $v0, .L800B4254
    /* A49F8 800B41F8 21200002 */   addu      $a0, $s0, $zero
    /* A49FC 800B41FC 20006224 */  addiu      $v0, $v1, 0x20
  .L800B4200:
    /* A4A00 800B4200 03006888 */  lwl        $t0, 0x3($v1)
    /* A4A04 800B4204 00006898 */  lwr        $t0, 0x0($v1)
    /* A4A08 800B4208 07006988 */  lwl        $t1, 0x7($v1)
    /* A4A0C 800B420C 04006998 */  lwr        $t1, 0x4($v1)
    /* A4A10 800B4210 0B006A88 */  lwl        $t2, 0xB($v1)
    /* A4A14 800B4214 08006A98 */  lwr        $t2, 0x8($v1)
    /* A4A18 800B4218 0F006B88 */  lwl        $t3, 0xF($v1)
    /* A4A1C 800B421C 0C006B98 */  lwr        $t3, 0xC($v1)
    /* A4A20 800B4220 030088A8 */  swl        $t0, 0x3($a0)
    /* A4A24 800B4224 000088B8 */  swr        $t0, 0x0($a0)
    /* A4A28 800B4228 070089A8 */  swl        $t1, 0x7($a0)
    /* A4A2C 800B422C 040089B8 */  swr        $t1, 0x4($a0)
    /* A4A30 800B4230 0B008AA8 */  swl        $t2, 0xB($a0)
    /* A4A34 800B4234 08008AB8 */  swr        $t2, 0x8($a0)
    /* A4A38 800B4238 0F008BA8 */  swl        $t3, 0xF($a0)
    /* A4A3C 800B423C 0C008BB8 */  swr        $t3, 0xC($a0)
    /* A4A40 800B4240 10006324 */  addiu      $v1, $v1, 0x10
    /* A4A44 800B4244 EEFF6214 */  bne        $v1, $v0, .L800B4200
    /* A4A48 800B4248 10008424 */   addiu     $a0, $a0, 0x10
    /* A4A4C 800B424C A2D00208 */  j          .L800B4288
    /* A4A50 800B4250 1000B027 */   addiu     $s0, $sp, 0x10
  .L800B4254:
    /* A4A54 800B4254 20006224 */  addiu      $v0, $v1, 0x20
  .L800B4258:
    /* A4A58 800B4258 0000688C */  lw         $t0, 0x0($v1)
    /* A4A5C 800B425C 0400698C */  lw         $t1, 0x4($v1)
    /* A4A60 800B4260 08006A8C */  lw         $t2, 0x8($v1)
    /* A4A64 800B4264 0C006B8C */  lw         $t3, 0xC($v1)
    /* A4A68 800B4268 000088AC */  sw         $t0, 0x0($a0)
    /* A4A6C 800B426C 040089AC */  sw         $t1, 0x4($a0)
    /* A4A70 800B4270 08008AAC */  sw         $t2, 0x8($a0)
    /* A4A74 800B4274 0C008BAC */  sw         $t3, 0xC($a0)
    /* A4A78 800B4278 10006324 */  addiu      $v1, $v1, 0x10
    /* A4A7C 800B427C F6FF6214 */  bne        $v1, $v0, .L800B4258
    /* A4A80 800B4280 10008424 */   addiu     $a0, $a0, 0x10
    /* A4A84 800B4284 1000B027 */  addiu      $s0, $sp, 0x10
  .L800B4288:
    /* A4A88 800B4288 21280002 */  addu       $a1, $s0, $zero
    /* A4A8C 800B428C 00006880 */  lb         $t0, 0x0($v1)
    /* A4A90 800B4290 00000000 */  nop
    /* A4A94 800B4294 000088A0 */  sb         $t0, 0x0($a0)
    /* A4A98 800B4298 1180043C */  lui        $a0, %hi(D_80117B98)
    /* A4A9C 800B429C 987B8424 */  addiu      $a0, $a0, %lo(D_80117B98)
    /* A4AA0 800B42A0 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4AA4 800B42A4 1000A693 */  lbu        $a2, 0x10($sp)
    /* A4AA8 800B42A8 B1AA030C */  jal        memcpy
    /* A4AAC 800B42AC 21204400 */   addu      $a0, $v0, $a0
    /* A4AB0 800B42B0 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4AB4 800B42B4 1000A393 */  lbu        $v1, 0x10($sp)
    /* A4AB8 800B42B8 00000000 */  nop
    /* A4ABC 800B42BC 21104300 */  addu       $v0, $v0, $v1
    /* A4AC0 800B42C0 AC0E82AF */  sw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4AC4 800B42C4 13CF020C */  jal        Replay_Compress__FPc
    /* A4AC8 800B42C8 8000A427 */   addiu     $a0, $sp, 0x80
    /* A4ACC 800B42CC 21184000 */  addu       $v1, $v0, $zero
    /* A4AD0 800B42D0 03006230 */  andi       $v0, $v1, 0x3
    /* A4AD4 800B42D4 17004010 */  beqz       $v0, .L800B4334
    /* A4AD8 800B42D8 21200002 */   addu      $a0, $s0, $zero
    /* A4ADC 800B42DC 20006224 */  addiu      $v0, $v1, 0x20
  .L800B42E0:
    /* A4AE0 800B42E0 03006888 */  lwl        $t0, 0x3($v1)
    /* A4AE4 800B42E4 00006898 */  lwr        $t0, 0x0($v1)
    /* A4AE8 800B42E8 07006988 */  lwl        $t1, 0x7($v1)
    /* A4AEC 800B42EC 04006998 */  lwr        $t1, 0x4($v1)
    /* A4AF0 800B42F0 0B006A88 */  lwl        $t2, 0xB($v1)
    /* A4AF4 800B42F4 08006A98 */  lwr        $t2, 0x8($v1)
    /* A4AF8 800B42F8 0F006B88 */  lwl        $t3, 0xF($v1)
    /* A4AFC 800B42FC 0C006B98 */  lwr        $t3, 0xC($v1)
    /* A4B00 800B4300 030088A8 */  swl        $t0, 0x3($a0)
    /* A4B04 800B4304 000088B8 */  swr        $t0, 0x0($a0)
    /* A4B08 800B4308 070089A8 */  swl        $t1, 0x7($a0)
    /* A4B0C 800B430C 040089B8 */  swr        $t1, 0x4($a0)
    /* A4B10 800B4310 0B008AA8 */  swl        $t2, 0xB($a0)
    /* A4B14 800B4314 08008AB8 */  swr        $t2, 0x8($a0)
    /* A4B18 800B4318 0F008BA8 */  swl        $t3, 0xF($a0)
    /* A4B1C 800B431C 0C008BB8 */  swr        $t3, 0xC($a0)
    /* A4B20 800B4320 10006324 */  addiu      $v1, $v1, 0x10
    /* A4B24 800B4324 EEFF6214 */  bne        $v1, $v0, .L800B42E0
    /* A4B28 800B4328 10008424 */   addiu     $a0, $a0, 0x10
    /* A4B2C 800B432C DAD00208 */  j          .L800B4368
    /* A4B30 800B4330 1000B027 */   addiu     $s0, $sp, 0x10
  .L800B4334:
    /* A4B34 800B4334 20006224 */  addiu      $v0, $v1, 0x20
  .L800B4338:
    /* A4B38 800B4338 0000688C */  lw         $t0, 0x0($v1)
    /* A4B3C 800B433C 0400698C */  lw         $t1, 0x4($v1)
    /* A4B40 800B4340 08006A8C */  lw         $t2, 0x8($v1)
    /* A4B44 800B4344 0C006B8C */  lw         $t3, 0xC($v1)
    /* A4B48 800B4348 000088AC */  sw         $t0, 0x0($a0)
    /* A4B4C 800B434C 040089AC */  sw         $t1, 0x4($a0)
    /* A4B50 800B4350 08008AAC */  sw         $t2, 0x8($a0)
    /* A4B54 800B4354 0C008BAC */  sw         $t3, 0xC($a0)
    /* A4B58 800B4358 10006324 */  addiu      $v1, $v1, 0x10
    /* A4B5C 800B435C F6FF6214 */  bne        $v1, $v0, .L800B4338
    /* A4B60 800B4360 10008424 */   addiu     $a0, $a0, 0x10
    /* A4B64 800B4364 1000B027 */  addiu      $s0, $sp, 0x10
  .L800B4368:
    /* A4B68 800B4368 21280002 */  addu       $a1, $s0, $zero
    /* A4B6C 800B436C 00006880 */  lb         $t0, 0x0($v1)
    /* A4B70 800B4370 00000000 */  nop
    /* A4B74 800B4374 000088A0 */  sb         $t0, 0x0($a0)
    /* A4B78 800B4378 1180043C */  lui        $a0, %hi(D_80117B98)
    /* A4B7C 800B437C 987B8424 */  addiu      $a0, $a0, %lo(D_80117B98)
    /* A4B80 800B4380 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4B84 800B4384 1000A693 */  lbu        $a2, 0x10($sp)
    /* A4B88 800B4388 B1AA030C */  jal        memcpy
    /* A4B8C 800B438C 21204400 */   addu      $a0, $v0, $a0
    /* A4B90 800B4390 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4B94 800B4394 1000A393 */  lbu        $v1, 0x10($sp)
    /* A4B98 800B4398 00000000 */  nop
    /* A4B9C 800B439C 21104300 */  addu       $v0, $v0, $v1
    /* A4BA0 800B43A0 AC0E82AF */  sw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4BA4 800B43A4 13CF020C */  jal        Replay_Compress__FPc
    /* A4BA8 800B43A8 A000A427 */   addiu     $a0, $sp, 0xA0
    /* A4BAC 800B43AC 21184000 */  addu       $v1, $v0, $zero
    /* A4BB0 800B43B0 03006230 */  andi       $v0, $v1, 0x3
    /* A4BB4 800B43B4 16004010 */  beqz       $v0, .L800B4410
    /* A4BB8 800B43B8 20006224 */   addiu     $v0, $v1, 0x20
  .L800B43BC:
    /* A4BBC 800B43BC 03006888 */  lwl        $t0, 0x3($v1)
    /* A4BC0 800B43C0 00006898 */  lwr        $t0, 0x0($v1)
    /* A4BC4 800B43C4 07006988 */  lwl        $t1, 0x7($v1)
    /* A4BC8 800B43C8 04006998 */  lwr        $t1, 0x4($v1)
    /* A4BCC 800B43CC 0B006A88 */  lwl        $t2, 0xB($v1)
    /* A4BD0 800B43D0 08006A98 */  lwr        $t2, 0x8($v1)
    /* A4BD4 800B43D4 0F006B88 */  lwl        $t3, 0xF($v1)
    /* A4BD8 800B43D8 0C006B98 */  lwr        $t3, 0xC($v1)
    /* A4BDC 800B43DC 030008AA */  swl        $t0, 0x3($s0)
    /* A4BE0 800B43E0 000008BA */  swr        $t0, 0x0($s0)
    /* A4BE4 800B43E4 070009AA */  swl        $t1, 0x7($s0)
    /* A4BE8 800B43E8 040009BA */  swr        $t1, 0x4($s0)
    /* A4BEC 800B43EC 0B000AAA */  swl        $t2, 0xB($s0)
    /* A4BF0 800B43F0 08000ABA */  swr        $t2, 0x8($s0)
    /* A4BF4 800B43F4 0F000BAA */  swl        $t3, 0xF($s0)
    /* A4BF8 800B43F8 0C000BBA */  swr        $t3, 0xC($s0)
    /* A4BFC 800B43FC 10006324 */  addiu      $v1, $v1, 0x10
    /* A4C00 800B4400 EEFF6214 */  bne        $v1, $v0, .L800B43BC
    /* A4C04 800B4404 10001026 */   addiu     $s0, $s0, 0x10
    /* A4C08 800B4408 10D10208 */  j          .L800B4440
    /* A4C0C 800B440C 1000A527 */   addiu     $a1, $sp, 0x10
  .L800B4410:
    /* A4C10 800B4410 0000688C */  lw         $t0, 0x0($v1)
    /* A4C14 800B4414 0400698C */  lw         $t1, 0x4($v1)
    /* A4C18 800B4418 08006A8C */  lw         $t2, 0x8($v1)
    /* A4C1C 800B441C 0C006B8C */  lw         $t3, 0xC($v1)
    /* A4C20 800B4420 000008AE */  sw         $t0, 0x0($s0)
    /* A4C24 800B4424 040009AE */  sw         $t1, 0x4($s0)
    /* A4C28 800B4428 08000AAE */  sw         $t2, 0x8($s0)
    /* A4C2C 800B442C 0C000BAE */  sw         $t3, 0xC($s0)
    /* A4C30 800B4430 10006324 */  addiu      $v1, $v1, 0x10
    /* A4C34 800B4434 F6FF6214 */  bne        $v1, $v0, .L800B4410
    /* A4C38 800B4438 10001026 */   addiu     $s0, $s0, 0x10
    /* A4C3C 800B443C 1000A527 */  addiu      $a1, $sp, 0x10
  .L800B4440:
    /* A4C40 800B4440 1180043C */  lui        $a0, %hi(D_80117B98)
    /* A4C44 800B4444 987B8424 */  addiu      $a0, $a0, %lo(D_80117B98)
    /* A4C48 800B4448 00006880 */  lb         $t0, 0x0($v1)
    /* A4C4C 800B444C 00000000 */  nop
    /* A4C50 800B4450 000008A2 */  sb         $t0, 0x0($s0)
    /* A4C54 800B4454 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4C58 800B4458 1000A693 */  lbu        $a2, 0x10($sp)
    /* A4C5C 800B445C B1AA030C */  jal        memcpy
    /* A4C60 800B4460 21204400 */   addu      $a0, $v0, $a0
    /* A4C64 800B4464 AC0E828F */  lw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A4C68 800B4468 1000A393 */  lbu        $v1, 0x10($sp)
    /* A4C6C 800B446C 00000000 */  nop
    /* A4C70 800B4470 21104300 */  addu       $v0, $v0, $v1
    /* A4C74 800B4474 AC0E82AF */  sw         $v0, %gp_rel(Replay_ReplayStorePtr)($gp)
  .L800B4478:
    /* A4C78 800B4478 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* A4C7C 800B447C 3800B08F */  lw         $s0, 0x38($sp)
    /* A4C80 800B4480 0800E003 */  jr         $ra
    /* A4C84 800B4484 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Replay_StoringControllerData__FG15tControllerData
