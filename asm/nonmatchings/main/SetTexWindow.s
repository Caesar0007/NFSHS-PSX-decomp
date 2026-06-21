.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetTexWindow, 0x38

glabel SetTexWindow
    /* DEADC 800EE2DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DEAE0 800EE2E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* DEAE4 800EE2E4 21808000 */  addu       $s0, $a0, $zero
    /* DEAE8 800EE2E8 02000224 */  addiu      $v0, $zero, 0x2
    /* DEAEC 800EE2EC 2120A000 */  addu       $a0, $a1, $zero
    /* DEAF0 800EE2F0 1400BFAF */  sw         $ra, 0x14($sp)
    /* DEAF4 800EE2F4 79BA030C */  jal        _get_tw
    /* DEAF8 800EE2F8 030002A2 */   sb        $v0, 0x3($s0)
    /* DEAFC 800EE2FC 040002AE */  sw         $v0, 0x4($s0)
    /* DEB00 800EE300 080000AE */  sw         $zero, 0x8($s0)
    /* DEB04 800EE304 1400BF8F */  lw         $ra, 0x14($sp)
    /* DEB08 800EE308 1000B08F */  lw         $s0, 0x10($sp)
    /* DEB0C 800EE30C 0800E003 */  jr         $ra
    /* DEB10 800EE310 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetTexWindow
