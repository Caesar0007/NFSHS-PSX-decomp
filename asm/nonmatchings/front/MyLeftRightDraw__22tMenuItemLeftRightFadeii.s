.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MyLeftRightDraw__22tMenuItemLeftRightFadeii, 0xF4

glabel MyLeftRightDraw__22tMenuItemLeftRightFadeii
    /* E93C 8001E13C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* E940 8001E140 3800B0AF */  sw         $s0, 0x38($sp)
    /* E944 8001E144 21808000 */  addu       $s0, $a0, $zero
    /* E948 8001E148 4000B2AF */  sw         $s2, 0x40($sp)
    /* E94C 8001E14C 2190A000 */  addu       $s2, $a1, $zero
    /* E950 8001E150 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* E954 8001E154 2188C000 */  addu       $s1, $a2, $zero
    /* E958 8001E158 C800043C */  lui        $a0, (0xC83C1E >> 16)
    /* E95C 8001E15C 1E3C8434 */  ori        $a0, $a0, (0xC83C1E & 0xFFFF)
    /* E960 8001E160 4400BFAF */  sw         $ra, 0x44($sp)
    /* E964 8001E164 08000686 */  lh         $a2, 0x8($s0)
    /* E968 8001E168 20000786 */  lh         $a3, 0x20($s0)
    /* E96C 8001E16C 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* E970 8001E170 BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* E974 8001E174 21202002 */  addu       $a0, $s1, $zero
    /* E978 8001E178 2400A2AF */  sw         $v0, 0x24($sp)
    /* E97C 8001E17C 08000586 */  lh         $a1, 0x8($s0)
    /* E980 8001E180 20000686 */  lh         $a2, 0x20($s0)
    /* E984 8001E184 E86F000C */  jal        DrawLeftFlare__FiiiRi
    /* E988 8001E188 28000726 */   addiu     $a3, $s0, 0x28
    /* E98C 8001E18C 08000586 */  lh         $a1, 0x8($s0)
    /* E990 8001E190 20000686 */  lh         $a2, 0x20($s0)
    /* E994 8001E194 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* E998 8001E198 06000424 */   addiu     $a0, $zero, 0x6
    /* E99C 8001E19C 0400048E */  lw         $a0, 0x4($s0)
    /* E9A0 8001E1A0 94E4020C */  jal        TextSys_Word__Fi
    /* E9A4 8001E1A4 21804000 */   addu      $s0, $v0, $zero
    /* E9A8 8001E1A8 21204000 */  addu       $a0, $v0, $zero
    /* E9AC 8001E1AC 002C1200 */  sll        $a1, $s2, 16
    /* E9B0 8001E1B0 032C0500 */  sra        $a1, $a1, 16
    /* E9B4 8001E1B4 00341100 */  sll        $a2, $s1, 16
    /* E9B8 8001E1B8 03340600 */  sra        $a2, $a2, 16
    /* E9BC 8001E1BC 21380002 */  addu       $a3, $s0, $zero
    /* E9C0 8001E1C0 01000224 */  addiu      $v0, $zero, 0x1
    /* E9C4 8001E1C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* E9C8 8001E1C8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* E9CC 8001E1CC 1400A2AF */   sw        $v0, 0x14($sp)
    /* E9D0 8001E1D0 2E000424 */  addiu      $a0, $zero, 0x2E
    /* E9D4 8001E1D4 18000524 */  addiu      $a1, $zero, 0x18
    /* E9D8 8001E1D8 1A004626 */  addiu      $a2, $s2, 0x1A
    /* E9DC 8001E1DC 01003126 */  addiu      $s1, $s1, 0x1
    /* E9E0 8001E1E0 21382002 */  addu       $a3, $s1, $zero
    /* E9E4 8001E1E4 2000B027 */  addiu      $s0, $sp, 0x20
    /* E9E8 8001E1E8 1000A0AF */  sw         $zero, 0x10($sp)
    /* E9EC 8001E1EC 1400A0AF */  sw         $zero, 0x14($sp)
    /* E9F0 8001E1F0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E9F4 8001E1F4 1800B0AF */   sw        $s0, 0x18($sp)
    /* E9F8 8001E1F8 2F000424 */  addiu      $a0, $zero, 0x2F
    /* E9FC 8001E1FC 18000524 */  addiu      $a1, $zero, 0x18
    /* EA00 8001E200 C8004626 */  addiu      $a2, $s2, 0xC8
    /* EA04 8001E204 21382002 */  addu       $a3, $s1, $zero
    /* EA08 8001E208 1000A0AF */  sw         $zero, 0x10($sp)
    /* EA0C 8001E20C 1400A0AF */  sw         $zero, 0x14($sp)
    /* EA10 8001E210 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* EA14 8001E214 1800B0AF */   sw        $s0, 0x18($sp)
    /* EA18 8001E218 4400BF8F */  lw         $ra, 0x44($sp)
    /* EA1C 8001E21C 4000B28F */  lw         $s2, 0x40($sp)
    /* EA20 8001E220 3C00B18F */  lw         $s1, 0x3C($sp)
    /* EA24 8001E224 3800B08F */  lw         $s0, 0x38($sp)
    /* EA28 8001E228 0800E003 */  jr         $ra
    /* EA2C 8001E22C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel MyLeftRightDraw__22tMenuItemLeftRightFadeii
