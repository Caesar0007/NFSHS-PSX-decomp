.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_AsyncPlayCommentary__FPc, 0xEC

glabel FeAudio_AsyncPlayCommentary__FPc
    /* 63CC 80015BCC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 63D0 80015BD0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63D4 80015BD4 21888000 */  addu       $s1, $a0, $zero
    /* 63D8 80015BD8 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 63DC 80015BDC 5CC6438C */  lw         $v1, %lo(gMasterFENarrationLevel)($v0)
    /* 63E0 80015BE0 0580043C */  lui        $a0, %hi(commentaryActualLevel)
    /* 63E4 80015BE4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 63E8 80015BE8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63EC 80015BEC C0100300 */  sll        $v0, $v1, 3
    /* 63F0 80015BF0 23104300 */  subu       $v0, $v0, $v1
    /* 63F4 80015BF4 C0100200 */  sll        $v0, $v0, 3
    /* 63F8 80015BF8 23104300 */  subu       $v0, $v0, $v1
    /* 63FC 80015BFC 40100200 */  sll        $v0, $v0, 1
    /* 6400 80015C00 C3110200 */  sra        $v0, $v0, 7
    /* 6404 80015C04 381582AC */  sw         $v0, %lo(commentaryActualLevel)($a0)
    /* 6408 80015C08 5B004228 */  slti       $v0, $v0, 0x5B
    /* 640C 80015C0C 03004014 */  bnez       $v0, .L80015C1C
    /* 6410 80015C10 0580103C */   lui       $s0, %hi(ginfo)
    /* 6414 80015C14 5A000224 */  addiu      $v0, $zero, 0x5A
    /* 6418 80015C18 381582AC */  sw         $v0, %lo(commentaryActualLevel)($a0)
  .L80015C1C:
    /* 641C 80015C1C E8141026 */  addiu      $s0, $s0, %lo(ginfo)
    /* 6420 80015C20 21200002 */  addu       $a0, $s0, $zero
    /* 6424 80015C24 21282002 */  addu       $a1, $s1, $zero
    /* 6428 80015C28 41D8030C */  jal        strncpy
    /* 642C 80015C2C 04000624 */   addiu     $a2, $zero, 0x4
    /* 6430 80015C30 21200002 */  addu       $a0, $s0, $zero
    /* 6434 80015C34 0580033C */  lui        $v1, %hi(gCurrentVIV)
    /* 6438 80015C38 080000AE */  sw         $zero, 0x8($s0)
    /* 643C 80015C3C 0C0000AE */  sw         $zero, 0xC($s0)
    /* 6440 80015C40 00002592 */  lbu        $a1, 0x0($s1)
    /* 6444 80015C44 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6448 80015C48 100080A0 */  sb         $zero, 0x10($a0)
    /* 644C 80015C4C 110080A0 */  sb         $zero, 0x11($a0)
    /* 6450 80015C50 120080A0 */  sb         $zero, 0x12($a0)
    /* 6454 80015C54 140080AC */  sw         $zero, 0x14($a0)
    /* 6458 80015C58 180080AC */  sw         $zero, 0x18($a0)
    /* 645C 80015C5C 1C0080AC */  sw         $zero, 0x1C($a0)
    /* 6460 80015C60 200080AC */  sw         $zero, 0x20($a0)
    /* 6464 80015C64 CC1462A0 */  sb         $v0, %lo(gCurrentVIV)($v1)
    /* 6468 80015C68 6300A538 */  xori       $a1, $a1, 0x63
    /* 646C 80015C6C 2B280500 */  sltu       $a1, $zero, $a1
    /* 6470 80015C70 E055000C */  jal        FEAudio_StartLoadPatch__FP10SPEECHINFO
    /* 6474 80015C74 040085AC */   sw        $a1, 0x4($a0)
    /* 6478 80015C78 09004010 */  beqz       $v0, .L80015CA0
    /* 647C 80015C7C 1480023C */   lui       $v0, %hi(gMasterMusicLevel)
    /* 6480 80015C80 50C6428C */  lw         $v0, %lo(gMasterMusicLevel)($v0)
    /* 6484 80015C84 00000000 */  nop
    /* 6488 80015C88 C0200200 */  sll        $a0, $v0, 3
    /* 648C 80015C8C 21208200 */  addu       $a0, $a0, $v0
    /* 6490 80015C90 80200400 */  sll        $a0, $a0, 2
    /* 6494 80015C94 23208200 */  subu       $a0, $a0, $v0
    /* 6498 80015C98 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 649C 80015C9C C3210400 */   sra       $a0, $a0, 7
  .L80015CA0:
    /* 64A0 80015CA0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 64A4 80015CA4 1400B18F */  lw         $s1, 0x14($sp)
    /* 64A8 80015CA8 1000B08F */  lw         $s0, 0x10($sp)
    /* 64AC 80015CAC 01000224 */  addiu      $v0, $zero, 0x1
    /* 64B0 80015CB0 0800E003 */  jr         $ra
    /* 64B4 80015CB4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FeAudio_AsyncPlayCommentary__FPc
