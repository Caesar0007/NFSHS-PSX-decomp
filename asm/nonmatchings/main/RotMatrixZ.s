.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RotMatrixZ, 0x198

glabel RotMatrixZ
    /* E392C 800F312C 21788000 */  addu       $t7, $a0, $zero
    /* E3930 800F3130 2110A000 */  addu       $v0, $a1, $zero
    /* E3934 800F3134 0E00E105 */  bgez       $t7, .L800F3170
    /* E3938 800F3138 FF0FF931 */   andi      $t9, $t7, 0xFFF
    /* E393C 800F313C 23780F00 */  negu       $t7, $t7
    /* E3940 800F3140 0100E105 */  bgez       $t7, .L800F3148
    /* E3944 800F3144 FF0FEF31 */   andi      $t7, $t7, 0xFFF
  .L800F3148:
    /* E3948 800F3148 80C00F00 */  sll        $t8, $t7, 2
    /* E394C 800F314C 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E3950 800F3150 21C83803 */  addu       $t9, $t9, $t8
    /* E3954 800F3154 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E3958 800F3158 00000000 */  nop
    /* E395C 800F315C 00741900 */  sll        $t6, $t9, 16
    /* E3960 800F3160 03740E00 */  sra        $t6, $t6, 16
    /* E3964 800F3164 23480E00 */  negu       $t1, $t6
    /* E3968 800F3168 64CC0308 */  j          .L800F3190
    /* E396C 800F316C 03441900 */   sra       $t0, $t9, 16
  .L800F3170:
    /* E3970 800F3170 80C01900 */  sll        $t8, $t9, 2
    /* E3974 800F3174 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E3978 800F3178 21C83803 */  addu       $t9, $t9, $t8
    /* E397C 800F317C 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E3980 800F3180 00000000 */  nop
    /* E3984 800F3184 00C41900 */  sll        $t8, $t9, 16
    /* E3988 800F3188 034C1800 */  sra        $t1, $t8, 16
    /* E398C 800F318C 03441900 */  sra        $t0, $t9, 16
  .L800F3190:
    /* E3990 800F3190 0000AA84 */  lh         $t2, 0x0($a1)
    /* E3994 800F3194 0600AD84 */  lh         $t5, 0x6($a1)
    /* E3998 800F3198 19000A01 */  multu      $t0, $t2
    /* E399C 800F319C 0200AB84 */  lh         $t3, 0x2($a1)
    /* E39A0 800F31A0 0800AE84 */  lh         $t6, 0x8($a1)
    /* E39A4 800F31A4 12C00000 */  mflo       $t8
    /* E39A8 800F31A8 0400AC84 */  lh         $t4, 0x4($a1)
    /* E39AC 800F31AC 0A00AF84 */  lh         $t7, 0xA($a1)
    /* E39B0 800F31B0 19002D01 */  multu      $t1, $t5
    /* E39B4 800F31B4 00000000 */  nop
    /* E39B8 800F31B8 00000000 */  nop
    /* E39BC 800F31BC 12C80000 */  mflo       $t9
    /* E39C0 800F31C0 23C81903 */  subu       $t9, $t8, $t9
    /* E39C4 800F31C4 03C31900 */  sra        $t8, $t9, 12
    /* E39C8 800F31C8 19000B01 */  multu      $t0, $t3
    /* E39CC 800F31CC 0000B8A4 */  sh         $t8, 0x0($a1)
    /* E39D0 800F31D0 00000000 */  nop
    /* E39D4 800F31D4 12C00000 */  mflo       $t8
    /* E39D8 800F31D8 00000000 */  nop
    /* E39DC 800F31DC 00000000 */  nop
    /* E39E0 800F31E0 19002E01 */  multu      $t1, $t6
    /* E39E4 800F31E4 00000000 */  nop
    /* E39E8 800F31E8 00000000 */  nop
    /* E39EC 800F31EC 12C80000 */  mflo       $t9
    /* E39F0 800F31F0 23C81903 */  subu       $t9, $t8, $t9
    /* E39F4 800F31F4 03C31900 */  sra        $t8, $t9, 12
    /* E39F8 800F31F8 19000C01 */  multu      $t0, $t4
    /* E39FC 800F31FC 0200B8A4 */  sh         $t8, 0x2($a1)
    /* E3A00 800F3200 00000000 */  nop
    /* E3A04 800F3204 12C00000 */  mflo       $t8
    /* E3A08 800F3208 00000000 */  nop
    /* E3A0C 800F320C 00000000 */  nop
    /* E3A10 800F3210 19002F01 */  multu      $t1, $t7
    /* E3A14 800F3214 00000000 */  nop
    /* E3A18 800F3218 00000000 */  nop
    /* E3A1C 800F321C 12C80000 */  mflo       $t9
    /* E3A20 800F3220 23C81903 */  subu       $t9, $t8, $t9
    /* E3A24 800F3224 03C31900 */  sra        $t8, $t9, 12
    /* E3A28 800F3228 19002A01 */  multu      $t1, $t2
    /* E3A2C 800F322C 0400B8A4 */  sh         $t8, 0x4($a1)
    /* E3A30 800F3230 00000000 */  nop
    /* E3A34 800F3234 12C00000 */  mflo       $t8
    /* E3A38 800F3238 00000000 */  nop
    /* E3A3C 800F323C 00000000 */  nop
    /* E3A40 800F3240 19000D01 */  multu      $t0, $t5
    /* E3A44 800F3244 00000000 */  nop
    /* E3A48 800F3248 00000000 */  nop
    /* E3A4C 800F324C 12C80000 */  mflo       $t9
    /* E3A50 800F3250 21C81903 */  addu       $t9, $t8, $t9
    /* E3A54 800F3254 03C31900 */  sra        $t8, $t9, 12
    /* E3A58 800F3258 19002B01 */  multu      $t1, $t3
    /* E3A5C 800F325C 0600B8A4 */  sh         $t8, 0x6($a1)
    /* E3A60 800F3260 00000000 */  nop
    /* E3A64 800F3264 12C00000 */  mflo       $t8
    /* E3A68 800F3268 00000000 */  nop
    /* E3A6C 800F326C 00000000 */  nop
    /* E3A70 800F3270 19000E01 */  multu      $t0, $t6
    /* E3A74 800F3274 00000000 */  nop
    /* E3A78 800F3278 00000000 */  nop
    /* E3A7C 800F327C 12C80000 */  mflo       $t9
    /* E3A80 800F3280 21C81903 */  addu       $t9, $t8, $t9
    /* E3A84 800F3284 03C31900 */  sra        $t8, $t9, 12
    /* E3A88 800F3288 19002C01 */  multu      $t1, $t4
    /* E3A8C 800F328C 0800B8A4 */  sh         $t8, 0x8($a1)
    /* E3A90 800F3290 00000000 */  nop
    /* E3A94 800F3294 12C00000 */  mflo       $t8
    /* E3A98 800F3298 00000000 */  nop
    /* E3A9C 800F329C 00000000 */  nop
    /* E3AA0 800F32A0 19000F01 */  multu      $t0, $t7
    /* E3AA4 800F32A4 00000000 */  nop
    /* E3AA8 800F32A8 00000000 */  nop
    /* E3AAC 800F32AC 12C80000 */  mflo       $t9
    /* E3AB0 800F32B0 21C81903 */  addu       $t9, $t8, $t9
    /* E3AB4 800F32B4 03C31900 */  sra        $t8, $t9, 12
    /* E3AB8 800F32B8 0A00B8A4 */  sh         $t8, 0xA($a1)
    /* E3ABC 800F32BC 0800E003 */  jr         $ra
    /* E3AC0 800F32C0 00000000 */   nop
endlabel RotMatrixZ
    /* E3AC4 800F32C4 00000000 */  nop
    /* E3AC8 800F32C8 00000000 */  nop
