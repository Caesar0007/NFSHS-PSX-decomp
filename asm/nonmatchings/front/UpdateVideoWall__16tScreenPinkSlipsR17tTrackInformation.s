.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation, 0xAC

glabel UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
    /* 29B68 80039368 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 29B6C 8003936C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 29B70 80039370 21888000 */  addu       $s1, $a0, $zero
    /* 29B74 80039374 1800B2AF */  sw         $s2, 0x18($sp)
    /* 29B78 80039378 2190A000 */  addu       $s2, $a1, $zero
    /* 29B7C 8003937C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 29B80 80039380 1000B0AF */  sw         $s0, 0x10($sp)
    /* 29B84 80039384 00004292 */  lbu        $v0, 0x0($s2)
    /* 29B88 80039388 70002386 */  lh         $v1, 0x70($s1)
    /* 29B8C 8003938C 00360200 */  sll        $a2, $v0, 24
    /* 29B90 80039390 03160600 */  sra        $v0, $a2, 24
    /* 29B94 80039394 19004310 */  beq        $v0, $v1, .L800393FC
    /* 29B98 80039398 0580103C */   lui       $s0, %hi(D_80052C00)
    /* 29B9C 8003939C 002C1026 */  addiu      $s0, $s0, %lo(D_80052C00)
    /* 29BA0 800393A0 21200002 */  addu       $a0, $s0, $zero
    /* 29BA4 800393A4 0180053C */  lui        $a1, %hi(D_80011924)
    /* 29BA8 800393A8 2419A524 */  addiu      $a1, $a1, %lo(D_80011924)
    /* 29BAC 800393AC 2F91030C */  jal        sprintf
    /* 29BB0 800393B0 21304000 */   addu      $a2, $v0, $zero
    /* 29BB4 800393B4 21202002 */  addu       $a0, $s1, $zero
    /* 29BB8 800393B8 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 29BBC 800393BC 21280002 */   addu      $a1, $s0, $zero
    /* 29BC0 800393C0 C40220AE */  sw         $zero, 0x2C4($s1)
    /* 29BC4 800393C4 00004292 */  lbu        $v0, 0x0($s2)
    /* 29BC8 800393C8 80002382 */  lb         $v1, 0x80($s1)
    /* 29BCC 800393CC 00160200 */  sll        $v0, $v0, 24
    /* 29BD0 800393D0 03160200 */  sra        $v0, $v0, 24
    /* 29BD4 800393D4 06006004 */  bltz       $v1, .L800393F0
    /* 29BD8 800393D8 700022A6 */   sh        $v0, 0x70($s1)
    /* 29BDC 800393DC 1480023C */  lui        $v0, %hi(ticks)
    /* 29BE0 800393E0 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 29BE4 800393E4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 29BE8 800393E8 800022A2 */  sb         $v0, 0x80($s1)
    /* 29BEC 800393EC 7C0023AE */  sw         $v1, 0x7C($s1)
  .L800393F0:
    /* 29BF0 800393F0 6800248E */  lw         $a0, 0x68($s1)
    /* 29BF4 800393F4 D543010C */  jal        VIDEO_abortplayback__Fi
    /* 29BF8 800393F8 00000000 */   nop
  .L800393FC:
    /* 29BFC 800393FC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 29C00 80039400 1800B28F */  lw         $s2, 0x18($sp)
    /* 29C04 80039404 1400B18F */  lw         $s1, 0x14($sp)
    /* 29C08 80039408 1000B08F */  lw         $s0, 0x10($sp)
    /* 29C0C 8003940C 0800E003 */  jr         $ra
    /* 29C10 80039410 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
