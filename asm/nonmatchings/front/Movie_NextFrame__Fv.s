.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_NextFrame__Fv, 0x134

glabel Movie_NextFrame__Fv
    /* 3D330 8004CB30 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3D334 8004CB34 0580023C */  lui        $v0, %hi(D_80052D28)
    /* 3D338 8004CB38 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3D33C 8004CB3C 282D5024 */  addiu      $s0, $v0, %lo(D_80052D28)
    /* 3D340 8004CB40 0580033C */  lui        $v1, %hi(D_80052D00)
    /* 3D344 8004CB44 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3D348 8004CB48 0800028E */  lw         $v0, 0x8($s0)
    /* 3D34C 8004CB4C 002D6584 */  lh         $a1, %lo(D_80052D00)($v1)
    /* 3D350 8004CB50 80100200 */  sll        $v0, $v0, 2
    /* 3D354 8004CB54 21105000 */  addu       $v0, $v0, $s0
    /* 3D358 8004CB58 0000448C */  lw         $a0, 0x0($v0)
    /* 3D35C 8004CB5C 7FE2030C */  jal        DecDCTin
    /* 3D360 8004CB60 00000000 */   nop
    /* 3D364 8004CB64 A6E2030C */  jal        DecDCTinSync
    /* 3D368 8004CB68 01000424 */   addiu     $a0, $zero, 0x1
    /* 3D36C 8004CB6C 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3D370 8004CB70 0580043C */  lui        $a0, %hi(D_80052CFE)
    /* 3D374 8004CB74 FC2C4384 */  lh         $v1, %lo(D_80052CFC)($v0)
    /* 3D378 8004CB78 FE2C8284 */  lh         $v0, %lo(D_80052CFE)($a0)
    /* 3D37C 8004CB7C 00190300 */  sll        $v1, $v1, 4
    /* 3D380 8004CB80 1A006200 */  div        $zero, $v1, $v0
    /* 3D384 8004CB84 02004014 */  bnez       $v0, .L8004CB90
    /* 3D388 8004CB88 00000000 */   nop
    /* 3D38C 8004CB8C 0D000700 */  break      7
  .L8004CB90:
    /* 3D390 8004CB90 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D394 8004CB94 04004114 */  bne        $v0, $at, .L8004CBA8
    /* 3D398 8004CB98 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D39C 8004CB9C 02006114 */  bne        $v1, $at, .L8004CBA8
    /* 3D3A0 8004CBA0 00000000 */   nop
    /* 3D3A4 8004CBA4 0D000600 */  break      6
  .L8004CBA8:
    /* 3D3A8 8004CBA8 12180000 */  mflo       $v1
    /* 3D3AC 8004CBAC 28000286 */  lh         $v0, 0x28($s0)
    /* 3D3B0 8004CBB0 00000000 */  nop
    /* 3D3B4 8004CBB4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 3D3B8 8004CBB8 1A004300 */  div        $zero, $v0, $v1
    /* 3D3BC 8004CBBC 02006014 */  bnez       $v1, .L8004CBC8
    /* 3D3C0 8004CBC0 00000000 */   nop
    /* 3D3C4 8004CBC4 0D000700 */  break      7
  .L8004CBC8:
    /* 3D3C8 8004CBC8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D3CC 8004CBCC 04006114 */  bne        $v1, $at, .L8004CBE0
    /* 3D3D0 8004CBD0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D3D4 8004CBD4 02004114 */  bne        $v0, $at, .L8004CBE0
    /* 3D3D8 8004CBD8 00000000 */   nop
    /* 3D3DC 8004CBDC 0D000600 */  break      6
  .L8004CBE0:
    /* 3D3E0 8004CBE0 12100000 */  mflo       $v0
    /* 3D3E4 8004CBE4 00000000 */  nop
    /* 3D3E8 8004CBE8 01004224 */  addiu      $v0, $v0, 0x1
    /* 3D3EC 8004CBEC 18004300 */  mult       $v0, $v1
    /* 3D3F0 8004CBF0 2A000386 */  lh         $v1, 0x2A($s0)
    /* 3D3F4 8004CBF4 00000000 */  nop
    /* 3D3F8 8004CBF8 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 3D3FC 8004CBFC 12380000 */  mflo       $a3
    /* 3D400 8004CC00 02004104 */  bgez       $v0, .L8004CC0C
    /* 3D404 8004CC04 00290700 */   sll       $a1, $a3, 4
    /* 3D408 8004CC08 0E006224 */  addiu      $v0, $v1, 0xE
  .L8004CC0C:
    /* 3D40C 8004CC0C 03110200 */  sra        $v0, $v0, 4
    /* 3D410 8004CC10 01004224 */  addiu      $v0, $v0, 0x1
    /* 3D414 8004CC14 1800A200 */  mult       $a1, $v0
    /* 3D418 8004CC18 0C00048E */  lw         $a0, 0xC($s0)
    /* 3D41C 8004CC1C 12300000 */  mflo       $a2
    /* 3D420 8004CC20 9EE2030C */  jal        DecDCTout
    /* 3D424 8004CC24 43280600 */   sra       $a1, $a2, 1
    /* 3D428 8004CC28 CD34010C */  jal        func_8004D334
    /* 3D42C 8004CC2C 21200002 */   addu      $a0, $s0, $zero
    /* 3D430 8004CC30 07004004 */  bltz       $v0, .L8004CC50
    /* 3D434 8004CC34 21200002 */   addu      $a0, $s0, $zero
    /* 3D438 8004CC38 7735010C */  jal        func_8004D5DC
    /* 3D43C 8004CC3C 21280000 */   addu      $a1, $zero, $zero
    /* 3D440 8004CC40 C7C8030C */  jal        VSync
    /* 3D444 8004CC44 21200000 */   addu      $a0, $zero, $zero
    /* 3D448 8004CC48 15330108 */  j          .L8004CC54
    /* 3D44C 8004CC4C 21100000 */   addu      $v0, $zero, $zero
  .L8004CC50:
    /* 3D450 8004CC50 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8004CC54:
    /* 3D454 8004CC54 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3D458 8004CC58 1800B08F */  lw         $s0, 0x18($sp)
    /* 3D45C 8004CC5C 0800E003 */  jr         $ra
    /* 3D460 8004CC60 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Movie_NextFrame__Fv
