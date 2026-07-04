.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching reserveop, 0x11C

glabel reserveop
    /* DD8DC 800ED0DC 00600D40 */  mfc0       $t5, $12 /* handwritten instruction */
    /* DD8E0 800ED0E0 00000000 */  nop
    /* DD8E4 800ED0E4 FEFB0124 */  addiu      $at, $zero, -0x402
    /* DD8E8 800ED0E8 2440A101 */  and        $t0, $t5, $at
    /* DD8EC 800ED0EC 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DD8F0 800ED0F0 00000000 */  nop
    /* DD8F4 800ED0F4 00000000 */  nop
    /* DD8F8 800ED0F8 00000000 */  nop
    /* DD8FC 800ED0FC 1480033C */  lui        $v1, %hi(gFileDevice)
    /* DD900 800ED100 88EA628C */  lw         $v0, %lo(gFileDevice)($v1)
    /* DD904 800ED104 00000000 */  nop
    /* DD908 800ED108 2D004018 */  blez       $v0, .L800ED1C0
    /* DD90C 800ED10C 21300000 */   addu      $a2, $zero, $zero
    /* DD910 800ED110 21486000 */  addu       $t1, $v1, $zero
    /* DD914 800ED114 88EA2825 */  addiu      $t0, $t1, %lo(gFileDevice)
    /* DD918 800ED118 0FFF0A3C */  lui        $t2, (0xFF0FFFFF >> 16)
    /* DD91C 800ED11C FFFF4A35 */  ori        $t2, $t2, (0xFF0FFFFF & 0xFFFF)
    /* DD920 800ED120 10000B3C */  lui        $t3, (0x100000 >> 16)
    /* DD924 800ED124 0F00073C */  lui        $a3, (0xFFFFF >> 16)
    /* DD928 800ED128 FFFFE734 */  ori        $a3, $a3, (0xFFFFF & 0xFFFF)
    /* DD92C 800ED12C F0FF0C3C */  lui        $t4, (0xFFF00000 >> 16)
    /* DD930 800ED130 2128C000 */  addu       $a1, $a2, $zero
  .L800ED134:
    /* DD934 800ED134 1800028D */  lw         $v0, 0x18($t0)
    /* DD938 800ED138 00000000 */  nop
    /* DD93C 800ED13C 2120A200 */  addu       $a0, $a1, $v0
    /* DD940 800ED140 0000838C */  lw         $v1, 0x0($a0)
    /* DD944 800ED144 00000000 */  nop
    /* DD948 800ED148 02150300 */  srl        $v0, $v1, 20
    /* DD94C 800ED14C 0F004230 */  andi       $v0, $v0, 0xF
    /* DD950 800ED150 16004014 */  bnez       $v0, .L800ED1AC
    /* DD954 800ED154 24106A00 */   and       $v0, $v1, $t2
    /* DD958 800ED158 25104B00 */  or         $v0, $v0, $t3
    /* DD95C 800ED15C 000082AC */  sw         $v0, 0x0($a0)
    /* DD960 800ED160 1800028D */  lw         $v0, 0x18($t0)
    /* DD964 800ED164 00000000 */  nop
    /* DD968 800ED168 2110A200 */  addu       $v0, $a1, $v0
    /* DD96C 800ED16C 030046A0 */  sb         $a2, 0x3($v0)
    /* DD970 800ED170 1800048D */  lw         $a0, 0x18($t0)
    /* DD974 800ED174 0417838F */  lw         $v1, %gp_rel(D_8013DC50)($gp)
    /* DD978 800ED178 2120A400 */  addu       $a0, $a1, $a0
    /* DD97C 800ED17C 24286700 */  and        $a1, $v1, $a3
    /* DD980 800ED180 0000828C */  lw         $v0, 0x0($a0)
    /* DD984 800ED184 01006324 */  addiu      $v1, $v1, 0x1
    /* DD988 800ED188 041783AF */  sw         $v1, %gp_rel(D_8013DC50)($gp)
    /* DD98C 800ED18C 2A18E300 */  slt        $v1, $a3, $v1
    /* DD990 800ED190 24104C00 */  and        $v0, $v0, $t4
    /* DD994 800ED194 25104500 */  or         $v0, $v0, $a1
    /* DD998 800ED198 09006010 */  beqz       $v1, .L800ED1C0
    /* DD99C 800ED19C 000082AC */   sw        $v0, 0x0($a0)
    /* DD9A0 800ED1A0 041780AF */  sw         $zero, %gp_rel(D_8013DC50)($gp)
    /* DD9A4 800ED1A4 70B40308 */  j          .L800ED1C0
    /* DD9A8 800ED1A8 00000000 */   nop
  .L800ED1AC:
    /* DD9AC 800ED1AC 88EA228D */  lw         $v0, %lo(gFileDevice)($t1)
    /* DD9B0 800ED1B0 0100C624 */  addiu      $a2, $a2, 0x1
    /* DD9B4 800ED1B4 2A10C200 */  slt        $v0, $a2, $v0
    /* DD9B8 800ED1B8 DEFF4014 */  bnez       $v0, .L800ED134
    /* DD9BC 800ED1BC 3000A524 */   addiu     $a1, $a1, 0x30
  .L800ED1C0:
    /* DD9C0 800ED1C0 00608D40 */  mtc0       $t5, $12 /* handwritten instruction */
    /* DD9C4 800ED1C4 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DD9C8 800ED1C8 88EA438C */  lw         $v1, %lo(gFileDevice)($v0)
    /* DD9CC 800ED1CC 00000000 */  nop
    /* DD9D0 800ED1D0 0700C310 */  beq        $a2, $v1, .L800ED1F0
    /* DD9D4 800ED1D4 88EA4424 */   addiu     $a0, $v0, %lo(gFileDevice)
    /* DD9D8 800ED1D8 40100600 */  sll        $v0, $a2, 1
    /* DD9DC 800ED1DC 21104600 */  addu       $v0, $v0, $a2
    /* DD9E0 800ED1E0 1800838C */  lw         $v1, 0x18($a0)
    /* DD9E4 800ED1E4 00110200 */  sll        $v0, $v0, 4
    /* DD9E8 800ED1E8 0800E003 */  jr         $ra
    /* DD9EC 800ED1EC 21106200 */   addu      $v0, $v1, $v0
  .L800ED1F0:
    /* DD9F0 800ED1F0 0800E003 */  jr         $ra
    /* DD9F4 800ED1F4 21100000 */   addu      $v0, $zero, $zero
endlabel reserveop
