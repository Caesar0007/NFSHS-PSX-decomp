.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_DoReactionsAndBehavior__FP8Car_tObj, 0xC4

glabel AI_DoReactionsAndBehavior__FP8Car_tObj
    /* 48814 80058014 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 48818 80058018 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4881C 8005801C 21988000 */  addu       $s3, $a0, $zero
    /* 48820 80058020 2000BFAF */  sw         $ra, 0x20($sp)
    /* 48824 80058024 1800B2AF */  sw         $s2, 0x18($sp)
    /* 48828 80058028 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4882C 8005802C E55E010C */  jal        AI_DoReactions__FP8Car_tObj
    /* 48830 80058030 1000B0AF */   sw        $s0, 0x10($sp)
    /* 48834 80058034 21900000 */  addu       $s2, $zero, $zero
    /* 48838 80058038 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4883C 8005803C DCF95124 */  addiu      $s1, $v0, %lo(Cars_gList)
  .L80058040:
    /* 48840 80058040 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 48844 80058044 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 48848 80058048 00000000 */  nop
    /* 4884C 8005804C 2A104202 */  slt        $v0, $s2, $v0
    /* 48850 80058050 1A004010 */  beqz       $v0, .L800580BC
    /* 48854 80058054 00000000 */   nop
    /* 48858 80058058 0000308E */  lw         $s0, 0x0($s1)
    /* 4885C 8005805C 00000000 */  nop
    /* 48860 80058060 13007012 */  beq        $s3, $s0, .L800580B0
    /* 48864 80058064 00000000 */   nop
    /* 48868 80058068 91000292 */  lbu        $v0, 0x91($s0)
    /* 4886C 8005806C 00000000 */  nop
    /* 48870 80058070 0F004010 */  beqz       $v0, .L800580B0
    /* 48874 80058074 00000000 */   nop
    /* 48878 80058078 6002028E */  lw         $v0, 0x260($s0)
    /* 4887C 8005807C 00000000 */  nop
    /* 48880 80058080 04004230 */  andi       $v0, $v0, 0x4
    /* 48884 80058084 0A004010 */  beqz       $v0, .L800580B0
    /* 48888 80058088 21206002 */   addu      $a0, $s3, $zero
    /* 4888C 8005808C 755F010C */  jal        AI_CheckForPlayerActions__FP8Car_tObjT0
    /* 48890 80058090 21280002 */   addu      $a1, $s0, $zero
    /* 48894 80058094 6002628E */  lw         $v0, 0x260($s3)
    /* 48898 80058098 00000000 */  nop
    /* 4889C 8005809C 08004230 */  andi       $v0, $v0, 0x8
    /* 488A0 800580A0 03004010 */  beqz       $v0, .L800580B0
    /* 488A4 800580A4 21206002 */   addu      $a0, $s3, $zero
    /* 488A8 800580A8 3660010C */  jal        AI_OpponentBlockPlayer__FP8Car_tObjT0
    /* 488AC 800580AC 21280002 */   addu      $a1, $s0, $zero
  .L800580B0:
    /* 488B0 800580B0 04003126 */  addiu      $s1, $s1, 0x4
    /* 488B4 800580B4 10600108 */  j          .L80058040
    /* 488B8 800580B8 01005226 */   addiu     $s2, $s2, 0x1
  .L800580BC:
    /* 488BC 800580BC 2000BF8F */  lw         $ra, 0x20($sp)
    /* 488C0 800580C0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 488C4 800580C4 1800B28F */  lw         $s2, 0x18($sp)
    /* 488C8 800580C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 488CC 800580CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 488D0 800580D0 0800E003 */  jr         $ra
    /* 488D4 800580D4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AI_DoReactionsAndBehavior__FP8Car_tObj
