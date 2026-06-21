.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_event_read, 0x28

glabel _cd_event_read
    /* F99A8 801091A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F99AC 801091AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* F99B0 801091B0 00F0043C */  lui        $a0, (0xF0000003 >> 16)
    /* F99B4 801091B4 03008434 */  ori        $a0, $a0, (0xF0000003 & 0xFFFF)
    /* F99B8 801091B8 BE31040C */  jal        DeliverEvent
    /* F99BC 801091BC 40000524 */   addiu     $a1, $zero, 0x40
    /* F99C0 801091C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* F99C4 801091C4 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F99C8 801091C8 0800E003 */  jr         $ra
    /* F99CC 801091CC 00000000 */   nop
endlabel _cd_event_read
    /* F99D0 801091D0 00000000 */  nop
    /* F99D4 801091D4 00000000 */  nop
    /* F99D8 801091D8 00000000 */  nop
