.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOffTV__FR9tTVConfig, 0x10

glabel TurnOffTV__FR9tTVConfig
    /* 13A18 80023218 03000224 */  addiu      $v0, $zero, 0x3
    /* 13A1C 8002321C 000082AC */  sw         $v0, 0x0($a0)
    /* 13A20 80023220 0800E003 */  jr         $ra
    /* 13A24 80023224 060080A4 */   sh        $zero, 0x6($a0)
endlabel TurnOffTV__FR9tTVConfig
