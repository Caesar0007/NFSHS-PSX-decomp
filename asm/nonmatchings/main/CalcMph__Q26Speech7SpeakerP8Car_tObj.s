.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcMph__Q26Speech7SpeakerP8Car_tObj, 0x48

glabel CalcMph__Q26Speech7SpeakerP8Car_tObj
    /* 880A4 800978A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 880A8 800978A8 0200043C */  lui        $a0, (0x23CA5 >> 16)
    /* 880AC 800978AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 880B0 800978B0 2004A58C */  lw         $a1, 0x420($a1)
    /* 880B4 800978B4 00000000 */  nop
    /* 880B8 800978B8 0200A104 */  bgez       $a1, .L800978C4
    /* 880BC 800978BC 00000000 */   nop
    /* 880C0 800978C0 23280500 */  negu       $a1, $a1
  .L800978C4:
    /* 880C4 800978C4 CA90030C */  jal        fixedmult
    /* 880C8 800978C8 A53C8434 */   ori       $a0, $a0, (0x23CA5 & 0xFFFF)
    /* 880CC 800978CC 21184000 */  addu       $v1, $v0, $zero
    /* 880D0 800978D0 02006104 */  bgez       $v1, .L800978DC
    /* 880D4 800978D4 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 880D8 800978D8 21186200 */  addu       $v1, $v1, $v0
  .L800978DC:
    /* 880DC 800978DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 880E0 800978E0 03140300 */  sra        $v0, $v1, 16
    /* 880E4 800978E4 0800E003 */  jr         $ra
    /* 880E8 800978E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcMph__Q26Speech7SpeakerP8Car_tObj
