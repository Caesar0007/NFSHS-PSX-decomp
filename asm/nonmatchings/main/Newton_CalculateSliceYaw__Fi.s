.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalculateSliceYaw__Fi, 0x70

glabel Newton_CalculateSliceYaw__Fi
    /* 8FF30 8009F730 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8FF34 8009F734 1480053C */  lui        $a1, %hi(gNumSlices)
    /* 8FF38 8009F738 C8C7A58C */  lw         $a1, %lo(gNumSlices)($a1)
    /* 8FF3C 8009F73C 01008324 */  addiu      $v1, $a0, 0x1
    /* 8FF40 8009F740 2A106500 */  slt        $v0, $v1, $a1
    /* 8FF44 8009F744 03004010 */  beqz       $v0, .L8009F754
    /* 8FF48 8009F748 1000BFAF */   sw        $ra, 0x10($sp)
    /* 8FF4C 8009F74C D77D0208 */  j          .L8009F75C
    /* 8FF50 8009F750 21306000 */   addu      $a2, $v1, $zero
  .L8009F754:
    /* 8FF54 8009F754 FFFFA224 */  addiu      $v0, $a1, -0x1
    /* 8FF58 8009F758 23308200 */  subu       $a2, $a0, $v0
  .L8009F75C:
    /* 8FF5C 8009F75C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 8FF60 8009F760 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 8FF64 8009F764 40110400 */  sll        $v0, $a0, 5
    /* 8FF68 8009F768 21104300 */  addu       $v0, $v0, $v1
    /* 8FF6C 8009F76C 0000448C */  lw         $a0, 0x0($v0)
    /* 8FF70 8009F770 0800458C */  lw         $a1, 0x8($v0)
    /* 8FF74 8009F774 40110600 */  sll        $v0, $a2, 5
    /* 8FF78 8009F778 21104300 */  addu       $v0, $v0, $v1
    /* 8FF7C 8009F77C 0000438C */  lw         $v1, 0x0($v0)
    /* 8FF80 8009F780 0800428C */  lw         $v0, 0x8($v0)
    /* 8FF84 8009F784 23206400 */  subu       $a0, $v1, $a0
    /* 8FF88 8009F788 CE96030C */  jal        intatan
    /* 8FF8C 8009F78C 23284500 */   subu      $a1, $v0, $a1
    /* 8FF90 8009F790 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8FF94 8009F794 00000000 */  nop
    /* 8FF98 8009F798 0800E003 */  jr         $ra
    /* 8FF9C 8009F79C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Newton_CalculateSliceYaw__Fi
