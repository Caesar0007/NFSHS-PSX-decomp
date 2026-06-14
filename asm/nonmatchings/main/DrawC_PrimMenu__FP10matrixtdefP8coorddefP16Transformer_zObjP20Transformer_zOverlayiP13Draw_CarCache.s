.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache, 0x780

glabel DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* B3AB0 800C32B0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* B3AB4 800C32B4 2000B4AF */  sw         $s4, 0x20($sp)
    /* B3AB8 800C32B8 4000B48F */  lw         $s4, 0x40($sp)
    /* B3ABC 800C32BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* B3AC0 800C32C0 4400B18F */  lw         $s1, 0x44($sp)
    /* B3AC4 800C32C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* B3AC8 800C32C8 21808000 */  addu       $s0, $a0, $zero
    /* B3ACC 800C32CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* B3AD0 800C32D0 2190A000 */  addu       $s2, $a1, $zero
    /* B3AD4 800C32D4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* B3AD8 800C32D8 2198C000 */  addu       $s3, $a2, $zero
    /* B3ADC 800C32DC 2400B5AF */  sw         $s5, 0x24($sp)
    /* B3AE0 800C32E0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* B3AE4 800C32E4 2800B6AF */  sw         $s6, 0x28($sp)
    /* B3AE8 800C32E8 1400638E */  lw         $v1, 0x14($s3)
    /* B3AEC 800C32EC 01008232 */  andi       $v0, $s4, 0x1
    /* B3AF0 800C32F0 38004010 */  beqz       $v0, .L800C33D4
    /* B3AF4 800C32F4 21A8E000 */   addu      $s5, $a3, $zero
    /* B3AF8 800C32F8 21386000 */  addu       $a3, $v1, $zero
    /* B3AFC 800C32FC 1280163C */  lui        $s6, %hi(DrawC_gMatA)
    /* B3B00 800C3300 E8F4D626 */  addiu      $s6, $s6, %lo(DrawC_gMatA)
    /* B3B04 800C3304 0000CC8E */  lw         $t4, 0x0($s6)
    /* B3B08 800C3308 0400CD8E */  lw         $t5, 0x4($s6)
    /* B3B0C 800C330C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B3B10 800C3310 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B3B14 800C3314 0800CC8E */  lw         $t4, 0x8($s6)
    /* B3B18 800C3318 0C00CD8E */  lw         $t5, 0xC($s6)
    /* B3B1C 800C331C 1000CE8E */  lw         $t6, 0x10($s6)
    /* B3B20 800C3320 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B3B24 800C3324 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B3B28 800C3328 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B3B2C 800C332C 1280163C */  lui        $s6, %hi(DrawC_gMatA)
    /* B3B30 800C3330 E8F4D626 */  addiu      $s6, $s6, %lo(DrawC_gMatA)
    /* B3B34 800C3334 1400CC8E */  lw         $t4, 0x14($s6)
    /* B3B38 800C3338 1800CD8E */  lw         $t5, 0x18($s6)
    /* B3B3C 800C333C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B3B40 800C3340 1C00CE8E */  lw         $t6, 0x1C($s6)
    /* B3B44 800C3344 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B3B48 800C3348 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B3B4C 800C334C 00007896 */  lhu        $t8, 0x0($s3)
    /* B3B50 800C3350 FFFF0A24 */  addiu      $t2, $zero, -0x1
    /* B3B54 800C3354 AC002926 */  addiu      $t1, $s1, 0xAC
    /* B3B58 800C3358 9C002826 */  addiu      $t0, $s1, 0x9C
    /* B3B5C 800C335C D7002626 */  addiu      $a2, $s1, 0xD7
    /* B3B60 800C3360 0400E524 */  addiu      $a1, $a3, 0x4
  .L800C3364:
    /* B3B64 800C3364 FFFF1827 */  addiu      $t8, $t8, -0x1
    /* B3B68 800C3368 1A000A13 */  beq        $t8, $t2, .L800C33D4
    /* B3B6C 800C336C 00000000 */   nop
    /* B3B70 800C3370 0000E294 */  lhu        $v0, 0x0($a3)
    /* B3B74 800C3374 FEFFA394 */  lhu        $v1, -0x2($a1)
    /* B3B78 800C3378 0000A494 */  lhu        $a0, 0x0($a1)
    /* B3B7C 800C337C AC0022A6 */  sh         $v0, 0xAC($s1)
    /* B3B80 800C3380 AE0023A6 */  sh         $v1, 0xAE($s1)
    /* B3B84 800C3384 B00024A6 */  sh         $a0, 0xB0($s1)
    /* B3B88 800C3388 000020C9 */  lwc2       $0, 0x0($t1)
    /* B3B8C 800C338C 040021C9 */  lwc2       $1, 0x4($t1)
    /* B3B90 800C3390 00000000 */  nop
    /* B3B94 800C3394 00000000 */  nop
    /* B3B98 800C3398 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B3B9C 800C339C 000019E9 */  swc2       $25, 0x0($t0)
    /* B3BA0 800C33A0 04001AE9 */  swc2       $26, 0x4($t0) /* handwritten instruction */
    /* B3BA4 800C33A4 08001BE9 */  swc2       $27, 0x8($t0) /* handwritten instruction */
    /* B3BA8 800C33A8 A400228E */  lw         $v0, 0xA4($s1)
    /* B3BAC 800C33AC 9C00238E */  lw         $v1, 0x9C($s1)
    /* B3BB0 800C33B0 02004104 */  bgez       $v0, .L800C33BC
    /* B3BB4 800C33B4 00000000 */   nop
    /* B3BB8 800C33B8 23100200 */  negu       $v0, $v0
  .L800C33BC:
    /* B3BBC 800C33BC 0600A524 */  addiu      $a1, $a1, 0x6
    /* B3BC0 800C33C0 0600E724 */  addiu      $a3, $a3, 0x6
    /* B3BC4 800C33C4 FFFFC3A0 */  sb         $v1, -0x1($a2)
    /* B3BC8 800C33C8 0000C2A0 */  sb         $v0, 0x0($a2)
    /* B3BCC 800C33CC D90C0308 */  j          .L800C3364
    /* B3BD0 800C33D0 0800C624 */   addiu     $a2, $a2, 0x8
  .L800C33D4:
    /* B3BD4 800C33D4 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B3BD8 800C33D8 08000424 */   addiu     $a0, $zero, 0x8
    /* B3BDC 800C33DC 0000028E */  lw         $v0, 0x0($s0)
    /* B3BE0 800C33E0 0C00038E */  lw         $v1, 0xC($s0)
    /* B3BE4 800C33E4 1800048E */  lw         $a0, 0x18($s0)
    /* B3BE8 800C33E8 03110200 */  sra        $v0, $v0, 4
    /* B3BEC 800C33EC 03190300 */  sra        $v1, $v1, 4
    /* B3BF0 800C33F0 03210400 */  sra        $a0, $a0, 4
    /* B3BF4 800C33F4 140022A6 */  sh         $v0, 0x14($s1)
    /* B3BF8 800C33F8 160023A6 */  sh         $v1, 0x16($s1)
    /* B3BFC 800C33FC 180024A6 */  sh         $a0, 0x18($s1)
    /* B3C00 800C3400 0400028E */  lw         $v0, 0x4($s0)
    /* B3C04 800C3404 1000038E */  lw         $v1, 0x10($s0)
    /* B3C08 800C3408 1C00048E */  lw         $a0, 0x1C($s0)
    /* B3C0C 800C340C 03110200 */  sra        $v0, $v0, 4
    /* B3C10 800C3410 03190300 */  sra        $v1, $v1, 4
    /* B3C14 800C3414 03210400 */  sra        $a0, $a0, 4
    /* B3C18 800C3418 1A0022A6 */  sh         $v0, 0x1A($s1)
    /* B3C1C 800C341C 1C0023A6 */  sh         $v1, 0x1C($s1)
    /* B3C20 800C3420 1E0024A6 */  sh         $a0, 0x1E($s1)
    /* B3C24 800C3424 0800038E */  lw         $v1, 0x8($s0)
    /* B3C28 800C3428 1400048E */  lw         $a0, 0x14($s0)
    /* B3C2C 800C342C 2000058E */  lw         $a1, 0x20($s0)
    /* B3C30 800C3430 23100200 */  negu       $v0, $v0
    /* B3C34 800C3434 1A0022A6 */  sh         $v0, 0x1A($s1)
    /* B3C38 800C3438 1C002296 */  lhu        $v0, 0x1C($s1)
    /* B3C3C 800C343C 03190300 */  sra        $v1, $v1, 4
    /* B3C40 800C3440 03210400 */  sra        $a0, $a0, 4
    /* B3C44 800C3444 03290500 */  sra        $a1, $a1, 4
    /* B3C48 800C3448 200023A6 */  sh         $v1, 0x20($s1)
    /* B3C4C 800C344C 1E002396 */  lhu        $v1, 0x1E($s1)
    /* B3C50 800C3450 23100200 */  negu       $v0, $v0
    /* B3C54 800C3454 220024A6 */  sh         $a0, 0x22($s1)
    /* B3C58 800C3458 240025A6 */  sh         $a1, 0x24($s1)
    /* B3C5C 800C345C 1C0022A6 */  sh         $v0, 0x1C($s1)
    /* B3C60 800C3460 23180300 */  negu       $v1, $v1
    /* B3C64 800C3464 1E0023A6 */  sh         $v1, 0x1E($s1)
    /* B3C68 800C3468 0000428E */  lw         $v0, 0x0($s2)
    /* B3C6C 800C346C 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B3C70 800C3470 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B3C74 800C3474 00000000 */  nop
    /* B3C78 800C3478 07106200 */  srav       $v0, $v0, $v1
    /* B3C7C 800C347C 280022AE */  sw         $v0, 0x28($s1)
    /* B3C80 800C3480 0400428E */  lw         $v0, 0x4($s2)
    /* B3C84 800C3484 00000000 */  nop
    /* B3C88 800C3488 07106200 */  srav       $v0, $v0, $v1
    /* B3C8C 800C348C 23100200 */  negu       $v0, $v0
    /* B3C90 800C3490 2C0022AE */  sw         $v0, 0x2C($s1)
    /* B3C94 800C3494 0800428E */  lw         $v0, 0x8($s2)
    /* B3C98 800C3498 00000000 */  nop
    /* B3C9C 800C349C 07106200 */  srav       $v0, $v0, $v1
    /* B3CA0 800C34A0 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B3CA4 800C34A4 300022AE */   sw        $v0, 0x30($s1)
    /* B3CA8 800C34A8 14002226 */  addiu      $v0, $s1, 0x14
    /* B3CAC 800C34AC 00004C8C */  lw         $t4, 0x0($v0)
    /* B3CB0 800C34B0 04004D8C */  lw         $t5, 0x4($v0)
    /* B3CB4 800C34B4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B3CB8 800C34B8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B3CBC 800C34BC 08004C8C */  lw         $t4, 0x8($v0)
    /* B3CC0 800C34C0 0C004D8C */  lw         $t5, 0xC($v0)
    /* B3CC4 800C34C4 10004E8C */  lw         $t6, 0x10($v0)
    /* B3CC8 800C34C8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B3CCC 800C34CC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B3CD0 800C34D0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B3CD4 800C34D4 14004C8C */  lw         $t4, 0x14($v0)
    /* B3CD8 800C34D8 18004D8C */  lw         $t5, 0x18($v0)
    /* B3CDC 800C34DC 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B3CE0 800C34E0 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B3CE4 800C34E4 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B3CE8 800C34E8 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B3CEC 800C34EC D0002826 */  addiu      $t0, $s1, 0xD0
    /* B3CF0 800C34F0 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* B3CF4 800C34F4 D4002626 */  addiu      $a2, $s1, 0xD4
    /* B3CF8 800C34F8 1000678E */  lw         $a3, 0x10($s3)
    /* B3CFC 800C34FC 00007896 */  lhu        $t8, 0x0($s3)
    /* B3D00 800C3500 0400E524 */  addiu      $a1, $a3, 0x4
  .L800C3504:
    /* B3D04 800C3504 FFFF1827 */  addiu      $t8, $t8, -0x1
    /* B3D08 800C3508 0C000913 */  beq        $t8, $t1, .L800C353C
    /* B3D0C 800C350C 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* B3D10 800C3510 FEFFA294 */  lhu        $v0, -0x2($a1)
    /* B3D14 800C3514 0000A494 */  lhu        $a0, 0x0($a1)
    /* B3D18 800C3518 0600A524 */  addiu      $a1, $a1, 0x6
    /* B3D1C 800C351C 0000E394 */  lhu        $v1, 0x0($a3)
    /* B3D20 800C3520 0600E724 */  addiu      $a3, $a3, 0x6
    /* B3D24 800C3524 000003A5 */  sh         $v1, 0x0($t0)
    /* B3D28 800C3528 FEFFC2A4 */  sh         $v0, -0x2($a2)
    /* B3D2C 800C352C 0000C4A4 */  sh         $a0, 0x0($a2)
    /* B3D30 800C3530 0800C624 */  addiu      $a2, $a2, 0x8
    /* B3D34 800C3534 410D0308 */  j          .L800C3504
    /* B3D38 800C3538 08000825 */   addiu     $t0, $t0, 0x8
  .L800C353C:
    /* B3D3C 800C353C 02007896 */  lhu        $t8, 0x2($s3)
    /* B3D40 800C3540 08F55224 */  addiu      $s2, $v0, %lo(DrawC_gOverlay)
    /* B3D44 800C3544 40101800 */  sll        $v0, $t8, 1
    /* B3D48 800C3548 21105800 */  addu       $v0, $v0, $t8
    /* B3D4C 800C354C 80C80200 */  sll        $t9, $v0, 2
  .L800C3550:
    /* B3D50 800C3550 FFFF1827 */  addiu      $t8, $t8, -0x1
  .L800C3554:
    /* B3D54 800C3554 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B3D58 800C3558 2B010213 */  beq        $t8, $v0, .L800C3A08
    /* B3D5C 800C355C F4FF3927 */   addiu     $t9, $t9, -0xC
    /* B3D60 800C3560 1800628E */  lw         $v0, 0x18($s3)
    /* B3D64 800C3564 0800238E */  lw         $v1, 0x8($s1)
    /* B3D68 800C3568 21405900 */  addu       $t0, $v0, $t9
    /* B3D6C 800C356C 03000A91 */  lbu        $t2, 0x3($t0)
    /* B3D70 800C3570 04000991 */  lbu        $t1, 0x4($t0)
    /* B3D74 800C3574 0400228E */  lw         $v0, 0x4($s1)
    /* B3D78 800C3578 05000691 */  lbu        $a2, 0x5($t0)
    /* B3D7C 800C357C 2B104300 */  sltu       $v0, $v0, $v1
    /* B3D80 800C3580 F4FF4010 */  beqz       $v0, .L800C3554
    /* B3D84 800C3584 FFFF1827 */   addiu     $t8, $t8, -0x1
    /* B3D88 800C3588 01001827 */  addiu      $t8, $t8, 0x1
    /* B3D8C 800C358C C0500A00 */  sll        $t2, $t2, 3
    /* B3D90 800C3590 21505101 */  addu       $t2, $t2, $s1
    /* B3D94 800C3594 C0480900 */  sll        $t1, $t1, 3
    /* B3D98 800C3598 21483101 */  addu       $t1, $t1, $s1
    /* B3D9C 800C359C C0300600 */  sll        $a2, $a2, 3
    /* B3DA0 800C35A0 2130D100 */  addu       $a2, $a2, $s1
    /* B3DA4 800C35A4 D00040C9 */  lwc2       $0, 0xD0($t2)
    /* B3DA8 800C35A8 D40041C9 */  lwc2       $1, 0xD4($t2)
    /* B3DAC 800C35AC D00022C9 */  lwc2       $2, 0xD0($t1)
    /* B3DB0 800C35B0 D40023C9 */  lwc2       $3, 0xD4($t1)
    /* B3DB4 800C35B4 D000C4C8 */  lwc2       $4, 0xD0($a2)
    /* B3DB8 800C35B8 D400C5C8 */  lwc2       $5, 0xD4($a2)
    /* B3DBC 800C35BC 00000000 */  nop
    /* B3DC0 800C35C0 00000000 */  nop
    /* B3DC4 800C35C4 3000284A */  .word 0x4A280030  /* rtpt */
    /* B3DC8 800C35C8 00000000 */  nop
    /* B3DCC 800C35CC 00000000 */  nop
    /* B3DD0 800C35D0 0600404B */  .word 0x4B400006  /* nclip */
    /* B3DD4 800C35D4 440038EA */  swc2       $24, 0x44($s1)
    /* B3DD8 800C35D8 0C00228E */  lw         $v0, 0xC($s1)
    /* B3DDC 800C35DC 4400238E */  lw         $v1, 0x44($s1)
    /* B3DE0 800C35E0 02004010 */  beqz       $v0, .L800C35EC
    /* B3DE4 800C35E4 00000000 */   nop
    /* B3DE8 800C35E8 23180300 */  negu       $v1, $v1
  .L800C35EC:
    /* B3DEC 800C35EC D9FF6018 */  blez       $v1, .L800C3554
    /* B3DF0 800C35F0 FFFF1827 */   addiu     $t8, $t8, -0x1
    /* B3DF4 800C35F4 01001827 */  addiu      $t8, $t8, 0x1
    /* B3DF8 800C35F8 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B3DFC 800C35FC C8002DEA */  swc2       $13, 0xC8($s1)
    /* B3E00 800C3600 CC002EEA */  swc2       $14, 0xCC($s1)
    /* B3E04 800C3604 00000000 */  nop
    /* B3E08 800C3608 00000000 */  nop
    /* B3E0C 800C360C 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B3E10 800C3610 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B3E14 800C3614 3C00238E */  lw         $v1, 0x3C($s1)
    /* B3E18 800C3618 4000228E */  lw         $v0, 0x40($s1)
    /* B3E1C 800C361C 00000000 */  nop
    /* B3E20 800C3620 21186200 */  addu       $v1, $v1, $v0
    /* B3E24 800C3624 CAFF6004 */  bltz       $v1, .L800C3550
    /* B3E28 800C3628 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B3E2C 800C362C 8800228E */  lw         $v0, 0x88($s1)
    /* B3E30 800C3630 00000000 */  nop
    /* B3E34 800C3634 2A104300 */  slt        $v0, $v0, $v1
    /* B3E38 800C3638 C6FF4014 */  bnez       $v0, .L800C3554
    /* B3E3C 800C363C FFFF1827 */   addiu     $t8, $t8, -0x1
    /* B3E40 800C3640 01001827 */  addiu      $t8, $t8, 0x1
    /* B3E44 800C3644 02000291 */  lbu        $v0, 0x2($t0)
    /* B3E48 800C3648 00000495 */  lhu        $a0, 0x0($t0)
    /* B3E4C 800C364C 40100200 */  sll        $v0, $v0, 1
    /* B3E50 800C3650 21105200 */  addu       $v0, $v0, $s2
    /* B3E54 800C3654 00004294 */  lhu        $v0, 0x0($v0)
    /* B3E58 800C3658 00000000 */  nop
    /* B3E5C 800C365C 001C0200 */  sll        $v1, $v0, 16
    /* B3E60 800C3660 032C0300 */  sra        $a1, $v1, 16
    /* B3E64 800C3664 1100A010 */  beqz       $a1, .L800C36AC
    /* B3E68 800C3668 FF0F8B30 */   andi      $t3, $a0, 0xFFF
    /* B3E6C 800C366C 00140400 */  sll        $v0, $a0, 16
    /* B3E70 800C3670 02004104 */  bgez       $v0, .L800C367C
    /* B3E74 800C3674 3F00A530 */   andi      $a1, $a1, 0x3F
    /* B3E78 800C3678 032E0300 */  sra        $a1, $v1, 24
  .L800C367C:
    /* B3E7C 800C367C F0036231 */  andi       $v0, $t3, 0x3F0
    /* B3E80 800C3680 0A004010 */  beqz       $v0, .L800C36AC
    /* B3E84 800C3684 02110B00 */   srl       $v0, $t3, 4
    /* B3E88 800C3688 2428A200 */  and        $a1, $a1, $v0
    /* B3E8C 800C368C 0700A010 */  beqz       $a1, .L800C36AC
    /* B3E90 800C3690 0300A230 */   andi      $v0, $a1, 0x3
    /* B3E94 800C3694 06004014 */  bnez       $v0, .L800C36B0
    /* B3E98 800C3698 01008232 */   andi      $v0, $s4, 0x1
  .L800C369C:
    /* B3E9C 800C369C 83280500 */  sra        $a1, $a1, 2
    /* B3EA0 800C36A0 0300A230 */  andi       $v0, $a1, 0x3
    /* B3EA4 800C36A4 FDFF4010 */  beqz       $v0, .L800C369C
    /* B3EA8 800C36A8 00000000 */   nop
  .L800C36AC:
    /* B3EAC 800C36AC 01008232 */  andi       $v0, $s4, 0x1
  .L800C36B0:
    /* B3EB0 800C36B0 5B004010 */  beqz       $v0, .L800C3820
    /* B3EB4 800C36B4 0300A230 */   andi      $v0, $a1, 0x3
    /* B3EB8 800C36B8 04002C8E */  lw         $t4, 0x4($s1)
    /* B3EBC 800C36BC 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B3EC0 800C36C0 38002E8E */  lw         $t6, 0x38($s1)
    /* B3EC4 800C36C4 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B3EC8 800C36C8 80680D00 */  sll        $t5, $t5, 2
    /* B3ECC 800C36CC 2170CD01 */  addu       $t6, $t6, $t5
    /* B3ED0 800C36D0 04002FAE */  sw         $t7, 0x4($s1)
    /* B3ED4 800C36D4 54002D8E */  lw         $t5, 0x54($s1)
    /* B3ED8 800C36D8 58002F8E */  lw         $t7, 0x58($s1)
    /* B3EDC 800C36DC 5C00308E */  lw         $s0, 0x5C($s1)
    /* B3EE0 800C36E0 00008DAD */  sw         $t5, 0x0($t4)
    /* B3EE4 800C36E4 04008FAD */  sw         $t7, 0x4($t4)
    /* B3EE8 800C36E8 080090AD */  sw         $s0, 0x8($t4)
    /* B3EEC 800C36EC 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B3EF0 800C36F0 007A0C00 */  sll        $t7, $t4, 8
    /* B3EF4 800C36F4 02008DA9 */  swl        $t5, 0x2($t4)
    /* B3EF8 800C36F8 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B3EFC 800C36FC 0400278E */  lw         $a3, 0x4($s1)
    /* B3F00 800C3700 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B3F04 800C3704 38002D8E */  lw         $t5, 0x38($s1)
    /* B3F08 800C3708 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B3F0C 800C370C 80600C00 */  sll        $t4, $t4, 2
    /* B3F10 800C3710 2168AC01 */  addu       $t5, $t5, $t4
    /* B3F14 800C3714 04002EAE */  sw         $t6, 0x4($s1)
    /* B3F18 800C3718 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B3F1C 800C371C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B3F20 800C3720 02720E00 */  srl        $t6, $t6, 8
    /* B3F24 800C3724 2570CC01 */  or         $t6, $t6, $t4
    /* B3F28 800C3728 00620700 */  sll        $t4, $a3, 8
    /* B3F2C 800C372C 0000EEAC */  sw         $t6, 0x0($a3)
    /* B3F30 800C3730 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B3F34 800C3734 04002C8E */  lw         $t4, 0x4($s1)
    /* B3F38 800C3738 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B3F3C 800C373C 38002E8E */  lw         $t6, 0x38($s1)
    /* B3F40 800C3740 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B3F44 800C3744 80680D00 */  sll        $t5, $t5, 2
    /* B3F48 800C3748 2170CD01 */  addu       $t6, $t6, $t5
    /* B3F4C 800C374C 04002FAE */  sw         $t7, 0x4($s1)
    /* B3F50 800C3750 48002D8E */  lw         $t5, 0x48($s1)
    /* B3F54 800C3754 4C002F8E */  lw         $t7, 0x4C($s1)
    /* B3F58 800C3758 5000308E */  lw         $s0, 0x50($s1)
    /* B3F5C 800C375C 00008DAD */  sw         $t5, 0x0($t4)
    /* B3F60 800C3760 04008FAD */  sw         $t7, 0x4($t4)
    /* B3F64 800C3764 080090AD */  sw         $s0, 0x8($t4)
    /* B3F68 800C3768 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B3F6C 800C376C 007A0C00 */  sll        $t7, $t4, 8
    /* B3F70 800C3770 02008DA9 */  swl        $t5, 0x2($t4)
    /* B3F74 800C3774 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B3F78 800C3778 C400228E */  lw         $v0, 0xC4($s1)
    /* B3F7C 800C377C C800238E */  lw         $v1, 0xC8($s1)
    /* B3F80 800C3780 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3F84 800C3784 0800E2AC */  sw         $v0, 0x8($a3)
    /* B3F88 800C3788 04006231 */  andi       $v0, $t3, 0x4
    /* B3F8C 800C378C 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3F90 800C3790 04004010 */  beqz       $v0, .L800C37A4
    /* B3F94 800C3794 1800E4AC */   sw        $a0, 0x18($a3)
    /* B3F98 800C3798 9400228E */  lw         $v0, 0x94($s1)
    /* B3F9C 800C379C EC0D0308 */  j          .L800C37B0
    /* B3FA0 800C37A0 0400E2AC */   sw        $v0, 0x4($a3)
  .L800C37A4:
    /* B3FA4 800C37A4 9000228E */  lw         $v0, 0x90($s1)
    /* B3FA8 800C37A8 00000000 */  nop
    /* B3FAC 800C37AC 0400E2AC */  sw         $v0, 0x4($a3)
  .L800C37B0:
    /* B3FB0 800C37B0 26000224 */  addiu      $v0, $zero, 0x26
    /* B3FB4 800C37B4 0700E2A0 */  sb         $v0, 0x7($a3)
    /* B3FB8 800C37B8 66002296 */  lhu        $v0, 0x66($s1)
    /* B3FBC 800C37BC 6A002396 */  lhu        $v1, 0x6A($s1)
    /* B3FC0 800C37C0 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B3FC4 800C37C4 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B3FC8 800C37C8 64002E92 */  lbu        $t6, 0x64($s1)
    /* B3FCC 800C37CC 65002F92 */  lbu        $t7, 0x65($s1)
    /* B3FD0 800C37D0 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B3FD4 800C37D4 D6004C91 */  lbu        $t4, 0xD6($t2)
    /* B3FD8 800C37D8 D7004D91 */  lbu        $t5, 0xD7($t2)
    /* B3FDC 800C37DC 21608E01 */  addu       $t4, $t4, $t6
    /* B3FE0 800C37E0 0C00ECA0 */  sb         $t4, 0xC($a3)
    /* B3FE4 800C37E4 2168AF01 */  addu       $t5, $t5, $t7
    /* B3FE8 800C37E8 0D00EDA0 */  sb         $t5, 0xD($a3)
    /* B3FEC 800C37EC D6002C91 */  lbu        $t4, 0xD6($t1)
    /* B3FF0 800C37F0 D7002D91 */  lbu        $t5, 0xD7($t1)
    /* B3FF4 800C37F4 21608E01 */  addu       $t4, $t4, $t6
    /* B3FF8 800C37F8 1400ECA0 */  sb         $t4, 0x14($a3)
    /* B3FFC 800C37FC 2168AF01 */  addu       $t5, $t5, $t7
    /* B4000 800C3800 1500EDA0 */  sb         $t5, 0x15($a3)
    /* B4004 800C3804 D600CC90 */  lbu        $t4, 0xD6($a2)
    /* B4008 800C3808 D700CD90 */  lbu        $t5, 0xD7($a2)
    /* B400C 800C380C 21608E01 */  addu       $t4, $t4, $t6
    /* B4010 800C3810 1C00ECA0 */  sb         $t4, 0x1C($a3)
    /* B4014 800C3814 2168AF01 */  addu       $t5, $t5, $t7
    /* B4018 800C3818 1D00EDA0 */  sb         $t5, 0x1D($a3)
    /* B401C 800C381C 0300A230 */  andi       $v0, $a1, 0x3
  .L800C3820:
    /* B4020 800C3820 2E004010 */  beqz       $v0, .L800C38DC
    /* B4024 800C3824 FFFF4424 */   addiu     $a0, $v0, -0x1
    /* B4028 800C3828 02000391 */  lbu        $v1, 0x2($t0)
    /* B402C 800C382C 0400278E */  lw         $a3, 0x4($s1)
    /* B4030 800C3830 40100300 */  sll        $v0, $v1, 1
    /* B4034 800C3834 21104300 */  addu       $v0, $v0, $v1
    /* B4038 800C3838 21104400 */  addu       $v0, $v0, $a0
    /* B403C 800C383C 80100200 */  sll        $v0, $v0, 2
    /* B4040 800C3840 2130A202 */  addu       $a2, $s5, $v0
    /* B4044 800C3844 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B4048 800C3848 38002D8E */  lw         $t5, 0x38($s1)
    /* B404C 800C384C 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B4050 800C3850 80600C00 */  sll        $t4, $t4, 2
    /* B4054 800C3854 2168AC01 */  addu       $t5, $t5, $t4
    /* B4058 800C3858 04002EAE */  sw         $t6, 0x4($s1)
    /* B405C 800C385C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B4060 800C3860 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B4064 800C3864 02720E00 */  srl        $t6, $t6, 8
    /* B4068 800C3868 2570CC01 */  or         $t6, $t6, $t4
    /* B406C 800C386C 00620700 */  sll        $t4, $a3, 8
    /* B4070 800C3870 0000EEAC */  sw         $t6, 0x0($a3)
    /* B4074 800C3874 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B4078 800C3878 C400228E */  lw         $v0, 0xC4($s1)
    /* B407C 800C387C C800238E */  lw         $v1, 0xC8($s1)
    /* B4080 800C3880 CC00248E */  lw         $a0, 0xCC($s1)
    /* B4084 800C3884 0800E2AC */  sw         $v0, 0x8($a3)
    /* B4088 800C3888 01006231 */  andi       $v0, $t3, 0x1
    /* B408C 800C388C 1000E3AC */  sw         $v1, 0x10($a3)
    /* B4090 800C3890 1800E4AC */  sw         $a0, 0x18($a3)
    /* B4094 800C3894 8C00238E */  lw         $v1, 0x8C($s1)
    /* B4098 800C3898 02004010 */  beqz       $v0, .L800C38A4
    /* B409C 800C389C 24000524 */   addiu     $a1, $zero, 0x24
    /* B40A0 800C38A0 26000524 */  addiu      $a1, $zero, 0x26
  .L800C38A4:
    /* B40A4 800C38A4 0400E3AC */  sw         $v1, 0x4($a3)
    /* B40A8 800C38A8 0700E5A0 */  sb         $a1, 0x7($a3)
    /* B40AC 800C38AC 02000391 */  lbu        $v1, 0x2($t0)
    /* B40B0 800C38B0 0000C284 */  lh         $v0, 0x0($a2)
    /* B40B4 800C38B4 0200C590 */  lbu        $a1, 0x2($a2)
    /* B40B8 800C38B8 0300C690 */  lbu        $a2, 0x3($a2)
    /* B40BC 800C38BC 21186200 */  addu       $v1, $v1, $v0
    /* B40C0 800C38C0 6000228E */  lw         $v0, 0x60($s1)
    /* B40C4 800C38C4 00190300 */  sll        $v1, $v1, 4
    /* B40C8 800C38C8 21104300 */  addu       $v0, $v0, $v1
    /* B40CC 800C38CC 02004394 */  lhu        $v1, 0x2($v0)
    /* B40D0 800C38D0 06004294 */  lhu        $v0, 0x6($v0)
    /* B40D4 800C38D4 5F0E0308 */  j          .L800C397C
    /* B40D8 800C38D8 0E00E3A4 */   sh        $v1, 0xE($a3)
  .L800C38DC:
    /* B40DC 800C38DC 0400278E */  lw         $a3, 0x4($s1)
    /* B40E0 800C38E0 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B40E4 800C38E4 38002D8E */  lw         $t5, 0x38($s1)
    /* B40E8 800C38E8 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B40EC 800C38EC 80600C00 */  sll        $t4, $t4, 2
    /* B40F0 800C38F0 2168AC01 */  addu       $t5, $t5, $t4
    /* B40F4 800C38F4 04002EAE */  sw         $t6, 0x4($s1)
    /* B40F8 800C38F8 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B40FC 800C38FC 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B4100 800C3900 02720E00 */  srl        $t6, $t6, 8
    /* B4104 800C3904 2570CC01 */  or         $t6, $t6, $t4
    /* B4108 800C3908 00620700 */  sll        $t4, $a3, 8
    /* B410C 800C390C 0000EEAC */  sw         $t6, 0x0($a3)
    /* B4110 800C3910 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B4114 800C3914 C400228E */  lw         $v0, 0xC4($s1)
    /* B4118 800C3918 C800238E */  lw         $v1, 0xC8($s1)
    /* B411C 800C391C CC00248E */  lw         $a0, 0xCC($s1)
    /* B4120 800C3920 1000E3AC */  sw         $v1, 0x10($a3)
    /* B4124 800C3924 01006331 */  andi       $v1, $t3, 0x1
    /* B4128 800C3928 0800E2AC */  sw         $v0, 0x8($a3)
    /* B412C 800C392C 1800E4AC */  sw         $a0, 0x18($a3)
    /* B4130 800C3930 8C00228E */  lw         $v0, 0x8C($s1)
    /* B4134 800C3934 02006010 */  beqz       $v1, .L800C3940
    /* B4138 800C3938 24000524 */   addiu     $a1, $zero, 0x24
    /* B413C 800C393C 26000524 */  addiu      $a1, $zero, 0x26
  .L800C3940:
    /* B4140 800C3940 0400E2AC */  sw         $v0, 0x4($a3)
    /* B4144 800C3944 02008232 */  andi       $v0, $s4, 0x2
    /* B4148 800C3948 20004010 */  beqz       $v0, .L800C39CC
    /* B414C 800C394C 0700E5A0 */   sb        $a1, 0x7($a3)
    /* B4150 800C3950 1E006014 */  bnez       $v1, .L800C39CC
    /* B4154 800C3954 00000000 */   nop
    /* B4158 800C3958 02000291 */  lbu        $v0, 0x2($t0)
    /* B415C 800C395C 6000238E */  lw         $v1, 0x60($s1)
    /* B4160 800C3960 EE032592 */  lbu        $a1, 0x3EE($s1)
    /* B4164 800C3964 EF032692 */  lbu        $a2, 0x3EF($s1)
    /* B4168 800C3968 00110200 */  sll        $v0, $v0, 4
    /* B416C 800C396C 21186200 */  addu       $v1, $v1, $v0
    /* B4170 800C3970 02006494 */  lhu        $a0, 0x2($v1)
    /* B4174 800C3974 06006294 */  lhu        $v0, 0x6($v1)
    /* B4178 800C3978 0E00E4A4 */  sh         $a0, 0xE($a3)
  .L800C397C:
    /* B417C 800C397C 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B4180 800C3980 06000291 */  lbu        $v0, 0x6($t0)
    /* B4184 800C3984 08000391 */  lbu        $v1, 0x8($t0)
    /* B4188 800C3988 0A000491 */  lbu        $a0, 0xA($t0)
    /* B418C 800C398C 21104500 */  addu       $v0, $v0, $a1
    /* B4190 800C3990 21186500 */  addu       $v1, $v1, $a1
    /* B4194 800C3994 21208500 */  addu       $a0, $a0, $a1
    /* B4198 800C3998 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B419C 800C399C 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B41A0 800C39A0 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B41A4 800C39A4 07000291 */  lbu        $v0, 0x7($t0)
    /* B41A8 800C39A8 09000391 */  lbu        $v1, 0x9($t0)
    /* B41AC 800C39AC 0B000491 */  lbu        $a0, 0xB($t0)
    /* B41B0 800C39B0 21104600 */  addu       $v0, $v0, $a2
    /* B41B4 800C39B4 21186600 */  addu       $v1, $v1, $a2
    /* B41B8 800C39B8 21208600 */  addu       $a0, $a0, $a2
    /* B41BC 800C39BC 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B41C0 800C39C0 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B41C4 800C39C4 540D0308 */  j          .L800C3550
    /* B41C8 800C39C8 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C39CC:
    /* B41CC 800C39CC 02000291 */  lbu        $v0, 0x2($t0)
    /* B41D0 800C39D0 6000238E */  lw         $v1, 0x60($s1)
    /* B41D4 800C39D4 00110200 */  sll        $v0, $v0, 4
    /* B41D8 800C39D8 21186200 */  addu       $v1, $v1, $v0
    /* B41DC 800C39DC 02006294 */  lhu        $v0, 0x2($v1)
    /* B41E0 800C39E0 06006394 */  lhu        $v1, 0x6($v1)
    /* B41E4 800C39E4 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B41E8 800C39E8 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B41EC 800C39EC 06000295 */  lhu        $v0, 0x6($t0)
    /* B41F0 800C39F0 08000395 */  lhu        $v1, 0x8($t0)
    /* B41F4 800C39F4 0A000495 */  lhu        $a0, 0xA($t0)
    /* B41F8 800C39F8 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B41FC 800C39FC 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B4200 800C3A00 540D0308 */  j          .L800C3550
    /* B4204 800C3A04 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C3A08:
    /* B4208 800C3A08 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* B420C 800C3A0C 2800B68F */  lw         $s6, 0x28($sp)
    /* B4210 800C3A10 2400B58F */  lw         $s5, 0x24($sp)
    /* B4214 800C3A14 2000B48F */  lw         $s4, 0x20($sp)
    /* B4218 800C3A18 1C00B38F */  lw         $s3, 0x1C($sp)
    /* B421C 800C3A1C 1800B28F */  lw         $s2, 0x18($sp)
    /* B4220 800C3A20 1400B18F */  lw         $s1, 0x14($sp)
    /* B4224 800C3A24 1000B08F */  lw         $s0, 0x10($sp)
    /* B4228 800C3A28 0800E003 */  jr         $ra
    /* B422C 800C3A2C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
