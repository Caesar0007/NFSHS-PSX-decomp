.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16, 0x160

glabel DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
    /* BA8A4 800CA0A4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BA8A8 800CA0A8 21C8A000 */  addu       $t9, $a1, $zero
    /* BA8AC 800CA0AC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BA8B0 800CA0B0 2198C000 */  addu       $s3, $a2, $zero
    /* BA8B4 800CA0B4 1280023C */  lui        $v0, %hi(gVertex3d)
    /* BA8B8 800CA0B8 60F74B24 */  addiu      $t3, $v0, %lo(gVertex3d)
    /* BA8BC 800CA0BC 04002C27 */  addiu      $t4, $t9, 0x4
    /* BA8C0 800CA0C0 21680000 */  addu       $t5, $zero, $zero
    /* BA8C4 800CA0C4 06006A25 */  addiu      $t2, $t3, 0x6
    /* BA8C8 800CA0C8 2000BFAF */  sw         $ra, 0x20($sp)
    /* BA8CC 800CA0CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* BA8D0 800CA0D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* BA8D4 800CA0D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* BA8D8 800CA0D8 68009284 */  lh         $s2, 0x68($a0)
    /* BA8DC 800CA0DC 0000F894 */  lhu        $t8, 0x0($a3)
    /* BA8E0 800CA0E0 0200EF94 */  lhu        $t7, 0x2($a3)
    /* BA8E4 800CA0E4 0400EE94 */  lhu        $t6, 0x4($a3)
    /* BA8E8 800CA0E8 6C00828C */  lw         $v0, 0x6C($a0)
    /* BA8EC 800CA0EC 1480113C */  lui        $s1, %hi(BWorldSm_slices)
    /* BA8F0 800CA0F0 C0C7318E */  lw         $s1, %lo(BWorldSm_slices)($s1)
    /* BA8F4 800CA0F4 04005024 */  addiu      $s0, $v0, 0x4
  .L800CA0F8:
    /* BA8F8 800CA0F8 0000228F */  lw         $v0, 0x0($t9)
    /* BA8FC 800CA0FC 00000000 */  nop
    /* BA900 800CA100 40100200 */  sll        $v0, $v0, 1
    /* BA904 800CA104 2A10A201 */  slt        $v0, $t5, $v0
    /* BA908 800CA108 31004010 */  beqz       $v0, .L800CA1D0
    /* BA90C 800CA10C 0200AD25 */   addiu     $t5, $t5, 0x2
    /* BA910 800CA110 00008691 */  lbu        $a2, 0x0($t4)
    /* BA914 800CA114 01008291 */  lbu        $v0, 0x1($t4)
    /* BA918 800CA118 04008C25 */  addiu      $t4, $t4, 0x4
    /* BA91C 800CA11C 21104202 */  addu       $v0, $s2, $v0
    /* BA920 800CA120 40110200 */  sll        $v0, $v0, 5
    /* BA924 800CA124 21105100 */  addu       $v0, $v0, $s1
    /* BA928 800CA128 12004890 */  lbu        $t0, 0x12($v0)
    /* BA92C 800CA12C 12004224 */  addiu      $v0, $v0, 0x12
    /* BA930 800CA130 C0300600 */  sll        $a2, $a2, 3
    /* BA934 800CA134 21300602 */  addu       $a2, $s0, $a2
    /* BA938 800CA138 01004990 */  lbu        $t1, 0x1($v0)
    /* BA93C 800CA13C 02004790 */  lbu        $a3, 0x2($v0)
    /* BA940 800CA140 0000C394 */  lhu        $v1, 0x0($a2)
    /* BA944 800CA144 0200C494 */  lhu        $a0, 0x2($a2)
    /* BA948 800CA148 0400C594 */  lhu        $a1, 0x4($a2)
    /* BA94C 800CA14C 00460800 */  sll        $t0, $t0, 24
    /* BA950 800CA150 C3460800 */  sra        $t0, $t0, 27
    /* BA954 800CA154 004E0900 */  sll        $t1, $t1, 24
    /* BA958 800CA158 C34E0900 */  sra        $t1, $t1, 27
    /* BA95C 800CA15C 003E0700 */  sll        $a3, $a3, 24
    /* BA960 800CA160 C33E0700 */  sra        $a3, $a3, 27
    /* BA964 800CA164 23106800 */  subu       $v0, $v1, $t0
    /* BA968 800CA168 21100203 */  addu       $v0, $t8, $v0
    /* BA96C 800CA16C 000062A5 */  sh         $v0, 0x0($t3)
    /* BA970 800CA170 23108900 */  subu       $v0, $a0, $t1
    /* BA974 800CA174 2110E201 */  addu       $v0, $t7, $v0
    /* BA978 800CA178 FCFF42A5 */  sh         $v0, -0x4($t2)
    /* BA97C 800CA17C 2310A700 */  subu       $v0, $a1, $a3
    /* BA980 800CA180 2110C201 */  addu       $v0, $t6, $v0
    /* BA984 800CA184 08006B25 */  addiu      $t3, $t3, 0x8
    /* BA988 800CA188 21186800 */  addu       $v1, $v1, $t0
    /* BA98C 800CA18C 21180303 */  addu       $v1, $t8, $v1
    /* BA990 800CA190 21208900 */  addu       $a0, $a0, $t1
    /* BA994 800CA194 2120E401 */  addu       $a0, $t7, $a0
    /* BA998 800CA198 2128A700 */  addu       $a1, $a1, $a3
    /* BA99C 800CA19C FEFF42A5 */  sh         $v0, -0x2($t2)
    /* BA9A0 800CA1A0 0600C294 */  lhu        $v0, 0x6($a2)
    /* BA9A4 800CA1A4 2128C501 */  addu       $a1, $t6, $a1
    /* BA9A8 800CA1A8 000042A5 */  sh         $v0, 0x0($t2)
    /* BA9AC 800CA1AC 08004A25 */  addiu      $t2, $t2, 0x8
    /* BA9B0 800CA1B0 000063A5 */  sh         $v1, 0x0($t3)
    /* BA9B4 800CA1B4 FCFF44A5 */  sh         $a0, -0x4($t2)
    /* BA9B8 800CA1B8 FEFF45A5 */  sh         $a1, -0x2($t2)
    /* BA9BC 800CA1BC 0600C294 */  lhu        $v0, 0x6($a2)
    /* BA9C0 800CA1C0 08006B25 */  addiu      $t3, $t3, 0x8
    /* BA9C4 800CA1C4 000042A5 */  sh         $v0, 0x0($t2)
    /* BA9C8 800CA1C8 3E280308 */  j          .L800CA0F8
    /* BA9CC 800CA1CC 08004A25 */   addiu     $t2, $t2, 0x8
  .L800CA1D0:
    /* BA9D0 800CA1D0 1280043C */  lui        $a0, %hi(gVertex3d)
    /* BA9D4 800CA1D4 60F78424 */  addiu      $a0, $a0, %lo(gVertex3d)
    /* BA9D8 800CA1D8 04002527 */  addiu      $a1, $t9, 0x4
    /* BA9DC 800CA1DC 0000268F */  lw         $a2, 0x0($t9)
    /* BA9E0 800CA1E0 2E26030C */  jal        DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
    /* BA9E4 800CA1E4 21386002 */   addu      $a3, $s3, $zero
    /* BA9E8 800CA1E8 2000BF8F */  lw         $ra, 0x20($sp)
    /* BA9EC 800CA1EC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* BA9F0 800CA1F0 1800B28F */  lw         $s2, 0x18($sp)
    /* BA9F4 800CA1F4 1400B18F */  lw         $s1, 0x14($sp)
    /* BA9F8 800CA1F8 1000B08F */  lw         $s0, 0x10($sp)
    /* BA9FC 800CA1FC 0800E003 */  jr         $ra
    /* BAA00 800CA200 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
