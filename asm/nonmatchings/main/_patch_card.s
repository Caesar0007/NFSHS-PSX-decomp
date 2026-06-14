.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _patch_card, 0x94

glabel _patch_card
    /* FD268 8010CA68 1580013C */  lui        $at, %hi(D_80148AC4)
    /* FD26C 8010CA6C C48A3FAC */  sw         $ra, %lo(D_80148AC4)($at)
    /* FD270 8010CA70 631A040C */  jal        EnterCriticalSection
    /* FD274 8010CA74 00000000 */   nop
    /* FD278 8010CA78 56000924 */  addiu      $t1, $zero, 0x56
    /* FD27C 8010CA7C B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD280 8010CA80 09F84001 */  jalr       $t2
    /* FD284 8010CA84 00000000 */   nop
    /* FD288 8010CA88 1800428C */  lw         $v0, 0x18($v0)
    /* FD28C 8010CA8C 00000000 */  nop
    /* FD290 8010CA90 7000438C */  lw         $v1, 0x70($v0)
    /* FD294 8010CA94 00000000 */  nop
    /* FD298 8010CA98 FFFF6930 */  andi       $t1, $v1, 0xFFFF
    /* FD29C 8010CA9C 004C0900 */  sll        $t1, $t1, 16
    /* FD2A0 8010CAA0 7400438C */  lw         $v1, 0x74($v0)
    /* FD2A4 8010CAA4 00000000 */  nop
    /* FD2A8 8010CAA8 FFFF6A30 */  andi       $t2, $v1, 0xFFFF
    /* FD2AC 8010CAAC 21182A01 */  addu       $v1, $t1, $t2
    /* FD2B0 8010CAB0 28006224 */  addiu      $v0, $v1, 0x28
    /* FD2B4 8010CAB4 11800A3C */  lui        $t2, %hi(func_8010CA40)
    /* FD2B8 8010CAB8 40CA4A25 */  addiu      $t2, $t2, %lo(func_8010CA40)
    /* FD2BC 8010CABC 1180093C */  lui        $t1, %hi(func_8010CA40 + 0x14)
    /* FD2C0 8010CAC0 54CA2925 */  addiu      $t1, $t1, %lo(func_8010CA40 + 0x14)
  .L8010CAC4:
    /* FD2C4 8010CAC4 0000438D */  lw         $v1, 0x0($t2)
    /* FD2C8 8010CAC8 00000000 */  nop
    /* FD2CC 8010CACC 000043AC */  sw         $v1, 0x0($v0)
    /* FD2D0 8010CAD0 04004A25 */  addiu      $t2, $t2, 0x4
    /* FD2D4 8010CAD4 FBFF4915 */  bne        $t2, $t1, .L8010CAC4
    /* FD2D8 8010CAD8 04004224 */   addiu     $v0, $v0, 0x4
    /* FD2DC 8010CADC 0100013C */  lui        $at, (0x10000 >> 16)
    /* FD2E0 8010CAE0 F5D0030C */  jal        FlushCache
    /* FD2E4 8010CAE4 FCDF22AC */   sw        $v0, -0x2004($at)
    /* FD2E8 8010CAE8 15801F3C */  lui        $ra, %hi(D_80148AC4)
    /* FD2EC 8010CAEC C48AFF8F */  lw         $ra, %lo(D_80148AC4)($ra)
    /* FD2F0 8010CAF0 00000000 */  nop
    /* FD2F4 8010CAF4 0800E003 */  jr         $ra
    /* FD2F8 8010CAF8 00000000 */   nop
endlabel _patch_card
