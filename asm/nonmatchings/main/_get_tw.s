.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _get_tw, 0x80

glabel _get_tw
    /* DF1E4 800EE9E4 03008014 */  bnez       $a0, .L800EE9F4
    /* DF1E8 800EE9E8 F0FFBD27 */   addiu     $sp, $sp, -0x10
    /* DF1EC 800EE9EC 97BA0308 */  j          .L800EEA5C
    /* DF1F0 800EE9F0 21100000 */   addu      $v0, $zero, $zero
  .L800EE9F4:
    /* DF1F4 800EE9F4 00008590 */  lbu        $a1, 0x0($a0)
    /* DF1F8 800EE9F8 00000000 */  nop
    /* DF1FC 800EE9FC C2280500 */  srl        $a1, $a1, 3
    /* DF200 800EEA00 0000A5AF */  sw         $a1, 0x0($sp)
    /* DF204 800EEA04 04008684 */  lh         $a2, 0x4($a0)
    /* DF208 800EEA08 00000000 */  nop
    /* DF20C 800EEA0C 23300600 */  negu       $a2, $a2
    /* DF210 800EEA10 FF00C630 */  andi       $a2, $a2, 0xFF
    /* DF214 800EEA14 C3300600 */  sra        $a2, $a2, 3
    /* DF218 800EEA18 0800A6AF */  sw         $a2, 0x8($sp)
    /* DF21C 800EEA1C 02008290 */  lbu        $v0, 0x2($a0)
    /* DF220 800EEA20 802A0500 */  sll        $a1, $a1, 10
    /* DF224 800EEA24 C2100200 */  srl        $v0, $v0, 3
    /* DF228 800EEA28 0400A2AF */  sw         $v0, 0x4($sp)
    /* DF22C 800EEA2C C0130200 */  sll        $v0, $v0, 15
    /* DF230 800EEA30 06008384 */  lh         $v1, 0x6($a0)
    /* DF234 800EEA34 00E2043C */  lui        $a0, (0xE2000000 >> 16)
    /* DF238 800EEA38 2528A400 */  or         $a1, $a1, $a0
    /* DF23C 800EEA3C 25104500 */  or         $v0, $v0, $a1
    /* DF240 800EEA40 23180300 */  negu       $v1, $v1
    /* DF244 800EEA44 FF006330 */  andi       $v1, $v1, 0xFF
    /* DF248 800EEA48 C3180300 */  sra        $v1, $v1, 3
    /* DF24C 800EEA4C 40210300 */  sll        $a0, $v1, 5
    /* DF250 800EEA50 25104400 */  or         $v0, $v0, $a0
    /* DF254 800EEA54 25104600 */  or         $v0, $v0, $a2
    /* DF258 800EEA58 0C00A3AF */  sw         $v1, 0xC($sp)
  .L800EEA5C:
    /* DF25C 800EEA5C 0800E003 */  jr         $ra
    /* DF260 800EEA60 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel _get_tw
