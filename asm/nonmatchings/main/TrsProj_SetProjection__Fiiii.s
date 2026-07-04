.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetProjection__Fiiii, 0x80

glabel TrsProj_SetProjection__Fiiii
    /* D2148 800E1948 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D214C 800E194C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D2150 800E1950 21988000 */  addu       $s3, $a0, $zero
    /* D2154 800E1954 1480043C */  lui        $a0, %hi(Camera_gGeomScreen)
    /* D2158 800E1958 DCC7848C */  lw         $a0, %lo(Camera_gGeomScreen)($a0)
    /* D215C 800E195C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D2160 800E1960 2190A000 */  addu       $s2, $a1, $zero
    /* D2164 800E1964 1000B0AF */  sw         $s0, 0x10($sp)
    /* D2168 800E1968 2180C000 */  addu       $s0, $a2, $zero
    /* D216C 800E196C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D2170 800E1970 2000BFAF */  sw         $ra, 0x20($sp)
    /* D2174 800E1974 E7AA030C */  jal        SetGeomScreen
    /* D2178 800E1978 2188E000 */   addu      $s1, $a3, $zero
    /* D217C 800E197C C2171000 */  srl        $v0, $s0, 31
    /* D2180 800E1980 21800202 */  addu       $s0, $s0, $v0
    /* D2184 800E1984 43801000 */  sra        $s0, $s0, 1
    /* D2188 800E1988 21987002 */  addu       $s3, $s3, $s0
    /* D218C 800E198C C2171100 */  srl        $v0, $s1, 31
    /* D2190 800E1990 21882202 */  addu       $s1, $s1, $v0
    /* D2194 800E1994 43881100 */  sra        $s1, $s1, 1
    /* D2198 800E1998 21905102 */  addu       $s2, $s2, $s1
    /* D219C 800E199C 00641300 */  sll        $t4, $s3, 16
    /* D21A0 800E19A0 006C1200 */  sll        $t5, $s2, 16
    /* D21A4 800E19A4 00C0CC48 */  ctc2       $t4, $24 /* handwritten instruction */
    /* D21A8 800E19A8 00C8CD48 */  ctc2       $t5, $25 /* handwritten instruction */
    /* D21AC 800E19AC 2000BF8F */  lw         $ra, 0x20($sp)
    /* D21B0 800E19B0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D21B4 800E19B4 1800B28F */  lw         $s2, 0x18($sp)
    /* D21B8 800E19B8 1400B18F */  lw         $s1, 0x14($sp)
    /* D21BC 800E19BC 1000B08F */  lw         $s0, 0x10($sp)
    /* D21C0 800E19C0 0800E003 */  jr         $ra
    /* D21C4 800E19C4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel TrsProj_SetProjection__Fiiii
