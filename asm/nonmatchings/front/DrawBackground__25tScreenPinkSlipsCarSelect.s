.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__25tScreenPinkSlipsCarSelect, 0x44

glabel DrawBackground__25tScreenPinkSlipsCarSelect
    /* 2F6D0 8003EED0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2F6D4 8003EED4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F6D8 8003EED8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2F6DC 8003EEDC C5FB000C */  jal        DoMemCardStuff__25tScreenPinkSlipsCarSelect
    /* 2F6E0 8003EEE0 21808000 */   addu      $s0, $a0, $zero
    /* 2F6E4 8003EEE4 2FF9000C */  jal        DrawBackground__25tScreenCarSelectTwoPlayer
    /* 2F6E8 8003EEE8 21200002 */   addu      $a0, $s0, $zero
    /* 2F6EC 8003EEEC 4804028E */  lw         $v0, 0x448($s0)
    /* 2F6F0 8003EEF0 00000000 */  nop
    /* 2F6F4 8003EEF4 03004010 */  beqz       $v0, .L8003EF04
    /* 2F6F8 8003EEF8 00000000 */   nop
    /* 2F6FC 8003EEFC 4162000C */  jal        Hide__11tDialogBase
    /* 2F700 8003EF00 A0030426 */   addiu     $a0, $s0, 0x3A0
  .L8003EF04:
    /* 2F704 8003EF04 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2F708 8003EF08 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F70C 8003EF0C 0800E003 */  jr         $ra
    /* 2F710 8003EF10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawBackground__25tScreenPinkSlipsCarSelect
