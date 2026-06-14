.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StUnSetRing, 0x80

glabel StUnSetRing
    /* E96C8 800F8EC8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E96CC 800F8ECC 1000BFAF */  sw         $ra, 0x10($sp)
    /* E96D0 800F8ED0 631A040C */  jal        EnterCriticalSection
    /* E96D4 800F8ED4 00000000 */   nop
    /* E96D8 800F8ED8 1480033C */  lui        $v1, %hi(DS_active)
    /* E96DC 800F8EDC 68BF638C */  lw         $v1, %lo(DS_active)($v1)
    /* E96E0 800F8EE0 01000224 */  addiu      $v0, $zero, 0x1
    /* E96E4 800F8EE4 07006214 */  bne        $v1, $v0, .L800F8F04
    /* E96E8 800F8EE8 00000000 */   nop
    /* E96EC 800F8EEC 0E22040C */  jal        DsDataCallback
    /* E96F0 800F8EF0 21200000 */   addu      $a0, $zero, $zero
    /* E96F4 800F8EF4 0922040C */  jal        DsReadyCallback
    /* E96F8 800F8EF8 21200000 */   addu      $a0, $zero, $zero
    /* E96FC 800F8EFC C5E30308 */  j          .L800F8F14
    /* E9700 800F8F00 00000000 */   nop
  .L800F8F04:
    /* E9704 800F8F04 2CDF030C */  jal        CdDataCallback
    /* E9708 800F8F08 21200000 */   addu      $a0, $zero, $zero
    /* E970C 800F8F0C 28DE030C */  jal        CdReadyCallback
    /* E9710 800F8F10 21200000 */   addu      $a0, $zero, $zero
  .L800F8F14:
    /* E9714 800F8F14 1380023C */  lui        $v0, %hi(D_80136C48)
    /* E9718 800F8F18 486C428C */  lw         $v0, %lo(D_80136C48)($v0)
    /* E971C 800F8F1C 00000000 */  nop
    /* E9720 800F8F20 000040A0 */  sb         $zero, 0x0($v0)
    /* E9724 800F8F24 1380023C */  lui        $v0, %hi(D_80136C54)
    /* E9728 800F8F28 546C428C */  lw         $v0, %lo(D_80136C54)($v0)
    /* E972C 800F8F2C 00000000 */  nop
    /* E9730 800F8F30 5B1A040C */  jal        ExitCriticalSection
    /* E9734 800F8F34 000040A0 */   sb        $zero, 0x0($v0)
    /* E9738 800F8F38 1000BF8F */  lw         $ra, 0x10($sp)
    /* E973C 800F8F3C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E9740 800F8F40 0800E003 */  jr         $ra
    /* E9744 800F8F44 00000000 */   nop
endlabel StUnSetRing
