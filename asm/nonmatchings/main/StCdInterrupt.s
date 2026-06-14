.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StCdInterrupt, 0x91C

glabel StCdInterrupt
    /* E8678 800F7E78 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E867C 800F7E7C 1480023C */  lui        $v0, %hi(StFinalSector)
    /* E8680 800F7E80 A46C428C */  lw         $v0, %lo(StFinalSector)($v0)
    /* E8684 800F7E84 01000424 */  addiu      $a0, $zero, 0x1
    /* E8688 800F7E88 3E024410 */  beq        $v0, $a0, .L800F8784
    /* E868C 800F7E8C 3800BFAF */   sw        $ra, 0x38($sp)
    /* E8690 800F7E90 1480023C */  lui        $v0, %hi(StRgb24)
    /* E8694 800F7E94 906C428C */  lw         $v0, %lo(StRgb24)($v0)
    /* E8698 800F7E98 00000000 */  nop
    /* E869C 800F7E9C 17004010 */  beqz       $v0, .L800F7EFC
    /* E86A0 800F7EA0 00000000 */   nop
    /* E86A4 800F7EA4 1380023C */  lui        $v0, %hi(D_80136AB8)
    /* E86A8 800F7EA8 B86A428C */  lw         $v0, %lo(D_80136AB8)($v0)
    /* E86AC 800F7EAC 00000000 */  nop
    /* E86B0 800F7EB0 0000428C */  lw         $v0, 0x0($v0)
    /* E86B4 800F7EB4 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* E86B8 800F7EB8 24104300 */  and        $v0, $v0, $v1
    /* E86BC 800F7EBC 0F004010 */  beqz       $v0, .L800F7EFC
    /* E86C0 800F7EC0 00000000 */   nop
    /* E86C4 800F7EC4 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E86C8 800F7EC8 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E86CC 800F7ECC 1480013C */  lui        $at, %hi(StCdIntrFlag)
    /* E86D0 800F7ED0 07004010 */  beqz       $v0, .L800F7EF0
    /* E86D4 800F7ED4 806C24AC */   sw        $a0, %lo(StCdIntrFlag)($at)
    /* E86D8 800F7ED8 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E86DC 800F7EDC 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E86E0 800F7EE0 00000000 */  nop
    /* E86E4 800F7EE4 01004224 */  addiu      $v0, $v0, 0x1
    /* E86E8 800F7EE8 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E86EC 800F7EEC 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
  .L800F7EF0:
    /* E86F0 800F7EF0 1380013C */  lui        $at, %hi(debug_cause)
    /* E86F4 800F7EF4 E1E10308 */  j          .L800F8784
    /* E86F8 800F7EF8 E06A24AC */   sw        $a0, %lo(debug_cause)($at)
  .L800F7EFC:
    /* E86FC 800F7EFC 1BDE030C */  jal        CdReady
    /* E8700 800F7F00 3000A527 */   addiu     $a1, $sp, 0x30
    /* E8704 800F7F04 05000324 */  addiu      $v1, $zero, 0x5
    /* E8708 800F7F08 1E024310 */  beq        $v0, $v1, .L800F8784
    /* E870C 800F7F0C 00000000 */   nop
    /* E8710 800F7F10 3000A293 */  lbu        $v0, 0x30($sp)
    /* E8714 800F7F14 3100A393 */  lbu        $v1, 0x31($sp)
    /* E8718 800F7F18 2200A2A7 */  sh         $v0, 0x22($sp)
    /* E871C 800F7F1C 2400A3A7 */  sh         $v1, 0x24($sp)
    /* E8720 800F7F20 2200A297 */  lhu        $v0, 0x22($sp)
    /* E8724 800F7F24 00000000 */  nop
    /* E8728 800F7F28 04004230 */  andi       $v0, $v0, 0x4
    /* E872C 800F7F2C 04004010 */  beqz       $v0, .L800F7F40
    /* E8730 800F7F30 03000224 */   addiu     $v0, $zero, 0x3
    /* E8734 800F7F34 1380013C */  lui        $at, %hi(debug_cause)
    /* E8738 800F7F38 E1E10308 */  j          .L800F8784
    /* E873C 800F7F3C E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F7F40:
    /* E8740 800F7F40 1480023C */  lui        $v0, %hi(StRingIdx1)
    /* E8744 800F7F44 B06C428C */  lw         $v0, %lo(StRingIdx1)($v0)
    /* E8748 800F7F48 1480033C */  lui        $v1, %hi(StRingAddr)
    /* E874C 800F7F4C AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* E8750 800F7F50 40110200 */  sll        $v0, $v0, 5
    /* E8754 800F7F54 21186200 */  addu       $v1, $v1, $v0
    /* E8758 800F7F58 1480013C */  lui        $at, %hi(D_80144864)
    /* E875C 800F7F5C 644823AC */  sw         $v1, %lo(D_80144864)($at)
    /* E8760 800F7F60 00006294 */  lhu        $v0, 0x0($v1)
    /* E8764 800F7F64 00000000 */  nop
    /* E8768 800F7F68 10004010 */  beqz       $v0, .L800F7FAC
    /* E876C 800F7F6C 00000000 */   nop
    /* E8770 800F7F70 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8774 800F7F74 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8778 800F7F78 00000000 */  nop
    /* E877C 800F7F7C 08004010 */  beqz       $v0, .L800F7FA0
    /* E8780 800F7F80 04000224 */   addiu     $v0, $zero, 0x4
    /* E8784 800F7F84 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8788 800F7F88 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E878C 800F7F8C 00000000 */  nop
    /* E8790 800F7F90 01004224 */  addiu      $v0, $v0, 0x1
    /* E8794 800F7F94 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8798 800F7F98 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
    /* E879C 800F7F9C 04000224 */  addiu      $v0, $zero, 0x4
  .L800F7FA0:
    /* E87A0 800F7FA0 1380013C */  lui        $at, %hi(debug_cause)
    /* E87A4 800F7FA4 E1E10308 */  j          .L800F8784
    /* E87A8 800F7FA8 E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F7FAC:
    /* E87AC 800F7FAC 1380023C */  lui        $v0, %hi(D_80136A98)
    /* E87B0 800F7FB0 986A428C */  lw         $v0, %lo(D_80136A98)($v0)
    /* E87B4 800F7FB4 00000000 */  nop
    /* E87B8 800F7FB8 000040A0 */  sb         $zero, 0x0($v0)
    /* E87BC 800F7FBC 1380023C */  lui        $v0, %hi(D_80136AA4)
    /* E87C0 800F7FC0 A46A428C */  lw         $v0, %lo(D_80136AA4)($v0)
    /* E87C4 800F7FC4 00000000 */  nop
    /* E87C8 800F7FC8 000040A0 */  sb         $zero, 0x0($v0)
    /* E87CC 800F7FCC 1380023C */  lui        $v0, %hi(D_80136A98)
    /* E87D0 800F7FD0 986A428C */  lw         $v0, %lo(D_80136A98)($v0)
    /* E87D4 800F7FD4 0200043C */  lui        $a0, (0x20943 >> 16)
    /* E87D8 800F7FD8 000040A0 */  sb         $zero, 0x0($v0)
    /* E87DC 800F7FDC 1380033C */  lui        $v1, %hi(D_80136AA4)
    /* E87E0 800F7FE0 A46A638C */  lw         $v1, %lo(D_80136AA4)($v1)
    /* E87E4 800F7FE4 80000224 */  addiu      $v0, $zero, 0x80
    /* E87E8 800F7FE8 000062A0 */  sb         $v0, 0x0($v1)
    /* E87EC 800F7FEC 1380023C */  lui        $v0, %hi(D_80136AA8)
    /* E87F0 800F7FF0 A86A428C */  lw         $v0, %lo(D_80136AA8)($v0)
    /* E87F4 800F7FF4 43098434 */  ori        $a0, $a0, (0x20943 & 0xFFFF)
    /* E87F8 800F7FF8 000044AC */  sw         $a0, 0x0($v0)
    /* E87FC 800F7FFC 1380033C */  lui        $v1, %hi(D_80136AAC)
    /* E8800 800F8000 AC6A638C */  lw         $v1, %lo(D_80136AAC)($v1)
    /* E8804 800F8004 23130224 */  addiu      $v0, $zero, 0x1323
    /* E8808 800F8008 000062AC */  sw         $v0, 0x0($v1)
    /* E880C 800F800C 1580023C */  lui        $v0, %hi(StMode)
    /* E8810 800F8010 CC89428C */  lw         $v0, %lo(StMode)($v0)
    /* E8814 800F8014 00000000 */  nop
    /* E8818 800F8018 14004014 */  bnez       $v0, .L800F806C
    /* E881C 800F801C 21200000 */   addu      $a0, $zero, $zero
    /* E8820 800F8020 2800A527 */  addiu      $a1, $sp, 0x28
  .L800F8024:
    /* E8824 800F8024 1380023C */  lui        $v0, %hi(D_80136AA0)
    /* E8828 800F8028 A06A428C */  lw         $v0, %lo(D_80136AA0)($v0)
    /* E882C 800F802C 2118A400 */  addu       $v1, $a1, $a0
    /* E8830 800F8030 00004290 */  lbu        $v0, 0x0($v0)
    /* E8834 800F8034 01008424 */  addiu      $a0, $a0, 0x1
    /* E8838 800F8038 000062A0 */  sb         $v0, 0x0($v1)
    /* E883C 800F803C 0400822C */  sltiu      $v0, $a0, 0x4
    /* E8840 800F8040 F8FF4014 */  bnez       $v0, .L800F8024
    /* E8844 800F8044 00000000 */   nop
    /* E8848 800F8048 21200000 */  addu       $a0, $zero, $zero
    /* E884C 800F804C 1380033C */  lui        $v1, %hi(D_80136AA0)
    /* E8850 800F8050 A06A638C */  lw         $v1, %lo(D_80136AA0)($v1)
    /* E8854 800F8054 00000000 */  nop
  .L800F8058:
    /* E8858 800F8058 00006290 */  lbu        $v0, 0x0($v1)
    /* E885C 800F805C 01008424 */  addiu      $a0, $a0, 0x1
    /* E8860 800F8060 0800822C */  sltiu      $v0, $a0, 0x8
    /* E8864 800F8064 FCFF4014 */  bnez       $v0, .L800F8058
    /* E8868 800F8068 00000000 */   nop
  .L800F806C:
    /* E886C 800F806C 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8870 800F8070 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8874 800F8074 00000000 */  nop
    /* E8878 800F8078 0C004010 */  beqz       $v0, .L800F80AC
    /* E887C 800F807C 0011083C */   lui       $t0, (0x11000000 >> 16)
    /* E8880 800F8080 08000624 */  addiu      $a2, $zero, 0x8
    /* E8884 800F8084 21380000 */  addu       $a3, $zero, $zero
    /* E8888 800F8088 1480053C */  lui        $a1, %hi(StEmu_Idx)
    /* E888C 800F808C 9C6CA58C */  lw         $a1, %lo(StEmu_Idx)($a1)
    /* E8890 800F8090 1480043C */  lui        $a0, %hi(D_80144864)
    /* E8894 800F8094 6448848C */  lw         $a0, %lo(D_80144864)($a0)
    /* E8898 800F8098 C02A0500 */  sll        $a1, $a1, 11
    /* E889C 800F809C E5E1030C */  jal        func_800F8794
    /* E88A0 800F80A0 21284500 */   addu      $a1, $v0, $a1
    /* E88A4 800F80A4 34E00308 */  j          .L800F80D0
    /* E88A8 800F80A8 00000000 */   nop
  .L800F80AC:
    /* E88AC 800F80AC 03000424 */  addiu      $a0, $zero, 0x3
    /* E88B0 800F80B0 21300000 */  addu       $a2, $zero, $zero
    /* E88B4 800F80B4 1480053C */  lui        $a1, %hi(D_80144864)
    /* E88B8 800F80B8 6448A58C */  lw         $a1, %lo(D_80144864)($a1)
    /* E88BC 800F80BC 08000724 */  addiu      $a3, $zero, 0x8
    /* E88C0 800F80C0 1000A8AF */  sw         $t0, 0x10($sp)
    /* E88C4 800F80C4 1400A0AF */  sw         $zero, 0x14($sp)
    /* E88C8 800F80C8 F0E1030C */  jal        func_800F87C0
    /* E88CC 800F80CC 1800A0AF */   sw        $zero, 0x18($sp)
  .L800F80D0:
    /* E88D0 800F80D0 1380043C */  lui        $a0, %hi(D_80136AC8)
    /* E88D4 800F80D4 C86A848C */  lw         $a0, %lo(D_80136AC8)($a0)
    /* E88D8 800F80D8 00000000 */  nop
    /* E88DC 800F80DC 0000828C */  lw         $v0, 0x0($a0)
    /* E88E0 800F80E0 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* E88E4 800F80E4 24104300 */  and        $v0, $v0, $v1
    /* E88E8 800F80E8 07004010 */  beqz       $v0, .L800F8108
    /* E88EC 800F80EC 21188000 */   addu      $v1, $a0, $zero
    /* E88F0 800F80F0 0001043C */  lui        $a0, (0x1000000 >> 16)
  .L800F80F4:
    /* E88F4 800F80F4 0000628C */  lw         $v0, 0x0($v1)
    /* E88F8 800F80F8 00000000 */  nop
    /* E88FC 800F80FC 24104400 */  and        $v0, $v0, $a0
    /* E8900 800F8100 FCFF4014 */  bnez       $v0, .L800F80F4
    /* E8904 800F8104 00000000 */   nop
  .L800F8108:
    /* E8908 800F8108 0200043C */  lui        $a0, (0x20843 >> 16)
    /* E890C 800F810C 43088434 */  ori        $a0, $a0, (0x20843 & 0xFFFF)
    /* E8910 800F8110 1480023C */  lui        $v0, %hi(D_80144864)
    /* E8914 800F8114 6448428C */  lw         $v0, %lo(D_80144864)($v0)
    /* E8918 800F8118 1380033C */  lui        $v1, %hi(D_80136AA8)
    /* E891C 800F811C A86A638C */  lw         $v1, %lo(D_80136AA8)($v1)
    /* E8920 800F8120 2B00A58B */  lwl        $a1, 0x2B($sp)
    /* E8924 800F8124 2800A59B */  lwr        $a1, 0x28($sp)
    /* E8928 800F8128 00000000 */  nop
    /* E892C 800F812C 1F0045A8 */  swl        $a1, 0x1F($v0)
    /* E8930 800F8130 1C0045B8 */  swr        $a1, 0x1C($v0)
    /* E8934 800F8134 000064AC */  sw         $a0, 0x0($v1)
    /* E8938 800F8138 1380033C */  lui        $v1, %hi(D_80136AAC)
    /* E893C 800F813C AC6A638C */  lw         $v1, %lo(D_80136AAC)($v1)
    /* E8940 800F8140 25130224 */  addiu      $v0, $zero, 0x1325
    /* E8944 800F8144 000062AC */  sw         $v0, 0x0($v1)
    /* E8948 800F8148 1480033C */  lui        $v1, %hi(StSTART_FLAG)
    /* E894C 800F814C 986C638C */  lw         $v1, %lo(StSTART_FLAG)($v1)
    /* E8950 800F8150 01000224 */  addiu      $v0, $zero, 0x1
    /* E8954 800F8154 1C006214 */  bne        $v1, $v0, .L800F81C8
    /* E8958 800F8158 00000000 */   nop
    /* E895C 800F815C 1480043C */  lui        $a0, %hi(StStartFrame)
    /* E8960 800F8160 C06C848C */  lw         $a0, %lo(StStartFrame)($a0)
    /* E8964 800F8164 00000000 */  nop
    /* E8968 800F8168 17008010 */  beqz       $a0, .L800F81C8
    /* E896C 800F816C 00000000 */   nop
    /* E8970 800F8170 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8974 800F8174 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8978 800F8178 00000000 */  nop
    /* E897C 800F817C 08006294 */  lhu        $v0, 0x8($v1)
    /* E8980 800F8180 00000000 */  nop
    /* E8984 800F8184 0E008210 */  beq        $a0, $v0, .L800F81C0
    /* E8988 800F8188 00000000 */   nop
    /* E898C 800F818C 000060A4 */  sh         $zero, 0x0($v1)
    /* E8990 800F8190 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8994 800F8194 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8998 800F8198 00000000 */  nop
    /* E899C 800F819C 79014010 */  beqz       $v0, .L800F8784
    /* E89A0 800F81A0 00000000 */   nop
    /* E89A4 800F81A4 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E89A8 800F81A8 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E89AC 800F81AC 00000000 */  nop
    /* E89B0 800F81B0 01004224 */  addiu      $v0, $v0, 0x1
    /* E89B4 800F81B4 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E89B8 800F81B8 E1E10308 */  j          .L800F8784
    /* E89BC 800F81BC 9C6C22AC */   sw        $v0, %lo(StEmu_Idx)($at)
  .L800F81C0:
    /* E89C0 800F81C0 1480013C */  lui        $at, %hi(StSTART_FLAG)
    /* E89C4 800F81C4 986C20AC */  sw         $zero, %lo(StSTART_FLAG)($at)
  .L800F81C8:
    /* E89C8 800F81C8 1480043C */  lui        $a0, %hi(D_80144864)
    /* E89CC 800F81CC 6448848C */  lw         $a0, %lo(D_80144864)($a0)
    /* E89D0 800F81D0 00000000 */  nop
    /* E89D4 800F81D4 00008394 */  lhu        $v1, 0x0($a0)
    /* E89D8 800F81D8 60010224 */  addiu      $v0, $zero, 0x160
    /* E89DC 800F81DC 08006214 */  bne        $v1, $v0, .L800F8200
    /* E89E0 800F81E0 00000000 */   nop
    /* E89E4 800F81E4 02008294 */  lhu        $v0, 0x2($a0)
    /* E89E8 800F81E8 1480033C */  lui        $v1, %hi(CChannel)
    /* E89EC 800F81EC 846C638C */  lw         $v1, %lo(CChannel)($v1)
    /* E89F0 800F81F0 82120200 */  srl        $v0, $v0, 10
    /* E89F4 800F81F4 1F004230 */  andi       $v0, $v0, 0x1F
    /* E89F8 800F81F8 11004310 */  beq        $v0, $v1, .L800F8240
    /* E89FC 800F81FC 00000000 */   nop
  .L800F8200:
    /* E8A00 800F8200 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8A04 800F8204 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8A08 800F8208 00000000 */  nop
    /* E8A0C 800F820C 04004010 */  beqz       $v0, .L800F8220
    /* E8A10 800F8210 00000000 */   nop
    /* E8A14 800F8214 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8A18 800F8218 89E00308 */  j          .L800F8224
    /* E8A1C 800F821C 9C6C20AC */   sw        $zero, %lo(StEmu_Idx)($at)
  .L800F8220:
    /* E8A20 800F8220 00008294 */  lhu        $v0, 0x0($a0)
  .L800F8224:
    /* E8A24 800F8224 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8A28 800F8228 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8A2C 800F822C 05000224 */  addiu      $v0, $zero, 0x5
    /* E8A30 800F8230 1380013C */  lui        $at, %hi(debug_cause)
    /* E8A34 800F8234 E06A22AC */  sw         $v0, %lo(debug_cause)($at)
    /* E8A38 800F8238 E1E10308 */  j          .L800F8784
    /* E8A3C 800F823C 000060A4 */   sh        $zero, 0x0($v1)
  .L800F8240:
    /* E8A40 800F8240 1480033C */  lui        $v1, %hi(Stsector_offset)
    /* E8A44 800F8244 A06C6384 */  lh         $v1, %lo(Stsector_offset)($v1)
    /* E8A48 800F8248 04008294 */  lhu        $v0, 0x4($a0)
    /* E8A4C 800F824C 00000000 */  nop
    /* E8A50 800F8250 0A006214 */  bne        $v1, $v0, .L800F827C
    /* E8A54 800F8254 00000000 */   nop
    /* E8A58 800F8258 1480033C */  lui        $v1, %hi(Stframe_no)
    /* E8A5C 800F825C 8C6C638C */  lw         $v1, %lo(Stframe_no)($v1)
    /* E8A60 800F8260 00000000 */  nop
    /* E8A64 800F8264 25006010 */  beqz       $v1, .L800F82FC
    /* E8A68 800F8268 00000000 */   nop
    /* E8A6C 800F826C 08008294 */  lhu        $v0, 0x8($a0)
    /* E8A70 800F8270 00000000 */  nop
    /* E8A74 800F8274 21006210 */  beq        $v1, $v0, .L800F82FC
    /* E8A78 800F8278 00000000 */   nop
  .L800F827C:
    /* E8A7C 800F827C 1480043C */  lui        $a0, %hi(StRingIdx2)
    /* E8A80 800F8280 B46C848C */  lw         $a0, %lo(StRingIdx2)($a0)
    /* E8A84 800F8284 1480053C */  lui        $a1, %hi(StRingIdx1)
    /* E8A88 800F8288 B06CA58C */  lw         $a1, %lo(StRingIdx1)($a1)
    /* E8A8C 800F828C 1480013C */  lui        $at, %hi(Stframe_no)
    /* E8A90 800F8290 8C6C20AC */  sw         $zero, %lo(Stframe_no)($at)
    /* E8A94 800F8294 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E8A98 800F8298 A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E8A9C 800F829C D621040C */  jal        init_ring_status
    /* E8AA0 800F82A0 2328A400 */   subu      $a1, $a1, $a0
    /* E8AA4 800F82A4 1480023C */  lui        $v0, %hi(StRingIdx2)
    /* E8AA8 800F82A8 B46C428C */  lw         $v0, %lo(StRingIdx2)($v0)
    /* E8AAC 800F82AC 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8AB0 800F82B0 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8AB4 800F82B4 1480013C */  lui        $at, %hi(StRingIdx1)
    /* E8AB8 800F82B8 B06C22AC */  sw         $v0, %lo(StRingIdx1)($at)
    /* E8ABC 800F82BC 000060A4 */  sh         $zero, 0x0($v1)
    /* E8AC0 800F82C0 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8AC4 800F82C4 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8AC8 800F82C8 00000000 */  nop
    /* E8ACC 800F82CC 08004010 */  beqz       $v0, .L800F82F0
    /* E8AD0 800F82D0 06000224 */   addiu     $v0, $zero, 0x6
    /* E8AD4 800F82D4 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8AD8 800F82D8 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8ADC 800F82DC 00000000 */  nop
    /* E8AE0 800F82E0 01004224 */  addiu      $v0, $v0, 0x1
    /* E8AE4 800F82E4 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8AE8 800F82E8 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
    /* E8AEC 800F82EC 06000224 */  addiu      $v0, $zero, 0x6
  .L800F82F0:
    /* E8AF0 800F82F0 1380013C */  lui        $at, %hi(debug_cause)
    /* E8AF4 800F82F4 E1E10308 */  j          .L800F8784
    /* E8AF8 800F82F8 E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F82FC:
    /* E8AFC 800F82FC 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8B00 800F8300 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8B04 800F8304 00000000 */  nop
    /* E8B08 800F8308 04006294 */  lhu        $v0, 0x4($v1)
    /* E8B0C 800F830C 00000000 */  nop
    /* E8B10 800F8310 8D004014 */  bnez       $v0, .L800F8548
    /* E8B14 800F8314 0A000224 */   addiu     $v0, $zero, 0xA
    /* E8B18 800F8318 08006294 */  lhu        $v0, 0x8($v1)
    /* E8B1C 800F831C 1480033C */  lui        $v1, %hi(StEndFrame)
    /* E8B20 800F8320 946C638C */  lw         $v1, %lo(StEndFrame)($v1)
    /* E8B24 800F8324 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E8B28 800F8328 A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E8B2C 800F832C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* E8B30 800F8330 1480013C */  lui        $at, %hi(Stframe_no)
    /* E8B34 800F8334 8C6C22AC */  sw         $v0, %lo(Stframe_no)($at)
    /* E8B38 800F8338 2B006010 */  beqz       $v1, .L800F83E8
    /* E8B3C 800F833C 2B104300 */   sltu      $v0, $v0, $v1
    /* E8B40 800F8340 29004014 */  bnez       $v0, .L800F83E8
    /* E8B44 800F8344 00000000 */   nop
    /* E8B48 800F8348 1480043C */  lui        $a0, %hi(StRingIdx2)
    /* E8B4C 800F834C B46C848C */  lw         $a0, %lo(StRingIdx2)($a0)
    /* E8B50 800F8350 1480053C */  lui        $a1, %hi(StRingIdx1)
    /* E8B54 800F8354 B06CA58C */  lw         $a1, %lo(StRingIdx1)($a1)
    /* E8B58 800F8358 1480013C */  lui        $at, %hi(Stframe_no)
    /* E8B5C 800F835C 8C6C20AC */  sw         $zero, %lo(Stframe_no)($at)
    /* E8B60 800F8360 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E8B64 800F8364 A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E8B68 800F8368 D621040C */  jal        init_ring_status
    /* E8B6C 800F836C 2328A400 */   subu      $a1, $a1, $a0
    /* E8B70 800F8370 1480023C */  lui        $v0, %hi(StRingIdx2)
    /* E8B74 800F8374 B46C428C */  lw         $v0, %lo(StRingIdx2)($v0)
    /* E8B78 800F8378 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8B7C 800F837C 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8B80 800F8380 1480013C */  lui        $at, %hi(StRingIdx1)
    /* E8B84 800F8384 B06C22AC */  sw         $v0, %lo(StRingIdx1)($at)
    /* E8B88 800F8388 000060A4 */  sh         $zero, 0x0($v1)
    /* E8B8C 800F838C 1480033C */  lui        $v1, %hi(StFunc2)
    /* E8B90 800F8390 7848638C */  lw         $v1, %lo(StFunc2)($v1)
    /* E8B94 800F8394 01000224 */  addiu      $v0, $zero, 0x1
    /* E8B98 800F8398 1480013C */  lui        $at, %hi(StSTART_FLAG)
    /* E8B9C 800F839C 03006010 */  beqz       $v1, .L800F83AC
    /* E8BA0 800F83A0 986C22AC */   sw        $v0, %lo(StSTART_FLAG)($at)
    /* E8BA4 800F83A4 09F86000 */  jalr       $v1
    /* E8BA8 800F83A8 00000000 */   nop
  .L800F83AC:
    /* E8BAC 800F83AC 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8BB0 800F83B0 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8BB4 800F83B4 00000000 */  nop
    /* E8BB8 800F83B8 08004010 */  beqz       $v0, .L800F83DC
    /* E8BBC 800F83BC 07000224 */   addiu     $v0, $zero, 0x7
    /* E8BC0 800F83C0 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8BC4 800F83C4 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8BC8 800F83C8 00000000 */  nop
    /* E8BCC 800F83CC 01004224 */  addiu      $v0, $v0, 0x1
    /* E8BD0 800F83D0 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8BD4 800F83D4 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
    /* E8BD8 800F83D8 07000224 */  addiu      $v0, $zero, 0x7
  .L800F83DC:
    /* E8BDC 800F83DC 1380013C */  lui        $at, %hi(debug_cause)
    /* E8BE0 800F83E0 E1E10308 */  j          .L800F8784
    /* E8BE4 800F83E4 E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F83E8:
    /* E8BE8 800F83E8 1480023C */  lui        $v0, %hi(StRingSize)
    /* E8BEC 800F83EC BC6C428C */  lw         $v0, %lo(StRingSize)($v0)
    /* E8BF0 800F83F0 1480033C */  lui        $v1, %hi(StRingIdx1)
    /* E8BF4 800F83F4 B06C638C */  lw         $v1, %lo(StRingIdx1)($v1)
    /* E8BF8 800F83F8 1480043C */  lui        $a0, %hi(D_80144864)
    /* E8BFC 800F83FC 6448848C */  lw         $a0, %lo(D_80144864)($a0)
    /* E8C00 800F8400 23104300 */  subu       $v0, $v0, $v1
    /* E8C04 800F8404 06008394 */  lhu        $v1, 0x6($a0)
    /* E8C08 800F8408 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E8C0C 800F840C 2B104300 */  sltu       $v0, $v0, $v1
    /* E8C10 800F8410 48004010 */  beqz       $v0, .L800F8534
    /* E8C14 800F8414 00000000 */   nop
    /* E8C18 800F8418 1480023C */  lui        $v0, %hi(StEndFrame)
    /* E8C1C 800F841C 946C428C */  lw         $v0, %lo(StEndFrame)($v0)
    /* E8C20 800F8420 00000000 */  nop
    /* E8C24 800F8424 19004014 */  bnez       $v0, .L800F848C
    /* E8C28 800F8428 01000224 */   addiu     $v0, $zero, 0x1
    /* E8C2C 800F842C 000082A4 */  sh         $v0, 0x0($a0)
    /* E8C30 800F8430 1480033C */  lui        $v1, %hi(StFunc2)
    /* E8C34 800F8434 7848638C */  lw         $v1, %lo(StFunc2)($v1)
    /* E8C38 800F8438 01000224 */  addiu      $v0, $zero, 0x1
    /* E8C3C 800F843C 1480013C */  lui        $at, %hi(StSTART_FLAG)
    /* E8C40 800F8440 03006010 */  beqz       $v1, .L800F8450
    /* E8C44 800F8444 986C22AC */   sw        $v0, %lo(StSTART_FLAG)($at)
    /* E8C48 800F8448 09F86000 */  jalr       $v1
    /* E8C4C 800F844C 00000000 */   nop
  .L800F8450:
    /* E8C50 800F8450 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8C54 800F8454 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8C58 800F8458 00000000 */  nop
    /* E8C5C 800F845C 08004010 */  beqz       $v0, .L800F8480
    /* E8C60 800F8460 08000224 */   addiu     $v0, $zero, 0x8
    /* E8C64 800F8464 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8C68 800F8468 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8C6C 800F846C 00000000 */  nop
    /* E8C70 800F8470 01004224 */  addiu      $v0, $v0, 0x1
    /* E8C74 800F8474 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8C78 800F8478 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
    /* E8C7C 800F847C 08000224 */  addiu      $v0, $zero, 0x8
  .L800F8480:
    /* E8C80 800F8480 1380013C */  lui        $at, %hi(debug_cause)
    /* E8C84 800F8484 E1E10308 */  j          .L800F8784
    /* E8C88 800F8488 E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F848C:
    /* E8C8C 800F848C 1480023C */  lui        $v0, %hi(StRingAddr)
    /* E8C90 800F8490 AC6C428C */  lw         $v0, %lo(StRingAddr)($v0)
    /* E8C94 800F8494 00000000 */  nop
    /* E8C98 800F8498 00004284 */  lh         $v0, 0x0($v0)
    /* E8C9C 800F849C 00000000 */  nop
    /* E8CA0 800F84A0 11004010 */  beqz       $v0, .L800F84E8
    /* E8CA4 800F84A4 01000224 */   addiu     $v0, $zero, 0x1
    /* E8CA8 800F84A8 000080A4 */  sh         $zero, 0x0($a0)
    /* E8CAC 800F84AC 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8CB0 800F84B0 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8CB4 800F84B4 00000000 */  nop
    /* E8CB8 800F84B8 08004010 */  beqz       $v0, .L800F84DC
    /* E8CBC 800F84BC 09000224 */   addiu     $v0, $zero, 0x9
    /* E8CC0 800F84C0 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8CC4 800F84C4 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8CC8 800F84C8 00000000 */  nop
    /* E8CCC 800F84CC 01004224 */  addiu      $v0, $v0, 0x1
    /* E8CD0 800F84D0 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8CD4 800F84D4 9C6C22AC */  sw         $v0, %lo(StEmu_Idx)($at)
    /* E8CD8 800F84D8 09000224 */  addiu      $v0, $zero, 0x9
  .L800F84DC:
    /* E8CDC 800F84DC 1380013C */  lui        $at, %hi(debug_cause)
    /* E8CE0 800F84E0 E1E10308 */  j          .L800F8784
    /* E8CE4 800F84E4 E06A22AC */   sw        $v0, %lo(debug_cause)($at)
  .L800F84E8:
    /* E8CE8 800F84E8 000082A4 */  sh         $v0, 0x0($a0)
    /* E8CEC 800F84EC 1480053C */  lui        $a1, %hi(StRingAddr)
    /* E8CF0 800F84F0 AC6CA58C */  lw         $a1, %lo(StRingAddr)($a1)
    /* E8CF4 800F84F4 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8CF8 800F84F8 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8CFC 800F84FC 21200000 */  addu       $a0, $zero, $zero
    /* E8D00 800F8500 1480013C */  lui        $at, %hi(StRingIdx1)
    /* E8D04 800F8504 B06C20AC */  sw         $zero, %lo(StRingIdx1)($at)
  .L800F8508:
    /* E8D08 800F8508 0000628C */  lw         $v0, 0x0($v1)
    /* E8D0C 800F850C 04006324 */  addiu      $v1, $v1, 0x4
    /* E8D10 800F8510 01008424 */  addiu      $a0, $a0, 0x1
    /* E8D14 800F8514 0000A2AC */  sw         $v0, 0x0($a1)
    /* E8D18 800F8518 0800822C */  sltiu      $v0, $a0, 0x8
    /* E8D1C 800F851C FAFF4014 */  bnez       $v0, .L800F8508
    /* E8D20 800F8520 0400A524 */   addiu     $a1, $a1, 0x4
    /* E8D24 800F8524 1480023C */  lui        $v0, %hi(StRingAddr)
    /* E8D28 800F8528 AC6C428C */  lw         $v0, %lo(StRingAddr)($v0)
    /* E8D2C 800F852C 1480013C */  lui        $at, %hi(D_80144864)
    /* E8D30 800F8530 644822AC */  sw         $v0, %lo(D_80144864)($at)
  .L800F8534:
    /* E8D34 800F8534 1480023C */  lui        $v0, %hi(StRingIdx1)
    /* E8D38 800F8538 B06C428C */  lw         $v0, %lo(StRingIdx1)($v0)
    /* E8D3C 800F853C 1480013C */  lui        $at, %hi(StRingIdx2)
    /* E8D40 800F8540 B46C22AC */  sw         $v0, %lo(StRingIdx2)($at)
    /* E8D44 800F8544 0A000224 */  addiu      $v0, $zero, 0xA
  .L800F8548:
    /* E8D48 800F8548 1380013C */  lui        $at, %hi(debug_cause)
    /* E8D4C 800F854C E06A22AC */  sw         $v0, %lo(debug_cause)($at)
    /* E8D50 800F8550 1480023C */  lui        $v0, %hi(Stsector_offset)
    /* E8D54 800F8554 A06C4294 */  lhu        $v0, %lo(Stsector_offset)($v0)
    /* E8D58 800F8558 1480043C */  lui        $a0, %hi(StRingSize)
    /* E8D5C 800F855C BC6C848C */  lw         $a0, %lo(StRingSize)($a0)
    /* E8D60 800F8560 1480033C */  lui        $v1, %hi(StRingAddr)
    /* E8D64 800F8564 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* E8D68 800F8568 1480053C */  lui        $a1, %hi(StRingIdx1)
    /* E8D6C 800F856C B06CA58C */  lw         $a1, %lo(StRingIdx1)($a1)
    /* E8D70 800F8570 01004224 */  addiu      $v0, $v0, 0x1
    /* E8D74 800F8574 40210400 */  sll        $a0, $a0, 5
    /* E8D78 800F8578 21186400 */  addu       $v1, $v1, $a0
    /* E8D7C 800F857C 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E8D80 800F8580 A06C22A4 */  sh         $v0, %lo(Stsector_offset)($at)
    /* E8D84 800F8584 80110500 */  sll        $v0, $a1, 6
    /* E8D88 800F8588 23104500 */  subu       $v0, $v0, $a1
    /* E8D8C 800F858C 40110200 */  sll        $v0, $v0, 5
    /* E8D90 800F8590 1480043C */  lui        $a0, %hi(StRgb24)
    /* E8D94 800F8594 906C848C */  lw         $a0, %lo(StRgb24)($a0)
    /* E8D98 800F8598 21186200 */  addu       $v1, $v1, $v0
    /* E8D9C 800F859C 1480013C */  lui        $at, %hi(StRingBase)
    /* E8DA0 800F85A0 A86C23AC */  sw         $v1, %lo(StRingBase)($at)
    /* E8DA4 800F85A4 0B008010 */  beqz       $a0, .L800F85D4
    /* E8DA8 800F85A8 0011083C */   lui       $t0, (0x11000000 >> 16)
    /* E8DAC 800F85AC 0200033C */  lui        $v1, (0x20943 >> 16)
    /* E8DB0 800F85B0 1380023C */  lui        $v0, %hi(D_80136AA8)
    /* E8DB4 800F85B4 A86A428C */  lw         $v0, %lo(D_80136AA8)($v0)
    /* E8DB8 800F85B8 43096334 */  ori        $v1, $v1, (0x20943 & 0xFFFF)
    /* E8DBC 800F85BC 000043AC */  sw         $v1, 0x0($v0)
    /* E8DC0 800F85C0 1380033C */  lui        $v1, %hi(D_80136AAC)
    /* E8DC4 800F85C4 AC6A638C */  lw         $v1, %lo(D_80136AAC)($v1)
    /* E8DC8 800F85C8 23130224 */  addiu      $v0, $zero, 0x1323
    /* E8DCC 800F85CC 7CE10308 */  j          .L800F85F0
    /* E8DD0 800F85D0 000062AC */   sw        $v0, 0x0($v1)
  .L800F85D4:
    /* E8DD4 800F85D4 0221033C */  lui        $v1, (0x21020843 >> 16)
    /* E8DD8 800F85D8 43086334 */  ori        $v1, $v1, (0x21020843 & 0xFFFF)
    /* E8DDC 800F85DC 4011083C */  lui        $t0, (0x11400100 >> 16)
    /* E8DE0 800F85E0 1380023C */  lui        $v0, %hi(D_80136AA8)
    /* E8DE4 800F85E4 A86A428C */  lw         $v0, %lo(D_80136AA8)($v0)
    /* E8DE8 800F85E8 00010835 */  ori        $t0, $t0, (0x11400100 & 0xFFFF)
    /* E8DEC 800F85EC 000043AC */  sw         $v1, 0x0($v0)
  .L800F85F0:
    /* E8DF0 800F85F0 1480023C */  lui        $v0, %hi(D_80144864)
    /* E8DF4 800F85F4 6448428C */  lw         $v0, %lo(D_80144864)($v0)
    /* E8DF8 800F85F8 00000000 */  nop
    /* E8DFC 800F85FC 06004394 */  lhu        $v1, 0x6($v0)
    /* E8E00 800F8600 04004294 */  lhu        $v0, 0x4($v0)
    /* E8E04 800F8604 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* E8E08 800F8608 29006214 */  bne        $v1, $v0, .L800F86B0
    /* E8E0C 800F860C 01000324 */   addiu     $v1, $zero, 0x1
    /* E8E10 800F8610 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8E14 800F8614 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8E18 800F8618 1480013C */  lui        $at, %hi(StFinalSector)
    /* E8E1C 800F861C A46C23AC */  sw         $v1, %lo(StFinalSector)($at)
    /* E8E20 800F8620 11004010 */  beqz       $v0, .L800F8668
    /* E8E24 800F8624 F8010624 */   addiu     $a2, $zero, 0x1F8
    /* E8E28 800F8628 01000724 */  addiu      $a3, $zero, 0x1
    /* E8E2C 800F862C 1480053C */  lui        $a1, %hi(StEmu_Idx)
    /* E8E30 800F8630 9C6CA58C */  lw         $a1, %lo(StEmu_Idx)($a1)
    /* E8E34 800F8634 1480043C */  lui        $a0, %hi(StRingBase)
    /* E8E38 800F8638 A86C848C */  lw         $a0, %lo(StRingBase)($a0)
    /* E8E3C 800F863C C02A0500 */  sll        $a1, $a1, 11
    /* E8E40 800F8640 21284500 */  addu       $a1, $v0, $a1
    /* E8E44 800F8644 E5E1030C */  jal        func_800F8794
    /* E8E48 800F8648 2000A524 */   addiu     $a1, $a1, 0x20
    /* E8E4C 800F864C 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8E50 800F8650 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8E54 800F8654 00000000 */  nop
    /* E8E58 800F8658 01004224 */  addiu      $v0, $v0, 0x1
    /* E8E5C 800F865C 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8E60 800F8660 A3E10308 */  j          .L800F868C
    /* E8E64 800F8664 9C6C22AC */   sw        $v0, %lo(StEmu_Idx)($at)
  .L800F8668:
    /* E8E68 800F8668 03000424 */  addiu      $a0, $zero, 0x3
    /* E8E6C 800F866C 21300000 */  addu       $a2, $zero, $zero
    /* E8E70 800F8670 1480053C */  lui        $a1, %hi(StRingBase)
    /* E8E74 800F8674 A86CA58C */  lw         $a1, %lo(StRingBase)($a1)
    /* E8E78 800F8678 F8010724 */  addiu      $a3, $zero, 0x1F8
    /* E8E7C 800F867C 1000A8AF */  sw         $t0, 0x10($sp)
    /* E8E80 800F8680 1400A3AF */  sw         $v1, 0x14($sp)
    /* E8E84 800F8684 F0E1030C */  jal        func_800F87C0
    /* E8E88 800F8688 1800A0AF */   sw        $zero, 0x18($sp)
  .L800F868C:
    /* E8E8C 800F868C 1480023C */  lui        $v0, %hi(StCHANNEL)
    /* E8E90 800F8690 886C428C */  lw         $v0, %lo(StCHANNEL)($v0)
    /* E8E94 800F8694 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E8E98 800F8698 A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E8E9C 800F869C 1480013C */  lui        $at, %hi(Stframe_no)
    /* E8EA0 800F86A0 8C6C20AC */  sw         $zero, %lo(Stframe_no)($at)
    /* E8EA4 800F86A4 1480013C */  lui        $at, %hi(CChannel)
    /* E8EA8 800F86A8 CAE10308 */  j          .L800F8728
    /* E8EAC 800F86AC 846C22AC */   sw        $v0, %lo(CChannel)($at)
  .L800F86B0:
    /* E8EB0 800F86B0 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* E8EB4 800F86B4 7C6C428C */  lw         $v0, %lo(StEmu_Addr)($v0)
    /* E8EB8 800F86B8 00000000 */  nop
    /* E8EBC 800F86BC 11004010 */  beqz       $v0, .L800F8704
    /* E8EC0 800F86C0 F8010624 */   addiu     $a2, $zero, 0x1F8
    /* E8EC4 800F86C4 21380000 */  addu       $a3, $zero, $zero
    /* E8EC8 800F86C8 1480053C */  lui        $a1, %hi(StEmu_Idx)
    /* E8ECC 800F86CC 9C6CA58C */  lw         $a1, %lo(StEmu_Idx)($a1)
    /* E8ED0 800F86D0 1480043C */  lui        $a0, %hi(StRingBase)
    /* E8ED4 800F86D4 A86C848C */  lw         $a0, %lo(StRingBase)($a0)
    /* E8ED8 800F86D8 C02A0500 */  sll        $a1, $a1, 11
    /* E8EDC 800F86DC 21284500 */  addu       $a1, $v0, $a1
    /* E8EE0 800F86E0 E5E1030C */  jal        func_800F8794
    /* E8EE4 800F86E4 2000A524 */   addiu     $a1, $a1, 0x20
    /* E8EE8 800F86E8 1480023C */  lui        $v0, %hi(StEmu_Idx)
    /* E8EEC 800F86EC 9C6C428C */  lw         $v0, %lo(StEmu_Idx)($v0)
    /* E8EF0 800F86F0 00000000 */  nop
    /* E8EF4 800F86F4 01004224 */  addiu      $v0, $v0, 0x1
    /* E8EF8 800F86F8 1480013C */  lui        $at, %hi(StEmu_Idx)
    /* E8EFC 800F86FC CAE10308 */  j          .L800F8728
    /* E8F00 800F8700 9C6C22AC */   sw        $v0, %lo(StEmu_Idx)($at)
  .L800F8704:
    /* E8F04 800F8704 03000424 */  addiu      $a0, $zero, 0x3
    /* E8F08 800F8708 21300000 */  addu       $a2, $zero, $zero
    /* E8F0C 800F870C 1480053C */  lui        $a1, %hi(StRingBase)
    /* E8F10 800F8710 A86CA58C */  lw         $a1, %lo(StRingBase)($a1)
    /* E8F14 800F8714 F8010724 */  addiu      $a3, $zero, 0x1F8
    /* E8F18 800F8718 1000A8AF */  sw         $t0, 0x10($sp)
    /* E8F1C 800F871C 1400A0AF */  sw         $zero, 0x14($sp)
    /* E8F20 800F8720 F0E1030C */  jal        func_800F87C0
    /* E8F24 800F8724 1800A0AF */   sw        $zero, 0x18($sp)
  .L800F8728:
    /* E8F28 800F8728 1380033C */  lui        $v1, %hi(D_80136AAC)
    /* E8F2C 800F872C AC6A638C */  lw         $v1, %lo(D_80136AAC)($v1)
    /* E8F30 800F8730 25130224 */  addiu      $v0, $zero, 0x1325
    /* E8F34 800F8734 000062AC */  sw         $v0, 0x0($v1)
    /* E8F38 800F8738 1480033C */  lui        $v1, %hi(D_80144864)
    /* E8F3C 800F873C 6448638C */  lw         $v1, %lo(D_80144864)($v1)
    /* E8F40 800F8740 03000224 */  addiu      $v0, $zero, 0x3
    /* E8F44 800F8744 000062A4 */  sh         $v0, 0x0($v1)
    /* E8F48 800F8748 1480023C */  lui        $v0, %hi(StRingIdx1)
    /* E8F4C 800F874C B06C428C */  lw         $v0, %lo(StRingIdx1)($v0)
    /* E8F50 800F8750 1480033C */  lui        $v1, %hi(StEmu_Addr)
    /* E8F54 800F8754 7C6C638C */  lw         $v1, %lo(StEmu_Addr)($v1)
    /* E8F58 800F8758 01004224 */  addiu      $v0, $v0, 0x1
    /* E8F5C 800F875C 1480013C */  lui        $at, %hi(StRingIdx1)
    /* E8F60 800F8760 08006010 */  beqz       $v1, .L800F8784
    /* E8F64 800F8764 B06C22AC */   sw        $v0, %lo(StRingIdx1)($at)
    /* E8F68 800F8768 1480023C */  lui        $v0, %hi(StFinalSector)
    /* E8F6C 800F876C A46C428C */  lw         $v0, %lo(StFinalSector)($v0)
    /* E8F70 800F8770 00000000 */  nop
    /* E8F74 800F8774 03004010 */  beqz       $v0, .L800F8784
    /* E8F78 800F8778 00000000 */   nop
    /* E8F7C 800F877C E621040C */  jal        data_ready_callback
    /* E8F80 800F8780 00000000 */   nop
  .L800F8784:
    /* E8F84 800F8784 3800BF8F */  lw         $ra, 0x38($sp)
    /* E8F88 800F8788 4000BD27 */  addiu      $sp, $sp, 0x40
    /* E8F8C 800F878C 0800E003 */  jr         $ra
    /* E8F90 800F8790 00000000 */   nop
endlabel StCdInterrupt
