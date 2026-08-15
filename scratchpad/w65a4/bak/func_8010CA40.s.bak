.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010CA40, 0x24

glabel func_8010CA40
    /* FD240 8010CA40 01A0023C */  lui        $v0, %hi(D_A000DFAC)
    /* FD244 8010CA44 ACDF4224 */  addiu      $v0, $v0, %lo(D_A000DFAC)
    /* FD248 8010CA48 08004000 */  jr         $v0
    /* FD24C 8010CA4C 00000000 */   nop
    /* FD250 8010CA50 00000000 */  nop
    /* FD254 8010CA54 01A0083C */  lui        $t0, %hi(D_A000DF80)
    /* FD258 8010CA58 80DF0825 */  addiu      $t0, $t0, %lo(D_A000DF80)
    /* FD25C 8010CA5C 09F80001 */  jalr       $t0
    /* FD260 8010CA60 00000000 */   nop
endlabel func_8010CA40
    /* FD264 8010CA64 00000000 */  nop
