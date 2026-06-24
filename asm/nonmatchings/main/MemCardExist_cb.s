.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardExist_cb, 0x1D4

glabel MemCardExist_cb
    /* EB3F0 800FABF0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EB3F4 800FABF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* EB3F8 800FABF8 21808000 */  addu       $s0, $a0, $zero
    /* EB3FC 800FABFC 1800BFAF */  sw         $ra, 0x18($sp)
    /* EB400 800FAC00 1400B1AF */  sw         $s1, 0x14($sp)
    /* EB404 800FAC04 0000038E */  lw         $v1, 0x0($s0)
    /* EB408 800FAC08 00000000 */  nop
    /* EB40C 800FAC0C 09006010 */  beqz       $v1, .L800FAC34
    /* EB410 800FAC10 0A000224 */   addiu     $v0, $zero, 0xA
    /* EB414 800FAC14 65006004 */  bltz       $v1, .L800FADAC
    /* EB418 800FAC18 0A001124 */   addiu     $s1, $zero, 0xA
    /* EB41C 800FAC1C 0A007110 */  beq        $v1, $s1, .L800FAC48
    /* EB420 800FAC20 0B000224 */   addiu     $v0, $zero, 0xB
    /* EB424 800FAC24 13006210 */  beq        $v1, $v0, .L800FAC74
    /* EB428 800FAC28 21100000 */   addu      $v0, $zero, $zero
    /* EB42C 800FAC2C 6CEB0308 */  j          .L800FADB0
    /* EB430 800FAC30 00000000 */   nop
  .L800FAC34:
    /* EB434 800FAC34 1480013C */  lui        $at, %hi(D_80147504)
    /* EB438 800FAC38 047520AC */  sw         $zero, %lo(D_80147504)($at)
    /* EB43C 800FAC3C 1480013C */  lui        $at, %hi(D_80147500)
    /* EB440 800FAC40 007520AC */  sw         $zero, %lo(D_80147500)($at)
    /* EB444 800FAC44 000002AE */  sw         $v0, 0x0($s0)
  .L800FAC48:
    /* EB448 800FAC48 3426040C */  jal        _clr_card_event
    /* EB44C 800FAC4C 00000000 */   nop
    /* EB450 800FAC50 1480043C */  lui        $a0, %hi(D_80147524)
    /* EB454 800FAC54 2475848C */  lw         $a0, %lo(D_80147524)($a0)
    /* EB458 800FAC58 4427040C */  jal        _card_info
    /* EB45C 800FAC5C 00000000 */   nop
    /* EB460 800FAC60 0000028E */  lw         $v0, 0x0($s0)
    /* EB464 800FAC64 00000000 */  nop
    /* EB468 800FAC68 01004224 */  addiu      $v0, $v0, 0x1
    /* EB46C 800FAC6C 6BEB0308 */  j          .L800FADAC
    /* EB470 800FAC70 000002AE */   sw        $v0, 0x0($s0)
  .L800FAC74:
    /* EB474 800FAC74 E226040C */  jal        _chk_card_event
    /* EB478 800FAC78 00000000 */   nop
    /* EB47C 800FAC7C 4C004010 */  beqz       $v0, .L800FADB0
    /* EB480 800FAC80 21100000 */   addu      $v0, $zero, $zero
    /* EB484 800FAC84 7626040C */  jal        _get_card_event
    /* EB488 800FAC88 00000000 */   nop
    /* EB48C 800FAC8C 21184000 */  addu       $v1, $v0, $zero
    /* EB490 800FAC90 1480013C */  lui        $at, %hi(D_80147504)
    /* EB494 800FAC94 047522AC */  sw         $v0, %lo(D_80147504)($at)
    /* EB498 800FAC98 03006228 */  slti       $v0, $v1, 0x3
    /* EB49C 800FAC9C 07004010 */  beqz       $v0, .L800FACBC
    /* EB4A0 800FACA0 00000000 */   nop
    /* EB4A4 800FACA4 2300601C */  bgtz       $v1, .L800FAD34
    /* EB4A8 800FACA8 00000000 */   nop
    /* EB4AC 800FACAC 0D006010 */  beqz       $v1, .L800FACE4
    /* EB4B0 800FACB0 01000224 */   addiu     $v0, $zero, 0x1
    /* EB4B4 800FACB4 58EB0308 */  j          .L800FAD60
    /* EB4B8 800FACB8 00000000 */   nop
  .L800FACBC:
    /* EB4BC 800FACBC 04000224 */  addiu      $v0, $zero, 0x4
    /* EB4C0 800FACC0 27006214 */  bne        $v1, $v0, .L800FAD60
    /* EB4C4 800FACC4 00000000 */   nop
    /* EB4C8 800FACC8 47F0030C */  jal        MemCardEventToRslt
    /* EB4CC 800FACCC 04000424 */   addiu     $a0, $zero, 0x4
    /* EB4D0 800FACD0 1480033C */  lui        $v1, %hi(D_80147518)
    /* EB4D4 800FACD4 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EB4D8 800FACD8 040062AC */  sw         $v0, 0x4($v1)
    /* EB4DC 800FACDC 6CEB0308 */  j          .L800FADB0
    /* EB4E0 800FACE0 01000224 */   addiu     $v0, $zero, 0x1
  .L800FACE4:
    /* EB4E4 800FACE4 1480103C */  lui        $s0, %hi(D_80147524)
    /* EB4E8 800FACE8 24751026 */  addiu      $s0, $s0, %lo(D_80147524)
    /* EB4EC 800FACEC 0000048E */  lw         $a0, 0x0($s0)
    /* EB4F0 800FACF0 1480033C */  lui        $v1, %hi(D_80147514)
    /* EB4F4 800FACF4 1475638C */  lw         $v1, %lo(D_80147514)($v1)
    /* EB4F8 800FACF8 04108200 */  sllv       $v0, $v0, $a0
    /* EB4FC 800FACFC 24186200 */  and        $v1, $v1, $v0
    /* EB500 800FAD00 03006014 */  bnez       $v1, .L800FAD10
    /* EB504 800FAD04 04000224 */   addiu     $v0, $zero, 0x4
    /* EB508 800FAD08 1480013C */  lui        $at, %hi(D_80147504)
    /* EB50C 800FAD0C 047522AC */  sw         $v0, %lo(D_80147504)($at)
  .L800FAD10:
    /* EB510 800FAD10 1480043C */  lui        $a0, %hi(D_80147504)
    /* EB514 800FAD14 0475848C */  lw         $a0, %lo(D_80147504)($a0)
    /* EB518 800FAD18 47F0030C */  jal        MemCardEventToRslt
    /* EB51C 800FAD1C 00000000 */   nop
    /* EB520 800FAD20 21204000 */  addu       $a0, $v0, $zero
    /* EB524 800FAD24 01000224 */  addiu      $v0, $zero, 0x1
    /* EB528 800FAD28 F4FF0326 */  addiu      $v1, $s0, -0xC
    /* EB52C 800FAD2C 6CEB0308 */  j          .L800FADB0
    /* EB530 800FAD30 040064AC */   sw        $a0, 0x4($v1)
  .L800FAD34:
    /* EB534 800FAD34 1480023C */  lui        $v0, %hi(D_80147500)
    /* EB538 800FAD38 0075428C */  lw         $v0, %lo(D_80147500)($v0)
    /* EB53C 800FAD3C 00000000 */  nop
    /* EB540 800FAD40 01004224 */  addiu      $v0, $v0, 0x1
    /* EB544 800FAD44 1480013C */  lui        $at, %hi(D_80147500)
    /* EB548 800FAD48 007522AC */  sw         $v0, %lo(D_80147500)($at)
    /* EB54C 800FAD4C 05004228 */  slti       $v0, $v0, 0x5
    /* EB550 800FAD50 03004010 */  beqz       $v0, .L800FAD60
    /* EB554 800FAD54 00000000 */   nop
    /* EB558 800FAD58 6BEB0308 */  j          .L800FADAC
    /* EB55C 800FAD5C 000011AE */   sw        $s1, 0x0($s0)
  .L800FAD60:
    /* EB560 800FAD60 1480103C */  lui        $s0, %hi(D_80147524)
    /* EB564 800FAD64 24751026 */  addiu      $s0, $s0, %lo(D_80147524)
    /* EB568 800FAD68 01000224 */  addiu      $v0, $zero, 0x1
    /* EB56C 800FAD6C 0000038E */  lw         $v1, 0x0($s0)
    /* EB570 800FAD70 1480043C */  lui        $a0, %hi(D_80147504)
    /* EB574 800FAD74 0475848C */  lw         $a0, %lo(D_80147504)($a0)
    /* EB578 800FAD78 04106200 */  sllv       $v0, $v0, $v1
    /* EB57C 800FAD7C 1480033C */  lui        $v1, %hi(D_80147514)
    /* EB580 800FAD80 1475638C */  lw         $v1, %lo(D_80147514)($v1)
    /* EB584 800FAD84 27100200 */  nor        $v0, $zero, $v0
    /* EB588 800FAD88 24186200 */  and        $v1, $v1, $v0
    /* EB58C 800FAD8C 1480013C */  lui        $at, %hi(D_80147514)
    /* EB590 800FAD90 147523AC */  sw         $v1, %lo(D_80147514)($at)
    /* EB594 800FAD94 47F0030C */  jal        MemCardEventToRslt
    /* EB598 800FAD98 F4FF1026 */   addiu     $s0, $s0, -0xC
    /* EB59C 800FAD9C 21184000 */  addu       $v1, $v0, $zero
    /* EB5A0 800FADA0 01000224 */  addiu      $v0, $zero, 0x1
    /* EB5A4 800FADA4 6CEB0308 */  j          .L800FADB0
    /* EB5A8 800FADA8 040003AE */   sw        $v1, 0x4($s0)
  .L800FADAC:
    /* EB5AC 800FADAC 21100000 */  addu       $v0, $zero, $zero
  .L800FADB0:
    /* EB5B0 800FADB0 1800BF8F */  lw         $ra, 0x18($sp)
    /* EB5B4 800FADB4 1400B18F */  lw         $s1, 0x14($sp)
    /* EB5B8 800FADB8 1000B08F */  lw         $s0, 0x10($sp)
    /* EB5BC 800FADBC 0800E003 */  jr         $ra
    /* EB5C0 800FADC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MemCardExist_cb
