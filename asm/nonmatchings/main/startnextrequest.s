.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching startnextrequest, 0x190

glabel startnextrequest
    /* ED1B4 800FC9B4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* ED1B8 800FC9B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* ED1BC 800FC9BC 21888000 */  addu       $s1, $a0, $zero
    /* ED1C0 800FC9C0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* ED1C4 800FC9C4 2198A000 */  addu       $s3, $a1, $zero
    /* ED1C8 800FC9C8 2000BFAF */  sw         $ra, 0x20($sp)
    /* ED1CC 800FC9CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* ED1D0 800FC9D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED1D4 800FC9D4 00600540 */  mfc0       $a1, $12 /* handwritten instruction */
    /* ED1D8 800FC9D8 00000000 */  nop
    /* ED1DC 800FC9DC FEFB0124 */  addiu      $at, $zero, -0x402
    /* ED1E0 800FC9E0 2440A100 */  and        $t0, $a1, $at
    /* ED1E4 800FC9E4 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ED1E8 800FC9E8 00000000 */  nop
    /* ED1EC 800FC9EC 00000000 */  nop
    /* ED1F0 800FC9F0 00000000 */  nop
    /* ED1F4 800FC9F4 5000248E */  lw         $a0, 0x50($s1)
    /* ED1F8 800FC9F8 00000000 */  nop
    /* ED1FC 800FC9FC 0C008010 */  beqz       $a0, .L800FCA30
    /* ED200 800FCA00 01000324 */   addiu     $v1, $zero, 0x1
    /* ED204 800FCA04 0400838C */  lw         $v1, 0x4($a0)
    /* ED208 800FCA08 01000224 */  addiu      $v0, $zero, 0x1
    /* ED20C 800FCA0C 08006210 */  beq        $v1, $v0, .L800FCA30
    /* ED210 800FCA10 21180000 */   addu      $v1, $zero, $zero
    /* ED214 800FCA14 0C00828C */  lw         $v0, 0xC($a0)
    /* ED218 800FCA18 00000000 */  nop
    /* ED21C 800FCA1C 03004014 */  bnez       $v0, .L800FCA2C
    /* ED220 800FCA20 00000000 */   nop
    /* ED224 800FCA24 8CF20308 */  j          .L800FCA30
    /* ED228 800FCA28 01000324 */   addiu     $v1, $zero, 0x1
  .L800FCA2C:
    /* ED22C 800FCA2C 500022AE */  sw         $v0, 0x50($s1)
  .L800FCA30:
    /* ED230 800FCA30 03006010 */  beqz       $v1, .L800FCA40
    /* ED234 800FCA34 00000000 */   nop
    /* ED238 800FCA38 96F20308 */  j          .L800FCA58
    /* ED23C 800FCA3C 280020AE */   sw        $zero, 0x28($s1)
  .L800FCA40:
    /* ED240 800FCA40 5000268E */  lw         $a2, 0x50($s1)
    /* ED244 800FCA44 4400228E */  lw         $v0, 0x44($s1)
    /* ED248 800FCA48 00000000 */  nop
    /* ED24C 800FCA4C 6000C2AC */  sw         $v0, 0x60($a2)
    /* ED250 800FCA50 02000224 */  addiu      $v0, $zero, 0x2
    /* ED254 800FCA54 0400C2AC */  sw         $v0, 0x4($a2)
  .L800FCA58:
    /* ED258 800FCA58 00608540 */  mtc0       $a1, $12 /* handwritten instruction */
    /* ED25C 800FCA5C 32006014 */  bnez       $v1, .L800FCB28
    /* ED260 800FCA60 00000000 */   nop
    /* ED264 800FCA64 4400228E */  lw         $v0, 0x44($s1)
    /* ED268 800FCA68 00000000 */  nop
    /* ED26C 800FCA6C 480022AE */  sw         $v0, 0x48($s1)
    /* ED270 800FCA70 1000C38C */  lw         $v1, 0x10($a2)
    /* ED274 800FCA74 01000224 */  addiu      $v0, $zero, 0x1
    /* ED278 800FCA78 03006214 */  bne        $v1, $v0, .L800FCA88
    /* ED27C 800FCA7C 1400D224 */   addiu     $s2, $a2, 0x14
    /* ED280 800FCA80 C7F20308 */  j          .L800FCB1C
    /* ED284 800FCA84 A00020AE */   sw        $zero, 0xA0($s1)
  .L800FCA88:
    /* ED288 800FCA88 21204002 */  addu       $a0, $s2, $zero
    /* ED28C 800FCA8C 5C003026 */  addiu      $s0, $s1, 0x5C
    /* ED290 800FCA90 5800C28C */  lw         $v0, 0x58($a2)
    /* ED294 800FCA94 21280002 */  addu       $a1, $s0, $zero
    /* ED298 800FCA98 5F97030C */  jal        strcmp
    /* ED29C 800FCA9C A00022AE */   sw        $v0, 0xA0($s1)
    /* ED2A0 800FCAA0 1E004010 */  beqz       $v0, .L800FCB1C
    /* ED2A4 800FCAA4 21200002 */   addu      $a0, $s0, $zero
    /* ED2A8 800FCAA8 CA96030C */  jal        strcpy
    /* ED2AC 800FCAAC 21284002 */   addu      $a1, $s2, $zero
    /* ED2B0 800FCAB0 9C00248E */  lw         $a0, 0x9C($s1)
    /* ED2B4 800FCAB4 00000000 */  nop
    /* ED2B8 800FCAB8 0E008014 */  bnez       $a0, .L800FCAF4
    /* ED2BC 800FCABC 21286002 */   addu      $a1, $s3, $zero
    /* ED2C0 800FCAC0 21200002 */  addu       $a0, $s0, $zero
    /* ED2C4 800FCAC4 01000524 */  addiu      $a1, $zero, 0x1
    /* ED2C8 800FCAC8 21306002 */  addu       $a2, $s3, $zero
    /* ED2CC 800FCACC DBB0030C */  jal        FILE_open
    /* ED2D0 800FCAD0 21382002 */   addu      $a3, $s1, $zero
    /* ED2D4 800FCAD4 14004010 */  beqz       $v0, .L800FCB28
    /* ED2D8 800FCAD8 A40022AE */   sw        $v0, 0xA4($s1)
    /* ED2DC 800FCADC 21204000 */  addu       $a0, $v0, $zero
    /* ED2E0 800FCAE0 1080053C */  lui        $a1, %hi(opencallback)
    /* ED2E4 800FCAE4 93AF030C */  jal        FILE_callbackop
    /* ED2E8 800FCAE8 10C8A524 */   addiu     $a1, $a1, %lo(opencallback)
    /* ED2EC 800FCAEC CAF20308 */  j          .L800FCB28
    /* ED2F0 800FCAF0 00000000 */   nop
  .L800FCAF4:
    /* ED2F4 800FCAF4 0BB1030C */  jal        FILE_close
    /* ED2F8 800FCAF8 21302002 */   addu      $a2, $s1, $zero
    /* ED2FC 800FCAFC 0A004010 */  beqz       $v0, .L800FCB28
    /* ED300 800FCB00 A40022AE */   sw        $v0, 0xA4($s1)
    /* ED304 800FCB04 21204000 */  addu       $a0, $v0, $zero
    /* ED308 800FCB08 1080053C */  lui        $a1, %hi(closecallback)
    /* ED30C 800FCB0C 93AF030C */  jal        FILE_callbackop
    /* ED310 800FCB10 50C8A524 */   addiu     $a1, $a1, %lo(closecallback)
    /* ED314 800FCB14 CAF20308 */  j          .L800FCB28
    /* ED318 800FCB18 00000000 */   nop
  .L800FCB1C:
    /* ED31C 800FCB1C 21202002 */  addu       $a0, $s1, $zero
    /* ED320 800FCB20 D1F2030C */  jal        restartstream
    /* ED324 800FCB24 21286002 */   addu      $a1, $s3, $zero
  .L800FCB28:
    /* ED328 800FCB28 2000BF8F */  lw         $ra, 0x20($sp)
    /* ED32C 800FCB2C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* ED330 800FCB30 1800B28F */  lw         $s2, 0x18($sp)
    /* ED334 800FCB34 1400B18F */  lw         $s1, 0x14($sp)
    /* ED338 800FCB38 1000B08F */  lw         $s0, 0x10($sp)
    /* ED33C 800FCB3C 0800E003 */  jr         $ra
    /* ED340 800FCB40 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel startnextrequest
