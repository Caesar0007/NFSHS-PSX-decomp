.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_ReplayUpdate__FiP15Camera_tCamSlot, 0x104

glabel Camera_ReplayUpdate__FiP15Camera_tCamSlot
    /* 763D0 80085BD0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 763D4 80085BD4 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 763D8 80085BD8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 763DC 80085BDC ACF25324 */  addiu      $s3, $v0, %lo(Camera_gInfo)
    /* 763E0 80085BE0 00110400 */  sll        $v0, $a0, 4
    /* 763E4 80085BE4 21104400 */  addu       $v0, $v0, $a0
    /* 763E8 80085BE8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 763EC 80085BEC 00910200 */  sll        $s2, $v0, 4
    /* 763F0 80085BF0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 763F4 80085BF4 21805302 */  addu       $s0, $s2, $s3
    /* 763F8 80085BF8 2000BFAF */  sw         $ra, 0x20($sp)
    /* 763FC 80085BFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 76400 80085C00 74000292 */  lbu        $v0, 0x74($s0)
    /* 76404 80085C04 00000000 */  nop
    /* 76408 80085C08 01004230 */  andi       $v0, $v0, 0x1
    /* 7640C 80085C0C 2A004014 */  bnez       $v0, .L80085CB8
    /* 76410 80085C10 2188A000 */   addu      $s1, $a1, $zero
    /* 76414 80085C14 00002592 */  lbu        $a1, 0x0($s1)
    /* 76418 80085C18 8215020C */  jal        Camera_SetMode__Fii
    /* 7641C 80085C1C 00000000 */   nop
    /* 76420 80085C20 FFF9053C */  lui        $a1, (0xF9FFFFFF >> 16)
    /* 76424 80085C24 FFFFA534 */  ori        $a1, $a1, (0xF9FFFFFF & 0xFFFF)
    /* 76428 80085C28 F7FF0424 */  addiu      $a0, $zero, -0x9
    /* 7642C 80085C2C 7400038E */  lw         $v1, 0x74($s0)
    /* 76430 80085C30 0000228E */  lw         $v0, 0x0($s1)
    /* 76434 80085C34 24186400 */  and        $v1, $v1, $a0
    /* 76438 80085C38 42110200 */  srl        $v0, $v0, 5
    /* 7643C 80085C3C 08004230 */  andi       $v0, $v0, 0x8
    /* 76440 80085C40 25186200 */  or         $v1, $v1, $v0
    /* 76444 80085C44 740003AE */  sw         $v1, 0x74($s0)
    /* 76448 80085C48 0000228E */  lw         $v0, 0x0($s1)
    /* 7644C 80085C4C 24186500 */  and        $v1, $v1, $a1
    /* 76450 80085C50 42120200 */  srl        $v0, $v0, 9
    /* 76454 80085C54 03004230 */  andi       $v0, $v0, 0x3
    /* 76458 80085C58 40160200 */  sll        $v0, $v0, 25
    /* 7645C 80085C5C 25186200 */  or         $v1, $v1, $v0
    /* 76460 80085C60 740003AE */  sw         $v1, 0x74($s0)
    /* 76464 80085C64 0000228E */  lw         $v0, 0x0($s1)
    /* 76468 80085C68 00000000 */  nop
    /* 7646C 80085C6C C2120200 */  srl        $v0, $v0, 11
    /* 76470 80085C70 07004230 */  andi       $v0, $v0, 0x7
    /* 76474 80085C74 7E0002A2 */  sb         $v0, 0x7E($s0)
    /* 76478 80085C78 02002386 */  lh         $v1, 0x2($s1)
    /* 7647C 80085C7C 0400288E */  lw         $t0, 0x4($s1)
    /* 76480 80085C80 0800298E */  lw         $t1, 0x8($s1)
    /* 76484 80085C84 0C002A8E */  lw         $t2, 0xC($s1)
    /* 76488 80085C88 080008AE */  sw         $t0, 0x8($s0)
    /* 7648C 80085C8C 0C0009AE */  sw         $t1, 0xC($s0)
    /* 76490 80085C90 10000AAE */  sw         $t2, 0x10($s0)
    /* 76494 80085C94 1000228E */  lw         $v0, 0x10($s1)
    /* 76498 80085C98 30006426 */  addiu      $a0, $s3, 0x30
    /* 7649C 80085C9C 2C0002AE */  sw         $v0, 0x2C($s0)
    /* 764A0 80085CA0 18002586 */  lh         $a1, 0x18($s1)
    /* 764A4 80085CA4 1A002686 */  lh         $a2, 0x1A($s1)
    /* 764A8 80085CA8 1C002786 */  lh         $a3, 0x1C($s1)
    /* 764AC 80085CAC 900283AF */  sw         $v1, %gp_rel(Camera_gGeomScreen)($gp)
    /* 764B0 80085CB0 8301020C */  jal        EulerToMat__FP10matrixtdefiii
    /* 764B4 80085CB4 21204402 */   addu      $a0, $s2, $a0
  .L80085CB8:
    /* 764B8 80085CB8 2000BF8F */  lw         $ra, 0x20($sp)
    /* 764BC 80085CBC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 764C0 80085CC0 1800B28F */  lw         $s2, 0x18($sp)
    /* 764C4 80085CC4 1400B18F */  lw         $s1, 0x14($sp)
    /* 764C8 80085CC8 1000B08F */  lw         $s0, 0x10($sp)
    /* 764CC 80085CCC 0800E003 */  jr         $ra
    /* 764D0 80085CD0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Camera_ReplayUpdate__FiP15Camera_tCamSlot
