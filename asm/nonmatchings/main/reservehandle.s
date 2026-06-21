.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching reservehandle, 0xB0

glabel reservehandle
    /* DDA40 800ED240 00600740 */  mfc0       $a3, $12 /* handwritten instruction */
    /* DDA44 800ED244 00000000 */  nop
    /* DDA48 800ED248 FEFB0124 */  addiu      $at, $zero, -0x402
    /* DDA4C 800ED24C 2440E100 */  and        $t0, $a3, $at
    /* DDA50 800ED250 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* DDA54 800ED254 00000000 */  nop
    /* DDA58 800ED258 00000000 */  nop
    /* DDA5C 800ED25C 00000000 */  nop
    /* DDA60 800ED260 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DDA64 800ED264 88EA4224 */  addiu      $v0, $v0, %lo(gFileDevice)
    /* DDA68 800ED268 0400438C */  lw         $v1, 0x4($v0)
    /* DDA6C 800ED26C 00000000 */  nop
    /* DDA70 800ED270 0D006018 */  blez       $v1, .L800ED2A8
    /* DDA74 800ED274 21200000 */   addu      $a0, $zero, $zero
    /* DDA78 800ED278 21306000 */  addu       $a2, $v1, $zero
    /* DDA7C 800ED27C 1C00458C */  lw         $a1, 0x1C($v0)
  .L800ED280:
    /* DDA80 800ED280 00000000 */  nop
    /* DDA84 800ED284 2118A000 */  addu       $v1, $a1, $zero
    /* DDA88 800ED288 0000628C */  lw         $v0, 0x0($v1)
    /* DDA8C 800ED28C 00000000 */  nop
    /* DDA90 800ED290 13004010 */  beqz       $v0, .L800ED2E0
    /* DDA94 800ED294 01000224 */   addiu     $v0, $zero, 0x1
    /* DDA98 800ED298 01008424 */  addiu      $a0, $a0, 0x1
    /* DDA9C 800ED29C 2A108600 */  slt        $v0, $a0, $a2
    /* DDAA0 800ED2A0 F7FF4014 */  bnez       $v0, .L800ED280
    /* DDAA4 800ED2A4 4C006524 */   addiu     $a1, $v1, 0x4C
  .L800ED2A8:
    /* DDAA8 800ED2A8 00608740 */  mtc0       $a3, $12 /* handwritten instruction */
    /* DDAAC 800ED2AC 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DDAB0 800ED2B0 88EA4324 */  addiu      $v1, $v0, %lo(gFileDevice)
    /* DDAB4 800ED2B4 0400628C */  lw         $v0, 0x4($v1)
    /* DDAB8 800ED2B8 00000000 */  nop
    /* DDABC 800ED2BC 0A008210 */  beq        $a0, $v0, .L800ED2E8
    /* DDAC0 800ED2C0 80100400 */   sll       $v0, $a0, 2
    /* DDAC4 800ED2C4 21104400 */  addu       $v0, $v0, $a0
    /* DDAC8 800ED2C8 80100200 */  sll        $v0, $v0, 2
    /* DDACC 800ED2CC 23104400 */  subu       $v0, $v0, $a0
    /* DDAD0 800ED2D0 1C00638C */  lw         $v1, 0x1C($v1)
    /* DDAD4 800ED2D4 80100200 */  sll        $v0, $v0, 2
    /* DDAD8 800ED2D8 0800E003 */  jr         $ra
    /* DDADC 800ED2DC 21106200 */   addu      $v0, $v1, $v0
  .L800ED2E0:
    /* DDAE0 800ED2E0 AAB40308 */  j          .L800ED2A8
    /* DDAE4 800ED2E4 0000A2AC */   sw        $v0, 0x0($a1)
  .L800ED2E8:
    /* DDAE8 800ED2E8 0800E003 */  jr         $ra
    /* DDAEC 800ED2EC 21100000 */   addu      $v0, $zero, $zero
endlabel reservehandle
