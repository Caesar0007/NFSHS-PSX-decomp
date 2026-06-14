.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetAnimFrameInfo__10AnimScriptPiT1, 0xBC

glabel GetAnimFrameInfo__10AnimScriptPiT1
    /* 64D3C 8007453C 2140A000 */  addu       $t0, $a1, $zero
    /* 64D40 80074540 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 64D44 80074544 1000838C */  lw         $v1, 0x10($a0)
    /* 64D48 80074548 B0E0458C */  lw         $a1, %lo(D_8011E0B0)($v0)
    /* 64D4C 8007454C 0000678C */  lw         $a3, 0x0($v1)
    /* 64D50 80074550 0000828C */  lw         $v0, 0x0($a0)
    /* 64D54 80074554 0A00E494 */  lhu        $a0, 0xA($a3)
    /* 64D58 80074558 2318A200 */  subu       $v1, $a1, $v0
    /* 64D5C 8007455C FFFF8224 */  addiu      $v0, $a0, -0x1
    /* 64D60 80074560 9001422C */  sltiu      $v0, $v0, 0x190
    /* 64D64 80074564 03004010 */  beqz       $v0, .L80074574
    /* 64D68 80074568 00140400 */   sll       $v0, $a0, 16
    /* 64D6C 8007456C 5ED10108 */  j          .L80074578
    /* 64D70 80074570 03140200 */   sra       $v0, $v0, 16
  .L80074574:
    /* 64D74 80074574 06000224 */  addiu      $v0, $zero, 0x6
  .L80074578:
    /* 64D78 80074578 1A006200 */  div        $zero, $v1, $v0
    /* 64D7C 8007457C 02004014 */  bnez       $v0, .L80074588
    /* 64D80 80074580 00000000 */   nop
    /* 64D84 80074584 0D000700 */  break      7
  .L80074588:
    /* 64D88 80074588 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 64D8C 8007458C 04004114 */  bne        $v0, $at, .L800745A0
    /* 64D90 80074590 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 64D94 80074594 02006114 */  bne        $v1, $at, .L800745A0
    /* 64D98 80074598 00000000 */   nop
    /* 64D9C 8007459C 0D000600 */  break      6
  .L800745A0:
    /* 64DA0 800745A0 12180000 */  mflo       $v1
    /* 64DA4 800745A4 0800E284 */  lh         $v0, 0x8($a3)
    /* 64DA8 800745A8 00000000 */  nop
    /* 64DAC 800745AC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 64DB0 800745B0 1A006200 */  div        $zero, $v1, $v0
    /* 64DB4 800745B4 02004014 */  bnez       $v0, .L800745C0
    /* 64DB8 800745B8 00000000 */   nop
    /* 64DBC 800745BC 0D000700 */  break      7
  .L800745C0:
    /* 64DC0 800745C0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 64DC4 800745C4 04004114 */  bne        $v0, $at, .L800745D8
    /* 64DC8 800745C8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 64DCC 800745CC 02006114 */  bne        $v1, $at, .L800745D8
    /* 64DD0 800745D0 00000000 */   nop
    /* 64DD4 800745D4 0D000600 */  break      6
  .L800745D8:
    /* 64DD8 800745D8 10100000 */  mfhi       $v0
    /* 64DDC 800745DC 00000000 */  nop
    /* 64DE0 800745E0 000002AD */  sw         $v0, 0x0($t0)
    /* 64DE4 800745E4 0800E284 */  lh         $v0, 0x8($a3)
    /* 64DE8 800745E8 00000000 */  nop
    /* 64DEC 800745EC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 64DF0 800745F0 0800E003 */  jr         $ra
    /* 64DF4 800745F4 0000C2AC */   sw        $v0, 0x0($a2)
endlabel GetAnimFrameInfo__10AnimScriptPiT1
