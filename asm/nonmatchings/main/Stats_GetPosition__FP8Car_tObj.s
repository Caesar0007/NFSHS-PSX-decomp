.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_GetPosition__FP8Car_tObj, 0x54

glabel Stats_GetPosition__FP8Car_tObj
    /* A8954 800B8154 21280000 */  addu       $a1, $zero, $zero
    /* A8958 800B8158 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A895C 800B815C F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A8960 800B8160 5402878C */  lw         $a3, 0x254($a0)
    /* A8964 800B8164 0E004018 */  blez       $v0, .L800B81A0
    /* A8968 800B8168 2130A000 */   addu      $a2, $a1, $zero
    /* A896C 800B816C 21204000 */  addu       $a0, $v0, $zero
    /* A8970 800B8170 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A8974 800B8174 E0E04324 */  addiu      $v1, $v0, %lo(Stats_racePosition)
  .L800B8178:
    /* A8978 800B8178 0000628C */  lw         $v0, 0x0($v1)
    /* A897C 800B817C 00000000 */  nop
    /* A8980 800B8180 03004714 */  bne        $v0, $a3, .L800B8190
    /* A8984 800B8184 00000000 */   nop
    /* A8988 800B8188 68E00208 */  j          .L800B81A0
    /* A898C 800B818C 0100A624 */   addiu     $a2, $a1, 0x1
  .L800B8190:
    /* A8990 800B8190 0100A524 */  addiu      $a1, $a1, 0x1
    /* A8994 800B8194 2A10A400 */  slt        $v0, $a1, $a0
    /* A8998 800B8198 F7FF4014 */  bnez       $v0, .L800B8178
    /* A899C 800B819C 10006324 */   addiu     $v1, $v1, 0x10
  .L800B81A0:
    /* A89A0 800B81A0 0800E003 */  jr         $ra
    /* A89A4 800B81A4 2110C000 */   addu      $v0, $a2, $zero
endlabel Stats_GetPosition__FP8Car_tObj
