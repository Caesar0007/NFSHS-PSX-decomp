.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_PitchAndRoll__Fi, 0xB4

glabel Camera_PitchAndRoll__Fi
    /* 74474 80083C74 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* 74478 80083C78 9000B2AF */  sw         $s2, 0x90($sp)
    /* 7447C 80083C7C 1180123C */  lui        $s2, %hi(Camera_gInfo)
    /* 74480 80083C80 ACF25226 */  addiu      $s2, $s2, %lo(Camera_gInfo)
    /* 74484 80083C84 8800B0AF */  sw         $s0, 0x88($sp)
    /* 74488 80083C88 00810400 */  sll        $s0, $a0, 4
    /* 7448C 80083C8C 21800402 */  addu       $s0, $s0, $a0
    /* 74490 80083C90 00811000 */  sll        $s0, $s0, 4
    /* 74494 80083C94 9400B3AF */  sw         $s3, 0x94($sp)
    /* 74498 80083C98 21981202 */  addu       $s3, $s0, $s2
    /* 7449C 80083C9C 9C00BFAF */  sw         $ra, 0x9C($sp)
    /* 744A0 80083CA0 9800B4AF */  sw         $s4, 0x98($sp)
    /* 744A4 80083CA4 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 744A8 80083CA8 0000628E */  lw         $v0, 0x0($s3)
    /* 744AC 80083CAC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 744B0 80083CB0 4808518C */  lw         $s1, 0x848($v0)
    /* 744B4 80083CB4 4C08458C */  lw         $a1, 0x84C($v0)
    /* 744B8 80083CB8 1DAB030C */  jal        fixedxformz
    /* 744BC 80083CBC 40881100 */   sll       $s1, $s1, 1
    /* 744C0 80083CC0 3800B427 */  addiu      $s4, $sp, 0x38
    /* 744C4 80083CC4 7400658E */  lw         $a1, 0x74($s3)
    /* 744C8 80083CC8 21208002 */  addu       $a0, $s4, $zero
    /* 744CC 80083CCC 42280500 */  srl        $a1, $a1, 1
    /* 744D0 80083CD0 0100A530 */  andi       $a1, $a1, 0x1
    /* 744D4 80083CD4 EBAA030C */  jal        fixedxformx
    /* 744D8 80083CD8 25282502 */   or        $a1, $s1, $a1
    /* 744DC 80083CDC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 744E0 80083CE0 21288002 */  addu       $a1, $s4, $zero
    /* 744E4 80083CE4 6000B127 */  addiu      $s1, $sp, 0x60
    /* 744E8 80083CE8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 744EC 80083CEC 21302002 */   addu      $a2, $s1, $zero
    /* 744F0 80083CF0 21202002 */  addu       $a0, $s1, $zero
    /* 744F4 80083CF4 30005226 */  addiu      $s2, $s2, 0x30
    /* 744F8 80083CF8 21801202 */  addu       $s0, $s0, $s2
    /* 744FC 80083CFC 21280002 */  addu       $a1, $s0, $zero
    /* 74500 80083D00 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 74504 80083D04 2130A000 */   addu      $a2, $a1, $zero
    /* 74508 80083D08 9C00BF8F */  lw         $ra, 0x9C($sp)
    /* 7450C 80083D0C 9800B48F */  lw         $s4, 0x98($sp)
    /* 74510 80083D10 9400B38F */  lw         $s3, 0x94($sp)
    /* 74514 80083D14 9000B28F */  lw         $s2, 0x90($sp)
    /* 74518 80083D18 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 7451C 80083D1C 8800B08F */  lw         $s0, 0x88($sp)
    /* 74520 80083D20 0800E003 */  jr         $ra
    /* 74524 80083D24 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel Camera_PitchAndRoll__Fi
