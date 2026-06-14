.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_InitReverb__Fv, 0x44

glabel AudioCmn_InitReverb__Fv
    /* 6A688 80079E88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6A68C 80079E8C 21200000 */  addu       $a0, $zero, $zero
    /* 6A690 80079E90 7F000524 */  addiu      $a1, $zero, 0x7F
    /* 6A694 80079E94 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6A698 80079E98 0A000624 */  addiu      $a2, $zero, 0xA
    /* 6A69C 80079E9C 21384000 */  addu       $a3, $v0, $zero
    /* 6A6A0 80079EA0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6A6A4 80079EA4 569B030C */  jal        SNDfxinitbus
    /* 6A6A8 80079EA8 1000A2AF */   sw        $v0, 0x10($sp)
    /* 6A6AC 80079EAC 21200000 */  addu       $a0, $zero, $zero
    /* 6A6B0 80079EB0 2D0180A3 */  sb         $zero, %gp_rel(fReverbLevel)($gp)
    /* 6A6B4 80079EB4 749B030C */  jal        SNDfxmasterlevel
    /* 6A6B8 80079EB8 21288000 */   addu      $a1, $a0, $zero
    /* 6A6BC 80079EBC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6A6C0 80079EC0 2C0180A3 */  sb         $zero, %gp_rel(fReverbOn)($gp)
    /* 6A6C4 80079EC4 0800E003 */  jr         $ra
    /* 6A6C8 80079EC8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_InitReverb__Fv
