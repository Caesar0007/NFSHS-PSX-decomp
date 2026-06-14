.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_operror, 0x30

glabel FILE_operror
    /* DC61C 800EBE1C F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* DC620 800EBE20 21188000 */  addu       $v1, $a0, $zero
    /* DC624 800EBE24 1480043C */  lui        $a0, %hi(D_8013EAA0)
    /* DC628 800EBE28 021E0300 */  srl        $v1, $v1, 24
    /* DC62C 800EBE2C 40100300 */  sll        $v0, $v1, 1
    /* DC630 800EBE30 21104300 */  addu       $v0, $v0, $v1
    /* DC634 800EBE34 A0EA838C */  lw         $v1, %lo(D_8013EAA0)($a0)
    /* DC638 800EBE38 00110200 */  sll        $v0, $v0, 4
    /* DC63C 800EBE3C 21104300 */  addu       $v0, $v0, $v1
    /* DC640 800EBE40 0C00428C */  lw         $v0, 0xC($v0)
    /* DC644 800EBE44 0800E003 */  jr         $ra
    /* DC648 800EBE48 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel FILE_operror
