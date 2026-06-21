.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_addbig, 0x128

glabel FILE_addbig
    /* DD058 800EC858 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DD05C 800EC85C 1480023C */  lui        $v0, %hi(D_8013EAAC)
    /* DD060 800EC860 1400B1AF */  sw         $s1, 0x14($sp)
    /* DD064 800EC864 ACEA518C */  lw         $s1, %lo(D_8013EAAC)($v0)
    /* DD068 800EC868 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DD06C 800EC86C 21988000 */  addu       $s3, $a0, $zero
    /* DD070 800EC870 2400B5AF */  sw         $s5, 0x24($sp)
    /* DD074 800EC874 21A8A000 */  addu       $s5, $a1, $zero
    /* DD078 800EC878 2000B4AF */  sw         $s4, 0x20($sp)
    /* DD07C 800EC87C 21A0C000 */  addu       $s4, $a2, $zero
    /* DD080 800EC880 1000B0AF */  sw         $s0, 0x10($sp)
    /* DD084 800EC884 2180E000 */  addu       $s0, $a3, $zero
    /* DD088 800EC888 2800BFAF */  sw         $ra, 0x28($sp)
    /* DD08C 800EC88C 37B4030C */  jal        reserveop
    /* DD090 800EC890 1800B2AF */   sw        $s2, 0x18($sp)
    /* DD094 800EC894 0FFF053C */  lui        $a1, (0xFF0FFFFF >> 16)
    /* DD098 800EC898 FFFFA534 */  ori        $a1, $a1, (0xFF0FFFFF & 0xFFFF)
    /* DD09C 800EC89C 21904000 */  addu       $s2, $v0, $zero
    /* DD0A0 800EC8A0 21200000 */  addu       $a0, $zero, $zero
    /* DD0A4 800EC8A4 0000438E */  lw         $v1, 0x0($s2)
    /* DD0A8 800EC8A8 9000023C */  lui        $v0, (0x900000 >> 16)
    /* DD0AC 800EC8AC 140050AE */  sw         $s0, 0x14($s2)
    /* DD0B0 800EC8B0 100054AE */  sw         $s4, 0x10($s2)
    /* DD0B4 800EC8B4 24186500 */  and        $v1, $v1, $a1
    /* DD0B8 800EC8B8 25186200 */  or         $v1, $v1, $v0
    /* DD0BC 800EC8BC 02F9030C */  jal        iscurrentthread
    /* DD0C0 800EC8C0 000043AE */   sw        $v1, 0x0($s2)
    /* DD0C4 800EC8C4 10002012 */  beqz       $s1, .L800EC908
    /* DD0C8 800EC8C8 21206002 */   addu      $a0, $s3, $zero
  .L800EC8CC:
    /* DD0CC 800EC8CC 0400258E */  lw         $a1, 0x4($s1)
    /* DD0D0 800EC8D0 40000624 */  addiu      $a2, $zero, 0x40
    /* DD0D4 800EC8D4 74AC030C */  jal        strncmp
    /* DD0D8 800EC8D8 0C00A524 */   addiu     $a1, $a1, 0xC
    /* DD0DC 800EC8DC 06004014 */  bnez       $v0, .L800EC8F8
    /* DD0E0 800EC8E0 21204002 */   addu      $a0, $s2, $zero
    /* DD0E4 800EC8E4 0400228E */  lw         $v0, 0x4($s1)
    /* DD0E8 800EC8E8 E6B2030C */  jal        iFILE_ExecCommand
    /* DD0EC 800EC8EC 240042AE */   sw        $v0, 0x24($s2)
    /* DD0F0 800EC8F0 57B20308 */  j          .L800EC95C
    /* DD0F4 800EC8F4 21104002 */   addu      $v0, $s2, $zero
  .L800EC8F8:
    /* DD0F8 800EC8F8 0C00318E */  lw         $s1, 0xC($s1)
    /* DD0FC 800EC8FC 00000000 */  nop
    /* DD100 800EC900 F2FF2016 */  bnez       $s1, .L800EC8CC
    /* DD104 800EC904 21206002 */   addu      $a0, $s3, $zero
  .L800EC908:
    /* DD108 800EC908 10000524 */  addiu      $a1, $zero, 0x10
    /* DD10C 800EC90C CF94030C */  jal        reservememadr
    /* DD110 800EC910 2130A002 */   addu      $a2, $s5, $zero
    /* DD114 800EC914 21884000 */  addu       $s1, $v0, $zero
    /* DD118 800EC918 0580043C */  lui        $a0, %hi(D_80056C5C)
    /* DD11C 800EC91C 5C6C8424 */  addiu      $a0, $a0, %lo(D_80056C5C)
    /* DD120 800EC920 00080524 */  addiu      $a1, $zero, 0x800
    /* DD124 800EC924 10000624 */  addiu      $a2, $zero, 0x10
    /* DD128 800EC928 CF94030C */  jal        reservememadr
    /* DD12C 800EC92C 080032AE */   sw        $s2, 0x8($s1)
    /* DD130 800EC930 21206002 */  addu       $a0, $s3, $zero
    /* DD134 800EC934 01000524 */  addiu      $a1, $zero, 0x1
    /* DD138 800EC938 21308002 */  addu       $a2, $s4, $zero
    /* DD13C 800EC93C 21382002 */  addu       $a3, $s1, $zero
    /* DD140 800EC940 DBB0030C */  jal        FILE_open
    /* DD144 800EC944 000022AE */   sw        $v0, 0x0($s1)
    /* DD148 800EC948 21204000 */  addu       $a0, $v0, $zero
    /* DD14C 800EC94C 0F80053C */  lui        $a1, %hi(iFILE_addbigopencallback)
    /* DD150 800EC950 93AF030C */  jal        FILE_callbackop
    /* DD154 800EC954 A0C7A524 */   addiu     $a1, $a1, %lo(iFILE_addbigopencallback)
    /* DD158 800EC958 0000428E */  lw         $v0, 0x0($s2)
  .L800EC95C:
    /* DD15C 800EC95C 2800BF8F */  lw         $ra, 0x28($sp)
    /* DD160 800EC960 2400B58F */  lw         $s5, 0x24($sp)
    /* DD164 800EC964 2000B48F */  lw         $s4, 0x20($sp)
    /* DD168 800EC968 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DD16C 800EC96C 1800B28F */  lw         $s2, 0x18($sp)
    /* DD170 800EC970 1400B18F */  lw         $s1, 0x14($sp)
    /* DD174 800EC974 1000B08F */  lw         $s0, 0x10($sp)
    /* DD178 800EC978 0800E003 */  jr         $ra
    /* DD17C 800EC97C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FILE_addbig
