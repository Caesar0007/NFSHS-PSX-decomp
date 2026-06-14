.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii, 0x34C

glabel LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
    /* A9C2C 800B942C 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* A9C30 800B9430 7C324284 */  lh         $v0, %lo(TrackSpec_gSpec)($v0)
    /* A9C34 800B9434 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* A9C38 800B9438 4800B6AF */  sw         $s6, 0x48($sp)
    /* A9C3C 800B943C 21B08000 */  addu       $s6, $a0, $zero
    /* A9C40 800B9440 4000B4AF */  sw         $s4, 0x40($sp)
    /* A9C44 800B9444 21A0A000 */  addu       $s4, $a1, $zero
    /* A9C48 800B9448 4400B5AF */  sw         $s5, 0x44($sp)
    /* A9C4C 800B944C FFFF1524 */  addiu      $s5, $zero, -0x1
    /* A9C50 800B9450 5000BEAF */  sw         $fp, 0x50($sp)
    /* A9C54 800B9454 21F0E000 */  addu       $fp, $a3, $zero
    /* A9C58 800B9458 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* A9C5C 800B945C 21B80000 */  addu       $s7, $zero, $zero
    /* A9C60 800B9460 5400BFAF */  sw         $ra, 0x54($sp)
    /* A9C64 800B9464 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* A9C68 800B9468 3800B2AF */  sw         $s2, 0x38($sp)
    /* A9C6C 800B946C 3400B1AF */  sw         $s1, 0x34($sp)
    /* A9C70 800B9470 3000B0AF */  sw         $s0, 0x30($sp)
    /* A9C74 800B9474 881880AF */  sw         $zero, %gp_rel(D_8013DDD4)($gp)
    /* A9C78 800B9478 12004010 */  beqz       $v0, .L800B94C4
    /* A9C7C 800B947C 6000A6AF */   sw        $a2, 0x60($sp)
    /* A9C80 800B9480 FDFF1524 */  addiu      $s5, $zero, -0x3
    /* A9C84 800B9484 0580043C */  lui        $a0, %hi(D_80056650)
    /* A9C88 800B9488 50668424 */  addiu      $a0, $a0, %lo(D_80056650)
    /* A9C8C 800B948C 80010524 */  addiu      $a1, $zero, 0x180
    /* A9C90 800B9490 CF94030C */  jal        reservememadr
    /* A9C94 800B9494 10000624 */   addiu     $a2, $zero, 0x10
    /* A9C98 800B9498 881882AF */  sw         $v0, %gp_rel(D_8013DDD4)($gp)
    /* A9C9C 800B949C 2120E002 */  addu       $a0, $s7, $zero
    /* A9CA0 800B94A0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* A9CA4 800B94A4 2118E002 */  addu       $v1, $s7, $zero
  .L800B94A8:
    /* A9CA8 800B94A8 8818828F */  lw         $v0, %gp_rel(D_8013DDD4)($gp)
    /* A9CAC 800B94AC 01008424 */  addiu      $a0, $a0, 0x1
    /* A9CB0 800B94B0 21106200 */  addu       $v0, $v1, $v0
    /* A9CB4 800B94B4 000045AC */  sw         $a1, 0x0($v0)
    /* A9CB8 800B94B8 20008228 */  slti       $v0, $a0, 0x20
    /* A9CBC 800B94BC FAFF4014 */  bnez       $v0, .L800B94A8
    /* A9CC0 800B94C0 0C006324 */   addiu     $v1, $v1, 0xC
  .L800B94C4:
    /* A9CC4 800B94C4 0580043C */  lui        $a0, %hi(D_8005665C)
    /* A9CC8 800B94C8 5C668424 */  addiu      $a0, $a0, %lo(D_8005665C)
    /* A9CCC 800B94CC 00040524 */  addiu      $a1, $zero, 0x400
    /* A9CD0 800B94D0 CF94030C */  jal        reservememadr
    /* A9CD4 800B94D4 10000624 */   addiu     $a2, $zero, 0x10
    /* A9CD8 800B94D8 8C1882AF */  sw         $v0, %gp_rel(D_8013DDD8)($gp)
    /* A9CDC 800B94DC FFFF0424 */  addiu      $a0, $zero, -0x1
    /* A9CE0 800B94E0 7F000324 */  addiu      $v1, $zero, 0x7F
    /* A9CE4 800B94E4 F8034224 */  addiu      $v0, $v0, 0x3F8
  .L800B94E8:
    /* A9CE8 800B94E8 020044A4 */  sh         $a0, 0x2($v0)
    /* A9CEC 800B94EC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* A9CF0 800B94F0 FDFF6104 */  bgez       $v1, .L800B94E8
    /* A9CF4 800B94F4 F8FF4224 */   addiu     $v0, $v0, -0x8
    /* A9CF8 800B94F8 1FB6030C */  jal        DrawSync
    /* A9CFC 800B94FC 21200000 */   addu      $a0, $zero, $zero
    /* A9D00 800B9500 21980000 */  addu       $s3, $zero, $zero
    /* A9D04 800B9504 21806002 */  addu       $s0, $s3, $zero
    /* A9D08 800B9508 21906002 */  addu       $s2, $s3, $zero
  .L800B950C:
    /* A9D0C 800B950C ABC2030C */  jal        shapecount
    /* A9D10 800B9510 2120C002 */   addu      $a0, $s6, $zero
    /* A9D14 800B9514 2A100202 */  slt        $v0, $s0, $v0
    /* A9D18 800B9518 8B004010 */  beqz       $v0, .L800B9748
    /* A9D1C 800B951C 2120C002 */   addu      $a0, $s6, $zero
    /* A9D20 800B9520 AEC2030C */  jal        shapepointer
    /* A9D24 800B9524 21280002 */   addu      $a1, $s0, $zero
    /* A9D28 800B9528 21884000 */  addu       $s1, $v0, $zero
    /* A9D2C 800B952C 84002012 */  beqz       $s1, .L800B9740
    /* A9D30 800B9530 2120C002 */   addu      $a0, $s6, $zero
    /* A9D34 800B9534 21280002 */  addu       $a1, $s0, $zero
    /* A9D38 800B9538 B8C2030C */  jal        shapename
    /* A9D3C 800B953C 2000A627 */   addiu     $a2, $sp, 0x20
    /* A9D40 800B9540 0C00022A */  slti       $v0, $s0, 0xC
    /* A9D44 800B9544 0A004014 */  bnez       $v0, .L800B9570
    /* A9D48 800B9548 2138A002 */   addu      $a3, $s5, $zero
    /* A9D4C 800B954C 00002292 */  lbu        $v0, 0x0($s1)
    /* A9D50 800B9550 01000324 */  addiu      $v1, $zero, 0x1
    /* A9D54 800B9554 03004230 */  andi       $v0, $v0, 0x3
    /* A9D58 800B9558 05004310 */  beq        $v0, $v1, .L800B9570
    /* A9D5C 800B955C 23000224 */   addiu     $v0, $zero, 0x23
    /* A9D60 800B9560 2000A393 */  lbu        $v1, 0x20($sp)
    /* A9D64 800B9564 00000000 */  nop
    /* A9D68 800B9568 03006214 */  bne        $v1, $v0, .L800B9578
    /* A9D6C 800B956C 21200000 */   addu      $a0, $zero, $zero
  .L800B9570:
    /* A9D70 800B9570 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* A9D74 800B9574 21200000 */  addu       $a0, $zero, $zero
  .L800B9578:
    /* A9D78 800B9578 6000A98F */  lw         $t1, 0x60($sp)
    /* A9D7C 800B957C 21282002 */  addu       $a1, $s1, $zero
    /* A9D80 800B9580 1400A7AF */  sw         $a3, 0x14($sp)
    /* A9D84 800B9584 1800A7AF */  sw         $a3, 0x18($sp)
    /* A9D88 800B9588 2138C003 */  addu       $a3, $fp, $zero
    /* A9D8C 800B958C 1C00B4AF */  sw         $s4, 0x1C($sp)
    /* A9D90 800B9590 25303701 */  or         $a2, $t1, $s7
    /* A9D94 800B9594 6800A98F */  lw         $t1, 0x68($sp)
    /* A9D98 800B9598 0200C634 */  ori        $a2, $a2, 0x2
    /* A9D9C 800B959C C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* A9DA0 800B95A0 1000A9AF */   sw        $t1, 0x10($sp)
    /* A9DA4 800B95A4 2000A393 */  lbu        $v1, 0x20($sp)
    /* A9DA8 800B95A8 21000224 */  addiu      $v0, $zero, 0x21
    /* A9DAC 800B95AC 2E006214 */  bne        $v1, $v0, .L800B9668
    /* A9DB0 800B95B0 1280023C */   lui       $v0, %hi(TrackSpec_gSpec)
    /* A9DB4 800B95B4 2300A427 */  addiu      $a0, $sp, 0x23
    /* A9DB8 800B95B8 8C18828F */  lw         $v0, %gp_rel(D_8013DDD8)($gp)
    /* A9DBC 800B95BC 2100A393 */  lbu        $v1, 0x21($sp)
    /* A9DC0 800B95C0 21104202 */  addu       $v0, $s2, $v0
    /* A9DC4 800B95C4 000043A0 */  sb         $v1, 0x0($v0)
    /* A9DC8 800B95C8 8C18828F */  lw         $v0, %gp_rel(D_8013DDD8)($gp)
    /* A9DCC 800B95CC 2200A393 */  lbu        $v1, 0x22($sp)
    /* A9DD0 800B95D0 21104202 */  addu       $v0, $s2, $v0
    /* A9DD4 800B95D4 40AC030C */  jal        atoi
    /* A9DD8 800B95D8 010043A0 */   sb        $v1, 0x1($v0)
    /* A9DDC 800B95DC 8C18848F */  lw         $a0, %gp_rel(D_8013DDD8)($gp)
    /* A9DE0 800B95E0 00000000 */  nop
    /* A9DE4 800B95E4 21184402 */  addu       $v1, $s2, $a0
    /* A9DE8 800B95E8 020062A4 */  sh         $v0, 0x2($v1)
    /* A9DEC 800B95EC 1B004010 */  beqz       $v0, .L800B965C
    /* A9DF0 800B95F0 060070A4 */   sh        $s0, 0x6($v1)
    /* A9DF4 800B95F4 21280000 */  addu       $a1, $zero, $zero
    /* A9DF8 800B95F8 21408000 */  addu       $t0, $a0, $zero
    /* A9DFC 800B95FC 2100A793 */  lbu        $a3, 0x21($sp)
    /* A9E00 800B9600 2200A693 */  lbu        $a2, 0x22($sp)
  .L800B9604:
    /* A9E04 800B9604 21188000 */  addu       $v1, $a0, $zero
    /* A9E08 800B9608 00006290 */  lbu        $v0, 0x0($v1)
    /* A9E0C 800B960C 00000000 */  nop
    /* A9E10 800B9610 09004714 */  bne        $v0, $a3, .L800B9638
    /* A9E14 800B9614 00000000 */   nop
    /* A9E18 800B9618 01006290 */  lbu        $v0, 0x1($v1)
    /* A9E1C 800B961C 00000000 */  nop
    /* A9E20 800B9620 05004614 */  bne        $v0, $a2, .L800B9638
    /* A9E24 800B9624 00000000 */   nop
    /* A9E28 800B9628 02006284 */  lh         $v0, 0x2($v1)
    /* A9E2C 800B962C 00000000 */  nop
    /* A9E30 800B9630 07004010 */  beqz       $v0, .L800B9650
    /* A9E34 800B9634 21104802 */   addu      $v0, $s2, $t0
  .L800B9638:
    /* A9E38 800B9638 0100A524 */  addiu      $a1, $a1, 0x1
    /* A9E3C 800B963C 8000A228 */  slti       $v0, $a1, 0x80
    /* A9E40 800B9640 F0FF4014 */  bnez       $v0, .L800B9604
    /* A9E44 800B9644 08008424 */   addiu     $a0, $a0, 0x8
    /* A9E48 800B9648 99E50208 */  j          .L800B9664
    /* A9E4C 800B964C 08005226 */   addiu     $s2, $s2, 0x8
  .L800B9650:
    /* A9E50 800B9650 04008394 */  lhu        $v1, 0x4($a0)
    /* A9E54 800B9654 98E50208 */  j          .L800B9660
    /* A9E58 800B9658 040043A4 */   sh        $v1, 0x4($v0)
  .L800B965C:
    /* A9E5C 800B965C 040070A4 */  sh         $s0, 0x4($v1)
  .L800B9660:
    /* A9E60 800B9660 08005226 */  addiu      $s2, $s2, 0x8
  .L800B9664:
    /* A9E64 800B9664 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
  .L800B9668:
    /* A9E68 800B9668 7C324284 */  lh         $v0, %lo(TrackSpec_gSpec)($v0)
    /* A9E6C 800B966C 00000000 */  nop
    /* A9E70 800B9670 32004010 */  beqz       $v0, .L800B973C
    /* A9E74 800B9674 5A000224 */   addiu     $v0, $zero, 0x5A
    /* A9E78 800B9678 2000A393 */  lbu        $v1, 0x20($sp)
    /* A9E7C 800B967C 00000000 */  nop
    /* A9E80 800B9680 2E006214 */  bne        $v1, $v0, .L800B973C
    /* A9E84 800B9684 00000000 */   nop
    /* A9E88 800B9688 2300A293 */  lbu        $v0, 0x23($sp)
    /* A9E8C 800B968C 2200A493 */  lbu        $a0, 0x22($sp)
    /* A9E90 800B9690 2100A393 */  lbu        $v1, 0x21($sp)
    /* A9E94 800B9694 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* A9E98 800B9698 52000224 */  addiu      $v0, $zero, 0x52
    /* A9E9C 800B969C 13006214 */  bne        $v1, $v0, .L800B96EC
    /* A9EA0 800B96A0 2800A4A7 */   sh        $a0, 0x28($sp)
    /* A9EA4 800B96A4 00002292 */  lbu        $v0, 0x0($s1)
    /* A9EA8 800B96A8 01000324 */  addiu      $v1, $zero, 0x1
    /* A9EAC 800B96AC 03004230 */  andi       $v0, $v0, 0x3
    /* A9EB0 800B96B0 0E004314 */  bne        $v0, $v1, .L800B96EC
    /* A9EB4 800B96B4 04107300 */   sllv      $v0, $s3, $v1
    /* A9EB8 800B96B8 21105300 */  addu       $v0, $v0, $s3
    /* A9EBC 800B96BC 8818838F */  lw         $v1, %gp_rel(D_8013DDD4)($gp)
    /* A9EC0 800B96C0 80100200 */  sll        $v0, $v0, 2
    /* A9EC4 800B96C4 21104300 */  addu       $v0, $v0, $v1
    /* A9EC8 800B96C8 000044A4 */  sh         $a0, 0x0($v0)
    /* A9ECC 800B96CC 2300A393 */  lbu        $v1, 0x23($sp)
    /* A9ED0 800B96D0 01007326 */  addiu      $s3, $s3, 0x1
    /* A9ED4 800B96D4 040050AC */  sw         $s0, 0x4($v0)
    /* A9ED8 800B96D8 080050AC */  sw         $s0, 0x8($v0)
    /* A9EDC 800B96DC CFE50208 */  j          .L800B973C
    /* A9EE0 800B96E0 020043A4 */   sh        $v1, 0x2($v0)
  .L800B96E4:
    /* A9EE4 800B96E4 CFE50208 */  j          .L800B973C
    /* A9EE8 800B96E8 080070AC */   sw        $s0, 0x8($v1)
  .L800B96EC:
    /* A9EEC 800B96EC 2100A393 */  lbu        $v1, 0x21($sp)
    /* A9EF0 800B96F0 5A000224 */  addiu      $v0, $zero, 0x5A
    /* A9EF4 800B96F4 11006214 */  bne        $v1, $v0, .L800B973C
    /* A9EF8 800B96F8 21200000 */   addu      $a0, $zero, $zero
    /* A9EFC 800B96FC 2800A687 */  lh         $a2, 0x28($sp)
    /* A9F00 800B9700 2A00A587 */  lh         $a1, 0x2A($sp)
    /* A9F04 800B9704 8818838F */  lw         $v1, %gp_rel(D_8013DDD4)($gp)
  .L800B9708:
    /* A9F08 800B9708 00000000 */  nop
    /* A9F0C 800B970C 00006294 */  lhu        $v0, 0x0($v1)
    /* A9F10 800B9710 00000000 */  nop
    /* A9F14 800B9714 0500C214 */  bne        $a2, $v0, .L800B972C
    /* A9F18 800B9718 00000000 */   nop
    /* A9F1C 800B971C 02006294 */  lhu        $v0, 0x2($v1)
    /* A9F20 800B9720 00000000 */  nop
    /* A9F24 800B9724 EFFFA210 */  beq        $a1, $v0, .L800B96E4
    /* A9F28 800B9728 00000000 */   nop
  .L800B972C:
    /* A9F2C 800B972C 01008424 */  addiu      $a0, $a0, 0x1
    /* A9F30 800B9730 20008228 */  slti       $v0, $a0, 0x20
    /* A9F34 800B9734 F4FF4014 */  bnez       $v0, .L800B9708
    /* A9F38 800B9738 0C006324 */   addiu     $v1, $v1, 0xC
  .L800B973C:
    /* A9F3C 800B973C 10009426 */  addiu      $s4, $s4, 0x10
  .L800B9740:
    /* A9F40 800B9740 43E50208 */  j          .L800B950C
    /* A9F44 800B9744 01001026 */   addiu     $s0, $s0, 0x1
  .L800B9748:
    /* A9F48 800B9748 5400BF8F */  lw         $ra, 0x54($sp)
    /* A9F4C 800B974C 5000BE8F */  lw         $fp, 0x50($sp)
    /* A9F50 800B9750 4C00B78F */  lw         $s7, 0x4C($sp)
    /* A9F54 800B9754 4800B68F */  lw         $s6, 0x48($sp)
    /* A9F58 800B9758 4400B58F */  lw         $s5, 0x44($sp)
    /* A9F5C 800B975C 4000B48F */  lw         $s4, 0x40($sp)
    /* A9F60 800B9760 3C00B38F */  lw         $s3, 0x3C($sp)
    /* A9F64 800B9764 3800B28F */  lw         $s2, 0x38($sp)
    /* A9F68 800B9768 3400B18F */  lw         $s1, 0x34($sp)
    /* A9F6C 800B976C 3000B08F */  lw         $s0, 0x30($sp)
    /* A9F70 800B9770 0800E003 */  jr         $ra
    /* A9F74 800B9774 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
