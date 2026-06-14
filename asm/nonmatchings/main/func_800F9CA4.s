.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F9CA4, 0x4B0

glabel func_800F9CA4
    /* EA4A4 800F9CA4 A0FEBD27 */  addiu      $sp, $sp, -0x160
    /* EA4A8 800F9CA8 5401B3AF */  sw         $s3, 0x154($sp)
    /* EA4AC 800F9CAC 2198A000 */  addu       $s3, $a1, $zero
    /* EA4B0 800F9CB0 4C01B1AF */  sw         $s1, 0x14C($sp)
    /* EA4B4 800F9CB4 21888000 */  addu       $s1, $a0, $zero
    /* EA4B8 800F9CB8 21200000 */  addu       $a0, $zero, $zero
    /* EA4BC 800F9CBC 1480023C */  lui        $v0, %hi(D_80146CE4)
    /* EA4C0 800F9CC0 4801B0AF */  sw         $s0, 0x148($sp)
    /* EA4C4 800F9CC4 E46C5024 */  addiu      $s0, $v0, %lo(D_80146CE4)
    /* EA4C8 800F9CC8 5801BFAF */  sw         $ra, 0x158($sp)
    /* EA4CC 800F9CCC 28DE030C */  jal        CdReadyCallback
    /* EA4D0 800F9CD0 5001B2AF */   sw        $s2, 0x150($sp)
    /* EA4D4 800F9CD4 00006292 */  lbu        $v0, 0x0($s3)
    /* EA4D8 800F9CD8 00000000 */  nop
    /* EA4DC 800F9CDC 10004230 */  andi       $v0, $v0, 0x10
    /* EA4E0 800F9CE0 0B004010 */  beqz       $v0, .L800F9D10
    /* EA4E4 800F9CE4 21900000 */   addu      $s2, $zero, $zero
    /* EA4E8 800F9CE8 1080043C */  lui        $a0, %hi(func_800F9C44)
    /* EA4EC 800F9CEC 12AC030C */  jal        deltimer
    /* EA4F0 800F9CF0 449C8424 */   addiu     $a0, $a0, %lo(func_800F9C44)
    /* EA4F4 800F9CF4 1080043C */  lui        $a0, %hi(func_800F9AE8)
    /* EA4F8 800F9CF8 E89A8424 */  addiu      $a0, $a0, %lo(func_800F9AE8)
    /* EA4FC 800F9CFC 21284002 */  addu       $a1, $s2, $zero
    /* EA500 800F9D00 BD9A030C */  jal        addsystemtask
    /* EA504 800F9D04 21304002 */   addu      $a2, $s2, $zero
    /* EA508 800F9D08 4EE80308 */  j          .L800FA138
    /* EA50C 800F9D0C 00000000 */   nop
  .L800F9D10:
    /* EA510 800F9D10 FF002432 */  andi       $a0, $s1, 0xFF
    /* EA514 800F9D14 02000224 */  addiu      $v0, $zero, 0x2
    /* EA518 800F9D18 0C008210 */  beq        $a0, $v0, .L800F9D4C
    /* EA51C 800F9D1C 03008228 */   slti      $v0, $a0, 0x3
    /* EA520 800F9D20 05004010 */  beqz       $v0, .L800F9D38
    /* EA524 800F9D24 01000224 */   addiu     $v0, $zero, 0x1
    /* EA528 800F9D28 10008210 */  beq        $a0, $v0, .L800F9D6C
    /* EA52C 800F9D2C 1480043C */   lui       $a0, %hi(Cdinfo)
    /* EA530 800F9D30 0CE80308 */  j          .L800FA030
    /* EA534 800F9D34 C46C9124 */   addiu     $s1, $a0, %lo(Cdinfo)
  .L800F9D38:
    /* EA538 800F9D38 05000224 */  addiu      $v0, $zero, 0x5
    /* EA53C 800F9D3C A0008210 */  beq        $a0, $v0, .L800F9FC0
    /* EA540 800F9D40 1480043C */   lui       $a0, %hi(Cdinfo)
    /* EA544 800F9D44 0CE80308 */  j          .L800FA030
    /* EA548 800F9D48 C46C9124 */   addiu     $s1, $a0, %lo(Cdinfo)
  .L800F9D4C:
    /* EA54C 800F9D4C E0FF0426 */  addiu      $a0, $s0, -0x20
    /* EA550 800F9D50 1C00838C */  lw         $v1, 0x1C($a0)
    /* EA554 800F9D54 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* EA558 800F9D58 B3006214 */  bne        $v1, $v0, .L800FA028
    /* EA55C 800F9D5C 00000000 */   nop
    /* EA560 800F9D60 E0FF028E */  lw         $v0, -0x20($s0)
    /* EA564 800F9D64 07E80308 */  j          .L800FA01C
    /* EA568 800F9D68 1C0080AC */   sw        $zero, 0x1C($a0)
  .L800F9D6C:
    /* EA56C 800F9D6C E0FF028E */  lw         $v0, -0x20($s0)
    /* EA570 800F9D70 00000000 */  nop
    /* EA574 800F9D74 01004230 */  andi       $v0, $v0, 0x1
    /* EA578 800F9D78 6E004010 */  beqz       $v0, .L800F9F34
    /* EA57C 800F9D7C 00000000 */   nop
    /* EA580 800F9D80 E0FF028E */  lw         $v0, -0x20($s0)
    /* EA584 800F9D84 00000000 */  nop
    /* EA588 800F9D88 04004230 */  andi       $v0, $v0, 0x4
    /* EA58C 800F9D8C 08004010 */  beqz       $v0, .L800F9DB0
    /* EA590 800F9D90 00000000 */   nop
    /* EA594 800F9D94 01001224 */  addiu      $s2, $zero, 0x1
    /* EA598 800F9D98 E0FF028E */  lw         $v0, -0x20($s0)
    /* EA59C 800F9D9C FBFF0324 */  addiu      $v1, $zero, -0x5
    /* EA5A0 800F9DA0 24104300 */  and        $v0, $v0, $v1
    /* EA5A4 800F9DA4 E0FF02AE */  sw         $v0, -0x20($s0)
    /* EA5A8 800F9DA8 CDE70308 */  j          .L800F9F34
    /* EA5AC 800F9DAC 00000000 */   nop
  .L800F9DB0:
    /* EA5B0 800F9DB0 E0FF028E */  lw         $v0, -0x20($s0)
    /* EA5B4 800F9DB4 00000000 */  nop
    /* EA5B8 800F9DB8 08004230 */  andi       $v0, $v0, 0x8
    /* EA5BC 800F9DBC 04004014 */  bnez       $v0, .L800F9DD0
    /* EA5C0 800F9DC0 1C001126 */   addiu     $s1, $s0, 0x1C
    /* EA5C4 800F9DC4 0C00118E */  lw         $s1, 0xC($s0)
    /* EA5C8 800F9DC8 75E70308 */  j          .L800F9DD4
    /* EA5CC 800F9DCC 1000A427 */   addiu     $a0, $sp, 0x10
  .L800F9DD0:
    /* EA5D0 800F9DD0 1000A427 */  addiu      $a0, $sp, 0x10
  .L800F9DD4:
    /* EA5D4 800F9DD4 1CDF030C */  jal        CdGetSector
    /* EA5D8 800F9DD8 03000524 */   addiu     $a1, $zero, 0x3
    /* EA5DC 800F9DDC 21202002 */  addu       $a0, $s1, $zero
    /* EA5E0 800F9DE0 1CDF030C */  jal        CdGetSector
    /* EA5E4 800F9DE4 00020524 */   addiu     $a1, $zero, 0x200
    /* EA5E8 800F9DE8 1C00A427 */  addiu      $a0, $sp, 0x1C
    /* EA5EC 800F9DEC 1CDF030C */  jal        CdGetSector
    /* EA5F0 800F9DF0 46000524 */   addiu     $a1, $zero, 0x46
    /* EA5F4 800F9DF4 35DF030C */  jal        CdDataSync
    /* EA5F8 800F9DF8 21200000 */   addu      $a0, $zero, $zero
    /* EA5FC 800F9DFC 7EDF030C */  jal        CdPosToInt
    /* EA600 800F9E00 1000A427 */   addiu     $a0, $sp, 0x10
    /* EA604 800F9E04 1480113C */  lui        $s1, %hi(Cdinfo)
    /* EA608 800F9E08 C46C2426 */  addiu      $a0, $s1, %lo(Cdinfo)
    /* EA60C 800F9E0C 0C00838C */  lw         $v1, 0xC($a0)
    /* EA610 800F9E10 00000000 */  nop
    /* EA614 800F9E14 14004310 */  beq        $v0, $v1, .L800F9E68
    /* EA618 800F9E18 1480023C */   lui       $v0, %hi(timerhz)
    /* EA61C 800F9E1C 1C00828C */  lw         $v0, 0x1C($a0)
    /* EA620 800F9E20 0C00838C */  lw         $v1, 0xC($a0)
    /* EA624 800F9E24 01004224 */  addiu      $v0, $v0, 0x1
    /* EA628 800F9E28 1C0082AC */  sw         $v0, 0x1C($a0)
    /* EA62C 800F9E2C 04004228 */  slti       $v0, $v0, 0x4
    /* EA630 800F9E30 07004010 */  beqz       $v0, .L800F9E50
    /* EA634 800F9E34 140083AC */   sw        $v1, 0x14($a0)
    /* EA638 800F9E38 C46C228E */  lw         $v0, %lo(Cdinfo)($s1)
    /* EA63C 800F9E3C 00000000 */  nop
    /* EA640 800F9E40 02004234 */  ori        $v0, $v0, 0x2
    /* EA644 800F9E44 C46C22AE */  sw         $v0, %lo(Cdinfo)($s1)
    /* EA648 800F9E48 D2E70308 */  j          .L800F9F48
    /* EA64C 800F9E4C 00000000 */   nop
  .L800F9E50:
    /* EA650 800F9E50 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* EA654 800F9E54 1C0082AC */  sw         $v0, 0x1C($a0)
    /* EA658 800F9E58 09000424 */  addiu      $a0, $zero, 0x9
    /* EA65C 800F9E5C 21280000 */  addu       $a1, $zero, $zero
    /* EA660 800F9E60 49E80308 */  j          .L800FA124
    /* EA664 800F9E64 2130A000 */   addu      $a2, $a1, $zero
  .L800F9E68:
    /* EA668 800F9E68 C4DC438C */  lw         $v1, %lo(timerhz)($v0)
    /* EA66C 800F9E6C 00000000 */  nop
    /* EA670 800F9E70 40100300 */  sll        $v0, $v1, 1
    /* EA674 800F9E74 21104300 */  addu       $v0, $v0, $v1
    /* EA678 800F9E78 C46C238E */  lw         $v1, %lo(Cdinfo)($s1)
    /* EA67C 800F9E7C 40100200 */  sll        $v0, $v0, 1
    /* EA680 800F9E80 08006330 */  andi       $v1, $v1, 0x8
    /* EA684 800F9E84 10006010 */  beqz       $v1, .L800F9EC8
    /* EA688 800F9E88 180082AC */   sw        $v0, 0x18($a0)
    /* EA68C 800F9E8C F7FF0324 */  addiu      $v1, $zero, -0x9
    /* EA690 800F9E90 0C00058E */  lw         $a1, 0xC($s0)
    /* EA694 800F9E94 C46C228E */  lw         $v0, %lo(Cdinfo)($s1)
    /* EA698 800F9E98 0000068E */  lw         $a2, 0x0($s0)
    /* EA69C 800F9E9C 24104300 */  and        $v0, $v0, $v1
    /* EA6A0 800F9EA0 3C008324 */  addiu      $v1, $a0, 0x3C
    /* EA6A4 800F9EA4 C46C22AE */  sw         $v0, %lo(Cdinfo)($s1)
    /* EA6A8 800F9EA8 0800048E */  lw         $a0, 0x8($s0)
    /* EA6AC 800F9EAC C46C228E */  lw         $v0, %lo(Cdinfo)($s1)
    /* EA6B0 800F9EB0 21208300 */  addu       $a0, $a0, $v1
    /* EA6B4 800F9EB4 10004234 */  ori        $v0, $v0, 0x10
    /* EA6B8 800F9EB8 C46C22AE */  sw         $v0, %lo(Cdinfo)($s1)
    /* EA6BC 800F9EBC B798030C */  jal        blockmove
    /* EA6C0 800F9EC0 00000000 */   nop
    /* EA6C4 800F9EC4 080000AE */  sw         $zero, 0x8($s0)
  .L800F9EC8:
    /* EA6C8 800F9EC8 0400028E */  lw         $v0, 0x4($s0)
    /* EA6CC 800F9ECC 00000000 */  nop
    /* EA6D0 800F9ED0 16004018 */  blez       $v0, .L800F9F2C
    /* EA6D4 800F9ED4 00000000 */   nop
    /* EA6D8 800F9ED8 0C00028E */  lw         $v0, 0xC($s0)
    /* EA6DC 800F9EDC 0000038E */  lw         $v1, 0x0($s0)
    /* EA6E0 800F9EE0 0400048E */  lw         $a0, 0x4($s0)
    /* EA6E4 800F9EE4 21104300 */  addu       $v0, $v0, $v1
    /* EA6E8 800F9EE8 0C0002AE */  sw         $v0, 0xC($s0)
    /* EA6EC 800F9EEC 00088228 */  slti       $v0, $a0, 0x800
    /* EA6F0 800F9EF0 07004010 */  beqz       $v0, .L800F9F10
    /* EA6F4 800F9EF4 00080224 */   addiu     $v0, $zero, 0x800
    /* EA6F8 800F9EF8 C46C228E */  lw         $v0, %lo(Cdinfo)($s1)
    /* EA6FC 800F9EFC 000004AE */  sw         $a0, 0x0($s0)
    /* EA700 800F9F00 08004234 */  ori        $v0, $v0, 0x8
    /* EA704 800F9F04 C46C22AE */  sw         $v0, %lo(Cdinfo)($s1)
    /* EA708 800F9F08 C5E70308 */  j          .L800F9F14
    /* EA70C 800F9F0C 00000000 */   nop
  .L800F9F10:
    /* EA710 800F9F10 000002AE */  sw         $v0, 0x0($s0)
  .L800F9F14:
    /* EA714 800F9F14 0400028E */  lw         $v0, 0x4($s0)
    /* EA718 800F9F18 0000038E */  lw         $v1, 0x0($s0)
    /* EA71C 800F9F1C 00000000 */  nop
    /* EA720 800F9F20 23104300 */  subu       $v0, $v0, $v1
    /* EA724 800F9F24 D2E70308 */  j          .L800F9F48
    /* EA728 800F9F28 040002AE */   sw        $v0, 0x4($s0)
  .L800F9F2C:
    /* EA72C 800F9F2C D2E70308 */  j          .L800F9F48
    /* EA730 800F9F30 01001224 */   addiu     $s2, $zero, 0x1
  .L800F9F34:
    /* EA734 800F9F34 06DE030C */  jal        CdFlush
    /* EA738 800F9F38 00000000 */   nop
    /* EA73C 800F9F3C 21200000 */  addu       $a0, $zero, $zero
    /* EA740 800F9F40 13DE030C */  jal        CdSync
    /* EA744 800F9F44 21288000 */   addu      $a1, $a0, $zero
  .L800F9F48:
    /* EA748 800F9F48 37004012 */  beqz       $s2, .L800FA028
    /* EA74C 800F9F4C 1480043C */   lui       $a0, %hi(Cdinfo)
    /* EA750 800F9F50 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* EA754 800F9F54 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA758 800F9F58 C46C9124 */  addiu      $s1, $a0, %lo(Cdinfo)
    /* EA75C 800F9F5C 24104300 */  and        $v0, $v0, $v1
    /* EA760 800F9F60 C46C82AC */  sw         $v0, %lo(Cdinfo)($a0)
    /* EA764 800F9F64 1080043C */  lui        $a0, %hi(func_800F9C44)
    /* EA768 800F9F68 0C00228E */  lw         $v0, 0xC($s1)
    /* EA76C 800F9F6C 449C8424 */  addiu      $a0, $a0, %lo(func_800F9C44)
    /* EA770 800F9F70 180020AE */  sw         $zero, 0x18($s1)
    /* EA774 800F9F74 12AC030C */  jal        deltimer
    /* EA778 800F9F78 100022AE */   sw        $v0, 0x10($s1)
    /* EA77C 800F9F7C 3000228E */  lw         $v0, 0x30($s1)
    /* EA780 800F9F80 00000000 */  nop
    /* EA784 800F9F84 28004010 */  beqz       $v0, .L800FA028
    /* EA788 800F9F88 4001A427 */   addiu     $a0, $sp, 0x140
    /* EA78C 800F9F8C 1480103C */  lui        $s0, %hi(g_currentthread)
    /* EA790 800F9F90 02000224 */  addiu      $v0, $zero, 0x2
    /* EA794 800F9F94 24AC030C */  jal        savegp
    /* EA798 800F9F98 5CDD02AE */   sw        $v0, %lo(g_currentthread)($s0)
    /* EA79C 800F9F9C 3000228E */  lw         $v0, 0x30($s1)
    /* EA7A0 800F9FA0 00000000 */  nop
    /* EA7A4 800F9FA4 09F84000 */  jalr       $v0
    /* EA7A8 800F9FA8 01000424 */   addiu     $a0, $zero, 0x1
    /* EA7AC 800F9FAC 4001A48F */  lw         $a0, 0x140($sp)
    /* EA7B0 800F9FB0 29AC030C */  jal        restoregp
    /* EA7B4 800F9FB4 00000000 */   nop
    /* EA7B8 800F9FB8 0AE80308 */  j          .L800FA028
    /* EA7BC 800F9FBC 5CDD00AE */   sw        $zero, %lo(g_currentthread)($s0)
  .L800F9FC0:
    /* EA7C0 800F9FC0 E0FF028E */  lw         $v0, -0x20($s0)
    /* EA7C4 800F9FC4 00000000 */  nop
    /* EA7C8 800F9FC8 01004230 */  andi       $v0, $v0, 0x1
    /* EA7CC 800F9FCC 16004010 */  beqz       $v0, .L800FA028
    /* EA7D0 800F9FD0 E0FF1126 */   addiu     $s1, $s0, -0x20
    /* EA7D4 800F9FD4 01000424 */  addiu      $a0, $zero, 0x1
    /* EA7D8 800F9FD8 21280000 */  addu       $a1, $zero, $zero
    /* EA7DC 800F9FDC 2DDE030C */  jal        CdControl
    /* EA7E0 800F9FE0 1000A627 */   addiu     $a2, $sp, 0x10
    /* EA7E4 800F9FE4 1C00228E */  lw         $v0, 0x1C($s1)
    /* EA7E8 800F9FE8 0C00238E */  lw         $v1, 0xC($s1)
    /* EA7EC 800F9FEC 01004224 */  addiu      $v0, $v0, 0x1
    /* EA7F0 800F9FF0 1C0022AE */  sw         $v0, 0x1C($s1)
    /* EA7F4 800F9FF4 04004228 */  slti       $v0, $v0, 0x4
    /* EA7F8 800F9FF8 07004014 */  bnez       $v0, .L800FA018
    /* EA7FC 800F9FFC 140023AE */   sw        $v1, 0x14($s1)
    /* EA800 800FA000 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* EA804 800FA004 1C0022AE */  sw         $v0, 0x1C($s1)
    /* EA808 800FA008 09000424 */  addiu      $a0, $zero, 0x9
    /* EA80C 800FA00C 21280000 */  addu       $a1, $zero, $zero
    /* EA810 800FA010 49E80308 */  j          .L800FA124
    /* EA814 800FA014 2130A000 */   addu      $a2, $a1, $zero
  .L800FA018:
    /* EA818 800FA018 E0FF028E */  lw         $v0, -0x20($s0)
  .L800FA01C:
    /* EA81C 800FA01C 00000000 */  nop
    /* EA820 800FA020 02004234 */  ori        $v0, $v0, 0x2
    /* EA824 800FA024 E0FF02AE */  sw         $v0, -0x20($s0)
  .L800FA028:
    /* EA828 800FA028 1480043C */  lui        $a0, %hi(Cdinfo)
    /* EA82C 800FA02C C46C9124 */  addiu      $s1, $a0, %lo(Cdinfo)
  .L800FA030:
    /* EA830 800FA030 0C00228E */  lw         $v0, 0xC($s1)
    /* EA834 800FA034 00000000 */  nop
    /* EA838 800FA038 01004224 */  addiu      $v0, $v0, 0x1
    /* EA83C 800FA03C 0C0022AE */  sw         $v0, 0xC($s1)
    /* EA840 800FA040 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA844 800FA044 00000000 */  nop
    /* EA848 800FA048 02004230 */  andi       $v0, $v0, 0x2
    /* EA84C 800FA04C 22004010 */  beqz       $v0, .L800FA0D8
    /* EA850 800FA050 1480033C */   lui       $v1, %hi(Cdinfo)
    /* EA854 800FA054 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA858 800FA058 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* EA85C 800FA05C 24104300 */  and        $v0, $v0, $v1
    /* EA860 800FA060 C46C82AC */  sw         $v0, %lo(Cdinfo)($a0)
    /* EA864 800FA064 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA868 800FA068 EFFF0324 */  addiu      $v1, $zero, -0x11
    /* EA86C 800FA06C 24104300 */  and        $v0, $v0, $v1
    /* EA870 800FA070 C46C82AC */  sw         $v0, %lo(Cdinfo)($a0)
    /* EA874 800FA074 C46C828C */  lw         $v0, %lo(Cdinfo)($a0)
    /* EA878 800FA078 00000000 */  nop
    /* EA87C 800FA07C 01004234 */  ori        $v0, $v0, 0x1
    /* EA880 800FA080 C46C82AC */  sw         $v0, %lo(Cdinfo)($a0)
    /* EA884 800FA084 0C00238E */  lw         $v1, 0xC($s1)
    /* EA888 800FA088 1400228E */  lw         $v0, 0x14($s1)
    /* EA88C 800FA08C 00000000 */  nop
    /* EA890 800FA090 10006210 */  beq        $v1, $v0, .L800FA0D4
    /* EA894 800FA094 00000000 */   nop
    /* EA898 800FA098 06DE030C */  jal        CdFlush
    /* EA89C 800FA09C 00000000 */   nop
    /* EA8A0 800FA0A0 21200000 */  addu       $a0, $zero, $zero
    /* EA8A4 800FA0A4 13DE030C */  jal        CdSync
    /* EA8A8 800FA0A8 21288000 */   addu      $a1, $a0, $zero
    /* EA8AC 800FA0AC 3801B027 */  addiu      $s0, $sp, 0x138
    /* EA8B0 800FA0B0 1400248E */  lw         $a0, 0x14($s1)
    /* EA8B4 800FA0B4 21280002 */  addu       $a1, $s0, $zero
    /* EA8B8 800FA0B8 0C0024AE */  sw         $a0, 0xC($s1)
    /* EA8BC 800FA0BC 3DDF030C */  jal        CdIntToPos
    /* EA8C0 800FA0C0 00000000 */   nop
    /* EA8C4 800FA0C4 1B000424 */  addiu      $a0, $zero, 0x1B
    /* EA8C8 800FA0C8 21280002 */  addu       $a1, $s0, $zero
    /* EA8CC 800FA0CC 2DDE030C */  jal        CdControl
    /* EA8D0 800FA0D0 21306002 */   addu      $a2, $s3, $zero
  .L800FA0D4:
    /* EA8D4 800FA0D4 1480033C */  lui        $v1, %hi(Cdinfo)
  .L800FA0D8:
    /* EA8D8 800FA0D8 C46C628C */  lw         $v0, %lo(Cdinfo)($v1)
    /* EA8DC 800FA0DC 00000000 */  nop
    /* EA8E0 800FA0E0 01004230 */  andi       $v0, $v0, 0x1
    /* EA8E4 800FA0E4 11004014 */  bnez       $v0, .L800FA12C
    /* EA8E8 800FA0E8 C46C6324 */   addiu     $v1, $v1, %lo(Cdinfo)
    /* EA8EC 800FA0EC 0C00628C */  lw         $v0, 0xC($v1)
    /* EA8F0 800FA0F0 1000648C */  lw         $a0, 0x10($v1)
    /* EA8F4 800FA0F4 00000000 */  nop
    /* EA8F8 800FA0F8 23104400 */  subu       $v0, $v0, $a0
    /* EA8FC 800FA0FC 15004228 */  slti       $v0, $v0, 0x15
    /* EA900 800FA100 0A004014 */  bnez       $v0, .L800FA12C
    /* EA904 800FA104 00000000 */   nop
    /* EA908 800FA108 0C0064AC */  sw         $a0, 0xC($v1)
    /* EA90C 800FA10C 3801B027 */  addiu      $s0, $sp, 0x138
    /* EA910 800FA110 3DDF030C */  jal        CdIntToPos
    /* EA914 800FA114 21280002 */   addu      $a1, $s0, $zero
    /* EA918 800FA118 1B000424 */  addiu      $a0, $zero, 0x1B
    /* EA91C 800FA11C 21280002 */  addu       $a1, $s0, $zero
    /* EA920 800FA120 21306002 */  addu       $a2, $s3, $zero
  .L800FA124:
    /* EA924 800FA124 2DDE030C */  jal        CdControl
    /* EA928 800FA128 00000000 */   nop
  .L800FA12C:
    /* EA92C 800FA12C 1080043C */  lui        $a0, %hi(func_800F9CA4)
    /* EA930 800FA130 28DE030C */  jal        CdReadyCallback
    /* EA934 800FA134 A49C8424 */   addiu     $a0, $a0, %lo(func_800F9CA4)
  .L800FA138:
    /* EA938 800FA138 5801BF8F */  lw         $ra, 0x158($sp)
    /* EA93C 800FA13C 5401B38F */  lw         $s3, 0x154($sp)
    /* EA940 800FA140 5001B28F */  lw         $s2, 0x150($sp)
    /* EA944 800FA144 4C01B18F */  lw         $s1, 0x14C($sp)
    /* EA948 800FA148 4801B08F */  lw         $s0, 0x148($sp)
    /* EA94C 800FA14C 0800E003 */  jr         $ra
    /* EA950 800FA150 6001BD27 */   addiu     $sp, $sp, 0x160
endlabel func_800F9CA4
