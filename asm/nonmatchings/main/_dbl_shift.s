.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _dbl_shift, 0xBC

glabel _dbl_shift
    /* F7640 80106E40 0800A6AF */  sw         $a2, 0x8($sp)
    /* F7644 80106E44 1000A68F */  lw         $a2, 0x10($sp)
    /* F7648 80106E48 21408000 */  addu       $t0, $a0, $zero
    /* F764C 80106E4C 1400A014 */  bnez       $a1, .L80106EA0
    /* F7650 80106E50 0C00A7AF */   sw        $a3, 0xC($sp)
    /* F7654 80106E54 2300C018 */  blez       $a2, .L80106EE4
    /* F7658 80106E58 21200000 */   addu      $a0, $zero, $zero
    /* F765C 80106E5C 0080073C */  lui        $a3, (0x80000000 >> 16)
  .L80106E60:
    /* F7660 80106E60 0C00A28F */  lw         $v0, 0xC($sp)
    /* F7664 80106E64 0800A58F */  lw         $a1, 0x8($sp)
    /* F7668 80106E68 40180200 */  sll        $v1, $v0, 1
    /* F766C 80106E6C 2410A700 */  and        $v0, $a1, $a3
    /* F7670 80106E70 03004010 */  beqz       $v0, .L80106E80
    /* F7674 80106E74 0C00A3AF */   sw        $v1, 0xC($sp)
    /* F7678 80106E78 01006234 */  ori        $v0, $v1, 0x1
    /* F767C 80106E7C 0C00A2AF */  sw         $v0, 0xC($sp)
  .L80106E80:
    /* F7680 80106E80 40100500 */  sll        $v0, $a1, 1
    /* F7684 80106E84 0800A2AF */  sw         $v0, 0x8($sp)
    /* F7688 80106E88 01008424 */  addiu      $a0, $a0, 0x1
    /* F768C 80106E8C 2A108600 */  slt        $v0, $a0, $a2
    /* F7690 80106E90 14004010 */  beqz       $v0, .L80106EE4
    /* F7694 80106E94 00000000 */   nop
    /* F7698 80106E98 981B0408 */  j          .L80106E60
    /* F769C 80106E9C 00000000 */   nop
  .L80106EA0:
    /* F76A0 80106EA0 1000C018 */  blez       $a2, .L80106EE4
    /* F76A4 80106EA4 21200000 */   addu      $a0, $zero, $zero
    /* F76A8 80106EA8 0080073C */  lui        $a3, (0x80000000 >> 16)
  .L80106EAC:
    /* F76AC 80106EAC 0800A28F */  lw         $v0, 0x8($sp)
    /* F76B0 80106EB0 0C00A58F */  lw         $a1, 0xC($sp)
    /* F76B4 80106EB4 42180200 */  srl        $v1, $v0, 1
    /* F76B8 80106EB8 0100A230 */  andi       $v0, $a1, 0x1
    /* F76BC 80106EBC 03004010 */  beqz       $v0, .L80106ECC
    /* F76C0 80106EC0 0800A3AF */   sw        $v1, 0x8($sp)
    /* F76C4 80106EC4 25106700 */  or         $v0, $v1, $a3
    /* F76C8 80106EC8 0800A2AF */  sw         $v0, 0x8($sp)
  .L80106ECC:
    /* F76CC 80106ECC 43100500 */  sra        $v0, $a1, 1
    /* F76D0 80106ED0 0C00A2AF */  sw         $v0, 0xC($sp)
    /* F76D4 80106ED4 01008424 */  addiu      $a0, $a0, 0x1
    /* F76D8 80106ED8 2A108600 */  slt        $v0, $a0, $a2
    /* F76DC 80106EDC F3FF4014 */  bnez       $v0, .L80106EAC
    /* F76E0 80106EE0 00000000 */   nop
  .L80106EE4:
    /* F76E4 80106EE4 0800A28F */  lw         $v0, 0x8($sp)
    /* F76E8 80106EE8 0C00A38F */  lw         $v1, 0xC($sp)
    /* F76EC 80106EEC 000002AD */  sw         $v0, 0x0($t0)
    /* F76F0 80106EF0 040003AD */  sw         $v1, 0x4($t0)
    /* F76F4 80106EF4 0800E003 */  jr         $ra
    /* F76F8 80106EF8 21100001 */   addu      $v0, $t0, $zero
endlabel _dbl_shift
    /* F76FC 80106EFC 00000000 */  nop
