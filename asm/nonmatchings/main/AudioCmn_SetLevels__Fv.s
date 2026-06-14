.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_SetLevels__Fv, 0x50

glabel AudioCmn_SetLevels__Fv
    /* 6781C 8007701C 1180023C */  lui        $v0, %hi(D_80117048)
    /* 67820 80077020 4870428C */  lw         $v0, %lo(D_80117048)($v0)
    /* 67824 80077024 00000000 */  nop
    /* 67828 80077028 0E004010 */  beqz       $v0, .L80077064
    /* 6782C 8007702C 0281043C */   lui       $a0, (0x81020409 >> 16)
    /* 67830 80077030 1180023C */  lui        $v0, %hi(D_801132E0)
    /* 67834 80077034 E032438C */  lw         $v1, %lo(D_801132E0)($v0)
    /* 67838 80077038 09048434 */  ori        $a0, $a0, (0x81020409 & 0xFFFF)
    /* 6783C 8007703C 80190300 */  sll        $v1, $v1, 6
    /* 67840 80077040 18006400 */  mult       $v1, $a0
    /* 67844 80077044 20000224 */  addiu      $v0, $zero, 0x20
    /* 67848 80077048 900182AF */  sw         $v0, %gp_rel(AudioCmn_gLastFade)($gp)
    /* 6784C 8007704C 10280000 */  mfhi       $a1
    /* 67850 80077050 2110A300 */  addu       $v0, $a1, $v1
    /* 67854 80077054 83110200 */  sra        $v0, $v0, 6
    /* 67858 80077058 C31F0300 */  sra        $v1, $v1, 31
    /* 6785C 8007705C 23104300 */  subu       $v0, $v0, $v1
    /* 67860 80077060 080182AF */  sw         $v0, %gp_rel(gMasterSFXLevel)($gp)
  .L80077064:
    /* 67864 80077064 0800E003 */  jr         $ra
    /* 67868 80077068 00000000 */   nop
endlabel AudioCmn_SetLevels__Fv
