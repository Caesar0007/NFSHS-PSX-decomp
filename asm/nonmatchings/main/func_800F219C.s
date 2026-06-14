.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F219C, 0x8

glabel func_800F219C
    /* E299C 800F219C 50730925 */  addiu      $t1, $t0, 0x7350
    /* E29A0 800F21A0 9B534300 */  .word      0x0043539B                    # divu       $t2, $v0, $v1 # 00000380 <InstrIdType: CPU_SPECIAL>
endlabel func_800F219C
