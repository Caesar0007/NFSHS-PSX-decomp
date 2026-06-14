.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching OpenEvent, 0xC

glabel OpenEvent
    /* F7620 80106E20 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* F7624 80106E24 08004001 */  jr         $t2
    /* F7628 80106E28 08000924 */   addiu     $t1, $zero, 0x8
endlabel OpenEvent
    /* F762C 80106E2C 00000000 */  nop
