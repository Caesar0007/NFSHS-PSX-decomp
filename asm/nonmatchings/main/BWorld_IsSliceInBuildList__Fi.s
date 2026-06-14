.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_IsSliceInBuildList__Fi, 0x54

glabel BWorld_IsSliceInBuildList__Fi
    /* 6E8A0 8007E0A0 02008104 */  bgez       $a0, .L8007E0AC
    /* 6E8A4 8007E0A4 21280000 */   addu      $a1, $zero, $zero
    /* 6E8A8 8007E0A8 07008424 */  addiu      $a0, $a0, 0x7
  .L8007E0AC:
    /* 6E8AC 8007E0AC 5C02828F */  lw         $v0, %gp_rel(BWorld_gChunkCount)($gp)
    /* 6E8B0 8007E0B0 00000000 */  nop
    /* 6E8B4 8007E0B4 0D004018 */  blez       $v0, .L8007E0EC
    /* 6E8B8 8007E0B8 C3200400 */   sra       $a0, $a0, 3
    /* 6E8BC 8007E0BC 21304000 */  addu       $a2, $v0, $zero
    /* 6E8C0 8007E0C0 1180023C */  lui        $v0, %hi(BWorld_gChunkBuildList)
    /* 6E8C4 8007E0C4 ECEF4324 */  addiu      $v1, $v0, %lo(BWorld_gChunkBuildList)
  .L8007E0C8:
    /* 6E8C8 8007E0C8 00006284 */  lh         $v0, 0x0($v1)
    /* 6E8CC 8007E0CC 00000000 */  nop
    /* 6E8D0 8007E0D0 03004414 */  bne        $v0, $a0, .L8007E0E0
    /* 6E8D4 8007E0D4 0100A524 */   addiu     $a1, $a1, 0x1
    /* 6E8D8 8007E0D8 0800E003 */  jr         $ra
    /* 6E8DC 8007E0DC 01000224 */   addiu     $v0, $zero, 0x1
  .L8007E0E0:
    /* 6E8E0 8007E0E0 2A10A600 */  slt        $v0, $a1, $a2
    /* 6E8E4 8007E0E4 F8FF4014 */  bnez       $v0, .L8007E0C8
    /* 6E8E8 8007E0E8 04006324 */   addiu     $v1, $v1, 0x4
  .L8007E0EC:
    /* 6E8EC 8007E0EC 0800E003 */  jr         $ra
    /* 6E8F0 8007E0F0 21100000 */   addu      $v0, $zero, $zero
endlabel BWorld_IsSliceInBuildList__Fi
