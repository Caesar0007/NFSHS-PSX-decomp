.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching crc16, 0xC8

glabel crc16
    /* E694C 800F614C 1380083C */  lui        $t0, %hi(D_80135C58)
    /* E6950 800F6150 585C0825 */  addiu      $t0, $t0, %lo(D_80135C58)
    /* E6954 800F6154 FB000324 */  addiu      $v1, $zero, 0xFB
    /* E6958 800F6158 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* E695C 800F615C 1C00A004 */  bltz       $a1, .L800F61D0
    /* E6960 800F6160 EA000224 */   addiu     $v0, $zero, 0xEA
  .L800F6164:
    /* E6964 800F6164 00008990 */  lbu        $t1, 0x0($a0)
    /* E6968 800F6168 01008A90 */  lbu        $t2, 0x1($a0)
    /* E696C 800F616C 26482201 */  xor        $t1, $t1, $v0
    /* E6970 800F6170 21582801 */  addu       $t3, $t1, $t0
    /* E6974 800F6174 00006C91 */  lbu        $t4, 0x0($t3)
    /* E6978 800F6178 00016D91 */  lbu        $t5, 0x100($t3)
    /* E697C 800F617C 26108301 */  xor        $v0, $t4, $v1
    /* E6980 800F6180 26504201 */  xor        $t2, $t2, $v0
    /* E6984 800F6184 21584801 */  addu       $t3, $t2, $t0
    /* E6988 800F6188 00006C91 */  lbu        $t4, 0x0($t3)
    /* E698C 800F618C 00016391 */  lbu        $v1, 0x100($t3)
    /* E6990 800F6190 26108D01 */  xor        $v0, $t4, $t5
    /* E6994 800F6194 02008990 */  lbu        $t1, 0x2($a0)
    /* E6998 800F6198 03008A90 */  lbu        $t2, 0x3($a0)
    /* E699C 800F619C 26482201 */  xor        $t1, $t1, $v0
    /* E69A0 800F61A0 21582801 */  addu       $t3, $t1, $t0
    /* E69A4 800F61A4 00006C91 */  lbu        $t4, 0x0($t3)
    /* E69A8 800F61A8 00016D91 */  lbu        $t5, 0x100($t3)
    /* E69AC 800F61AC 26108301 */  xor        $v0, $t4, $v1
    /* E69B0 800F61B0 26504201 */  xor        $t2, $t2, $v0
    /* E69B4 800F61B4 21584801 */  addu       $t3, $t2, $t0
    /* E69B8 800F61B8 00006C91 */  lbu        $t4, 0x0($t3)
    /* E69BC 800F61BC 00016391 */  lbu        $v1, 0x100($t3)
    /* E69C0 800F61C0 26108D01 */  xor        $v0, $t4, $t5
    /* E69C4 800F61C4 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* E69C8 800F61C8 E6FFA104 */  bgez       $a1, .L800F6164
    /* E69CC 800F61CC 04008424 */   addiu     $a0, $a0, 0x4
  .L800F61D0:
    /* E69D0 800F61D0 0300A524 */  addiu      $a1, $a1, 0x3
    /* E69D4 800F61D4 0C00A004 */  bltz       $a1, .L800F6208
    /* E69D8 800F61D8 00000000 */   nop
  .L800F61DC:
    /* E69DC 800F61DC 00008990 */  lbu        $t1, 0x0($a0)
    /* E69E0 800F61E0 00000000 */  nop
    /* E69E4 800F61E4 26482201 */  xor        $t1, $t1, $v0
    /* E69E8 800F61E8 21582801 */  addu       $t3, $t1, $t0
    /* E69EC 800F61EC 00006C91 */  lbu        $t4, 0x0($t3)
    /* E69F0 800F61F0 00016D91 */  lbu        $t5, 0x100($t3)
    /* E69F4 800F61F4 26108301 */  xor        $v0, $t4, $v1
    /* E69F8 800F61F8 2118A001 */  addu       $v1, $t5, $zero
    /* E69FC 800F61FC FFFFA524 */  addiu      $a1, $a1, -0x1
    /* E6A00 800F6200 F6FFA104 */  bgez       $a1, .L800F61DC
    /* E6A04 800F6204 01008424 */   addiu     $a0, $a0, 0x1
  .L800F6208:
    /* E6A08 800F6208 001A0300 */  sll        $v1, $v1, 8
    /* E6A0C 800F620C 0800E003 */  jr         $ra
    /* E6A10 800F6210 25104300 */   or        $v0, $v0, $v1
endlabel crc16
