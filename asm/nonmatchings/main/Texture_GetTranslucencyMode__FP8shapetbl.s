.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_GetTranslucencyMode__FP8shapetbl, 0x78

glabel Texture_GetTranslucencyMode__FP8shapetbl
    /* D06A0 800DFEA0 6B000624 */  addiu      $a2, $zero, 0x6B
    /* D06A4 800DFEA4 03000724 */  addiu      $a3, $zero, 0x3
    /* D06A8 800DFEA8 00FF0524 */  addiu      $a1, $zero, -0x100
  .L800DFEAC:
    /* D06AC 800DFEAC 16008010 */  beqz       $a0, .L800DFF08
    /* D06B0 800DFEB0 00000000 */   nop
    /* D06B4 800DFEB4 00008290 */  lbu        $v0, 0x0($a0)
    /* D06B8 800DFEB8 00000000 */  nop
    /* D06BC 800DFEBC 09004614 */  bne        $v0, $a2, .L800DFEE4
    /* D06C0 800DFEC0 00000000 */   nop
    /* D06C4 800DFEC4 04008294 */  lhu        $v0, 0x4($a0)
    /* D06C8 800DFEC8 00000000 */  nop
    /* D06CC 800DFECC 42110200 */  srl        $v0, $v0, 5
    /* D06D0 800DFED0 03004230 */  andi       $v0, $v0, 0x3
    /* D06D4 800DFED4 0E004714 */  bne        $v0, $a3, .L800DFF10
    /* D06D8 800DFED8 00000000 */   nop
    /* D06DC 800DFEDC 0800E003 */  jr         $ra
    /* D06E0 800DFEE0 02000224 */   addiu     $v0, $zero, 0x2
  .L800DFEE4:
    /* D06E4 800DFEE4 0000838C */  lw         $v1, 0x0($a0)
    /* D06E8 800DFEE8 00000000 */  nop
    /* D06EC 800DFEEC 24106500 */  and        $v0, $v1, $a1
    /* D06F0 800DFEF0 03004010 */  beqz       $v0, .L800DFF00
    /* D06F4 800DFEF4 03120300 */   sra       $v0, $v1, 8
    /* D06F8 800DFEF8 AB7F0308 */  j          .L800DFEAC
    /* D06FC 800DFEFC 21208200 */   addu      $a0, $a0, $v0
  .L800DFF00:
    /* D0700 800DFF00 AB7F0308 */  j          .L800DFEAC
    /* D0704 800DFF04 21200000 */   addu      $a0, $zero, $zero
  .L800DFF08:
    /* D0708 800DFF08 0800E003 */  jr         $ra
    /* D070C 800DFF0C 21100000 */   addu      $v0, $zero, $zero
  .L800DFF10:
    /* D0710 800DFF10 0800E003 */  jr         $ra
    /* D0714 800DFF14 00000000 */   nop
endlabel Texture_GetTranslucencyMode__FP8shapetbl
