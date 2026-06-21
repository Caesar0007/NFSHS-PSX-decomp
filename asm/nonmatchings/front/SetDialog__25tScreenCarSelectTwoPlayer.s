.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDialog__25tScreenCarSelectTwoPlayer, 0xC0

glabel SetDialog__25tScreenCarSelectTwoPlayer
    /* 2F450 8003EC50 0580023C */  lui        $v0, %hi(FEApp)
    /* 2F454 8003EC54 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2F458 8003EC58 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2F45C 8003EC5C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2F460 8003EC60 21888000 */  addu       $s1, $a0, $zero
    /* 2F464 8003EC64 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 2F468 8003EC68 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2F46C 8003EC6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F470 8003EC70 2C024490 */  lbu        $a0, 0x22C($v0)
    /* 2F474 8003EC74 00000000 */  nop
    /* 2F478 8003EC78 80180400 */  sll        $v1, $a0, 2
    /* 2F47C 8003EC7C 21104300 */  addu       $v0, $v0, $v1
    /* 2F480 8003EC80 3002428C */  lw         $v0, 0x230($v0)
    /* 2F484 8003EC84 00000000 */  nop
    /* 2F488 8003EC88 19004010 */  beqz       $v0, .L8003ECF0
    /* 2F48C 8003EC8C 21808000 */   addu      $s0, $a0, $zero
    /* 2F490 8003EC90 02008014 */  bnez       $a0, .L8003EC9C
    /* 2F494 8003EC94 3C000224 */   addiu     $v0, $zero, 0x3C
    /* 2F498 8003EC98 C4FF0224 */  addiu      $v0, $zero, -0x3C
  .L8003EC9C:
    /* 2F49C 8003EC9C A8020424 */  addiu      $a0, $zero, 0x2A8
    /* 2F4A0 8003ECA0 A0033126 */  addiu      $s1, $s1, 0x3A0
    /* 2F4A4 8003ECA4 7C0020A6 */  sh         $zero, 0x7C($s1)
    /* 2F4A8 8003ECA8 7E0022A6 */  sh         $v0, 0x7E($s1)
    /* 2F4AC 8003ECAC 94E4020C */  jal        TextSys_Word__Fi
    /* 2F4B0 8003ECB0 640030A6 */   sh        $s0, 0x64($s1)
    /* 2F4B4 8003ECB4 01000424 */  addiu      $a0, $zero, 0x1
    /* 2F4B8 8003ECB8 23209000 */  subu       $a0, $a0, $s0
    /* 2F4BC 8003ECBC 7FAE000C */  jal        PlayerName__Fi
    /* 2F4C0 8003ECC0 21904000 */   addu      $s2, $v0, $zero
    /* 2F4C4 8003ECC4 0580103C */  lui        $s0, %hi(D_80052C58)
    /* 2F4C8 8003ECC8 582C1026 */  addiu      $s0, $s0, %lo(D_80052C58)
    /* 2F4CC 8003ECCC 21200002 */  addu       $a0, $s0, $zero
    /* 2F4D0 8003ECD0 21284002 */  addu       $a1, $s2, $zero
    /* 2F4D4 8003ECD4 2F91030C */  jal        sprintf
    /* 2F4D8 8003ECD8 21304000 */   addu      $a2, $v0, $zero
    /* 2F4DC 8003ECDC 21202002 */  addu       $a0, $s1, $zero
    /* 2F4E0 8003ECE0 1062000C */  jal        Display__11tDialogBase
    /* 2F4E4 8003ECE4 900090AC */   sw        $s0, 0x90($a0)
    /* 2F4E8 8003ECE8 3EFB0008 */  j          .L8003ECF8
    /* 2F4EC 8003ECEC 00000000 */   nop
  .L8003ECF0:
    /* 2F4F0 8003ECF0 4162000C */  jal        Hide__11tDialogBase
    /* 2F4F4 8003ECF4 A0032426 */   addiu     $a0, $s1, 0x3A0
  .L8003ECF8:
    /* 2F4F8 8003ECF8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 2F4FC 8003ECFC 1800B28F */  lw         $s2, 0x18($sp)
    /* 2F500 8003ED00 1400B18F */  lw         $s1, 0x14($sp)
    /* 2F504 8003ED04 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F508 8003ED08 0800E003 */  jr         $ra
    /* 2F50C 8003ED0C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetDialog__25tScreenCarSelectTwoPlayer
