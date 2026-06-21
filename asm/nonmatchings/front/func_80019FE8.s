.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80019FE8, 0x30

glabel func_80019FE8
    /* A7E8 80019FE8 00008294 */  lhu        $v0, 0x0($a0)
    /* A7EC 80019FEC 0580033C */  lui        $v1, %hi(D_80052B58)
    /* A7F0 80019FF0 582B62A4 */  sh         $v0, %lo(D_80052B58)($v1)
    /* A7F4 80019FF4 02008294 */  lhu        $v0, 0x2($a0)
    /* A7F8 80019FF8 582B6324 */  addiu      $v1, $v1, %lo(D_80052B58)
    /* A7FC 80019FFC 020062A4 */  sh         $v0, 0x2($v1)
    /* A800 8001A000 04008294 */  lhu        $v0, 0x4($a0)
    /* A804 8001A004 00000000 */  nop
    /* A808 8001A008 040062A4 */  sh         $v0, 0x4($v1)
    /* A80C 8001A00C 06008294 */  lhu        $v0, 0x6($a0)
    /* A810 8001A010 0800E003 */  jr         $ra
    /* A814 8001A014 060062A4 */   sh        $v0, 0x6($v1)
endlabel func_80019FE8
