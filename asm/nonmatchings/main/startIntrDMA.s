.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching startIntrDMA, 0x4C

glabel startIntrDMA
    /* F6EAC 801066AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F6EB0 801066B0 1480043C */  lui        $a0, %hi(D_8013BD24)
    /* F6EB4 801066B4 24BD8424 */  addiu      $a0, $a0, %lo(D_8013BD24)
    /* F6EB8 801066B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* F6EBC 801066BC 491A040C */  jal        _bzero_w
    /* F6EC0 801066C0 08000524 */   addiu     $a1, $zero, 0x8
    /* F6EC4 801066C4 03000424 */  addiu      $a0, $zero, 0x3
    /* F6EC8 801066C8 1480023C */  lui        $v0, %hi(D_8013BD20)
    /* F6ECC 801066CC 20BD428C */  lw         $v0, %lo(D_8013BD20)($v0)
    /* F6ED0 801066D0 1080053C */  lui        $a1, %hi(_dma_isr)
    /* F6ED4 801066D4 F866A524 */  addiu      $a1, $a1, %lo(_dma_isr)
    /* F6ED8 801066D8 1FCA030C */  jal        InterruptCallback
    /* F6EDC 801066DC 000040AC */   sw        $zero, 0x0($v0)
    /* F6EE0 801066E0 1080023C */  lui        $v0, %hi(func_80106878)
    /* F6EE4 801066E4 78684224 */  addiu      $v0, $v0, %lo(func_80106878)
    /* F6EE8 801066E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F6EEC 801066EC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F6EF0 801066F0 0800E003 */  jr         $ra
    /* F6EF4 801066F4 00000000 */   nop
endlabel startIntrDMA
