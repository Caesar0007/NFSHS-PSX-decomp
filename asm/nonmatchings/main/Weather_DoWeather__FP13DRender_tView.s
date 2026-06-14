.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_DoWeather__FP13DRender_tView, 0x314

glabel Weather_DoWeather__FP13DRender_tView
    /* D421C 800E3A1C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* D4220 800E3A20 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* D4224 800E3A24 21A88000 */  addu       $s5, $a0, $zero
    /* D4228 800E3A28 1480053C */  lui        $a1, %hi(Weather_gPServer)
    /* D422C 800E3A2C D0DBA524 */  addiu      $a1, $a1, %lo(Weather_gPServer)
    /* D4230 800E3A30 1480033C */  lui        $v1, %hi(Weather_gPrevPServer)
    /* D4234 800E3A34 D8DB6324 */  addiu      $v1, $v1, %lo(Weather_gPrevPServer)
    /* D4238 800E3A38 1480023C */  lui        $v0, %hi(Weather_gDrawnServer)
    /* D423C 800E3A3C E0DB4224 */  addiu      $v0, $v0, %lo(Weather_gDrawnServer)
    /* D4240 800E3A40 3800BFAF */  sw         $ra, 0x38($sp)
    /* D4244 800E3A44 3400B7AF */  sw         $s7, 0x34($sp)
    /* D4248 800E3A48 3000B6AF */  sw         $s6, 0x30($sp)
    /* D424C 800E3A4C 2800B4AF */  sw         $s4, 0x28($sp)
    /* D4250 800E3A50 2400B3AF */  sw         $s3, 0x24($sp)
    /* D4254 800E3A54 2000B2AF */  sw         $s2, 0x20($sp)
    /* D4258 800E3A58 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D425C 800E3A5C 1800B0AF */  sw         $s0, 0x18($sp)
    /* D4260 800E3A60 0400B28E */  lw         $s2, 0x4($s5)
    /* D4264 800E3A64 01000624 */  addiu      $a2, $zero, 0x1
    /* D4268 800E3A68 80201200 */  sll        $a0, $s2, 2
    /* D426C 800E3A6C 21288500 */  addu       $a1, $a0, $a1
    /* D4270 800E3A70 21188300 */  addu       $v1, $a0, $v1
    /* D4274 800E3A74 21208200 */  addu       $a0, $a0, $v0
    /* D4278 800E3A78 1180023C */  lui        $v0, %hi(D_801131F8)
    /* D427C 800E3A7C 0000B68C */  lw         $s6, 0x0($a1)
    /* D4280 800E3A80 0000778C */  lw         $s7, 0x0($v1)
    /* D4284 800E3A84 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* D4288 800E3A88 0000948C */  lw         $s4, 0x0($a0)
    /* D428C 800E3A8C 10004610 */  beq        $v0, $a2, .L800E3AD0
    /* D4290 800E3A90 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D4294 800E3A94 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* D4298 800E3A98 0019828F */  lw         $v0, %gp_rel(D_8013DE4C)($gp)
    /* D429C 800E3A9C 00000000 */  nop
    /* D42A0 800E3AA0 23106200 */  subu       $v0, $v1, $v0
    /* D42A4 800E3AA4 21004228 */  slti       $v0, $v0, 0x21
    /* D42A8 800E3AA8 0A004014 */  bnez       $v0, .L800E3AD4
    /* D42AC 800E3AAC 1280023C */   lui       $v0, %hi(Weather_gSys)
    /* D42B0 800E3AB0 BC16828F */  lw         $v0, %gp_rel(Weather_gSnowTrack)($gp)
    /* D42B4 800E3AB4 001983AF */  sw         $v1, %gp_rel(D_8013DE4C)($gp)
    /* D42B8 800E3AB8 03004014 */  bnez       $v0, .L800E3AC8
    /* D42BC 800E3ABC 00000000 */   nop
    /* D42C0 800E3AC0 BC88030C */  jal        Weather_ChangeIntensityBasedOnTime__Fv
    /* D42C4 800E3AC4 00000000 */   nop
  .L800E3AC8:
    /* D42C8 800E3AC8 8688030C */  jal        Weather_ChangeDensityBasedOnTime__Fv
    /* D42CC 800E3ACC 00000000 */   nop
  .L800E3AD0:
    /* D42D0 800E3AD0 1280023C */  lui        $v0, %hi(Weather_gSys)
  .L800E3AD4:
    /* D42D4 800E3AD4 0834438C */  lw         $v1, %lo(Weather_gSys)($v0)
    /* D42D8 800E3AD8 00000000 */  nop
    /* D42DC 800E3ADC 89006010 */  beqz       $v1, .L800E3D04
    /* D42E0 800E3AE0 08345324 */   addiu     $s3, $v0, %lo(Weather_gSys)
    /* D42E4 800E3AE4 80881200 */  sll        $s1, $s2, 2
    /* D42E8 800E3AE8 1480023C */  lui        $v0, %hi(Input_gLookBehind)
    /* D42EC 800E3AEC 30D24224 */  addiu      $v0, $v0, %lo(Input_gLookBehind)
    /* D42F0 800E3AF0 21102202 */  addu       $v0, $s1, $v0
    /* D42F4 800E3AF4 0000458C */  lw         $a1, 0x0($v0)
    /* D42F8 800E3AF8 1480023C */  lui        $v0, %hi(D_8013DBB4)
    /* D42FC 800E3AFC B4DB4224 */  addiu      $v0, $v0, %lo(D_8013DBB4)
    /* D4300 800E3B00 21182202 */  addu       $v1, $s1, $v0
    /* D4304 800E3B04 0000628C */  lw         $v0, 0x0($v1)
    /* D4308 800E3B08 00000000 */  nop
    /* D430C 800E3B0C 0300A210 */  beq        $a1, $v0, .L800E3B1C
    /* D4310 800E3B10 21800000 */   addu      $s0, $zero, $zero
    /* D4314 800E3B14 0100A238 */  xori       $v0, $a1, 0x1
    /* D4318 800E3B18 0100502C */  sltiu      $s0, $v0, 0x1
  .L800E3B1C:
    /* D431C 800E3B1C 21204002 */  addu       $a0, $s2, $zero
    /* D4320 800E3B20 5A15020C */  jal        Camera_GetMode__Fi
    /* D4324 800E3B24 000065AC */   sw        $a1, 0x0($v1)
    /* D4328 800E3B28 1480033C */  lui        $v1, %hi(D_8013DBBC)
    /* D432C 800E3B2C BCDB6324 */  addiu      $v1, $v1, %lo(D_8013DBBC)
    /* D4330 800E3B30 21202302 */  addu       $a0, $s1, $v1
    /* D4334 800E3B34 0000838C */  lw         $v1, 0x0($a0)
    /* D4338 800E3B38 21284000 */  addu       $a1, $v0, $zero
    /* D433C 800E3B3C 0200A310 */  beq        $a1, $v1, .L800E3B48
    /* D4340 800E3B40 00000000 */   nop
    /* D4344 800E3B44 01001024 */  addiu      $s0, $zero, 0x1
  .L800E3B48:
    /* D4348 800E3B48 0D000012 */  beqz       $s0, .L800E3B80
    /* D434C 800E3B4C 000085AC */   sw        $a1, 0x0($a0)
    /* D4350 800E3B50 21203302 */  addu       $a0, $s1, $s3
    /* D4354 800E3B54 0000828C */  lw         $v0, 0x0($a0)
    /* D4358 800E3B58 00000000 */  nop
    /* D435C 800E3B5C 08004018 */  blez       $v0, .L800E3B80
    /* D4360 800E3B60 21180000 */   addu      $v1, $zero, $zero
    /* D4364 800E3B64 21108302 */  addu       $v0, $s4, $v1
  .L800E3B68:
    /* D4368 800E3B68 000040A0 */  sb         $zero, 0x0($v0)
    /* D436C 800E3B6C 0000828C */  lw         $v0, 0x0($a0)
    /* D4370 800E3B70 01006324 */  addiu      $v1, $v1, 0x1
    /* D4374 800E3B74 2A106200 */  slt        $v0, $v1, $v0
    /* D4378 800E3B78 FBFF4014 */  bnez       $v0, .L800E3B68
    /* D437C 800E3B7C 21108302 */   addu      $v0, $s4, $v1
  .L800E3B80:
    /* D4380 800E3B80 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* D4384 800E3B84 80801200 */  sll        $s0, $s2, 2
    /* D4388 800E3B88 1480023C */  lui        $v0, %hi(D_8013DE54)
    /* D438C 800E3B8C 54DE4224 */  addiu      $v0, $v0, %lo(D_8013DE54)
    /* D4390 800E3B90 21280202 */  addu       $a1, $s0, $v0
    /* D4394 800E3B94 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* D4398 800E3B98 0000A28C */  lw         $v0, 0x0($a1)
    /* D439C 800E3B9C 00000000 */  nop
    /* D43A0 800E3BA0 23106200 */  subu       $v0, $v1, $v0
    /* D43A4 800E3BA4 02004228 */  slti       $v0, $v0, 0x2
    /* D43A8 800E3BA8 09004014 */  bnez       $v0, .L800E3BD0
    /* D43AC 800E3BAC 2120A002 */   addu      $a0, $s5, $zero
    /* D43B0 800E3BB0 2130C002 */  addu       $a2, $s6, $zero
    /* D43B4 800E3BB4 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D43B8 800E3BB8 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D43BC 800E3BBC 21100202 */  addu       $v0, $s0, $v0
    /* D43C0 800E3BC0 0000A3AC */  sw         $v1, 0x0($a1)
    /* D43C4 800E3BC4 0000458C */  lw         $a1, 0x0($v0)
    /* D43C8 800E3BC8 F48B030C */  jal        Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
    /* D43CC 800E3BCC 21388002 */   addu      $a3, $s4, $zero
  .L800E3BD0:
    /* D43D0 800E3BD0 A587030C */  jal        Weather_SetIdentMatrix__Fv
    /* D43D4 800E3BD4 00000000 */   nop
    /* D43D8 800E3BD8 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* D43DC 800E3BDC ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* D43E0 800E3BE0 00191200 */  sll        $v1, $s2, 4
    /* D43E4 800E3BE4 21187200 */  addu       $v1, $v1, $s2
    /* D43E8 800E3BE8 00190300 */  sll        $v1, $v1, 4
    /* D43EC 800E3BEC 21186200 */  addu       $v1, $v1, $v0
    /* D43F0 800E3BF0 7400628C */  lw         $v0, 0x74($v1)
    /* D43F4 800E3BF4 00000000 */  nop
    /* D43F8 800E3BF8 C2160200 */  srl        $v0, $v0, 27
    /* D43FC 800E3BFC 01004230 */  andi       $v0, $v0, 0x1
    /* D4400 800E3C00 0A004010 */  beqz       $v0, .L800E3C2C
    /* D4404 800E3C04 1280023C */   lui       $v0, %hi(Weather_gSys)
    /* D4408 800E3C08 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D440C 800E3C0C 21100202 */  addu       $v0, $s0, $v0
    /* D4410 800E3C10 1480033C */  lui        $v1, %hi(Weather_gSplatInfoServer)
    /* D4414 800E3C14 C8DB6324 */  addiu      $v1, $v1, %lo(Weather_gSplatInfoServer)
    /* D4418 800E3C18 21180302 */  addu       $v1, $s0, $v1
    /* D441C 800E3C1C 0000448C */  lw         $a0, 0x0($v0)
    /* D4420 800E3C20 0000658C */  lw         $a1, 0x0($v1)
    /* D4424 800E3C24 168E030C */  jal        Weather_DoSplats__FiP18Weather_tSplatInfo
    /* D4428 800E3C28 C3200400 */   sra       $a0, $a0, 3
  .L800E3C2C:
    /* D442C 800E3C2C 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D4430 800E3C30 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D4434 800E3C34 21180202 */  addu       $v1, $s0, $v0
    /* D4438 800E3C38 0000628C */  lw         $v0, 0x0($v1)
    /* D443C 800E3C3C 00000000 */  nop
    /* D4440 800E3C40 16004018 */  blez       $v0, .L800E3C9C
    /* D4444 800E3C44 21880000 */   addu      $s1, $zero, $zero
    /* D4448 800E3C48 01001524 */  addiu      $s5, $zero, 0x1
    /* D444C 800E3C4C 21986000 */  addu       $s3, $v1, $zero
    /* D4450 800E3C50 2180C002 */  addu       $s0, $s6, $zero
    /* D4454 800E3C54 2190E002 */  addu       $s2, $s7, $zero
  .L800E3C58:
    /* D4458 800E3C58 A016828F */  lw         $v0, %gp_rel(Weather_gType)($gp)
    /* D445C 800E3C5C 00000000 */  nop
    /* D4460 800E3C60 06005514 */  bne        $v0, $s5, .L800E3C7C
    /* D4464 800E3C64 21200002 */   addu      $a0, $s0, $zero
    /* D4468 800E3C68 21284002 */  addu       $a1, $s2, $zero
    /* D446C 800E3C6C 5B8D030C */  jal        Weather_CreateRain__FP7SVECTORP7DVECTORPc
    /* D4470 800E3C70 21309102 */   addu      $a2, $s4, $s1
    /* D4474 800E3C74 228F0308 */  j          .L800E3C88
    /* D4478 800E3C78 08001026 */   addiu     $s0, $s0, 0x8
  .L800E3C7C:
    /* D447C 800E3C7C EF8C030C */  jal        Weather_CreateSnow__FP7SVECTOR
    /* D4480 800E3C80 21200002 */   addu      $a0, $s0, $zero
    /* D4484 800E3C84 08001026 */  addiu      $s0, $s0, 0x8
  .L800E3C88:
    /* D4488 800E3C88 0000628E */  lw         $v0, 0x0($s3)
    /* D448C 800E3C8C 01003126 */  addiu      $s1, $s1, 0x1
    /* D4490 800E3C90 2A102202 */  slt        $v0, $s1, $v0
    /* D4494 800E3C94 F0FF4014 */  bnez       $v0, .L800E3C58
    /* D4498 800E3C98 04005226 */   addiu     $s2, $s2, 0x4
  .L800E3C9C:
    /* D449C 800E3C9C 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* D44A0 800E3CA0 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* D44A4 800E3CA4 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* D44A8 800E3CA8 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* D44AC 800E3CAC 21280000 */  addu       $a1, $zero, $zero
    /* D44B0 800E3CB0 2130A000 */  addu       $a2, $a1, $zero
    /* D44B4 800E3CB4 20000724 */  addiu      $a3, $zero, 0x20
    /* D44B8 800E3CB8 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* D44BC 800E3CBC 0000648D */  lw         $a0, 0x0($t3)
    /* D44C0 800E3CC0 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* D44C4 800E3CC4 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* D44C8 800E3CC8 0000838C */  lw         $v1, 0x0($a0)
    /* D44CC 800E3CCC 0000028D */  lw         $v0, 0x0($t0)
    /* D44D0 800E3CD0 24186A00 */  and        $v1, $v1, $t2
    /* D44D4 800E3CD4 24104900 */  and        $v0, $v0, $t1
    /* D44D8 800E3CD8 25186200 */  or         $v1, $v1, $v0
    /* D44DC 800E3CDC 000083AC */  sw         $v1, 0x0($a0)
    /* D44E0 800E3CE0 0000028D */  lw         $v0, 0x0($t0)
    /* D44E4 800E3CE4 0C008324 */  addiu      $v1, $a0, 0xC
    /* D44E8 800E3CE8 000063AD */  sw         $v1, 0x0($t3)
    /* D44EC 800E3CEC 24188900 */  and        $v1, $a0, $t1
    /* D44F0 800E3CF0 24104A00 */  and        $v0, $v0, $t2
    /* D44F4 800E3CF4 25104300 */  or         $v0, $v0, $v1
    /* D44F8 800E3CF8 000002AD */  sw         $v0, 0x0($t0)
    /* D44FC 800E3CFC EFB8030C */  jal        SetDrawMode
    /* D4500 800E3D00 1000A0AF */   sw        $zero, 0x10($sp)
  .L800E3D04:
    /* D4504 800E3D04 3800BF8F */  lw         $ra, 0x38($sp)
    /* D4508 800E3D08 3400B78F */  lw         $s7, 0x34($sp)
    /* D450C 800E3D0C 3000B68F */  lw         $s6, 0x30($sp)
    /* D4510 800E3D10 2C00B58F */  lw         $s5, 0x2C($sp)
    /* D4514 800E3D14 2800B48F */  lw         $s4, 0x28($sp)
    /* D4518 800E3D18 2400B38F */  lw         $s3, 0x24($sp)
    /* D451C 800E3D1C 2000B28F */  lw         $s2, 0x20($sp)
    /* D4520 800E3D20 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D4524 800E3D24 1800B08F */  lw         $s0, 0x18($sp)
    /* D4528 800E3D28 0800E003 */  jr         $ra
    /* D452C 800E3D2C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Weather_DoWeather__FP13DRender_tView
