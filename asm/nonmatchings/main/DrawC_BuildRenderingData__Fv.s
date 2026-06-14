.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_BuildRenderingData__Fv, 0x30

glabel DrawC_BuildRenderingData__Fv
    /* AF118 800BE918 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AF11C 800BE91C 1000BFAF */  sw         $ra, 0x10($sp)
    /* AF120 800BE920 BCF9020C */  jal        DrawC_ReadLightingData__Fv
    /* AF124 800BE924 00000000 */   nop
    /* AF128 800BE928 3EFA020C */  jal        DrawC_ReadeMapData__Fv
    /* AF12C 800BE92C 00000000 */   nop
    /* AF130 800BE930 9AB9020C */  jal        R3DCcar_ReadTrackShadow__Fv
    /* AF134 800BE934 00000000 */   nop
    /* AF138 800BE938 1000BF8F */  lw         $ra, 0x10($sp)
    /* AF13C 800BE93C 00000000 */  nop
    /* AF140 800BE940 0800E003 */  jr         $ra
    /* AF144 800BE944 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawC_BuildRenderingData__Fv
