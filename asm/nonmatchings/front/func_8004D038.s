.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8004D038, 0x2FC

glabel func_8004D038
    /* 3D838 8004D038 0580023C */  lui        $v0, %hi(D_80052D04)
    /* 3D83C 8004D03C 042D428C */  lw         $v0, %lo(D_80052D04)($v0)
    /* 3D840 8004D040 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3D844 8004D044 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3D848 8004D048 09004010 */  beqz       $v0, .L8004D070
    /* 3D84C 8004D04C 1800B0AF */   sw        $s0, 0x18($sp)
    /* 3D850 8004D050 1480103C */  lui        $s0, %hi(StCdIntrFlag)
    /* 3D854 8004D054 806C028E */  lw         $v0, %lo(StCdIntrFlag)($s0)
    /* 3D858 8004D058 00000000 */  nop
    /* 3D85C 8004D05C 05004010 */  beqz       $v0, .L8004D074
    /* 3D860 8004D060 0580023C */   lui       $v0, %hi(download)
    /* 3D864 8004D064 9EDF030C */  jal        StCdInterrupt
    /* 3D868 8004D068 00000000 */   nop
    /* 3D86C 8004D06C 806C00AE */  sw         $zero, %lo(StCdIntrFlag)($s0)
  .L8004D070:
    /* 3D870 8004D070 0580023C */  lui        $v0, %hi(download)
  .L8004D074:
    /* 3D874 8004D074 302A4284 */  lh         $v0, %lo(download)($v0)
    /* 3D878 8004D078 00000000 */  nop
    /* 3D87C 8004D07C 05004010 */  beqz       $v0, .L8004D094
    /* 3D880 8004D080 0580043C */   lui       $a0, %hi(D_80052D4C)
    /* 3D884 8004D084 4C2D8424 */  addiu      $a0, $a0, %lo(D_80052D4C)
    /* 3D888 8004D088 E8FF858C */  lw         $a1, -0x18($a0)
    /* 3D88C 8004D08C A4B6030C */  jal        LoadImage
    /* 3D890 8004D090 00000000 */   nop
  .L8004D094:
    /* 3D894 8004D094 0580073C */  lui        $a3, %hi(D_80052D20)
    /* 3D898 8004D098 202DE28C */  lw         $v0, %lo(D_80052D20)($a3)
    /* 3D89C 8004D09C 00000000 */  nop
    /* 3D8A0 8004D0A0 39004010 */  beqz       $v0, .L8004D188
    /* 3D8A4 8004D0A4 0580023C */   lui       $v0, %hi(D_80052CFC)
    /* 3D8A8 8004D0A8 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3D8AC 8004D0AC FC2C4684 */  lh         $a2, %lo(D_80052CFC)($v0)
    /* 3D8B0 8004D0B0 FE2C6484 */  lh         $a0, %lo(D_80052CFE)($v1)
    /* 3D8B4 8004D0B4 00190600 */  sll        $v1, $a2, 4
    /* 3D8B8 8004D0B8 1A006400 */  div        $zero, $v1, $a0
    /* 3D8BC 8004D0BC 02008014 */  bnez       $a0, .L8004D0C8
    /* 3D8C0 8004D0C0 00000000 */   nop
    /* 3D8C4 8004D0C4 0D000700 */  break      7
  .L8004D0C8:
    /* 3D8C8 8004D0C8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D8CC 8004D0CC 04008114 */  bne        $a0, $at, .L8004D0E0
    /* 3D8D0 8004D0D0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D8D4 8004D0D4 02006114 */  bne        $v1, $at, .L8004D0E0
    /* 3D8D8 8004D0D8 00000000 */   nop
    /* 3D8DC 8004D0DC 0D000600 */  break      6
  .L8004D0E0:
    /* 3D8E0 8004D0E0 12180000 */  mflo       $v1
    /* 3D8E4 8004D0E4 0580023C */  lui        $v0, %hi(D_80052D28)
    /* 3D8E8 8004D0E8 282D4524 */  addiu      $a1, $v0, %lo(D_80052D28)
    /* 3D8EC 8004D0EC 2000A28C */  lw         $v0, 0x20($a1)
    /* 3D8F0 8004D0F0 00000000 */  nop
    /* 3D8F4 8004D0F4 C0100200 */  sll        $v0, $v0, 3
    /* 3D8F8 8004D0F8 21104500 */  addu       $v0, $v0, $a1
    /* 3D8FC 8004D0FC 14004284 */  lh         $v0, 0x14($v0)
    /* 3D900 8004D100 00000000 */  nop
    /* 3D904 8004D104 1A004300 */  div        $zero, $v0, $v1
    /* 3D908 8004D108 02006014 */  bnez       $v1, .L8004D114
    /* 3D90C 8004D10C 00000000 */   nop
    /* 3D910 8004D110 0D000700 */  break      7
  .L8004D114:
    /* 3D914 8004D114 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D918 8004D118 04006114 */  bne        $v1, $at, .L8004D12C
    /* 3D91C 8004D11C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D920 8004D120 02004114 */  bne        $v0, $at, .L8004D12C
    /* 3D924 8004D124 00000000 */   nop
    /* 3D928 8004D128 0D000600 */  break      6
  .L8004D12C:
    /* 3D92C 8004D12C 10180000 */  mfhi       $v1
    /* 3D930 8004D130 00000000 */  nop
    /* 3D934 8004D134 14006010 */  beqz       $v1, .L8004D188
    /* 3D938 8004D138 18006600 */   mult      $v1, $a2
    /* 3D93C 8004D13C 12180000 */  mflo       $v1
    /* 3D940 8004D140 00000000 */  nop
    /* 3D944 8004D144 00000000 */  nop
    /* 3D948 8004D148 1A006400 */  div        $zero, $v1, $a0
    /* 3D94C 8004D14C 02008014 */  bnez       $a0, .L8004D158
    /* 3D950 8004D150 00000000 */   nop
    /* 3D954 8004D154 0D000700 */  break      7
  .L8004D158:
    /* 3D958 8004D158 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D95C 8004D15C 04008114 */  bne        $a0, $at, .L8004D170
    /* 3D960 8004D160 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D964 8004D164 02006114 */  bne        $v1, $at, .L8004D170
    /* 3D968 8004D168 00000000 */   nop
    /* 3D96C 8004D16C 0D000600 */  break      6
  .L8004D170:
    /* 3D970 8004D170 12180000 */  mflo       $v1
    /* 3D974 8004D174 2400A294 */  lhu        $v0, 0x24($a1)
    /* 3D978 8004D178 202DE0AC */  sw         $zero, %lo(D_80052D20)($a3)
    /* 3D97C 8004D17C 21104300 */  addu       $v0, $v0, $v1
    /* 3D980 8004D180 78340108 */  j          .L8004D1E0
    /* 3D984 8004D184 2400A2A4 */   sh        $v0, 0x24($a1)
  .L8004D188:
    /* 3D988 8004D188 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3D98C 8004D18C 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3D990 8004D190 FC2C4484 */  lh         $a0, %lo(D_80052CFC)($v0)
    /* 3D994 8004D194 FE2C6284 */  lh         $v0, %lo(D_80052CFE)($v1)
    /* 3D998 8004D198 00210400 */  sll        $a0, $a0, 4
    /* 3D99C 8004D19C 1A008200 */  div        $zero, $a0, $v0
    /* 3D9A0 8004D1A0 02004014 */  bnez       $v0, .L8004D1AC
    /* 3D9A4 8004D1A4 00000000 */   nop
    /* 3D9A8 8004D1A8 0D000700 */  break      7
  .L8004D1AC:
    /* 3D9AC 8004D1AC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3D9B0 8004D1B0 04004114 */  bne        $v0, $at, .L8004D1C4
    /* 3D9B4 8004D1B4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3D9B8 8004D1B8 02008114 */  bne        $a0, $at, .L8004D1C4
    /* 3D9BC 8004D1BC 00000000 */   nop
    /* 3D9C0 8004D1C0 0D000600 */  break      6
  .L8004D1C4:
    /* 3D9C4 8004D1C4 12200000 */  mflo       $a0
    /* 3D9C8 8004D1C8 0580033C */  lui        $v1, %hi(D_80052D28)
    /* 3D9CC 8004D1CC 282D6324 */  addiu      $v1, $v1, %lo(D_80052D28)
    /* 3D9D0 8004D1D0 24006294 */  lhu        $v0, 0x24($v1)
    /* 3D9D4 8004D1D4 00000000 */  nop
    /* 3D9D8 8004D1D8 21104400 */  addu       $v0, $v0, $a0
    /* 3D9DC 8004D1DC 240062A4 */  sh         $v0, 0x24($v1)
  .L8004D1E0:
    /* 3D9E0 8004D1E0 0580023C */  lui        $v0, %hi(D_80052D28)
    /* 3D9E4 8004D1E4 282D4624 */  addiu      $a2, $v0, %lo(D_80052D28)
    /* 3D9E8 8004D1E8 2000C78C */  lw         $a3, 0x20($a2)
    /* 3D9EC 8004D1EC 00000000 */  nop
    /* 3D9F0 8004D1F0 C0100700 */  sll        $v0, $a3, 3
    /* 3D9F4 8004D1F4 21104600 */  addu       $v0, $v0, $a2
    /* 3D9F8 8004D1F8 10004384 */  lh         $v1, 0x10($v0)
    /* 3D9FC 8004D1FC 14004484 */  lh         $a0, 0x14($v0)
    /* 3DA00 8004D200 2400C284 */  lh         $v0, 0x24($a2)
    /* 3DA04 8004D204 21186400 */  addu       $v1, $v1, $a0
    /* 3DA08 8004D208 2A104300 */  slt        $v0, $v0, $v1
    /* 3DA0C 8004D20C 31004010 */  beqz       $v0, .L8004D2D4
    /* 3DA10 8004D210 0580023C */   lui       $v0, %hi(D_80052CFC)
    /* 3DA14 8004D214 0580043C */  lui        $a0, %hi(D_80052CFE)
    /* 3DA18 8004D218 FC2C4384 */  lh         $v1, %lo(D_80052CFC)($v0)
    /* 3DA1C 8004D21C FE2C8284 */  lh         $v0, %lo(D_80052CFE)($a0)
    /* 3DA20 8004D220 00190300 */  sll        $v1, $v1, 4
    /* 3DA24 8004D224 1A006200 */  div        $zero, $v1, $v0
    /* 3DA28 8004D228 02004014 */  bnez       $v0, .L8004D234
    /* 3DA2C 8004D22C 00000000 */   nop
    /* 3DA30 8004D230 0D000700 */  break      7
  .L8004D234:
    /* 3DA34 8004D234 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3DA38 8004D238 04004114 */  bne        $v0, $at, .L8004D24C
    /* 3DA3C 8004D23C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3DA40 8004D240 02006114 */  bne        $v1, $at, .L8004D24C
    /* 3DA44 8004D244 00000000 */   nop
    /* 3DA48 8004D248 0D000600 */  break      6
  .L8004D24C:
    /* 3DA4C 8004D24C 12180000 */  mflo       $v1
    /* 3DA50 8004D250 2800C284 */  lh         $v0, 0x28($a2)
    /* 3DA54 8004D254 00000000 */  nop
    /* 3DA58 8004D258 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 3DA5C 8004D25C 1A004300 */  div        $zero, $v0, $v1
    /* 3DA60 8004D260 02006014 */  bnez       $v1, .L8004D26C
    /* 3DA64 8004D264 00000000 */   nop
    /* 3DA68 8004D268 0D000700 */  break      7
  .L8004D26C:
    /* 3DA6C 8004D26C FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3DA70 8004D270 04006114 */  bne        $v1, $at, .L8004D284
    /* 3DA74 8004D274 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3DA78 8004D278 02004114 */  bne        $v0, $at, .L8004D284
    /* 3DA7C 8004D27C 00000000 */   nop
    /* 3DA80 8004D280 0D000600 */  break      6
  .L8004D284:
    /* 3DA84 8004D284 12100000 */  mflo       $v0
    /* 3DA88 8004D288 00000000 */  nop
    /* 3DA8C 8004D28C 01004224 */  addiu      $v0, $v0, 0x1
    /* 3DA90 8004D290 18004300 */  mult       $v0, $v1
    /* 3DA94 8004D294 2A00C384 */  lh         $v1, 0x2A($a2)
    /* 3DA98 8004D298 00000000 */  nop
    /* 3DA9C 8004D29C FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 3DAA0 8004D2A0 12380000 */  mflo       $a3
    /* 3DAA4 8004D2A4 02004104 */  bgez       $v0, .L8004D2B0
    /* 3DAA8 8004D2A8 00290700 */   sll       $a1, $a3, 4
    /* 3DAAC 8004D2AC 0E006224 */  addiu      $v0, $v1, 0xE
  .L8004D2B0:
    /* 3DAB0 8004D2B0 03110200 */  sra        $v0, $v0, 4
    /* 3DAB4 8004D2B4 01004224 */  addiu      $v0, $v0, 0x1
    /* 3DAB8 8004D2B8 1800A200 */  mult       $a1, $v0
    /* 3DABC 8004D2BC 0C00C48C */  lw         $a0, 0xC($a2)
    /* 3DAC0 8004D2C0 12400000 */  mflo       $t0
    /* 3DAC4 8004D2C4 9EE2030C */  jal        DecDCTout
    /* 3DAC8 8004D2C8 43280800 */   sra       $a1, $t0, 1
    /* 3DACC 8004D2CC C9340108 */  j          .L8004D324
    /* 3DAD0 8004D2D0 00000000 */   nop
  .L8004D2D4:
    /* 3DAD4 8004D2D4 01000524 */  addiu      $a1, $zero, 0x1
    /* 3DAD8 8004D2D8 2B20E500 */  sltu       $a0, $a3, $a1
    /* 3DADC 8004D2DC 2000C4AC */  sw         $a0, 0x20($a2)
    /* 3DAE0 8004D2E0 C0200400 */  sll        $a0, $a0, 3
    /* 3DAE4 8004D2E4 21208600 */  addu       $a0, $a0, $a2
    /* 3DAE8 8004D2E8 2C00C5AC */  sw         $a1, 0x2C($a2)
    /* 3DAEC 8004D2EC 10008394 */  lhu        $v1, 0x10($a0)
    /* 3DAF0 8004D2F0 0580023C */  lui        $v0, %hi(D_80052D20)
    /* 3DAF4 8004D2F4 202D45AC */  sw         $a1, %lo(D_80052D20)($v0)
    /* 3DAF8 8004D2F8 0580023C */  lui        $v0, %hi(D_80052A28)
    /* 3DAFC 8004D2FC 2400C3A4 */  sh         $v1, 0x24($a2)
    /* 3DB00 8004D300 282A438C */  lw         $v1, %lo(D_80052A28)($v0)
    /* 3DB04 8004D304 F0000224 */  addiu      $v0, $zero, 0xF0
    /* 3DB08 8004D308 23104300 */  subu       $v0, $v0, $v1
    /* 3DB0C 8004D30C C21F0200 */  srl        $v1, $v0, 31
    /* 3DB10 8004D310 21104300 */  addu       $v0, $v0, $v1
    /* 3DB14 8004D314 12008394 */  lhu        $v1, 0x12($a0)
    /* 3DB18 8004D318 0710A200 */  srav       $v0, $v0, $a1
    /* 3DB1C 8004D31C 21186200 */  addu       $v1, $v1, $v0
    /* 3DB20 8004D320 2600C3A4 */  sh         $v1, 0x26($a2)
  .L8004D324:
    /* 3DB24 8004D324 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3DB28 8004D328 1800B08F */  lw         $s0, 0x18($sp)
    /* 3DB2C 8004D32C 0800E003 */  jr         $ra
    /* 3DB30 8004D330 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_8004D038
