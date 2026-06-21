.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _gpu_dma_chain, 0x48

glabel _gpu_dma_chain
    /* DFAC0 800EF2C0 0004033C */  lui        $v1, (0x4000002 >> 16)
    /* DFAC4 800EF2C4 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DFAC8 800EF2C8 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DFACC 800EF2CC 02006334 */  ori        $v1, $v1, (0x4000002 & 0xFFFF)
    /* DFAD0 800EF2D0 000043AC */  sw         $v1, 0x0($v0)
    /* DFAD4 800EF2D4 1280023C */  lui        $v0, %hi(D_801237A8)
    /* DFAD8 800EF2D8 A837428C */  lw         $v0, %lo(D_801237A8)($v0)
    /* DFADC 800EF2DC 00000000 */  nop
    /* DFAE0 800EF2E0 000044AC */  sw         $a0, 0x0($v0)
    /* DFAE4 800EF2E4 1280023C */  lui        $v0, %hi(D_801237AC)
    /* DFAE8 800EF2E8 AC37428C */  lw         $v0, %lo(D_801237AC)($v0)
    /* DFAEC 800EF2EC 0001033C */  lui        $v1, (0x1000401 >> 16)
    /* DFAF0 800EF2F0 000040AC */  sw         $zero, 0x0($v0)
    /* DFAF4 800EF2F4 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFAF8 800EF2F8 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFAFC 800EF2FC 01046334 */  ori        $v1, $v1, (0x1000401 & 0xFFFF)
    /* DFB00 800EF300 0800E003 */  jr         $ra
    /* DFB04 800EF304 000043AC */   sw        $v1, 0x0($v0)
endlabel _gpu_dma_chain
