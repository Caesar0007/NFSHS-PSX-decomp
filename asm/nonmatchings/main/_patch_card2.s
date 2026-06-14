.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _patch_card2, 0x70

glabel _patch_card2
    /* FD2FC 8010CAFC 1580013C */  lui        $at, %hi(D_80148AC4)
    /* FD300 8010CB00 C48A3FAC */  sw         $ra, %lo(D_80148AC4)($at)
    /* FD304 8010CB04 631A040C */  jal        EnterCriticalSection
    /* FD308 8010CB08 00000000 */   nop
    /* FD30C 8010CB0C 57000924 */  addiu      $t1, $zero, 0x57
    /* FD310 8010CB10 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD314 8010CB14 09F84001 */  jalr       $t2
    /* FD318 8010CB18 00000000 */   nop
    /* FD31C 8010CB1C 6C01428C */  lw         $v0, 0x16C($v0)
    /* FD320 8010CB20 00000000 */  nop
    /* FD324 8010CB24 C809438C */  lw         $v1, 0x9C8($v0)
    /* FD328 8010CB28 11800A3C */  lui        $t2, %hi(func_8010CA40 + 0x14)
    /* FD32C 8010CB2C 54CA4A25 */  addiu      $t2, $t2, %lo(func_8010CA40 + 0x14)
    /* FD330 8010CB30 1180093C */  lui        $t1, %hi(_patch_card)
    /* FD334 8010CB34 68CA2925 */  addiu      $t1, $t1, %lo(_patch_card)
  .L8010CB38:
    /* FD338 8010CB38 0000488D */  lw         $t0, 0x0($t2)
    /* FD33C 8010CB3C 00000000 */  nop
    /* FD340 8010CB40 C80948AC */  sw         $t0, 0x9C8($v0)
    /* FD344 8010CB44 04004A25 */  addiu      $t2, $t2, 0x4
    /* FD348 8010CB48 FBFF4915 */  bne        $t2, $t1, .L8010CB38
    /* FD34C 8010CB4C 04004224 */   addiu     $v0, $v0, 0x4
    /* FD350 8010CB50 F5D0030C */  jal        FlushCache
    /* FD354 8010CB54 00000000 */   nop
    /* FD358 8010CB58 15801F3C */  lui        $ra, %hi(D_80148AC4)
    /* FD35C 8010CB5C C48AFF8F */  lw         $ra, %lo(D_80148AC4)($ra)
    /* FD360 8010CB60 00000000 */  nop
    /* FD364 8010CB64 0800E003 */  jr         $ra
    /* FD368 8010CB68 00000000 */   nop
endlabel _patch_card2
