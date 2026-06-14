.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching EnterCriticalSection, 0x10

glabel EnterCriticalSection
    /* F718C 8010698C 01000424 */  addiu      $a0, $zero, 0x1
    /* F7190 80106990 0C000000 */  syscall    0 /* handwritten instruction */
    /* F7194 80106994 0800E003 */  jr         $ra
    /* F7198 80106998 00000000 */   nop
endlabel EnterCriticalSection
