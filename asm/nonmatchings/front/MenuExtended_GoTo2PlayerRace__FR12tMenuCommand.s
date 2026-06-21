.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x14C

glabel MenuExtended_GoTo2PlayerRace__FR12tMenuCommand
    /* 1D5F4 8002CDF4 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 1D5F8 8002CDF8 EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 1D5FC 8002CDFC 21988000 */  addu       $s3, $a0, $zero
    /* 1D600 8002CE00 0580033C */  lui        $v1, %hi(FEApp)
    /* 1D604 8002CE04 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1D608 8002CE08 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 1D60C 8002CE0C 00465124 */  addiu      $s1, $v0, %lo(frontEnd)
    /* 1D610 8002CE10 C014628C */  lw         $v0, %lo(FEApp)($v1)
    /* 1D614 8002CE14 06000424 */  addiu      $a0, $zero, 0x6
    /* 1D618 8002CE18 F000BFAF */  sw         $ra, 0xF0($sp)
    /* 1D61C 8002CE1C E800B2AF */  sw         $s2, 0xE8($sp)
    /* 1D620 8002CE20 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 1D624 8002CE24 000064AE */  sw         $a0, 0x0($s3)
    /* 1D628 8002CE28 04002392 */  lbu        $v1, 0x4($s1)
    /* 1D62C 8002CE2C 00000000 */  nop
    /* 1D630 8002CE30 3C006410 */  beq        $v1, $a0, .L8002CF24
    /* 1D634 8002CE34 2C005224 */   addiu     $s2, $v0, 0x2C
    /* 1D638 8002CE38 2A013092 */  lbu        $s0, 0x12A($s1)
    /* 1D63C 8002CE3C 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D640 8002CE40 0D000216 */  bne        $s0, $v0, .L8002CE78
    /* 1D644 8002CE44 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D648 8002CE48 1180043C */  lui        $a0, %hi(carManager)
    /* 1D64C 8002CE4C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D650 8002CE50 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1D654 8002CE54 21280000 */   addu      $a1, $zero, $zero
    /* 1D658 8002CE58 00140200 */  sll        $v0, $v0, 16
    /* 1D65C 8002CE5C 0600401C */  bgtz       $v0, .L8002CE78
    /* 1D660 8002CE60 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D664 8002CE64 04002292 */  lbu        $v0, 0x4($s1)
    /* 1D668 8002CE68 00000000 */  nop
    /* 1D66C 8002CE6C 27005014 */  bne        $v0, $s0, .L8002CF0C
    /* 1D670 8002CE70 AA000424 */   addiu     $a0, $zero, 0xAA
    /* 1D674 8002CE74 1180023C */  lui        $v0, %hi(frontEnd)
  .L8002CE78:
    /* 1D678 8002CE78 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 1D67C 8002CE7C 2A016290 */  lbu        $v0, 0x12A($v1)
    /* 1D680 8002CE80 00000000 */  nop
    /* 1D684 8002CE84 10004014 */  bnez       $v0, .L8002CEC8
    /* 1D688 8002CE88 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D68C 8002CE8C 0580023C */  lui        $v0, %hi(FEApp)
    /* 1D690 8002CE90 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 1D694 8002CE94 1180043C */  lui        $a0, %hi(carManager)
    /* 1D698 8002CE98 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 1D69C 8002CE9C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D6A0 8002CEA0 21104300 */  addu       $v0, $v0, $v1
    /* 1D6A4 8002CEA4 5C004590 */  lbu        $a1, 0x5C($v0)
    /* 1D6A8 8002CEA8 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1D6AC 8002CEAC 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1D6B0 8002CEB0 1700A293 */  lbu        $v0, 0x17($sp)
    /* 1D6B4 8002CEB4 00000000 */  nop
    /* 1D6B8 8002CEB8 03004014 */  bnez       $v0, .L8002CEC8
    /* 1D6BC 8002CEBC 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1D6C0 8002CEC0 C3B30008 */  j          .L8002CF0C
    /* 1D6C4 8002CEC4 F3000424 */   addiu     $a0, $zero, 0xF3
  .L8002CEC8:
    /* 1D6C8 8002CEC8 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 1D6CC 8002CECC 0400A390 */  lbu        $v1, 0x4($a1)
    /* 1D6D0 8002CED0 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D6D4 8002CED4 13006214 */  bne        $v1, $v0, .L8002CF24
    /* 1D6D8 8002CED8 0580023C */   lui       $v0, %hi(FEApp)
    /* 1D6DC 8002CEDC C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 1D6E0 8002CEE0 1180043C */  lui        $a0, %hi(carManager)
    /* 1D6E4 8002CEE4 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 1D6E8 8002CEE8 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1D6EC 8002CEEC 21104500 */  addu       $v0, $v0, $a1
    /* 1D6F0 8002CEF0 5C004590 */  lbu        $a1, 0x5C($v0)
    /* 1D6F4 8002CEF4 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1D6F8 8002CEF8 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1D6FC 8002CEFC CF00A293 */  lbu        $v0, 0xCF($sp)
    /* 1D700 8002CF00 00000000 */  nop
    /* 1D704 8002CF04 07004014 */  bnez       $v0, .L8002CF24
    /* 1D708 8002CF08 F2000424 */   addiu     $a0, $zero, 0xF2
  .L8002CF0C:
    /* 1D70C 8002CF0C 94E4020C */  jal        TextSys_Word__Fi
    /* 1D710 8002CF10 00000000 */   nop
    /* 1D714 8002CF14 21204002 */  addu       $a0, $s2, $zero
    /* 1D718 8002CF18 1062000C */  jal        Display__11tDialogBase
    /* 1D71C 8002CF1C 900082AC */   sw        $v0, 0x90($a0)
    /* 1D720 8002CF20 000060AE */  sw         $zero, 0x0($s3)
  .L8002CF24:
    /* 1D724 8002CF24 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 1D728 8002CF28 EC00B38F */  lw         $s3, 0xEC($sp)
    /* 1D72C 8002CF2C E800B28F */  lw         $s2, 0xE8($sp)
    /* 1D730 8002CF30 E400B18F */  lw         $s1, 0xE4($sp)
    /* 1D734 8002CF34 E000B08F */  lw         $s0, 0xE0($sp)
    /* 1D738 8002CF38 0800E003 */  jr         $ra
    /* 1D73C 8002CF3C F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel MenuExtended_GoTo2PlayerRace__FR12tMenuCommand
