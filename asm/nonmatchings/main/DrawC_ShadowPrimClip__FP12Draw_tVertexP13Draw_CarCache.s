.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache, 0x53C

glabel DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
    /* B4AC4 800C42C4 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* B4AC8 800C42C8 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* B4ACC 800C42CC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* B4AD0 800C42D0 4800BEAF */  sw         $fp, 0x48($sp)
    /* B4AD4 800C42D4 14801E3C */  lui        $fp, %hi(gShadowPixmap)
    /* B4AD8 800C42D8 E4D1DE8F */  lw         $fp, %lo(gShadowPixmap)($fp)
    /* B4ADC 800C42DC 2800B0AF */  sw         $s0, 0x28($sp)
    /* B4AE0 800C42E0 21808000 */  addu       $s0, $a0, $zero
    /* B4AE4 800C42E4 4400B7AF */  sw         $s7, 0x44($sp)
    /* B4AE8 800C42E8 21B8A000 */  addu       $s7, $a1, $zero
    /* B4AEC 800C42EC 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* B4AF0 800C42F0 4000B6AF */  sw         $s6, 0x40($sp)
    /* B4AF4 800C42F4 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* B4AF8 800C42F8 3800B4AF */  sw         $s4, 0x38($sp)
    /* B4AFC 800C42FC 3400B3AF */  sw         $s3, 0x34($sp)
    /* B4B00 800C4300 3000B2AF */  sw         $s2, 0x30($sp)
    /* B4B04 800C4304 03004010 */  beqz       $v0, .L800C4314
    /* B4B08 800C4308 2C00B1AF */   sw        $s1, 0x2C($sp)
    /* B4B0C 800C430C 1280023C */  lui        $v0, %hi(D_80120FD4)
    /* B4B10 800C4310 D40F5E8C */  lw         $fp, %lo(D_80120FD4)($v0)
  .L800C4314:
    /* B4B14 800C4314 00000000 */  nop
    /* B4B18 800C4318 0600C427 */  addiu      $a0, $fp, 0x6
    /* B4B1C 800C431C B4F9020C */  jal        ChangeTPage__FPUsi
    /* B4B20 800C4320 02000524 */   addiu     $a1, $zero, 0x2
    /* B4B24 800C4324 1280093C */  lui        $t1, %hi(DrawC_gScreenMat)
    /* B4B28 800C4328 C8F42925 */  addiu      $t1, $t1, %lo(DrawC_gScreenMat)
    /* B4B2C 800C432C 00002C8D */  lw         $t4, 0x0($t1)
    /* B4B30 800C4330 04002D8D */  lw         $t5, 0x4($t1)
    /* B4B34 800C4334 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B4B38 800C4338 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B4B3C 800C433C 08002C8D */  lw         $t4, 0x8($t1)
    /* B4B40 800C4340 0C002D8D */  lw         $t5, 0xC($t1)
    /* B4B44 800C4344 10002E8D */  lw         $t6, 0x10($t1)
    /* B4B48 800C4348 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B4B4C 800C434C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B4B50 800C4350 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B4B54 800C4354 1280093C */  lui        $t1, %hi(DrawC_gScreenMat)
    /* B4B58 800C4358 C8F42925 */  addiu      $t1, $t1, %lo(DrawC_gScreenMat)
    /* B4B5C 800C435C 14002C8D */  lw         $t4, 0x14($t1)
    /* B4B60 800C4360 18002D8D */  lw         $t5, 0x18($t1)
    /* B4B64 800C4364 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B4B68 800C4368 1C002E8D */  lw         $t6, 0x1C($t1)
    /* B4B6C 800C436C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B4B70 800C4370 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B4B74 800C4374 D803F326 */  addiu      $s3, $s7, 0x3D8
    /* B4B78 800C4378 F803F526 */  addiu      $s5, $s7, 0x3F8
    /* B4B7C 800C437C 00000296 */  lhu        $v0, 0x0($s0)
    /* B4B80 800C4380 02000396 */  lhu        $v1, 0x2($s0)
    /* B4B84 800C4384 04000496 */  lhu        $a0, 0x4($s0)
    /* B4B88 800C4388 F003F626 */  addiu      $s6, $s7, 0x3F0
    /* B4B8C 800C438C AC00E2A6 */  sh         $v0, 0xAC($s7)
    /* B4B90 800C4390 08000226 */  addiu      $v0, $s0, 0x8
    /* B4B94 800C4394 AE00E3A6 */  sh         $v1, 0xAE($s7)
    /* B4B98 800C4398 B000E4A6 */  sh         $a0, 0xB0($s7)
    /* B4B9C 800C439C 08000396 */  lhu        $v1, 0x8($s0)
    /* B4BA0 800C43A0 02004494 */  lhu        $a0, 0x2($v0)
    /* B4BA4 800C43A4 04004294 */  lhu        $v0, 0x4($v0)
    /* B4BA8 800C43A8 DE03F126 */  addiu      $s1, $s7, 0x3DE
    /* B4BAC 800C43AC B800E2A6 */  sh         $v0, 0xB8($s7)
    /* B4BB0 800C43B0 18000226 */  addiu      $v0, $s0, 0x18
    /* B4BB4 800C43B4 B400E3A6 */  sh         $v1, 0xB4($s7)
    /* B4BB8 800C43B8 B600E4A6 */  sh         $a0, 0xB6($s7)
    /* B4BBC 800C43BC 18000396 */  lhu        $v1, 0x18($s0)
    /* B4BC0 800C43C0 02004494 */  lhu        $a0, 0x2($v0)
    /* B4BC4 800C43C4 04004294 */  lhu        $v0, 0x4($v0)
    /* B4BC8 800C43C8 F603F226 */  addiu      $s2, $s7, 0x3F6
    /* B4BCC 800C43CC BC00E3A6 */  sh         $v1, 0xBC($s7)
    /* B4BD0 800C43D0 10000326 */  addiu      $v1, $s0, 0x10
    /* B4BD4 800C43D4 BE00E4A6 */  sh         $a0, 0xBE($s7)
    /* B4BD8 800C43D8 C000E2A6 */  sh         $v0, 0xC0($s7)
    /* B4BDC 800C43DC 10000596 */  lhu        $a1, 0x10($s0)
    /* B4BE0 800C43E0 02006694 */  lhu        $a2, 0x2($v1)
    /* B4BE4 800C43E4 AC00E296 */  lhu        $v0, 0xAC($s7)
    /* B4BE8 800C43E8 04006494 */  lhu        $a0, 0x4($v1)
    /* B4BEC 800C43EC B000E396 */  lhu        $v1, 0xB0($s7)
    /* B4BF0 800C43F0 80100200 */  sll        $v0, $v0, 2
    /* B4BF4 800C43F4 AC00E2A6 */  sh         $v0, 0xAC($s7)
    /* B4BF8 800C43F8 AE00E296 */  lhu        $v0, 0xAE($s7)
    /* B4BFC 800C43FC 80180300 */  sll        $v1, $v1, 2
    /* B4C00 800C4400 B000E3A6 */  sh         $v1, 0xB0($s7)
    /* B4C04 800C4404 B600E396 */  lhu        $v1, 0xB6($s7)
    /* B4C08 800C4408 FE03F026 */  addiu      $s0, $s7, 0x3FE
    /* B4C0C 800C440C D003E5A6 */  sh         $a1, 0x3D0($s7)
    /* B4C10 800C4410 D203E6A6 */  sh         $a2, 0x3D2($s7)
    /* B4C14 800C4414 D403E4A6 */  sh         $a0, 0x3D4($s7)
    /* B4C18 800C4418 80100200 */  sll        $v0, $v0, 2
    /* B4C1C 800C441C AE00E2A6 */  sh         $v0, 0xAE($s7)
    /* B4C20 800C4420 B400E296 */  lhu        $v0, 0xB4($s7)
    /* B4C24 800C4424 80180300 */  sll        $v1, $v1, 2
    /* B4C28 800C4428 80100200 */  sll        $v0, $v0, 2
    /* B4C2C 800C442C B400E2A6 */  sh         $v0, 0xB4($s7)
    /* B4C30 800C4430 B600E3A6 */  sh         $v1, 0xB6($s7)
    /* B4C34 800C4434 B800E296 */  lhu        $v0, 0xB8($s7)
    /* B4C38 800C4438 BC00E396 */  lhu        $v1, 0xBC($s7)
    /* B4C3C 800C443C 80100200 */  sll        $v0, $v0, 2
    /* B4C40 800C4440 B800E2A6 */  sh         $v0, 0xB8($s7)
    /* B4C44 800C4444 BE00E296 */  lhu        $v0, 0xBE($s7)
    /* B4C48 800C4448 80180300 */  sll        $v1, $v1, 2
    /* B4C4C 800C444C BC00E3A6 */  sh         $v1, 0xBC($s7)
    /* B4C50 800C4450 C000E396 */  lhu        $v1, 0xC0($s7)
    /* B4C54 800C4454 80100200 */  sll        $v0, $v0, 2
    /* B4C58 800C4458 80180300 */  sll        $v1, $v1, 2
    /* B4C5C 800C445C BE00E2A6 */  sh         $v0, 0xBE($s7)
    /* B4C60 800C4460 2110A000 */  addu       $v0, $a1, $zero
    /* B4C64 800C4464 C000E3A6 */  sh         $v1, 0xC0($s7)
    /* B4C68 800C4468 2118C000 */  addu       $v1, $a2, $zero
    /* B4C6C 800C446C 80100200 */  sll        $v0, $v0, 2
    /* B4C70 800C4470 80180300 */  sll        $v1, $v1, 2
    /* B4C74 800C4474 D203E3A6 */  sh         $v1, 0x3D2($s7)
    /* B4C78 800C4478 21188000 */  addu       $v1, $a0, $zero
    /* B4C7C 800C447C D003E2A6 */  sh         $v0, 0x3D0($s7)
    /* B4C80 800C4480 AC00E286 */  lh         $v0, 0xAC($s7)
    /* B4C84 800C4484 B400E486 */  lh         $a0, 0xB4($s7)
    /* B4C88 800C4488 80180300 */  sll        $v1, $v1, 2
    /* B4C8C 800C448C D403E3A6 */  sh         $v1, 0x3D4($s7)
    /* B4C90 800C4490 AE00E386 */  lh         $v1, 0xAE($s7)
    /* B4C94 800C4494 21104400 */  addu       $v0, $v0, $a0
    /* B4C98 800C4498 01004224 */  addiu      $v0, $v0, 0x1
    /* B4C9C 800C449C B600E486 */  lh         $a0, 0xB6($s7)
    /* B4CA0 800C44A0 43100200 */  sra        $v0, $v0, 1
    /* B4CA4 800C44A4 D803E2A6 */  sh         $v0, 0x3D8($s7)
    /* B4CA8 800C44A8 B000E286 */  lh         $v0, 0xB0($s7)
    /* B4CAC 800C44AC 21186400 */  addu       $v1, $v1, $a0
    /* B4CB0 800C44B0 01006324 */  addiu      $v1, $v1, 0x1
    /* B4CB4 800C44B4 B800E486 */  lh         $a0, 0xB8($s7)
    /* B4CB8 800C44B8 43180300 */  sra        $v1, $v1, 1
    /* B4CBC 800C44BC DA03E3A6 */  sh         $v1, 0x3DA($s7)
    /* B4CC0 800C44C0 B400E386 */  lh         $v1, 0xB4($s7)
    /* B4CC4 800C44C4 21104400 */  addu       $v0, $v0, $a0
    /* B4CC8 800C44C8 01004224 */  addiu      $v0, $v0, 0x1
    /* B4CCC 800C44CC BC00E486 */  lh         $a0, 0xBC($s7)
    /* B4CD0 800C44D0 43100200 */  sra        $v0, $v0, 1
    /* B4CD4 800C44D4 DC03E2A6 */  sh         $v0, 0x3DC($s7)
    /* B4CD8 800C44D8 B600E286 */  lh         $v0, 0xB6($s7)
    /* B4CDC 800C44DC 21186400 */  addu       $v1, $v1, $a0
    /* B4CE0 800C44E0 01006324 */  addiu      $v1, $v1, 0x1
    /* B4CE4 800C44E4 BE00E486 */  lh         $a0, 0xBE($s7)
    /* B4CE8 800C44E8 43180300 */  sra        $v1, $v1, 1
    /* B4CEC 800C44EC E003E3A6 */  sh         $v1, 0x3E0($s7)
    /* B4CF0 800C44F0 B800E386 */  lh         $v1, 0xB8($s7)
    /* B4CF4 800C44F4 21104400 */  addu       $v0, $v0, $a0
    /* B4CF8 800C44F8 01004224 */  addiu      $v0, $v0, 0x1
    /* B4CFC 800C44FC C000E486 */  lh         $a0, 0xC0($s7)
    /* B4D00 800C4500 43100200 */  sra        $v0, $v0, 1
    /* B4D04 800C4504 E203E2A6 */  sh         $v0, 0x3E2($s7)
    /* B4D08 800C4508 BC00E286 */  lh         $v0, 0xBC($s7)
    /* B4D0C 800C450C 21186400 */  addu       $v1, $v1, $a0
    /* B4D10 800C4510 01006324 */  addiu      $v1, $v1, 0x1
    /* B4D14 800C4514 D003E486 */  lh         $a0, 0x3D0($s7)
    /* B4D18 800C4518 43180300 */  sra        $v1, $v1, 1
    /* B4D1C 800C451C E403E3A6 */  sh         $v1, 0x3E4($s7)
    /* B4D20 800C4520 21104400 */  addu       $v0, $v0, $a0
    /* B4D24 800C4524 01004224 */  addiu      $v0, $v0, 0x1
    /* B4D28 800C4528 43100200 */  sra        $v0, $v0, 1
    /* B4D2C 800C452C E803E2A6 */  sh         $v0, 0x3E8($s7)
    /* B4D30 800C4530 BE00E286 */  lh         $v0, 0xBE($s7)
    /* B4D34 800C4534 D203E386 */  lh         $v1, 0x3D2($s7)
    /* B4D38 800C4538 D403E586 */  lh         $a1, 0x3D4($s7)
    /* B4D3C 800C453C 21104300 */  addu       $v0, $v0, $v1
    /* B4D40 800C4540 01004224 */  addiu      $v0, $v0, 0x1
    /* B4D44 800C4544 C000E386 */  lh         $v1, 0xC0($s7)
    /* B4D48 800C4548 43100200 */  sra        $v0, $v0, 1
    /* B4D4C 800C454C EA03E2A6 */  sh         $v0, 0x3EA($s7)
    /* B4D50 800C4550 D003E286 */  lh         $v0, 0x3D0($s7)
    /* B4D54 800C4554 21186500 */  addu       $v1, $v1, $a1
    /* B4D58 800C4558 01006324 */  addiu      $v1, $v1, 0x1
    /* B4D5C 800C455C AC00E586 */  lh         $a1, 0xAC($s7)
    /* B4D60 800C4560 43180300 */  sra        $v1, $v1, 1
    /* B4D64 800C4564 EC03E3A6 */  sh         $v1, 0x3EC($s7)
    /* B4D68 800C4568 D203E386 */  lh         $v1, 0x3D2($s7)
    /* B4D6C 800C456C 21104500 */  addu       $v0, $v0, $a1
    /* B4D70 800C4570 01004224 */  addiu      $v0, $v0, 0x1
    /* B4D74 800C4574 AE00E586 */  lh         $a1, 0xAE($s7)
    /* B4D78 800C4578 43100200 */  sra        $v0, $v0, 1
    /* B4D7C 800C457C F003E2A6 */  sh         $v0, 0x3F0($s7)
    /* B4D80 800C4580 D403E286 */  lh         $v0, 0x3D4($s7)
    /* B4D84 800C4584 21186500 */  addu       $v1, $v1, $a1
    /* B4D88 800C4588 01006324 */  addiu      $v1, $v1, 0x1
    /* B4D8C 800C458C B000E586 */  lh         $a1, 0xB0($s7)
    /* B4D90 800C4590 43180300 */  sra        $v1, $v1, 1
    /* B4D94 800C4594 F203E3A6 */  sh         $v1, 0x3F2($s7)
    /* B4D98 800C4598 AC00E386 */  lh         $v1, 0xAC($s7)
    /* B4D9C 800C459C 21104500 */  addu       $v0, $v0, $a1
    /* B4DA0 800C45A0 01004224 */  addiu      $v0, $v0, 0x1
    /* B4DA4 800C45A4 BC00E586 */  lh         $a1, 0xBC($s7)
    /* B4DA8 800C45A8 43100200 */  sra        $v0, $v0, 1
    /* B4DAC 800C45AC F403E2A6 */  sh         $v0, 0x3F4($s7)
    /* B4DB0 800C45B0 BE00E286 */  lh         $v0, 0xBE($s7)
    /* B4DB4 800C45B4 21186500 */  addu       $v1, $v1, $a1
    /* B4DB8 800C45B8 01006324 */  addiu      $v1, $v1, 0x1
    /* B4DBC 800C45BC AE00E586 */  lh         $a1, 0xAE($s7)
    /* B4DC0 800C45C0 43180300 */  sra        $v1, $v1, 1
    /* B4DC4 800C45C4 F803E3A6 */  sh         $v1, 0x3F8($s7)
    /* B4DC8 800C45C8 C000E386 */  lh         $v1, 0xC0($s7)
    /* B4DCC 800C45CC 2128A200 */  addu       $a1, $a1, $v0
    /* B4DD0 800C45D0 0100A524 */  addiu      $a1, $a1, 0x1
    /* B4DD4 800C45D4 B000E286 */  lh         $v0, 0xB0($s7)
    /* B4DD8 800C45D8 43280500 */  sra        $a1, $a1, 1
    /* B4DDC 800C45DC FA03E5A6 */  sh         $a1, 0x3FA($s7)
    /* B4DE0 800C45E0 21104300 */  addu       $v0, $v0, $v1
    /* B4DE4 800C45E4 01004224 */  addiu      $v0, $v0, 0x1
    /* B4DE8 800C45E8 43100200 */  sra        $v0, $v0, 1
    /* B4DEC 800C45EC FC03E2A6 */  sh         $v0, 0x3FC($s7)
    /* B4DF0 800C45F0 0000C297 */  lhu        $v0, 0x0($fp)
    /* B4DF4 800C45F4 0400C397 */  lhu        $v1, 0x4($fp)
    /* B4DF8 800C45F8 0C00C797 */  lhu        $a3, 0xC($fp)
    /* B4DFC 800C45FC 0800C897 */  lhu        $t0, 0x8($fp)
    /* B4E00 800C4600 2130A002 */  addu       $a2, $s5, $zero
    /* B4E04 800C4604 B200E2A6 */  sh         $v0, 0xB2($s7)
    /* B4E08 800C4608 B200E292 */  lbu        $v0, 0xB2($s7)
    /* B4E0C 800C460C AC00E426 */  addiu      $a0, $s7, 0xAC
    /* B4E10 800C4610 BA00E3A6 */  sh         $v1, 0xBA($s7)
    /* B4E14 800C4614 BA00E392 */  lbu        $v1, 0xBA($s7)
    /* B4E18 800C4618 21286002 */  addu       $a1, $s3, $zero
    /* B4E1C 800C461C C200E7A6 */  sh         $a3, 0xC2($s7)
    /* B4E20 800C4620 2138C002 */  addu       $a3, $s6, $zero
    /* B4E24 800C4624 D603E8A6 */  sh         $t0, 0x3D6($s7)
    /* B4E28 800C4628 21104300 */  addu       $v0, $v0, $v1
    /* B4E2C 800C462C 01004224 */  addiu      $v0, $v0, 0x1
    /* B4E30 800C4630 43100200 */  sra        $v0, $v0, 1
    /* B4E34 800C4634 DE03E2A2 */  sb         $v0, 0x3DE($s7)
    /* B4E38 800C4638 B300E292 */  lbu        $v0, 0xB3($s7)
    /* B4E3C 800C463C BB00E392 */  lbu        $v1, 0xBB($s7)
    /* B4E40 800C4640 C200E892 */  lbu        $t0, 0xC2($s7)
    /* B4E44 800C4644 21104300 */  addu       $v0, $v0, $v1
    /* B4E48 800C4648 01004224 */  addiu      $v0, $v0, 0x1
    /* B4E4C 800C464C BA00E392 */  lbu        $v1, 0xBA($s7)
    /* B4E50 800C4650 43100200 */  sra        $v0, $v0, 1
    /* B4E54 800C4654 DF03E2A2 */  sb         $v0, 0x3DF($s7)
    /* B4E58 800C4658 BB00E292 */  lbu        $v0, 0xBB($s7)
    /* B4E5C 800C465C 21186800 */  addu       $v1, $v1, $t0
    /* B4E60 800C4660 01006324 */  addiu      $v1, $v1, 0x1
    /* B4E64 800C4664 C300E892 */  lbu        $t0, 0xC3($s7)
    /* B4E68 800C4668 43180300 */  sra        $v1, $v1, 1
    /* B4E6C 800C466C E603E3A2 */  sb         $v1, 0x3E6($s7)
    /* B4E70 800C4670 C200E392 */  lbu        $v1, 0xC2($s7)
    /* B4E74 800C4674 21104800 */  addu       $v0, $v0, $t0
    /* B4E78 800C4678 01004224 */  addiu      $v0, $v0, 0x1
    /* B4E7C 800C467C D603E892 */  lbu        $t0, 0x3D6($s7)
    /* B4E80 800C4680 43100200 */  sra        $v0, $v0, 1
    /* B4E84 800C4684 E703E2A2 */  sb         $v0, 0x3E7($s7)
    /* B4E88 800C4688 C300E292 */  lbu        $v0, 0xC3($s7)
    /* B4E8C 800C468C 21186800 */  addu       $v1, $v1, $t0
    /* B4E90 800C4690 01006324 */  addiu      $v1, $v1, 0x1
    /* B4E94 800C4694 D703E892 */  lbu        $t0, 0x3D7($s7)
    /* B4E98 800C4698 43180300 */  sra        $v1, $v1, 1
    /* B4E9C 800C469C EE03E3A2 */  sb         $v1, 0x3EE($s7)
    /* B4EA0 800C46A0 D603E392 */  lbu        $v1, 0x3D6($s7)
    /* B4EA4 800C46A4 21104800 */  addu       $v0, $v0, $t0
    /* B4EA8 800C46A8 01004224 */  addiu      $v0, $v0, 0x1
    /* B4EAC 800C46AC B200E892 */  lbu        $t0, 0xB2($s7)
    /* B4EB0 800C46B0 43100200 */  sra        $v0, $v0, 1
    /* B4EB4 800C46B4 EF03E2A2 */  sb         $v0, 0x3EF($s7)
    /* B4EB8 800C46B8 D703E292 */  lbu        $v0, 0x3D7($s7)
    /* B4EBC 800C46BC 21186800 */  addu       $v1, $v1, $t0
    /* B4EC0 800C46C0 01006324 */  addiu      $v1, $v1, 0x1
    /* B4EC4 800C46C4 B300E892 */  lbu        $t0, 0xB3($s7)
    /* B4EC8 800C46C8 43180300 */  sra        $v1, $v1, 1
    /* B4ECC 800C46CC F603E3A2 */  sb         $v1, 0x3F6($s7)
    /* B4ED0 800C46D0 B200E392 */  lbu        $v1, 0xB2($s7)
    /* B4ED4 800C46D4 21104800 */  addu       $v0, $v0, $t0
    /* B4ED8 800C46D8 01004224 */  addiu      $v0, $v0, 0x1
    /* B4EDC 800C46DC C200E892 */  lbu        $t0, 0xC2($s7)
    /* B4EE0 800C46E0 43100200 */  sra        $v0, $v0, 1
    /* B4EE4 800C46E4 F703E2A2 */  sb         $v0, 0x3F7($s7)
    /* B4EE8 800C46E8 B300E292 */  lbu        $v0, 0xB3($s7)
    /* B4EEC 800C46EC 21186800 */  addu       $v1, $v1, $t0
    /* B4EF0 800C46F0 01006324 */  addiu      $v1, $v1, 0x1
    /* B4EF4 800C46F4 C300E892 */  lbu        $t0, 0xC3($s7)
    /* B4EF8 800C46F8 43180300 */  sra        $v1, $v1, 1
    /* B4EFC 800C46FC FE03E3A2 */  sb         $v1, 0x3FE($s7)
    /* B4F00 800C4700 21104800 */  addu       $v0, $v0, $t0
    /* B4F04 800C4704 01004224 */  addiu      $v0, $v0, 0x1
    /* B4F08 800C4708 43100200 */  sra        $v0, $v0, 1
    /* B4F0C 800C470C FF03E2A2 */  sb         $v0, 0x3FF($s7)
    /* B4F10 800C4710 B200E226 */  addiu      $v0, $s7, 0xB2
    /* B4F14 800C4714 1000A2AF */  sw         $v0, 0x10($sp)
    /* B4F18 800C4718 1400B1AF */  sw         $s1, 0x14($sp)
    /* B4F1C 800C471C 1800B0AF */  sw         $s0, 0x18($sp)
    /* B4F20 800C4720 1C00B2AF */  sw         $s2, 0x1C($sp)
    /* B4F24 800C4724 2000BEAF */  sw         $fp, 0x20($sp)
    /* B4F28 800C4728 3710030C */  jal        DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
    /* B4F2C 800C472C 2400B7AF */   sw        $s7, 0x24($sp)
    /* B4F30 800C4730 21206002 */  addu       $a0, $s3, $zero
    /* B4F34 800C4734 B400E526 */  addiu      $a1, $s7, 0xB4
    /* B4F38 800C4738 E003F426 */  addiu      $s4, $s7, 0x3E0
    /* B4F3C 800C473C 21308002 */  addu       $a2, $s4, $zero
    /* B4F40 800C4740 2138A002 */  addu       $a3, $s5, $zero
    /* B4F44 800C4744 BA00E226 */  addiu      $v0, $s7, 0xBA
    /* B4F48 800C4748 E603F326 */  addiu      $s3, $s7, 0x3E6
    /* B4F4C 800C474C 1000B1AF */  sw         $s1, 0x10($sp)
    /* B4F50 800C4750 1400A2AF */  sw         $v0, 0x14($sp)
    /* B4F54 800C4754 1800B3AF */  sw         $s3, 0x18($sp)
    /* B4F58 800C4758 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* B4F5C 800C475C 2000BEAF */  sw         $fp, 0x20($sp)
    /* B4F60 800C4760 3710030C */  jal        DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
    /* B4F64 800C4764 2400B7AF */   sw        $s7, 0x24($sp)
    /* B4F68 800C4768 2120C002 */  addu       $a0, $s6, $zero
    /* B4F6C 800C476C 2128A002 */  addu       $a1, $s5, $zero
    /* B4F70 800C4770 E803F126 */  addiu      $s1, $s7, 0x3E8
    /* B4F74 800C4774 21302002 */  addu       $a2, $s1, $zero
    /* B4F78 800C4778 D003E726 */  addiu      $a3, $s7, 0x3D0
    /* B4F7C 800C477C 1000B2AF */  sw         $s2, 0x10($sp)
    /* B4F80 800C4780 EE03F226 */  addiu      $s2, $s7, 0x3EE
    /* B4F84 800C4784 D603E226 */  addiu      $v0, $s7, 0x3D6
    /* B4F88 800C4788 1400B0AF */  sw         $s0, 0x14($sp)
    /* B4F8C 800C478C 1800B2AF */  sw         $s2, 0x18($sp)
    /* B4F90 800C4790 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* B4F94 800C4794 2000BEAF */  sw         $fp, 0x20($sp)
    /* B4F98 800C4798 3710030C */  jal        DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
    /* B4F9C 800C479C 2400B7AF */   sw        $s7, 0x24($sp)
    /* B4FA0 800C47A0 2120A002 */  addu       $a0, $s5, $zero
    /* B4FA4 800C47A4 21288002 */  addu       $a1, $s4, $zero
    /* B4FA8 800C47A8 BC00E626 */  addiu      $a2, $s7, 0xBC
    /* B4FAC 800C47AC 21382002 */  addu       $a3, $s1, $zero
    /* B4FB0 800C47B0 C200E226 */  addiu      $v0, $s7, 0xC2
    /* B4FB4 800C47B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* B4FB8 800C47B8 1400B3AF */  sw         $s3, 0x14($sp)
    /* B4FBC 800C47BC 1800A2AF */  sw         $v0, 0x18($sp)
    /* B4FC0 800C47C0 1C00B2AF */  sw         $s2, 0x1C($sp)
    /* B4FC4 800C47C4 2000BEAF */  sw         $fp, 0x20($sp)
    /* B4FC8 800C47C8 3710030C */  jal        DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
    /* B4FCC 800C47CC 2400B7AF */   sw        $s7, 0x24($sp)
    /* B4FD0 800C47D0 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* B4FD4 800C47D4 4800BE8F */  lw         $fp, 0x48($sp)
    /* B4FD8 800C47D8 4400B78F */  lw         $s7, 0x44($sp)
    /* B4FDC 800C47DC 4000B68F */  lw         $s6, 0x40($sp)
    /* B4FE0 800C47E0 3C00B58F */  lw         $s5, 0x3C($sp)
    /* B4FE4 800C47E4 3800B48F */  lw         $s4, 0x38($sp)
    /* B4FE8 800C47E8 3400B38F */  lw         $s3, 0x34($sp)
    /* B4FEC 800C47EC 3000B28F */  lw         $s2, 0x30($sp)
    /* B4FF0 800C47F0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* B4FF4 800C47F4 2800B08F */  lw         $s0, 0x28($sp)
    /* B4FF8 800C47F8 0800E003 */  jr         $ra
    /* B4FFC 800C47FC 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
