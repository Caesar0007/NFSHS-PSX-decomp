.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii, 0x3A8

glabel Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
    /* 33F8 80012BF8 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 33FC 80012BFC E400B5AF */  sw         $s5, 0xE4($sp)
    /* 3400 80012C00 1401B58F */  lw         $s5, 0x114($sp)
    /* 3404 80012C04 E800B6AF */  sw         $s6, 0xE8($sp)
    /* 3408 80012C08 1801B68F */  lw         $s6, 0x118($sp)
    /* 340C 80012C0C F000BEAF */  sw         $fp, 0xF0($sp)
    /* 3410 80012C10 0801BE8F */  lw         $fp, 0x108($sp)
    /* 3414 80012C14 DC00B3AF */  sw         $s3, 0xDC($sp)
    /* 3418 80012C18 1001B38F */  lw         $s3, 0x110($sp)
    /* 341C 80012C1C E000B4AF */  sw         $s4, 0xE0($sp)
    /* 3420 80012C20 21A08000 */  addu       $s4, $a0, $zero
    /* 3424 80012C24 EC00B7AF */  sw         $s7, 0xEC($sp)
    /* 3428 80012C28 21B8A000 */  addu       $s7, $a1, $zero
    /* 342C 80012C2C D800B2AF */  sw         $s2, 0xD8($sp)
    /* 3430 80012C30 2190C000 */  addu       $s2, $a2, $zero
    /* 3434 80012C34 D000B0AF */  sw         $s0, 0xD0($sp)
    /* 3438 80012C38 2180E000 */  addu       $s0, $a3, $zero
    /* 343C 80012C3C F400BFAF */  sw         $ra, 0xF4($sp)
    /* 3440 80012C40 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* 3444 80012C44 D400B1AF */   sw        $s1, 0xD4($sp)
    /* 3448 80012C48 0580113C */  lui        $s1, %hi(_front_data_org)
    /* 344C 80012C4C 6012228E */  lw         $v0, %lo(_front_data_org)($s1)
    /* 3450 80012C50 00000000 */  nop
    /* 3454 80012C54 02004010 */  beqz       $v0, .L80012C60
    /* 3458 80012C58 00FF4426 */   addiu     $a0, $s2, -0x100
    /* 345C 80012C5C 8C001024 */  addiu      $s0, $zero, 0x8C
  .L80012C60:
    /* 3460 80012C60 80FF0526 */  addiu      $a1, $s0, -0x80
    /* 3464 80012C64 00020624 */  addiu      $a2, $zero, 0x200
    /* 3468 80012C68 7286030C */  jal        TrsProj_SetMenuProjection__Fiiii
    /* 346C 80012C6C 00010724 */   addiu     $a3, $zero, 0x100
    /* 3470 80012C70 0580023C */  lui        $v0, %hi(gMenuRotate)
    /* 3474 80012C74 64124224 */  addiu      $v0, $v0, %lo(gMenuRotate)
    /* 3478 80012C78 80201E00 */  sll        $a0, $fp, 2
    /* 347C 80012C7C 21208200 */  addu       $a0, $a0, $v0
    /* 3480 80012C80 0000828C */  lw         $v0, 0x0($a0)
    /* 3484 80012C84 0C01A38F */  lw         $v1, 0x10C($sp)
    /* 3488 80012C88 6012258E */  lw         $a1, %lo(_front_data_org)($s1)
    /* 348C 80012C8C 21104300 */  addu       $v0, $v0, $v1
    /* 3490 80012C90 3500A010 */  beqz       $a1, .L80012D68
    /* 3494 80012C94 000082AC */   sw        $v0, 0x0($a0)
    /* 3498 80012C98 003F053C */  lui        $a1, (0x3F000000 >> 16)
    /* 349C 80012C9C 2CCD030C */  jal        __mulsf3
    /* 34A0 80012CA0 2120A002 */   addu      $a0, $s5, $zero
    /* 34A4 80012CA4 21A84000 */  addu       $s5, $v0, $zero
    /* 34A8 80012CA8 8047103C */  lui        $s0, (0x47800000 >> 16)
    /* 34AC 80012CAC 2120A002 */  addu       $a0, $s5, $zero
    /* 34B0 80012CB0 9800A0AF */  sw         $zero, 0x98($sp)
    /* 34B4 80012CB4 2CCD030C */  jal        __mulsf3
    /* 34B8 80012CB8 21280002 */   addu      $a1, $s0, $zero
    /* 34BC 80012CBC 4ECE030C */  jal        __fixsfsi
    /* 34C0 80012CC0 21204000 */   addu      $a0, $v0, $zero
    /* 34C4 80012CC4 2120C002 */  addu       $a0, $s6, $zero
    /* 34C8 80012CC8 21280002 */  addu       $a1, $s0, $zero
    /* 34CC 80012CCC 2CCD030C */  jal        __mulsf3
    /* 34D0 80012CD0 9C00A2AF */   sw        $v0, 0x9C($sp)
    /* 34D4 80012CD4 4ECE030C */  jal        __fixsfsi
    /* 34D8 80012CD8 21204000 */   addu      $a0, $v0, $zero
    /* 34DC 80012CDC 3800B127 */  addiu      $s1, $sp, 0x38
    /* 34E0 80012CE0 21202002 */  addu       $a0, $s1, $zero
    /* 34E4 80012CE4 9800A527 */  addiu      $a1, $sp, 0x98
    /* 34E8 80012CE8 B94A000C */  jal        CameraLookAt__FP10matrixtdefP8coorddef
    /* 34EC 80012CEC A000A2AF */   sw        $v0, 0xA0($sp)
    /* 34F0 80012CF0 6000B027 */  addiu      $s0, $sp, 0x60
    /* 34F4 80012CF4 21200002 */  addu       $a0, $s0, $zero
    /* 34F8 80012CF8 04AB030C */  jal        fixedxformy
    /* 34FC 80012CFC 80291300 */   sll       $a1, $s3, 6
    /* 3500 80012D00 21202002 */  addu       $a0, $s1, $zero
    /* 3504 80012D04 21280002 */  addu       $a1, $s0, $zero
    /* 3508 80012D08 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 350C 80012D0C 1000A627 */   addiu     $a2, $sp, 0x10
    /* 3510 80012D10 F1D5030C */  jal        __extendsfdf2
    /* 3514 80012D14 2120C002 */   addu      $a0, $s6, $zero
    /* 3518 80012D18 2120A002 */  addu       $a0, $s5, $zero
    /* 351C 80012D1C 21804000 */  addu       $s0, $v0, $zero
    /* 3520 80012D20 F1D5030C */  jal        __extendsfdf2
    /* 3524 80012D24 21886000 */   addu      $s1, $v1, $zero
    /* 3528 80012D28 00000624 */  addiu      $a2, $zero, 0x0
    /* 352C 80012D2C 0440073C */  lui        $a3, (0x40040000 >> 16)
    /* 3530 80012D30 21204000 */  addu       $a0, $v0, $zero
    /* 3534 80012D34 75D7030C */  jal        __divdf3
    /* 3538 80012D38 21286000 */   addu      $a1, $v1, $zero
    /* 353C 80012D3C 21200002 */  addu       $a0, $s0, $zero
    /* 3540 80012D40 21282002 */  addu       $a1, $s1, $zero
    /* 3544 80012D44 21304000 */  addu       $a2, $v0, $zero
    /* 3548 80012D48 95D6030C */  jal        __adddf3
    /* 354C 80012D4C 21386000 */   addu      $a3, $v1, $zero
    /* 3550 80012D50 21204000 */  addu       $a0, $v0, $zero
    /* 3554 80012D54 49D6030C */  jal        __truncdfsf2
    /* 3558 80012D58 21286000 */   addu      $a1, $v1, $zero
    /* 355C 80012D5C 21B04000 */  addu       $s6, $v0, $zero
    /* 3560 80012D60 5D4B0008 */  j          .L80012D74
    /* 3564 80012D64 21A80000 */   addu      $s5, $zero, $zero
  .L80012D68:
    /* 3568 80012D68 1000A427 */  addiu      $a0, $sp, 0x10
    /* 356C 80012D6C 04AB030C */  jal        fixedxformy
    /* 3570 80012D70 80291300 */   sll       $a1, $s3, 6
  .L80012D74:
    /* 3574 80012D74 A800A427 */  addiu      $a0, $sp, 0xA8
    /* 3578 80012D78 1000A527 */  addiu      $a1, $sp, 0x10
    /* 357C 80012D7C 1400F226 */  addiu      $s2, $s7, 0x14
    /* 3580 80012D80 21304002 */  addu       $a2, $s2, $zero
    /* 3584 80012D84 0100113C */  lui        $s1, (0x10000 >> 16)
    /* 3588 80012D88 80890234 */  ori        $v0, $zero, 0x8980
    /* 358C 80012D8C A800B1AF */  sw         $s1, 0xA8($sp)
    /* 3590 80012D90 AC00A0AF */  sw         $zero, 0xAC($sp)
    /* 3594 80012D94 B000A0AF */  sw         $zero, 0xB0($sp)
    /* 3598 80012D98 B400A0AF */  sw         $zero, 0xB4($sp)
    /* 359C 80012D9C B800B1AF */  sw         $s1, 0xB8($sp)
    /* 35A0 80012DA0 BC00A0AF */  sw         $zero, 0xBC($sp)
    /* 35A4 80012DA4 C000A0AF */  sw         $zero, 0xC0($sp)
    /* 35A8 80012DA8 C400A0AF */  sw         $zero, 0xC4($sp)
    /* 35AC 80012DAC C800B1AF */  sw         $s1, 0xC8($sp)
    /* 35B0 80012DB0 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 35B4 80012DB4 B800A2AF */   sw        $v0, 0xB8($sp)
    /* 35B8 80012DB8 21204002 */  addu       $a0, $s2, $zero
    /* 35BC 80012DBC 4400F326 */  addiu      $s3, $s7, 0x44
    /* 35C0 80012DC0 D690030C */  jal        transpose
    /* 35C4 80012DC4 21286002 */   addu      $a1, $s3, $zero
    /* 35C8 80012DC8 8047103C */  lui        $s0, (0x47800000 >> 16)
    /* 35CC 80012DCC 2120A002 */  addu       $a0, $s5, $zero
    /* 35D0 80012DD0 8800A0AF */  sw         $zero, 0x88($sp)
    /* 35D4 80012DD4 2CCD030C */  jal        __mulsf3
    /* 35D8 80012DD8 21280002 */   addu      $a1, $s0, $zero
    /* 35DC 80012DDC 4ECE030C */  jal        __fixsfsi
    /* 35E0 80012DE0 21204000 */   addu      $a0, $v0, $zero
    /* 35E4 80012DE4 2120C002 */  addu       $a0, $s6, $zero
    /* 35E8 80012DE8 21280002 */  addu       $a1, $s0, $zero
    /* 35EC 80012DEC 2CCD030C */  jal        __mulsf3
    /* 35F0 80012DF0 8C00A2AF */   sw        $v0, 0x8C($sp)
    /* 35F4 80012DF4 4ECE030C */  jal        __fixsfsi
    /* 35F8 80012DF8 21204000 */   addu      $a0, $v0, $zero
    /* 35FC 80012DFC 8800B027 */  addiu      $s0, $sp, 0x88
    /* 3600 80012E00 21200002 */  addu       $a0, $s0, $zero
    /* 3604 80012E04 21284002 */  addu       $a1, $s2, $zero
    /* 3608 80012E08 0800E626 */  addiu      $a2, $s7, 0x8
    /* 360C 80012E0C B6AB030C */  jal        transform
    /* 3610 80012E10 9000A2AF */   sw        $v0, 0x90($sp)
    /* 3614 80012E14 0800E28E */  lw         $v0, 0x8($s7)
    /* 3618 80012E18 21200002 */  addu       $a0, $s0, $zero
    /* 361C 80012E1C 23100200 */  negu       $v0, $v0
    /* 3620 80012E20 8800A2AF */  sw         $v0, 0x88($sp)
    /* 3624 80012E24 0C00E28E */  lw         $v0, 0xC($s7)
    /* 3628 80012E28 21286002 */  addu       $a1, $s3, $zero
    /* 362C 80012E2C 23100200 */  negu       $v0, $v0
    /* 3630 80012E30 8C00A2AF */  sw         $v0, 0x8C($sp)
    /* 3634 80012E34 1000E28E */  lw         $v0, 0x10($s7)
    /* 3638 80012E38 3800E626 */  addiu      $a2, $s7, 0x38
    /* 363C 80012E3C 23100200 */  negu       $v0, $v0
    /* 3640 80012E40 B6AB030C */  jal        transform
    /* 3644 80012E44 9000A2AF */   sw        $v0, 0x90($sp)
    /* 3648 80012E48 F00091AE */  sw         $s1, 0xF0($s4)
    /* 364C 80012E4C 000191AE */  sw         $s1, 0x100($s4)
    /* 3650 80012E50 100191AE */  sw         $s1, 0x110($s4)
    /* 3654 80012E54 F40080AE */  sw         $zero, 0xF4($s4)
    /* 3658 80012E58 F80080AE */  sw         $zero, 0xF8($s4)
    /* 365C 80012E5C FC0080AE */  sw         $zero, 0xFC($s4)
    /* 3660 80012E60 040180AE */  sw         $zero, 0x104($s4)
    /* 3664 80012E64 080180AE */  sw         $zero, 0x108($s4)
    /* 3668 80012E68 0C0180AE */  sw         $zero, 0x10C($s4)
    /* 366C 80012E6C A00080AE */  sw         $zero, 0xA0($s4)
    /* 3670 80012E70 A40080AE */  sw         $zero, 0xA4($s4)
    /* 3674 80012E74 1000C017 */  bnez       $fp, .L80012EB8
    /* 3678 80012E78 A80080AE */   sw        $zero, 0xA8($s4)
    /* 367C 80012E7C 1480043C */  lui        $a0, %hi(generic128HzClock)
    /* 3680 80012E80 1480053C */  lui        $a1, %hi(R3DCar_ClockLast)
    /* 3684 80012E84 28C8838C */  lw         $v1, %lo(generic128HzClock)($a0)
    /* 3688 80012E88 ACD3A28C */  lw         $v0, %lo(R3DCar_ClockLast)($a1)
    /* 368C 80012E8C 00000000 */  nop
    /* 3690 80012E90 2A104300 */  slt        $v0, $v0, $v1
    /* 3694 80012E94 07004010 */  beqz       $v0, .L80012EB4
    /* 3698 80012E98 1480023C */   lui       $v0, %hi(R3DCar_Clock)
    /* 369C 80012E9C 28C8838C */  lw         $v1, %lo(generic128HzClock)($a0)
    /* 36A0 80012EA0 01000424 */  addiu      $a0, $zero, 0x1
    /* 36A4 80012EA4 A8D344AC */  sw         $a0, %lo(R3DCar_Clock)($v0)
    /* 36A8 80012EA8 05006324 */  addiu      $v1, $v1, 0x5
    /* 36AC 80012EAC AE4B0008 */  j          .L80012EB8
    /* 36B0 80012EB0 ACD3A3AC */   sw        $v1, %lo(R3DCar_ClockLast)($a1)
  .L80012EB4:
    /* 36B4 80012EB4 A8D340AC */  sw         $zero, %lo(R3DCar_Clock)($v0)
  .L80012EB8:
    /* 36B8 80012EB8 A681030C */  jal        Texture_LoadMenuTexture__Fv
    /* 36BC 80012EBC 0400FEAE */   sw        $fp, 0x4($s7)
    /* 36C0 80012EC0 21208002 */  addu       $a0, $s4, $zero
    /* 36C4 80012EC4 3FC4020C */  jal        R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
    /* 36C8 80012EC8 2128E002 */   addu      $a1, $s7, $zero
    /* 36CC 80012ECC 1C01A58F */  lw         $a1, 0x11C($sp)
    /* 36D0 80012ED0 D8C9020C */  jal        R3DCar_InsertCarFacetMenuII__FP8Car_tObji
    /* 36D4 80012ED4 21208002 */   addu      $a0, $s4, $zero
    /* 36D8 80012ED8 E2CA020C */  jal        R3DCar_Showroom__FP13DRender_tView
    /* 36DC 80012EDC 2120E002 */   addu      $a0, $s7, $zero
    /* 36E0 80012EE0 2001A88F */  lw         $t0, 0x120($sp)
    /* 36E4 80012EE4 00000000 */  nop
    /* 36E8 80012EE8 21000011 */  beqz       $t0, .L80012F70
    /* 36EC 80012EEC 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* 36F0 80012EF0 FC038434 */  ori        $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* 36F4 80012EF4 801F123C */  lui        $s2, (0x1F80000C >> 16)
    /* 36F8 80012EF8 1480113C */  lui        $s1, %hi(R3DCar_InMenu)
    /* 36FC 80012EFC 24D3228E */  lw         $v0, %lo(R3DCar_InMenu)($s1)
    /* 3700 80012F00 0C00438E */  lw         $v1, (0x1F80000C & 0xFFFF)($s2)
    /* 3704 80012F04 80004234 */  ori        $v0, $v0, 0x80
    /* 3708 80012F08 01006338 */  xori       $v1, $v1, 0x1
    /* 370C 80012F0C 24D322AE */  sw         $v0, %lo(R3DCar_InMenu)($s1)
    /* 3710 80012F10 2B91030C */  jal        SetSp
    /* 3714 80012F14 0C0043AE */   sw        $v1, (0x1F80000C & 0xFFFF)($s2)
    /* 3718 80012F18 21208002 */  addu       $a0, $s4, $zero
    /* 371C 80012F1C 2128E002 */  addu       $a1, $s7, $zero
    /* 3720 80012F20 1480103C */  lui        $s0, %hi(gWSavePtr)
    /* 3724 80012F24 1480133C */  lui        $s3, %hi(stackSpeedUpEnbabledFlag)
    /* 3728 80012F28 30D802AE */  sw         $v0, %lo(gWSavePtr)($s0)
    /* 372C 80012F2C 01000224 */  addiu      $v0, $zero, 0x1
    /* 3730 80012F30 3FC4020C */  jal        R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
    /* 3734 80012F34 1CD862AE */   sw        $v0, %lo(stackSpeedUpEnbabledFlag)($s3)
    /* 3738 80012F38 30D8048E */  lw         $a0, %lo(gWSavePtr)($s0)
    /* 373C 80012F3C 2B91030C */  jal        SetSp
    /* 3740 80012F40 00000000 */   nop
    /* 3744 80012F44 1C01A58F */  lw         $a1, 0x11C($sp)
    /* 3748 80012F48 21208002 */  addu       $a0, $s4, $zero
    /* 374C 80012F4C 30D802AE */  sw         $v0, %lo(gWSavePtr)($s0)
    /* 3750 80012F50 D8C9020C */  jal        R3DCar_InsertCarFacetMenuII__FP8Car_tObji
    /* 3754 80012F54 1CD860AE */   sw        $zero, %lo(stackSpeedUpEnbabledFlag)($s3)
    /* 3758 80012F58 24D3228E */  lw         $v0, %lo(R3DCar_InMenu)($s1)
    /* 375C 80012F5C 0C00438E */  lw         $v1, (0x1F80000C & 0xFFFF)($s2)
    /* 3760 80012F60 7F004230 */  andi       $v0, $v0, 0x7F
    /* 3764 80012F64 01006338 */  xori       $v1, $v1, 0x1
    /* 3768 80012F68 24D322AE */  sw         $v0, %lo(R3DCar_InMenu)($s1)
    /* 376C 80012F6C 0C0043AE */  sw         $v1, (0x1F80000C & 0xFFFF)($s2)
  .L80012F70:
    /* 3770 80012F70 F400BF8F */  lw         $ra, 0xF4($sp)
    /* 3774 80012F74 F000BE8F */  lw         $fp, 0xF0($sp)
    /* 3778 80012F78 EC00B78F */  lw         $s7, 0xEC($sp)
    /* 377C 80012F7C E800B68F */  lw         $s6, 0xE8($sp)
    /* 3780 80012F80 E400B58F */  lw         $s5, 0xE4($sp)
    /* 3784 80012F84 E000B48F */  lw         $s4, 0xE0($sp)
    /* 3788 80012F88 DC00B38F */  lw         $s3, 0xDC($sp)
    /* 378C 80012F8C D800B28F */  lw         $s2, 0xD8($sp)
    /* 3790 80012F90 D400B18F */  lw         $s1, 0xD4($sp)
    /* 3794 80012F94 D000B08F */  lw         $s0, 0xD0($sp)
    /* 3798 80012F98 0800E003 */  jr         $ra
    /* 379C 80012F9C F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
