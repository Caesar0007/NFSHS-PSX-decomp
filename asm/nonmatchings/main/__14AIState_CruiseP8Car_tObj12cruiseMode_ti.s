.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14AIState_CruiseP8Car_tObj12cruiseMode_ti, 0x6C

glabel __14AIState_CruiseP8Car_tObj12cruiseMode_ti
    /* 62D1C 8007251C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 62D20 80072520 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62D24 80072524 21808000 */  addu       $s0, $a0, $zero
    /* 62D28 80072528 1400B1AF */  sw         $s1, 0x14($sp)
    /* 62D2C 8007252C 2188C000 */  addu       $s1, $a2, $zero
    /* 62D30 80072530 1800B2AF */  sw         $s2, 0x18($sp)
    /* 62D34 80072534 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 62D38 80072538 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 62D3C 8007253C 2190E000 */   addu      $s2, $a3, $zero
    /* 62D40 80072540 0580023C */  lui        $v0, %hi(_vt_14AIState_Cruise)
    /* 62D44 80072544 00554224 */  addiu      $v0, $v0, %lo(_vt_14AIState_Cruise)
    /* 62D48 80072548 040002AE */  sw         $v0, 0x4($s0)
    /* 62D4C 8007254C 03002016 */  bnez       $s1, .L8007255C
    /* 62D50 80072550 080011AE */   sw        $s1, 0x8($s0)
    /* 62D54 80072554 5BC90108 */  j          .L8007256C
    /* 62D58 80072558 0C0012AE */   sw        $s2, 0xC($s0)
  .L8007255C:
    /* 62D5C 8007255C 01000224 */  addiu      $v0, $zero, 0x1
    /* 62D60 80072560 03002216 */  bne        $s1, $v0, .L80072570
    /* 62D64 80072564 21100002 */   addu      $v0, $s0, $zero
    /* 62D68 80072568 100012AE */  sw         $s2, 0x10($s0)
  .L8007256C:
    /* 62D6C 8007256C 21100002 */  addu       $v0, $s0, $zero
  .L80072570:
    /* 62D70 80072570 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 62D74 80072574 1800B28F */  lw         $s2, 0x18($sp)
    /* 62D78 80072578 1400B18F */  lw         $s1, 0x14($sp)
    /* 62D7C 8007257C 1000B08F */  lw         $s0, 0x10($sp)
    /* 62D80 80072580 0800E003 */  jr         $ra
    /* 62D84 80072584 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __14AIState_CruiseP8Car_tObj12cruiseMode_ti
