.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching stup0, 0x1C

glabel stup0
    /* D48CC 800E40CC CC91020C */  jal        main
    /* D48D0 800E40D0 00000000 */   nop
    /* D48D4 800E40D4 4D000000 */  break      0, 1
  alabel D_800E40D8
    /* D48D8 800E40D8 00002000 */  .word      0x00200000                    # sll        $zero, $zero, 0 # 00200000 <InstrIdType: CPU_SPECIAL>
    /* D48DC 800E40DC 00002000 */  .word      0x00200000                    # sll        $zero, $zero, 0 # 00200000 <InstrIdType: CPU_SPECIAL>
    /* D48E0 800E40E0 00002000 */  .word      0x00200000                    # sll        $zero, $zero, 0 # 00200000 <InstrIdType: CPU_SPECIAL>
    /* D48E4 800E40E4 00002000 */  .word      0x00200000                    # sll        $zero, $zero, 0 # 00200000 <InstrIdType: CPU_SPECIAL>
endlabel stup0
