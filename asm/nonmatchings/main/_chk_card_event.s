.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _chk_card_event, 0x3C

glabel _chk_card_event
    /* FA388 80109B88 1580023C */  lui        $v0, %hi(D_80148A10)
    /* FA38C 80109B8C 108A428C */  lw         $v0, %lo(D_80148A10)($v0)
    /* FA390 80109B90 1580043C */  lui        $a0, %hi(D_80148A0C)
    /* FA394 80109B94 0C8A848C */  lw         $a0, %lo(D_80148A0C)($a0)
    /* FA398 80109B98 1580033C */  lui        $v1, %hi(D_80148A14)
    /* FA39C 80109B9C 148A638C */  lw         $v1, %lo(D_80148A14)($v1)
    /* FA3A0 80109BA0 40100200 */  sll        $v0, $v0, 1
    /* FA3A4 80109BA4 21208200 */  addu       $a0, $a0, $v0
    /* FA3A8 80109BA8 80180300 */  sll        $v1, $v1, 2
    /* FA3AC 80109BAC 1580023C */  lui        $v0, %hi(D_80148A18)
    /* FA3B0 80109BB0 188A428C */  lw         $v0, %lo(D_80148A18)($v0)
    /* FA3B4 80109BB4 21208300 */  addu       $a0, $a0, $v1
    /* FA3B8 80109BB8 C0100200 */  sll        $v0, $v0, 3
    /* FA3BC 80109BBC 0800E003 */  jr         $ra
    /* FA3C0 80109BC0 21108200 */   addu      $v0, $a0, $v0
endlabel _chk_card_event
