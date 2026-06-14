.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache, 0x4A4

glabel DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
    /* B5384 800C4B84 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* B5388 800C4B88 0580033C */  lui        $v1, %hi(gShowroomLights)
    /* B538C 800C4B8C B414638C */  lw         $v1, %lo(gShowroomLights)($v1)
    /* B5390 800C4B90 1280023C */  lui        $v0, %hi(D_80120FDC)
    /* B5394 800C4B94 4400B1AF */  sw         $s1, 0x44($sp)
    /* B5398 800C4B98 DC0F518C */  lw         $s1, %lo(D_80120FDC)($v0)
    /* B539C 800C4B9C 4800B2AF */  sw         $s2, 0x48($sp)
    /* B53A0 800C4BA0 21908000 */  addu       $s2, $a0, $zero
    /* B53A4 800C4BA4 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* B53A8 800C4BA8 2198A000 */  addu       $s3, $a1, $zero
    /* B53AC 800C4BAC 4000B0AF */  sw         $s0, 0x40($sp)
    /* B53B0 800C4BB0 2180C000 */  addu       $s0, $a2, $zero
    /* B53B4 800C4BB4 5400BFAF */  sw         $ra, 0x54($sp)
    /* B53B8 800C4BB8 13016010 */  beqz       $v1, .L800C5008
    /* B53BC 800C4BBC 5000B4AF */   sw        $s4, 0x50($sp)
    /* B53C0 800C4BC0 88A0030C */  jal        gettick
    /* B53C4 800C4BC4 00000000 */   nop
    /* B53C8 800C4BC8 21184000 */  addu       $v1, $v0, $zero
    /* B53CC 800C4BCC 03006104 */  bgez       $v1, .L800C4BDC
    /* B53D0 800C4BD0 03120200 */   sra       $v0, $v0, 8
    /* B53D4 800C4BD4 FF006224 */  addiu      $v0, $v1, 0xFF
    /* B53D8 800C4BD8 03120200 */  sra        $v0, $v0, 8
  .L800C4BDC:
    /* B53DC 800C4BDC 00120200 */  sll        $v0, $v0, 8
    /* B53E0 800C4BE0 23106200 */  subu       $v0, $v1, $v0
    /* B53E4 800C4BE4 C3180200 */  sra        $v1, $v0, 3
    /* B53E8 800C4BE8 C012828F */  lw         $v0, %gp_rel(DrawC_gMenuLightsDirection)($gp)
    /* B53EC 800C4BEC FFFF0424 */  addiu      $a0, $zero, -0x1
    /* B53F0 800C4BF0 3000A3AF */  sw         $v1, 0x30($sp)
    /* B53F4 800C4BF4 06004014 */  bnez       $v0, .L800C4C10
    /* B53F8 800C4BF8 3800A4AF */   sw        $a0, 0x38($sp)
    /* B53FC 800C4BFC 10006224 */  addiu      $v0, $v1, 0x10
    /* B5400 800C4C00 1F004230 */  andi       $v0, $v0, 0x1F
    /* B5404 800C4C04 3400A2AF */  sw         $v0, 0x34($sp)
    /* B5408 800C4C08 09130308 */  j          .L800C4C24
    /* B540C 800C4C0C 3C00A4AF */   sw        $a0, 0x3C($sp)
  .L800C4C10:
    /* B5410 800C4C10 20000224 */  addiu      $v0, $zero, 0x20
    /* B5414 800C4C14 23104300 */  subu       $v0, $v0, $v1
    /* B5418 800C4C18 3400A2AF */  sw         $v0, 0x34($sp)
    /* B541C 800C4C1C 01000224 */  addiu      $v0, $zero, 0x1
    /* B5420 800C4C20 3C00A2AF */  sw         $v0, 0x3C($sp)
  .L800C4C24:
    /* B5424 800C4C24 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* B5428 800C4C28 1F000824 */  addiu      $t0, $zero, 0x1F
    /* B542C 800C4C2C 2F00A227 */  addiu      $v0, $sp, 0x2F
  .L800C4C30:
    /* B5430 800C4C30 000043A0 */  sb         $v1, 0x0($v0)
    /* B5434 800C4C34 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* B5438 800C4C38 FDFF0105 */  bgez       $t0, .L800C4C30
    /* B543C 800C4C3C FFFF4224 */   addiu     $v0, $v0, -0x1
    /* B5440 800C4C40 21400000 */  addu       $t0, $zero, $zero
    /* B5444 800C4C44 1000AA27 */  addiu      $t2, $sp, 0x10
    /* B5448 800C4C48 3800A927 */  addiu      $t1, $sp, 0x38
    /* B544C 800C4C4C 3000A627 */  addiu      $a2, $sp, 0x30
  .L800C4C50:
    /* B5450 800C4C50 21380000 */  addu       $a3, $zero, $zero
    /* B5454 800C4C54 2128C000 */  addu       $a1, $a2, $zero
    /* B5458 800C4C58 21202001 */  addu       $a0, $t1, $zero
  .L800C4C5C:
    /* B545C 800C4C5C 0000828C */  lw         $v0, 0x0($a0)
    /* B5460 800C4C60 00000000 */  nop
    /* B5464 800C4C64 1800E200 */  mult       $a3, $v0
    /* B5468 800C4C68 0000A28C */  lw         $v0, 0x0($a1)
    /* B546C 800C4C6C 12A00000 */  mflo       $s4
    /* B5470 800C4C70 21105400 */  addu       $v0, $v0, $s4
    /* B5474 800C4C74 1F004230 */  andi       $v0, $v0, 0x1F
    /* B5478 800C4C78 21184201 */  addu       $v1, $t2, $v0
    /* B547C 800C4C7C 00006280 */  lb         $v0, 0x0($v1)
    /* B5480 800C4C80 00000000 */  nop
    /* B5484 800C4C84 2A104700 */  slt        $v0, $v0, $a3
    /* B5488 800C4C88 02004010 */  beqz       $v0, .L800C4C94
    /* B548C 800C4C8C 00000000 */   nop
    /* B5490 800C4C90 000067A0 */  sb         $a3, 0x0($v1)
  .L800C4C94:
    /* B5494 800C4C94 0100E724 */  addiu      $a3, $a3, 0x1
    /* B5498 800C4C98 0500E228 */  slti       $v0, $a3, 0x5
    /* B549C 800C4C9C EFFF4014 */  bnez       $v0, .L800C4C5C
    /* B54A0 800C4CA0 00000000 */   nop
    /* B54A4 800C4CA4 04002925 */  addiu      $t1, $t1, 0x4
    /* B54A8 800C4CA8 01000825 */  addiu      $t0, $t0, 0x1
    /* B54AC 800C4CAC 02000229 */  slti       $v0, $t0, 0x2
    /* B54B0 800C4CB0 E7FF4014 */  bnez       $v0, .L800C4C50
    /* B54B4 800C4CB4 0400C624 */   addiu     $a2, $a2, 0x4
    /* B54B8 800C4CB8 06002426 */  addiu      $a0, $s1, 0x6
    /* B54BC 800C4CBC B4F9020C */  jal        ChangeTPage__FPUsi
    /* B54C0 800C4CC0 01000524 */   addiu     $a1, $zero, 0x1
    /* B54C4 800C4CC4 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B54C8 800C4CC8 08000424 */   addiu     $a0, $zero, 0x8
    /* B54CC 800C4CCC 0000428E */  lw         $v0, 0x0($s2)
    /* B54D0 800C4CD0 0C00438E */  lw         $v1, 0xC($s2)
    /* B54D4 800C4CD4 1800448E */  lw         $a0, 0x18($s2)
    /* B54D8 800C4CD8 03110200 */  sra        $v0, $v0, 4
    /* B54DC 800C4CDC 03190300 */  sra        $v1, $v1, 4
    /* B54E0 800C4CE0 03210400 */  sra        $a0, $a0, 4
    /* B54E4 800C4CE4 140002A6 */  sh         $v0, 0x14($s0)
    /* B54E8 800C4CE8 160003A6 */  sh         $v1, 0x16($s0)
    /* B54EC 800C4CEC 180004A6 */  sh         $a0, 0x18($s0)
    /* B54F0 800C4CF0 0400428E */  lw         $v0, 0x4($s2)
    /* B54F4 800C4CF4 1000438E */  lw         $v1, 0x10($s2)
    /* B54F8 800C4CF8 1C00448E */  lw         $a0, 0x1C($s2)
    /* B54FC 800C4CFC 03110200 */  sra        $v0, $v0, 4
    /* B5500 800C4D00 03190300 */  sra        $v1, $v1, 4
    /* B5504 800C4D04 03210400 */  sra        $a0, $a0, 4
    /* B5508 800C4D08 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* B550C 800C4D0C 1C0003A6 */  sh         $v1, 0x1C($s0)
    /* B5510 800C4D10 1E0004A6 */  sh         $a0, 0x1E($s0)
    /* B5514 800C4D14 0800438E */  lw         $v1, 0x8($s2)
    /* B5518 800C4D18 1400448E */  lw         $a0, 0x14($s2)
    /* B551C 800C4D1C 2000458E */  lw         $a1, 0x20($s2)
    /* B5520 800C4D20 23100200 */  negu       $v0, $v0
    /* B5524 800C4D24 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* B5528 800C4D28 1C000296 */  lhu        $v0, 0x1C($s0)
    /* B552C 800C4D2C 03190300 */  sra        $v1, $v1, 4
    /* B5530 800C4D30 03210400 */  sra        $a0, $a0, 4
    /* B5534 800C4D34 03290500 */  sra        $a1, $a1, 4
    /* B5538 800C4D38 200003A6 */  sh         $v1, 0x20($s0)
    /* B553C 800C4D3C 1E000396 */  lhu        $v1, 0x1E($s0)
    /* B5540 800C4D40 23100200 */  negu       $v0, $v0
    /* B5544 800C4D44 220004A6 */  sh         $a0, 0x22($s0)
    /* B5548 800C4D48 240005A6 */  sh         $a1, 0x24($s0)
    /* B554C 800C4D4C 1C0002A6 */  sh         $v0, 0x1C($s0)
    /* B5550 800C4D50 23180300 */  negu       $v1, $v1
    /* B5554 800C4D54 1E0003A6 */  sh         $v1, 0x1E($s0)
    /* B5558 800C4D58 0000628E */  lw         $v0, 0x0($s3)
    /* B555C 800C4D5C 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B5560 800C4D60 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B5564 800C4D64 00000000 */  nop
    /* B5568 800C4D68 07106200 */  srav       $v0, $v0, $v1
    /* B556C 800C4D6C 280002AE */  sw         $v0, 0x28($s0)
    /* B5570 800C4D70 0400628E */  lw         $v0, 0x4($s3)
    /* B5574 800C4D74 00000000 */  nop
    /* B5578 800C4D78 07106200 */  srav       $v0, $v0, $v1
    /* B557C 800C4D7C 23100200 */  negu       $v0, $v0
    /* B5580 800C4D80 2C0002AE */  sw         $v0, 0x2C($s0)
    /* B5584 800C4D84 0800628E */  lw         $v0, 0x8($s3)
    /* B5588 800C4D88 00000000 */  nop
    /* B558C 800C4D8C 07106200 */  srav       $v0, $v0, $v1
    /* B5590 800C4D90 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B5594 800C4D94 300002AE */   sw        $v0, 0x30($s0)
    /* B5598 800C4D98 14000226 */  addiu      $v0, $s0, 0x14
    /* B559C 800C4D9C 00004C8C */  lw         $t4, 0x0($v0)
    /* B55A0 800C4DA0 04004D8C */  lw         $t5, 0x4($v0)
    /* B55A4 800C4DA4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B55A8 800C4DA8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B55AC 800C4DAC 08004C8C */  lw         $t4, 0x8($v0)
    /* B55B0 800C4DB0 0C004D8C */  lw         $t5, 0xC($v0)
    /* B55B4 800C4DB4 10004E8C */  lw         $t6, 0x10($v0)
    /* B55B8 800C4DB8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B55BC 800C4DBC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B55C0 800C4DC0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B55C4 800C4DC4 14004C8C */  lw         $t4, 0x14($v0)
    /* B55C8 800C4DC8 18004D8C */  lw         $t5, 0x18($v0)
    /* B55CC 800C4DCC 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B55D0 800C4DD0 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B55D4 800C4DD4 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B55D8 800C4DD8 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B55DC 800C4DDC 21400000 */  addu       $t0, $zero, $zero
    /* B55E0 800C4DE0 1000B927 */  addiu      $t9, $sp, 0x10
    /* B55E4 800C4DE4 FF000C3C */  lui        $t4, (0xFFFFFF >> 16)
    /* B55E8 800C4DE8 FFFF8C35 */  ori        $t4, $t4, (0xFFFFFF & 0xFFFF)
    /* B55EC 800C4DEC 00FF123C */  lui        $s2, (0xFF000000 >> 16)
    /* B55F0 800C4DF0 B4000F26 */  addiu      $t7, $s0, 0xB4
    /* B55F4 800C4DF4 D0030E26 */  addiu      $t6, $s0, 0x3D0
    /* B55F8 800C4DF8 0580023C */  lui        $v0, %hi(Fe3D_lightsVertex)
    /* B55FC 800C4DFC 34135824 */  addiu      $t8, $v0, %lo(Fe3D_lightsVertex)
    /* B5600 800C4E00 06001327 */  addiu      $s3, $t8, 0x6
    /* B5604 800C4E04 21586002 */  addu       $t3, $s3, $zero
    /* B5608 800C4E08 21500003 */  addu       $t2, $t8, $zero
    /* B560C 800C4E0C 3C0000AE */  sw         $zero, 0x3C($s0)
  .L800C4E10:
    /* B5610 800C4E10 20000229 */  slti       $v0, $t0, 0x20
    /* B5614 800C4E14 7C004010 */  beqz       $v0, .L800C5008
    /* B5618 800C4E18 40100800 */   sll       $v0, $t0, 1
    /* B561C 800C4E1C 02004524 */  addiu      $a1, $v0, 0x2
    /* B5620 800C4E20 40000224 */  addiu      $v0, $zero, 0x40
    /* B5624 800C4E24 0200A214 */  bne        $a1, $v0, .L800C4E30
    /* B5628 800C4E28 00000000 */   nop
    /* B562C 800C4E2C 21280000 */  addu       $a1, $zero, $zero
  .L800C4E30:
    /* B5630 800C4E30 0400028E */  lw         $v0, 0x4($s0)
    /* B5634 800C4E34 0800038E */  lw         $v1, 0x8($s0)
    /* B5638 800C4E38 00000000 */  nop
    /* B563C 800C4E3C 2B104300 */  sltu       $v0, $v0, $v1
    /* B5640 800C4E40 71004010 */  beqz       $v0, .L800C5008
    /* B5644 800C4E44 21380000 */   addu      $a3, $zero, $zero
    /* B5648 800C4E48 00004295 */  lhu        $v0, 0x0($t2)
    /* B564C 800C4E4C 02004395 */  lhu        $v1, 0x2($t2)
    /* B5650 800C4E50 04004495 */  lhu        $a0, 0x4($t2)
    /* B5654 800C4E54 AE0003A6 */  sh         $v1, 0xAE($s0)
    /* B5658 800C4E58 40180500 */  sll        $v1, $a1, 1
    /* B565C 800C4E5C 21186500 */  addu       $v1, $v1, $a1
    /* B5660 800C4E60 40180300 */  sll        $v1, $v1, 1
    /* B5664 800C4E64 AC0002A6 */  sh         $v0, 0xAC($s0)
    /* B5668 800C4E68 21107800 */  addu       $v0, $v1, $t8
    /* B566C 800C4E6C B00004A6 */  sh         $a0, 0xB0($s0)
    /* B5670 800C4E70 00004494 */  lhu        $a0, 0x0($v0)
    /* B5674 800C4E74 02004594 */  lhu        $a1, 0x2($v0)
    /* B5678 800C4E78 04004294 */  lhu        $v0, 0x4($v0)
    /* B567C 800C4E7C 21482803 */  addu       $t1, $t9, $t0
    /* B5680 800C4E80 B40004A6 */  sh         $a0, 0xB4($s0)
    /* B5684 800C4E84 B60005A6 */  sh         $a1, 0xB6($s0)
    /* B5688 800C4E88 B80002A6 */  sh         $v0, 0xB8($s0)
    /* B568C 800C4E8C 00006295 */  lhu        $v0, 0x0($t3)
    /* B5690 800C4E90 02006495 */  lhu        $a0, 0x2($t3)
    /* B5694 800C4E94 04006595 */  lhu        $a1, 0x4($t3)
    /* B5698 800C4E98 21187300 */  addu       $v1, $v1, $s3
    /* B569C 800C4E9C BC0002A6 */  sh         $v0, 0xBC($s0)
    /* B56A0 800C4EA0 1280023C */  lui        $v0, %hi(D_8011F4B4)
    /* B56A4 800C4EA4 BE0004A6 */  sh         $a0, 0xBE($s0)
    /* B56A8 800C4EA8 C00005A6 */  sh         $a1, 0xC0($s0)
    /* B56AC 800C4EAC 00006494 */  lhu        $a0, 0x0($v1)
    /* B56B0 800C4EB0 02006594 */  lhu        $a1, 0x2($v1)
    /* B56B4 800C4EB4 04006394 */  lhu        $v1, 0x4($v1)
    /* B56B8 800C4EB8 B4F44D24 */  addiu      $t5, $v0, %lo(D_8011F4B4)
    /* B56BC 800C4EBC D00304A6 */  sh         $a0, 0x3D0($s0)
    /* B56C0 800C4EC0 D20305A6 */  sh         $a1, 0x3D2($s0)
    /* B56C4 800C4EC4 D40303A6 */  sh         $v1, 0x3D4($s0)
  .L800C4EC8:
    /* B56C8 800C4EC8 0200E228 */  slti       $v0, $a3, 0x2
    /* B56CC 800C4ECC 4A004010 */  beqz       $v0, .L800C4FF8
    /* B56D0 800C4ED0 00000000 */   nop
    /* B56D4 800C4ED4 0500E010 */  beqz       $a3, .L800C4EEC
    /* B56D8 800C4ED8 AC000226 */   addiu     $v0, $s0, 0xAC
    /* B56DC 800C4EDC 00002281 */  lb         $v0, 0x0($t1)
    /* B56E0 800C4EE0 00000000 */  nop
    /* B56E4 800C4EE4 42004004 */  bltz       $v0, .L800C4FF0
    /* B56E8 800C4EE8 AC000226 */   addiu     $v0, $s0, 0xAC
  .L800C4EEC:
    /* B56EC 800C4EEC 000040C8 */  lwc2       $0, 0x0($v0)
    /* B56F0 800C4EF0 040041C8 */  lwc2       $1, 0x4($v0)
    /* B56F4 800C4EF4 00000000 */  nop
    /* B56F8 800C4EF8 00000000 */  nop
    /* B56FC 800C4EFC 0100184A */  .word 0x4A180001  /* rtps */
    /* B5700 800C4F00 0400068E */  lw         $a2, 0x4($s0)
    /* B5704 800C4F04 00000000 */  nop
    /* B5708 800C4F08 2800C224 */  addiu      $v0, $a2, 0x28
    /* B570C 800C4F0C 040002AE */  sw         $v0, 0x4($s0)
    /* B5710 800C4F10 3C00028E */  lw         $v0, 0x3C($s0)
    /* B5714 800C4F14 0000048E */  lw         $a0, 0x0($s0)
    /* B5718 800C4F18 80100200 */  sll        $v0, $v0, 2
    /* B571C 800C4F1C 21208200 */  addu       $a0, $a0, $v0
    /* B5720 800C4F20 0000C28C */  lw         $v0, 0x0($a2)
    /* B5724 800C4F24 0000838C */  lw         $v1, 0x0($a0)
    /* B5728 800C4F28 24105200 */  and        $v0, $v0, $s2
    /* B572C 800C4F2C 24186C00 */  and        $v1, $v1, $t4
    /* B5730 800C4F30 25104300 */  or         $v0, $v0, $v1
    /* B5734 800C4F34 0000C2AC */  sw         $v0, 0x0($a2)
    /* B5738 800C4F38 0000828C */  lw         $v0, 0x0($a0)
    /* B573C 800C4F3C 2418CC00 */  and        $v1, $a2, $t4
    /* B5740 800C4F40 24105200 */  and        $v0, $v0, $s2
    /* B5744 800C4F44 25104300 */  or         $v0, $v0, $v1
    /* B5748 800C4F48 000082AC */  sw         $v0, 0x0($a0)
    /* B574C 800C4F4C 0800C224 */  addiu      $v0, $a2, 0x8
    /* B5750 800C4F50 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5754 800C4F54 BC000226 */  addiu      $v0, $s0, 0xBC
    /* B5758 800C4F58 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* B575C 800C4F5C 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* B5760 800C4F60 0000C2C9 */  lwc2       $2, 0x0($t6)
    /* B5764 800C4F64 0400C3C9 */  lwc2       $3, 0x4($t6)
    /* B5768 800C4F68 000044C8 */  lwc2       $4, 0x0($v0)
    /* B576C 800C4F6C 040045C8 */  lwc2       $5, 0x4($v0)
    /* B5770 800C4F70 00000000 */  nop
    /* B5774 800C4F74 00000000 */  nop
    /* B5778 800C4F78 3000284A */  .word 0x4A280030  /* rtpt */
    /* B577C 800C4F7C 1000C424 */  addiu      $a0, $a2, 0x10
    /* B5780 800C4F80 2000C324 */  addiu      $v1, $a2, 0x20
    /* B5784 800C4F84 1800C224 */  addiu      $v0, $a2, 0x18
    /* B5788 800C4F88 00008CE8 */  swc2       $12, 0x0($a0)
    /* B578C 800C4F8C 00006DE8 */  swc2       $13, 0x0($v1)
    /* B5790 800C4F90 00004EE8 */  swc2       $14, 0x0($v0)
    /* B5794 800C4F94 0300E014 */  bnez       $a3, .L800C4FA4
    /* B5798 800C4F98 3000023C */   lui       $v0, (0x300A00 >> 16)
    /* B579C 800C4F9C EE130308 */  j          .L800C4FB8
    /* B57A0 800C4FA0 000A4234 */   ori       $v0, $v0, (0x300A00 & 0xFFFF)
  .L800C4FA4:
    /* B57A4 800C4FA4 00002281 */  lb         $v0, 0x0($t1)
    /* B57A8 800C4FA8 00000000 */  nop
    /* B57AC 800C4FAC 80100200 */  sll        $v0, $v0, 2
    /* B57B0 800C4FB0 21104D00 */  addu       $v0, $v0, $t5
    /* B57B4 800C4FB4 0000428C */  lw         $v0, 0x0($v0)
  .L800C4FB8:
    /* B57B8 800C4FB8 00000000 */  nop
    /* B57BC 800C4FBC 0400C2AC */  sw         $v0, 0x4($a2)
    /* B57C0 800C4FC0 2E000224 */  addiu      $v0, $zero, 0x2E
    /* B57C4 800C4FC4 0700C2A0 */  sb         $v0, 0x7($a2)
    /* B57C8 800C4FC8 09000224 */  addiu      $v0, $zero, 0x9
    /* B57CC 800C4FCC 0300C2A0 */  sb         $v0, 0x3($a2)
    /* B57D0 800C4FD0 0000228E */  lw         $v0, 0x0($s1)
    /* B57D4 800C4FD4 0400238E */  lw         $v1, 0x4($s1)
    /* B57D8 800C4FD8 0800248E */  lw         $a0, 0x8($s1)
    /* B57DC 800C4FDC 0C00258E */  lw         $a1, 0xC($s1)
    /* B57E0 800C4FE0 0C00C2AC */  sw         $v0, 0xC($a2)
    /* B57E4 800C4FE4 1400C3AC */  sw         $v1, 0x14($a2)
    /* B57E8 800C4FE8 1C00C4AC */  sw         $a0, 0x1C($a2)
    /* B57EC 800C4FEC 2400C5AC */  sw         $a1, 0x24($a2)
  .L800C4FF0:
    /* B57F0 800C4FF0 B2130308 */  j          .L800C4EC8
    /* B57F4 800C4FF4 0100E724 */   addiu     $a3, $a3, 0x1
  .L800C4FF8:
    /* B57F8 800C4FF8 0C006B25 */  addiu      $t3, $t3, 0xC
    /* B57FC 800C4FFC 0C004A25 */  addiu      $t2, $t2, 0xC
    /* B5800 800C5000 84130308 */  j          .L800C4E10
    /* B5804 800C5004 01000825 */   addiu     $t0, $t0, 0x1
  .L800C5008:
    /* B5808 800C5008 5400BF8F */  lw         $ra, 0x54($sp)
    /* B580C 800C500C 5000B48F */  lw         $s4, 0x50($sp)
    /* B5810 800C5010 4C00B38F */  lw         $s3, 0x4C($sp)
    /* B5814 800C5014 4800B28F */  lw         $s2, 0x48($sp)
    /* B5818 800C5018 4400B18F */  lw         $s1, 0x44($sp)
    /* B581C 800C501C 4000B08F */  lw         $s0, 0x40($sp)
    /* B5820 800C5020 0800E003 */  jr         $ra
    /* B5824 800C5024 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
