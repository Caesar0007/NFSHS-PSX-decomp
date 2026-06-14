.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForBarriersAndTargetAroundThem__13AIState_Chase, 0x150

glabel CheckForBarriersAndTargetAroundThem__13AIState_Chase
    /* 613C4 80070BC4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 613C8 80070BC8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 613CC 80070BCC 21908000 */  addu       $s2, $a0, $zero
    /* 613D0 80070BD0 2000BFAF */  sw         $ra, 0x20($sp)
    /* 613D4 80070BD4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 613D8 80070BD8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 613DC 80070BDC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 613E0 80070BE0 6800438E */  lw         $v1, 0x68($s2)
    /* 613E4 80070BE4 F401023C */  lui        $v0, (0x1F40000 >> 16)
    /* 613E8 80070BE8 02006104 */  bgez       $v1, .L80070BF4
    /* 613EC 80070BEC 00000000 */   nop
    /* 613F0 80070BF0 23180300 */  negu       $v1, $v1
  .L80070BF4:
    /* 613F4 80070BF4 2A104300 */  slt        $v0, $v0, $v1
    /* 613F8 80070BF8 3F004014 */  bnez       $v0, .L80070CF8
    /* 613FC 80070BFC 06000724 */   addiu     $a3, $zero, 0x6
    /* 61400 80070C00 0000438E */  lw         $v1, 0x0($s2)
    /* 61404 80070C04 1480063C */  lui        $a2, %hi(BWorldSm_slices)
    /* 61408 80070C08 C0C7C68C */  lw         $a2, %lo(BWorldSm_slices)($a2)
    /* 6140C 80070C0C 08007384 */  lh         $s3, 0x8($v1)
    /* 61410 80070C10 C406708C */  lw         $s0, 0x6C4($v1)
    /* 61414 80070C14 4800438E */  lw         $v1, 0x48($s2)
    /* 61418 80070C18 40111300 */  sll        $v0, $s3, 5
    /* 6141C 80070C1C 21104600 */  addu       $v0, $v0, $a2
    /* 61420 80070C20 1D004590 */  lbu        $a1, 0x1D($v0)
    /* 61424 80070C24 08006484 */  lh         $a0, 0x8($v1)
    /* 61428 80070C28 C406718C */  lw         $s1, 0x6C4($v1)
    /* 6142C 80070C2C 02110500 */  srl        $v0, $a1, 4
    /* 61430 80070C30 2310E200 */  subu       $v0, $a3, $v0
    /* 61434 80070C34 2A100202 */  slt        $v0, $s0, $v0
    /* 61438 80070C38 2F004014 */  bnez       $v0, .L80070CF8
    /* 6143C 80070C3C 0F00A230 */   andi      $v0, $a1, 0xF
    /* 61440 80070C40 07004224 */  addiu      $v0, $v0, 0x7
    /* 61444 80070C44 2A105000 */  slt        $v0, $v0, $s0
    /* 61448 80070C48 2B004014 */  bnez       $v0, .L80070CF8
    /* 6144C 80070C4C 40110400 */   sll       $v0, $a0, 5
    /* 61450 80070C50 21104600 */  addu       $v0, $v0, $a2
    /* 61454 80070C54 1D004390 */  lbu        $v1, 0x1D($v0)
    /* 61458 80070C58 00000000 */  nop
    /* 6145C 80070C5C 02110300 */  srl        $v0, $v1, 4
    /* 61460 80070C60 2310E200 */  subu       $v0, $a3, $v0
    /* 61464 80070C64 2A102202 */  slt        $v0, $s1, $v0
    /* 61468 80070C68 23004014 */  bnez       $v0, .L80070CF8
    /* 6146C 80070C6C 0F006230 */   andi      $v0, $v1, 0xF
    /* 61470 80070C70 07004224 */  addiu      $v0, $v0, 0x7
    /* 61474 80070C74 2A105100 */  slt        $v0, $v0, $s1
    /* 61478 80070C78 1F004014 */  bnez       $v0, .L80070CF8
    /* 6147C 80070C7C 21282002 */   addu      $a1, $s1, $zero
    /* 61480 80070C80 16CD010C */  jal        AIWorld_CheckForBarrierBetweenLanes__Fiii
    /* 61484 80070C84 21300002 */   addu      $a2, $s0, $zero
    /* 61488 80070C88 21206002 */  addu       $a0, $s3, $zero
    /* 6148C 80070C8C 21282002 */  addu       $a1, $s1, $zero
    /* 61490 80070C90 21300002 */  addu       $a2, $s0, $zero
    /* 61494 80070C94 16CD010C */  jal        AIWorld_CheckForBarrierBetweenLanes__Fiii
    /* 61498 80070C98 21804000 */   addu      $s0, $v0, $zero
    /* 6149C 80070C9C 15000012 */  beqz       $s0, .L80070CF4
    /* 614A0 80070CA0 00000000 */   nop
    /* 614A4 80070CA4 0C004014 */  bnez       $v0, .L80070CD8
    /* 614A8 80070CA8 21282002 */   addu      $a1, $s1, $zero
    /* 614AC 80070CAC 0000448E */  lw         $a0, 0x0($s2)
    /* 614B0 80070CB0 C75E010C */  jal        AI_TargetLane__FP8Car_tObji
    /* 614B4 80070CB4 900040AE */   sw        $zero, 0x90($s2)
    /* 614B8 80070CB8 0000448E */  lw         $a0, 0x0($s2)
    /* 614BC 80070CBC C75E010C */  jal        AI_TargetLane__FP8Car_tObji
    /* 614C0 80070CC0 21282002 */   addu      $a1, $s1, $zero
    /* 614C4 80070CC4 0000448E */  lw         $a0, 0x0($s2)
    /* 614C8 80070CC8 C75E010C */  jal        AI_TargetLane__FP8Car_tObji
    /* 614CC 80070CCC 21282002 */   addu      $a1, $s1, $zero
    /* 614D0 80070CD0 3EC30108 */  j          .L80070CF8
    /* 614D4 80070CD4 00000000 */   nop
  .L80070CD8:
    /* 614D8 80070CD8 9000428E */  lw         $v0, 0x90($s2)
    /* 614DC 80070CDC 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 614E0 80070CE0 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 614E4 80070CE4 00000000 */  nop
    /* 614E8 80070CE8 21104300 */  addu       $v0, $v0, $v1
    /* 614EC 80070CEC 3EC30108 */  j          .L80070CF8
    /* 614F0 80070CF0 900042AE */   sw        $v0, 0x90($s2)
  .L80070CF4:
    /* 614F4 80070CF4 900040AE */  sw         $zero, 0x90($s2)
  .L80070CF8:
    /* 614F8 80070CF8 2000BF8F */  lw         $ra, 0x20($sp)
    /* 614FC 80070CFC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 61500 80070D00 1800B28F */  lw         $s2, 0x18($sp)
    /* 61504 80070D04 1400B18F */  lw         $s1, 0x14($sp)
    /* 61508 80070D08 1000B08F */  lw         $s0, 0x10($sp)
    /* 6150C 80070D0C 0800E003 */  jr         $ra
    /* 61510 80070D10 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CheckForBarriersAndTargetAroundThem__13AIState_Chase
