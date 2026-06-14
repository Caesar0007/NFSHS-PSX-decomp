.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__21tPListIteratorIndexed7tPlayer, 0xCC

glabel Decrement__21tPListIteratorIndexed7tPlayer
    /* 97B1C 800A731C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97B20 800A7320 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97B24 800A7324 0C00868C */  lw         $a2, 0xC($a0)
    /* 97B28 800A7328 00000000 */  nop
    /* 97B2C 800A732C 0000C290 */  lbu        $v0, 0x0($a2)
    /* 97B30 800A7330 0400858C */  lw         $a1, 0x4($a0)
    /* 97B34 800A7334 80100200 */  sll        $v0, $v0, 2
    /* 97B38 800A7338 21184500 */  addu       $v1, $v0, $a1
    /* 97B3C 800A733C 0000628C */  lw         $v0, 0x0($v1)
    /* 97B40 800A7340 00000000 */  nop
    /* 97B44 800A7344 1F004014 */  bnez       $v0, .L800A73C4
    /* 97B48 800A7348 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 97B4C 800A734C 0000828C */  lw         $v0, 0x0($a0)
    /* 97B50 800A7350 00000000 */  nop
    /* 97B54 800A7354 02004284 */  lh         $v0, 0x2($v0)
    /* 97B58 800A7358 00000000 */  nop
    /* 97B5C 800A735C 1A004018 */  blez       $v0, .L800A73C8
    /* 97B60 800A7360 00000000 */   nop
  .L800A7364:
    /* 97B64 800A7364 0000C390 */  lbu        $v1, 0x0($a2)
    /* 97B68 800A7368 00000000 */  nop
    /* 97B6C 800A736C 80180300 */  sll        $v1, $v1, 2
    /* 97B70 800A7370 21186500 */  addu       $v1, $v1, $a1
    /* 97B74 800A7374 0000628C */  lw         $v0, 0x0($v1)
    /* 97B78 800A7378 00000000 */  nop
    /* 97B7C 800A737C 01004224 */  addiu      $v0, $v0, 0x1
    /* 97B80 800A7380 000062AC */  sw         $v0, 0x0($v1)
    /* 97B84 800A7384 0C00868C */  lw         $a2, 0xC($a0)
    /* 97B88 800A7388 00000000 */  nop
    /* 97B8C 800A738C 0000C290 */  lbu        $v0, 0x0($a2)
    /* 97B90 800A7390 0400858C */  lw         $a1, 0x4($a0)
    /* 97B94 800A7394 80100200 */  sll        $v0, $v0, 2
    /* 97B98 800A7398 21104500 */  addu       $v0, $v0, $a1
    /* 97B9C 800A739C 0000428C */  lw         $v0, 0x0($v0)
    /* 97BA0 800A73A0 0000838C */  lw         $v1, 0x0($a0)
    /* 97BA4 800A73A4 40100200 */  sll        $v0, $v0, 1
    /* 97BA8 800A73A8 21104300 */  addu       $v0, $v0, $v1
    /* 97BAC 800A73AC 02004284 */  lh         $v0, 0x2($v0)
    /* 97BB0 800A73B0 00000000 */  nop
    /* 97BB4 800A73B4 04004018 */  blez       $v0, .L800A73C8
    /* 97BB8 800A73B8 00000000 */   nop
    /* 97BBC 800A73BC D99C0208 */  j          .L800A7364
    /* 97BC0 800A73C0 00000000 */   nop
  .L800A73C4:
    /* 97BC4 800A73C4 000062AC */  sw         $v0, 0x0($v1)
  .L800A73C8:
    /* 97BC8 800A73C8 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 97BCC 800A73CC 05000424 */   addiu     $a0, $zero, 0x5
    /* 97BD0 800A73D0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97BD4 800A73D4 01000224 */  addiu      $v0, $zero, 0x1
    /* 97BD8 800A73D8 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 97BDC 800A73DC 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 97BE0 800A73E0 0800E003 */  jr         $ra
    /* 97BE4 800A73E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Decrement__21tPListIteratorIndexed7tPlayer
