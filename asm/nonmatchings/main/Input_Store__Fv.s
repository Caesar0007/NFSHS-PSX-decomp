.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_Store__Fv, 0x8C

glabel Input_Store__Fv
    /* 8DA08 8009D208 1480023C */  lui        $v0, %hi(gSimQueue_BlockSelf)
    /* 8DA0C 8009D20C 38D4428C */  lw         $v0, %lo(gSimQueue_BlockSelf)($v0)
    /* 8DA10 8009D210 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8DA14 8009D214 1B004014 */  bnez       $v0, .L8009D284
    /* 8DA18 8009D218 1000BFAF */   sw        $ra, 0x10($sp)
    /* 8DA1C 8009D21C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8DA20 8009D220 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 8DA24 8009D224 C803628C */  lw         $v0, 0x3C8($v1)
    /* 8DA28 8009D228 00000000 */  nop
    /* 8DA2C 8009D22C 02004228 */  slti       $v0, $v0, 0x2
    /* 8DA30 8009D230 0B004014 */  bnez       $v0, .L8009D260
    /* 8DA34 8009D234 00000000 */   nop
    /* 8DA38 8009D238 1480053C */  lui        $a1, %hi(Input_gResults)
    /* 8DA3C 8009D23C 24D2A524 */  addiu      $a1, $a1, %lo(Input_gResults)
    /* 8DA40 8009D240 F3DC020C */  jal        SimQueue_Put__FiP14Input_tResults
    /* 8DA44 8009D244 21200000 */   addu      $a0, $zero, $zero
    /* 8DA48 8009D248 0E004010 */  beqz       $v0, .L8009D284
    /* 8DA4C 8009D24C 01000424 */   addiu     $a0, $zero, 0x1
    /* 8DA50 8009D250 1480053C */  lui        $a1, %hi(D_8013D228)
    /* 8DA54 8009D254 28D2A524 */  addiu      $a1, $a1, %lo(D_8013D228)
    /* 8DA58 8009D258 9F740208 */  j          .L8009D27C
    /* 8DA5C 8009D25C 00000000 */   nop
  .L8009D260:
    /* 8DA60 8009D260 0C00628C */  lw         $v0, 0xC($v1)
    /* 8DA64 8009D264 00000000 */  nop
    /* 8DA68 8009D268 06004014 */  bnez       $v0, .L8009D284
    /* 8DA6C 8009D26C 00000000 */   nop
    /* 8DA70 8009D270 1C00648C */  lw         $a0, 0x1C($v1)
    /* 8DA74 8009D274 1480053C */  lui        $a1, %hi(Input_gResults)
    /* 8DA78 8009D278 24D2A524 */  addiu      $a1, $a1, %lo(Input_gResults)
  .L8009D27C:
    /* 8DA7C 8009D27C F3DC020C */  jal        SimQueue_Put__FiP14Input_tResults
    /* 8DA80 8009D280 00000000 */   nop
  .L8009D284:
    /* 8DA84 8009D284 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8DA88 8009D288 00000000 */  nop
    /* 8DA8C 8009D28C 0800E003 */  jr         $ra
    /* 8DA90 8009D290 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Input_Store__Fv
