.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformcalcdatarate, 0x30

glabel iSNDplatformcalcdatarate
    /* F49EC 801041EC 00008394 */  lhu        $v1, 0x0($a0)
    /* F49F0 801041F0 02008290 */  lbu        $v0, 0x2($a0)
    /* F49F4 801041F4 00000000 */  nop
    /* F49F8 801041F8 18006200 */  mult       $v1, $v0
    /* F49FC 801041FC 12180000 */  mflo       $v1
    /* F4A00 80104200 C0100300 */  sll        $v0, $v1, 3
    /* F4A04 80104204 21104300 */  addu       $v0, $v0, $v1
    /* F4A08 80104208 C0100200 */  sll        $v0, $v0, 3
    /* F4A0C 8010420C 21104300 */  addu       $v0, $v0, $v1
    /* F4A10 80104210 40100200 */  sll        $v0, $v0, 1
    /* F4A14 80104214 0800E003 */  jr         $ra
    /* F4A18 80104218 03120200 */   sra       $v0, $v0, 8
endlabel iSNDplatformcalcdatarate
