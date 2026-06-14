.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache, 0x430

glabel DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
    /* BAD20 800CA520 1480023C */  lui        $v0, %hi(gSpikeBeltSlice)
    /* BAD24 800CA524 98C7428C */  lw         $v0, %lo(gSpikeBeltSlice)($v0)
    /* BAD28 800CA528 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* BAD2C 800CA52C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* BAD30 800CA530 38FEBD27 */  addiu      $sp, $sp, -0x1C8
    /* BAD34 800CA534 A001B0AF */  sw         $s0, 0x1A0($sp)
    /* BAD38 800CA538 2180A000 */  addu       $s0, $a1, $zero
    /* BAD3C 800CA53C C801A4AF */  sw         $a0, 0x1C8($sp)
    /* BAD40 800CA540 21200002 */  addu       $a0, $s0, $zero
    /* BAD44 800CA544 C401BFAF */  sw         $ra, 0x1C4($sp)
    /* BAD48 800CA548 C001BEAF */  sw         $fp, 0x1C0($sp)
    /* BAD4C 800CA54C BC01B7AF */  sw         $s7, 0x1BC($sp)
    /* BAD50 800CA550 B801B6AF */  sw         $s6, 0x1B8($sp)
    /* BAD54 800CA554 B401B5AF */  sw         $s5, 0x1B4($sp)
    /* BAD58 800CA558 B001B4AF */  sw         $s4, 0x1B0($sp)
    /* BAD5C 800CA55C AC01B3AF */  sw         $s3, 0x1AC($sp)
    /* BAD60 800CA560 A801B2AF */  sw         $s2, 0x1A8($sp)
    /* BAD64 800CA564 A401B1AF */  sw         $s1, 0x1A4($sp)
    /* BAD68 800CA568 D001A6AF */  sw         $a2, 0x1D0($sp)
    /* BAD6C 800CA56C 40A90200 */  sll        $s5, $v0, 5
    /* BAD70 800CA570 21187500 */  addu       $v1, $v1, $s5
    /* BAD74 800CA574 02000106 */  bgez       $s0, .L800CA580
    /* BAD78 800CA578 9801A3AF */   sw        $v1, 0x198($sp)
    /* BAD7C 800CA57C 07000426 */  addiu      $a0, $s0, 0x7
  .L800CA580:
    /* BAD80 800CA580 9801AB8F */  lw         $t3, 0x198($sp)
    /* BAD84 800CA584 C3800400 */  sra        $s0, $a0, 3
    /* BAD88 800CA588 12006481 */  lb         $a0, 0x12($t3)
    /* BAD8C 800CA58C 21280002 */  addu       $a1, $s0, $zero
    /* BAD90 800CA590 CA90030C */  jal        fixedmult
    /* BAD94 800CA594 40220400 */   sll       $a0, $a0, 9
    /* BAD98 800CA598 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* BAD9C 800CA59C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* BADA0 800CA5A0 82F20200 */  srl        $fp, $v0, 10
    /* BADA4 800CA5A4 2118A302 */  addu       $v1, $s5, $v1
    /* BADA8 800CA5A8 13006480 */  lb         $a0, 0x13($v1)
    /* BADAC 800CA5AC 21280002 */  addu       $a1, $s0, $zero
    /* BADB0 800CA5B0 CA90030C */  jal        fixedmult
    /* BADB4 800CA5B4 40220400 */   sll       $a0, $a0, 9
    /* BADB8 800CA5B8 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* BADBC 800CA5BC C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* BADC0 800CA5C0 82BA0200 */  srl        $s7, $v0, 10
    /* BADC4 800CA5C4 2118A302 */  addu       $v1, $s5, $v1
    /* BADC8 800CA5C8 14006480 */  lb         $a0, 0x14($v1)
    /* BADCC 800CA5CC 21280002 */  addu       $a1, $s0, $zero
    /* BADD0 800CA5D0 CA90030C */  jal        fixedmult
    /* BADD4 800CA5D4 40220400 */   sll       $a0, $a0, 9
    /* BADD8 800CA5D8 82B20200 */  srl        $s6, $v0, 10
    /* BADDC 800CA5DC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* BADE0 800CA5E0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* BADE4 800CA5E4 1480043C */  lui        $a0, %hi(gSpikeBeltX)
    /* BADE8 800CA5E8 A0C7848C */  lw         $a0, %lo(gSpikeBeltX)($a0)
    /* BADEC 800CA5EC 2118A302 */  addu       $v1, $s5, $v1
    /* BADF0 800CA5F0 0F007480 */  lb         $s4, 0xF($v1)
    /* BADF4 800CA5F4 10007380 */  lb         $s3, 0x10($v1)
    /* BADF8 800CA5F8 43A01400 */  sra        $s4, $s4, 1
    /* BADFC 800CA5FC 7001B4A7 */  sh         $s4, 0x170($sp)
    /* BAE00 800CA600 11007280 */  lb         $s2, 0x11($v1)
    /* BAE04 800CA604 43981300 */  sra        $s3, $s3, 1
    /* BAE08 800CA608 7801B3A7 */  sh         $s3, 0x178($sp)
    /* BAE0C 800CA60C 12006580 */  lb         $a1, 0x12($v1)
    /* BAE10 800CA610 43901200 */  sra        $s2, $s2, 1
    /* BAE14 800CA614 402A0500 */  sll        $a1, $a1, 9
    /* BAE18 800CA618 CA90030C */  jal        fixedmult
    /* BAE1C 800CA61C 8001B2A7 */   sh        $s2, 0x180($sp)
    /* BAE20 800CA620 838A0200 */  sra        $s1, $v0, 10
    /* BAE24 800CA624 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* BAE28 800CA628 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* BAE2C 800CA62C 8801B1A7 */  sh         $s1, 0x188($sp)
    /* BAE30 800CA630 2110A202 */  addu       $v0, $s5, $v0
    /* BAE34 800CA634 13004580 */  lb         $a1, 0x13($v0)
    /* BAE38 800CA638 1480043C */  lui        $a0, %hi(gSpikeBeltX)
    /* BAE3C 800CA63C A0C7848C */  lw         $a0, %lo(gSpikeBeltX)($a0)
    /* BAE40 800CA640 CA90030C */  jal        fixedmult
    /* BAE44 800CA644 402A0500 */   sll       $a1, $a1, 9
    /* BAE48 800CA648 83820200 */  sra        $s0, $v0, 10
    /* BAE4C 800CA64C 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* BAE50 800CA650 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* BAE54 800CA654 9001B0A7 */  sh         $s0, 0x190($sp)
    /* BAE58 800CA658 2110A202 */  addu       $v0, $s5, $v0
    /* BAE5C 800CA65C 14004580 */  lb         $a1, 0x14($v0)
    /* BAE60 800CA660 1480043C */  lui        $a0, %hi(gSpikeBeltX)
    /* BAE64 800CA664 A0C7848C */  lw         $a0, %lo(gSpikeBeltX)($a0)
    /* BAE68 800CA668 CA90030C */  jal        fixedmult
    /* BAE6C 800CA66C 402A0500 */   sll       $a1, $a1, 9
    /* BAE70 800CA670 83120200 */  sra        $v0, $v0, 10
    /* BAE74 800CA674 21484000 */  addu       $t1, $v0, $zero
    /* BAE78 800CA678 01000524 */  addiu      $a1, $zero, 0x1
    /* BAE7C 800CA67C 1000A727 */  addiu      $a3, $sp, 0x10
    /* BAE80 800CA680 1800A427 */  addiu      $a0, $sp, 0x18
    /* BAE84 800CA684 21300000 */  addu       $a2, $zero, $zero
    /* BAE88 800CA688 23883402 */  subu       $s1, $s1, $s4
    /* BAE8C 800CA68C 23801302 */  subu       $s0, $s0, $s3
    /* BAE90 800CA690 23105200 */  subu       $v0, $v0, $s2
    /* BAE94 800CA694 1000B1A7 */  sh         $s1, 0x10($sp)
    /* BAE98 800CA698 1200B0A7 */  sh         $s0, 0x12($sp)
    /* BAE9C 800CA69C 1400A2A7 */  sh         $v0, 0x14($sp)
    /* BAEA0 800CA6A0 1600A0A7 */  sh         $zero, 0x16($sp)
  .L800CA6A4:
    /* BAEA4 800CA6A4 2118E600 */  addu       $v1, $a3, $a2
    /* BAEA8 800CA6A8 00006294 */  lhu        $v0, 0x0($v1)
    /* BAEAC 800CA6AC 00000000 */  nop
    /* BAEB0 800CA6B0 21105E00 */  addu       $v0, $v0, $fp
    /* BAEB4 800CA6B4 000082A4 */  sh         $v0, 0x0($a0)
    /* BAEB8 800CA6B8 02006294 */  lhu        $v0, 0x2($v1)
    /* BAEBC 800CA6BC 0800C624 */  addiu      $a2, $a2, 0x8
    /* BAEC0 800CA6C0 21105700 */  addu       $v0, $v0, $s7
    /* BAEC4 800CA6C4 020082A4 */  sh         $v0, 0x2($a0)
    /* BAEC8 800CA6C8 04006294 */  lhu        $v0, 0x4($v1)
    /* BAECC 800CA6CC 0100A524 */  addiu      $a1, $a1, 0x1
    /* BAED0 800CA6D0 060080A4 */  sh         $zero, 0x6($a0)
    /* BAED4 800CA6D4 21105600 */  addu       $v0, $v0, $s6
    /* BAED8 800CA6D8 040082A4 */  sh         $v0, 0x4($a0)
    /* BAEDC 800CA6DC 0900A228 */  slti       $v0, $a1, 0x9
    /* BAEE0 800CA6E0 F0FF4014 */  bnez       $v0, .L800CA6A4
    /* BAEE4 800CA6E4 08008424 */   addiu     $a0, $a0, 0x8
    /* BAEE8 800CA6E8 01000524 */  addiu      $a1, $zero, 0x1
    /* BAEEC 800CA6EC 1000A827 */  addiu      $t0, $sp, 0x10
    /* BAEF0 800CA6F0 48000724 */  addiu      $a3, $zero, 0x48
    /* BAEF4 800CA6F4 8801AC97 */  lhu        $t4, 0x188($sp)
    /* BAEF8 800CA6F8 9001AB97 */  lhu        $t3, 0x190($sp)
    /* BAEFC 800CA6FC 50000624 */  addiu      $a2, $zero, 0x50
    /* BAF00 800CA700 5C00A9A7 */  sh         $t1, 0x5C($sp)
    /* BAF04 800CA704 5E00A0A7 */  sh         $zero, 0x5E($sp)
    /* BAF08 800CA708 19006225 */  addiu      $v0, $t3, 0x19
    /* BAF0C 800CA70C 5800ACA7 */  sh         $t4, 0x58($sp)
    /* BAF10 800CA710 5A00A2A7 */  sh         $v0, 0x5A($sp)
  .L800CA714:
    /* BAF14 800CA714 21200701 */  addu       $a0, $t0, $a3
    /* BAF18 800CA718 0800E724 */  addiu      $a3, $a3, 0x8
    /* BAF1C 800CA71C 00008294 */  lhu        $v0, 0x0($a0)
    /* BAF20 800CA720 21180601 */  addu       $v1, $t0, $a2
    /* BAF24 800CA724 21105E00 */  addu       $v0, $v0, $fp
    /* BAF28 800CA728 000062A4 */  sh         $v0, 0x0($v1)
    /* BAF2C 800CA72C 02008294 */  lhu        $v0, 0x2($a0)
    /* BAF30 800CA730 00000000 */  nop
    /* BAF34 800CA734 21105700 */  addu       $v0, $v0, $s7
    /* BAF38 800CA738 020062A4 */  sh         $v0, 0x2($v1)
    /* BAF3C 800CA73C 04008294 */  lhu        $v0, 0x4($a0)
    /* BAF40 800CA740 0100A524 */  addiu      $a1, $a1, 0x1
    /* BAF44 800CA744 060060A4 */  sh         $zero, 0x6($v1)
    /* BAF48 800CA748 21105600 */  addu       $v0, $v0, $s6
    /* BAF4C 800CA74C 040062A4 */  sh         $v0, 0x4($v1)
    /* BAF50 800CA750 0900A228 */  slti       $v0, $a1, 0x9
    /* BAF54 800CA754 EFFF4014 */  bnez       $v0, .L800CA714
    /* BAF58 800CA758 0800C624 */   addiu     $a2, $a2, 0x8
    /* BAF5C 800CA75C 01000524 */  addiu      $a1, $zero, 0x1
    /* BAF60 800CA760 8801AC97 */  lhu        $t4, 0x188($sp)
    /* BAF64 800CA764 7001AB97 */  lhu        $t3, 0x170($sp)
    /* BAF68 800CA768 1000A827 */  addiu      $t0, $sp, 0x10
    /* BAF6C 800CA76C 21108B01 */  addu       $v0, $t4, $t3
    /* BAF70 800CA770 9001AC97 */  lhu        $t4, 0x190($sp)
    /* BAF74 800CA774 7801AB97 */  lhu        $t3, 0x178($sp)
    /* BAF78 800CA778 90000724 */  addiu      $a3, $zero, 0x90
    /* BAF7C 800CA77C A000A2A7 */  sh         $v0, 0xA0($sp)
    /* BAF80 800CA780 21108B01 */  addu       $v0, $t4, $t3
    /* BAF84 800CA784 8001AC97 */  lhu        $t4, 0x180($sp)
    /* BAF88 800CA788 98000624 */  addiu      $a2, $zero, 0x98
    /* BAF8C 800CA78C A600A0A7 */  sh         $zero, 0xA6($sp)
    /* BAF90 800CA790 A200A2A7 */  sh         $v0, 0xA2($sp)
    /* BAF94 800CA794 21102C01 */  addu       $v0, $t1, $t4
    /* BAF98 800CA798 A400A2A7 */  sh         $v0, 0xA4($sp)
  .L800CA79C:
    /* BAF9C 800CA79C 21200701 */  addu       $a0, $t0, $a3
    /* BAFA0 800CA7A0 0800E724 */  addiu      $a3, $a3, 0x8
    /* BAFA4 800CA7A4 00008294 */  lhu        $v0, 0x0($a0)
    /* BAFA8 800CA7A8 21180601 */  addu       $v1, $t0, $a2
    /* BAFAC 800CA7AC 21105E00 */  addu       $v0, $v0, $fp
    /* BAFB0 800CA7B0 000062A4 */  sh         $v0, 0x0($v1)
    /* BAFB4 800CA7B4 02008294 */  lhu        $v0, 0x2($a0)
    /* BAFB8 800CA7B8 00000000 */  nop
    /* BAFBC 800CA7BC 21105700 */  addu       $v0, $v0, $s7
    /* BAFC0 800CA7C0 020062A4 */  sh         $v0, 0x2($v1)
    /* BAFC4 800CA7C4 04008294 */  lhu        $v0, 0x4($a0)
    /* BAFC8 800CA7C8 0100A524 */  addiu      $a1, $a1, 0x1
    /* BAFCC 800CA7CC 060060A4 */  sh         $zero, 0x6($v1)
    /* BAFD0 800CA7D0 21105600 */  addu       $v0, $v0, $s6
    /* BAFD4 800CA7D4 040062A4 */  sh         $v0, 0x4($v1)
    /* BAFD8 800CA7D8 0900A228 */  slti       $v0, $a1, 0x9
    /* BAFDC 800CA7DC EFFF4014 */  bnez       $v0, .L800CA79C
    /* BAFE0 800CA7E0 0800C624 */   addiu     $a2, $a2, 0x8
    /* BAFE4 800CA7E4 21480000 */  addu       $t1, $zero, $zero
    /* BAFE8 800CA7E8 E800AA27 */  addiu      $t2, $sp, 0xE8
    /* BAFEC 800CA7EC 40100900 */  sll        $v0, $t1, 1
  .L800CA7F0:
    /* BAFF0 800CA7F0 21104900 */  addu       $v0, $v0, $t1
    /* BAFF4 800CA7F4 40100200 */  sll        $v0, $v0, 1
    /* BAFF8 800CA7F8 21104201 */  addu       $v0, $t2, $v0
    /* BAFFC 800CA7FC 01002325 */  addiu      $v1, $t1, 0x1
    /* BB000 800CA800 0A002625 */  addiu      $a2, $t1, 0xA
    /* BB004 800CA804 09002525 */  addiu      $a1, $t1, 0x9
    /* BB008 800CA808 08002425 */  addiu      $a0, $t1, 0x8
    /* BB00C 800CA80C 13002725 */  addiu      $a3, $t1, 0x13
    /* BB010 800CA810 12002825 */  addiu      $t0, $t1, 0x12
    /* BB014 800CA814 050049A0 */  sb         $t1, 0x5($v0)
    /* BB018 800CA818 21486000 */  addu       $t1, $v1, $zero
    /* BB01C 800CA81C 000040A4 */  sh         $zero, 0x0($v0)
    /* BB020 800CA820 020049A0 */  sb         $t1, 0x2($v0)
    /* BB024 800CA824 030046A0 */  sb         $a2, 0x3($v0)
    /* BB028 800CA828 040045A0 */  sb         $a1, 0x4($v0)
    /* BB02C 800CA82C 40100400 */  sll        $v0, $a0, 1
    /* BB030 800CA830 21104400 */  addu       $v0, $v0, $a0
    /* BB034 800CA834 40100200 */  sll        $v0, $v0, 1
    /* BB038 800CA838 21104201 */  addu       $v0, $t2, $v0
    /* BB03C 800CA83C 000040A4 */  sh         $zero, 0x0($v0)
    /* BB040 800CA840 030045A0 */  sb         $a1, 0x3($v0)
    /* BB044 800CA844 040046A0 */  sb         $a2, 0x4($v0)
    /* BB048 800CA848 050047A0 */  sb         $a3, 0x5($v0)
    /* BB04C 800CA84C 020048A0 */  sb         $t0, 0x2($v0)
    /* BB050 800CA850 08002229 */  slti       $v0, $t1, 0x8
    /* BB054 800CA854 E6FF4014 */  bnez       $v0, .L800CA7F0
    /* BB058 800CA858 40100900 */   sll       $v0, $t1, 1
    /* BB05C 800CA85C 1280023C */  lui        $v0, %hi(D_8011E160)
    /* BB060 800CA860 5001A427 */  addiu      $a0, $sp, 0x150
    /* BB064 800CA864 60E14294 */  lhu        $v0, %lo(D_8011E160)($v0)
    /* BB068 800CA868 D001AB8F */  lw         $t3, 0x1D0($sp)
    /* BB06C 800CA86C 1180053C */  lui        $a1, %hi(gWorldMat)
    /* BB070 800CA870 4801A0A3 */  sb         $zero, 0x148($sp)
    /* BB074 800CA874 4901A0A3 */  sb         $zero, 0x149($sp)
    /* BB078 800CA878 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* BB07C 800CA87C 4A01A2A7 */  sh         $v0, 0x14A($sp)
    /* BB080 800CA880 060160A1 */  sb         $zero, 0x106($t3)
    /* BB084 800CA884 C801AC8F */  lw         $t4, 0x1C8($sp)
    /* BB088 800CA888 9801AB8F */  lw         $t3, 0x198($sp)
    /* BB08C 800CA88C 0800838D */  lw         $v1, 0x8($t4)
    /* BB090 800CA890 0000628D */  lw         $v0, 0x0($t3)
    /* BB094 800CA894 40EEA524 */  addiu      $a1, $a1, %lo(gWorldMat)
    /* BB098 800CA898 23104300 */  subu       $v0, $v0, $v1
    /* BB09C 800CA89C 5001A2AF */  sw         $v0, 0x150($sp)
    /* BB0A0 800CA8A0 0C00838D */  lw         $v1, 0xC($t4)
    /* BB0A4 800CA8A4 0400628D */  lw         $v0, 0x4($t3)
    /* BB0A8 800CA8A8 6001B027 */  addiu      $s0, $sp, 0x160
    /* BB0AC 800CA8AC 23104300 */  subu       $v0, $v0, $v1
    /* BB0B0 800CA8B0 5401A2AF */  sw         $v0, 0x154($sp)
    /* BB0B4 800CA8B4 1000838D */  lw         $v1, 0x10($t4)
    /* BB0B8 800CA8B8 0800628D */  lw         $v0, 0x8($t3)
    /* BB0BC 800CA8BC 21300002 */  addu       $a2, $s0, $zero
    /* BB0C0 800CA8C0 23104300 */  subu       $v0, $v0, $v1
    /* BB0C4 800CA8C4 B6AB030C */  jal        transform
    /* BB0C8 800CA8C8 5801A2AF */   sw        $v0, 0x158($sp)
    /* BB0CC 800CA8CC D001AC8F */  lw         $t4, 0x1D0($sp)
    /* BB0D0 800CA8D0 21200002 */  addu       $a0, $s0, $zero
    /* BB0D4 800CA8D4 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* BB0D8 800CA8D8 14008525 */   addiu     $a1, $t4, 0x14
    /* BB0DC 800CA8DC D001A48F */  lw         $a0, 0x1D0($sp)
    /* BB0E0 800CA8E0 1000A227 */  addiu      $v0, $sp, 0x10
    /* BB0E4 800CA8E4 E00082AC */  sw         $v0, 0xE0($a0)
    /* BB0E8 800CA8E8 10000224 */  addiu      $v0, $zero, 0x10
    /* BB0EC 800CA8EC E70082A0 */  sb         $v0, 0xE7($a0)
    /* BB0F0 800CA8F0 E800A227 */  addiu      $v0, $sp, 0xE8
    /* BB0F4 800CA8F4 E80082AC */  sw         $v0, 0xE8($a0)
    /* BB0F8 800CA8F8 23000224 */  addiu      $v0, $zero, 0x23
    /* BB0FC 800CA8FC EC0082AC */  sw         $v0, 0xEC($a0)
    /* BB100 800CA900 4801A227 */  addiu      $v0, $sp, 0x148
    /* BB104 800CA904 F00082AC */  sw         $v0, 0xF0($a0)
    /* BB108 800CA908 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BB10C 800CA90C F40080AC */  sw         $zero, 0xF4($a0)
    /* BB110 800CA910 F80080A4 */  sh         $zero, 0xF8($a0)
    /* BB114 800CA914 070180A0 */  sb         $zero, 0x107($a0)
    /* BB118 800CA918 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* BB11C 800CA91C D80082A4 */   sh        $v0, 0xD8($a0)
    /* BB120 800CA920 C401BF8F */  lw         $ra, 0x1C4($sp)
    /* BB124 800CA924 C001BE8F */  lw         $fp, 0x1C0($sp)
    /* BB128 800CA928 BC01B78F */  lw         $s7, 0x1BC($sp)
    /* BB12C 800CA92C B801B68F */  lw         $s6, 0x1B8($sp)
    /* BB130 800CA930 B401B58F */  lw         $s5, 0x1B4($sp)
    /* BB134 800CA934 B001B48F */  lw         $s4, 0x1B0($sp)
    /* BB138 800CA938 AC01B38F */  lw         $s3, 0x1AC($sp)
    /* BB13C 800CA93C A801B28F */  lw         $s2, 0x1A8($sp)
    /* BB140 800CA940 A401B18F */  lw         $s1, 0x1A4($sp)
    /* BB144 800CA944 A001B08F */  lw         $s0, 0x1A0($sp)
    /* BB148 800CA948 0800E003 */  jr         $ra
    /* BB14C 800CA94C C801BD27 */   addiu     $sp, $sp, 0x1C8
endlabel DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
