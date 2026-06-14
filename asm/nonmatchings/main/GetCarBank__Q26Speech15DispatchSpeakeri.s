.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCarBank__Q26Speech15DispatchSpeakeri, 0x1C

glabel GetCarBank__Q26Speech15DispatchSpeakeri
    /* 89B28 80099328 40180500 */  sll        $v1, $a1, 1
    /* 89B2C 8009932C 21186500 */  addu       $v1, $v1, $a1
    /* 89B30 80099330 80180300 */  sll        $v1, $v1, 2
    /* 89B34 80099334 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89B38 80099338 6C006324 */  addiu      $v1, $v1, 0x6C
    /* 89B3C 8009933C 0800E003 */  jr         $ra
    /* 89B40 80099340 21104300 */   addu      $v0, $v0, $v1
endlabel GetCarBank__Q26Speech15DispatchSpeakeri
