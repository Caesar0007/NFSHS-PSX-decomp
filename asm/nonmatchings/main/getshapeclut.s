.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getshapeclut, 0x58

glabel getshapeclut
    /* E743C 800F6C3C 11008010 */  beqz       $a0, .L800F6C84
    /* E7440 800F6C40 23000624 */   addiu     $a2, $zero, 0x23
    /* E7444 800F6C44 00FF0524 */  addiu      $a1, $zero, -0x100
  .L800F6C48:
    /* E7448 800F6C48 00008290 */  lbu        $v0, 0x0($a0)
    /* E744C 800F6C4C 00000000 */  nop
    /* E7450 800F6C50 0E004610 */  beq        $v0, $a2, .L800F6C8C
    /* E7454 800F6C54 21108000 */   addu      $v0, $a0, $zero
    /* E7458 800F6C58 0000838C */  lw         $v1, 0x0($a0)
    /* E745C 800F6C5C 00000000 */  nop
    /* E7460 800F6C60 24106500 */  and        $v0, $v1, $a1
    /* E7464 800F6C64 03004010 */  beqz       $v0, .L800F6C74
    /* E7468 800F6C68 03120300 */   sra       $v0, $v1, 8
    /* E746C 800F6C6C 1EDB0308 */  j          .L800F6C78
    /* E7470 800F6C70 21108200 */   addu      $v0, $a0, $v0
  .L800F6C74:
    /* E7474 800F6C74 21100000 */  addu       $v0, $zero, $zero
  .L800F6C78:
    /* E7478 800F6C78 21204000 */  addu       $a0, $v0, $zero
    /* E747C 800F6C7C F2FF8014 */  bnez       $a0, .L800F6C48
    /* E7480 800F6C80 00000000 */   nop
  .L800F6C84:
    /* E7484 800F6C84 0800E003 */  jr         $ra
    /* E7488 800F6C88 21100000 */   addu      $v0, $zero, $zero
  .L800F6C8C:
    /* E748C 800F6C8C 0800E003 */  jr         $ra
    /* E7490 800F6C90 00000000 */   nop
endlabel getshapeclut
