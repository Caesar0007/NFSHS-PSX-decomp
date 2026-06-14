.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache, 0x4A8

glabel DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
    /* B4230 800C3A30 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* B4234 800C3A34 2000B0AF */  sw         $s0, 0x20($sp)
    /* B4238 800C3A38 21808000 */  addu       $s0, $a0, $zero
    /* B423C 800C3A3C 2400B1AF */  sw         $s1, 0x24($sp)
    /* B4240 800C3A40 2188A000 */  addu       $s1, $a1, $zero
    /* B4244 800C3A44 2800B2AF */  sw         $s2, 0x28($sp)
    /* B4248 800C3A48 6000B28F */  lw         $s2, 0x60($sp)
    /* B424C 800C3A4C 4400BFAF */  sw         $ra, 0x44($sp)
    /* B4250 800C3A50 4000BEAF */  sw         $fp, 0x40($sp)
    /* B4254 800C3A54 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* B4258 800C3A58 3800B6AF */  sw         $s6, 0x38($sp)
    /* B425C 800C3A5C 3400B5AF */  sw         $s5, 0x34($sp)
    /* B4260 800C3A60 3000B4AF */  sw         $s4, 0x30($sp)
    /* B4264 800C3A64 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B4268 800C3A68 5000A6AF */  sw         $a2, 0x50($sp)
    /* B426C 800C3A6C 5400A7AF */  sw         $a3, 0x54($sp)
    /* B4270 800C3A70 1000DE8C */  lw         $fp, 0x10($a2)
    /* B4274 800C3A74 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B4278 800C3A78 08000424 */   addiu     $a0, $zero, 0x8
    /* B427C 800C3A7C 0000028E */  lw         $v0, 0x0($s0)
    /* B4280 800C3A80 0C00038E */  lw         $v1, 0xC($s0)
    /* B4284 800C3A84 1800048E */  lw         $a0, 0x18($s0)
    /* B4288 800C3A88 03110200 */  sra        $v0, $v0, 4
    /* B428C 800C3A8C 03190300 */  sra        $v1, $v1, 4
    /* B4290 800C3A90 03210400 */  sra        $a0, $a0, 4
    /* B4294 800C3A94 140042A6 */  sh         $v0, 0x14($s2)
    /* B4298 800C3A98 160043A6 */  sh         $v1, 0x16($s2)
    /* B429C 800C3A9C 180044A6 */  sh         $a0, 0x18($s2)
    /* B42A0 800C3AA0 0400028E */  lw         $v0, 0x4($s0)
    /* B42A4 800C3AA4 1000038E */  lw         $v1, 0x10($s0)
    /* B42A8 800C3AA8 1C00048E */  lw         $a0, 0x1C($s0)
    /* B42AC 800C3AAC 03110200 */  sra        $v0, $v0, 4
    /* B42B0 800C3AB0 03190300 */  sra        $v1, $v1, 4
    /* B42B4 800C3AB4 03210400 */  sra        $a0, $a0, 4
    /* B42B8 800C3AB8 1A0042A6 */  sh         $v0, 0x1A($s2)
    /* B42BC 800C3ABC 1C0043A6 */  sh         $v1, 0x1C($s2)
    /* B42C0 800C3AC0 1E0044A6 */  sh         $a0, 0x1E($s2)
    /* B42C4 800C3AC4 0800038E */  lw         $v1, 0x8($s0)
    /* B42C8 800C3AC8 1400048E */  lw         $a0, 0x14($s0)
    /* B42CC 800C3ACC 2000058E */  lw         $a1, 0x20($s0)
    /* B42D0 800C3AD0 23100200 */  negu       $v0, $v0
    /* B42D4 800C3AD4 1A0042A6 */  sh         $v0, 0x1A($s2)
    /* B42D8 800C3AD8 1C004296 */  lhu        $v0, 0x1C($s2)
    /* B42DC 800C3ADC 03190300 */  sra        $v1, $v1, 4
    /* B42E0 800C3AE0 03210400 */  sra        $a0, $a0, 4
    /* B42E4 800C3AE4 03290500 */  sra        $a1, $a1, 4
    /* B42E8 800C3AE8 200043A6 */  sh         $v1, 0x20($s2)
    /* B42EC 800C3AEC 1E004396 */  lhu        $v1, 0x1E($s2)
    /* B42F0 800C3AF0 23100200 */  negu       $v0, $v0
    /* B42F4 800C3AF4 220044A6 */  sh         $a0, 0x22($s2)
    /* B42F8 800C3AF8 240045A6 */  sh         $a1, 0x24($s2)
    /* B42FC 800C3AFC 1C0042A6 */  sh         $v0, 0x1C($s2)
    /* B4300 800C3B00 23180300 */  negu       $v1, $v1
    /* B4304 800C3B04 1E0043A6 */  sh         $v1, 0x1E($s2)
    /* B4308 800C3B08 0000228E */  lw         $v0, 0x0($s1)
    /* B430C 800C3B0C 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B4310 800C3B10 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B4314 800C3B14 00000000 */  nop
    /* B4318 800C3B18 07106200 */  srav       $v0, $v0, $v1
    /* B431C 800C3B1C 280042AE */  sw         $v0, 0x28($s2)
    /* B4320 800C3B20 0400228E */  lw         $v0, 0x4($s1)
    /* B4324 800C3B24 00000000 */  nop
    /* B4328 800C3B28 07106200 */  srav       $v0, $v0, $v1
    /* B432C 800C3B2C 23100200 */  negu       $v0, $v0
    /* B4330 800C3B30 2C0042AE */  sw         $v0, 0x2C($s2)
    /* B4334 800C3B34 0800228E */  lw         $v0, 0x8($s1)
    /* B4338 800C3B38 00000000 */  nop
    /* B433C 800C3B3C 07106200 */  srav       $v0, $v0, $v1
    /* B4340 800C3B40 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B4344 800C3B44 300042AE */   sw        $v0, 0x30($s2)
    /* B4348 800C3B48 5000A88F */  lw         $t0, 0x50($sp)
    /* B434C 800C3B4C 00000000 */  nop
    /* B4350 800C3B50 02001595 */  lhu        $s5, 0x2($t0)
    /* B4354 800C3B54 14005626 */  addiu      $s6, $s2, 0x14
    /* B4358 800C3B58 40101500 */  sll        $v0, $s5, 1
    /* B435C 800C3B5C 21105500 */  addu       $v0, $v0, $s5
    /* B4360 800C3B60 80B80200 */  sll        $s7, $v0, 2
  .L800C3B64:
    /* B4364 800C3B64 FFFFB526 */  addiu      $s5, $s5, -0x1
  .L800C3B68:
    /* B4368 800C3B68 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B436C 800C3B6C CE00A212 */  beq        $s5, $v0, .L800C3EA8
    /* B4370 800C3B70 F4FFF726 */   addiu     $s7, $s7, -0xC
    /* B4374 800C3B74 5000A88F */  lw         $t0, 0x50($sp)
    /* B4378 800C3B78 00000000 */  nop
    /* B437C 800C3B7C 1800028D */  lw         $v0, 0x18($t0)
    /* B4380 800C3B80 00000000 */  nop
    /* B4384 800C3B84 21885700 */  addu       $s1, $v0, $s7
    /* B4388 800C3B88 03002392 */  lbu        $v1, 0x3($s1)
    /* B438C 800C3B8C 04002592 */  lbu        $a1, 0x4($s1)
    /* B4390 800C3B90 05002692 */  lbu        $a2, 0x5($s1)
    /* B4394 800C3B94 0000CC8E */  lw         $t4, 0x0($s6)
    /* B4398 800C3B98 0400CD8E */  lw         $t5, 0x4($s6)
    /* B439C 800C3B9C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B43A0 800C3BA0 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B43A4 800C3BA4 0800CC8E */  lw         $t4, 0x8($s6)
    /* B43A8 800C3BA8 0C00CD8E */  lw         $t5, 0xC($s6)
    /* B43AC 800C3BAC 1000CE8E */  lw         $t6, 0x10($s6)
    /* B43B0 800C3BB0 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B43B4 800C3BB4 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B43B8 800C3BB8 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B43BC 800C3BBC 1400CC8E */  lw         $t4, 0x14($s6)
    /* B43C0 800C3BC0 1800CD8E */  lw         $t5, 0x18($s6)
    /* B43C4 800C3BC4 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B43C8 800C3BC8 1C00CE8E */  lw         $t6, 0x1C($s6)
    /* B43CC 800C3BCC 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B43D0 800C3BD0 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B43D4 800C3BD4 40100300 */  sll        $v0, $v1, 1
    /* B43D8 800C3BD8 21104300 */  addu       $v0, $v0, $v1
    /* B43DC 800C3BDC 40100200 */  sll        $v0, $v0, 1
    /* B43E0 800C3BE0 2110C203 */  addu       $v0, $fp, $v0
    /* B43E4 800C3BE4 00004394 */  lhu        $v1, 0x0($v0)
    /* B43E8 800C3BE8 02004494 */  lhu        $a0, 0x2($v0)
    /* B43EC 800C3BEC 04004294 */  lhu        $v0, 0x4($v0)
    /* B43F0 800C3BF0 00000000 */  nop
    /* B43F4 800C3BF4 B00042A6 */  sh         $v0, 0xB0($s2)
    /* B43F8 800C3BF8 40100500 */  sll        $v0, $a1, 1
    /* B43FC 800C3BFC 21104500 */  addu       $v0, $v0, $a1
    /* B4400 800C3C00 40100200 */  sll        $v0, $v0, 1
    /* B4404 800C3C04 2110C203 */  addu       $v0, $fp, $v0
    /* B4408 800C3C08 AC0043A6 */  sh         $v1, 0xAC($s2)
    /* B440C 800C3C0C AE0044A6 */  sh         $a0, 0xAE($s2)
    /* B4410 800C3C10 00004394 */  lhu        $v1, 0x0($v0)
    /* B4414 800C3C14 02004494 */  lhu        $a0, 0x2($v0)
    /* B4418 800C3C18 04004294 */  lhu        $v0, 0x4($v0)
    /* B441C 800C3C1C 00000000 */  nop
    /* B4420 800C3C20 B80042A6 */  sh         $v0, 0xB8($s2)
    /* B4424 800C3C24 40100600 */  sll        $v0, $a2, 1
    /* B4428 800C3C28 21104600 */  addu       $v0, $v0, $a2
    /* B442C 800C3C2C 40100200 */  sll        $v0, $v0, 1
    /* B4430 800C3C30 2110C203 */  addu       $v0, $fp, $v0
    /* B4434 800C3C34 B40043A6 */  sh         $v1, 0xB4($s2)
    /* B4438 800C3C38 B60044A6 */  sh         $a0, 0xB6($s2)
    /* B443C 800C3C3C 00004394 */  lhu        $v1, 0x0($v0)
    /* B4440 800C3C40 02004494 */  lhu        $a0, 0x2($v0)
    /* B4444 800C3C44 04004294 */  lhu        $v0, 0x4($v0)
    /* B4448 800C3C48 BE0044A6 */  sh         $a0, 0xBE($s2)
    /* B444C 800C3C4C AC004426 */  addiu      $a0, $s2, 0xAC
    /* B4450 800C3C50 BC0043A6 */  sh         $v1, 0xBC($s2)
    /* B4454 800C3C54 B4004326 */  addiu      $v1, $s2, 0xB4
    /* B4458 800C3C58 C00042A6 */  sh         $v0, 0xC0($s2)
    /* B445C 800C3C5C BC004226 */  addiu      $v0, $s2, 0xBC
    /* B4460 800C3C60 000080C8 */  lwc2       $0, 0x0($a0)
    /* B4464 800C3C64 040081C8 */  lwc2       $1, 0x4($a0)
    /* B4468 800C3C68 000062C8 */  lwc2       $2, 0x0($v1)
    /* B446C 800C3C6C 040063C8 */  lwc2       $3, 0x4($v1)
    /* B4470 800C3C70 000044C8 */  lwc2       $4, 0x0($v0)
    /* B4474 800C3C74 040045C8 */  lwc2       $5, 0x4($v0)
    /* B4478 800C3C78 00000000 */  nop
    /* B447C 800C3C7C 00000000 */  nop
    /* B4480 800C3C80 3000284A */  .word 0x4A280030  /* rtpt */
    /* B4484 800C3C84 00000000 */  nop
    /* B4488 800C3C88 00000000 */  nop
    /* B448C 800C3C8C 0600404B */  .word 0x4B400006  /* nclip */
    /* B4490 800C3C90 440058EA */  swc2       $24, 0x44($s2)
    /* B4494 800C3C94 0C00428E */  lw         $v0, 0xC($s2)
    /* B4498 800C3C98 4400438E */  lw         $v1, 0x44($s2)
    /* B449C 800C3C9C 02004010 */  beqz       $v0, .L800C3CA8
    /* B44A0 800C3CA0 00000000 */   nop
    /* B44A4 800C3CA4 23180300 */  negu       $v1, $v1
  .L800C3CA8:
    /* B44A8 800C3CA8 AFFF6018 */  blez       $v1, .L800C3B68
    /* B44AC 800C3CAC FFFFB526 */   addiu     $s5, $s5, -0x1
    /* B44B0 800C3CB0 0100B526 */  addiu      $s5, $s5, 0x1
    /* B44B4 800C3CB4 00000000 */  nop
    /* B44B8 800C3CB8 00000000 */  nop
    /* B44BC 800C3CBC 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B44C0 800C3CC0 3C0047EA */  swc2       $7, 0x3C($s2)
    /* B44C4 800C3CC4 3C00438E */  lw         $v1, 0x3C($s2)
    /* B44C8 800C3CC8 4000428E */  lw         $v0, 0x40($s2)
    /* B44CC 800C3CCC 00000000 */  nop
    /* B44D0 800C3CD0 21186200 */  addu       $v1, $v1, $v0
    /* B44D4 800C3CD4 A3FF6004 */  bltz       $v1, .L800C3B64
    /* B44D8 800C3CD8 3C0043AE */   sw        $v1, 0x3C($s2)
    /* B44DC 800C3CDC 8800428E */  lw         $v0, 0x88($s2)
    /* B44E0 800C3CE0 00000000 */  nop
    /* B44E4 800C3CE4 2A104300 */  slt        $v0, $v0, $v1
    /* B44E8 800C3CE8 9FFF4014 */  bnez       $v0, .L800C3B68
    /* B44EC 800C3CEC FFFFB526 */   addiu     $s5, $s5, -0x1
    /* B44F0 800C3CF0 0100B526 */  addiu      $s5, $s5, 0x1
    /* B44F4 800C3CF4 5400A88F */  lw         $t0, 0x54($sp)
    /* B44F8 800C3CF8 00000000 */  nop
    /* B44FC 800C3CFC BFFF1331 */  andi       $s3, $t0, 0xFFBF
    /* B4500 800C3D00 5800A88F */  lw         $t0, 0x58($sp)
    /* B4504 800C3D04 00000000 */  nop
    /* B4508 800C3D08 2F000005 */  bltz       $t0, .L800C3DC8
    /* B450C 800C3D0C 40100800 */   sll       $v0, $t0, 1
    /* B4510 800C3D10 1280083C */  lui        $t0, %hi(DrawC_gOverlay)
    /* B4514 800C3D14 08F50825 */  addiu      $t0, $t0, %lo(DrawC_gOverlay)
    /* B4518 800C3D18 21104800 */  addu       $v0, $v0, $t0
    /* B451C 800C3D1C 00004294 */  lhu        $v0, 0x0($v0)
    /* B4520 800C3D20 00000000 */  nop
    /* B4524 800C3D24 00240200 */  sll        $a0, $v0, 16
    /* B4528 800C3D28 00002286 */  lh         $v0, 0x0($s1)
    /* B452C 800C3D2C 00000000 */  nop
    /* B4530 800C3D30 03004104 */  bgez       $v0, .L800C3D40
    /* B4534 800C3D34 031C0400 */   sra       $v1, $a0, 16
    /* B4538 800C3D38 510F0308 */  j          .L800C3D44
    /* B453C 800C3D3C 031E0400 */   sra       $v1, $a0, 24
  .L800C3D40:
    /* B4540 800C3D40 FF006330 */  andi       $v1, $v1, 0xFF
  .L800C3D44:
    /* B4544 800C3D44 5400A88F */  lw         $t0, 0x54($sp)
    /* B4548 800C3D48 00000000 */  nop
    /* B454C 800C3D4C 40000231 */  andi       $v0, $t0, 0x40
    /* B4550 800C3D50 0F004010 */  beqz       $v0, .L800C3D90
    /* B4554 800C3D54 40006230 */   andi      $v0, $v1, 0x40
    /* B4558 800C3D58 0E004014 */  bnez       $v0, .L800C3D94
    /* B455C 800C3D5C 81006230 */   andi      $v0, $v1, 0x81
    /* B4560 800C3D60 1280083C */  lui        $t0, %hi(DrawC_gOverlay)
    /* B4564 800C3D64 08F50825 */  addiu      $t0, $t0, %lo(DrawC_gOverlay)
    /* B4568 800C3D68 30000295 */  lhu        $v0, 0x30($t0)
    /* B456C 800C3D6C 00000000 */  nop
    /* B4570 800C3D70 00240200 */  sll        $a0, $v0, 16
    /* B4574 800C3D74 00002286 */  lh         $v0, 0x0($s1)
    /* B4578 800C3D78 00000000 */  nop
    /* B457C 800C3D7C 03004104 */  bgez       $v0, .L800C3D8C
    /* B4580 800C3D80 031C0400 */   sra       $v1, $a0, 16
    /* B4584 800C3D84 640F0308 */  j          .L800C3D90
    /* B4588 800C3D88 031E0400 */   sra       $v1, $a0, 24
  .L800C3D8C:
    /* B458C 800C3D8C FF006330 */  andi       $v1, $v1, 0xFF
  .L800C3D90:
    /* B4590 800C3D90 81006230 */  andi       $v0, $v1, 0x81
  .L800C3D94:
    /* B4594 800C3D94 74FF4010 */  beqz       $v0, .L800C3B68
    /* B4598 800C3D98 FFFFB526 */   addiu     $s5, $s5, -0x1
    /* B459C 800C3D9C 0100B526 */  addiu      $s5, $s5, 0x1
    /* B45A0 800C3DA0 03006330 */  andi       $v1, $v1, 0x3
    /* B45A4 800C3DA4 01000224 */  addiu      $v0, $zero, 0x1
    /* B45A8 800C3DA8 08006210 */  beq        $v1, $v0, .L800C3DCC
    /* B45AC 800C3DAC FF007032 */   andi      $s0, $s3, 0xFF
    /* B45B0 800C3DB0 5400A88F */  lw         $t0, 0x54($sp)
    /* B45B4 800C3DB4 00000000 */  nop
    /* B45B8 800C3DB8 007F0231 */  andi       $v0, $t0, 0x7F00
    /* B45BC 800C3DBC 04004010 */  beqz       $v0, .L800C3DD0
    /* B45C0 800C3DC0 21200002 */   addu      $a0, $s0, $zero
    /* B45C4 800C3DC4 039A1300 */  sra        $s3, $s3, 8
  .L800C3DC8:
    /* B45C8 800C3DC8 FF007032 */  andi       $s0, $s3, 0xFF
  .L800C3DCC:
    /* B45CC 800C3DCC 21200002 */  addu       $a0, $s0, $zero
  .L800C3DD0:
    /* B45D0 800C3DD0 0000548E */  lw         $s4, 0x0($s2)
    /* B45D4 800C3DD4 3800428E */  lw         $v0, 0x38($s2)
    /* B45D8 800C3DD8 AC004526 */  addiu      $a1, $s2, 0xAC
    /* B45DC 800C3DDC 000042AE */  sw         $v0, 0x0($s2)
    /* B45E0 800C3DE0 00002286 */  lh         $v0, 0x0($s1)
    /* B45E4 800C3DE4 B4004626 */  addiu      $a2, $s2, 0xB4
    /* B45E8 800C3DE8 1000A2AF */  sw         $v0, 0x10($sp)
    /* B45EC 800C3DEC 3C00428E */  lw         $v0, 0x3C($s2)
    /* B45F0 800C3DF0 BC004726 */  addiu      $a3, $s2, 0xBC
    /* B45F4 800C3DF4 1800B2AF */  sw         $s2, 0x18($sp)
    /* B45F8 800C3DF8 D632030C */  jal        Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
    /* B45FC 800C3DFC 1400A2AF */   sw        $v0, 0x14($sp)
    /* B4600 800C3E00 5C00A88F */  lw         $t0, 0x5C($sp)
    /* B4604 800C3E04 00000000 */  nop
    /* B4608 800C3E08 0A00001D */  bgtz       $t0, .L800C3E34
    /* B460C 800C3E0C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* B4610 800C3E10 04000215 */  bne        $t0, $v0, .L800C3E24
    /* B4614 800C3E14 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* B4618 800C3E18 05000224 */  addiu      $v0, $zero, 0x5
    /* B461C 800C3E1C 05000212 */  beq        $s0, $v0, .L800C3E34
    /* B4620 800C3E20 FEFF0224 */   addiu     $v0, $zero, -0x2
  .L800C3E24:
    /* B4624 800C3E24 1E000215 */  bne        $t0, $v0, .L800C3EA0
    /* B4628 800C3E28 05000224 */   addiu     $v0, $zero, 0x5
    /* B462C 800C3E2C 1C000212 */  beq        $s0, $v0, .L800C3EA0
    /* B4630 800C3E30 00000000 */   nop
  .L800C3E34:
    /* B4634 800C3E34 0000CC8E */  lw         $t4, 0x0($s6)
    /* B4638 800C3E38 0400CD8E */  lw         $t5, 0x4($s6)
    /* B463C 800C3E3C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B4640 800C3E40 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B4644 800C3E44 0800CC8E */  lw         $t4, 0x8($s6)
    /* B4648 800C3E48 0C00CD8E */  lw         $t5, 0xC($s6)
    /* B464C 800C3E4C 1000CE8E */  lw         $t6, 0x10($s6)
    /* B4650 800C3E50 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B4654 800C3E54 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B4658 800C3E58 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B465C 800C3E5C 1400CC8E */  lw         $t4, 0x14($s6)
    /* B4660 800C3E60 1800CD8E */  lw         $t5, 0x18($s6)
    /* B4664 800C3E64 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B4668 800C3E68 1C00CE8E */  lw         $t6, 0x1C($s6)
    /* B466C 800C3E6C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B4670 800C3E70 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B4674 800C3E74 FF006432 */  andi       $a0, $s3, 0xFF
    /* B4678 800C3E78 00018434 */  ori        $a0, $a0, 0x100
    /* B467C 800C3E7C AC004526 */  addiu      $a1, $s2, 0xAC
    /* B4680 800C3E80 00002286 */  lh         $v0, 0x0($s1)
    /* B4684 800C3E84 B4004626 */  addiu      $a2, $s2, 0xB4
    /* B4688 800C3E88 1000A2AF */  sw         $v0, 0x10($sp)
    /* B468C 800C3E8C 3C00428E */  lw         $v0, 0x3C($s2)
    /* B4690 800C3E90 BC004726 */  addiu      $a3, $s2, 0xBC
    /* B4694 800C3E94 1800B2AF */  sw         $s2, 0x18($sp)
    /* B4698 800C3E98 D632030C */  jal        Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
    /* B469C 800C3E9C 1400A2AF */   sw        $v0, 0x14($sp)
  .L800C3EA0:
    /* B46A0 800C3EA0 D90E0308 */  j          .L800C3B64
    /* B46A4 800C3EA4 000054AE */   sw        $s4, 0x0($s2)
  .L800C3EA8:
    /* B46A8 800C3EA8 4400BF8F */  lw         $ra, 0x44($sp)
    /* B46AC 800C3EAC 4000BE8F */  lw         $fp, 0x40($sp)
    /* B46B0 800C3EB0 3C00B78F */  lw         $s7, 0x3C($sp)
    /* B46B4 800C3EB4 3800B68F */  lw         $s6, 0x38($sp)
    /* B46B8 800C3EB8 3400B58F */  lw         $s5, 0x34($sp)
    /* B46BC 800C3EBC 3000B48F */  lw         $s4, 0x30($sp)
    /* B46C0 800C3EC0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* B46C4 800C3EC4 2800B28F */  lw         $s2, 0x28($sp)
    /* B46C8 800C3EC8 2400B18F */  lw         $s1, 0x24($sp)
    /* B46CC 800C3ECC 2000B08F */  lw         $s0, 0x20($sp)
    /* B46D0 800C3ED0 0800E003 */  jr         $ra
    /* B46D4 800C3ED4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
