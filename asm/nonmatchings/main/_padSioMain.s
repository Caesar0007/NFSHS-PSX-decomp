.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSioMain, 0xC8

glabel _padSioMain
    /* F5860 80105060 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5864 80105064 1380053C */  lui        $a1, %hi(_padSioState)
    /* F5868 80105068 BC7CA524 */  addiu      $a1, $a1, %lo(_padSioState)
    /* F586C 8010506C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F5870 80105070 0000A38C */  lw         $v1, 0x0($a1)
    /* F5874 80105074 00000000 */  nop
    /* F5878 80105078 80100300 */  sll        $v0, $v1, 2
    /* F587C 8010507C 1480013C */  lui        $at, %hi(padIntFunc)
    /* F5880 80105080 21082200 */  addu       $at, $at, $v0
    /* F5884 80105084 14C3228C */  lw         $v0, %lo(padIntFunc)($at)
    /* F5888 80105088 01006324 */  addiu      $v1, $v1, 0x1
    /* F588C 8010508C 09F84000 */  jalr       $v0
    /* F5890 80105090 0000A3AC */   sw        $v1, 0x0($a1)
    /* F5894 80105094 21204000 */  addu       $a0, $v0, $zero
    /* F5898 80105098 1A008004 */  bltz       $a0, .L80105104
    /* F589C 8010509C 00000000 */   nop
    /* F58A0 801050A0 1380023C */  lui        $v0, %hi(_padSioState)
    /* F58A4 801050A4 BC7C428C */  lw         $v0, %lo(_padSioState)($v0)
    /* F58A8 801050A8 00000000 */  nop
    /* F58AC 801050AC 0C004010 */  beqz       $v0, .L801050E0
    /* F58B0 801050B0 00000000 */   nop
    /* F58B4 801050B4 FA2F040C */  jal        setRC2wait
    /* F58B8 801050B8 3C000424 */   addiu     $a0, $zero, 0x3C
    /* F58BC 801050BC 4E15040C */  jal        _padClrIntSio0
    /* F58C0 801050C0 00000000 */   nop
    /* F58C4 801050C4 06004014 */  bnez       $v0, .L801050E0
    /* F58C8 801050C8 00000000 */   nop
    /* F58CC 801050CC 1380023C */  lui        $v0, %hi(_padFuncNextPort)
    /* F58D0 801050D0 787C428C */  lw         $v0, %lo(_padFuncNextPort)($v0)
    /* F58D4 801050D4 00000000 */  nop
    /* F58D8 801050D8 09F84000 */  jalr       $v0
    /* F58DC 801050DC FDFF0424 */   addiu     $a0, $zero, -0x3
  .L801050E0:
    /* F58E0 801050E0 1380033C */  lui        $v1, %hi(_padSioState)
    /* F58E4 801050E4 BC7C638C */  lw         $v1, %lo(_padSioState)($v1)
    /* F58E8 801050E8 00000000 */  nop
    /* F58EC 801050EC 05006228 */  slti       $v0, $v1, 0x5
    /* F58F0 801050F0 09004014 */  bnez       $v0, .L80105118
    /* F58F4 801050F4 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* F58F8 801050F8 1380013C */  lui        $at, %hi(_padSioState)
    /* F58FC 801050FC 46140408 */  j          .L80105118
    /* F5900 80105100 BC7C22AC */   sw        $v0, %lo(_padSioState)($at)
  .L80105104:
    /* F5904 80105104 1380023C */  lui        $v0, %hi(_padFuncNextPort)
    /* F5908 80105108 787C428C */  lw         $v0, %lo(_padFuncNextPort)($v0)
    /* F590C 8010510C 00000000 */  nop
    /* F5910 80105110 09F84000 */  jalr       $v0
    /* F5914 80105114 00000000 */   nop
  .L80105118:
    /* F5918 80105118 1000BF8F */  lw         $ra, 0x10($sp)
    /* F591C 8010511C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F5920 80105120 0800E003 */  jr         $ra
    /* F5924 80105124 00000000 */   nop
endlabel _padSioMain
