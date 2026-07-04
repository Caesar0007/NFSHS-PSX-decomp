.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetMenuProjection__Fiiii, 0x40

glabel TrsProj_SetMenuProjection__Fiiii
    /* D21C8 800E19C8 00020324 */  addiu      $v1, $zero, 0x200
    /* D21CC 800E19CC 00D0C348 */  ctc2       $v1, $26 /* handwritten instruction */
    /* D21D0 800E19D0 C2170600 */  srl        $v0, $a2, 31
    /* D21D4 800E19D4 2130C200 */  addu       $a2, $a2, $v0
    /* D21D8 800E19D8 43300600 */  sra        $a2, $a2, 1
    /* D21DC 800E19DC 21208600 */  addu       $a0, $a0, $a2
    /* D21E0 800E19E0 C2170700 */  srl        $v0, $a3, 31
    /* D21E4 800E19E4 2138E200 */  addu       $a3, $a3, $v0
    /* D21E8 800E19E8 43380700 */  sra        $a3, $a3, 1
    /* D21EC 800E19EC 2128A700 */  addu       $a1, $a1, $a3
    /* D21F0 800E19F0 00640400 */  sll        $t4, $a0, 16
    /* D21F4 800E19F4 006C0500 */  sll        $t5, $a1, 16
    /* D21F8 800E19F8 00C0CC48 */  ctc2       $t4, $24 /* handwritten instruction */
    /* D21FC 800E19FC 00C8CD48 */  ctc2       $t5, $25 /* handwritten instruction */
    /* D2200 800E1A00 0800E003 */  jr         $ra
    /* D2204 800E1A04 00000000 */   nop
endlabel TrsProj_SetMenuProjection__Fiiii
