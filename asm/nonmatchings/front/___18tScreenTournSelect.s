.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tScreenTournSelect, 0x28

glabel ___18tScreenTournSelect
    /* 2FFAC 8003F7AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FFB0 8003F7B0 0180023C */  lui        $v0, %hi(_vt_18tScreenTournSelect)
    /* 2FFB4 8003F7B4 B01D4224 */  addiu      $v0, $v0, %lo(_vt_18tScreenTournSelect)
    /* 2FFB8 8003F7B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2FFBC 8003F7BC 1E98000C */  jal        ___7tScreen
    /* 2FFC0 8003F7C0 600082AC */   sw        $v0, 0x60($a0)
    /* 2FFC4 8003F7C4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2FFC8 8003F7C8 00000000 */  nop
    /* 2FFCC 8003F7CC 0800E003 */  jr         $ra
    /* 2FFD0 8003F7D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tScreenTournSelect
