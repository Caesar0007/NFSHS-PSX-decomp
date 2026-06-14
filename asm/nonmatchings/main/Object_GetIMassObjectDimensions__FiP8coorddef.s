.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetIMassObjectDimensions__FiP8coorddef, 0x2C

glabel Object_GetIMassObjectDimensions__FiP8coorddef
    /* 96810 800A6010 8C0D828F */  lw         $v0, %gp_rel(Object_IMassObjInst)($gp)
    /* 96814 800A6014 40210400 */  sll        $a0, $a0, 5
    /* 96818 800A6018 21208200 */  addu       $a0, $a0, $v0
    /* 9681C 800A601C 0400838C */  lw         $v1, 0x4($a0)
    /* 96820 800A6020 0800868C */  lw         $a2, 0x8($a0)
    /* 96824 800A6024 0C00878C */  lw         $a3, 0xC($a0)
    /* 96828 800A6028 0000A3AC */  sw         $v1, 0x0($a1)
    /* 9682C 800A602C 0400A6AC */  sw         $a2, 0x4($a1)
    /* 96830 800A6030 0800A7AC */  sw         $a3, 0x8($a1)
    /* 96834 800A6034 0800E003 */  jr         $ra
    /* 96838 800A6038 00000000 */   nop
endlabel Object_GetIMassObjectDimensions__FiP8coorddef
