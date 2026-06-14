.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDserverremove100hzclient, 0xAC

glabel iSNDserverremove100hzclient
    /* DAE20 800EA620 21308000 */  addu       $a2, $a0, $zero
    /* DAE24 800EA624 1480023C */  lui        $v0, %hi(sndgs)
    /* DAE28 800EA628 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* DAE2C 800EA62C 40006280 */  lb         $v0, 0x40($v1)
    /* DAE30 800EA630 00000000 */  nop
    /* DAE34 800EA634 1C004018 */  blez       $v0, .L800EA6A8
    /* DAE38 800EA638 21200000 */   addu      $a0, $zero, $zero
    /* DAE3C 800EA63C 21286000 */  addu       $a1, $v1, $zero
    /* DAE40 800EA640 80100400 */  sll        $v0, $a0, 2
  .L800EA644:
    /* DAE44 800EA644 21104500 */  addu       $v0, $v0, $a1
    /* DAE48 800EA648 4C00428C */  lw         $v0, 0x4C($v0)
    /* DAE4C 800EA64C 00000000 */  nop
    /* DAE50 800EA650 17004614 */  bne        $v0, $a2, .L800EA6B0
    /* DAE54 800EA654 00000000 */   nop
    /* DAE58 800EA658 4000A290 */  lbu        $v0, 0x40($a1)
    /* DAE5C 800EA65C 00000000 */  nop
    /* DAE60 800EA660 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DAE64 800EA664 4000A2A0 */  sb         $v0, 0x40($a1)
    /* DAE68 800EA668 00160200 */  sll        $v0, $v0, 24
    /* DAE6C 800EA66C 03160200 */  sra        $v0, $v0, 24
    /* DAE70 800EA670 2A108200 */  slt        $v0, $a0, $v0
    /* DAE74 800EA674 0C004010 */  beqz       $v0, .L800EA6A8
    /* DAE78 800EA678 80180400 */   sll       $v1, $a0, 2
  .L800EA67C:
    /* DAE7C 800EA67C 01008424 */  addiu      $a0, $a0, 0x1
    /* DAE80 800EA680 80100400 */  sll        $v0, $a0, 2
    /* DAE84 800EA684 21104500 */  addu       $v0, $v0, $a1
    /* DAE88 800EA688 4C00428C */  lw         $v0, 0x4C($v0)
    /* DAE8C 800EA68C 21186500 */  addu       $v1, $v1, $a1
    /* DAE90 800EA690 4C0062AC */  sw         $v0, 0x4C($v1)
    /* DAE94 800EA694 4000A280 */  lb         $v0, 0x40($a1)
    /* DAE98 800EA698 00000000 */  nop
    /* DAE9C 800EA69C 2A108200 */  slt        $v0, $a0, $v0
    /* DAEA0 800EA6A0 F6FF4014 */  bnez       $v0, .L800EA67C
    /* DAEA4 800EA6A4 80180400 */   sll       $v1, $a0, 2
  .L800EA6A8:
    /* DAEA8 800EA6A8 0800E003 */  jr         $ra
    /* DAEAC 800EA6AC 00000000 */   nop
  .L800EA6B0:
    /* DAEB0 800EA6B0 4000A280 */  lb         $v0, 0x40($a1)
    /* DAEB4 800EA6B4 01008424 */  addiu      $a0, $a0, 0x1
    /* DAEB8 800EA6B8 2A108200 */  slt        $v0, $a0, $v0
    /* DAEBC 800EA6BC E1FF4014 */  bnez       $v0, .L800EA644
    /* DAEC0 800EA6C0 80100400 */   sll       $v0, $a0, 2
    /* DAEC4 800EA6C4 0800E003 */  jr         $ra
    /* DAEC8 800EA6C8 00000000 */   nop
endlabel iSNDserverremove100hzclient
