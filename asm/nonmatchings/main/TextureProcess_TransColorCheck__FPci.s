.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextureProcess_TransColorCheck__FPci, 0x34

glabel TextureProcess_TransColorCheck__FPci
    /* D1084 800E0884 21180000 */  addu       $v1, $zero, $zero
    /* D1088 800E0888 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* D108C 800E088C 00800634 */  ori        $a2, $zero, 0x8000
  .L800E0890:
    /* D1090 800E0890 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* D1094 800E0894 0600A710 */  beq        $a1, $a3, .L800E08B0
    /* D1098 800E0898 00000000 */   nop
    /* D109C 800E089C 00008294 */  lhu        $v0, 0x0($a0)
    /* D10A0 800E08A0 02008424 */  addiu      $a0, $a0, 0x2
    /* D10A4 800E08A4 2B10C200 */  sltu       $v0, $a2, $v0
    /* D10A8 800E08A8 24820308 */  j          .L800E0890
    /* D10AC 800E08AC 25186200 */   or        $v1, $v1, $v0
  .L800E08B0:
    /* D10B0 800E08B0 0800E003 */  jr         $ra
    /* D10B4 800E08B4 21106000 */   addu      $v0, $v1, $zero
endlabel TextureProcess_TransColorCheck__FPci
