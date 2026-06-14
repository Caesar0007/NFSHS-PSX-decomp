.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Activate__Q26Speech15DispatchSpeakeri, 0x9C

glabel Activate__Q26Speech15DispatchSpeakeri
    /* 86654 80095E54 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 86658 80095E58 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8665C 80095E5C 21808000 */  addu       $s0, $a0, $zero
    /* 86660 80095E60 1800BFAF */  sw         $ra, 0x18($sp)
    /* 86664 80095E64 1400B1AF */  sw         $s1, 0x14($sp)
    /* 86668 80095E68 4C00028E */  lw         $v0, 0x4C($s0)
    /* 8666C 80095E6C 2188A000 */  addu       $s1, $a1, $zero
    /* 86670 80095E70 F0004484 */  lh         $a0, 0xF0($v0)
    /* 86674 80095E74 F400428C */  lw         $v0, 0xF4($v0)
    /* 86678 80095E78 00000000 */  nop
    /* 8667C 80095E7C 09F84000 */  jalr       $v0
    /* 86680 80095E80 21200402 */   addu      $a0, $s0, $a0
    /* 86684 80095E84 01000524 */  addiu      $a1, $zero, 0x1
    /* 86688 80095E88 0400428C */  lw         $v0, 0x4($v0)
    /* 8668C 80095E8C 04000426 */  addiu      $a0, $s0, 0x4
    /* 86690 80095E90 380002AE */  sw         $v0, 0x38($s0)
    /* 86694 80095E94 1180023C */  lui        $v0, %hi(D_80113228)
    /* 86698 80095E98 2832438C */  lw         $v1, %lo(D_80113228)($v0)
    /* 8669C 80095E9C FF000224 */  addiu      $v0, $zero, 0xFF
    /* 866A0 80095EA0 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 866A4 80095EA4 0F000224 */  addiu      $v0, $zero, 0xF
    /* 866A8 80095EA8 200002AE */  sw         $v0, 0x20($s0)
    /* 866AC 80095EAC 480000AE */  sw         $zero, 0x48($s0)
    /* 866B0 80095EB0 24186500 */  and        $v1, $v1, $a1
    /* 866B4 80095EB4 180003AE */  sw         $v1, 0x18($s0)
  .L80095EB8:
    /* 866B8 80095EB8 5C0080AC */  sw         $zero, 0x5C($a0)
    /* 866BC 80095EBC FFFFA524 */  addiu      $a1, $a1, -0x1
    /* 866C0 80095EC0 FDFFA104 */  bgez       $a1, .L80095EB8
    /* 866C4 80095EC4 FCFF8424 */   addiu     $a0, $a0, -0x4
    /* 866C8 80095EC8 00020224 */  addiu      $v0, $zero, 0x200
    /* 866CC 80095ECC 500002AE */  sw         $v0, 0x50($s0)
    /* 866D0 80095ED0 540000AE */  sw         $zero, 0x54($s0)
    /* 866D4 80095ED4 580011AE */  sw         $s1, 0x58($s0)
    /* 866D8 80095ED8 440000AE */  sw         $zero, 0x44($s0)
    /* 866DC 80095EDC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 866E0 80095EE0 1400B18F */  lw         $s1, 0x14($sp)
    /* 866E4 80095EE4 1000B08F */  lw         $s0, 0x10($sp)
    /* 866E8 80095EE8 0800E003 */  jr         $ra
    /* 866EC 80095EEC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Activate__Q26Speech15DispatchSpeakeri
