.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_DoFileLoad, 0x2A8

glabel iMCRD_DoFileLoad
    /* 3FFA4 8004F7A4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 3FFA8 8004F7A8 0580023C */  lui        $v0, %hi(D_80052FC8)
    /* 3FFAC 8004F7AC 2800B2AF */  sw         $s2, 0x28($sp)
    /* 3FFB0 8004F7B0 C82F5224 */  addiu      $s2, $v0, %lo(D_80052FC8)
    /* 3FFB4 8004F7B4 4000BFAF */  sw         $ra, 0x40($sp)
    /* 3FFB8 8004F7B8 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* 3FFBC 8004F7BC 3800B6AF */  sw         $s6, 0x38($sp)
    /* 3FFC0 8004F7C0 3400B5AF */  sw         $s5, 0x34($sp)
    /* 3FFC4 8004F7C4 3000B4AF */  sw         $s4, 0x30($sp)
    /* 3FFC8 8004F7C8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 3FFCC 8004F7CC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 3FFD0 8004F7D0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 3FFD4 8004F7D4 1C00428E */  lw         $v0, 0x1C($s2)
    /* 3FFD8 8004F7D8 00000000 */  nop
    /* 3FFDC 8004F7DC 05004014 */  bnez       $v0, .L8004F7F4
    /* 3FFE0 8004F7E0 21B88000 */   addu      $s7, $a0, $zero
    /* 3FFE4 8004F7E4 3002428E */  lw         $v0, 0x230($s2)
    /* 3FFE8 8004F7E8 00000000 */  nop
    /* 3FFEC 8004F7EC 6A004010 */  beqz       $v0, .L8004F998
    /* 3FFF0 8004F7F0 00000000 */   nop
  .L8004F7F4:
    /* 3FFF4 8004F7F4 04004526 */  addiu      $a1, $s2, 0x4
    /* 3FFF8 8004F7F8 2C004626 */  addiu      $a2, $s2, 0x2C
    /* 3FFFC 8004F7FC 21380000 */  addu       $a3, $zero, $zero
    /* 40000 8004F800 A0FD4226 */  addiu      $v0, $s2, -0x260
    /* 40004 8004F804 21804000 */  addu       $s0, $v0, $zero
    /* 40008 8004F808 3C00048E */  lw         $a0, 0x3C($s0)
    /* 4000C 8004F80C 00020224 */  addiu      $v0, $zero, 0x200
    /* 40010 8004F810 12ED030C */  jal        MemCardReadFile
    /* 40014 8004F814 1000A2AF */   sw        $v0, 0x10($sp)
    /* 40018 8004F818 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 4001C 8004F81C 01000424 */  addiu      $a0, $zero, 0x1
  .L8004F820:
    /* 40020 8004F820 1800A527 */  addiu      $a1, $sp, 0x18
    /* 40024 8004F824 BFEE030C */  jal        MemCardSync
    /* 40028 8004F828 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* 4002C 8004F82C 09004014 */  bnez       $v0, .L8004F854
    /* 40030 8004F830 03000424 */   addiu     $a0, $zero, 0x3
    /* 40034 8004F834 2800028E */  lw         $v0, 0x28($s0)
    /* 40038 8004F838 00000000 */  nop
    /* 4003C 8004F83C 09F84000 */  jalr       $v0
    /* 40040 8004F840 00000000 */   nop
    /* 40044 8004F844 C7C8030C */  jal        VSync
    /* 40048 8004F848 21200000 */   addu      $a0, $zero, $zero
    /* 4004C 8004F84C 083E0108 */  j          .L8004F820
    /* 40050 8004F850 01000424 */   addiu     $a0, $zero, 0x1
  .L8004F854:
    /* 40054 8004F854 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 40058 8004F858 3341010C */  jal        iMCRD_HandleError
    /* 4005C 8004F85C 2130E002 */   addu      $a2, $s7, $zero
    /* 40060 8004F860 6F004014 */  bnez       $v0, .L8004FA20
    /* 40064 8004F864 00000000 */   nop
    /* 40068 8004F868 1C00428E */  lw         $v0, 0x1C($s2)
    /* 4006C 8004F86C 00000000 */  nop
    /* 40070 8004F870 0E004010 */  beqz       $v0, .L8004F8AC
    /* 40074 8004F874 21880000 */   addu      $s1, $zero, $zero
    /* 40078 8004F878 21804002 */  addu       $s0, $s2, $zero
  .L8004F87C:
    /* 4007C 8004F87C 30000486 */  lh         $a0, 0x30($s0)
    /* 40080 8004F880 0442010C */  jal        func_80050810
    /* 40084 8004F884 00000000 */   nop
    /* 40088 8004F888 1C00438E */  lw         $v1, 0x1C($s2)
    /* 4008C 8004F88C 00000000 */  nop
    /* 40090 8004F890 21187100 */  addu       $v1, $v1, $s1
    /* 40094 8004F894 000062A0 */  sb         $v0, 0x0($v1)
    /* 40098 8004F898 FF004230 */  andi       $v0, $v0, 0xFF
    /* 4009C 8004F89C 03004010 */  beqz       $v0, .L8004F8AC
    /* 400A0 8004F8A0 02001026 */   addiu     $s0, $s0, 0x2
    /* 400A4 8004F8A4 1F3E0108 */  j          .L8004F87C
    /* 400A8 8004F8A8 01003126 */   addiu     $s1, $s1, 0x1
  .L8004F8AC:
    /* 400AC 8004F8AC 21880000 */  addu       $s1, $zero, $zero
    /* 400B0 8004F8B0 01001624 */  addiu      $s6, $zero, 0x1
    /* 400B4 8004F8B4 10001424 */  addiu      $s4, $zero, 0x10
    /* 400B8 8004F8B8 00F0133C */  lui        $s3, (0xF000FFFF >> 16)
    /* 400BC 8004F8BC FFFF7336 */  ori        $s3, $s3, (0xF000FFFF & 0xFFFF)
    /* 400C0 8004F8C0 00F01524 */  addiu      $s5, $zero, -0x1000
    /* 400C4 8004F8C4 80101100 */  sll        $v0, $s1, 2
  .L8004F8C8:
    /* 400C8 8004F8C8 21104202 */  addu       $v0, $s2, $v0
    /* 400CC 8004F8CC 3002508C */  lw         $s0, 0x230($v0)
    /* 400D0 8004F8D0 00000000 */  nop
    /* 400D4 8004F8D4 30000012 */  beqz       $s0, .L8004F998
    /* 400D8 8004F8D8 00000000 */   nop
    /* 400DC 8004F8DC 06002012 */  beqz       $s1, .L8004F8F8
    /* 400E0 8004F8E0 AC004426 */   addiu     $a0, $s2, 0xAC
    /* 400E4 8004F8E4 03003616 */  bne        $s1, $s6, .L8004F8F4
    /* 400E8 8004F8E8 00000000 */   nop
    /* 400EC 8004F8EC 3E3E0108 */  j          .L8004F8F8
    /* 400F0 8004F8F0 2C014426 */   addiu     $a0, $s2, 0x12C
  .L8004F8F4:
    /* 400F4 8004F8F4 AC014426 */  addiu      $a0, $s2, 0x1AC
  .L8004F8F8:
    /* 400F8 8004F8F8 10000526 */  addiu      $a1, $s0, 0x10
    /* 400FC 8004F8FC B798030C */  jal        blockmove
    /* 40100 8004F900 80000624 */   addiu     $a2, $zero, 0x80
    /* 40104 8004F904 A5F0030C */  jal        shapetype
    /* 40108 8004F908 04000424 */   addiu     $a0, $zero, 0x4
    /* 4010C 8004F90C 8C004426 */  addiu      $a0, $s2, 0x8C
    /* 40110 8004F910 000002A2 */  sb         $v0, 0x0($s0)
    /* 40114 8004F914 FF004330 */  andi       $v1, $v0, 0xFF
    /* 40118 8004F918 20000624 */  addiu      $a2, $zero, 0x20
    /* 4011C 8004F91C 0C00028E */  lw         $v0, 0xC($s0)
    /* 40120 8004F920 00906334 */  ori        $v1, $v1, 0x9000
    /* 40124 8004F924 000003AE */  sw         $v1, 0x0($s0)
    /* 40128 8004F928 031A0300 */  sra        $v1, $v1, 8
    /* 4012C 8004F92C 060014A6 */  sh         $s4, 0x6($s0)
    /* 40130 8004F930 040014A6 */  sh         $s4, 0x4($s0)
    /* 40134 8004F934 0A0000A6 */  sh         $zero, 0xA($s0)
    /* 40138 8004F938 080000A6 */  sh         $zero, 0x8($s0)
    /* 4013C 8004F93C 24105300 */  and        $v0, $v0, $s3
    /* 40140 8004F940 24105500 */  and        $v0, $v0, $s5
    /* 40144 8004F944 0C0002AE */  sw         $v0, 0xC($s0)
    /* 40148 8004F948 21800302 */  addu       $s0, $s0, $v1
    /* 4014C 8004F94C B798030C */  jal        blockmove
    /* 40150 8004F950 10000526 */   addiu     $a1, $s0, 0x10
    /* 40154 8004F954 94F0030C */  jal        cluttype
    /* 40158 8004F958 10000424 */   addiu     $a0, $zero, 0x10
    /* 4015C 8004F95C 000002A2 */  sb         $v0, 0x0($s0)
    /* 40160 8004F960 FF004330 */  andi       $v1, $v0, 0xFF
    /* 40164 8004F964 0C00028E */  lw         $v0, 0xC($s0)
    /* 40168 8004F968 01003126 */  addiu      $s1, $s1, 0x1
    /* 4016C 8004F96C 040014A6 */  sh         $s4, 0x4($s0)
    /* 40170 8004F970 060016A6 */  sh         $s6, 0x6($s0)
    /* 40174 8004F974 0A0000A6 */  sh         $zero, 0xA($s0)
    /* 40178 8004F978 080000A6 */  sh         $zero, 0x8($s0)
    /* 4017C 8004F97C 000003AE */  sw         $v1, 0x0($s0)
    /* 40180 8004F980 24105300 */  and        $v0, $v0, $s3
    /* 40184 8004F984 24105500 */  and        $v0, $v0, $s5
    /* 40188 8004F988 0C0002AE */  sw         $v0, 0xC($s0)
    /* 4018C 8004F98C 0300222A */  slti       $v0, $s1, 0x3
    /* 40190 8004F990 CDFF4014 */  bnez       $v0, .L8004F8C8
    /* 40194 8004F994 80101100 */   sll       $v0, $s1, 2
  .L8004F998:
    /* 40198 8004F998 2000438E */  lw         $v1, 0x20($s2)
    /* 4019C 8004F99C 00000000 */  nop
    /* 401A0 8004F9A0 1B006010 */  beqz       $v1, .L8004FA10
    /* 401A4 8004F9A4 0580023C */   lui       $v0, %hi(gMemCardInfo)
    /* 401A8 8004F9A8 682D5024 */  addiu      $s0, $v0, %lo(gMemCardInfo)
    /* 401AC 8004F9AC 3C00048E */  lw         $a0, 0x3C($s0)
    /* 401B0 8004F9B0 2C02468E */  lw         $a2, 0x22C($s2)
    /* 401B4 8004F9B4 2400478E */  lw         $a3, 0x24($s2)
    /* 401B8 8004F9B8 04004526 */  addiu      $a1, $s2, 0x4
    /* 401BC 8004F9BC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 401C0 8004F9C0 12ED030C */  jal        MemCardReadFile
    /* 401C4 8004F9C4 0002E724 */   addiu     $a3, $a3, 0x200
    /* 401C8 8004F9C8 05004014 */  bnez       $v0, .L8004F9E0
    /* 401CC 8004F9CC 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 401D0 8004F9D0 01000224 */  addiu      $v0, $zero, 0x1
    /* 401D4 8004F9D4 340002AE */  sw         $v0, 0x34($s0)
    /* 401D8 8004F9D8 883E0108 */  j          .L8004FA20
    /* 401DC 8004F9DC 10000224 */   addiu     $v0, $zero, 0x10
  .L8004F9E0:
    /* 401E0 8004F9E0 21200000 */  addu       $a0, $zero, $zero
  .L8004F9E4:
    /* 401E4 8004F9E4 1800A527 */  addiu      $a1, $sp, 0x18
    /* 401E8 8004F9E8 BFEE030C */  jal        MemCardSync
    /* 401EC 8004F9EC 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* 401F0 8004F9F0 FCFF4010 */  beqz       $v0, .L8004F9E4
    /* 401F4 8004F9F4 21200000 */   addu      $a0, $zero, $zero
    /* 401F8 8004F9F8 03000424 */  addiu      $a0, $zero, 0x3
    /* 401FC 8004F9FC 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 40200 8004FA00 3341010C */  jal        iMCRD_HandleError
    /* 40204 8004FA04 2130E002 */   addu      $a2, $s7, $zero
    /* 40208 8004FA08 05004014 */  bnez       $v0, .L8004FA20
    /* 4020C 8004FA0C 00000000 */   nop
  .L8004FA10:
    /* 40210 8004FA10 0580033C */  lui        $v1, %hi(D_80052D9C)
    /* 40214 8004FA14 01000224 */  addiu      $v0, $zero, 0x1
    /* 40218 8004FA18 9C2D62AC */  sw         $v0, %lo(D_80052D9C)($v1)
    /* 4021C 8004FA1C 0F000224 */  addiu      $v0, $zero, 0xF
  .L8004FA20:
    /* 40220 8004FA20 4000BF8F */  lw         $ra, 0x40($sp)
    /* 40224 8004FA24 3C00B78F */  lw         $s7, 0x3C($sp)
    /* 40228 8004FA28 3800B68F */  lw         $s6, 0x38($sp)
    /* 4022C 8004FA2C 3400B58F */  lw         $s5, 0x34($sp)
    /* 40230 8004FA30 3000B48F */  lw         $s4, 0x30($sp)
    /* 40234 8004FA34 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 40238 8004FA38 2800B28F */  lw         $s2, 0x28($sp)
    /* 4023C 8004FA3C 2400B18F */  lw         $s1, 0x24($sp)
    /* 40240 8004FA40 2000B08F */  lw         $s0, 0x20($sp)
    /* 40244 8004FA44 0800E003 */  jr         $ra
    /* 40248 8004FA48 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iMCRD_DoFileLoad
