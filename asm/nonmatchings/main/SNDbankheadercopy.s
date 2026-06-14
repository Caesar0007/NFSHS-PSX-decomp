.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDbankheadercopy, 0x144

glabel SNDbankheadercopy
    /* D83A8 800E7BA8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D83AC 800E7BAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* D83B0 800E7BB0 21888000 */  addu       $s1, $a0, $zero
    /* D83B4 800E7BB4 1480023C */  lui        $v0, %hi(sndgs)
    /* D83B8 800E7BB8 1800B2AF */  sw         $s2, 0x18($sp)
    /* D83BC 800E7BBC 60785224 */  addiu      $s2, $v0, %lo(sndgs)
    /* D83C0 800E7BC0 2000BFAF */  sw         $ra, 0x20($sp)
    /* D83C4 800E7BC4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D83C8 800E7BC8 1000B0AF */  sw         $s0, 0x10($sp)
    /* D83CC 800E7BCC 3C004282 */  lb         $v0, 0x3C($s2)
    /* D83D0 800E7BD0 00000000 */  nop
    /* D83D4 800E7BD4 03004014 */  bnez       $v0, .L800E7BE4
    /* D83D8 800E7BD8 2198A000 */   addu      $s3, $a1, $zero
    /* D83DC 800E7BDC 349F0308 */  j          .L800E7CD0
    /* D83E0 800E7BE0 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E7BE4:
    /* D83E4 800E7BE4 D99E030C */  jal        SNDbankheadersize
    /* D83E8 800E7BE8 21206002 */   addu      $a0, $s3, $zero
    /* D83EC 800E7BEC 21304000 */  addu       $a2, $v0, $zero
    /* D83F0 800E7BF0 3700C004 */  bltz       $a2, .L800E7CD0
    /* D83F4 800E7BF4 40801300 */   sll       $s0, $s3, 1
    /* D83F8 800E7BF8 21801302 */  addu       $s0, $s0, $s3
    /* D83FC 800E7BFC 9800428E */  lw         $v0, 0x98($s2)
    /* D8400 800E7C00 80801000 */  sll        $s0, $s0, 2
    /* D8404 800E7C04 21100202 */  addu       $v0, $s0, $v0
    /* D8408 800E7C08 0000458C */  lw         $a1, 0x0($v0)
    /* D840C 800E7C0C B1AA030C */  jal        memcpy
    /* D8410 800E7C10 21202002 */   addu      $a0, $s1, $zero
    /* D8414 800E7C14 9800428E */  lw         $v0, 0x98($s2)
    /* D8418 800E7C18 00000000 */  nop
    /* D841C 800E7C1C 21800202 */  addu       $s0, $s0, $v0
    /* D8420 800E7C20 0000108E */  lw         $s0, 0x0($s0)
    /* D8424 800E7C24 21180000 */  addu       $v1, $zero, $zero
    /* D8428 800E7C28 06000296 */  lhu        $v0, 0x6($s0)
    /* D842C 800E7C2C 00000000 */  nop
    /* D8430 800E7C30 1F004010 */  beqz       $v0, .L800E7CB0
    /* D8434 800E7C34 21400002 */   addu      $t0, $s0, $zero
    /* D8438 800E7C38 04000924 */  addiu      $t1, $zero, 0x4
    /* D843C 800E7C3C 21382002 */  addu       $a3, $s1, $zero
    /* D8440 800E7C40 21300002 */  addu       $a2, $s0, $zero
    /* D8444 800E7C44 21282002 */  addu       $a1, $s1, $zero
    /* D8448 800E7C48 21200002 */  addu       $a0, $s0, $zero
  .L800E7C4C:
    /* D844C 800E7C4C 04000292 */  lbu        $v0, 0x4($s0)
    /* D8450 800E7C50 00000000 */  nop
    /* D8454 800E7C54 08004914 */  bne        $v0, $t1, .L800E7C78
    /* D8458 800E7C58 00000000 */   nop
    /* D845C 800E7C5C 1400828C */  lw         $v0, 0x14($a0)
    /* D8460 800E7C60 00000000 */  nop
    /* D8464 800E7C64 0A004010 */  beqz       $v0, .L800E7C90
    /* D8468 800E7C68 23104800 */   subu      $v0, $v0, $t0
    /* D846C 800E7C6C 21102202 */  addu       $v0, $s1, $v0
    /* D8470 800E7C70 249F0308 */  j          .L800E7C90
    /* D8474 800E7C74 1400A2AC */   sw        $v0, 0x14($a1)
  .L800E7C78:
    /* D8478 800E7C78 0C00C28C */  lw         $v0, 0xC($a2)
    /* D847C 800E7C7C 00000000 */  nop
    /* D8480 800E7C80 03004010 */  beqz       $v0, .L800E7C90
    /* D8484 800E7C84 23105000 */   subu      $v0, $v0, $s0
    /* D8488 800E7C88 21102202 */  addu       $v0, $s1, $v0
    /* D848C 800E7C8C 0C00E2AC */  sw         $v0, 0xC($a3)
  .L800E7C90:
    /* D8490 800E7C90 0400E724 */  addiu      $a3, $a3, 0x4
    /* D8494 800E7C94 0400C624 */  addiu      $a2, $a2, 0x4
    /* D8498 800E7C98 0400A524 */  addiu      $a1, $a1, 0x4
    /* D849C 800E7C9C 06000296 */  lhu        $v0, 0x6($s0)
    /* D84A0 800E7CA0 01006324 */  addiu      $v1, $v1, 0x1
    /* D84A4 800E7CA4 2A106200 */  slt        $v0, $v1, $v0
    /* D84A8 800E7CA8 E8FF4014 */  bnez       $v0, .L800E7C4C
    /* D84AC 800E7CAC 04008424 */   addiu     $a0, $a0, 0x4
  .L800E7CB0:
    /* D84B0 800E7CB0 21100000 */  addu       $v0, $zero, $zero
    /* D84B4 800E7CB4 1480033C */  lui        $v1, %hi(D_801478F8)
    /* D84B8 800E7CB8 40201300 */  sll        $a0, $s3, 1
    /* D84BC 800E7CBC 21209300 */  addu       $a0, $a0, $s3
    /* D84C0 800E7CC0 F878638C */  lw         $v1, %lo(D_801478F8)($v1)
    /* D84C4 800E7CC4 80200400 */  sll        $a0, $a0, 2
    /* D84C8 800E7CC8 21208300 */  addu       $a0, $a0, $v1
    /* D84CC 800E7CCC 000091AC */  sw         $s1, 0x0($a0)
  .L800E7CD0:
    /* D84D0 800E7CD0 2000BF8F */  lw         $ra, 0x20($sp)
    /* D84D4 800E7CD4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D84D8 800E7CD8 1800B28F */  lw         $s2, 0x18($sp)
    /* D84DC 800E7CDC 1400B18F */  lw         $s1, 0x14($sp)
    /* D84E0 800E7CE0 1000B08F */  lw         $s0, 0x10($sp)
    /* D84E4 800E7CE4 0800E003 */  jr         $ra
    /* D84E8 800E7CE8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDbankheadercopy
