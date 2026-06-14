.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_InitEventDat, 0x28

glabel iSPCH_InitEventDat
    /* D77BC 800E6FBC 03000324 */  addiu      $v1, $zero, 0x3
    /* D77C0 800E6FC0 1580023C */  lui        $v0, %hi(gEventDats)
    /* D77C4 800E6FC4 48804224 */  addiu      $v0, $v0, %lo(gEventDats)
    /* D77C8 800E6FC8 0C004224 */  addiu      $v0, $v0, 0xC
  .L800E6FCC:
    /* D77CC 800E6FCC 000040AC */  sw         $zero, 0x0($v0)
    /* D77D0 800E6FD0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* D77D4 800E6FD4 FDFF6104 */  bgez       $v1, .L800E6FCC
    /* D77D8 800E6FD8 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* D77DC 800E6FDC 0800E003 */  jr         $ra
    /* D77E0 800E6FE0 00000000 */   nop
endlabel iSPCH_InitEventDat
