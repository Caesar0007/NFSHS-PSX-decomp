.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_SetPlayerHeadLightColor__Fiii, 0x3C

glabel Night_SetPlayerHeadLightColor__Fiii
    /* CC138 800DB938 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC13C 800DB93C 80100400 */  sll        $v0, $a0, 2
    /* CC140 800DB940 1480033C */  lui        $v1, %hi(Night_gPlayerHeadLightColor)
    /* CC144 800DB944 80DA6324 */  addiu      $v1, $v1, %lo(Night_gPlayerHeadLightColor)
    /* CC148 800DB948 21104300 */  addu       $v0, $v0, $v1
    /* CC14C 800DB94C 2120A000 */  addu       $a0, $a1, $zero
    /* CC150 800DB950 1000BFAF */  sw         $ra, 0x10($sp)
    /* CC154 800DB954 0000458C */  lw         $a1, 0x0($v0)
    /* CC158 800DB958 9814878F */  lw         $a3, %gp_rel(Night_gPlayerLightingTable)($gp)
    /* CC15C 800DB95C 696D030C */  jal        Night_CreateNightTable__FiliPA256_A16_Uc
    /* CC160 800DB960 00000000 */   nop
    /* CC164 800DB964 1000BF8F */  lw         $ra, 0x10($sp)
    /* CC168 800DB968 00000000 */  nop
    /* CC16C 800DB96C 0800E003 */  jr         $ra
    /* CC170 800DB970 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_SetPlayerHeadLightColor__Fiii
