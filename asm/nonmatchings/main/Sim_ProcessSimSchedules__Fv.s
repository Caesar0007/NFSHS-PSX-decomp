.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_ProcessSimSchedules__Fv, 0x324

glabel Sim_ProcessSimSchedules__Fv
    /* A7078 800B6878 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A707C 800B687C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A7080 800B6880 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* A7084 800B6884 01000224 */  addiu      $v0, $zero, 0x1
    /* A7088 800B6888 2000BFAF */  sw         $ra, 0x20($sp)
    /* A708C 800B688C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A7090 800B6890 04006210 */  beq        $v1, $v0, .L800B68A4
    /* A7094 800B6894 1800B0AF */   sw        $s0, 0x18($sp)
    /* A7098 800B6898 05000224 */  addiu      $v0, $zero, 0x5
    /* A709C 800B689C 15006214 */  bne        $v1, $v0, .L800B68F4
    /* A70A0 800B68A0 1280023C */   lui       $v0, %hi(simGlobal)
  .L800B68A4:
    /* A70A4 800B68A4 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* A70A8 800B68A8 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* A70AC 800B68AC 00000000 */  nop
    /* A70B0 800B68B0 6002428C */  lw         $v0, 0x260($v0)
    /* A70B4 800B68B4 00000000 */  nop
    /* A70B8 800B68B8 00024230 */  andi       $v0, $v0, 0x200
    /* A70BC 800B68BC 46004014 */  bnez       $v0, .L800B69D8
    /* A70C0 800B68C0 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* A70C4 800B68C4 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* A70C8 800B68C8 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* A70CC 800B68CC 02000224 */  addiu      $v0, $zero, 0x2
    /* A70D0 800B68D0 08006214 */  bne        $v1, $v0, .L800B68F4
    /* A70D4 800B68D4 1280023C */   lui       $v0, %hi(simGlobal)
    /* A70D8 800B68D8 0400828C */  lw         $v0, 0x4($a0)
    /* A70DC 800B68DC 00000000 */  nop
    /* A70E0 800B68E0 6002428C */  lw         $v0, 0x260($v0)
    /* A70E4 800B68E4 00000000 */  nop
    /* A70E8 800B68E8 00024230 */  andi       $v0, $v0, 0x200
    /* A70EC 800B68EC 3A004014 */  bnez       $v0, .L800B69D8
    /* A70F0 800B68F0 1280023C */   lui       $v0, %hi(simGlobal)
  .L800B68F4:
    /* A70F4 800B68F4 ACE0428C */  lw         $v0, %lo(simGlobal)($v0)
    /* A70F8 800B68F8 00000000 */  nop
    /* A70FC 800B68FC 3C004014 */  bnez       $v0, .L800B69F0
    /* A7100 800B6900 1280023C */   lui       $v0, %hi(simGlobal)
    /* A7104 800B6904 1480023C */  lui        $v0, %hi(countdown)
    /* A7108 800B6908 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* A710C 800B690C 00000000 */  nop
    /* A7110 800B6910 FFFF5024 */  addiu      $s0, $v0, -0x1
    /* A7114 800B6914 03000106 */  bgez       $s0, .L800B6924
    /* A7118 800B6918 0400022A */   slti      $v0, $s0, 0x4
    /* A711C 800B691C 21800000 */  addu       $s0, $zero, $zero
    /* A7120 800B6920 0400022A */  slti       $v0, $s0, 0x4
  .L800B6924:
    /* A7124 800B6924 0B004010 */  beqz       $v0, .L800B6954
    /* A7128 800B6928 1280063C */   lui       $a2, %hi(simGlobal)
    /* A712C 800B692C 23001124 */  addiu      $s1, $zero, 0x23
    /* A7130 800B6930 02000424 */  addiu      $a0, $zero, 0x2
  .L800B6934:
    /* A7134 800B6934 21281102 */  addu       $a1, $s0, $s1
    /* A7138 800B6938 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* A713C 800B693C 21300000 */   addu      $a2, $zero, $zero
    /* A7140 800B6940 01001026 */  addiu      $s0, $s0, 0x1
    /* A7144 800B6944 0400022A */  slti       $v0, $s0, 0x4
    /* A7148 800B6948 FAFF4014 */  bnez       $v0, .L800B6934
    /* A714C 800B694C 02000424 */   addiu     $a0, $zero, 0x2
    /* A7150 800B6950 1280063C */  lui        $a2, %hi(simGlobal)
  .L800B6954:
    /* A7154 800B6954 ACE0C424 */  addiu      $a0, $a2, %lo(simGlobal)
    /* A7158 800B6958 1280033C */  lui        $v1, %hi(counter)
    /* A715C 800B695C 1480053C */  lui        $a1, %hi(countdown)
    /* A7160 800B6960 3CC6A590 */  lbu        $a1, %lo(countdown)($a1)
    /* A7164 800B6964 9CE06324 */  addiu      $v1, $v1, %lo(counter)
    /* A7168 800B6968 80100500 */  sll        $v0, $a1, 2
    /* A716C 800B696C 21104300 */  addu       $v0, $v0, $v1
    /* A7170 800B6970 0400838C */  lw         $v1, 0x4($a0)
    /* A7174 800B6974 0000428C */  lw         $v0, 0x0($v0)
    /* A7178 800B6978 00000000 */  nop
    /* A717C 800B697C 2A106200 */  slt        $v0, $v1, $v0
    /* A7180 800B6980 11004014 */  bnez       $v0, .L800B69C8
    /* A7184 800B6984 00026228 */   slti      $v0, $v1, 0x200
    /* A7188 800B6988 03004014 */  bnez       $v0, .L800B6998
    /* A718C 800B698C FCFF0424 */   addiu     $a0, $zero, -0x4
    /* A7190 800B6990 01000224 */  addiu      $v0, $zero, 0x1
    /* A7194 800B6994 ACE0C2AC */  sw         $v0, %lo(simGlobal)($a2)
  .L800B6998:
    /* A7198 800B6998 2300A524 */  addiu      $a1, $a1, 0x23
    /* A719C 800B699C 21300000 */  addu       $a2, $zero, $zero
    /* A71A0 800B69A0 40000224 */  addiu      $v0, $zero, 0x40
    /* A71A4 800B69A4 7F000724 */  addiu      $a3, $zero, 0x7F
    /* A71A8 800B69A8 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* A71AC 800B69AC 1000A2AF */   sw        $v0, 0x10($sp)
    /* A71B0 800B69B0 1480023C */  lui        $v0, %hi(countdown)
    /* A71B4 800B69B4 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* A71B8 800B69B8 00000000 */  nop
    /* A71BC 800B69BC 01004224 */  addiu      $v0, $v0, 0x1
    /* A71C0 800B69C0 1480013C */  lui        $at, %hi(countdown)
    /* A71C4 800B69C4 3CC622A0 */  sb         $v0, %lo(countdown)($at)
  .L800B69C8:
    /* A71C8 800B69C8 FED9020C */  jal        Sim_FadeInSFX__Fv
    /* A71CC 800B69CC 00000000 */   nop
    /* A71D0 800B69D0 7CDA0208 */  j          .L800B69F0
    /* A71D4 800B69D4 1280023C */   lui       $v0, %hi(simGlobal)
  .L800B69D8:
    /* A71D8 800B69D8 FED9020C */  jal        Sim_FadeInSFX__Fv
    /* A71DC 800B69DC 00000000 */   nop
    /* A71E0 800B69E0 1280033C */  lui        $v1, %hi(simGlobal)
    /* A71E4 800B69E4 01000224 */  addiu      $v0, $zero, 0x1
    /* A71E8 800B69E8 ACE062AC */  sw         $v0, %lo(simGlobal)($v1)
    /* A71EC 800B69EC 1280023C */  lui        $v0, %hi(simGlobal)
  .L800B69F0:
    /* A71F0 800B69F0 ACE05024 */  addiu      $s0, $v0, %lo(simGlobal)
    /* A71F4 800B69F4 0400028E */  lw         $v0, 0x4($s0)
    /* A71F8 800B69F8 00000000 */  nop
    /* A71FC 800B69FC 01004230 */  andi       $v0, $v0, 0x1
    /* A7200 800B6A00 1E004014 */  bnez       $v0, .L800B6A7C
    /* A7204 800B6A04 00000000 */   nop
    /* A7208 800B6A08 019B030C */  jal        systemtask
    /* A720C 800B6A0C 21200000 */   addu      $a0, $zero, $zero
    /* A7210 800B6A10 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A7214 800B6A14 2B91030C */  jal        SetSp
    /* A7218 800B6A18 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A721C 800B6A1C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A7220 800B6A20 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A7224 800B6A24 01000224 */  addiu      $v0, $zero, 0x1
    /* A7228 800B6A28 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A722C 800B6A2C 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A7230 800B6A30 45E0020C */  jal        Stats_ClearPosition__Fv
    /* A7234 800B6A34 00000000 */   nop
    /* A7238 800B6A38 3545020C */  jal        Collide_ClearCollisionRegistry__Fv
    /* A723C 800B6A3C 00000000 */   nop
    /* A7240 800B6A40 1000048E */  lw         $a0, 0x10($s0)
    /* A7244 800B6A44 40D9020C */  jal        Sched_Execute__FP15Sched_tSchedule
    /* A7248 800B6A48 00000000 */   nop
    /* A724C 800B6A4C FF2B020C */  jal        Cars_ManageBureaucracy__Fv
    /* A7250 800B6A50 00000000 */   nop
    /* A7254 800B6A54 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A7258 800B6A58 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A725C 800B6A5C 2B91030C */  jal        SetSp
    /* A7260 800B6A60 00000000 */   nop
    /* A7264 800B6A64 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A7268 800B6A68 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A726C 800B6A6C 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A7270 800B6A70 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A7274 800B6A74 712C020C */  jal        Cars_CheckForAccidentScenes__Fv
    /* A7278 800B6A78 00000000 */   nop
  .L800B6A7C:
    /* A727C 800B6A7C 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A7280 800B6A80 2B91030C */  jal        SetSp
    /* A7284 800B6A84 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A7288 800B6A88 0C00048E */  lw         $a0, 0xC($s0)
    /* A728C 800B6A8C 01001124 */  addiu      $s1, $zero, 0x1
    /* A7290 800B6A90 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A7294 800B6A94 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A7298 800B6A98 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A729C 800B6A9C 1CD831AC */  sw         $s1, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A72A0 800B6AA0 40D9020C */  jal        Sched_Execute__FP15Sched_tSchedule
    /* A72A4 800B6AA4 00000000 */   nop
    /* A72A8 800B6AA8 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A72AC 800B6AAC 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A72B0 800B6AB0 2B91030C */  jal        SetSp
    /* A72B4 800B6AB4 00000000 */   nop
    /* A72B8 800B6AB8 0400038E */  lw         $v1, 0x4($s0)
    /* A72BC 800B6ABC 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A72C0 800B6AC0 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A72C4 800B6AC4 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A72C8 800B6AC8 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A72CC 800B6ACC 24187100 */  and        $v1, $v1, $s1
    /* A72D0 800B6AD0 29006010 */  beqz       $v1, .L800B6B78
    /* A72D4 800B6AD4 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* A72D8 800B6AD8 2B91030C */  jal        SetSp
    /* A72DC 800B6ADC FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A72E0 800B6AE0 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A72E4 800B6AE4 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A72E8 800B6AE8 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A72EC 800B6AEC 1CD831AC */  sw         $s1, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A72F0 800B6AF0 846C010C */  jal        AIHigh_Execute__Fv
    /* A72F4 800B6AF4 00000000 */   nop
    /* A72F8 800B6AF8 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A72FC 800B6AFC 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A7300 800B6B00 2B91030C */  jal        SetSp
    /* A7304 800B6B04 00000000 */   nop
    /* A7308 800B6B08 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A730C 800B6B0C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A7310 800B6B10 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A7314 800B6B14 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A7318 800B6B18 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A731C 800B6B1C 2B91030C */  jal        SetSp
    /* A7320 800B6B20 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A7324 800B6B24 1400048E */  lw         $a0, 0x14($s0)
    /* A7328 800B6B28 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A732C 800B6B2C 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A7330 800B6B30 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A7334 800B6B34 1CD831AC */  sw         $s1, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A7338 800B6B38 40D9020C */  jal        Sched_Execute__FP15Sched_tSchedule
    /* A733C 800B6B3C 00000000 */   nop
    /* A7340 800B6B40 6EE3020C */  jal        Stats_TrackEndGame__Fv
    /* A7344 800B6B44 00000000 */   nop
    /* A7348 800B6B48 D6DF020C */  jal        Stats_DoPlayerGlue__Fv
    /* A734C 800B6B4C 00000000 */   nop
    /* A7350 800B6B50 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A7354 800B6B54 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A7358 800B6B58 2B91030C */  jal        SetSp
    /* A735C 800B6B5C 00000000 */   nop
    /* A7360 800B6B60 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A7364 800B6B64 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A7368 800B6B68 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A736C 800B6B6C 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A7370 800B6B70 58D8010C */  jal        AudioClc_SoundCars__Fv
    /* A7374 800B6B74 00000000 */   nop
  .L800B6B78:
    /* A7378 800B6B78 0400028E */  lw         $v0, 0x4($s0)
    /* A737C 800B6B7C 00000000 */  nop
    /* A7380 800B6B80 01004224 */  addiu      $v0, $v0, 0x1
    /* A7384 800B6B84 040002AE */  sw         $v0, 0x4($s0)
    /* A7388 800B6B88 2000BF8F */  lw         $ra, 0x20($sp)
    /* A738C 800B6B8C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A7390 800B6B90 1800B08F */  lw         $s0, 0x18($sp)
    /* A7394 800B6B94 0800E003 */  jr         $ra
    /* A7398 800B6B98 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Sim_ProcessSimSchedules__Fv
