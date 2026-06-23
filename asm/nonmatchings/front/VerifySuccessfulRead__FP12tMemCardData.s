.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VerifySuccessfulRead__FP12tMemCardData, 0xD8

glabel VerifySuccessfulRead__FP12tMemCardData
    /* 24B18 80034318 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 24B1C 8003431C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 24B20 80034320 21888000 */  addu       $s1, $a0, $zero
    /* 24B24 80034324 08002426 */  addiu      $a0, $s1, 0x8
    /* 24B28 80034328 50040524 */  addiu      $a1, $zero, 0x450
    /* 24B2C 8003432C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 24B30 80034330 53D8030C */  jal        crc16
    /* 24B34 80034334 1000B0AF */   sw        $s0, 0x10($sp)
    /* 24B38 80034338 58042426 */  addiu      $a0, $s1, 0x458
    /* 24B3C 8003433C 9814238E */  lw         $v1, 0x1498($s1)
    /* 24B40 80034340 E0000524 */  addiu      $a1, $zero, 0xE0
    /* 24B44 80034344 26186200 */  xor        $v1, $v1, $v0
    /* 24B48 80034348 53D8030C */  jal        crc16
    /* 24B4C 8003434C 0100702C */   sltiu     $s0, $v1, 0x1
    /* 24B50 80034350 9C14238E */  lw         $v1, 0x149C($s1)
    /* 24B54 80034354 00000000 */  nop
    /* 24B58 80034358 02006210 */  beq        $v1, $v0, .L80034364
    /* 24B5C 8003435C 01001032 */   andi      $s0, $s0, 0x1
    /* 24B60 80034360 21800000 */  addu       $s0, $zero, $zero
  .L80034364:
    /* 24B64 80034364 38052426 */  addiu      $a0, $s1, 0x538
    /* 24B68 80034368 53D8030C */  jal        crc16
    /* 24B6C 8003436C 10000524 */   addiu     $a1, $zero, 0x10
    /* 24B70 80034370 A014238E */  lw         $v1, 0x14A0($s1)
    /* 24B74 80034374 00000000 */  nop
    /* 24B78 80034378 02006210 */  beq        $v1, $v0, .L80034384
    /* 24B7C 8003437C 01001032 */   andi      $s0, $s0, 0x1
    /* 24B80 80034380 21800000 */  addu       $s0, $zero, $zero
  .L80034384:
    /* 24B84 80034384 48052426 */  addiu      $a0, $s1, 0x548
    /* 24B88 80034388 53D8030C */  jal        crc16
    /* 24B8C 8003438C B0000524 */   addiu     $a1, $zero, 0xB0
    /* 24B90 80034390 A414238E */  lw         $v1, 0x14A4($s1)
    /* 24B94 80034394 00000000 */  nop
    /* 24B98 80034398 02006210 */  beq        $v1, $v0, .L800343A4
    /* 24B9C 8003439C 01001032 */   andi      $s0, $s0, 0x1
    /* 24BA0 800343A0 21800000 */  addu       $s0, $zero, $zero
  .L800343A4:
    /* 24BA4 800343A4 F8052426 */  addiu      $a0, $s1, 0x5F8
    /* 24BA8 800343A8 53D8030C */  jal        crc16
    /* 24BAC 800343AC 9C0E0524 */   addiu     $a1, $zero, 0xE9C
    /* 24BB0 800343B0 A814238E */  lw         $v1, 0x14A8($s1)
    /* 24BB4 800343B4 00000000 */  nop
    /* 24BB8 800343B8 02006210 */  beq        $v1, $v0, .L800343C4
    /* 24BBC 800343BC 01001032 */   andi      $s0, $s0, 0x1
    /* 24BC0 800343C0 21800000 */  addu       $s0, $zero, $zero
  .L800343C4:
    /* 24BC4 800343C4 0000238E */  lw         $v1, 0x0($s1)
    /* 24BC8 800343C8 AC140224 */  addiu      $v0, $zero, 0x14AC
    /* 24BCC 800343CC 02006210 */  beq        $v1, $v0, .L800343D8
    /* 24BD0 800343D0 01001032 */   andi      $s0, $s0, 0x1
    /* 24BD4 800343D4 21800000 */  addu       $s0, $zero, $zero
  .L800343D8:
    /* 24BD8 800343D8 21100002 */  addu       $v0, $s0, $zero
    /* 24BDC 800343DC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 24BE0 800343E0 1400B18F */  lw         $s1, 0x14($sp)
    /* 24BE4 800343E4 1000B08F */  lw         $s0, 0x10($sp)
    /* 24BE8 800343E8 0800E003 */  jr         $ra
    /* 24BEC 800343EC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel VerifySuccessfulRead__FP12tMemCardData
