.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCarBank__Q26Speech13MobileSpeakeri, 0x18

glabel GetCarBank__Q26Speech13MobileSpeakeri
    /* 89AB4 800992B4 40180500 */  sll        $v1, $a1, 1
    /* 89AB8 800992B8 21186500 */  addu       $v1, $v1, $a1
    /* 89ABC 800992BC 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89AC0 800992C0 80180300 */  sll        $v1, $v1, 2
    /* 89AC4 800992C4 0800E003 */  jr         $ra
    /* 89AC8 800992C8 21104300 */   addu      $v0, $v0, $v1
endlabel GetCarBank__Q26Speech13MobileSpeakeri
