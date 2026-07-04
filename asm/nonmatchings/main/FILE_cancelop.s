.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_cancelop, 0x1B4

glabel FILE_cancelop
    /* DC808 800EC008 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DC80C 800EC00C 21288000 */  addu       $a1, $a0, $zero
    /* DC810 800EC010 21300000 */  addu       $a2, $zero, $zero
    /* DC814 800EC014 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* DC818 800EC018 2800B0AF */  sw         $s0, 0x28($sp)
    /* DC81C 800EC01C 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* DC820 800EC020 00000000 */  nop
    /* DC824 800EC024 FEFB0124 */  addiu      $at, $zero, -0x402
    /* DC828 800EC028 24400102 */  and        $t0, $s0, $at
    /* DC82C 800EC02C 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DC830 800EC030 00000000 */  nop
    /* DC834 800EC034 00000000 */  nop
    /* DC838 800EC038 00000000 */  nop
    /* DC83C 800EC03C 5A00A010 */  beqz       $a1, .L800EC1A8
    /* DC840 800EC040 0F00043C */   lui       $a0, (0xFFFFF >> 16)
    /* DC844 800EC044 FFFF8434 */  ori        $a0, $a0, (0xFFFFF & 0xFFFF)
    /* DC848 800EC048 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DC84C 800EC04C 88EA4824 */  addiu      $t0, $v0, %lo(gFileDevice)
    /* DC850 800EC050 021E0500 */  srl        $v1, $a1, 24
    /* DC854 800EC054 40100300 */  sll        $v0, $v1, 1
    /* DC858 800EC058 21104300 */  addu       $v0, $v0, $v1
    /* DC85C 800EC05C 1800038D */  lw         $v1, 0x18($t0)
    /* DC860 800EC060 00110200 */  sll        $v0, $v0, 4
    /* DC864 800EC064 21384300 */  addu       $a3, $v0, $v1
    /* DC868 800EC068 0000E28C */  lw         $v0, 0x0($a3)
    /* DC86C 800EC06C 2418A400 */  and        $v1, $a1, $a0
    /* DC870 800EC070 24104400 */  and        $v0, $v0, $a0
    /* DC874 800EC074 4C006214 */  bne        $v1, $v0, .L800EC1A8
    /* DC878 800EC078 02150500 */   srl       $v0, $a1, 20
    /* DC87C 800EC07C 0F004330 */  andi       $v1, $v0, 0xF
    /* DC880 800EC080 03000224 */  addiu      $v0, $zero, 0x3
    /* DC884 800EC084 48006210 */  beq        $v1, $v0, .L800EC1A8
    /* DC888 800EC088 0A000224 */   addiu     $v0, $zero, 0xA
    /* DC88C 800EC08C 46006210 */  beq        $v1, $v0, .L800EC1A8
    /* DC890 800EC090 00000000 */   nop
    /* DC894 800EC094 1400028D */  lw         $v0, 0x14($t0)
    /* DC898 800EC098 2128E000 */  addu       $a1, $a3, $zero
    /* DC89C 800EC09C 04004514 */  bne        $v0, $a1, .L800EC0B0
    /* DC8A0 800EC0A0 01000224 */   addiu     $v0, $zero, 0x1
    /* DC8A4 800EC0A4 0400A2AC */  sw         $v0, 0x4($a1)
    /* DC8A8 800EC0A8 51B00308 */  j          .L800EC144
    /* DC8AC 800EC0AC 21304000 */   addu      $a2, $v0, $zero
  .L800EC0B0:
    /* DC8B0 800EC0B0 0800A38C */  lw         $v1, 0x8($a1)
    /* DC8B4 800EC0B4 01000224 */  addiu      $v0, $zero, 0x1
    /* DC8B8 800EC0B8 20006210 */  beq        $v1, $v0, .L800EC13C
    /* DC8BC 800EC0BC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DC8C0 800EC0C0 2000028D */  lw         $v0, 0x20($t0)
    /* DC8C4 800EC0C4 00000000 */  nop
    /* DC8C8 800EC0C8 0A004010 */  beqz       $v0, .L800EC0F4
    /* DC8CC 800EC0CC 21180000 */   addu      $v1, $zero, $zero
  .L800EC0D0:
    /* DC8D0 800EC0D0 06004510 */  beq        $v0, $a1, .L800EC0EC
    /* DC8D4 800EC0D4 00000000 */   nop
    /* DC8D8 800EC0D8 21184000 */  addu       $v1, $v0, $zero
    /* DC8DC 800EC0DC 2C00628C */  lw         $v0, 0x2C($v1)
    /* DC8E0 800EC0E0 00000000 */  nop
    /* DC8E4 800EC0E4 FAFF4014 */  bnez       $v0, .L800EC0D0
    /* DC8E8 800EC0E8 00000000 */   nop
  .L800EC0EC:
    /* DC8EC 800EC0EC 04004014 */  bnez       $v0, .L800EC100
    /* DC8F0 800EC0F0 00000000 */   nop
  .L800EC0F4:
    /* DC8F4 800EC0F4 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* DC8F8 800EC0F8 6BB00308 */  j          .L800EC1AC
    /* DC8FC 800EC0FC 00000000 */   nop
  .L800EC100:
    /* DC900 800EC100 04006010 */  beqz       $v1, .L800EC114
    /* DC904 800EC104 1480023C */   lui       $v0, %hi(D_8013EAA8)
    /* DC908 800EC108 2C00A28C */  lw         $v0, 0x2C($a1)
    /* DC90C 800EC10C 48B00308 */  j          .L800EC120
    /* DC910 800EC110 2C0062AC */   sw        $v0, 0x2C($v1)
  .L800EC114:
    /* DC914 800EC114 2C00A38C */  lw         $v1, 0x2C($a1)
    /* DC918 800EC118 00000000 */  nop
    /* DC91C 800EC11C A8EA43AC */  sw         $v1, %lo(D_8013EAA8)($v0)
  .L800EC120:
    /* DC920 800EC120 1480033C */  lui        $v1, %hi(gFileDevice)
    /* DC924 800EC124 88EA6324 */  addiu      $v1, $v1, %lo(gFileDevice)
    /* DC928 800EC128 0C00628C */  lw         $v0, 0xC($v1)
    /* DC92C 800EC12C 02000624 */  addiu      $a2, $zero, 0x2
    /* DC930 800EC130 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DC934 800EC134 0C0062AC */  sw         $v0, 0xC($v1)
    /* DC938 800EC138 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800EC13C:
    /* DC93C 800EC13C 0800A2AC */  sw         $v0, 0x8($a1)
    /* DC940 800EC140 01000224 */  addiu      $v0, $zero, 0x1
  .L800EC144:
    /* DC944 800EC144 0E00C214 */  bne        $a2, $v0, .L800EC180
    /* DC948 800EC148 02000224 */   addiu     $v0, $zero, 0x2
    /* DC94C 800EC14C 0000A28C */  lw         $v0, 0x0($a1)
    /* DC950 800EC150 04000324 */  addiu      $v1, $zero, 0x4
    /* DC954 800EC154 02150200 */  srl        $v0, $v0, 20
    /* DC958 800EC158 0F004230 */  andi       $v0, $v0, 0xF
    /* DC95C 800EC15C 08004314 */  bne        $v0, $v1, .L800EC180
    /* DC960 800EC160 02000224 */   addiu     $v0, $zero, 0x2
    /* DC964 800EC164 2400A28C */  lw         $v0, 0x24($a1)
    /* DC968 800EC168 00000000 */  nop
    /* DC96C 800EC16C 0000448C */  lw         $a0, 0x0($v0)
    /* DC970 800EC170 40D0030C */  jal        stopreadfile
    /* DC974 800EC174 00000000 */   nop
    /* DC978 800EC178 6AB00308 */  j          .L800EC1A8
    /* DC97C 800EC17C 00000000 */   nop
  .L800EC180:
    /* DC980 800EC180 0900C214 */  bne        $a2, $v0, .L800EC1A8
    /* DC984 800EC184 00000000 */   nop
    /* DC988 800EC188 2800A28C */  lw         $v0, 0x28($a1)
    /* DC98C 800EC18C 00000000 */  nop
    /* DC990 800EC190 05004010 */  beqz       $v0, .L800EC1A8
    /* DC994 800EC194 00000000 */   nop
    /* DC998 800EC198 0000A48C */  lw         $a0, 0x0($a1)
    /* DC99C 800EC19C 1400A68C */  lw         $a2, 0x14($a1)
    /* DC9A0 800EC1A0 09F84000 */  jalr       $v0
    /* DC9A4 800EC1A4 FFFF0524 */   addiu     $a1, $zero, -0x1
  .L800EC1A8:
    /* DC9A8 800EC1A8 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
  .L800EC1AC:
    /* DC9AC 800EC1AC 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* DC9B0 800EC1B0 2800B08F */  lw         $s0, 0x28($sp)
    /* DC9B4 800EC1B4 0800E003 */  jr         $ra
    /* DC9B8 800EC1B8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FILE_cancelop
