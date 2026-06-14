.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartRCnt, 0x30

glabel StartRCnt
    /* DA744 800E9F44 FFFF8230 */  andi       $v0, $a0, 0xFFFF
    /* DA748 800E9F48 80200200 */  sll        $a0, $v0, 2
    /* DA74C 800E9F4C 1280053C */  lui        $a1, %hi(D_801234B4)
    /* DA750 800E9F50 B434A58C */  lw         $a1, %lo(D_801234B4)($a1)
    /* DA754 800E9F54 1280013C */  lui        $at, %hi(D_801234BC)
    /* DA758 800E9F58 21082400 */  addu       $at, $at, $a0
    /* DA75C 800E9F5C BC34248C */  lw         $a0, %lo(D_801234BC)($at)
    /* DA760 800E9F60 0400A38C */  lw         $v1, 0x4($a1)
    /* DA764 800E9F64 03004228 */  slti       $v0, $v0, 0x3
    /* DA768 800E9F68 25186400 */  or         $v1, $v1, $a0
    /* DA76C 800E9F6C 0800E003 */  jr         $ra
    /* DA770 800E9F70 0400A3AC */   sw        $v1, 0x4($a1)
endlabel StartRCnt
