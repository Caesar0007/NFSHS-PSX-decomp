.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unbtree, 0x210

glabel unbtree
    /* E5DB4 800F55B4 E0FCBD27 */  addiu      $sp, $sp, -0x320
    /* E5DB8 800F55B8 1403B1AF */  sw         $s1, 0x314($sp)
    /* E5DBC 800F55BC 1000A227 */  addiu      $v0, $sp, 0x10
    /* E5DC0 800F55C0 7C1982AF */  sw         $v0, %gp_rel(D_8013DEC8)($gp)
    /* E5DC4 800F55C4 1001A227 */  addiu      $v0, $sp, 0x110
    /* E5DC8 800F55C8 801982AF */  sw         $v0, %gp_rel(D_8013DECC)($gp)
    /* E5DCC 800F55CC 1002A227 */  addiu      $v0, $sp, 0x210
    /* E5DD0 800F55D0 1803BFAF */  sw         $ra, 0x318($sp)
    /* E5DD4 800F55D4 1003B0AF */  sw         $s0, 0x310($sp)
    /* E5DD8 800F55D8 881984AF */  sw         $a0, %gp_rel(D_8013DED4)($gp)
    /* E5DDC 800F55DC 8C1985AF */  sw         $a1, %gp_rel(D_8013DED8)($gp)
    /* E5DE0 800F55E0 841982AF */  sw         $v0, %gp_rel(D_8013DED0)($gp)
    /* E5DE4 800F55E4 71008010 */  beqz       $a0, .L800F57AC
    /* E5DE8 800F55E8 21880000 */   addu      $s1, $zero, $zero
    /* E5DEC 800F55EC 00008590 */  lbu        $a1, 0x0($a0)
    /* E5DF0 800F55F0 01008224 */  addiu      $v0, $a0, 0x1
    /* E5DF4 800F55F4 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5DF8 800F55F8 01008390 */  lbu        $v1, 0x1($a0)
    /* E5DFC 800F55FC 02008224 */  addiu      $v0, $a0, 0x2
    /* E5E00 800F5600 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E04 800F5604 00120500 */  sll        $v0, $a1, 8
    /* E5E08 800F5608 21284300 */  addu       $a1, $v0, $v1
    /* E5E0C 800F560C FB470224 */  addiu      $v0, $zero, 0x47FB
    /* E5E10 800F5610 0200A214 */  bne        $a1, $v0, .L800F561C
    /* E5E14 800F5614 05008224 */   addiu     $v0, $a0, 0x5
    /* E5E18 800F5618 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
  .L800F561C:
    /* E5E1C 800F561C 8819828F */  lw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E20 800F5620 21280000 */  addu       $a1, $zero, $zero
    /* E5E24 800F5624 00005190 */  lbu        $s1, 0x0($v0)
    /* E5E28 800F5628 01004224 */  addiu      $v0, $v0, 0x1
    /* E5E2C 800F562C 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E30 800F5630 00004490 */  lbu        $a0, 0x0($v0)
    /* E5E34 800F5634 01004324 */  addiu      $v1, $v0, 0x1
    /* E5E38 800F5638 881983AF */  sw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5E3C 800F563C 01004390 */  lbu        $v1, 0x1($v0)
    /* E5E40 800F5640 02004224 */  addiu      $v0, $v0, 0x2
    /* E5E44 800F5644 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E48 800F5648 00121100 */  sll        $v0, $s1, 8
    /* E5E4C 800F564C 21884400 */  addu       $s1, $v0, $a0
    /* E5E50 800F5650 00121100 */  sll        $v0, $s1, 8
    /* E5E54 800F5654 21884300 */  addu       $s1, $v0, $v1
  .L800F5658:
    /* E5E58 800F5658 7C19828F */  lw         $v0, %gp_rel(D_8013DEC8)($gp)
    /* E5E5C 800F565C 00000000 */  nop
    /* E5E60 800F5660 21104500 */  addu       $v0, $v0, $a1
    /* E5E64 800F5664 0100A524 */  addiu      $a1, $a1, 0x1
    /* E5E68 800F5668 000040A0 */  sb         $zero, 0x0($v0)
    /* E5E6C 800F566C 0001A228 */  slti       $v0, $a1, 0x100
    /* E5E70 800F5670 F9FF4014 */  bnez       $v0, .L800F5658
    /* E5E74 800F5674 00000000 */   nop
    /* E5E78 800F5678 8819828F */  lw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E7C 800F567C 7C19838F */  lw         $v1, %gp_rel(D_8013DEC8)($gp)
    /* E5E80 800F5680 00004490 */  lbu        $a0, 0x0($v0)
    /* E5E84 800F5684 01004224 */  addiu      $v0, $v0, 0x1
    /* E5E88 800F5688 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E8C 800F568C 01000224 */  addiu      $v0, $zero, 0x1
    /* E5E90 800F5690 21186400 */  addu       $v1, $v1, $a0
    /* E5E94 800F5694 000062A0 */  sb         $v0, 0x0($v1)
    /* E5E98 800F5698 8819828F */  lw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5E9C 800F569C 00000000 */  nop
    /* E5EA0 800F56A0 00004690 */  lbu        $a2, 0x0($v0)
    /* E5EA4 800F56A4 01004224 */  addiu      $v0, $v0, 0x1
    /* E5EA8 800F56A8 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5EAC 800F56AC 1A00C010 */  beqz       $a2, .L800F5718
    /* E5EB0 800F56B0 21280000 */   addu      $a1, $zero, $zero
    /* E5EB4 800F56B4 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* E5EB8 800F56B8 0100A524 */  addiu      $a1, $a1, 0x1
  .L800F56BC:
    /* E5EBC 800F56BC 8819838F */  lw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5EC0 800F56C0 8019828F */  lw         $v0, %gp_rel(D_8013DECC)($gp)
    /* E5EC4 800F56C4 00007090 */  lbu        $s0, 0x0($v1)
    /* E5EC8 800F56C8 01006324 */  addiu      $v1, $v1, 0x1
    /* E5ECC 800F56CC 881983AF */  sw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5ED0 800F56D0 00006490 */  lbu        $a0, 0x0($v1)
    /* E5ED4 800F56D4 21105000 */  addu       $v0, $v0, $s0
    /* E5ED8 800F56D8 000044A0 */  sb         $a0, 0x0($v0)
    /* E5EDC 800F56DC 01006224 */  addiu      $v0, $v1, 0x1
    /* E5EE0 800F56E0 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5EE4 800F56E4 8419828F */  lw         $v0, %gp_rel(D_8013DED0)($gp)
    /* E5EE8 800F56E8 01006490 */  lbu        $a0, 0x1($v1)
    /* E5EEC 800F56EC 21105000 */  addu       $v0, $v0, $s0
    /* E5EF0 800F56F0 000044A0 */  sb         $a0, 0x0($v0)
    /* E5EF4 800F56F4 7C19828F */  lw         $v0, %gp_rel(D_8013DEC8)($gp)
    /* E5EF8 800F56F8 02006324 */  addiu      $v1, $v1, 0x2
    /* E5EFC 800F56FC 881983AF */  sw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5F00 800F5700 21105000 */  addu       $v0, $v0, $s0
    /* E5F04 800F5704 000047A0 */  sb         $a3, 0x0($v0)
    /* E5F08 800F5708 2A10A600 */  slt        $v0, $a1, $a2
    /* E5F0C 800F570C EBFF4014 */  bnez       $v0, .L800F56BC
    /* E5F10 800F5710 0100A524 */   addiu     $a1, $a1, 0x1
    /* E5F14 800F5714 FFFFA524 */  addiu      $a1, $a1, -0x1
  .L800F5718:
    /* E5F18 800F5718 8819838F */  lw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5F1C 800F571C 7C19828F */  lw         $v0, %gp_rel(D_8013DEC8)($gp)
    /* E5F20 800F5720 00007090 */  lbu        $s0, 0x0($v1)
    /* E5F24 800F5724 01006324 */  addiu      $v1, $v1, 0x1
    /* E5F28 800F5728 881983AF */  sw         $v1, %gp_rel(D_8013DED4)($gp)
    /* E5F2C 800F572C 21105000 */  addu       $v0, $v0, $s0
    /* E5F30 800F5730 00004280 */  lb         $v0, 0x0($v0)
    /* E5F34 800F5734 00000000 */  nop
    /* E5F38 800F5738 15004010 */  beqz       $v0, .L800F5790
    /* E5F3C 800F573C 00000000 */   nop
    /* E5F40 800F5740 0F004104 */  bgez       $v0, .L800F5780
    /* E5F44 800F5744 01006224 */   addiu     $v0, $v1, 0x1
    /* E5F48 800F5748 8019828F */  lw         $v0, %gp_rel(D_8013DECC)($gp)
    /* E5F4C 800F574C 00000000 */  nop
    /* E5F50 800F5750 21105000 */  addu       $v0, $v0, $s0
    /* E5F54 800F5754 00004490 */  lbu        $a0, 0x0($v0)
    /* E5F58 800F5758 4CD5030C */  jal        chase
    /* E5F5C 800F575C 00000000 */   nop
    /* E5F60 800F5760 8419828F */  lw         $v0, %gp_rel(D_8013DED0)($gp)
    /* E5F64 800F5764 00000000 */  nop
    /* E5F68 800F5768 21105000 */  addu       $v0, $v0, $s0
    /* E5F6C 800F576C 00004490 */  lbu        $a0, 0x0($v0)
    /* E5F70 800F5770 4CD5030C */  jal        chase
    /* E5F74 800F5774 00000000 */   nop
    /* E5F78 800F5778 C6D50308 */  j          .L800F5718
    /* E5F7C 800F577C 00000000 */   nop
  .L800F5780:
    /* E5F80 800F5780 00007090 */  lbu        $s0, 0x0($v1)
    /* E5F84 800F5784 881982AF */  sw         $v0, %gp_rel(D_8013DED4)($gp)
    /* E5F88 800F5788 09000012 */  beqz       $s0, .L800F57B0
    /* E5F8C 800F578C 21102002 */   addu      $v0, $s1, $zero
  .L800F5790:
    /* E5F90 800F5790 8C19828F */  lw         $v0, %gp_rel(D_8013DED8)($gp)
    /* E5F94 800F5794 00000000 */  nop
    /* E5F98 800F5798 000050A0 */  sb         $s0, 0x0($v0)
    /* E5F9C 800F579C 01004224 */  addiu      $v0, $v0, 0x1
    /* E5FA0 800F57A0 8C1982AF */  sw         $v0, %gp_rel(D_8013DED8)($gp)
    /* E5FA4 800F57A4 C6D50308 */  j          .L800F5718
    /* E5FA8 800F57A8 00000000 */   nop
  .L800F57AC:
    /* E5FAC 800F57AC 21102002 */  addu       $v0, $s1, $zero
  .L800F57B0:
    /* E5FB0 800F57B0 1803BF8F */  lw         $ra, 0x318($sp)
    /* E5FB4 800F57B4 1403B18F */  lw         $s1, 0x314($sp)
    /* E5FB8 800F57B8 1003B08F */  lw         $s0, 0x310($sp)
    /* E5FBC 800F57BC 0800E003 */  jr         $ra
    /* E5FC0 800F57C0 2003BD27 */   addiu     $sp, $sp, 0x320
endlabel unbtree
