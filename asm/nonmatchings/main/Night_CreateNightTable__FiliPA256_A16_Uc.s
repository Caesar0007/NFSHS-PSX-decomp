.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_CreateNightTable__FiliPA256_A16_Uc, 0x28

glabel Night_CreateNightTable__FiliPA256_A16_Uc
    /* CBDA4 800DB5A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CBDA8 800DB5A8 00110400 */  sll        $v0, $a0, 4
    /* CBDAC 800DB5AC 2138E200 */  addu       $a3, $a3, $v0
    /* CBDB0 800DB5B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* CBDB4 800DB5B4 F86C030C */  jal        Night_CreateNightTableElement__FiliPUc
    /* CBDB8 800DB5B8 2138E600 */   addu      $a3, $a3, $a2
    /* CBDBC 800DB5BC 1000BF8F */  lw         $ra, 0x10($sp)
    /* CBDC0 800DB5C0 00000000 */  nop
    /* CBDC4 800DB5C4 0800E003 */  jr         $ra
    /* CBDC8 800DB5C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_CreateNightTable__FiliPA256_A16_Uc
