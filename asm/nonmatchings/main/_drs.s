.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _drs, 0x280

glabel _drs
    /* DF7C8 800EEFC8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DF7CC 800EEFCC 1400B1AF */  sw         $s1, 0x14($sp)
    /* DF7D0 800EEFD0 21888000 */  addu       $s1, $a0, $zero
    /* DF7D4 800EEFD4 1800B2AF */  sw         $s2, 0x18($sp)
    /* DF7D8 800EEFD8 2190A000 */  addu       $s2, $a1, $zero
    /* DF7DC 800EEFDC 2400BFAF */  sw         $ra, 0x24($sp)
    /* DF7E0 800EEFE0 2000B4AF */  sw         $s4, 0x20($sp)
    /* DF7E4 800EEFE4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DF7E8 800EEFE8 BEBE030C */  jal        _gpu_arm_timeout
    /* DF7EC 800EEFEC 1000B0AF */   sw        $s0, 0x10($sp)
    /* DF7F0 800EEFF0 04002586 */  lh         $a1, 0x4($s1)
    /* DF7F4 800EEFF4 04002396 */  lhu        $v1, 0x4($s1)
    /* DF7F8 800EEFF8 0A00A004 */  bltz       $a1, .L800EF024
    /* DF7FC 800EEFFC 21206000 */   addu      $a0, $v1, $zero
    /* DF800 800EF000 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DF804 800EF004 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DF808 800EF008 1280033C */  lui        $v1, %hi(D_801236A0)
    /* DF80C 800EF00C A0366394 */  lhu        $v1, %lo(D_801236A0)($v1)
    /* DF810 800EF010 2A104500 */  slt        $v0, $v0, $a1
    /* DF814 800EF014 04004010 */  beqz       $v0, .L800EF028
    /* DF818 800EF018 00000000 */   nop
    /* DF81C 800EF01C 0ABC0308 */  j          .L800EF028
    /* DF820 800EF020 21206000 */   addu      $a0, $v1, $zero
  .L800EF024:
    /* DF824 800EF024 21200000 */  addu       $a0, $zero, $zero
  .L800EF028:
    /* DF828 800EF028 06002586 */  lh         $a1, 0x6($s1)
    /* DF82C 800EF02C 06002396 */  lhu        $v1, 0x6($s1)
    /* DF830 800EF030 0B00A004 */  bltz       $a1, .L800EF060
    /* DF834 800EF034 040024A6 */   sh        $a0, 0x4($s1)
    /* DF838 800EF038 21206000 */  addu       $a0, $v1, $zero
    /* DF83C 800EF03C 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DF840 800EF040 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DF844 800EF044 1280033C */  lui        $v1, %hi(D_801236A2)
    /* DF848 800EF048 A2366394 */  lhu        $v1, %lo(D_801236A2)($v1)
    /* DF84C 800EF04C 2A104500 */  slt        $v0, $v0, $a1
    /* DF850 800EF050 05004010 */  beqz       $v0, .L800EF068
    /* DF854 800EF054 00140400 */   sll       $v0, $a0, 16
    /* DF858 800EF058 19BC0308 */  j          .L800EF064
    /* DF85C 800EF05C 21206000 */   addu      $a0, $v1, $zero
  .L800EF060:
    /* DF860 800EF060 21200000 */  addu       $a0, $zero, $zero
  .L800EF064:
    /* DF864 800EF064 00140400 */  sll        $v0, $a0, 16
  .L800EF068:
    /* DF868 800EF068 04002386 */  lh         $v1, 0x4($s1)
    /* DF86C 800EF06C 03140200 */  sra        $v0, $v0, 16
    /* DF870 800EF070 18006200 */  mult       $v1, $v0
    /* DF874 800EF074 060024A6 */  sh         $a0, 0x6($s1)
    /* DF878 800EF078 12300000 */  mflo       $a2
    /* DF87C 800EF07C 0100C324 */  addiu      $v1, $a2, 0x1
    /* DF880 800EF080 C2170300 */  srl        $v0, $v1, 31
    /* DF884 800EF084 21186200 */  addu       $v1, $v1, $v0
    /* DF888 800EF088 43200300 */  sra        $a0, $v1, 1
    /* DF88C 800EF08C 0300801C */  bgtz       $a0, .L800EF09C
    /* DF890 800EF090 43810300 */   sra       $s0, $v1, 5
    /* DF894 800EF094 8ABC0308 */  j          .L800EF228
    /* DF898 800EF098 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EF09C:
    /* DF89C 800EF09C 21180002 */  addu       $v1, $s0, $zero
    /* DF8A0 800EF0A0 00110300 */  sll        $v0, $v1, 4
    /* DF8A4 800EF0A4 23808200 */  subu       $s0, $a0, $v0
    /* DF8A8 800EF0A8 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF8AC 800EF0AC A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF8B0 800EF0B0 21A06000 */  addu       $s4, $v1, $zero
    /* DF8B4 800EF0B4 0000428C */  lw         $v0, 0x0($v0)
    /* DF8B8 800EF0B8 0004033C */  lui        $v1, (0x4000000 >> 16)
    /* DF8BC 800EF0BC 24104300 */  and        $v0, $v0, $v1
    /* DF8C0 800EF0C0 0E004014 */  bnez       $v0, .L800EF0FC
    /* DF8C4 800EF0C4 00000000 */   nop
    /* DF8C8 800EF0C8 0004133C */  lui        $s3, (0x4000000 >> 16)
  .L800EF0CC:
    /* DF8CC 800EF0CC CBBE030C */  jal        _gpu_check_timeout
    /* DF8D0 800EF0D0 00000000 */   nop
    /* DF8D4 800EF0D4 54004014 */  bnez       $v0, .L800EF228
    /* DF8D8 800EF0D8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DF8DC 800EF0DC 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF8E0 800EF0E0 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF8E4 800EF0E4 00000000 */  nop
    /* DF8E8 800EF0E8 0000428C */  lw         $v0, 0x0($v0)
    /* DF8EC 800EF0EC 00000000 */  nop
    /* DF8F0 800EF0F0 24105300 */  and        $v0, $v0, $s3
    /* DF8F4 800EF0F4 F5FF4010 */  beqz       $v0, .L800EF0CC
    /* DF8F8 800EF0F8 00000000 */   nop
  .L800EF0FC:
    /* DF8FC 800EF0FC 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DF900 800EF100 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DF904 800EF104 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* DF908 800EF108 000062AC */  sw         $v0, 0x0($v1)
    /* DF90C 800EF10C 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF910 800EF110 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF914 800EF114 0001023C */  lui        $v0, (0x1000000 >> 16)
    /* DF918 800EF118 000062AC */  sw         $v0, 0x0($v1)
    /* DF91C 800EF11C 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF920 800EF120 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF924 800EF124 00C0023C */  lui        $v0, (0xC0000000 >> 16)
    /* DF928 800EF128 000062AC */  sw         $v0, 0x0($v1)
    /* DF92C 800EF12C 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF930 800EF130 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF934 800EF134 0000228E */  lw         $v0, 0x0($s1)
    /* DF938 800EF138 00000000 */  nop
    /* DF93C 800EF13C 000062AC */  sw         $v0, 0x0($v1)
    /* DF940 800EF140 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF944 800EF144 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF948 800EF148 0400228E */  lw         $v0, 0x4($s1)
    /* DF94C 800EF14C 00000000 */  nop
    /* DF950 800EF150 000062AC */  sw         $v0, 0x0($v1)
    /* DF954 800EF154 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF958 800EF158 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF95C 800EF15C 00000000 */  nop
    /* DF960 800EF160 0000428C */  lw         $v0, 0x0($v0)
    /* DF964 800EF164 0008033C */  lui        $v1, (0x8000000 >> 16)
    /* DF968 800EF168 24104300 */  and        $v0, $v0, $v1
    /* DF96C 800EF16C 0E004014 */  bnez       $v0, .L800EF1A8
    /* DF970 800EF170 00000000 */   nop
    /* DF974 800EF174 0008113C */  lui        $s1, (0x8000000 >> 16)
  .L800EF178:
    /* DF978 800EF178 CBBE030C */  jal        _gpu_check_timeout
    /* DF97C 800EF17C 00000000 */   nop
    /* DF980 800EF180 29004014 */  bnez       $v0, .L800EF228
    /* DF984 800EF184 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DF988 800EF188 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF98C 800EF18C A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF990 800EF190 00000000 */  nop
    /* DF994 800EF194 0000428C */  lw         $v0, 0x0($v0)
    /* DF998 800EF198 00000000 */  nop
    /* DF99C 800EF19C 24105100 */  and        $v0, $v0, $s1
    /* DF9A0 800EF1A0 F5FF4010 */  beqz       $v0, .L800EF178
    /* DF9A4 800EF1A4 00000000 */   nop
  .L800EF1A8:
    /* DF9A8 800EF1A8 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* DF9AC 800EF1AC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* DF9B0 800EF1B0 09000212 */  beq        $s0, $v0, .L800EF1D8
    /* DF9B4 800EF1B4 FFFF0324 */   addiu     $v1, $zero, -0x1
  .L800EF1B8:
    /* DF9B8 800EF1B8 1280023C */  lui        $v0, %hi(D_801237A0)
    /* DF9BC 800EF1BC A037428C */  lw         $v0, %lo(D_801237A0)($v0)
    /* DF9C0 800EF1C0 00000000 */  nop
    /* DF9C4 800EF1C4 0000428C */  lw         $v0, 0x0($v0)
    /* DF9C8 800EF1C8 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* DF9CC 800EF1CC 000042AE */  sw         $v0, 0x0($s2)
    /* DF9D0 800EF1D0 F9FF0316 */  bne        $s0, $v1, .L800EF1B8
    /* DF9D4 800EF1D4 04005226 */   addiu     $s2, $s2, 0x4
  .L800EF1D8:
    /* DF9D8 800EF1D8 12008012 */  beqz       $s4, .L800EF224
    /* DF9DC 800EF1DC 0004033C */   lui       $v1, (0x4000003 >> 16)
    /* DF9E0 800EF1E0 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF9E4 800EF1E4 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF9E8 800EF1E8 03006334 */  ori        $v1, $v1, (0x4000003 & 0xFFFF)
    /* DF9EC 800EF1EC 000043AC */  sw         $v1, 0x0($v0)
    /* DF9F0 800EF1F0 1280023C */  lui        $v0, %hi(D_801237A8)
    /* DF9F4 800EF1F4 A837428C */  lw         $v0, %lo(D_801237A8)($v0)
    /* DF9F8 800EF1F8 0001043C */  lui        $a0, (0x1000200 >> 16)
    /* DF9FC 800EF1FC 000052AC */  sw         $s2, 0x0($v0)
    /* DFA00 800EF200 00141400 */  sll        $v0, $s4, 16
    /* DFA04 800EF204 1280033C */  lui        $v1, %hi(D_801237AC)
    /* DFA08 800EF208 AC37638C */  lw         $v1, %lo(D_801237AC)($v1)
    /* DFA0C 800EF20C 10004234 */  ori        $v0, $v0, 0x10
    /* DFA10 800EF210 000062AC */  sw         $v0, 0x0($v1)
    /* DFA14 800EF214 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFA18 800EF218 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFA1C 800EF21C 00028434 */  ori        $a0, $a0, (0x1000200 & 0xFFFF)
    /* DFA20 800EF220 000044AC */  sw         $a0, 0x0($v0)
  .L800EF224:
    /* DFA24 800EF224 21100000 */  addu       $v0, $zero, $zero
  .L800EF228:
    /* DFA28 800EF228 2400BF8F */  lw         $ra, 0x24($sp)
    /* DFA2C 800EF22C 2000B48F */  lw         $s4, 0x20($sp)
    /* DFA30 800EF230 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DFA34 800EF234 1800B28F */  lw         $s2, 0x18($sp)
    /* DFA38 800EF238 1400B18F */  lw         $s1, 0x14($sp)
    /* DFA3C 800EF23C 1000B08F */  lw         $s0, 0x10($sp)
    /* DFA40 800EF240 0800E003 */  jr         $ra
    /* DFA44 800EF244 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _drs
