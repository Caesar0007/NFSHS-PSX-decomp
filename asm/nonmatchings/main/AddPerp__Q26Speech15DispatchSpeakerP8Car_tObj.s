.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj, 0x30

glabel AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 87980 80097180 21180000 */  addu       $v1, $zero, $zero
  .L80097184:
    /* 87984 80097184 5C00828C */  lw         $v0, 0x5C($a0)
    /* 87988 80097188 00000000 */  nop
    /* 8798C 8009718C 02004014 */  bnez       $v0, .L80097198
    /* 87990 80097190 00000000 */   nop
    /* 87994 80097194 5C0085AC */  sw         $a1, 0x5C($a0)
  .L80097198:
    /* 87998 80097198 01006324 */  addiu      $v1, $v1, 0x1
    /* 8799C 8009719C 02006228 */  slti       $v0, $v1, 0x2
    /* 879A0 800971A0 F8FF4014 */  bnez       $v0, .L80097184
    /* 879A4 800971A4 04008424 */   addiu     $a0, $a0, 0x4
    /* 879A8 800971A8 0800E003 */  jr         $ra
    /* 879AC 800971AC 00000000 */   nop
endlabel AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj
