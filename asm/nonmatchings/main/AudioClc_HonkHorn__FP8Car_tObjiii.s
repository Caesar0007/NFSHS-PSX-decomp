.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_HonkHorn__FP8Car_tObjiii, 0x60

glabel AudioClc_HonkHorn__FP8Car_tObjiii
    /* 64FA8 800747A8 21480000 */  addu       $t1, $zero, $zero
    /* 64FAC 800747AC 1180023C */  lui        $v0, %hi(AudioClc_gClosest)
    /* 64FB0 800747B0 48E34824 */  addiu      $t0, $v0, %lo(AudioClc_gClosest)
    /* 64FB4 800747B4 23380700 */  negu       $a3, $a3
    /* 64FB8 800747B8 2C000325 */  addiu      $v1, $t0, 0x2C
  .L800747BC:
    /* 64FBC 800747BC 0000028D */  lw         $v0, 0x0($t0)
    /* 64FC0 800747C0 00000000 */  nop
    /* 64FC4 800747C4 09004414 */  bne        $v0, $a0, .L800747EC
    /* 64FC8 800747C8 00000000 */   nop
    /* 64FCC 800747CC F4FF628C */  lw         $v0, -0xC($v1)
    /* 64FD0 800747D0 00000000 */  nop
    /* 64FD4 800747D4 05004014 */  bnez       $v0, .L800747EC
    /* 64FD8 800747D8 00000000 */   nop
    /* 64FDC 800747DC F4FF66AC */  sw         $a2, -0xC($v1)
    /* 64FE0 800747E0 F8FF66AC */  sw         $a2, -0x8($v1)
    /* 64FE4 800747E4 FCFF67AC */  sw         $a3, -0x4($v1)
    /* 64FE8 800747E8 000065AC */  sw         $a1, 0x0($v1)
  .L800747EC:
    /* 64FEC 800747EC 01002925 */  addiu      $t1, $t1, 0x1
    /* 64FF0 800747F0 38006324 */  addiu      $v1, $v1, 0x38
    /* 64FF4 800747F4 04002229 */  slti       $v0, $t1, 0x4
    /* 64FF8 800747F8 F0FF4014 */  bnez       $v0, .L800747BC
    /* 64FFC 800747FC 38000825 */   addiu     $t0, $t0, 0x38
    /* 65000 80074800 0800E003 */  jr         $ra
    /* 65004 80074804 00000000 */   nop
endlabel AudioClc_HonkHorn__FP8Car_tObjiii
