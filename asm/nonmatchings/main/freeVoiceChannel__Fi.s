.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching freeVoiceChannel__Fi, 0x70

glabel freeVoiceChannel__Fi
    /* 688D0 800780D0 F800828F */  lw         $v0, %gp_rel(AudioCmn_kAudioOn)($gp)
    /* 688D4 800780D4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 688D8 800780D8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 688DC 800780DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 688E0 800780E0 12004010 */  beqz       $v0, .L8007812C
    /* 688E4 800780E4 1000B0AF */   sw        $s0, 0x10($sp)
    /* 688E8 800780E8 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 688EC 800780EC 0F009110 */  beq        $a0, $s1, .L8007812C
    /* 688F0 800780F0 1180023C */   lui       $v0, %hi(gaChannel)
    /* 688F4 800780F4 FCE84224 */  addiu      $v0, $v0, %lo(gaChannel)
    /* 688F8 800780F8 C0180400 */  sll        $v1, $a0, 3
    /* 688FC 800780FC 21806200 */  addu       $s0, $v1, $v0
    /* 68900 80078100 0000048E */  lw         $a0, 0x0($s0)
    /* 68904 80078104 00000000 */  nop
    /* 68908 80078108 08009110 */  beq        $a0, $s1, .L8007812C
    /* 6890C 8007810C 05000524 */   addiu     $a1, $zero, 0x5
    /* 68910 80078110 B4A0030C */  jal        SNDautovol
    /* 68914 80078114 21302002 */   addu      $a2, $s1, $zero
    /* 68918 80078118 2401828F */  lw         $v0, %gp_rel(NumSFXOn)($gp)
    /* 6891C 8007811C 000011AE */  sw         $s1, 0x0($s0)
    /* 68920 80078120 040011AE */  sw         $s1, 0x4($s0)
    /* 68924 80078124 21105100 */  addu       $v0, $v0, $s1
    /* 68928 80078128 240182AF */  sw         $v0, %gp_rel(NumSFXOn)($gp)
  .L8007812C:
    /* 6892C 8007812C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 68930 80078130 1400B18F */  lw         $s1, 0x14($sp)
    /* 68934 80078134 1000B08F */  lw         $s0, 0x10($sp)
    /* 68938 80078138 0800E003 */  jr         $ra
    /* 6893C 8007813C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel freeVoiceChannel__Fi
