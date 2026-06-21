.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcAnimFrame__23tScreenControllerConfigi, 0x8C

glabel CalcAnimFrame__23tScreenControllerConfigi
    /* 342F0 80043AF0 74018390 */  lbu        $v1, 0x174($a0)
    /* 342F4 80043AF4 02000224 */  addiu      $v0, $zero, 0x2
    /* 342F8 80043AF8 1E006214 */  bne        $v1, $v0, .L80043B74
    /* 342FC 80043AFC 00000000 */   nop
    /* 34300 80043B00 0500A010 */  beqz       $a1, .L80043B18
    /* 34304 80043B04 14000224 */   addiu     $v0, $zero, 0x14
    /* 34308 80043B08 0300A210 */  beq        $a1, $v0, .L80043B18
    /* 3430C 80043B0C 28000224 */   addiu     $v0, $zero, 0x28
    /* 34310 80043B10 0300A214 */  bne        $a1, $v0, .L80043B20
    /* 34314 80043B14 0B00A228 */   slti      $v0, $a1, 0xB
  .L80043B18:
    /* 34318 80043B18 DD0E0108 */  j          .L80043B74
    /* 3431C 80043B1C 01000524 */   addiu     $a1, $zero, 0x1
  .L80043B20:
    /* 34320 80043B20 06004010 */  beqz       $v0, .L80043B3C
    /* 34324 80043B24 0A00A228 */   slti      $v0, $a1, 0xA
    /* 34328 80043B28 02004014 */  bnez       $v0, .L80043B34
    /* 3432C 80043B2C 00000000 */   nop
    /* 34330 80043B30 09000524 */  addiu      $a1, $zero, 0x9
  .L80043B34:
    /* 34334 80043B34 DD0E0108 */  j          .L80043B74
    /* 34338 80043B38 0200A524 */   addiu     $a1, $a1, 0x2
  .L80043B3C:
    /* 3433C 80043B3C 1400A228 */  slti       $v0, $a1, 0x14
    /* 34340 80043B40 0B004014 */  bnez       $v0, .L80043B70
    /* 34344 80043B44 16000224 */   addiu     $v0, $zero, 0x16
    /* 34348 80043B48 1F00A228 */  slti       $v0, $a1, 0x1F
    /* 3434C 80043B4C 08004010 */  beqz       $v0, .L80043B70
    /* 34350 80043B50 38000224 */   addiu     $v0, $zero, 0x38
    /* 34354 80043B54 ECFFA524 */  addiu      $a1, $a1, -0x14
    /* 34358 80043B58 0A00A228 */  slti       $v0, $a1, 0xA
    /* 3435C 80043B5C 02004014 */  bnez       $v0, .L80043B68
    /* 34360 80043B60 00000000 */   nop
    /* 34364 80043B64 09000524 */  addiu      $a1, $zero, 0x9
  .L80043B68:
    /* 34368 80043B68 DD0E0108 */  j          .L80043B74
    /* 3436C 80043B6C 1000A524 */   addiu     $a1, $a1, 0x10
  .L80043B70:
    /* 34370 80043B70 23284500 */  subu       $a1, $v0, $a1
  .L80043B74:
    /* 34374 80043B74 0800E003 */  jr         $ra
    /* 34378 80043B78 2110A000 */   addu      $v0, $a1, $zero
endlabel CalcAnimFrame__23tScreenControllerConfigi
