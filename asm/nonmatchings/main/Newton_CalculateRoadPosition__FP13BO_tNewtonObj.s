.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalculateRoadPosition__FP13BO_tNewtonObj, 0x108

glabel Newton_CalculateRoadPosition__FP13BO_tNewtonObj
    /* 94454 800A3C54 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 94458 800A3C58 21408000 */  addu       $t0, $a0, $zero
    /* 9445C 800A3C5C 08000285 */  lh         $v0, 0x8($t0)
    /* 94460 800A3C60 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 94464 800A3C64 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 94468 800A3C68 40110200 */  sll        $v0, $v0, 5
    /* 9446C 800A3C6C 21104300 */  addu       $v0, $v0, $v1
    /* 94470 800A3C70 0000498C */  lw         $t1, 0x0($v0)
    /* 94474 800A3C74 04004A8C */  lw         $t2, 0x4($v0)
    /* 94478 800A3C78 08004B8C */  lw         $t3, 0x8($v0)
    /* 9447C 800A3C7C 0000A9AF */  sw         $t1, 0x0($sp)
    /* 94480 800A3C80 0400AAAF */  sw         $t2, 0x4($sp)
    /* 94484 800A3C84 0800ABAF */  sw         $t3, 0x8($sp)
    /* 94488 800A3C88 A000098D */  lw         $t1, 0xA0($t0)
    /* 9448C 800A3C8C A4000A8D */  lw         $t2, 0xA4($t0)
    /* 94490 800A3C90 A8000B8D */  lw         $t3, 0xA8($t0)
    /* 94494 800A3C94 2000A9AF */  sw         $t1, 0x20($sp)
    /* 94498 800A3C98 2400AAAF */  sw         $t2, 0x24($sp)
    /* 9449C 800A3C9C 2800ABAF */  sw         $t3, 0x28($sp)
    /* 944A0 800A3CA0 2000A38F */  lw         $v1, 0x20($sp)
    /* 944A4 800A3CA4 0000A28F */  lw         $v0, 0x0($sp)
    /* 944A8 800A3CA8 2400A48F */  lw         $a0, 0x24($sp)
    /* 944AC 800A3CAC 2800A58F */  lw         $a1, 0x28($sp)
    /* 944B0 800A3CB0 23386200 */  subu       $a3, $v1, $v0
    /* 944B4 800A3CB4 0400A28F */  lw         $v0, 0x4($sp)
    /* 944B8 800A3CB8 0800A38F */  lw         $v1, 0x8($sp)
    /* 944BC 800A3CBC 1000A7AF */  sw         $a3, 0x10($sp)
    /* 944C0 800A3CC0 23208200 */  subu       $a0, $a0, $v0
    /* 944C4 800A3CC4 2328A300 */  subu       $a1, $a1, $v1
    /* 944C8 800A3CC8 1400A4AF */  sw         $a0, 0x14($sp)
    /* 944CC 800A3CCC 1800A5AF */  sw         $a1, 0x18($sp)
    /* 944D0 800A3CD0 4401068D */  lw         $a2, 0x144($t0)
    /* 944D4 800A3CD4 00000000 */  nop
    /* 944D8 800A3CD8 0200C104 */  bgez       $a2, .L800A3CE4
    /* 944DC 800A3CDC 2110E000 */   addu      $v0, $a3, $zero
    /* 944E0 800A3CE0 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800A3CE4:
    /* 944E4 800A3CE4 02004104 */  bgez       $v0, .L800A3CF0
    /* 944E8 800A3CE8 03320600 */   sra       $a2, $a2, 8
    /* 944EC 800A3CEC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3CF0:
    /* 944F0 800A3CF0 03120200 */  sra        $v0, $v0, 8
    /* 944F4 800A3CF4 1800C200 */  mult       $a2, $v0
    /* 944F8 800A3CF8 4801038D */  lw         $v1, 0x148($t0)
    /* 944FC 800A3CFC 12300000 */  mflo       $a2
    /* 94500 800A3D00 02006104 */  bgez       $v1, .L800A3D0C
    /* 94504 800A3D04 21108000 */   addu      $v0, $a0, $zero
    /* 94508 800A3D08 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A3D0C:
    /* 9450C 800A3D0C 02004104 */  bgez       $v0, .L800A3D18
    /* 94510 800A3D10 031A0300 */   sra       $v1, $v1, 8
    /* 94514 800A3D14 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3D18:
    /* 94518 800A3D18 03120200 */  sra        $v0, $v0, 8
    /* 9451C 800A3D1C 18006200 */  mult       $v1, $v0
    /* 94520 800A3D20 4C01048D */  lw         $a0, 0x14C($t0)
    /* 94524 800A3D24 12480000 */  mflo       $t1
    /* 94528 800A3D28 02008104 */  bgez       $a0, .L800A3D34
    /* 9452C 800A3D2C 2118C900 */   addu      $v1, $a2, $t1
    /* 94530 800A3D30 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800A3D34:
    /* 94534 800A3D34 2110A000 */  addu       $v0, $a1, $zero
    /* 94538 800A3D38 02004104 */  bgez       $v0, .L800A3D44
    /* 9453C 800A3D3C 03220400 */   sra       $a0, $a0, 8
    /* 94540 800A3D40 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3D44:
    /* 94544 800A3D44 03120200 */  sra        $v0, $v0, 8
    /* 94548 800A3D48 18008200 */  mult       $a0, $v0
    /* 9454C 800A3D4C 12480000 */  mflo       $t1
    /* 94550 800A3D50 21106900 */  addu       $v0, $v1, $t1
    /* 94554 800A3D54 0800E003 */  jr         $ra
    /* 94558 800A3D58 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Newton_CalculateRoadPosition__FP13BO_tNewtonObj
