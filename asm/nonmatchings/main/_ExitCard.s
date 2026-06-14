.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _ExitCard, 0x70

glabel _ExitCard
    /* FD3C0 8010CBC0 1580013C */  lui        $at, %hi(D_80148AD4)
    /* FD3C4 8010CBC4 D48A3FAC */  sw         $ra, %lo(D_80148AD4)($at)
    /* FD3C8 8010CBC8 631A040C */  jal        EnterCriticalSection
    /* FD3CC 8010CBCC 00000000 */   nop
    /* FD3D0 8010CBD0 56000924 */  addiu      $t1, $zero, 0x56
    /* FD3D4 8010CBD4 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD3D8 8010CBD8 09F84001 */  jalr       $t2
    /* FD3DC 8010CBDC 00000000 */   nop
    /* FD3E0 8010CBE0 1800428C */  lw         $v0, 0x18($v0)
    /* FD3E4 8010CBE4 11800A3C */  lui        $t2, %hi(D_8010CC30)
    /* FD3E8 8010CBE8 30CC4A25 */  addiu      $t2, $t2, %lo(D_8010CC30)
    /* FD3EC 8010CBEC 1180093C */  lui        $t1, %hi(D_8010CC3C)
    /* FD3F0 8010CBF0 3CCC2925 */  addiu      $t1, $t1, %lo(D_8010CC3C)
  .L8010CBF4:
    /* FD3F4 8010CBF4 0000438D */  lw         $v1, 0x0($t2)
    /* FD3F8 8010CBF8 00000000 */  nop
    /* FD3FC 8010CBFC 700043AC */  sw         $v1, 0x70($v0)
    /* FD400 8010CC00 04004A25 */  addiu      $t2, $t2, 0x4
    /* FD404 8010CC04 FBFF4915 */  bne        $t2, $t1, .L8010CBF4
    /* FD408 8010CC08 04004224 */   addiu     $v0, $v0, 0x4
    /* FD40C 8010CC0C F5D0030C */  jal        FlushCache
    /* FD410 8010CC10 00000000 */   nop
    /* FD414 8010CC14 5B1A040C */  jal        ExitCriticalSection
    /* FD418 8010CC18 00000000 */   nop
    /* FD41C 8010CC1C 15801F3C */  lui        $ra, %hi(D_80148AD4)
    /* FD420 8010CC20 D48AFF8F */  lw         $ra, %lo(D_80148AD4)($ra)
    /* FD424 8010CC24 00000000 */  nop
    /* FD428 8010CC28 0800E003 */  jr         $ra
    /* FD42C 8010CC2C 00000000 */   nop
endlabel _ExitCard
  alabel D_8010CC30
    /* FD430 8010CC30 00000000 */  nop
    /* FD434 8010CC34 00000000 */  nop
    /* FD438 8010CC38 00000000 */  nop
  alabel D_8010CC3C
    /* FD43C 8010CC3C 00000000 */  nop
