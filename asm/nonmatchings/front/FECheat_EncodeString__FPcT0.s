.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_EncodeString__FPcT0, 0x8C

glabel FECheat_EncodeString__FPcT0
    /* 13C10 80023410 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* 13C14 80023414 21308000 */  addu       $a2, $a0, $zero
    /* 13C18 80023418 21380000 */  addu       $a3, $zero, $zero
  .L8002341C:
    /* 13C1C 8002341C 2120A703 */  addu       $a0, $sp, $a3
    /* 13C20 80023420 2110C700 */  addu       $v0, $a2, $a3
    /* 13C24 80023424 2118A700 */  addu       $v1, $a1, $a3
    /* 13C28 80023428 00004290 */  lbu        $v0, 0x0($v0)
    /* 13C2C 8002342C 0100E724 */  addiu      $a3, $a3, 0x1
    /* 13C30 80023430 000082A0 */  sb         $v0, 0x0($a0)
    /* 13C34 80023434 0800E228 */  slti       $v0, $a3, 0x8
    /* 13C38 80023438 F8FF4014 */  bnez       $v0, .L8002341C
    /* 13C3C 8002343C 000060A0 */   sb        $zero, 0x0($v1)
    /* 13C40 80023440 21380000 */  addu       $a3, $zero, $zero
  .L80023444:
    /* 13C44 80023444 21300000 */  addu       $a2, $zero, $zero
    /* 13C48 80023448 2140A700 */  addu       $t0, $a1, $a3
  .L8002344C:
    /* 13C4C 8002344C 2120A603 */  addu       $a0, $sp, $a2
    /* 13C50 80023450 00008290 */  lbu        $v0, 0x0($a0)
    /* 13C54 80023454 00000391 */  lbu        $v1, 0x0($t0)
    /* 13C58 80023458 01004230 */  andi       $v0, $v0, 0x1
    /* 13C5C 8002345C 0410C200 */  sllv       $v0, $v0, $a2
    /* 13C60 80023460 25186200 */  or         $v1, $v1, $v0
    /* 13C64 80023464 000003A1 */  sb         $v1, 0x0($t0)
    /* 13C68 80023468 00008290 */  lbu        $v0, 0x0($a0)
    /* 13C6C 8002346C 0100C624 */  addiu      $a2, $a2, 0x1
    /* 13C70 80023470 42100200 */  srl        $v0, $v0, 1
    /* 13C74 80023474 000082A0 */  sb         $v0, 0x0($a0)
    /* 13C78 80023478 0800C228 */  slti       $v0, $a2, 0x8
    /* 13C7C 8002347C F3FF4014 */  bnez       $v0, .L8002344C
    /* 13C80 80023480 00000000 */   nop
    /* 13C84 80023484 0100E724 */  addiu      $a3, $a3, 0x1
    /* 13C88 80023488 0800E228 */  slti       $v0, $a3, 0x8
    /* 13C8C 8002348C EDFF4014 */  bnez       $v0, .L80023444
    /* 13C90 80023490 00000000 */   nop
    /* 13C94 80023494 0800E003 */  jr         $ra
    /* 13C98 80023498 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel FECheat_EncodeString__FPcT0
