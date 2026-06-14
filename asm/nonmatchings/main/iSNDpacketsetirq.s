.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpacketsetirq, 0xE0

glabel iSNDpacketsetirq
    /* F40BC 801038BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F40C0 801038C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* F40C4 801038C4 E92F040C */  jal        iSNDpsxdisablespuirq
    /* F40C8 801038C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* F40CC 801038CC 1480023C */  lui        $v0, %hi(sndpd)
    /* F40D0 801038D0 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* F40D4 801038D4 01006290 */  lbu        $v0, 0x1($v1)
    /* F40D8 801038D8 00000000 */  nop
    /* F40DC 801038DC 2B004014 */  bnez       $v0, .L8010398C
    /* F40E0 801038E0 21800000 */   addu      $s0, $zero, $zero
    /* F40E4 801038E4 1580043C */  lui        $a0, %hi(sndpp)
    /* F40E8 801038E8 21286000 */  addu       $a1, $v1, $zero
  .L801038EC:
    /* F40EC 801038EC 7885828C */  lw         $v0, %lo(sndpp)($a0)
    /* F40F0 801038F0 00000000 */  nop
    /* F40F4 801038F4 01004224 */  addiu      $v0, $v0, 0x1
    /* F40F8 801038F8 788582AC */  sw         $v0, %lo(sndpp)($a0)
    /* F40FC 801038FC 7885828C */  lw         $v0, %lo(sndpp)($a0)
    /* F4100 80103900 00000000 */  nop
    /* F4104 80103904 02004018 */  blez       $v0, .L80103910
    /* F4108 80103908 00000000 */   nop
    /* F410C 8010390C 788580AC */  sw         $zero, %lo(sndpp)($a0)
  .L80103910:
    /* F4110 80103910 7885828C */  lw         $v0, %lo(sndpp)($a0)
    /* F4114 80103914 00000000 */  nop
    /* F4118 80103918 80100200 */  sll        $v0, $v0, 2
    /* F411C 8010391C 21104500 */  addu       $v0, $v0, $a1
    /* F4120 80103920 F804438C */  lw         $v1, 0x4F8($v0)
    /* F4124 80103924 00000000 */  nop
    /* F4128 80103928 05006010 */  beqz       $v1, .L80103940
    /* F412C 8010392C 00000000 */   nop
    /* F4130 80103930 42006280 */  lb         $v0, 0x42($v1)
    /* F4134 80103934 00000000 */  nop
    /* F4138 80103938 07004104 */  bgez       $v0, .L80103958
    /* F413C 8010393C 00000000 */   nop
  .L80103940:
    /* F4140 80103940 01001026 */  addiu      $s0, $s0, 0x1
    /* F4144 80103944 0200022A */  slti       $v0, $s0, 0x2
    /* F4148 80103948 10004010 */  beqz       $v0, .L8010398C
    /* F414C 8010394C 00000000 */   nop
    /* F4150 80103950 3B0E0408 */  j          .L801038EC
    /* F4154 80103954 00000000 */   nop
  .L80103958:
    /* F4158 80103958 0000628C */  lw         $v0, 0x0($v1)
    /* F415C 8010395C 1480033C */  lui        $v1, %hi(D_80147E2C)
    /* F4160 80103960 1080053C */  lui        $a1, %hi(iSNDpacketirqcallback)
    /* F4164 80103964 09000424 */  addiu      $a0, $zero, 0x9
    /* F4168 80103968 9C39A524 */  addiu      $a1, $a1, %lo(iSNDpacketirqcallback)
    /* F416C 8010396C 2C7E638C */  lw         $v1, %lo(D_80147E2C)($v1)
    /* F4170 80103970 08004224 */  addiu      $v0, $v0, 0x8
    /* F4174 80103974 C3100200 */  sra        $v0, $v0, 3
    /* F4178 80103978 A40162A4 */  sh         $v0, 0x1A4($v1)
    /* F417C 8010397C 1FCA030C */  jal        InterruptCallback
    /* F4180 80103980 00000000 */   nop
    /* F4184 80103984 E02F040C */  jal        iSNDpsxenablespuirq
    /* F4188 80103988 00000000 */   nop
  .L8010398C:
    /* F418C 8010398C 1400BF8F */  lw         $ra, 0x14($sp)
    /* F4190 80103990 1000B08F */  lw         $s0, 0x10($sp)
    /* F4194 80103994 0800E003 */  jr         $ra
    /* F4198 80103998 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDpacketsetirq
