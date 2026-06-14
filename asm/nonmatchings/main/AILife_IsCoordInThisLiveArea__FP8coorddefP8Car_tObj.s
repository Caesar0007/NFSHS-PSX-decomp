.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj, 0xAC

glabel AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
    /* 58E58 80068658 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 58E5C 8006865C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 58E60 80068660 0800838C */  lw         $v1, 0x8($a0)
    /* 58E64 80068664 A800A28C */  lw         $v0, 0xA8($a1)
    /* 58E68 80068668 00000000 */  nop
    /* 58E6C 8006866C 23306200 */  subu       $a2, $v1, $v0
    /* 58E70 80068670 0000838C */  lw         $v1, 0x0($a0)
    /* 58E74 80068674 A000A28C */  lw         $v0, 0xA0($a1)
    /* 58E78 80068678 0200C104 */  bgez       $a2, .L80068684
    /* 58E7C 8006867C 00000000 */   nop
    /* 58E80 80068680 23300600 */  negu       $a2, $a2
  .L80068684:
    /* 58E84 80068684 23186200 */  subu       $v1, $v1, $v0
    /* 58E88 80068688 02006104 */  bgez       $v1, .L80068694
    /* 58E8C 8006868C 00000000 */   nop
    /* 58E90 80068690 23180300 */  negu       $v1, $v1
  .L80068694:
    /* 58E94 80068694 2A10C300 */  slt        $v0, $a2, $v1
    /* 58E98 80068698 03004010 */  beqz       $v0, .L800686A8
    /* 58E9C 8006869C 83100600 */   sra       $v0, $a2, 2
    /* 58EA0 800686A0 ACA10108 */  j          .L800686B0
    /* 58EA4 800686A4 21186200 */   addu      $v1, $v1, $v0
  .L800686A8:
    /* 58EA8 800686A8 83100300 */  sra        $v0, $v1, 2
    /* 58EAC 800686AC 2118C200 */  addu       $v1, $a2, $v0
  .L800686B0:
    /* 58EB0 800686B0 D800023C */  lui        $v0, (0xD80000 >> 16)
    /* 58EB4 800686B4 2A104300 */  slt        $v0, $v0, $v1
    /* 58EB8 800686B8 03004014 */  bnez       $v0, .L800686C8
    /* 58EBC 800686BC 0080023C */   lui       $v0, (0x80008001 >> 16)
    /* 58EC0 800686C0 BDA10108 */  j          .L800686F4
    /* 58EC4 800686C4 01000224 */   addiu     $v0, $zero, 0x1
  .L800686C8:
    /* 58EC8 800686C8 01804234 */  ori        $v0, $v0, (0x80008001 & 0xFFFF)
    /* 58ECC 800686CC 18006200 */  mult       $v1, $v0
    /* 58ED0 800686D0 1480043C */  lui        $a0, %hi(D_8013C588)
    /* 58ED4 800686D4 C3170300 */  sra        $v0, $v1, 31
    /* 58ED8 800686D8 88C58424 */  addiu      $a0, $a0, %lo(D_8013C588)
    /* 58EDC 800686DC 10380000 */  mfhi       $a3
    /* 58EE0 800686E0 2128E300 */  addu       $a1, $a3, $v1
    /* 58EE4 800686E4 C32B0500 */  sra        $a1, $a1, 15
    /* 58EE8 800686E8 74A2010C */  jal        AILife_Debug__FPce
    /* 58EEC 800686EC 2328A200 */   subu      $a1, $a1, $v0
    /* 58EF0 800686F0 21100000 */  addu       $v0, $zero, $zero
  .L800686F4:
    /* 58EF4 800686F4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 58EF8 800686F8 00000000 */  nop
    /* 58EFC 800686FC 0800E003 */  jr         $ra
    /* 58F00 80068700 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
