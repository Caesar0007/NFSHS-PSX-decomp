.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapetoclutid, 0x84

glabel shapetoclutid
    /* E7494 800F6C94 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E7498 800F6C98 1A008010 */  beqz       $a0, .L800F6D04
    /* E749C 800F6C9C 1000BFAF */   sw        $ra, 0x10($sp)
  .L800F6CA0:
    /* E74A0 800F6CA0 00008290 */  lbu        $v0, 0x0($a0)
    /* E74A4 800F6CA4 23000324 */  addiu      $v1, $zero, 0x23
    /* E74A8 800F6CA8 F7004230 */  andi       $v0, $v0, 0xF7
    /* E74AC 800F6CAC 0B004314 */  bne        $v0, $v1, .L800F6CDC
    /* E74B0 800F6CB0 00000000 */   nop
    /* E74B4 800F6CB4 0C00848C */  lw         $a0, 0xC($a0)
    /* E74B8 800F6CB8 00000000 */  nop
    /* E74BC 800F6CBC 00290400 */  sll        $a1, $a0, 4
    /* E74C0 800F6CC0 00250400 */  sll        $a0, $a0, 20
    /* E74C4 800F6CC4 03250400 */  sra        $a0, $a0, 20
    /* E74C8 800F6CC8 14D1030C */  jal        GetClut
    /* E74CC 800F6CCC 032D0500 */   sra       $a1, $a1, 20
    /* E74D0 800F6CD0 00140200 */  sll        $v0, $v0, 16
    /* E74D4 800F6CD4 42DB0308 */  j          .L800F6D08
    /* E74D8 800F6CD8 03140200 */   sra       $v0, $v0, 16
  .L800F6CDC:
    /* E74DC 800F6CDC 0000838C */  lw         $v1, 0x0($a0)
    /* E74E0 800F6CE0 00FF0224 */  addiu      $v0, $zero, -0x100
    /* E74E4 800F6CE4 24106200 */  and        $v0, $v1, $v0
    /* E74E8 800F6CE8 03004010 */  beqz       $v0, .L800F6CF8
    /* E74EC 800F6CEC 03120300 */   sra       $v0, $v1, 8
    /* E74F0 800F6CF0 3FDB0308 */  j          .L800F6CFC
    /* E74F4 800F6CF4 21208200 */   addu      $a0, $a0, $v0
  .L800F6CF8:
    /* E74F8 800F6CF8 21200000 */  addu       $a0, $zero, $zero
  .L800F6CFC:
    /* E74FC 800F6CFC E8FF8014 */  bnez       $a0, .L800F6CA0
    /* E7500 800F6D00 00000000 */   nop
  .L800F6D04:
    /* E7504 800F6D04 21100000 */  addu       $v0, $zero, $zero
  .L800F6D08:
    /* E7508 800F6D08 1000BF8F */  lw         $ra, 0x10($sp)
    /* E750C 800F6D0C 00000000 */  nop
    /* E7510 800F6D10 0800E003 */  jr         $ra
    /* E7514 800F6D14 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel shapetoclutid
