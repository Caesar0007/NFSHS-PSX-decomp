.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14ObjectSignAnim, 0xB4

glabel ___14ObjectSignAnim
    /* 97410 800A6C10 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 97414 800A6C14 1400B1AF */  sw         $s1, 0x14($sp)
    /* 97418 800A6C18 21888000 */  addu       $s1, $a0, $zero
    /* 9741C 800A6C1C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 97420 800A6C20 2190A000 */  addu       $s2, $a1, $zero
    /* 97424 800A6C24 0580023C */  lui        $v0, %hi(_vt_14ObjectSignAnim)
    /* 97428 800A6C28 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9742C 800A6C2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97430 800A6C30 2800308E */  lw         $s0, 0x28($s1)
    /* 97434 800A6C34 88604224 */  addiu      $v0, $v0, %lo(_vt_14ObjectSignAnim)
    /* 97438 800A6C38 09000012 */  beqz       $s0, .L800A6C60
    /* 9743C 800A6C3C 000022AE */   sw        $v0, 0x0($s1)
    /* 97440 800A6C40 1000048E */  lw         $a0, 0x10($s0)
    /* 97444 800A6C44 00000000 */  nop
    /* 97448 800A6C48 03008010 */  beqz       $a0, .L800A6C58
    /* 9744C 800A6C4C 00000000 */   nop
    /* 97450 800A6C50 738F020C */  jal        __builtin_vec_delete
    /* 97454 800A6C54 00000000 */   nop
  .L800A6C58:
    /* 97458 800A6C58 6B8F020C */  jal        __builtin_delete
    /* 9745C 800A6C5C 21200002 */   addu      $a0, $s0, $zero
  .L800A6C60:
    /* 97460 800A6C60 2C00238E */  lw         $v1, 0x2C($s1)
    /* 97464 800A6C64 00000000 */  nop
    /* 97468 800A6C68 08006010 */  beqz       $v1, .L800A6C8C
    /* 9746C 800A6C6C 03000524 */   addiu     $a1, $zero, 0x3
    /* 97470 800A6C70 0000628C */  lw         $v0, 0x0($v1)
    /* 97474 800A6C74 00000000 */  nop
    /* 97478 800A6C78 08004484 */  lh         $a0, 0x8($v0)
    /* 9747C 800A6C7C 0C00428C */  lw         $v0, 0xC($v0)
    /* 97480 800A6C80 00000000 */  nop
    /* 97484 800A6C84 09F84000 */  jalr       $v0
    /* 97488 800A6C88 21206400 */   addu      $a0, $v1, $a0
  .L800A6C8C:
    /* 9748C 800A6C8C 0580023C */  lui        $v0, %hi(D_800560E8)
    /* 97490 800A6C90 E8604224 */  addiu      $v0, $v0, %lo(D_800560E8)
    /* 97494 800A6C94 000022AE */  sw         $v0, 0x0($s1)
    /* 97498 800A6C98 01004232 */  andi       $v0, $s2, 0x1
    /* 9749C 800A6C9C 03004010 */  beqz       $v0, .L800A6CAC
    /* 974A0 800A6CA0 00000000 */   nop
    /* 974A4 800A6CA4 6B8F020C */  jal        __builtin_delete
    /* 974A8 800A6CA8 21202002 */   addu      $a0, $s1, $zero
  .L800A6CAC:
    /* 974AC 800A6CAC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 974B0 800A6CB0 1800B28F */  lw         $s2, 0x18($sp)
    /* 974B4 800A6CB4 1400B18F */  lw         $s1, 0x14($sp)
    /* 974B8 800A6CB8 1000B08F */  lw         $s0, 0x10($sp)
    /* 974BC 800A6CBC 0800E003 */  jr         $ra
    /* 974C0 800A6CC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___14ObjectSignAnim
