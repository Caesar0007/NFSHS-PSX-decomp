.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_InitPaletteSharing__Fv, 0x7C

glabel Texture_InitPaletteSharing__Fv
    /* CFDB4 800DF5B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CFDB8 800DF5B8 0580043C */  lui        $a0, %hi(D_80056A20)
    /* CFDBC 800DF5BC 206A8424 */  addiu      $a0, $a0, %lo(D_80056A20)
    /* CFDC0 800DF5C0 00080524 */  addiu      $a1, $zero, 0x800
    /* CFDC4 800DF5C4 1000BFAF */  sw         $ra, 0x10($sp)
    /* CFDC8 800DF5C8 C81580AF */  sw         $zero, %gp_rel(Texture_gNum4bitPal)($gp)
    /* CFDCC 800DF5CC CC1580AF */  sw         $zero, %gp_rel(Texture_gNum8bitPal)($gp)
    /* CFDD0 800DF5D0 CF94030C */  jal        reservememadr
    /* CFDD4 800DF5D4 10000624 */   addiu     $a2, $zero, 0x10
    /* CFDD8 800DF5D8 0580043C */  lui        $a0, %hi(D_80056A2C)
    /* CFDDC 800DF5DC 2C6A8424 */  addiu      $a0, $a0, %lo(D_80056A2C)
    /* CFDE0 800DF5E0 00010524 */  addiu      $a1, $zero, 0x100
    /* CFDE4 800DF5E4 D01582AF */  sw         $v0, %gp_rel(Texture_gP4bitPmx)($gp)
    /* CFDE8 800DF5E8 CF94030C */  jal        reservememadr
    /* CFDEC 800DF5EC 10000624 */   addiu     $a2, $zero, 0x10
    /* CFDF0 800DF5F0 0580043C */  lui        $a0, %hi(D_80056A38)
    /* CFDF4 800DF5F4 386A8424 */  addiu      $a0, $a0, %lo(D_80056A38)
    /* CFDF8 800DF5F8 00080524 */  addiu      $a1, $zero, 0x800
    /* CFDFC 800DF5FC D41582AF */  sw         $v0, %gp_rel(Texture_gP8bitPmx)($gp)
    /* CFE00 800DF600 CF94030C */  jal        reservememadr
    /* CFE04 800DF604 10000624 */   addiu     $a2, $zero, 0x10
    /* CFE08 800DF608 0580043C */  lui        $a0, %hi(D_80056A44)
    /* CFE0C 800DF60C 446A8424 */  addiu      $a0, $a0, %lo(D_80056A44)
    /* CFE10 800DF610 00010524 */  addiu      $a1, $zero, 0x100
    /* CFE14 800DF614 D81582AF */  sw         $v0, %gp_rel(Texture_gPalette4bit)($gp)
    /* CFE18 800DF618 CF94030C */  jal        reservememadr
    /* CFE1C 800DF61C 10000624 */   addiu     $a2, $zero, 0x10
    /* CFE20 800DF620 1000BF8F */  lw         $ra, 0x10($sp)
    /* CFE24 800DF624 DC1582AF */  sw         $v0, %gp_rel(Texture_gPalette8bit)($gp)
    /* CFE28 800DF628 0800E003 */  jr         $ra
    /* CFE2C 800DF62C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_InitPaletteSharing__Fv
