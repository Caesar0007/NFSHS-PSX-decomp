.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdmservice, 0x80

glabel iSNDdmservice
    /* FB420 8010AC20 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FB424 8010AC24 1480023C */  lui        $v0, %hi(sndpd)
    /* FB428 8010AC28 18794524 */  addiu      $a1, $v0, %lo(sndpd)
    /* FB42C 8010AC2C 1000BFAF */  sw         $ra, 0x10($sp)
    /* FB430 8010AC30 0E00A290 */  lbu        $v0, 0xE($a1)
    /* FB434 8010AC34 00000000 */  nop
    /* FB438 8010AC38 05004014 */  bnez       $v0, .L8010AC50
    /* FB43C 8010AC3C 1480043C */   lui       $a0, %hi(sndgs)
    /* FB440 8010AC40 202A040C */  jal        iSNDdmtransfer
    /* FB444 8010AC44 00000000 */   nop
    /* FB448 8010AC48 242B0408 */  j          .L8010AC90
    /* FB44C 8010AC4C 00000000 */   nop
  .L8010AC50:
    /* FB450 8010AC50 0D00A390 */  lbu        $v1, 0xD($a1)
    /* FB454 8010AC54 60788424 */  addiu      $a0, $a0, %lo(sndgs)
    /* FB458 8010AC58 001E0300 */  sll        $v1, $v1, 24
    /* FB45C 8010AC5C 031E0300 */  sra        $v1, $v1, 24
    /* FB460 8010AC60 80100300 */  sll        $v0, $v1, 2
    /* FB464 8010AC64 21104300 */  addu       $v0, $v0, $v1
    /* FB468 8010AC68 80100200 */  sll        $v0, $v0, 2
    /* FB46C 8010AC6C 21104500 */  addu       $v0, $v0, $a1
    /* FB470 8010AC70 4400838C */  lw         $v1, 0x44($a0)
    /* FB474 8010AC74 2000428C */  lw         $v0, 0x20($v0)
    /* FB478 8010AC78 00000000 */  nop
    /* FB47C 8010AC7C 2B186200 */  sltu       $v1, $v1, $v0
    /* FB480 8010AC80 03006014 */  bnez       $v1, .L8010AC90
    /* FB484 8010AC84 00000000 */   nop
    /* FB488 8010AC88 992A040C */  jal        iSNDdmcallback
    /* FB48C 8010AC8C 00000000 */   nop
  .L8010AC90:
    /* FB490 8010AC90 1000BF8F */  lw         $ra, 0x10($sp)
    /* FB494 8010AC94 00000000 */  nop
    /* FB498 8010AC98 0800E003 */  jr         $ra
    /* FB49C 8010AC9C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDdmservice
