.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_Blit__FiiPviiP12charactertbli, 0xDC

glabel Font_Blit__FiiPviiP12charactertbli
    /* BBAAC 800CB2AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BBAB0 800CB2B0 801F0D3C */  lui        $t5, (0x1F800004 >> 16)
    /* BBAB4 800CB2B4 0400AD35 */  ori        $t5, $t5, (0x1F800004 & 0xFFFF)
    /* BBAB8 800CB2B8 FF000A3C */  lui        $t2, (0xFFFFFF >> 16)
    /* BBABC 800CB2BC FFFF4A35 */  ori        $t2, $t2, (0xFFFFFF & 0xFFFF)
    /* BBAC0 800CB2C0 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* BBAC4 800CB2C4 002C0500 */  sll        $a1, $a1, 16
    /* BBAC8 800CB2C8 2528A400 */  or         $a1, $a1, $a0
    /* BBACC 800CB2CC 1000BFAF */  sw         $ra, 0x10($sp)
    /* BBAD0 800CB2D0 0000A98D */  lw         $t1, 0x0($t5)
    /* BBAD4 800CB2D4 801F0B3C */  lui        $t3, (0x1F800000 >> 16)
    /* BBAD8 800CB2D8 00006B8D */  lw         $t3, (0x1F800000 & 0xFFFF)($t3)
    /* BBADC 800CB2DC 0C00C68C */  lw         $a2, 0xC($a2)
    /* BBAE0 800CB2E0 2C00A88F */  lw         $t0, 0x2C($sp)
    /* BBAE4 800CB2E4 00310600 */  sll        $a2, $a2, 4
    /* BBAE8 800CB2E8 03350600 */  sra        $a2, $a2, 20
    /* BBAEC 800CB2EC 21202001 */  addu       $a0, $t1, $zero
    /* BBAF0 800CB2F0 0000238D */  lw         $v1, 0x0($t1)
    /* BBAF4 800CB2F4 0000628D */  lw         $v0, 0x0($t3)
    /* BBAF8 800CB2F8 02000F91 */  lbu        $t7, 0x2($t0)
    /* BBAFC 800CB2FC 03000891 */  lbu        $t0, 0x3($t0)
    /* BBB00 800CB300 24186C00 */  and        $v1, $v1, $t4
    /* BBB04 800CB304 24104A00 */  and        $v0, $v0, $t2
    /* BBB08 800CB308 25186200 */  or         $v1, $v1, $v0
    /* BBB0C 800CB30C 000023AD */  sw         $v1, 0x0($t1)
    /* BBB10 800CB310 14002325 */  addiu      $v1, $t1, 0x14
    /* BBB14 800CB314 24502A01 */  and        $t2, $t1, $t2
    /* BBB18 800CB318 00440800 */  sll        $t0, $t0, 16
    /* BBB1C 800CB31C 2800AE8F */  lw         $t6, 0x28($sp)
    /* BBB20 800CB320 0000628D */  lw         $v0, 0x0($t3)
    /* BBB24 800CB324 25400F01 */  or         $t0, $t0, $t7
    /* BBB28 800CB328 0000A3AD */  sw         $v1, 0x0($t5)
    /* BBB2C 800CB32C 24104C00 */  and        $v0, $v0, $t4
    /* BBB30 800CB330 25104A00 */  or         $v0, $v0, $t2
    /* BBB34 800CB334 000062AD */  sw         $v0, 0x0($t3)
    /* BBB38 800CB338 04000224 */  addiu      $v0, $zero, 0x4
    /* BBB3C 800CB33C 2130CE00 */  addu       $a2, $a2, $t6
    /* BBB40 800CB340 FF00C630 */  andi       $a2, $a2, 0xFF
    /* BBB44 800CB344 030022A1 */  sb         $v0, 0x3($t1)
    /* BBB48 800CB348 1013828F */  lw         $v0, %gp_rel(font_tint)($gp)
    /* BBB4C 800CB34C 00320600 */  sll        $a2, $a2, 8
    /* BBB50 800CB350 080025AD */  sw         $a1, 0x8($t1)
    /* BBB54 800CB354 040022AD */  sw         $v0, 0x4($t1)
    /* BBB58 800CB358 18138297 */  lhu        $v0, %gp_rel(gFontClut)($gp)
    /* BBB5C 800CB35C 01000524 */  addiu      $a1, $zero, 0x1
    /* BBB60 800CB360 100028AD */  sw         $t0, 0x10($t1)
    /* BBB64 800CB364 00140200 */  sll        $v0, $v0, 16
    /* BBB68 800CB368 25104600 */  or         $v0, $v0, $a2
    /* BBB6C 800CB36C 25104700 */  or         $v0, $v0, $a3
    /* BBB70 800CB370 3FCC030C */  jal        SetSemiTrans
    /* BBB74 800CB374 0C0022AD */   sw        $v0, 0xC($t1)
    /* BBB78 800CB378 1000BF8F */  lw         $ra, 0x10($sp)
    /* BBB7C 800CB37C 00000000 */  nop
    /* BBB80 800CB380 0800E003 */  jr         $ra
    /* BBB84 800CB384 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Font_Blit__FiiPviiP12charactertbli
