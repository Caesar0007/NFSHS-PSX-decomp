.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching init_ring_status, 0x34

glabel init_ring_status
    /* F8F58 80108758 0A00A010 */  beqz       $a1, .L80108784
    /* F8F5C 8010875C 21300000 */   addu      $a2, $zero, $zero
  .L80108760:
    /* F8F60 80108760 2110C400 */  addu       $v0, $a2, $a0
    /* F8F64 80108764 0100C624 */  addiu      $a2, $a2, 0x1
    /* F8F68 80108768 1480033C */  lui        $v1, %hi(StRingAddr)
    /* F8F6C 8010876C AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* F8F70 80108770 40110200 */  sll        $v0, $v0, 5
    /* F8F74 80108774 21186200 */  addu       $v1, $v1, $v0
    /* F8F78 80108778 2B10C500 */  sltu       $v0, $a2, $a1
    /* F8F7C 8010877C F8FF4014 */  bnez       $v0, .L80108760
    /* F8F80 80108780 000060AC */   sw        $zero, 0x0($v1)
  .L80108784:
    /* F8F84 80108784 0800E003 */  jr         $ra
    /* F8F88 80108788 00000000 */   nop
endlabel init_ring_status
    /* F8F8C 8010878C 00000000 */  nop
    /* F8F90 80108790 00000000 */  nop
    /* F8F94 80108794 00000000 */  nop
