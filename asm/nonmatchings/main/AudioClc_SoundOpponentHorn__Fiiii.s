.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SoundOpponentHorn__Fiiii, 0xAC

glabel AudioClc_SoundOpponentHorn__Fiiii
    /* 6575C 80074F5C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 65760 80074F60 21408000 */  addu       $t0, $a0, $zero
    /* 65764 80074F64 2148A000 */  addu       $t1, $a1, $zero
    /* 65768 80074F68 C0100800 */  sll        $v0, $t0, 3
    /* 6576C 80074F6C 23104800 */  subu       $v0, $v0, $t0
    /* 65770 80074F70 C0100200 */  sll        $v0, $v0, 3
    /* 65774 80074F74 1180033C */  lui        $v1, %hi(AudioClc_gClosest)
    /* 65778 80074F78 48E36324 */  addiu      $v1, $v1, %lo(AudioClc_gClosest)
    /* 6577C 80074F7C 21104300 */  addu       $v0, $v0, $v1
    /* 65780 80074F80 1800BFAF */  sw         $ra, 0x18($sp)
    /* 65784 80074F84 0000428C */  lw         $v0, 0x0($v0)
    /* 65788 80074F88 2150C000 */  addu       $t2, $a2, $zero
    /* 6578C 80074F8C 8802428C */  lw         $v0, 0x288($v0)
    /* 65790 80074F90 00000000 */  nop
    /* 65794 80074F94 0000468C */  lw         $a2, 0x0($v0)
    /* 65798 80074F98 30000224 */  addiu      $v0, $zero, 0x30
    /* 6579C 80074F9C 0200C214 */  bne        $a2, $v0, .L80074FA8
    /* 657A0 80074FA0 0A000524 */   addiu     $a1, $zero, 0xA
    /* 657A4 80074FA4 0B000524 */  addiu      $a1, $zero, 0xB
  .L80074FA8:
    /* 657A8 80074FA8 FF6A043C */  lui        $a0, (0x6AFF5F81 >> 16)
    /* 657AC 80074FAC 815F8434 */  ori        $a0, $a0, (0x6AFF5F81 & 0xFFFF)
    /* 657B0 80074FB0 24130224 */  addiu      $v0, $zero, 0x1324
    /* 657B4 80074FB4 23104700 */  subu       $v0, $v0, $a3
    /* 657B8 80074FB8 C0190200 */  sll        $v1, $v0, 7
    /* 657BC 80074FBC 23186200 */  subu       $v1, $v1, $v0
    /* 657C0 80074FC0 18006400 */  mult       $v1, $a0
    /* 657C4 80074FC4 1180023C */  lui        $v0, %hi(D_8010E274)
    /* 657C8 80074FC8 74E24224 */  addiu      $v0, $v0, %lo(D_8010E274)
    /* 657CC 80074FCC 2110C200 */  addu       $v0, $a2, $v0
    /* 657D0 80074FD0 C31F0300 */  sra        $v1, $v1, 31
    /* 657D4 80074FD4 25000425 */  addiu      $a0, $t0, 0x25
    /* 657D8 80074FD8 00004690 */  lbu        $a2, 0x0($v0)
    /* 657DC 80074FDC 21384001 */  addu       $a3, $t2, $zero
    /* 657E0 80074FE0 1400A9AF */  sw         $t1, 0x14($sp)
    /* 657E4 80074FE4 10580000 */  mfhi       $t3
    /* 657E8 80074FE8 C3120B00 */  sra        $v0, $t3, 11
    /* 657EC 80074FEC 23104300 */  subu       $v0, $v0, $v1
    /* 657F0 80074FF0 F3E0010C */  jal        AudioCmn_PlaySFX__Fiiiiii
    /* 657F4 80074FF4 1000A2AF */   sw        $v0, 0x10($sp)
    /* 657F8 80074FF8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 657FC 80074FFC 00000000 */  nop
    /* 65800 80075000 0800E003 */  jr         $ra
    /* 65804 80075004 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioClc_SoundOpponentHorn__Fiiii
