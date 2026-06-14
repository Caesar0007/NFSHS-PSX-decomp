.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_HandleTrafficHonking__FP8Car_tObj, 0x104

glabel AI_HandleTrafficHonking__FP8Car_tObj
    /* 4A388 80059B88 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4A38C 80059B8C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4A390 80059B90 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4A394 80059B94 FBA1010C */  jal        AILife_IsCarInAnyVisibleArea__FP8Car_tObj
    /* 4A398 80059B98 21808000 */   addu      $s0, $a0, $zero
    /* 4A39C 80059B9C 6002038E */  lw         $v1, 0x260($s0)
    /* 4A3A0 80059BA0 00000000 */  nop
    /* 4A3A4 80059BA4 10006330 */  andi       $v1, $v1, 0x10
    /* 4A3A8 80059BA8 34006010 */  beqz       $v1, .L80059C7C
    /* 4A3AC 80059BAC 21204000 */   addu      $a0, $v0, $zero
    /* 4A3B0 80059BB0 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 4A3B4 80059BB4 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 4A3B8 80059BB8 5405038E */  lw         $v1, 0x554($s0)
    /* 4A3BC 80059BBC 02004014 */  bnez       $v0, .L80059BC8
    /* 4A3C0 80059BC0 27100300 */   nor       $v0, $zero, $v1
    /* 4A3C4 80059BC4 01006238 */  xori       $v0, $v1, 0x1
  .L80059BC8:
    /* 4A3C8 80059BC8 2B100200 */  sltu       $v0, $zero, $v0
    /* 4A3CC 80059BCC 2B004010 */  beqz       $v0, .L80059C7C
    /* 4A3D0 80059BD0 00000000 */   nop
    /* 4A3D4 80059BD4 29008010 */  beqz       $a0, .L80059C7C
    /* 4A3D8 80059BD8 1180023C */   lui       $v0, %hi(D_8010CD0C)
    /* 4A3DC 80059BDC 0CCD438C */  lw         $v1, %lo(D_8010CD0C)($v0)
    /* 4A3E0 80059BE0 FDFF023C */  lui        $v0, (0xFFFD0000 >> 16)
    /* 4A3E4 80059BE4 2A104300 */  slt        $v0, $v0, $v1
    /* 4A3E8 80059BE8 24004010 */  beqz       $v0, .L80059C7C
    /* 4A3EC 80059BEC 00000000 */   nop
    /* 4A3F0 80059BF0 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4A3F4 80059BF4 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4A3F8 80059BF8 1480023C */  lui        $v0, %hi(randSeed)
    /* 4A3FC 80059BFC 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4A400 80059C00 00000000 */  nop
    /* 4A404 80059C04 18006200 */  mult       $v1, $v0
    /* 4A408 80059C08 12180000 */  mflo       $v1
    /* 4A40C 80059C0C FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4A410 80059C10 1480013C */  lui        $at, %hi(randtemp)
    /* 4A414 80059C14 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4A418 80059C18 021A0300 */  srl        $v1, $v1, 8
    /* 4A41C 80059C1C FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4A420 80059C20 1480013C */  lui        $at, %hi(fastRandom)
    /* 4A424 80059C24 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4A428 80059C28 40110300 */  sll        $v0, $v1, 5
    /* 4A42C 80059C2C 23104300 */  subu       $v0, $v0, $v1
    /* 4A430 80059C30 80100200 */  sll        $v0, $v0, 2
    /* 4A434 80059C34 21104300 */  addu       $v0, $v0, $v1
    /* 4A438 80059C38 C0100200 */  sll        $v0, $v0, 3
    /* 4A43C 80059C3C 02240200 */  srl        $a0, $v0, 16
    /* 4A440 80059C40 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 4A444 80059C44 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 4A448 80059C48 01000224 */  addiu      $v0, $zero, 0x1
    /* 4A44C 80059C4C 0B006210 */  beq        $v1, $v0, .L80059C7C
    /* 4A450 80059C50 05008228 */   slti      $v0, $a0, 0x5
    /* 4A454 80059C54 09004010 */  beqz       $v0, .L80059C7C
    /* 4A458 80059C58 00000000 */   nop
    /* 4A45C 80059C5C 6405028E */  lw         $v0, 0x564($s0)
    /* 4A460 80059C60 00000000 */  nop
    /* 4A464 80059C64 05004010 */  beqz       $v0, .L80059C7C
    /* 4A468 80059C68 21200002 */   addu      $a0, $s0, $zero
    /* 4A46C 80059C6C 02000524 */  addiu      $a1, $zero, 0x2
    /* 4A470 80059C70 20000624 */  addiu      $a2, $zero, 0x20
    /* 4A474 80059C74 EAD1010C */  jal        AudioClc_HonkHorn__FP8Car_tObjiii
    /* 4A478 80059C78 08000724 */   addiu     $a3, $zero, 0x8
  .L80059C7C:
    /* 4A47C 80059C7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4A480 80059C80 1000B08F */  lw         $s0, 0x10($sp)
    /* 4A484 80059C84 0800E003 */  jr         $ra
    /* 4A488 80059C88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_HandleTrafficHonking__FP8Car_tObj
