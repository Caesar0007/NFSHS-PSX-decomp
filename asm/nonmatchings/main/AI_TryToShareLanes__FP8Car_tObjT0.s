.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_TryToShareLanes__FP8Car_tObjT0, 0xFC

glabel AI_TryToShareLanes__FP8Car_tObjT0
    /* 4A860 8005A060 21488000 */  addu       $t1, $a0, $zero
    /* 4A864 8005A064 1180033C */  lui        $v1, %hi(D_8010CD2C)
    /* 4A868 8005A068 3401248D */  lw         $a0, 0x134($t1)
    /* 4A86C 8005A06C 2CCD668C */  lw         $a2, %lo(D_8010CD2C)($v1)
    /* 4A870 8005A070 C2170400 */  srl        $v0, $a0, 31
    /* 4A874 8005A074 21108200 */  addu       $v0, $a0, $v0
    /* 4A878 8005A078 43100200 */  sra        $v0, $v0, 1
    /* 4A87C 8005A07C 21208200 */  addu       $a0, $a0, $v0
    /* 4A880 8005A080 0700C228 */  slti       $v0, $a2, 0x7
    /* 4A884 8005A084 0D004014 */  bnez       $v0, .L8005A0BC
    /* 4A888 8005A088 00000000 */   nop
    /* 4A88C 8005A08C 0800A284 */  lh         $v0, 0x8($a1)
    /* 4A890 8005A090 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4A894 8005A094 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4A898 8005A098 40110200 */  sll        $v0, $v0, 5
    /* 4A89C 8005A09C 21104300 */  addu       $v0, $v0, $v1
    /* 4A8A0 8005A0A0 1F004290 */  lbu        $v0, 0x1F($v0)
    /* 4A8A4 8005A0A4 F9FFC324 */  addiu      $v1, $a2, -0x7
    /* 4A8A8 8005A0A8 C0130200 */  sll        $v0, $v0, 15
    /* 4A8AC 8005A0AC 18006200 */  mult       $v1, $v0
    /* 4A8B0 8005A0B0 12300000 */  mflo       $a2
    /* 4A8B4 8005A0B4 3A680108 */  j          .L8005A0E8
    /* 4A8B8 8005A0B8 2138C200 */   addu      $a3, $a2, $v0
  .L8005A0BC:
    /* 4A8BC 8005A0BC 0800A284 */  lh         $v0, 0x8($a1)
    /* 4A8C0 8005A0C0 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4A8C4 8005A0C4 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4A8C8 8005A0C8 40110200 */  sll        $v0, $v0, 5
    /* 4A8CC 8005A0CC 21104300 */  addu       $v0, $v0, $v1
    /* 4A8D0 8005A0D0 1E004290 */  lbu        $v0, 0x1E($v0)
    /* 4A8D4 8005A0D4 FAFFC324 */  addiu      $v1, $a2, -0x6
    /* 4A8D8 8005A0D8 C0130200 */  sll        $v0, $v0, 15
    /* 4A8DC 8005A0DC 18006200 */  mult       $v1, $v0
    /* 4A8E0 8005A0E0 12380000 */  mflo       $a3
    /* 4A8E4 8005A0E4 2330E200 */  subu       $a2, $a3, $v0
  .L8005A0E8:
    /* 4A8E8 8005A0E8 7405A38C */  lw         $v1, 0x574($a1)
    /* 4A8EC 8005A0EC 6C02A28C */  lw         $v0, 0x26C($a1)
    /* 4A8F0 8005A0F0 00000000 */  nop
    /* 4A8F4 8005A0F4 23406200 */  subu       $t0, $v1, $v0
    /* 4A8F8 8005A0F8 23280601 */  subu       $a1, $t0, $a2
    /* 4A8FC 8005A0FC 21306200 */  addu       $a2, $v1, $v0
    /* 4A900 8005A100 2318E600 */  subu       $v1, $a3, $a2
    /* 4A904 8005A104 2A108300 */  slt        $v0, $a0, $v1
    /* 4A908 8005A108 04004014 */  bnez       $v0, .L8005A11C
    /* 4A90C 8005A10C 2A10A300 */   slt       $v0, $a1, $v1
    /* 4A910 8005A110 2A108500 */  slt        $v0, $a0, $a1
    /* 4A914 8005A114 0F004010 */  beqz       $v0, .L8005A154
    /* 4A918 8005A118 2A10A300 */   slt       $v0, $a1, $v1
  .L8005A11C:
    /* 4A91C 8005A11C 06004010 */  beqz       $v0, .L8005A138
    /* 4A920 8005A120 00000000 */   nop
    /* 4A924 8005A124 C2170300 */  srl        $v0, $v1, 31
    /* 4A928 8005A128 21106200 */  addu       $v0, $v1, $v0
    /* 4A92C 8005A12C 43100200 */  sra        $v0, $v0, 1
    /* 4A930 8005A130 52680108 */  j          .L8005A148
    /* 4A934 8005A134 2110C200 */   addu      $v0, $a2, $v0
  .L8005A138:
    /* 4A938 8005A138 C2170500 */  srl        $v0, $a1, 31
    /* 4A93C 8005A13C 2110A200 */  addu       $v0, $a1, $v0
    /* 4A940 8005A140 43100200 */  sra        $v0, $v0, 1
    /* 4A944 8005A144 23100201 */  subu       $v0, $t0, $v0
  .L8005A148:
    /* 4A948 8005A148 580522AD */  sw         $v0, 0x558($t1)
    /* 4A94C 8005A14C 0800E003 */  jr         $ra
    /* 4A950 8005A150 01000224 */   addiu     $v0, $zero, 0x1
  .L8005A154:
    /* 4A954 8005A154 0800E003 */  jr         $ra
    /* 4A958 8005A158 21100000 */   addu      $v0, $zero, $zero
endlabel AI_TryToShareLanes__FP8Car_tObjT0
