.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _image, 0x11C

glabel _image
    /* DE0E4 800ED8E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE0E8 800ED8E8 21408000 */  addu       $t0, $a0, $zero
    /* DE0EC 800ED8EC 1800B0AF */  sw         $s0, 0x18($sp)
    /* DE0F0 800ED8F0 1280043C */  lui        $a0, %hi(D_8012369E)
    /* DE0F4 800ED8F4 9E368424 */  addiu      $a0, $a0, %lo(D_8012369E)
    /* DE0F8 800ED8F8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DE0FC 800ED8FC 00008390 */  lbu        $v1, 0x0($a0)
    /* DE100 800ED900 01000224 */  addiu      $v0, $zero, 0x1
    /* DE104 800ED904 06006210 */  beq        $v1, $v0, .L800ED920
    /* DE108 800ED908 2180A000 */   addu      $s0, $a1, $zero
    /* DE10C 800ED90C 02000224 */  addiu      $v0, $zero, 0x2
    /* DE110 800ED910 26006210 */  beq        $v1, $v0, .L800ED9AC
    /* DE114 800ED914 00000000 */   nop
    /* DE118 800ED918 7CB60308 */  j          .L800ED9F0
    /* DE11C 800ED91C 00000000 */   nop
  .L800ED920:
    /* DE120 800ED920 04000586 */  lh         $a1, 0x4($s0)
    /* DE124 800ED924 02008384 */  lh         $v1, 0x2($a0)
    /* DE128 800ED928 00000000 */  nop
    /* DE12C 800ED92C 2A106500 */  slt        $v0, $v1, $a1
    /* DE130 800ED930 1B004014 */  bnez       $v0, .L800ED9A0
    /* DE134 800ED934 00000000 */   nop
    /* DE138 800ED938 00000786 */  lh         $a3, 0x0($s0)
    /* DE13C 800ED93C 00000000 */  nop
    /* DE140 800ED940 2110A700 */  addu       $v0, $a1, $a3
    /* DE144 800ED944 2A106200 */  slt        $v0, $v1, $v0
    /* DE148 800ED948 15004014 */  bnez       $v0, .L800ED9A0
    /* DE14C 800ED94C 00000000 */   nop
    /* DE150 800ED950 02000386 */  lh         $v1, 0x2($s0)
    /* DE154 800ED954 04008484 */  lh         $a0, 0x4($a0)
    /* DE158 800ED958 00000000 */  nop
    /* DE15C 800ED95C 2A108300 */  slt        $v0, $a0, $v1
    /* DE160 800ED960 0F004014 */  bnez       $v0, .L800ED9A0
    /* DE164 800ED964 00000000 */   nop
    /* DE168 800ED968 06000686 */  lh         $a2, 0x6($s0)
    /* DE16C 800ED96C 00000000 */  nop
    /* DE170 800ED970 21106600 */  addu       $v0, $v1, $a2
    /* DE174 800ED974 2A108200 */  slt        $v0, $a0, $v0
    /* DE178 800ED978 09004014 */  bnez       $v0, .L800ED9A0
    /* DE17C 800ED97C 00000000 */   nop
    /* DE180 800ED980 0700A018 */  blez       $a1, .L800ED9A0
    /* DE184 800ED984 00000000 */   nop
    /* DE188 800ED988 0500E004 */  bltz       $a3, .L800ED9A0
    /* DE18C 800ED98C 00000000 */   nop
    /* DE190 800ED990 03006004 */  bltz       $v1, .L800ED9A0
    /* DE194 800ED994 00000000 */   nop
    /* DE198 800ED998 1500C01C */  bgtz       $a2, .L800ED9F0
    /* DE19C 800ED99C 00000000 */   nop
  .L800ED9A0:
    /* DE1A0 800ED9A0 0580043C */  lui        $a0, %hi(D_80056DC8)
    /* DE1A4 800ED9A4 6DB60308 */  j          .L800ED9B4
    /* DE1A8 800ED9A8 C86D8424 */   addiu     $a0, $a0, %lo(D_80056DC8)
  .L800ED9AC:
    /* DE1AC 800ED9AC 0580043C */  lui        $a0, %hi(D_80056DE8)
    /* DE1B0 800ED9B0 E86D8424 */  addiu      $a0, $a0, %lo(D_80056DE8)
  .L800ED9B4:
    /* DE1B4 800ED9B4 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE1B8 800ED9B8 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE1BC 800ED9BC 00000000 */  nop
    /* DE1C0 800ED9C0 09F84000 */  jalr       $v0
    /* DE1C4 800ED9C4 21280001 */   addu      $a1, $t0, $zero
    /* DE1C8 800ED9C8 00000586 */  lh         $a1, 0x0($s0)
    /* DE1CC 800ED9CC 02000686 */  lh         $a2, 0x2($s0)
    /* DE1D0 800ED9D0 04000786 */  lh         $a3, 0x4($s0)
    /* DE1D4 800ED9D4 06000386 */  lh         $v1, 0x6($s0)
    /* DE1D8 800ED9D8 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE1DC 800ED9DC 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE1E0 800ED9E0 0580043C */  lui        $a0, %hi(D_80056DD4)
    /* DE1E4 800ED9E4 D46D8424 */  addiu      $a0, $a0, %lo(D_80056DD4)
    /* DE1E8 800ED9E8 09F84000 */  jalr       $v0
    /* DE1EC 800ED9EC 1000A3AF */   sw        $v1, 0x10($sp)
  .L800ED9F0:
    /* DE1F0 800ED9F0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DE1F4 800ED9F4 1800B08F */  lw         $s0, 0x18($sp)
    /* DE1F8 800ED9F8 0800E003 */  jr         $ra
    /* DE1FC 800ED9FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _image
