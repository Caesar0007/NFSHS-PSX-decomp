.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__12tDialogYesNo, 0x188

glabel Draw__12tDialogYesNo
    /* A344 80019B44 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A348 80019B48 2000B2AF */  sw         $s2, 0x20($sp)
    /* A34C 80019B4C 21908000 */  addu       $s2, $a0, $zero
    /* A350 80019B50 3800BFAF */  sw         $ra, 0x38($sp)
    /* A354 80019B54 3400B7AF */  sw         $s7, 0x34($sp)
    /* A358 80019B58 3000B6AF */  sw         $s6, 0x30($sp)
    /* A35C 80019B5C 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* A360 80019B60 2800B4AF */  sw         $s4, 0x28($sp)
    /* A364 80019B64 2400B3AF */  sw         $s3, 0x24($sp)
    /* A368 80019B68 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A36C 80019B6C 1800B0AF */  sw         $s0, 0x18($sp)
    /* A370 80019B70 6000428E */  lw         $v0, 0x60($s2)
    /* A374 80019B74 00000000 */  nop
    /* A378 80019B78 50004484 */  lh         $a0, 0x50($v0)
    /* A37C 80019B7C 5400428C */  lw         $v0, 0x54($v0)
    /* A380 80019B80 00000000 */  nop
    /* A384 80019B84 09F84000 */  jalr       $v0
    /* A388 80019B88 21204402 */   addu      $a0, $s2, $a0
    /* A38C 80019B8C 8C00428E */  lw         $v0, 0x8C($s2)
    /* A390 80019B90 00000000 */  nop
    /* A394 80019B94 02004010 */  beqz       $v0, .L80019BA0
    /* A398 80019B98 1480023C */   lui       $v0, %hi(ticks)
    /* A39C 80019B9C 840040AE */  sw         $zero, 0x84($s2)
  .L80019BA0:
    /* A3A0 80019BA0 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* A3A4 80019BA4 7400438E */  lw         $v1, 0x74($s2)
    /* A3A8 80019BA8 00000000 */  nop
    /* A3AC 80019BAC 23104300 */  subu       $v0, $v0, $v1
    /* A3B0 80019BB0 32004228 */  slti       $v0, $v0, 0x32
    /* A3B4 80019BB4 38004014 */  bnez       $v0, .L80019C98
    /* A3B8 80019BB8 21980000 */   addu      $s3, $zero, $zero
    /* A3BC 80019BBC 0580023C */  lui        $v0, %hi(kRGBVals)
    /* A3C0 80019BC0 C8165724 */  addiu      $s7, $v0, %lo(kRGBVals)
    /* A3C4 80019BC4 0580023C */  lui        $v0, %hi(textDefinitions)
    /* A3C8 80019BC8 B8155624 */  addiu      $s6, $v0, %lo(textDefinitions)
    /* A3CC 80019BCC 21A84002 */  addu       $s5, $s2, $zero
    /* A3D0 80019BD0 6A004296 */  lhu        $v0, 0x6A($s2)
    /* A3D4 80019BD4 66004386 */  lh         $v1, 0x66($s2)
    /* A3D8 80019BD8 00140200 */  sll        $v0, $v0, 16
    /* A3DC 80019BDC 83140200 */  sra        $v0, $v0, 18
    /* A3E0 80019BE0 21A06200 */  addu       $s4, $v1, $v0
  .L80019BE4:
    /* A3E4 80019BE4 0200622A */  slti       $v0, $s3, 0x2
    /* A3E8 80019BE8 2B004010 */  beqz       $v0, .L80019C98
    /* A3EC 80019BEC 00000000 */   nop
    /* A3F0 80019BF0 8A004286 */  lh         $v0, 0x8A($s2)
    /* A3F4 80019BF4 00000000 */  nop
    /* A3F8 80019BF8 02006216 */  bne        $s3, $v0, .L80019C04
    /* A3FC 80019BFC 02000324 */   addiu     $v1, $zero, 0x2
    /* A400 80019C00 01000324 */  addiu      $v1, $zero, 0x1
  .L80019C04:
    /* A404 80019C04 21107600 */  addu       $v0, $v1, $s6
    /* A408 80019C08 33004290 */  lbu        $v0, 0x33($v0)
    /* A40C 80019C0C 8C00458E */  lw         $a1, 0x8C($s2)
    /* A410 80019C10 80100200 */  sll        $v0, $v0, 2
    /* A414 80019C14 21105700 */  addu       $v0, $v0, $s7
    /* A418 80019C18 0000448C */  lw         $a0, 0x0($v0)
    /* A41C 80019C1C 222E010C */  jal        CalcFadeVal__Fii
    /* A420 80019C20 01007326 */   addiu     $s3, $s3, 0x1
    /* A424 80019C24 01000424 */  addiu      $a0, $zero, 0x1
    /* A428 80019C28 21288000 */  addu       $a1, $a0, $zero
    /* A42C 80019C2C 68005086 */  lh         $s0, 0x68($s2)
    /* A430 80019C30 6C004386 */  lh         $v1, 0x6C($s2)
    /* A434 80019C34 21884000 */  addu       $s1, $v0, $zero
    /* A438 80019C38 21800302 */  addu       $s0, $s0, $v1
    /* A43C 80019C3C 7A86000C */  jal        FETextRender_SetABR__Fib
    /* A440 80019C40 F5FF1026 */   addiu     $s0, $s0, -0xB
    /* A444 80019C44 A000A48E */  lw         $a0, 0xA0($s5)
    /* A448 80019C48 94E4020C */  jal        TextSys_Word__Fi
    /* A44C 80019C4C 00841000 */   sll       $s0, $s0, 16
    /* A450 80019C50 21204000 */  addu       $a0, $v0, $zero
    /* A454 80019C54 002C1400 */  sll        $a1, $s4, 16
    /* A458 80019C58 032C0500 */  sra        $a1, $a1, 16
    /* A45C 80019C5C 02000224 */  addiu      $v0, $zero, 0x2
    /* A460 80019C60 03341000 */  sra        $a2, $s0, 16
    /* A464 80019C64 21382002 */  addu       $a3, $s1, $zero
    /* A468 80019C68 1000A0AF */  sw         $zero, 0x10($sp)
    /* A46C 80019C6C 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* A470 80019C70 1400A2AF */   sw        $v0, 0x14($sp)
    /* A474 80019C74 21200000 */  addu       $a0, $zero, $zero
    /* A478 80019C78 7A86000C */  jal        FETextRender_SetABR__Fib
    /* A47C 80019C7C 21288000 */   addu      $a1, $a0, $zero
    /* A480 80019C80 6A004296 */  lhu        $v0, 0x6A($s2)
    /* A484 80019C84 0400B526 */  addiu      $s5, $s5, 0x4
    /* A488 80019C88 00140200 */  sll        $v0, $v0, 16
    /* A48C 80019C8C 43140200 */  sra        $v0, $v0, 17
    /* A490 80019C90 F9660008 */  j          .L80019BE4
    /* A494 80019C94 21A08202 */   addu      $s4, $s4, $v0
  .L80019C98:
    /* A498 80019C98 8B65000C */  jal        Draw__20tDialogMessageString
    /* A49C 80019C9C 21204002 */   addu      $a0, $s2, $zero
    /* A4A0 80019CA0 3800BF8F */  lw         $ra, 0x38($sp)
    /* A4A4 80019CA4 3400B78F */  lw         $s7, 0x34($sp)
    /* A4A8 80019CA8 3000B68F */  lw         $s6, 0x30($sp)
    /* A4AC 80019CAC 2C00B58F */  lw         $s5, 0x2C($sp)
    /* A4B0 80019CB0 2800B48F */  lw         $s4, 0x28($sp)
    /* A4B4 80019CB4 2400B38F */  lw         $s3, 0x24($sp)
    /* A4B8 80019CB8 2000B28F */  lw         $s2, 0x20($sp)
    /* A4BC 80019CBC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A4C0 80019CC0 1800B08F */  lw         $s0, 0x18($sp)
    /* A4C4 80019CC4 0800E003 */  jr         $ra
    /* A4C8 80019CC8 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Draw__12tDialogYesNo
