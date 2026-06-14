.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_ChangeDensityBasedOnTime__Fv, 0xD8

glabel Weather_ChangeDensityBasedOnTime__Fv
    /* D2A18 800E2218 AC16828F */  lw         $v0, %gp_rel(Weather_gDensityChangeFactor)($gp)
    /* D2A1C 800E221C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D2A20 800E2220 0F004018 */  blez       $v0, .L800E2260
    /* D2A24 800E2224 1000BFAF */   sw        $ra, 0x10($sp)
    /* D2A28 800E2228 1280043C */  lui        $a0, %hi(Weather_gSys)
    /* D2A2C 800E222C 1280023C */  lui        $v0, %hi(Weather_gDensityTbl)
    /* D2A30 800E2230 A416838F */  lw         $v1, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D2A34 800E2234 84334224 */  addiu      $v0, $v0, %lo(Weather_gDensityTbl)
    /* D2A38 800E2238 80180300 */  sll        $v1, $v1, 2
    /* D2A3C 800E223C 21186200 */  addu       $v1, $v1, $v0
    /* D2A40 800E2240 0834828C */  lw         $v0, %lo(Weather_gSys)($a0)
    /* D2A44 800E2244 0000638C */  lw         $v1, 0x0($v1)
    /* D2A48 800E2248 00000000 */  nop
    /* D2A4C 800E224C 2A104300 */  slt        $v0, $v0, $v1
    /* D2A50 800E2250 19004010 */  beqz       $v0, .L800E22B8
    /* D2A54 800E2254 00000000 */   nop
    /* D2A58 800E2258 B1880308 */  j          .L800E22C4
    /* D2A5C 800E225C 00000000 */   nop
  .L800E2260:
    /* D2A60 800E2260 0F004104 */  bgez       $v0, .L800E22A0
    /* D2A64 800E2264 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D2A68 800E2268 1280043C */  lui        $a0, %hi(Weather_gSys)
    /* D2A6C 800E226C 1280033C */  lui        $v1, %hi(Weather_gDensityTbl)
    /* D2A70 800E2270 A416828F */  lw         $v0, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D2A74 800E2274 84336324 */  addiu      $v1, $v1, %lo(Weather_gDensityTbl)
    /* D2A78 800E2278 80100200 */  sll        $v0, $v0, 2
    /* D2A7C 800E227C 21104300 */  addu       $v0, $v0, $v1
    /* D2A80 800E2280 0834838C */  lw         $v1, %lo(Weather_gSys)($a0)
    /* D2A84 800E2284 0000428C */  lw         $v0, 0x0($v0)
    /* D2A88 800E2288 00000000 */  nop
    /* D2A8C 800E228C 2A104300 */  slt        $v0, $v0, $v1
    /* D2A90 800E2290 09004010 */  beqz       $v0, .L800E22B8
    /* D2A94 800E2294 00000000 */   nop
    /* D2A98 800E2298 B1880308 */  j          .L800E22C4
    /* D2A9C 800E229C 00000000 */   nop
  .L800E22A0:
    /* D2AA0 800E22A0 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* D2AA4 800E22A4 B416828F */  lw         $v0, %gp_rel(Weather_gDensityTimerGoal)($gp)
    /* D2AA8 800E22A8 00000000 */  nop
    /* D2AAC 800E22AC 2A104300 */  slt        $v0, $v0, $v1
    /* D2AB0 800E22B0 04004010 */  beqz       $v0, .L800E22C4
    /* D2AB4 800E22B4 1280043C */   lui       $a0, %hi(Weather_gSys)
  .L800E22B8:
    /* D2AB8 800E22B8 4B88030C */  jal        Weather_ChangeDensityState__Fv
    /* D2ABC 800E22BC 00000000 */   nop
    /* D2AC0 800E22C0 1280043C */  lui        $a0, %hi(Weather_gSys)
  .L800E22C4:
    /* D2AC4 800E22C4 0834828C */  lw         $v0, %lo(Weather_gSys)($a0)
    /* D2AC8 800E22C8 AC16838F */  lw         $v1, %gp_rel(Weather_gDensityChangeFactor)($gp)
    /* D2ACC 800E22CC 00000000 */  nop
    /* D2AD0 800E22D0 21104300 */  addu       $v0, $v0, $v1
    /* D2AD4 800E22D4 0200401C */  bgtz       $v0, .L800E22E0
    /* D2AD8 800E22D8 083482AC */   sw        $v0, %lo(Weather_gSys)($a0)
    /* D2ADC 800E22DC 083480AC */  sw         $zero, %lo(Weather_gSys)($a0)
  .L800E22E0:
    /* D2AE0 800E22E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2AE4 800E22E4 00000000 */  nop
    /* D2AE8 800E22E8 0800E003 */  jr         $ra
    /* D2AEC 800E22EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_ChangeDensityBasedOnTime__Fv
