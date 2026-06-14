.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_Instantiate3DCar__FP8Car_tObji, 0x820

glabel R3DCar_Instantiate3DCar__FP8Car_tObji
    /* 9F72C 800AEF2C F0FEBD27 */  addiu      $sp, $sp, -0x110
    /* 9F730 800AEF30 F800B4AF */  sw         $s4, 0xF8($sp)
    /* 9F734 800AEF34 21A08000 */  addu       $s4, $a0, $zero
    /* 9F738 800AEF38 0801BFAF */  sw         $ra, 0x108($sp)
    /* 9F73C 800AEF3C 0401B7AF */  sw         $s7, 0x104($sp)
    /* 9F740 800AEF40 0001B6AF */  sw         $s6, 0x100($sp)
    /* 9F744 800AEF44 FC00B5AF */  sw         $s5, 0xFC($sp)
    /* 9F748 800AEF48 F400B3AF */  sw         $s3, 0xF4($sp)
    /* 9F74C 800AEF4C F000B2AF */  sw         $s2, 0xF0($sp)
    /* 9F750 800AEF50 EC00B1AF */  sw         $s1, 0xEC($sp)
    /* 9F754 800AEF54 E800B0AF */  sw         $s0, 0xE8($sp)
    /* 9F758 800AEF58 8802838E */  lw         $v1, 0x288($s4)
    /* 9F75C 800AEF5C 00000000 */  nop
    /* 9F760 800AEF60 0000758C */  lw         $s5, 0x0($v1)
    /* 9F764 800AEF64 00000000 */  nop
    /* 9F768 800AEF68 EAFFA226 */  addiu      $v0, $s5, -0x16
    /* 9F76C 800AEF6C 0600422C */  sltiu      $v0, $v0, 0x6
    /* 9F770 800AEF70 02004014 */  bnez       $v0, .L800AEF7C
    /* 9F774 800AEF74 00000000 */   nop
    /* 9F778 800AEF78 A00060AC */  sw         $zero, 0xA0($v1)
  .L800AEF7C:
    /* 9F77C 800AEF7C D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9F780 800AEF80 00000000 */  nop
    /* 9F784 800AEF84 1B004014 */  bnez       $v0, .L800AEFF4
    /* 9F788 800AEF88 1C00A22A */   slti      $v0, $s5, 0x1C
    /* 9F78C 800AEF8C 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* 9F790 800AEF90 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 9F794 800AEF94 40180500 */  sll        $v1, $a1, 1
    /* 9F798 800AEF98 21186500 */  addu       $v1, $v1, $a1
    /* 9F79C 800AEF9C 00110300 */  sll        $v0, $v1, 4
    /* 9F7A0 800AEFA0 23104300 */  subu       $v0, $v0, $v1
    /* 9F7A4 800AEFA4 80100200 */  sll        $v0, $v0, 2
    /* 9F7A8 800AEFA8 21104400 */  addu       $v0, $v0, $a0
    /* 9F7AC 800AEFAC E0034294 */  lhu        $v0, 0x3E0($v0)
    /* 9F7B0 800AEFB0 8802858E */  lw         $a1, 0x288($s4)
    /* 9F7B4 800AEFB4 0F004230 */  andi       $v0, $v0, 0xF
    /* 9F7B8 800AEFB8 400882A6 */  sh         $v0, 0x840($s4)
    /* 9F7BC 800AEFBC 4000A490 */  lbu        $a0, 0x40($a1)
    /* 9F7C0 800AEFC0 3C00A390 */  lbu        $v1, 0x3C($a1)
    /* 9F7C4 800AEFC4 4400A290 */  lbu        $v0, 0x44($a1)
    /* 9F7C8 800AEFC8 40200400 */  sll        $a0, $a0, 1
    /* 9F7CC 800AEFCC 21186400 */  addu       $v1, $v1, $a0
    /* 9F7D0 800AEFD0 80100200 */  sll        $v0, $v0, 2
    /* 9F7D4 800AEFD4 21186200 */  addu       $v1, $v1, $v0
    /* 9F7D8 800AEFD8 F0FFA226 */  addiu      $v0, $s5, -0x10
    /* 9F7DC 800AEFDC 0300422C */  sltiu      $v0, $v0, 0x3
    /* 9F7E0 800AEFE0 03004010 */  beqz       $v0, .L800AEFF0
    /* 9F7E4 800AEFE4 B30883A2 */   sb        $v1, 0x8B3($s4)
    /* 9F7E8 800AEFE8 07000224 */  addiu      $v0, $zero, 0x7
    /* 9F7EC 800AEFEC B30882A2 */  sb         $v0, 0x8B3($s4)
  .L800AEFF0:
    /* 9F7F0 800AEFF0 1C00A22A */  slti       $v0, $s5, 0x1C
  .L800AEFF4:
    /* 9F7F4 800AEFF4 C00880A6 */  sh         $zero, 0x8C0($s4)
    /* 9F7F8 800AEFF8 1F004010 */  beqz       $v0, .L800AF078
    /* 9F7FC 800AEFFC B20880A2 */   sb        $zero, 0x8B2($s4)
    /* 9F800 800AF000 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9F804 800AF004 00000000 */  nop
    /* 9F808 800AF008 03004010 */  beqz       $v0, .L800AF018
    /* 9F80C 800AF00C 01000224 */   addiu     $v0, $zero, 0x1
    /* 9F810 800AF010 1EBC0208 */  j          .L800AF078
    /* 9F814 800AF014 C00882A6 */   sh        $v0, 0x8C0($s4)
  .L800AF018:
    /* 9F818 800AF018 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 9F81C 800AF01C F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* 9F820 800AF020 01000424 */  addiu      $a0, $zero, 0x1
    /* 9F824 800AF024 13004410 */  beq        $v0, $a0, .L800AF074
    /* 9F828 800AF028 00000000 */   nop
    /* 9F82C 800AF02C 6002828E */  lw         $v0, 0x260($s4)
    /* 9F830 800AF030 00000000 */  nop
    /* 9F834 800AF034 04004230 */  andi       $v0, $v0, 0x4
    /* 9F838 800AF038 0A004014 */  bnez       $v0, .L800AF064
    /* 9F83C 800AF03C 00000000 */   nop
    /* 9F840 800AF040 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 9F844 800AF044 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 9F848 800AF048 1480033C */  lui        $v1, %hi(Cars_gNumTrafficCars)
    /* 9F84C 800AF04C 08C8638C */  lw         $v1, %lo(Cars_gNumTrafficCars)($v1)
    /* 9F850 800AF050 00000000 */  nop
    /* 9F854 800AF054 23104300 */  subu       $v0, $v0, $v1
    /* 9F858 800AF058 03004228 */  slti       $v0, $v0, 0x3
    /* 9F85C 800AF05C 03004010 */  beqz       $v0, .L800AF06C
    /* 9F860 800AF060 00000000 */   nop
  .L800AF064:
    /* 9F864 800AF064 1EBC0208 */  j          .L800AF078
    /* 9F868 800AF068 C00884A6 */   sh        $a0, 0x8C0($s4)
  .L800AF06C:
    /* 9F86C 800AF06C 1EBC0208 */  j          .L800AF078
    /* 9F870 800AF070 B20884A2 */   sb        $a0, 0x8B2($s4)
  .L800AF074:
    /* 9F874 800AF074 B20882A2 */  sb         $v0, 0x8B2($s4)
  .L800AF078:
    /* 9F878 800AF078 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9F87C 800AF07C B40880A6 */  sh         $zero, 0x8B4($s4)
    /* 9F880 800AF080 0A004014 */  bnez       $v0, .L800AF0AC
    /* 9F884 800AF084 B60880A6 */   sh        $zero, 0x8B6($s4)
    /* 9F888 800AF088 1180023C */  lui        $v0, %hi(D_80113240)
    /* 9F88C 800AF08C 4032428C */  lw         $v0, %lo(D_80113240)($v0)
    /* 9F890 800AF090 00000000 */  nop
    /* 9F894 800AF094 07004010 */  beqz       $v0, .L800AF0B4
    /* 9F898 800AF098 33000224 */   addiu     $v0, $zero, 0x33
    /* 9F89C 800AF09C B40882A6 */  sh         $v0, 0x8B4($s4)
    /* 9F8A0 800AF0A0 02000224 */  addiu      $v0, $zero, 0x2
    /* 9F8A4 800AF0A4 2DBC0208 */  j          .L800AF0B4
    /* 9F8A8 800AF0A8 B60882A6 */   sh        $v0, 0x8B6($s4)
  .L800AF0AC:
    /* 9F8AC 800AF0AC 33000224 */  addiu      $v0, $zero, 0x33
    /* 9F8B0 800AF0B0 B40882A6 */  sh         $v0, 0x8B4($s4)
  .L800AF0B4:
    /* 9F8B4 800AF0B4 8802828E */  lw         $v0, 0x288($s4)
    /* 9F8B8 800AF0B8 BE0895A6 */  sh         $s5, 0x8BE($s4)
    /* 9F8BC 800AF0BC BC0895A6 */  sh         $s5, 0x8BC($s4)
    /* 9F8C0 800AF0C0 840880AE */  sw         $zero, 0x884($s4)
    /* 9F8C4 800AF0C4 A0004290 */  lbu        $v0, 0xA0($v0)
    /* 9F8C8 800AF0C8 00000000 */  nop
    /* 9F8CC 800AF0CC 420882A2 */  sb         $v0, 0x842($s4)
    /* 9F8D0 800AF0D0 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9F8D4 800AF0D4 00000000 */  nop
    /* 9F8D8 800AF0D8 84014014 */  bnez       $v0, .L800AF6EC
    /* 9F8DC 800AF0DC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 9F8E0 800AF0E0 8802828E */  lw         $v0, 0x288($s4)
    /* 9F8E4 800AF0E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9F8E8 800AF0E8 A000468C */  lw         $a2, 0xA0($v0)
    /* 9F8EC 800AF0EC A6BB020C */  jal        R3DCar_GetCarName__FPcii
    /* 9F8F0 800AF0F0 2128A002 */   addu      $a1, $s5, $zero
    /* 9F8F4 800AF0F4 1180023C */  lui        $v0, %hi(D_801164C8)
    /* 9F8F8 800AF0F8 3000B027 */  addiu      $s0, $sp, 0x30
    /* 9F8FC 800AF0FC C864458C */  lw         $a1, %lo(D_801164C8)($v0)
    /* 9F900 800AF100 CA96030C */  jal        strcpy
    /* 9F904 800AF104 21200002 */   addu      $a0, $s0, $zero
    /* 9F908 800AF108 21200002 */  addu       $a0, $s0, $zero
    /* 9F90C 800AF10C 3A9E030C */  jal        strcat
    /* 9F910 800AF110 1000A527 */   addiu     $a1, $sp, 0x10
    /* 9F914 800AF114 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* 9F918 800AF118 00000000 */  nop
    /* 9F91C 800AF11C 01004230 */  andi       $v0, $v0, 0x1
    /* 9F920 800AF120 04004010 */  beqz       $v0, .L800AF134
    /* 9F924 800AF124 21200002 */   addu      $a0, $s0, $zero
    /* 9F928 800AF128 1480053C */  lui        $a1, %hi(D_8013D358)
    /* 9F92C 800AF12C 56BC0208 */  j          .L800AF158
    /* 9F930 800AF130 58D3A524 */   addiu     $a1, $a1, %lo(D_8013D358)
  .L800AF134:
    /* 9F934 800AF134 B2088292 */  lbu        $v0, 0x8B2($s4)
    /* 9F938 800AF138 00000000 */  nop
    /* 9F93C 800AF13C 08004010 */  beqz       $v0, .L800AF160
    /* 9F940 800AF140 1C00A22A */   slti      $v0, $s5, 0x1C
    /* 9F944 800AF144 06004010 */  beqz       $v0, .L800AF160
    /* 9F948 800AF148 00000000 */   nop
    /* 9F94C 800AF14C 21200002 */  addu       $a0, $s0, $zero
    /* 9F950 800AF150 1480053C */  lui        $a1, %hi(D_8013D35C)
    /* 9F954 800AF154 5CD3A524 */  addiu      $a1, $a1, %lo(D_8013D35C)
  .L800AF158:
    /* 9F958 800AF158 3A9E030C */  jal        strcat
    /* 9F95C 800AF15C 00000000 */   nop
  .L800AF160:
    /* 9F960 800AF160 3000B027 */  addiu      $s0, $sp, 0x30
    /* 9F964 800AF164 21200002 */  addu       $a0, $s0, $zero
    /* 9F968 800AF168 1480053C */  lui        $a1, %hi(D_8013D360)
    /* 9F96C 800AF16C 3A9E030C */  jal        strcat
    /* 9F970 800AF170 60D3A524 */   addiu     $a1, $a1, %lo(D_8013D360)
    /* 9F974 800AF174 94BB020C */  jal        R3DCar_LoadFileAdr__FPc
    /* 9F978 800AF178 21200002 */   addu      $a0, $s0, $zero
    /* 9F97C 800AF17C 2000B027 */  addiu      $s0, $sp, 0x20
    /* 9F980 800AF180 21200002 */  addu       $a0, $s0, $zero
    /* 9F984 800AF184 640E82AF */  sw         $v0, %gp_rel(R3DCar_BigFile)($gp)
    /* 9F988 800AF188 CA96030C */  jal        strcpy
    /* 9F98C 800AF18C 1000A527 */   addiu     $a1, $sp, 0x10
    /* 9F990 800AF190 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* 9F994 800AF194 00000000 */  nop
    /* 9F998 800AF198 01004230 */  andi       $v0, $v0, 0x1
    /* 9F99C 800AF19C 04004010 */  beqz       $v0, .L800AF1B0
    /* 9F9A0 800AF1A0 21200002 */   addu      $a0, $s0, $zero
    /* 9F9A4 800AF1A4 1480053C */  lui        $a1, %hi(D_8013D358)
    /* 9F9A8 800AF1A8 74BC0208 */  j          .L800AF1D0
    /* 9F9AC 800AF1AC 58D3A524 */   addiu     $a1, $a1, %lo(D_8013D358)
  .L800AF1B0:
    /* 9F9B0 800AF1B0 B2088292 */  lbu        $v0, 0x8B2($s4)
    /* 9F9B4 800AF1B4 00000000 */  nop
    /* 9F9B8 800AF1B8 07004010 */  beqz       $v0, .L800AF1D8
    /* 9F9BC 800AF1BC 1C00A22A */   slti      $v0, $s5, 0x1C
    /* 9F9C0 800AF1C0 05004010 */  beqz       $v0, .L800AF1D8
    /* 9F9C4 800AF1C4 21200002 */   addu      $a0, $s0, $zero
    /* 9F9C8 800AF1C8 1480053C */  lui        $a1, %hi(D_8013D35C)
    /* 9F9CC 800AF1CC 5CD3A524 */  addiu      $a1, $a1, %lo(D_8013D35C)
  .L800AF1D0:
    /* 9F9D0 800AF1D0 3A9E030C */  jal        strcat
    /* 9F9D4 800AF1D4 00000000 */   nop
  .L800AF1D8:
    /* 9F9D8 800AF1D8 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* 9F9DC 800AF1DC 08694224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedScenePointer)
    /* 9F9E0 800AF1E0 80381500 */  sll        $a3, $s5, 2
    /* 9F9E4 800AF1E4 2188E200 */  addu       $s1, $a3, $v0
    /* 9F9E8 800AF1E8 0000228E */  lw         $v0, 0x0($s1)
    /* 9F9EC 800AF1EC 00000000 */  nop
    /* 9F9F0 800AF1F0 22004014 */  bnez       $v0, .L800AF27C
    /* 9F9F4 800AF1F4 1180023C */   lui       $v0, %hi(R3DCar_LoadedSceneCountry)
    /* 9F9F8 800AF1F8 2000A427 */  addiu      $a0, $sp, 0x20
    /* 9F9FC 800AF1FC 40089096 */  lhu        $s0, 0x840($s4)
    /* 9FA00 800AF200 21288002 */  addu       $a1, $s4, $zero
    /* 9FA04 800AF204 2AB8020C */  jal        R3DCar_ReadInCarData__FPcP8Car_tObj
    /* 9FA08 800AF208 00841000 */   sll       $s0, $s0, 16
    /* 9FA0C 800AF20C 1180033C */  lui        $v1, %hi(R3DCar_LoadedSceneCounter)
    /* 9FA10 800AF210 986A6324 */  addiu      $v1, $v1, %lo(R3DCar_LoadedSceneCounter)
    /* 9FA14 800AF214 2118A302 */  addu       $v1, $s5, $v1
    /* 9FA18 800AF218 21B00000 */  addu       $s6, $zero, $zero
    /* 9FA1C 800AF21C 032C1000 */  sra        $a1, $s0, 16
    /* 9FA20 800AF220 1180043C */  lui        $a0, %hi(R3DCar_LoadedSceneColor)
    /* 9FA24 800AF224 306B8424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedSceneColor)
    /* 9FA28 800AF228 C3841000 */  sra        $s0, $s0, 19
    /* 9FA2C 800AF22C 000022AE */  sw         $v0, 0x0($s1)
    /* 9FA30 800AF230 00006290 */  lbu        $v0, 0x0($v1)
    /* 9FA34 800AF234 0800A530 */  andi       $a1, $a1, 0x8
    /* 9FA38 800AF238 01004224 */  addiu      $v0, $v0, 0x1
    /* 9FA3C 800AF23C 000062A0 */  sb         $v0, 0x0($v1)
    /* 9FA40 800AF240 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneCountry)
    /* 9FA44 800AF244 FC6A4224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedSceneCountry)
    /* 9FA48 800AF248 42088392 */  lbu        $v1, 0x842($s4)
    /* 9FA4C 800AF24C 2110A202 */  addu       $v0, $s5, $v0
    /* 9FA50 800AF250 000043A0 */  sb         $v1, 0x0($v0)
    /* 9FA54 800AF254 40181500 */  sll        $v1, $s5, 1
    /* 9FA58 800AF258 40101000 */  sll        $v0, $s0, 1
    /* 9FA5C 800AF25C 21105000 */  addu       $v0, $v0, $s0
    /* 9FA60 800AF260 C0100200 */  sll        $v0, $v0, 3
    /* 9FA64 800AF264 21105000 */  addu       $v0, $v0, $s0
    /* 9FA68 800AF268 80100200 */  sll        $v0, $v0, 2
    /* 9FA6C 800AF26C 21186200 */  addu       $v1, $v1, $v0
    /* 9FA70 800AF270 21186400 */  addu       $v1, $v1, $a0
    /* 9FA74 800AF274 D7BC0208 */  j          .L800AF35C
    /* 9FA78 800AF278 000065A4 */   sh        $a1, 0x0($v1)
  .L800AF27C:
    /* 9FA7C 800AF27C FC6A4224 */  addiu      $v0, $v0, %lo(R3DCar_LoadedSceneCountry)
    /* 9FA80 800AF280 2110A202 */  addu       $v0, $s5, $v0
    /* 9FA84 800AF284 00004280 */  lb         $v0, 0x0($v0)
    /* 9FA88 800AF288 42088392 */  lbu        $v1, 0x842($s4)
    /* 9FA8C 800AF28C 00000000 */  nop
    /* 9FA90 800AF290 0E004310 */  beq        $v0, $v1, .L800AF2CC
    /* 9FA94 800AF294 2000A427 */   addiu     $a0, $sp, 0x20
    /* 9FA98 800AF298 21288002 */  addu       $a1, $s4, $zero
    /* 9FA9C 800AF29C 80006234 */  ori        $v0, $v1, 0x80
    /* 9FAA0 800AF2A0 2AB8020C */  jal        R3DCar_ReadInCarData__FPcP8Car_tObj
    /* 9FAA4 800AF2A4 420882A2 */   sb        $v0, 0x842($s4)
    /* 9FAA8 800AF2A8 1180033C */  lui        $v1, %hi(R3DCar_LoadedSceneCounter)
    /* 9FAAC 800AF2AC 986A6324 */  addiu      $v1, $v1, %lo(R3DCar_LoadedSceneCounter)
    /* 9FAB0 800AF2B0 2118A302 */  addu       $v1, $s5, $v1
    /* 9FAB4 800AF2B4 C80022AE */  sw         $v0, 0xC8($s1)
    /* 9FAB8 800AF2B8 32006290 */  lbu        $v0, 0x32($v1)
    /* 9FABC 800AF2BC 21B00000 */  addu       $s6, $zero, $zero
    /* 9FAC0 800AF2C0 01004224 */  addiu      $v0, $v0, 0x1
    /* 9FAC4 800AF2C4 D7BC0208 */  j          .L800AF35C
    /* 9FAC8 800AF2C8 320062A0 */   sb        $v0, 0x32($v1)
  .L800AF2CC:
    /* 9FACC 800AF2CC 1180033C */  lui        $v1, %hi(R3DCar_LoadedSceneCounter)
    /* 9FAD0 800AF2D0 986A6324 */  addiu      $v1, $v1, %lo(R3DCar_LoadedSceneCounter)
    /* 9FAD4 800AF2D4 2118A302 */  addu       $v1, $s5, $v1
    /* 9FAD8 800AF2D8 1180043C */  lui        $a0, %hi(R3DCar_LoadedSceneColor)
    /* 9FADC 800AF2DC 306B8424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedSceneColor)
    /* 9FAE0 800AF2E0 00006290 */  lbu        $v0, 0x0($v1)
    /* 9FAE4 800AF2E4 40088596 */  lhu        $a1, 0x840($s4)
    /* 9FAE8 800AF2E8 01004224 */  addiu      $v0, $v0, 0x1
    /* 9FAEC 800AF2EC 000062A0 */  sb         $v0, 0x0($v1)
    /* 9FAF0 800AF2F0 00140500 */  sll        $v0, $a1, 16
    /* 9FAF4 800AF2F4 C3340200 */  sra        $a2, $v0, 19
    /* 9FAF8 800AF2F8 40181500 */  sll        $v1, $s5, 1
    /* 9FAFC 800AF2FC 40100600 */  sll        $v0, $a2, 1
    /* 9FB00 800AF300 21104600 */  addu       $v0, $v0, $a2
    /* 9FB04 800AF304 C0100200 */  sll        $v0, $v0, 3
    /* 9FB08 800AF308 21304600 */  addu       $a2, $v0, $a2
    /* 9FB0C 800AF30C 80100600 */  sll        $v0, $a2, 2
    /* 9FB10 800AF310 21186200 */  addu       $v1, $v1, $v0
    /* 9FB14 800AF314 21186400 */  addu       $v1, $v1, $a0
    /* 9FB18 800AF318 00006284 */  lh         $v0, 0x0($v1)
    /* 9FB1C 800AF31C 0800A530 */  andi       $a1, $a1, 0x8
    /* 9FB20 800AF320 0D004514 */  bne        $v0, $a1, .L800AF358
    /* 9FB24 800AF324 21B00000 */   addu      $s6, $zero, $zero
    /* 9FB28 800AF328 1180033C */  lui        $v1, %hi(R3DCar_LoadedSceneVRam)
    /* 9FB2C 800AF32C F86B6324 */  addiu      $v1, $v1, %lo(R3DCar_LoadedSceneVRam)
    /* 9FB30 800AF330 C0100600 */  sll        $v0, $a2, 3
    /* 9FB34 800AF334 2110E200 */  addu       $v0, $a3, $v0
    /* 9FB38 800AF338 21104300 */  addu       $v0, $v0, $v1
    /* 9FB3C 800AF33C 00004394 */  lhu        $v1, 0x0($v0)
    /* 9FB40 800AF340 00000000 */  nop
    /* 9FB44 800AF344 C40883A6 */  sh         $v1, 0x8C4($s4)
    /* 9FB48 800AF348 02004294 */  lhu        $v0, 0x2($v0)
    /* 9FB4C 800AF34C 01001624 */  addiu      $s6, $zero, 0x1
    /* 9FB50 800AF350 D7BC0208 */  j          .L800AF35C
    /* 9FB54 800AF354 C60882A6 */   sh        $v0, 0x8C6($s4)
  .L800AF358:
    /* 9FB58 800AF358 000065A4 */  sh         $a1, 0x0($v1)
  .L800AF35C:
    /* 9FB5C 800AF35C 21208002 */  addu       $a0, $s4, $zero
    /* 9FB60 800AF360 1180063C */  lui        $a2, %hi(R3DCar_LoadedScenePointer)
    /* 9FB64 800AF364 0869C624 */  addiu      $a2, $a2, %lo(R3DCar_LoadedScenePointer)
    /* 9FB68 800AF368 42088392 */  lbu        $v1, 0x842($s4)
    /* 9FB6C 800AF36C 80281500 */  sll        $a1, $s5, 2
    /* 9FB70 800AF370 C2190300 */  srl        $v1, $v1, 7
    /* 9FB74 800AF374 40100300 */  sll        $v0, $v1, 1
    /* 9FB78 800AF378 21104300 */  addu       $v0, $v0, $v1
    /* 9FB7C 800AF37C C0100200 */  sll        $v0, $v0, 3
    /* 9FB80 800AF380 21104300 */  addu       $v0, $v0, $v1
    /* 9FB84 800AF384 C0100200 */  sll        $v0, $v0, 3
    /* 9FB88 800AF388 2128A200 */  addu       $a1, $a1, $v0
    /* 9FB8C 800AF38C 2128A600 */  addu       $a1, $a1, $a2
    /* 9FB90 800AF390 0000A58C */  lw         $a1, 0x0($a1)
    /* 9FB94 800AF394 D4B9020C */  jal        R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei
    /* 9FB98 800AF398 2130A002 */   addu      $a2, $s5, $zero
    /* 9FB9C 800AF39C 8802828E */  lw         $v0, 0x288($s4)
    /* 9FBA0 800AF3A0 00000000 */  nop
    /* 9FBA4 800AF3A4 1400428C */  lw         $v0, 0x14($v0)
    /* 9FBA8 800AF3A8 00000000 */  nop
    /* 9FBAC 800AF3AC 06004010 */  beqz       $v0, .L800AF3C8
    /* 9FBB0 800AF3B0 1480043C */   lui       $a0, %hi(D_8013D368)
    /* 9FBB4 800AF3B4 68D38424 */  addiu      $a0, $a0, %lo(D_8013D368)
    /* 9FBB8 800AF3B8 A0280524 */  addiu      $a1, $zero, 0x28A0
    /* 9FBBC 800AF3BC CF94030C */  jal        reservememadr
    /* 9FBC0 800AF3C0 21300000 */   addu      $a2, $zero, $zero
    /* 9FBC4 800AF3C4 840882AE */  sw         $v0, 0x884($s4)
  .L800AF3C8:
    /* 9FBC8 800AF3C8 1480013C */  lui        $at, %hi(Texture_palNum)
    /* 9FBCC 800AF3CC 10DB20AC */  sw         $zero, %lo(Texture_palNum)($at)
    /* 9FBD0 800AF3D0 1C00A22A */  slti       $v0, $s5, 0x1C
    /* 9FBD4 800AF3D4 8C004010 */  beqz       $v0, .L800AF608
    /* 9FBD8 800AF3D8 21980000 */   addu      $s3, $zero, $zero
    /* 9FBDC 800AF3DC C0088296 */  lhu        $v0, 0x8C0($s4)
    /* 9FBE0 800AF3E0 00000000 */  nop
    /* 9FBE4 800AF3E4 01004230 */  andi       $v0, $v0, 0x1
    /* 9FBE8 800AF3E8 06004010 */  beqz       $v0, .L800AF404
    /* 9FBEC 800AF3EC 40B81600 */   sll       $s7, $s6, 1
    /* 9FBF0 800AF3F0 9800A427 */  addiu      $a0, $sp, 0x98
    /* 9FBF4 800AF3F4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FBF8 800AF3F8 1480063C */  lui        $a2, %hi(D_8013D358)
    /* 9FBFC 800AF3FC 05BD0208 */  j          .L800AF414
    /* 9FC00 800AF400 58D3C624 */   addiu     $a2, $a2, %lo(D_8013D358)
  .L800AF404:
    /* 9FC04 800AF404 9800A427 */  addiu      $a0, $sp, 0x98
    /* 9FC08 800AF408 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FC0C 800AF40C 1480063C */  lui        $a2, %hi(D_8013D370)
    /* 9FC10 800AF410 70D3C624 */  addiu      $a2, $a2, %lo(D_8013D370)
  .L800AF414:
    /* 9FC14 800AF414 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* 9FC18 800AF418 01007326 */   addiu     $s3, $s3, 0x1
    /* 9FC1C 800AF41C C0088296 */  lhu        $v0, 0x8C0($s4)
    /* 9FC20 800AF420 00000000 */  nop
    /* 9FC24 800AF424 01004230 */  andi       $v0, $v0, 0x1
    /* 9FC28 800AF428 09004010 */  beqz       $v0, .L800AF450
    /* 9FC2C 800AF42C 9800A427 */   addiu     $a0, $sp, 0x98
    /* 9FC30 800AF430 00111300 */  sll        $v0, $s3, 4
    /* 9FC34 800AF434 23105300 */  subu       $v0, $v0, $s3
    /* 9FC38 800AF438 21208200 */  addu       $a0, $a0, $v0
    /* 9FC3C 800AF43C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FC40 800AF440 1480063C */  lui        $a2, %hi(D_8013D374)
    /* 9FC44 800AF444 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* 9FC48 800AF448 74D3C624 */   addiu     $a2, $a2, %lo(D_8013D374)
    /* 9FC4C 800AF44C 01007326 */  addiu      $s3, $s3, 0x1
  .L800AF450:
    /* 9FC50 800AF450 40088286 */  lh         $v0, 0x840($s4)
    /* 9FC54 800AF454 00000000 */  nop
    /* 9FC58 800AF458 08004228 */  slti       $v0, $v0, 0x8
    /* 9FC5C 800AF45C 08004014 */  bnez       $v0, .L800AF480
    /* 9FC60 800AF460 9800A427 */   addiu     $a0, $sp, 0x98
    /* 9FC64 800AF464 00111300 */  sll        $v0, $s3, 4
    /* 9FC68 800AF468 23105300 */  subu       $v0, $v0, $s3
    /* 9FC6C 800AF46C 21208200 */  addu       $a0, $a0, $v0
    /* 9FC70 800AF470 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FC74 800AF474 1480063C */  lui        $a2, %hi(D_8013D378)
    /* 9FC78 800AF478 26BD0208 */  j          .L800AF498
    /* 9FC7C 800AF47C 78D3C624 */   addiu     $a2, $a2, %lo(D_8013D378)
  .L800AF480:
    /* 9FC80 800AF480 00111300 */  sll        $v0, $s3, 4
    /* 9FC84 800AF484 23105300 */  subu       $v0, $v0, $s3
    /* 9FC88 800AF488 21208200 */  addu       $a0, $a0, $v0
    /* 9FC8C 800AF48C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FC90 800AF490 1480063C */  lui        $a2, %hi(D_8013D37C)
    /* 9FC94 800AF494 7CD3C624 */  addiu      $a2, $a2, %lo(D_8013D37C)
  .L800AF498:
    /* 9FC98 800AF498 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* 9FC9C 800AF49C 01007326 */   addiu     $s3, $s3, 0x1
    /* 9FCA0 800AF4A0 9800B127 */  addiu      $s1, $sp, 0x98
    /* 9FCA4 800AF4A4 00211300 */  sll        $a0, $s3, 4
    /* 9FCA8 800AF4A8 23209300 */  subu       $a0, $a0, $s3
    /* 9FCAC 800AF4AC 21202402 */  addu       $a0, $s1, $a0
    /* 9FCB0 800AF4B0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9FCB4 800AF4B4 1480063C */  lui        $a2, %hi(D_8013D380)
    /* 9FCB8 800AF4B8 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* 9FCBC 800AF4BC 80D3C624 */   addiu     $a2, $a2, %lo(D_8013D380)
    /* 9FCC0 800AF4C0 01007326 */  addiu      $s3, $s3, 0x1
    /* 9FCC4 800AF4C4 0B00601A */  blez       $s3, .L800AF4F4
    /* 9FCC8 800AF4C8 21800000 */   addu      $s0, $zero, $zero
    /* 9FCCC 800AF4CC D800B227 */  addiu      $s2, $sp, 0xD8
  .L800AF4D0:
    /* 9FCD0 800AF4D0 21282002 */  addu       $a1, $s1, $zero
    /* 9FCD4 800AF4D4 0F003126 */  addiu      $s1, $s1, 0xF
    /* 9FCD8 800AF4D8 640E848F */  lw         $a0, %gp_rel(R3DCar_BigFile)($gp)
    /* 9FCDC 800AF4DC 8698030C */  jal        locatebig
    /* 9FCE0 800AF4E0 01001026 */   addiu     $s0, $s0, 0x1
    /* 9FCE4 800AF4E4 000042AE */  sw         $v0, 0x0($s2)
    /* 9FCE8 800AF4E8 2A101302 */  slt        $v0, $s0, $s3
    /* 9FCEC 800AF4EC F8FF4014 */  bnez       $v0, .L800AF4D0
    /* 9FCF0 800AF4F0 04005226 */   addiu     $s2, $s2, 0x4
  .L800AF4F4:
    /* 9FCF4 800AF4F4 2128A002 */  addu       $a1, $s5, $zero
    /* 9FCF8 800AF4F8 21300000 */  addu       $a2, $zero, $zero
    /* 9FCFC 800AF4FC 8802848E */  lw         $a0, 0x288($s4)
    /* 9FD00 800AF500 01001324 */  addiu      $s3, $zero, 0x1
    /* 9FD04 800AF504 CA0880A6 */  sh         $zero, 0x8CA($s4)
    /* 9FD08 800AF508 C80880A6 */  sh         $zero, 0x8C8($s4)
    /* 9FD0C 800AF50C 97F0020C */  jal        CarIO_CreateLicense__FPcii
    /* 9FD10 800AF510 68008424 */   addiu     $a0, $a0, 0x68
    /* 9FD14 800AF514 21288002 */  addu       $a1, $s4, $zero
    /* 9FD18 800AF518 2530D702 */  or         $a2, $s6, $s7
    /* 9FD1C 800AF51C D800A48F */  lw         $a0, 0xD8($sp)
    /* 9FD20 800AF520 40088396 */  lhu        $v1, 0x840($s4)
    /* 9FD24 800AF524 B3088292 */  lbu        $v0, 0x8B3($s4)
    /* 9FD28 800AF528 07006330 */  andi       $v1, $v1, 0x7
    /* 9FD2C 800AF52C 02004230 */  andi       $v0, $v0, 0x2
    /* 9FD30 800AF530 80100200 */  sll        $v0, $v0, 2
    /* 9FD34 800AF534 21186200 */  addu       $v1, $v1, $v0
    /* 9FD38 800AF538 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9FD3C 800AF53C 08DB23AC */  sw         $v1, %lo(Texture_CarColor)($at)
    /* 9FD40 800AF540 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* 9FD44 800AF544 21380000 */   addu      $a3, $zero, $zero
    /* 9FD48 800AF548 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* 9FD4C 800AF54C 00000000 */  nop
    /* 9FD50 800AF550 24105300 */  and        $v0, $v0, $s3
    /* 9FD54 800AF554 07004010 */  beqz       $v0, .L800AF574
    /* 9FD58 800AF558 D800B027 */   addiu     $s0, $sp, 0xD8
    /* 9FD5C 800AF55C DC00A48F */  lw         $a0, 0xDC($sp)
    /* 9FD60 800AF560 21288002 */  addu       $a1, $s4, $zero
    /* 9FD64 800AF564 19000624 */  addiu      $a2, $zero, 0x19
    /* 9FD68 800AF568 21380000 */  addu       $a3, $zero, $zero
    /* 9FD6C 800AF56C C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* 9FD70 800AF570 02001324 */   addiu     $s3, $zero, 0x2
  .L800AF574:
    /* 9FD74 800AF574 21288002 */  addu       $a1, $s4, $zero
    /* 9FD78 800AF578 9100E636 */  ori        $a2, $s7, 0x91
    /* 9FD7C 800AF57C 21380000 */  addu       $a3, $zero, $zero
    /* 9FD80 800AF580 80101300 */  sll        $v0, $s3, 2
    /* 9FD84 800AF584 21100202 */  addu       $v0, $s0, $v0
    /* 9FD88 800AF588 0000448C */  lw         $a0, 0x0($v0)
    /* 9FD8C 800AF58C 40088396 */  lhu        $v1, 0x840($s4)
    /* 9FD90 800AF590 B3088292 */  lbu        $v0, 0x8B3($s4)
    /* 9FD94 800AF594 07006330 */  andi       $v1, $v1, 0x7
    /* 9FD98 800AF598 01004230 */  andi       $v0, $v0, 0x1
    /* 9FD9C 800AF59C C0100200 */  sll        $v0, $v0, 3
    /* 9FDA0 800AF5A0 21186200 */  addu       $v1, $v1, $v0
    /* 9FDA4 800AF5A4 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9FDA8 800AF5A8 08DB23AC */  sw         $v1, %lo(Texture_CarColor)($at)
    /* 9FDAC 800AF5AC C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* 9FDB0 800AF5B0 01007326 */   addiu     $s3, $s3, 0x1
    /* 9FDB4 800AF5B4 7CF1020C */  jal        CarIO_CleanUpLicense__Fi
    /* 9FDB8 800AF5B8 21200000 */   addu      $a0, $zero, $zero
    /* 9FDBC 800AF5BC 21288002 */  addu       $a1, $s4, $zero
    /* 9FDC0 800AF5C0 1480023C */  lui        $v0, %hi(Texture_palNum)
    /* 9FDC4 800AF5C4 10DB4294 */  lhu        $v0, %lo(Texture_palNum)($v0)
    /* 9FDC8 800AF5C8 40088396 */  lhu        $v1, 0x840($s4)
    /* 9FDCC 800AF5CC 880882A6 */  sh         $v0, 0x888($s4)
    /* 9FDD0 800AF5D0 80101300 */  sll        $v0, $s3, 2
    /* 9FDD4 800AF5D4 21100202 */  addu       $v0, $s0, $v0
    /* 9FDD8 800AF5D8 0000448C */  lw         $a0, 0x0($v0)
    /* 9FDDC 800AF5DC B3088292 */  lbu        $v0, 0x8B3($s4)
    /* 9FDE0 800AF5E0 07006330 */  andi       $v1, $v1, 0x7
    /* 9FDE4 800AF5E4 02004230 */  andi       $v0, $v0, 0x2
    /* 9FDE8 800AF5E8 80100200 */  sll        $v0, $v0, 2
    /* 9FDEC 800AF5EC 21186200 */  addu       $v1, $v1, $v0
    /* 9FDF0 800AF5F0 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9FDF4 800AF5F4 08DB23AC */  sw         $v1, %lo(Texture_CarColor)($at)
    /* 9FDF8 800AF5F8 ACF3020C */  jal        CarIO_UpdateCarTextureData__FPcP8Car_tObji
    /* 9FDFC 800AF5FC 21300000 */   addu      $a2, $zero, $zero
    /* 9FE00 800AF600 9BBD0208 */  j          .L800AF66C
    /* 9FE04 800AF604 00000000 */   nop
  .L800AF608:
    /* 9FE08 800AF608 9800B027 */  addiu      $s0, $sp, 0x98
    /* 9FE0C 800AF60C 21200002 */  addu       $a0, $s0, $zero
    /* 9FE10 800AF610 CA96030C */  jal        strcpy
    /* 9FE14 800AF614 2000A527 */   addiu     $a1, $sp, 0x20
    /* 9FE18 800AF618 21200002 */  addu       $a0, $s0, $zero
    /* 9FE1C 800AF61C 1480053C */  lui        $a1, %hi(D_8013D340)
    /* 9FE20 800AF620 3A9E030C */  jal        strcat
    /* 9FE24 800AF624 40D3A524 */   addiu     $a1, $a1, %lo(D_8013D340)
    /* 9FE28 800AF628 640E848F */  lw         $a0, %gp_rel(R3DCar_BigFile)($gp)
    /* 9FE2C 800AF62C 8698030C */  jal        locatebig
    /* 9FE30 800AF630 21280002 */   addu      $a1, $s0, $zero
    /* 9FE34 800AF634 21204000 */  addu       $a0, $v0, $zero
    /* 9FE38 800AF638 21288002 */  addu       $a1, $s4, $zero
    /* 9FE3C 800AF63C 8800C636 */  ori        $a2, $s6, 0x88
    /* 9FE40 800AF640 40088296 */  lhu        $v0, 0x840($s4)
    /* 9FE44 800AF644 00000000 */  nop
    /* 9FE48 800AF648 07004230 */  andi       $v0, $v0, 0x7
    /* 9FE4C 800AF64C 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* 9FE50 800AF650 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
    /* 9FE54 800AF654 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* 9FE58 800AF658 21380000 */   addu      $a3, $zero, $zero
    /* 9FE5C 800AF65C 1480023C */  lui        $v0, %hi(Texture_palNum)
    /* 9FE60 800AF660 10DB4294 */  lhu        $v0, %lo(Texture_palNum)($v0)
    /* 9FE64 800AF664 00000000 */  nop
    /* 9FE68 800AF668 880882A6 */  sh         $v0, 0x888($s4)
  .L800AF66C:
    /* 9FE6C 800AF66C 1200C016 */  bnez       $s6, .L800AF6B8
    /* 9FE70 800AF670 1180053C */   lui       $a1, %hi(R3DCar_LoadedSceneVRam)
    /* 9FE74 800AF674 F86BA524 */  addiu      $a1, $a1, %lo(R3DCar_LoadedSceneVRam)
    /* 9FE78 800AF678 40088396 */  lhu        $v1, 0x840($s4)
    /* 9FE7C 800AF67C 80201500 */  sll        $a0, $s5, 2
    /* 9FE80 800AF680 001C0300 */  sll        $v1, $v1, 16
    /* 9FE84 800AF684 C31C0300 */  sra        $v1, $v1, 19
    /* 9FE88 800AF688 40100300 */  sll        $v0, $v1, 1
    /* 9FE8C 800AF68C 21104300 */  addu       $v0, $v0, $v1
    /* 9FE90 800AF690 C0100200 */  sll        $v0, $v0, 3
    /* 9FE94 800AF694 21104300 */  addu       $v0, $v0, $v1
    /* 9FE98 800AF698 C0100200 */  sll        $v0, $v0, 3
    /* 9FE9C 800AF69C 21208200 */  addu       $a0, $a0, $v0
    /* 9FEA0 800AF6A0 C4088296 */  lhu        $v0, 0x8C4($s4)
    /* 9FEA4 800AF6A4 21208500 */  addu       $a0, $a0, $a1
    /* 9FEA8 800AF6A8 000082A4 */  sh         $v0, 0x0($a0)
    /* 9FEAC 800AF6AC C6088296 */  lhu        $v0, 0x8C6($s4)
    /* 9FEB0 800AF6B0 00000000 */  nop
    /* 9FEB4 800AF6B4 020082A4 */  sh         $v0, 0x2($a0)
  .L800AF6B8:
    /* 9FEB8 800AF6B8 8408848E */  lw         $a0, 0x884($s4)
    /* 9FEBC 800AF6BC 00000000 */  nop
    /* 9FEC0 800AF6C0 07008010 */  beqz       $a0, .L800AF6E0
    /* 9FEC4 800AF6C4 00000000 */   nop
    /* 9FEC8 800AF6C8 88088286 */  lh         $v0, 0x888($s4)
    /* 9FECC 800AF6CC 00000000 */  nop
    /* 9FED0 800AF6D0 80290200 */  sll        $a1, $v0, 6
    /* 9FED4 800AF6D4 2128A200 */  addu       $a1, $a1, $v0
    /* 9FED8 800AF6D8 54C6030C */  jal        resizememadr
    /* 9FEDC 800AF6DC C0280500 */   sll       $a1, $a1, 3
  .L800AF6E0:
    /* 9FEE0 800AF6E0 640E80AF */  sw         $zero, %gp_rel(R3DCar_BigFile)($gp)
    /* 9FEE4 800AF6E4 C8BD0208 */  j          .L800AF720
    /* 9FEE8 800AF6E8 00000000 */   nop
  .L800AF6EC:
    /* 9FEEC 800AF6EC C0088396 */  lhu        $v1, 0x8C0($s4)
    /* 9FEF0 800AF6F0 BC0882A6 */  sh         $v0, 0x8BC($s4)
    /* 9FEF4 800AF6F4 BE088296 */  lhu        $v0, 0x8BE($s4)
    /* 9FEF8 800AF6F8 D80880AE */  sw         $zero, 0x8D8($s4)
    /* 9FEFC 800AF6FC 00190300 */  sll        $v1, $v1, 4
    /* 9FF00 800AF700 C00883A6 */  sh         $v1, 0x8C0($s4)
    /* 9FF04 800AF704 42088392 */  lbu        $v1, 0x842($s4)
    /* 9FF08 800AF708 80004234 */  ori        $v0, $v0, 0x80
    /* 9FF0C 800AF70C BE0882A6 */  sh         $v0, 0x8BE($s4)
    /* 9FF10 800AF710 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 9FF14 800AF714 430883A2 */  sb         $v1, 0x843($s4)
    /* 9FF18 800AF718 640E80AF */  sw         $zero, %gp_rel(R3DCar_BigFile)($gp)
    /* 9FF1C 800AF71C 380E82AF */  sw         $v0, %gp_rel(R3DCar_aSyncLoading)($gp)
  .L800AF720:
    /* 9FF20 800AF720 0801BF8F */  lw         $ra, 0x108($sp)
    /* 9FF24 800AF724 0401B78F */  lw         $s7, 0x104($sp)
    /* 9FF28 800AF728 0001B68F */  lw         $s6, 0x100($sp)
    /* 9FF2C 800AF72C FC00B58F */  lw         $s5, 0xFC($sp)
    /* 9FF30 800AF730 F800B48F */  lw         $s4, 0xF8($sp)
    /* 9FF34 800AF734 F400B38F */  lw         $s3, 0xF4($sp)
    /* 9FF38 800AF738 F000B28F */  lw         $s2, 0xF0($sp)
    /* 9FF3C 800AF73C EC00B18F */  lw         $s1, 0xEC($sp)
    /* 9FF40 800AF740 E800B08F */  lw         $s0, 0xE8($sp)
    /* 9FF44 800AF744 0800E003 */  jr         $ra
    /* 9FF48 800AF748 1001BD27 */   addiu     $sp, $sp, 0x110
endlabel R3DCar_Instantiate3DCar__FP8Car_tObji
