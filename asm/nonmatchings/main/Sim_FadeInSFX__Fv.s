.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_FadeInSFX__Fv, 0x80

glabel Sim_FadeInSFX__Fv
    /* A6FF8 800B67F8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A6FFC 800B67FC B0E0448C */  lw         $a0, %lo(D_8011E0B0)($v0)
    /* A7000 800B6800 00000000 */  nop
    /* A7004 800B6804 08008014 */  bnez       $a0, .L800B6828
    /* A7008 800B6808 EFFF8224 */   addiu     $v0, $a0, -0x11
    /* A700C 800B680C 1480033C */  lui        $v1, %hi(gMasterSFXLevel)
    /* A7010 800B6810 54C6638C */  lw         $v1, %lo(gMasterSFXLevel)($v1)
    /* A7014 800B6814 1180023C */  lui        $v0, %hi(D_801132E0)
    /* A7018 800B6818 1480013C */  lui        $at, %hi(gMasterSFXLevel)
    /* A701C 800B681C 54C620AC */  sw         $zero, %lo(gMasterSFXLevel)($at)
    /* A7020 800B6820 0800E003 */  jr         $ra
    /* A7024 800B6824 E03243AC */   sw        $v1, %lo(D_801132E0)($v0)
  .L800B6828:
    /* A7028 800B6828 4000422C */  sltiu      $v0, $v0, 0x40
    /* A702C 800B682C 10004010 */  beqz       $v0, .L800B6870
    /* A7030 800B6830 1180023C */   lui       $v0, %hi(D_80117048)
    /* A7034 800B6834 4870428C */  lw         $v0, %lo(D_80117048)($v0)
    /* A7038 800B6838 00000000 */  nop
    /* A703C 800B683C 05004010 */  beqz       $v0, .L800B6854
    /* A7040 800B6840 1180023C */   lui       $v0, %hi(D_801132E0)
    /* A7044 800B6844 E032428C */  lw         $v0, %lo(D_801132E0)($v0)
    /* A7048 800B6848 F0FF8324 */  addiu      $v1, $a0, -0x10
    /* A704C 800B684C 17DA0208 */  j          .L800B685C
    /* A7050 800B6850 83100200 */   sra       $v0, $v0, 2
  .L800B6854:
    /* A7054 800B6854 E032438C */  lw         $v1, %lo(D_801132E0)($v0)
    /* A7058 800B6858 F0FF8224 */  addiu      $v0, $a0, -0x10
  .L800B685C:
    /* A705C 800B685C 18006200 */  mult       $v1, $v0
    /* A7060 800B6860 12280000 */  mflo       $a1
    /* A7064 800B6864 83110500 */  sra        $v0, $a1, 6
    /* A7068 800B6868 1480013C */  lui        $at, %hi(gMasterSFXLevel)
    /* A706C 800B686C 54C622AC */  sw         $v0, %lo(gMasterSFXLevel)($at)
  .L800B6870:
    /* A7070 800B6870 0800E003 */  jr         $ra
    /* A7074 800B6874 00000000 */   nop
endlabel Sim_FadeInSFX__Fv
