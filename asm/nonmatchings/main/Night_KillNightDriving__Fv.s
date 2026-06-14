.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_KillNightDriving__Fv, 0xA0

glabel Night_KillNightDriving__Fv
    /* CC780 800DBF80 4C15848F */  lw         $a0, %gp_rel(nightfile)($gp)
    /* CC784 800DBF84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC788 800DBF88 03008010 */  beqz       $a0, .L800DBF98
    /* CC78C 800DBF8C 1000BFAF */   sw        $ra, 0x10($sp)
    /* CC790 800DBF90 5095030C */  jal        purgememadr
    /* CC794 800DBF94 00000000 */   nop
  .L800DBF98:
    /* CC798 800DBF98 9814848F */  lw         $a0, %gp_rel(Night_gPlayerLightingTable)($gp)
    /* CC79C 800DBF9C 4C1580AF */  sw         $zero, %gp_rel(nightfile)($gp)
    /* CC7A0 800DBFA0 03008010 */  beqz       $a0, .L800DBFB0
    /* CC7A4 800DBFA4 00000000 */   nop
    /* CC7A8 800DBFA8 5095030C */  jal        purgememadr
    /* CC7AC 800DBFAC 00000000 */   nop
  .L800DBFB0:
    /* CC7B0 800DBFB0 9C14848F */  lw         $a0, %gp_rel(Night_gCopLightingTableRed)($gp)
    /* CC7B4 800DBFB4 981480AF */  sw         $zero, %gp_rel(Night_gPlayerLightingTable)($gp)
    /* CC7B8 800DBFB8 03008010 */  beqz       $a0, .L800DBFC8
    /* CC7BC 800DBFBC 00000000 */   nop
    /* CC7C0 800DBFC0 5095030C */  jal        purgememadr
    /* CC7C4 800DBFC4 00000000 */   nop
  .L800DBFC8:
    /* CC7C8 800DBFC8 A014848F */  lw         $a0, %gp_rel(Night_gCopLightingTableBlue)($gp)
    /* CC7CC 800DBFCC 9C1480AF */  sw         $zero, %gp_rel(Night_gCopLightingTableRed)($gp)
    /* CC7D0 800DBFD0 03008010 */  beqz       $a0, .L800DBFE0
    /* CC7D4 800DBFD4 00000000 */   nop
    /* CC7D8 800DBFD8 5095030C */  jal        purgememadr
    /* CC7DC 800DBFDC 00000000 */   nop
  .L800DBFE0:
    /* CC7E0 800DBFE0 A414848F */  lw         $a0, %gp_rel(Night_gWeatherLightingTable)($gp)
    /* CC7E4 800DBFE4 A01480AF */  sw         $zero, %gp_rel(Night_gCopLightingTableBlue)($gp)
    /* CC7E8 800DBFE8 03008010 */  beqz       $a0, .L800DBFF8
    /* CC7EC 800DBFEC 00000000 */   nop
    /* CC7F0 800DBFF0 5095030C */  jal        purgememadr
    /* CC7F4 800DBFF4 00000000 */   nop
  .L800DBFF8:
    /* CC7F8 800DBFF8 A814848F */  lw         $a0, %gp_rel(D_8013D9F4)($gp)
    /* CC7FC 800DBFFC A41480AF */  sw         $zero, %gp_rel(Night_gWeatherLightingTable)($gp)
    /* CC800 800DC000 03008010 */  beqz       $a0, .L800DC010
    /* CC804 800DC004 00000000 */   nop
    /* CC808 800DC008 5095030C */  jal        purgememadr
    /* CC80C 800DC00C 00000000 */   nop
  .L800DC010:
    /* CC810 800DC010 1000BF8F */  lw         $ra, 0x10($sp)
    /* CC814 800DC014 A81480AF */  sw         $zero, %gp_rel(D_8013D9F4)($gp)
    /* CC818 800DC018 0800E003 */  jr         $ra
    /* CC81C 800DC01C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_KillNightDriving__Fv
