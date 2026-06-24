.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardStart, 0x50

glabel MemCardStart
    /* EB2F8 800FAAF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB2FC 800FAAFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB300 800FAB00 0027040C */  jal        UserFuncInit
    /* EB304 800FAB04 00000000 */   nop
    /* EB308 800FAB08 1480023C */  lui        $v0, %hi(D_80147518)
    /* EB30C 800FAB0C 18754224 */  addiu      $v0, $v0, %lo(D_80147518)
    /* EB310 800FAB10 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* EB314 800FAB14 000040AC */  sw         $zero, 0x0($v0)
    /* EB318 800FAB18 040040AC */  sw         $zero, 0x4($v0)
    /* EB31C 800FAB1C 080040AC */  sw         $zero, 0x8($v0)
    /* EB320 800FAB20 8825040C */  jal        _card_start
    /* EB324 800FAB24 100043AC */   sw        $v1, 0x10($v0)
    /* EB328 800FAB28 1080053C */  lui        $a1, %hi(MemCardStart_cb)
    /* EB32C 800FAB2C 70C1A524 */  addiu      $a1, $a1, %lo(MemCardStart_cb)
    /* EB330 800FAB30 44CA030C */  jal        VSyncCallbacks
    /* EB334 800FAB34 07000424 */   addiu     $a0, $zero, 0x7
    /* EB338 800FAB38 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB33C 800FAB3C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB340 800FAB40 0800E003 */  jr         $ra
    /* EB344 800FAB44 00000000 */   nop
endlabel MemCardStart
