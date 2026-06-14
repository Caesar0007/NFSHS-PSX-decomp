.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EEA64, 0x18

glabel func_800EEA64
    /* DF264 800EEA64 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF268 800EEA68 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF26C 800EEA6C 00000000 */  nop
    /* DF270 800EEA70 0000428C */  lw         $v0, 0x0($v0)
    /* DF274 800EEA74 0800E003 */  jr         $ra
    /* DF278 800EEA78 00000000 */   nop
endlabel func_800EEA64
