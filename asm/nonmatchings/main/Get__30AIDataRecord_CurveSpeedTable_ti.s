.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Get__30AIDataRecord_CurveSpeedTable_ti, 0x34

glabel Get__30AIDataRecord_CurveSpeedTable_ti
    /* 5DC4C 8006D44C 0300A104 */  bgez       $a1, .L8006D45C
    /* 5DC50 8006D450 0001A228 */   slti      $v0, $a1, 0x100
    /* 5DC54 8006D454 23280500 */  negu       $a1, $a1
    /* 5DC58 8006D458 0001A228 */  slti       $v0, $a1, 0x100
  .L8006D45C:
    /* 5DC5C 8006D45C 02004014 */  bnez       $v0, .L8006D468
    /* 5DC60 8006D460 00000000 */   nop
    /* 5DC64 8006D464 FF000524 */  addiu      $a1, $zero, 0xFF
  .L8006D468:
    /* 5DC68 8006D468 4800828C */  lw         $v0, 0x48($a0)
    /* 5DC6C 8006D46C 00000000 */  nop
    /* 5DC70 8006D470 21104500 */  addu       $v0, $v0, $a1
    /* 5DC74 8006D474 00004290 */  lbu        $v0, 0x0($v0)
    /* 5DC78 8006D478 0800E003 */  jr         $ra
    /* 5DC7C 8006D47C 00140200 */   sll       $v0, $v0, 16
endlabel Get__30AIDataRecord_CurveSpeedTable_ti
