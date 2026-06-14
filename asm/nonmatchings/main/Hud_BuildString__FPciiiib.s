.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildString__FPciiiib, 0x35C

glabel Hud_BuildString__FPciiiib
    /* C4AC8 800D42C8 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* C4ACC 800D42CC 2800B0AF */  sw         $s0, 0x28($sp)
    /* C4AD0 800D42D0 6000B08F */  lw         $s0, 0x60($sp)
    /* C4AD4 800D42D4 3000B2AF */  sw         $s2, 0x30($sp)
    /* C4AD8 800D42D8 21908000 */  addu       $s2, $a0, $zero
    /* C4ADC 800D42DC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* C4AE0 800D42E0 2188A000 */  addu       $s1, $a1, $zero
    /* C4AE4 800D42E4 4000B6AF */  sw         $s6, 0x40($sp)
    /* C4AE8 800D42E8 21B0C000 */  addu       $s6, $a2, $zero
    /* C4AEC 800D42EC 4400B7AF */  sw         $s7, 0x44($sp)
    /* C4AF0 800D42F0 21B8E000 */  addu       $s7, $a3, $zero
    /* C4AF4 800D42F4 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* C4AF8 800D42F8 6400B58F */  lw         $s5, 0x64($sp)
    /* C4AFC 800D42FC 01000424 */  addiu      $a0, $zero, 0x1
    /* C4B00 800D4300 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* C4B04 800D4304 4800BEAF */  sw         $fp, 0x48($sp)
    /* C4B08 800D4308 3800B4AF */  sw         $s4, 0x38($sp)
    /* C4B0C 800D430C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C4B10 800D4310 3400B3AF */   sw        $s3, 0x34($sp)
    /* C4B14 800D4314 21204002 */  addu       $a0, $s2, $zero
    /* C4B18 800D4318 DDA7030C */  jal        strlen
    /* C4B1C 800D431C 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* C4B20 800D4320 23001324 */  addiu      $s3, $zero, 0x23
    /* C4B24 800D4324 2000A2AF */  sw         $v0, 0x20($sp)
    /* C4B28 800D4328 1480023C */  lui        $v0, %hi(gPadinfo)
    /* C4B2C 800D432C 9CE85424 */  addiu      $s4, $v0, %lo(gPadinfo)
    /* C4B30 800D4330 1800A0AF */  sw         $zero, 0x18($sp)
    /* C4B34 800D4334 40811000 */  sll        $s0, $s0, 5
    /* C4B38 800D4338 21F01402 */  addu       $fp, $s0, $s4
  .L800D433C:
    /* C4B3C 800D433C 1800A88F */  lw         $t0, 0x18($sp)
    /* C4B40 800D4340 2000A98F */  lw         $t1, 0x20($sp)
    /* C4B44 800D4344 00000000 */  nop
    /* C4B48 800D4348 2A100901 */  slt        $v0, $t0, $t1
    /* C4B4C 800D434C A5004010 */  beqz       $v0, .L800D45E4
    /* C4B50 800D4350 20000224 */   addiu     $v0, $zero, 0x20
    /* C4B54 800D4354 00004492 */  lbu        $a0, 0x0($s2)
    /* C4B58 800D4358 00000000 */  nop
    /* C4B5C 800D435C FF008330 */  andi       $v1, $a0, 0xFF
    /* C4B60 800D4360 03006214 */  bne        $v1, $v0, .L800D4370
    /* C4B64 800D4364 2A000224 */   addiu     $v0, $zero, 0x2A
    /* C4B68 800D4368 75510308 */  j          .L800D45D4
    /* C4B6C 800D436C 03003126 */   addiu     $s1, $s1, 0x3
  .L800D4370:
    /* C4B70 800D4370 50006214 */  bne        $v1, $v0, .L800D44B4
    /* C4B74 800D4374 5E000224 */   addiu     $v0, $zero, 0x5E
    /* C4B78 800D4378 05008292 */  lbu        $v0, 0x5($s4)
    /* C4B7C 800D437C 00000000 */  nop
    /* C4B80 800D4380 0E005314 */  bne        $v0, $s3, .L800D43BC
    /* C4B84 800D4384 02003126 */   addiu     $s1, $s1, 0x2
    /* C4B88 800D4388 0800A016 */  bnez       $s5, .L800D43AC
    /* C4B8C 800D438C 1180083C */   lui       $t0, %hi(D_80111A1C)
    /* C4B90 800D4390 1000A0AF */  sw         $zero, 0x10($sp)
    /* C4B94 800D4394 AD000424 */  addiu      $a0, $zero, 0xAD
    /* C4B98 800D4398 21282002 */  addu       $a1, $s1, $zero
    /* C4B9C 800D439C 2130C002 */  addu       $a2, $s6, $zero
    /* C4BA0 800D43A0 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C4BA4 800D43A4 2138E002 */   addu      $a3, $s7, $zero
    /* C4BA8 800D43A8 1180083C */  lui        $t0, %hi(D_80111A1C)
  .L800D43AC:
    /* C4BAC 800D43AC 1C1A0825 */  addiu      $t0, $t0, %lo(D_80111A1C)
    /* C4BB0 800D43B0 10000385 */  lh         $v1, 0x10($t0)
    /* C4BB4 800D43B4 FB500308 */  j          .L800D43EC
    /* C4BB8 800D43B8 03002226 */   addiu     $v0, $s1, 0x3
  .L800D43BC:
    /* C4BBC 800D43BC 0800A016 */  bnez       $s5, .L800D43E0
    /* C4BC0 800D43C0 1180093C */   lui       $t1, %hi(D_801119E0)
    /* C4BC4 800D43C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* C4BC8 800D43C8 AA000424 */  addiu      $a0, $zero, 0xAA
    /* C4BCC 800D43CC 21282002 */  addu       $a1, $s1, $zero
    /* C4BD0 800D43D0 2130C002 */  addu       $a2, $s6, $zero
    /* C4BD4 800D43D4 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C4BD8 800D43D8 2138E002 */   addu      $a3, $s7, $zero
    /* C4BDC 800D43DC 1180093C */  lui        $t1, %hi(D_801119E0)
  .L800D43E0:
    /* C4BE0 800D43E0 E0192925 */  addiu      $t1, $t1, %lo(D_801119E0)
    /* C4BE4 800D43E4 10002385 */  lh         $v1, 0x10($t1)
    /* C4BE8 800D43E8 03002226 */  addiu      $v0, $s1, 0x3
  .L800D43EC:
    /* C4BEC 800D43EC 21884300 */  addu       $s1, $v0, $v1
    /* C4BF0 800D43F0 1180023C */  lui        $v0, %hi(D_801131F8)
    /* C4BF4 800D43F4 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* C4BF8 800D43F8 01000224 */  addiu      $v0, $zero, 0x1
    /* C4BFC 800D43FC 74006214 */  bne        $v1, $v0, .L800D45D0
    /* C4C00 800D4400 00000000 */   nop
    /* C4C04 800D4404 25008292 */  lbu        $v0, 0x25($s4)
    /* C4C08 800D4408 00000000 */  nop
    /* C4C0C 800D440C 07005314 */  bne        $v0, $s3, .L800D442C
    /* C4C10 800D4410 00000000 */   nop
    /* C4C14 800D4414 05008292 */  lbu        $v0, 0x5($s4)
    /* C4C18 800D4418 00000000 */  nop
    /* C4C1C 800D441C 6C005310 */  beq        $v0, $s3, .L800D45D0
    /* C4C20 800D4420 00000000 */   nop
    /* C4C24 800D4424 0F510308 */  j          .L800D443C
    /* C4C28 800D4428 00000000 */   nop
  .L800D442C:
    /* C4C2C 800D442C 05008292 */  lbu        $v0, 0x5($s4)
    /* C4C30 800D4430 00000000 */  nop
    /* C4C34 800D4434 66005314 */  bne        $v0, $s3, .L800D45D0
    /* C4C38 800D4438 00000000 */   nop
  .L800D443C:
    /* C4C3C 800D443C 25008292 */  lbu        $v0, 0x25($s4)
    /* C4C40 800D4440 00000000 */  nop
    /* C4C44 800D4444 0E005314 */  bne        $v0, $s3, .L800D4480
    /* C4C48 800D4448 00000000 */   nop
    /* C4C4C 800D444C 0800A016 */  bnez       $s5, .L800D4470
    /* C4C50 800D4450 1180083C */   lui       $t0, %hi(D_80111A1C)
    /* C4C54 800D4454 1000A0AF */  sw         $zero, 0x10($sp)
    /* C4C58 800D4458 AD000424 */  addiu      $a0, $zero, 0xAD
    /* C4C5C 800D445C 21282002 */  addu       $a1, $s1, $zero
    /* C4C60 800D4460 2130C002 */  addu       $a2, $s6, $zero
    /* C4C64 800D4464 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C4C68 800D4468 2138E002 */   addu      $a3, $s7, $zero
    /* C4C6C 800D446C 1180083C */  lui        $t0, %hi(D_80111A1C)
  .L800D4470:
    /* C4C70 800D4470 1C1A0825 */  addiu      $t0, $t0, %lo(D_80111A1C)
    /* C4C74 800D4474 10000385 */  lh         $v1, 0x10($t0)
    /* C4C78 800D4478 73510308 */  j          .L800D45CC
    /* C4C7C 800D447C 03002226 */   addiu     $v0, $s1, 0x3
  .L800D4480:
    /* C4C80 800D4480 0800A016 */  bnez       $s5, .L800D44A4
    /* C4C84 800D4484 1180093C */   lui       $t1, %hi(D_801119E0)
    /* C4C88 800D4488 1000A0AF */  sw         $zero, 0x10($sp)
    /* C4C8C 800D448C AA000424 */  addiu      $a0, $zero, 0xAA
    /* C4C90 800D4490 21282002 */  addu       $a1, $s1, $zero
    /* C4C94 800D4494 2130C002 */  addu       $a2, $s6, $zero
    /* C4C98 800D4498 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C4C9C 800D449C 2138E002 */   addu      $a3, $s7, $zero
    /* C4CA0 800D44A0 1180093C */  lui        $t1, %hi(D_801119E0)
  .L800D44A4:
    /* C4CA4 800D44A4 E0192925 */  addiu      $t1, $t1, %lo(D_801119E0)
    /* C4CA8 800D44A8 10002385 */  lh         $v1, 0x10($t1)
    /* C4CAC 800D44AC 73510308 */  j          .L800D45CC
    /* C4CB0 800D44B0 03002226 */   addiu     $v0, $s1, 0x3
  .L800D44B4:
    /* C4CB4 800D44B4 07006214 */  bne        $v1, $v0, .L800D44D4
    /* C4CB8 800D44B8 21300000 */   addu      $a2, $zero, $zero
    /* C4CBC 800D44BC 0500C293 */  lbu        $v0, 0x5($fp)
    /* C4CC0 800D44C0 00000000 */  nop
    /* C4CC4 800D44C4 31005314 */  bne        $v0, $s3, .L800D458C
    /* C4CC8 800D44C8 AA001024 */   addiu     $s0, $zero, 0xAA
    /* C4CCC 800D44CC 63510308 */  j          .L800D458C
    /* C4CD0 800D44D0 AD001024 */   addiu     $s0, $zero, 0xAD
  .L800D44D4:
    /* C4CD4 800D44D4 28000224 */  addiu      $v0, $zero, 0x28
    /* C4CD8 800D44D8 07006214 */  bne        $v1, $v0, .L800D44F8
    /* C4CDC 800D44DC 29000224 */   addiu     $v0, $zero, 0x29
    /* C4CE0 800D44E0 0500C293 */  lbu        $v0, 0x5($fp)
    /* C4CE4 800D44E4 00000000 */  nop
    /* C4CE8 800D44E8 28005314 */  bne        $v0, $s3, .L800D458C
    /* C4CEC 800D44EC A9001024 */   addiu     $s0, $zero, 0xA9
    /* C4CF0 800D44F0 63510308 */  j          .L800D458C
    /* C4CF4 800D44F4 AB001024 */   addiu     $s0, $zero, 0xAB
  .L800D44F8:
    /* C4CF8 800D44F8 07006214 */  bne        $v1, $v0, .L800D4518
    /* C4CFC 800D44FC 26000224 */   addiu     $v0, $zero, 0x26
    /* C4D00 800D4500 0500C293 */  lbu        $v0, 0x5($fp)
    /* C4D04 800D4504 00000000 */  nop
    /* C4D08 800D4508 20005314 */  bne        $v0, $s3, .L800D458C
    /* C4D0C 800D450C A8001024 */   addiu     $s0, $zero, 0xA8
    /* C4D10 800D4510 63510308 */  j          .L800D458C
    /* C4D14 800D4514 AC001024 */   addiu     $s0, $zero, 0xAC
  .L800D4518:
    /* C4D18 800D4518 03006214 */  bne        $v1, $v0, .L800D4528
    /* C4D1C 800D451C D0FF8224 */   addiu     $v0, $a0, -0x30
    /* C4D20 800D4520 63510308 */  j          .L800D458C
    /* C4D24 800D4524 AE001024 */   addiu     $s0, $zero, 0xAE
  .L800D4528:
    /* C4D28 800D4528 FF004230 */  andi       $v0, $v0, 0xFF
    /* C4D2C 800D452C 0A00422C */  sltiu      $v0, $v0, 0xA
    /* C4D30 800D4530 16004014 */  bnez       $v0, .L800D458C
    /* C4D34 800D4534 6E009024 */   addiu     $s0, $a0, 0x6E
    /* C4D38 800D4538 2D000224 */  addiu      $v0, $zero, 0x2D
    /* C4D3C 800D453C 03006214 */  bne        $v1, $v0, .L800D454C
    /* C4D40 800D4540 3A000224 */   addiu     $v0, $zero, 0x3A
    /* C4D44 800D4544 63510308 */  j          .L800D458C
    /* C4D48 800D4548 48001024 */   addiu     $s0, $zero, 0x48
  .L800D454C:
    /* C4D4C 800D454C 03006214 */  bne        $v1, $v0, .L800D455C
    /* C4D50 800D4550 40008224 */   addiu     $v0, $a0, 0x40
    /* C4D54 800D4554 63510308 */  j          .L800D458C
    /* C4D58 800D4558 49001024 */   addiu     $s0, $zero, 0x49
  .L800D455C:
    /* C4D5C 800D455C FF004230 */  andi       $v0, $v0, 0xFF
    /* C4D60 800D4560 1D00422C */  sltiu      $v0, $v0, 0x1D
    /* C4D64 800D4564 03004010 */  beqz       $v0, .L800D4574
    /* C4D68 800D4568 8AFF9024 */   addiu     $s0, $a0, -0x76
    /* C4D6C 800D456C 63510308 */  j          .L800D458C
    /* C4D70 800D4570 FFFF0624 */   addiu     $a2, $zero, -0x1
  .L800D4574:
    /* C4D74 800D4574 00004392 */  lbu        $v1, 0x0($s2)
    /* C4D78 800D4578 E5000224 */  addiu      $v0, $zero, 0xE5
    /* C4D7C 800D457C 03006214 */  bne        $v1, $v0, .L800D458C
    /* C4D80 800D4580 43007024 */   addiu     $s0, $v1, 0x43
    /* C4D84 800D4584 67001024 */  addiu      $s0, $zero, 0x67
    /* C4D88 800D4588 FFFF0624 */  addiu      $a2, $zero, -0x1
  .L800D458C:
    /* C4D8C 800D458C 0700A016 */  bnez       $s5, .L800D45AC
    /* C4D90 800D4590 FF000432 */   andi      $a0, $s0, 0xFF
    /* C4D94 800D4594 1000A0AF */  sw         $zero, 0x10($sp)
    /* C4D98 800D4598 21282002 */  addu       $a1, $s1, $zero
    /* C4D9C 800D459C 2130C602 */  addu       $a2, $s6, $a2
    /* C4DA0 800D45A0 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C4DA4 800D45A4 2138E002 */   addu      $a3, $s7, $zero
    /* C4DA8 800D45A8 FF000432 */  andi       $a0, $s0, 0xFF
  .L800D45AC:
    /* C4DAC 800D45AC 1180033C */  lui        $v1, %hi(HudPmx_gShapes)
    /* C4DB0 800D45B0 980C6324 */  addiu      $v1, $v1, %lo(HudPmx_gShapes)
    /* C4DB4 800D45B4 80100400 */  sll        $v0, $a0, 2
    /* C4DB8 800D45B8 21104400 */  addu       $v0, $v0, $a0
    /* C4DBC 800D45BC 80100200 */  sll        $v0, $v0, 2
    /* C4DC0 800D45C0 21104300 */  addu       $v0, $v0, $v1
    /* C4DC4 800D45C4 10004384 */  lh         $v1, 0x10($v0)
    /* C4DC8 800D45C8 01002226 */  addiu      $v0, $s1, 0x1
  .L800D45CC:
    /* C4DCC 800D45CC 21884300 */  addu       $s1, $v0, $v1
  .L800D45D0:
    /* C4DD0 800D45D0 1800A88F */  lw         $t0, 0x18($sp)
  .L800D45D4:
    /* C4DD4 800D45D4 01005226 */  addiu      $s2, $s2, 0x1
    /* C4DD8 800D45D8 01000825 */  addiu      $t0, $t0, 0x1
    /* C4DDC 800D45DC CF500308 */  j          .L800D433C
    /* C4DE0 800D45E0 1800A8AF */   sw        $t0, 0x18($sp)
  .L800D45E4:
    /* C4DE4 800D45E4 5B47030C */  jal        Hud_GoTpage__Fi
    /* C4DE8 800D45E8 21200000 */   addu      $a0, $zero, $zero
    /* C4DEC 800D45EC 1C00A98F */  lw         $t1, 0x1C($sp)
    /* C4DF0 800D45F0 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* C4DF4 800D45F4 4800BE8F */  lw         $fp, 0x48($sp)
    /* C4DF8 800D45F8 4400B78F */  lw         $s7, 0x44($sp)
    /* C4DFC 800D45FC 4000B68F */  lw         $s6, 0x40($sp)
    /* C4E00 800D4600 3C00B58F */  lw         $s5, 0x3C($sp)
    /* C4E04 800D4604 3800B48F */  lw         $s4, 0x38($sp)
    /* C4E08 800D4608 3400B38F */  lw         $s3, 0x34($sp)
    /* C4E0C 800D460C 3000B28F */  lw         $s2, 0x30($sp)
    /* C4E10 800D4610 2800B08F */  lw         $s0, 0x28($sp)
    /* C4E14 800D4614 23102902 */  subu       $v0, $s1, $t1
    /* C4E18 800D4618 2C00B18F */  lw         $s1, 0x2C($sp)
    /* C4E1C 800D461C 0800E003 */  jr         $ra
    /* C4E20 800D4620 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Hud_BuildString__FPciiiib
