.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetFogNear, 0x64

glabel SetFogNear
    /* E2FDC 800F27DC 80100400 */  sll        $v0, $a0, 2
    /* E2FE0 800F27E0 21104400 */  addu       $v0, $v0, $a0
    /* E2FE4 800F27E4 80110200 */  sll        $v0, $v0, 6
    /* E2FE8 800F27E8 23100200 */  negu       $v0, $v0
    /* E2FEC 800F27EC 1A004500 */  div        $zero, $v0, $a1
    /* E2FF0 800F27F0 0200A014 */  bnez       $a1, .L800F27FC
    /* E2FF4 800F27F4 00000000 */   nop
    /* E2FF8 800F27F8 0D000700 */  break      7
  .L800F27FC:
    /* E2FFC 800F27FC FFFF0124 */  addiu      $at, $zero, -0x1
    /* E3000 800F2800 0400A114 */  bne        $a1, $at, .L800F2814
    /* E3004 800F2804 0080013C */   lui       $at, (0x80000000 >> 16)
    /* E3008 800F2808 02004114 */  bne        $v0, $at, .L800F2814
    /* E300C 800F280C 00000000 */   nop
    /* E3010 800F2810 0D000600 */  break      6
  .L800F2814:
    /* E3014 800F2814 12200000 */  mflo       $a0
    /* E3018 800F2818 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E301C 800F281C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E3020 800F2820 9D19040C */  jal        SetDQA
    /* E3024 800F2824 00000000 */   nop
    /* E3028 800F2828 A019040C */  jal        SetDQB
    /* E302C 800F282C 4001043C */   lui       $a0, (0x1400000 >> 16)
    /* E3030 800F2830 1000BF8F */  lw         $ra, 0x10($sp)
    /* E3034 800F2834 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E3038 800F2838 0800E003 */  jr         $ra
    /* E303C 800F283C 00000000 */   nop
endlabel SetFogNear
    /* E3040 800F2840 00000000 */  nop
    /* E3044 800F2844 00000000 */  nop
    /* E3048 800F2848 00000000 */  nop
