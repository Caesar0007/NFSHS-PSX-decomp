.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching resettick, 0x24

glabel resettick
    /* D8A60 800E8260 1480013C */  lui        $at, %hi(ticks)
    /* D8A64 800E8264 ACDC20AC */  sw         $zero, %lo(ticks)($at)
    /* D8A68 800E8268 1480023C */  lui        $v0, %hi(ticks)
    /* D8A6C 800E826C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* D8A70 800E8270 00000000 */  nop
    /* D8A74 800E8274 F81682AF */  sw         $v0, %gp_rel(tickval)($gp)
    /* D8A78 800E8278 F41682AF */  sw         $v0, %gp_rel(tickset)($gp)
    /* D8A7C 800E827C 0800E003 */  jr         $ra
    /* D8A80 800E8280 00000000 */   nop
endlabel resettick
