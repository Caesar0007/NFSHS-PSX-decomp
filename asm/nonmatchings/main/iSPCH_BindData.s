.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_BindData, 0x50

glabel iSPCH_BindData
    /* DC384 800EBB84 00008294 */  lhu        $v0, 0x0($a0)
    /* DC388 800EBB88 00000000 */  nop
    /* DC38C 800EBB8C 1E01422C */  sltiu      $v0, $v0, 0x11E
    /* DC390 800EBB90 0E004014 */  bnez       $v0, .L800EBBCC
    /* DC394 800EBB94 21300000 */   addu      $a2, $zero, $zero
    /* DC398 800EBB98 2128C000 */  addu       $a1, $a2, $zero
    /* DC39C 800EBB9C 1580023C */  lui        $v0, %hi(gEventDats)
    /* DC3A0 800EBBA0 48804324 */  addiu      $v1, $v0, %lo(gEventDats)
  .L800EBBA4:
    /* DC3A4 800EBBA4 0000628C */  lw         $v0, 0x0($v1)
    /* DC3A8 800EBBA8 00000000 */  nop
    /* DC3AC 800EBBAC 04004014 */  bnez       $v0, .L800EBBC0
    /* DC3B0 800EBBB0 0100A524 */   addiu     $a1, $a1, 0x1
    /* DC3B4 800EBBB4 000064AC */  sw         $a0, 0x0($v1)
    /* DC3B8 800EBBB8 F3AE0308 */  j          .L800EBBCC
    /* DC3BC 800EBBBC 01000624 */   addiu     $a2, $zero, 0x1
  .L800EBBC0:
    /* DC3C0 800EBBC0 0400A228 */  slti       $v0, $a1, 0x4
    /* DC3C4 800EBBC4 F7FF4014 */  bnez       $v0, .L800EBBA4
    /* DC3C8 800EBBC8 04006324 */   addiu     $v1, $v1, 0x4
  .L800EBBCC:
    /* DC3CC 800EBBCC 0800E003 */  jr         $ra
    /* DC3D0 800EBBD0 2110C000 */   addu      $v0, $a2, $zero
endlabel iSPCH_BindData
