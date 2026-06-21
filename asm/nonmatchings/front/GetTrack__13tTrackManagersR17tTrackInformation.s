.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrack__13tTrackManagersR17tTrackInformation, 0x70

glabel GetTrack__13tTrackManagersR17tTrackInformation
    /* 122A4 80021AA4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 122A8 80021AA8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 122AC 80021AAC 21808000 */  addu       $s0, $a0, $zero
    /* 122B0 80021AB0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 122B4 80021AB4 2188C000 */  addu       $s1, $a2, $zero
    /* 122B8 80021AB8 002C0500 */  sll        $a1, $a1, 16
    /* 122BC 80021ABC 032C0500 */  sra        $a1, $a1, 16
    /* 122C0 80021AC0 40200500 */  sll        $a0, $a1, 1
    /* 122C4 80021AC4 21208500 */  addu       $a0, $a0, $a1
    /* 122C8 80021AC8 00210400 */  sll        $a0, $a0, 4
    /* 122CC 80021ACC 21282002 */  addu       $a1, $s1, $zero
    /* 122D0 80021AD0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 122D4 80021AD4 0400028E */  lw         $v0, 0x4($s0)
    /* 122D8 80021AD8 30000624 */  addiu      $a2, $zero, 0x30
    /* 122DC 80021ADC B798030C */  jal        blockmove
    /* 122E0 80021AE0 21204400 */   addu      $a0, $v0, $a0
    /* 122E4 80021AE4 00002282 */  lb         $v0, 0x0($s1)
    /* 122E8 80021AE8 00000000 */  nop
    /* 122EC 80021AEC 80100200 */  sll        $v0, $v0, 2
    /* 122F0 80021AF0 21800202 */  addu       $s0, $s0, $v0
    /* 122F4 80021AF4 08000292 */  lbu        $v0, 0x8($s0)
    /* 122F8 80021AF8 00000000 */  nop
    /* 122FC 80021AFC 030022A2 */  sb         $v0, 0x3($s1)
    /* 12300 80021B00 1800BF8F */  lw         $ra, 0x18($sp)
    /* 12304 80021B04 1400B18F */  lw         $s1, 0x14($sp)
    /* 12308 80021B08 1000B08F */  lw         $s0, 0x10($sp)
    /* 1230C 80021B0C 0800E003 */  jr         $ra
    /* 12310 80021B10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetTrack__13tTrackManagersR17tTrackInformation
