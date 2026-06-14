.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E80C4, 0x8

glabel func_800E80C4
    /* D88C4 800E80C4 50730125 */  addiu      $at, $t0, 0x7350
    /* D88C8 800E80C8 9B524300 */  .word      0x0043529B                    # divu       $t2, $v0, $v1 # 00000280 <InstrIdType: CPU_SPECIAL>
endlabel func_800E80C4
