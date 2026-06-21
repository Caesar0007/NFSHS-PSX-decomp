.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_event_ready, 0x28

glabel _cd_event_ready
    /* F9980 80109180 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9984 80109184 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9988 80109188 00F0043C */  lui        $a0, (0xF0000003 >> 16)
    /* F998C 8010918C 03008434 */  ori        $a0, $a0, (0xF0000003 & 0xFFFF)
    /* F9990 80109190 BE31040C */  jal        DeliverEvent
    /* F9994 80109194 40000524 */   addiu     $a1, $zero, 0x40
    /* F9998 80109198 1000BF8F */  lw         $ra, 0x10($sp)
    /* F999C 8010919C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F99A0 801091A0 0800E003 */  jr         $ra
    /* F99A4 801091A4 00000000 */   nop
endlabel _cd_event_ready
