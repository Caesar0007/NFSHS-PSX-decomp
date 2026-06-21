.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseDescription__11tCarManager, 0x40

glabel ReleaseDescription__11tCarManager
    /* 7AF4 800172F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7AF8 800172F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7AFC 800172FC 21808000 */  addu       $s0, $a0, $zero
    /* 7B00 80017300 1400BFAF */  sw         $ra, 0x14($sp)
    /* 7B04 80017304 0400048E */  lw         $a0, 0x4($s0)
    /* 7B08 80017308 00000000 */  nop
    /* 7B0C 8001730C 03008010 */  beqz       $a0, .L8001731C
    /* 7B10 80017310 00000000 */   nop
    /* 7B14 80017314 5095030C */  jal        purgememadr
    /* 7B18 80017318 00000000 */   nop
  .L8001731C:
    /* 7B1C 8001731C 040000AE */  sw         $zero, 0x4($s0)
    /* 7B20 80017320 000000AE */  sw         $zero, 0x0($s0)
    /* 7B24 80017324 1400BF8F */  lw         $ra, 0x14($sp)
    /* 7B28 80017328 1000B08F */  lw         $s0, 0x10($sp)
    /* 7B2C 8001732C 0800E003 */  jr         $ra
    /* 7B30 80017330 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ReleaseDescription__11tCarManager
