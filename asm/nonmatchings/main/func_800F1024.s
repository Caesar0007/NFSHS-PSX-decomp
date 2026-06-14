.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F1024, 0xFC

glabel func_800F1024
    /* E1824 800F1024 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E1828 800F1028 1800B0AF */  sw         $s0, 0x18($sp)
    /* E182C 800F102C 2180C000 */  addu       $s0, $a2, $zero
    /* E1830 800F1030 2000BFAF */  sw         $ra, 0x20($sp)
    /* E1834 800F1034 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E1838 800F1038 1800048E */  lw         $a0, 0x18($s0)
    /* E183C 800F103C ACB0030C */  jal        FILE_completeop
    /* E1840 800F1040 21880002 */   addu      $s1, $s0, $zero
    /* E1844 800F1044 21204000 */  addu       $a0, $v0, $zero
    /* E1848 800F1048 0800028E */  lw         $v0, 0x8($s0)
    /* E184C 800F104C 2000038E */  lw         $v1, 0x20($s0)
    /* E1850 800F1050 21104400 */  addu       $v0, $v0, $a0
    /* E1854 800F1054 080002AE */  sw         $v0, 0x8($s0)
    /* E1858 800F1058 0C00028E */  lw         $v0, 0xC($s0)
    /* E185C 800F105C 21186400 */  addu       $v1, $v1, $a0
    /* E1860 800F1060 200003AE */  sw         $v1, 0x20($s0)
    /* E1864 800F1064 681983AF */  sw         $v1, %gp_rel(D_8013DEB4)($gp)
    /* E1868 800F1068 05004010 */  beqz       $v0, .L800F1080
    /* E186C 800F106C 00000000 */   nop
    /* E1870 800F1070 14C3030C */  jal        func_800F0C50
    /* E1874 800F1074 21200002 */   addu      $a0, $s0, $zero
    /* E1878 800F1078 43C40308 */  j          .L800F110C
    /* E187C 800F107C 00000000 */   nop
  .L800F1080:
    /* E1880 800F1080 4419838F */  lw         $v1, %gp_rel(D_8013DE90)($gp)
    /* E1884 800F1084 00000000 */  nop
    /* E1888 800F1088 2A108300 */  slt        $v0, $a0, $v1
    /* E188C 800F108C 05004010 */  beqz       $v0, .L800F10A4
    /* E1890 800F1090 00000000 */   nop
    /* E1894 800F1094 3AC3030C */  jal        func_800F0CE8
    /* E1898 800F1098 21200002 */   addu      $a0, $s0, $zero
    /* E189C 800F109C 43C40308 */  j          .L800F110C
    /* E18A0 800F10A0 00000000 */   nop
  .L800F10A4:
    /* E18A4 800F10A4 2400028E */  lw         $v0, 0x24($s0)
    /* E18A8 800F10A8 00000000 */  nop
    /* E18AC 800F10AC 23104400 */  subu       $v0, $v0, $a0
    /* E18B0 800F10B0 240002AE */  sw         $v0, 0x24($s0)
    /* E18B4 800F10B4 2800028E */  lw         $v0, 0x28($s0)
    /* E18B8 800F10B8 2400078E */  lw         $a3, 0x24($s0)
    /* E18BC 800F10BC 21104400 */  addu       $v0, $v0, $a0
    /* E18C0 800F10C0 280002AE */  sw         $v0, 0x28($s0)
    /* E18C4 800F10C4 2A106700 */  slt        $v0, $v1, $a3
    /* E18C8 800F10C8 02004010 */  beqz       $v0, .L800F10D4
    /* E18CC 800F10CC 00000000 */   nop
    /* E18D0 800F10D0 21386000 */  addu       $a3, $v1, $zero
  .L800F10D4:
    /* E18D4 800F10D4 6419848F */  lw         $a0, %gp_rel(D_8013DEB0)($gp)
    /* E18D8 800F10D8 63000224 */  addiu      $v0, $zero, 0x63
    /* E18DC 800F10DC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E18E0 800F10E0 1400B1AF */  sw         $s1, 0x14($sp)
    /* E18E4 800F10E4 2000258E */  lw         $a1, 0x20($s1)
    /* E18E8 800F10E8 2800268E */  lw         $a2, 0x28($s1)
    /* E18EC 800F10EC 3BB1030C */  jal        FILE_read
    /* E18F0 800F10F0 00000000 */   nop
    /* E18F4 800F10F4 05004010 */  beqz       $v0, .L800F110C
    /* E18F8 800F10F8 180022AE */   sw        $v0, 0x18($s1)
    /* E18FC 800F10FC 21204000 */  addu       $a0, $v0, $zero
    /* E1900 800F1100 0F80053C */  lui        $a1, %hi(func_800F1024)
    /* E1904 800F1104 93AF030C */  jal        FILE_callbackop
    /* E1908 800F1108 2410A524 */   addiu     $a1, $a1, %lo(func_800F1024)
  .L800F110C:
    /* E190C 800F110C 2000BF8F */  lw         $ra, 0x20($sp)
    /* E1910 800F1110 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E1914 800F1114 1800B08F */  lw         $s0, 0x18($sp)
    /* E1918 800F1118 0800E003 */  jr         $ra
    /* E191C 800F111C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800F1024
