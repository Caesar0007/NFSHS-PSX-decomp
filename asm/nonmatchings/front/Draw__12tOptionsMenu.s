.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__12tOptionsMenu, 0x204

glabel Draw__12tOptionsMenu
    /* D304 8001CB04 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D308 8001CB08 3800B0AF */  sw         $s0, 0x38($sp)
    /* D30C 8001CB0C 21808000 */  addu       $s0, $a0, $zero
    /* D310 8001CB10 4000BFAF */  sw         $ra, 0x40($sp)
    /* D314 8001CB14 D26F000C */  jal        CalcPulsateYellow__Fv
    /* D318 8001CB18 3C00B1AF */   sw        $s1, 0x3C($sp)
    /* D31C 8001CB1C 0800028E */  lw         $v0, 0x8($s0)
    /* D320 8001CB20 00000000 */  nop
    /* D324 8001CB24 80100200 */  sll        $v0, $v0, 2
    /* D328 8001CB28 21100202 */  addu       $v0, $s0, $v0
    /* D32C 8001CB2C 1000428C */  lw         $v0, 0x10($v0)
    /* D330 8001CB30 00000000 */  nop
    /* D334 8001CB34 06004010 */  beqz       $v0, .L8001CB50
    /* D338 8001CB38 00000000 */   nop
    /* D33C 8001CB3C 0000428C */  lw         $v0, 0x0($v0)
    /* D340 8001CB40 00000000 */  nop
    /* D344 8001CB44 01004230 */  andi       $v0, $v0, 0x1
    /* D348 8001CB48 02004010 */  beqz       $v0, .L8001CB54
    /* D34C 8001CB4C 00000000 */   nop
  .L8001CB50:
    /* D350 8001CB50 080000AE */  sw         $zero, 0x8($s0)
  .L8001CB54:
    /* D354 8001CB54 0800038E */  lw         $v1, 0x8($s0)
    /* D358 8001CB58 00000000 */  nop
    /* D35C 8001CB5C 80100300 */  sll        $v0, $v1, 2
    /* D360 8001CB60 21100202 */  addu       $v0, $s0, $v0
    /* D364 8001CB64 1000428C */  lw         $v0, 0x10($v0)
    /* D368 8001CB68 00000000 */  nop
    /* D36C 8001CB6C 0000428C */  lw         $v0, 0x0($v0)
    /* D370 8001CB70 00000000 */  nop
    /* D374 8001CB74 01004230 */  andi       $v0, $v0, 0x1
    /* D378 8001CB78 09004010 */  beqz       $v0, .L8001CBA0
    /* D37C 8001CB7C 01006324 */   addiu     $v1, $v1, 0x1
    /* D380 8001CB80 80100300 */  sll        $v0, $v1, 2
    /* D384 8001CB84 21100202 */  addu       $v0, $s0, $v0
    /* D388 8001CB88 1000428C */  lw         $v0, 0x10($v0)
    /* D38C 8001CB8C 00000000 */  nop
    /* D390 8001CB90 03004010 */  beqz       $v0, .L8001CBA0
    /* D394 8001CB94 00000000 */   nop
    /* D398 8001CB98 D5720008 */  j          .L8001CB54
    /* D39C 8001CB9C 080003AE */   sw        $v1, 0x8($s0)
  .L8001CBA0:
    /* D3A0 8001CBA0 0800038E */  lw         $v1, 0x8($s0)
    /* D3A4 8001CBA4 00000000 */  nop
    /* D3A8 8001CBA8 80100300 */  sll        $v0, $v1, 2
    /* D3AC 8001CBAC 21100202 */  addu       $v0, $s0, $v0
    /* D3B0 8001CBB0 1000428C */  lw         $v0, 0x10($v0)
    /* D3B4 8001CBB4 00000000 */  nop
    /* D3B8 8001CBB8 0000428C */  lw         $v0, 0x0($v0)
    /* D3BC 8001CBBC 00000000 */  nop
    /* D3C0 8001CBC0 01004230 */  andi       $v0, $v0, 0x1
    /* D3C4 8001CBC4 05004010 */  beqz       $v0, .L8001CBDC
    /* D3C8 8001CBC8 00000000 */   nop
    /* D3CC 8001CBCC 03006018 */  blez       $v1, .L8001CBDC
    /* D3D0 8001CBD0 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* D3D4 8001CBD4 E8720008 */  j          .L8001CBA0
    /* D3D8 8001CBD8 080002AE */   sw        $v0, 0x8($s0)
  .L8001CBDC:
    /* D3DC 8001CBDC 7800028E */  lw         $v0, 0x78($s0)
    /* D3E0 8001CBE0 00000000 */  nop
    /* D3E4 8001CBE4 20004004 */  bltz       $v0, .L8001CC68
    /* D3E8 8001CBE8 00000000 */   nop
    /* D3EC 8001CBEC 7C00028E */  lw         $v0, 0x7C($s0)
    /* D3F0 8001CBF0 00000000 */  nop
    /* D3F4 8001CBF4 1C004018 */  blez       $v0, .L8001CC68
    /* D3F8 8001CBF8 CE00023C */   lui       $v0, (0xCEC844 >> 16)
    /* D3FC 8001CBFC 44C84234 */  ori        $v0, $v0, (0xCEC844 & 0xFFFF)
    /* D400 8001CC00 2400A2AF */  sw         $v0, 0x24($sp)
    /* D404 8001CC04 1480023C */  lui        $v0, %hi(ticks)
    /* D408 8001CC08 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* D40C 8001CC0C 7C00038E */  lw         $v1, 0x7C($s0)
    /* D410 8001CC10 03110200 */  sra        $v0, $v0, 4
    /* D414 8001CC14 1A004300 */  div        $zero, $v0, $v1
    /* D418 8001CC18 02006014 */  bnez       $v1, .L8001CC24
    /* D41C 8001CC1C 00000000 */   nop
    /* D420 8001CC20 0D000700 */  break      7
  .L8001CC24:
    /* D424 8001CC24 FFFF0124 */  addiu      $at, $zero, -0x1
    /* D428 8001CC28 04006114 */  bne        $v1, $at, .L8001CC3C
    /* D42C 8001CC2C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* D430 8001CC30 02004114 */  bne        $v0, $at, .L8001CC3C
    /* D434 8001CC34 00000000 */   nop
    /* D438 8001CC38 0D000600 */  break      6
  .L8001CC3C:
    /* D43C 8001CC3C 10180000 */  mfhi       $v1
    /* D440 8001CC40 10040524 */  addiu      $a1, $zero, 0x410
    /* D444 8001CC44 10000624 */  addiu      $a2, $zero, 0x10
    /* D448 8001CC48 7800048E */  lw         $a0, 0x78($s0)
    /* D44C 8001CC4C 2138C000 */  addu       $a3, $a2, $zero
    /* D450 8001CC50 1000A0AF */  sw         $zero, 0x10($sp)
    /* D454 8001CC54 1400A0AF */  sw         $zero, 0x14($sp)
    /* D458 8001CC58 2000A227 */  addiu      $v0, $sp, 0x20
    /* D45C 8001CC5C 1800A2AF */  sw         $v0, 0x18($sp)
    /* D460 8001CC60 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* D464 8001CC64 21208300 */   addu      $a0, $a0, $v1
  .L8001CC68:
    /* D468 8001CC68 1000028E */  lw         $v0, 0x10($s0)
    /* D46C 8001CC6C 00000000 */  nop
    /* D470 8001CC70 20004010 */  beqz       $v0, .L8001CCF4
    /* D474 8001CC74 21880000 */   addu      $s1, $zero, $zero
  .L8001CC78:
    /* D478 8001CC78 00141100 */  sll        $v0, $s1, 16
    /* D47C 8001CC7C 032C0200 */  sra        $a1, $v0, 16
    /* D480 8001CC80 80100500 */  sll        $v0, $a1, 2
    /* D484 8001CC84 21100202 */  addu       $v0, $s0, $v0
    /* D488 8001CC88 1000448C */  lw         $a0, 0x10($v0)
    /* D48C 8001CC8C 00000000 */  nop
    /* D490 8001CC90 1800828C */  lw         $v0, 0x18($a0)
    /* D494 8001CC94 21380000 */  addu       $a3, $zero, $zero
    /* D498 8001CC98 28004824 */  addiu      $t0, $v0, 0x28
    /* D49C 8001CC9C 28004284 */  lh         $v0, 0x28($v0)
    /* D4A0 8001CCA0 6C00038E */  lw         $v1, 0x6C($s0)
    /* D4A4 8001CCA4 00000000 */  nop
    /* D4A8 8001CCA8 05006014 */  bnez       $v1, .L8001CCC0
    /* D4AC 8001CCAC 21208200 */   addu      $a0, $a0, $v0
    /* D4B0 8001CCB0 0800028E */  lw         $v0, 0x8($s0)
    /* D4B4 8001CCB4 00000000 */  nop
    /* D4B8 8001CCB8 2610A200 */  xor        $v0, $a1, $v0
    /* D4BC 8001CCBC 0100472C */  sltiu      $a3, $v0, 0x1
  .L8001CCC0:
    /* D4C0 8001CCC0 21280000 */  addu       $a1, $zero, $zero
    /* D4C4 8001CCC4 0400028D */  lw         $v0, 0x4($t0)
    /* D4C8 8001CCC8 00000000 */  nop
    /* D4CC 8001CCCC 09F84000 */  jalr       $v0
    /* D4D0 8001CCD0 2130A000 */   addu      $a2, $a1, $zero
    /* D4D4 8001CCD4 01002326 */  addiu      $v1, $s1, 0x1
    /* D4D8 8001CCD8 00140300 */  sll        $v0, $v1, 16
    /* D4DC 8001CCDC 83130200 */  sra        $v0, $v0, 14
    /* D4E0 8001CCE0 21100202 */  addu       $v0, $s0, $v0
    /* D4E4 8001CCE4 1000428C */  lw         $v0, 0x10($v0)
    /* D4E8 8001CCE8 00000000 */  nop
    /* D4EC 8001CCEC E2FF4014 */  bnez       $v0, .L8001CC78
    /* D4F0 8001CCF0 21886000 */   addu      $s1, $v1, $zero
  .L8001CCF4:
    /* D4F4 8001CCF4 4000BF8F */  lw         $ra, 0x40($sp)
    /* D4F8 8001CCF8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* D4FC 8001CCFC 3800B08F */  lw         $s0, 0x38($sp)
    /* D500 8001CD00 0800E003 */  jr         $ra
    /* D504 8001CD04 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Draw__12tOptionsMenu
