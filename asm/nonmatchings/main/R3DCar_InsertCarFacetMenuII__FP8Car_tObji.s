.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertCarFacetMenuII__FP8Car_tObji, 0x428

glabel R3DCar_InsertCarFacetMenuII__FP8Car_tObji
    /* A2F60 800B2760 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* A2F64 800B2764 5000BEAF */  sw         $fp, 0x50($sp)
    /* A2F68 800B2768 21F08000 */  addu       $fp, $a0, $zero
    /* A2F6C 800B276C 2130A000 */  addu       $a2, $a1, $zero
    /* A2F70 800B2770 5400BFAF */  sw         $ra, 0x54($sp)
    /* A2F74 800B2774 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* A2F78 800B2778 4800B6AF */  sw         $s6, 0x48($sp)
    /* A2F7C 800B277C 4400B5AF */  sw         $s5, 0x44($sp)
    /* A2F80 800B2780 4000B4AF */  sw         $s4, 0x40($sp)
    /* A2F84 800B2784 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* A2F88 800B2788 3800B2AF */  sw         $s2, 0x38($sp)
    /* A2F8C 800B278C 3400B1AF */  sw         $s1, 0x34($sp)
    /* A2F90 800B2790 3000B0AF */  sw         $s0, 0x30($sp)
    /* A2F94 800B2794 4208C293 */  lbu        $v0, 0x842($fp)
    /* A2F98 800B2798 BC08D187 */  lh         $s1, 0x8BC($fp)
    /* A2F9C 800B279C C2B10200 */  srl        $s6, $v0, 7
    /* A2FA0 800B27A0 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* A2FA4 800B27A4 08695424 */  addiu      $s4, $v0, %lo(R3DCar_LoadedScenePointer)
    /* A2FA8 800B27A8 80981100 */  sll        $s3, $s1, 2
    /* A2FAC 800B27AC 40101600 */  sll        $v0, $s6, 1
    /* A2FB0 800B27B0 21105600 */  addu       $v0, $v0, $s6
    /* A2FB4 800B27B4 C0100200 */  sll        $v0, $v0, 3
    /* A2FB8 800B27B8 21105600 */  addu       $v0, $v0, $s6
    /* A2FBC 800B27BC C0100200 */  sll        $v0, $v0, 3
    /* A2FC0 800B27C0 21106202 */  addu       $v0, $s3, $v0
    /* A2FC4 800B27C4 21105400 */  addu       $v0, $v0, $s4
    /* A2FC8 800B27C8 0000428C */  lw         $v0, 0x0($v0)
    /* A2FCC 800B27CC 700E8B8F */  lw         $t3, %gp_rel(R3DCar_rightHandDrive)($gp)
    /* A2FD0 800B27D0 E4004224 */  addiu      $v0, $v0, 0xE4
    /* A2FD4 800B27D4 2400A2AF */  sw         $v0, 0x24($sp)
    /* A2FD8 800B27D8 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A2FDC 800B27DC 801F123C */  lui        $s2, (0x1F80000C >> 16)
    /* A2FE0 800B27E0 80004230 */  andi       $v0, $v0, 0x80
    /* A2FE4 800B27E4 02004010 */  beqz       $v0, .L800B27F0
    /* A2FE8 800B27E8 2000ABAF */   sw        $t3, 0x20($sp)
    /* A2FEC 800B27EC 43300600 */  sra        $a2, $a2, 1
  .L800B27F0:
    /* A2FF0 800B27F0 00140600 */  sll        $v0, $a2, 16
    /* A2FF4 800B27F4 001A0600 */  sll        $v1, $a2, 8
    /* A2FF8 800B27F8 21104300 */  addu       $v0, $v0, $v1
    /* A2FFC 800B27FC 21104600 */  addu       $v0, $v0, $a2
    /* A3000 800B2800 8C0042AE */  sw         $v0, (0x1F80008C & 0xFFFF)($s2)
    /* A3004 800B2804 C208C287 */  lh         $v0, 0x8C2($fp)
    /* A3008 800B2808 00000000 */  nop
    /* A300C 800B280C D2004004 */  bltz       $v0, .L800B2B58
    /* A3010 800B2810 00000000 */   nop
    /* A3014 800B2814 1480043C */  lui        $a0, %hi(R3DCar_center)
    /* A3018 800B2818 90D38424 */  addiu      $a0, $a0, %lo(R3DCar_center)
    /* A301C 800B281C 2128C003 */  addu       $a1, $fp, $zero
    /* A3020 800B2820 51FB020C */  jal        DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
    /* A3024 800B2824 801F073C */   lui       $a3, (0x1F800000 >> 16)
    /* A3028 800B2828 CB004004 */  bltz       $v0, .L800B2B58
    /* A302C 800B282C 21800000 */   addu      $s0, $zero, $zero
    /* A3030 800B2830 2800B3AF */  sw         $s3, 0x28($sp)
    /* A3034 800B2834 21A80002 */  addu       $s5, $s0, $zero
    /* A3038 800B2838 21A00002 */  addu       $s4, $s0, $zero
    /* A303C 800B283C 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* A3040 800B2840 E0655324 */  addiu      $s3, $v0, %lo(R3DCar_ObjectInfo)
  .L800B2844:
    /* A3044 800B2844 3900022A */  slti       $v0, $s0, 0x39
    /* A3048 800B2848 B8004010 */  beqz       $v0, .L800B2B2C
    /* A304C 800B284C 40101600 */   sll       $v0, $s6, 1
    /* A3050 800B2850 21105600 */  addu       $v0, $v0, $s6
    /* A3054 800B2854 C0100200 */  sll        $v0, $v0, 3
    /* A3058 800B2858 21105600 */  addu       $v0, $v0, $s6
    /* A305C 800B285C 2800AB8F */  lw         $t3, 0x28($sp)
    /* A3060 800B2860 C0100200 */  sll        $v0, $v0, 3
    /* A3064 800B2864 21106201 */  addu       $v0, $t3, $v0
    /* A3068 800B2868 11800B3C */  lui        $t3, %hi(R3DCar_LoadedScenePointer)
    /* A306C 800B286C 08696B25 */  addiu      $t3, $t3, %lo(R3DCar_LoadedScenePointer)
    /* A3070 800B2870 21104B00 */  addu       $v0, $v0, $t3
    /* A3074 800B2874 0000438C */  lw         $v1, 0x0($v0)
    /* A3078 800B2878 80101000 */  sll        $v0, $s0, 2
    /* A307C 800B287C 21186200 */  addu       $v1, $v1, $v0
    /* A3080 800B2880 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
    /* A3084 800B2884 AC684224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectVisible)
    /* A3088 800B2888 0000668C */  lw         $a2, 0x0($v1)
    /* A308C 800B288C 21100202 */  addu       $v0, $s0, $v0
    /* A3090 800B2890 0200C394 */  lhu        $v1, 0x2($a2)
    /* A3094 800B2894 00004990 */  lbu        $t1, 0x0($v0)
    /* A3098 800B2898 9F006010 */  beqz       $v1, .L800B2B18
    /* A309C 800B289C 00000000 */   nop
    /* A30A0 800B28A0 9D002011 */  beqz       $t1, .L800B2B18
    /* A30A4 800B28A4 1C00222A */   slti      $v0, $s1, 0x1C
    /* A30A8 800B28A8 01006A82 */  lb         $t2, 0x1($s3)
    /* A30AC 800B28AC 00006882 */  lb         $t0, 0x0($s3)
    /* A30B0 800B28B0 0C004010 */  beqz       $v0, .L800B28E4
    /* A30B4 800B28B4 21B80000 */   addu      $s7, $zero, $zero
    /* A30B8 800B28B8 E4FF0226 */  addiu      $v0, $s0, -0x1C
    /* A30BC 800B28BC 0200422C */  sltiu      $v0, $v0, 0x2
    /* A30C0 800B28C0 08004010 */  beqz       $v0, .L800B28E4
    /* A30C4 800B28C4 1180023C */   lui       $v0, %hi(R3DCar_RecessedLight)
    /* A30C8 800B28C8 28684224 */  addiu      $v0, $v0, %lo(R3DCar_RecessedLight)
    /* A30CC 800B28CC 21102202 */  addu       $v0, $s1, $v0
    /* A30D0 800B28D0 00004290 */  lbu        $v0, 0x0($v0)
    /* A30D4 800B28D4 00000000 */  nop
    /* A30D8 800B28D8 02004010 */  beqz       $v0, .L800B28E4
    /* A30DC 800B28DC 00000000 */   nop
    /* A30E0 800B28E0 23400800 */  negu       $t0, $t0
  .L800B28E4:
    /* A30E4 800B28E4 2000AB8F */  lw         $t3, 0x20($sp)
    /* A30E8 800B28E8 00000000 */  nop
    /* A30EC 800B28EC 09006011 */  beqz       $t3, .L800B2914
    /* A30F0 800B28F0 2300022A */   slti      $v0, $s0, 0x23
    /* A30F4 800B28F4 07004014 */  bnez       $v0, .L800B2914
    /* A30F8 800B28F8 2900022A */   slti      $v0, $s0, 0x29
    /* A30FC 800B28FC 05004010 */  beqz       $v0, .L800B2914
    /* A3100 800B2900 00000000 */   nop
    /* A3104 800B2904 0C00428E */  lw         $v0, (0x1F80000C & 0xFFFF)($s2)
    /* A3108 800B2908 01001724 */  addiu      $s7, $zero, 0x1
    /* A310C 800B290C 26105700 */  xor        $v0, $v0, $s7
    /* A3110 800B2910 0C0042AE */  sw         $v0, (0x1F80000C & 0xFFFF)($s2)
  .L800B2914:
    /* A3114 800B2914 EFFF2925 */  addiu      $t1, $t1, -0x11
    /* A3118 800B2918 50002005 */  bltz       $t1, .L800B2A5C
    /* A311C 800B291C 21382001 */   addu      $a3, $t1, $zero
    /* A3120 800B2920 1C00222A */  slti       $v0, $s1, 0x1C
    /* A3124 800B2924 3A004010 */  beqz       $v0, .L800B2A10
    /* A3128 800B2928 FFFF0324 */   addiu     $v1, $zero, -0x1
    /* A312C 800B292C 1600222A */  slti       $v0, $s1, 0x16
    /* A3130 800B2930 28004014 */  bnez       $v0, .L800B29D4
    /* A3134 800B2934 04000224 */   addiu     $v0, $zero, 0x4
    /* A3138 800B2938 EAFF2426 */  addiu      $a0, $s1, -0x16
    /* A313C 800B293C 80100400 */  sll        $v0, $a0, 2
    /* A3140 800B2940 21104400 */  addu       $v0, $v0, $a0
    /* A3144 800B2944 11800B3C */  lui        $t3, %hi(R3DCar_CopIndex)
    /* A3148 800B2948 7C686B25 */  addiu      $t3, $t3, %lo(R3DCar_CopIndex)
    /* A314C 800B294C 1180053C */  lui        $a1, %hi(R3DCar_FlareCopSirenType)
    /* A3150 800B2950 4208C393 */  lbu        $v1, 0x842($fp)
    /* A3154 800B2954 5867A524 */  addiu      $a1, $a1, %lo(R3DCar_FlareCopSirenType)
    /* A3158 800B2958 7F006330 */  andi       $v1, $v1, 0x7F
    /* A315C 800B295C 21186200 */  addu       $v1, $v1, $v0
    /* A3160 800B2960 21186B00 */  addu       $v1, $v1, $t3
    /* A3164 800B2964 00006490 */  lbu        $a0, 0x0($v1)
    /* A3168 800B2968 40180700 */  sll        $v1, $a3, 1
    /* A316C 800B296C 40100400 */  sll        $v0, $a0, 1
    /* A3170 800B2970 21104400 */  addu       $v0, $v0, $a0
    /* A3174 800B2974 80100200 */  sll        $v0, $v0, 2
    /* A3178 800B2978 21186200 */  addu       $v1, $v1, $v0
    /* A317C 800B297C 21186500 */  addu       $v1, $v1, $a1
    /* A3180 800B2980 00006284 */  lh         $v0, 0x0($v1)
    /* A3184 800B2984 00000000 */  nop
    /* A3188 800B2988 02004010 */  beqz       $v0, .L800B2994
    /* A318C 800B298C 00000000 */   nop
    /* A3190 800B2990 21384000 */  addu       $a3, $v0, $zero
  .L800B2994:
    /* A3194 800B2994 10004231 */  andi       $v0, $t2, 0x10
    /* A3198 800B2998 08004010 */  beqz       $v0, .L800B29BC
    /* A319C 800B299C 1180033C */   lui       $v1, %hi(R3DCar_FlareOverlayIndex)
    /* A31A0 800B29A0 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A31A4 800B29A4 00000000 */  nop
    /* A31A8 800B29A8 80004230 */  andi       $v0, $v0, 0x80
    /* A31AC 800B29AC 04004010 */  beqz       $v0, .L800B29C0
    /* A31B0 800B29B0 4C676324 */   addiu     $v1, $v1, %lo(R3DCar_FlareOverlayIndex)
    /* A31B4 800B29B4 21400000 */  addu       $t0, $zero, $zero
    /* A31B8 800B29B8 1180033C */  lui        $v1, %hi(R3DCar_FlareOverlayIndex)
  .L800B29BC:
    /* A31BC 800B29BC 4C676324 */  addiu      $v1, $v1, %lo(R3DCar_FlareOverlayIndex)
  .L800B29C0:
    /* A31C0 800B29C0 40100900 */  sll        $v0, $t1, 1
    /* A31C4 800B29C4 21104300 */  addu       $v0, $v0, $v1
    /* A31C8 800B29C8 00004384 */  lh         $v1, 0x0($v0)
    /* A31CC 800B29CC 7FCA0208 */  j          .L800B29FC
    /* A31D0 800B29D0 1600222A */   slti      $v0, $s1, 0x16
  .L800B29D4:
    /* A31D4 800B29D4 0900E214 */  bne        $a3, $v0, .L800B29FC
    /* A31D8 800B29D8 1600222A */   slti      $v0, $s1, 0x16
    /* A31DC 800B29DC 1180023C */  lui        $v0, %hi(R3DCar_SignalBrakeFlare)
    /* A31E0 800B29E0 0C684224 */  addiu      $v0, $v0, %lo(R3DCar_SignalBrakeFlare)
    /* A31E4 800B29E4 21102202 */  addu       $v0, $s1, $v0
    /* A31E8 800B29E8 00004290 */  lbu        $v0, 0x0($v0)
    /* A31EC 800B29EC 00000000 */  nop
    /* A31F0 800B29F0 02004010 */  beqz       $v0, .L800B29FC
    /* A31F4 800B29F4 1600222A */   slti      $v0, $s1, 0x16
    /* A31F8 800B29F8 01000724 */  addiu      $a3, $zero, 0x1
  .L800B29FC:
    /* A31FC 800B29FC 04004014 */  bnez       $v0, .L800B2A10
    /* A3200 800B2A00 01000224 */   addiu     $v0, $zero, 0x1
    /* A3204 800B2A04 0200E214 */  bne        $a3, $v0, .L800B2A10
    /* A3208 800B2A08 00000000 */   nop
    /* A320C 800B2A0C 01060724 */  addiu      $a3, $zero, 0x601
  .L800B2A10:
    /* A3210 800B2A10 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A3214 800B2A14 00000000 */  nop
    /* A3218 800B2A18 80004230 */  andi       $v0, $v0, 0x80
    /* A321C 800B2A1C 02004010 */  beqz       $v0, .L800B2A28
    /* A3220 800B2A20 00000000 */   nop
    /* A3224 800B2A24 8080E734 */  ori        $a3, $a3, 0x8080
  .L800B2A28:
    /* A3228 800B2A28 6808C28F */  lw         $v0, 0x868($fp)
    /* A322C 800B2A2C 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* A3230 800B2A30 400E858F */  lw         $a1, %gp_rel(R3DCar_position)($gp)
    /* A3234 800B2A34 1000A3AF */  sw         $v1, 0x10($sp)
    /* A3238 800B2A38 1400A0AF */  sw         $zero, 0x14($sp)
    /* A323C 800B2A3C 1800B2AF */  sw         $s2, 0x18($sp)
    /* A3240 800B2A40 21209400 */  addu       $a0, $a0, $s4
    /* A3244 800B2A44 2128B500 */  addu       $a1, $a1, $s5
    /* A3248 800B2A48 21104800 */  addu       $v0, $v0, $t0
    /* A324C 800B2A4C 8C0E030C */  jal        DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
    /* A3250 800B2A50 400042AE */   sw        $v0, (0x1F800040 & 0xFFFF)($s2)
    /* A3254 800B2A54 C0CA0208 */  j          .L800B2B00
    /* A3258 800B2A58 00000000 */   nop
  .L800B2A5C:
    /* A325C 800B2A5C 1C00222A */  slti       $v0, $s1, 0x1C
    /* A3260 800B2A60 09004014 */  bnez       $v0, .L800B2A88
    /* A3264 800B2A64 10004231 */   andi      $v0, $t2, 0x10
    /* A3268 800B2A68 1C000224 */  addiu      $v0, $zero, 0x1C
    /* A326C 800B2A6C 10002216 */  bne        $s1, $v0, .L800B2AB0
    /* A3270 800B2A70 80004A31 */   andi      $t2, $t2, 0x80
    /* A3274 800B2A74 23000224 */  addiu      $v0, $zero, 0x23
    /* A3278 800B2A78 0E000216 */  bne        $s0, $v0, .L800B2AB4
    /* A327C 800B2A7C 80004231 */   andi      $v0, $t2, 0x80
    /* A3280 800B2A80 ADCA0208 */  j          .L800B2AB4
    /* A3284 800B2A84 04000824 */   addiu     $t0, $zero, 0x4
  .L800B2A88:
    /* A3288 800B2A88 09004010 */  beqz       $v0, .L800B2AB0
    /* A328C 800B2A8C 1600222A */   slti      $v0, $s1, 0x16
    /* A3290 800B2A90 08004014 */  bnez       $v0, .L800B2AB4
    /* A3294 800B2A94 80004231 */   andi      $v0, $t2, 0x80
    /* A3298 800B2A98 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A329C 800B2A9C 00000000 */  nop
    /* A32A0 800B2AA0 80004230 */  andi       $v0, $v0, 0x80
    /* A32A4 800B2AA4 02004010 */  beqz       $v0, .L800B2AB0
    /* A32A8 800B2AA8 0C000825 */   addiu     $t0, $t0, 0xC
    /* A32AC 800B2AAC 23400800 */  negu       $t0, $t0
  .L800B2AB0:
    /* A32B0 800B2AB0 80004231 */  andi       $v0, $t2, 0x80
  .L800B2AB4:
    /* A32B4 800B2AB4 07004010 */  beqz       $v0, .L800B2AD4
    /* A32B8 800B2AB8 00000000 */   nop
    /* A32BC 800B2ABC D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A32C0 800B2AC0 00000000 */  nop
    /* A32C4 800B2AC4 80004230 */  andi       $v0, $v0, 0x80
    /* A32C8 800B2AC8 02004010 */  beqz       $v0, .L800B2AD4
    /* A32CC 800B2ACC 00000000 */   nop
    /* A32D0 800B2AD0 23400800 */  negu       $t0, $t0
  .L800B2AD4:
    /* A32D4 800B2AD4 6808C28F */  lw         $v0, 0x868($fp)
    /* A32D8 800B2AD8 2400A78F */  lw         $a3, 0x24($sp)
    /* A32DC 800B2ADC 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* A32E0 800B2AE0 400E858F */  lw         $a1, %gp_rel(R3DCar_position)($gp)
    /* A32E4 800B2AE4 1000AAAF */  sw         $t2, 0x10($sp)
    /* A32E8 800B2AE8 1400B2AF */  sw         $s2, 0x14($sp)
    /* A32EC 800B2AEC 21209400 */  addu       $a0, $a0, $s4
    /* A32F0 800B2AF0 2128B500 */  addu       $a1, $a1, $s5
    /* A32F4 800B2AF4 21104800 */  addu       $v0, $v0, $t0
    /* A32F8 800B2AF8 AC0C030C */  jal        DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* A32FC 800B2AFC 400042AE */   sw        $v0, (0x1F800040 & 0xFFFF)($s2)
  .L800B2B00:
    /* A3300 800B2B00 0500E012 */  beqz       $s7, .L800B2B18
    /* A3304 800B2B04 00000000 */   nop
    /* A3308 800B2B08 0C00428E */  lw         $v0, (0x1F80000C & 0xFFFF)($s2)
    /* A330C 800B2B0C 00000000 */  nop
    /* A3310 800B2B10 01004238 */  xori       $v0, $v0, 0x1
    /* A3314 800B2B14 0C0042AE */  sw         $v0, (0x1F80000C & 0xFFFF)($s2)
  .L800B2B18:
    /* A3318 800B2B18 0C00B526 */  addiu      $s5, $s5, 0xC
    /* A331C 800B2B1C 24009426 */  addiu      $s4, $s4, 0x24
    /* A3320 800B2B20 06007326 */  addiu      $s3, $s3, 0x6
    /* A3324 800B2B24 11CA0208 */  j          .L800B2844
    /* A3328 800B2B28 01001026 */   addiu     $s0, $s0, 0x1
  .L800B2B2C:
    /* A332C 800B2B2C 2120C003 */  addu       $a0, $fp, $zero
    /* A3330 800B2B30 21FF020C */  jal        DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
    /* A3334 800B2B34 21284002 */   addu      $a1, $s2, $zero
    /* A3338 800B2B38 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* A333C 800B2B3C 00000000 */  nop
    /* A3340 800B2B40 80004230 */  andi       $v0, $v0, 0x80
    /* A3344 800B2B44 04004014 */  bnez       $v0, .L800B2B58
    /* A3348 800B2B48 1180043C */   lui       $a0, %hi(R3DCar_shadowVertex)
    /* A334C 800B2B4C E8688424 */  addiu      $a0, $a0, %lo(R3DCar_shadowVertex)
    /* A3350 800B2B50 B110030C */  jal        DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
    /* A3354 800B2B54 21284002 */   addu      $a1, $s2, $zero
  .L800B2B58:
    /* A3358 800B2B58 5400BF8F */  lw         $ra, 0x54($sp)
    /* A335C 800B2B5C 5000BE8F */  lw         $fp, 0x50($sp)
    /* A3360 800B2B60 4C00B78F */  lw         $s7, 0x4C($sp)
    /* A3364 800B2B64 4800B68F */  lw         $s6, 0x48($sp)
    /* A3368 800B2B68 4400B58F */  lw         $s5, 0x44($sp)
    /* A336C 800B2B6C 4000B48F */  lw         $s4, 0x40($sp)
    /* A3370 800B2B70 3C00B38F */  lw         $s3, 0x3C($sp)
    /* A3374 800B2B74 3800B28F */  lw         $s2, 0x38($sp)
    /* A3378 800B2B78 3400B18F */  lw         $s1, 0x34($sp)
    /* A337C 800B2B7C 3000B08F */  lw         $s0, 0x30($sp)
    /* A3380 800B2B80 0800E003 */  jr         $ra
    /* A3384 800B2B84 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel R3DCar_InsertCarFacetMenuII__FP8Car_tObji
