.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_Put__FiP14Input_tResults, 0x118

glabel SimQueue_Put__FiP14Input_tResults
    /* A7BCC 800B73CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A7BD0 800B73D0 1800B2AF */  sw         $s2, 0x18($sp)
    /* A7BD4 800B73D4 21908000 */  addu       $s2, $a0, $zero
    /* A7BD8 800B73D8 2000B4AF */  sw         $s4, 0x20($sp)
    /* A7BDC 800B73DC 21A0A000 */  addu       $s4, $a1, $zero
    /* A7BE0 800B73E0 1480023C */  lui        $v0, %hi(D_8013E0F4)
    /* A7BE4 800B73E4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A7BE8 800B73E8 F4E05324 */  addiu      $s3, $v0, %lo(D_8013E0F4)
    /* A7BEC 800B73EC 80101200 */  sll        $v0, $s2, 2
    /* A7BF0 800B73F0 1000B0AF */  sw         $s0, 0x10($sp)
    /* A7BF4 800B73F4 21805300 */  addu       $s0, $v0, $s3
    /* A7BF8 800B73F8 2400BFAF */  sw         $ra, 0x24($sp)
    /* A7BFC 800B73FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* A7C00 800B7400 0402028E */  lw         $v0, 0x204($s0)
    /* A7C04 800B7404 7EDD020C */  jal        SimQueue_IsBlocking__Fi
    /* A7C08 800B7408 1F005130 */   andi      $s1, $v0, 0x1F
    /* A7C0C 800B740C 2D004014 */  bnez       $v0, .L800B74C4
    /* A7C10 800B7410 21100000 */   addu      $v0, $zero, $zero
    /* A7C14 800B7414 80101100 */  sll        $v0, $s1, 2
    /* A7C18 800B7418 C0191200 */  sll        $v1, $s2, 7
    /* A7C1C 800B741C 21104300 */  addu       $v0, $v0, $v1
    /* A7C20 800B7420 21185300 */  addu       $v1, $v0, $s3
    /* A7C24 800B7424 0001628C */  lw         $v0, 0x100($v1)
    /* A7C28 800B7428 00000000 */  nop
    /* A7C2C 800B742C 25004014 */  bnez       $v0, .L800B74C4
    /* A7C30 800B7430 21100000 */   addu      $v0, $zero, $zero
    /* A7C34 800B7434 01000424 */  addiu      $a0, $zero, 0x1
    /* A7C38 800B7438 0300868A */  lwl        $a2, 0x3($s4)
    /* A7C3C 800B743C 0000869A */  lwr        $a2, 0x0($s4)
    /* A7C40 800B7440 00000000 */  nop
    /* A7C44 800B7444 030066A8 */  swl        $a2, 0x3($v1)
    /* A7C48 800B7448 000066B8 */  swr        $a2, 0x0($v1)
    /* A7C4C 800B744C 000164AC */  sw         $a0, 0x100($v1)
    /* A7C50 800B7450 0402028E */  lw         $v0, 0x204($s0)
    /* A7C54 800B7454 00000000 */  nop
    /* A7C58 800B7458 21104400 */  addu       $v0, $v0, $a0
    /* A7C5C 800B745C 040202AE */  sw         $v0, 0x204($s0)
    /* A7C60 800B7460 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A7C64 800B7464 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A7C68 800B7468 0C00438C */  lw         $v1, 0xC($v0)
    /* A7C6C 800B746C 00000000 */  nop
    /* A7C70 800B7470 08006010 */  beqz       $v1, .L800B7494
    /* A7C74 800B7474 00000000 */   nop
    /* A7C78 800B7478 11006414 */  bne        $v1, $a0, .L800B74C0
    /* A7C7C 800B747C 00000000 */   nop
    /* A7C80 800B7480 0F004012 */  beqz       $s2, .L800B74C0
    /* A7C84 800B7484 00000000 */   nop
    /* A7C88 800B7488 E80E828F */  lw         $v0, %gp_rel(gSimQueue_Ticker)($gp)
    /* A7C8C 800B748C 2FDD0208 */  j          .L800B74BC
    /* A7C90 800B7490 21104400 */   addu      $v0, $v0, $a0
  .L800B7494:
    /* A7C94 800B7494 C803428C */  lw         $v0, 0x3C8($v0)
    /* A7C98 800B7498 00000000 */  nop
    /* A7C9C 800B749C 02004228 */  slti       $v0, $v0, 0x2
    /* A7CA0 800B74A0 03004014 */  bnez       $v0, .L800B74B0
    /* A7CA4 800B74A4 00000000 */   nop
    /* A7CA8 800B74A8 06004012 */  beqz       $s2, .L800B74C4
    /* A7CAC 800B74AC 01000224 */   addiu     $v0, $zero, 0x1
  .L800B74B0:
    /* A7CB0 800B74B0 E80E828F */  lw         $v0, %gp_rel(gSimQueue_Ticker)($gp)
    /* A7CB4 800B74B4 00000000 */  nop
    /* A7CB8 800B74B8 01004224 */  addiu      $v0, $v0, 0x1
  .L800B74BC:
    /* A7CBC 800B74BC E80E82AF */  sw         $v0, %gp_rel(gSimQueue_Ticker)($gp)
  .L800B74C0:
    /* A7CC0 800B74C0 01000224 */  addiu      $v0, $zero, 0x1
  .L800B74C4:
    /* A7CC4 800B74C4 2400BF8F */  lw         $ra, 0x24($sp)
    /* A7CC8 800B74C8 2000B48F */  lw         $s4, 0x20($sp)
    /* A7CCC 800B74CC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A7CD0 800B74D0 1800B28F */  lw         $s2, 0x18($sp)
    /* A7CD4 800B74D4 1400B18F */  lw         $s1, 0x14($sp)
    /* A7CD8 800B74D8 1000B08F */  lw         $s0, 0x10($sp)
    /* A7CDC 800B74DC 0800E003 */  jr         $ra
    /* A7CE0 800B74E0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SimQueue_Put__FiP14Input_tResults
