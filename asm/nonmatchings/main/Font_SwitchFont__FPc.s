.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_SwitchFont__FPc, 0x6C

glabel Font_SwitchFont__FPc
    /* BBFEC 800CB7EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BBFF0 800CB7F0 1000BFAF */  sw         $ra, 0x10($sp)
    /* BBFF4 800CB7F4 A5CB030C */  jal        setfont
    /* BBFF8 800CB7F8 00000000 */   nop
    /* BBFFC 800CB7FC 1380023C */  lui        $v0, %hi(currentfont)
    /* BC000 800CB800 A05B4224 */  addiu      $v0, $v0, %lo(currentfont)
    /* BC004 800CB804 8800438C */  lw         $v1, 0x88($v0)
    /* BC008 800CB808 1413858F */  lw         $a1, %gp_rel(font_abr)($gp)
    /* BC00C 800CB80C 940040AC */  sw         $zero, 0x94($v0)
    /* BC010 800CB810 980040AC */  sw         $zero, 0x98($v0)
    /* BC014 800CB814 9C0040AC */  sw         $zero, 0x9C($v0)
    /* BC018 800CB818 00006490 */  lbu        $a0, 0x0($v1)
    /* BC01C 800CB81C 0C00668C */  lw         $a2, 0xC($v1)
    /* BC020 800CB820 03008430 */  andi       $a0, $a0, 0x3
    /* BC024 800CB824 00390600 */  sll        $a3, $a2, 4
    /* BC028 800CB828 00350600 */  sll        $a2, $a2, 20
    /* BC02C 800CB82C 03350600 */  sra        $a2, $a2, 20
    /* BC030 800CB830 FFC6030C */  jal        GetTPage
    /* BC034 800CB834 033D0700 */   sra       $a3, $a3, 20
    /* BC038 800CB838 1C1382A7 */  sh         $v0, %gp_rel(font_currentTPage)($gp)
    /* BC03C 800CB83C D02D030C */  jal        Font_Getcharacter__Fi
    /* BC040 800CB840 20000424 */   addiu     $a0, $zero, 0x20
    /* BC044 800CB844 08004290 */  lbu        $v0, 0x8($v0)
    /* BC048 800CB848 1000BF8F */  lw         $ra, 0x10($sp)
    /* BC04C 800CB84C 1A1382A3 */  sb         $v0, %gp_rel(gFontSpaceWidth)($gp)
    /* BC050 800CB850 0800E003 */  jr         $ra
    /* BC054 800CB854 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Font_SwitchFont__FPc
