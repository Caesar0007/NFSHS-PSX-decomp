.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetTuningLevers__10AIHigh_Cop, 0x78

glabel SetTuningLevers__10AIHigh_Cop
    /* 5444C 80063C4C 21388000 */  addu       $a3, $a0, $zero
    /* 54450 80063C50 0000E58C */  lw         $a1, 0x0($a3)
    /* 54454 80063C54 01000224 */  addiu      $v0, $zero, 0x1
    /* 54458 80063C58 8802A38C */  lw         $v1, 0x288($a1)
    /* 5445C 80063C5C 1800E48C */  lw         $a0, 0x18($a3)
    /* 54460 80063C60 0000668C */  lw         $a2, 0x0($v1)
    /* 54464 80063C64 0C008214 */  bne        $a0, $v0, .L80063C98
    /* 54468 80063C68 1180033C */   lui       $v1, %hi(copTuningInfo)
    /* 5446C 80063C6C 5CDF6324 */  addiu      $v1, $v1, %lo(copTuningInfo)
    /* 54470 80063C70 EAFFC224 */  addiu      $v0, $a2, -0x16
    /* 54474 80063C74 00110200 */  sll        $v0, $v0, 4
    /* 54478 80063C78 21104300 */  addu       $v0, $v0, $v1
    /* 5447C 80063C7C 0C00438C */  lw         $v1, 0xC($v0)
    /* 54480 80063C80 00000000 */  nop
    /* 54484 80063C84 C806A3AC */  sw         $v1, 0x6C8($a1)
    /* 54488 80063C88 0000E38C */  lw         $v1, 0x0($a3)
    /* 5448C 80063C8C 0400428C */  lw         $v0, 0x4($v0)
    /* 54490 80063C90 0800E003 */  jr         $ra
    /* 54494 80063C94 CC0662AC */   sw        $v0, 0x6CC($v1)
  .L80063C98:
    /* 54498 80063C98 5CDF6324 */  addiu      $v1, $v1, %lo(copTuningInfo)
    /* 5449C 80063C9C EAFFC224 */  addiu      $v0, $a2, -0x16
    /* 544A0 80063CA0 00110200 */  sll        $v0, $v0, 4
    /* 544A4 80063CA4 21104300 */  addu       $v0, $v0, $v1
    /* 544A8 80063CA8 0800438C */  lw         $v1, 0x8($v0)
    /* 544AC 80063CAC 00000000 */  nop
    /* 544B0 80063CB0 C806A3AC */  sw         $v1, 0x6C8($a1)
    /* 544B4 80063CB4 0000E38C */  lw         $v1, 0x0($a3)
    /* 544B8 80063CB8 0000428C */  lw         $v0, 0x0($v0)
    /* 544BC 80063CBC 0800E003 */  jr         $ra
    /* 544C0 80063CC0 CC0662AC */   sw        $v0, 0x6CC($v1)
endlabel SetTuningLevers__10AIHigh_Cop
