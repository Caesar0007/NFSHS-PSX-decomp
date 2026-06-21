.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDialog__25tScreenPinkSlipsCarSelect, 0x290

glabel SetDialog__25tScreenPinkSlipsCarSelect
    /* 2FB00 8003F300 0580023C */  lui        $v0, %hi(FEApp)
    /* 2FB04 8003F304 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2FB08 8003F308 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2FB0C 8003F30C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2FB10 8003F310 21908000 */  addu       $s2, $a0, $zero
    /* 2FB14 8003F314 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 2FB18 8003F318 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2FB1C 8003F31C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FB20 8003F320 2C025090 */  lbu        $s0, 0x22C($v0)
    /* 2FB24 8003F324 00000000 */  nop
    /* 2FB28 8003F328 02000016 */  bnez       $s0, .L8003F334
    /* 2FB2C 8003F32C 3C000324 */   addiu     $v1, $zero, 0x3C
    /* 2FB30 8003F330 C4FF0324 */  addiu      $v1, $zero, -0x3C
  .L8003F334:
    /* 2FB34 8003F334 A0034226 */  addiu      $v0, $s2, 0x3A0
    /* 2FB38 8003F338 7C0040A4 */  sh         $zero, 0x7C($v0)
    /* 2FB3C 8003F33C 7E0043A4 */  sh         $v1, 0x7E($v0)
    /* 2FB40 8003F340 640050A4 */  sh         $s0, 0x64($v0)
    /* 2FB44 8003F344 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2FB48 8003F348 34204424 */  addiu      $a0, $v0, %lo(PinkSlipsScreenState)
    /* 2FB4C 8003F34C 3420438C */  lw         $v1, %lo(PinkSlipsScreenState)($v0)
    /* 2FB50 8003F350 06000224 */  addiu      $v0, $zero, 0x6
    /* 2FB54 8003F354 03006210 */  beq        $v1, $v0, .L8003F364
    /* 2FB58 8003F358 01000224 */   addiu     $v0, $zero, 0x1
    /* 2FB5C 8003F35C 17000212 */  beq        $s0, $v0, .L8003F3BC
    /* 2FB60 8003F360 00000000 */   nop
  .L8003F364:
    /* 2FB64 8003F364 4804428E */  lw         $v0, 0x448($s2)
    /* 2FB68 8003F368 00000000 */  nop
    /* 2FB6C 8003F36C 13004014 */  bnez       $v0, .L8003F3BC
    /* 2FB70 8003F370 80101000 */   sll       $v0, $s0, 2
    /* 2FB74 8003F374 21184400 */  addu       $v1, $v0, $a0
    /* 2FB78 8003F378 0000628C */  lw         $v0, 0x0($v1)
    /* 2FB7C 8003F37C 00000000 */  nop
    /* 2FB80 8003F380 02004010 */  beqz       $v0, .L8003F38C
    /* 2FB84 8003F384 00000000 */   nop
    /* 2FB88 8003F388 400440AE */  sw         $zero, 0x440($s2)
  .L8003F38C:
    /* 2FB8C 8003F38C 0000638C */  lw         $v1, 0x0($v1)
    /* 2FB90 8003F390 00000000 */  nop
    /* 2FB94 8003F394 0900622C */  sltiu      $v0, $v1, 0x9
    /* 2FB98 8003F398 77004010 */  beqz       $v0, .L8003F578
    /* 2FB9C 8003F39C 0180023C */   lui       $v0, %hi(jtbl_80011B38)
    /* 2FBA0 8003F3A0 381B4224 */  addiu      $v0, $v0, %lo(jtbl_80011B38)
    /* 2FBA4 8003F3A4 80180300 */  sll        $v1, $v1, 2
    /* 2FBA8 8003F3A8 21186200 */  addu       $v1, $v1, $v0
    /* 2FBAC 8003F3AC 0000628C */  lw         $v0, 0x0($v1)
    /* 2FBB0 8003F3B0 00000000 */  nop
    /* 2FBB4 8003F3B4 08004000 */  jr         $v0
    /* 2FBB8 8003F3B8 00000000 */   nop
  jlabel .L8003F3BC
    /* 2FBBC 8003F3BC 4162000C */  jal        Hide__11tDialogBase
    /* 2FBC0 8003F3C0 A0034426 */   addiu     $a0, $s2, 0x3A0
    /* 2FBC4 8003F3C4 5EFD0008 */  j          .L8003F578
    /* 2FBC8 8003F3C8 00000000 */   nop
  jlabel .L8003F3CC
    /* 2FBCC 8003F3CC 0580023C */  lui        $v0, %hi(FEApp)
    /* 2FBD0 8003F3D0 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2FBD4 8003F3D4 80181000 */  sll        $v1, $s0, 2
    /* 2FBD8 8003F3D8 21104300 */  addu       $v0, $v0, $v1
    /* 2FBDC 8003F3DC 3002428C */  lw         $v0, 0x230($v0)
    /* 2FBE0 8003F3E0 00000000 */  nop
    /* 2FBE4 8003F3E4 0A004014 */  bnez       $v0, .L8003F410
    /* 2FBE8 8003F3E8 0580033C */   lui       $v1, %hi(PinkSlipsScreenState)
    /* 2FBEC 8003F3EC 34206324 */  addiu      $v1, $v1, %lo(PinkSlipsScreenState)
    /* 2FBF0 8003F3F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 2FBF4 8003F3F4 23105000 */  subu       $v0, $v0, $s0
    /* 2FBF8 8003F3F8 80100200 */  sll        $v0, $v0, 2
    /* 2FBFC 8003F3FC 21104300 */  addu       $v0, $v0, $v1
    /* 2FC00 8003F400 0000438C */  lw         $v1, 0x0($v0)
    /* 2FC04 8003F404 06000224 */  addiu      $v0, $zero, 0x6
    /* 2FC08 8003F408 10006210 */  beq        $v1, $v0, .L8003F44C
    /* 2FC0C 8003F40C 00000000 */   nop
  .L8003F410:
    /* 2FC10 8003F410 94E4020C */  jal        TextSys_Word__Fi
    /* 2FC14 8003F414 A8020424 */   addiu     $a0, $zero, 0x2A8
    /* 2FC18 8003F418 01000424 */  addiu      $a0, $zero, 0x1
    /* 2FC1C 8003F41C 23209000 */  subu       $a0, $a0, $s0
    /* 2FC20 8003F420 7FAE000C */  jal        PlayerName__Fi
    /* 2FC24 8003F424 21884000 */   addu      $s1, $v0, $zero
    /* 2FC28 8003F428 0580103C */  lui        $s0, %hi(D_80052C58)
    /* 2FC2C 8003F42C 582C1026 */  addiu      $s0, $s0, %lo(D_80052C58)
    /* 2FC30 8003F430 21200002 */  addu       $a0, $s0, $zero
    /* 2FC34 8003F434 21282002 */  addu       $a1, $s1, $zero
    /* 2FC38 8003F438 2F91030C */  jal        sprintf
    /* 2FC3C 8003F43C 21304000 */   addu      $a2, $v0, $zero
    /* 2FC40 8003F440 A0034426 */  addiu      $a0, $s2, 0x3A0
    /* 2FC44 8003F444 5AFD0008 */  j          .L8003F568
    /* 2FC48 8003F448 900090AC */   sw        $s0, 0x90($a0)
  .L8003F44C:
    /* 2FC4C 8003F44C 4162000C */  jal        Hide__11tDialogBase
    /* 2FC50 8003F450 A0034426 */   addiu     $a0, $s2, 0x3A0
    /* 2FC54 8003F454 5DFD0008 */  j          .L8003F574
    /* 2FC58 8003F458 400440AE */   sw        $zero, 0x440($s2)
  jlabel .L8003F45C
    /* 2FC5C 8003F45C 4404428E */  lw         $v0, 0x444($s2)
    /* 2FC60 8003F460 00000000 */  nop
    /* 2FC64 8003F464 18004014 */  bnez       $v0, .L8003F4C8
    /* 2FC68 8003F468 00000000 */   nop
    /* 2FC6C 8003F46C 4004428E */  lw         $v0, 0x440($s2)
    /* 2FC70 8003F470 00000000 */  nop
    /* 2FC74 8003F474 05004014 */  bnez       $v0, .L8003F48C
    /* 2FC78 8003F478 1480023C */   lui       $v0, %hi(ticks)
    /* 2FC7C 8003F47C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2FC80 8003F480 00000000 */  nop
    /* 2FC84 8003F484 400442AE */  sw         $v0, 0x440($s2)
    /* 2FC88 8003F488 1480023C */  lui        $v0, %hi(ticks)
  .L8003F48C:
    /* 2FC8C 8003F48C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2FC90 8003F490 4004438E */  lw         $v1, 0x440($s2)
    /* 2FC94 8003F494 00000000 */  nop
    /* 2FC98 8003F498 23104300 */  subu       $v0, $v0, $v1
    /* 2FC9C 8003F49C 20034228 */  slti       $v0, $v0, 0x320
    /* 2FCA0 8003F4A0 02004014 */  bnez       $v0, .L8003F4AC
    /* 2FCA4 8003F4A4 AB020426 */   addiu     $a0, $s0, 0x2AB
    /* 2FCA8 8003F4A8 A9020426 */  addiu      $a0, $s0, 0x2A9
  .L8003F4AC:
    /* 2FCAC 8003F4AC 94E4020C */  jal        TextSys_Word__Fi
    /* 2FCB0 8003F4B0 A0035026 */   addiu     $s0, $s2, 0x3A0
    /* 2FCB4 8003F4B4 900002AE */  sw         $v0, 0x90($s0)
    /* 2FCB8 8003F4B8 1062000C */  jal        Display__11tDialogBase
    /* 2FCBC 8003F4BC 21200002 */   addu      $a0, $s0, $zero
    /* 2FCC0 8003F4C0 5EFD0008 */  j          .L8003F578
    /* 2FCC4 8003F4C4 00000000 */   nop
  .L8003F4C8:
    /* 2FCC8 8003F4C8 4004428E */  lw         $v0, 0x440($s2)
    /* 2FCCC 8003F4CC 00000000 */  nop
    /* 2FCD0 8003F4D0 05004014 */  bnez       $v0, .L8003F4E8
    /* 2FCD4 8003F4D4 1480023C */   lui       $v0, %hi(ticks)
    /* 2FCD8 8003F4D8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2FCDC 8003F4DC 00000000 */  nop
    /* 2FCE0 8003F4E0 400442AE */  sw         $v0, 0x440($s2)
    /* 2FCE4 8003F4E4 1480023C */  lui        $v0, %hi(ticks)
  .L8003F4E8:
    /* 2FCE8 8003F4E8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2FCEC 8003F4EC 4004438E */  lw         $v1, 0x440($s2)
    /* 2FCF0 8003F4F0 00000000 */  nop
    /* 2FCF4 8003F4F4 23104300 */  subu       $v0, $v0, $v1
    /* 2FCF8 8003F4F8 85034228 */  slti       $v0, $v0, 0x385
    /* 2FCFC 8003F4FC 1E004014 */  bnez       $v0, .L8003F578
    /* 2FD00 8003F500 00000000 */   nop
    /* 2FD04 8003F504 5DFD0008 */  j          .L8003F574
    /* 2FD08 8003F508 400440AE */   sw        $zero, 0x440($s2)
  jlabel .L8003F50C
    /* 2FD0C 8003F50C 48FD0008 */  j          .L8003F520
    /* 2FD10 8003F510 AF020426 */   addiu     $a0, $s0, 0x2AF
  jlabel .L8003F514
    /* 2FD14 8003F514 48FD0008 */  j          .L8003F520
    /* 2FD18 8003F518 B1020426 */   addiu     $a0, $s0, 0x2B1
  jlabel .L8003F51C
    /* 2FD1C 8003F51C AD020426 */  addiu      $a0, $s0, 0x2AD
  .L8003F520:
    /* 2FD20 8003F520 94E4020C */  jal        TextSys_Word__Fi
    /* 2FD24 8003F524 A0035026 */   addiu     $s0, $s2, 0x3A0
    /* 2FD28 8003F528 21200002 */  addu       $a0, $s0, $zero
    /* 2FD2C 8003F52C 1062000C */  jal        Display__11tDialogBase
    /* 2FD30 8003F530 900082AC */   sw        $v0, 0x90($a0)
    /* 2FD34 8003F534 01000224 */  addiu      $v0, $zero, 0x1
    /* 2FD38 8003F538 440442AE */  sw         $v0, 0x444($s2)
    /* 2FD3C 8003F53C 5EFD0008 */  j          .L8003F578
    /* 2FD40 8003F540 400440AE */   sw        $zero, 0x440($s2)
  jlabel .L8003F544
    /* 2FD44 8003F544 56FD0008 */  j          .L8003F558
    /* 2FD48 8003F548 2D030426 */   addiu     $a0, $s0, 0x32D
  jlabel .L8003F54C
    /* 2FD4C 8003F54C 56FD0008 */  j          .L8003F558
    /* 2FD50 8003F550 2F030426 */   addiu     $a0, $s0, 0x32F
  jlabel .L8003F554
    /* 2FD54 8003F554 80020426 */  addiu      $a0, $s0, 0x280
  .L8003F558:
    /* 2FD58 8003F558 94E4020C */  jal        TextSys_Word__Fi
    /* 2FD5C 8003F55C A0035026 */   addiu     $s0, $s2, 0x3A0
    /* 2FD60 8003F560 21200002 */  addu       $a0, $s0, $zero
    /* 2FD64 8003F564 900082AC */  sw         $v0, 0x90($a0)
  .L8003F568:
    /* 2FD68 8003F568 1062000C */  jal        Display__11tDialogBase
    /* 2FD6C 8003F56C 00000000 */   nop
    /* 2FD70 8003F570 400440AE */  sw         $zero, 0x440($s2)
  .L8003F574:
    /* 2FD74 8003F574 440440AE */  sw         $zero, 0x444($s2)
  .L8003F578:
    /* 2FD78 8003F578 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 2FD7C 8003F57C 1800B28F */  lw         $s2, 0x18($sp)
    /* 2FD80 8003F580 1400B18F */  lw         $s1, 0x14($sp)
    /* 2FD84 8003F584 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FD88 8003F588 0800E003 */  jr         $ra
    /* 2FD8C 8003F58C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetDialog__25tScreenPinkSlipsCarSelect
