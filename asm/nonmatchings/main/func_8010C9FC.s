.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010C9FC, 0x44

glabel func_8010C9FC
    /* FD1FC 8010C9FC 7410628C */  lw         $v0, 0x1074($v1)
    /* FD200 8010CA00 00000000 */  nop
    /* FD204 8010CA04 80004230 */  andi       $v0, $v0, 0x80
    /* FD208 8010CA08 0B004010 */  beqz       $v0, .L8010CA38
    /* FD20C 8010CA0C 00000000 */   nop
  .L8010CA10:
    /* FD210 8010CA10 4410628C */  lw         $v0, 0x1044($v1)
    /* FD214 8010CA14 00000000 */  nop
    /* FD218 8010CA18 80004230 */  andi       $v0, $v0, 0x80
    /* FD21C 8010CA1C FCFF4014 */  bnez       $v0, .L8010CA10
    /* FD220 8010CA20 00000000 */   nop
    /* FD224 8010CA24 0100023C */  lui        $v0, (0x10000 >> 16)
    /* FD228 8010CA28 FCDF428C */  lw         $v0, -0x2004($v0)
    /* FD22C 8010CA2C 00000000 */  nop
    /* FD230 8010CA30 08004000 */  jr         $v0
    /* FD234 8010CA34 00000000 */   nop
  .L8010CA38:
    /* FD238 8010CA38 0800E003 */  jr         $ra
    /* FD23C 8010CA3C 00000000 */   nop
endlabel func_8010C9FC
