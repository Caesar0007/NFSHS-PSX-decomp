.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F8E44, 0x7C

glabel func_800F8E44
    /* E9644 800F8E44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E9648 800F8E48 21288000 */  addu       $a1, $a0, $zero
    /* E964C 800F8E4C 0580043C */  lui        $a0, %hi(D_8005716C)
    /* E9650 800F8E50 6C718424 */  addiu      $a0, $a0, %lo(D_8005716C)
    /* E9654 800F8E54 1000BFAF */  sw         $ra, 0x10($sp)
    /* E9658 800F8E58 2B0A040C */  jal        printf
    /* E965C 800F8E5C 00000000 */   nop
    /* E9660 800F8E60 1380033C */  lui        $v1, %hi(D_80136C3C)
    /* E9664 800F8E64 3C6C638C */  lw         $v1, %lo(D_80136C3C)($v1)
    /* E9668 800F8E68 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E966C 800F8E6C 000062AC */  sw         $v0, 0x0($v1)
    /* E9670 800F8E70 1380023C */  lui        $v0, %hi(D_80136C10)
    /* E9674 800F8E74 106C428C */  lw         $v0, %lo(D_80136C10)($v0)
    /* E9678 800F8E78 00000000 */  nop
    /* E967C 800F8E7C 000040AC */  sw         $zero, 0x0($v0)
    /* E9680 800F8E80 1380023C */  lui        $v0, %hi(D_80136C1C)
    /* E9684 800F8E84 1C6C428C */  lw         $v0, %lo(D_80136C1C)($v0)
    /* E9688 800F8E88 00000000 */  nop
    /* E968C 800F8E8C 000040AC */  sw         $zero, 0x0($v0)
    /* E9690 800F8E90 21100000 */  addu       $v0, $zero, $zero
    /* E9694 800F8E94 1380033C */  lui        $v1, %hi(D_80136C1C)
    /* E9698 800F8E98 1C6C638C */  lw         $v1, %lo(D_80136C1C)($v1)
    /* E969C 800F8E9C 1380043C */  lui        $a0, %hi(D_80136C3C)
    /* E96A0 800F8EA0 3C6C848C */  lw         $a0, %lo(D_80136C3C)($a0)
    /* E96A4 800F8EA4 0000638C */  lw         $v1, 0x0($v1)
    /* E96A8 800F8EA8 0060033C */  lui        $v1, (0x60000000 >> 16)
    /* E96AC 800F8EAC 000083AC */  sw         $v1, 0x0($a0)
    /* E96B0 800F8EB0 1000BF8F */  lw         $ra, 0x10($sp)
    /* E96B4 800F8EB4 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E96B8 800F8EB8 0800E003 */  jr         $ra
    /* E96BC 800F8EBC 00000000 */   nop
endlabel func_800F8E44
    /* E96C0 800F8EC0 00000000 */  nop
    /* E96C4 800F8EC4 00000000 */  nop
