.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_close, 0xC0

glabel FILE_close
    /* DCC2C 800EC42C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DCC30 800EC430 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DCC34 800EC434 21988000 */  addu       $s3, $a0, $zero
    /* DCC38 800EC438 1000B0AF */  sw         $s0, 0x10($sp)
    /* DCC3C 800EC43C 2180A000 */  addu       $s0, $a1, $zero
    /* DCC40 800EC440 1400B1AF */  sw         $s1, 0x14($sp)
    /* DCC44 800EC444 2188C000 */  addu       $s1, $a2, $zero
    /* DCC48 800EC448 2000BFAF */  sw         $ra, 0x20($sp)
    /* DCC4C 800EC44C 37B4030C */  jal        reserveop
    /* DCC50 800EC450 1800B2AF */   sw        $s2, 0x18($sp)
    /* DCC54 800EC454 0FFF043C */  lui        $a0, (0xFF0FFFFF >> 16)
    /* DCC58 800EC458 1480033C */  lui        $v1, %hi(D_8013EAAC)
    /* DCC5C 800EC45C 21904000 */  addu       $s2, $v0, $zero
    /* DCC60 800EC460 FFFF8434 */  ori        $a0, $a0, (0xFF0FFFFF & 0xFFFF)
    /* DCC64 800EC464 ACEA658C */  lw         $a1, %lo(D_8013EAAC)($v1)
    /* DCC68 800EC468 0000438E */  lw         $v1, 0x0($s2)
    /* DCC6C 800EC46C 3000023C */  lui        $v0, (0x300000 >> 16)
    /* DCC70 800EC470 100050AE */  sw         $s0, 0x10($s2)
    /* DCC74 800EC474 140051AE */  sw         $s1, 0x14($s2)
    /* DCC78 800EC478 240053AE */  sw         $s3, 0x24($s2)
    /* DCC7C 800EC47C 24186400 */  and        $v1, $v1, $a0
    /* DCC80 800EC480 25186200 */  or         $v1, $v1, $v0
    /* DCC84 800EC484 0F00A010 */  beqz       $a1, .L800EC4C4
    /* DCC88 800EC488 000043AE */   sw        $v1, 0x0($s2)
    /* DCC8C 800EC48C 03000324 */  addiu      $v1, $zero, 0x3
  .L800EC490:
    /* DCC90 800EC490 0400A28C */  lw         $v0, 0x4($a1)
    /* DCC94 800EC494 00000000 */  nop
    /* DCC98 800EC498 06005314 */  bne        $v0, $s3, .L800EC4B4
    /* DCC9C 800EC49C 00000000 */   nop
    /* DCCA0 800EC4A0 0C0043AE */  sw         $v1, 0xC($s2)
    /* DCCA4 800EC4A4 35B4030C */  jal        iFILE_perror
    /* DCCA8 800EC4A8 21204002 */   addu      $a0, $s2, $zero
    /* DCCAC 800EC4AC 31B10308 */  j          .L800EC4C4
    /* DCCB0 800EC4B0 00000000 */   nop
  .L800EC4B4:
    /* DCCB4 800EC4B4 0C00A58C */  lw         $a1, 0xC($a1)
    /* DCCB8 800EC4B8 00000000 */  nop
    /* DCCBC 800EC4BC F4FFA014 */  bnez       $a1, .L800EC490
    /* DCCC0 800EC4C0 00000000 */   nop
  .L800EC4C4:
    /* DCCC4 800EC4C4 E6B2030C */  jal        iFILE_ExecCommand
    /* DCCC8 800EC4C8 21204002 */   addu      $a0, $s2, $zero
    /* DCCCC 800EC4CC 0000428E */  lw         $v0, 0x0($s2)
    /* DCCD0 800EC4D0 2000BF8F */  lw         $ra, 0x20($sp)
    /* DCCD4 800EC4D4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DCCD8 800EC4D8 1800B28F */  lw         $s2, 0x18($sp)
    /* DCCDC 800EC4DC 1400B18F */  lw         $s1, 0x14($sp)
    /* DCCE0 800EC4E0 1000B08F */  lw         $s0, 0x10($sp)
    /* DCCE4 800EC4E4 0800E003 */  jr         $ra
    /* DCCE8 800EC4E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FILE_close
