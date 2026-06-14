.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileadr, 0x48

glabel loadfileadr
    /* D5FE8 800E57E8 1480023C */  lui        $v0, %hi(abortflag)
    /* D5FEC 800E57EC D4DC428C */  lw         $v0, %lo(abortflag)($v0)
    /* D5FF0 800E57F0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D5FF4 800E57F4 2000BFAF */  sw         $ra, 0x20($sp)
    /* D5FF8 800E57F8 1000A4AF */  sw         $a0, 0x10($sp)
    /* D5FFC 800E57FC 1800A5AF */  sw         $a1, 0x18($sp)
    /* D6000 800E5800 45D8030C */  jal        setclipwindow
    /* D6004 800E5804 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* D6008 800E5808 0E80043C */  lui        $a0, %hi(func_800E56B0)
    /* D600C 800E580C B0568424 */  addiu      $a0, $a0, %lo(func_800E56B0)
    /* D6010 800E5810 21284000 */  addu       $a1, $v0, $zero
    /* D6014 800E5814 64000624 */  addiu      $a2, $zero, 0x64
    /* D6018 800E5818 D0B2030C */  jal        FILE_atomic
    /* D601C 800E581C 1000A727 */   addiu     $a3, $sp, 0x10
    /* D6020 800E5820 2000BF8F */  lw         $ra, 0x20($sp)
    /* D6024 800E5824 00000000 */  nop
    /* D6028 800E5828 0800E003 */  jr         $ra
    /* D602C 800E582C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadfileadr
