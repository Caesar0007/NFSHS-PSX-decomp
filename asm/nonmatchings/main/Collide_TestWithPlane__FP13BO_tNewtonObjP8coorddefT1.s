.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1, 0xC2C

glabel Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
    /* 7E1A8 8008D9A8 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 7E1AC 8008D9AC 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 7E1B0 8008D9B0 21988000 */  addu       $s3, $a0, $zero
    /* 7E1B4 8008D9B4 7800B2AF */  sw         $s2, 0x78($sp)
    /* 7E1B8 8008D9B8 2190A000 */  addu       $s2, $a1, $zero
    /* 7E1BC 8008D9BC 7000B0AF */  sw         $s0, 0x70($sp)
    /* 7E1C0 8008D9C0 2180C000 */  addu       $s0, $a2, $zero
    /* 7E1C4 8008D9C4 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 7E1C8 8008D9C8 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* 7E1CC 8008D9CC 8800B6AF */  sw         $s6, 0x88($sp)
    /* 7E1D0 8008D9D0 8400B5AF */  sw         $s5, 0x84($sp)
    /* 7E1D4 8008D9D4 8000B4AF */  sw         $s4, 0x80($sp)
    /* 7E1D8 8008D9D8 7400B1AF */  sw         $s1, 0x74($sp)
    /* 7E1DC 8008D9DC 1401658E */  lw         $a1, 0x114($s3)
    /* 7E1E0 8008D9E0 CA90030C */  jal        fixedmult
    /* 7E1E4 8008D9E4 7E488434 */   ori       $a0, $a0, (0x6487E & 0xFFFF)
    /* 7E1E8 8008D9E8 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 7E1EC 8008D9EC 1801658E */  lw         $a1, 0x118($s3)
    /* 7E1F0 8008D9F0 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 7E1F4 8008D9F4 CA90030C */  jal        fixedmult
    /* 7E1F8 8008D9F8 140162AE */   sw        $v0, 0x114($s3)
    /* 7E1FC 8008D9FC 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 7E200 8008DA00 1C01658E */  lw         $a1, 0x11C($s3)
    /* 7E204 8008DA04 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 7E208 8008DA08 CA90030C */  jal        fixedmult
    /* 7E20C 8008DA0C 180162AE */   sw        $v0, 0x118($s3)
    /* 7E210 8008DA10 1C0162AE */  sw         $v0, 0x11C($s3)
    /* 7E214 8008DA14 0000428E */  lw         $v0, 0x0($s2)
    /* 7E218 8008DA18 00000000 */  nop
    /* 7E21C 8008DA1C 0A004014 */  bnez       $v0, .L8008DA48
    /* 7E220 8008DA20 21880000 */   addu      $s1, $zero, $zero
    /* 7E224 8008DA24 0400428E */  lw         $v0, 0x4($s2)
    /* 7E228 8008DA28 00000000 */  nop
    /* 7E22C 8008DA2C 06004014 */  bnez       $v0, .L8008DA48
    /* 7E230 8008DA30 00000000 */   nop
    /* 7E234 8008DA34 0800428E */  lw         $v0, 0x8($s2)
    /* 7E238 8008DA38 00000000 */  nop
    /* 7E23C 8008DA3C 02004014 */  bnez       $v0, .L8008DA48
    /* 7E240 8008DA40 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 7E244 8008DA44 040042AE */  sw         $v0, 0x4($s2)
  .L8008DA48:
    /* 7E248 8008DA48 0000438E */  lw         $v1, 0x0($s2)
    /* 7E24C 8008DA4C 00000000 */  nop
    /* 7E250 8008DA50 02006104 */  bgez       $v1, .L8008DA5C
    /* 7E254 8008DA54 00000000 */   nop
    /* 7E258 8008DA58 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DA5C:
    /* 7E25C 8008DA5C F000628E */  lw         $v0, 0xF0($s3)
    /* 7E260 8008DA60 00000000 */  nop
    /* 7E264 8008DA64 02004104 */  bgez       $v0, .L8008DA70
    /* 7E268 8008DA68 03220300 */   sra       $a0, $v1, 8
    /* 7E26C 8008DA6C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DA70:
    /* 7E270 8008DA70 03120200 */  sra        $v0, $v0, 8
    /* 7E274 8008DA74 18008200 */  mult       $a0, $v0
    /* 7E278 8008DA78 0400438E */  lw         $v1, 0x4($s2)
    /* 7E27C 8008DA7C 12200000 */  mflo       $a0
    /* 7E280 8008DA80 02006104 */  bgez       $v1, .L8008DA8C
    /* 7E284 8008DA84 00000000 */   nop
    /* 7E288 8008DA88 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DA8C:
    /* 7E28C 8008DA8C F400628E */  lw         $v0, 0xF4($s3)
    /* 7E290 8008DA90 00000000 */  nop
    /* 7E294 8008DA94 02004104 */  bgez       $v0, .L8008DAA0
    /* 7E298 8008DA98 031A0300 */   sra       $v1, $v1, 8
    /* 7E29C 8008DA9C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DAA0:
    /* 7E2A0 8008DAA0 03120200 */  sra        $v0, $v0, 8
    /* 7E2A4 8008DAA4 18006200 */  mult       $v1, $v0
    /* 7E2A8 8008DAA8 0800438E */  lw         $v1, 0x8($s2)
    /* 7E2AC 8008DAAC 12680000 */  mflo       $t5
    /* 7E2B0 8008DAB0 02006104 */  bgez       $v1, .L8008DABC
    /* 7E2B4 8008DAB4 21208D00 */   addu      $a0, $a0, $t5
    /* 7E2B8 8008DAB8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DABC:
    /* 7E2BC 8008DABC F800628E */  lw         $v0, 0xF8($s3)
    /* 7E2C0 8008DAC0 00000000 */  nop
    /* 7E2C4 8008DAC4 02004104 */  bgez       $v0, .L8008DAD0
    /* 7E2C8 8008DAC8 031A0300 */   sra       $v1, $v1, 8
    /* 7E2CC 8008DACC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DAD0:
    /* 7E2D0 8008DAD0 03120200 */  sra        $v0, $v0, 8
    /* 7E2D4 8008DAD4 18006200 */  mult       $v1, $v0
    /* 7E2D8 8008DAD8 12680000 */  mflo       $t5
    /* 7E2DC 8008DADC 21188D00 */  addu       $v1, $a0, $t5
    /* 7E2E0 8008DAE0 02006104 */  bgez       $v1, .L8008DAEC
    /* 7E2E4 8008DAE4 00000000 */   nop
    /* 7E2E8 8008DAE8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DAEC:
    /* 7E2EC 8008DAEC 3401628E */  lw         $v0, 0x134($s3)
    /* 7E2F0 8008DAF0 00000000 */  nop
    /* 7E2F4 8008DAF4 02004104 */  bgez       $v0, .L8008DB00
    /* 7E2F8 8008DAF8 031A0300 */   sra       $v1, $v1, 8
    /* 7E2FC 8008DAFC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DB00:
    /* 7E300 8008DB00 03120200 */  sra        $v0, $v0, 8
    /* 7E304 8008DB04 18006200 */  mult       $v1, $v0
    /* 7E308 8008DB08 12680000 */  mflo       $t5
    /* 7E30C 8008DB0C 1000ADAF */  sw         $t5, 0x10($sp)
    /* 7E310 8008DB10 0000438E */  lw         $v1, 0x0($s2)
    /* 7E314 8008DB14 00000000 */  nop
    /* 7E318 8008DB18 02006104 */  bgez       $v1, .L8008DB24
    /* 7E31C 8008DB1C 00000000 */   nop
    /* 7E320 8008DB20 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DB24:
    /* 7E324 8008DB24 FC00628E */  lw         $v0, 0xFC($s3)
    /* 7E328 8008DB28 00000000 */  nop
    /* 7E32C 8008DB2C 02004104 */  bgez       $v0, .L8008DB38
    /* 7E330 8008DB30 03220300 */   sra       $a0, $v1, 8
    /* 7E334 8008DB34 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DB38:
    /* 7E338 8008DB38 03120200 */  sra        $v0, $v0, 8
    /* 7E33C 8008DB3C 18008200 */  mult       $a0, $v0
    /* 7E340 8008DB40 0400438E */  lw         $v1, 0x4($s2)
    /* 7E344 8008DB44 12200000 */  mflo       $a0
    /* 7E348 8008DB48 02006104 */  bgez       $v1, .L8008DB54
    /* 7E34C 8008DB4C 00000000 */   nop
    /* 7E350 8008DB50 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DB54:
    /* 7E354 8008DB54 0001628E */  lw         $v0, 0x100($s3)
    /* 7E358 8008DB58 00000000 */  nop
    /* 7E35C 8008DB5C 02004104 */  bgez       $v0, .L8008DB68
    /* 7E360 8008DB60 031A0300 */   sra       $v1, $v1, 8
    /* 7E364 8008DB64 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DB68:
    /* 7E368 8008DB68 03120200 */  sra        $v0, $v0, 8
    /* 7E36C 8008DB6C 18006200 */  mult       $v1, $v0
    /* 7E370 8008DB70 0800438E */  lw         $v1, 0x8($s2)
    /* 7E374 8008DB74 12680000 */  mflo       $t5
    /* 7E378 8008DB78 02006104 */  bgez       $v1, .L8008DB84
    /* 7E37C 8008DB7C 21208D00 */   addu      $a0, $a0, $t5
    /* 7E380 8008DB80 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DB84:
    /* 7E384 8008DB84 0401628E */  lw         $v0, 0x104($s3)
    /* 7E388 8008DB88 00000000 */  nop
    /* 7E38C 8008DB8C 02004104 */  bgez       $v0, .L8008DB98
    /* 7E390 8008DB90 031A0300 */   sra       $v1, $v1, 8
    /* 7E394 8008DB94 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DB98:
    /* 7E398 8008DB98 03120200 */  sra        $v0, $v0, 8
    /* 7E39C 8008DB9C 18006200 */  mult       $v1, $v0
    /* 7E3A0 8008DBA0 12680000 */  mflo       $t5
    /* 7E3A4 8008DBA4 21188D00 */  addu       $v1, $a0, $t5
    /* 7E3A8 8008DBA8 02006104 */  bgez       $v1, .L8008DBB4
    /* 7E3AC 8008DBAC 00000000 */   nop
    /* 7E3B0 8008DBB0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DBB4:
    /* 7E3B4 8008DBB4 3801628E */  lw         $v0, 0x138($s3)
    /* 7E3B8 8008DBB8 00000000 */  nop
    /* 7E3BC 8008DBBC 02004104 */  bgez       $v0, .L8008DBC8
    /* 7E3C0 8008DBC0 031A0300 */   sra       $v1, $v1, 8
    /* 7E3C4 8008DBC4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DBC8:
    /* 7E3C8 8008DBC8 03120200 */  sra        $v0, $v0, 8
    /* 7E3CC 8008DBCC 18006200 */  mult       $v1, $v0
    /* 7E3D0 8008DBD0 12280000 */  mflo       $a1
    /* 7E3D4 8008DBD4 1400A5AF */  sw         $a1, 0x14($sp)
    /* 7E3D8 8008DBD8 0000438E */  lw         $v1, 0x0($s2)
    /* 7E3DC 8008DBDC 00000000 */  nop
    /* 7E3E0 8008DBE0 02006104 */  bgez       $v1, .L8008DBEC
    /* 7E3E4 8008DBE4 00000000 */   nop
    /* 7E3E8 8008DBE8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DBEC:
    /* 7E3EC 8008DBEC 0801628E */  lw         $v0, 0x108($s3)
    /* 7E3F0 8008DBF0 00000000 */  nop
    /* 7E3F4 8008DBF4 02004104 */  bgez       $v0, .L8008DC00
    /* 7E3F8 8008DBF8 03220300 */   sra       $a0, $v1, 8
    /* 7E3FC 8008DBFC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DC00:
    /* 7E400 8008DC00 03120200 */  sra        $v0, $v0, 8
    /* 7E404 8008DC04 18008200 */  mult       $a0, $v0
    /* 7E408 8008DC08 0400438E */  lw         $v1, 0x4($s2)
    /* 7E40C 8008DC0C 12200000 */  mflo       $a0
    /* 7E410 8008DC10 02006104 */  bgez       $v1, .L8008DC1C
    /* 7E414 8008DC14 00000000 */   nop
    /* 7E418 8008DC18 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DC1C:
    /* 7E41C 8008DC1C 0C01628E */  lw         $v0, 0x10C($s3)
    /* 7E420 8008DC20 00000000 */  nop
    /* 7E424 8008DC24 02004104 */  bgez       $v0, .L8008DC30
    /* 7E428 8008DC28 031A0300 */   sra       $v1, $v1, 8
    /* 7E42C 8008DC2C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DC30:
    /* 7E430 8008DC30 03120200 */  sra        $v0, $v0, 8
    /* 7E434 8008DC34 18006200 */  mult       $v1, $v0
    /* 7E438 8008DC38 0800438E */  lw         $v1, 0x8($s2)
    /* 7E43C 8008DC3C 12680000 */  mflo       $t5
    /* 7E440 8008DC40 02006104 */  bgez       $v1, .L8008DC4C
    /* 7E444 8008DC44 21208D00 */   addu      $a0, $a0, $t5
    /* 7E448 8008DC48 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DC4C:
    /* 7E44C 8008DC4C 1001628E */  lw         $v0, 0x110($s3)
    /* 7E450 8008DC50 00000000 */  nop
    /* 7E454 8008DC54 02004104 */  bgez       $v0, .L8008DC60
    /* 7E458 8008DC58 031A0300 */   sra       $v1, $v1, 8
    /* 7E45C 8008DC5C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DC60:
    /* 7E460 8008DC60 03120200 */  sra        $v0, $v0, 8
    /* 7E464 8008DC64 18006200 */  mult       $v1, $v0
    /* 7E468 8008DC68 12680000 */  mflo       $t5
    /* 7E46C 8008DC6C 21188D00 */  addu       $v1, $a0, $t5
    /* 7E470 8008DC70 02006104 */  bgez       $v1, .L8008DC7C
    /* 7E474 8008DC74 00000000 */   nop
    /* 7E478 8008DC78 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DC7C:
    /* 7E47C 8008DC7C 3C01628E */  lw         $v0, 0x13C($s3)
    /* 7E480 8008DC80 00000000 */  nop
    /* 7E484 8008DC84 02004104 */  bgez       $v0, .L8008DC90
    /* 7E488 8008DC88 031A0300 */   sra       $v1, $v1, 8
    /* 7E48C 8008DC8C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DC90:
    /* 7E490 8008DC90 03120200 */  sra        $v0, $v0, 8
    /* 7E494 8008DC94 18006200 */  mult       $v1, $v0
    /* 7E498 8008DC98 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 7E49C 8008DC9C 1000AC8F */  lw         $t4, 0x10($sp)
    /* 7E4A0 8008DCA0 12380000 */  mflo       $a3
    /* 7E4A4 8008DCA4 02008105 */  bgez       $t4, .L8008DCB0
    /* 7E4A8 8008DCA8 1800A7AF */   sw        $a3, 0x18($sp)
    /* 7E4AC 8008DCAC 01000924 */  addiu      $t1, $zero, 0x1
  .L8008DCB0:
    /* 7E4B0 8008DCB0 0200A104 */  bgez       $a1, .L8008DCBC
    /* 7E4B4 8008DCB4 FFFF0A24 */   addiu     $t2, $zero, -0x1
    /* 7E4B8 8008DCB8 01000A24 */  addiu      $t2, $zero, 0x1
  .L8008DCBC:
    /* 7E4BC 8008DCBC 0200E104 */  bgez       $a3, .L8008DCC8
    /* 7E4C0 8008DCC0 FFFF0B24 */   addiu     $t3, $zero, -0x1
    /* 7E4C4 8008DCC4 01000B24 */  addiu      $t3, $zero, 0x1
  .L8008DCC8:
    /* 7E4C8 8008DCC8 A000638E */  lw         $v1, 0xA0($s3)
    /* 7E4CC 8008DCCC 0000028E */  lw         $v0, 0x0($s0)
    /* 7E4D0 8008DCD0 00000000 */  nop
    /* 7E4D4 8008DCD4 23286200 */  subu       $a1, $v1, $v0
    /* 7E4D8 8008DCD8 2000A5AF */  sw         $a1, 0x20($sp)
    /* 7E4DC 8008DCDC A400638E */  lw         $v1, 0xA4($s3)
    /* 7E4E0 8008DCE0 0400028E */  lw         $v0, 0x4($s0)
    /* 7E4E4 8008DCE4 00000000 */  nop
    /* 7E4E8 8008DCE8 23306200 */  subu       $a2, $v1, $v0
    /* 7E4EC 8008DCEC 2400A6AF */  sw         $a2, 0x24($sp)
    /* 7E4F0 8008DCF0 A800638E */  lw         $v1, 0xA8($s3)
    /* 7E4F4 8008DCF4 0800028E */  lw         $v0, 0x8($s0)
    /* 7E4F8 8008DCF8 00000000 */  nop
    /* 7E4FC 8008DCFC 23406200 */  subu       $t0, $v1, $v0
    /* 7E500 8008DD00 2800A8AF */  sw         $t0, 0x28($sp)
    /* 7E504 8008DD04 0000448E */  lw         $a0, 0x0($s2)
    /* 7E508 8008DD08 00000000 */  nop
    /* 7E50C 8008DD0C 02008104 */  bgez       $a0, .L8008DD18
    /* 7E510 8008DD10 2110A000 */   addu      $v0, $a1, $zero
    /* 7E514 8008DD14 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008DD18:
    /* 7E518 8008DD18 02004104 */  bgez       $v0, .L8008DD24
    /* 7E51C 8008DD1C 032A0400 */   sra       $a1, $a0, 8
    /* 7E520 8008DD20 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DD24:
    /* 7E524 8008DD24 03120200 */  sra        $v0, $v0, 8
    /* 7E528 8008DD28 1800A200 */  mult       $a1, $v0
    /* 7E52C 8008DD2C 0400448E */  lw         $a0, 0x4($s2)
    /* 7E530 8008DD30 12280000 */  mflo       $a1
    /* 7E534 8008DD34 02008104 */  bgez       $a0, .L8008DD40
    /* 7E538 8008DD38 2110C000 */   addu      $v0, $a2, $zero
    /* 7E53C 8008DD3C FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008DD40:
    /* 7E540 8008DD40 02004104 */  bgez       $v0, .L8008DD4C
    /* 7E544 8008DD44 03220400 */   sra       $a0, $a0, 8
    /* 7E548 8008DD48 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DD4C:
    /* 7E54C 8008DD4C 03120200 */  sra        $v0, $v0, 8
    /* 7E550 8008DD50 18008200 */  mult       $a0, $v0
    /* 7E554 8008DD54 0800448E */  lw         $a0, 0x8($s2)
    /* 7E558 8008DD58 12680000 */  mflo       $t5
    /* 7E55C 8008DD5C 02008104 */  bgez       $a0, .L8008DD68
    /* 7E560 8008DD60 2118AD00 */   addu      $v1, $a1, $t5
    /* 7E564 8008DD64 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008DD68:
    /* 7E568 8008DD68 21100001 */  addu       $v0, $t0, $zero
    /* 7E56C 8008DD6C 02004104 */  bgez       $v0, .L8008DD78
    /* 7E570 8008DD70 03220400 */   sra       $a0, $a0, 8
    /* 7E574 8008DD74 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DD78:
    /* 7E578 8008DD78 03120200 */  sra        $v0, $v0, 8
    /* 7E57C 8008DD7C 18008200 */  mult       $a0, $v0
    /* 7E580 8008DD80 12280000 */  mflo       $a1
    /* 7E584 8008DD84 00000000 */  nop
    /* 7E588 8008DD88 00000000 */  nop
    /* 7E58C 8008DD8C 18002C01 */  mult       $t1, $t4
    /* 7E590 8008DD90 12300000 */  mflo       $a2
    /* 7E594 8008DD94 1400A28F */  lw         $v0, 0x14($sp)
    /* 7E598 8008DD98 00000000 */  nop
    /* 7E59C 8008DD9C 18004201 */  mult       $t2, $v0
    /* 7E5A0 8008DDA0 12400000 */  mflo       $t0
    /* 7E5A4 8008DDA4 00000000 */  nop
    /* 7E5A8 8008DDA8 00000000 */  nop
    /* 7E5AC 8008DDAC 18006701 */  mult       $t3, $a3
    /* 7E5B0 8008DDB0 21186500 */  addu       $v1, $v1, $a1
    /* 7E5B4 8008DDB4 2110C800 */  addu       $v0, $a2, $t0
    /* 7E5B8 8008DDB8 12200000 */  mflo       $a0
    /* 7E5BC 8008DDBC 21104400 */  addu       $v0, $v0, $a0
    /* 7E5C0 8008DDC0 21284300 */  addu       $a1, $v0, $v1
    /* 7E5C4 8008DDC4 6B01A104 */  bgez       $a1, .L8008E374
    /* 7E5C8 8008DDC8 00000000 */   nop
    /* 7E5CC 8008DDCC F000638E */  lw         $v1, 0xF0($s3)
    /* 7E5D0 8008DDD0 00000000 */  nop
    /* 7E5D4 8008DDD4 02006104 */  bgez       $v1, .L8008DDE0
    /* 7E5D8 8008DDD8 00000000 */   nop
    /* 7E5DC 8008DDDC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DDE0:
    /* 7E5E0 8008DDE0 3401628E */  lw         $v0, 0x134($s3)
    /* 7E5E4 8008DDE4 00000000 */  nop
    /* 7E5E8 8008DDE8 02004104 */  bgez       $v0, .L8008DDF4
    /* 7E5EC 8008DDEC 031A0300 */   sra       $v1, $v1, 8
    /* 7E5F0 8008DDF0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DDF4:
    /* 7E5F4 8008DDF4 03120200 */  sra        $v0, $v0, 8
    /* 7E5F8 8008DDF8 18006200 */  mult       $v1, $v0
    /* 7E5FC 8008DDFC 12680000 */  mflo       $t5
    /* 7E600 8008DE00 00000000 */  nop
    /* 7E604 8008DE04 00000000 */  nop
    /* 7E608 8008DE08 18002D01 */  mult       $t1, $t5
    /* 7E60C 8008DE0C A000628E */  lw         $v0, 0xA0($s3)
    /* 7E610 8008DE10 FC00638E */  lw         $v1, 0xFC($s3)
    /* 7E614 8008DE14 12680000 */  mflo       $t5
    /* 7E618 8008DE18 02006104 */  bgez       $v1, .L8008DE24
    /* 7E61C 8008DE1C 21204D00 */   addu      $a0, $v0, $t5
    /* 7E620 8008DE20 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DE24:
    /* 7E624 8008DE24 3801628E */  lw         $v0, 0x138($s3)
    /* 7E628 8008DE28 00000000 */  nop
    /* 7E62C 8008DE2C 02004104 */  bgez       $v0, .L8008DE38
    /* 7E630 8008DE30 031A0300 */   sra       $v1, $v1, 8
    /* 7E634 8008DE34 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DE38:
    /* 7E638 8008DE38 03120200 */  sra        $v0, $v0, 8
    /* 7E63C 8008DE3C 18006200 */  mult       $v1, $v0
    /* 7E640 8008DE40 12680000 */  mflo       $t5
    /* 7E644 8008DE44 00000000 */  nop
    /* 7E648 8008DE48 00000000 */  nop
    /* 7E64C 8008DE4C 18004D01 */  mult       $t2, $t5
    /* 7E650 8008DE50 0801638E */  lw         $v1, 0x108($s3)
    /* 7E654 8008DE54 12680000 */  mflo       $t5
    /* 7E658 8008DE58 02006104 */  bgez       $v1, .L8008DE64
    /* 7E65C 8008DE5C 21208D00 */   addu      $a0, $a0, $t5
    /* 7E660 8008DE60 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DE64:
    /* 7E664 8008DE64 3C01628E */  lw         $v0, 0x13C($s3)
    /* 7E668 8008DE68 00000000 */  nop
    /* 7E66C 8008DE6C 02004104 */  bgez       $v0, .L8008DE78
    /* 7E670 8008DE70 031A0300 */   sra       $v1, $v1, 8
    /* 7E674 8008DE74 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DE78:
    /* 7E678 8008DE78 03120200 */  sra        $v0, $v0, 8
    /* 7E67C 8008DE7C 18006200 */  mult       $v1, $v0
    /* 7E680 8008DE80 12680000 */  mflo       $t5
    /* 7E684 8008DE84 00000000 */  nop
    /* 7E688 8008DE88 00000000 */  nop
    /* 7E68C 8008DE8C 18006D01 */  mult       $t3, $t5
    /* 7E690 8008DE90 12680000 */  mflo       $t5
    /* 7E694 8008DE94 21108D00 */  addu       $v0, $a0, $t5
    /* 7E698 8008DE98 6000A2AF */  sw         $v0, 0x60($sp)
    /* 7E69C 8008DE9C F400638E */  lw         $v1, 0xF4($s3)
    /* 7E6A0 8008DEA0 00000000 */  nop
    /* 7E6A4 8008DEA4 02006104 */  bgez       $v1, .L8008DEB0
    /* 7E6A8 8008DEA8 00000000 */   nop
    /* 7E6AC 8008DEAC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DEB0:
    /* 7E6B0 8008DEB0 3401628E */  lw         $v0, 0x134($s3)
    /* 7E6B4 8008DEB4 00000000 */  nop
    /* 7E6B8 8008DEB8 02004104 */  bgez       $v0, .L8008DEC4
    /* 7E6BC 8008DEBC 031A0300 */   sra       $v1, $v1, 8
    /* 7E6C0 8008DEC0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DEC4:
    /* 7E6C4 8008DEC4 03120200 */  sra        $v0, $v0, 8
    /* 7E6C8 8008DEC8 18006200 */  mult       $v1, $v0
    /* 7E6CC 8008DECC 12680000 */  mflo       $t5
    /* 7E6D0 8008DED0 00000000 */  nop
    /* 7E6D4 8008DED4 00000000 */  nop
    /* 7E6D8 8008DED8 18002D01 */  mult       $t1, $t5
    /* 7E6DC 8008DEDC A400628E */  lw         $v0, 0xA4($s3)
    /* 7E6E0 8008DEE0 0001638E */  lw         $v1, 0x100($s3)
    /* 7E6E4 8008DEE4 12680000 */  mflo       $t5
    /* 7E6E8 8008DEE8 02006104 */  bgez       $v1, .L8008DEF4
    /* 7E6EC 8008DEEC 21204D00 */   addu      $a0, $v0, $t5
    /* 7E6F0 8008DEF0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DEF4:
    /* 7E6F4 8008DEF4 3801628E */  lw         $v0, 0x138($s3)
    /* 7E6F8 8008DEF8 00000000 */  nop
    /* 7E6FC 8008DEFC 02004104 */  bgez       $v0, .L8008DF08
    /* 7E700 8008DF00 031A0300 */   sra       $v1, $v1, 8
    /* 7E704 8008DF04 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DF08:
    /* 7E708 8008DF08 03120200 */  sra        $v0, $v0, 8
    /* 7E70C 8008DF0C 18006200 */  mult       $v1, $v0
    /* 7E710 8008DF10 12680000 */  mflo       $t5
    /* 7E714 8008DF14 00000000 */  nop
    /* 7E718 8008DF18 00000000 */  nop
    /* 7E71C 8008DF1C 18004D01 */  mult       $t2, $t5
    /* 7E720 8008DF20 0C01638E */  lw         $v1, 0x10C($s3)
    /* 7E724 8008DF24 12680000 */  mflo       $t5
    /* 7E728 8008DF28 02006104 */  bgez       $v1, .L8008DF34
    /* 7E72C 8008DF2C 21208D00 */   addu      $a0, $a0, $t5
    /* 7E730 8008DF30 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DF34:
    /* 7E734 8008DF34 3C01628E */  lw         $v0, 0x13C($s3)
    /* 7E738 8008DF38 00000000 */  nop
    /* 7E73C 8008DF3C 02004104 */  bgez       $v0, .L8008DF48
    /* 7E740 8008DF40 031A0300 */   sra       $v1, $v1, 8
    /* 7E744 8008DF44 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DF48:
    /* 7E748 8008DF48 03120200 */  sra        $v0, $v0, 8
    /* 7E74C 8008DF4C 18006200 */  mult       $v1, $v0
    /* 7E750 8008DF50 12680000 */  mflo       $t5
    /* 7E754 8008DF54 00000000 */  nop
    /* 7E758 8008DF58 00000000 */  nop
    /* 7E75C 8008DF5C 18006D01 */  mult       $t3, $t5
    /* 7E760 8008DF60 12680000 */  mflo       $t5
    /* 7E764 8008DF64 21108D00 */  addu       $v0, $a0, $t5
    /* 7E768 8008DF68 6400A2AF */  sw         $v0, 0x64($sp)
    /* 7E76C 8008DF6C F800638E */  lw         $v1, 0xF8($s3)
    /* 7E770 8008DF70 00000000 */  nop
    /* 7E774 8008DF74 02006104 */  bgez       $v1, .L8008DF80
    /* 7E778 8008DF78 00000000 */   nop
    /* 7E77C 8008DF7C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DF80:
    /* 7E780 8008DF80 3401628E */  lw         $v0, 0x134($s3)
    /* 7E784 8008DF84 00000000 */  nop
    /* 7E788 8008DF88 02004104 */  bgez       $v0, .L8008DF94
    /* 7E78C 8008DF8C 031A0300 */   sra       $v1, $v1, 8
    /* 7E790 8008DF90 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DF94:
    /* 7E794 8008DF94 03120200 */  sra        $v0, $v0, 8
    /* 7E798 8008DF98 18006200 */  mult       $v1, $v0
    /* 7E79C 8008DF9C 12680000 */  mflo       $t5
    /* 7E7A0 8008DFA0 00000000 */  nop
    /* 7E7A4 8008DFA4 00000000 */  nop
    /* 7E7A8 8008DFA8 18002D01 */  mult       $t1, $t5
    /* 7E7AC 8008DFAC A800628E */  lw         $v0, 0xA8($s3)
    /* 7E7B0 8008DFB0 0401638E */  lw         $v1, 0x104($s3)
    /* 7E7B4 8008DFB4 12680000 */  mflo       $t5
    /* 7E7B8 8008DFB8 02006104 */  bgez       $v1, .L8008DFC4
    /* 7E7BC 8008DFBC 21204D00 */   addu      $a0, $v0, $t5
    /* 7E7C0 8008DFC0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008DFC4:
    /* 7E7C4 8008DFC4 3801628E */  lw         $v0, 0x138($s3)
    /* 7E7C8 8008DFC8 00000000 */  nop
    /* 7E7CC 8008DFCC 02004104 */  bgez       $v0, .L8008DFD8
    /* 7E7D0 8008DFD0 031A0300 */   sra       $v1, $v1, 8
    /* 7E7D4 8008DFD4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008DFD8:
    /* 7E7D8 8008DFD8 03120200 */  sra        $v0, $v0, 8
    /* 7E7DC 8008DFDC 18006200 */  mult       $v1, $v0
    /* 7E7E0 8008DFE0 12680000 */  mflo       $t5
    /* 7E7E4 8008DFE4 00000000 */  nop
    /* 7E7E8 8008DFE8 00000000 */  nop
    /* 7E7EC 8008DFEC 18004D01 */  mult       $t2, $t5
    /* 7E7F0 8008DFF0 1001638E */  lw         $v1, 0x110($s3)
    /* 7E7F4 8008DFF4 12680000 */  mflo       $t5
    /* 7E7F8 8008DFF8 02006104 */  bgez       $v1, .L8008E004
    /* 7E7FC 8008DFFC 21208D00 */   addu      $a0, $a0, $t5
    /* 7E800 8008E000 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008E004:
    /* 7E804 8008E004 3C01628E */  lw         $v0, 0x13C($s3)
    /* 7E808 8008E008 00000000 */  nop
    /* 7E80C 8008E00C 02004104 */  bgez       $v0, .L8008E018
    /* 7E810 8008E010 031A0300 */   sra       $v1, $v1, 8
    /* 7E814 8008E014 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E018:
    /* 7E818 8008E018 03120200 */  sra        $v0, $v0, 8
    /* 7E81C 8008E01C 18006200 */  mult       $v1, $v0
    /* 7E820 8008E020 12680000 */  mflo       $t5
    /* 7E824 8008E024 00000000 */  nop
    /* 7E828 8008E028 00000000 */  nop
    /* 7E82C 8008E02C 18006D01 */  mult       $t3, $t5
    /* 7E830 8008E030 23180500 */  negu       $v1, $a1
    /* 7E834 8008E034 12680000 */  mflo       $t5
    /* 7E838 8008E038 21108D00 */  addu       $v0, $a0, $t5
    /* 7E83C 8008E03C 6800A2AF */  sw         $v0, 0x68($sp)
    /* 7E840 8008E040 2A102302 */  slt        $v0, $s1, $v1
    /* 7E844 8008E044 02004010 */  beqz       $v0, .L8008E050
    /* 7E848 8008E048 00000000 */   nop
    /* 7E84C 8008E04C 21886000 */  addu       $s1, $v1, $zero
  .L8008E050:
    /* 7E850 8008E050 E002828F */  lw         $v0, %gp_rel(Collide_gRaiseUp)($gp)
    /* 7E854 8008E054 00000000 */  nop
    /* 7E858 8008E058 21004010 */  beqz       $v0, .L8008E0E0
    /* 7E85C 8008E05C 00000000 */   nop
    /* 7E860 8008E060 1F002012 */  beqz       $s1, .L8008E0E0
    /* 7E864 8008E064 00000000 */   nop
    /* 7E868 8008E068 C2871100 */  srl        $s0, $s1, 31
    /* 7E86C 8008E06C 21803002 */  addu       $s0, $s1, $s0
    /* 7E870 8008E070 43801000 */  sra        $s0, $s0, 1
    /* 7E874 8008E074 0000458E */  lw         $a1, 0x0($s2)
    /* 7E878 8008E078 CA90030C */  jal        fixedmult
    /* 7E87C 8008E07C 21200002 */   addu      $a0, $s0, $zero
    /* 7E880 8008E080 3000A2AF */  sw         $v0, 0x30($sp)
    /* 7E884 8008E084 0400458E */  lw         $a1, 0x4($s2)
    /* 7E888 8008E088 CA90030C */  jal        fixedmult
    /* 7E88C 8008E08C 21200002 */   addu      $a0, $s0, $zero
    /* 7E890 8008E090 3400A2AF */  sw         $v0, 0x34($sp)
    /* 7E894 8008E094 0800458E */  lw         $a1, 0x8($s2)
    /* 7E898 8008E098 CA90030C */  jal        fixedmult
    /* 7E89C 8008E09C 21200002 */   addu      $a0, $s0, $zero
    /* 7E8A0 8008E0A0 3800A2AF */  sw         $v0, 0x38($sp)
    /* 7E8A4 8008E0A4 A000628E */  lw         $v0, 0xA0($s3)
    /* 7E8A8 8008E0A8 3000A38F */  lw         $v1, 0x30($sp)
    /* 7E8AC 8008E0AC 00000000 */  nop
    /* 7E8B0 8008E0B0 21104300 */  addu       $v0, $v0, $v1
    /* 7E8B4 8008E0B4 A00062AE */  sw         $v0, 0xA0($s3)
    /* 7E8B8 8008E0B8 A400628E */  lw         $v0, 0xA4($s3)
    /* 7E8BC 8008E0BC 3400A38F */  lw         $v1, 0x34($sp)
    /* 7E8C0 8008E0C0 00000000 */  nop
    /* 7E8C4 8008E0C4 21104300 */  addu       $v0, $v0, $v1
    /* 7E8C8 8008E0C8 A40062AE */  sw         $v0, 0xA4($s3)
    /* 7E8CC 8008E0CC A800628E */  lw         $v0, 0xA8($s3)
    /* 7E8D0 8008E0D0 3800A38F */  lw         $v1, 0x38($sp)
    /* 7E8D4 8008E0D4 00000000 */  nop
    /* 7E8D8 8008E0D8 21104300 */  addu       $v0, $v0, $v1
    /* 7E8DC 8008E0DC A80062AE */  sw         $v0, 0xA8($s3)
  .L8008E0E0:
    /* 7E8E0 8008E0E0 6000A38F */  lw         $v1, 0x60($sp)
    /* 7E8E4 8008E0E4 A000628E */  lw         $v0, 0xA0($s3)
    /* 7E8E8 8008E0E8 00000000 */  nop
    /* 7E8EC 8008E0EC 23486200 */  subu       $t1, $v1, $v0
    /* 7E8F0 8008E0F0 6400A38F */  lw         $v1, 0x64($sp)
    /* 7E8F4 8008E0F4 5000A9AF */  sw         $t1, 0x50($sp)
    /* 7E8F8 8008E0F8 A400628E */  lw         $v0, 0xA4($s3)
    /* 7E8FC 8008E0FC 00000000 */  nop
    /* 7E900 8008E100 23306200 */  subu       $a2, $v1, $v0
    /* 7E904 8008E104 6800A38F */  lw         $v1, 0x68($sp)
    /* 7E908 8008E108 5400A6AF */  sw         $a2, 0x54($sp)
    /* 7E90C 8008E10C A800628E */  lw         $v0, 0xA8($s3)
    /* 7E910 8008E110 00000000 */  nop
    /* 7E914 8008E114 23186200 */  subu       $v1, $v1, $v0
    /* 7E918 8008E118 5800A3AF */  sw         $v1, 0x58($sp)
    /* 7E91C 8008E11C 1801628E */  lw         $v0, 0x118($s3)
    /* 7E920 8008E120 00000000 */  nop
    /* 7E924 8008E124 02004104 */  bgez       $v0, .L8008E130
    /* 7E928 8008E128 21206000 */   addu      $a0, $v1, $zero
    /* 7E92C 8008E12C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E130:
    /* 7E930 8008E130 02006104 */  bgez       $v1, .L8008E13C
    /* 7E934 8008E134 032A0200 */   sra       $a1, $v0, 8
    /* 7E938 8008E138 FF006424 */  addiu      $a0, $v1, 0xFF
  .L8008E13C:
    /* 7E93C 8008E13C 033A0400 */  sra        $a3, $a0, 8
    /* 7E940 8008E140 1800A700 */  mult       $a1, $a3
    /* 7E944 8008E144 1C01628E */  lw         $v0, 0x11C($s3)
    /* 7E948 8008E148 12280000 */  mflo       $a1
    /* 7E94C 8008E14C 02004104 */  bgez       $v0, .L8008E158
    /* 7E950 8008E150 2120C000 */   addu      $a0, $a2, $zero
    /* 7E954 8008E154 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E158:
    /* 7E958 8008E158 0200C104 */  bgez       $a2, .L8008E164
    /* 7E95C 8008E15C 03120200 */   sra       $v0, $v0, 8
    /* 7E960 8008E160 FF00C424 */  addiu      $a0, $a2, 0xFF
  .L8008E164:
    /* 7E964 8008E164 03420400 */  sra        $t0, $a0, 8
    /* 7E968 8008E168 18004800 */  mult       $v0, $t0
    /* 7E96C 8008E16C 12680000 */  mflo       $t5
    /* 7E970 8008E170 2350AD00 */  subu       $t2, $a1, $t5
    /* 7E974 8008E174 4000AAAF */  sw         $t2, 0x40($sp)
    /* 7E978 8008E178 1C01648E */  lw         $a0, 0x11C($s3)
    /* 7E97C 8008E17C 00000000 */  nop
    /* 7E980 8008E180 02008104 */  bgez       $a0, .L8008E18C
    /* 7E984 8008E184 21102001 */   addu      $v0, $t1, $zero
    /* 7E988 8008E188 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008E18C:
    /* 7E98C 8008E18C 02004104 */  bgez       $v0, .L8008E198
    /* 7E990 8008E190 032A0400 */   sra       $a1, $a0, 8
    /* 7E994 8008E194 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E198:
    /* 7E998 8008E198 03120200 */  sra        $v0, $v0, 8
    /* 7E99C 8008E19C 1800A200 */  mult       $a1, $v0
    /* 7E9A0 8008E1A0 1401648E */  lw         $a0, 0x114($s3)
    /* 7E9A4 8008E1A4 12280000 */  mflo       $a1
    /* 7E9A8 8008E1A8 03008104 */  bgez       $a0, .L8008E1B8
    /* 7E9AC 8008E1AC 03120400 */   sra       $v0, $a0, 8
    /* 7E9B0 8008E1B0 FF008424 */  addiu      $a0, $a0, 0xFF
    /* 7E9B4 8008E1B4 03120400 */  sra        $v0, $a0, 8
  .L8008E1B8:
    /* 7E9B8 8008E1B8 18004700 */  mult       $v0, $a3
    /* 7E9BC 8008E1BC 12680000 */  mflo       $t5
    /* 7E9C0 8008E1C0 2338AD00 */  subu       $a3, $a1, $t5
    /* 7E9C4 8008E1C4 4400A7AF */  sw         $a3, 0x44($sp)
    /* 7E9C8 8008E1C8 1401628E */  lw         $v0, 0x114($s3)
    /* 7E9CC 8008E1CC 00000000 */  nop
    /* 7E9D0 8008E1D0 03004104 */  bgez       $v0, .L8008E1E0
    /* 7E9D4 8008E1D4 031A0200 */   sra       $v1, $v0, 8
    /* 7E9D8 8008E1D8 FF004224 */  addiu      $v0, $v0, 0xFF
    /* 7E9DC 8008E1DC 031A0200 */  sra        $v1, $v0, 8
  .L8008E1E0:
    /* 7E9E0 8008E1E0 18006800 */  mult       $v1, $t0
    /* 7E9E4 8008E1E4 1801648E */  lw         $a0, 0x118($s3)
    /* 7E9E8 8008E1E8 12280000 */  mflo       $a1
    /* 7E9EC 8008E1EC 02008104 */  bgez       $a0, .L8008E1F8
    /* 7E9F0 8008E1F0 00000000 */   nop
    /* 7E9F4 8008E1F4 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008E1F8:
    /* 7E9F8 8008E1F8 5000A28F */  lw         $v0, 0x50($sp)
    /* 7E9FC 8008E1FC 00000000 */  nop
    /* 7EA00 8008E200 02004104 */  bgez       $v0, .L8008E20C
    /* 7EA04 8008E204 031A0400 */   sra       $v1, $a0, 8
    /* 7EA08 8008E208 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E20C:
    /* 7EA0C 8008E20C 03120200 */  sra        $v0, $v0, 8
    /* 7EA10 8008E210 18006200 */  mult       $v1, $v0
    /* 7EA14 8008E214 12680000 */  mflo       $t5
    /* 7EA18 8008E218 2318AD00 */  subu       $v1, $a1, $t5
    /* 7EA1C 8008E21C 4800A3AF */  sw         $v1, 0x48($sp)
    /* 7EA20 8008E220 AC00628E */  lw         $v0, 0xAC($s3)
    /* 7EA24 8008E224 00000000 */  nop
    /* 7EA28 8008E228 21284201 */  addu       $a1, $t2, $v0
    /* 7EA2C 8008E22C 4000A5AF */  sw         $a1, 0x40($sp)
    /* 7EA30 8008E230 B000628E */  lw         $v0, 0xB0($s3)
    /* 7EA34 8008E234 00000000 */  nop
    /* 7EA38 8008E238 2130E200 */  addu       $a2, $a3, $v0
    /* 7EA3C 8008E23C 4400A6AF */  sw         $a2, 0x44($sp)
    /* 7EA40 8008E240 B400628E */  lw         $v0, 0xB4($s3)
    /* 7EA44 8008E244 00000000 */  nop
    /* 7EA48 8008E248 21186200 */  addu       $v1, $v1, $v0
    /* 7EA4C 8008E24C 4800A3AF */  sw         $v1, 0x48($sp)
    /* 7EA50 8008E250 0000448E */  lw         $a0, 0x0($s2)
    /* 7EA54 8008E254 00000000 */  nop
    /* 7EA58 8008E258 02008104 */  bgez       $a0, .L8008E264
    /* 7EA5C 8008E25C 2110A000 */   addu      $v0, $a1, $zero
    /* 7EA60 8008E260 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008E264:
    /* 7EA64 8008E264 02004104 */  bgez       $v0, .L8008E270
    /* 7EA68 8008E268 032A0400 */   sra       $a1, $a0, 8
    /* 7EA6C 8008E26C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E270:
    /* 7EA70 8008E270 03120200 */  sra        $v0, $v0, 8
    /* 7EA74 8008E274 1800A200 */  mult       $a1, $v0
    /* 7EA78 8008E278 0400448E */  lw         $a0, 0x4($s2)
    /* 7EA7C 8008E27C 12280000 */  mflo       $a1
    /* 7EA80 8008E280 02008104 */  bgez       $a0, .L8008E28C
    /* 7EA84 8008E284 2110C000 */   addu      $v0, $a2, $zero
    /* 7EA88 8008E288 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008E28C:
    /* 7EA8C 8008E28C 02004104 */  bgez       $v0, .L8008E298
    /* 7EA90 8008E290 03220400 */   sra       $a0, $a0, 8
    /* 7EA94 8008E294 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E298:
    /* 7EA98 8008E298 03120200 */  sra        $v0, $v0, 8
    /* 7EA9C 8008E29C 18008200 */  mult       $a0, $v0
    /* 7EAA0 8008E2A0 0800448E */  lw         $a0, 0x8($s2)
    /* 7EAA4 8008E2A4 12680000 */  mflo       $t5
    /* 7EAA8 8008E2A8 02008104 */  bgez       $a0, .L8008E2B4
    /* 7EAAC 8008E2AC 2128AD00 */   addu      $a1, $a1, $t5
    /* 7EAB0 8008E2B0 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8008E2B4:
    /* 7EAB4 8008E2B4 21106000 */  addu       $v0, $v1, $zero
    /* 7EAB8 8008E2B8 02004104 */  bgez       $v0, .L8008E2C4
    /* 7EABC 8008E2BC 031A0400 */   sra       $v1, $a0, 8
    /* 7EAC0 8008E2C0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008E2C4:
    /* 7EAC4 8008E2C4 03120200 */  sra        $v0, $v0, 8
    /* 7EAC8 8008E2C8 18006200 */  mult       $v1, $v0
    /* 7EACC 8008E2CC 12680000 */  mflo       $t5
    /* 7EAD0 8008E2D0 2110AD00 */  addu       $v0, $a1, $t5
    /* 7EAD4 8008E2D4 05004104 */  bgez       $v0, .L8008E2EC
    /* 7EAD8 8008E2D8 21206002 */   addu      $a0, $s3, $zero
    /* 7EADC 8008E2DC 6000A527 */  addiu      $a1, $sp, 0x60
    /* 7EAE0 8008E2E0 4000A627 */  addiu      $a2, $sp, 0x40
    /* 7EAE4 8008E2E4 C332020C */  jal        Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
    /* 7EAE8 8008E2E8 21384002 */   addu      $a3, $s2, $zero
  .L8008E2EC:
    /* 7EAEC 8008E2EC E002828F */  lw         $v0, %gp_rel(Collide_gRaiseUp)($gp)
    /* 7EAF0 8008E2F0 00000000 */  nop
    /* 7EAF4 8008E2F4 1F004010 */  beqz       $v0, .L8008E374
    /* 7EAF8 8008E2F8 00000000 */   nop
    /* 7EAFC 8008E2FC 1D002012 */  beqz       $s1, .L8008E374
    /* 7EB00 8008E300 00000000 */   nop
    /* 7EB04 8008E304 3400A58F */  lw         $a1, 0x34($sp)
    /* 7EB08 8008E308 00000000 */  nop
    /* 7EB0C 8008E30C 1900A018 */  blez       $a1, .L8008E374
    /* 7EB10 8008E310 0900043C */   lui       $a0, (0x9CCCC >> 16)
    /* 7EB14 8008E314 CA90030C */  jal        fixedmult
    /* 7EB18 8008E318 CCCC8434 */   ori       $a0, $a0, (0x9CCCC & 0xFFFF)
    /* 7EB1C 8008E31C B000648E */  lw         $a0, 0xB0($s3)
    /* 7EB20 8008E320 40800200 */  sll        $s0, $v0, 1
    /* 7EB24 8008E324 CA90030C */  jal        fixedmult
    /* 7EB28 8008E328 21288000 */   addu      $a1, $a0, $zero
    /* 7EB2C 8008E32C 21204000 */  addu       $a0, $v0, $zero
    /* 7EB30 8008E330 2A109000 */  slt        $v0, $a0, $s0
    /* 7EB34 8008E334 03004010 */  beqz       $v0, .L8008E344
    /* 7EB38 8008E338 00000000 */   nop
    /* 7EB3C 8008E33C DD380208 */  j          .L8008E374
    /* 7EB40 8008E340 B00060AE */   sw        $zero, 0xB0($s3)
  .L8008E344:
    /* 7EB44 8008E344 B000628E */  lw         $v0, 0xB0($s3)
    /* 7EB48 8008E348 00000000 */  nop
    /* 7EB4C 8008E34C 05004018 */  blez       $v0, .L8008E364
    /* 7EB50 8008E350 00000000 */   nop
    /* 7EB54 8008E354 2BAC030C */  jal        fixedsqrt
    /* 7EB58 8008E358 23209000 */   subu      $a0, $a0, $s0
    /* 7EB5C 8008E35C DD380208 */  j          .L8008E374
    /* 7EB60 8008E360 B00062AE */   sw        $v0, 0xB0($s3)
  .L8008E364:
    /* 7EB64 8008E364 2BAC030C */  jal        fixedsqrt
    /* 7EB68 8008E368 23209000 */   subu      $a0, $a0, $s0
    /* 7EB6C 8008E36C 23100200 */  negu       $v0, $v0
    /* 7EB70 8008E370 B00062AE */  sw         $v0, 0xB0($s3)
  .L8008E374:
    /* 7EB74 8008E374 1401658E */  lw         $a1, 0x114($s3)
    /* 7EB78 8008E378 CA90030C */  jal        fixedmult
    /* 7EB7C 8008E37C BE280424 */   addiu     $a0, $zero, 0x28BE
    /* 7EB80 8008E380 1801658E */  lw         $a1, 0x118($s3)
    /* 7EB84 8008E384 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 7EB88 8008E388 CA90030C */  jal        fixedmult
    /* 7EB8C 8008E38C 140162AE */   sw        $v0, 0x114($s3)
    /* 7EB90 8008E390 1C01658E */  lw         $a1, 0x11C($s3)
    /* 7EB94 8008E394 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 7EB98 8008E398 CA90030C */  jal        fixedmult
    /* 7EB9C 8008E39C 180162AE */   sw        $v0, 0x118($s3)
    /* 7EBA0 8008E3A0 21206002 */  addu       $a0, $s3, $zero
    /* 7EBA4 8008E3A4 2D36020C */  jal        Collide_LimitAngularVel__FP13BO_tNewtonObj
    /* 7EBA8 8008E3A8 1C0162AE */   sw        $v0, 0x11C($s3)
    /* 7EBAC 8008E3AC 0000448E */  lw         $a0, 0x0($s2)
    /* 7EBB0 8008E3B0 AC00658E */  lw         $a1, 0xAC($s3)
    /* 7EBB4 8008E3B4 CA90030C */  jal        fixedmult
    /* 7EBB8 8008E3B8 09001524 */   addiu     $s5, $zero, 0x9
    /* 7EBBC 8008E3BC 0400448E */  lw         $a0, 0x4($s2)
    /* 7EBC0 8008E3C0 B000658E */  lw         $a1, 0xB0($s3)
    /* 7EBC4 8008E3C4 CA90030C */  jal        fixedmult
    /* 7EBC8 8008E3C8 21804000 */   addu      $s0, $v0, $zero
    /* 7EBCC 8008E3CC 0800448E */  lw         $a0, 0x8($s2)
    /* 7EBD0 8008E3D0 B400658E */  lw         $a1, 0xB4($s3)
    /* 7EBD4 8008E3D4 CA90030C */  jal        fixedmult
    /* 7EBD8 8008E3D8 21884000 */   addu      $s1, $v0, $zero
    /* 7EBDC 8008E3DC 21801102 */  addu       $s0, $s0, $s1
    /* 7EBE0 8008E3E0 21800202 */  addu       $s0, $s0, $v0
    /* 7EBE4 8008E3E4 1000001A */  blez       $s0, .L8008E428
    /* 7EBE8 8008E3E8 00000000 */   nop
    /* 7EBEC 8008E3EC 0000448E */  lw         $a0, 0x0($s2)
    /* 7EBF0 8008E3F0 AC00658E */  lw         $a1, 0xAC($s3)
    /* 7EBF4 8008E3F4 CA90030C */  jal        fixedmult
    /* 7EBF8 8008E3F8 00000000 */   nop
    /* 7EBFC 8008E3FC 0400448E */  lw         $a0, 0x4($s2)
    /* 7EC00 8008E400 B000658E */  lw         $a1, 0xB0($s3)
    /* 7EC04 8008E404 CA90030C */  jal        fixedmult
    /* 7EC08 8008E408 21804000 */   addu      $s0, $v0, $zero
    /* 7EC0C 8008E40C 0800448E */  lw         $a0, 0x8($s2)
    /* 7EC10 8008E410 B400658E */  lw         $a1, 0xB4($s3)
    /* 7EC14 8008E414 CA90030C */  jal        fixedmult
    /* 7EC18 8008E418 21884000 */   addu      $s1, $v0, $zero
    /* 7EC1C 8008E41C 21801102 */  addu       $s0, $s0, $s1
    /* 7EC20 8008E420 19390208 */  j          .L8008E464
    /* 7EC24 8008E424 21800202 */   addu      $s0, $s0, $v0
  .L8008E428:
    /* 7EC28 8008E428 0000448E */  lw         $a0, 0x0($s2)
    /* 7EC2C 8008E42C AC00658E */  lw         $a1, 0xAC($s3)
    /* 7EC30 8008E430 CA90030C */  jal        fixedmult
    /* 7EC34 8008E434 00000000 */   nop
    /* 7EC38 8008E438 0400448E */  lw         $a0, 0x4($s2)
    /* 7EC3C 8008E43C B000658E */  lw         $a1, 0xB0($s3)
    /* 7EC40 8008E440 CA90030C */  jal        fixedmult
    /* 7EC44 8008E444 21804000 */   addu      $s0, $v0, $zero
    /* 7EC48 8008E448 0800448E */  lw         $a0, 0x8($s2)
    /* 7EC4C 8008E44C B400658E */  lw         $a1, 0xB4($s3)
    /* 7EC50 8008E450 CA90030C */  jal        fixedmult
    /* 7EC54 8008E454 21884000 */   addu      $s1, $v0, $zero
    /* 7EC58 8008E458 21801102 */  addu       $s0, $s0, $s1
    /* 7EC5C 8008E45C 21800202 */  addu       $s0, $s0, $v0
    /* 7EC60 8008E460 23801000 */  negu       $s0, $s0
  .L8008E464:
    /* 7EC64 8008E464 80B01000 */  sll        $s6, $s0, 2
    /* 7EC68 8008E468 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 7EC6C 8008E46C 2A105600 */  slt        $v0, $v0, $s6
    /* 7EC70 8008E470 4E004010 */  beqz       $v0, .L8008E5AC
    /* 7EC74 8008E474 00000000 */   nop
    /* 7EC78 8008E478 0000448E */  lw         $a0, 0x0($s2)
    /* 7EC7C 8008E47C F000658E */  lw         $a1, 0xF0($s3)
    /* 7EC80 8008E480 CA90030C */  jal        fixedmult
    /* 7EC84 8008E484 00000000 */   nop
    /* 7EC88 8008E488 0400448E */  lw         $a0, 0x4($s2)
    /* 7EC8C 8008E48C F400658E */  lw         $a1, 0xF4($s3)
    /* 7EC90 8008E490 CA90030C */  jal        fixedmult
    /* 7EC94 8008E494 21804000 */   addu      $s0, $v0, $zero
    /* 7EC98 8008E498 0800448E */  lw         $a0, 0x8($s2)
    /* 7EC9C 8008E49C F800658E */  lw         $a1, 0xF8($s3)
    /* 7ECA0 8008E4A0 CA90030C */  jal        fixedmult
    /* 7ECA4 8008E4A4 21884000 */   addu      $s1, $v0, $zero
    /* 7ECA8 8008E4A8 21801102 */  addu       $s0, $s0, $s1
    /* 7ECAC 8008E4AC 0000448E */  lw         $a0, 0x0($s2)
    /* 7ECB0 8008E4B0 FC00658E */  lw         $a1, 0xFC($s3)
    /* 7ECB4 8008E4B4 CA90030C */  jal        fixedmult
    /* 7ECB8 8008E4B8 21A00202 */   addu      $s4, $s0, $v0
    /* 7ECBC 8008E4BC 0400448E */  lw         $a0, 0x4($s2)
    /* 7ECC0 8008E4C0 0001658E */  lw         $a1, 0x100($s3)
    /* 7ECC4 8008E4C4 CA90030C */  jal        fixedmult
    /* 7ECC8 8008E4C8 21884000 */   addu      $s1, $v0, $zero
    /* 7ECCC 8008E4CC 0800448E */  lw         $a0, 0x8($s2)
    /* 7ECD0 8008E4D0 0401658E */  lw         $a1, 0x104($s3)
    /* 7ECD4 8008E4D4 CA90030C */  jal        fixedmult
    /* 7ECD8 8008E4D8 21804000 */   addu      $s0, $v0, $zero
    /* 7ECDC 8008E4DC 21883002 */  addu       $s1, $s1, $s0
    /* 7ECE0 8008E4E0 0000448E */  lw         $a0, 0x0($s2)
    /* 7ECE4 8008E4E4 0801658E */  lw         $a1, 0x108($s3)
    /* 7ECE8 8008E4E8 CA90030C */  jal        fixedmult
    /* 7ECEC 8008E4EC 21882202 */   addu      $s1, $s1, $v0
    /* 7ECF0 8008E4F0 0400448E */  lw         $a0, 0x4($s2)
    /* 7ECF4 8008E4F4 0C01658E */  lw         $a1, 0x10C($s3)
    /* 7ECF8 8008E4F8 CA90030C */  jal        fixedmult
    /* 7ECFC 8008E4FC 21804000 */   addu      $s0, $v0, $zero
    /* 7ED00 8008E500 0800448E */  lw         $a0, 0x8($s2)
    /* 7ED04 8008E504 1001658E */  lw         $a1, 0x110($s3)
    /* 7ED08 8008E508 CA90030C */  jal        fixedmult
    /* 7ED0C 8008E50C 21904000 */   addu      $s2, $v0, $zero
    /* 7ED10 8008E510 21801202 */  addu       $s0, $s0, $s2
    /* 7ED14 8008E514 0080312A */  slti       $s1, $s1, -0x8000
    /* 7ED18 8008E518 07002012 */  beqz       $s1, .L8008E538
    /* 7ED1C 8008E51C 21800202 */   addu      $s0, $s0, $v0
    /* 7ED20 8008E520 08001524 */  addiu      $s5, $zero, 0x8
    /* 7ED24 8008E524 21206002 */  addu       $a0, $s3, $zero
    /* 7ED28 8008E528 2128C002 */  addu       $a1, $s6, $zero
    /* 7ED2C 8008E52C 2130A002 */  addu       $a2, $s5, $zero
    /* 7ED30 8008E530 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7ED34 8008E534 21380000 */   addu      $a3, $zero, $zero
  .L8008E538:
    /* 7ED38 8008E538 67E6022A */  slti       $v0, $s0, -0x1999
    /* 7ED3C 8008E53C 09004010 */  beqz       $v0, .L8008E564
    /* 7ED40 8008E540 9A19822A */   slti      $v0, $s4, 0x199A
    /* 7ED44 8008E544 03004014 */  bnez       $v0, .L8008E554
    /* 7ED48 8008E548 67E6822A */   slti      $v0, $s4, -0x1999
    /* 7ED4C 8008E54C 64390208 */  j          .L8008E590
    /* 7ED50 8008E550 21A80000 */   addu      $s5, $zero, $zero
  .L8008E554:
    /* 7ED54 8008E554 04004010 */  beqz       $v0, .L8008E568
    /* 7ED58 8008E558 9A19022A */   slti      $v0, $s0, 0x199A
    /* 7ED5C 8008E55C 64390208 */  j          .L8008E590
    /* 7ED60 8008E560 02001524 */   addiu     $s5, $zero, 0x2
  .L8008E564:
    /* 7ED64 8008E564 9A19022A */  slti       $v0, $s0, 0x199A
  .L8008E568:
    /* 7ED68 8008E568 0A004014 */  bnez       $v0, .L8008E594
    /* 7ED6C 8008E56C 0800A22A */   slti      $v0, $s5, 0x8
    /* 7ED70 8008E570 9A19822A */  slti       $v0, $s4, 0x199A
    /* 7ED74 8008E574 03004014 */  bnez       $v0, .L8008E584
    /* 7ED78 8008E578 67E6822A */   slti      $v0, $s4, -0x1999
    /* 7ED7C 8008E57C 64390208 */  j          .L8008E590
    /* 7ED80 8008E580 04001524 */   addiu     $s5, $zero, 0x4
  .L8008E584:
    /* 7ED84 8008E584 03004010 */  beqz       $v0, .L8008E594
    /* 7ED88 8008E588 0800A22A */   slti      $v0, $s5, 0x8
    /* 7ED8C 8008E58C 06001524 */  addiu      $s5, $zero, 0x6
  .L8008E590:
    /* 7ED90 8008E590 0800A22A */  slti       $v0, $s5, 0x8
  .L8008E594:
    /* 7ED94 8008E594 05004010 */  beqz       $v0, .L8008E5AC
    /* 7ED98 8008E598 21206002 */   addu      $a0, $s3, $zero
    /* 7ED9C 8008E59C 2128C002 */  addu       $a1, $s6, $zero
    /* 7EDA0 8008E5A0 2130A002 */  addu       $a2, $s5, $zero
    /* 7EDA4 8008E5A4 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 7EDA8 8008E5A8 21380000 */   addu      $a3, $zero, $zero
  .L8008E5AC:
    /* 7EDAC 8008E5AC 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* 7EDB0 8008E5B0 8800B68F */  lw         $s6, 0x88($sp)
    /* 7EDB4 8008E5B4 8400B58F */  lw         $s5, 0x84($sp)
    /* 7EDB8 8008E5B8 8000B48F */  lw         $s4, 0x80($sp)
    /* 7EDBC 8008E5BC 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 7EDC0 8008E5C0 7800B28F */  lw         $s2, 0x78($sp)
    /* 7EDC4 8008E5C4 7400B18F */  lw         $s1, 0x74($sp)
    /* 7EDC8 8008E5C8 7000B08F */  lw         $s0, 0x70($sp)
    /* 7EDCC 8008E5CC 0800E003 */  jr         $ra
    /* 7EDD0 8008E5D0 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
