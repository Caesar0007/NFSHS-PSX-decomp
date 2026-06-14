.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_NormalizeVector__FP8coorddef, 0x1B8

glabel Math_NormalizeVector__FP8coorddef
    /* 8E21C 8009DA1C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8E220 8009DA20 2400B5AF */  sw         $s5, 0x24($sp)
    /* 8E224 8009DA24 21A88000 */  addu       $s5, $a0, $zero
    /* 8E228 8009DA28 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 8E22C 8009DA2C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 8E230 8009DA30 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8E234 8009DA34 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8E238 8009DA38 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8E23C 8009DA3C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8E240 8009DA40 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8E244 8009DA44 0000B08E */  lw         $s0, 0x0($s5)
    /* 8E248 8009DA48 0400B18E */  lw         $s1, 0x4($s5)
    /* 8E24C 8009DA4C 0800B28E */  lw         $s2, 0x8($s5)
    /* 8E250 8009DA50 02000106 */  bgez       $s0, .L8009DA5C
    /* 8E254 8009DA54 21100002 */   addu      $v0, $s0, $zero
    /* 8E258 8009DA58 23100200 */  negu       $v0, $v0
  .L8009DA5C:
    /* 8E25C 8009DA5C A0760208 */  j          .L8009DA80
    /* 8E260 8009DA60 0001033C */   lui       $v1, (0x1000000 >> 16)
  .L8009DA64:
    /* 8E264 8009DA64 43801000 */  sra        $s0, $s0, 1
    /* 8E268 8009DA68 43881100 */  sra        $s1, $s1, 1
    /* 8E26C 8009DA6C 43901200 */  sra        $s2, $s2, 1
    /* 8E270 8009DA70 02000106 */  bgez       $s0, .L8009DA7C
    /* 8E274 8009DA74 21100002 */   addu      $v0, $s0, $zero
    /* 8E278 8009DA78 23100200 */  negu       $v0, $v0
  .L8009DA7C:
    /* 8E27C 8009DA7C 0001033C */  lui        $v1, (0x1000000 >> 16)
  .L8009DA80:
    /* 8E280 8009DA80 2A106200 */  slt        $v0, $v1, $v0
    /* 8E284 8009DA84 F7FF4014 */  bnez       $v0, .L8009DA64
    /* 8E288 8009DA88 00000000 */   nop
    /* 8E28C 8009DA8C 02002106 */  bgez       $s1, .L8009DA98
    /* 8E290 8009DA90 21102002 */   addu      $v0, $s1, $zero
    /* 8E294 8009DA94 23100200 */  negu       $v0, $v0
  .L8009DA98:
    /* 8E298 8009DA98 2A106200 */  slt        $v0, $v1, $v0
    /* 8E29C 8009DA9C F1FF4014 */  bnez       $v0, .L8009DA64
    /* 8E2A0 8009DAA0 00000000 */   nop
    /* 8E2A4 8009DAA4 02004106 */  bgez       $s2, .L8009DAB0
    /* 8E2A8 8009DAA8 21104002 */   addu      $v0, $s2, $zero
    /* 8E2AC 8009DAAC 23100200 */  negu       $v0, $v0
  .L8009DAB0:
    /* 8E2B0 8009DAB0 2A106200 */  slt        $v0, $v1, $v0
    /* 8E2B4 8009DAB4 EBFF4014 */  bnez       $v0, .L8009DA64
    /* 8E2B8 8009DAB8 21200002 */   addu      $a0, $s0, $zero
    /* 8E2BC 8009DABC CA90030C */  jal        fixedmult
    /* 8E2C0 8009DAC0 21280002 */   addu      $a1, $s0, $zero
    /* 8E2C4 8009DAC4 21A04000 */  addu       $s4, $v0, $zero
    /* 8E2C8 8009DAC8 21202002 */  addu       $a0, $s1, $zero
    /* 8E2CC 8009DACC CA90030C */  jal        fixedmult
    /* 8E2D0 8009DAD0 21282002 */   addu      $a1, $s1, $zero
    /* 8E2D4 8009DAD4 21984000 */  addu       $s3, $v0, $zero
    /* 8E2D8 8009DAD8 21204002 */  addu       $a0, $s2, $zero
    /* 8E2DC 8009DADC CA90030C */  jal        fixedmult
    /* 8E2E0 8009DAE0 21284002 */   addu      $a1, $s2, $zero
    /* 8E2E4 8009DAE4 21304000 */  addu       $a2, $v0, $zero
    /* 8E2E8 8009DAE8 82101400 */  srl        $v0, $s4, 2
    /* 8E2EC 8009DAEC 82201300 */  srl        $a0, $s3, 2
    /* 8E2F0 8009DAF0 82280600 */  srl        $a1, $a2, 2
    /* 8E2F4 8009DAF4 21184400 */  addu       $v1, $v0, $a0
    /* 8E2F8 8009DAF8 21186500 */  addu       $v1, $v1, $a1
    /* 8E2FC 8009DAFC 0040023C */  lui        $v0, (0x40000000 >> 16)
    /* 8E300 8009DB00 2B104300 */  sltu       $v0, $v0, $v1
    /* 8E304 8009DB04 18004010 */  beqz       $v0, .L8009DB68
    /* 8E308 8009DB08 0040163C */   lui       $s6, (0x40000000 >> 16)
  .L8009DB0C:
    /* 8E30C 8009DB0C 43801000 */  sra        $s0, $s0, 1
    /* 8E310 8009DB10 43881100 */  sra        $s1, $s1, 1
    /* 8E314 8009DB14 43901200 */  sra        $s2, $s2, 1
    /* 8E318 8009DB18 21200002 */  addu       $a0, $s0, $zero
    /* 8E31C 8009DB1C CA90030C */  jal        fixedmult
    /* 8E320 8009DB20 21280002 */   addu      $a1, $s0, $zero
    /* 8E324 8009DB24 21A04000 */  addu       $s4, $v0, $zero
    /* 8E328 8009DB28 21202002 */  addu       $a0, $s1, $zero
    /* 8E32C 8009DB2C CA90030C */  jal        fixedmult
    /* 8E330 8009DB30 21282002 */   addu      $a1, $s1, $zero
    /* 8E334 8009DB34 21984000 */  addu       $s3, $v0, $zero
    /* 8E338 8009DB38 21204002 */  addu       $a0, $s2, $zero
    /* 8E33C 8009DB3C CA90030C */  jal        fixedmult
    /* 8E340 8009DB40 21284002 */   addu      $a1, $s2, $zero
    /* 8E344 8009DB44 21304000 */  addu       $a2, $v0, $zero
    /* 8E348 8009DB48 82101400 */  srl        $v0, $s4, 2
    /* 8E34C 8009DB4C 82201300 */  srl        $a0, $s3, 2
    /* 8E350 8009DB50 82280600 */  srl        $a1, $a2, 2
    /* 8E354 8009DB54 21104400 */  addu       $v0, $v0, $a0
    /* 8E358 8009DB58 21104500 */  addu       $v0, $v0, $a1
    /* 8E35C 8009DB5C 2B10C202 */  sltu       $v0, $s6, $v0
    /* 8E360 8009DB60 EAFF4014 */  bnez       $v0, .L8009DB0C
    /* 8E364 8009DB64 00000000 */   nop
  .L8009DB68:
    /* 8E368 8009DB68 21209302 */  addu       $a0, $s4, $s3
    /* 8E36C 8009DB6C 2BAC030C */  jal        fixedsqrt
    /* 8E370 8009DB70 21208600 */   addu      $a0, $a0, $a2
    /* 8E374 8009DB74 21984000 */  addu       $s3, $v0, $zero
    /* 8E378 8009DB78 0C006012 */  beqz       $s3, .L8009DBAC
    /* 8E37C 8009DB7C 21200002 */   addu      $a0, $s0, $zero
    /* 8E380 8009DB80 0191030C */  jal        rdiv
    /* 8E384 8009DB84 21286002 */   addu      $a1, $s3, $zero
    /* 8E388 8009DB88 21202002 */  addu       $a0, $s1, $zero
    /* 8E38C 8009DB8C 21286002 */  addu       $a1, $s3, $zero
    /* 8E390 8009DB90 0191030C */  jal        rdiv
    /* 8E394 8009DB94 0000A2AE */   sw        $v0, 0x0($s5)
    /* 8E398 8009DB98 21204002 */  addu       $a0, $s2, $zero
    /* 8E39C 8009DB9C 21286002 */  addu       $a1, $s3, $zero
    /* 8E3A0 8009DBA0 0191030C */  jal        rdiv
    /* 8E3A4 8009DBA4 0400A2AE */   sw        $v0, 0x4($s5)
    /* 8E3A8 8009DBA8 0800A2AE */  sw         $v0, 0x8($s5)
  .L8009DBAC:
    /* 8E3AC 8009DBAC 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 8E3B0 8009DBB0 2800B68F */  lw         $s6, 0x28($sp)
    /* 8E3B4 8009DBB4 2400B58F */  lw         $s5, 0x24($sp)
    /* 8E3B8 8009DBB8 2000B48F */  lw         $s4, 0x20($sp)
    /* 8E3BC 8009DBBC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8E3C0 8009DBC0 1800B28F */  lw         $s2, 0x18($sp)
    /* 8E3C4 8009DBC4 1400B18F */  lw         $s1, 0x14($sp)
    /* 8E3C8 8009DBC8 1000B08F */  lw         $s0, 0x10($sp)
    /* 8E3CC 8009DBCC 0800E003 */  jr         $ra
    /* 8E3D0 8009DBD0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Math_NormalizeVector__FP8coorddef
