.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_InitGlobals__Fv, 0x24

glabel AudioMus_InitGlobals__Fv
    /* 6B254 8007AA54 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B258 8007AA58 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 6B25C 8007AA5C 8C0040AC */  sw         $zero, 0x8C($v0)
    /* 6B260 8007AA60 700040AC */  sw         $zero, 0x70($v0)
    /* 6B264 8007AA64 740043AC */  sw         $v1, 0x74($v0)
    /* 6B268 8007AA68 7C0040AC */  sw         $zero, 0x7C($v0)
    /* 6B26C 8007AA6C 800040AC */  sw         $zero, 0x80($v0)
    /* 6B270 8007AA70 0800E003 */  jr         $ra
    /* 6B274 8007AA74 040040AC */   sw        $zero, 0x4($v0)
endlabel AudioMus_InitGlobals__Fv
