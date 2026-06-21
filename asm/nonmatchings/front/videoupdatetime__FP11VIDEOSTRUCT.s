.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching videoupdatetime__FP11VIDEOSTRUCT, 0x30

glabel videoupdatetime__FP11VIDEOSTRUCT
    /* 41980 80051180 2C00838C */  lw         $v1, 0x2C($a0)
    /* 41984 80051184 3000828C */  lw         $v0, 0x30($a0)
    /* 41988 80051188 00000000 */  nop
    /* 4198C 8005118C 21186200 */  addu       $v1, $v1, $v0
    /* 41990 80051190 2C0083AC */  sw         $v1, 0x2C($a0)
    /* 41994 80051194 031C0300 */  sra        $v1, $v1, 16
    /* 41998 80051198 2800828C */  lw         $v0, 0x28($a0)
    /* 4199C 8005119C 2C008594 */  lhu        $a1, 0x2C($a0)
    /* 419A0 800511A0 21104300 */  addu       $v0, $v0, $v1
    /* 419A4 800511A4 280082AC */  sw         $v0, 0x28($a0)
    /* 419A8 800511A8 0800E003 */  jr         $ra
    /* 419AC 800511AC 2C0085AC */   sw        $a1, 0x2C($a0)
endlabel videoupdatetime__FP11VIDEOSTRUCT
