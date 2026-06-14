.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileadrz, 0x40

glabel loadfileadrz
    /* D5FA8 800E57A8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D5FAC 800E57AC 2000BFAF */  sw         $ra, 0x20($sp)
    /* D5FB0 800E57B0 1000A4AF */  sw         $a0, 0x10($sp)
    /* D5FB4 800E57B4 1800A5AF */  sw         $a1, 0x18($sp)
    /* D5FB8 800E57B8 45D8030C */  jal        setclipwindow
    /* D5FBC 800E57BC 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* D5FC0 800E57C0 0E80043C */  lui        $a0, %hi(func_800E56B0)
    /* D5FC4 800E57C4 B0568424 */  addiu      $a0, $a0, %lo(func_800E56B0)
    /* D5FC8 800E57C8 21284000 */  addu       $a1, $v0, $zero
    /* D5FCC 800E57CC 64000624 */  addiu      $a2, $zero, 0x64
    /* D5FD0 800E57D0 D0B2030C */  jal        FILE_atomic
    /* D5FD4 800E57D4 1000A727 */   addiu     $a3, $sp, 0x10
    /* D5FD8 800E57D8 2000BF8F */  lw         $ra, 0x20($sp)
    /* D5FDC 800E57DC 00000000 */  nop
    /* D5FE0 800E57E0 0800E003 */  jr         $ra
    /* D5FE4 800E57E4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadfileadrz
