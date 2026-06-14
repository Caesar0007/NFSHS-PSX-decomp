.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EF35C, 0x2B0

glabel func_800EF35C
    /* DFB5C 800EF35C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DFB60 800EF360 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DFB64 800EF364 21988000 */  addu       $s3, $a0, $zero
    /* DFB68 800EF368 1000B0AF */  sw         $s0, 0x10($sp)
    /* DFB6C 800EF36C 2180A000 */  addu       $s0, $a1, $zero
    /* DFB70 800EF370 1400B1AF */  sw         $s1, 0x14($sp)
    /* DFB74 800EF374 2188C000 */  addu       $s1, $a2, $zero
    /* DFB78 800EF378 1800B2AF */  sw         $s2, 0x18($sp)
    /* DFB7C 800EF37C 2000BFAF */  sw         $ra, 0x20($sp)
    /* DFB80 800EF380 BEBE030C */  jal        func_800EFAF8
    /* DFB84 800EF384 2190E000 */   addu      $s2, $a3, $zero
    /* DFB88 800EF388 EABC0308 */  j          .L800EF3A8
    /* DFB8C 800EF38C 00000000 */   nop
  .L800EF390:
    /* DFB90 800EF390 CBBE030C */  jal        func_800EFB2C
    /* DFB94 800EF394 00000000 */   nop
    /* DFB98 800EF398 95004014 */  bnez       $v0, .L800EF5F0
    /* DFB9C 800EF39C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DFBA0 800EF3A0 83BD030C */  jal        func_800EF60C
    /* DFBA4 800EF3A4 00000000 */   nop
  .L800EF3A8:
    /* DFBA8 800EF3A8 1280023C */  lui        $v0, %hi(_qin)
    /* DFBAC 800EF3AC C437428C */  lw         $v0, %lo(_qin)($v0)
    /* DFBB0 800EF3B0 1280033C */  lui        $v1, %hi(_qout)
    /* DFBB4 800EF3B4 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* DFBB8 800EF3B8 01004224 */  addiu      $v0, $v0, 0x1
    /* DFBBC 800EF3BC 3F004230 */  andi       $v0, $v0, 0x3F
    /* DFBC0 800EF3C0 F3FF4310 */  beq        $v0, $v1, .L800EF390
    /* DFBC4 800EF3C4 00000000 */   nop
    /* DFBC8 800EF3C8 54CA030C */  jal        SetIntrMask
    /* DFBCC 800EF3CC 21200000 */   addu      $a0, $zero, $zero
    /* DFBD0 800EF3D0 1280043C */  lui        $a0, %hi(GEnv)
    /* DFBD4 800EF3D4 9C368424 */  addiu      $a0, $a0, %lo(GEnv)
    /* DFBD8 800EF3D8 1280013C */  lui        $at, %hi(D_801237CC)
    /* DFBDC 800EF3DC CC3722AC */  sw         $v0, %lo(D_801237CC)($at)
    /* DFBE0 800EF3E0 01008390 */  lbu        $v1, 0x1($a0)
    /* DFBE4 800EF3E4 01000224 */  addiu      $v0, $zero, 0x1
    /* DFBE8 800EF3E8 14006010 */  beqz       $v1, .L800EF43C
    /* DFBEC 800EF3EC 080082AC */   sw        $v0, 0x8($a0)
    /* DFBF0 800EF3F0 1280033C */  lui        $v1, %hi(_qin)
    /* DFBF4 800EF3F4 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFBF8 800EF3F8 1280023C */  lui        $v0, %hi(_qout)
    /* DFBFC 800EF3FC C837428C */  lw         $v0, %lo(_qout)($v0)
    /* DFC00 800EF400 00000000 */  nop
    /* DFC04 800EF404 1E006214 */  bne        $v1, $v0, .L800EF480
    /* DFC08 800EF408 00000000 */   nop
    /* DFC0C 800EF40C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFC10 800EF410 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFC14 800EF414 00000000 */  nop
    /* DFC18 800EF418 0000428C */  lw         $v0, 0x0($v0)
    /* DFC1C 800EF41C 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* DFC20 800EF420 24104300 */  and        $v0, $v0, $v1
    /* DFC24 800EF424 16004014 */  bnez       $v0, .L800EF480
    /* DFC28 800EF428 00000000 */   nop
    /* DFC2C 800EF42C 0C00828C */  lw         $v0, 0xC($a0)
    /* DFC30 800EF430 00000000 */  nop
    /* DFC34 800EF434 12004014 */  bnez       $v0, .L800EF480
    /* DFC38 800EF438 00000000 */   nop
  .L800EF43C:
    /* DFC3C 800EF43C 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DFC40 800EF440 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DFC44 800EF444 0004043C */  lui        $a0, (0x4000000 >> 16)
  .L800EF448:
    /* DFC48 800EF448 0000628C */  lw         $v0, 0x0($v1)
    /* DFC4C 800EF44C 00000000 */  nop
    /* DFC50 800EF450 24104400 */  and        $v0, $v0, $a0
    /* DFC54 800EF454 FCFF4010 */  beqz       $v0, .L800EF448
    /* DFC58 800EF458 00000000 */   nop
    /* DFC5C 800EF45C 21200002 */  addu       $a0, $s0, $zero
    /* DFC60 800EF460 09F86002 */  jalr       $s3
    /* DFC64 800EF464 21284002 */   addu      $a1, $s2, $zero
    /* DFC68 800EF468 1280043C */  lui        $a0, %hi(D_801237CC)
    /* DFC6C 800EF46C CC37848C */  lw         $a0, %lo(D_801237CC)($a0)
    /* DFC70 800EF470 54CA030C */  jal        SetIntrMask
    /* DFC74 800EF474 00000000 */   nop
    /* DFC78 800EF478 7CBD0308 */  j          .L800EF5F0
    /* DFC7C 800EF47C 21100000 */   addu      $v0, $zero, $zero
  .L800EF480:
    /* DFC80 800EF480 0F80053C */  lui        $a1, %hi(func_800EF60C)
    /* DFC84 800EF484 0CF6A524 */  addiu      $a1, $a1, %lo(func_800EF60C)
    /* DFC88 800EF488 2BCA030C */  jal        DMACallback
    /* DFC8C 800EF48C 02000424 */   addiu     $a0, $zero, 0x2
    /* DFC90 800EF490 2A002012 */  beqz       $s1, .L800EF53C
    /* DFC94 800EF494 21300000 */   addu      $a2, $zero, $zero
    /* DFC98 800EF498 1480083C */  lui        $t0, %hi(D_8013EC0C)
    /* DFC9C 800EF49C 0CEC0825 */  addiu      $t0, $t0, %lo(D_8013EC0C)
    /* DFCA0 800EF4A0 21380002 */  addu       $a3, $s0, $zero
    /* DFCA4 800EF4A4 21102002 */  addu       $v0, $s1, $zero
  .L800EF4A8:
    /* DFCA8 800EF4A8 02004104 */  bgez       $v0, .L800EF4B4
    /* DFCAC 800EF4AC 00000000 */   nop
    /* DFCB0 800EF4B0 03004224 */  addiu      $v0, $v0, 0x3
  .L800EF4B4:
    /* DFCB4 800EF4B4 83100200 */  sra        $v0, $v0, 2
    /* DFCB8 800EF4B8 2A10C200 */  slt        $v0, $a2, $v0
    /* DFCBC 800EF4BC 0E004010 */  beqz       $v0, .L800EF4F8
    /* DFCC0 800EF4C0 80200600 */   sll       $a0, $a2, 2
    /* DFCC4 800EF4C4 0000E58C */  lw         $a1, 0x0($a3)
    /* DFCC8 800EF4C8 0400E724 */  addiu      $a3, $a3, 0x4
    /* DFCCC 800EF4CC 1280033C */  lui        $v1, %hi(_qin)
    /* DFCD0 800EF4D0 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFCD4 800EF4D4 0100C624 */  addiu      $a2, $a2, 0x1
    /* DFCD8 800EF4D8 40100300 */  sll        $v0, $v1, 1
    /* DFCDC 800EF4DC 21104300 */  addu       $v0, $v0, $v1
    /* DFCE0 800EF4E0 40110200 */  sll        $v0, $v0, 5
    /* DFCE4 800EF4E4 21104800 */  addu       $v0, $v0, $t0
    /* DFCE8 800EF4E8 21208200 */  addu       $a0, $a0, $v0
    /* DFCEC 800EF4EC 000085AC */  sw         $a1, 0x0($a0)
    /* DFCF0 800EF4F0 2ABD0308 */  j          .L800EF4A8
    /* DFCF4 800EF4F4 21102002 */   addu      $v0, $s1, $zero
  .L800EF4F8:
    /* DFCF8 800EF4F8 1280023C */  lui        $v0, %hi(_qin)
    /* DFCFC 800EF4FC C437428C */  lw         $v0, %lo(_qin)($v0)
    /* DFD00 800EF500 1280033C */  lui        $v1, %hi(_qin)
    /* DFD04 800EF504 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFD08 800EF508 40200200 */  sll        $a0, $v0, 1
    /* DFD0C 800EF50C 21208200 */  addu       $a0, $a0, $v0
    /* DFD10 800EF510 40210400 */  sll        $a0, $a0, 5
    /* DFD14 800EF514 40100300 */  sll        $v0, $v1, 1
    /* DFD18 800EF518 21104300 */  addu       $v0, $v0, $v1
    /* DFD1C 800EF51C 40110200 */  sll        $v0, $v0, 5
    /* DFD20 800EF520 1480033C */  lui        $v1, %hi(D_8013EC0C)
    /* DFD24 800EF524 0CEC6324 */  addiu      $v1, $v1, %lo(D_8013EC0C)
    /* DFD28 800EF528 21104300 */  addu       $v0, $v0, $v1
    /* DFD2C 800EF52C 1480013C */  lui        $at, %hi(D_8013EC04)
    /* DFD30 800EF530 21082400 */  addu       $at, $at, $a0
    /* DFD34 800EF534 58BD0308 */  j          .L800EF560
    /* DFD38 800EF538 04EC22AC */   sw        $v0, %lo(D_8013EC04)($at)
  .L800EF53C:
    /* DFD3C 800EF53C 1280033C */  lui        $v1, %hi(_qin)
    /* DFD40 800EF540 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFD44 800EF544 00000000 */  nop
    /* DFD48 800EF548 40100300 */  sll        $v0, $v1, 1
    /* DFD4C 800EF54C 21104300 */  addu       $v0, $v0, $v1
    /* DFD50 800EF550 40110200 */  sll        $v0, $v0, 5
    /* DFD54 800EF554 1480013C */  lui        $at, %hi(D_8013EC04)
    /* DFD58 800EF558 21082200 */  addu       $at, $at, $v0
    /* DFD5C 800EF55C 04EC30AC */  sw         $s0, %lo(D_8013EC04)($at)
  .L800EF560:
    /* DFD60 800EF560 1280033C */  lui        $v1, %hi(_qin)
    /* DFD64 800EF564 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFD68 800EF568 00000000 */  nop
    /* DFD6C 800EF56C 40100300 */  sll        $v0, $v1, 1
    /* DFD70 800EF570 21104300 */  addu       $v0, $v0, $v1
    /* DFD74 800EF574 40110200 */  sll        $v0, $v0, 5
    /* DFD78 800EF578 1480013C */  lui        $at, %hi(D_8013EC08)
    /* DFD7C 800EF57C 21082200 */  addu       $at, $at, $v0
    /* DFD80 800EF580 08EC32AC */  sw         $s2, %lo(D_8013EC08)($at)
    /* DFD84 800EF584 1280033C */  lui        $v1, %hi(_qin)
    /* DFD88 800EF588 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFD8C 800EF58C 00000000 */  nop
    /* DFD90 800EF590 40100300 */  sll        $v0, $v1, 1
    /* DFD94 800EF594 21104300 */  addu       $v0, $v0, $v1
    /* DFD98 800EF598 40110200 */  sll        $v0, $v0, 5
    /* DFD9C 800EF59C 1480013C */  lui        $at, %hi(_que)
    /* DFDA0 800EF5A0 21082200 */  addu       $at, $at, $v0
    /* DFDA4 800EF5A4 00EC33AC */  sw         $s3, %lo(_que)($at)
    /* DFDA8 800EF5A8 1280023C */  lui        $v0, %hi(_qin)
    /* DFDAC 800EF5AC C437428C */  lw         $v0, %lo(_qin)($v0)
    /* DFDB0 800EF5B0 1280043C */  lui        $a0, %hi(D_801237CC)
    /* DFDB4 800EF5B4 CC37848C */  lw         $a0, %lo(D_801237CC)($a0)
    /* DFDB8 800EF5B8 01004224 */  addiu      $v0, $v0, 0x1
    /* DFDBC 800EF5BC 3F004230 */  andi       $v0, $v0, 0x3F
    /* DFDC0 800EF5C0 1280013C */  lui        $at, %hi(_qin)
    /* DFDC4 800EF5C4 54CA030C */  jal        SetIntrMask
    /* DFDC8 800EF5C8 C43722AC */   sw        $v0, %lo(_qin)($at)
    /* DFDCC 800EF5CC 83BD030C */  jal        func_800EF60C
    /* DFDD0 800EF5D0 00000000 */   nop
    /* DFDD4 800EF5D4 1280023C */  lui        $v0, %hi(_qin)
    /* DFDD8 800EF5D8 C437428C */  lw         $v0, %lo(_qin)($v0)
    /* DFDDC 800EF5DC 1280033C */  lui        $v1, %hi(_qout)
    /* DFDE0 800EF5E0 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* DFDE4 800EF5E4 00000000 */  nop
    /* DFDE8 800EF5E8 23104300 */  subu       $v0, $v0, $v1
    /* DFDEC 800EF5EC 3F004230 */  andi       $v0, $v0, 0x3F
  .L800EF5F0:
    /* DFDF0 800EF5F0 2000BF8F */  lw         $ra, 0x20($sp)
    /* DFDF4 800EF5F4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DFDF8 800EF5F8 1800B28F */  lw         $s2, 0x18($sp)
    /* DFDFC 800EF5FC 1400B18F */  lw         $s1, 0x14($sp)
    /* DFE00 800EF600 1000B08F */  lw         $s0, 0x10($sp)
    /* DFE04 800EF604 0800E003 */  jr         $ra
    /* DFE08 800EF608 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800EF35C
