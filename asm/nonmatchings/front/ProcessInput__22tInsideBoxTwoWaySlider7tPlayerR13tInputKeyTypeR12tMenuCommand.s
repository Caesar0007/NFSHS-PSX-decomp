.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xB0

glabel ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* FCF0 8001F4F0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FCF4 8001F4F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* FCF8 8001F4F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* FCFC 8001F4FC 2180C000 */  addu       $s0, $a2, $zero
    /* FD00 8001F500 1800BFAF */  sw         $ra, 0x18($sp)
    /* FD04 8001F504 0000038E */  lw         $v1, 0x0($s0)
    /* FD08 8001F508 02000224 */  addiu      $v0, $zero, 0x2
    /* FD0C 8001F50C 07006214 */  bne        $v1, $v0, .L8001F52C
    /* FD10 8001F510 21888000 */   addu      $s1, $a0, $zero
    /* FD14 8001F514 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* FD18 8001F518 21200000 */   addu      $a0, $zero, $zero
    /* FD1C 8001F51C 01000224 */  addiu      $v0, $zero, 0x1
    /* FD20 8001F520 2C0022AE */  sw         $v0, 0x2C($s1)
    /* FD24 8001F524 000002AE */  sw         $v0, 0x0($s0)
    /* FD28 8001F528 0000038E */  lw         $v1, 0x0($s0)
  .L8001F52C:
    /* FD2C 8001F52C 80000224 */  addiu      $v0, $zero, 0x80
    /* FD30 8001F530 0A006214 */  bne        $v1, $v0, .L8001F55C
    /* FD34 8001F534 00000000 */   nop
    /* FD38 8001F538 2C00228E */  lw         $v0, 0x2C($s1)
    /* FD3C 8001F53C 00000000 */  nop
    /* FD40 8001F540 0C004010 */  beqz       $v0, .L8001F574
    /* FD44 8001F544 00080224 */   addiu     $v0, $zero, 0x800
    /* FD48 8001F548 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* FD4C 8001F54C 01000424 */   addiu     $a0, $zero, 0x1
    /* FD50 8001F550 01000224 */  addiu      $v0, $zero, 0x1
    /* FD54 8001F554 2C0020AE */  sw         $zero, 0x2C($s1)
    /* FD58 8001F558 000002AE */  sw         $v0, 0x0($s0)
  .L8001F55C:
    /* FD5C 8001F55C 2C00228E */  lw         $v0, 0x2C($s1)
    /* FD60 8001F560 00000000 */  nop
    /* FD64 8001F564 08004014 */  bnez       $v0, .L8001F588
    /* FD68 8001F568 01000224 */   addiu     $v0, $zero, 0x1
    /* FD6C 8001F56C 0000038E */  lw         $v1, 0x0($s0)
    /* FD70 8001F570 00080224 */  addiu      $v0, $zero, 0x800
  .L8001F574:
    /* FD74 8001F574 03006210 */  beq        $v1, $v0, .L8001F584
    /* FD78 8001F578 00100224 */   addiu     $v0, $zero, 0x1000
    /* FD7C 8001F57C 03006214 */  bne        $v1, $v0, .L8001F58C
    /* FD80 8001F580 00000000 */   nop
  .L8001F584:
    /* FD84 8001F584 01000224 */  addiu      $v0, $zero, 0x1
  .L8001F588:
    /* FD88 8001F588 000002AE */  sw         $v0, 0x0($s0)
  .L8001F58C:
    /* FD8C 8001F58C 1800BF8F */  lw         $ra, 0x18($sp)
    /* FD90 8001F590 1400B18F */  lw         $s1, 0x14($sp)
    /* FD94 8001F594 1000B08F */  lw         $s0, 0x10($sp)
    /* FD98 8001F598 0800E003 */  jr         $ra
    /* FD9C 8001F59C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand
