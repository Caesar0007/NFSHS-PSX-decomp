.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_Logic__Fv, 0x31C

glabel MPause_Logic__Fv
    /* 8EF84 8009E784 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8EF88 8009E788 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8EF8C 8009E78C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 8EF90 8009E790 2400B1AF */  sw         $s1, 0x24($sp)
    /* 8EF94 8009E794 2000B0AF */  sw         $s0, 0x20($sp)
    /* 8EF98 8009E798 52A0020C */  jal        Debounce__6tPMenu
    /* 8EF9C 8009E79C 1800A0AF */   sw        $zero, 0x18($sp)
    /* 8EFA0 8009E7A0 05000424 */  addiu      $a0, $zero, 0x5
    /* 8EFA4 8009E7A4 01000524 */  addiu      $a1, $zero, 0x1
    /* 8EFA8 8009E7A8 C674020C */  jal        Input_Interface__FUli
    /* 8EFAC 8009E7AC 21804000 */   addu      $s0, $v0, $zero
    /* 8EFB0 8009E7B0 1F004014 */  bnez       $v0, .L8009E830
    /* 8EFB4 8009E7B4 02000224 */   addiu     $v0, $zero, 0x2
    /* 8EFB8 8009E7B8 01000424 */  addiu      $a0, $zero, 0x1
    /* 8EFBC 8009E7BC C674020C */  jal        Input_Interface__FUli
    /* 8EFC0 8009E7C0 21288000 */   addu      $a1, $a0, $zero
    /* 8EFC4 8009E7C4 1A004014 */  bnez       $v0, .L8009E830
    /* 8EFC8 8009E7C8 00020224 */   addiu     $v0, $zero, 0x200
    /* 8EFCC 8009E7CC 02000424 */  addiu      $a0, $zero, 0x2
    /* 8EFD0 8009E7D0 C674020C */  jal        Input_Interface__FUli
    /* 8EFD4 8009E7D4 01000524 */   addiu     $a1, $zero, 0x1
    /* 8EFD8 8009E7D8 15004014 */  bnez       $v0, .L8009E830
    /* 8EFDC 8009E7DC 00040224 */   addiu     $v0, $zero, 0x400
    /* 8EFE0 8009E7E0 03000424 */  addiu      $a0, $zero, 0x3
    /* 8EFE4 8009E7E4 C674020C */  jal        Input_Interface__FUli
    /* 8EFE8 8009E7E8 21280002 */   addu      $a1, $s0, $zero
    /* 8EFEC 8009E7EC 10004014 */  bnez       $v0, .L8009E830
    /* 8EFF0 8009E7F0 00080224 */   addiu     $v0, $zero, 0x800
    /* 8EFF4 8009E7F4 04000424 */  addiu      $a0, $zero, 0x4
    /* 8EFF8 8009E7F8 C674020C */  jal        Input_Interface__FUli
    /* 8EFFC 8009E7FC 21280002 */   addu      $a1, $s0, $zero
    /* 8F000 8009E800 0B004014 */  bnez       $v0, .L8009E830
    /* 8F004 8009E804 00100224 */   addiu     $v0, $zero, 0x1000
    /* 8F008 8009E808 06000424 */  addiu      $a0, $zero, 0x6
    /* 8F00C 8009E80C C674020C */  jal        Input_Interface__FUli
    /* 8F010 8009E810 01000524 */   addiu     $a1, $zero, 0x1
    /* 8F014 8009E814 06004014 */  bnez       $v0, .L8009E830
    /* 8F018 8009E818 00200224 */   addiu     $v0, $zero, 0x2000
    /* 8F01C 8009E81C 18000424 */  addiu      $a0, $zero, 0x18
    /* 8F020 8009E820 C674020C */  jal        Input_Interface__FUli
    /* 8F024 8009E824 01000524 */   addiu     $a1, $zero, 0x1
    /* 8F028 8009E828 02004010 */  beqz       $v0, .L8009E834
    /* 8F02C 8009E82C 10000224 */   addiu     $v0, $zero, 0x10
  .L8009E830:
    /* 8F030 8009E830 1800A2AF */  sw         $v0, 0x18($sp)
  .L8009E834:
    /* 8F034 8009E834 6C188287 */  lh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F038 8009E838 00000000 */  nop
    /* 8F03C 8009E83C 37004014 */  bnez       $v0, .L8009E91C
    /* 8F040 8009E840 1000A0AF */   sw        $zero, 0x10($sp)
    /* 8F044 8009E844 1800A28F */  lw         $v0, 0x18($sp)
    /* 8F048 8009E848 00000000 */  nop
    /* 8F04C 8009E84C 2E004010 */  beqz       $v0, .L8009E908
    /* 8F050 8009E850 1800A527 */   addiu     $a1, $sp, 0x18
    /* 8F054 8009E854 01000224 */  addiu      $v0, $zero, 0x1
    /* 8F058 8009E858 7418838F */  lw         $v1, %gp_rel(D_8013DDC0)($gp)
    /* 8F05C 8009E85C 1000A627 */  addiu      $a2, $sp, 0x10
    /* 8F060 8009E860 180D82AF */  sw         $v0, %gp_rel(gMPauseUpdate)($gp)
    /* 8F064 8009E864 5000678C */  lw         $a3, 0x50($v1)
    /* 8F068 8009E868 0000708C */  lw         $s0, 0x0($v1)
    /* 8F06C 8009E86C 1800E484 */  lh         $a0, 0x18($a3)
    /* 8F070 8009E870 1C00E28C */  lw         $v0, 0x1C($a3)
    /* 8F074 8009E874 00000000 */  nop
    /* 8F078 8009E878 09F84000 */  jalr       $v0
    /* 8F07C 8009E87C 21206400 */   addu      $a0, $v1, $a0
    /* 8F080 8009E880 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F084 8009E884 00841000 */  sll        $s0, $s0, 16
    /* 8F088 8009E888 00009184 */  lh         $s1, 0x0($a0)
    /* 8F08C 8009E88C 032C1000 */  sra        $a1, $s0, 16
    /* 8F090 8009E890 2F00B110 */  beq        $a1, $s1, .L8009E950
    /* 8F094 8009E894 00000000 */   nop
    /* 8F098 8009E898 94A1020C */  jal        ItemEnabledNum__6tPMenui
    /* 8F09C 8009E89C 00000000 */   nop
    /* 8F0A0 8009E8A0 21282002 */  addu       $a1, $s1, $zero
    /* 8F0A4 8009E8A4 40800200 */  sll        $s0, $v0, 1
    /* 8F0A8 8009E8A8 21800202 */  addu       $s0, $s0, $v0
    /* 8F0AC 8009E8AC 80801000 */  sll        $s0, $s0, 2
    /* 8F0B0 8009E8B0 21800202 */  addu       $s0, $s0, $v0
    /* 8F0B4 8009E8B4 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F0B8 8009E8B8 94A1020C */  jal        ItemEnabledNum__6tPMenui
    /* 8F0BC 8009E8BC 6A001026 */   addiu     $s0, $s0, 0x6A
    /* 8F0C0 8009E8C0 6666053C */  lui        $a1, (0x66666667 >> 16)
    /* 8F0C4 8009E8C4 6766A534 */  ori        $a1, $a1, (0x66666667 & 0xFFFF)
    /* 8F0C8 8009E8C8 40180200 */  sll        $v1, $v0, 1
    /* 8F0CC 8009E8CC 21186200 */  addu       $v1, $v1, $v0
    /* 8F0D0 8009E8D0 80180300 */  sll        $v1, $v1, 2
    /* 8F0D4 8009E8D4 21186200 */  addu       $v1, $v1, $v0
    /* 8F0D8 8009E8D8 6A006324 */  addiu      $v1, $v1, 0x6A
    /* 8F0DC 8009E8DC 23207000 */  subu       $a0, $v1, $s0
    /* 8F0E0 8009E8E0 18008500 */  mult       $a0, $a1
    /* 8F0E4 8009E8E4 23800302 */  subu       $s0, $s0, $v1
    /* 8F0E8 8009E8E8 C3270400 */  sra        $a0, $a0, 31
    /* 8F0EC 8009E8EC 6C1890A7 */  sh         $s0, %gp_rel(D_8013DDB8)($gp)
    /* 8F0F0 8009E8F0 10400000 */  mfhi       $t0
    /* 8F0F4 8009E8F4 83100800 */  sra        $v0, $t0, 2
    /* 8F0F8 8009E8F8 23104400 */  subu       $v0, $v0, $a0
    /* 8F0FC 8009E8FC 6E1882A7 */  sh         $v0, %gp_rel(D_8013DDBA)($gp)
    /* 8F100 8009E900 547A0208 */  j          .L8009E950
    /* 8F104 8009E904 00000000 */   nop
  .L8009E908:
    /* 8F108 8009E908 1480023C */  lui        $v0, %hi(ChangedEnabling)
    /* 8F10C 8009E90C ECD2428C */  lw         $v0, %lo(ChangedEnabling)($v0)
    /* 8F110 8009E910 00000000 */  nop
    /* 8F114 8009E914 05004010 */  beqz       $v0, .L8009E92C
    /* 8F118 8009E918 00000000 */   nop
  .L8009E91C:
    /* 8F11C 8009E91C 01000224 */  addiu      $v0, $zero, 0x1
    /* 8F120 8009E920 180D82AF */  sw         $v0, %gp_rel(gMPauseUpdate)($gp)
    /* 8F124 8009E924 547A0208 */  j          .L8009E950
    /* 8F128 8009E928 00000000 */   nop
  .L8009E92C:
    /* 8F12C 8009E92C F40C828F */  lw         $v0, %gp_rel(gMPauseUpdateNextTime)($gp)
    /* 8F130 8009E930 00000000 */  nop
    /* 8F134 8009E934 05004010 */  beqz       $v0, .L8009E94C
    /* 8F138 8009E938 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F13C 8009E93C 180D82AF */  sw         $v0, %gp_rel(gMPauseUpdate)($gp)
    /* 8F140 8009E940 F40C80AF */  sw         $zero, %gp_rel(gMPauseUpdateNextTime)($gp)
    /* 8F144 8009E944 547A0208 */  j          .L8009E950
    /* 8F148 8009E948 00000000 */   nop
  .L8009E94C:
    /* 8F14C 8009E94C 180D80AF */  sw         $zero, %gp_rel(gMPauseUpdate)($gp)
  .L8009E950:
    /* 8F150 8009E950 1000A28F */  lw         $v0, 0x10($sp)
    /* 8F154 8009E954 00000000 */  nop
    /* 8F158 8009E958 43004010 */  beqz       $v0, .L8009EA68
    /* 8F15C 8009E95C 00014230 */   andi      $v0, $v0, 0x100
    /* 8F160 8009E960 13004010 */  beqz       $v0, .L8009E9B0
    /* 8F164 8009E964 00000000 */   nop
    /* 8F168 8009E968 7418838F */  lw         $v1, %gp_rel(D_8013DDC0)($gp)
    /* 8F16C 8009E96C 00000000 */  nop
    /* 8F170 8009E970 0000628C */  lw         $v0, 0x0($v1)
    /* 8F174 8009E974 00000000 */  nop
    /* 8F178 8009E978 80100200 */  sll        $v0, $v0, 2
    /* 8F17C 8009E97C 21186200 */  addu       $v1, $v1, $v0
    /* 8F180 8009E980 0800628C */  lw         $v0, 0x8($v1)
    /* 8F184 8009E984 1C0D838F */  lw         $v1, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F188 8009E988 0400428C */  lw         $v0, 0x4($v0)
    /* 8F18C 8009E98C 00000000 */  nop
    /* 8F190 8009E990 D00262AC */  sw         $v0, 0x2D0($v1)
    /* 8F194 8009E994 1000A293 */  lbu        $v0, 0x10($sp)
    /* 8F198 8009E998 040360AC */  sw         $zero, 0x304($v1)
    /* 8F19C 8009E99C 000362AC */  sw         $v0, 0x300($v1)
    /* 8F1A0 8009E9A0 06000224 */  addiu      $v0, $zero, 0x6
    /* 8F1A4 8009E9A4 04036324 */  addiu      $v1, $v1, 0x304
    /* 8F1A8 8009E9A8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8F1AC 8009E9AC 1400A3AF */  sw         $v1, 0x14($sp)
  .L8009E9B0:
    /* 8F1B0 8009E9B0 1000A38F */  lw         $v1, 0x10($sp)
    /* 8F1B4 8009E9B4 06000224 */  addiu      $v0, $zero, 0x6
    /* 8F1B8 8009E9B8 05006210 */  beq        $v1, $v0, .L8009E9D0
    /* 8F1BC 8009E9BC 07000224 */   addiu     $v0, $zero, 0x7
    /* 8F1C0 8009E9C0 0F006210 */  beq        $v1, $v0, .L8009EA00
    /* 8F1C4 8009E9C4 00000000 */   nop
    /* 8F1C8 8009E9C8 977A0208 */  j          .L8009EA5C
    /* 8F1CC 8009E9CC 00000000 */   nop
  .L8009E9D0:
    /* 8F1D0 8009E9D0 1480033C */  lui        $v1, %hi(D_8013E0C0)
    /* 8F1D4 8009E9D4 C0E06324 */  addiu      $v1, $v1, %lo(D_8013E0C0)
    /* 8F1D8 8009E9D8 7018858F */  lw         $a1, %gp_rel(D_8013DDBC)($gp)
    /* 8F1DC 8009E9DC 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F1E0 8009E9E0 80100500 */  sll        $v0, $a1, 2
    /* 8F1E4 8009E9E4 21104300 */  addu       $v0, $v0, $v1
    /* 8F1E8 8009E9E8 000044AC */  sw         $a0, 0x0($v0)
    /* 8F1EC 8009E9EC 1400A48F */  lw         $a0, 0x14($sp)
    /* 8F1F0 8009E9F0 00000000 */  nop
    /* 8F1F4 8009E9F4 5000838C */  lw         $v1, 0x50($a0)
    /* 8F1F8 8009E9F8 8B7A0208 */  j          .L8009EA2C
    /* 8F1FC 8009E9FC 0100A524 */   addiu     $a1, $a1, 0x1
  .L8009EA00:
    /* 8F200 8009EA00 7018858F */  lw         $a1, %gp_rel(D_8013DDBC)($gp)
    /* 8F204 8009EA04 00000000 */  nop
    /* 8F208 8009EA08 1100A018 */  blez       $a1, .L8009EA50
    /* 8F20C 8009EA0C FFFFA524 */   addiu     $a1, $a1, -0x1
    /* 8F210 8009EA10 1480033C */  lui        $v1, %hi(D_8013E0C0)
    /* 8F214 8009EA14 C0E06324 */  addiu      $v1, $v1, %lo(D_8013E0C0)
    /* 8F218 8009EA18 80100500 */  sll        $v0, $a1, 2
    /* 8F21C 8009EA1C 21104300 */  addu       $v0, $v0, $v1
    /* 8F220 8009EA20 0000448C */  lw         $a0, 0x0($v0)
    /* 8F224 8009EA24 00000000 */  nop
    /* 8F228 8009EA28 5000838C */  lw         $v1, 0x50($a0)
  .L8009EA2C:
    /* 8F22C 8009EA2C 701885AF */  sw         $a1, %gp_rel(D_8013DDBC)($gp)
    /* 8F230 8009EA30 741884AF */  sw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F234 8009EA34 10006284 */  lh         $v0, 0x10($v1)
    /* 8F238 8009EA38 1400638C */  lw         $v1, 0x14($v1)
    /* 8F23C 8009EA3C 00000000 */  nop
    /* 8F240 8009EA40 09F86000 */  jalr       $v1
    /* 8F244 8009EA44 21208200 */   addu      $a0, $a0, $v0
    /* 8F248 8009EA48 9A7A0208 */  j          .L8009EA68
    /* 8F24C 8009EA4C 00000000 */   nop
  .L8009EA50:
    /* 8F250 8009EA50 01000224 */  addiu      $v0, $zero, 0x1
    /* 8F254 8009EA54 A37A0208 */  j          .L8009EA8C
    /* 8F258 8009EA58 1000A2AF */   sw        $v0, 0x10($sp)
  .L8009EA5C:
    /* 8F25C 8009EA5C 1000A28F */  lw         $v0, 0x10($sp)
    /* 8F260 8009EA60 A37A0208 */  j          .L8009EA8C
    /* 8F264 8009EA64 00000000 */   nop
  .L8009EA68:
    /* 8F268 8009EA68 1C0D828F */  lw         $v0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F26C 8009EA6C 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F270 8009EA70 C8014224 */  addiu      $v0, $v0, 0x1C8
    /* 8F274 8009EA74 26208200 */  xor        $a0, $a0, $v0
    /* 8F278 8009EA78 FA78020C */  jal        MPause_MusicLogic__Fc
    /* 8F27C 8009EA7C 0100842C */   sltiu     $a0, $a0, 0x1
    /* 8F280 8009EA80 A879020C */  jal        MPause_ControllerLogic__Fv
    /* 8F284 8009EA84 00000000 */   nop
    /* 8F288 8009EA88 21100000 */  addu       $v0, $zero, $zero
  .L8009EA8C:
    /* 8F28C 8009EA8C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 8F290 8009EA90 2400B18F */  lw         $s1, 0x24($sp)
    /* 8F294 8009EA94 2000B08F */  lw         $s0, 0x20($sp)
    /* 8F298 8009EA98 0800E003 */  jr         $ra
    /* 8F29C 8009EA9C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel MPause_Logic__Fv
