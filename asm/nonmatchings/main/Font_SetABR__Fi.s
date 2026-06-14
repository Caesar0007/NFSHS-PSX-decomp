.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_SetABR__Fi, 0x48

glabel Font_SetABR__Fi
    /* BBA64 800CB264 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BBA68 800CB268 1380023C */  lui        $v0, %hi(D_80135C28)
    /* BBA6C 800CB26C 285C428C */  lw         $v0, %lo(D_80135C28)($v0)
    /* BBA70 800CB270 21288000 */  addu       $a1, $a0, $zero
    /* BBA74 800CB274 1000BFAF */  sw         $ra, 0x10($sp)
    /* BBA78 800CB278 141385AF */  sw         $a1, %gp_rel(font_abr)($gp)
    /* BBA7C 800CB27C 0C00468C */  lw         $a2, 0xC($v0)
    /* BBA80 800CB280 00004490 */  lbu        $a0, 0x0($v0)
    /* BBA84 800CB284 00390600 */  sll        $a3, $a2, 4
    /* BBA88 800CB288 00350600 */  sll        $a2, $a2, 20
    /* BBA8C 800CB28C 03008430 */  andi       $a0, $a0, 0x3
    /* BBA90 800CB290 03350600 */  sra        $a2, $a2, 20
    /* BBA94 800CB294 FFC6030C */  jal        GetTPage
    /* BBA98 800CB298 033D0700 */   sra       $a3, $a3, 20
    /* BBA9C 800CB29C 1000BF8F */  lw         $ra, 0x10($sp)
    /* BBAA0 800CB2A0 1C1382A7 */  sh         $v0, %gp_rel(font_currentTPage)($gp)
    /* BBAA4 800CB2A4 0800E003 */  jr         $ra
    /* BBAA8 800CB2A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Font_SetABR__Fi
