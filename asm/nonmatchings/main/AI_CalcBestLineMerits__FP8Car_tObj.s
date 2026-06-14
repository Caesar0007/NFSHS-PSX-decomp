.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CalcBestLineMerits__FP8Car_tObj, 0x88

glabel AI_CalcBestLineMerits__FP8Car_tObj
    /* 49EA4 800596A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 49EA8 800596A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 49EAC 800596AC 21808000 */  addu       $s0, $a0, $zero
    /* 49EB0 800596B0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 49EB4 800596B4 6002028E */  lw         $v0, 0x260($s0)
    /* 49EB8 800596B8 5807038E */  lw         $v1, 0x758($s0)
    /* 49EBC 800596BC 08004230 */  andi       $v0, $v0, 0x8
    /* 49EC0 800596C0 16004010 */  beqz       $v0, .L8005971C
    /* 49EC4 800596C4 00000000 */   nop
    /* 49EC8 800596C8 1480023C */  lui        $v0, %hi(AIDataRecord_BestLine)
    /* 49ECC 800596CC A0C5428C */  lw         $v0, %lo(AIDataRecord_BestLine)($v0)
    /* 49ED0 800596D0 00000000 */  nop
    /* 49ED4 800596D4 4800428C */  lw         $v0, 0x48($v0)
    /* 49ED8 800596D8 00000000 */  nop
    /* 49EDC 800596DC 21104300 */  addu       $v0, $v0, $v1
    /* 49EE0 800596E0 F004038E */  lw         $v1, 0x4F0($s0)
    /* 49EE4 800596E4 00004580 */  lb         $a1, 0x0($v0)
    /* 49EE8 800596E8 4400648C */  lw         $a0, 0x44($v1)
    /* 49EEC 800596EC CA90030C */  jal        fixedmult
    /* 49EF0 800596F0 802B0500 */   sll       $a1, $a1, 14
    /* 49EF4 800596F4 6C05048E */  lw         $a0, 0x56C($s0)
    /* 49EF8 800596F8 5405038E */  lw         $v1, 0x554($s0)
    /* 49EFC 800596FC 00000000 */  nop
    /* 49F00 80059700 18008300 */  mult       $a0, $v1
    /* 49F04 80059704 1C0702AE */  sw         $v0, 0x71C($s0)
    /* 49F08 80059708 0500033C */  lui        $v1, (0x50000 >> 16)
    /* 49F0C 8005970C 200703AE */  sw         $v1, 0x720($s0)
    /* 49F10 80059710 12300000 */  mflo       $a2
    /* 49F14 80059714 23104600 */  subu       $v0, $v0, $a2
    /* 49F18 80059718 1C0702AE */  sw         $v0, 0x71C($s0)
  .L8005971C:
    /* 49F1C 8005971C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 49F20 80059720 1000B08F */  lw         $s0, 0x10($sp)
    /* 49F24 80059724 0800E003 */  jr         $ra
    /* 49F28 80059728 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_CalcBestLineMerits__FP8Car_tObj
