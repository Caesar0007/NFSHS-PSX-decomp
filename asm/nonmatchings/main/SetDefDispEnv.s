.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDefDispEnv, 0x3C

glabel SetDefDispEnv
    /* E2AE0 800F22E0 1000A38F */  lw         $v1, 0x10($sp)
    /* E2AE4 800F22E4 21108000 */  addu       $v0, $a0, $zero
    /* E2AE8 800F22E8 000045A4 */  sh         $a1, 0x0($v0)
    /* E2AEC 800F22EC 020046A4 */  sh         $a2, 0x2($v0)
    /* E2AF0 800F22F0 040047A4 */  sh         $a3, 0x4($v0)
    /* E2AF4 800F22F4 080040A4 */  sh         $zero, 0x8($v0)
    /* E2AF8 800F22F8 0A0040A4 */  sh         $zero, 0xA($v0)
    /* E2AFC 800F22FC 0C0040A4 */  sh         $zero, 0xC($v0)
    /* E2B00 800F2300 0E0040A4 */  sh         $zero, 0xE($v0)
    /* E2B04 800F2304 110040A0 */  sb         $zero, 0x11($v0)
    /* E2B08 800F2308 100040A0 */  sb         $zero, 0x10($v0)
    /* E2B0C 800F230C 130040A0 */  sb         $zero, 0x13($v0)
    /* E2B10 800F2310 120040A0 */  sb         $zero, 0x12($v0)
    /* E2B14 800F2314 0800E003 */  jr         $ra
    /* E2B18 800F2318 060043A4 */   sh        $v1, 0x6($v0)
endlabel SetDefDispEnv
