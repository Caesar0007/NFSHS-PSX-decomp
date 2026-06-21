.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__16tScreenPinkSlips, 0x5B0

glabel DrawBackground__16tScreenPinkSlips
    /* 29368 80038B68 18FFBD27 */  addiu      $sp, $sp, -0xE8
    /* 2936C 80038B6C E000BEAF */  sw         $fp, 0xE0($sp)
    /* 29370 80038B70 21F08000 */  addu       $fp, $a0, $zero
    /* 29374 80038B74 C800B2AF */  sw         $s2, 0xC8($sp)
    /* 29378 80038B78 21900000 */  addu       $s2, $zero, $zero
    /* 2937C 80038B7C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 29380 80038B80 D000B4AF */  sw         $s4, 0xD0($sp)
    /* 29384 80038B84 00465424 */  addiu      $s4, $v0, %lo(frontEnd)
    /* 29388 80038B88 CC00B3AF */  sw         $s3, 0xCC($sp)
    /* 2938C 80038B8C 0580133C */  lui        $s3, %hi(D_80052BF0)
    /* 29390 80038B90 5B010224 */  addiu      $v0, $zero, 0x15B
    /* 29394 80038B94 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 29398 80038B98 8F000224 */  addiu      $v0, $zero, 0x8F
    /* 2939C 80038B9C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* 293A0 80038BA0 90000224 */  addiu      $v0, $zero, 0x90
    /* 293A4 80038BA4 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 293A8 80038BA8 0E000224 */  addiu      $v0, $zero, 0xE
    /* 293AC 80038BAC E400BFAF */  sw         $ra, 0xE4($sp)
    /* 293B0 80038BB0 DC00B7AF */  sw         $s7, 0xDC($sp)
    /* 293B4 80038BB4 D800B6AF */  sw         $s6, 0xD8($sp)
    /* 293B8 80038BB8 D400B5AF */  sw         $s5, 0xD4($sp)
    /* 293BC 80038BBC C400B1AF */  sw         $s1, 0xC4($sp)
    /* 293C0 80038BC0 C000B0AF */  sw         $s0, 0xC0($sp)
    /* 293C4 80038BC4 2600A2A7 */  sh         $v0, 0x26($sp)
  .L80038BC8:
    /* 293C8 80038BC8 001C1200 */  sll        $v1, $s2, 16
    /* 293CC 80038BCC 47008292 */  lbu        $v0, 0x47($s4)
    /* 293D0 80038BD0 031C0300 */  sra        $v1, $v1, 16
    /* 293D4 80038BD4 2A106200 */  slt        $v0, $v1, $v0
    /* 293D8 80038BD8 6A004010 */  beqz       $v0, .L80038D84
    /* 293DC 80038BDC 01001024 */   addiu     $s0, $zero, 0x1
    /* 293E0 80038BE0 6400C28F */  lw         $v0, 0x64($fp)
    /* 293E4 80038BE4 00000000 */  nop
    /* 293E8 80038BE8 08004484 */  lh         $a0, 0x8($v0)
    /* 293EC 80038BEC 00000000 */  nop
    /* 293F0 80038BF0 FFFF8224 */  addiu      $v0, $a0, -0x1
    /* 293F4 80038BF4 05006210 */  beq        $v1, $v0, .L80038C0C
    /* 293F8 80038BF8 21280000 */   addu      $a1, $zero, $zero
    /* 293FC 80038BFC 04006014 */  bnez       $v1, .L80038C10
    /* 29400 80038C00 00000000 */   nop
    /* 29404 80038C04 02008014 */  bnez       $a0, .L80038C10
    /* 29408 80038C08 00000000 */   nop
  .L80038C0C:
    /* 2940C 80038C0C 01000524 */  addiu      $a1, $zero, 0x1
  .L80038C10:
    /* 29410 80038C10 3700A010 */  beqz       $a1, .L80038CF0
    /* 29414 80038C14 1180043C */   lui       $a0, %hi(trackManager)
    /* 29418 80038C18 F02B628E */  lw         $v0, %lo(D_80052BF0)($s3)
    /* 2941C 80038C1C 00000000 */  nop
    /* 29420 80038C20 01004224 */  addiu      $v0, $v0, 0x1
    /* 29424 80038C24 F02B62AE */  sw         $v0, %lo(D_80052BF0)($s3)
    /* 29428 80038C28 3D004228 */  slti       $v0, $v0, 0x3D
    /* 2942C 80038C2C 02004014 */  bnez       $v0, .L80038C38
    /* 29430 80038C30 00000000 */   nop
    /* 29434 80038C34 F02B60AE */  sw         $zero, %lo(D_80052BF0)($s3)
  .L80038C38:
    /* 29438 80038C38 F02B638E */  lw         $v1, %lo(D_80052BF0)($s3)
    /* 2943C 80038C3C 00000000 */  nop
    /* 29440 80038C40 1F006228 */  slti       $v0, $v1, 0x1F
    /* 29444 80038C44 04004014 */  bnez       $v0, .L80038C58
    /* 29448 80038C48 C2170300 */   srl       $v0, $v1, 31
    /* 2944C 80038C4C 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 29450 80038C50 23104300 */  subu       $v0, $v0, $v1
    /* 29454 80038C54 C21F0200 */  srl        $v1, $v0, 31
  .L80038C58:
    /* 29458 80038C58 21106200 */  addu       $v0, $v1, $v0
    /* 2945C 80038C5C 43200200 */  sra        $a0, $v0, 1
    /* 29460 80038C60 14008424 */  addiu      $a0, $a0, 0x14
    /* 29464 80038C64 5C00C387 */  lh         $v1, 0x5C($fp)
    /* 29468 80038C68 80000224 */  addiu      $v0, $zero, 0x80
    /* 2946C 80038C6C 23104300 */  subu       $v0, $v0, $v1
    /* 29470 80038C70 18008200 */  mult       $a0, $v0
    /* 29474 80038C74 12200000 */  mflo       $a0
    /* 29478 80038C78 1B008018 */  blez       $a0, .L80038CE8
    /* 2947C 80038C7C 5555023C */   lui       $v0, (0x55555556 >> 16)
    /* 29480 80038C80 56554234 */  ori        $v0, $v0, (0x55555556 & 0xFFFF)
    /* 29484 80038C84 40380400 */  sll        $a3, $a0, 1
    /* 29488 80038C88 1800E200 */  mult       $a3, $v0
    /* 2948C 80038C8C C2370400 */  srl        $a2, $a0, 31
    /* 29490 80038C90 21308600 */  addu       $a2, $a0, $a2
    /* 29494 80038C94 43300600 */  sra        $a2, $a2, 1
    /* 29498 80038C98 17000224 */  addiu      $v0, $zero, 0x17
    /* 2949C 80038C9C 2000B087 */  lh         $s0, 0x20($sp)
    /* 294A0 80038CA0 2200B187 */  lh         $s1, 0x22($sp)
    /* 294A4 80038CA4 C33F0700 */  sra        $a3, $a3, 31
    /* 294A8 80038CA8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 294AC 80038CAC F1FF0426 */  addiu      $a0, $s0, -0xF
    /* 294B0 80038CB0 06002526 */  addiu      $a1, $s1, 0x6
    /* 294B4 80038CB4 10500000 */  mfhi       $t2
    /* 294B8 80038CB8 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* 294BC 80038CBC 23384701 */   subu      $a3, $t2, $a3
    /* 294C0 80038CC0 38000424 */  addiu      $a0, $zero, 0x38
    /* 294C4 80038CC4 21280000 */  addu       $a1, $zero, $zero
    /* 294C8 80038CC8 EEFF0626 */  addiu      $a2, $s0, -0x12
    /* 294CC 80038CCC 21382002 */  addu       $a3, $s1, $zero
    /* 294D0 80038CD0 5C00C387 */  lh         $v1, 0x5C($fp)
    /* 294D4 80038CD4 01000224 */  addiu      $v0, $zero, 0x1
    /* 294D8 80038CD8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 294DC 80038CDC 1800A0AF */  sw         $zero, 0x18($sp)
    /* 294E0 80038CE0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 294E4 80038CE4 1000A3AF */   sw        $v1, 0x10($sp)
  .L80038CE8:
    /* 294E8 80038CE8 02001024 */  addiu      $s0, $zero, 0x2
    /* 294EC 80038CEC 1180043C */  lui        $a0, %hi(trackManager)
  .L80038CF0:
    /* 294F0 80038CF0 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 294F4 80038CF4 00141200 */  sll        $v0, $s2, 16
    /* 294F8 80038CF8 03140200 */  sra        $v0, $v0, 16
    /* 294FC 80038CFC 21105400 */  addu       $v0, $v0, $s4
    /* 29500 80038D00 23004590 */  lbu        $a1, 0x23($v0)
    /* 29504 80038D04 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 29508 80038D08 2800A627 */   addiu     $a2, $sp, 0x28
    /* 2950C 80038D0C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 29510 80038D10 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 29514 80038D14 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 29518 80038D18 460092A2 */  sb         $s2, 0x46($s4)
    /* 2951C 80038D1C 7587000C */  jal        TextValue__18tListIteratorTrack7tPlayer
    /* 29520 80038D20 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 29524 80038D24 00140200 */  sll        $v0, $v0, 16
    /* 29528 80038D28 03240200 */  sra        $a0, $v0, 16
    /* 2952C 80038D2C 21380000 */  addu       $a3, $zero, $zero
    /* 29530 80038D30 2000A597 */  lhu        $a1, 0x20($sp)
    /* 29534 80038D34 2200A697 */  lhu        $a2, 0x22($sp)
    /* 29538 80038D38 01000224 */  addiu      $v0, $zero, 0x1
    /* 2953C 80038D3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 29540 80038D40 1400A2AF */  sw         $v0, 0x14($sp)
    /* 29544 80038D44 0A00A524 */  addiu      $a1, $a1, 0xA
    /* 29548 80038D48 002C0500 */  sll        $a1, $a1, 16
    /* 2954C 80038D4C 032C0500 */  sra        $a1, $a1, 16
    /* 29550 80038D50 0300C624 */  addiu      $a2, $a2, 0x3
    /* 29554 80038D54 00340600 */  sll        $a2, $a2, 16
    /* 29558 80038D58 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2955C 80038D5C 03340600 */   sra       $a2, $a2, 16
    /* 29560 80038D60 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 29564 80038D64 2000A527 */  addiu      $a1, $sp, 0x20
    /* 29568 80038D68 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 2956C 80038D6C 01000624 */   addiu     $a2, $zero, 0x1
    /* 29570 80038D70 2200A297 */  lhu        $v0, 0x22($sp)
    /* 29574 80038D74 01005226 */  addiu      $s2, $s2, 0x1
    /* 29578 80038D78 0E004224 */  addiu      $v0, $v0, 0xE
    /* 2957C 80038D7C F2E20008 */  j          .L80038BC8
    /* 29580 80038D80 2200A2A7 */   sh        $v0, 0x22($sp)
  .L80038D84:
    /* 29584 80038D84 6400C28F */  lw         $v0, 0x64($fp)
    /* 29588 80038D88 1180033C */  lui        $v1, %hi(frontEnd)
    /* 2958C 80038D8C 08004294 */  lhu        $v0, 0x8($v0)
    /* 29590 80038D90 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 29594 80038D94 21204000 */  addu       $a0, $v0, $zero
    /* 29598 80038D98 460062A0 */  sb         $v0, 0x46($v1)
    /* 2959C 80038D9C FF008230 */  andi       $v0, $a0, 0xFF
    /* 295A0 80038DA0 02004010 */  beqz       $v0, .L80038DAC
    /* 295A4 80038DA4 FFFF8224 */   addiu     $v0, $a0, -0x1
    /* 295A8 80038DA8 460062A0 */  sb         $v0, 0x46($v1)
  .L80038DAC:
    /* 295AC 80038DAC 1180043C */  lui        $a0, %hi(trackManager)
    /* 295B0 80038DB0 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 295B4 80038DB4 46006290 */  lbu        $v0, 0x46($v1)
    /* 295B8 80038DB8 2800B027 */  addiu      $s0, $sp, 0x28
    /* 295BC 80038DBC 21104300 */  addu       $v0, $v0, $v1
    /* 295C0 80038DC0 23004590 */  lbu        $a1, 0x23($v0)
    /* 295C4 80038DC4 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 295C8 80038DC8 21300002 */   addu      $a2, $s0, $zero
    /* 295CC 80038DCC 2120C003 */  addu       $a0, $fp, $zero
    /* 295D0 80038DD0 DAE4000C */  jal        UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
    /* 295D4 80038DD4 21280002 */   addu      $a1, $s0, $zero
    /* 295D8 80038DD8 2120C003 */  addu       $a0, $fp, $zero
    /* 295DC 80038DDC 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 295E0 80038DE0 2800C527 */   addiu     $a1, $fp, 0x28
    /* 295E4 80038DE4 2C00C28F */  lw         $v0, 0x2C($fp)
    /* 295E8 80038DE8 00000000 */  nop
    /* 295EC 80038DEC 0D004010 */  beqz       $v0, .L80038E24
    /* 295F0 80038DF0 00000000 */   nop
    /* 295F4 80038DF4 8000C283 */  lb         $v0, 0x80($fp)
    /* 295F8 80038DF8 00000000 */  nop
    /* 295FC 80038DFC 09004004 */  bltz       $v0, .L80038E24
    /* 29600 80038E00 2120C003 */   addu      $a0, $fp, $zero
    /* 29604 80038E04 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 29608 80038E08 04000524 */   addiu     $a1, $zero, 0x4
    /* 2960C 80038E0C 01000224 */  addiu      $v0, $zero, 0x1
    /* 29610 80038E10 8000C2A3 */  sb         $v0, 0x80($fp)
    /* 29614 80038E14 1480023C */  lui        $v0, %hi(ticks)
    /* 29618 80038E18 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2961C 80038E1C 00000000 */  nop
    /* 29620 80038E20 7C00C2AF */  sw         $v0, 0x7C($fp)
  .L80038E24:
    /* 29624 80038E24 05E5000C */  jal        DrawVideoWall__16tScreenPinkSlips
    /* 29628 80038E28 2120C003 */   addu      $a0, $fp, $zero
    /* 2962C 80038E2C 6C00C28F */  lw         $v0, 0x6C($fp)
    /* 29630 80038E30 6800C48F */  lw         $a0, 0x68($fp)
    /* 29634 80038E34 01004230 */  andi       $v0, $v0, 0x1
    /* 29638 80038E38 0100422C */  sltiu      $v0, $v0, 0x1
    /* 2963C 80038E3C C0810200 */  sll        $s0, $v0, 7
    /* 29640 80038E40 E643010C */  jal        VIDEO_state__Fi
    /* 29644 80038E44 A800B0A7 */   sh        $s0, 0xA8($sp)
    /* 29648 80038E48 5B004010 */  beqz       $v0, .L80038FB8
    /* 2964C 80038E4C 00020524 */   addiu     $a1, $zero, 0x200
    /* 29650 80038E50 6800C48F */  lw         $a0, 0x68($fp)
    /* 29654 80038E54 00341000 */  sll        $a2, $s0, 16
    /* 29658 80038E58 1044010C */  jal        VIDEO_updateframexy__Fiii
    /* 2965C 80038E5C 02340600 */   srl       $a2, $a2, 16
    /* 29660 80038E60 09004010 */  beqz       $v0, .L80038E88
    /* 29664 80038E64 21980000 */   addu      $s3, $zero, $zero
    /* 29668 80038E68 6C00C38F */  lw         $v1, 0x6C($fp)
    /* 2966C 80038E6C 00000000 */  nop
    /* 29670 80038E70 01006324 */  addiu      $v1, $v1, 0x1
    /* 29674 80038E74 01006230 */  andi       $v0, $v1, 0x1
    /* 29678 80038E78 0100422C */  sltiu      $v0, $v0, 0x1
    /* 2967C 80038E7C C0110200 */  sll        $v0, $v0, 7
    /* 29680 80038E80 A800A2A7 */  sh         $v0, 0xA8($sp)
    /* 29684 80038E84 6C00C3AF */  sw         $v1, 0x6C($fp)
  .L80038E88:
    /* 29688 80038E88 21906002 */  addu       $s2, $s3, $zero
    /* 2968C 80038E8C 40000924 */  addiu      $t1, $zero, 0x40
    /* 29690 80038E90 A800AA93 */  lbu        $t2, 0xA8($sp)
    /* 29694 80038E94 01000824 */  addiu      $t0, $zero, 0x1
    /* 29698 80038E98 B000AAA3 */  sb         $t2, 0xB0($sp)
    /* 2969C 80038E9C 21880000 */  addu       $s1, $zero, $zero
  .L80038EA0:
    /* 296A0 80038EA0 00141200 */  sll        $v0, $s2, 16
    /* 296A4 80038EA4 03AC0200 */  sra        $s5, $v0, 16
    /* 296A8 80038EA8 B000AA93 */  lbu        $t2, 0xB0($sp)
    /* 296AC 80038EAC 80A11500 */  sll        $s4, $s5, 6
    /* 296B0 80038EB0 21B88A02 */  addu       $s7, $s4, $t2
    /* 296B4 80038EB4 40000A24 */  addiu      $t2, $zero, 0x40
    /* 296B8 80038EB8 FFFF5625 */  addiu      $s6, $t2, -0x1
  .L80038EBC:
    /* 296BC 80038EBC 001C1300 */  sll        $v1, $s3, 16
    /* 296C0 80038EC0 031C0300 */  sra        $v1, $v1, 16
    /* 296C4 80038EC4 40100300 */  sll        $v0, $v1, 1
    /* 296C8 80038EC8 21104300 */  addu       $v0, $v0, $v1
    /* 296CC 80038ECC 00110200 */  sll        $v0, $v0, 4
    /* 296D0 80038ED0 2180C203 */  addu       $s0, $fp, $v0
    /* 296D4 80038ED4 00141100 */  sll        $v0, $s1, 16
    /* 296D8 80038ED8 03140200 */  sra        $v0, $v0, 16
    /* 296DC 80038EDC 80180200 */  sll        $v1, $v0, 2
    /* 296E0 80038EE0 21186200 */  addu       $v1, $v1, $v0
    /* 296E4 80038EE4 00110300 */  sll        $v0, $v1, 4
    /* 296E8 80038EE8 A0004224 */  addiu      $v0, $v0, 0xA0
    /* 296EC 80038EEC 980002A6 */  sh         $v0, 0x98($s0)
    /* 296F0 80038EF0 19008226 */  addiu      $v0, $s4, 0x19
    /* 296F4 80038EF4 9A0002A6 */  sh         $v0, 0x9A($s0)
    /* 296F8 80038EF8 50000224 */  addiu      $v0, $zero, 0x50
    /* 296FC 80038EFC C0180300 */  sll        $v1, $v1, 3
    /* 29700 80038F00 9C0002A6 */  sh         $v0, 0x9C($s0)
    /* 29704 80038F04 28000224 */  addiu      $v0, $zero, 0x28
    /* 29708 80038F08 9E0009A6 */  sh         $t1, 0x9E($s0)
    /* 2970C 80038F0C A00003A2 */  sb         $v1, 0xA0($s0)
    /* 29710 80038F10 A10017A2 */  sb         $s7, 0xA1($s0)
    /* 29714 80038F14 A20002A2 */  sb         $v0, 0xA2($s0)
    /* 29718 80038F18 0200A816 */  bne        $s5, $t0, .L80038F24
    /* 2971C 80038F1C A30009A2 */   sb        $t1, 0xA3($s0)
    /* 29720 80038F20 A30016A2 */  sb         $s6, 0xA3($s0)
  .L80038F24:
    /* 29724 80038F24 02000424 */  addiu      $a0, $zero, 0x2
    /* 29728 80038F28 21280000 */  addu       $a1, $zero, $zero
    /* 2972C 80038F2C 00020A24 */  addiu      $t2, $zero, 0x200
    /* 29730 80038F30 00340A00 */  sll        $a2, $t2, 16
    /* 29734 80038F34 A800AA97 */  lhu        $t2, 0xA8($sp)
    /* 29738 80038F38 03340600 */  sra        $a2, $a2, 16
    /* 2973C 80038F3C B800A8AF */  sw         $t0, 0xB8($sp)
    /* 29740 80038F40 BC00A9AF */  sw         $t1, 0xBC($sp)
    /* 29744 80038F44 003C0A00 */  sll        $a3, $t2, 16
    /* 29748 80038F48 FFC6030C */  jal        GetTPage
    /* 2974C 80038F4C 033C0700 */   sra       $a3, $a3, 16
    /* 29750 80038F50 8000043C */  lui        $a0, (0x808080 >> 16)
    /* 29754 80038F54 80808434 */  ori        $a0, $a0, (0x808080 & 0xFFFF)
    /* 29758 80038F58 01002326 */  addiu      $v1, $s1, 0x1
    /* 2975C 80038F5C 21886000 */  addu       $s1, $v1, $zero
    /* 29760 80038F60 A80002A6 */  sh         $v0, 0xA8($s0)
    /* 29764 80038F64 20000224 */  addiu      $v0, $zero, 0x20
    /* 29768 80038F68 001C0300 */  sll        $v1, $v1, 16
    /* 2976C 80038F6C 031C0300 */  sra        $v1, $v1, 16
    /* 29770 80038F70 A60000A6 */  sh         $zero, 0xA6($s0)
    /* 29774 80038F74 B800A88F */  lw         $t0, 0xB8($sp)
    /* 29778 80038F78 04006328 */  slti       $v1, $v1, 0x4
    /* 2977C 80038F7C 8C0002A6 */  sh         $v0, 0x8C($s0)
    /* 29780 80038F80 940004AE */  sw         $a0, 0x94($s0)
    /* 29784 80038F84 840008AE */  sw         $t0, 0x84($s0)
    /* 29788 80038F88 BC00A98F */  lw         $t1, 0xBC($sp)
    /* 2978C 80038F8C CBFF6014 */  bnez       $v1, .L80038EBC
    /* 29790 80038F90 01007326 */   addiu     $s3, $s3, 0x1
    /* 29794 80038F94 01004226 */  addiu      $v0, $s2, 0x1
    /* 29798 80038F98 21904000 */  addu       $s2, $v0, $zero
    /* 2979C 80038F9C 00140200 */  sll        $v0, $v0, 16
    /* 297A0 80038FA0 03140200 */  sra        $v0, $v0, 16
    /* 297A4 80038FA4 02004228 */  slti       $v0, $v0, 0x2
    /* 297A8 80038FA8 BDFF4014 */  bnez       $v0, .L80038EA0
    /* 297AC 80038FAC 21880000 */   addu      $s1, $zero, $zero
    /* 297B0 80038FB0 04E40008 */  j          .L80039010
    /* 297B4 80038FB4 F0001224 */   addiu     $s2, $zero, 0xF0
  .L80038FB8:
    /* 297B8 80038FB8 1480023C */  lui        $v0, %hi(ticks)
    /* 297BC 80038FBC ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 297C0 80038FC0 7C00C38F */  lw         $v1, 0x7C($fp)
    /* 297C4 80038FC4 00000000 */  nop
    /* 297C8 80038FC8 23104300 */  subu       $v0, $v0, $v1
    /* 297CC 80038FCC 0101422C */  sltiu      $v0, $v0, 0x101
    /* 297D0 80038FD0 0F004014 */  bnez       $v0, .L80039010
    /* 297D4 80038FD4 F0001224 */   addiu     $s2, $zero, 0xF0
    /* 297D8 80038FD8 5800B027 */  addiu      $s0, $sp, 0x58
    /* 297DC 80038FDC 21200002 */  addu       $a0, $s0, $zero
    /* 297E0 80038FE0 1180023C */  lui        $v0, %hi(D_8011650C)
    /* 297E4 80038FE4 0180053C */  lui        $a1, %hi(D_8001190C)
    /* 297E8 80038FE8 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 297EC 80038FEC 2800A783 */  lb         $a3, 0x28($sp)
    /* 297F0 80038FF0 2F91030C */  jal        sprintf
    /* 297F4 80038FF4 0C19A524 */   addiu     $a1, $a1, %lo(D_8001190C)
    /* 297F8 80038FF8 6800C48F */  lw         $a0, 0x68($fp)
    /* 297FC 80038FFC A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 29800 80039000 21280002 */   addu      $a1, $s0, $zero
    /* 29804 80039004 6800C48F */  lw         $a0, 0x68($fp)
    /* 29808 80039008 BD43010C */  jal        VIDEO_startplayback__Fi
    /* 2980C 8003900C F0001224 */   addiu     $s2, $zero, 0xF0
  .L80039010:
    /* 29810 80039010 81001124 */  addiu      $s1, $zero, 0x81
    /* 29814 80039014 01001024 */  addiu      $s0, $zero, 0x1
    /* 29818 80039018 3000043C */  lui        $a0, (0x303030 >> 16)
  .L8003901C:
    /* 2981C 8003901C 30308434 */  ori        $a0, $a0, (0x303030 & 0xFFFF)
    /* 29820 80039020 002C1200 */  sll        $a1, $s2, 16
    /* 29824 80039024 032C0500 */  sra        $a1, $a1, 16
    /* 29828 80039028 0F000624 */  addiu      $a2, $zero, 0xF
    /* 2982C 8003902C 02000724 */  addiu      $a3, $zero, 0x2
    /* 29830 80039030 1000B1AF */  sw         $s1, 0x10($sp)
    /* 29834 80039034 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 29838 80039038 1400B0AF */   sw        $s0, 0x14($sp)
    /* 2983C 8003903C 50004226 */  addiu      $v0, $s2, 0x50
    /* 29840 80039040 21904000 */  addu       $s2, $v0, $zero
    /* 29844 80039044 00140200 */  sll        $v0, $v0, 16
    /* 29848 80039048 03140200 */  sra        $v0, $v0, 16
    /* 2984C 8003904C E0014228 */  slti       $v0, $v0, 0x1E0
    /* 29850 80039050 F2FF4014 */  bnez       $v0, .L8003901C
    /* 29854 80039054 3000043C */   lui       $a0, (0x303030 >> 16)
    /* 29858 80039058 4F001224 */  addiu      $s2, $zero, 0x4F
    /* 2985C 8003905C 01001024 */  addiu      $s0, $zero, 0x1
  .L80039060:
    /* 29860 80039060 2000043C */  lui        $a0, (0x202020 >> 16)
    /* 29864 80039064 20208434 */  ori        $a0, $a0, (0x202020 & 0xFFFF)
    /* 29868 80039068 A0000524 */  addiu      $a1, $zero, 0xA0
    /* 2986C 8003906C 00341200 */  sll        $a2, $s2, 16
    /* 29870 80039070 03340600 */  sra        $a2, $a2, 16
    /* 29874 80039074 41010724 */  addiu      $a3, $zero, 0x141
    /* 29878 80039078 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2987C 8003907C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 29880 80039080 1400B0AF */   sw        $s0, 0x14($sp)
    /* 29884 80039084 40004226 */  addiu      $v0, $s2, 0x40
    /* 29888 80039088 21904000 */  addu       $s2, $v0, $zero
    /* 2988C 8003908C 00140200 */  sll        $v0, $v0, 16
    /* 29890 80039090 03140200 */  sra        $v0, $v0, 16
    /* 29894 80039094 8F004228 */  slti       $v0, $v0, 0x8F
    /* 29898 80039098 F1FF4014 */  bnez       $v0, .L80039060
    /* 2989C 8003909C 00000000 */   nop
    /* 298A0 800390A0 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 298A4 800390A4 02000424 */   addiu     $a0, $zero, 0x2
    /* 298A8 800390A8 21900000 */  addu       $s2, $zero, $zero
  .L800390AC:
    /* 298AC 800390AC 00141200 */  sll        $v0, $s2, 16
    /* 298B0 800390B0 03140200 */  sra        $v0, $v0, 16
    /* 298B4 800390B4 40200200 */  sll        $a0, $v0, 1
    /* 298B8 800390B8 21208200 */  addu       $a0, $a0, $v0
    /* 298BC 800390BC 00210400 */  sll        $a0, $a0, 4
    /* 298C0 800390C0 84008424 */  addiu      $a0, $a0, 0x84
    /* 298C4 800390C4 D388000C */  jal        DrawTV__FR9tTVConfig
    /* 298C8 800390C8 2120C403 */   addu      $a0, $fp, $a0
    /* 298CC 800390CC 01004226 */  addiu      $v0, $s2, 0x1
    /* 298D0 800390D0 21904000 */  addu       $s2, $v0, $zero
    /* 298D4 800390D4 00140200 */  sll        $v0, $v0, 16
    /* 298D8 800390D8 03140200 */  sra        $v0, $v0, 16
    /* 298DC 800390DC 08004228 */  slti       $v0, $v0, 0x8
    /* 298E0 800390E0 F2FF4014 */  bnez       $v0, .L800390AC
    /* 298E4 800390E4 00000000 */   nop
    /* 298E8 800390E8 E400BF8F */  lw         $ra, 0xE4($sp)
    /* 298EC 800390EC E000BE8F */  lw         $fp, 0xE0($sp)
    /* 298F0 800390F0 DC00B78F */  lw         $s7, 0xDC($sp)
    /* 298F4 800390F4 D800B68F */  lw         $s6, 0xD8($sp)
    /* 298F8 800390F8 D400B58F */  lw         $s5, 0xD4($sp)
    /* 298FC 800390FC D000B48F */  lw         $s4, 0xD0($sp)
    /* 29900 80039100 CC00B38F */  lw         $s3, 0xCC($sp)
    /* 29904 80039104 C800B28F */  lw         $s2, 0xC8($sp)
    /* 29908 80039108 C400B18F */  lw         $s1, 0xC4($sp)
    /* 2990C 8003910C C000B08F */  lw         $s0, 0xC0($sp)
    /* 29910 80039110 0800E003 */  jr         $ra
    /* 29914 80039114 E800BD27 */   addiu     $sp, $sp, 0xE8
endlabel DrawBackground__16tScreenPinkSlips
