.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31, 0x88

glabel DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
    /* B59FC 800C51FC 0400A584 */  lh         $a1, 0x4($a1)
    /* B5A00 800C5200 0400C684 */  lh         $a2, 0x4($a2)
    /* B5A04 800C5204 1000A28F */  lw         $v0, 0x10($sp)
    /* B5A08 800C5208 0400E784 */  lh         $a3, 0x4($a3)
    /* B5A0C 800C520C 2A18C500 */  slt        $v1, $a2, $a1
    /* B5A10 800C5210 04004884 */  lh         $t0, 0x4($v0)
    /* B5A14 800C5214 03006010 */  beqz       $v1, .L800C5224
    /* B5A18 800C5218 2A10E500 */   slt       $v0, $a3, $a1
    /* B5A1C 800C521C 2128C000 */  addu       $a1, $a2, $zero
    /* B5A20 800C5220 2A10E500 */  slt        $v0, $a3, $a1
  .L800C5224:
    /* B5A24 800C5224 03004010 */  beqz       $v0, .L800C5234
    /* B5A28 800C5228 2A100501 */   slt       $v0, $t0, $a1
    /* B5A2C 800C522C 2128E000 */  addu       $a1, $a3, $zero
    /* B5A30 800C5230 2A100501 */  slt        $v0, $t0, $a1
  .L800C5234:
    /* B5A34 800C5234 02004010 */  beqz       $v0, .L800C5240
    /* B5A38 800C5238 00000000 */   nop
    /* B5A3C 800C523C 21280001 */  addu       $a1, $t0, $zero
  .L800C5240:
    /* B5A40 800C5240 48018284 */  lh         $v0, 0x148($a0)
    /* B5A44 800C5244 00000000 */  nop
    /* B5A48 800C5248 2128A200 */  addu       $a1, $a1, $v0
    /* B5A4C 800C524C 0108A228 */  slti       $v0, $a1, 0x801
    /* B5A50 800C5250 03004014 */  bnez       $v0, .L800C5260
    /* B5A54 800C5254 0105A228 */   slti      $v0, $a1, 0x501
    /* B5A58 800C5258 0800E003 */  jr         $ra
    /* B5A5C 800C525C 21100000 */   addu      $v0, $zero, $zero
  .L800C5260:
    /* B5A60 800C5260 05004010 */  beqz       $v0, .L800C5278
    /* B5A64 800C5264 0102A328 */   slti      $v1, $a1, 0x201
    /* B5A68 800C5268 04006010 */  beqz       $v1, .L800C527C
    /* B5A6C 800C526C 02000224 */   addiu     $v0, $zero, 0x2
    /* B5A70 800C5270 0800E003 */  jr         $ra
    /* B5A74 800C5274 03000224 */   addiu     $v0, $zero, 0x3
  .L800C5278:
    /* B5A78 800C5278 01000224 */  addiu      $v0, $zero, 0x1
  .L800C527C:
    /* B5A7C 800C527C 0800E003 */  jr         $ra
    /* B5A80 800C5280 00000000 */   nop
endlabel DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
