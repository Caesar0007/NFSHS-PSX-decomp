.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010694C, 0x8

glabel func_8010694C
    /* F714C 8010694C 50730025 */  addiu      $zero, $t0, 0x7350
    /* F7150 80106950 9B524300 */  .word      0x0043529B                    # divu       $t2, $v0, $v1 # 00000280 <InstrIdType: CPU_SPECIAL>
endlabel func_8010694C
