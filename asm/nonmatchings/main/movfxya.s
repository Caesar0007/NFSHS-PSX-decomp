.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching movfxya, 0x374

glabel movfxya
    /* E0F38 800F0738 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* E0F3C 800F073C 4000B6AF */  sw         $s6, 0x40($sp)
    /* E0F40 800F0740 21B08000 */  addu       $s6, $a0, $zero
    /* E0F44 800F0744 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* E0F48 800F0748 4800BEAF */  sw         $fp, 0x48($sp)
    /* E0F4C 800F074C 4400B7AF */  sw         $s7, 0x44($sp)
    /* E0F50 800F0750 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* E0F54 800F0754 3800B4AF */  sw         $s4, 0x38($sp)
    /* E0F58 800F0758 3400B3AF */  sw         $s3, 0x34($sp)
    /* E0F5C 800F075C 3000B2AF */  sw         $s2, 0x30($sp)
    /* E0F60 800F0760 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* E0F64 800F0764 2800B0AF */  sw         $s0, 0x28($sp)
    /* E0F68 800F0768 5400A5AF */  sw         $a1, 0x54($sp)
    /* E0F6C 800F076C F9D0030C */  jal        shapedepth
    /* E0F70 800F0770 5800A6AF */   sw        $a2, 0x58($sp)
    /* E0F74 800F0774 0000C392 */  lbu        $v1, 0x0($s6)
    /* E0F78 800F0778 21A84000 */  addu       $s5, $v0, $zero
    /* E0F7C 800F077C 08006230 */  andi       $v0, $v1, 0x8
    /* E0F80 800F0780 AD004010 */  beqz       $v0, .L800F0A38
    /* E0F84 800F0784 03006330 */   andi      $v1, $v1, 0x3
    /* E0F88 800F0788 02000224 */  addiu      $v0, $zero, 0x2
    /* E0F8C 800F078C 0D006214 */  bne        $v1, $v0, .L800F07C4
    /* E0F90 800F0790 00000000 */   nop
    /* E0F94 800F0794 1480023C */  lui        $v0, %hi(semitrans)
    /* E0F98 800F0798 14DD428C */  lw         $v0, %lo(semitrans)($v0)
    /* E0F9C 800F079C 00000000 */  nop
    /* E0FA0 800F07A0 02004230 */  andi       $v0, $v0, 0x2
    /* E0FA4 800F07A4 07004014 */  bnez       $v0, .L800F07C4
    /* E0FA8 800F07A8 00000000 */   nop
    /* E0FAC 800F07AC 5400A58F */  lw         $a1, 0x54($sp)
    /* E0FB0 800F07B0 5800A68F */  lw         $a2, 0x58($sp)
    /* E0FB4 800F07B4 2118040C */  jal        fastmovfxya
    /* E0FB8 800F07B8 2120C002 */   addu      $a0, $s6, $zero
    /* E0FBC 800F07BC 9FC20308 */  j          .L800F0A7C
    /* E0FC0 800F07C0 00000000 */   nop
  .L800F07C4:
    /* E0FC4 800F07C4 0600C286 */  lh         $v0, 0x6($s6)
    /* E0FC8 800F07C8 0600C396 */  lhu        $v1, 0x6($s6)
    /* E0FCC 800F07CC AB004018 */  blez       $v0, .L800F0A7C
    /* E0FD0 800F07D0 21380000 */   addu      $a3, $zero, $zero
  .L800F07D4:
    /* E0FD4 800F07D4 0C00C28E */  lw         $v0, 0xC($s6)
    /* E0FD8 800F07D8 00000000 */  nop
    /* E0FDC 800F07DC 00110200 */  sll        $v0, $v0, 4
    /* E0FE0 800F07E0 03150200 */  sra        $v0, $v0, 20
    /* E0FE4 800F07E4 21204700 */  addu       $a0, $v0, $a3
    /* E0FE8 800F07E8 FF009E30 */  andi       $fp, $a0, 0xFF
    /* E0FEC 800F07EC FF000224 */  addiu      $v0, $zero, 0xFF
    /* E0FF0 800F07F0 23305E00 */  subu       $a2, $v0, $fp
    /* E0FF4 800F07F4 00140300 */  sll        $v0, $v1, 16
    /* E0FF8 800F07F8 03140200 */  sra        $v0, $v0, 16
    /* E0FFC 800F07FC 23184700 */  subu       $v1, $v0, $a3
    /* E1000 800F0800 2A106600 */  slt        $v0, $v1, $a2
    /* E1004 800F0804 02004010 */  beqz       $v0, .L800F0810
    /* E1008 800F0808 00000000 */   nop
    /* E100C 800F080C 21306000 */  addu       $a2, $v1, $zero
  .L800F0810:
    /* E1010 800F0810 0400C286 */  lh         $v0, 0x4($s6)
    /* E1014 800F0814 00000000 */  nop
    /* E1018 800F0818 7F004018 */  blez       $v0, .L800F0A18
    /* E101C 800F081C 21980000 */   addu      $s3, $zero, $zero
    /* E1020 800F0820 00018230 */  andi       $v0, $a0, 0x100
    /* E1024 800F0824 5800A98F */  lw         $t1, 0x58($sp)
    /* E1028 800F0828 03410200 */  sra        $t0, $v0, 4
    /* E102C 800F082C 21B8E900 */  addu       $s7, $a3, $t1
    /* E1030 800F0830 18007502 */  mult       $s3, $s5
  .L800F0834:
    /* E1034 800F0834 0C00C28E */  lw         $v0, 0xC($s6)
    /* E1038 800F0838 00000000 */  nop
    /* E103C 800F083C 00150200 */  sll        $v0, $v0, 20
    /* E1040 800F0840 12200000 */  mflo       $a0
    /* E1044 800F0844 02008104 */  bgez       $a0, .L800F0850
    /* E1048 800F0848 032D0200 */   sra       $a1, $v0, 20
    /* E104C 800F084C 0F008424 */  addiu      $a0, $a0, 0xF
  .L800F0850:
    /* E1050 800F0850 00190500 */  sll        $v1, $a1, 4
    /* E1054 800F0854 1A007500 */  div        $zero, $v1, $s5
    /* E1058 800F0858 0200A016 */  bnez       $s5, .L800F0864
    /* E105C 800F085C 00000000 */   nop
    /* E1060 800F0860 0D000700 */  break      7
  .L800F0864:
    /* E1064 800F0864 FFFF0124 */  addiu      $at, $zero, -0x1
    /* E1068 800F0868 0400A116 */  bne        $s5, $at, .L800F087C
    /* E106C 800F086C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* E1070 800F0870 02006114 */  bne        $v1, $at, .L800F087C
    /* E1074 800F0874 00000000 */   nop
    /* E1078 800F0878 0D000600 */  break      6
  .L800F087C:
    /* E107C 800F087C 12180000 */  mflo       $v1
    /* E1080 800F0880 03110400 */  sra        $v0, $a0, 4
    /* E1084 800F0884 21A0A200 */  addu       $s4, $a1, $v0
    /* E1088 800F0888 C0FF0224 */  addiu      $v0, $zero, -0x40
    /* E108C 800F088C 24108202 */  and        $v0, $s4, $v0
    /* E1090 800F0890 00110200 */  sll        $v0, $v0, 4
    /* E1094 800F0894 1A005500 */  div        $zero, $v0, $s5
    /* E1098 800F0898 0200A016 */  bnez       $s5, .L800F08A4
    /* E109C 800F089C 00000000 */   nop
    /* E10A0 800F08A0 0D000700 */  break      7
  .L800F08A4:
    /* E10A4 800F08A4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* E10A8 800F08A8 0400A116 */  bne        $s5, $at, .L800F08BC
    /* E10AC 800F08AC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* E10B0 800F08B0 02004114 */  bne        $v0, $at, .L800F08BC
    /* E10B4 800F08B4 00000000 */   nop
    /* E10B8 800F08B8 0D000600 */  break      6
  .L800F08BC:
    /* E10BC 800F08BC 12100000 */  mflo       $v0
    /* E10C0 800F08C0 21187300 */  addu       $v1, $v1, $s3
    /* E10C4 800F08C4 23906200 */  subu       $s2, $v1, $v0
    /* E10C8 800F08C8 0400C386 */  lh         $v1, 0x4($s6)
    /* E10CC 800F08CC FF000224 */  addiu      $v0, $zero, 0xFF
    /* E10D0 800F08D0 23885200 */  subu       $s1, $v0, $s2
    /* E10D4 800F08D4 23187300 */  subu       $v1, $v1, $s3
    /* E10D8 800F08D8 2A107100 */  slt        $v0, $v1, $s1
    /* E10DC 800F08DC 02004010 */  beqz       $v0, .L800F08E8
    /* E10E0 800F08E0 00000000 */   nop
    /* E10E4 800F08E4 21886000 */  addu       $s1, $v1, $zero
  .L800F08E8:
    /* E10E8 800F08E8 1480103C */  lui        $s0, %hi(primptr)
    /* E10EC 800F08EC 80DE108E */  lw         $s0, %lo(primptr)($s0)
    /* E10F0 800F08F0 00000000 */  nop
    /* E10F4 800F08F4 28000226 */  addiu      $v0, $s0, 0x28
    /* E10F8 800F08F8 1480013C */  lui        $at, %hi(primptr)
    /* E10FC 800F08FC 80DE22AC */  sw         $v0, %lo(primptr)($at)
    /* E1100 800F0900 09000224 */  addiu      $v0, $zero, 0x9
    /* E1104 800F0904 030002A2 */  sb         $v0, 0x3($s0)
    /* E1108 800F0908 2C000224 */  addiu      $v0, $zero, 0x2C
    /* E110C 800F090C 070002A2 */  sb         $v0, 0x7($s0)
    /* E1110 800F0910 1480023C */  lui        $v0, %hi(semitrans)
    /* E1114 800F0914 14DD4290 */  lbu        $v0, %lo(semitrans)($v0)
    /* E1118 800F0918 2120C002 */  addu       $a0, $s6, $zero
    /* E111C 800F091C 2C004234 */  ori        $v0, $v0, 0x2C
    /* E1120 800F0920 070002A2 */  sb         $v0, 0x7($s0)
    /* E1124 800F0924 1800A6AF */  sw         $a2, 0x18($sp)
    /* E1128 800F0928 1C00A7AF */  sw         $a3, 0x1C($sp)
    /* E112C 800F092C 25DB030C */  jal        shapetoclutid
    /* E1130 800F0930 2000A8AF */   sw        $t0, 0x20($sp)
    /* E1134 800F0934 21282002 */  addu       $a1, $s1, $zero
    /* E1138 800F0938 0E0002A6 */  sh         $v0, 0xE($s0)
    /* E113C 800F093C 0000C392 */  lbu        $v1, 0x0($s6)
    /* E1140 800F0940 21204502 */  addu       $a0, $s2, $a1
    /* E1144 800F0944 0C0012A2 */  sb         $s2, 0xC($s0)
    /* E1148 800F0948 0D001EA2 */  sb         $fp, 0xD($s0)
    /* E114C 800F094C 140004A2 */  sb         $a0, 0x14($s0)
    /* E1150 800F0950 15001EA2 */  sb         $fp, 0x15($s0)
    /* E1154 800F0954 1C0012A2 */  sb         $s2, 0x1C($s0)
    /* E1158 800F0958 1800A68F */  lw         $a2, 0x18($sp)
    /* E115C 800F095C 240004A2 */  sb         $a0, 0x24($s0)
    /* E1160 800F0960 2110C603 */  addu       $v0, $fp, $a2
    /* E1164 800F0964 03006330 */  andi       $v1, $v1, 0x3
    /* E1168 800F0968 C0190300 */  sll        $v1, $v1, 7
    /* E116C 800F096C 1D0002A2 */  sb         $v0, 0x1D($s0)
    /* E1170 800F0970 250002A2 */  sb         $v0, 0x25($s0)
    /* E1174 800F0974 C0038232 */  andi       $v0, $s4, 0x3C0
    /* E1178 800F0978 2000A88F */  lw         $t0, 0x20($sp)
    /* E117C 800F097C 83110200 */  sra        $v0, $v0, 6
    /* E1180 800F0980 25186800 */  or         $v1, $v1, $t0
    /* E1184 800F0984 25186200 */  or         $v1, $v1, $v0
    /* E1188 800F0988 160003A6 */  sh         $v1, 0x16($s0)
    /* E118C 800F098C 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E1190 800F0990 0200A01C */  bgtz       $a1, .L800F099C
    /* E1194 800F0994 2188C000 */   addu      $s1, $a2, $zero
    /* E1198 800F0998 01000524 */  addiu      $a1, $zero, 0x1
  .L800F099C:
    /* E119C 800F099C 0200201E */  bgtz       $s1, .L800F09A8
    /* E11A0 800F09A0 00000000 */   nop
    /* E11A4 800F09A4 01001124 */  addiu      $s1, $zero, 0x1
  .L800F09A8:
    /* E11A8 800F09A8 5400A98F */  lw         $t1, 0x54($sp)
    /* E11AC 800F09AC 00000000 */  nop
    /* E11B0 800F09B0 21106902 */  addu       $v0, $s3, $t1
    /* E11B4 800F09B4 21184500 */  addu       $v1, $v0, $a1
    /* E11B8 800F09B8 080002A6 */  sh         $v0, 0x8($s0)
    /* E11BC 800F09BC 180002A6 */  sh         $v0, 0x18($s0)
    /* E11C0 800F09C0 2110F102 */  addu       $v0, $s7, $s1
    /* E11C4 800F09C4 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* E11C8 800F09C8 220002A6 */  sh         $v0, 0x22($s0)
    /* E11CC 800F09CC 1480023C */  lui        $v0, %hi(nextprim)
    /* E11D0 800F09D0 78DE428C */  lw         $v0, %lo(nextprim)($v0)
    /* E11D4 800F09D4 0A0017A6 */  sh         $s7, 0xA($s0)
    /* E11D8 800F09D8 120017A6 */  sh         $s7, 0x12($s0)
    /* E11DC 800F09DC 100003A6 */  sh         $v1, 0x10($s0)
    /* E11E0 800F09E0 200003A6 */  sh         $v1, 0x20($s0)
    /* E11E4 800F09E4 14800D3C */  lui        $t5, %hi(nextprim)
    /* E11E8 800F09E8 78DEAD8D */  lw         $t5, %lo(nextprim)($t5)
    /* E11EC 800F09EC 02004E88 */  lwl        $t6, 0x2($v0)
    /* E11F0 800F09F0 007A1000 */  sll        $t7, $s0, 8
    /* E11F4 800F09F4 02000EAA */  swl        $t6, 0x2($s0)
    /* E11F8 800F09F8 02004FA8 */  swl        $t7, 0x2($v0)
    /* E11FC 800F09FC 0400C286 */  lh         $v0, 0x4($s6)
    /* E1200 800F0A00 21986502 */  addu       $s3, $s3, $a1
    /* E1204 800F0A04 1480013C */  lui        $at, %hi(nextprim)
    /* E1208 800F0A08 78DE30AC */  sw         $s0, %lo(nextprim)($at)
    /* E120C 800F0A0C 2A106202 */  slt        $v0, $s3, $v0
    /* E1210 800F0A10 88FF4014 */  bnez       $v0, .L800F0834
    /* E1214 800F0A14 18007502 */   mult      $s3, $s5
  .L800F0A18:
    /* E1218 800F0A18 2138F100 */  addu       $a3, $a3, $s1
    /* E121C 800F0A1C 0600C286 */  lh         $v0, 0x6($s6)
    /* E1220 800F0A20 0600C396 */  lhu        $v1, 0x6($s6)
    /* E1224 800F0A24 2A10E200 */  slt        $v0, $a3, $v0
    /* E1228 800F0A28 14004010 */  beqz       $v0, .L800F0A7C
    /* E122C 800F0A2C 00000000 */   nop
    /* E1230 800F0A30 F5C10308 */  j          .L800F07D4
    /* E1234 800F0A34 00000000 */   nop
  .L800F0A38:
    /* E1238 800F0A38 1580023C */  lui        $v0, %hi(currentwindow)
    /* E123C 800F0A3C E4864224 */  addiu      $v0, $v0, %lo(currentwindow)
    /* E1240 800F0A40 04004394 */  lhu        $v1, 0x4($v0)
    /* E1244 800F0A44 5400A98F */  lw         $t1, 0x54($sp)
    /* E1248 800F0A48 08004294 */  lhu        $v0, 0x8($v0)
    /* E124C 800F0A4C 21186900 */  addu       $v1, $v1, $t1
    /* E1250 800F0A50 5800A98F */  lw         $t1, 0x58($sp)
    /* E1254 800F0A54 1000A3A7 */  sh         $v1, 0x10($sp)
    /* E1258 800F0A58 21104900 */  addu       $v0, $v0, $t1
    /* E125C 800F0A5C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* E1260 800F0A60 0400C296 */  lhu        $v0, 0x4($s6)
    /* E1264 800F0A64 1000A427 */  addiu      $a0, $sp, 0x10
    /* E1268 800F0A68 1400A2A7 */  sh         $v0, 0x14($sp)
    /* E126C 800F0A6C 0600C296 */  lhu        $v0, 0x6($s6)
    /* E1270 800F0A70 1000C526 */  addiu      $a1, $s6, 0x10
    /* E1274 800F0A74 58DA030C */  jal        vramimage
    /* E1278 800F0A78 1600A2A7 */   sh        $v0, 0x16($sp)
  .L800F0A7C:
    /* E127C 800F0A7C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* E1280 800F0A80 4800BE8F */  lw         $fp, 0x48($sp)
    /* E1284 800F0A84 4400B78F */  lw         $s7, 0x44($sp)
    /* E1288 800F0A88 4000B68F */  lw         $s6, 0x40($sp)
    /* E128C 800F0A8C 3C00B58F */  lw         $s5, 0x3C($sp)
    /* E1290 800F0A90 3800B48F */  lw         $s4, 0x38($sp)
    /* E1294 800F0A94 3400B38F */  lw         $s3, 0x34($sp)
    /* E1298 800F0A98 3000B28F */  lw         $s2, 0x30($sp)
    /* E129C 800F0A9C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* E12A0 800F0AA0 2800B08F */  lw         $s0, 0x28($sp)
    /* E12A4 800F0AA4 0800E003 */  jr         $ra
    /* E12A8 800F0AA8 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel movfxya
