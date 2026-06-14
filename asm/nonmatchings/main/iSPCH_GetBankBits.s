.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetBankBits, 0x24

glabel iSPCH_GetBankBits
    /* F1194 80100994 02008290 */  lbu        $v0, 0x2($a0)
    /* F1198 80100998 03008390 */  lbu        $v1, 0x3($a0)
    /* F119C 8010099C 0F004230 */  andi       $v0, $v0, 0xF
    /* F11A0 801009A0 02004224 */  addiu      $v0, $v0, 0x2
    /* F11A4 801009A4 18006200 */  mult       $v1, $v0
    /* F11A8 801009A8 08008424 */  addiu      $a0, $a0, 0x8
    /* F11AC 801009AC 12280000 */  mflo       $a1
    /* F11B0 801009B0 0800E003 */  jr         $ra
    /* F11B4 801009B4 21108500 */   addu      $v0, $a0, $a1
endlabel iSPCH_GetBankBits
