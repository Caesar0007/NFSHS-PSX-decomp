.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_SetCurrentSongInfo__Fv, 0x40

glabel AudioMus_SetCurrentSongInfo__Fv
    /* 6AB90 8007A390 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AB94 8007A394 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6AB98 8007A398 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6AB9C 8007A39C A400628C */  lw         $v0, 0xA4($v1)
    /* 6ABA0 8007A3A0 A000658C */  lw         $a1, 0xA0($v1)
    /* 6ABA4 8007A3A4 18016424 */  addiu      $a0, $v1, 0x118
    /* 6ABA8 8007A3A8 140162AC */  sw         $v0, 0x114($v1)
    /* 6ABAC 8007A3AC 21104500 */  addu       $v0, $v0, $a1
    /* 6ABB0 8007A3B0 180082AC */  sw         $v0, 0x18($a0)
    /* 6ABB4 8007A3B4 2C00628C */  lw         $v0, 0x2C($v1)
    /* 6ABB8 8007A3B8 C2E8010C */  jal        AudioMus_SetEntry__FP19AudioMus_tSongEntry
    /* 6ABBC 8007A3BC 180162AC */   sw        $v0, 0x118($v1)
    /* 6ABC0 8007A3C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6ABC4 8007A3C4 00000000 */  nop
    /* 6ABC8 8007A3C8 0800E003 */  jr         $ra
    /* 6ABCC 8007A3CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_SetCurrentSongInfo__Fv
