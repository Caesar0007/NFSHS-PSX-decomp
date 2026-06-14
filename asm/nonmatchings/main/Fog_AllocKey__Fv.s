.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_AllocKey__Fv, 0x4C

glabel Fog_AllocKey__Fv
    /* D1480 800E0C80 21280000 */  addu       $a1, $zero, $zero
    /* D1484 800E0C84 01000624 */  addiu      $a2, $zero, 0x1
    /* D1488 800E0C88 1280023C */  lui        $v0, %hi(Fog_gBuf)
    /* D148C 800E0C8C 7C304424 */  addiu      $a0, $v0, %lo(Fog_gBuf)
    /* D1490 800E0C90 1280023C */  lui        $v0, %hi(openkeys)
    /* D1494 800E0C94 FC314324 */  addiu      $v1, $v0, %lo(openkeys)
  .L800E0C98:
    /* D1498 800E0C98 0000628C */  lw         $v0, 0x0($v1)
    /* D149C 800E0C9C 00000000 */  nop
    /* D14A0 800E0CA0 04004614 */  bne        $v0, $a2, .L800E0CB4
    /* D14A4 800E0CA4 0100A524 */   addiu     $a1, $a1, 0x1
    /* D14A8 800E0CA8 000060AC */  sw         $zero, 0x0($v1)
    /* D14AC 800E0CAC 0800E003 */  jr         $ra
    /* D14B0 800E0CB0 21108000 */   addu      $v0, $a0, $zero
  .L800E0CB4:
    /* D14B4 800E0CB4 0C008424 */  addiu      $a0, $a0, 0xC
    /* D14B8 800E0CB8 2000A228 */  slti       $v0, $a1, 0x20
    /* D14BC 800E0CBC F6FF4014 */  bnez       $v0, .L800E0C98
    /* D14C0 800E0CC0 04006324 */   addiu     $v1, $v1, 0x4
    /* D14C4 800E0CC4 0800E003 */  jr         $ra
    /* D14C8 800E0CC8 21100000 */   addu      $v0, $zero, $zero
endlabel Fog_AllocKey__Fv
