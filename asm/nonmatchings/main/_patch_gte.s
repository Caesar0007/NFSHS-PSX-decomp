.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _patch_gte, 0xAC

glabel _patch_gte
    /* F6C54 80106454 1580013C */  lui        $at, %hi(D_8014898C)
    /* F6C58 80106458 8C893FAC */  sw         $ra, %lo(D_8014898C)($at)
    /* F6C5C 8010645C 631A040C */  jal        EnterCriticalSection
    /* F6C60 80106460 00000000 */   nop
    /* F6C64 80106464 56000924 */  addiu      $t1, $zero, 0x56
    /* F6C68 80106468 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F6C6C 8010646C 09F84001 */  jalr       $t2
    /* F6C70 80106470 00000000 */   nop
    /* F6C74 80106474 1800428C */  lw         $v0, 0x18($v0)
    /* F6C78 80106478 00000000 */  nop
    /* F6C7C 8010647C 28004224 */  addiu      $v0, $v0, 0x28
    /* F6C80 80106480 21784000 */  addu       $t7, $v0, $zero
    /* F6C84 80106484 10800A3C */  lui        $t2, %hi(func_80106500)
    /* F6C88 80106488 00654A25 */  addiu      $t2, $t2, %lo(func_80106500)
    /* F6C8C 8010648C 1080093C */  lui        $t1, %hi(D_80106518)
    /* F6C90 80106490 18652925 */  addiu      $t1, $t1, %lo(D_80106518)
  .L80106494:
    /* F6C94 80106494 0000438D */  lw         $v1, 0x0($t2)
    /* F6C98 80106498 00004B8C */  lw         $t3, 0x0($v0)
    /* F6C9C 8010649C 04004A25 */  addiu      $t2, $t2, 0x4
    /* F6CA0 801064A0 0E006B14 */  bne        $v1, $t3, .L801064DC
    /* F6CA4 801064A4 04004224 */   addiu     $v0, $v0, 0x4
    /* F6CA8 801064A8 FAFF4915 */  bne        $t2, $t1, .L80106494
    /* F6CAC 801064AC 00000000 */   nop
    /* F6CB0 801064B0 2110E001 */  addu       $v0, $t7, $zero
    /* F6CB4 801064B4 10800A3C */  lui        $t2, %hi(D_80106518)
    /* F6CB8 801064B8 18654A25 */  addiu      $t2, $t2, %lo(D_80106518)
    /* F6CBC 801064BC 1080093C */  lui        $t1, %hi(D_80106530)
    /* F6CC0 801064C0 30652925 */  addiu      $t1, $t1, %lo(D_80106530)
  .L801064C4:
    /* F6CC4 801064C4 0000438D */  lw         $v1, 0x0($t2)
    /* F6CC8 801064C8 00000000 */  nop
    /* F6CCC 801064CC 000043AC */  sw         $v1, 0x0($v0)
    /* F6CD0 801064D0 04004A25 */  addiu      $t2, $t2, 0x4
    /* F6CD4 801064D4 FBFF4915 */  bne        $t2, $t1, .L801064C4
    /* F6CD8 801064D8 04004224 */   addiu     $v0, $v0, 0x4
  .L801064DC:
    /* F6CDC 801064DC F5D0030C */  jal        FlushCache
    /* F6CE0 801064E0 00000000 */   nop
    /* F6CE4 801064E4 5B1A040C */  jal        ExitCriticalSection
    /* F6CE8 801064E8 00000000 */   nop
    /* F6CEC 801064EC 15801F3C */  lui        $ra, %hi(D_8014898C)
    /* F6CF0 801064F0 8C89FF8F */  lw         $ra, %lo(D_8014898C)($ra)
    /* F6CF4 801064F4 00000000 */  nop
    /* F6CF8 801064F8 0800E003 */  jr         $ra
    /* F6CFC 801064FC 00000000 */   nop
endlabel _patch_gte
