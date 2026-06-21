.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _gpu_arm_timeout, 0x34

glabel _gpu_arm_timeout
    /* E02F8 800EFAF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E02FC 800EFAFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* E0300 800EFB00 C7C8030C */  jal        VSync
    /* E0304 800EFB04 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* E0308 800EFB08 F0004224 */  addiu      $v0, $v0, 0xF0
    /* E030C 800EFB0C 1280013C */  lui        $at, %hi(D_801237D8)
    /* E0310 800EFB10 D83722AC */  sw         $v0, %lo(D_801237D8)($at)
    /* E0314 800EFB14 1280013C */  lui        $at, %hi(D_801237DC)
    /* E0318 800EFB18 DC3720AC */  sw         $zero, %lo(D_801237DC)($at)
    /* E031C 800EFB1C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0320 800EFB20 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E0324 800EFB24 0800E003 */  jr         $ra
    /* E0328 800EFB28 00000000 */   nop
endlabel _gpu_arm_timeout
