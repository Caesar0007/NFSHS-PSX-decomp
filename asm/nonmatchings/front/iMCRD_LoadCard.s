.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_LoadCard, 0xFC

glabel iMCRD_LoadCard
    /* 40B44 80050344 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 40B48 80050348 2000B2AF */  sw         $s2, 0x20($sp)
    /* 40B4C 8005034C 21908000 */  addu       $s2, $a0, $zero
    /* 40B50 80050350 2400BFAF */  sw         $ra, 0x24($sp)
    /* 40B54 80050354 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 40B58 80050358 9140010C */  jal        MCRD_getcard
    /* 40B5C 8005035C 1800B0AF */   sw        $s0, 0x18($sp)
    /* 40B60 80050360 21884000 */  addu       $s1, $v0, $zero
    /* 40B64 80050364 10003026 */  addiu      $s0, $s1, 0x10
    /* 40B68 80050368 203D010C */  jal        iMCRD_InitCard
    /* 40B6C 8005036C 21204002 */   addu      $a0, $s2, $zero
    /* 40B70 80050370 2D004014 */  bnez       $v0, .L80050428
    /* 40B74 80050374 0B000224 */   addiu     $v0, $zero, 0xB
    /* 40B78 80050378 0180053C */  lui        $a1, %hi(D_80012884)
    /* 40B7C 8005037C 8428A524 */  addiu      $a1, $a1, %lo(D_80012884)
    /* 40B80 80050380 0580023C */  lui        $v0, %hi(D_80052DA4)
    /* 40B84 80050384 21300002 */  addu       $a2, $s0, $zero
    /* 40B88 80050388 A42D448C */  lw         $a0, %lo(D_80052DA4)($v0)
    /* 40B8C 8005038C 0F000224 */  addiu      $v0, $zero, 0xF
    /* 40B90 80050390 08002726 */  addiu      $a3, $s1, 0x8
    /* 40B94 80050394 1000A0AF */  sw         $zero, 0x10($sp)
    /* 40B98 80050398 22EE030C */  jal        MemCardGetDirentry
    /* 40B9C 8005039C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 40BA0 800503A0 01000424 */  addiu      $a0, $zero, 0x1
    /* 40BA4 800503A4 21284000 */  addu       $a1, $v0, $zero
    /* 40BA8 800503A8 3341010C */  jal        iMCRD_HandleError
    /* 40BAC 800503AC 21304002 */   addu      $a2, $s2, $zero
    /* 40BB0 800503B0 1D004014 */  bnez       $v0, .L80050428
    /* 40BB4 800503B4 21200000 */   addu      $a0, $zero, $zero
  .L800503B8:
    /* 40BB8 800503B8 00000292 */  lbu        $v0, 0x0($s0)
    /* 40BBC 800503BC 00000000 */  nop
    /* 40BC0 800503C0 0A004010 */  beqz       $v0, .L800503EC
    /* 40BC4 800503C4 00000000 */   nop
    /* 40BC8 800503C8 1800038E */  lw         $v1, 0x18($s0)
    /* 40BCC 800503CC 00000000 */  nop
    /* 40BD0 800503D0 02006104 */  bgez       $v1, .L800503DC
    /* 40BD4 800503D4 00000000 */   nop
    /* 40BD8 800503D8 FF1F6324 */  addiu      $v1, $v1, 0x1FFF
  .L800503DC:
    /* 40BDC 800503DC 0C00228E */  lw         $v0, 0xC($s1)
    /* 40BE0 800503E0 431B0300 */  sra        $v1, $v1, 13
    /* 40BE4 800503E4 23104300 */  subu       $v0, $v0, $v1
    /* 40BE8 800503E8 0C0022AE */  sw         $v0, 0xC($s1)
  .L800503EC:
    /* 40BEC 800503EC 01008424 */  addiu      $a0, $a0, 0x1
    /* 40BF0 800503F0 0F008228 */  slti       $v0, $a0, 0xF
    /* 40BF4 800503F4 F0FF4014 */  bnez       $v0, .L800503B8
    /* 40BF8 800503F8 28001026 */   addiu     $s0, $s0, 0x28
    /* 40BFC 800503FC 0C00228E */  lw         $v0, 0xC($s1)
    /* 40C00 80050400 00000000 */  nop
    /* 40C04 80050404 03004014 */  bnez       $v0, .L80050414
    /* 40C08 80050408 FDFF0224 */   addiu     $v0, $zero, -0x3
    /* 40C0C 8005040C 06410108 */  j          .L80050418
    /* 40C10 80050410 000022AE */   sw        $v0, 0x0($s1)
  .L80050414:
    /* 40C14 80050414 000020AE */  sw         $zero, 0x0($s1)
  .L80050418:
    /* 40C18 80050418 0580033C */  lui        $v1, %hi(D_80052D9C)
    /* 40C1C 8005041C 01000224 */  addiu      $v0, $zero, 0x1
    /* 40C20 80050420 9C2D62AC */  sw         $v0, %lo(D_80052D9C)($v1)
    /* 40C24 80050424 09000224 */  addiu      $v0, $zero, 0x9
  .L80050428:
    /* 40C28 80050428 2400BF8F */  lw         $ra, 0x24($sp)
    /* 40C2C 8005042C 2000B28F */  lw         $s2, 0x20($sp)
    /* 40C30 80050430 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 40C34 80050434 1800B08F */  lw         $s0, 0x18($sp)
    /* 40C38 80050438 0800E003 */  jr         $ra
    /* 40C3C 8005043C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iMCRD_LoadCard
