.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeIngameCarList__11tCarManager, 0x80

glabel InitializeIngameCarList__11tCarManager
    /* 7D78 80017578 21280000 */  addu       $a1, $zero, $zero
    /* 7D7C 8001757C 0580023C */  lui        $v0, %hi(gCarSelected)
    /* 7D80 80017580 44154624 */  addiu      $a2, $v0, %lo(gCarSelected)
    /* 7D84 80017584 21200000 */  addu       $a0, $zero, $zero
  .L80017588:
    /* 7D88 80017588 001C0500 */  sll        $v1, $a1, 16
    /* 7D8C 8001758C 031C0300 */  sra        $v1, $v1, 16
    /* 7D90 80017590 40100300 */  sll        $v0, $v1, 1
    /* 7D94 80017594 21104300 */  addu       $v0, $v0, $v1
    /* 7D98 80017598 C0100200 */  sll        $v0, $v0, 3
    /* 7D9C 8001759C 21104300 */  addu       $v0, $v0, $v1
    /* 7DA0 800175A0 40180200 */  sll        $v1, $v0, 1
    /* 7DA4 800175A4 00140400 */  sll        $v0, $a0, 16
  .L800175A8:
    /* 7DA8 800175A8 03140200 */  sra        $v0, $v0, 16
    /* 7DAC 800175AC 21104300 */  addu       $v0, $v0, $v1
    /* 7DB0 800175B0 21104600 */  addu       $v0, $v0, $a2
    /* 7DB4 800175B4 000040A0 */  sb         $zero, 0x0($v0)
    /* 7DB8 800175B8 01008224 */  addiu      $v0, $a0, 0x1
    /* 7DBC 800175BC 21204000 */  addu       $a0, $v0, $zero
    /* 7DC0 800175C0 00140200 */  sll        $v0, $v0, 16
    /* 7DC4 800175C4 03140200 */  sra        $v0, $v0, 16
    /* 7DC8 800175C8 32004228 */  slti       $v0, $v0, 0x32
    /* 7DCC 800175CC F6FF4014 */  bnez       $v0, .L800175A8
    /* 7DD0 800175D0 00140400 */   sll       $v0, $a0, 16
    /* 7DD4 800175D4 0100A224 */  addiu      $v0, $a1, 0x1
    /* 7DD8 800175D8 21284000 */  addu       $a1, $v0, $zero
    /* 7DDC 800175DC 00140200 */  sll        $v0, $v0, 16
    /* 7DE0 800175E0 03140200 */  sra        $v0, $v0, 16
    /* 7DE4 800175E4 02004228 */  slti       $v0, $v0, 0x2
    /* 7DE8 800175E8 E7FF4014 */  bnez       $v0, .L80017588
    /* 7DEC 800175EC 21200000 */   addu      $a0, $zero, $zero
    /* 7DF0 800175F0 0800E003 */  jr         $ra
    /* 7DF4 800175F4 00000000 */   nop
endlabel InitializeIngameCarList__11tCarManager
