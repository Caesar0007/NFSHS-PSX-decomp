.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RestartCallback, 0x78

glabel RestartCallback
    /* E35F8 800F2DF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E35FC 800F2DFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3600 800F2E00 1380103C */  lui        $s0, %hi(D_80134AF8)
    /* E3604 800F2E04 F84A1026 */  addiu      $s0, $s0, %lo(D_80134AF8)
    /* E3608 800F2E08 1400BFAF */  sw         $ra, 0x14($sp)
    /* E360C 800F2E0C 00000296 */  lhu        $v0, 0x0($s0)
    /* E3610 800F2E10 00000000 */  nop
    /* E3614 800F2E14 11004014 */  bnez       $v0, .L800F2E5C
    /* E3618 800F2E18 00000000 */   nop
    /* E361C 800F2E1C A719040C */  jal        HookEntryInt
    /* E3620 800F2E20 38000426 */   addiu     $a0, $s0, 0x38
    /* E3624 800F2E24 1380043C */  lui        $a0, %hi(D_80135B88)
    /* E3628 800F2E28 885B848C */  lw         $a0, %lo(D_80135B88)($a0)
    /* E362C 800F2E2C 32000396 */  lhu        $v1, 0x32($s0)
    /* E3630 800F2E30 01000224 */  addiu      $v0, $zero, 0x1
    /* E3634 800F2E34 000002A6 */  sh         $v0, 0x0($s0)
    /* E3638 800F2E38 000083A4 */  sh         $v1, 0x0($a0)
    /* E363C 800F2E3C 1380033C */  lui        $v1, %hi(D_80135B8C)
    /* E3640 800F2E40 8C5B638C */  lw         $v1, %lo(D_80135B8C)($v1)
    /* E3644 800F2E44 3400028E */  lw         $v0, 0x34($s0)
    /* E3648 800F2E48 00000000 */  nop
    /* E364C 800F2E4C 5B1A040C */  jal        ExitCriticalSection
    /* E3650 800F2E50 000062AC */   sw        $v0, 0x0($v1)
    /* E3654 800F2E54 98CB0308 */  j          .L800F2E60
    /* E3658 800F2E58 21100002 */   addu      $v0, $s0, $zero
  .L800F2E5C:
    /* E365C 800F2E5C 21100000 */  addu       $v0, $zero, $zero
  .L800F2E60:
    /* E3660 800F2E60 1400BF8F */  lw         $ra, 0x14($sp)
    /* E3664 800F2E64 1000B08F */  lw         $s0, 0x10($sp)
    /* E3668 800F2E68 0800E003 */  jr         $ra
    /* E366C 800F2E6C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel RestartCallback
