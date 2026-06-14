.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj, 0x30

glabel ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 87920 80097120 21180000 */  addu       $v1, $zero, $zero
  .L80097124:
    /* 87924 80097124 5C00828C */  lw         $v0, 0x5C($a0)
    /* 87928 80097128 00000000 */  nop
    /* 8792C 8009712C 02004514 */  bne        $v0, $a1, .L80097138
    /* 87930 80097130 00000000 */   nop
    /* 87934 80097134 5C0080AC */  sw         $zero, 0x5C($a0)
  .L80097138:
    /* 87938 80097138 01006324 */  addiu      $v1, $v1, 0x1
    /* 8793C 8009713C 02006228 */  slti       $v0, $v1, 0x2
    /* 87940 80097140 F8FF4014 */  bnez       $v0, .L80097124
    /* 87944 80097144 04008424 */   addiu     $a0, $a0, 0x4
    /* 87948 80097148 0800E003 */  jr         $ra
    /* 8794C 8009714C 00000000 */   nop
endlabel ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj
