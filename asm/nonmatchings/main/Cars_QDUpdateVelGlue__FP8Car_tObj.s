.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_QDUpdateVelGlue__FP8Car_tObj, 0x7C

glabel Cars_QDUpdateVelGlue__FP8Car_tObj
    /* 766E8 80085EE8 AC00828C */  lw         $v0, 0xAC($a0)
    /* 766EC 80085EEC 7002868C */  lw         $a2, 0x270($a0)
    /* 766F0 80085EF0 02004104 */  bgez       $v0, .L80085EFC
    /* 766F4 80085EF4 2128C000 */   addu      $a1, $a2, $zero
    /* 766F8 80085EF8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80085EFC:
    /* 766FC 80085EFC 0200C104 */  bgez       $a2, .L80085F08
    /* 76700 80085F00 031A0200 */   sra       $v1, $v0, 8
    /* 76704 80085F04 FF00C524 */  addiu      $a1, $a2, 0xFF
  .L80085F08:
    /* 76708 80085F08 033A0500 */  sra        $a3, $a1, 8
    /* 7670C 80085F0C 18006700 */  mult       $v1, $a3
    /* 76710 80085F10 B400858C */  lw         $a1, 0xB4($a0)
    /* 76714 80085F14 B000828C */  lw         $v0, 0xB0($a0)
    /* 76718 80085F18 A400838C */  lw         $v1, 0xA4($a0)
    /* 7671C 80085F1C 83110200 */  sra        $v0, $v0, 6
    /* 76720 80085F20 21186200 */  addu       $v1, $v1, $v0
    /* 76724 80085F24 A000828C */  lw         $v0, 0xA0($a0)
    /* 76728 80085F28 A40083AC */  sw         $v1, 0xA4($a0)
    /* 7672C 80085F2C 12400000 */  mflo       $t0
    /* 76730 80085F30 83190800 */  sra        $v1, $t0, 6
    /* 76734 80085F34 21104300 */  addu       $v0, $v0, $v1
    /* 76738 80085F38 0200A104 */  bgez       $a1, .L80085F44
    /* 7673C 80085F3C A00082AC */   sw        $v0, 0xA0($a0)
    /* 76740 80085F40 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L80085F44:
    /* 76744 80085F44 031A0500 */  sra        $v1, $a1, 8
    /* 76748 80085F48 18006700 */  mult       $v1, $a3
    /* 7674C 80085F4C A800828C */  lw         $v0, 0xA8($a0)
    /* 76750 80085F50 12400000 */  mflo       $t0
    /* 76754 80085F54 83190800 */  sra        $v1, $t0, 6
    /* 76758 80085F58 21104300 */  addu       $v0, $v0, $v1
    /* 7675C 80085F5C 0800E003 */  jr         $ra
    /* 76760 80085F60 A80082AC */   sw        $v0, 0xA8($a0)
endlabel Cars_QDUpdateVelGlue__FP8Car_tObj
