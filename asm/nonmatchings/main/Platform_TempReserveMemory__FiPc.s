.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_TempReserveMemory__FiPc, 0x44

glabel Platform_TempReserveMemory__FiPc
    /* CCB34 800DC334 03008424 */  addiu      $a0, $a0, 0x3
    /* CCB38 800DC338 02008104 */  bgez       $a0, .L800DC344
    /* CCB3C 800DC33C 21108000 */   addu      $v0, $a0, $zero
    /* CCB40 800DC340 03008224 */  addiu      $v0, $a0, 0x3
  .L800DC344:
    /* CCB44 800DC344 83100200 */  sra        $v0, $v0, 2
    /* CCB48 800DC348 80200200 */  sll        $a0, $v0, 2
    /* CCB4C 800DC34C 6C15868F */  lw         $a2, %gp_rel(gCurrentMemory)($gp)
    /* CCB50 800DC350 6415858F */  lw         $a1, %gp_rel(gLowMemory)($gp)
    /* CCB54 800DC354 7015838F */  lw         $v1, %gp_rel(gTotalMemory)($gp)
    /* CCB58 800DC358 2120C400 */  addu       $a0, $a2, $a0
    /* CCB5C 800DC35C 23208500 */  subu       $a0, $a0, $a1
    /* CCB60 800DC360 2A186400 */  slt        $v1, $v1, $a0
    /* CCB64 800DC364 02006014 */  bnez       $v1, .L800DC370
    /* CCB68 800DC368 21100000 */   addu      $v0, $zero, $zero
    /* CCB6C 800DC36C 2110C000 */  addu       $v0, $a2, $zero
  .L800DC370:
    /* CCB70 800DC370 0800E003 */  jr         $ra
    /* CCB74 800DC374 00000000 */   nop
endlabel Platform_TempReserveMemory__FiPc
