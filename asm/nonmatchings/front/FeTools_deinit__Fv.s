.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeTools_deinit__Fv, 0x50

glabel FeTools_deinit__Fv
    /* 17490 80026C90 0580023C */  lui        $v0, %hi(font18)
    /* 17494 80026C94 D817448C */  lw         $a0, %lo(font18)($v0)
    /* 17498 80026C98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1749C 80026C9C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 174A0 80026CA0 5095030C */  jal        purgememadr
    /* 174A4 80026CA4 00000000 */   nop
    /* 174A8 80026CA8 0580023C */  lui        $v0, %hi(fontTitle)
    /* 174AC 80026CAC DC17448C */  lw         $a0, %lo(fontTitle)($v0)
    /* 174B0 80026CB0 5095030C */  jal        purgememadr
    /* 174B4 80026CB4 00000000 */   nop
    /* 174B8 80026CB8 0580023C */  lui        $v0, %hi(font12)
    /* 174BC 80026CBC D417448C */  lw         $a0, %lo(font12)($v0)
    /* 174C0 80026CC0 5095030C */  jal        purgememadr
    /* 174C4 80026CC4 00000000 */   nop
    /* 174C8 80026CC8 162E030C */  jal        Font_DeInit__Fv
    /* 174CC 80026CCC 00000000 */   nop
    /* 174D0 80026CD0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 174D4 80026CD4 00000000 */  nop
    /* 174D8 80026CD8 0800E003 */  jr         $ra
    /* 174DC 80026CDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FeTools_deinit__Fv
