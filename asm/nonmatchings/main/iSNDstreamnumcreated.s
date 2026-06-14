.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamnumcreated, 0x38

glabel iSNDstreamnumcreated
    /* D9EF8 800E96F8 21280000 */  addu       $a1, $zero, $zero
    /* D9EFC 800E96FC 2120A000 */  addu       $a0, $a1, $zero
    /* D9F00 800E9700 1480023C */  lui        $v0, %hi(sndss)
    /* D9F04 800E9704 80EA4324 */  addiu      $v1, $v0, %lo(sndss)
  .L800E9708:
    /* D9F08 800E9708 0000628C */  lw         $v0, 0x0($v1)
    /* D9F0C 800E970C 00000000 */  nop
    /* D9F10 800E9710 02004010 */  beqz       $v0, .L800E971C
    /* D9F14 800E9714 00000000 */   nop
    /* D9F18 800E9718 0100A524 */  addiu      $a1, $a1, 0x1
  .L800E971C:
    /* D9F1C 800E971C 01008424 */  addiu      $a0, $a0, 0x1
    /* D9F20 800E9720 F9FF8018 */  blez       $a0, .L800E9708
    /* D9F24 800E9724 04006324 */   addiu     $v1, $v1, 0x4
    /* D9F28 800E9728 0800E003 */  jr         $ra
    /* D9F2C 800E972C 2110A000 */   addu      $v0, $a1, $zero
endlabel iSNDstreamnumcreated
