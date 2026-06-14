.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_InitDriverGlobals__Fv, 0x5C

glabel AudioMus_InitDriverGlobals__Fv
    /* 6B278 8007AA78 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B27C 8007AA7C FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 6B280 8007AA80 0C0043AC */  sw         $v1, 0xC($v0)
    /* 6B284 8007AA84 18014324 */  addiu      $v1, $v0, 0x118
    /* 6B288 8007AA88 000040AC */  sw         $zero, 0x0($v0)
    /* 6B28C 8007AA8C 240040AC */  sw         $zero, 0x24($v0)
    /* 6B290 8007AA90 080040AC */  sw         $zero, 0x8($v0)
    /* 6B294 8007AA94 100040AC */  sw         $zero, 0x10($v0)
    /* 6B298 8007AA98 180040AC */  sw         $zero, 0x18($v0)
    /* 6B29C 8007AA9C 2C0040AC */  sw         $zero, 0x2C($v0)
    /* 6B2A0 8007AAA0 140040AC */  sw         $zero, 0x14($v0)
    /* 6B2A4 8007AAA4 200040AC */  sw         $zero, 0x20($v0)
    /* 6B2A8 8007AAA8 840040AC */  sw         $zero, 0x84($v0)
    /* 6B2AC 8007AAAC 140140AC */  sw         $zero, 0x114($v0)
    /* 6B2B0 8007AAB0 180060AC */  sw         $zero, 0x18($v1)
    /* 6B2B4 8007AAB4 180140AC */  sw         $zero, 0x118($v0)
    /* 6B2B8 8007AAB8 040060AC */  sw         $zero, 0x4($v1)
    /* 6B2BC 8007AABC 080060AC */  sw         $zero, 0x8($v1)
    /* 6B2C0 8007AAC0 0C0060AC */  sw         $zero, 0xC($v1)
    /* 6B2C4 8007AAC4 140060AC */  sw         $zero, 0x14($v1)
    /* 6B2C8 8007AAC8 01000324 */  addiu      $v1, $zero, 0x1
    /* 6B2CC 8007AACC 0800E003 */  jr         $ra
    /* 6B2D0 8007AAD0 800043AC */   sw        $v1, 0x80($v0)
endlabel AudioMus_InitDriverGlobals__Fv
