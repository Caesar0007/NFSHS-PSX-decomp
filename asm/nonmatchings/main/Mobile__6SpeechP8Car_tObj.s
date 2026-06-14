.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Mobile__6SpeechP8Car_tObj, 0x48

glabel Mobile__6SpeechP8Car_tObj
    /* 8805C 8009785C 21288000 */  addu       $a1, $a0, $zero
    /* 88060 80097860 3808848F */  lw         $a0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 88064 80097864 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 88068 80097868 05008010 */  beqz       $a0, .L80097880
    /* 8806C 8009786C 1000BFAF */   sw        $ra, 0x10($sp)
    /* 88070 80097870 6C03828C */  lw         $v0, 0x36C($a0)
    /* 88074 80097874 00000000 */  nop
    /* 88078 80097878 04004014 */  bnez       $v0, .L8009788C
    /* 8807C 8009787C 00000000 */   nop
  .L80097880:
    /* 88080 80097880 3C08828F */  lw         $v0, %gp_rel(_6Speech_fgUndefined)($gp)
    /* 88084 80097884 255E0208 */  j          .L80097894
    /* 88088 80097888 00000000 */   nop
  .L8009788C:
    /* 8808C 8009788C EE5D020C */  jal        FindMobile__6SpeechP8Car_tObj
    /* 88090 80097890 00000000 */   nop
  .L80097894:
    /* 88094 80097894 1000BF8F */  lw         $ra, 0x10($sp)
    /* 88098 80097898 00000000 */  nop
    /* 8809C 8009789C 0800E003 */  jr         $ra
    /* 880A0 800978A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Mobile__6SpeechP8Car_tObj
