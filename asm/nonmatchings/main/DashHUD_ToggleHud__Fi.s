.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_ToggleHud__Fi, 0x24

glabel DashHUD_ToggleHud__Fi
    /* 8B874 8009B074 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* 8B878 8009B078 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* 8B87C 8009B07C 80200400 */  sll        $a0, $a0, 2
    /* 8B880 8009B080 21208200 */  addu       $a0, $a0, $v0
    /* 8B884 8009B084 1C00828C */  lw         $v0, 0x1C($a0)
    /* 8B888 8009B088 00000000 */  nop
    /* 8B88C 8009B08C 01004238 */  xori       $v0, $v0, 0x1
    /* 8B890 8009B090 0800E003 */  jr         $ra
    /* 8B894 8009B094 1C0082AC */   sw        $v0, 0x1C($a0)
endlabel DashHUD_ToggleHud__Fi
