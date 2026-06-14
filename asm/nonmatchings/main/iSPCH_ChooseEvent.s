.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ChooseEvent, 0x1E0

glabel iSPCH_ChooseEvent
    /* D7B00 800E7300 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D7B04 800E7304 3000B4AF */  sw         $s4, 0x30($sp)
    /* D7B08 800E7308 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* D7B0C 800E730C 4400BFAF */  sw         $ra, 0x44($sp)
    /* D7B10 800E7310 4000BEAF */  sw         $fp, 0x40($sp)
    /* D7B14 800E7314 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* D7B18 800E7318 3800B6AF */  sw         $s6, 0x38($sp)
    /* D7B1C 800E731C 3400B5AF */  sw         $s5, 0x34($sp)
    /* D7B20 800E7320 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D7B24 800E7324 2800B2AF */  sw         $s2, 0x28($sp)
    /* D7B28 800E7328 2400B1AF */  sw         $s1, 0x24($sp)
    /* D7B2C 800E732C 88A0030C */  jal        gettick
    /* D7B30 800E7330 2000B0AF */   sw        $s0, 0x20($sp)
    /* D7B34 800E7334 21F08002 */  addu       $fp, $s4, $zero
    /* D7B38 800E7338 21B80000 */  addu       $s7, $zero, $zero
    /* D7B3C 800E733C 1580053C */  lui        $a1, %hi(gVoxEvents)
    /* D7B40 800E7340 1580033C */  lui        $v1, %hi(gPreLoadTicks)
    /* D7B44 800E7344 4480638C */  lw         $v1, %lo(gPreLoadTicks)($v1)
    /* D7B48 800E7348 6080B324 */  addiu      $s3, $a1, %lo(gVoxEvents)
    /* D7B4C 800E734C 1400A0AF */  sw         $zero, 0x14($sp)
    /* D7B50 800E7350 1800A0A7 */  sh         $zero, 0x18($sp)
    /* D7B54 800E7354 21104300 */  addu       $v0, $v0, $v1
    /* D7B58 800E7358 1000A2AF */  sw         $v0, 0x10($sp)
  .L800E735C:
    /* D7B5C 800E735C 08006296 */  lhu        $v0, 0x8($s3)
    /* D7B60 800E7360 00000000 */  nop
    /* D7B64 800E7364 4D004010 */  beqz       $v0, .L800E749C
    /* D7B68 800E7368 21A80000 */   addu      $s5, $zero, $zero
    /* D7B6C 800E736C 21B0A002 */  addu       $s6, $s5, $zero
    /* D7B70 800E7370 1000718E */  lw         $s1, 0x10($s3)
    /* D7B74 800E7374 0C00628E */  lw         $v0, 0xC($s3)
    /* D7B78 800E7378 1000A58F */  lw         $a1, 0x10($sp)
    /* D7B7C 800E737C 02002396 */  lhu        $v1, 0x2($s1)
    /* D7B80 800E7380 00000000 */  nop
    /* D7B84 800E7384 03006010 */  beqz       $v1, .L800E7394
    /* D7B88 800E7388 2390A200 */   subu      $s2, $a1, $v0
    /* D7B8C 800E738C 21106000 */  addu       $v0, $v1, $zero
    /* D7B90 800E7390 2BA85200 */  sltu       $s5, $v0, $s2
  .L800E7394:
    /* D7B94 800E7394 1580023C */  lui        $v0, %hi(gFilterSetting)
    /* D7B98 800E7398 2C84438C */  lw         $v1, %lo(gFilterSetting)($v0)
    /* D7B9C 800E739C 01000224 */  addiu      $v0, $zero, 0x1
    /* D7BA0 800E73A0 0D006214 */  bne        $v1, $v0, .L800E73D8
    /* D7BA4 800E73A4 00000000 */   nop
    /* D7BA8 800E73A8 A29B030C */  jal        func_800E6E88
    /* D7BAC 800E73AC 21202002 */   addu      $a0, $s1, $zero
    /* D7BB0 800E73B0 FF004230 */  andi       $v0, $v0, 0xFF
    /* D7BB4 800E73B4 08004010 */  beqz       $v0, .L800E73D8
    /* D7BB8 800E73B8 00000000 */   nop
    /* D7BBC 800E73BC 04003096 */  lhu        $s0, 0x4($s1)
    /* D7BC0 800E73C0 FF9B030C */  jal        GetFilterPriority
    /* D7BC4 800E73C4 00000000 */   nop
    /* D7BC8 800E73C8 2A800202 */  slt        $s0, $s0, $v0
    /* D7BCC 800E73CC 02000012 */  beqz       $s0, .L800E73D8
    /* D7BD0 800E73D0 00000000 */   nop
    /* D7BD4 800E73D4 01001624 */  addiu      $s6, $zero, 0x1
  .L800E73D8:
    /* D7BD8 800E73D8 0300A016 */  bnez       $s5, .L800E73E8
    /* D7BDC 800E73DC 1580053C */   lui       $a1, %hi(gVoxEvents)
    /* D7BE0 800E73E0 0700C012 */  beqz       $s6, .L800E7400
    /* D7BE4 800E73E4 00000000 */   nop
  .L800E73E8:
    /* D7BE8 800E73E8 080060A6 */  sh         $zero, 0x8($s3)
    /* D7BEC 800E73EC 6080A28C */  lw         $v0, %lo(gVoxEvents)($a1)
    /* D7BF0 800E73F0 00000000 */  nop
    /* D7BF4 800E73F4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7BF8 800E73F8 279D0308 */  j          .L800E749C
    /* D7BFC 800E73FC 6080A2AC */   sw        $v0, %lo(gVoxEvents)($a1)
  .L800E7400:
    /* D7C00 800E7400 04002496 */  lhu        $a0, 0x4($s1)
    /* D7C04 800E7404 1400A58F */  lw         $a1, 0x14($sp)
    /* D7C08 800E7408 00000000 */  nop
    /* D7C0C 800E740C 2A10A400 */  slt        $v0, $a1, $a0
    /* D7C10 800E7410 0B004010 */  beqz       $v0, .L800E7440
    /* D7C14 800E7414 00111700 */   sll       $v0, $s7, 4
    /* D7C18 800E7418 21A0E002 */  addu       $s4, $s7, $zero
    /* D7C1C 800E741C 23105400 */  subu       $v0, $v0, $s4
    /* D7C20 800E7420 80100200 */  sll        $v0, $v0, 2
    /* D7C24 800E7424 1580053C */  lui        $a1, %hi(gVoxEvents)
    /* D7C28 800E7428 6080A524 */  addiu      $a1, $a1, %lo(gVoxEvents)
    /* D7C2C 800E742C 21104500 */  addu       $v0, $v0, $a1
    /* D7C30 800E7430 0A004294 */  lhu        $v0, 0xA($v0)
    /* D7C34 800E7434 21F04002 */  addu       $fp, $s2, $zero
    /* D7C38 800E7438 259D0308 */  j          .L800E7494
    /* D7C3C 800E743C 1400A4AF */   sw        $a0, 0x14($sp)
  .L800E7440:
    /* D7C40 800E7440 16008514 */  bne        $a0, $a1, .L800E749C
    /* D7C44 800E7444 2B105E02 */   sltu      $v0, $s2, $fp
    /* D7C48 800E7448 09004014 */  bnez       $v0, .L800E7470
    /* D7C4C 800E744C 00000000 */   nop
    /* D7C50 800E7450 12005E16 */  bne        $s2, $fp, .L800E749C
    /* D7C54 800E7454 00000000 */   nop
    /* D7C58 800E7458 0A006296 */  lhu        $v0, 0xA($s3)
    /* D7C5C 800E745C 1800A597 */  lhu        $a1, 0x18($sp)
    /* D7C60 800E7460 00000000 */  nop
    /* D7C64 800E7464 2B10A200 */  sltu       $v0, $a1, $v0
    /* D7C68 800E7468 0C004010 */  beqz       $v0, .L800E749C
    /* D7C6C 800E746C 00000000 */   nop
  .L800E7470:
    /* D7C70 800E7470 21A0E002 */  addu       $s4, $s7, $zero
    /* D7C74 800E7474 21F04002 */  addu       $fp, $s2, $zero
    /* D7C78 800E7478 00111400 */  sll        $v0, $s4, 4
    /* D7C7C 800E747C 23105400 */  subu       $v0, $v0, $s4
    /* D7C80 800E7480 80100200 */  sll        $v0, $v0, 2
    /* D7C84 800E7484 1580053C */  lui        $a1, %hi(gVoxEvents)
    /* D7C88 800E7488 6080A524 */  addiu      $a1, $a1, %lo(gVoxEvents)
    /* D7C8C 800E748C 21104500 */  addu       $v0, $v0, $a1
    /* D7C90 800E7490 0A004294 */  lhu        $v0, 0xA($v0)
  .L800E7494:
    /* D7C94 800E7494 00000000 */  nop
    /* D7C98 800E7498 1800A2A7 */  sh         $v0, 0x18($sp)
  .L800E749C:
    /* D7C9C 800E749C 0100F726 */  addiu      $s7, $s7, 0x1
    /* D7CA0 800E74A0 1000E22A */  slti       $v0, $s7, 0x10
    /* D7CA4 800E74A4 ADFF4014 */  bnez       $v0, .L800E735C
    /* D7CA8 800E74A8 3C007326 */   addiu     $s3, $s3, 0x3C
    /* D7CAC 800E74AC 21108002 */  addu       $v0, $s4, $zero
    /* D7CB0 800E74B0 4400BF8F */  lw         $ra, 0x44($sp)
    /* D7CB4 800E74B4 4000BE8F */  lw         $fp, 0x40($sp)
    /* D7CB8 800E74B8 3C00B78F */  lw         $s7, 0x3C($sp)
    /* D7CBC 800E74BC 3800B68F */  lw         $s6, 0x38($sp)
    /* D7CC0 800E74C0 3400B58F */  lw         $s5, 0x34($sp)
    /* D7CC4 800E74C4 3000B48F */  lw         $s4, 0x30($sp)
    /* D7CC8 800E74C8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D7CCC 800E74CC 2800B28F */  lw         $s2, 0x28($sp)
    /* D7CD0 800E74D0 2400B18F */  lw         $s1, 0x24($sp)
    /* D7CD4 800E74D4 2000B08F */  lw         $s0, 0x20($sp)
    /* D7CD8 800E74D8 0800E003 */  jr         $ra
    /* D7CDC 800E74DC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSPCH_ChooseEvent
