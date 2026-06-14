.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDmulu64, 0x9C

glabel iSNDmulu64
    /* F3C24 80103424 21108000 */  addu       $v0, $a0, $zero
    /* F3C28 80103428 FFFFA430 */  andi       $a0, $a1, 0xFFFF
    /* F3C2C 8010342C FFFFC830 */  andi       $t0, $a2, 0xFFFF
    /* F3C30 80103430 18008800 */  mult       $a0, $t0
    /* F3C34 80103434 12380000 */  mflo       $a3
    /* F3C38 80103438 02340600 */  srl        $a2, $a2, 16
    /* F3C3C 8010343C 00000000 */  nop
    /* F3C40 80103440 18008600 */  mult       $a0, $a2
    /* F3C44 80103444 12200000 */  mflo       $a0
    /* F3C48 80103448 022C0500 */  srl        $a1, $a1, 16
    /* F3C4C 8010344C 00000000 */  nop
    /* F3C50 80103450 1800A800 */  mult       $a1, $t0
    /* F3C54 80103454 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* F3C58 80103458 001C0400 */  sll        $v1, $a0, 16
    /* F3C5C 8010345C 12400000 */  mflo       $t0
    /* F3C60 80103460 2118E300 */  addu       $v1, $a3, $v1
    /* F3C64 80103464 023C0700 */  srl        $a3, $a3, 16
    /* F3C68 80103468 1800A600 */  mult       $a1, $a2
    /* F3C6C 8010346C 004C0800 */  sll        $t1, $t0, 16
    /* F3C70 80103470 21186900 */  addu       $v1, $v1, $t1
    /* F3C74 80103474 0000A3AF */  sw         $v1, 0x0($sp)
    /* F3C78 80103478 FFFF8330 */  andi       $v1, $a0, 0xFFFF
    /* F3C7C 8010347C 2138E300 */  addu       $a3, $a3, $v1
    /* F3C80 80103480 FFFF0331 */  andi       $v1, $t0, 0xFFFF
    /* F3C84 80103484 2138E300 */  addu       $a3, $a3, $v1
    /* F3C88 80103488 023C0700 */  srl        $a3, $a3, 16
    /* F3C8C 8010348C 02240400 */  srl        $a0, $a0, 16
    /* F3C90 80103490 02440800 */  srl        $t0, $t0, 16
    /* F3C94 80103494 21208800 */  addu       $a0, $a0, $t0
    /* F3C98 80103498 12700000 */  mflo       $t6
    /* F3C9C 8010349C 21208E00 */  addu       $a0, $a0, $t6
    /* F3CA0 801034A0 21208700 */  addu       $a0, $a0, $a3
    /* F3CA4 801034A4 0400A4AF */  sw         $a0, 0x4($sp)
    /* F3CA8 801034A8 0000AA8F */  lw         $t2, 0x0($sp)
    /* F3CAC 801034AC 0400AB8F */  lw         $t3, 0x4($sp)
    /* F3CB0 801034B0 00004AAC */  sw         $t2, 0x0($v0)
    /* F3CB4 801034B4 04004BAC */  sw         $t3, 0x4($v0)
    /* F3CB8 801034B8 0800E003 */  jr         $ra
    /* F3CBC 801034BC 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel iSNDmulu64
