.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache, 0x70

glabel DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
    /* B58B4 800C50B4 1000A98F */  lw         $t1, 0x10($sp)
    /* B58B8 800C50B8 09000224 */  addiu      $v0, $zero, 0x9
    /* B58BC 800C50BC 030082A0 */  sb         $v0, 0x3($a0)
    /* B58C0 800C50C0 0C00A28C */  lw         $v0, 0xC($a1)
    /* B58C4 800C50C4 0C00C38C */  lw         $v1, 0xC($a2)
    /* B58C8 800C50C8 0C00E88C */  lw         $t0, 0xC($a3)
    /* B58CC 800C50CC 040082AC */  sw         $v0, 0x4($a0)
    /* B58D0 800C50D0 100083AC */  sw         $v1, 0x10($a0)
    /* B58D4 800C50D4 1C0088AC */  sw         $t0, 0x1C($a0)
    /* B58D8 800C50D8 0800A28C */  lw         $v0, 0x8($a1)
    /* B58DC 800C50DC 0800C38C */  lw         $v1, 0x8($a2)
    /* B58E0 800C50E0 0800E88C */  lw         $t0, 0x8($a3)
    /* B58E4 800C50E4 080082AC */  sw         $v0, 0x8($a0)
    /* B58E8 800C50E8 140083AC */  sw         $v1, 0x14($a0)
    /* B58EC 800C50EC 200088AC */  sw         $t0, 0x20($a0)
    /* B58F0 800C50F0 0600A294 */  lhu        $v0, 0x6($a1)
    /* B58F4 800C50F4 0600C394 */  lhu        $v1, 0x6($a2)
    /* B58F8 800C50F8 0600E594 */  lhu        $a1, 0x6($a3)
    /* B58FC 800C50FC 0C0082A4 */  sh         $v0, 0xC($a0)
    /* B5900 800C5100 180083A4 */  sh         $v1, 0x18($a0)
    /* B5904 800C5104 240085A4 */  sh         $a1, 0x24($a0)
    /* B5908 800C5108 17012291 */  lbu        $v0, 0x117($t1)
    /* B590C 800C510C 2A012395 */  lhu        $v1, 0x12A($t1)
    /* B5910 800C5110 1E012595 */  lhu        $a1, 0x11E($t1)
    /* B5914 800C5114 070082A0 */  sb         $v0, 0x7($a0)
    /* B5918 800C5118 1A0083A4 */  sh         $v1, 0x1A($a0)
    /* B591C 800C511C 0800E003 */  jr         $ra
    /* B5920 800C5120 0E0085A4 */   sh        $a1, 0xE($a0)
endlabel DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
