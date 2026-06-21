.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_AsyncPlaySpeech__Fii, 0x7C

glabel FeAudio_AsyncPlaySpeech__Fii
    /* 64B8 80015CB8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64BC 80015CBC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 64C0 80015CC0 21308000 */  addu       $a2, $a0, $zero
    /* 64C4 80015CC4 02000224 */  addiu      $v0, $zero, 0x2
    /* 64C8 80015CC8 0600C214 */  bne        $a2, $v0, .L80015CE4
    /* 64CC 80015CCC 2138A000 */   addu      $a3, $a1, $zero
    /* 64D0 80015CD0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 64D4 80015CD4 0180053C */  lui        $a1, %hi(D_80010110)
    /* 64D8 80015CD8 1001A524 */  addiu      $a1, $a1, %lo(D_80010110)
    /* 64DC 80015CDC 44570008 */  j          .L80015D10
    /* 64E0 80015CE0 63000624 */   addiu     $a2, $zero, 0x63
  .L80015CE4:
    /* 64E4 80015CE4 0600C014 */  bnez       $a2, .L80015D00
    /* 64E8 80015CE8 0180053C */   lui       $a1, %hi(D_80010118)
    /* 64EC 80015CEC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 64F0 80015CF0 1801A524 */  addiu      $a1, $a1, %lo(D_80010118)
    /* 64F4 80015CF4 61000624 */  addiu      $a2, $zero, 0x61
    /* 64F8 80015CF8 44570008 */  j          .L80015D10
    /* 64FC 80015CFC 2138E600 */   addu      $a3, $a3, $a2
  .L80015D00:
    /* 6500 80015D00 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6504 80015D04 1801A524 */  addiu      $a1, $a1, %lo(D_80010118)
    /* 6508 80015D08 6100C624 */  addiu      $a2, $a2, 0x61
    /* 650C 80015D0C 3000E724 */  addiu      $a3, $a3, 0x30
  .L80015D10:
    /* 6510 80015D10 2F91030C */  jal        sprintf
    /* 6514 80015D14 00000000 */   nop
    /* 6518 80015D18 F356000C */  jal        FeAudio_AsyncPlayCommentary__FPc
    /* 651C 80015D1C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 6520 80015D20 00140200 */  sll        $v0, $v0, 16
    /* 6524 80015D24 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6528 80015D28 03140200 */  sra        $v0, $v0, 16
    /* 652C 80015D2C 0800E003 */  jr         $ra
    /* 6530 80015D30 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FeAudio_AsyncPlaySpeech__Fii
