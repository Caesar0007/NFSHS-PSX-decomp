.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_InitSample, 0x28

glabel iSPCH_InitSample
    /* FBDAC 8010B5AC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* FBDB0 8010B5B0 040082AC */  sw         $v0, 0x4($a0)
    /* FBDB4 8010B5B4 FF000224 */  addiu      $v0, $zero, 0xFF
    /* FBDB8 8010B5B8 000080AC */  sw         $zero, 0x0($a0)
    /* FBDBC 8010B5BC 080080AC */  sw         $zero, 0x8($a0)
    /* FBDC0 8010B5C0 0C0082A0 */  sb         $v0, 0xC($a0)
    /* FBDC4 8010B5C4 0D0082A0 */  sb         $v0, 0xD($a0)
    /* FBDC8 8010B5C8 0E0082A0 */  sb         $v0, 0xE($a0)
    /* FBDCC 8010B5CC 0800E003 */  jr         $ra
    /* FBDD0 8010B5D0 0F0082A0 */   sb        $v0, 0xF($a0)
endlabel iSPCH_InitSample
