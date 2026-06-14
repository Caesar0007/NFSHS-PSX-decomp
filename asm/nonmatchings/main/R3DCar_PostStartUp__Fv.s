.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_PostStartUp__Fv, 0xE4

glabel R3DCar_PostStartUp__Fv
    /* 9E5E4 800ADDE4 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9E5E8 800ADDE8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9E5EC 800ADDEC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 9E5F0 800ADDF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9E5F4 800ADDF4 08004014 */  bnez       $v0, .L800ADE18
    /* 9E5F8 800ADDF8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 9E5FC 800ADDFC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 9E600 800ADE00 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 9E604 800ADE04 C0010524 */  addiu      $a1, $zero, 0x1C0
    /* 9E608 800ADE08 18004500 */  mult       $v0, $a1
    /* 9E60C 800ADE0C 12280000 */  mflo       $a1
    /* 9E610 800ADE10 88B70208 */  j          .L800ADE20
    /* 9E614 800ADE14 0004A228 */   slti      $v0, $a1, 0x400
  .L800ADE18:
    /* 9E618 800ADE18 00040524 */  addiu      $a1, $zero, 0x400
    /* 9E61C 800ADE1C 0004A228 */  slti       $v0, $a1, 0x400
  .L800ADE20:
    /* 9E620 800ADE20 02004010 */  beqz       $v0, .L800ADE2C
    /* 9E624 800ADE24 1480043C */   lui       $a0, %hi(D_8013D328)
    /* 9E628 800ADE28 00040524 */  addiu      $a1, $zero, 0x400
  .L800ADE2C:
    /* 9E62C 800ADE2C 28D38424 */  addiu      $a0, $a0, %lo(D_8013D328)
    /* 9E630 800ADE30 80800500 */  sll        $s0, $a1, 2
    /* 9E634 800ADE34 21280002 */  addu       $a1, $s0, $zero
    /* 9E638 800ADE38 CF94030C */  jal        reservememadr
    /* 9E63C 800ADE3C 21300000 */   addu      $a2, $zero, $zero
    /* 9E640 800ADE40 1480043C */  lui        $a0, %hi(D_8013D330)
    /* 9E644 800ADE44 30D38424 */  addiu      $a0, $a0, %lo(D_8013D330)
    /* 9E648 800ADE48 21280002 */  addu       $a1, $s0, $zero
    /* 9E64C 800ADE4C 21300000 */  addu       $a2, $zero, $zero
    /* 9E650 800ADE50 1180033C */  lui        $v1, %hi(R3DCar_subOtStart)
    /* 9E654 800ADE54 AC6D7124 */  addiu      $s1, $v1, %lo(R3DCar_subOtStart)
    /* 9E658 800ADE58 CF94030C */  jal        reservememadr
    /* 9E65C 800ADE5C AC6D62AC */   sw        $v0, %lo(R3DCar_subOtStart)($v1)
    /* 9E660 800ADE60 D80D838F */  lw         $v1, %gp_rel(R3DCar_InMenu)($gp)
    /* 9E664 800ADE64 00000000 */  nop
    /* 9E668 800ADE68 06006014 */  bnez       $v1, .L800ADE84
    /* 9E66C 800ADE6C 080022AE */   sw        $v0, 0x8($s1)
    /* 9E670 800ADE70 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 9E674 800ADE74 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 9E678 800ADE78 01000224 */  addiu      $v0, $zero, 0x1
    /* 9E67C 800ADE7C 0D006214 */  bne        $v1, $v0, .L800ADEB4
    /* 9E680 800ADE80 00000000 */   nop
  .L800ADE84:
    /* 9E684 800ADE84 0580043C */  lui        $a0, %hi(D_800563E4)
    /* 9E688 800ADE88 E4638424 */  addiu      $a0, $a0, %lo(D_800563E4)
    /* 9E68C 800ADE8C 21280002 */  addu       $a1, $s0, $zero
    /* 9E690 800ADE90 CF94030C */  jal        reservememadr
    /* 9E694 800ADE94 21300000 */   addu      $a2, $zero, $zero
    /* 9E698 800ADE98 0580043C */  lui        $a0, %hi(D_800563F0)
    /* 9E69C 800ADE9C F0638424 */  addiu      $a0, $a0, %lo(D_800563F0)
    /* 9E6A0 800ADEA0 21280002 */  addu       $a1, $s0, $zero
    /* 9E6A4 800ADEA4 21300000 */  addu       $a2, $zero, $zero
    /* 9E6A8 800ADEA8 CF94030C */  jal        reservememadr
    /* 9E6AC 800ADEAC 040022AE */   sw        $v0, 0x4($s1)
    /* 9E6B0 800ADEB0 0C0022AE */  sw         $v0, 0xC($s1)
  .L800ADEB4:
    /* 9E6B4 800ADEB4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 9E6B8 800ADEB8 1400B18F */  lw         $s1, 0x14($sp)
    /* 9E6BC 800ADEBC 1000B08F */  lw         $s0, 0x10($sp)
    /* 9E6C0 800ADEC0 0800E003 */  jr         $ra
    /* 9E6C4 800ADEC4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_PostStartUp__Fv
