.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_FormatCard, 0x8C

glabel iMCRD_FormatCard
    /* 40C40 80050440 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 40C44 80050444 1400B1AF */  sw         $s1, 0x14($sp)
    /* 40C48 80050448 21880000 */  addu       $s1, $zero, $zero
    /* 40C4C 8005044C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 40C50 80050450 9140010C */  jal        MCRD_getcard
    /* 40C54 80050454 1000B0AF */   sw        $s0, 0x10($sp)
    /* 40C58 80050458 0580033C */  lui        $v1, %hi(D_80052DA4)
    /* 40C5C 8005045C A42D648C */  lw         $a0, %lo(D_80052DA4)($v1)
    /* 40C60 80050460 F7EF030C */  jal        MemCardFormat
    /* 40C64 80050464 21804000 */   addu      $s0, $v0, $zero
    /* 40C68 80050468 21184000 */  addu       $v1, $v0, $zero
    /* 40C6C 8005046C 01000224 */  addiu      $v0, $zero, 0x1
    /* 40C70 80050470 08006210 */  beq        $v1, $v0, .L80050494
    /* 40C74 80050474 02006228 */   slti      $v0, $v1, 0x2
    /* 40C78 80050478 0C004014 */  bnez       $v0, .L800504AC
    /* 40C7C 8005047C 21102002 */   addu      $v0, $s1, $zero
    /* 40C80 80050480 02000224 */  addiu      $v0, $zero, 0x2
    /* 40C84 80050484 05006210 */  beq        $v1, $v0, .L8005049C
    /* 40C88 80050488 21102002 */   addu      $v0, $s1, $zero
    /* 40C8C 8005048C 2C410108 */  j          .L800504B0
    /* 40C90 80050490 0F000324 */   addiu     $v1, $zero, 0xF
  .L80050494:
    /* 40C94 80050494 28410108 */  j          .L800504A0
    /* 40C98 80050498 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8005049C:
    /* 40C9C 8005049C FCFF0224 */  addiu      $v0, $zero, -0x4
  .L800504A0:
    /* 40CA0 800504A0 000002AE */  sw         $v0, 0x0($s0)
    /* 40CA4 800504A4 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 40CA8 800504A8 21102002 */  addu       $v0, $s1, $zero
  .L800504AC:
    /* 40CAC 800504AC 0F000324 */  addiu      $v1, $zero, 0xF
  .L800504B0:
    /* 40CB0 800504B0 000000AE */  sw         $zero, 0x0($s0)
    /* 40CB4 800504B4 0C0003AE */  sw         $v1, 0xC($s0)
    /* 40CB8 800504B8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 40CBC 800504BC 1400B18F */  lw         $s1, 0x14($sp)
    /* 40CC0 800504C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 40CC4 800504C4 0800E003 */  jr         $ra
    /* 40CC8 800504C8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iMCRD_FormatCard
