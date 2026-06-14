.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDgetdata, 0x88

glabel iSNDgetdata
    /* FD128 8010C928 21380000 */  addu       $a3, $zero, $zero
    /* FD12C 8010C92C 0800A010 */  beqz       $a1, .L8010C950
    /* FD130 8010C930 FFFFA624 */   addiu     $a2, $a1, -0x1
    /* FD134 8010C934 FFFF0824 */  addiu      $t0, $zero, -0x1
  .L8010C938:
    /* FD138 8010C938 00008390 */  lbu        $v1, 0x0($a0)
    /* FD13C 8010C93C 01008424 */  addiu      $a0, $a0, 0x1
    /* FD140 8010C940 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* FD144 8010C944 00120700 */  sll        $v0, $a3, 8
    /* FD148 8010C948 FBFFC814 */  bne        $a2, $t0, .L8010C938
    /* FD14C 8010C94C 21384300 */   addu      $a3, $v0, $v1
  .L8010C950:
    /* FD150 8010C950 01000224 */  addiu      $v0, $zero, 0x1
    /* FD154 8010C954 0600A214 */  bne        $a1, $v0, .L8010C970
    /* FD158 8010C958 02000224 */   addiu     $v0, $zero, 0x2
    /* FD15C 8010C95C 8000E228 */  slti       $v0, $a3, 0x80
    /* FD160 8010C960 03004014 */  bnez       $v0, .L8010C970
    /* FD164 8010C964 02000224 */   addiu     $v0, $zero, 0x2
    /* FD168 8010C968 6A320408 */  j          .L8010C9A8
    /* FD16C 8010C96C 00FFE724 */   addiu     $a3, $a3, -0x100
  .L8010C970:
    /* FD170 8010C970 0600A214 */  bne        $a1, $v0, .L8010C98C
    /* FD174 8010C974 03000224 */   addiu     $v0, $zero, 0x3
    /* FD178 8010C978 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* FD17C 8010C97C 2A104700 */  slt        $v0, $v0, $a3
    /* FD180 8010C980 08004014 */  bnez       $v0, .L8010C9A4
    /* FD184 8010C984 FFFF023C */   lui       $v0, (0xFFFF0000 >> 16)
    /* FD188 8010C988 03000224 */  addiu      $v0, $zero, 0x3
  .L8010C98C:
    /* FD18C 8010C98C 0600A214 */  bne        $a1, $v0, .L8010C9A8
    /* FD190 8010C990 7F00023C */   lui       $v0, (0x7FFFFF >> 16)
    /* FD194 8010C994 FFFF4234 */  ori        $v0, $v0, (0x7FFFFF & 0xFFFF)
    /* FD198 8010C998 2A104700 */  slt        $v0, $v0, $a3
    /* FD19C 8010C99C 02004010 */  beqz       $v0, .L8010C9A8
    /* FD1A0 8010C9A0 00FF023C */   lui       $v0, (0xFF000000 >> 16)
  .L8010C9A4:
    /* FD1A4 8010C9A4 2138E200 */  addu       $a3, $a3, $v0
  .L8010C9A8:
    /* FD1A8 8010C9A8 0800E003 */  jr         $ra
    /* FD1AC 8010C9AC 2110E000 */   addu      $v0, $a3, $zero
endlabel iSNDgetdata
