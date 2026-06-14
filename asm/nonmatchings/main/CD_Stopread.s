.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Stopread, 0x1C

glabel CD_Stopread
    /* EB104 800FA904 1480033C */  lui        $v1, %hi(Cdinfo)
    /* EB108 800FA908 C46C628C */  lw         $v0, %lo(Cdinfo)($v1)
    /* EB10C 800FA90C 00000000 */  nop
    /* EB110 800FA910 04004234 */  ori        $v0, $v0, 0x4
    /* EB114 800FA914 C46C62AC */  sw         $v0, %lo(Cdinfo)($v1)
    /* EB118 800FA918 0800E003 */  jr         $ra
    /* EB11C 800FA91C 00000000 */   nop
endlabel CD_Stopread
