.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_TargetedGetDesiredVector__FP8Car_tObj, 0x3C

glabel AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
    /* 5BA24 8006B224 0807828C */  lw         $v0, 0x708($a0)
    /* 5BA28 8006B228 A000858C */  lw         $a1, 0xA0($a0)
    /* 5BA2C 8006B22C 0C07838C */  lw         $v1, 0x70C($a0)
    /* 5BA30 8006B230 A400868C */  lw         $a2, 0xA4($a0)
    /* 5BA34 8006B234 23104500 */  subu       $v0, $v0, $a1
    /* 5BA38 8006B238 D00682AC */  sw         $v0, 0x6D0($a0)
    /* 5BA3C 8006B23C 1007828C */  lw         $v0, 0x710($a0)
    /* 5BA40 8006B240 23186600 */  subu       $v1, $v1, $a2
    /* 5BA44 8006B244 D40683AC */  sw         $v1, 0x6D4($a0)
    /* 5BA48 8006B248 A800838C */  lw         $v1, 0xA8($a0)
    /* 5BA4C 8006B24C 1407858C */  lw         $a1, 0x714($a0)
    /* 5BA50 8006B250 23104300 */  subu       $v0, $v0, $v1
    /* 5BA54 8006B254 D80682AC */  sw         $v0, 0x6D8($a0)
    /* 5BA58 8006B258 0800E003 */  jr         $ra
    /* 5BA5C 8006B25C 180785AC */   sw        $a1, 0x718($a0)
endlabel AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
