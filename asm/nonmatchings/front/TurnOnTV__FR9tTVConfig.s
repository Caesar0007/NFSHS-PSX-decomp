.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOnTV__FR9tTVConfig, 0x14

glabel TurnOnTV__FR9tTVConfig
    /* 13A28 80023228 02000224 */  addiu      $v0, $zero, 0x2
    /* 13A2C 8002322C 000082AC */  sw         $v0, 0x0($a0)
    /* 13A30 80023230 80000224 */  addiu      $v0, $zero, 0x80
    /* 13A34 80023234 0800E003 */  jr         $ra
    /* 13A38 80023238 060082A4 */   sh        $v0, 0x6($a0)
endlabel TurnOnTV__FR9tTVConfig
    /* 13A3C 8002323C 00000000 */  nop
