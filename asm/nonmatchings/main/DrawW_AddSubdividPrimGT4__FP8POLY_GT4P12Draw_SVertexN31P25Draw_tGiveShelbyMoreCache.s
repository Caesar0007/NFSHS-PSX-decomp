.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache, 0x8C

glabel DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
    /* B5828 800C5028 1000AA8F */  lw         $t2, 0x10($sp)
    /* B582C 800C502C 1400AB8F */  lw         $t3, 0x14($sp)
    /* B5830 800C5030 0C000224 */  addiu      $v0, $zero, 0xC
    /* B5834 800C5034 030082A0 */  sb         $v0, 0x3($a0)
    /* B5838 800C5038 0C00A28C */  lw         $v0, 0xC($a1)
    /* B583C 800C503C 0C00C38C */  lw         $v1, 0xC($a2)
    /* B5840 800C5040 0C00E88C */  lw         $t0, 0xC($a3)
    /* B5844 800C5044 0C00498D */  lw         $t1, 0xC($t2)
    /* B5848 800C5048 040082AC */  sw         $v0, 0x4($a0)
    /* B584C 800C504C 100083AC */  sw         $v1, 0x10($a0)
    /* B5850 800C5050 280088AC */  sw         $t0, 0x28($a0)
    /* B5854 800C5054 1C0089AC */  sw         $t1, 0x1C($a0)
    /* B5858 800C5058 0800A28C */  lw         $v0, 0x8($a1)
    /* B585C 800C505C 0800C38C */  lw         $v1, 0x8($a2)
    /* B5860 800C5060 0800E88C */  lw         $t0, 0x8($a3)
    /* B5864 800C5064 0800498D */  lw         $t1, 0x8($t2)
    /* B5868 800C5068 080082AC */  sw         $v0, 0x8($a0)
    /* B586C 800C506C 140083AC */  sw         $v1, 0x14($a0)
    /* B5870 800C5070 2C0088AC */  sw         $t0, 0x2C($a0)
    /* B5874 800C5074 200089AC */  sw         $t1, 0x20($a0)
    /* B5878 800C5078 0600A294 */  lhu        $v0, 0x6($a1)
    /* B587C 800C507C 0600C394 */  lhu        $v1, 0x6($a2)
    /* B5880 800C5080 0600E594 */  lhu        $a1, 0x6($a3)
    /* B5884 800C5084 06004695 */  lhu        $a2, 0x6($t2)
    /* B5888 800C5088 0C0082A4 */  sh         $v0, 0xC($a0)
    /* B588C 800C508C 180083A4 */  sh         $v1, 0x18($a0)
    /* B5890 800C5090 300085A4 */  sh         $a1, 0x30($a0)
    /* B5894 800C5094 240086A4 */  sh         $a2, 0x24($a0)
    /* B5898 800C5098 17016291 */  lbu        $v0, 0x117($t3)
    /* B589C 800C509C 2A016395 */  lhu        $v1, 0x12A($t3)
    /* B58A0 800C50A0 1E016595 */  lhu        $a1, 0x11E($t3)
    /* B58A4 800C50A4 070082A0 */  sb         $v0, 0x7($a0)
    /* B58A8 800C50A8 1A0083A4 */  sh         $v1, 0x1A($a0)
    /* B58AC 800C50AC 0800E003 */  jr         $ra
    /* B58B0 800C50B0 0E0085A4 */   sh        $a1, 0xE($a0)
endlabel DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
