.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDfreechan, 0x1B8

glabel iSNDfreechan
    /* EF40C 800FEC0C 21400000 */  addu       $t0, $zero, $zero
    /* EF410 800FEC10 1480023C */  lui        $v0, %hi(sndgs)
    /* EF414 800FEC14 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* EF418 800FEC18 40100400 */  sll        $v0, $a0, 1
    /* EF41C 800FEC1C 21104400 */  addu       $v0, $v0, $a0
    /* EF420 800FEC20 C0100200 */  sll        $v0, $v0, 3
    /* EF424 800FEC24 21104400 */  addu       $v0, $v0, $a0
    /* EF428 800FEC28 9400698C */  lw         $t1, 0x94($v1)
    /* EF42C 800FEC2C 80100200 */  sll        $v0, $v0, 2
    /* EF430 800FEC30 21282201 */  addu       $a1, $t1, $v0
    /* EF434 800FEC34 3700A790 */  lbu        $a3, 0x37($a1)
    /* EF438 800FEC38 00000000 */  nop
    /* EF43C 800FEC3C 5D00E010 */  beqz       $a3, .L800FEDB4
    /* EF440 800FEC40 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* EF444 800FEC44 11006390 */  lbu        $v1, 0x11($v1)
    /* EF448 800FEC48 00000000 */  nop
    /* EF44C 800FEC4C 2A100301 */  slt        $v0, $t0, $v1
    /* EF450 800FEC50 18004010 */  beqz       $v0, .L800FECB4
    /* EF454 800FEC54 21280001 */   addu      $a1, $t0, $zero
    /* EF458 800FEC58 21506000 */  addu       $t2, $v1, $zero
    /* EF45C 800FEC5C 21182001 */  addu       $v1, $t1, $zero
  .L800FEC60:
    /* EF460 800FEC60 37006290 */  lbu        $v0, 0x37($v1)
    /* EF464 800FEC64 00000000 */  nop
    /* EF468 800FEC68 0E004714 */  bne        $v0, $a3, .L800FECA4
    /* EF46C 800FEC6C 00000000 */   nop
    /* EF470 800FEC70 0000628C */  lw         $v0, 0x0($v1)
    /* EF474 800FEC74 00000000 */  nop
    /* EF478 800FEC78 0A004004 */  bltz       $v0, .L800FECA4
    /* EF47C 800FEC7C 00000000 */   nop
    /* EF480 800FEC80 0B006280 */  lb         $v0, 0xB($v1)
    /* EF484 800FEC84 00000000 */  nop
    /* EF488 800FEC88 06004010 */  beqz       $v0, .L800FECA4
    /* EF48C 800FEC8C 00000000 */   nop
    /* EF490 800FEC90 36006290 */  lbu        $v0, 0x36($v1)
    /* EF494 800FEC94 00000000 */  nop
    /* EF498 800FEC98 02004010 */  beqz       $v0, .L800FECA4
    /* EF49C 800FEC9C 01000825 */   addiu     $t0, $t0, 0x1
    /* EF4A0 800FECA0 2130A000 */  addu       $a2, $a1, $zero
  .L800FECA4:
    /* EF4A4 800FECA4 0100A524 */  addiu      $a1, $a1, 0x1
    /* EF4A8 800FECA8 2A10AA00 */  slt        $v0, $a1, $t2
    /* EF4AC 800FECAC ECFF4014 */  bnez       $v0, .L800FEC60
    /* EF4B0 800FECB0 64006324 */   addiu     $v1, $v1, 0x64
  .L800FECB4:
    /* EF4B4 800FECB4 1480023C */  lui        $v0, %hi(sndgs)
    /* EF4B8 800FECB8 60784924 */  addiu      $t1, $v0, %lo(sndgs)
    /* EF4BC 800FECBC 40100400 */  sll        $v0, $a0, 1
    /* EF4C0 800FECC0 21104400 */  addu       $v0, $v0, $a0
    /* EF4C4 800FECC4 C0100200 */  sll        $v0, $v0, 3
    /* EF4C8 800FECC8 21104400 */  addu       $v0, $v0, $a0
    /* EF4CC 800FECCC 9400238D */  lw         $v1, 0x94($t1)
    /* EF4D0 800FECD0 80100200 */  sll        $v0, $v0, 2
    /* EF4D4 800FECD4 21286200 */  addu       $a1, $v1, $v0
    /* EF4D8 800FECD8 01000224 */  addiu      $v0, $zero, 0x1
    /* EF4DC 800FECDC 05000215 */  bne        $t0, $v0, .L800FECF4
    /* EF4E0 800FECE0 40100600 */   sll       $v0, $a2, 1
    /* EF4E4 800FECE4 0B00A0A0 */  sb         $zero, 0xB($a1)
    /* EF4E8 800FECE8 4400228D */  lw         $v0, 0x44($t1)
    /* EF4EC 800FECEC 0800E003 */  jr         $ra
    /* EF4F0 800FECF0 1000A2AC */   sw        $v0, 0x10($a1)
  .L800FECF4:
    /* EF4F4 800FECF4 21104600 */  addu       $v0, $v0, $a2
    /* EF4F8 800FECF8 C0100200 */  sll        $v0, $v0, 3
    /* EF4FC 800FECFC 21104600 */  addu       $v0, $v0, $a2
    /* EF500 800FED00 80380200 */  sll        $a3, $v0, 2
    /* EF504 800FED04 2110E300 */  addu       $v0, $a3, $v1
    /* EF508 800FED08 0B004380 */  lb         $v1, 0xB($v0)
    /* EF50C 800FED0C 02000224 */  addiu      $v0, $zero, 0x2
    /* EF510 800FED10 12006214 */  bne        $v1, $v0, .L800FED5C
    /* EF514 800FED14 00000000 */   nop
    /* EF518 800FED18 10008610 */  beq        $a0, $a2, .L800FED5C
    /* EF51C 800FED1C 00000000 */   nop
    /* EF520 800FED20 0F000315 */  bne        $t0, $v1, .L800FED60
    /* EF524 800FED24 1480033C */   lui       $v1, %hi(D_801478F4)
    /* EF528 800FED28 0B00A0A0 */  sb         $zero, 0xB($a1)
    /* EF52C 800FED2C 4400228D */  lw         $v0, 0x44($t1)
    /* EF530 800FED30 00000000 */  nop
    /* EF534 800FED34 1000A2AC */  sw         $v0, 0x10($a1)
    /* EF538 800FED38 9400228D */  lw         $v0, 0x94($t1)
    /* EF53C 800FED3C 00000000 */  nop
    /* EF540 800FED40 2110E200 */  addu       $v0, $a3, $v0
    /* EF544 800FED44 0B0040A0 */  sb         $zero, 0xB($v0)
    /* EF548 800FED48 9400228D */  lw         $v0, 0x94($t1)
    /* EF54C 800FED4C 4400238D */  lw         $v1, 0x44($t1)
    /* EF550 800FED50 2110E200 */  addu       $v0, $a3, $v0
    /* EF554 800FED54 0800E003 */  jr         $ra
    /* EF558 800FED58 100043AC */   sw        $v1, 0x10($v0)
  .L800FED5C:
    /* EF55C 800FED5C 1480033C */  lui        $v1, %hi(D_801478F4)
  .L800FED60:
    /* EF560 800FED60 40100600 */  sll        $v0, $a2, 1
    /* EF564 800FED64 21104600 */  addu       $v0, $v0, $a2
    /* EF568 800FED68 C0100200 */  sll        $v0, $v0, 3
    /* EF56C 800FED6C 21104600 */  addu       $v0, $v0, $a2
    /* EF570 800FED70 F478638C */  lw         $v1, %lo(D_801478F4)($v1)
    /* EF574 800FED74 80100200 */  sll        $v0, $v0, 2
    /* EF578 800FED78 21384300 */  addu       $a3, $v0, $v1
    /* EF57C 800FED7C 0B00E380 */  lb         $v1, 0xB($a3)
    /* EF580 800FED80 01000224 */  addiu      $v0, $zero, 0x1
    /* EF584 800FED84 06006214 */  bne        $v1, $v0, .L800FEDA0
    /* EF588 800FED88 1480023C */   lui       $v0, %hi(sndgs)
    /* EF58C 800FED8C 05008614 */  bne        $a0, $a2, .L800FEDA4
    /* EF590 800FED90 60784224 */   addiu     $v0, $v0, %lo(sndgs)
    /* EF594 800FED94 02000224 */  addiu      $v0, $zero, 0x2
    /* EF598 800FED98 0800E003 */  jr         $ra
    /* EF59C 800FED9C 0B00E2A0 */   sb        $v0, 0xB($a3)
  .L800FEDA0:
    /* EF5A0 800FEDA0 60784224 */  addiu      $v0, $v0, %lo(sndgs)
  .L800FEDA4:
    /* EF5A4 800FEDA4 0B00A0A0 */  sb         $zero, 0xB($a1)
    /* EF5A8 800FEDA8 4400428C */  lw         $v0, 0x44($v0)
    /* EF5AC 800FEDAC 0800E003 */  jr         $ra
    /* EF5B0 800FEDB0 1000A2AC */   sw        $v0, 0x10($a1)
  .L800FEDB4:
    /* EF5B4 800FEDB4 0B00A0A0 */  sb         $zero, 0xB($a1)
    /* EF5B8 800FEDB8 4400628C */  lw         $v0, 0x44($v1)
    /* EF5BC 800FEDBC 0800E003 */  jr         $ra
    /* EF5C0 800FEDC0 1000A2AC */   sw        $v0, 0x10($a1)
endlabel iSNDfreechan
