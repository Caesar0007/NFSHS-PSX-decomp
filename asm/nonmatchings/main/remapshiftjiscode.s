.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching remapshiftjiscode, 0x28

glabel remapshiftjiscode
    /* F71C4 801069C4 E0FF8524 */  addiu      $a1, $a0, -0x20
    /* F71C8 801069C8 6000A22C */  sltiu      $v0, $a1, 0x60
    /* F71CC 801069CC 05004010 */  beqz       $v0, .L801069E4
    /* F71D0 801069D0 1480033C */   lui       $v1, %hi(D_8013BD50)
    /* F71D4 801069D4 50BD6324 */  addiu      $v1, $v1, %lo(D_8013BD50)
    /* F71D8 801069D8 40100500 */  sll        $v0, $a1, 1
    /* F71DC 801069DC 21104300 */  addu       $v0, $v0, $v1
    /* F71E0 801069E0 00004494 */  lhu        $a0, 0x0($v0)
  .L801069E4:
    /* F71E4 801069E4 0800E003 */  jr         $ra
    /* F71E8 801069E8 21108000 */   addu      $v0, $a0, $zero
endlabel remapshiftjiscode
