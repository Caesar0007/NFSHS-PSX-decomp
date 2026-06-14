.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_Update__Fi, 0x144

glabel Fog_Update__Fi
    /* D1580 800E0D80 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D1584 800E0D84 1800B2AF */  sw         $s2, 0x18($sp)
    /* D1588 800E0D88 21908000 */  addu       $s2, $a0, $zero
    /* D158C 800E0D8C 3016838F */  lw         $v1, %gp_rel(Fog_gNumKeys)($gp)
    /* D1590 800E0D90 01000224 */  addiu      $v0, $zero, 0x1
    /* D1594 800E0D94 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D1598 800E0D98 1400B1AF */  sw         $s1, 0x14($sp)
    /* D159C 800E0D9C 43006210 */  beq        $v1, $v0, .L800E0EAC
    /* D15A0 800E0DA0 1000B0AF */   sw        $s0, 0x10($sp)
    /* D15A4 800E0DA4 1180043C */  lui        $a0, %hi(D_80116F84)
    /* D15A8 800E0DA8 846F8424 */  addiu      $a0, $a0, %lo(D_80116F84)
    /* D15AC 800E0DAC 40811200 */  sll        $s0, $s2, 5
    /* D15B0 800E0DB0 21801202 */  addu       $s0, $s0, $s2
    /* D15B4 800E0DB4 80801000 */  sll        $s0, $s0, 2
    /* D15B8 800E0DB8 4016858F */  lw         $a1, %gp_rel(fogslicePos)($gp)
    /* D15BC 800E0DBC 21304000 */  addu       $a2, $v0, $zero
    /* D15C0 800E0DC0 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* D15C4 800E0DC4 2128B000 */   addu      $a1, $a1, $s0
    /* D15C8 800E0DC8 4016828F */  lw         $v0, %gp_rel(fogslicePos)($gp)
    /* D15CC 800E0DCC 00000000 */  nop
    /* D15D0 800E0DD0 21800202 */  addu       $s0, $s0, $v0
    /* D15D4 800E0DD4 00001186 */  lh         $s1, 0x0($s0)
    /* D15D8 800E0DD8 80801200 */  sll        $s0, $s2, 2
    /* D15DC 800E0DDC 1480023C */  lui        $v0, %hi(Fog_gCurrentKey)
    /* D15E0 800E0DE0 80DB4224 */  addiu      $v0, $v0, %lo(Fog_gCurrentKey)
    /* D15E4 800E0DE4 21800202 */  addu       $s0, $s0, $v0
    /* D15E8 800E0DE8 0000058E */  lw         $a1, 0x0($s0)
    /* D15EC 800E0DEC FB82030C */  jal        Fog_FindKey__FiP6FogKey
    /* D15F0 800E0DF0 21202002 */   addu      $a0, $s1, $zero
    /* D15F4 800E0DF4 21304000 */  addu       $a2, $v0, $zero
    /* D15F8 800E0DF8 000006AE */  sw         $a2, 0x0($s0)
    /* D15FC 800E0DFC 0400C28C */  lw         $v0, 0x4($a2)
    /* D1600 800E0E00 0000C584 */  lh         $a1, 0x0($a2)
    /* D1604 800E0E04 00004384 */  lh         $v1, 0x0($v0)
    /* D1608 800E0E08 02004784 */  lh         $a3, 0x2($v0)
    /* D160C 800E0E0C 2600A310 */  beq        $a1, $v1, .L800E0EA8
    /* D1610 800E0E10 1280023C */   lui       $v0, %hi(D_80123294)
    /* D1614 800E0E14 0200C484 */  lh         $a0, 0x2($a2)
    /* D1618 800E0E18 00000000 */  nop
    /* D161C 800E0E1C 2A10E400 */  slt        $v0, $a3, $a0
    /* D1620 800E0E20 09004010 */  beqz       $v0, .L800E0E48
    /* D1624 800E0E24 00000000 */   nop
    /* D1628 800E0E28 1480033C */  lui        $v1, %hi(gNumSlices)
    /* D162C 800E0E2C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* D1630 800E0E30 05002006 */  bltz       $s1, .L800E0E48
    /* D1634 800E0E34 2138E300 */   addu      $a3, $a3, $v1
    /* D1638 800E0E38 2A102402 */  slt        $v0, $s1, $a0
    /* D163C 800E0E3C 02004010 */  beqz       $v0, .L800E0E48
    /* D1640 800E0E40 00000000 */   nop
    /* D1644 800E0E44 21882302 */  addu       $s1, $s1, $v1
  .L800E0E48:
    /* D1648 800E0E48 0400C28C */  lw         $v0, 0x4($a2)
    /* D164C 800E0E4C 0000C584 */  lh         $a1, 0x0($a2)
    /* D1650 800E0E50 00004484 */  lh         $a0, 0x0($v0)
    /* D1654 800E0E54 0200C284 */  lh         $v0, 0x2($a2)
    /* D1658 800E0E58 23208500 */  subu       $a0, $a0, $a1
    /* D165C 800E0E5C 23182202 */  subu       $v1, $s1, $v0
    /* D1660 800E0E60 18006400 */  mult       $v1, $a0
    /* D1664 800E0E64 12180000 */  mflo       $v1
    /* D1668 800E0E68 2310E200 */  subu       $v0, $a3, $v0
    /* D166C 800E0E6C 00000000 */  nop
    /* D1670 800E0E70 1A006200 */  div        $zero, $v1, $v0
    /* D1674 800E0E74 02004014 */  bnez       $v0, .L800E0E80
    /* D1678 800E0E78 00000000 */   nop
    /* D167C 800E0E7C 0D000700 */  break      7
  .L800E0E80:
    /* D1680 800E0E80 FFFF0124 */  addiu      $at, $zero, -0x1
    /* D1684 800E0E84 04004114 */  bne        $v0, $at, .L800E0E98
    /* D1688 800E0E88 0080013C */   lui       $at, (0x80000000 >> 16)
    /* D168C 800E0E8C 02006114 */  bne        $v1, $at, .L800E0E98
    /* D1690 800E0E90 00000000 */   nop
    /* D1694 800E0E94 0D000600 */  break      6
  .L800E0E98:
    /* D1698 800E0E98 12100000 */  mflo       $v0
    /* D169C 800E0E9C 00000000 */  nop
    /* D16A0 800E0EA0 2128A200 */  addu       $a1, $a1, $v0
    /* D16A4 800E0EA4 1280023C */  lui        $v0, %hi(D_80123294)
  .L800E0EA8:
    /* D16A8 800E0EA8 943245AC */  sw         $a1, %lo(D_80123294)($v0)
  .L800E0EAC:
    /* D16AC 800E0EAC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D16B0 800E0EB0 1800B28F */  lw         $s2, 0x18($sp)
    /* D16B4 800E0EB4 1400B18F */  lw         $s1, 0x14($sp)
    /* D16B8 800E0EB8 1000B08F */  lw         $s0, 0x10($sp)
    /* D16BC 800E0EBC 0800E003 */  jr         $ra
    /* D16C0 800E0EC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Fog_Update__Fi
