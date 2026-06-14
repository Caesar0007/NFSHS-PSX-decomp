.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileatadr, 0x48

glabel loadfileatadr
    /* D60F0 800E58F0 1480023C */  lui        $v0, %hi(abortflag)
    /* D60F4 800E58F4 D4DC428C */  lw         $v0, %lo(abortflag)($v0)
    /* D60F8 800E58F8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D60FC 800E58FC 2000BFAF */  sw         $ra, 0x20($sp)
    /* D6100 800E5900 1000A4AF */  sw         $a0, 0x10($sp)
    /* D6104 800E5904 1400A5AF */  sw         $a1, 0x14($sp)
    /* D6108 800E5908 45D8030C */  jal        setclipwindow
    /* D610C 800E590C 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* D6110 800E5910 0E80043C */  lui        $a0, %hi(func_800E5830)
    /* D6114 800E5914 30588424 */  addiu      $a0, $a0, %lo(func_800E5830)
    /* D6118 800E5918 21284000 */  addu       $a1, $v0, $zero
    /* D611C 800E591C 64000624 */  addiu      $a2, $zero, 0x64
    /* D6120 800E5920 D0B2030C */  jal        FILE_atomic
    /* D6124 800E5924 1000A727 */   addiu     $a3, $sp, 0x10
    /* D6128 800E5928 2000BF8F */  lw         $ra, 0x20($sp)
    /* D612C 800E592C 00000000 */  nop
    /* D6130 800E5930 0800E003 */  jr         $ra
    /* D6134 800E5934 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadfileatadr
