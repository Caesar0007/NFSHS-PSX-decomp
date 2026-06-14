.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_ChangeDensityState__Fv, 0x74

glabel Weather_ChangeDensityState__Fv
    /* D292C 800E212C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D2930 800E2130 1000BFAF */  sw         $ra, 0x10($sp)
    /* D2934 800E2134 3B88030C */  jal        Weather_GetNewState__Fv
    /* D2938 800E2138 00000000 */   nop
    /* D293C 800E213C A416838F */  lw         $v1, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D2940 800E2140 21204000 */  addu       $a0, $v0, $zero
    /* D2944 800E2144 21186400 */  addu       $v1, $v1, $a0
    /* D2948 800E2148 04006228 */  slti       $v0, $v1, 0x4
    /* D294C 800E214C 03004014 */  bnez       $v0, .L800E215C
    /* D2950 800E2150 00000000 */   nop
    /* D2954 800E2154 5A880308 */  j          .L800E2168
    /* D2958 800E2158 FFFF0424 */   addiu     $a0, $zero, -0x1
  .L800E215C:
    /* D295C 800E215C 02006104 */  bgez       $v1, .L800E2168
    /* D2960 800E2160 00000000 */   nop
    /* D2964 800E2164 01000424 */  addiu      $a0, $zero, 0x1
  .L800E2168:
    /* D2968 800E2168 A416828F */  lw         $v0, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D296C 800E216C AC1684AF */  sw         $a0, %gp_rel(Weather_gDensityChangeFactor)($gp)
    /* D2970 800E2170 21104400 */  addu       $v0, $v0, $a0
    /* D2974 800E2174 A41682AF */  sw         $v0, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D2978 800E2178 05008014 */  bnez       $a0, .L800E2190
    /* D297C 800E217C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D2980 800E2180 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* D2984 800E2184 00000000 */  nop
    /* D2988 800E2188 00044224 */  addiu      $v0, $v0, 0x400
    /* D298C 800E218C B41682AF */  sw         $v0, %gp_rel(Weather_gDensityTimerGoal)($gp)
  .L800E2190:
    /* D2990 800E2190 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2994 800E2194 00000000 */  nop
    /* D2998 800E2198 0800E003 */  jr         $ra
    /* D299C 800E219C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_ChangeDensityState__Fv
