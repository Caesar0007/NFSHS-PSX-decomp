.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching reorthogonalize, 0x230

glabel reorthogonalize
    /* E0AE4 800F02E4 00FFBD27 */  addiu      $sp, $sp, -0x100
    /* E0AE8 800F02E8 E800B4AF */  sw         $s4, 0xE8($sp)
    /* E0AEC 800F02EC 21A08000 */  addu       $s4, $a0, $zero
    /* E0AF0 800F02F0 F000B6AF */  sw         $s6, 0xF0($sp)
    /* E0AF4 800F02F4 21B00000 */  addu       $s6, $zero, $zero
    /* E0AF8 800F02F8 E400B3AF */  sw         $s3, 0xE4($sp)
    /* E0AFC 800F02FC 3800B327 */  addiu      $s3, $sp, 0x38
    /* E0B00 800F0300 1280073C */  lui        $a3, %hi(identitymatrix)
    /* E0B04 800F0304 EC37E724 */  addiu      $a3, $a3, %lo(identitymatrix)
    /* E0B08 800F0308 F800BEAF */  sw         $fp, 0xF8($sp)
    /* E0B0C 800F030C 2000FE24 */  addiu      $fp, $a3, 0x20
    /* E0B10 800F0310 EC00B5AF */  sw         $s5, 0xEC($sp)
    /* E0B14 800F0314 8800B527 */  addiu      $s5, $sp, 0x88
    /* E0B18 800F0318 F400B7AF */  sw         $s7, 0xF4($sp)
    /* E0B1C 800F031C 5800B727 */  addiu      $s7, $sp, 0x58
    /* E0B20 800F0320 FC00BFAF */  sw         $ra, 0xFC($sp)
    /* E0B24 800F0324 E000B2AF */  sw         $s2, 0xE0($sp)
    /* E0B28 800F0328 DC00B1AF */  sw         $s1, 0xDC($sp)
    /* E0B2C 800F032C D800B0AF */  sw         $s0, 0xD8($sp)
    /* E0B30 800F0330 21208002 */  addu       $a0, $s4, $zero
  .L800F0334:
    /* E0B34 800F0334 D690030C */  jal        transpose
    /* E0B38 800F0338 21286002 */   addu      $a1, $s3, $zero
    /* E0B3C 800F033C 21206002 */  addu       $a0, $s3, $zero
    /* E0B40 800F0340 21288002 */  addu       $a1, $s4, $zero
    /* E0B44 800F0344 D017040C */  jal        transmult
    /* E0B48 800F0348 1000A627 */   addiu     $a2, $sp, 0x10
    /* E0B4C 800F034C 1000A427 */  addiu      $a0, $sp, 0x10
    /* E0B50 800F0350 1280053C */  lui        $a1, %hi(identitymatrix)
    /* E0B54 800F0354 EC37A524 */  addiu      $a1, $a1, %lo(identitymatrix)
    /* E0B58 800F0358 8DC0030C */  jal        submatrix
    /* E0B5C 800F035C 6000A627 */   addiu     $a2, $sp, 0x60
    /* E0B60 800F0360 8800A327 */  addiu      $v1, $sp, 0x88
    /* E0B64 800F0364 1280023C */  lui        $v0, %hi(identitymatrix)
    /* E0B68 800F0368 EC374224 */  addiu      $v0, $v0, %lo(identitymatrix)
  .L800F036C:
    /* E0B6C 800F036C 0000488C */  lw         $t0, 0x0($v0)
    /* E0B70 800F0370 0400498C */  lw         $t1, 0x4($v0)
    /* E0B74 800F0374 08004A8C */  lw         $t2, 0x8($v0)
    /* E0B78 800F0378 0C00478C */  lw         $a3, 0xC($v0)
    /* E0B7C 800F037C 000068AC */  sw         $t0, 0x0($v1)
    /* E0B80 800F0380 040069AC */  sw         $t1, 0x4($v1)
    /* E0B84 800F0384 08006AAC */  sw         $t2, 0x8($v1)
    /* E0B88 800F0388 0C0067AC */  sw         $a3, 0xC($v1)
    /* E0B8C 800F038C 10004224 */  addiu      $v0, $v0, 0x10
    /* E0B90 800F0390 F6FF5E14 */  bne        $v0, $fp, .L800F036C
    /* E0B94 800F0394 10006324 */   addiu     $v1, $v1, 0x10
    /* E0B98 800F0398 0000C88F */  lw         $t0, 0x0($fp)
    /* E0B9C 800F039C 00000000 */  nop
    /* E0BA0 800F03A0 000068AC */  sw         $t0, 0x0($v1)
    /* E0BA4 800F03A4 B000A327 */  addiu      $v1, $sp, 0xB0
    /* E0BA8 800F03A8 1280083C */  lui        $t0, %hi(identitymatrix)
    /* E0BAC 800F03AC EC370225 */  addiu      $v0, $t0, %lo(identitymatrix)
  .L800F03B0:
    /* E0BB0 800F03B0 0000498C */  lw         $t1, 0x0($v0)
    /* E0BB4 800F03B4 04004A8C */  lw         $t2, 0x4($v0)
    /* E0BB8 800F03B8 0800478C */  lw         $a3, 0x8($v0)
    /* E0BBC 800F03BC 0C00488C */  lw         $t0, 0xC($v0)
    /* E0BC0 800F03C0 000069AC */  sw         $t1, 0x0($v1)
    /* E0BC4 800F03C4 04006AAC */  sw         $t2, 0x4($v1)
    /* E0BC8 800F03C8 080067AC */  sw         $a3, 0x8($v1)
    /* E0BCC 800F03CC 0C0068AC */  sw         $t0, 0xC($v1)
    /* E0BD0 800F03D0 10004224 */  addiu      $v0, $v0, 0x10
    /* E0BD4 800F03D4 F6FF5E14 */  bne        $v0, $fp, .L800F03B0
    /* E0BD8 800F03D8 10006324 */   addiu     $v1, $v1, 0x10
    /* E0BDC 800F03DC 0000498C */  lw         $t1, 0x0($v0)
    /* E0BE0 800F03E0 00000000 */  nop
    /* E0BE4 800F03E4 000069AC */  sw         $t1, 0x0($v1)
    /* E0BE8 800F03E8 01001124 */  addiu      $s1, $zero, 0x1
    /* E0BEC 800F03EC B000B227 */  addiu      $s2, $sp, 0xB0
    /* E0BF0 800F03F0 1280023C */  lui        $v0, %hi(D_80123810)
    /* E0BF4 800F03F4 10384224 */  addiu      $v0, $v0, %lo(D_80123810)
    /* E0BF8 800F03F8 04005024 */  addiu      $s0, $v0, 0x4
    /* E0BFC 800F03FC 2120A002 */  addu       $a0, $s5, $zero
  .L800F0400:
    /* E0C00 800F0400 6000A527 */  addiu      $a1, $sp, 0x60
    /* E0C04 800F0404 D017040C */  jal        transmult
    /* E0C08 800F0408 21306002 */   addu      $a2, $s3, $zero
    /* E0C0C 800F040C 2118A002 */  addu       $v1, $s5, $zero
    /* E0C10 800F0410 21106002 */  addu       $v0, $s3, $zero
  .L800F0414:
    /* E0C14 800F0414 0000498C */  lw         $t1, 0x0($v0)
    /* E0C18 800F0418 04004A8C */  lw         $t2, 0x4($v0)
    /* E0C1C 800F041C 0800478C */  lw         $a3, 0x8($v0)
    /* E0C20 800F0420 0C00488C */  lw         $t0, 0xC($v0)
    /* E0C24 800F0424 000069AC */  sw         $t1, 0x0($v1)
    /* E0C28 800F0428 04006AAC */  sw         $t2, 0x4($v1)
    /* E0C2C 800F042C 080067AC */  sw         $a3, 0x8($v1)
    /* E0C30 800F0430 0C0068AC */  sw         $t0, 0xC($v1)
    /* E0C34 800F0434 10004224 */  addiu      $v0, $v0, 0x10
    /* E0C38 800F0438 F6FF5714 */  bne        $v0, $s7, .L800F0414
    /* E0C3C 800F043C 10006324 */   addiu     $v1, $v1, 0x10
    /* E0C40 800F0440 8800A427 */  addiu      $a0, $sp, 0x88
    /* E0C44 800F0444 1000A627 */  addiu      $a2, $sp, 0x10
    /* E0C48 800F0448 0000498C */  lw         $t1, 0x0($v0)
    /* E0C4C 800F044C 00000000 */  nop
    /* E0C50 800F0450 000069AC */  sw         $t1, 0x0($v1)
    /* E0C54 800F0454 0000058E */  lw         $a1, 0x0($s0)
    /* E0C58 800F0458 04001026 */  addiu      $s0, $s0, 0x4
    /* E0C5C 800F045C 9BC0030C */  jal        scalematrix
    /* E0C60 800F0460 01003126 */   addiu     $s1, $s1, 0x1
    /* E0C64 800F0464 21204002 */  addu       $a0, $s2, $zero
    /* E0C68 800F0468 1000A527 */  addiu      $a1, $sp, 0x10
    /* E0C6C 800F046C 7FC0030C */  jal        addmatrix
    /* E0C70 800F0470 21304002 */   addu      $a2, $s2, $zero
    /* E0C74 800F0474 0400222A */  slti       $v0, $s1, 0x4
    /* E0C78 800F0478 E1FF4014 */  bnez       $v0, .L800F0400
    /* E0C7C 800F047C 2120A002 */   addu      $a0, $s5, $zero
    /* E0C80 800F0480 3800A327 */  addiu      $v1, $sp, 0x38
    /* E0C84 800F0484 21108002 */  addu       $v0, $s4, $zero
    /* E0C88 800F0488 20008426 */  addiu      $a0, $s4, 0x20
  .L800F048C:
    /* E0C8C 800F048C 0000498C */  lw         $t1, 0x0($v0)
    /* E0C90 800F0490 04004A8C */  lw         $t2, 0x4($v0)
    /* E0C94 800F0494 0800478C */  lw         $a3, 0x8($v0)
    /* E0C98 800F0498 0C00488C */  lw         $t0, 0xC($v0)
    /* E0C9C 800F049C 000069AC */  sw         $t1, 0x0($v1)
    /* E0CA0 800F04A0 04006AAC */  sw         $t2, 0x4($v1)
    /* E0CA4 800F04A4 080067AC */  sw         $a3, 0x8($v1)
    /* E0CA8 800F04A8 0C0068AC */  sw         $t0, 0xC($v1)
    /* E0CAC 800F04AC 10004224 */  addiu      $v0, $v0, 0x10
    /* E0CB0 800F04B0 F6FF4414 */  bne        $v0, $a0, .L800F048C
    /* E0CB4 800F04B4 10006324 */   addiu     $v1, $v1, 0x10
    /* E0CB8 800F04B8 0000498C */  lw         $t1, 0x0($v0)
    /* E0CBC 800F04BC 00000000 */  nop
    /* E0CC0 800F04C0 000069AC */  sw         $t1, 0x0($v1)
    /* E0CC4 800F04C4 3800A427 */  addiu      $a0, $sp, 0x38
    /* E0CC8 800F04C8 B000A527 */  addiu      $a1, $sp, 0xB0
    /* E0CCC 800F04CC D017040C */  jal        transmult
    /* E0CD0 800F04D0 21308002 */   addu      $a2, $s4, $zero
    /* E0CD4 800F04D4 0100D626 */  addiu      $s6, $s6, 0x1
    /* E0CD8 800F04D8 0400C22A */  slti       $v0, $s6, 0x4
    /* E0CDC 800F04DC 95FF4014 */  bnez       $v0, .L800F0334
    /* E0CE0 800F04E0 21208002 */   addu      $a0, $s4, $zero
    /* E0CE4 800F04E4 FC00BF8F */  lw         $ra, 0xFC($sp)
    /* E0CE8 800F04E8 F800BE8F */  lw         $fp, 0xF8($sp)
    /* E0CEC 800F04EC F400B78F */  lw         $s7, 0xF4($sp)
    /* E0CF0 800F04F0 F000B68F */  lw         $s6, 0xF0($sp)
    /* E0CF4 800F04F4 EC00B58F */  lw         $s5, 0xEC($sp)
    /* E0CF8 800F04F8 E800B48F */  lw         $s4, 0xE8($sp)
    /* E0CFC 800F04FC E400B38F */  lw         $s3, 0xE4($sp)
    /* E0D00 800F0500 E000B28F */  lw         $s2, 0xE0($sp)
    /* E0D04 800F0504 DC00B18F */  lw         $s1, 0xDC($sp)
    /* E0D08 800F0508 D800B08F */  lw         $s0, 0xD8($sp)
    /* E0D0C 800F050C 0800E003 */  jr         $ra
    /* E0D10 800F0510 0001BD27 */   addiu     $sp, $sp, 0x100
endlabel reorthogonalize
