.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___16AIHigh_BasicPerp, 0x28

glabel ___16AIHigh_BasicPerp
    /* 4C93C 8005C13C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4C940 8005C140 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 4C944 8005C144 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 4C948 8005C148 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4C94C 8005C14C F16C010C */  jal        ___11AIHigh_Base
    /* 4C950 8005C150 140082AC */   sw        $v0, 0x14($a0)
    /* 4C954 8005C154 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4C958 8005C158 00000000 */  nop
    /* 4C95C 8005C15C 0800E003 */  jr         $ra
    /* 4C960 8005C160 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___16AIHigh_BasicPerp
