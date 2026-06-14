.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching nfs2eacinit__Fv, 0x48

glabel nfs2eacinit__Fv
    /* CCC58 800DC458 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CCC5C 800DC45C 1000BFAF */  sw         $ra, 0x10($sp)
    /* CCC60 800DC460 F5D0030C */  jal        FlushCache
    /* CCC64 800DC464 00000000 */   nop
    /* CCC68 800DC468 13CA030C */  jal        ResetCallback
    /* CCC6C 800DC46C 00000000 */   nop
    /* CCC70 800DC470 9CB5030C */  jal        ResetGraph
    /* CCC74 800DC474 03000424 */   addiu     $a0, $zero, 0x3
    /* CCC78 800DC478 7ECE030C */  jal        initjoy
    /* CCC7C 800DC47C 02000424 */   addiu     $a0, $zero, 0x2
    /* CCC80 800DC480 0A000424 */  addiu      $a0, $zero, 0xA
    /* CCC84 800DC484 20030524 */  addiu      $a1, $zero, 0x320
    /* CCC88 800DC488 FDAE030C */  jal        FILE_init
    /* CCC8C 800DC48C 30000624 */   addiu     $a2, $zero, 0x30
    /* CCC90 800DC490 1000BF8F */  lw         $ra, 0x10($sp)
    /* CCC94 800DC494 00000000 */  nop
    /* CCC98 800DC498 0800E003 */  jr         $ra
    /* CCC9C 800DC49C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel nfs2eacinit__Fv
