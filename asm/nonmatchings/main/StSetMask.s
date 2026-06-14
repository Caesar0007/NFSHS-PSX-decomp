.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StSetMask, 0x1C

glabel StSetMask
    /* F905C 8010885C 1480013C */  lui        $at, %hi(StSTART_FLAG)
    /* F9060 80108860 986C24AC */  sw         $a0, %lo(StSTART_FLAG)($at)
    /* F9064 80108864 1480013C */  lui        $at, %hi(StStartFrame)
    /* F9068 80108868 C06C25AC */  sw         $a1, %lo(StStartFrame)($at)
    /* F906C 8010886C 1480013C */  lui        $at, %hi(StEndFrame)
    /* F9070 80108870 0800E003 */  jr         $ra
    /* F9074 80108874 946C26AC */   sw        $a2, %lo(StEndFrame)($at)
endlabel StSetMask
    /* F9078 80108878 00000000 */  nop
