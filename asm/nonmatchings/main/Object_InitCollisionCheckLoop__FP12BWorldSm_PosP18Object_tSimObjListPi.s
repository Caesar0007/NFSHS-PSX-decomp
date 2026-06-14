.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi, 0x218

glabel Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
    /* 954FC 800A4CFC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 95500 800A4D00 21388000 */  addu       $a3, $a0, $zero
    /* 95504 800A4D04 1400BFAF */  sw         $ra, 0x14($sp)
    /* 95508 800A4D08 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9550C 800A4D0C 7500E290 */  lbu        $v0, 0x75($a3)
    /* 95510 800A4D10 00000000 */  nop
    /* 95514 800A4D14 C0180200 */  sll        $v1, $v0, 3
    /* 95518 800A4D18 23186200 */  subu       $v1, $v1, $v0
    /* 9551C 800A4D1C 1480023C */  lui        $v0, %hi(Track_chunkList)
    /* 95520 800A4D20 B8D4428C */  lw         $v0, %lo(Track_chunkList)($v0)
    /* 95524 800A4D24 00190300 */  sll        $v1, $v1, 4
    /* 95528 800A4D28 21186200 */  addu       $v1, $v1, $v0
    /* 9552C 800A4D2C 5000628C */  lw         $v0, 0x50($v1)
    /* 95530 800A4D30 00000000 */  nop
    /* 95534 800A4D34 04004010 */  beqz       $v0, .L800A4D48
    /* 95538 800A4D38 2180C000 */   addu      $s0, $a2, $zero
    /* 9553C 800A4D3C 0000428C */  lw         $v0, 0x0($v0)
    /* 95540 800A4D40 53930208 */  j          .L800A4D4C
    /* 95544 800A4D44 0000A2AC */   sw        $v0, 0x0($a1)
  .L800A4D48:
    /* 95548 800A4D48 0000A0AC */  sw         $zero, 0x0($a1)
  .L800A4D4C:
    /* 9554C 800A4D4C 7500E290 */  lbu        $v0, 0x75($a3)
    /* 95550 800A4D50 0800A0AC */  sw         $zero, 0x8($a1)
    /* 95554 800A4D54 0400A2AC */  sw         $v0, 0x4($a1)
    /* 95558 800A4D58 0000E684 */  lh         $a2, 0x0($a3)
    /* 9555C 800A4D5C 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 95560 800A4D60 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 95564 800A4D64 0100C424 */  addiu      $a0, $a2, 0x1
    /* 95568 800A4D68 2A108300 */  slt        $v0, $a0, $v1
    /* 9556C 800A4D6C 05004010 */  beqz       $v0, .L800A4D84
    /* 95570 800A4D70 40110400 */   sll       $v0, $a0, 5
    /* 95574 800A4D74 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 95578 800A4D78 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 9557C 800A4D7C 67930208 */  j          .L800A4D9C
    /* 95580 800A4D80 21106200 */   addu      $v0, $v1, $v0
  .L800A4D84:
    /* 95584 800A4D84 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 95588 800A4D88 2310C200 */  subu       $v0, $a2, $v0
    /* 9558C 800A4D8C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 95590 800A4D90 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 95594 800A4D94 40110200 */  sll        $v0, $v0, 5
    /* 95598 800A4D98 21106200 */  addu       $v0, $v1, $v0
  .L800A4D9C:
    /* 9559C 800A4D9C 1C004490 */  lbu        $a0, 0x1C($v0)
    /* 955A0 800A4DA0 7500E290 */  lbu        $v0, 0x75($a3)
    /* 955A4 800A4DA4 00000000 */  nop
    /* 955A8 800A4DA8 12008210 */  beq        $a0, $v0, .L800A4DF4
    /* 955AC 800A4DAC C0100400 */   sll       $v0, $a0, 3
    /* 955B0 800A4DB0 23104400 */  subu       $v0, $v0, $a0
    /* 955B4 800A4DB4 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 955B8 800A4DB8 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 955BC 800A4DBC 00110200 */  sll        $v0, $v0, 4
    /* 955C0 800A4DC0 21104300 */  addu       $v0, $v0, $v1
    /* 955C4 800A4DC4 5000428C */  lw         $v0, 0x50($v0)
    /* 955C8 800A4DC8 00000000 */  nop
    /* 955CC 800A4DCC 09004010 */  beqz       $v0, .L800A4DF4
    /* 955D0 800A4DD0 00000000 */   nop
    /* 955D4 800A4DD4 0000428C */  lw         $v0, 0x0($v0)
    /* 955D8 800A4DD8 00000000 */  nop
    /* 955DC 800A4DDC 0800A2AC */  sw         $v0, 0x8($a1)
    /* 955E0 800A4DE0 0000A28C */  lw         $v0, 0x0($a1)
    /* 955E4 800A4DE4 0800A38C */  lw         $v1, 0x8($a1)
    /* 955E8 800A4DE8 0C00A4AC */  sw         $a0, 0xC($a1)
    /* 955EC 800A4DEC A2930208 */  j          .L800A4E88
    /* 955F0 800A4DF0 21104300 */   addu      $v0, $v0, $v1
  .L800A4DF4:
    /* 955F4 800A4DF4 0000E384 */  lh         $v1, 0x0($a3)
    /* 955F8 800A4DF8 00000000 */  nop
    /* 955FC 800A4DFC FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 95600 800A4E00 06004104 */  bgez       $v0, .L800A4E1C
    /* 95604 800A4E04 00000000 */   nop
    /* 95608 800A4E08 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 9560C 800A4E0C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 95610 800A4E10 00000000 */  nop
    /* 95614 800A4E14 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 95618 800A4E18 21106200 */  addu       $v0, $v1, $v0
  .L800A4E1C:
    /* 9561C 800A4E1C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 95620 800A4E20 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 95624 800A4E24 40110200 */  sll        $v0, $v0, 5
    /* 95628 800A4E28 21106200 */  addu       $v0, $v1, $v0
    /* 9562C 800A4E2C 1C004490 */  lbu        $a0, 0x1C($v0)
    /* 95630 800A4E30 7500E290 */  lbu        $v0, 0x75($a3)
    /* 95634 800A4E34 00000000 */  nop
    /* 95638 800A4E38 12008210 */  beq        $a0, $v0, .L800A4E84
    /* 9563C 800A4E3C C0100400 */   sll       $v0, $a0, 3
    /* 95640 800A4E40 23104400 */  subu       $v0, $v0, $a0
    /* 95644 800A4E44 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 95648 800A4E48 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 9564C 800A4E4C 00110200 */  sll        $v0, $v0, 4
    /* 95650 800A4E50 21104300 */  addu       $v0, $v0, $v1
    /* 95654 800A4E54 5000428C */  lw         $v0, 0x50($v0)
    /* 95658 800A4E58 00000000 */  nop
    /* 9565C 800A4E5C 09004010 */  beqz       $v0, .L800A4E84
    /* 95660 800A4E60 00000000 */   nop
    /* 95664 800A4E64 0000428C */  lw         $v0, 0x0($v0)
    /* 95668 800A4E68 00000000 */  nop
    /* 9566C 800A4E6C 0800A2AC */  sw         $v0, 0x8($a1)
    /* 95670 800A4E70 0000A28C */  lw         $v0, 0x0($a1)
    /* 95674 800A4E74 0800A38C */  lw         $v1, 0x8($a1)
    /* 95678 800A4E78 0C00A4AC */  sw         $a0, 0xC($a1)
    /* 9567C 800A4E7C A2930208 */  j          .L800A4E88
    /* 95680 800A4E80 21104300 */   addu      $v0, $v0, $v1
  .L800A4E84:
    /* 95684 800A4E84 0000A28C */  lw         $v0, 0x0($a1)
  .L800A4E88:
    /* 95688 800A4E88 00000000 */  nop
    /* 9568C 800A4E8C 000002AE */  sw         $v0, 0x0($s0)
    /* 95690 800A4E90 800D828F */  lw         $v0, %gp_rel(Object_customSimObjs)($gp)
    /* 95694 800A4E94 00000000 */  nop
    /* 95698 800A4E98 1A004010 */  beqz       $v0, .L800A4F04
    /* 9569C 800A4E9C 00000000 */   nop
    /* 956A0 800A4EA0 0000428C */  lw         $v0, 0x0($v0)
    /* 956A4 800A4EA4 00000000 */  nop
    /* 956A8 800A4EA8 16004018 */  blez       $v0, .L800A4F04
    /* 956AC 800A4EAC 00000000 */   nop
    /* 956B0 800A4EB0 880D848F */  lw         $a0, %gp_rel(Object_customSliceNum)($gp)
    /* 956B4 800A4EB4 0000E584 */  lh         $a1, 0x0($a3)
    /* 956B8 800A4EB8 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 956BC 800A4EBC C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 956C0 800A4EC0 40210400 */  sll        $a0, $a0, 5
    /* 956C4 800A4EC4 40290500 */  sll        $a1, $a1, 5
    /* 956C8 800A4EC8 21204400 */  addu       $a0, $v0, $a0
    /* 956CC 800A4ECC F974020C */  jal        Math_DistXZ__FP8coorddefT0
    /* 956D0 800A4ED0 21284500 */   addu      $a1, $v0, $a1
    /* 956D4 800A4ED4 BF00033C */  lui        $v1, (0xBFFFFF >> 16)
    /* 956D8 800A4ED8 FFFF6334 */  ori        $v1, $v1, (0xBFFFFF & 0xFFFF)
    /* 956DC 800A4EDC 2A186200 */  slt        $v1, $v1, $v0
    /* 956E0 800A4EE0 08006014 */  bnez       $v1, .L800A4F04
    /* 956E4 800A4EE4 00000000 */   nop
    /* 956E8 800A4EE8 800D828F */  lw         $v0, %gp_rel(Object_customSimObjs)($gp)
    /* 956EC 800A4EEC 00000000 */  nop
    /* 956F0 800A4EF0 0000438C */  lw         $v1, 0x0($v0)
    /* 956F4 800A4EF4 0000028E */  lw         $v0, 0x0($s0)
    /* 956F8 800A4EF8 00000000 */  nop
    /* 956FC 800A4EFC 21104300 */  addu       $v0, $v0, $v1
    /* 95700 800A4F00 000002AE */  sw         $v0, 0x0($s0)
  .L800A4F04:
    /* 95704 800A4F04 1400BF8F */  lw         $ra, 0x14($sp)
    /* 95708 800A4F08 1000B08F */  lw         $s0, 0x10($sp)
    /* 9570C 800A4F0C 0800E003 */  jr         $ra
    /* 95710 800A4F10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
