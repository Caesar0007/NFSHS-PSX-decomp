.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HookEntryInt, 0xC

glabel HookEntryInt
    /* F6E9C 8010669C B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F6EA0 801066A0 08004001 */  jr         $t2
    /* F6EA4 801066A4 19000924 */   addiu     $t1, $zero, 0x19
endlabel HookEntryInt
    /* F6EA8 801066A8 00000000 */  nop
