.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_InitSystem__FPc, 0x194

glabel Anim_InitSystem__FPc
    /* 6431C 80073B1C 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 64320 80073B20 6C00B3AF */  sw         $s3, 0x6C($sp)
    /* 64324 80073B24 21988000 */  addu       $s3, $a0, $zero
    /* 64328 80073B28 7000BFAF */  sw         $ra, 0x70($sp)
    /* 6432C 80073B2C 6800B2AF */  sw         $s2, 0x68($sp)
    /* 64330 80073B30 6400B1AF */  sw         $s1, 0x64($sp)
    /* 64334 80073B34 A5CE010C */  jal        Anim_Restart__Fv
    /* 64338 80073B38 6000B0AF */   sw        $s0, 0x60($sp)
    /* 6433C 80073B3C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 64340 80073B40 1480053C */  lui        $a1, %hi(D_8013C5FC)
    /* 64344 80073B44 FCC5A524 */  addiu      $a1, $a1, %lo(D_8013C5FC)
    /* 64348 80073B48 2F91030C */  jal        sprintf
    /* 6434C 80073B4C 21306002 */   addu      $a2, $s3, $zero
    /* 64350 80073B50 1000A427 */  addiu      $a0, $sp, 0x10
    /* 64354 80073B54 EA95030C */  jal        loadfileadrz
    /* 64358 80073B58 21280000 */   addu      $a1, $zero, $zero
    /* 6435C 80073B5C 21884000 */  addu       $s1, $v0, $zero
    /* 64360 80073B60 25002012 */  beqz       $s1, .L80073BF8
    /* 64364 80073B64 09001024 */   addiu     $s0, $zero, 0x9
    /* 64368 80073B68 9B95030C */  jal        filesize
    /* 6436C 80073B6C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 64370 80073B70 21804000 */  addu       $s0, $v0, $zero
    /* 64374 80073B74 21200002 */  addu       $a0, $s0, $zero
    /* 64378 80073B78 0580053C */  lui        $a1, %hi(D_8005569C)
    /* 6437C 80073B7C 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 64380 80073B80 9C56A524 */   addiu     $a1, $a1, %lo(D_8005569C)
    /* 64384 80073B84 21202002 */  addu       $a0, $s1, $zero
    /* 64388 80073B88 21904000 */  addu       $s2, $v0, $zero
    /* 6438C 80073B8C 21284002 */  addu       $a1, $s2, $zero
    /* 64390 80073B90 B798030C */  jal        blockmove
    /* 64394 80073B94 21300002 */   addu      $a2, $s0, $zero
    /* 64398 80073B98 5095030C */  jal        purgememadr
    /* 6439C 80073B9C 21202002 */   addu      $a0, $s1, $zero
    /* 643A0 80073BA0 21206002 */  addu       $a0, $s3, $zero
    /* 643A4 80073BA4 1480053C */  lui        $a1, %hi(D_8013C604)
    /* 643A8 80073BA8 B398030C */  jal        strstr
    /* 643AC 80073BAC 04C6A524 */   addiu     $a1, $a1, %lo(D_8013C604)
    /* 643B0 80073BB0 21800000 */  addu       $s0, $zero, $zero
    /* 643B4 80073BB4 0580133C */  lui        $s3, %hi(D_800556A8)
    /* 643B8 80073BB8 1180023C */  lui        $v0, %hi(animScripts)
    /* 643BC 80073BBC 4CE25124 */  addiu      $s1, $v0, %lo(animScripts)
  .L80073BC0:
    /* 643C0 80073BC0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 643C4 80073BC4 A8566526 */  addiu      $a1, $s3, %lo(D_800556A8)
    /* 643C8 80073BC8 2F91030C */  jal        sprintf
    /* 643CC 80073BCC 21300002 */   addu      $a2, $s0, $zero
    /* 643D0 80073BD0 21204002 */  addu       $a0, $s2, $zero
    /* 643D4 80073BD4 8698030C */  jal        locatebig
    /* 643D8 80073BD8 1000A527 */   addiu     $a1, $sp, 0x10
    /* 643DC 80073BDC 000022AE */  sw         $v0, 0x0($s1)
    /* 643E0 80073BE0 01001026 */  addiu      $s0, $s0, 0x1
    /* 643E4 80073BE4 0A00022A */  slti       $v0, $s0, 0xA
    /* 643E8 80073BE8 F5FF4014 */  bnez       $v0, .L80073BC0
    /* 643EC 80073BEC 04003126 */   addiu     $s1, $s1, 0x4
    /* 643F0 80073BF0 05CF0108 */  j          .L80073C14
    /* 643F4 80073BF4 00000000 */   nop
  .L80073BF8:
    /* 643F8 80073BF8 1180023C */  lui        $v0, %hi(animScripts)
    /* 643FC 80073BFC 4CE24224 */  addiu      $v0, $v0, %lo(animScripts)
    /* 64400 80073C00 24004224 */  addiu      $v0, $v0, 0x24
  .L80073C04:
    /* 64404 80073C04 000040AC */  sw         $zero, 0x0($v0)
    /* 64408 80073C08 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* 6440C 80073C0C FDFF0106 */  bgez       $s0, .L80073C04
    /* 64410 80073C10 FCFF4224 */   addiu     $v0, $v0, -0x4
  .L80073C14:
    /* 64414 80073C14 1480023C */  lui        $v0, %hi(gPersistObjInst)
    /* 64418 80073C18 C0D4428C */  lw         $v0, %lo(gPersistObjInst)($v0)
    /* 6441C 80073C1C 00000000 */  nop
    /* 64420 80073C20 1B004010 */  beqz       $v0, .L80073C90
    /* 64424 80073C24 00000000 */   nop
    /* 64428 80073C28 0000448C */  lw         $a0, 0x0($v0)
    /* 6442C 80073C2C 04004324 */  addiu      $v1, $v0, 0x4
    /* 64430 80073C30 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 64434 80073C34 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 64438 80073C38 15008210 */  beq        $a0, $v0, .L80073C90
    /* 6443C 80073C3C 1180023C */   lui       $v0, %hi(Anim_gInstanceFromIndex)
    /* 64440 80073C40 03000824 */  addiu      $t0, $zero, 0x3
    /* 64444 80073C44 07000724 */  addiu      $a3, $zero, 0x7
    /* 64448 80073C48 CCE14624 */  addiu      $a2, $v0, %lo(Anim_gInstanceFromIndex)
    /* 6444C 80073C4C FFFF0524 */  addiu      $a1, $zero, -0x1
  .L80073C50:
    /* 64450 80073C50 02006290 */  lbu        $v0, 0x2($v1)
    /* 64454 80073C54 00000000 */  nop
    /* 64458 80073C58 03004810 */  beq        $v0, $t0, .L80073C68
    /* 6445C 80073C5C 00000000 */   nop
    /* 64460 80073C60 07004714 */  bne        $v0, $a3, .L80073C80
    /* 64464 80073C64 00000000 */   nop
  .L80073C68:
    /* 64468 80073C68 03006290 */  lbu        $v0, 0x3($v1)
    /* 6446C 80073C6C 00000000 */  nop
    /* 64470 80073C70 03004010 */  beqz       $v0, .L80073C80
    /* 64474 80073C74 80100200 */   sll       $v0, $v0, 2
    /* 64478 80073C78 21104600 */  addu       $v0, $v0, $a2
    /* 6447C 80073C7C 000043AC */  sw         $v1, 0x0($v0)
  .L80073C80:
    /* 64480 80073C80 00006284 */  lh         $v0, 0x0($v1)
    /* 64484 80073C84 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 64488 80073C88 F1FF8514 */  bne        $a0, $a1, .L80073C50
    /* 6448C 80073C8C 21186200 */   addu      $v1, $v1, $v0
  .L80073C90:
    /* 64490 80073C90 7000BF8F */  lw         $ra, 0x70($sp)
    /* 64494 80073C94 6C00B38F */  lw         $s3, 0x6C($sp)
    /* 64498 80073C98 6800B28F */  lw         $s2, 0x68($sp)
    /* 6449C 80073C9C 6400B18F */  lw         $s1, 0x64($sp)
    /* 644A0 80073CA0 6000B08F */  lw         $s0, 0x60($sp)
    /* 644A4 80073CA4 21100000 */  addu       $v0, $zero, $zero
    /* 644A8 80073CA8 0800E003 */  jr         $ra
    /* 644AC 80073CAC 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Anim_InitSystem__FPc
