.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_UnPause__Fv, 0x8C

glabel AudioCmn_UnPause__Fv
    /* 6A418 80079C18 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A41C 80079C1C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A420 80079C20 FC9F030C */  jal        SNDmastervol
    /* 6A424 80079C24 7F000424 */   addiu     $a0, $zero, 0x7F
    /* 6A428 80079C28 0401838F */  lw         $v1, %gp_rel(gMasterMusicLevel)($gp)
    /* 6A42C 80079C2C 00000000 */  nop
    /* 6A430 80079C30 56006228 */  slti       $v0, $v1, 0x56
    /* 6A434 80079C34 09004014 */  bnez       $v0, .L80079C5C
    /* 6A438 80079C38 C0100300 */   sll       $v0, $v1, 3
    /* 6A43C 80079C3C ABFF6224 */  addiu      $v0, $v1, -0x55
    /* 6A440 80079C40 C0180200 */  sll        $v1, $v0, 3
    /* 6A444 80079C44 23186200 */  subu       $v1, $v1, $v0
    /* 6A448 80079C48 C2170300 */  srl        $v0, $v1, 31
    /* 6A44C 80079C4C 21186200 */  addu       $v1, $v1, $v0
    /* 6A450 80079C50 43180300 */  sra        $v1, $v1, 1
    /* 6A454 80079C54 55006324 */  addiu      $v1, $v1, 0x55
    /* 6A458 80079C58 C0100300 */  sll        $v0, $v1, 3
  .L80079C5C:
    /* 6A45C 80079C5C 21104300 */  addu       $v0, $v0, $v1
    /* 6A460 80079C60 80100200 */  sll        $v0, $v0, 2
    /* 6A464 80079C64 23104300 */  subu       $v0, $v0, $v1
    /* 6A468 80079C68 40100200 */  sll        $v0, $v0, 1
    /* 6A46C 80079C6C ACEC010C */  jal        AudioMus_Volume__Fi
    /* 6A470 80079C70 C3210200 */   sra       $a0, $v0, 7
    /* 6A474 80079C74 4BF1010C */  jal        AudioEng_Resume__Fv
    /* 6A478 80079C78 00000000 */   nop
    /* 6A47C 80079C7C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 6A480 80079C80 0801838F */  lw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 6A484 80079C84 0401848F */  lw         $a0, %gp_rel(gMasterMusicLevel)($gp)
    /* 6A488 80079C88 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 6A48C 80079C8C F40043AC */  sw         $v1, 0xF4($v0)
    /* 6A490 80079C90 F00044AC */  sw         $a0, 0xF0($v0)
    /* 6A494 80079C94 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A498 80079C98 00000000 */  nop
    /* 6A49C 80079C9C 0800E003 */  jr         $ra
    /* 6A4A0 80079CA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_UnPause__Fv
