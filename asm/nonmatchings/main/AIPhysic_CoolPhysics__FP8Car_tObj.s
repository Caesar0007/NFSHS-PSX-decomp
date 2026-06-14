.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CoolPhysics__FP8Car_tObj, 0xB4

glabel AIPhysic_CoolPhysics__FP8Car_tObj
    /* 5AF18 8006A718 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5AF1C 8006A71C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5AF20 8006A720 21808000 */  addu       $s0, $a0, $zero
    /* 5AF24 8006A724 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5AF28 8006A728 7005028E */  lw         $v0, 0x570($s0)
    /* 5AF2C 8006A72C 00000000 */  nop
    /* 5AF30 8006A730 10004234 */  ori        $v0, $v0, 0x10
    /* 5AF34 8006A734 F3A9010C */  jal        AIPhysic_HandleDirection__FP8Car_tObj
    /* 5AF38 8006A738 700502AE */   sw        $v0, 0x570($s0)
    /* 5AF3C 8006A73C 5405038E */  lw         $v1, 0x554($s0)
    /* 5AF40 8006A740 6405028E */  lw         $v0, 0x564($s0)
    /* 5AF44 8006A744 00000000 */  nop
    /* 5AF48 8006A748 18006200 */  mult       $v1, $v0
    /* 5AF4C 8006A74C 12300000 */  mflo       $a2
    /* 5AF50 8006A750 0600C104 */  bgez       $a2, .L8006A76C
    /* 5AF54 8006A754 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 5AF58 8006A758 F006038E */  lw         $v1, 0x6F0($s0)
    /* 5AF5C 8006A75C 00000000 */  nop
    /* 5AF60 8006A760 02006210 */  beq        $v1, $v0, .L8006A76C
    /* 5AF64 8006A764 00000000 */   nop
    /* 5AF68 8006A768 180700AE */  sw         $zero, 0x718($s0)
  .L8006A76C:
    /* 5AF6C 8006A76C 1CB2010C */  jal        AIPhysic_HitWallCheck__FP8Car_tObj
    /* 5AF70 8006A770 21200002 */   addu      $a0, $s0, $zero
    /* 5AF74 8006A774 03004010 */  beqz       $v0, .L8006A784
    /* 5AF78 8006A778 21200002 */   addu      $a0, $s0, $zero
    /* 5AF7C 8006A77C 7CB2010C */  jal        AIPhysic_ChangeDirection__FP8Car_tObji
    /* 5AF80 8006A780 40000524 */   addiu     $a1, $zero, 0x40
  .L8006A784:
    /* 5AF84 8006A784 2DAA010C */  jal        AIPhysic_Preperation__FP8Car_tObj
    /* 5AF88 8006A788 21200002 */   addu      $a0, $s0, $zero
    /* 5AF8C 8006A78C 98AC010C */  jal        AIPhysic_CheckIfOutOfControl__FP8Car_tObj
    /* 5AF90 8006A790 21200002 */   addu      $a0, $s0, $zero
    /* 5AF94 8006A794 05004010 */  beqz       $v0, .L8006A7AC
    /* 5AF98 8006A798 00000000 */   nop
    /* 5AF9C 8006A79C 00AD010C */  jal        AIPhysic_OutOfControlPhysics__FP8Car_tObj
    /* 5AFA0 8006A7A0 21200002 */   addu      $a0, $s0, $zero
    /* 5AFA4 8006A7A4 EDA90108 */  j          .L8006A7B4
    /* 5AFA8 8006A7A8 00000000 */   nop
  .L8006A7AC:
    /* 5AFAC 8006A7AC B2AE010C */  jal        AIPhysic_InControlPhysics__FP8Car_tObj
    /* 5AFB0 8006A7B0 21200002 */   addu      $a0, $s0, $zero
  .L8006A7B4:
    /* 5AFB4 8006A7B4 DFB0010C */  jal        AIPhysic_FinishUp__FP8Car_tObj
    /* 5AFB8 8006A7B8 21200002 */   addu      $a0, $s0, $zero
    /* 5AFBC 8006A7BC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5AFC0 8006A7C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 5AFC4 8006A7C4 0800E003 */  jr         $ra
    /* 5AFC8 8006A7C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_CoolPhysics__FP8Car_tObj
