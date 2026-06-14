.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching xzsquaredist32__FP8coorddefT0, 0x44

glabel xzsquaredist32__FP8coorddefT0
    /* 6DDC4 8007D5C4 0000A28C */  lw         $v0, 0x0($a1)
    /* 6DDC8 8007D5C8 0000838C */  lw         $v1, 0x0($a0)
    /* 6DDCC 8007D5CC 00000000 */  nop
    /* 6DDD0 8007D5D0 23104300 */  subu       $v0, $v0, $v1
    /* 6DDD4 8007D5D4 03130200 */  sra        $v0, $v0, 12
    /* 6DDD8 8007D5D8 18004200 */  mult       $v0, $v0
    /* 6DDDC 8007D5DC 0800A28C */  lw         $v0, 0x8($a1)
    /* 6DDE0 8007D5E0 0800838C */  lw         $v1, 0x8($a0)
    /* 6DDE4 8007D5E4 12300000 */  mflo       $a2
    /* 6DDE8 8007D5E8 23104300 */  subu       $v0, $v0, $v1
    /* 6DDEC 8007D5EC 03130200 */  sra        $v0, $v0, 12
    /* 6DDF0 8007D5F0 18004200 */  mult       $v0, $v0
    /* 6DDF4 8007D5F4 83190600 */  sra        $v1, $a2, 6
    /* 6DDF8 8007D5F8 12400000 */  mflo       $t0
    /* 6DDFC 8007D5FC 83110800 */  sra        $v0, $t0, 6
    /* 6DE00 8007D600 0800E003 */  jr         $ra
    /* 6DE04 8007D604 21106200 */   addu      $v0, $v1, $v0
endlabel xzsquaredist32__FP8coorddefT0
