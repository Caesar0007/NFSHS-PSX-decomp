.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapename, 0x3C

glabel shapename
    /* E12E0 800F0AE0 0800888C */  lw         $t0, 0x8($a0)
    /* E12E4 800F0AE4 C0500500 */  sll        $t2, $a1, 3
    /* E12E8 800F0AE8 2B08A800 */  sltu       $at, $a1, $t0
    /* E12EC 800F0AEC 06002010 */  beqz       $at, .L800F0B08
    /* E12F0 800F0AF0 21508A00 */   addu      $t2, $a0, $t2
    /* E12F4 800F0AF4 1000428D */  lw         $v0, 0x10($t2)
    /* E12F8 800F0AF8 00000000 */  nop
    /* E12FC 800F0AFC 0000C2B8 */  swr        $v0, 0x0($a2)
    /* E1300 800F0B00 0300C2A8 */  swl        $v0, 0x3($a2)
    /* E1304 800F0B04 0800E003 */  jr         $ra
  .L800F0B08:
    /* E1308 800F0B08 00000224 */   addiu     $v0, $zero, 0x0
    /* E130C 800F0B0C 0000C2B8 */  swr        $v0, 0x0($a2)
    /* E1310 800F0B10 0300C2A8 */  swl        $v0, 0x3($a2)
    /* E1314 800F0B14 0800E003 */  jr         $ra
    /* E1318 800F0B18 00000000 */   nop
endlabel shapename
