.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_setgreedylevel, 0x6C

glabel STREAM_setgreedylevel
    /* EDA48 800FD248 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EDA4C 800FD24C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EDA50 800FD250 21888000 */  addu       $s1, $a0, $zero
    /* EDA54 800FD254 1800B0AF */  sw         $s0, 0x18($sp)
    /* EDA58 800FD258 2180A000 */  addu       $s0, $a1, $zero
    /* EDA5C 800FD25C 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDA60 800FD260 2000BFAF */  sw         $ra, 0x20($sp)
    /* EDA64 800FD264 BEF0030C */  jal        validatehandle
    /* EDA68 800FD268 1400A627 */   addiu     $a2, $sp, 0x14
    /* EDA6C 800FD26C 0C004014 */  bnez       $v0, .L800FD2A0
    /* EDA70 800FD270 00000000 */   nop
    /* EDA74 800FD274 1000A28F */  lw         $v0, 0x10($sp)
    /* EDA78 800FD278 00000000 */  nop
    /* EDA7C 800FD27C 3400438C */  lw         $v1, 0x34($v0)
    /* EDA80 800FD280 3C00448C */  lw         $a0, 0x3C($v0)
    /* EDA84 800FD284 00000000 */  nop
    /* EDA88 800FD288 2A188300 */  slt        $v1, $a0, $v1
    /* EDA8C 800FD28C 2A289000 */  slt        $a1, $a0, $s0
    /* EDA90 800FD290 03006510 */  beq        $v1, $a1, .L800FD2A0
    /* EDA94 800FD294 340050AC */   sw        $s0, 0x34($v0)
    /* EDA98 800FD298 ADF4030C */  jal        STREAM_setgreedystate
    /* EDA9C 800FD29C 21202002 */   addu      $a0, $s1, $zero
  .L800FD2A0:
    /* EDAA0 800FD2A0 2000BF8F */  lw         $ra, 0x20($sp)
    /* EDAA4 800FD2A4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EDAA8 800FD2A8 1800B08F */  lw         $s0, 0x18($sp)
    /* EDAAC 800FD2AC 0800E003 */  jr         $ra
    /* EDAB0 800FD2B0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel STREAM_setgreedylevel
