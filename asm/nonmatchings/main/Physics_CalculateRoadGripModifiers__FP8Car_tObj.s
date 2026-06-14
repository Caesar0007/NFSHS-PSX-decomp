.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalculateRoadGripModifiers__FP8Car_tObj, 0x17C

glabel Physics_CalculateRoadGripModifiers__FP8Car_tObj
    /* 9B008 800AA808 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9B00C 800AA80C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9B010 800AA810 21808000 */  addu       $s0, $a0, $zero
    /* 9B014 800AA814 21400000 */  addu       $t0, $zero, $zero
    /* 9B018 800AA818 21480001 */  addu       $t1, $t0, $zero
    /* 9B01C 800AA81C 21500001 */  addu       $t2, $t0, $zero
    /* 9B020 800AA820 21580001 */  addu       $t3, $t0, $zero
    /* 9B024 800AA824 21280001 */  addu       $a1, $t0, $zero
    /* 9B028 800AA828 1180023C */  lui        $v0, %hi(roadSurfaceIndex)
    /* 9B02C 800AA82C 80654C24 */  addiu      $t4, $v0, %lo(roadSurfaceIndex)
    /* 9B030 800AA830 1180023C */  lui        $v0, %hi(roadSurfaceFrictionCoeff)
    /* 9B034 800AA834 30654724 */  addiu      $a3, $v0, %lo(roadSurfaceFrictionCoeff)
    /* 9B038 800AA838 21300002 */  addu       $a2, $s0, $zero
    /* 9B03C 800AA83C 1400BFAF */  sw         $ra, 0x14($sp)
  .L800AA840:
    /* 9B040 800AA840 0400A228 */  slti       $v0, $a1, 0x4
    /* 9B044 800AA844 29004010 */  beqz       $v0, .L800AA8EC
    /* 9B048 800AA848 43100800 */   sra       $v0, $t0, 1
    /* 9B04C 800AA84C 8802028E */  lw         $v0, 0x288($s0)
    /* 9B050 800AA850 B802C38C */  lw         $v1, 0x2B8($a2)
    /* 9B054 800AA854 3800448C */  lw         $a0, 0x38($v0)
    /* 9B058 800AA858 0F006330 */  andi       $v1, $v1, 0xF
    /* 9B05C 800AA85C 80100400 */  sll        $v0, $a0, 2
    /* 9B060 800AA860 21104400 */  addu       $v0, $v0, $a0
    /* 9B064 800AA864 80100200 */  sll        $v0, $v0, 2
    /* 9B068 800AA868 21186200 */  addu       $v1, $v1, $v0
    /* 9B06C 800AA86C 21186C00 */  addu       $v1, $v1, $t4
    /* 9B070 800AA870 CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9B074 800AA874 00006390 */  lbu        $v1, 0x0($v1)
    /* 9B078 800AA878 02004010 */  beqz       $v0, .L800AA884
    /* 9B07C 800AA87C 0200A228 */   slti      $v0, $a1, 0x2
    /* 9B080 800AA880 01006324 */  addiu      $v1, $v1, 0x1
  .L800AA884:
    /* 9B084 800AA884 05004010 */  beqz       $v0, .L800AA89C
    /* 9B088 800AA888 80100300 */   sll       $v0, $v1, 2
    /* 9B08C 800AA88C 21104700 */  addu       $v0, $v0, $a3
    /* 9B090 800AA890 0000428C */  lw         $v0, 0x0($v0)
    /* 9B094 800AA894 2BAA0208 */  j          .L800AA8AC
    /* 9B098 800AA898 21400201 */   addu      $t0, $t0, $v0
  .L800AA89C:
    /* 9B09C 800AA89C 21104700 */  addu       $v0, $v0, $a3
    /* 9B0A0 800AA8A0 0000428C */  lw         $v0, 0x0($v0)
    /* 9B0A4 800AA8A4 00000000 */  nop
    /* 9B0A8 800AA8A8 21482201 */  addu       $t1, $t1, $v0
  .L800AA8AC:
    /* 9B0AC 800AA8AC 0300A010 */  beqz       $a1, .L800AA8BC
    /* 9B0B0 800AA8B0 02000224 */   addiu     $v0, $zero, 0x2
    /* 9B0B4 800AA8B4 0600A214 */  bne        $a1, $v0, .L800AA8D0
    /* 9B0B8 800AA8B8 80100300 */   sll       $v0, $v1, 2
  .L800AA8BC:
    /* 9B0BC 800AA8BC 80100300 */  sll        $v0, $v1, 2
    /* 9B0C0 800AA8C0 21104700 */  addu       $v0, $v0, $a3
    /* 9B0C4 800AA8C4 0000428C */  lw         $v0, 0x0($v0)
    /* 9B0C8 800AA8C8 38AA0208 */  j          .L800AA8E0
    /* 9B0CC 800AA8CC 21504201 */   addu      $t2, $t2, $v0
  .L800AA8D0:
    /* 9B0D0 800AA8D0 21104700 */  addu       $v0, $v0, $a3
    /* 9B0D4 800AA8D4 0000428C */  lw         $v0, 0x0($v0)
    /* 9B0D8 800AA8D8 00000000 */  nop
    /* 9B0DC 800AA8DC 21586201 */  addu       $t3, $t3, $v0
  .L800AA8E0:
    /* 9B0E0 800AA8E0 3000C624 */  addiu      $a2, $a2, 0x30
    /* 9B0E4 800AA8E4 10AA0208 */  j          .L800AA840
    /* 9B0E8 800AA8E8 0100A524 */   addiu     $a1, $a1, 0x1
  .L800AA8EC:
    /* 9B0EC 800AA8EC 43200900 */  sra        $a0, $t1, 1
    /* 9B0F0 800AA8F0 43180A00 */  sra        $v1, $t2, 1
    /* 9B0F4 800AA8F4 C40D83AF */  sw         $v1, %gp_rel(leftMult)($gp)
    /* 9B0F8 800AA8F8 43180B00 */  sra        $v1, $t3, 1
    /* 9B0FC 800AA8FC BC0D82AF */  sw         $v0, %gp_rel(frontMult)($gp)
    /* 9B100 800AA900 21104400 */  addu       $v0, $v0, $a0
    /* 9B104 800AA904 C80D83AF */  sw         $v1, %gp_rel(rightMult)($gp)
    /* 9B108 800AA908 7401038E */  lw         $v1, 0x174($s0)
    /* 9B10C 800AA90C 43100200 */  sra        $v0, $v0, 1
    /* 9B110 800AA910 C00D84AF */  sw         $a0, %gp_rel(rearMult)($gp)
    /* 9B114 800AA914 2004048E */  lw         $a0, 0x420($s0)
    /* 9B118 800AA918 21104300 */  addu       $v0, $v0, $v1
    /* 9B11C 800AA91C B80D82AF */  sw         $v0, %gp_rel(roadMult)($gp)
    /* 9B120 800AA920 0500023C */  lui        $v0, (0x50000 >> 16)
    /* 9B124 800AA924 2A104400 */  slt        $v0, $v0, $a0
    /* 9B128 800AA928 12004010 */  beqz       $v0, .L800AA974
    /* 9B12C 800AA92C 00000000 */   nop
    /* 9B130 800AA930 6404028E */  lw         $v0, 0x464($s0)
    /* 9B134 800AA934 00000000 */  nop
    /* 9B138 800AA938 1801458C */  lw         $a1, 0x118($v0)
    /* 9B13C 800AA93C CA90030C */  jal        fixedmult
    /* 9B140 800AA940 00000000 */   nop
    /* 9B144 800AA944 2004048E */  lw         $a0, 0x420($s0)
    /* 9B148 800AA948 6404058E */  lw         $a1, 0x464($s0)
    /* 9B14C 800AA94C BC0D838F */  lw         $v1, %gp_rel(frontMult)($gp)
    /* 9B150 800AA950 1C01A58C */  lw         $a1, 0x11C($a1)
    /* 9B154 800AA954 21186200 */  addu       $v1, $v1, $v0
    /* 9B158 800AA958 BC0D83AF */  sw         $v1, %gp_rel(frontMult)($gp)
    /* 9B15C 800AA95C CA90030C */  jal        fixedmult
    /* 9B160 800AA960 00000000 */   nop
    /* 9B164 800AA964 C00D838F */  lw         $v1, %gp_rel(rearMult)($gp)
    /* 9B168 800AA968 00000000 */  nop
    /* 9B16C 800AA96C 21186200 */  addu       $v1, $v1, $v0
    /* 9B170 800AA970 C00D83AF */  sw         $v1, %gp_rel(rearMult)($gp)
  .L800AA974:
    /* 9B174 800AA974 1400BF8F */  lw         $ra, 0x14($sp)
    /* 9B178 800AA978 1000B08F */  lw         $s0, 0x10($sp)
    /* 9B17C 800AA97C 0800E003 */  jr         $ra
    /* 9B180 800AA980 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Physics_CalculateRoadGripModifiers__FP8Car_tObj
