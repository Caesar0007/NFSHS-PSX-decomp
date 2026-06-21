.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_initintr, 0x4C

glabel CD_initintr
    /* F88F4 801080F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F88F8 801080F8 1000BFAF */  sw         $ra, 0x10($sp)
    /* F88FC 801080FC 1480013C */  lui        $at, %hi(CD_cbready)
    /* F8900 80108100 4CBF20AC */  sw         $zero, %lo(CD_cbready)($at)
    /* F8904 80108104 1480013C */  lui        $at, %hi(CD_cbsync)
    /* F8908 80108108 48BF20AC */  sw         $zero, %lo(CD_cbsync)($at)
    /* F890C 8010810C 1480013C */  lui        $at, %hi(CD_status1)
    /* F8910 80108110 58BF20AC */  sw         $zero, %lo(CD_status1)($at)
    /* F8914 80108114 1480013C */  lui        $at, %hi(CD_status)
    /* F8918 80108118 13CA030C */  jal        ResetCallback
    /* F891C 8010811C 54BF20AC */   sw        $zero, %lo(CD_status)($at)
    /* F8920 80108120 1180053C */  lui        $a1, %hi(_cd_intr_dispatch)
    /* F8924 80108124 8086A524 */  addiu      $a1, $a1, %lo(_cd_intr_dispatch)
    /* F8928 80108128 1FCA030C */  jal        InterruptCallback
    /* F892C 8010812C 02000424 */   addiu     $a0, $zero, 0x2
    /* F8930 80108130 1000BF8F */  lw         $ra, 0x10($sp)
    /* F8934 80108134 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F8938 80108138 0800E003 */  jr         $ra
    /* F893C 8010813C 00000000 */   nop
endlabel CD_initintr
