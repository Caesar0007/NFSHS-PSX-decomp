.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CheckForBadPosition__FP8Car_tObj, 0xD8

glabel AIPhysic_CheckForBadPosition__FP8Car_tObj
    /* 5A614 80069E14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5A618 80069E18 21380000 */  addu       $a3, $zero, $zero
    /* 5A61C 80069E1C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5A620 80069E20 B400828C */  lw         $v0, 0xB4($a0)
    /* 5A624 80069E24 7300033C */  lui        $v1, (0x730000 >> 16)
    /* 5A628 80069E28 2A106200 */  slt        $v0, $v1, $v0
    /* 5A62C 80069E2C 0F004014 */  bnez       $v0, .L80069E6C
    /* 5A630 80069E30 2140E000 */   addu      $t0, $a3, $zero
    /* 5A634 80069E34 AC00828C */  lw         $v0, 0xAC($a0)
    /* 5A638 80069E38 00000000 */  nop
    /* 5A63C 80069E3C 2A106200 */  slt        $v0, $v1, $v0
    /* 5A640 80069E40 0A004014 */  bnez       $v0, .L80069E6C
    /* 5A644 80069E44 00000000 */   nop
    /* 5A648 80069E48 C000828C */  lw         $v0, 0xC0($a0)
    /* 5A64C 80069E4C 00000000 */  nop
    /* 5A650 80069E50 2A106200 */  slt        $v0, $v1, $v0
    /* 5A654 80069E54 06004010 */  beqz       $v0, .L80069E70
    /* 5A658 80069E58 00000000 */   nop
    /* 5A65C 80069E5C 90008290 */  lbu        $v0, 0x90($a0)
    /* 5A660 80069E60 00000000 */  nop
    /* 5A664 80069E64 02004014 */  bnez       $v0, .L80069E70
    /* 5A668 80069E68 00000000 */   nop
  .L80069E6C:
    /* 5A66C 80069E6C 01000724 */  addiu      $a3, $zero, 0x1
  .L80069E70:
    /* 5A670 80069E70 08008284 */  lh         $v0, 0x8($a0)
    /* 5A674 80069E74 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5A678 80069E78 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5A67C 80069E7C 7405868C */  lw         $a2, 0x574($a0)
    /* 5A680 80069E80 40110200 */  sll        $v0, $v0, 5
    /* 5A684 80069E84 21284300 */  addu       $a1, $v0, $v1
    /* 5A688 80069E88 1800A384 */  lh         $v1, 0x18($a1)
    /* 5A68C 80069E8C DDFF023C */  lui        $v0, (0xFFDD0000 >> 16)
    /* 5A690 80069E90 001A0300 */  sll        $v1, $v1, 8
    /* 5A694 80069E94 23104300 */  subu       $v0, $v0, $v1
    /* 5A698 80069E98 2A10C200 */  slt        $v0, $a2, $v0
    /* 5A69C 80069E9C 08004014 */  bnez       $v0, .L80069EC0
    /* 5A6A0 80069EA0 2300033C */   lui       $v1, (0x230000 >> 16)
    /* 5A6A4 80069EA4 1A00A284 */  lh         $v0, 0x1A($a1)
    /* 5A6A8 80069EA8 00000000 */  nop
    /* 5A6AC 80069EAC 00120200 */  sll        $v0, $v0, 8
    /* 5A6B0 80069EB0 21104300 */  addu       $v0, $v0, $v1
    /* 5A6B4 80069EB4 2A104600 */  slt        $v0, $v0, $a2
    /* 5A6B8 80069EB8 02004010 */  beqz       $v0, .L80069EC4
    /* 5A6BC 80069EBC 00000000 */   nop
  .L80069EC0:
    /* 5A6C0 80069EC0 01000824 */  addiu      $t0, $zero, 0x1
  .L80069EC4:
    /* 5A6C4 80069EC4 0300E014 */  bnez       $a3, .L80069ED4
    /* 5A6C8 80069EC8 01000524 */   addiu     $a1, $zero, 0x1
    /* 5A6CC 80069ECC 03000011 */  beqz       $t0, .L80069EDC
    /* 5A6D0 80069ED0 00000000 */   nop
  .L80069ED4:
    /* 5A6D4 80069ED4 9919020C */  jal        Cars_ResetCollidedCars__FP8Car_tObjii
    /* 5A6D8 80069ED8 21300000 */   addu      $a2, $zero, $zero
  .L80069EDC:
    /* 5A6DC 80069EDC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5A6E0 80069EE0 00000000 */  nop
    /* 5A6E4 80069EE4 0800E003 */  jr         $ra
    /* 5A6E8 80069EE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_CheckForBadPosition__FP8Car_tObj
