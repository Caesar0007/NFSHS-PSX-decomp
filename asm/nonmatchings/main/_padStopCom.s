.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padStopCom, 0x44

glabel _padStopCom
    /* F54E8 80104CE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F54EC 80104CEC 1000BFAF */  sw         $ra, 0x10($sp)
    /* F54F0 80104CF0 631A040C */  jal        EnterCriticalSection
    /* F54F4 80104CF4 00000000 */   nop
    /* F54F8 80104CF8 03000424 */  addiu      $a0, $zero, 0x3
    /* F54FC 80104CFC 9919040C */  jal        ChangeClearRCnt
    /* F5500 80104D00 01000524 */   addiu     $a1, $zero, 0x1
    /* F5504 80104D04 1580053C */  lui        $a1, %hi(D_8014857C)
    /* F5508 80104D08 7C85A524 */  addiu      $a1, $a1, %lo(D_8014857C)
    /* F550C 80104D0C F22F040C */  jal        SysDeqIntRP
    /* F5510 80104D10 02000424 */   addiu     $a0, $zero, 0x2
    /* F5514 80104D14 5B1A040C */  jal        ExitCriticalSection
    /* F5518 80104D18 00000000 */   nop
    /* F551C 80104D1C 1000BF8F */  lw         $ra, 0x10($sp)
    /* F5520 80104D20 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F5524 80104D24 0800E003 */  jr         $ra
    /* F5528 80104D28 00000000 */   nop
endlabel _padStopCom
