.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_ResetReplay__Fv, 0x158

glabel Replay_ResetReplay__Fv
    /* A4744 800B3F44 A80E838F */  lw         $v1, %gp_rel(Replay_ReplayMode)($gp)
    /* A4748 800B3F48 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A474C 800B3F4C 2000BFAF */  sw         $ra, 0x20($sp)
    /* A4750 800B3F50 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A4754 800B3F54 1800B2AF */  sw         $s2, 0x18($sp)
    /* A4758 800B3F58 1400B1AF */  sw         $s1, 0x14($sp)
    /* A475C 800B3F5C 0200622C */  sltiu      $v0, $v1, 0x2
    /* A4760 800B3F60 0D004010 */  beqz       $v0, .L800B3F98
    /* A4764 800B3F64 1000B0AF */   sw        $s0, 0x10($sp)
    /* A4768 800B3F68 FF5F1024 */  addiu      $s0, $zero, 0x5FFF
    /* A476C 800B3F6C 1180023C */  lui        $v0, %hi(Replay_ReplayBuffer)
    /* A4770 800B3F70 6C714224 */  addiu      $v0, $v0, %lo(Replay_ReplayBuffer)
    /* A4774 800B3F74 21105000 */  addu       $v0, $v0, $s0
  .L800B3F78:
    /* A4778 800B3F78 2C0A40A0 */  sb         $zero, 0xA2C($v0)
    /* A477C 800B3F7C FFFF1026 */  addiu      $s0, $s0, -0x1
    /* A4780 800B3F80 FDFF0106 */  bgez       $s0, .L800B3F78
    /* A4784 800B3F84 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* A4788 800B3F88 AC0E80AF */  sw         $zero, %gp_rel(Replay_ReplayStorePtr)($gp)
    /* A478C 800B3F8C B00E80AF */  sw         $zero, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A4790 800B3F90 16D00208 */  j          .L800B4058
    /* A4794 800B3F94 01001024 */   addiu     $s0, $zero, 0x1
  .L800B3F98:
    /* A4798 800B3F98 02006228 */  slti       $v0, $v1, 0x2
    /* A479C 800B3F9C 2E004014 */  bnez       $v0, .L800B4058
    /* A47A0 800B3FA0 01001024 */   addiu     $s0, $zero, 0x1
    /* A47A4 800B3FA4 21800000 */  addu       $s0, $zero, $zero
    /* A47A8 800B3FA8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A47AC 800B3FAC EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* A47B0 800B3FB0 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
    /* A47B4 800B3FB4 4C705124 */  addiu      $s1, $v0, %lo(Replay_ReplayCamera)
    /* A47B8 800B3FB8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A47BC 800B3FBC 48FA5224 */  addiu      $s2, $v0, %lo(Cars_gHumanRaceCarList)
    /* A47C0 800B3FC0 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* A47C4 800B3FC4 2C7040AC */  sw         $zero, %lo(Replay_ReplayInterface)($v0)
    /* A47C8 800B3FC8 2C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayInterface)
    /* A47CC 800B3FCC 02000324 */  addiu      $v1, $zero, 0x2
    /* A47D0 800B3FD0 040043AC */  sw         $v1, 0x4($v0)
    /* A47D4 800B3FD4 04000324 */  addiu      $v1, $zero, 0x4
    /* A47D8 800B3FD8 B00E80AF */  sw         $zero, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A47DC 800B3FDC 080040AC */  sw         $zero, 0x8($v0)
    /* A47E0 800B3FE0 0C0040AC */  sw         $zero, 0xC($v0)
    /* A47E4 800B3FE4 100043AC */  sw         $v1, 0x10($v0)
    /* A47E8 800B3FE8 140040AC */  sw         $zero, 0x14($v0)
    /* A47EC 800B3FEC 180040AC */  sw         $zero, 0x18($v0)
  .L800B3FF0:
    /* A47F0 800B3FF0 A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A47F4 800B3FF4 00000000 */  nop
    /* A47F8 800B3FF8 0E004010 */  beqz       $v0, .L800B4034
    /* A47FC 800B3FFC 01000224 */   addiu     $v0, $zero, 0x1
    /* A4800 800B4000 0C00638E */  lw         $v1, 0xC($s3)
    /* A4804 800B4004 00000000 */  nop
    /* A4808 800B4008 03006210 */  beq        $v1, $v0, .L800B4018
    /* A480C 800B400C 00000000 */   nop
    /* A4810 800B4010 06000016 */  bnez       $s0, .L800B402C
    /* A4814 800B4014 00000000 */   nop
  .L800B4018:
    /* A4818 800B4018 0000428E */  lw         $v0, 0x0($s2)
    /* A481C 800B401C 00000000 */  nop
    /* A4820 800B4020 08004584 */  lh         $a1, 0x8($v0)
    /* A4824 800B4024 C5D6020C */  jal        Replay_ReplayFindClosestCamera__Fii
    /* A4828 800B4028 21200002 */   addu      $a0, $s0, $zero
  .L800B402C:
    /* A482C 800B402C 0ED00208 */  j          .L800B4038
    /* A4830 800B4030 13000224 */   addiu     $v0, $zero, 0x13
  .L800B4034:
    /* A4834 800B4034 04000224 */  addiu      $v0, $zero, 0x4
  .L800B4038:
    /* A4838 800B4038 080022AE */  sw         $v0, 0x8($s1)
    /* A483C 800B403C 0C0020AE */  sw         $zero, 0xC($s1)
    /* A4840 800B4040 10003126 */  addiu      $s1, $s1, 0x10
    /* A4844 800B4044 01001026 */  addiu      $s0, $s0, 0x1
    /* A4848 800B4048 0200022A */  slti       $v0, $s0, 0x2
    /* A484C 800B404C E8FF4014 */  bnez       $v0, .L800B3FF0
    /* A4850 800B4050 04005226 */   addiu     $s2, $s2, 0x4
    /* A4854 800B4054 01001024 */  addiu      $s0, $zero, 0x1
  .L800B4058:
    /* A4858 800B4058 1480023C */  lui        $v0, %hi(D_8013D404)
    /* A485C 800B405C 04D44224 */  addiu      $v0, $v0, %lo(D_8013D404)
  .L800B4060:
    /* A4860 800B4060 000040AC */  sw         $zero, 0x0($v0)
    /* A4864 800B4064 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* A4868 800B4068 FDFF0106 */  bgez       $s0, .L800B4060
    /* A486C 800B406C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* A4870 800B4070 2000BF8F */  lw         $ra, 0x20($sp)
    /* A4874 800B4074 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A4878 800B4078 1800B28F */  lw         $s2, 0x18($sp)
    /* A487C 800B407C 1400B18F */  lw         $s1, 0x14($sp)
    /* A4880 800B4080 1000B08F */  lw         $s0, 0x10($sp)
    /* A4884 800B4084 1480013C */  lui        $at, %hi(StatsTimer)
    /* A4888 800B4088 98D920AC */  sw         $zero, %lo(StatsTimer)($at)
    /* A488C 800B408C 1480013C */  lui        $at, %hi(D_8013D99C)
    /* A4890 800B4090 9CD920AC */  sw         $zero, %lo(D_8013D99C)($at)
    /* A4894 800B4094 0800E003 */  jr         $ra
    /* A4898 800B4098 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Replay_ResetReplay__Fv
