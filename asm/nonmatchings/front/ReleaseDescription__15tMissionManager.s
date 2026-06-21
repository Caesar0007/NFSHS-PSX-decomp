.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseDescription__15tMissionManager, 0x3C

glabel ReleaseDescription__15tMissionManager
    /* 249B8 800341B8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 249BC 800341BC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 249C0 800341C0 21808000 */  addu       $s0, $a0, $zero
    /* 249C4 800341C4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 249C8 800341C8 0400048E */  lw         $a0, 0x4($s0)
    /* 249CC 800341CC 00000000 */  nop
    /* 249D0 800341D0 04008010 */  beqz       $a0, .L800341E4
    /* 249D4 800341D4 00000000 */   nop
    /* 249D8 800341D8 5095030C */  jal        purgememadr
    /* 249DC 800341DC 00000000 */   nop
    /* 249E0 800341E0 040000AE */  sw         $zero, 0x4($s0)
  .L800341E4:
    /* 249E4 800341E4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 249E8 800341E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 249EC 800341EC 0800E003 */  jr         $ra
    /* 249F0 800341F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ReleaseDescription__15tMissionManager
