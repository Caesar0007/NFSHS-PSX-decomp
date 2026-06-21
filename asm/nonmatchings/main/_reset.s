.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _reset, 0x150

glabel _reset
    /* E006C 800EF86C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0070 800EF870 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0074 800EF874 21808000 */  addu       $s0, $a0, $zero
    /* E0078 800EF878 1400BFAF */  sw         $ra, 0x14($sp)
    /* E007C 800EF87C 54CA030C */  jal        SetIntrMask
    /* E0080 800EF880 21200000 */   addu      $a0, $zero, $zero
    /* E0084 800EF884 1280013C */  lui        $at, %hi(_qout)
    /* E0088 800EF888 C83720AC */  sw         $zero, %lo(_qout)($at)
    /* E008C 800EF88C 1280033C */  lui        $v1, %hi(_qout)
    /* E0090 800EF890 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* E0094 800EF894 1280013C */  lui        $at, %hi(D_801237D4)
    /* E0098 800EF898 D43722AC */  sw         $v0, %lo(D_801237D4)($at)
    /* E009C 800EF89C 01000224 */  addiu      $v0, $zero, 0x1
    /* E00A0 800EF8A0 1280013C */  lui        $at, %hi(_qin)
    /* E00A4 800EF8A4 C43723AC */  sw         $v1, %lo(_qin)($at)
    /* E00A8 800EF8A8 07000332 */  andi       $v1, $s0, 0x7
    /* E00AC 800EF8AC 23006210 */  beq        $v1, $v0, .L800EF93C
    /* E00B0 800EF8B0 02006228 */   slti      $v0, $v1, 0x2
    /* E00B4 800EF8B4 05004010 */  beqz       $v0, .L800EF8CC
    /* E00B8 800EF8B8 03000224 */   addiu     $v0, $zero, 0x3
    /* E00BC 800EF8BC 07006010 */  beqz       $v1, .L800EF8DC
    /* E00C0 800EF8C0 00000000 */   nop
    /* E00C4 800EF8C4 62BE0308 */  j          .L800EF988
    /* E00C8 800EF8C8 00000000 */   nop
  .L800EF8CC:
    /* E00CC 800EF8CC 1B006210 */  beq        $v1, $v0, .L800EF93C
    /* E00D0 800EF8D0 05000224 */   addiu     $v0, $zero, 0x5
    /* E00D4 800EF8D4 2C006214 */  bne        $v1, $v0, .L800EF988
    /* E00D8 800EF8D8 00000000 */   nop
  .L800EF8DC:
    /* E00DC 800EF8DC 1280033C */  lui        $v1, %hi(D_801237B0)
    /* E00E0 800EF8E0 B037638C */  lw         $v1, %lo(D_801237B0)($v1)
    /* E00E4 800EF8E4 01040224 */  addiu      $v0, $zero, 0x401
    /* E00E8 800EF8E8 000062AC */  sw         $v0, 0x0($v1)
    /* E00EC 800EF8EC 1280033C */  lui        $v1, %hi(D_801237C0)
    /* E00F0 800EF8F0 C037638C */  lw         $v1, %lo(D_801237C0)($v1)
    /* E00F4 800EF8F4 1480043C */  lui        $a0, %hi(D_8013EAF8)
    /* E00F8 800EF8F8 F8EA8424 */  addiu      $a0, $a0, %lo(D_8013EAF8)
    /* E00FC 800EF8FC 0000628C */  lw         $v0, 0x0($v1)
    /* E0100 800EF900 21280000 */  addu       $a1, $zero, $zero
    /* E0104 800EF904 00084234 */  ori        $v0, $v0, 0x800
    /* E0108 800EF908 000062AC */  sw         $v0, 0x0($v1)
    /* E010C 800EF90C 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E0110 800EF910 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E0114 800EF914 00010624 */  addiu      $a2, $zero, 0x100
    /* E0118 800EF918 8DBF030C */  jal        _memset
    /* E011C 800EF91C 000040AC */   sw        $zero, 0x0($v0)
    /* E0120 800EF920 1480043C */  lui        $a0, %hi(_que)
    /* E0124 800EF924 00EC8424 */  addiu      $a0, $a0, %lo(_que)
    /* E0128 800EF928 21280000 */  addu       $a1, $zero, $zero
    /* E012C 800EF92C 8DBF030C */  jal        _memset
    /* E0130 800EF930 00180624 */   addiu     $a2, $zero, 0x1800
    /* E0134 800EF934 62BE0308 */  j          .L800EF988
    /* E0138 800EF938 00000000 */   nop
  .L800EF93C:
    /* E013C 800EF93C 1280033C */  lui        $v1, %hi(D_801237B0)
    /* E0140 800EF940 B037638C */  lw         $v1, %lo(D_801237B0)($v1)
    /* E0144 800EF944 01040224 */  addiu      $v0, $zero, 0x401
    /* E0148 800EF948 000062AC */  sw         $v0, 0x0($v1)
    /* E014C 800EF94C 1280033C */  lui        $v1, %hi(D_801237C0)
    /* E0150 800EF950 C037638C */  lw         $v1, %lo(D_801237C0)($v1)
    /* E0154 800EF954 00000000 */  nop
    /* E0158 800EF958 0000628C */  lw         $v0, 0x0($v1)
    /* E015C 800EF95C 00000000 */  nop
    /* E0160 800EF960 00084234 */  ori        $v0, $v0, 0x800
    /* E0164 800EF964 000062AC */  sw         $v0, 0x0($v1)
    /* E0168 800EF968 1280033C */  lui        $v1, %hi(D_801237A4)
    /* E016C 800EF96C A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* E0170 800EF970 0002023C */  lui        $v0, (0x2000000 >> 16)
    /* E0174 800EF974 000062AC */  sw         $v0, 0x0($v1)
    /* E0178 800EF978 1280033C */  lui        $v1, %hi(D_801237A4)
    /* E017C 800EF97C A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* E0180 800EF980 0001023C */  lui        $v0, (0x1000000 >> 16)
    /* E0184 800EF984 000062AC */  sw         $v0, 0x0($v1)
  .L800EF988:
    /* E0188 800EF988 1280043C */  lui        $a0, %hi(D_801237D4)
    /* E018C 800EF98C D437848C */  lw         $a0, %lo(D_801237D4)($a0)
    /* E0190 800EF990 54CA030C */  jal        SetIntrMask
    /* E0194 800EF994 00000000 */   nop
    /* E0198 800EF998 07000232 */  andi       $v0, $s0, 0x7
    /* E019C 800EF99C 03004014 */  bnez       $v0, .L800EF9AC
    /* E01A0 800EF9A0 21100000 */   addu      $v0, $zero, $zero
    /* E01A4 800EF9A4 1CBF030C */  jal        _gpu_init_videomode
    /* E01A8 800EF9A8 21200002 */   addu      $a0, $s0, $zero
  .L800EF9AC:
    /* E01AC 800EF9AC 1400BF8F */  lw         $ra, 0x14($sp)
    /* E01B0 800EF9B0 1000B08F */  lw         $s0, 0x10($sp)
    /* E01B4 800EF9B4 0800E003 */  jr         $ra
    /* E01B8 800EF9B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _reset
