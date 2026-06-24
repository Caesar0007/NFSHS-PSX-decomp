.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _MDEC_in_dma, 0x90

glabel _MDEC_in_dma
    /* E93E8 800F8BE8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E93EC 800F8BEC 1400B1AF */  sw         $s1, 0x14($sp)
    /* E93F0 800F8BF0 21888000 */  addu       $s1, $a0, $zero
    /* E93F4 800F8BF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* E93F8 800F8BF8 1800BFAF */  sw         $ra, 0x18($sp)
    /* E93FC 800F8BFC 41E3030C */  jal        MDEC_in_sync
    /* E9400 800F8C00 2180A000 */   addu      $s0, $a1, $zero
    /* E9404 800F8C04 1380033C */  lui        $v1, %hi(D_80136C40)
    /* E9408 800F8C08 406C638C */  lw         $v1, %lo(D_80136C40)($v1)
    /* E940C 800F8C0C 42811000 */  srl        $s0, $s0, 5
    /* E9410 800F8C10 0000628C */  lw         $v0, 0x0($v1)
    /* E9414 800F8C14 00841000 */  sll        $s0, $s0, 16
    /* E9418 800F8C18 88004234 */  ori        $v0, $v0, 0x88
    /* E941C 800F8C1C 000062AC */  sw         $v0, 0x0($v1)
    /* E9420 800F8C20 1380033C */  lui        $v1, %hi(D_80136C08)
    /* E9424 800F8C24 086C638C */  lw         $v1, %lo(D_80136C08)($v1)
    /* E9428 800F8C28 04002226 */  addiu      $v0, $s1, 0x4
    /* E942C 800F8C2C 000062AC */  sw         $v0, 0x0($v1)
    /* E9430 800F8C30 1380023C */  lui        $v0, %hi(D_80136C0C)
    /* E9434 800F8C34 0C6C428C */  lw         $v0, %lo(D_80136C0C)($v0)
    /* E9438 800F8C38 20001036 */  ori        $s0, $s0, 0x20
    /* E943C 800F8C3C 000050AC */  sw         $s0, 0x0($v0)
    /* E9440 800F8C40 1380033C */  lui        $v1, %hi(D_80136C38)
    /* E9444 800F8C44 386C638C */  lw         $v1, %lo(D_80136C38)($v1)
    /* E9448 800F8C48 0000228E */  lw         $v0, 0x0($s1)
    /* E944C 800F8C4C 0001043C */  lui        $a0, (0x1000201 >> 16)
    /* E9450 800F8C50 000062AC */  sw         $v0, 0x0($v1)
    /* E9454 800F8C54 1380023C */  lui        $v0, %hi(D_80136C10)
    /* E9458 800F8C58 106C428C */  lw         $v0, %lo(D_80136C10)($v0)
    /* E945C 800F8C5C 01028434 */  ori        $a0, $a0, (0x1000201 & 0xFFFF)
    /* E9460 800F8C60 000044AC */  sw         $a0, 0x0($v0)
    /* E9464 800F8C64 1800BF8F */  lw         $ra, 0x18($sp)
    /* E9468 800F8C68 1400B18F */  lw         $s1, 0x14($sp)
    /* E946C 800F8C6C 1000B08F */  lw         $s0, 0x10($sp)
    /* E9470 800F8C70 0800E003 */  jr         $ra
    /* E9474 800F8C74 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _MDEC_in_dma
