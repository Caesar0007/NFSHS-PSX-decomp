.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedsqrt, 0x54

glabel fixedsqrt
    /* DB8AC 800EB0AC 12008010 */  beqz       $a0, .L800EB0F8
    /* DB8B0 800EB0B0 0080093C */   lui       $t1, (0x80000000 >> 16)
    /* DB8B4 800EB0B4 1280083C */  lui        $t0, %hi(D_8012356C)
    /* DB8B8 800EB0B8 6C350825 */  addiu      $t0, $t0, %lo(D_8012356C)
  .L800EB0BC:
    /* DB8BC 800EB0BC 24508900 */  and        $t2, $a0, $t1
    /* DB8C0 800EB0C0 FCFF0825 */  addiu      $t0, $t0, -0x4
    /* DB8C4 800EB0C4 FDFF4011 */  beqz       $t2, .L800EB0BC
    /* DB8C8 800EB0C8 42480900 */   srl       $t1, $t1, 1
    /* DB8CC 800EB0CC 00000B8D */  lw         $t3, 0x0($t0)
    /* DB8D0 800EB0D0 84000C8D */  lw         $t4, 0x84($t0)
    /* DB8D4 800EB0D4 18008B00 */  mult       $a0, $t3
    /* DB8D8 800EB0D8 00000000 */  nop
    /* DB8DC 800EB0DC 12400000 */  mflo       $t0
    /* DB8E0 800EB0E0 10480000 */  mfhi       $t1
    /* DB8E4 800EB0E4 02440800 */  srl        $t0, $t0, 16
    /* DB8E8 800EB0E8 004C0900 */  sll        $t1, $t1, 16
    /* DB8EC 800EB0EC 25100901 */  or         $v0, $t0, $t1
    /* DB8F0 800EB0F0 0800E003 */  jr         $ra
    /* DB8F4 800EB0F4 21104C00 */   addu      $v0, $v0, $t4
  .L800EB0F8:
    /* DB8F8 800EB0F8 0800E003 */  jr         $ra
    /* DB8FC 800EB0FC 21100000 */   addu      $v0, $zero, $zero
endlabel fixedsqrt
