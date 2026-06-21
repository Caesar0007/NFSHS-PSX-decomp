.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_event_sync, 0x28

glabel _cd_event_sync
    /* F9958 80109158 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F995C 8010915C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9960 80109160 00F0043C */  lui        $a0, (0xF0000003 >> 16)
    /* F9964 80109164 03008434 */  ori        $a0, $a0, (0xF0000003 & 0xFFFF)
    /* F9968 80109168 BE31040C */  jal        DeliverEvent
    /* F996C 8010916C 20000524 */   addiu     $a1, $zero, 0x20
    /* F9970 80109170 1000BF8F */  lw         $ra, 0x10($sp)
    /* F9974 80109174 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F9978 80109178 0800E003 */  jr         $ra
    /* F997C 8010917C 00000000 */   nop
endlabel _cd_event_sync
