.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawShape_NFS4RoundRectangle__FiR4RECTs, 0x20C

glabel DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 3C7B0 8004BFB0 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* 3C7B4 8004BFB4 642A428C */  lw         $v0, %lo(gHelpShapes)($v0)
    /* 3C7B8 8004BFB8 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 3C7BC 8004BFBC 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 3C7C0 8004BFC0 2188A000 */  addu       $s1, $a1, $zero
    /* 3C7C4 8004BFC4 3800B0AF */  sw         $s0, 0x38($sp)
    /* 3C7C8 8004BFC8 2180C000 */  addu       $s0, $a2, $zero
    /* 3C7CC 8004BFCC 4400B3AF */  sw         $s3, 0x44($sp)
    /* 3C7D0 8004BFD0 21980000 */  addu       $s3, $zero, $zero
    /* 3C7D4 8004BFD4 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 3C7D8 8004BFD8 4800B4AF */  sw         $s4, 0x48($sp)
    /* 3C7DC 8004BFDC 4000B2AF */  sw         $s2, 0x40($sp)
    /* 3C7E0 8004BFE0 14008004 */  bltz       $a0, .L8004C034
    /* 3C7E4 8004BFE4 20055224 */   addiu     $s2, $v0, 0x520
    /* 3C7E8 8004BFE8 00240400 */  sll        $a0, $a0, 16
    /* 3C7EC 8004BFEC 03240400 */  sra        $a0, $a0, 16
    /* 3C7F0 8004BFF0 02000724 */  addiu      $a3, $zero, 0x2
    /* 3C7F4 8004BFF4 04002396 */  lhu        $v1, 0x4($s1)
    /* 3C7F8 8004BFF8 00002596 */  lhu        $a1, 0x0($s1)
    /* 3C7FC 8004BFFC 02002696 */  lhu        $a2, 0x2($s1)
    /* 3C800 8004C000 01000224 */  addiu      $v0, $zero, 0x1
    /* 3C804 8004C004 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3C808 8004C008 03000224 */  addiu      $v0, $zero, 0x3
    /* 3C80C 8004C00C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3C810 8004C010 001C0300 */  sll        $v1, $v1, 16
    /* 3C814 8004C014 431C0300 */  sra        $v1, $v1, 17
    /* 3C818 8004C018 2128A300 */  addu       $a1, $a1, $v1
    /* 3C81C 8004C01C 002C0500 */  sll        $a1, $a1, 16
    /* 3C820 8004C020 032C0500 */  sra        $a1, $a1, 16
    /* 3C824 8004C024 0400C624 */  addiu      $a2, $a2, 0x4
    /* 3C828 8004C028 00340600 */  sll        $a2, $a2, 16
    /* 3C82C 8004C02C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 3C830 8004C030 03340600 */   sra       $a2, $a2, 16
  .L8004C034:
    /* 3C834 8004C034 00141000 */  sll        $v0, $s0, 16
    /* 3C838 8004C038 03A40200 */  sra        $s4, $v0, 16
    /* 3C83C 8004C03C 02008016 */  bnez       $s4, .L8004C048
    /* 3C840 8004C040 29000424 */   addiu     $a0, $zero, 0x29
    /* 3C844 8004C044 01001324 */  addiu      $s3, $zero, 0x1
  .L8004C048:
    /* 3C848 8004C048 08006536 */  ori        $a1, $s3, 0x8
    /* 3C84C 8004C04C 00002686 */  lh         $a2, 0x0($s1)
    /* 3C850 8004C050 02002786 */  lh         $a3, 0x2($s1)
    /* 3C854 8004C054 2000B027 */  addiu      $s0, $sp, 0x20
    /* 3C858 8004C058 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3C85C 8004C05C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3C860 8004C060 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3C864 8004C064 1800B0AF */   sw        $s0, 0x18($sp)
    /* 3C868 8004C068 29000424 */  addiu      $a0, $zero, 0x29
    /* 3C86C 8004C06C 00002686 */  lh         $a2, 0x0($s1)
    /* 3C870 8004C070 04002286 */  lh         $v0, 0x4($s1)
    /* 3C874 8004C074 10004386 */  lh         $v1, 0x10($s2)
    /* 3C878 8004C078 02002786 */  lh         $a3, 0x2($s1)
    /* 3C87C 8004C07C 0C006536 */  ori        $a1, $s3, 0xC
    /* 3C880 8004C080 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3C884 8004C084 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3C888 8004C088 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3C88C 8004C08C 2130C200 */  addu       $a2, $a2, $v0
    /* 3C890 8004C090 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3C894 8004C094 2330C300 */   subu      $a2, $a2, $v1
    /* 3C898 8004C098 1F008012 */  beqz       $s4, .L8004C118
    /* 3C89C 8004C09C 01000224 */   addiu     $v0, $zero, 0x1
    /* 3C8A0 8004C0A0 8400043C */  lui        $a0, (0x841D08 >> 16)
    /* 3C8A4 8004C0A4 081D8434 */  ori        $a0, $a0, (0x841D08 & 0xFFFF)
    /* 3C8A8 8004C0A8 00002586 */  lh         $a1, 0x0($s1)
    /* 3C8AC 8004C0AC 10004386 */  lh         $v1, 0x10($s2)
    /* 3C8B0 8004C0B0 02002686 */  lh         $a2, 0x2($s1)
    /* 3C8B4 8004C0B4 12004886 */  lh         $t0, 0x12($s2)
    /* 3C8B8 8004C0B8 04002786 */  lh         $a3, 0x4($s1)
    /* 3C8BC 8004C0BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3C8C0 8004C0C0 2128A300 */  addu       $a1, $a1, $v1
    /* 3C8C4 8004C0C4 2130C800 */  addu       $a2, $a2, $t0
    /* 3C8C8 8004C0C8 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 3C8CC 8004C0CC 04184300 */  sllv       $v1, $v1, $v0
    /* 3C8D0 8004C0D0 2338E300 */  subu       $a3, $a3, $v1
    /* 3C8D4 8004C0D4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3C8D8 8004C0D8 2138E200 */   addu      $a3, $a3, $v0
    /* 3C8DC 8004C0DC 21200000 */  addu       $a0, $zero, $zero
    /* 3C8E0 8004C0E0 00002586 */  lh         $a1, 0x0($s1)
    /* 3C8E4 8004C0E4 10004286 */  lh         $v0, 0x10($s2)
    /* 3C8E8 8004C0E8 02002686 */  lh         $a2, 0x2($s1)
    /* 3C8EC 8004C0EC 04002786 */  lh         $a3, 0x4($s1)
    /* 3C8F0 8004C0F0 2128A200 */  addu       $a1, $a1, $v0
    /* 3C8F4 8004C0F4 40100200 */  sll        $v0, $v0, 1
    /* 3C8F8 8004C0F8 2338E200 */  subu       $a3, $a3, $v0
    /* 3C8FC 8004C0FC 12004286 */  lh         $v0, 0x12($s2)
    /* 3C900 8004C100 0100E724 */  addiu      $a3, $a3, 0x1
    /* 3C904 8004C104 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 3C908 8004C108 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3C90C 8004C10C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3C910 8004C110 67300108 */  j          .L8004C19C
    /* 3C914 8004C114 00000000 */   nop
  .L8004C118:
    /* 3C918 8004C118 8400043C */  lui        $a0, (0x841D08 >> 16)
    /* 3C91C 8004C11C 081D8434 */  ori        $a0, $a0, (0x841D08 & 0xFFFF)
    /* 3C920 8004C120 00002586 */  lh         $a1, 0x0($s1)
    /* 3C924 8004C124 10004286 */  lh         $v0, 0x10($s2)
    /* 3C928 8004C128 02002686 */  lh         $a2, 0x2($s1)
    /* 3C92C 8004C12C 12004386 */  lh         $v1, 0x12($s2)
    /* 3C930 8004C130 04002786 */  lh         $a3, 0x4($s1)
    /* 3C934 8004C134 01001024 */  addiu      $s0, $zero, 0x1
    /* 3C938 8004C138 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C93C 8004C13C 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3C940 8004C140 2128A200 */  addu       $a1, $a1, $v0
    /* 3C944 8004C144 2130C300 */  addu       $a2, $a2, $v1
    /* 3C948 8004C148 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 3C94C 8004C14C 04100202 */  sllv       $v0, $v0, $s0
    /* 3C950 8004C150 2338E200 */  subu       $a3, $a3, $v0
    /* 3C954 8004C154 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3C958 8004C158 2138F000 */   addu      $a3, $a3, $s0
    /* 3C95C 8004C15C 00002586 */  lh         $a1, 0x0($s1)
    /* 3C960 8004C160 10004286 */  lh         $v0, 0x10($s2)
    /* 3C964 8004C164 02002686 */  lh         $a2, 0x2($s1)
    /* 3C968 8004C168 04002786 */  lh         $a3, 0x4($s1)
    /* 3C96C 8004C16C 12004386 */  lh         $v1, 0x12($s2)
    /* 3C970 8004C170 21200000 */  addu       $a0, $zero, $zero
    /* 3C974 8004C174 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3C978 8004C178 2128A200 */  addu       $a1, $a1, $v0
    /* 3C97C 8004C17C 04100202 */  sllv       $v0, $v0, $s0
    /* 3C980 8004C180 2338E200 */  subu       $a3, $a3, $v0
    /* 3C984 8004C184 2138F000 */  addu       $a3, $a3, $s0
    /* 3C988 8004C188 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 3C98C 8004C18C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3C990 8004C190 1000A3AF */   sw        $v1, 0x10($sp)
    /* 3C994 8004C194 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 3C998 8004C198 21200000 */   addu      $a0, $zero, $zero
  .L8004C19C:
    /* 3C99C 8004C19C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 3C9A0 8004C1A0 4800B48F */  lw         $s4, 0x48($sp)
    /* 3C9A4 8004C1A4 4400B38F */  lw         $s3, 0x44($sp)
    /* 3C9A8 8004C1A8 4000B28F */  lw         $s2, 0x40($sp)
    /* 3C9AC 8004C1AC 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 3C9B0 8004C1B0 3800B08F */  lw         $s0, 0x38($sp)
    /* 3C9B4 8004C1B4 0800E003 */  jr         $ra
    /* 3C9B8 8004C1B8 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawShape_NFS4RoundRectangle__FiR4RECTs
