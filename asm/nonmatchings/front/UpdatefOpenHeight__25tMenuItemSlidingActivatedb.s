.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdatefOpenHeight__25tMenuItemSlidingActivatedb, 0x68

glabel UpdatefOpenHeight__25tMenuItemSlidingActivatedb
    /* E56C 8001DD6C 4400828C */  lw         $v0, 0x44($a0)
    /* E570 8001DD70 00000000 */  nop
    /* E574 8001DD74 04004010 */  beqz       $v0, .L8001DD88
    /* E578 8001DD78 00000000 */   nop
    /* E57C 8001DD7C 2A008294 */  lhu        $v0, 0x2A($a0)
    /* E580 8001DD80 65770008 */  j          .L8001DD94
    /* E584 8001DD84 FDFF4224 */   addiu     $v0, $v0, -0x3
  .L8001DD88:
    /* E588 8001DD88 2A008294 */  lhu        $v0, 0x2A($a0)
    /* E58C 8001DD8C 00000000 */  nop
    /* E590 8001DD90 03004224 */  addiu      $v0, $v0, 0x3
  .L8001DD94:
    /* E594 8001DD94 2A0082A4 */  sh         $v0, 0x2A($a0)
    /* E598 8001DD98 26008294 */  lhu        $v0, 0x26($a0)
    /* E59C 8001DD9C 2A008584 */  lh         $a1, 0x2A($a0)
    /* E5A0 8001DDA0 00140200 */  sll        $v0, $v0, 16
    /* E5A4 8001DDA4 031C0200 */  sra        $v1, $v0, 16
    /* E5A8 8001DDA8 43140200 */  sra        $v0, $v0, 17
    /* E5AC 8001DDAC 21186200 */  addu       $v1, $v1, $v0
    /* E5B0 8001DDB0 2A10A300 */  slt        $v0, $a1, $v1
    /* E5B4 8001DDB4 02004010 */  beqz       $v0, .L8001DDC0
    /* E5B8 8001DDB8 00000000 */   nop
    /* E5BC 8001DDBC 2118A000 */  addu       $v1, $a1, $zero
  .L8001DDC0:
    /* E5C0 8001DDC0 02006104 */  bgez       $v1, .L8001DDCC
    /* E5C4 8001DDC4 00000000 */   nop
    /* E5C8 8001DDC8 21180000 */  addu       $v1, $zero, $zero
  .L8001DDCC:
    /* E5CC 8001DDCC 0800E003 */  jr         $ra
    /* E5D0 8001DDD0 2A0083A4 */   sh        $v1, 0x2A($a0)
endlabel UpdatefOpenHeight__25tMenuItemSlidingActivatedb
