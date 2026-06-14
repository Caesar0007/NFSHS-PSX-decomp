.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NormalCache_AddEntry__FP12BWorldSm_Pos, 0xBC

glabel NormalCache_AddEntry__FP12BWorldSm_Pos
    /* 7082C 8008002C 21408000 */  addu       $t0, $a0, $zero
    /* 70830 80080030 FFFF0624 */  addiu      $a2, $zero, -0x1
    /* 70834 80080034 2138C000 */  addu       $a3, $a2, $zero
    /* 70838 80080038 1180023C */  lui        $v0, %hi(BWSM_NormalCache)
    /* 7083C 8008003C ACF04324 */  addiu      $v1, $v0, %lo(BWSM_NormalCache)
    /* 70840 80080040 8C02828F */  lw         $v0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 70844 80080044 21280000 */  addu       $a1, $zero, $zero
    /* 70848 80080048 01004224 */  addiu      $v0, $v0, 0x1
    /* 7084C 8008004C 8C0282AF */  sw         $v0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
  .L80080050:
    /* 70850 80080050 1C00648C */  lw         $a0, 0x1C($v1)
    /* 70854 80080054 00000000 */  nop
    /* 70858 80080058 2B108600 */  sltu       $v0, $a0, $a2
    /* 7085C 8008005C 03004010 */  beqz       $v0, .L8008006C
    /* 70860 80080060 00000000 */   nop
    /* 70864 80080064 2138A000 */  addu       $a3, $a1, $zero
    /* 70868 80080068 21308000 */  addu       $a2, $a0, $zero
  .L8008006C:
    /* 7086C 8008006C 0100A524 */  addiu      $a1, $a1, 0x1
    /* 70870 80080070 1000A228 */  slti       $v0, $a1, 0x10
    /* 70874 80080074 F6FF4014 */  bnez       $v0, .L80080050
    /* 70878 80080078 20006324 */   addiu     $v1, $v1, 0x20
    /* 7087C 8008007C 1180023C */  lui        $v0, %hi(BWSM_NormalCache)
    /* 70880 80080080 ACF04224 */  addiu      $v0, $v0, %lo(BWSM_NormalCache)
    /* 70884 80080084 40190700 */  sll        $v1, $a3, 5
    /* 70888 80080088 8C02848F */  lw         $a0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 7088C 8008008C 21186200 */  addu       $v1, $v1, $v0
    /* 70890 80080090 1C0064AC */  sw         $a0, 0x1C($v1)
    /* 70894 80080094 6800098D */  lw         $t1, 0x68($t0)
    /* 70898 80080098 6C000A8D */  lw         $t2, 0x6C($t0)
    /* 7089C 8008009C 70000B8D */  lw         $t3, 0x70($t0)
    /* 708A0 800800A0 100069AC */  sw         $t1, 0x10($v1)
    /* 708A4 800800A4 14006AAC */  sw         $t2, 0x14($v1)
    /* 708A8 800800A8 18006BAC */  sw         $t3, 0x18($v1)
    /* 708AC 800800AC 5C00098D */  lw         $t1, 0x5C($t0)
    /* 708B0 800800B0 60000A8D */  lw         $t2, 0x60($t0)
    /* 708B4 800800B4 64000B8D */  lw         $t3, 0x64($t0)
    /* 708B8 800800B8 040069AC */  sw         $t1, 0x4($v1)
    /* 708BC 800800BC 08006AAC */  sw         $t2, 0x8($v1)
    /* 708C0 800800C0 0C006BAC */  sw         $t3, 0xC($v1)
    /* 708C4 800800C4 00000295 */  lhu        $v0, 0x0($t0)
    /* 708C8 800800C8 00000000 */  nop
    /* 708CC 800800CC 000062A4 */  sh         $v0, 0x0($v1)
    /* 708D0 800800D0 74000291 */  lbu        $v0, 0x74($t0)
    /* 708D4 800800D4 00000000 */  nop
    /* 708D8 800800D8 030062A0 */  sb         $v0, 0x3($v1)
    /* 708DC 800800DC 5B000291 */  lbu        $v0, 0x5B($t0)
    /* 708E0 800800E0 0800E003 */  jr         $ra
    /* 708E4 800800E4 020062A0 */   sb        $v0, 0x2($v1)
endlabel NormalCache_AddEntry__FP12BWorldSm_Pos
