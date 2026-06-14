.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__21tPListIteratorIndexed7tPlayer, 0x8C

glabel Increment__21tPListIteratorIndexed7tPlayer
    /* 97A90 800A7290 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97A94 800A7294 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97A98 800A7298 0C00828C */  lw         $v0, 0xC($a0)
    /* 97A9C 800A729C 00000000 */  nop
    /* 97AA0 800A72A0 00004390 */  lbu        $v1, 0x0($v0)
    /* 97AA4 800A72A4 0400828C */  lw         $v0, 0x4($a0)
    /* 97AA8 800A72A8 80180300 */  sll        $v1, $v1, 2
    /* 97AAC 800A72AC 21186200 */  addu       $v1, $v1, $v0
    /* 97AB0 800A72B0 0000628C */  lw         $v0, 0x0($v1)
    /* 97AB4 800A72B4 00000000 */  nop
    /* 97AB8 800A72B8 01004224 */  addiu      $v0, $v0, 0x1
    /* 97ABC 800A72BC 000062AC */  sw         $v0, 0x0($v1)
    /* 97AC0 800A72C0 0C00828C */  lw         $v0, 0xC($a0)
    /* 97AC4 800A72C4 00000000 */  nop
    /* 97AC8 800A72C8 00004290 */  lbu        $v0, 0x0($v0)
    /* 97ACC 800A72CC 0400838C */  lw         $v1, 0x4($a0)
    /* 97AD0 800A72D0 80100200 */  sll        $v0, $v0, 2
    /* 97AD4 800A72D4 21284300 */  addu       $a1, $v0, $v1
    /* 97AD8 800A72D8 0000A28C */  lw         $v0, 0x0($a1)
    /* 97ADC 800A72DC 0000838C */  lw         $v1, 0x0($a0)
    /* 97AE0 800A72E0 40100200 */  sll        $v0, $v0, 1
    /* 97AE4 800A72E4 21104300 */  addu       $v0, $v0, $v1
    /* 97AE8 800A72E8 00004284 */  lh         $v0, 0x0($v0)
    /* 97AEC 800A72EC 00000000 */  nop
    /* 97AF0 800A72F0 02004014 */  bnez       $v0, .L800A72FC
    /* 97AF4 800A72F4 00000000 */   nop
    /* 97AF8 800A72F8 0000A0AC */  sw         $zero, 0x0($a1)
  .L800A72FC:
    /* 97AFC 800A72FC B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 97B00 800A7300 05000424 */   addiu     $a0, $zero, 0x5
    /* 97B04 800A7304 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97B08 800A7308 01000224 */  addiu      $v0, $zero, 0x1
    /* 97B0C 800A730C 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 97B10 800A7310 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 97B14 800A7314 0800E003 */  jr         $ra
    /* 97B18 800A7318 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Increment__21tPListIteratorIndexed7tPlayer
