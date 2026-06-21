.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching queuefetch, 0x4C

glabel queuefetch
    /* E1374 800F0B74 00600540 */  mfc0       $a1, $12 /* handwritten instruction */
    /* E1378 800F0B78 00000000 */  nop
    /* E137C 800F0B7C FEFB0124 */  addiu      $at, $zero, -0x402
    /* E1380 800F0B80 2440A100 */  and        $t0, $a1, $at
    /* E1384 800F0B84 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* E1388 800F0B88 00000000 */  nop
    /* E138C 800F0B8C 00000000 */  nop
    /* E1390 800F0B90 00000000 */  nop
    /* E1394 800F0B94 0000828C */  lw         $v0, 0x0($a0)
    /* E1398 800F0B98 00000000 */  nop
    /* E139C 800F0B9C 05004010 */  beqz       $v0, .L800F0BB4
    /* E13A0 800F0BA0 21180000 */   addu      $v1, $zero, $zero
    /* E13A4 800F0BA4 21184000 */  addu       $v1, $v0, $zero
    /* E13A8 800F0BA8 0400628C */  lw         $v0, 0x4($v1)
    /* E13AC 800F0BAC 00000000 */  nop
    /* E13B0 800F0BB0 000082AC */  sw         $v0, 0x0($a0)
  .L800F0BB4:
    /* E13B4 800F0BB4 00608540 */  mtc0       $a1, $12 /* handwritten instruction */
    /* E13B8 800F0BB8 0800E003 */  jr         $ra
    /* E13BC 800F0BBC 21106000 */   addu      $v0, $v1, $zero
endlabel queuefetch
