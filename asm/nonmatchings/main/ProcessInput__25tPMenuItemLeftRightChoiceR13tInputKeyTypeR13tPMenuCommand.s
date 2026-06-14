.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand, 0x8C

glabel ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand
    /* 97DC4 800A75C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97DC8 800A75C8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97DCC 800A75CC 2180A000 */  addu       $s0, $a1, $zero
    /* 97DD0 800A75D0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 97DD4 800A75D4 0000038E */  lw         $v1, 0x0($s0)
    /* 97DD8 800A75D8 00080224 */  addiu      $v0, $zero, 0x800
    /* 97DDC 800A75DC 05006210 */  beq        $v1, $v0, .L800A75F4
    /* 97DE0 800A75E0 00100224 */   addiu     $v0, $zero, 0x1000
    /* 97DE4 800A75E4 0B006210 */  beq        $v1, $v0, .L800A7614
    /* 97DE8 800A75E8 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 97DEC 800A75EC 909D0208 */  j          .L800A7640
    /* 97DF0 800A75F0 00000000 */   nop
  .L800A75F4:
    /* 97DF4 800A75F4 0C00838C */  lw         $v1, 0xC($a0)
    /* 97DF8 800A75F8 00000000 */  nop
    /* 97DFC 800A75FC 0800628C */  lw         $v0, 0x8($v1)
    /* 97E00 800A7600 00000000 */  nop
    /* 97E04 800A7604 28004484 */  lh         $a0, 0x28($v0)
    /* 97E08 800A7608 2C00428C */  lw         $v0, 0x2C($v0)
    /* 97E0C 800A760C 8B9D0208 */  j          .L800A762C
    /* 97E10 800A7610 FFFF0524 */   addiu     $a1, $zero, -0x1
  .L800A7614:
    /* 97E14 800A7614 0C00838C */  lw         $v1, 0xC($a0)
    /* 97E18 800A7618 00000000 */  nop
    /* 97E1C 800A761C 0800628C */  lw         $v0, 0x8($v1)
    /* 97E20 800A7620 00000000 */  nop
    /* 97E24 800A7624 20004484 */  lh         $a0, 0x20($v0)
    /* 97E28 800A7628 2400428C */  lw         $v0, 0x24($v0)
  .L800A762C:
    /* 97E2C 800A762C 00000000 */  nop
    /* 97E30 800A7630 09F84000 */  jalr       $v0
    /* 97E34 800A7634 21206400 */   addu      $a0, $v1, $a0
    /* 97E38 800A7638 01000224 */  addiu      $v0, $zero, 0x1
    /* 97E3C 800A763C 000002AE */  sw         $v0, 0x0($s0)
  .L800A7640:
    /* 97E40 800A7640 1400BF8F */  lw         $ra, 0x14($sp)
    /* 97E44 800A7644 1000B08F */  lw         $s0, 0x10($sp)
    /* 97E48 800A7648 0800E003 */  jr         $ra
    /* 97E4C 800A764C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand
