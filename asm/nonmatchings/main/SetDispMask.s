.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDispMask, 0x98

glabel SetDispMask
    /* DDFE4 800ED7E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DDFE8 800ED7E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DDFEC 800ED7EC 1280113C */  lui        $s1, %hi(D_8012369E)
    /* DDFF0 800ED7F0 9E363126 */  addiu      $s1, $s1, %lo(D_8012369E)
    /* DDFF4 800ED7F4 1800BFAF */  sw         $ra, 0x18($sp)
    /* DDFF8 800ED7F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* DDFFC 800ED7FC 00002292 */  lbu        $v0, 0x0($s1)
    /* DE000 800ED800 00000000 */  nop
    /* DE004 800ED804 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE008 800ED808 08004014 */  bnez       $v0, .L800ED82C
    /* DE00C 800ED80C 21808000 */   addu      $s0, $a0, $zero
    /* DE010 800ED810 0580043C */  lui        $a0, %hi(D_80056DA0)
    /* DE014 800ED814 A06D8424 */  addiu      $a0, $a0, %lo(D_80056DA0)
    /* DE018 800ED818 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE01C 800ED81C 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE020 800ED820 00000000 */  nop
    /* DE024 800ED824 09F84000 */  jalr       $v0
    /* DE028 800ED828 21280002 */   addu      $a1, $s0, $zero
  .L800ED82C:
    /* DE02C 800ED82C 04000016 */  bnez       $s0, .L800ED840
    /* DE030 800ED830 6A002426 */   addiu     $a0, $s1, 0x6A
    /* DE034 800ED834 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* DE038 800ED838 8DBF030C */  jal        func_800EFE34
    /* DE03C 800ED83C 14000624 */   addiu     $a2, $zero, 0x14
  .L800ED840:
    /* DE040 800ED840 0003043C */  lui        $a0, (0x3000001 >> 16)
    /* DE044 800ED844 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE048 800ED848 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE04C 800ED84C 02000012 */  beqz       $s0, .L800ED858
    /* DE050 800ED850 01008434 */   ori       $a0, $a0, (0x3000001 & 0xFFFF)
    /* DE054 800ED854 0003043C */  lui        $a0, (0x3000000 >> 16)
  .L800ED858:
    /* DE058 800ED858 1000428C */  lw         $v0, 0x10($v0)
    /* DE05C 800ED85C 00000000 */  nop
    /* DE060 800ED860 09F84000 */  jalr       $v0
    /* DE064 800ED864 00000000 */   nop
    /* DE068 800ED868 1800BF8F */  lw         $ra, 0x18($sp)
    /* DE06C 800ED86C 1400B18F */  lw         $s1, 0x14($sp)
    /* DE070 800ED870 1000B08F */  lw         $s0, 0x10($sp)
    /* DE074 800ED874 0800E003 */  jr         $ra
    /* DE078 800ED878 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetDispMask
