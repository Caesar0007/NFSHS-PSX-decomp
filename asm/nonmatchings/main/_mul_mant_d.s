.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _mul_mant_d, 0xEC

glabel _mul_mant_d
    /* E6DF8 800F65F8 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E6DFC 800F65FC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* E6E00 800F6600 2188A000 */  addu       $s1, $a1, $zero
    /* E6E04 800F6604 2800B0AF */  sw         $s0, 0x28($sp)
    /* E6E08 800F6608 2180C000 */  addu       $s0, $a2, $zero
    /* E6E0C 800F660C 3000B2AF */  sw         $s2, 0x30($sp)
    /* E6E10 800F6610 FFFF3232 */  andi       $s2, $s1, 0xFFFF
    /* E6E14 800F6614 FFFF0232 */  andi       $v0, $s0, 0xFFFF
    /* E6E18 800F6618 18004202 */  mult       $s2, $v0
    /* E6E1C 800F661C 12180000 */  mflo       $v1
    /* E6E20 800F6620 028C1100 */  srl        $s1, $s1, 16
    /* E6E24 800F6624 00000000 */  nop
    /* E6E28 800F6628 18002202 */  mult       $s1, $v0
    /* E6E2C 800F662C 3400B3AF */  sw         $s3, 0x34($sp)
    /* E6E30 800F6630 21988000 */  addu       $s3, $a0, $zero
    /* E6E34 800F6634 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6E38 800F6638 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* E6E3C 800F663C 1800A3AF */  sw         $v1, 0x18($sp)
    /* E6E40 800F6640 12100000 */  mflo       $v0
    /* E6E44 800F6644 021C0200 */  srl        $v1, $v0, 16
    /* E6E48 800F6648 00140200 */  sll        $v0, $v0, 16
    /* E6E4C 800F664C 2400A3AF */  sw         $v1, 0x24($sp)
    /* E6E50 800F6650 2000A2AF */  sw         $v0, 0x20($sp)
    /* E6E54 800F6654 1000A3AF */  sw         $v1, 0x10($sp)
    /* E6E58 800F6658 2000A78F */  lw         $a3, 0x20($sp)
    /* E6E5C 800F665C 1800A58F */  lw         $a1, 0x18($sp)
    /* E6E60 800F6660 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6E64 800F6664 3800BFAF */  sw         $ra, 0x38($sp)
    /* E6E68 800F6668 DC1B040C */  jal        _add_mant_d
    /* E6E6C 800F666C 02841000 */   srl       $s0, $s0, 16
    /* E6E70 800F6670 18005002 */  mult       $s2, $s0
    /* E6E74 800F6674 12100000 */  mflo       $v0
    /* E6E78 800F6678 021C0200 */  srl        $v1, $v0, 16
    /* E6E7C 800F667C 00140200 */  sll        $v0, $v0, 16
    /* E6E80 800F6680 2400A3AF */  sw         $v1, 0x24($sp)
    /* E6E84 800F6684 2000A2AF */  sw         $v0, 0x20($sp)
    /* E6E88 800F6688 1000A3AF */  sw         $v1, 0x10($sp)
    /* E6E8C 800F668C 2000A78F */  lw         $a3, 0x20($sp)
    /* E6E90 800F6690 1800A58F */  lw         $a1, 0x18($sp)
    /* E6E94 800F6694 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6E98 800F6698 DC1B040C */  jal        _add_mant_d
    /* E6E9C 800F669C 1800A427 */   addiu     $a0, $sp, 0x18
    /* E6EA0 800F66A0 18003002 */  mult       $s1, $s0
    /* E6EA4 800F66A4 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6EA8 800F66A8 12180000 */  mflo       $v1
    /* E6EAC 800F66AC 21104300 */  addu       $v0, $v0, $v1
    /* E6EB0 800F66B0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E6EB4 800F66B4 1800A28F */  lw         $v0, 0x18($sp)
    /* E6EB8 800F66B8 1C00A38F */  lw         $v1, 0x1C($sp)
    /* E6EBC 800F66BC 000062AE */  sw         $v0, 0x0($s3)
    /* E6EC0 800F66C0 040063AE */  sw         $v1, 0x4($s3)
    /* E6EC4 800F66C4 21106002 */  addu       $v0, $s3, $zero
    /* E6EC8 800F66C8 3800BF8F */  lw         $ra, 0x38($sp)
    /* E6ECC 800F66CC 3400B38F */  lw         $s3, 0x34($sp)
    /* E6ED0 800F66D0 3000B28F */  lw         $s2, 0x30($sp)
    /* E6ED4 800F66D4 2C00B18F */  lw         $s1, 0x2C($sp)
    /* E6ED8 800F66D8 2800B08F */  lw         $s0, 0x28($sp)
    /* E6EDC 800F66DC 0800E003 */  jr         $ra
    /* E6EE0 800F66E0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel _mul_mant_d
