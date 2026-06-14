.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setRC2wait, 0x20

glabel setRC2wait
    /* FC7E8 8010BFE8 801F023C */  lui        $v0, (0x1F801120 >> 16)
    /* FC7EC 8010BFEC 20114234 */  ori        $v0, $v0, (0x1F801120 & 0xFFFF)
    /* FC7F0 8010BFF0 00004294 */  lhu        $v0, 0x0($v0)
    /* FC7F4 8010BFF4 1580013C */  lui        $at, %hi(_waitTime)
    /* FC7F8 8010BFF8 AC8A24AC */  sw         $a0, %lo(_waitTime)($at)
    /* FC7FC 8010BFFC 1580013C */  lui        $at, %hi(_startTime)
    /* FC800 8010C000 0800E003 */  jr         $ra
    /* FC804 8010C004 B08A22AC */   sw        $v0, %lo(_startTime)($at)
endlabel setRC2wait
