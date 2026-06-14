.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_ResetClosest__FiP8Car_tObji, 0xC8

glabel AudioClc_ResetClosest__FiP8Car_tObji
    /* 6643C 80075C3C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 66440 80075C40 1000B0AF */  sw         $s0, 0x10($sp)
    /* 66444 80075C44 21808000 */  addu       $s0, $a0, $zero
    /* 66448 80075C48 1180023C */  lui        $v0, %hi(AudioClc_gClosest)
    /* 6644C 80075C4C 48E34224 */  addiu      $v0, $v0, %lo(AudioClc_gClosest)
    /* 66450 80075C50 C0181000 */  sll        $v1, $s0, 3
    /* 66454 80075C54 23187000 */  subu       $v1, $v1, $s0
    /* 66458 80075C58 C0180300 */  sll        $v1, $v1, 3
    /* 6645C 80075C5C 21186200 */  addu       $v1, $v1, $v0
    /* 66460 80075C60 1800BFAF */  sw         $ra, 0x18($sp)
    /* 66464 80075C64 1400B1AF */  sw         $s1, 0x14($sp)
    /* 66468 80075C68 0000628C */  lw         $v0, 0x0($v1)
    /* 6646C 80075C6C 00000000 */  nop
    /* 66470 80075C70 17004010 */  beqz       $v0, .L80075CD0
    /* 66474 80075C74 2188A000 */   addu      $s1, $a1, $zero
    /* 66478 80075C78 08002016 */  bnez       $s1, .L80075C9C
    /* 6647C 80075C7C 1180023C */   lui       $v0, %hi(bSirenOn)
    /* 66480 80075C80 34E0010C */  jal        freeVoiceChannel__Fi
    /* 66484 80075C84 06000426 */   addiu     $a0, $s0, 0x6
    /* 66488 80075C88 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6648C 80075C8C 0A000426 */   addiu     $a0, $s0, 0xA
    /* 66490 80075C90 34E0010C */  jal        freeVoiceChannel__Fi
    /* 66494 80075C94 0E000426 */   addiu     $a0, $s0, 0xE
    /* 66498 80075C98 1180023C */  lui        $v0, %hi(bSirenOn)
  .L80075C9C:
    /* 6649C 80075C9C 90E74224 */  addiu      $v0, $v0, %lo(bSirenOn)
    /* 664A0 80075CA0 80181000 */  sll        $v1, $s0, 2
    /* 664A4 80075CA4 21186200 */  addu       $v1, $v1, $v0
    /* 664A8 80075CA8 0000628C */  lw         $v0, 0x0($v1)
    /* 664AC 80075CAC 00000000 */  nop
    /* 664B0 80075CB0 03004010 */  beqz       $v0, .L80075CC0
    /* 664B4 80075CB4 00000000 */   nop
    /* 664B8 80075CB8 28E6010C */  jal        SirenOff__Fi
    /* 664BC 80075CBC 21200002 */   addu      $a0, $s0, $zero
  .L80075CC0:
    /* 664C0 80075CC0 34E0010C */  jal        freeVoiceChannel__Fi
    /* 664C4 80075CC4 20000426 */   addiu     $a0, $s0, 0x20
    /* 664C8 80075CC8 34E0010C */  jal        freeVoiceChannel__Fi
    /* 664CC 80075CCC 25000426 */   addiu     $a0, $s0, 0x25
  .L80075CD0:
    /* 664D0 80075CD0 C0101000 */  sll        $v0, $s0, 3
    /* 664D4 80075CD4 23105000 */  subu       $v0, $v0, $s0
    /* 664D8 80075CD8 C0100200 */  sll        $v0, $v0, 3
    /* 664DC 80075CDC 1180043C */  lui        $a0, %hi(AudioClc_gClosest)
    /* 664E0 80075CE0 48E38424 */  addiu      $a0, $a0, %lo(AudioClc_gClosest)
    /* 664E4 80075CE4 21204400 */  addu       $a0, $v0, $a0
    /* 664E8 80075CE8 02D2010C */  jal        AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
    /* 664EC 80075CEC 21282002 */   addu      $a1, $s1, $zero
    /* 664F0 80075CF0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 664F4 80075CF4 1400B18F */  lw         $s1, 0x14($sp)
    /* 664F8 80075CF8 1000B08F */  lw         $s0, 0x10($sp)
    /* 664FC 80075CFC 0800E003 */  jr         $ra
    /* 66500 80075D00 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioClc_ResetClosest__FiP8Car_tObji
