.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_CreateSplat__FP18Weather_tSplatInfo, 0x128

glabel Weather_CreateSplat__FP18Weather_tSplatInfo
    /* D3F30 800E3730 21488000 */  addu       $t1, $a0, $zero
    /* D3F34 800E3734 801F073C */  lui        $a3, (0x1F800004 >> 16)
    /* D3F38 800E3738 0400E734 */  ori        $a3, $a3, (0x1F800004 & 0xFFFF)
    /* D3F3C 800E373C FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* D3F40 800E3740 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* D3F44 800E3744 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* D3F48 800E3748 0000E88C */  lw         $t0, 0x0($a3)
    /* D3F4C 800E374C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* D3F50 800E3750 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* D3F54 800E3754 00002A95 */  lhu        $t2, 0x0($t1)
    /* D3F58 800E3758 02002B95 */  lhu        $t3, 0x2($t1)
    /* D3F5C 800E375C 0000028D */  lw         $v0, 0x0($t0)
    /* D3F60 800E3760 0000A38C */  lw         $v1, 0x0($a1)
    /* D3F64 800E3764 24104600 */  and        $v0, $v0, $a2
    /* D3F68 800E3768 24186400 */  and        $v1, $v1, $a0
    /* D3F6C 800E376C 25104300 */  or         $v0, $v0, $v1
    /* D3F70 800E3770 28000325 */  addiu      $v1, $t0, 0x28
    /* D3F74 800E3774 000002AD */  sw         $v0, 0x0($t0)
    /* D3F78 800E3778 0000A28C */  lw         $v0, 0x0($a1)
    /* D3F7C 800E377C 24200401 */  and        $a0, $t0, $a0
    /* D3F80 800E3780 0000E3AC */  sw         $v1, 0x0($a3)
    /* D3F84 800E3784 24104600 */  and        $v0, $v0, $a2
    /* D3F88 800E3788 25104400 */  or         $v0, $v0, $a0
    /* D3F8C 800E378C 0000A2AC */  sw         $v0, 0x0($a1)
    /* D3F90 800E3790 09000224 */  addiu      $v0, $zero, 0x9
    /* D3F94 800E3794 030002A1 */  sb         $v0, 0x3($t0)
    /* D3F98 800E3798 2E000224 */  addiu      $v0, $zero, 0x2E
    /* D3F9C 800E379C 070002A1 */  sb         $v0, 0x7($t0)
    /* D3FA0 800E37A0 00002295 */  lhu        $v0, 0x0($t1)
    /* D3FA4 800E37A4 00000000 */  nop
    /* D3FA8 800E37A8 01004230 */  andi       $v0, $v0, 0x1
    /* D3FAC 800E37AC 02004010 */  beqz       $v0, .L800E37B8
    /* D3FB0 800E37B0 12000724 */   addiu     $a3, $zero, 0x12
    /* D3FB4 800E37B4 0C000724 */  addiu      $a3, $zero, 0xC
  .L800E37B8:
    /* D3FB8 800E37B8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* D3FBC 800E37BC B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* D3FC0 800E37C0 0400228D */  lw         $v0, 0x4($t1)
    /* D3FC4 800E37C4 00000000 */  nop
    /* D3FC8 800E37C8 23186200 */  subu       $v1, $v1, $v0
    /* D3FCC 800E37CC 80200300 */  sll        $a0, $v1, 2
    /* D3FD0 800E37D0 80FF0224 */  addiu      $v0, $zero, -0x80
    /* D3FD4 800E37D4 23104400 */  subu       $v0, $v0, $a0
    /* D3FD8 800E37D8 C3180300 */  sra        $v1, $v1, 3
    /* D3FDC 800E37DC 23304301 */  subu       $a2, $t2, $v1
    /* D3FE0 800E37E0 060002A1 */  sb         $v0, 0x6($t0)
    /* D3FE4 800E37E4 050002A1 */  sb         $v0, 0x5($t0)
    /* D3FE8 800E37E8 040002A1 */  sb         $v0, 0x4($t0)
    /* D3FEC 800E37EC 21106301 */  addu       $v0, $t3, $v1
    /* D3FF0 800E37F0 23284300 */  subu       $a1, $v0, $v1
    /* D3FF4 800E37F4 21204701 */  addu       $a0, $t2, $a3
    /* D3FF8 800E37F8 21208300 */  addu       $a0, $a0, $v1
    /* D3FFC 800E37FC 21104700 */  addu       $v0, $v0, $a3
    /* D4000 800E3800 40180300 */  sll        $v1, $v1, 1
    /* D4004 800E3804 21104300 */  addu       $v0, $v0, $v1
    /* D4008 800E3808 1A0002A5 */  sh         $v0, 0x1A($t0)
    /* D400C 800E380C 220002A5 */  sh         $v0, 0x22($t0)
    /* D4010 800E3810 1180023C */  lui        $v0, %hi(D_80112B84)
    /* D4014 800E3814 080006A5 */  sh         $a2, 0x8($t0)
    /* D4018 800E3818 0A0005A5 */  sh         $a1, 0xA($t0)
    /* D401C 800E381C 100004A5 */  sh         $a0, 0x10($t0)
    /* D4020 800E3820 120005A5 */  sh         $a1, 0x12($t0)
    /* D4024 800E3824 180006A5 */  sh         $a2, 0x18($t0)
    /* D4028 800E3828 200004A5 */  sh         $a0, 0x20($t0)
    /* D402C 800E382C 842B428C */  lw         $v0, %lo(D_80112B84)($v0)
    /* D4030 800E3830 00000000 */  nop
    /* D4034 800E3834 0000438C */  lw         $v1, 0x0($v0)
    /* D4038 800E3838 0400448C */  lw         $a0, 0x4($v0)
    /* D403C 800E383C 0800458C */  lw         $a1, 0x8($v0)
    /* D4040 800E3840 0C00428C */  lw         $v0, 0xC($v0)
    /* D4044 800E3844 0C0003AD */  sw         $v1, 0xC($t0)
    /* D4048 800E3848 140004AD */  sw         $a0, 0x14($t0)
    /* D404C 800E384C 1C0005AD */  sw         $a1, 0x1C($t0)
    /* D4050 800E3850 0800E003 */  jr         $ra
    /* D4054 800E3854 240002AD */   sw        $v0, 0x24($t0)
endlabel Weather_CreateSplat__FP18Weather_tSplatInfo
