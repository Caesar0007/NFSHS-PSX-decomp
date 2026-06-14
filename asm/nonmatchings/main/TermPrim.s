.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TermPrim, 0x18

glabel TermPrim
    /* F7820 80107020 FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* F7824 80107024 0000828C */  lw         $v0, 0x0($a0)
    /* F7828 80107028 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* F782C 8010702C 25104300 */  or         $v0, $v0, $v1
    /* F7830 80107030 0800E003 */  jr         $ra
    /* F7834 80107034 000082AC */   sw        $v0, 0x0($a0)
endlabel TermPrim
    /* F7838 80107038 00000000 */  nop
    /* F783C 8010703C 00000000 */  nop
