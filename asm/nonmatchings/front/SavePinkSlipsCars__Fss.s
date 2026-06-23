.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SavePinkSlipsCars__Fss, 0x388

glabel SavePinkSlipsCars__Fss
    /* 25BF0 800353F0 98E9BD27 */  addiu      $sp, $sp, -0x1668
    /* 25BF4 800353F4 4016B0AF */  sw         $s0, 0x1640($sp)
    /* 25BF8 800353F8 21808000 */  addu       $s0, $a0, $zero
    /* 25BFC 800353FC 6016BEAF */  sw         $fp, 0x1660($sp)
    /* 25C00 80035400 21F00002 */  addu       $fp, $s0, $zero
    /* 25C04 80035404 6416BFAF */  sw         $ra, 0x1664($sp)
    /* 25C08 80035408 5C16B7AF */  sw         $s7, 0x165C($sp)
    /* 25C0C 8003540C 5816B6AF */  sw         $s6, 0x1658($sp)
    /* 25C10 80035410 5416B5AF */  sw         $s5, 0x1654($sp)
    /* 25C14 80035414 5016B4AF */  sw         $s4, 0x1650($sp)
    /* 25C18 80035418 4C16B3AF */  sw         $s3, 0x164C($sp)
    /* 25C1C 8003541C 4816B2AF */  sw         $s2, 0x1648($sp)
    /* 25C20 80035420 4416B1AF */  sw         $s1, 0x1644($sp)
    /* 25C24 80035424 FCD0000C */  jal        MakeWayForMemoryCard__Fv
    /* 25C28 80035428 3016A5A7 */   sh        $a1, 0x1630($sp)
    /* 25C2C 8003542C 00841000 */  sll        $s0, $s0, 16
    /* 25C30 80035430 03841000 */  sra        $s0, $s0, 16
    /* 25C34 80035434 80101000 */  sll        $v0, $s0, 2
    /* 25C38 80035438 01004224 */  addiu      $v0, $v0, 0x1
    /* 25C3C 8003543C 21980000 */  addu       $s3, $zero, $zero
    /* 25C40 80035440 21A86002 */  addu       $s5, $s3, $zero
    /* 25C44 80035444 21906002 */  addu       $s2, $s3, $zero
    /* 25C48 80035448 C015B127 */  addiu      $s1, $sp, 0x15C0
    /* 25C4C 8003544C 21202002 */  addu       $a0, $s1, $zero
    /* 25C50 80035450 0180053C */  lui        $a1, %hi(D_800116EC)
    /* 25C54 80035454 EC16A524 */  addiu      $a1, $a1, %lo(D_800116EC)
    /* 25C58 80035458 3816A2A7 */  sh         $v0, 0x1638($sp)
    /* 25C5C 8003545C 00140200 */  sll        $v0, $v0, 16
    /* 25C60 80035460 21A04000 */  addu       $s4, $v0, $zero
    /* 25C64 80035464 15001624 */  addiu      $s6, $zero, 0x15
    /* 25C68 80035468 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 25C6C 8003546C E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 25C70 80035470 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* 25C74 80035474 0580033C */  lui        $v1, %hi(CURRENTLYUSINGMEMCARD)
    /* 25C78 80035478 681A50AC */  sw         $s0, %lo(CURRENTPLAYER)($v0)
    /* 25C7C 8003547C 01000224 */  addiu      $v0, $zero, 0x1
    /* 25C80 80035480 7C1A62AC */  sw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v1)
    /* 25C84 80035484 0580023C */  lui        $v0, %hi(nomessage)
    /* 25C88 80035488 2F91030C */  jal        sprintf
    /* 25C8C 8003548C 781A40AC */   sw        $zero, %lo(nomessage)($v0)
    /* 25C90 80035490 21202002 */  addu       $a0, $s1, $zero
    /* 25C94 80035494 0FC7030C */  jal        loadshapeadr
    /* 25C98 80035498 21286002 */   addu      $a1, $s3, $zero
    /* 25C9C 8003549C 0016A427 */  addiu      $a0, $sp, 0x1600
    /* 25CA0 800354A0 032C1400 */  sra        $a1, $s4, 16
    /* 25CA4 800354A4 01000624 */  addiu      $a2, $zero, 0x1
    /* 25CA8 800354A8 28D2000C */  jal        Init_MemcardFile__FR12MCRDFILE_defsb
    /* 25CAC 800354AC 21B84000 */   addu      $s7, $v0, $zero
  .L800354B0:
    /* 25CB0 800354B0 A03F010C */  jal        MCRD_handlecardevents
    /* 25CB4 800354B4 03241400 */   sra       $a0, $s4, 16
    /* 25CB8 800354B8 05005614 */  bne        $v0, $s6, .L800354D0
    /* 25CBC 800354BC 00141E00 */   sll       $v0, $fp, 16
    /* 25CC0 800354C0 C7C8030C */  jal        VSync
    /* 25CC4 800354C4 21200000 */   addu      $a0, $zero, $zero
    /* 25CC8 800354C8 2CD50008 */  j          .L800354B0
    /* 25CCC 800354CC 00000000 */   nop
  .L800354D0:
    /* 25CD0 800354D0 03A40200 */  sra        $s4, $v0, 16
    /* 25CD4 800354D4 3816A897 */  lhu        $t0, 0x1638($sp)
    /* 25CD8 800354D8 1000A227 */  addiu      $v0, $sp, 0x10
    /* 25CDC 800354DC 1416A2AF */  sw         $v0, 0x1614($sp)
    /* 25CE0 800354E0 1016A0AF */  sw         $zero, 0x1610($sp)
    /* 25CE4 800354E4 008C0800 */  sll        $s1, $t0, 16
  jlabel .L800354E8
    /* 25CE8 800354E8 85006016 */  bnez       $s3, .L80035700
    /* 25CEC 800354EC 00000000 */   nop
    /* 25CF0 800354F0 A03F010C */  jal        MCRD_handlecardevents
    /* 25CF4 800354F4 03241100 */   sra       $a0, $s1, 16
    /* 25CF8 800354F8 21200000 */  addu       $a0, $zero, $zero
    /* 25CFC 800354FC 019B030C */  jal        systemtask
    /* 25D00 80035500 21804000 */   addu      $s0, $v0, $zero
    /* 25D04 80035504 C7C8030C */  jal        VSync
    /* 25D08 80035508 21200000 */   addu      $a0, $zero, $zero
    /* 25D0C 8003550C FEFF1026 */  addiu      $s0, $s0, -0x2
    /* 25D10 80035510 1600022E */  sltiu      $v0, $s0, 0x16
    /* 25D14 80035514 F4FF4010 */  beqz       $v0, .L800354E8
    /* 25D18 80035518 80101000 */   sll       $v0, $s0, 2
    /* 25D1C 8003551C 0180083C */  lui        $t0, %hi(jtbl_800117A8)
    /* 25D20 80035520 A8170825 */  addiu      $t0, $t0, %lo(jtbl_800117A8)
    /* 25D24 80035524 21104800 */  addu       $v0, $v0, $t0
    /* 25D28 80035528 0000428C */  lw         $v0, 0x0($v0)
    /* 25D2C 8003552C 00000000 */  nop
    /* 25D30 80035530 08004000 */  jr         $v0
    /* 25D34 80035534 00000000 */   nop
  jlabel .L80035538
    /* 25D38 80035538 03241100 */  sra        $a0, $s1, 16
    /* 25D3C 8003553C 0016A527 */  addiu      $a1, $sp, 0x1600
    /* 25D40 80035540 AE3D010C */  jal        MCRD_loadfile
    /* 25D44 80035544 21300000 */   addu      $a2, $zero, $zero
    /* 25D48 80035548 3AD50008 */  j          .L800354E8
    /* 25D4C 8003554C 00000000 */   nop
  jlabel .L80035550
    /* 25D50 80035550 C6D0000C */  jal        VerifySuccessfulRead__FP12tMemCardData
    /* 25D54 80035554 1000A427 */   addiu     $a0, $sp, 0x10
    /* 25D58 80035558 57004010 */  beqz       $v0, .L800356B8
    /* 25D5C 8003555C 80101400 */   sll       $v0, $s4, 2
    /* 25D60 80035560 1180083C */  lui        $t0, %hi(frontEnd)
    /* 25D64 80035564 00460825 */  addiu      $t0, $t0, %lo(frontEnd)
    /* 25D68 80035568 21104800 */  addu       $v0, $v0, $t0
    /* 25D6C 8003556C 3C04438C */  lw         $v1, 0x43C($v0)
    /* 25D70 80035570 A414A28F */  lw         $v0, 0x14A4($sp)
    /* 25D74 80035574 00000000 */  nop
    /* 25D78 80035578 03006210 */  beq        $v1, $v0, .L80035588
    /* 25D7C 8003557C 01001324 */   addiu     $s3, $zero, 0x1
    /* 25D80 80035580 3AD50008 */  j          .L800354E8
    /* 25D84 80035584 21906002 */   addu      $s2, $s3, $zero
  .L80035588:
    /* 25D88 80035588 1180043C */  lui        $a0, %hi(carManager)
    /* 25D8C 8003558C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 25D90 80035590 6804A527 */  addiu      $a1, $sp, 0x468
    /* 25D94 80035594 3016A897 */  lhu        $t0, 0x1630($sp)
    /* 25D98 80035598 21308002 */  addu       $a2, $s4, $zero
    /* 25D9C 8003559C 003C0800 */  sll        $a3, $t0, 16
    /* 25DA0 800355A0 035B000C */  jal        SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
    /* 25DA4 800355A4 033C0700 */   sra       $a3, $a3, 16
    /* 25DA8 800355A8 15001024 */  addiu      $s0, $zero, 0x15
  .L800355AC:
    /* 25DAC 800355AC A03F010C */  jal        MCRD_handlecardevents
    /* 25DB0 800355B0 03241100 */   sra       $a0, $s1, 16
    /* 25DB4 800355B4 05005014 */  bne        $v0, $s0, .L800355CC
    /* 25DB8 800355B8 2120E002 */   addu      $a0, $s7, $zero
    /* 25DBC 800355BC C7C8030C */  jal        VSync
    /* 25DC0 800355C0 21200000 */   addu      $a0, $zero, $zero
    /* 25DC4 800355C4 6BD50008 */  j          .L800355AC
    /* 25DC8 800355C8 00000000 */   nop
  .L800355CC:
    /* 25DCC 800355CC 21280000 */  addu       $a1, $zero, $zero
    /* 25DD0 800355D0 00020224 */  addiu      $v0, $zero, 0x200
    /* 25DD4 800355D4 AEC2030C */  jal        shapepointer
    /* 25DD8 800355D8 1016A2AF */   sw        $v0, 0x1610($sp)
    /* 25DDC 800355DC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 25DE0 800355E0 1816A2AF */  sw         $v0, 0x1618($sp)
    /* 25DE4 800355E4 1C16A0AF */  sw         $zero, 0x161C($sp)
    /* 25DE8 800355E8 A8D0000C */  jal        ChecksumData__FP12tMemCardData
    /* 25DEC 800355EC 2016A0AF */   sw        $zero, 0x1620($sp)
    /* 25DF0 800355F0 0180023C */  lui        $v0, %hi(jtbl_80011800)
    /* 25DF4 800355F4 00185624 */  addiu      $s6, $v0, %lo(jtbl_80011800)
    /* 25DF8 800355F8 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 25DFC 800355FC 682D5324 */  addiu      $s3, $v0, %lo(gMemCardInfo)
  jlabel .L80035600
    /* 25E00 80035600 3A00A016 */  bnez       $s5, .L800356EC
    /* 25E04 80035604 00000000 */   nop
    /* 25E08 80035608 A03F010C */  jal        MCRD_handlecardevents
    /* 25E0C 8003560C 03241100 */   sra       $a0, $s1, 16
    /* 25E10 80035610 21200000 */  addu       $a0, $zero, $zero
    /* 25E14 80035614 019B030C */  jal        systemtask
    /* 25E18 80035618 21804000 */   addu      $s0, $v0, $zero
    /* 25E1C 8003561C C7C8030C */  jal        VSync
    /* 25E20 80035620 21200000 */   addu      $a0, $zero, $zero
    /* 25E24 80035624 FEFF1026 */  addiu      $s0, $s0, -0x2
    /* 25E28 80035628 1600022E */  sltiu      $v0, $s0, 0x16
    /* 25E2C 8003562C F4FF4010 */  beqz       $v0, .L80035600
    /* 25E30 80035630 80101000 */   sll       $v0, $s0, 2
    /* 25E34 80035634 21105600 */  addu       $v0, $v0, $s6
    /* 25E38 80035638 0000428C */  lw         $v0, 0x0($v0)
    /* 25E3C 8003563C 00000000 */  nop
    /* 25E40 80035640 08004000 */  jr         $v0
    /* 25E44 80035644 00000000 */   nop
  jlabel .L80035648
    /* 25E48 80035648 3400628E */  lw         $v0, 0x34($s3)
    /* 25E4C 8003564C 00000000 */  nop
    /* 25E50 80035650 EBFF4010 */  beqz       $v0, .L80035600
    /* 25E54 80035654 03241100 */   sra       $a0, $s1, 16
    /* 25E58 80035658 933E010C */  jal        MCRD_savefile
    /* 25E5C 8003565C 0016A527 */   addiu     $a1, $sp, 0x1600
    /* 25E60 80035660 80D50008 */  j          .L80035600
    /* 25E64 80035664 00000000 */   nop
  jlabel .L80035668
    /* 25E68 80035668 01001524 */  addiu      $s5, $zero, 0x1
    /* 25E6C 8003566C 80D50008 */  j          .L80035600
    /* 25E70 80035670 21900000 */   addu      $s2, $zero, $zero
  jlabel .L80035674
    /* 25E74 80035674 0580023C */  lui        $v0, %hi(FEApp)
    /* 25E78 80035678 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 25E7C 8003567C 4162000C */  jal        Hide__11tDialogBase
    /* 25E80 80035680 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 25E84 80035684 80201400 */  sll        $a0, $s4, 2
    /* 25E88 80035688 9140010C */  jal        MCRD_getcard
    /* 25E8C 8003568C 01008424 */   addiu     $a0, $a0, 0x1
    /* 25E90 80035690 0000438C */  lw         $v1, 0x0($v0)
    /* 25E94 80035694 FDFF0224 */  addiu      $v0, $zero, -0x3
    /* 25E98 80035698 05006210 */  beq        $v1, $v0, .L800356B0
    /* 25E9C 8003569C 06001224 */   addiu     $s2, $zero, 0x6
    /* 25EA0 800356A0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 25EA4 800356A4 02006214 */  bne        $v1, $v0, .L800356B0
    /* 25EA8 800356A8 03001224 */   addiu     $s2, $zero, 0x3
    /* 25EAC 800356AC 04001224 */  addiu      $s2, $zero, 0x4
  .L800356B0:
    /* 25EB0 800356B0 80D50008 */  j          .L80035600
    /* 25EB4 800356B4 01001524 */   addiu     $s5, $zero, 0x1
  .L800356B8:
    /* 25EB8 800356B8 BBD50008 */  j          .L800356EC
    /* 25EBC 800356BC 02001224 */   addiu     $s2, $zero, 0x2
  jlabel .L800356C0
    /* 25EC0 800356C0 80201400 */  sll        $a0, $s4, 2
    /* 25EC4 800356C4 9140010C */  jal        MCRD_getcard
    /* 25EC8 800356C8 01008424 */   addiu     $a0, $a0, 0x1
    /* 25ECC 800356CC 0000438C */  lw         $v1, 0x0($v0)
    /* 25ED0 800356D0 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 25ED4 800356D4 05006210 */  beq        $v1, $v0, .L800356EC
    /* 25ED8 800356D8 05001224 */   addiu     $s2, $zero, 0x5
    /* 25EDC 800356DC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 25EE0 800356E0 02006214 */  bne        $v1, $v0, .L800356EC
    /* 25EE4 800356E4 02001224 */   addiu     $s2, $zero, 0x2
    /* 25EE8 800356E8 04001224 */  addiu      $s2, $zero, 0x4
  .L800356EC:
    /* 25EEC 800356EC 3AD50008 */  j          .L800354E8
    /* 25EF0 800356F0 01001324 */   addiu     $s3, $zero, 0x1
  jlabel .L800356F4
    /* 25EF4 800356F4 01001324 */  addiu      $s3, $zero, 0x1
    /* 25EF8 800356F8 3AD50008 */  j          .L800354E8
    /* 25EFC 800356FC 02001224 */   addiu     $s2, $zero, 0x2
  .L80035700:
    /* 25F00 80035700 3816A897 */  lhu        $t0, 0x1638($sp)
    /* 25F04 80035704 16001124 */  addiu      $s1, $zero, 0x16
    /* 25F08 80035708 00840800 */  sll        $s0, $t0, 16
  .L8003570C:
    /* 25F0C 8003570C A03F010C */  jal        MCRD_handlecardevents
    /* 25F10 80035710 03241000 */   sra       $a0, $s0, 16
    /* 25F14 80035714 05005110 */  beq        $v0, $s1, .L8003572C
    /* 25F18 80035718 00000000 */   nop
    /* 25F1C 8003571C C7C8030C */  jal        VSync
    /* 25F20 80035720 21200000 */   addu      $a0, $zero, $zero
    /* 25F24 80035724 C3D50008 */  j          .L8003570C
    /* 25F28 80035728 00000000 */   nop
  .L8003572C:
    /* 25F2C 8003572C 5095030C */  jal        purgememadr
    /* 25F30 80035730 2120E002 */   addu      $a0, $s7, $zero
    /* 25F34 80035734 05D1000C */  jal        BringThatBeatBack__Fv
    /* 25F38 80035738 00000000 */   nop
    /* 25F3C 8003573C 0580023C */  lui        $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 25F40 80035740 7C1A40AC */  sw         $zero, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 25F44 80035744 21104002 */  addu       $v0, $s2, $zero
    /* 25F48 80035748 6416BF8F */  lw         $ra, 0x1664($sp)
    /* 25F4C 8003574C 6016BE8F */  lw         $fp, 0x1660($sp)
    /* 25F50 80035750 5C16B78F */  lw         $s7, 0x165C($sp)
    /* 25F54 80035754 5816B68F */  lw         $s6, 0x1658($sp)
    /* 25F58 80035758 5416B58F */  lw         $s5, 0x1654($sp)
    /* 25F5C 8003575C 5016B48F */  lw         $s4, 0x1650($sp)
    /* 25F60 80035760 4C16B38F */  lw         $s3, 0x164C($sp)
    /* 25F64 80035764 4816B28F */  lw         $s2, 0x1648($sp)
    /* 25F68 80035768 4416B18F */  lw         $s1, 0x1644($sp)
    /* 25F6C 8003576C 4016B08F */  lw         $s0, 0x1640($sp)
    /* 25F70 80035770 0800E003 */  jr         $ra
    /* 25F74 80035774 6816BD27 */   addiu     $sp, $sp, 0x1668
endlabel SavePinkSlipsCars__Fss
