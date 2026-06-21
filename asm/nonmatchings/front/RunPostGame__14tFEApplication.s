.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RunPostGame__14tFEApplication, 0x308

glabel RunPostGame__14tFEApplication
    /* 5C30 80015430 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 5C34 80015434 2800B2AF */  sw         $s2, 0x28($sp)
    /* 5C38 80015438 1180023C */  lui        $v0, %hi(frontEnd)
    /* 5C3C 8001543C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 5C40 80015440 00465024 */  addiu      $s0, $v0, %lo(frontEnd)
    /* 5C44 80015444 3800BFAF */  sw         $ra, 0x38($sp)
    /* 5C48 80015448 3400B5AF */  sw         $s5, 0x34($sp)
    /* 5C4C 8001544C 3000B4AF */  sw         $s4, 0x30($sp)
    /* 5C50 80015450 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 5C54 80015454 2400B1AF */  sw         $s1, 0x24($sp)
    /* 5C58 80015458 04000392 */  lbu        $v1, 0x4($s0)
    /* 5C5C 8001545C 06000224 */  addiu      $v0, $zero, 0x6
    /* 5C60 80015460 A6006210 */  beq        $v1, $v0, .L800156FC
    /* 5C64 80015464 21908000 */   addu      $s2, $a0, $zero
    /* 5C68 80015468 05006014 */  bnez       $v1, .L80015480
    /* 5C6C 8001546C 1180023C */   lui       $v0, %hi(Cars_gNewCarStatsList)
    /* 5C70 80015470 2A010292 */  lbu        $v0, 0x12A($s0)
    /* 5C74 80015474 00000000 */  nop
    /* 5C78 80015478 A0004010 */  beqz       $v0, .L800156FC
    /* 5C7C 8001547C 1180023C */   lui       $v0, %hi(Cars_gNewCarStatsList)
  .L80015480:
    /* 5C80 80015480 0E2A010C */  jal        StatChk_ClearNewRecords__Fv
    /* 5C84 80015484 44FB5524 */   addiu     $s5, $v0, %lo(Cars_gNewCarStatsList)
    /* 5C88 80015488 21880000 */  addu       $s1, $zero, $zero
    /* 5C8C 8001548C 21A00002 */  addu       $s4, $s0, $zero
    /* 5C90 80015490 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 5C94 80015494 21804002 */  addu       $s0, $s2, $zero
  .L80015498:
    /* 5C98 80015498 21202002 */  addu       $a0, $s1, $zero
    /* 5C9C 8001549C 21103402 */  addu       $v0, $s1, $s4
    /* 5CA0 800154A0 62034590 */  lbu        $a1, 0x362($v0)
    /* 5CA4 800154A4 399C000C */  jal        Front_ResetPSXController__Fii
    /* 5CA8 800154A8 01003126 */   addiu     $s1, $s1, 0x1
    /* 5CAC 800154AC 680300AE */  sw         $zero, 0x368($s0)
    /* 5CB0 800154B0 700300AE */  sw         $zero, 0x370($s0)
    /* 5CB4 800154B4 780313AE */  sw         $s3, 0x378($s0)
    /* 5CB8 800154B8 0200222A */  slti       $v0, $s1, 0x2
    /* 5CBC 800154BC F6FF4014 */  bnez       $v0, .L80015498
    /* 5CC0 800154C0 04001026 */   addiu     $s0, $s0, 0x4
    /* 5CC4 800154C4 2120A002 */  addu       $a0, $s5, $zero
    /* 5CC8 800154C8 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* 5CCC 800154CC F8C74584 */  lh         $a1, %lo(Cars_gNumRaceCars)($v0)
    /* 5CD0 800154D0 1026010C */  jal        StatChk_IsRecordLapTime__FP10Car_tStatssPs
    /* 5CD4 800154D4 1800A627 */   addiu     $a2, $sp, 0x18
    /* 5CD8 800154D8 17004010 */  beqz       $v0, .L80015538
    /* 5CDC 800154DC 1180023C */   lui       $v0, %hi(D_80114603)
    /* 5CE0 800154E0 03464390 */  lbu        $v1, %lo(D_80114603)($v0)
    /* 5CE4 800154E4 01000224 */  addiu      $v0, $zero, 0x1
    /* 5CE8 800154E8 09006214 */  bne        $v1, $v0, .L80015510
    /* 5CEC 800154EC 06000324 */   addiu     $v1, $zero, 0x6
    /* 5CF0 800154F0 1800A387 */  lh         $v1, 0x18($sp)
    /* 5CF4 800154F4 07000424 */  addiu      $a0, $zero, 0x7
    /* 5CF8 800154F8 80100300 */  sll        $v0, $v1, 2
    /* 5CFC 800154FC 02006010 */  beqz       $v1, .L80015508
    /* 5D00 80015500 21104202 */   addu      $v0, $s2, $v0
    /* 5D04 80015504 08000424 */  addiu      $a0, $zero, 0x8
  .L80015508:
    /* 5D08 80015508 49550008 */  j          .L80015524
    /* 5D0C 8001550C 780344AC */   sw        $a0, 0x378($v0)
  .L80015510:
    /* 5D10 80015510 1800A287 */  lh         $v0, 0x18($sp)
    /* 5D14 80015514 00000000 */  nop
    /* 5D18 80015518 80100200 */  sll        $v0, $v0, 2
    /* 5D1C 8001551C 21104202 */  addu       $v0, $s2, $v0
    /* 5D20 80015520 780343AC */  sw         $v1, 0x378($v0)
  .L80015524:
    /* 5D24 80015524 1800A287 */  lh         $v0, 0x18($sp)
    /* 5D28 80015528 01000324 */  addiu      $v1, $zero, 0x1
    /* 5D2C 8001552C 80100200 */  sll        $v0, $v0, 2
    /* 5D30 80015530 21104202 */  addu       $v0, $s2, $v0
    /* 5D34 80015534 700343AC */  sw         $v1, 0x370($v0)
  .L80015538:
    /* 5D38 80015538 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* 5D3C 8001553C F8C74584 */  lh         $a1, %lo(Cars_gNumRaceCars)($v0)
    /* 5D40 80015540 4327010C */  jal        StatChk_IsTopTime__FP10Car_tStatss
    /* 5D44 80015544 2120A002 */   addu      $a0, $s5, $zero
    /* 5D48 80015548 00140200 */  sll        $v0, $v0, 16
    /* 5D4C 8001554C 03240200 */  sra        $a0, $v0, 16
    /* 5D50 80015550 41008010 */  beqz       $a0, .L80015658
    /* 5D54 80015554 1180023C */   lui       $v0, %hi(D_80114603)
    /* 5D58 80015558 03464290 */  lbu        $v0, %lo(D_80114603)($v0)
    /* 5D5C 8001555C 01000324 */  addiu      $v1, $zero, 0x1
    /* 5D60 80015560 2F004314 */  bne        $v0, $v1, .L80015620
    /* 5D64 80015564 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 5D68 80015568 03008230 */  andi       $v0, $a0, 0x3
    /* 5D6C 8001556C 12004010 */  beqz       $v0, .L800155B8
    /* 5D70 80015570 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 5D74 80015574 700343AE */  sw         $v1, 0x370($s2)
    /* 5D78 80015578 7803438E */  lw         $v1, 0x378($s2)
    /* 5D7C 8001557C 00000000 */  nop
    /* 5D80 80015580 09006210 */  beq        $v1, $v0, .L800155A8
    /* 5D84 80015584 02008230 */   andi      $v0, $a0, 0x2
    /* 5D88 80015588 1800A287 */  lh         $v0, 0x18($sp)
    /* 5D8C 8001558C 00000000 */  nop
    /* 5D90 80015590 05004014 */  bnez       $v0, .L800155A8
    /* 5D94 80015594 02008230 */   andi      $v0, $a0, 0x2
    /* 5D98 80015598 06004014 */  bnez       $v0, .L800155B4
    /* 5D9C 8001559C 0A000224 */   addiu     $v0, $zero, 0xA
    /* 5DA0 800155A0 6D550008 */  j          .L800155B4
    /* 5DA4 800155A4 0D000224 */   addiu     $v0, $zero, 0xD
  .L800155A8:
    /* 5DA8 800155A8 02004014 */  bnez       $v0, .L800155B4
    /* 5DAC 800155AC 01000224 */   addiu     $v0, $zero, 0x1
    /* 5DB0 800155B0 04000224 */  addiu      $v0, $zero, 0x4
  .L800155B4:
    /* 5DB4 800155B4 780342AE */  sw         $v0, 0x378($s2)
  .L800155B8:
    /* 5DB8 800155B8 0C008230 */  andi       $v0, $a0, 0xC
    /* 5DBC 800155BC 26004010 */  beqz       $v0, .L80015658
    /* 5DC0 800155C0 01000524 */   addiu     $a1, $zero, 0x1
    /* 5DC4 800155C4 7C03438E */  lw         $v1, 0x37C($s2)
    /* 5DC8 800155C8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 5DCC 800155CC 0C006210 */  beq        $v1, $v0, .L80015600
    /* 5DD0 800155D0 740345AE */   sw        $a1, 0x374($s2)
    /* 5DD4 800155D4 1800A287 */  lh         $v0, 0x18($sp)
    /* 5DD8 800155D8 00000000 */  nop
    /* 5DDC 800155DC 09004514 */  bne        $v0, $a1, .L80015604
    /* 5DE0 800155E0 08008230 */   andi      $v0, $a0, 0x8
    /* 5DE4 800155E4 03004010 */  beqz       $v0, .L800155F4
    /* 5DE8 800155E8 0B000224 */   addiu     $v0, $zero, 0xB
    /* 5DEC 800155EC 96550008 */  j          .L80015658
    /* 5DF0 800155F0 7C0342AE */   sw        $v0, 0x37C($s2)
  .L800155F4:
    /* 5DF4 800155F4 0E000224 */  addiu      $v0, $zero, 0xE
    /* 5DF8 800155F8 96550008 */  j          .L80015658
    /* 5DFC 800155FC 7C0342AE */   sw        $v0, 0x37C($s2)
  .L80015600:
    /* 5E00 80015600 08008230 */  andi       $v0, $a0, 0x8
  .L80015604:
    /* 5E04 80015604 03004010 */  beqz       $v0, .L80015614
    /* 5E08 80015608 02000224 */   addiu     $v0, $zero, 0x2
    /* 5E0C 8001560C 96550008 */  j          .L80015658
    /* 5E10 80015610 7C0342AE */   sw        $v0, 0x37C($s2)
  .L80015614:
    /* 5E14 80015614 05000224 */  addiu      $v0, $zero, 0x5
    /* 5E18 80015618 96550008 */  j          .L80015658
    /* 5E1C 8001561C 7C0342AE */   sw        $v0, 0x37C($s2)
  .L80015620:
    /* 5E20 80015620 700343AE */  sw         $v1, 0x370($s2)
    /* 5E24 80015624 7803438E */  lw         $v1, 0x378($s2)
    /* 5E28 80015628 00000000 */  nop
    /* 5E2C 8001562C 05006210 */  beq        $v1, $v0, .L80015644
    /* 5E30 80015630 02008230 */   andi      $v0, $a0, 0x2
    /* 5E34 80015634 07004014 */  bnez       $v0, .L80015654
    /* 5E38 80015638 09000224 */   addiu     $v0, $zero, 0x9
    /* 5E3C 8001563C 95550008 */  j          .L80015654
    /* 5E40 80015640 0C000224 */   addiu     $v0, $zero, 0xC
  .L80015644:
    /* 5E44 80015644 03004010 */  beqz       $v0, .L80015654
    /* 5E48 80015648 03000224 */   addiu     $v0, $zero, 0x3
    /* 5E4C 8001564C 96550008 */  j          .L80015658
    /* 5E50 80015650 780340AE */   sw        $zero, 0x378($s2)
  .L80015654:
    /* 5E54 80015654 780342AE */  sw         $v0, 0x378($s2)
  .L80015658:
    /* 5E58 80015658 7003428E */  lw         $v0, 0x370($s2)
    /* 5E5C 8001565C 00000000 */  nop
    /* 5E60 80015660 11004010 */  beqz       $v0, .L800156A8
    /* 5E64 80015664 0580023C */   lui       $v0, %hi(menuDefs)
    /* 5E68 80015668 21204002 */  addu       $a0, $s2, $zero
    /* 5E6C 8001566C 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 5E70 80015670 1180023C */  lui        $v0, %hi(D_80114964)
    /* 5E74 80015674 64494224 */  addiu      $v0, $v0, %lo(D_80114964)
    /* 5E78 80015678 D0366524 */  addiu      $a1, $v1, 0x36D0
    /* 5E7C 8001567C B8316324 */  addiu      $v1, $v1, 0x31B8
    /* 5E80 80015680 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 5E84 80015684 0580023C */  lui        $v0, %hi(screenUserName)
    /* 5E88 80015688 B429468C */  lw         $a2, %lo(screenUserName)($v0)
    /* 5E8C 8001568C 07000224 */  addiu      $v0, $zero, 0x7
    /* 5E90 80015690 800060A4 */  sh         $zero, 0x80($v1)
    /* 5E94 80015694 200062A4 */  sh         $v0, 0x20($v1)
    /* 5E98 80015698 240060A4 */  sh         $zero, 0x24($v1)
    /* 5E9C 8001569C 220060A4 */  sh         $zero, 0x22($v1)
    /* 5EA0 800156A0 C3550008 */  j          .L8001570C
    /* 5EA4 800156A4 6400C5AC */   sw        $a1, 0x64($a2)
  .L800156A8:
    /* 5EA8 800156A8 7403428E */  lw         $v0, 0x374($s2)
    /* 5EAC 800156AC 00000000 */  nop
    /* 5EB0 800156B0 12004010 */  beqz       $v0, .L800156FC
    /* 5EB4 800156B4 0580023C */   lui       $v0, %hi(menuDefs)
    /* 5EB8 800156B8 21204002 */  addu       $a0, $s2, $zero
    /* 5EBC 800156BC 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 5EC0 800156C0 01000224 */  addiu      $v0, $zero, 0x1
    /* 5EC4 800156C4 50376524 */  addiu      $a1, $v1, 0x3750
    /* 5EC8 800156C8 44326324 */  addiu      $v1, $v1, 0x3244
    /* 5ECC 800156CC 800062A4 */  sh         $v0, 0x80($v1)
    /* 5ED0 800156D0 1180023C */  lui        $v0, %hi(D_8011496C)
    /* 5ED4 800156D4 6C494224 */  addiu      $v0, $v0, %lo(D_8011496C)
    /* 5ED8 800156D8 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 5EDC 800156DC 0580023C */  lui        $v0, %hi(screenUserName)
    /* 5EE0 800156E0 B429468C */  lw         $a2, %lo(screenUserName)($v0)
    /* 5EE4 800156E4 07000224 */  addiu      $v0, $zero, 0x7
    /* 5EE8 800156E8 200062A4 */  sh         $v0, 0x20($v1)
    /* 5EEC 800156EC 240060A4 */  sh         $zero, 0x24($v1)
    /* 5EF0 800156F0 220060A4 */  sh         $zero, 0x22($v1)
    /* 5EF4 800156F4 C3550008 */  j          .L8001570C
    /* 5EF8 800156F8 6400C5AC */   sw        $a1, 0x64($a2)
  .L800156FC:
    /* 5EFC 800156FC C1B6000C */  jal        MenuExtended_PostGameMenu__FR12tMenuCommand
    /* 5F00 80015700 1000A427 */   addiu     $a0, $sp, 0x10
    /* 5F04 80015704 1400A58F */  lw         $a1, 0x14($sp)
    /* 5F08 80015708 21204002 */  addu       $a0, $s2, $zero
  .L8001570C:
    /* 5F0C 8001570C A950000C */  jal        MainLoop__14tFEApplicationP5tMenu
    /* 5F10 80015710 00000000 */   nop
    /* 5F14 80015714 3800BF8F */  lw         $ra, 0x38($sp)
    /* 5F18 80015718 3400B58F */  lw         $s5, 0x34($sp)
    /* 5F1C 8001571C 3000B48F */  lw         $s4, 0x30($sp)
    /* 5F20 80015720 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 5F24 80015724 2800B28F */  lw         $s2, 0x28($sp)
    /* 5F28 80015728 2400B18F */  lw         $s1, 0x24($sp)
    /* 5F2C 8001572C 2000B08F */  lw         $s0, 0x20($sp)
    /* 5F30 80015730 0800E003 */  jr         $ra
    /* 5F34 80015734 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel RunPostGame__14tFEApplication
