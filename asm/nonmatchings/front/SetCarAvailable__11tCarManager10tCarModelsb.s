.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetCarAvailable__11tCarManager10tCarModelsb, 0x1C

glabel SetCarAvailable__11tCarManager10tCarModelsb
    /* 75EC 80016DEC 21208500 */  addu       $a0, $a0, $a1
    /* 75F0 80016DF0 0300C010 */  beqz       $a2, .L80016E00
    /* 75F4 80016DF4 080286A0 */   sb        $a2, 0x208($a0)
    /* 75F8 80016DF8 01000224 */  addiu      $v0, $zero, 0x1
    /* 75FC 80016DFC 380282A0 */  sb         $v0, 0x238($a0)
  .L80016E00:
    /* 7600 80016E00 0800E003 */  jr         $ra
    /* 7604 80016E04 00000000 */   nop
endlabel SetCarAvailable__11tCarManager10tCarModelsb
