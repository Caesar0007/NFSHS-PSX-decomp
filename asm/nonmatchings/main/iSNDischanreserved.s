.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDischanreserved, 0x40

glabel iSNDischanreserved
    /* EEF24 800FE724 0D00A018 */  blez       $a1, .L800FE75C
    /* EEF28 800FE728 21180000 */   addu      $v1, $zero, $zero
    /* EEF2C 800FE72C 1480023C */  lui        $v0, %hi(sndchanreserved)
    /* EEF30 800FE730 14794624 */  addiu      $a2, $v0, %lo(sndchanreserved)
    /* EEF34 800FE734 21106600 */  addu       $v0, $v1, $a2
  .L800FE738:
    /* EEF38 800FE738 00004280 */  lb         $v0, 0x0($v0)
    /* EEF3C 800FE73C 00000000 */  nop
    /* EEF40 800FE740 03004414 */  bne        $v0, $a0, .L800FE750
    /* EEF44 800FE744 01006324 */   addiu     $v1, $v1, 0x1
    /* EEF48 800FE748 0800E003 */  jr         $ra
    /* EEF4C 800FE74C 01000224 */   addiu     $v0, $zero, 0x1
  .L800FE750:
    /* EEF50 800FE750 2A106500 */  slt        $v0, $v1, $a1
    /* EEF54 800FE754 F8FF4014 */  bnez       $v0, .L800FE738
    /* EEF58 800FE758 21106600 */   addu      $v0, $v1, $a2
  .L800FE75C:
    /* EEF5C 800FE75C 0800E003 */  jr         $ra
    /* EEF60 800FE760 21100000 */   addu      $v0, $zero, $zero
endlabel iSNDischanreserved
