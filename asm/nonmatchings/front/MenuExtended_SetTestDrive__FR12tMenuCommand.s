.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetTestDrive__FR12tMenuCommand, 0x1C

glabel MenuExtended_SetTestDrive__FR12tMenuCommand
    /* 1C97C 8002C17C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C980 8002C180 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1C984 8002C184 2A0140A0 */  sb         $zero, 0x12A($v0)
    /* 1C988 8002C188 1E0340A0 */  sb         $zero, 0x31E($v0)
    /* 1C98C 8002C18C 460040A0 */  sb         $zero, 0x46($v0)
    /* 1C990 8002C190 0800E003 */  jr         $ra
    /* 1C994 8002C194 040040A0 */   sb        $zero, 0x4($v0)
endlabel MenuExtended_SetTestDrive__FR12tMenuCommand
