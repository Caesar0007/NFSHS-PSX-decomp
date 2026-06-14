.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_RefreshStatus__Fv, 0x64

glabel AudioMus_RefreshStatus__Fv
    /* 6A6F4 80079EF4 D401858F */  lw         $a1, %gp_rel(AudioMus_g)($gp)
    /* 6A6F8 80079EF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A6FC 80079EFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A700 80079F00 7400A48C */  lw         $a0, 0x74($a1)
    /* 6A704 80079F04 00000000 */  nop
    /* 6A708 80079F08 0E008004 */  bltz       $a0, .L80079F44
    /* 6A70C 80079F0C 00000000 */   nop
    /* 6A710 80079F10 B6A1030C */  jal        SNDSTRM_status
    /* 6A714 80079F14 9000A524 */   addiu     $a1, $a1, 0x90
    /* 6A718 80079F18 D401858F */  lw         $a1, %gp_rel(AudioMus_g)($gp)
    /* 6A71C 80079F1C 00000000 */  nop
    /* 6A720 80079F20 9000A28C */  lw         $v0, 0x90($a1)
    /* 6A724 80079F24 00000000 */  nop
    /* 6A728 80079F28 07004018 */  blez       $v0, .L80079F48
    /* 6A72C 80079F2C 00000000 */   nop
    /* 6A730 80079F30 9400A48C */  lw         $a0, 0x94($a1)
    /* 6A734 80079F34 F4A1030C */  jal        SNDSTRM_requeststatus
    /* 6A738 80079F38 9C00A524 */   addiu     $a1, $a1, 0x9C
    /* 6A73C 80079F3C D2E70108 */  j          .L80079F48
    /* 6A740 80079F40 00000000 */   nop
  .L80079F44:
    /* 6A744 80079F44 9000A0AC */  sw         $zero, 0x90($a1)
  .L80079F48:
    /* 6A748 80079F48 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A74C 80079F4C 00000000 */  nop
    /* 6A750 80079F50 0800E003 */  jr         $ra
    /* 6A754 80079F54 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_RefreshStatus__Fv
