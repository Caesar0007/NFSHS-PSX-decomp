.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UploadSwapShapes__7tScreeni, 0x38

glabel UploadSwapShapes__7tScreeni
    /* 167D0 80025FD0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 167D4 80025FD4 002C0500 */  sll        $a1, $a1, 16
    /* 167D8 80025FD8 032C0500 */  sra        $a1, $a1, 16
    /* 167DC 80025FDC 1000A5AF */  sw         $a1, 0x10($sp)
    /* 167E0 80025FE0 28008524 */  addiu      $a1, $a0, 0x28
    /* 167E4 80025FE4 21300000 */  addu       $a2, $zero, $zero
    /* 167E8 80025FE8 2138C000 */  addu       $a3, $a2, $zero
    /* 167EC 80025FEC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 167F0 80025FF0 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 167F4 80025FF4 1400A0AF */   sw        $zero, 0x14($sp)
    /* 167F8 80025FF8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 167FC 80025FFC 00000000 */  nop
    /* 16800 80026000 0800E003 */  jr         $ra
    /* 16804 80026004 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UploadSwapShapes__7tScreeni
