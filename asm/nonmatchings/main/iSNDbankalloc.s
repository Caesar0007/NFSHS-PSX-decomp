.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDbankalloc, 0x54

glabel iSNDbankalloc
    /* F2FBC 801027BC 1480023C */  lui        $v0, %hi(sndgs)
    /* F2FC0 801027C0 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* F2FC4 801027C4 0C004494 */  lhu        $a0, 0xC($v0)
    /* F2FC8 801027C8 00000000 */  nop
    /* F2FCC 801027CC 0C008010 */  beqz       $a0, .L80102800
    /* F2FD0 801027D0 21180000 */   addu      $v1, $zero, $zero
    /* F2FD4 801027D4 21288000 */  addu       $a1, $a0, $zero
    /* F2FD8 801027D8 9800448C */  lw         $a0, 0x98($v0)
  .L801027DC:
    /* F2FDC 801027DC 00000000 */  nop
    /* F2FE0 801027E0 0000828C */  lw         $v0, 0x0($a0)
    /* F2FE4 801027E4 00000000 */  nop
    /* F2FE8 801027E8 07004010 */  beqz       $v0, .L80102808
    /* F2FEC 801027EC 21106000 */   addu      $v0, $v1, $zero
    /* F2FF0 801027F0 01006324 */  addiu      $v1, $v1, 0x1
    /* F2FF4 801027F4 2A106500 */  slt        $v0, $v1, $a1
    /* F2FF8 801027F8 F8FF4014 */  bnez       $v0, .L801027DC
    /* F2FFC 801027FC 0C008424 */   addiu     $a0, $a0, 0xC
  .L80102800:
    /* F3000 80102800 0800E003 */  jr         $ra
    /* F3004 80102804 F7FF0224 */   addiu     $v0, $zero, -0x9
  .L80102808:
    /* F3008 80102808 0800E003 */  jr         $ra
    /* F300C 8010280C 00000000 */   nop
endlabel iSNDbankalloc
