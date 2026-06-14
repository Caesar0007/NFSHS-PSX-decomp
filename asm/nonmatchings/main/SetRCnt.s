.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetRCnt, 0x9C

glabel SetRCnt
    /* DA670 800E9E70 FFFF8830 */  andi       $t0, $a0, 0xFFFF
    /* DA674 800E9E74 03000229 */  slti       $v0, $t0, 0x3
    /* DA678 800E9E78 03004014 */  bnez       $v0, .L800E9E88
    /* DA67C 800E9E7C 48000724 */   addiu     $a3, $zero, 0x48
    /* DA680 800E9E80 C1A70308 */  j          .L800E9F04
    /* DA684 800E9E84 21100000 */   addu      $v0, $zero, $zero
  .L800E9E88:
    /* DA688 800E9E88 1280023C */  lui        $v0, %hi(D_801234B8)
    /* DA68C 800E9E8C B834428C */  lw         $v0, %lo(D_801234B8)($v0)
    /* DA690 800E9E90 00190800 */  sll        $v1, $t0, 4
    /* DA694 800E9E94 21186200 */  addu       $v1, $v1, $v0
    /* DA698 800E9E98 0200022D */  sltiu      $v0, $t0, 0x2
    /* DA69C 800E9E9C 040060A4 */  sh         $zero, 0x4($v1)
    /* DA6A0 800E9EA0 080065A4 */  sh         $a1, 0x8($v1)
    /* DA6A4 800E9EA4 08004010 */  beqz       $v0, .L800E9EC8
    /* DA6A8 800E9EA8 1000C230 */   andi      $v0, $a2, 0x10
    /* DA6AC 800E9EAC 02004010 */  beqz       $v0, .L800E9EB8
    /* DA6B0 800E9EB0 0100C230 */   andi      $v0, $a2, 0x1
    /* DA6B4 800E9EB4 49000724 */  addiu      $a3, $zero, 0x49
  .L800E9EB8:
    /* DA6B8 800E9EB8 0A004014 */  bnez       $v0, .L800E9EE4
    /* DA6BC 800E9EBC 0010C230 */   andi      $v0, $a2, 0x1000
    /* DA6C0 800E9EC0 B9A70308 */  j          .L800E9EE4
    /* DA6C4 800E9EC4 0001E734 */   ori       $a3, $a3, 0x100
  .L800E9EC8:
    /* DA6C8 800E9EC8 02000224 */  addiu      $v0, $zero, 0x2
    /* DA6CC 800E9ECC 05000215 */  bne        $t0, $v0, .L800E9EE4
    /* DA6D0 800E9ED0 0010C230 */   andi      $v0, $a2, 0x1000
    /* DA6D4 800E9ED4 0100C230 */  andi       $v0, $a2, 0x1
    /* DA6D8 800E9ED8 02004014 */  bnez       $v0, .L800E9EE4
    /* DA6DC 800E9EDC 0010C230 */   andi      $v0, $a2, 0x1000
    /* DA6E0 800E9EE0 48020724 */  addiu      $a3, $zero, 0x248
  .L800E9EE4:
    /* DA6E4 800E9EE4 02004010 */  beqz       $v0, .L800E9EF0
    /* DA6E8 800E9EE8 01000224 */   addiu     $v0, $zero, 0x1
    /* DA6EC 800E9EEC 1000E734 */  ori        $a3, $a3, 0x10
  .L800E9EF0:
    /* DA6F0 800E9EF0 1280043C */  lui        $a0, %hi(D_801234B8)
    /* DA6F4 800E9EF4 B834848C */  lw         $a0, %lo(D_801234B8)($a0)
    /* DA6F8 800E9EF8 00190800 */  sll        $v1, $t0, 4
    /* DA6FC 800E9EFC 21186400 */  addu       $v1, $v1, $a0
    /* DA700 800E9F00 040067A4 */  sh         $a3, 0x4($v1)
  .L800E9F04:
    /* DA704 800E9F04 0800E003 */  jr         $ra
    /* DA708 800E9F08 00000000 */   nop
endlabel SetRCnt
