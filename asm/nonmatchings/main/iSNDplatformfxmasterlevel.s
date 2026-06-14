.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformfxmasterlevel, 0x2C

glabel iSNDplatformfxmasterlevel
    /* F0DBC 801005BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F0DC0 801005C0 C0210500 */  sll        $a0, $a1, 7
    /* F0DC4 801005C4 21208500 */  addu       $a0, $a0, $a1
    /* F0DC8 801005C8 40200400 */  sll        $a0, $a0, 1
    /* F0DCC 801005CC 1000BFAF */  sw         $ra, 0x10($sp)
    /* F0DD0 801005D0 84FC030C */  jal        iSNDpsxeffectvol
    /* F0DD4 801005D4 21288000 */   addu      $a1, $a0, $zero
    /* F0DD8 801005D8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F0DDC 801005DC 21100000 */  addu       $v0, $zero, $zero
    /* F0DE0 801005E0 0800E003 */  jr         $ra
    /* F0DE4 801005E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDplatformfxmasterlevel
