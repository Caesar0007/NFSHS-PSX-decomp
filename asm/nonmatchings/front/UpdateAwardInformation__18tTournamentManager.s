.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateAwardInformation__18tTournamentManager, 0x178

glabel UpdateAwardInformation__18tTournamentManager
    /* 24114 80033914 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 24118 80033918 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 2411C 8003391C 21888000 */  addu       $s1, $a0, $zero
    /* 24120 80033920 01000524 */  addiu      $a1, $zero, 0x1
    /* 24124 80033924 1000A627 */  addiu      $a2, $sp, 0x10
    /* 24128 80033928 1400A727 */  addiu      $a3, $sp, 0x14
    /* 2412C 8003392C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 24130 80033930 1BCB000C */  jal        CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
    /* 24134 80033934 1800B0AF */   sw        $s0, 0x18($sp)
    /* 24138 80033938 1400228E */  lw         $v0, 0x14($s1)
    /* 2413C 8003393C 1000A38F */  lw         $v1, 0x10($sp)
    /* 24140 80033940 00000000 */  nop
    /* 24144 80033944 23104300 */  subu       $v0, $v0, $v1
    /* 24148 80033948 140022AE */  sw         $v0, 0x14($s1)
    /* 2414C 8003394C 1400A38F */  lw         $v1, 0x14($sp)
    /* 24150 80033950 4002248E */  lw         $a0, 0x240($s1)
    /* 24154 80033954 21104300 */  addu       $v0, $v0, $v1
    /* 24158 80033958 140022AE */  sw         $v0, 0x14($s1)
    /* 2415C 8003395C 21104400 */  addu       $v0, $v0, $a0
    /* 24160 80033960 4402248E */  lw         $a0, 0x244($s1)
    /* 24164 80033964 48022396 */  lhu        $v1, 0x248($s1)
    /* 24168 80033968 140022AE */  sw         $v0, 0x14($s1)
    /* 2416C 8003396C 21104400 */  addu       $v0, $v0, $a0
    /* 24170 80033970 02006330 */  andi       $v1, $v1, 0x2
    /* 24174 80033974 04006010 */  beqz       $v1, .L80033988
    /* 24178 80033978 140022AE */   sw        $v0, 0x14($s1)
    /* 2417C 8003397C 4C02248E */  lw         $a0, 0x24C($s1)
    /* 24180 80033980 768D000C */  jal        FECheat_ActivateBonus__F10tCheatCode
    /* 24184 80033984 00000000 */   nop
  .L80033988:
    /* 24188 80033988 48022296 */  lhu        $v0, 0x248($s1)
    /* 2418C 8003398C 00000000 */  nop
    /* 24190 80033990 04004230 */  andi       $v0, $v0, 0x4
    /* 24194 80033994 05004010 */  beqz       $v0, .L800339AC
    /* 24198 80033998 1180043C */   lui       $a0, %hi(carManager)
    /* 2419C 8003399C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 241A0 800339A0 5002258E */  lw         $a1, 0x250($s1)
    /* 241A4 800339A4 7B5B000C */  jal        SetCarAvailable__11tCarManager10tCarModelsb
    /* 241A8 800339A8 01000624 */   addiu     $a2, $zero, 0x1
  .L800339AC:
    /* 241AC 800339AC 48022296 */  lhu        $v0, 0x248($s1)
    /* 241B0 800339B0 00000000 */  nop
    /* 241B4 800339B4 01004230 */  andi       $v0, $v0, 0x1
    /* 241B8 800339B8 05004010 */  beqz       $v0, .L800339D0
    /* 241BC 800339BC 1180043C */   lui       $a0, %hi(trackManager)
    /* 241C0 800339C0 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 241C4 800339C4 4A022592 */  lbu        $a1, 0x24A($s1)
    /* 241C8 800339C8 2387000C */  jal        SetTrackAvailable__13tTrackManagersb
    /* 241CC 800339CC 01000624 */   addiu     $a2, $zero, 0x1
  .L800339D0:
    /* 241D0 800339D0 48022296 */  lhu        $v0, 0x248($s1)
    /* 241D4 800339D4 00000000 */  nop
    /* 241D8 800339D8 08004230 */  andi       $v0, $v0, 0x8
    /* 241DC 800339DC 05004010 */  beqz       $v0, .L800339F4
    /* 241E0 800339E0 1180043C */   lui       $a0, %hi(trackManager)
    /* 241E4 800339E4 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 241E8 800339E8 5402258E */  lw         $a1, 0x254($s1)
    /* 241EC 800339EC 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 241F0 800339F0 01000624 */   addiu     $a2, $zero, 0x1
  .L800339F4:
    /* 241F4 800339F4 48022296 */  lhu        $v0, 0x248($s1)
    /* 241F8 800339F8 00000000 */  nop
    /* 241FC 800339FC 10004230 */  andi       $v0, $v0, 0x10
    /* 24200 80033A00 04004010 */  beqz       $v0, .L80033A14
    /* 24204 80033A04 00000000 */   nop
    /* 24208 80033A08 5802248E */  lw         $a0, 0x258($s1)
    /* 2420C 80033A0C 768D000C */  jal        FECheat_ActivateBonus__F10tCheatCode
    /* 24210 80033A10 00000000 */   nop
  .L80033A14:
    /* 24214 80033A14 5C02228E */  lw         $v0, 0x25C($s1)
    /* 24218 80033A18 00000000 */  nop
    /* 2421C 80033A1C 16004010 */  beqz       $v0, .L80033A78
    /* 24220 80033A20 00000000 */   nop
    /* 24224 80033A24 6002228E */  lw         $v0, 0x260($s1)
    /* 24228 80033A28 00000000 */  nop
    /* 2422C 80033A2C 12004014 */  bnez       $v0, .L80033A78
    /* 24230 80033A30 1180103C */   lui       $s0, %hi(carManager)
    /* 24234 80033A34 74421026 */  addiu      $s0, $s0, %lo(carManager)
    /* 24238 80033A38 68022586 */  lh         $a1, 0x268($s1)
    /* 2423C 80033A3C 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 24240 80033A40 21200002 */   addu      $a0, $s0, $zero
    /* 24244 80033A44 21200002 */  addu       $a0, $s0, $zero
    /* 24248 80033A48 6C022392 */  lbu        $v1, 0x26C($s1)
    /* 2424C 80033A4C 68022586 */  lh         $a1, 0x268($s1)
    /* 24250 80033A50 21104300 */  addu       $v0, $v0, $v1
    /* 24254 80033A54 AF004680 */  lb         $a2, 0xAF($v0)
    /* 24258 80033A58 1459000C */  jal        PurchaseCar__11tCarManagersss
    /* 2425C 80033A5C 21380000 */   addu      $a3, $zero, $zero
    /* 24260 80033A60 21200002 */  addu       $a0, $s0, $zero
    /* 24264 80033A64 1180023C */  lui        $v0, %hi(D_80114723)
    /* 24268 80033A68 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
    /* 2426C 80033A6C 6D022692 */  lbu        $a2, 0x26D($s1)
    /* 24270 80033A70 AB59000C */  jal        PurchaseUpgrade__11tCarManagersss
    /* 24274 80033A74 21380000 */   addu      $a3, $zero, $zero
  .L80033A78:
    /* 24278 80033A78 2000BF8F */  lw         $ra, 0x20($sp)
    /* 2427C 80033A7C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 24280 80033A80 1800B08F */  lw         $s0, 0x18($sp)
    /* 24284 80033A84 0800E003 */  jr         $ra
    /* 24288 80033A88 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel UpdateAwardInformation__18tTournamentManager
