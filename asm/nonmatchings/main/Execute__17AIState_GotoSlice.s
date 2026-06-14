.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__17AIState_GotoSlice, 0x118

glabel Execute__17AIState_GotoSlice
    /* 62BC0 800723C0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 62BC4 800723C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62BC8 800723C8 21808000 */  addu       $s0, $a0, $zero
    /* 62BCC 800723CC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 62BD0 800723D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 62BD4 800723D4 0800048E */  lw         $a0, 0x8($s0)
    /* 62BD8 800723D8 0000058E */  lw         $a1, 0x0($s0)
    /* 62BDC 800723DC 65CC010C */  jal        AIWorld_ApxSplineDistance__FiP8Car_tObj
    /* 62BE0 800723E0 00000000 */   nop
    /* 62BE4 800723E4 21884000 */  addu       $s1, $v0, $zero
    /* 62BE8 800723E8 04002006 */  bltz       $s1, .L800723FC
    /* 62BEC 800723EC 01000224 */   addiu     $v0, $zero, 0x1
    /* 62BF0 800723F0 0000038E */  lw         $v1, 0x0($s0)
    /* 62BF4 800723F4 02C90108 */  j          .L80072408
    /* 62BF8 800723F8 500562AC */   sw        $v0, 0x550($v1)
  .L800723FC:
    /* 62BFC 800723FC 0000038E */  lw         $v1, 0x0($s0)
    /* 62C00 80072400 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 62C04 80072404 500562AC */  sw         $v0, 0x550($v1)
  .L80072408:
    /* 62C08 80072408 A3BE010C */  jal        Execute__14AIState_Normal
    /* 62C0C 8007240C 21200002 */   addu      $a0, $s0, $zero
    /* 62C10 80072410 0C00028E */  lw         $v0, 0xC($s0)
    /* 62C14 80072414 00000000 */  nop
    /* 62C18 80072418 2A004010 */  beqz       $v0, .L800724C4
    /* 62C1C 8007241C 0B00023C */   lui       $v0, (0xBFFFF >> 16)
    /* 62C20 80072420 FFFF4234 */  ori        $v0, $v0, (0xBFFFF & 0xFFFF)
    /* 62C24 80072424 02002106 */  bgez       $s1, .L80072430
    /* 62C28 80072428 21182002 */   addu      $v1, $s1, $zero
    /* 62C2C 8007242C 23180300 */  negu       $v1, $v1
  .L80072430:
    /* 62C30 80072430 2A104300 */  slt        $v0, $v0, $v1
    /* 62C34 80072434 03004014 */  bnez       $v0, .L80072444
    /* 62C38 80072438 C800043C */   lui       $a0, (0xC80000 >> 16)
    /* 62C3C 8007243C 23C90108 */  j          .L8007248C
    /* 62C40 80072440 0400043C */   lui       $a0, (0x40000 >> 16)
  .L80072444:
    /* 62C44 80072444 3100023C */  lui        $v0, (0x31FFFF >> 16)
    /* 62C48 80072448 FFFF4234 */  ori        $v0, $v0, (0x31FFFF & 0xFFFF)
    /* 62C4C 8007244C 2A104300 */  slt        $v0, $v0, $v1
    /* 62C50 80072450 03004014 */  bnez       $v0, .L80072460
    /* 62C54 80072454 9500023C */   lui       $v0, (0x95FFFF >> 16)
    /* 62C58 80072458 23C90108 */  j          .L8007248C
    /* 62C5C 8007245C 1400043C */   lui       $a0, (0x140000 >> 16)
  .L80072460:
    /* 62C60 80072460 FFFF4234 */  ori        $v0, $v0, (0x95FFFF & 0xFFFF)
    /* 62C64 80072464 2A104300 */  slt        $v0, $v0, $v1
    /* 62C68 80072468 03004014 */  bnez       $v0, .L80072478
    /* 62C6C 8007246C 8F01023C */   lui       $v0, (0x18FFFFF >> 16)
    /* 62C70 80072470 23C90108 */  j          .L8007248C
    /* 62C74 80072474 2800043C */   lui       $a0, (0x280000 >> 16)
  .L80072478:
    /* 62C78 80072478 FFFF4234 */  ori        $v0, $v0, (0x18FFFFF & 0xFFFF)
    /* 62C7C 8007247C 2A104300 */  slt        $v0, $v0, $v1
    /* 62C80 80072480 02004014 */  bnez       $v0, .L8007248C
    /* 62C84 80072484 00000000 */   nop
    /* 62C88 80072488 5000043C */  lui        $a0, (0x500000 >> 16)
  .L8007248C:
    /* 62C8C 8007248C 0000038E */  lw         $v1, 0x0($s0)
    /* 62C90 80072490 00000000 */  nop
    /* 62C94 80072494 5C05678C */  lw         $a3, 0x55C($v1)
    /* 62C98 80072498 00000000 */  nop
    /* 62C9C 8007249C 0300E004 */  bltz       $a3, .L800724AC
    /* 62CA0 800724A0 21308000 */   addu      $a2, $a0, $zero
    /* 62CA4 800724A4 2DC90108 */  j          .L800724B4
    /* 62CA8 800724A8 2A10E600 */   slt       $v0, $a3, $a2
  .L800724AC:
    /* 62CAC 800724AC 23300400 */  negu       $a2, $a0
    /* 62CB0 800724B0 2A10C700 */  slt        $v0, $a2, $a3
  .L800724B4:
    /* 62CB4 800724B4 02004010 */  beqz       $v0, .L800724C0
    /* 62CB8 800724B8 00000000 */   nop
    /* 62CBC 800724BC 2130E000 */  addu       $a2, $a3, $zero
  .L800724C0:
    /* 62CC0 800724C0 5C0566AC */  sw         $a2, 0x55C($v1)
  .L800724C4:
    /* 62CC4 800724C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 62CC8 800724C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 62CCC 800724CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 62CD0 800724D0 0800E003 */  jr         $ra
    /* 62CD4 800724D4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Execute__17AIState_GotoSlice
