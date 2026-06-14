.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FC4E4, 0x64

glabel func_800FC4E4
    /* ECCE4 800FC4E4 0C00828C */  lw         $v0, 0xC($a0)
    /* ECCE8 800FC4E8 FF00A330 */  andi       $v1, $a1, 0xFF
    /* ECCEC 800FC4EC 2A106200 */  slt        $v0, $v1, $v0
    /* ECCF0 800FC4F0 03004014 */  bnez       $v0, .L800FC500
    /* ECCF4 800FC4F4 40100300 */   sll       $v0, $v1, 1
    /* ECCF8 800FC4F8 0800E003 */  jr         $ra
    /* ECCFC 800FC4FC 21100000 */   addu      $v0, $zero, $zero
  .L800FC500:
    /* ECD00 800FC500 21104300 */  addu       $v0, $v0, $v1
    /* ECD04 800FC504 C0100200 */  sll        $v0, $v0, 3
    /* ECD08 800FC508 21104300 */  addu       $v0, $v0, $v1
    /* ECD0C 800FC50C 0800838C */  lw         $v1, 0x8($a0)
    /* ECD10 800FC510 80100200 */  sll        $v0, $v0, 2
    /* ECD14 800FC514 21206200 */  addu       $a0, $v1, $v0
    /* ECD18 800FC518 0000828C */  lw         $v0, 0x0($a0)
    /* ECD1C 800FC51C 00000000 */  nop
    /* ECD20 800FC520 0700A214 */  bne        $a1, $v0, .L800FC540
    /* ECD24 800FC524 21100000 */   addu      $v0, $zero, $zero
    /* ECD28 800FC528 0400838C */  lw         $v1, 0x4($a0)
    /* ECD2C 800FC52C 00000000 */  nop
    /* ECD30 800FC530 03006010 */  beqz       $v1, .L800FC540
    /* ECD34 800FC534 00000000 */   nop
    /* ECD38 800FC538 0800E003 */  jr         $ra
    /* ECD3C 800FC53C 21108000 */   addu      $v0, $a0, $zero
  .L800FC540:
    /* ECD40 800FC540 0800E003 */  jr         $ra
    /* ECD44 800FC544 00000000 */   nop
endlabel func_800FC4E4
