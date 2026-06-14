.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EEB5C, 0x230

glabel func_800EEB5C
    /* DF35C 800EEB5C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DF360 800EEB60 21408000 */  addu       $t0, $a0, $zero
    /* DF364 800EEB64 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DF368 800EEB68 1800B2AF */  sw         $s2, 0x18($sp)
    /* DF36C 800EEB6C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DF370 800EEB70 1000B0AF */  sw         $s0, 0x10($sp)
    /* DF374 800EEB74 04000385 */  lh         $v1, 0x4($t0)
    /* DF378 800EEB78 04000495 */  lhu        $a0, 0x4($t0)
    /* DF37C 800EEB7C 0C006004 */  bltz       $v1, .L800EEBB0
    /* DF380 800EEB80 2148A000 */   addu      $t1, $a1, $zero
    /* DF384 800EEB84 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DF388 800EEB88 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DF38C 800EEB8C 00000000 */  nop
    /* DF390 800EEB90 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF394 800EEB94 2A104300 */  slt        $v0, $v0, $v1
    /* DF398 800EEB98 1280033C */  lui        $v1, %hi(D_801236A0)
    /* DF39C 800EEB9C A0366394 */  lhu        $v1, %lo(D_801236A0)($v1)
    /* DF3A0 800EEBA0 04004014 */  bnez       $v0, .L800EEBB4
    /* DF3A4 800EEBA4 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* DF3A8 800EEBA8 EDBA0308 */  j          .L800EEBB4
    /* DF3AC 800EEBAC 21108000 */   addu      $v0, $a0, $zero
  .L800EEBB0:
    /* DF3B0 800EEBB0 21100000 */  addu       $v0, $zero, $zero
  .L800EEBB4:
    /* DF3B4 800EEBB4 06000385 */  lh         $v1, 0x6($t0)
    /* DF3B8 800EEBB8 06000495 */  lhu        $a0, 0x6($t0)
    /* DF3BC 800EEBBC 0C006004 */  bltz       $v1, .L800EEBF0
    /* DF3C0 800EEBC0 040002A5 */   sh        $v0, 0x4($t0)
    /* DF3C4 800EEBC4 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DF3C8 800EEBC8 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DF3CC 800EEBCC 00000000 */  nop
    /* DF3D0 800EEBD0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF3D4 800EEBD4 2A104300 */  slt        $v0, $v0, $v1
    /* DF3D8 800EEBD8 1280033C */  lui        $v1, %hi(D_801236A2)
    /* DF3DC 800EEBDC A2366394 */  lhu        $v1, %lo(D_801236A2)($v1)
    /* DF3E0 800EEBE0 04004014 */  bnez       $v0, .L800EEBF4
    /* DF3E4 800EEBE4 FFFF6324 */   addiu     $v1, $v1, -0x1
    /* DF3E8 800EEBE8 FDBA0308 */  j          .L800EEBF4
    /* DF3EC 800EEBEC 21188000 */   addu      $v1, $a0, $zero
  .L800EEBF0:
    /* DF3F0 800EEBF0 21180000 */  addu       $v1, $zero, $zero
  .L800EEBF4:
    /* DF3F4 800EEBF4 00000295 */  lhu        $v0, 0x0($t0)
    /* DF3F8 800EEBF8 00000000 */  nop
    /* DF3FC 800EEBFC 3F004230 */  andi       $v0, $v0, 0x3F
    /* DF400 800EEC00 06004014 */  bnez       $v0, .L800EEC1C
    /* DF404 800EEC04 060003A5 */   sh        $v1, 0x6($t0)
    /* DF408 800EEC08 04000295 */  lhu        $v0, 0x4($t0)
    /* DF40C 800EEC0C 00000000 */  nop
    /* DF410 800EEC10 3F004230 */  andi       $v0, $v0, 0x3F
    /* DF414 800EEC14 37004010 */  beqz       $v0, .L800EECF4
    /* DF418 800EEC18 FF05023C */   lui       $v0, (0x5FFFFFF >> 16)
  .L800EEC1C:
    /* DF41C 800EEC1C FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* DF420 800EEC20 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* DF424 800EEC24 FFE4043C */  lui        $a0, (0xE4FFFFFF >> 16)
    /* DF428 800EEC28 FFFF8434 */  ori        $a0, $a0, (0xE4FFFFFF & 0xFFFF)
    /* DF42C 800EEC2C FF03073C */  lui        $a3, (0x3FFFFFF >> 16)
    /* DF430 800EEC30 1480053C */  lui        $a1, %hi(D_8013EAB0)
    /* DF434 800EEC34 B0EAA524 */  addiu      $a1, $a1, %lo(D_8013EAB0)
    /* DF438 800EEC38 1480103C */  lui        $s0, %hi(D_8013EAD8)
    /* DF43C 800EEC3C D8EA1026 */  addiu      $s0, $s0, %lo(D_8013EAD8)
    /* DF440 800EEC40 24100602 */  and        $v0, $s0, $a2
    /* DF444 800EEC44 0008033C */  lui        $v1, (0x8000000 >> 16)
    /* DF448 800EEC48 25104300 */  or         $v0, $v0, $v1
    /* DF44C 800EEC4C 00E3113C */  lui        $s1, (0xE3000000 >> 16)
    /* DF450 800EEC50 00E5123C */  lui        $s2, (0xE5000000 >> 16)
    /* DF454 800EEC54 0000A2AC */  sw         $v0, 0x0($a1)
    /* DF458 800EEC58 00E6023C */  lui        $v0, (0xE6000000 >> 16)
    /* DF45C 800EEC5C 24302601 */  and        $a2, $t1, $a2
    /* DF460 800EEC60 0060033C */  lui        $v1, (0x60000000 >> 16)
    /* DF464 800EEC64 2530C300 */  or         $a2, $a2, $v1
    /* DF468 800EEC68 1000A2AC */  sw         $v0, 0x10($a1)
    /* DF46C 800EEC6C 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF470 800EEC70 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF474 800EEC74 00E1033C */  lui        $v1, (0xE1000000 >> 16)
    /* DF478 800EEC78 0400B1AC */  sw         $s1, 0x4($a1)
    /* DF47C 800EEC7C 0800A4AC */  sw         $a0, 0x8($a1)
    /* DF480 800EEC80 0C00B2AC */  sw         $s2, 0xC($a1)
    /* DF484 800EEC84 0000448C */  lw         $a0, 0x0($v0)
    /* DF488 800EEC88 C2170900 */  srl        $v0, $t1, 31
    /* DF48C 800EEC8C 80120200 */  sll        $v0, $v0, 10
    /* DF490 800EEC90 25104300 */  or         $v0, $v0, $v1
    /* DF494 800EEC94 1800A6AC */  sw         $a2, 0x18($a1)
    /* DF498 800EEC98 FF078430 */  andi       $a0, $a0, 0x7FF
    /* DF49C 800EEC9C 25208200 */  or         $a0, $a0, $v0
    /* DF4A0 800EECA0 1400A4AC */  sw         $a0, 0x14($a1)
    /* DF4A4 800EECA4 0000028D */  lw         $v0, 0x0($t0)
    /* DF4A8 800EECA8 FFFFE734 */  ori        $a3, $a3, (0x3FFFFFF & 0xFFFF)
    /* DF4AC 800EECAC 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* DF4B0 800EECB0 0400028D */  lw         $v0, 0x4($t0)
    /* DF4B4 800EECB4 03000424 */  addiu      $a0, $zero, 0x3
    /* DF4B8 800EECB8 000007AE */  sw         $a3, 0x0($s0)
    /* DF4BC 800EECBC C2BC030C */  jal        func_800EF308
    /* DF4C0 800EECC0 2000A2AC */   sw        $v0, 0x20($a1)
    /* DF4C4 800EECC4 04000424 */  addiu      $a0, $zero, 0x4
    /* DF4C8 800EECC8 25105100 */  or         $v0, $v0, $s1
    /* DF4CC 800EECCC C2BC030C */  jal        func_800EF308
    /* DF4D0 800EECD0 040002AE */   sw        $v0, 0x4($s0)
    /* DF4D4 800EECD4 05000424 */  addiu      $a0, $zero, 0x5
    /* DF4D8 800EECD8 00E4033C */  lui        $v1, (0xE4000000 >> 16)
    /* DF4DC 800EECDC 25104300 */  or         $v0, $v0, $v1
    /* DF4E0 800EECE0 C2BC030C */  jal        func_800EF308
    /* DF4E4 800EECE4 080002AE */   sw        $v0, 0x8($s0)
    /* DF4E8 800EECE8 25105200 */  or         $v0, $v0, $s2
    /* DF4EC 800EECEC 59BB0308 */  j          .L800EED64
    /* DF4F0 800EECF0 0C0002AE */   sw        $v0, 0xC($s0)
  .L800EECF4:
    /* DF4F4 800EECF4 FFFF4234 */  ori        $v0, $v0, (0x5FFFFFF & 0xFFFF)
    /* DF4F8 800EECF8 FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* DF4FC 800EECFC FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* DF500 800EED00 1480063C */  lui        $a2, %hi(D_8013EAB0)
    /* DF504 800EED04 B0EAC624 */  addiu      $a2, $a2, %lo(D_8013EAB0)
    /* DF508 800EED08 0000C2AC */  sw         $v0, 0x0($a2)
    /* DF50C 800EED0C 00E6023C */  lui        $v0, (0xE6000000 >> 16)
    /* DF510 800EED10 24182301 */  and        $v1, $t1, $v1
    /* DF514 800EED14 0002053C */  lui        $a1, (0x2000000 >> 16)
    /* DF518 800EED18 0400C2AC */  sw         $v0, 0x4($a2)
    /* DF51C 800EED1C 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF520 800EED20 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF524 800EED24 25186500 */  or         $v1, $v1, $a1
    /* DF528 800EED28 0000448C */  lw         $a0, 0x0($v0)
    /* DF52C 800EED2C C2170900 */  srl        $v0, $t1, 31
    /* DF530 800EED30 80120200 */  sll        $v0, $v0, 10
    /* DF534 800EED34 0C00C3AC */  sw         $v1, 0xC($a2)
    /* DF538 800EED38 00E1033C */  lui        $v1, (0xE1000000 >> 16)
    /* DF53C 800EED3C 25104300 */  or         $v0, $v0, $v1
    /* DF540 800EED40 FF078430 */  andi       $a0, $a0, 0x7FF
    /* DF544 800EED44 25208200 */  or         $a0, $a0, $v0
    /* DF548 800EED48 0800C4AC */  sw         $a0, 0x8($a2)
    /* DF54C 800EED4C 0000028D */  lw         $v0, 0x0($t0)
    /* DF550 800EED50 00000000 */  nop
    /* DF554 800EED54 1000C2AC */  sw         $v0, 0x10($a2)
    /* DF558 800EED58 0400028D */  lw         $v0, 0x4($t0)
    /* DF55C 800EED5C 00000000 */  nop
    /* DF560 800EED60 1400C2AC */  sw         $v0, 0x14($a2)
  .L800EED64:
    /* DF564 800EED64 1480043C */  lui        $a0, %hi(D_8013EAB0)
    /* DF568 800EED68 B0BC030C */  jal        func_800EF2C0
    /* DF56C 800EED6C B0EA8424 */   addiu     $a0, $a0, %lo(D_8013EAB0)
    /* DF570 800EED70 21100000 */  addu       $v0, $zero, $zero
    /* DF574 800EED74 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DF578 800EED78 1800B28F */  lw         $s2, 0x18($sp)
    /* DF57C 800EED7C 1400B18F */  lw         $s1, 0x14($sp)
    /* DF580 800EED80 1000B08F */  lw         $s0, 0x10($sp)
    /* DF584 800EED84 0800E003 */  jr         $ra
    /* DF588 800EED88 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800EEB5C
