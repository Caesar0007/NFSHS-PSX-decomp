.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DeliverEvent, 0xC

glabel DeliverEvent
    /* FCEF8 8010C6F8 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FCEFC 8010C6FC 08004001 */  jr         $t2
    /* FCF00 8010C700 07000924 */   addiu     $t1, $zero, 0x7
endlabel DeliverEvent
    /* FCF04 8010C704 00000000 */  nop
