.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Udff_GetInt__FP10Udff_tInfo, 0x18

glabel Udff_GetInt__FP10Udff_tInfo
    /* AC324 800BBB24 0800838C */  lw         $v1, 0x8($a0)
    /* AC328 800BBB28 00000000 */  nop
    /* AC32C 800BBB2C 0000628C */  lw         $v0, 0x0($v1)
    /* AC330 800BBB30 04006324 */  addiu      $v1, $v1, 0x4
    /* AC334 800BBB34 0800E003 */  jr         $ra
    /* AC338 800BBB38 080083AC */   sw        $v1, 0x8($a0)
endlabel Udff_GetInt__FP10Udff_tInfo
