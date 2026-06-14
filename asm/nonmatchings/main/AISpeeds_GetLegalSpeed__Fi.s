.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetLegalSpeed__Fi, 0x44

glabel AISpeeds_GetLegalSpeed__Fi
    /* 5F50C 8006ED0C 1180033C */  lui        $v1, %hi(AISpeeds_TrackSpeeds)
    /* 5F510 8006ED10 1180023C */  lui        $v0, %hi(D_80113228)
    /* 5F514 8006ED14 2832428C */  lw         $v0, %lo(D_80113228)($v0)
    /* 5F518 8006ED18 78DD6324 */  addiu      $v1, $v1, %lo(AISpeeds_TrackSpeeds)
    /* 5F51C 8006ED1C 80100200 */  sll        $v0, $v0, 2
    /* 5F520 8006ED20 21104300 */  addu       $v0, $v0, $v1
    /* 5F524 8006ED24 0000438C */  lw         $v1, 0x0($v0)
  .L8006ED28:
    /* 5F528 8006ED28 00000000 */  nop
    /* 5F52C 8006ED2C 00006294 */  lhu        $v0, 0x0($v1)
    /* 5F530 8006ED30 00000000 */  nop
    /* 5F534 8006ED34 2A104400 */  slt        $v0, $v0, $a0
    /* 5F538 8006ED38 FBFF4014 */  bnez       $v0, .L8006ED28
    /* 5F53C 8006ED3C 04006324 */   addiu     $v1, $v1, 0x4
    /* 5F540 8006ED40 FCFF6324 */  addiu      $v1, $v1, -0x4
    /* 5F544 8006ED44 02006294 */  lhu        $v0, 0x2($v1)
    /* 5F548 8006ED48 0800E003 */  jr         $ra
    /* 5F54C 8006ED4C 00120200 */   sll       $v0, $v0, 8
endlabel AISpeeds_GetLegalSpeed__Fi
