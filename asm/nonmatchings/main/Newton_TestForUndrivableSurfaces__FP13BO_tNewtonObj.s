.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj, 0x758

glabel Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
    /* 93684 800A2E84 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* 93688 800A2E88 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 9368C 800A2E8C 21888000 */  addu       $s1, $a0, $zero
    /* 93690 800A2E90 A000B6AF */  sw         $s6, 0xA0($sp)
    /* 93694 800A2E94 21B00000 */  addu       $s6, $zero, $zero
    /* 93698 800A2E98 4000A427 */  addiu      $a0, $sp, 0x40
    /* 9369C 800A2E9C 2128C002 */  addu       $a1, $s6, $zero
    /* 936A0 800A2EA0 AC00BFAF */  sw         $ra, 0xAC($sp)
    /* 936A4 800A2EA4 A800BEAF */  sw         $fp, 0xA8($sp)
    /* 936A8 800A2EA8 A400B7AF */  sw         $s7, 0xA4($sp)
    /* 936AC 800A2EAC 9C00B5AF */  sw         $s5, 0x9C($sp)
    /* 936B0 800A2EB0 9800B4AF */  sw         $s4, 0x98($sp)
    /* 936B4 800A2EB4 9400B3AF */  sw         $s3, 0x94($sp)
    /* 936B8 800A2EB8 9000B2AF */  sw         $s2, 0x90($sp)
    /* 936BC 800A2EBC 8800B0AF */  sw         $s0, 0x88($sp)
    /* 936C0 800A2EC0 8000A0AF */  sw         $zero, 0x80($sp)
    /* 936C4 800A2EC4 6801298E */  lw         $t1, 0x168($s1)
    /* 936C8 800A2EC8 6C012A8E */  lw         $t2, 0x16C($s1)
    /* 936CC 800A2ECC 70012B8E */  lw         $t3, 0x170($s1)
    /* 936D0 800A2ED0 2000A9AF */  sw         $t1, 0x20($sp)
    /* 936D4 800A2ED4 2400AAAF */  sw         $t2, 0x24($sp)
    /* 936D8 800A2ED8 2800ABAF */  sw         $t3, 0x28($sp)
    /* 936DC 800A2EDC C690030C */  jal        memset
    /* 936E0 800A2EE0 0C000624 */   addiu     $a2, $zero, 0xC
    /* 936E4 800A2EE4 1180023C */  lui        $v0, %hi(testSimRoadInfo)
    /* 936E8 800A2EE8 34414224 */  addiu      $v0, $v0, %lo(testSimRoadInfo)
    /* 936EC 800A2EEC 08002326 */  addiu      $v1, $s1, 0x8
    /* 936F0 800A2EF0 88002426 */  addiu      $a0, $s1, 0x88
  .L800A2EF4:
    /* 936F4 800A2EF4 00006D8C */  lw         $t5, 0x0($v1)
    /* 936F8 800A2EF8 0400698C */  lw         $t1, 0x4($v1)
    /* 936FC 800A2EFC 08006A8C */  lw         $t2, 0x8($v1)
    /* 93700 800A2F00 0C006B8C */  lw         $t3, 0xC($v1)
    /* 93704 800A2F04 00004DAC */  sw         $t5, 0x0($v0)
    /* 93708 800A2F08 040049AC */  sw         $t1, 0x4($v0)
    /* 9370C 800A2F0C 08004AAC */  sw         $t2, 0x8($v0)
    /* 93710 800A2F10 0C004BAC */  sw         $t3, 0xC($v0)
    /* 93714 800A2F14 10006324 */  addiu      $v1, $v1, 0x10
    /* 93718 800A2F18 F6FF6414 */  bne        $v1, $a0, .L800A2EF4
    /* 9371C 800A2F1C 10004224 */   addiu     $v0, $v0, 0x10
    /* 93720 800A2F20 00006C8C */  lw         $t4, 0x0($v1)
    /* 93724 800A2F24 00000000 */  nop
    /* 93728 800A2F28 00004CAC */  sw         $t4, 0x0($v0)
    /* 9372C 800A2F2C C000238E */  lw         $v1, 0xC0($s1)
    /* 93730 800A2F30 2800023C */  lui        $v0, (0x280000 >> 16)
    /* 93734 800A2F34 2A104300 */  slt        $v0, $v0, $v1
    /* 93738 800A2F38 1D004010 */  beqz       $v0, .L800A2FB0
    /* 9373C 800A2F3C 21900000 */   addu      $s2, $zero, $zero
    /* 93740 800A2F40 AC00238E */  lw         $v1, 0xAC($s1)
    /* 93744 800A2F44 00000000 */  nop
    /* 93748 800A2F48 80100300 */  sll        $v0, $v1, 2
    /* 9374C 800A2F4C 21104300 */  addu       $v0, $v0, $v1
    /* 93750 800A2F50 02004104 */  bgez       $v0, .L800A2F5C
    /* 93754 800A2F54 00000000 */   nop
    /* 93758 800A2F58 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2F5C:
    /* 9375C 800A2F5C 03120200 */  sra        $v0, $v0, 8
    /* 93760 800A2F60 4000A2AF */  sw         $v0, 0x40($sp)
    /* 93764 800A2F64 B000238E */  lw         $v1, 0xB0($s1)
    /* 93768 800A2F68 00000000 */  nop
    /* 9376C 800A2F6C 80100300 */  sll        $v0, $v1, 2
    /* 93770 800A2F70 21104300 */  addu       $v0, $v0, $v1
    /* 93774 800A2F74 02004104 */  bgez       $v0, .L800A2F80
    /* 93778 800A2F78 00000000 */   nop
    /* 9377C 800A2F7C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2F80:
    /* 93780 800A2F80 03120200 */  sra        $v0, $v0, 8
    /* 93784 800A2F84 4400A2AF */  sw         $v0, 0x44($sp)
    /* 93788 800A2F88 B400238E */  lw         $v1, 0xB4($s1)
    /* 9378C 800A2F8C 00000000 */  nop
    /* 93790 800A2F90 80100300 */  sll        $v0, $v1, 2
    /* 93794 800A2F94 21104300 */  addu       $v0, $v0, $v1
    /* 93798 800A2F98 02004104 */  bgez       $v0, .L800A2FA4
    /* 9379C 800A2F9C 00000000 */   nop
    /* 937A0 800A2FA0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2FA4:
    /* 937A4 800A2FA4 03120200 */  sra        $v0, $v0, 8
    /* 937A8 800A2FA8 4800A2AF */  sw         $v0, 0x48($sp)
    /* 937AC 800A2FAC 21900000 */  addu       $s2, $zero, $zero
  .L800A2FB0:
    /* 937B0 800A2FB0 1180173C */  lui        $s7, %hi(testSimRoadInfo)
    /* 937B4 800A2FB4 3441F326 */  addiu      $s3, $s7, %lo(testSimRoadInfo)
    /* 937B8 800A2FB8 08003426 */  addiu      $s4, $s1, 0x8
    /* 937BC 800A2FBC 11800B3C */  lui        $t3, %hi(newtestSimRoadInfo)
    /* 937C0 800A2FC0 B8417E25 */  addiu      $fp, $t3, %lo(newtestSimRoadInfo)
    /* 937C4 800A2FC4 21A82002 */  addu       $s5, $s1, $zero
    /* 937C8 800A2FC8 8400A0AF */  sw         $zero, 0x84($sp)
  .L800A2FCC:
    /* 937CC 800A2FCC 0400422A */  slti       $v0, $s2, 0x4
    /* 937D0 800A2FD0 76014010 */  beqz       $v0, .L800A35AC
    /* 937D4 800A2FD4 5000A427 */   addiu     $a0, $sp, 0x50
    /* 937D8 800A2FD8 21286002 */  addu       $a1, $s3, $zero
    /* 937DC 800A2FDC 01000624 */  addiu      $a2, $zero, 0x1
    /* 937E0 800A2FE0 8C02AC8E */  lw         $t4, 0x28C($s5)
    /* 937E4 800A2FE4 9002AD8E */  lw         $t5, 0x290($s5)
    /* 937E8 800A2FE8 9402A98E */  lw         $t1, 0x294($s5)
    /* 937EC 800A2FEC 5000ACAF */  sw         $t4, 0x50($sp)
    /* 937F0 800A2FF0 5400ADAF */  sw         $t5, 0x54($sp)
    /* 937F4 800A2FF4 5800A9AF */  sw         $t1, 0x58($sp)
    /* 937F8 800A2FF8 5000A28F */  lw         $v0, 0x50($sp)
    /* 937FC 800A2FFC 4000A38F */  lw         $v1, 0x40($sp)
    /* 93800 800A3000 4400A78F */  lw         $a3, 0x44($sp)
    /* 93804 800A3004 4800A88F */  lw         $t0, 0x48($sp)
    /* 93808 800A3008 21104300 */  addu       $v0, $v0, $v1
    /* 9380C 800A300C 5000A2AF */  sw         $v0, 0x50($sp)
    /* 93810 800A3010 5400A28F */  lw         $v0, 0x54($sp)
    /* 93814 800A3014 5800A38F */  lw         $v1, 0x58($sp)
    /* 93818 800A3018 21104700 */  addu       $v0, $v0, $a3
    /* 9381C 800A301C 21186800 */  addu       $v1, $v1, $t0
    /* 93820 800A3020 5400A2AF */  sw         $v0, 0x54($sp)
    /* 93824 800A3024 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 93828 800A3028 5800A3AF */   sw        $v1, 0x58($sp)
    /* 9382C 800A302C 5A006482 */  lb         $a0, 0x5A($s3)
    /* 93830 800A3030 00000000 */  nop
    /* 93834 800A3034 08008010 */  beqz       $a0, .L800A3058
    /* 93838 800A3038 1000A527 */   addiu     $a1, $sp, 0x10
    /* 9383C 800A303C 268B020C */  jal        Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
    /* 93840 800A3040 08002626 */   addiu     $a2, $s1, 0x8
    /* 93844 800A3044 1400A0AF */  sw         $zero, 0x14($sp)
    /* 93848 800A3048 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 9384C 800A304C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 93850 800A3050 3C8D0208 */  j          .L800A34F0
    /* 93854 800A3054 01001624 */   addiu     $s6, $zero, 0x1
  .L800A3058:
    /* 93858 800A3058 21202002 */  addu       $a0, $s1, $zero
    /* 9385C 800A305C 21286002 */  addu       $a1, $s3, $zero
    /* 93860 800A3060 898B020C */  jal        Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
    /* 93864 800A3064 21304002 */   addu      $a2, $s2, $zero
    /* 93868 800A3068 21014010 */  beqz       $v0, .L800A34F0
    /* 9386C 800A306C 11800B3C */   lui       $t3, %hi(newtestSimRoadInfo)
    /* 93870 800A3070 B8416325 */  addiu      $v1, $t3, %lo(newtestSimRoadInfo)
    /* 93874 800A3074 21106002 */  addu       $v0, $s3, $zero
  .L800A3078:
    /* 93878 800A3078 00004C8C */  lw         $t4, 0x0($v0)
    /* 9387C 800A307C 04004D8C */  lw         $t5, 0x4($v0)
    /* 93880 800A3080 0800498C */  lw         $t1, 0x8($v0)
    /* 93884 800A3084 0C004A8C */  lw         $t2, 0xC($v0)
    /* 93888 800A3088 00006CAC */  sw         $t4, 0x0($v1)
    /* 9388C 800A308C 04006DAC */  sw         $t5, 0x4($v1)
    /* 93890 800A3090 080069AC */  sw         $t1, 0x8($v1)
    /* 93894 800A3094 0C006AAC */  sw         $t2, 0xC($v1)
    /* 93898 800A3098 10004224 */  addiu      $v0, $v0, 0x10
    /* 9389C 800A309C 11800B3C */  lui        $t3, %hi(D_801141B4)
    /* 938A0 800A30A0 B4416B25 */  addiu      $t3, $t3, %lo(D_801141B4)
    /* 938A4 800A30A4 F4FF4B14 */  bne        $v0, $t3, .L800A3078
    /* 938A8 800A30A8 10006324 */   addiu     $v1, $v1, 0x10
    /* 938AC 800A30AC 5000A427 */  addiu      $a0, $sp, 0x50
    /* 938B0 800A30B0 21288002 */  addu       $a1, $s4, $zero
    /* 938B4 800A30B4 3441E626 */  addiu      $a2, $s7, %lo(testSimRoadInfo)
    /* 938B8 800A30B8 11800C3C */  lui        $t4, %hi(D_801141B4)
    /* 938BC 800A30BC B4418C25 */  addiu      $t4, $t4, %lo(D_801141B4)
    /* 938C0 800A30C0 00008D8D */  lw         $t5, 0x0($t4)
    /* 938C4 800A30C4 00000000 */  nop
    /* 938C8 800A30C8 00006DAC */  sw         $t5, 0x0($v1)
    /* 938CC 800A30CC 5000AC8F */  lw         $t4, 0x50($sp)
    /* 938D0 800A30D0 5400AD8F */  lw         $t5, 0x54($sp)
    /* 938D4 800A30D4 5800A98F */  lw         $t1, 0x58($sp)
    /* 938D8 800A30D8 6000ACAF */  sw         $t4, 0x60($sp)
    /* 938DC 800A30DC 6400ADAF */  sw         $t5, 0x64($sp)
    /* 938E0 800A30E0 6800A9AF */  sw         $t1, 0x68($sp)
    /* 938E4 800A30E4 4AFF010C */  jal        BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
    /* 938E8 800A30E8 8000A727 */   addiu     $a3, $sp, 0x80
    /* 938EC 800A30EC 21804000 */  addu       $s0, $v0, $zero
    /* 938F0 800A30F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 938F4 800A30F4 0A000212 */  beq        $s0, $v0, .L800A3120
    /* 938F8 800A30F8 02001624 */   addiu     $s6, $zero, 0x2
    /* 938FC 800A30FC 03001616 */  bne        $s0, $s6, .L800A310C
    /* 93900 800A3100 04000224 */   addiu     $v0, $zero, 0x4
    /* 93904 800A3104 498C0208 */  j          .L800A3124
    /* 93908 800A3108 02000424 */   addiu     $a0, $zero, 0x2
  .L800A310C:
    /* 9390C 800A310C 05000212 */  beq        $s0, $v0, .L800A3124
    /* 93910 800A3110 21204000 */   addu      $a0, $v0, $zero
    /* 93914 800A3114 08000224 */  addiu      $v0, $zero, 0x8
    /* 93918 800A3118 05000216 */  bne        $s0, $v0, .L800A3130
    /* 9391C 800A311C 00000000 */   nop
  .L800A3120:
    /* 93920 800A3120 21204000 */  addu       $a0, $v0, $zero
  .L800A3124:
    /* 93924 800A3124 1000A527 */  addiu      $a1, $sp, 0x10
    /* 93928 800A3128 268B020C */  jal        Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
    /* 9392C 800A312C 21308002 */   addu      $a2, $s4, $zero
  .L800A3130:
    /* 93930 800A3130 03000232 */  andi       $v0, $s0, 0x3
    /* 93934 800A3134 EB004010 */  beqz       $v0, .L800A34E4
    /* 93938 800A3138 01000232 */   andi      $v0, $s0, 0x1
    /* 9393C 800A313C 04004014 */  bnez       $v0, .L800A3150
    /* 93940 800A3140 01000424 */   addiu     $a0, $zero, 0x1
    /* 93944 800A3144 02000232 */  andi       $v0, $s0, 0x2
    /* 93948 800A3148 04004010 */  beqz       $v0, .L800A315C
    /* 9394C 800A314C 02000424 */   addiu     $a0, $zero, 0x2
  .L800A3150:
    /* 93950 800A3150 1000A527 */  addiu      $a1, $sp, 0x10
    /* 93954 800A3154 268B020C */  jal        Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
    /* 93958 800A3158 08002626 */   addiu     $a2, $s1, 0x8
  .L800A315C:
    /* 9395C 800A315C 6000A427 */  addiu      $a0, $sp, 0x60
    /* 93960 800A3160 2128C003 */  addu       $a1, $fp, $zero
    /* 93964 800A3164 01000624 */  addiu      $a2, $zero, 0x1
    /* 93968 800A3168 6000A28F */  lw         $v0, 0x60($sp)
    /* 9396C 800A316C 1000A38F */  lw         $v1, 0x10($sp)
    /* 93970 800A3170 1400A78F */  lw         $a3, 0x14($sp)
    /* 93974 800A3174 1800A88F */  lw         $t0, 0x18($sp)
    /* 93978 800A3178 21104300 */  addu       $v0, $v0, $v1
    /* 9397C 800A317C 6000A2AF */  sw         $v0, 0x60($sp)
    /* 93980 800A3180 6400A28F */  lw         $v0, 0x64($sp)
    /* 93984 800A3184 6800A38F */  lw         $v1, 0x68($sp)
    /* 93988 800A3188 21104700 */  addu       $v0, $v0, $a3
    /* 9398C 800A318C 21186800 */  addu       $v1, $v1, $t0
    /* 93990 800A3190 6400A2AF */  sw         $v0, 0x64($sp)
    /* 93994 800A3194 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 93998 800A3198 6800A3AF */   sw        $v1, 0x68($sp)
    /* 9399C 800A319C 21202002 */  addu       $a0, $s1, $zero
    /* 939A0 800A31A0 2128C003 */  addu       $a1, $fp, $zero
    /* 939A4 800A31A4 898B020C */  jal        Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
    /* 939A8 800A31A8 21304002 */   addu      $a2, $s2, $zero
    /* 939AC 800A31AC CD004010 */  beqz       $v0, .L800A34E4
    /* 939B0 800A31B0 0C000232 */   andi      $v0, $s0, 0xC
    /* 939B4 800A31B4 83004010 */  beqz       $v0, .L800A33C4
    /* 939B8 800A31B8 04000232 */   andi      $v0, $s0, 0x4
    /* 939BC 800A31BC 04004010 */  beqz       $v0, .L800A31D0
    /* 939C0 800A31C0 04000424 */   addiu     $a0, $zero, 0x4
    /* 939C4 800A31C4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 939C8 800A31C8 798C0208 */  j          .L800A31E4
    /* 939CC 800A31CC 08002626 */   addiu     $a2, $s1, 0x8
  .L800A31D0:
    /* 939D0 800A31D0 08000232 */  andi       $v0, $s0, 0x8
    /* 939D4 800A31D4 05004010 */  beqz       $v0, .L800A31EC
    /* 939D8 800A31D8 08000424 */   addiu     $a0, $zero, 0x8
    /* 939DC 800A31DC 1000A527 */  addiu      $a1, $sp, 0x10
    /* 939E0 800A31E0 21302402 */  addu       $a2, $s1, $a0
  .L800A31E4:
    /* 939E4 800A31E4 268B020C */  jal        Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
    /* 939E8 800A31E8 00000000 */   nop
  .L800A31EC:
    /* 939EC 800A31EC 11800B3C */  lui        $t3, %hi(newtestSimRoadInfo)
    /* 939F0 800A31F0 B8416325 */  addiu      $v1, $t3, %lo(newtestSimRoadInfo)
    /* 939F4 800A31F4 3441E226 */  addiu      $v0, $s7, %lo(testSimRoadInfo)
  .L800A31F8:
    /* 939F8 800A31F8 00004C8C */  lw         $t4, 0x0($v0)
    /* 939FC 800A31FC 04004D8C */  lw         $t5, 0x4($v0)
    /* 93A00 800A3200 0800498C */  lw         $t1, 0x8($v0)
    /* 93A04 800A3204 0C004A8C */  lw         $t2, 0xC($v0)
    /* 93A08 800A3208 00006CAC */  sw         $t4, 0x0($v1)
    /* 93A0C 800A320C 04006DAC */  sw         $t5, 0x4($v1)
    /* 93A10 800A3210 080069AC */  sw         $t1, 0x8($v1)
    /* 93A14 800A3214 0C006AAC */  sw         $t2, 0xC($v1)
    /* 93A18 800A3218 10004224 */  addiu      $v0, $v0, 0x10
    /* 93A1C 800A321C 11800B3C */  lui        $t3, %hi(D_801141B4)
    /* 93A20 800A3220 B4416B25 */  addiu      $t3, $t3, %lo(D_801141B4)
    /* 93A24 800A3224 F4FF4B14 */  bne        $v0, $t3, .L800A31F8
    /* 93A28 800A3228 10006324 */   addiu     $v1, $v1, 0x10
    /* 93A2C 800A322C 6000A427 */  addiu      $a0, $sp, 0x60
    /* 93A30 800A3230 2128C003 */  addu       $a1, $fp, $zero
    /* 93A34 800A3234 01000624 */  addiu      $a2, $zero, 0x1
    /* 93A38 800A3238 00004C8C */  lw         $t4, 0x0($v0)
    /* 93A3C 800A323C 00000000 */  nop
    /* 93A40 800A3240 00006CAC */  sw         $t4, 0x0($v1)
    /* 93A44 800A3244 5000AB8F */  lw         $t3, 0x50($sp)
    /* 93A48 800A3248 5400AC8F */  lw         $t4, 0x54($sp)
    /* 93A4C 800A324C 5800AD8F */  lw         $t5, 0x58($sp)
    /* 93A50 800A3250 6000ABAF */  sw         $t3, 0x60($sp)
    /* 93A54 800A3254 6400ACAF */  sw         $t4, 0x64($sp)
    /* 93A58 800A3258 6800ADAF */  sw         $t5, 0x68($sp)
    /* 93A5C 800A325C 6000A28F */  lw         $v0, 0x60($sp)
    /* 93A60 800A3260 1000A38F */  lw         $v1, 0x10($sp)
    /* 93A64 800A3264 1400A78F */  lw         $a3, 0x14($sp)
    /* 93A68 800A3268 1800A88F */  lw         $t0, 0x18($sp)
    /* 93A6C 800A326C 21104300 */  addu       $v0, $v0, $v1
    /* 93A70 800A3270 6000A2AF */  sw         $v0, 0x60($sp)
    /* 93A74 800A3274 6400A28F */  lw         $v0, 0x64($sp)
    /* 93A78 800A3278 6800A38F */  lw         $v1, 0x68($sp)
    /* 93A7C 800A327C 21104700 */  addu       $v0, $v0, $a3
    /* 93A80 800A3280 21186800 */  addu       $v1, $v1, $t0
    /* 93A84 800A3284 6400A2AF */  sw         $v0, 0x64($sp)
    /* 93A88 800A3288 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 93A8C 800A328C 6800A3AF */   sw        $v1, 0x68($sp)
    /* 93A90 800A3290 21202002 */  addu       $a0, $s1, $zero
    /* 93A94 800A3294 2128C003 */  addu       $a1, $fp, $zero
    /* 93A98 800A3298 898B020C */  jal        Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
    /* 93A9C 800A329C 21304002 */   addu      $a2, $s2, $zero
    /* 93AA0 800A32A0 90004010 */  beqz       $v0, .L800A34E4
    /* 93AA4 800A32A4 21380000 */   addu      $a3, $zero, $zero
    /* 93AA8 800A32A8 1180063C */  lui        $a2, %hi(D_8011413C)
    /* 93AAC 800A32AC 3C41C624 */  addiu      $a2, $a2, %lo(D_8011413C)
    /* 93AB0 800A32B0 3800A0AF */  sw         $zero, 0x38($sp)
    /* 93AB4 800A32B4 3400A0AF */  sw         $zero, 0x34($sp)
    /* 93AB8 800A32B8 3000A0AF */  sw         $zero, 0x30($sp)
  .L800A32BC:
    /* 93ABC 800A32BC 0400E228 */  slti       $v0, $a3, 0x4
    /* 93AC0 800A32C0 27004010 */  beqz       $v0, .L800A3360
    /* 93AC4 800A32C4 00000000 */   nop
    /* 93AC8 800A32C8 7800628E */  lw         $v0, 0x78($s3)
    /* 93ACC 800A32CC 00000000 */  nop
    /* 93AD0 800A32D0 09004010 */  beqz       $v0, .L800A32F8
    /* 93AD4 800A32D4 00000000 */   nop
    /* 93AD8 800A32D8 0000CA8C */  lw         $t2, 0x0($a2)
    /* 93ADC 800A32DC 0400CB8C */  lw         $t3, 0x4($a2)
    /* 93AE0 800A32E0 0800CC8C */  lw         $t4, 0x8($a2)
    /* 93AE4 800A32E4 7000AAAF */  sw         $t2, 0x70($sp)
    /* 93AE8 800A32E8 7400ABAF */  sw         $t3, 0x74($sp)
    /* 93AEC 800A32EC 7800ACAF */  sw         $t4, 0x78($sp)
    /* 93AF0 800A32F0 CA8C0208 */  j          .L800A3328
    /* 93AF4 800A32F4 0C00C624 */   addiu     $a2, $a2, 0xC
  .L800A32F8:
    /* 93AF8 800A32F8 3441E286 */  lh         $v0, %lo(testSimRoadInfo)($s7)
    /* 93AFC 800A32FC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 93B00 800A3300 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 93B04 800A3304 40110200 */  sll        $v0, $v0, 5
    /* 93B08 800A3308 21104300 */  addu       $v0, $v0, $v1
    /* 93B0C 800A330C 0000498C */  lw         $t1, 0x0($v0)
    /* 93B10 800A3310 04004A8C */  lw         $t2, 0x4($v0)
    /* 93B14 800A3314 08004B8C */  lw         $t3, 0x8($v0)
    /* 93B18 800A3318 7000A9AF */  sw         $t1, 0x70($sp)
    /* 93B1C 800A331C 7400AAAF */  sw         $t2, 0x74($sp)
    /* 93B20 800A3320 7800ABAF */  sw         $t3, 0x78($sp)
    /* 93B24 800A3324 0C00C624 */  addiu      $a2, $a2, 0xC
  .L800A3328:
    /* 93B28 800A3328 0100E724 */  addiu      $a3, $a3, 0x1
    /* 93B2C 800A332C 3000A28F */  lw         $v0, 0x30($sp)
    /* 93B30 800A3330 7000A38F */  lw         $v1, 0x70($sp)
    /* 93B34 800A3334 7400A48F */  lw         $a0, 0x74($sp)
    /* 93B38 800A3338 7800A58F */  lw         $a1, 0x78($sp)
    /* 93B3C 800A333C 21104300 */  addu       $v0, $v0, $v1
    /* 93B40 800A3340 3000A2AF */  sw         $v0, 0x30($sp)
    /* 93B44 800A3344 3400A28F */  lw         $v0, 0x34($sp)
    /* 93B48 800A3348 3800A38F */  lw         $v1, 0x38($sp)
    /* 93B4C 800A334C 21104400 */  addu       $v0, $v0, $a0
    /* 93B50 800A3350 21186500 */  addu       $v1, $v1, $a1
    /* 93B54 800A3354 3400A2AF */  sw         $v0, 0x34($sp)
    /* 93B58 800A3358 AF8C0208 */  j          .L800A32BC
    /* 93B5C 800A335C 3800A3AF */   sw        $v1, 0x38($sp)
  .L800A3360:
    /* 93B60 800A3360 3000A38F */  lw         $v1, 0x30($sp)
    /* 93B64 800A3364 00000000 */  nop
    /* 93B68 800A3368 02006104 */  bgez       $v1, .L800A3374
    /* 93B6C 800A336C 00000000 */   nop
    /* 93B70 800A3370 03006324 */  addiu      $v1, $v1, 0x3
  .L800A3374:
    /* 93B74 800A3374 3400A28F */  lw         $v0, 0x34($sp)
    /* 93B78 800A3378 83280300 */  sra        $a1, $v1, 2
    /* 93B7C 800A337C 02004104 */  bgez       $v0, .L800A3388
    /* 93B80 800A3380 3000A5AF */   sw        $a1, 0x30($sp)
    /* 93B84 800A3384 03004224 */  addiu      $v0, $v0, 0x3
  .L800A3388:
    /* 93B88 800A3388 3800A38F */  lw         $v1, 0x38($sp)
    /* 93B8C 800A338C 83100200 */  sra        $v0, $v0, 2
    /* 93B90 800A3390 02006104 */  bgez       $v1, .L800A339C
    /* 93B94 800A3394 3400A2AF */   sw        $v0, 0x34($sp)
    /* 93B98 800A3398 03006324 */  addiu      $v1, $v1, 0x3
  .L800A339C:
    /* 93B9C 800A339C 83100300 */  sra        $v0, $v1, 2
    /* 93BA0 800A33A0 2000A38F */  lw         $v1, 0x20($sp)
    /* 93BA4 800A33A4 2800A48F */  lw         $a0, 0x28($sp)
    /* 93BA8 800A33A8 3800A2AF */  sw         $v0, 0x38($sp)
    /* 93BAC 800A33AC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 93BB0 800A33B0 23186500 */  subu       $v1, $v1, $a1
    /* 93BB4 800A33B4 23208200 */  subu       $a0, $a0, $v0
    /* 93BB8 800A33B8 1000A3AF */  sw         $v1, 0x10($sp)
    /* 93BBC 800A33BC 398D0208 */  j          .L800A34E4
    /* 93BC0 800A33C0 1800A4AF */   sw        $a0, 0x18($sp)
  .L800A33C4:
    /* 93BC4 800A33C4 21380000 */  addu       $a3, $zero, $zero
    /* 93BC8 800A33C8 1180063C */  lui        $a2, %hi(D_8011413C)
    /* 93BCC 800A33CC 3C41C624 */  addiu      $a2, $a2, %lo(D_8011413C)
    /* 93BD0 800A33D0 3800A0AF */  sw         $zero, 0x38($sp)
    /* 93BD4 800A33D4 3400A0AF */  sw         $zero, 0x34($sp)
    /* 93BD8 800A33D8 3000A0AF */  sw         $zero, 0x30($sp)
  .L800A33DC:
    /* 93BDC 800A33DC 0400E228 */  slti       $v0, $a3, 0x4
    /* 93BE0 800A33E0 27004010 */  beqz       $v0, .L800A3480
    /* 93BE4 800A33E4 00000000 */   nop
    /* 93BE8 800A33E8 7800628E */  lw         $v0, 0x78($s3)
    /* 93BEC 800A33EC 00000000 */  nop
    /* 93BF0 800A33F0 09004010 */  beqz       $v0, .L800A3418
    /* 93BF4 800A33F4 00000000 */   nop
    /* 93BF8 800A33F8 0000CD8C */  lw         $t5, 0x0($a2)
    /* 93BFC 800A33FC 0400C98C */  lw         $t1, 0x4($a2)
    /* 93C00 800A3400 0800CA8C */  lw         $t2, 0x8($a2)
    /* 93C04 800A3404 7000ADAF */  sw         $t5, 0x70($sp)
    /* 93C08 800A3408 7400A9AF */  sw         $t1, 0x74($sp)
    /* 93C0C 800A340C 7800AAAF */  sw         $t2, 0x78($sp)
    /* 93C10 800A3410 128D0208 */  j          .L800A3448
    /* 93C14 800A3414 0C00C624 */   addiu     $a2, $a2, 0xC
  .L800A3418:
    /* 93C18 800A3418 3441E286 */  lh         $v0, %lo(testSimRoadInfo)($s7)
    /* 93C1C 800A341C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 93C20 800A3420 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 93C24 800A3424 40110200 */  sll        $v0, $v0, 5
    /* 93C28 800A3428 21104300 */  addu       $v0, $v0, $v1
    /* 93C2C 800A342C 00004C8C */  lw         $t4, 0x0($v0)
    /* 93C30 800A3430 04004D8C */  lw         $t5, 0x4($v0)
    /* 93C34 800A3434 0800498C */  lw         $t1, 0x8($v0)
    /* 93C38 800A3438 7000ACAF */  sw         $t4, 0x70($sp)
    /* 93C3C 800A343C 7400ADAF */  sw         $t5, 0x74($sp)
    /* 93C40 800A3440 7800A9AF */  sw         $t1, 0x78($sp)
    /* 93C44 800A3444 0C00C624 */  addiu      $a2, $a2, 0xC
  .L800A3448:
    /* 93C48 800A3448 0100E724 */  addiu      $a3, $a3, 0x1
    /* 93C4C 800A344C 3000A28F */  lw         $v0, 0x30($sp)
    /* 93C50 800A3450 7000A38F */  lw         $v1, 0x70($sp)
    /* 93C54 800A3454 7400A48F */  lw         $a0, 0x74($sp)
    /* 93C58 800A3458 7800A58F */  lw         $a1, 0x78($sp)
    /* 93C5C 800A345C 21104300 */  addu       $v0, $v0, $v1
    /* 93C60 800A3460 3000A2AF */  sw         $v0, 0x30($sp)
    /* 93C64 800A3464 3400A28F */  lw         $v0, 0x34($sp)
    /* 93C68 800A3468 3800A38F */  lw         $v1, 0x38($sp)
    /* 93C6C 800A346C 21104400 */  addu       $v0, $v0, $a0
    /* 93C70 800A3470 21186500 */  addu       $v1, $v1, $a1
    /* 93C74 800A3474 3400A2AF */  sw         $v0, 0x34($sp)
    /* 93C78 800A3478 F78C0208 */  j          .L800A33DC
    /* 93C7C 800A347C 3800A3AF */   sw        $v1, 0x38($sp)
  .L800A3480:
    /* 93C80 800A3480 3000A38F */  lw         $v1, 0x30($sp)
    /* 93C84 800A3484 00000000 */  nop
    /* 93C88 800A3488 02006104 */  bgez       $v1, .L800A3494
    /* 93C8C 800A348C 00000000 */   nop
    /* 93C90 800A3490 03006324 */  addiu      $v1, $v1, 0x3
  .L800A3494:
    /* 93C94 800A3494 3400A28F */  lw         $v0, 0x34($sp)
    /* 93C98 800A3498 83200300 */  sra        $a0, $v1, 2
    /* 93C9C 800A349C 02004104 */  bgez       $v0, .L800A34A8
    /* 93CA0 800A34A0 3000A4AF */   sw        $a0, 0x30($sp)
    /* 93CA4 800A34A4 03004224 */  addiu      $v0, $v0, 0x3
  .L800A34A8:
    /* 93CA8 800A34A8 3800A38F */  lw         $v1, 0x38($sp)
    /* 93CAC 800A34AC 83100200 */  sra        $v0, $v0, 2
    /* 93CB0 800A34B0 02006104 */  bgez       $v1, .L800A34BC
    /* 93CB4 800A34B4 3400A2AF */   sw        $v0, 0x34($sp)
    /* 93CB8 800A34B8 03006324 */  addiu      $v1, $v1, 0x3
  .L800A34BC:
    /* 93CBC 800A34BC 83100300 */  sra        $v0, $v1, 2
    /* 93CC0 800A34C0 3800A2AF */  sw         $v0, 0x38($sp)
    /* 93CC4 800A34C4 A000238E */  lw         $v1, 0xA0($s1)
    /* 93CC8 800A34C8 00000000 */  nop
    /* 93CCC 800A34CC 23186400 */  subu       $v1, $v1, $a0
    /* 93CD0 800A34D0 1000A3AF */  sw         $v1, 0x10($sp)
    /* 93CD4 800A34D4 A800238E */  lw         $v1, 0xA8($s1)
    /* 93CD8 800A34D8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 93CDC 800A34DC 23186200 */  subu       $v1, $v1, $v0
    /* 93CE0 800A34E0 1800A3AF */  sw         $v1, 0x18($sp)
  .L800A34E4:
    /* 93CE4 800A34E4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 93CE8 800A34E8 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 93CEC 800A34EC 1000A427 */   addiu     $a0, $sp, 0x10
  .L800A34F0:
    /* 93CF0 800A34F0 2800C012 */  beqz       $s6, .L800A3594
    /* 93CF4 800A34F4 21580000 */   addu      $t3, $zero, $zero
    /* 93CF8 800A34F8 2C006015 */  bnez       $t3, .L800A35AC
    /* 93CFC 800A34FC 00000000 */   nop
    /* 93D00 800A3500 1000A58F */  lw         $a1, 0x10($sp)
    /* 93D04 800A3504 1400A68F */  lw         $a2, 0x14($sp)
    /* 93D08 800A3508 1800A78F */  lw         $a3, 0x18($sp)
    /* 93D0C 800A350C BC8A020C */  jal        Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
    /* 93D10 800A3510 21202002 */   addu      $a0, $s1, $zero
    /* 93D14 800A3514 8C02AC8E */  lw         $t4, 0x28C($s5)
    /* 93D18 800A3518 9002AD8E */  lw         $t5, 0x290($s5)
    /* 93D1C 800A351C 9402A98E */  lw         $t1, 0x294($s5)
    /* 93D20 800A3520 A0012CAE */  sw         $t4, 0x1A0($s1)
    /* 93D24 800A3524 A4012DAE */  sw         $t5, 0x1A4($s1)
    /* 93D28 800A3528 A80129AE */  sw         $t1, 0x1A8($s1)
    /* 93D2C 800A352C 48B2010C */  jal        AIPhysic_ProcessBarrierCollision__FP8Car_tObj
    /* 93D30 800A3530 21202002 */   addu      $a0, $s1, $zero
    /* 93D34 800A3534 6002228E */  lw         $v0, 0x260($s1)
    /* 93D38 800A3538 00000000 */  nop
    /* 93D3C 800A353C 04004230 */  andi       $v0, $v0, 0x4
    /* 93D40 800A3540 03004010 */  beqz       $v0, .L800A3550
    /* 93D44 800A3544 00000000 */   nop
    /* 93D48 800A3548 39A9020C */  jal        Physics_FixEngineRpm__FP8Car_tObj
    /* 93D4C 800A354C 21202002 */   addu      $a0, $s1, $zero
  .L800A3550:
    /* 93D50 800A3550 9001258E */  lw         $a1, 0x190($s1)
    /* 93D54 800A3554 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 93D58 800A3558 2A104500 */  slt        $v0, $v0, $a1
    /* 93D5C 800A355C 13004010 */  beqz       $v0, .L800A35AC
    /* 93D60 800A3560 02000224 */   addiu     $v0, $zero, 0x2
    /* 93D64 800A3564 06004212 */  beq        $s2, $v0, .L800A3580
    /* 93D68 800A3568 06000624 */   addiu     $a2, $zero, 0x6
    /* 93D6C 800A356C 8400A68F */  lw         $a2, 0x84($sp)
    /* 93D70 800A3570 03000224 */  addiu      $v0, $zero, 0x3
    /* 93D74 800A3574 03004216 */  bne        $s2, $v0, .L800A3584
    /* 93D78 800A3578 21202002 */   addu      $a0, $s1, $zero
    /* 93D7C 800A357C 04000624 */  addiu      $a2, $zero, 0x4
  .L800A3580:
    /* 93D80 800A3580 21202002 */  addu       $a0, $s1, $zero
  .L800A3584:
    /* 93D84 800A3584 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 93D88 800A3588 01000724 */   addiu     $a3, $zero, 0x1
    /* 93D8C 800A358C 6B8D0208 */  j          .L800A35AC
    /* 93D90 800A3590 00000000 */   nop
  .L800A3594:
    /* 93D94 800A3594 3000B526 */  addiu      $s5, $s5, 0x30
    /* 93D98 800A3598 8400AB8F */  lw         $t3, 0x84($sp)
    /* 93D9C 800A359C 01005226 */  addiu      $s2, $s2, 0x1
    /* 93DA0 800A35A0 02006B25 */  addiu      $t3, $t3, 0x2
    /* 93DA4 800A35A4 F38B0208 */  j          .L800A2FCC
    /* 93DA8 800A35A8 8400ABAF */   sw        $t3, 0x84($sp)
  .L800A35AC:
    /* 93DAC 800A35AC AC00BF8F */  lw         $ra, 0xAC($sp)
    /* 93DB0 800A35B0 A800BE8F */  lw         $fp, 0xA8($sp)
    /* 93DB4 800A35B4 A400B78F */  lw         $s7, 0xA4($sp)
    /* 93DB8 800A35B8 A000B68F */  lw         $s6, 0xA0($sp)
    /* 93DBC 800A35BC 9C00B58F */  lw         $s5, 0x9C($sp)
    /* 93DC0 800A35C0 9800B48F */  lw         $s4, 0x98($sp)
    /* 93DC4 800A35C4 9400B38F */  lw         $s3, 0x94($sp)
    /* 93DC8 800A35C8 9000B28F */  lw         $s2, 0x90($sp)
    /* 93DCC 800A35CC 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 93DD0 800A35D0 8800B08F */  lw         $s0, 0x88($sp)
    /* 93DD4 800A35D4 0800E003 */  jr         $ra
    /* 93DD8 800A35D8 B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
