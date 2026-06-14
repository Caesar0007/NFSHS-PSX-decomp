.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTPage, 0x3C

glabel GetTPage
    /* E23FC 800F1BFC 03008230 */  andi       $v0, $a0, 0x3
    /* E2400 800F1C00 C0110200 */  sll        $v0, $v0, 7
    /* E2404 800F1C04 0300A530 */  andi       $a1, $a1, 0x3
    /* E2408 800F1C08 40290500 */  sll        $a1, $a1, 5
    /* E240C 800F1C0C 25104500 */  or         $v0, $v0, $a1
    /* E2410 800F1C10 0001E330 */  andi       $v1, $a3, 0x100
    /* E2414 800F1C14 03190300 */  sra        $v1, $v1, 4
    /* E2418 800F1C18 25104300 */  or         $v0, $v0, $v1
    /* E241C 800F1C1C FF03C630 */  andi       $a2, $a2, 0x3FF
    /* E2420 800F1C20 83310600 */  sra        $a2, $a2, 6
    /* E2424 800F1C24 25104600 */  or         $v0, $v0, $a2
    /* E2428 800F1C28 0002E730 */  andi       $a3, $a3, 0x200
    /* E242C 800F1C2C 80380700 */  sll        $a3, $a3, 2
    /* E2430 800F1C30 0800E003 */  jr         $ra
    /* E2434 800F1C34 25104700 */   or        $v0, $v0, $a3
endlabel GetTPage
    /* E2438 800F1C38 00000000 */  nop
