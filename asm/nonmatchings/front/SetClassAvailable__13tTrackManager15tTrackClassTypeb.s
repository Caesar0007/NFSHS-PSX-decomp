.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetClassAvailable__13tTrackManager15tTrackClassTypeb, 0x60

glabel SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 124A0 80021CA0 0000828C */  lw         $v0, 0x0($a0)
    /* 124A4 80021CA4 00000000 */  nop
    /* 124A8 80021CA8 13004010 */  beqz       $v0, .L80021CF8
    /* 124AC 80021CAC 21380000 */   addu      $a3, $zero, $zero
    /* 124B0 80021CB0 2140E000 */  addu       $t0, $a3, $zero
  .L80021CB4:
    /* 124B4 80021CB4 0400828C */  lw         $v0, 0x4($a0)
    /* 124B8 80021CB8 00000000 */  nop
    /* 124BC 80021CBC 21180201 */  addu       $v1, $t0, $v0
    /* 124C0 80021CC0 02006290 */  lbu        $v0, 0x2($v1)
    /* 124C4 80021CC4 00000000 */  nop
    /* 124C8 80021CC8 06004514 */  bne        $v0, $a1, .L80021CE4
    /* 124CC 80021CCC 00000000 */   nop
    /* 124D0 80021CD0 00006280 */  lb         $v0, 0x0($v1)
    /* 124D4 80021CD4 00000000 */  nop
    /* 124D8 80021CD8 80100200 */  sll        $v0, $v0, 2
    /* 124DC 80021CDC 21108200 */  addu       $v0, $a0, $v0
    /* 124E0 80021CE0 080046AC */  sw         $a2, 0x8($v0)
  .L80021CE4:
    /* 124E4 80021CE4 0000828C */  lw         $v0, 0x0($a0)
    /* 124E8 80021CE8 0100E724 */  addiu      $a3, $a3, 0x1
    /* 124EC 80021CEC 2B10E200 */  sltu       $v0, $a3, $v0
    /* 124F0 80021CF0 F0FF4014 */  bnez       $v0, .L80021CB4
    /* 124F4 80021CF4 30000825 */   addiu     $t0, $t0, 0x30
  .L80021CF8:
    /* 124F8 80021CF8 0800E003 */  jr         $ra
    /* 124FC 80021CFC 00000000 */   nop
endlabel SetClassAvailable__13tTrackManager15tTrackClassTypeb
