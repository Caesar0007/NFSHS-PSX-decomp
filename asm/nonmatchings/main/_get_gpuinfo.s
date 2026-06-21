.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _get_gpuinfo, 0x30

glabel _get_gpuinfo
    /* DFB08 800EF308 0010023C */  lui        $v0, (0x10000000 >> 16)
    /* DFB0C 800EF30C 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DFB10 800EF310 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DFB14 800EF314 25208200 */  or         $a0, $a0, $v0
    /* DFB18 800EF318 000064AC */  sw         $a0, 0x0($v1)
    /* DFB1C 800EF31C 1280023C */  lui        $v0, %hi(D_801237A0)
    /* DFB20 800EF320 A037428C */  lw         $v0, %lo(D_801237A0)($v0)
    /* DFB24 800EF324 FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* DFB28 800EF328 0000428C */  lw         $v0, 0x0($v0)
    /* DFB2C 800EF32C FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* DFB30 800EF330 0800E003 */  jr         $ra
    /* DFB34 800EF334 24104300 */   and       $v0, $v0, $v1
endlabel _get_gpuinfo
