.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileatadrz, 0x40

glabel loadfileatadrz
    /* D60B0 800E58B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D60B4 800E58B4 2000BFAF */  sw         $ra, 0x20($sp)
    /* D60B8 800E58B8 1000A4AF */  sw         $a0, 0x10($sp)
    /* D60BC 800E58BC 1400A5AF */  sw         $a1, 0x14($sp)
    /* D60C0 800E58C0 45D8030C */  jal        setclipwindow
    /* D60C4 800E58C4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* D60C8 800E58C8 0E80043C */  lui        $a0, %hi(loadfileatadratomic)
    /* D60CC 800E58CC 30588424 */  addiu      $a0, $a0, %lo(loadfileatadratomic)
    /* D60D0 800E58D0 21284000 */  addu       $a1, $v0, $zero
    /* D60D4 800E58D4 64000624 */  addiu      $a2, $zero, 0x64
    /* D60D8 800E58D8 D0B2030C */  jal        FILE_atomic
    /* D60DC 800E58DC 1000A727 */   addiu     $a3, $sp, 0x10
    /* D60E0 800E58E0 2000BF8F */  lw         $ra, 0x20($sp)
    /* D60E4 800E58E4 00000000 */  nop
    /* D60E8 800E58E8 0800E003 */  jr         $ra
    /* D60EC 800E58EC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadfileatadrz
