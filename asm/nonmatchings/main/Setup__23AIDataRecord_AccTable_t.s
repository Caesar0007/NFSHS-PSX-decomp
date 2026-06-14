.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Setup__23AIDataRecord_AccTable_t, 0x6C

glabel Setup__23AIDataRecord_AccTable_t
    /* 5DA0C 8006D20C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5DA10 8006D210 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5DA14 8006D214 21888000 */  addu       $s1, $a0, $zero
    /* 5DA18 8006D218 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5DA1C 8006D21C 23B4010C */  jal        Setup__14AIDataRecord_t
    /* 5DA20 8006D220 1000B0AF */   sw        $s0, 0x10($sp)
    /* 5DA24 8006D224 21800000 */  addu       $s0, $zero, $zero
  .L8006D228:
    /* 5DA28 8006D228 7000022A */  slti       $v0, $s0, 0x70
    /* 5DA2C 8006D22C 0D004010 */  beqz       $v0, .L8006D264
    /* 5DA30 8006D230 21202002 */   addu      $a0, $s1, $zero
    /* 5DA34 8006D234 7DB4010C */  jal        Get__23AIDataRecord_AccTable_ti
    /* 5DA38 8006D238 21280002 */   addu      $a1, $s0, $zero
    /* 5DA3C 8006D23C 5800258E */  lw         $a1, 0x58($s1)
    /* 5DA40 8006D240 CA90030C */  jal        fixedmult
    /* 5DA44 8006D244 21204000 */   addu      $a0, $v0, $zero
    /* 5DA48 8006D248 40181000 */  sll        $v1, $s0, 1
    /* 5DA4C 8006D24C 01001026 */  addiu      $s0, $s0, 0x1
    /* 5DA50 8006D250 4800248E */  lw         $a0, 0x48($s1)
    /* 5DA54 8006D254 03120200 */  sra        $v0, $v0, 8
    /* 5DA58 8006D258 21186400 */  addu       $v1, $v1, $a0
    /* 5DA5C 8006D25C 8AB40108 */  j          .L8006D228
    /* 5DA60 8006D260 000062A4 */   sh        $v0, 0x0($v1)
  .L8006D264:
    /* 5DA64 8006D264 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5DA68 8006D268 1400B18F */  lw         $s1, 0x14($sp)
    /* 5DA6C 8006D26C 1000B08F */  lw         $s0, 0x10($sp)
    /* 5DA70 8006D270 0800E003 */  jr         $ra
    /* 5DA74 8006D274 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Setup__23AIDataRecord_AccTable_t
