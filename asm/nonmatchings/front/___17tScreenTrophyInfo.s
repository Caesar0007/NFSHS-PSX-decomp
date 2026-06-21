.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17tScreenTrophyInfo, 0x20

glabel ___17tScreenTrophyInfo
    /* 31DE0 800415E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 31DE4 800415E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 31DE8 800415E8 1E98000C */  jal        ___7tScreen
    /* 31DEC 800415EC 00000000 */   nop
    /* 31DF0 800415F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 31DF4 800415F4 00000000 */  nop
    /* 31DF8 800415F8 0800E003 */  jr         $ra
    /* 31DFC 800415FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17tScreenTrophyInfo
