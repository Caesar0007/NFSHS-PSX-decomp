.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcTextFadeUnselToSel__F13tMenuTextTypess, 0x70

glabel CalcTextFadeUnselToSel__F13tMenuTextTypess
    /* 3C0E0 8004B8E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3C0E4 8004B8E4 0580083C */  lui        $t0, %hi(kRGBVals)
    /* 3C0E8 8004B8E8 0580073C */  lui        $a3, %hi(textDefinitions)
    /* 3C0EC 8004B8EC B815E724 */  addiu      $a3, $a3, %lo(textDefinitions)
    /* 3C0F0 8004B8F0 40100400 */  sll        $v0, $a0, 1
    /* 3C0F4 8004B8F4 21104400 */  addu       $v0, $v0, $a0
    /* 3C0F8 8004B8F8 40100200 */  sll        $v0, $v0, 1
    /* 3C0FC 8004B8FC 21184700 */  addu       $v1, $v0, $a3
    /* 3C100 8004B900 C8160825 */  addiu      $t0, $t0, %lo(kRGBVals)
    /* 3C104 8004B904 21104700 */  addu       $v0, $v0, $a3
    /* 3C108 8004B908 002C0500 */  sll        $a1, $a1, 16
    /* 3C10C 8004B90C 003C0600 */  sll        $a3, $a2, 16
    /* 3C110 8004B910 03340500 */  sra        $a2, $a1, 16
    /* 3C114 8004B914 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3C118 8004B918 03006390 */  lbu        $v1, 0x3($v1)
    /* 3C11C 8004B91C 04004290 */  lbu        $v0, 0x4($v0)
    /* 3C120 8004B920 80180300 */  sll        $v1, $v1, 2
    /* 3C124 8004B924 21186800 */  addu       $v1, $v1, $t0
    /* 3C128 8004B928 80100200 */  sll        $v0, $v0, 2
    /* 3C12C 8004B92C 21104800 */  addu       $v0, $v0, $t0
    /* 3C130 8004B930 0000648C */  lw         $a0, 0x0($v1)
    /* 3C134 8004B934 0000458C */  lw         $a1, 0x0($v0)
    /* 3C138 8004B938 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* 3C13C 8004B93C 033C0700 */   sra       $a3, $a3, 16
    /* 3C140 8004B940 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3C144 8004B944 00000000 */  nop
    /* 3C148 8004B948 0800E003 */  jr         $ra
    /* 3C14C 8004B94C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcTextFadeUnselToSel__F13tMenuTextTypess
