.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_ChangeIntensityState__Fv, 0x78

glabel Weather_ChangeIntensityState__Fv
    /* D29A0 800E21A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D29A4 800E21A4 1000BFAF */  sw         $ra, 0x10($sp)
    /* D29A8 800E21A8 3B88030C */  jal        Weather_GetNewState__Fv
    /* D29AC 800E21AC 00000000 */   nop
    /* D29B0 800E21B0 21204000 */  addu       $a0, $v0, $zero
    /* D29B4 800E21B4 A816838F */  lw         $v1, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D29B8 800E21B8 C016828F */  lw         $v0, %gp_rel(Weather_gTrackIntensityLimit)($gp)
    /* D29BC 800E21BC 21186400 */  addu       $v1, $v1, $a0
    /* D29C0 800E21C0 2A104300 */  slt        $v0, $v0, $v1
    /* D29C4 800E21C4 03004010 */  beqz       $v0, .L800E21D4
    /* D29C8 800E21C8 00000000 */   nop
    /* D29CC 800E21CC 78880308 */  j          .L800E21E0
    /* D29D0 800E21D0 FFFF0424 */   addiu     $a0, $zero, -0x1
  .L800E21D4:
    /* D29D4 800E21D4 02006104 */  bgez       $v1, .L800E21E0
    /* D29D8 800E21D8 00000000 */   nop
    /* D29DC 800E21DC 01000424 */  addiu      $a0, $zero, 0x1
  .L800E21E0:
    /* D29E0 800E21E0 A816828F */  lw         $v0, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D29E4 800E21E4 B01684AF */  sw         $a0, %gp_rel(Weather_gIntensityChangeFactor)($gp)
    /* D29E8 800E21E8 21104400 */  addu       $v0, $v0, $a0
    /* D29EC 800E21EC A81682AF */  sw         $v0, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D29F0 800E21F0 05008014 */  bnez       $a0, .L800E2208
    /* D29F4 800E21F4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D29F8 800E21F8 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* D29FC 800E21FC 00000000 */  nop
    /* D2A00 800E2200 00044224 */  addiu      $v0, $v0, 0x400
    /* D2A04 800E2204 B81682AF */  sw         $v0, %gp_rel(Weather_gIntensityTimerGoal)($gp)
  .L800E2208:
    /* D2A08 800E2208 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2A0C 800E220C 00000000 */  nop
    /* D2A10 800E2210 0800E003 */  jr         $ra
    /* D2A14 800E2214 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_ChangeIntensityState__Fv
