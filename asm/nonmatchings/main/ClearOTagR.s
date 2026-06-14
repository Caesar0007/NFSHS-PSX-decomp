.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearOTagR, 0xAC

glabel ClearOTagR
    /* DE408 800EDC08 1280023C */  lui        $v0, %hi(D_8012369E)
    /* DE40C 800EDC0C 9E364290 */  lbu        $v0, %lo(D_8012369E)($v0)
    /* DE410 800EDC10 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE414 800EDC14 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE418 800EDC18 21808000 */  addu       $s0, $a0, $zero
    /* DE41C 800EDC1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE420 800EDC20 2188A000 */  addu       $s1, $a1, $zero
    /* DE424 800EDC24 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE428 800EDC28 09004014 */  bnez       $v0, .L800EDC50
    /* DE42C 800EDC2C 1800BFAF */   sw        $ra, 0x18($sp)
    /* DE430 800EDC30 0580043C */  lui        $a0, %hi(D_80056E40)
    /* DE434 800EDC34 406E8424 */  addiu      $a0, $a0, %lo(D_80056E40)
    /* DE438 800EDC38 21280002 */  addu       $a1, $s0, $zero
    /* DE43C 800EDC3C 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE440 800EDC40 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE444 800EDC44 00000000 */  nop
    /* DE448 800EDC48 09F84000 */  jalr       $v0
    /* DE44C 800EDC4C 21302002 */   addu      $a2, $s1, $zero
  .L800EDC50:
    /* DE450 800EDC50 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE454 800EDC54 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE458 800EDC58 21200002 */  addu       $a0, $s0, $zero
    /* DE45C 800EDC5C 2C00428C */  lw         $v0, 0x2C($v0)
    /* DE460 800EDC60 00000000 */  nop
    /* DE464 800EDC64 09F84000 */  jalr       $v0
    /* DE468 800EDC68 21282002 */   addu      $a1, $s1, $zero
    /* DE46C 800EDC6C FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* DE470 800EDC70 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* DE474 800EDC74 21100002 */  addu       $v0, $s0, $zero
    /* DE478 800EDC78 1280053C */  lui        $a1, %hi(D_8012375C)
    /* DE47C 800EDC7C 5C37A524 */  addiu      $a1, $a1, %lo(D_8012375C)
    /* DE480 800EDC80 1280033C */  lui        $v1, %hi(D_80123748)
    /* DE484 800EDC84 48376324 */  addiu      $v1, $v1, %lo(D_80123748)
    /* DE488 800EDC88 24186600 */  and        $v1, $v1, $a2
    /* DE48C 800EDC8C 0004043C */  lui        $a0, (0x4000000 >> 16)
    /* DE490 800EDC90 25186400 */  or         $v1, $v1, $a0
    /* DE494 800EDC94 0000A3AC */  sw         $v1, 0x0($a1)
    /* DE498 800EDC98 2428A600 */  and        $a1, $a1, $a2
    /* DE49C 800EDC9C 000045AC */  sw         $a1, 0x0($v0)
    /* DE4A0 800EDCA0 1800BF8F */  lw         $ra, 0x18($sp)
    /* DE4A4 800EDCA4 1400B18F */  lw         $s1, 0x14($sp)
    /* DE4A8 800EDCA8 1000B08F */  lw         $s0, 0x10($sp)
    /* DE4AC 800EDCAC 0800E003 */  jr         $ra
    /* DE4B0 800EDCB0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ClearOTagR
