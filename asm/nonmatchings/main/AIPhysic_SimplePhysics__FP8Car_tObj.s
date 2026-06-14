.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_SimplePhysics__FP8Car_tObj, 0x36C

glabel AIPhysic_SimplePhysics__FP8Car_tObj
    /* 5A730 80069F30 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 5A734 80069F34 3000B0AF */  sw         $s0, 0x30($sp)
    /* 5A738 80069F38 21808000 */  addu       $s0, $a0, $zero
    /* 5A73C 80069F3C 3800BFAF */  sw         $ra, 0x38($sp)
    /* 5A740 80069F40 3400B1AF */  sw         $s1, 0x34($sp)
    /* 5A744 80069F44 7005028E */  lw         $v0, 0x570($s0)
    /* 5A748 80069F48 00000000 */  nop
    /* 5A74C 80069F4C 10004230 */  andi       $v0, $v0, 0x10
    /* 5A750 80069F50 08004010 */  beqz       $v0, .L80069F74
    /* 5A754 80069F54 EFFF0324 */   addiu     $v1, $zero, -0x11
    /* 5A758 80069F58 7405028E */  lw         $v0, 0x574($s0)
    /* 5A75C 80069F5C 00000000 */  nop
    /* 5A760 80069F60 180702AE */  sw         $v0, 0x718($s0)
    /* 5A764 80069F64 7005028E */  lw         $v0, 0x570($s0)
    /* 5A768 80069F68 00000000 */  nop
    /* 5A76C 80069F6C 24104300 */  and        $v0, $v0, $v1
    /* 5A770 80069F70 700502AE */  sw         $v0, 0x570($s0)
  .L80069F74:
    /* 5A774 80069F74 6002028E */  lw         $v0, 0x260($s0)
    /* 5A778 80069F78 00000000 */  nop
    /* 5A77C 80069F7C 08004230 */  andi       $v0, $v0, 0x8
    /* 5A780 80069F80 19004010 */  beqz       $v0, .L80069FE8
    /* 5A784 80069F84 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5A788 80069F88 ACE05124 */  addiu      $s1, $v0, %lo(simGlobal)
    /* 5A78C 80069F8C 0400238E */  lw         $v1, 0x4($s1)
    /* 5A790 80069F90 4407028E */  lw         $v0, 0x744($s0)
    /* 5A794 80069F94 00000000 */  nop
    /* 5A798 80069F98 2A104300 */  slt        $v0, $v0, $v1
    /* 5A79C 80069F9C 12004010 */  beqz       $v0, .L80069FE8
    /* 5A7A0 80069FA0 00000000 */   nop
    /* 5A7A4 80069FA4 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5A7A8 80069FA8 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5A7AC 80069FAC 08000586 */  lh         $a1, 0x8($s0)
    /* 5A7B0 80069FB0 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5A7B4 80069FB4 00000000 */   nop
    /* 5A7B8 80069FB8 1F004228 */  slti       $v0, $v0, 0x1F
    /* 5A7BC 80069FBC 0A004014 */  bnez       $v0, .L80069FE8
    /* 5A7C0 80069FC0 1600023C */   lui       $v0, (0x1638E3 >> 16)
    /* 5A7C4 80069FC4 6805038E */  lw         $v1, 0x568($s0)
    /* 5A7C8 80069FC8 E3384234 */  ori        $v0, $v0, (0x1638E3 & 0xFFFF)
    /* 5A7CC 80069FCC 2A104300 */  slt        $v0, $v0, $v1
    /* 5A7D0 80069FD0 05004010 */  beqz       $v0, .L80069FE8
    /* 5A7D4 80069FD4 00000000 */   nop
    /* 5A7D8 80069FD8 0400228E */  lw         $v0, 0x4($s1)
    /* 5A7DC 80069FDC 00000000 */  nop
    /* 5A7E0 80069FE0 80014224 */  addiu      $v0, $v0, 0x180
    /* 5A7E4 80069FE4 480702AE */  sw         $v0, 0x748($s0)
  .L80069FE8:
    /* 5A7E8 80069FE8 A7A8010C */  jal        AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
    /* 5A7EC 80069FEC 21200002 */   addu      $a0, $s0, $zero
    /* 5A7F0 80069FF0 7DA9010C */  jal        AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
    /* 5A7F4 80069FF4 21200002 */   addu      $a0, $s0, $zero
    /* 5A7F8 80069FF8 0801078E */  lw         $a3, 0x108($s0)
    /* 5A7FC 80069FFC 0C01088E */  lw         $t0, 0x10C($s0)
    /* 5A800 8006A000 1001098E */  lw         $t1, 0x110($s0)
    /* 5A804 8006A004 1000A7AF */  sw         $a3, 0x10($sp)
    /* 5A808 8006A008 1400A8AF */  sw         $t0, 0x14($sp)
    /* 5A80C 8006A00C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 5A810 8006A010 4401078E */  lw         $a3, 0x144($s0)
    /* 5A814 8006A014 4801088E */  lw         $t0, 0x148($s0)
    /* 5A818 8006A018 4C01098E */  lw         $t1, 0x14C($s0)
    /* 5A81C 8006A01C 2000A7AF */  sw         $a3, 0x20($sp)
    /* 5A820 8006A020 2400A8AF */  sw         $t0, 0x24($sp)
    /* 5A824 8006A024 2800A9AF */  sw         $t1, 0x28($sp)
    /* 5A828 8006A028 9405048E */  lw         $a0, 0x594($s0)
    /* 5A82C 8006A02C 2000A58F */  lw         $a1, 0x20($sp)
    /* 5A830 8006A030 CA90030C */  jal        fixedmult
    /* 5A834 8006A034 00000000 */   nop
    /* 5A838 8006A038 2000A2AF */  sw         $v0, 0x20($sp)
    /* 5A83C 8006A03C 9405048E */  lw         $a0, 0x594($s0)
    /* 5A840 8006A040 2400A58F */  lw         $a1, 0x24($sp)
    /* 5A844 8006A044 CA90030C */  jal        fixedmult
    /* 5A848 8006A048 00000000 */   nop
    /* 5A84C 8006A04C 2400A2AF */  sw         $v0, 0x24($sp)
    /* 5A850 8006A050 9405048E */  lw         $a0, 0x594($s0)
    /* 5A854 8006A054 2800A58F */  lw         $a1, 0x28($sp)
    /* 5A858 8006A058 CA90030C */  jal        fixedmult
    /* 5A85C 8006A05C 00000000 */   nop
    /* 5A860 8006A060 2800A2AF */  sw         $v0, 0x28($sp)
    /* 5A864 8006A064 6405028E */  lw         $v0, 0x564($s0)
    /* 5A868 8006A068 5405048E */  lw         $a0, 0x554($s0)
    /* 5A86C 8006A06C 00000000 */  nop
    /* 5A870 8006A070 18004400 */  mult       $v0, $a0
    /* 5A874 8006A074 1000A58F */  lw         $a1, 0x10($sp)
    /* 5A878 8006A078 12200000 */  mflo       $a0
    /* 5A87C 8006A07C CA90030C */  jal        fixedmult
    /* 5A880 8006A080 00000000 */   nop
    /* 5A884 8006A084 1000A2AF */  sw         $v0, 0x10($sp)
    /* 5A888 8006A088 6405028E */  lw         $v0, 0x564($s0)
    /* 5A88C 8006A08C 5405048E */  lw         $a0, 0x554($s0)
    /* 5A890 8006A090 00000000 */  nop
    /* 5A894 8006A094 18004400 */  mult       $v0, $a0
    /* 5A898 8006A098 1400A58F */  lw         $a1, 0x14($sp)
    /* 5A89C 8006A09C 12200000 */  mflo       $a0
    /* 5A8A0 8006A0A0 CA90030C */  jal        fixedmult
    /* 5A8A4 8006A0A4 00000000 */   nop
    /* 5A8A8 8006A0A8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 5A8AC 8006A0AC 6405028E */  lw         $v0, 0x564($s0)
    /* 5A8B0 8006A0B0 5405048E */  lw         $a0, 0x554($s0)
    /* 5A8B4 8006A0B4 00000000 */  nop
    /* 5A8B8 8006A0B8 18004400 */  mult       $v0, $a0
    /* 5A8BC 8006A0BC 1800A58F */  lw         $a1, 0x18($sp)
    /* 5A8C0 8006A0C0 12200000 */  mflo       $a0
    /* 5A8C4 8006A0C4 CA90030C */  jal        fixedmult
    /* 5A8C8 8006A0C8 00000000 */   nop
    /* 5A8CC 8006A0CC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 5A8D0 8006A0D0 1000A28F */  lw         $v0, 0x10($sp)
    /* 5A8D4 8006A0D4 2000A38F */  lw         $v1, 0x20($sp)
    /* 5A8D8 8006A0D8 9405058E */  lw         $a1, 0x594($s0)
    /* 5A8DC 8006A0DC 5405048E */  lw         $a0, 0x554($s0)
    /* 5A8E0 8006A0E0 21104300 */  addu       $v0, $v0, $v1
    /* 5A8E4 8006A0E4 1800A400 */  mult       $a1, $a0
    /* 5A8E8 8006A0E8 AC0002AE */  sw         $v0, 0xAC($s0)
    /* 5A8EC 8006A0EC 1400A28F */  lw         $v0, 0x14($sp)
    /* 5A8F0 8006A0F0 2400A38F */  lw         $v1, 0x24($sp)
    /* 5A8F4 8006A0F4 6805048E */  lw         $a0, 0x568($s0)
    /* 5A8F8 8006A0F8 21104300 */  addu       $v0, $v0, $v1
    /* 5A8FC 8006A0FC B00002AE */  sw         $v0, 0xB0($s0)
    /* 5A900 8006A100 1800A28F */  lw         $v0, 0x18($sp)
    /* 5A904 8006A104 2800A38F */  lw         $v1, 0x28($sp)
    /* 5A908 8006A108 200404AE */  sw         $a0, 0x420($s0)
    /* 5A90C 8006A10C 21104300 */  addu       $v0, $v0, $v1
    /* 5A910 8006A110 B40002AE */  sw         $v0, 0xB4($s0)
    /* 5A914 8006A114 12280000 */  mflo       $a1
    /* 5A918 8006A118 0200A104 */  bgez       $a1, .L8006A124
    /* 5A91C 8006A11C 2120A000 */   addu      $a0, $a1, $zero
    /* 5A920 8006A120 23200400 */  negu       $a0, $a0
  .L8006A124:
    /* 5A924 8006A124 21188000 */  addu       $v1, $a0, $zero
    /* 5A928 8006A128 02008104 */  bgez       $a0, .L8006A134
    /* 5A92C 8006A12C 180405AE */   sw        $a1, 0x418($s0)
    /* 5A930 8006A130 FF008324 */  addiu      $v1, $a0, 0xFF
  .L8006A134:
    /* 5A934 8006A134 031A0300 */  sra        $v1, $v1, 8
    /* 5A938 8006A138 40100300 */  sll        $v0, $v1, 1
    /* 5A93C 8006A13C 21104300 */  addu       $v0, $v0, $v1
    /* 5A940 8006A140 C0100200 */  sll        $v0, $v0, 3
    /* 5A944 8006A144 21104300 */  addu       $v0, $v0, $v1
    /* 5A948 8006A148 2A104400 */  slt        $v0, $v0, $a0
    /* 5A94C 8006A14C 03004010 */  beqz       $v0, .L8006A15C
    /* 5A950 8006A150 00800234 */   ori       $v0, $zero, 0x8000
    /* 5A954 8006A154 58A80108 */  j          .L8006A160
    /* 5A958 8006A158 780402AE */   sw        $v0, 0x478($s0)
  .L8006A15C:
    /* 5A95C 8006A15C 780400AE */  sw         $zero, 0x478($s0)
  .L8006A160:
    /* 5A960 8006A160 6805038E */  lw         $v1, 0x568($s0)
    /* 5A964 8006A164 0300023C */  lui        $v0, (0x30000 >> 16)
    /* 5A968 8006A168 140100AE */  sw         $zero, 0x114($s0)
    /* 5A96C 8006A16C 180100AE */  sw         $zero, 0x118($s0)
    /* 5A970 8006A170 2A104300 */  slt        $v0, $v0, $v1
    /* 5A974 8006A174 06004010 */  beqz       $v0, .L8006A190
    /* 5A978 8006A178 1C0100AE */   sw        $zero, 0x11C($s0)
    /* 5A97C 8006A17C 5405058E */  lw         $a1, 0x554($s0)
    /* 5A980 8006A180 21200002 */  addu       $a0, $s0, $zero
    /* 5A984 8006A184 27280500 */  nor        $a1, $zero, $a1
    /* 5A988 8006A188 7D85020C */  jal        Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
    /* 5A98C 8006A18C 0100A52C */   sltiu     $a1, $a1, 0x1
  .L8006A190:
    /* 5A990 8006A190 AA2A063C */  lui        $a2, (0x2AAAAAAB >> 16)
    /* 5A994 8006A194 6405028E */  lw         $v0, 0x564($s0)
    /* 5A998 8006A198 ABAAC634 */  ori        $a2, $a2, (0x2AAAAAAB & 0xFFFF)
    /* 5A99C 8006A19C 02004104 */  bgez       $v0, .L8006A1A8
    /* 5A9A0 8006A1A0 21284000 */   addu      $a1, $v0, $zero
    /* 5A9A4 8006A1A4 23280500 */  negu       $a1, $a1
  .L8006A1A8:
    /* 5A9A8 8006A1A8 1800A600 */  mult       $a1, $a2
    /* 5A9AC 8006A1AC C3170500 */  sra        $v0, $a1, 31
    /* 5A9B0 8006A1B0 10380000 */  mfhi       $a3
    /* 5A9B4 8006A1B4 031C0700 */  sra        $v1, $a3, 16
    /* 5A9B8 8006A1B8 23206200 */  subu       $a0, $v1, $v0
    /* 5A9BC 8006A1BC 0D008004 */  bltz       $a0, .L8006A1F4
    /* 5A9C0 8006A1C0 1180023C */   lui       $v0, %hi(D_8010DC78)
    /* 5A9C4 8006A1C4 78DC428C */  lw         $v0, %lo(D_8010DC78)($v0)
    /* 5A9C8 8006A1C8 00000000 */  nop
    /* 5A9CC 8006A1CC 18004600 */  mult       $v0, $a2
    /* 5A9D0 8006A1D0 C3170200 */  sra        $v0, $v0, 31
    /* 5A9D4 8006A1D4 10380000 */  mfhi       $a3
    /* 5A9D8 8006A1D8 2318E200 */  subu       $v1, $a3, $v0
    /* 5A9DC 8006A1DC 2A108300 */  slt        $v0, $a0, $v1
    /* 5A9E0 8006A1E0 04004010 */  beqz       $v0, .L8006A1F4
    /* 5A9E4 8006A1E4 00000000 */   nop
    /* 5A9E8 8006A1E8 0200A004 */  bltz       $a1, .L8006A1F4
    /* 5A9EC 8006A1EC 00000000 */   nop
    /* 5A9F0 8006A1F0 21206000 */  addu       $a0, $v1, $zero
  .L8006A1F4:
    /* 5A9F4 8006A1F4 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
    /* 5A9F8 8006A1F8 1180023C */  lui        $v0, %hi(D_8010DC7C)
    /* 5A9FC 8006A1FC 7CDC428C */  lw         $v0, %lo(D_8010DC7C)($v0)
    /* 5AA00 8006A200 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 5AA04 8006A204 18004300 */  mult       $v0, $v1
    /* 5AA08 8006A208 C3170200 */  sra        $v0, $v0, 31
    /* 5AA0C 8006A20C 10380000 */  mfhi       $a3
    /* 5AA10 8006A210 2318E200 */  subu       $v1, $a3, $v0
    /* 5AA14 8006A214 2A106400 */  slt        $v0, $v1, $a0
    /* 5AA18 8006A218 02004010 */  beqz       $v0, .L8006A224
    /* 5AA1C 8006A21C 00000000 */   nop
    /* 5AA20 8006A220 21206000 */  addu       $a0, $v1, $zero
  .L8006A224:
    /* 5AA24 8006A224 5405028E */  lw         $v0, 0x554($s0)
    /* 5AA28 8006A228 00000000 */  nop
    /* 5AA2C 8006A22C 18008200 */  mult       $a0, $v0
    /* 5AA30 8006A230 12180000 */  mflo       $v1
    /* 5AA34 8006A234 0A006004 */  bltz       $v1, .L8006A260
    /* 5AA38 8006A238 00000000 */   nop
    /* 5AA3C 8006A23C 08000286 */  lh         $v0, 0x8($s0)
    /* 5AA40 8006A240 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 5AA44 8006A244 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 5AA48 8006A248 21184300 */  addu       $v1, $v0, $v1
    /* 5AA4C 8006A24C 2A106400 */  slt        $v0, $v1, $a0
    /* 5AA50 8006A250 0C004014 */  bnez       $v0, .L8006A284
    /* 5AA54 8006A254 00000000 */   nop
    /* 5AA58 8006A258 A1A80108 */  j          .L8006A284
    /* 5AA5C 8006A25C 23186400 */   subu      $v1, $v1, $a0
  .L8006A260:
    /* 5AA60 8006A260 08000286 */  lh         $v0, 0x8($s0)
    /* 5AA64 8006A264 00000000 */  nop
    /* 5AA68 8006A268 21184300 */  addu       $v1, $v0, $v1
    /* 5AA6C 8006A26C 05006104 */  bgez       $v1, .L8006A284
    /* 5AA70 8006A270 00000000 */   nop
    /* 5AA74 8006A274 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5AA78 8006A278 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5AA7C 8006A27C 00000000 */  nop
    /* 5AA80 8006A280 21186200 */  addu       $v1, $v1, $v0
  .L8006A284:
    /* 5AA84 8006A284 580703AE */  sw         $v1, 0x758($s0)
    /* 5AA88 8006A288 3800BF8F */  lw         $ra, 0x38($sp)
    /* 5AA8C 8006A28C 3400B18F */  lw         $s1, 0x34($sp)
    /* 5AA90 8006A290 3000B08F */  lw         $s0, 0x30($sp)
    /* 5AA94 8006A294 0800E003 */  jr         $ra
    /* 5AA98 8006A298 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel AIPhysic_SimplePhysics__FP8Car_tObj
