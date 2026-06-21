.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching mdecdone, 0x1C

glabel mdecdone
    /* 41404 80050C04 0580023C */  lui        $v0, %hi(gMDECinfo)
    /* 41408 80050C08 282B4224 */  addiu      $v0, $v0, %lo(gMDECinfo)
    /* 4140C 80050C0C 0400428C */  lw         $v0, 0x4($v0)
    /* 41410 80050C10 00000000 */  nop
    /* 41414 80050C14 26104400 */  xor        $v0, $v0, $a0
    /* 41418 80050C18 0800E003 */  jr         $ra
    /* 4141C 80050C1C 2B100200 */   sltu      $v0, $zero, $v0
endlabel mdecdone
