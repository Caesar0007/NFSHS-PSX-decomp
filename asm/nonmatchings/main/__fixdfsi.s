.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __fixdfsi, 0xFC

glabel __fixdfsi
    /* E7034 800F6834 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* E7038 800F6838 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E703C 800F683C FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E7040 800F6840 2400B1AF */  sw         $s1, 0x24($sp)
    /* E7044 800F6844 2000B0AF */  sw         $s0, 0x20($sp)
    /* E7048 800F6848 21808000 */  addu       $s0, $a0, $zero
    /* E704C 800F684C 2188A000 */  addu       $s1, $a1, $zero
    /* E7050 800F6850 24102202 */  and        $v0, $s1, $v0
    /* E7054 800F6854 3000BFAF */  sw         $ra, 0x30($sp)
    /* E7058 800F6858 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* E705C 800F685C 05004014 */  bnez       $v0, .L800F6874
    /* E7060 800F6860 2800B2AF */   sw        $s2, 0x28($sp)
    /* E7064 800F6864 03000016 */  bnez       $s0, .L800F6874
    /* E7068 800F6868 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E706C 800F686C 45DA0308 */  j          .L800F6914
    /* E7070 800F6870 24102202 */   and       $v0, $s1, $v0
  .L800F6874:
    /* E7074 800F6874 03151100 */  sra        $v0, $s1, 20
    /* E7078 800F6878 FF075230 */  andi       $s2, $v0, 0x7FF
    /* E707C 800F687C E3FB5326 */  addiu      $s3, $s2, -0x41D
    /* E7080 800F6880 0800601A */  blez       $s3, .L800F68A4
    /* E7084 800F6884 22000424 */   addiu     $a0, $zero, 0x22
    /* E7088 800F6888 951A040C */  jal        _err_math
    /* E708C 800F688C 11000524 */   addiu     $a1, $zero, 0x11
    /* E7090 800F6890 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E7094 800F6894 1F002106 */  bgez       $s1, .L800F6914
    /* E7098 800F6898 FFFF4234 */   ori       $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E709C 800F689C 45DA0308 */  j          .L800F6914
    /* E70A0 800F68A0 0080023C */   lui       $v0, (0x80000000 >> 16)
  .L800F68A4:
    /* E70A4 800F68A4 0F00023C */  lui        $v0, (0xFFFFF >> 16)
    /* E70A8 800F68A8 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* E70AC 800F68AC 1800A427 */  addiu      $a0, $sp, 0x18
    /* E70B0 800F68B0 24102202 */  and        $v0, $s1, $v0
    /* E70B4 800F68B4 1000033C */  lui        $v1, (0x100000 >> 16)
    /* E70B8 800F68B8 25104300 */  or         $v0, $v0, $v1
    /* E70BC 800F68BC 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E70C0 800F68C0 0A000224 */  addiu      $v0, $zero, 0xA
    /* E70C4 800F68C4 1800B0AF */  sw         $s0, 0x18($sp)
    /* E70C8 800F68C8 1000A2AF */  sw         $v0, 0x10($sp)
    /* E70CC 800F68CC 1800A68F */  lw         $a2, 0x18($sp)
    /* E70D0 800F68D0 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E70D4 800F68D4 901B040C */  jal        _dbl_shift
    /* E70D8 800F68D8 21280000 */   addu      $a1, $zero, $zero
    /* E70DC 800F68DC 02FC4226 */  addiu      $v0, $s2, -0x3FE
    /* E70E0 800F68E0 2000422C */  sltiu      $v0, $v0, 0x20
    /* E70E4 800F68E4 1C00A38F */  lw         $v1, 0x1C($sp)
    /* E70E8 800F68E8 05004010 */  beqz       $v0, .L800F6900
    /* E70EC 800F68EC 00000000 */   nop
    /* E70F0 800F68F0 03006010 */  beqz       $v1, .L800F6900
    /* E70F4 800F68F4 23101300 */   negu      $v0, $s3
    /* E70F8 800F68F8 42DA0308 */  j          .L800F6908
    /* E70FC 800F68FC 07184300 */   srav      $v1, $v1, $v0
  .L800F6900:
    /* E7100 800F6900 45DA0308 */  j          .L800F6914
    /* E7104 800F6904 21100000 */   addu      $v0, $zero, $zero
  .L800F6908:
    /* E7108 800F6908 02002106 */  bgez       $s1, .L800F6914
    /* E710C 800F690C 21106000 */   addu      $v0, $v1, $zero
    /* E7110 800F6910 23100200 */  negu       $v0, $v0
  .L800F6914:
    /* E7114 800F6914 3000BF8F */  lw         $ra, 0x30($sp)
    /* E7118 800F6918 2C00B38F */  lw         $s3, 0x2C($sp)
    /* E711C 800F691C 2800B28F */  lw         $s2, 0x28($sp)
    /* E7120 800F6920 2400B18F */  lw         $s1, 0x24($sp)
    /* E7124 800F6924 2000B08F */  lw         $s0, 0x20($sp)
    /* E7128 800F6928 0800E003 */  jr         $ra
    /* E712C 800F692C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel __fixdfsi
    /* E7130 800F6930 00000000 */  nop
