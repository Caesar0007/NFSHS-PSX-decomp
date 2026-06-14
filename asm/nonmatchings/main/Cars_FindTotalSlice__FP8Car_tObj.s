.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_FindTotalSlice__FP8Car_tObj, 0x6C

glabel Cars_FindTotalSlice__FP8Car_tObj
    /* 79F60 80089760 6802828C */  lw         $v0, 0x268($a0)
    /* 79F64 80089764 00000000 */  nop
    /* 79F68 80089768 03004018 */  blez       $v0, .L80089778
    /* 79F6C 8008976C 1180023C */   lui       $v0, %hi(D_8011321C)
    /* 79F70 80089770 0800E003 */  jr         $ra
    /* 79F74 80089774 060080A4 */   sh        $zero, 0x6($a0)
  .L80089778:
    /* 79F78 80089778 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 79F7C 8008977C 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 79F80 80089780 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 79F84 80089784 09004010 */  beqz       $v0, .L800897AC
    /* 79F88 80089788 00000000 */   nop
    /* 79F8C 8008978C 6402828C */  lw         $v0, 0x264($a0)
    /* 79F90 80089790 00000000 */  nop
    /* 79F94 80089794 18004300 */  mult       $v0, $v1
    /* 79F98 80089798 08008294 */  lhu        $v0, 0x8($a0)
    /* 79F9C 8008979C 00000000 */  nop
    /* 79FA0 800897A0 23106200 */  subu       $v0, $v1, $v0
    /* 79FA4 800897A4 EF250208 */  j          .L800897BC
    /* 79FA8 800897A8 FFFF4224 */   addiu     $v0, $v0, -0x1
  .L800897AC:
    /* 79FAC 800897AC 6402828C */  lw         $v0, 0x264($a0)
    /* 79FB0 800897B0 00000000 */  nop
    /* 79FB4 800897B4 18004300 */  mult       $v0, $v1
    /* 79FB8 800897B8 08008294 */  lhu        $v0, 0x8($a0)
  .L800897BC:
    /* 79FBC 800897BC 12280000 */  mflo       $a1
    /* 79FC0 800897C0 21104500 */  addu       $v0, $v0, $a1
    /* 79FC4 800897C4 0800E003 */  jr         $ra
    /* 79FC8 800897C8 060082A4 */   sh        $v0, 0x6($a0)
endlabel Cars_FindTotalSlice__FP8Car_tObj
