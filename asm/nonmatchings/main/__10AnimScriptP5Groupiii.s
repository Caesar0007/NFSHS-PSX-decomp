.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10AnimScriptP5Groupiii, 0xCC

glabel __10AnimScriptP5Groupiii
    /* 64C68 80074468 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 64C6C 8007446C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 64C70 80074470 21908000 */  addu       $s2, $a0, $zero
    /* 64C74 80074474 3800A48F */  lw         $a0, 0x38($sp)
    /* 64C78 80074478 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 64C7C 8007447C 2198C000 */  addu       $s3, $a2, $zero
    /* 64C80 80074480 2000B4AF */  sw         $s4, 0x20($sp)
    /* 64C84 80074484 21A0E000 */  addu       $s4, $a3, $zero
    /* 64C88 80074488 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64C8C 8007448C 0400B024 */  addiu      $s0, $a1, 0x4
    /* 64C90 80074490 2400BFAF */  sw         $ra, 0x24($sp)
    /* 64C94 80074494 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64C98 80074498 0000B18C */  lw         $s1, 0x0($a1)
    /* 64C9C 8007449C 618F020C */  jal        __builtin_vec_new
    /* 64CA0 800744A0 80200400 */   sll       $a0, $a0, 2
    /* 64CA4 800744A4 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* 64CA8 800744A8 100042AE */  sw         $v0, 0x10($s2)
    /* 64CAC 800744AC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 64CB0 800744B0 12002212 */  beq        $s1, $v0, .L800744FC
    /* 64CB4 800744B4 21200000 */   addu      $a0, $zero, $zero
    /* 64CB8 800744B8 21284000 */  addu       $a1, $v0, $zero
  .L800744BC:
    /* 64CBC 800744BC 02000292 */  lbu        $v0, 0x2($s0)
    /* 64CC0 800744C0 00000000 */  nop
    /* 64CC4 800744C4 09005314 */  bne        $v0, $s3, .L800744EC
    /* 64CC8 800744C8 00000000 */   nop
    /* 64CCC 800744CC 0D000292 */  lbu        $v0, 0xD($s0)
    /* 64CD0 800744D0 00000000 */  nop
    /* 64CD4 800744D4 05005414 */  bne        $v0, $s4, .L800744EC
    /* 64CD8 800744D8 80100400 */   sll       $v0, $a0, 2
    /* 64CDC 800744DC 1000438E */  lw         $v1, 0x10($s2)
    /* 64CE0 800744E0 01008424 */  addiu      $a0, $a0, 0x1
    /* 64CE4 800744E4 21104300 */  addu       $v0, $v0, $v1
    /* 64CE8 800744E8 000050AC */  sw         $s0, 0x0($v0)
  .L800744EC:
    /* 64CEC 800744EC 00000286 */  lh         $v0, 0x0($s0)
    /* 64CF0 800744F0 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* 64CF4 800744F4 F1FF2516 */  bne        $s1, $a1, .L800744BC
    /* 64CF8 800744F8 21800202 */   addu      $s0, $s0, $v0
  .L800744FC:
    /* 64CFC 800744FC 21104002 */  addu       $v0, $s2, $zero
    /* 64D00 80074500 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 64D04 80074504 B0E0648C */  lw         $a0, %lo(D_8011E0B0)($v1)
    /* 64D08 80074508 06000324 */  addiu      $v1, $zero, 0x6
    /* 64D0C 8007450C 080043AC */  sw         $v1, 0x8($v0)
    /* 64D10 80074510 000044AC */  sw         $a0, 0x0($v0)
    /* 64D14 80074514 2400BF8F */  lw         $ra, 0x24($sp)
    /* 64D18 80074518 2000B48F */  lw         $s4, 0x20($sp)
    /* 64D1C 8007451C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 64D20 80074520 1800B28F */  lw         $s2, 0x18($sp)
    /* 64D24 80074524 1400B18F */  lw         $s1, 0x14($sp)
    /* 64D28 80074528 1000B08F */  lw         $s0, 0x10($sp)
    /* 64D2C 8007452C 0800E003 */  jr         $ra
    /* 64D30 80074530 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __10AnimScriptP5Groupiii
