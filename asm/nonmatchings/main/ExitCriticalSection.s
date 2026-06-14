.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching ExitCriticalSection, 0x10

glabel ExitCriticalSection
    /* F716C 8010696C 02000424 */  addiu      $a0, $zero, 0x2
    /* F7170 80106970 0C000000 */  syscall    0 /* handwritten instruction */
    /* F7174 80106974 0800E003 */  jr         $ra
    /* F7178 80106978 00000000 */   nop
endlabel ExitCriticalSection
