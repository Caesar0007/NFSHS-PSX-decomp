.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80063248, 0x28

glabel func_80063248
    /* 53A48 80063248 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 53A4C 8006324C 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 53A50 80063250 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 53A54 80063254 1000BFAF */  sw         $ra, 0x10($sp)
    /* 53A58 80063258 F16C010C */  jal        ___11AIHigh_Base
    /* 53A5C 8006325C 140082AC */   sw        $v0, 0x14($a0)
    /* 53A60 80063260 1000BF8F */  lw         $ra, 0x10($sp)
    /* 53A64 80063264 00000000 */  nop
    /* 53A68 80063268 0800E003 */  jr         $ra
    /* 53A6C 8006326C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80063248
