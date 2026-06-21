.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__9tMenuItemiiib, 0x44

glabel Draw__9tMenuItemiiib
    /* 15064 80024864 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15068 80024868 1800BFAF */  sw         $ra, 0x18($sp)
    /* 1506C 8002486C 1800838C */  lw         $v1, 0x18($a0)
    /* 15070 80024870 2138C000 */  addu       $a3, $a2, $zero
    /* 15074 80024874 30006284 */  lh         $v0, 0x30($v1)
    /* 15078 80024878 2130A000 */  addu       $a2, $a1, $zero
    /* 1507C 8002487C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 15080 80024880 3000A58F */  lw         $a1, 0x30($sp)
    /* 15084 80024884 21208200 */  addu       $a0, $a0, $v0
    /* 15088 80024888 3400628C */  lw         $v0, 0x34($v1)
    /* 1508C 8002488C 00000000 */  nop
    /* 15090 80024890 09F84000 */  jalr       $v0
    /* 15094 80024894 00000000 */   nop
    /* 15098 80024898 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1509C 8002489C 00000000 */  nop
    /* 150A0 800248A0 0800E003 */  jr         $ra
    /* 150A4 800248A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw__9tMenuItemiiib
