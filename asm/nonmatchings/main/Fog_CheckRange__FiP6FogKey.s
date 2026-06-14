.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_CheckRange__FiP6FogKey, 0x54

glabel Fog_CheckRange__FiP6FogKey
    /* D1398 800E0B98 0400A28C */  lw         $v0, 0x4($a1)
    /* D139C 800E0B9C 0200A684 */  lh         $a2, 0x2($a1)
    /* D13A0 800E0BA0 02004784 */  lh         $a3, 0x2($v0)
    /* D13A4 800E0BA4 00000000 */  nop
    /* D13A8 800E0BA8 2A10E600 */  slt        $v0, $a3, $a2
    /* D13AC 800E0BAC 07004010 */  beqz       $v0, .L800E0BCC
    /* D13B0 800E0BB0 2A108600 */   slt       $v0, $a0, $a2
    /* D13B4 800E0BB4 03004010 */  beqz       $v0, .L800E0BC4
    /* D13B8 800E0BB8 2A108700 */   slt       $v0, $a0, $a3
    /* D13BC 800E0BBC 09004010 */  beqz       $v0, .L800E0BE4
    /* D13C0 800E0BC0 21100000 */   addu      $v0, $zero, $zero
  .L800E0BC4:
    /* D13C4 800E0BC4 0800E003 */  jr         $ra
    /* D13C8 800E0BC8 2110A000 */   addu      $v0, $a1, $zero
  .L800E0BCC:
    /* D13CC 800E0BCC 05004014 */  bnez       $v0, .L800E0BE4
    /* D13D0 800E0BD0 21100000 */   addu      $v0, $zero, $zero
    /* D13D4 800E0BD4 2A188700 */  slt        $v1, $a0, $a3
    /* D13D8 800E0BD8 02006014 */  bnez       $v1, .L800E0BE4
    /* D13DC 800E0BDC 2110A000 */   addu      $v0, $a1, $zero
    /* D13E0 800E0BE0 21100000 */  addu       $v0, $zero, $zero
  .L800E0BE4:
    /* D13E4 800E0BE4 0800E003 */  jr         $ra
    /* D13E8 800E0BE8 00000000 */   nop
endlabel Fog_CheckRange__FiP6FogKey
