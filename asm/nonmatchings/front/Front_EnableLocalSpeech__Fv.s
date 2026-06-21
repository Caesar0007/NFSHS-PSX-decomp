.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_EnableLocalSpeech__Fv, 0x8C

glabel Front_EnableLocalSpeech__Fv
    /* 1AEAC 8002A6AC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 1AEB0 8002A6B0 4400B1AF */  sw         $s1, 0x44($sp)
    /* 1AEB4 8002A6B4 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1AEB8 8002A6B8 4000B0AF */  sw         $s0, 0x40($sp)
    /* 1AEBC 8002A6BC 00465024 */  addiu      $s0, $v0, %lo(frontEnd)
    /* 1AEC0 8002A6C0 4800BFAF */  sw         $ra, 0x48($sp)
    /* 1AEC4 8002A6C4 04000392 */  lbu        $v1, 0x4($s0)
    /* 1AEC8 8002A6C8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1AECC 8002A6CC 14006214 */  bne        $v1, $v0, .L8002A720
    /* 1AED0 8002A6D0 21880000 */   addu      $s1, $zero, $zero
    /* 1AED4 8002A6D4 1180043C */  lui        $a0, %hi(trackManager)
    /* 1AED8 8002A6D8 46000292 */  lbu        $v0, 0x46($s0)
    /* 1AEDC 8002A6DC 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 1AEE0 8002A6E0 21105000 */  addu       $v0, $v0, $s0
    /* 1AEE4 8002A6E4 23004590 */  lbu        $a1, 0x23($v0)
    /* 1AEE8 8002A6E8 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 1AEEC 8002A6EC 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1AEF0 8002A6F0 2B00A393 */  lbu        $v1, 0x2B($sp)
    /* 1AEF4 8002A6F4 40030292 */  lbu        $v0, 0x340($s0)
    /* 1AEF8 8002A6F8 00000000 */  nop
    /* 1AEFC 8002A6FC 09006210 */  beq        $v1, $v0, .L8002A724
    /* 1AF00 8002A700 21102002 */   addu      $v0, $s1, $zero
    /* 1AF04 8002A704 06006004 */  bltz       $v1, .L8002A720
    /* 1AF08 8002A708 03006228 */   slti      $v0, $v1, 0x3
    /* 1AF0C 8002A70C 03004014 */  bnez       $v0, .L8002A71C
    /* 1AF10 8002A710 06000224 */   addiu     $v0, $zero, 0x6
    /* 1AF14 8002A714 03006214 */  bne        $v1, $v0, .L8002A724
    /* 1AF18 8002A718 21102002 */   addu      $v0, $s1, $zero
  .L8002A71C:
    /* 1AF1C 8002A71C 01001124 */  addiu      $s1, $zero, 0x1
  .L8002A720:
    /* 1AF20 8002A720 21102002 */  addu       $v0, $s1, $zero
  .L8002A724:
    /* 1AF24 8002A724 4800BF8F */  lw         $ra, 0x48($sp)
    /* 1AF28 8002A728 4400B18F */  lw         $s1, 0x44($sp)
    /* 1AF2C 8002A72C 4000B08F */  lw         $s0, 0x40($sp)
    /* 1AF30 8002A730 0800E003 */  jr         $ra
    /* 1AF34 8002A734 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Front_EnableLocalSpeech__Fv
