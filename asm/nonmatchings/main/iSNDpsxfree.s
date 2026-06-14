.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxfree, 0xB8

glabel iSNDpsxfree
    /* FAFC8 8010A7C8 21280000 */  addu       $a1, $zero, $zero
    /* FAFCC 8010A7CC 1480023C */  lui        $v0, %hi(sndpd)
    /* FAFD0 8010A7D0 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* FAFD4 8010A7D4 18056294 */  lhu        $v0, 0x518($v1)
    /* FAFD8 8010A7D8 00000000 */  nop
    /* FAFDC 8010A7DC 26004010 */  beqz       $v0, .L8010A878
    /* FAFE0 8010A7E0 83210400 */   sra       $a0, $a0, 6
    /* FAFE4 8010A7E4 20056724 */  addiu      $a3, $v1, 0x520
    /* FAFE8 8010A7E8 21306000 */  addu       $a2, $v1, $zero
    /* FAFEC 8010A7EC 80100500 */  sll        $v0, $a1, 2
  .L8010A7F0:
    /* FAFF0 8010A7F0 21104700 */  addu       $v0, $v0, $a3
    /* FAFF4 8010A7F4 00004294 */  lhu        $v0, 0x0($v0)
    /* FAFF8 8010A7F8 00000000 */  nop
    /* FAFFC 8010A7FC 19004414 */  bne        $v0, $a0, .L8010A864
    /* FB000 8010A800 00000000 */   nop
    /* FB004 8010A804 1805C294 */  lhu        $v0, 0x518($a2)
    /* FB008 8010A808 00000000 */  nop
    /* FB00C 8010A80C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FB010 8010A810 1805C2A4 */  sh         $v0, 0x518($a2)
    /* FB014 8010A814 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* FB018 8010A818 2A10A200 */  slt        $v0, $a1, $v0
    /* FB01C 8010A81C 0F004010 */  beqz       $v0, .L8010A85C
    /* FB020 8010A820 80180500 */   sll       $v1, $a1, 2
  .L8010A824:
    /* FB024 8010A824 21186600 */  addu       $v1, $v1, $a2
    /* FB028 8010A828 0100A424 */  addiu      $a0, $a1, 0x1
    /* FB02C 8010A82C 80100400 */  sll        $v0, $a0, 2
    /* FB030 8010A830 21104600 */  addu       $v0, $v0, $a2
    /* FB034 8010A834 23054888 */  lwl        $t0, 0x523($v0)
    /* FB038 8010A838 20054898 */  lwr        $t0, 0x520($v0)
    /* FB03C 8010A83C 00000000 */  nop
    /* FB040 8010A840 230568A8 */  swl        $t0, 0x523($v1)
    /* FB044 8010A844 200568B8 */  swr        $t0, 0x520($v1)
    /* FB048 8010A848 1805C294 */  lhu        $v0, 0x518($a2)
    /* FB04C 8010A84C 21288000 */  addu       $a1, $a0, $zero
    /* FB050 8010A850 2A10A200 */  slt        $v0, $a1, $v0
    /* FB054 8010A854 F3FF4014 */  bnez       $v0, .L8010A824
    /* FB058 8010A858 80180500 */   sll       $v1, $a1, 2
  .L8010A85C:
    /* FB05C 8010A85C 0800E003 */  jr         $ra
    /* FB060 8010A860 21100000 */   addu      $v0, $zero, $zero
  .L8010A864:
    /* FB064 8010A864 1805C294 */  lhu        $v0, 0x518($a2)
    /* FB068 8010A868 0100A524 */  addiu      $a1, $a1, 0x1
    /* FB06C 8010A86C 2A10A200 */  slt        $v0, $a1, $v0
    /* FB070 8010A870 DFFF4014 */  bnez       $v0, .L8010A7F0
    /* FB074 8010A874 80100500 */   sll       $v0, $a1, 2
  .L8010A878:
    /* FB078 8010A878 0800E003 */  jr         $ra
    /* FB07C 8010A87C F8FF0224 */   addiu     $v0, $zero, -0x8
endlabel iSNDpsxfree
