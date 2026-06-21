.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrapHeight__FsPc, 0x4C

glabel FETextRender_WordWrapHeight__FsPc
    /* 120C8 800218C8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 120CC 800218CC F4010224 */  addiu      $v0, $zero, 0x1F4
    /* 120D0 800218D0 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* 120D4 800218D4 01000224 */  addiu      $v0, $zero, 0x1
    /* 120D8 800218D8 1C00A4A7 */  sh         $a0, 0x1C($sp)
    /* 120DC 800218DC 2120A000 */  addu       $a0, $a1, $zero
    /* 120E0 800218E0 1800A527 */  addiu      $a1, $sp, 0x18
    /* 120E4 800218E4 21300000 */  addu       $a2, $zero, $zero
    /* 120E8 800218E8 2138C000 */  addu       $a3, $a2, $zero
    /* 120EC 800218EC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 120F0 800218F0 1800A0A7 */  sh         $zero, 0x18($sp)
    /* 120F4 800218F4 1A00A0A7 */  sh         $zero, 0x1A($sp)
    /* 120F8 800218F8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 120FC 800218FC A984000C */  jal        FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
    /* 12100 80021900 1400A2AF */   sw        $v0, 0x14($sp)
    /* 12104 80021904 2000BF8F */  lw         $ra, 0x20($sp)
    /* 12108 80021908 00000000 */  nop
    /* 1210C 8002190C 0800E003 */  jr         $ra
    /* 12110 80021910 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FETextRender_WordWrapHeight__FsPc
