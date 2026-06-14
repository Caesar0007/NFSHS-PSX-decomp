.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayThunder__Fii, 0x2C

glabel AudioCmn_PlayThunder__Fii
    /* 66CA4 800764A4 C801828F */  lw         $v0, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66CA8 800764A8 00000000 */  nop
    /* 66CAC 800764AC 2A104400 */  slt        $v0, $v0, $a0
    /* 66CB0 800764B0 05004010 */  beqz       $v0, .L800764C8
    /* 66CB4 800764B4 87000224 */   addiu     $v0, $zero, 0x87
    /* 66CB8 800764B8 23104400 */  subu       $v0, $v0, $a0
    /* 66CBC 800764BC C80184AF */  sw         $a0, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66CC0 800764C0 CC0185AF */  sw         $a1, %gp_rel(AudioCmn_ThunderAzi)($gp)
    /* 66CC4 800764C4 D00182AF */  sw         $v0, %gp_rel(AudioCmn_ThunderDel)($gp)
  .L800764C8:
    /* 66CC8 800764C8 0800E003 */  jr         $ra
    /* 66CCC 800764CC 00000000 */   nop
endlabel AudioCmn_PlayThunder__Fii
