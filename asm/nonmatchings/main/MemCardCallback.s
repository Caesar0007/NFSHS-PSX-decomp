.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardCallback, 0x14

glabel MemCardCallback
    /* EC2E8 800FBAE8 1480033C */  lui        $v1, %hi(D_80147558)
    /* EC2EC 800FBAEC 58756324 */  addiu      $v1, $v1, %lo(D_80147558)
    /* EC2F0 800FBAF0 0000628C */  lw         $v0, 0x0($v1)
    /* EC2F4 800FBAF4 0800E003 */  jr         $ra
    /* EC2F8 800FBAF8 000064AC */   sw        $a0, 0x0($v1)
endlabel MemCardCallback
