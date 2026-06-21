.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_GetRecords__FsP13tRecordBuffer, 0x48

glabel Stattool_GetRecords__FsP13tRecordBuffer
    /* 3B618 8004AE18 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3B61C 8004AE1C 00240400 */  sll        $a0, $a0, 16
    /* 3B620 8004AE20 03240400 */  sra        $a0, $a0, 16
    /* 3B624 8004AE24 80100400 */  sll        $v0, $a0, 2
    /* 3B628 8004AE28 21104400 */  addu       $v0, $v0, $a0
    /* 3B62C 8004AE2C 00190200 */  sll        $v1, $v0, 4
    /* 3B630 8004AE30 21104300 */  addu       $v0, $v0, $v1
    /* 3B634 8004AE34 80100200 */  sll        $v0, $v0, 2
    /* 3B638 8004AE38 1180043C */  lui        $a0, %hi(Stats_gTrackRecords)
    /* 3B63C 8004AE3C 944D8424 */  addiu      $a0, $a0, %lo(Stats_gTrackRecords)
    /* 3B640 8004AE40 21204400 */  addu       $a0, $v0, $a0
    /* 3B644 8004AE44 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3B648 8004AE48 B798030C */  jal        blockmove
    /* 3B64C 8004AE4C 54010624 */   addiu     $a2, $zero, 0x154
    /* 3B650 8004AE50 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3B654 8004AE54 00000000 */  nop
    /* 3B658 8004AE58 0800E003 */  jr         $ra
    /* 3B65C 8004AE5C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Stattool_GetRecords__FsP13tRecordBuffer
