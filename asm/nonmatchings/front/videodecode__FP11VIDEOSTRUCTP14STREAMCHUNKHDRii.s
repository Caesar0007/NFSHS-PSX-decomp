.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii, 0xAC

glabel videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii
    /* 419B0 800511B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 419B4 800511B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 419B8 800511B8 4344033C */  lui        $v1, (0x4443546D >> 16)
    /* 419BC 800511BC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 419C0 800511C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 419C4 800511C4 0000A28C */  lw         $v0, 0x0($a1)
    /* 419C8 800511C8 6D546334 */  ori        $v1, $v1, (0x4443546D & 0xFFFF)
    /* 419CC 800511CC 1D004314 */  bne        $v0, $v1, .L80051244
    /* 419D0 800511D0 21808000 */   addu      $s0, $a0, $zero
    /* 419D4 800511D4 0C00A284 */  lh         $v0, 0xC($a1)
    /* 419D8 800511D8 1000048E */  lw         $a0, 0x10($s0)
    /* 419DC 800511DC 340002AE */  sw         $v0, 0x34($s0)
    /* 419E0 800511E0 0E00A284 */  lh         $v0, 0xE($a1)
    /* 419E4 800511E4 0800A524 */  addiu      $a1, $a1, 0x8
    /* 419E8 800511E8 BB42010C */  jal        mdec
    /* 419EC 800511EC 380002AE */   sw        $v0, 0x38($s0)
    /* 419F0 800511F0 1480033C */  lui        $v1, %hi(ticks)
    /* 419F4 800511F4 1480023C */  lui        $v0, %hi(timerhz)
    /* 419F8 800511F8 C4DC428C */  lw         $v0, %lo(timerhz)($v0)
    /* 419FC 800511FC ACDC638C */  lw         $v1, %lo(ticks)($v1)
    /* 41A00 80051200 80100200 */  sll        $v0, $v0, 2
    /* 41A04 80051204 21886200 */  addu       $s1, $v1, $v0
  .L80051208:
    /* 41A08 80051208 1000048E */  lw         $a0, 0x10($s0)
    /* 41A0C 8005120C 0143010C */  jal        mdecdone
    /* 41A10 80051210 00000000 */   nop
    /* 41A14 80051214 0C004014 */  bnez       $v0, .L80051248
    /* 41A18 80051218 01000224 */   addiu     $v0, $zero, 0x1
    /* 41A1C 8005121C 019B030C */  jal        systemtask
    /* 41A20 80051220 21200000 */   addu      $a0, $zero, $zero
    /* 41A24 80051224 1480023C */  lui        $v0, %hi(ticks)
    /* 41A28 80051228 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 41A2C 8005122C 00000000 */  nop
    /* 41A30 80051230 2A102202 */  slt        $v0, $s1, $v0
    /* 41A34 80051234 F4FF4010 */  beqz       $v0, .L80051208
    /* 41A38 80051238 00000000 */   nop
    /* 41A3C 8005123C AA42010C */  jal        mdecreset__Fv
    /* 41A40 80051240 00000000 */   nop
  .L80051244:
    /* 41A44 80051244 21100000 */  addu       $v0, $zero, $zero
  .L80051248:
    /* 41A48 80051248 1800BF8F */  lw         $ra, 0x18($sp)
    /* 41A4C 8005124C 1400B18F */  lw         $s1, 0x14($sp)
    /* 41A50 80051250 1000B08F */  lw         $s0, 0x10($sp)
    /* 41A54 80051254 0800E003 */  jr         $ra
    /* 41A58 80051258 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii
    /* 41A5C 8005125C 00000000 */  nop
