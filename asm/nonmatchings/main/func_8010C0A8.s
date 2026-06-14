.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010C0A8, 0x48

glabel func_8010C0A8
    /* FC8A8 8010C0A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FC8AC 8010C0AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC8B0 8010C0B0 1380023C */  lui        $v0, %hi(_padFuncSendAuto)
    /* FC8B4 8010C0B4 907C428C */  lw         $v0, %lo(_padFuncSendAuto)($v0)
    /* FC8B8 8010C0B8 1400BFAF */  sw         $ra, 0x14($sp)
    /* FC8BC 8010C0BC 09F84000 */  jalr       $v0
    /* FC8C0 8010C0C0 21808000 */   addu      $s0, $a0, $zero
    /* FC8C4 8010C0C4 21200002 */  addu       $a0, $s0, $zero
    /* FC8C8 8010C0C8 3C00038E */  lw         $v1, 0x3C($s0)
    /* FC8CC 8010C0CC FEFF0524 */  addiu      $a1, $zero, -0x2
    /* FC8D0 8010C0D0 1480013C */  lui        $at, %hi(D_8013C310)
    /* FC8D4 8010C0D4 10C322AC */  sw         $v0, %lo(D_8013C310)($at)
    /* FC8D8 8010C0D8 4A14040C */  jal        _padSioRW
    /* FC8DC 8010C0DC 000060A0 */   sb        $zero, 0x0($v1)
    /* FC8E0 8010C0E0 1400BF8F */  lw         $ra, 0x14($sp)
    /* FC8E4 8010C0E4 1000B08F */  lw         $s0, 0x10($sp)
    /* FC8E8 8010C0E8 0800E003 */  jr         $ra
    /* FC8EC 8010C0EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8010C0A8
