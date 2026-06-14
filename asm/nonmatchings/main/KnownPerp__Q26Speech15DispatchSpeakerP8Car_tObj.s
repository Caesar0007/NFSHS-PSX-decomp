.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj, 0x30

glabel KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 87950 80097150 21180000 */  addu       $v1, $zero, $zero
  .L80097154:
    /* 87954 80097154 5C00828C */  lw         $v0, 0x5C($a0)
    /* 87958 80097158 00000000 */  nop
    /* 8795C 8009715C 03004514 */  bne        $v0, $a1, .L8009716C
    /* 87960 80097160 01006324 */   addiu     $v1, $v1, 0x1
    /* 87964 80097164 0800E003 */  jr         $ra
    /* 87968 80097168 01000224 */   addiu     $v0, $zero, 0x1
  .L8009716C:
    /* 8796C 8009716C 02006228 */  slti       $v0, $v1, 0x2
    /* 87970 80097170 F8FF4014 */  bnez       $v0, .L80097154
    /* 87974 80097174 04008424 */   addiu     $a0, $a0, 0x4
    /* 87978 80097178 0800E003 */  jr         $ra
    /* 8797C 8009717C 21100000 */   addu      $v0, $zero, $zero
endlabel KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj
