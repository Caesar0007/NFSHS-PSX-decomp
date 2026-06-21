.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheapestCarStockPrice__11tCarManager, 0x58

glabel CheapestCarStockPrice__11tCarManager
    /* 6AEC 800162EC 9800063C */  lui        $a2, (0x989680 >> 16)
    /* 6AF0 800162F0 8096C634 */  ori        $a2, $a2, (0x989680 & 0xFFFF)
    /* 6AF4 800162F4 0000828C */  lw         $v0, 0x0($a0)
    /* 6AF8 800162F8 00000000 */  nop
    /* 6AFC 800162FC 0F004010 */  beqz       $v0, .L8001633C
    /* 6B00 80016300 21280000 */   addu      $a1, $zero, $zero
    /* 6B04 80016304 21384000 */  addu       $a3, $v0, $zero
    /* 6B08 80016308 0400848C */  lw         $a0, 0x4($a0)
  .L8001630C:
    /* 6B0C 8001630C 00000000 */  nop
    /* 6B10 80016310 2000838C */  lw         $v1, 0x20($a0)
    /* 6B14 80016314 00000000 */  nop
    /* 6B18 80016318 04006018 */  blez       $v1, .L8001632C
    /* 6B1C 8001631C 2A106600 */   slt       $v0, $v1, $a2
    /* 6B20 80016320 02004010 */  beqz       $v0, .L8001632C
    /* 6B24 80016324 00000000 */   nop
    /* 6B28 80016328 21306000 */  addu       $a2, $v1, $zero
  .L8001632C:
    /* 6B2C 8001632C 0100A524 */  addiu      $a1, $a1, 0x1
    /* 6B30 80016330 2B10A700 */  sltu       $v0, $a1, $a3
    /* 6B34 80016334 F5FF4014 */  bnez       $v0, .L8001630C
    /* 6B38 80016338 CC008424 */   addiu     $a0, $a0, 0xCC
  .L8001633C:
    /* 6B3C 8001633C 0800E003 */  jr         $ra
    /* 6B40 80016340 2110C000 */   addu      $v0, $a2, $zero
endlabel CheapestCarStockPrice__11tCarManager
