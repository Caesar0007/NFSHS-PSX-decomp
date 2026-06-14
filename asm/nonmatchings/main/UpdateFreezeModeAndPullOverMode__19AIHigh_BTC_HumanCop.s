.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop, 0x124

glabel UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
    /* 4E2D4 8005DAD4 21288000 */  addu       $a1, $a0, $zero
    /* 4E2D8 8005DAD8 7000A28C */  lw         $v0, 0x70($a1)
    /* 4E2DC 8005DADC 00000000 */  nop
    /* 4E2E0 8005DAE0 0A004104 */  bgez       $v0, .L8005DB0C
    /* 4E2E4 8005DAE4 03000224 */   addiu     $v0, $zero, 0x3
    /* 4E2E8 8005DAE8 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E2EC 8005DAEC 00000000 */  nop
    /* 4E2F0 8005DAF0 5405448C */  lw         $a0, 0x554($v0)
    /* 4E2F4 8005DAF4 01000324 */  addiu      $v1, $zero, 0x1
    /* 4E2F8 8005DAF8 1480013C */  lui        $at, %hi(AIInit_forceHumanHandBrake)
    /* 4E2FC 8005DAFC 84C523AC */  sw         $v1, %lo(AIInit_forceHumanHandBrake)($at)
    /* 4E300 8005DB00 600444AC */  sw         $a0, 0x460($v0)
    /* 4E304 8005DB04 0800E003 */  jr         $ra
    /* 4E308 8005DB08 8800A0AC */   sw        $zero, 0x88($a1)
  .L8005DB0C:
    /* 4E30C 8005DB0C 6000A38C */  lw         $v1, 0x60($a1)
    /* 4E310 8005DB10 00000000 */  nop
    /* 4E314 8005DB14 09006214 */  bne        $v1, $v0, .L8005DB3C
    /* 4E318 8005DB18 01000424 */   addiu     $a0, $zero, 0x1
    /* 4E31C 8005DB1C 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E320 8005DB20 00000000 */  nop
    /* 4E324 8005DB24 600440AC */  sw         $zero, 0x460($v0)
    /* 4E328 8005DB28 0000A38C */  lw         $v1, 0x0($a1)
    /* 4E32C 8005DB2C 01000224 */  addiu      $v0, $zero, 0x1
    /* 4E330 8005DB30 780262AC */  sw         $v0, 0x278($v1)
    /* 4E334 8005DB34 0800E003 */  jr         $ra
    /* 4E338 8005DB38 8800A0AC */   sw        $zero, 0x88($a1)
  .L8005DB3C:
    /* 4E33C 8005DB3C 17006414 */  bne        $v1, $a0, .L8005DB9C
    /* 4E340 8005DB40 FDFF0324 */   addiu     $v1, $zero, -0x3
    /* 4E344 8005DB44 0000A48C */  lw         $a0, 0x0($a1)
    /* 4E348 8005DB48 00000000 */  nop
    /* 4E34C 8005DB4C 7005828C */  lw         $v0, 0x570($a0)
    /* 4E350 8005DB50 00000000 */  nop
    /* 4E354 8005DB54 24104300 */  and        $v0, $v0, $v1
    /* 4E358 8005DB58 700582AC */  sw         $v0, 0x570($a0)
    /* 4E35C 8005DB5C 8000A38C */  lw         $v1, 0x80($a1)
    /* 4E360 8005DB60 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E364 8005DB64 00000000 */  nop
    /* 4E368 8005DB68 600443AC */  sw         $v1, 0x460($v0)
    /* 4E36C 8005DB6C 8400A28C */  lw         $v0, 0x84($a1)
    /* 4E370 8005DB70 0000A38C */  lw         $v1, 0x0($a1)
    /* 4E374 8005DB74 0100422C */  sltiu      $v0, $v0, 0x1
    /* 4E378 8005DB78 780262AC */  sw         $v0, 0x278($v1)
    /* 4E37C 8005DB7C 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E380 8005DB80 00000000 */  nop
    /* 4E384 8005DB84 7802428C */  lw         $v0, 0x278($v0)
    /* 4E388 8005DB88 00000000 */  nop
    /* 4E38C 8005DB8C 18004010 */  beqz       $v0, .L8005DBF0
    /* 4E390 8005DB90 00000000 */   nop
    /* 4E394 8005DB94 0800E003 */  jr         $ra
    /* 4E398 8005DB98 8800A0AC */   sw        $zero, 0x88($a1)
  .L8005DB9C:
    /* 4E39C 8005DB9C 0000A38C */  lw         $v1, 0x0($a1)
    /* 4E3A0 8005DBA0 00000000 */  nop
    /* 4E3A4 8005DBA4 7802628C */  lw         $v0, 0x278($v1)
    /* 4E3A8 8005DBA8 00000000 */  nop
    /* 4E3AC 8005DBAC 05004410 */  beq        $v0, $a0, .L8005DBC4
    /* 4E3B0 8005DBB0 00000000 */   nop
    /* 4E3B4 8005DBB4 6004628C */  lw         $v0, 0x460($v1)
    /* 4E3B8 8005DBB8 00000000 */  nop
    /* 4E3BC 8005DBBC 05004010 */  beqz       $v0, .L8005DBD4
    /* 4E3C0 8005DBC0 00000000 */   nop
  .L8005DBC4:
    /* 4E3C4 8005DBC4 7005628C */  lw         $v0, 0x570($v1)
    /* 4E3C8 8005DBC8 00000000 */  nop
    /* 4E3CC 8005DBCC 02004234 */  ori        $v0, $v0, 0x2
    /* 4E3D0 8005DBD0 700562AC */  sw         $v0, 0x570($v1)
  .L8005DBD4:
    /* 4E3D4 8005DBD4 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E3D8 8005DBD8 8800A0AC */  sw         $zero, 0x88($a1)
    /* 4E3DC 8005DBDC 6000A0AC */  sw         $zero, 0x60($a1)
    /* 4E3E0 8005DBE0 600440AC */  sw         $zero, 0x460($v0)
    /* 4E3E4 8005DBE4 0000A28C */  lw         $v0, 0x0($a1)
    /* 4E3E8 8005DBE8 00000000 */  nop
    /* 4E3EC 8005DBEC 780240AC */  sw         $zero, 0x278($v0)
  .L8005DBF0:
    /* 4E3F0 8005DBF0 0800E003 */  jr         $ra
    /* 4E3F4 8005DBF4 00000000 */   nop
endlabel UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
