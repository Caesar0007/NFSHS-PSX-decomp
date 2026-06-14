.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_Fail__Fi, 0x7C

glabel AudioMus_Fail__Fi
    /* 6A9DC 8007A1DC D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6A9E0 8007A1E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A9E4 8007A1E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A9E8 8007A1E8 9000438C */  lw         $v1, 0x90($v0)
    /* 6A9EC 8007A1EC 00000000 */  nop
    /* 6A9F0 8007A1F0 0D006010 */  beqz       $v1, .L8007A228
    /* 6A9F4 8007A1F4 200044AC */   sw        $a0, 0x20($v0)
    /* 6A9F8 8007A1F8 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6A9FC 8007A1FC 00000000 */   nop
    /* 6AA00 8007A200 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AA04 8007A204 21284000 */  addu       $a1, $v0, $zero
    /* 6AA08 8007A208 7400648C */  lw         $a0, 0x74($v1)
    /* 6AA0C 8007A20C 7AA7030C */  jal        SNDSTRM_autovol
    /* 6AA10 8007A210 21300000 */   addu      $a2, $zero, $zero
    /* 6AA14 8007A214 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 6AA18 8007A218 00000000 */   nop
    /* 6AA1C 8007A21C D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AA20 8007A220 00000000 */  nop
    /* 6AA24 8007A224 240062AC */  sw         $v0, 0x24($v1)
  .L8007A228:
    /* 6AA28 8007A228 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AA2C 8007A22C 01000324 */  addiu      $v1, $zero, 0x1
    /* 6AA30 8007A230 180043AC */  sw         $v1, 0x18($v0)
    /* 6AA34 8007A234 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 6AA38 8007A238 100040AC */  sw         $zero, 0x10($v0)
    /* 6AA3C 8007A23C 2C0040AC */  sw         $zero, 0x2C($v0)
    /* 6AA40 8007A240 140043AC */  sw         $v1, 0x14($v0)
    /* 6AA44 8007A244 0C0043AC */  sw         $v1, 0xC($v0)
    /* 6AA48 8007A248 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6AA4C 8007A24C 00000000 */  nop
    /* 6AA50 8007A250 0800E003 */  jr         $ra
    /* 6AA54 8007A254 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_Fail__Fi
