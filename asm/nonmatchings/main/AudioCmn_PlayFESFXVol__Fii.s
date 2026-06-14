.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayFESFXVol__Fii, 0x88

glabel AudioCmn_PlayFESFXVol__Fii
    /* 69E24 80079624 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 69E28 80079628 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 69E2C 8007962C 21888000 */  addu       $s1, $a0, $zero
    /* 69E30 80079630 2800B0AF */  sw         $s0, 0x28($sp)
    /* 69E34 80079634 2180A000 */  addu       $s0, $a1, $zero
    /* 69E38 80079638 3000BFAF */  sw         $ra, 0x30($sp)
    /* 69E3C 8007963C 0D9A030C */  jal        SNDplaysetdef
    /* 69E40 80079640 1000A427 */   addiu     $a0, $sp, 0x10
    /* 69E44 80079644 00111000 */  sll        $v0, $s0, 4
    /* 69E48 80079648 23105000 */  subu       $v0, $v0, $s0
    /* 69E4C 8007964C 0801838F */  lw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 69E50 80079650 C0100200 */  sll        $v0, $v0, 3
    /* 69E54 80079654 18006200 */  mult       $v1, $v0
    /* 69E58 80079658 1000A427 */  addiu      $a0, $sp, 0x10
    /* 69E5C 8007965C 1000B1AF */  sw         $s1, 0x10($sp)
    /* 69E60 80079660 1B00A0A3 */  sb         $zero, 0x1B($sp)
    /* 69E64 80079664 1180023C */  lui        $v0, %hi(gSndBnk)
    /* 69E68 80079668 A8E84390 */  lbu        $v1, %lo(gSndBnk)($v0)
    /* 69E6C 8007966C 40000224 */  addiu      $v0, $zero, 0x40
    /* 69E70 80079670 1900A2A3 */  sb         $v0, 0x19($sp)
    /* 69E74 80079674 1700A2A3 */  sb         $v0, 0x17($sp)
    /* 69E78 80079678 1400A3A3 */  sb         $v1, 0x14($sp)
    /* 69E7C 8007967C 12300000 */  mflo       $a2
    /* 69E80 80079680 83130600 */  sra        $v0, $a2, 14
    /* 69E84 80079684 8C9E030C */  jal        SNDplay
    /* 69E88 80079688 1800A2A3 */   sb        $v0, 0x18($sp)
    /* 69E8C 8007968C 2401828F */  lw         $v0, %gp_rel(NumSFXOn)($gp)
    /* 69E90 80079690 3000BF8F */  lw         $ra, 0x30($sp)
    /* 69E94 80079694 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 69E98 80079698 2800B08F */  lw         $s0, 0x28($sp)
    /* 69E9C 8007969C 01004224 */  addiu      $v0, $v0, 0x1
    /* 69EA0 800796A0 240182AF */  sw         $v0, %gp_rel(NumSFXOn)($gp)
    /* 69EA4 800796A4 0800E003 */  jr         $ra
    /* 69EA8 800796A8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AudioCmn_PlayFESFXVol__Fii
