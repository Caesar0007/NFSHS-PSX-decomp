.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_DeleteAll__Fv, 0x64

glabel Front_DeleteAll__Fv
    /* 177E8 80026FE8 0580023C */  lui        $v0, %hi(gAllScreens)
    /* 177EC 80026FEC 3419448C */  lw         $a0, %lo(gAllScreens)($v0)
    /* 177F0 80026FF0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 177F4 80026FF4 03008010 */  beqz       $a0, .L80027004
    /* 177F8 80026FF8 1000BFAF */   sw        $ra, 0x10($sp)
    /* 177FC 80026FFC C3AF000C */  jal        func_8002BF0C
    /* 17800 80027000 03000524 */   addiu     $a1, $zero, 0x3
  .L80027004:
    /* 17804 80027004 0580023C */  lui        $v0, %hi(FEApp)
    /* 17808 80027008 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1780C 8002700C 00000000 */  nop
    /* 17810 80027010 04008010 */  beqz       $a0, .L80027024
    /* 17814 80027014 0580023C */   lui       $v0, %hi(menuDefs)
    /* 17818 80027018 714C000C */  jal        ___14tFEApplication
    /* 1781C 8002701C 03000524 */   addiu     $a1, $zero, 0x3
    /* 17820 80027020 0580023C */  lui        $v0, %hi(menuDefs)
  .L80027024:
    /* 17824 80027024 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 17828 80027028 00000000 */  nop
    /* 1782C 8002702C 03008010 */  beqz       $a0, .L8002703C
    /* 17830 80027030 00000000 */   nop
    /* 17834 80027034 75C5000C */  jal        ___15tGlobalMenuDefs
    /* 17838 80027038 03000524 */   addiu     $a1, $zero, 0x3
  .L8002703C:
    /* 1783C 8002703C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 17840 80027040 00000000 */  nop
    /* 17844 80027044 0800E003 */  jr         $ra
    /* 17848 80027048 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_DeleteAll__Fv
