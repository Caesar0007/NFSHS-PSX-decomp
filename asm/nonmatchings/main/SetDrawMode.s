.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDrawMode, 0x54

glabel SetDrawMode
    /* DEBBC 800EE3BC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DEBC0 800EE3C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* DEBC4 800EE3C4 21808000 */  addu       $s0, $a0, $zero
    /* DEBC8 800EE3C8 2120A000 */  addu       $a0, $a1, $zero
    /* DEBCC 800EE3CC 02000224 */  addiu      $v0, $zero, 0x2
    /* DEBD0 800EE3D0 2128C000 */  addu       $a1, $a2, $zero
    /* DEBD4 800EE3D4 1400B1AF */  sw         $s1, 0x14($sp)
    /* DEBD8 800EE3D8 3000B18F */  lw         $s1, 0x30($sp)
    /* DEBDC 800EE3DC FFFFE630 */  andi       $a2, $a3, 0xFFFF
    /* DEBE0 800EE3E0 1800BFAF */  sw         $ra, 0x18($sp)
    /* DEBE4 800EE3E4 1EBA030C */  jal        _set_draw_mode
    /* DEBE8 800EE3E8 030002A2 */   sb        $v0, 0x3($s0)
    /* DEBEC 800EE3EC 040002AE */  sw         $v0, 0x4($s0)
    /* DEBF0 800EE3F0 79BA030C */  jal        _get_tw
    /* DEBF4 800EE3F4 21202002 */   addu      $a0, $s1, $zero
    /* DEBF8 800EE3F8 080002AE */  sw         $v0, 0x8($s0)
    /* DEBFC 800EE3FC 1800BF8F */  lw         $ra, 0x18($sp)
    /* DEC00 800EE400 1400B18F */  lw         $s1, 0x14($sp)
    /* DEC04 800EE404 1000B08F */  lw         $s0, 0x10($sp)
    /* DEC08 800EE408 0800E003 */  jr         $ra
    /* DEC0C 800EE40C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetDrawMode
