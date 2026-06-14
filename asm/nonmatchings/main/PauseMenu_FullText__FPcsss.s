.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PauseMenu_FullText__FPcsss, 0xB4

glabel PauseMenu_FullText__FPcsss
    /* 97660 800A6E60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 97664 800A6E64 1000B0AF */  sw         $s0, 0x10($sp)
    /* 97668 800A6E68 2180A000 */  addu       $s0, $a1, $zero
    /* 9766C 800A6E6C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 97670 800A6E70 2190E000 */  addu       $s2, $a3, $zero
    /* 97674 800A6E74 1400B1AF */  sw         $s1, 0x14($sp)
    /* 97678 800A6E78 21888000 */  addu       $s1, $a0, $zero
    /* 9767C 800A6E7C 7818838F */  lw         $v1, %gp_rel(D_8013DDC4)($gp)
    /* 97680 800A6E80 62000224 */  addiu      $v0, $zero, 0x62
    /* 97684 800A6E84 04006214 */  bne        $v1, $v0, .L800A6E98
    /* 97688 800A6E88 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* 9768C 800A6E8C A0001024 */  addiu      $s0, $zero, 0xA0
    /* 97690 800A6E90 02000624 */  addiu      $a2, $zero, 0x2
    /* 97694 800A6E94 06001224 */  addiu      $s2, $zero, 0x6
  .L800A6E98:
    /* 97698 800A6E98 00140600 */  sll        $v0, $a2, 16
    /* 9769C 800A6E9C 031C0200 */  sra        $v1, $v0, 16
    /* 976A0 800A6EA0 01000224 */  addiu      $v0, $zero, 0x1
    /* 976A4 800A6EA4 05006214 */  bne        $v1, $v0, .L800A6EBC
    /* 976A8 800A6EA8 02000224 */   addiu     $v0, $zero, 0x2
    /* 976AC 800A6EAC 888F030C */  jal        textpixels
    /* 976B0 800A6EB0 21202002 */   addu      $a0, $s1, $zero
    /* 976B4 800A6EB4 B79B0208 */  j          .L800A6EDC
    /* 976B8 800A6EB8 23800202 */   subu      $s0, $s0, $v0
  .L800A6EBC:
    /* 976BC 800A6EBC 07006214 */  bne        $v1, $v0, .L800A6EDC
    /* 976C0 800A6EC0 00000000 */   nop
    /* 976C4 800A6EC4 888F030C */  jal        textpixels
    /* 976C8 800A6EC8 21202002 */   addu      $a0, $s1, $zero
    /* 976CC 800A6ECC C21F0200 */  srl        $v1, $v0, 31
    /* 976D0 800A6ED0 21186200 */  addu       $v1, $v1, $v0
    /* 976D4 800A6ED4 43180300 */  sra        $v1, $v1, 1
    /* 976D8 800A6ED8 23800302 */  subu       $s0, $s0, $v1
  .L800A6EDC:
    /* 976DC 800A6EDC 00241200 */  sll        $a0, $s2, 16
    /* 976E0 800A6EE0 832C030C */  jal        Font_TextColor__Fi
    /* 976E4 800A6EE4 03240400 */   sra       $a0, $a0, 16
    /* 976E8 800A6EE8 21202002 */  addu       $a0, $s1, $zero
    /* 976EC 800A6EEC 002C1000 */  sll        $a1, $s0, 16
    /* 976F0 800A6EF0 7818868F */  lw         $a2, %gp_rel(D_8013DDC4)($gp)
    /* 976F4 800A6EF4 A42E030C */  jal        Font_TextXY__FPcii
    /* 976F8 800A6EF8 032C0500 */   sra       $a1, $a1, 16
    /* 976FC 800A6EFC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 97700 800A6F00 1800B28F */  lw         $s2, 0x18($sp)
    /* 97704 800A6F04 1400B18F */  lw         $s1, 0x14($sp)
    /* 97708 800A6F08 1000B08F */  lw         $s0, 0x10($sp)
    /* 9770C 800A6F0C 0800E003 */  jr         $ra
    /* 97710 800A6F10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PauseMenu_FullText__FPcsss
