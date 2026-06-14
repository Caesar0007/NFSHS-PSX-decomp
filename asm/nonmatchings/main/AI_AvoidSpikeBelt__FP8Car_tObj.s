.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_AvoidSpikeBelt__FP8Car_tObj, 0x88

glabel AI_AvoidSpikeBelt__FP8Car_tObj
    /* 4A15C 8005995C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4A160 80059960 2800B0AF */  sw         $s0, 0x28($sp)
    /* 4A164 80059964 21808000 */  addu       $s0, $a0, $zero
    /* 4A168 80059968 1800A427 */  addiu      $a0, $sp, 0x18
    /* 4A16C 8005996C 1C00A527 */  addiu      $a1, $sp, 0x1C
    /* 4A170 80059970 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 4A174 80059974 3EF6010C */  jal        BWorld_GetSpikeBelt__FPiN20
    /* 4A178 80059978 2000A627 */   addiu     $a2, $sp, 0x20
    /* 4A17C 8005997C 15004010 */  beqz       $v0, .L800599D4
    /* 4A180 80059980 00000000 */   nop
    /* 4A184 80059984 1800A48F */  lw         $a0, 0x18($sp)
    /* 4A188 80059988 65CC010C */  jal        AIWorld_ApxSplineDistance__FiP8Car_tObj
    /* 4A18C 8005998C 21280002 */   addu      $a1, $s0, $zero
    /* 4A190 80059990 5405038E */  lw         $v1, 0x554($s0)
    /* 4A194 80059994 00000000 */  nop
    /* 4A198 80059998 18004300 */  mult       $v0, $v1
    /* 4A19C 8005999C 6300023C */  lui        $v0, (0x63FFFE >> 16)
    /* 4A1A0 800599A0 FEFF4234 */  ori        $v0, $v0, (0x63FFFE & 0xFFFF)
    /* 4A1A4 800599A4 12400000 */  mflo       $t0
    /* 4A1A8 800599A8 FFFF0325 */  addiu      $v1, $t0, -0x1
    /* 4A1AC 800599AC 2B104300 */  sltu       $v0, $v0, $v1
    /* 4A1B0 800599B0 08004014 */  bnez       $v0, .L800599D4
    /* 4A1B4 800599B4 21200002 */   addu      $a0, $s0, $zero
    /* 4A1B8 800599B8 D8FF053C */  lui        $a1, (0xFFD80000 >> 16)
    /* 4A1BC 800599BC 1C00A68F */  lw         $a2, 0x1C($sp)
    /* 4A1C0 800599C0 2000A78F */  lw         $a3, 0x20($sp)
    /* 4A1C4 800599C4 1800A28F */  lw         $v0, 0x18($sp)
    /* 4A1C8 800599C8 2138C700 */  addu       $a3, $a2, $a3
    /* 4A1CC 800599CC 7966010C */  jal        AI_SubmitObstacle__FP8Car_tObjiiii
    /* 4A1D0 800599D0 1000A2AF */   sw        $v0, 0x10($sp)
  .L800599D4:
    /* 4A1D4 800599D4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 4A1D8 800599D8 2800B08F */  lw         $s0, 0x28($sp)
    /* 4A1DC 800599DC 0800E003 */  jr         $ra
    /* 4A1E0 800599E0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AI_AvoidSpikeBelt__FP8Car_tObj
