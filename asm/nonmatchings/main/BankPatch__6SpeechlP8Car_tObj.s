.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BankPatch__6SpeechlP8Car_tObj, 0x3C

glabel BankPatch__6SpeechlP8Car_tObj
    /* 863E4 80095BE4 7803828C */  lw         $v0, 0x378($a0)
    /* 863E8 80095BE8 00000000 */  nop
    /* 863EC 80095BEC 0300A214 */  bne        $a1, $v0, .L80095BFC
    /* 863F0 80095BF0 00000000 */   nop
    /* 863F4 80095BF4 0800E003 */  jr         $ra
    /* 863F8 80095BF8 15000224 */   addiu     $v0, $zero, 0x15
  .L80095BFC:
    /* 863FC 80095BFC 7403838C */  lw         $v1, 0x374($a0)
    /* 86400 80095C00 00000000 */  nop
    /* 86404 80095C04 0400A314 */  bne        $a1, $v1, .L80095C18
    /* 86408 80095C08 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8640C 80095C0C 0200C010 */  beqz       $a2, .L80095C18
    /* 86410 80095C10 13000224 */   addiu     $v0, $zero, 0x13
    /* 86414 80095C14 14000224 */  addiu      $v0, $zero, 0x14
  .L80095C18:
    /* 86418 80095C18 0800E003 */  jr         $ra
    /* 8641C 80095C1C 00000000 */   nop
endlabel BankPatch__6SpeechlP8Car_tObj
