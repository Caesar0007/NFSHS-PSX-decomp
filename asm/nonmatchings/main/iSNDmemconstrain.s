.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDmemconstrain, 0x2C

glabel iSNDmemconstrain
    /* F69A8 801061A8 1580033C */  lui        $v1, %hi(D_80148786)
    /* F69AC 801061AC 0000848C */  lw         $a0, 0x0($a0)
    /* F69B0 801061B0 0000A28C */  lw         $v0, 0x0($a1)
    /* F69B4 801061B4 86876394 */  lhu        $v1, %lo(D_80148786)($v1)
    /* F69B8 801061B8 21108200 */  addu       $v0, $a0, $v0
    /* F69BC 801061BC 2A106200 */  slt        $v0, $v1, $v0
    /* F69C0 801061C0 02004010 */  beqz       $v0, .L801061CC
    /* F69C4 801061C4 23106400 */   subu      $v0, $v1, $a0
    /* F69C8 801061C8 0000A2AC */  sw         $v0, 0x0($a1)
  .L801061CC:
    /* F69CC 801061CC 0800E003 */  jr         $ra
    /* F69D0 801061D0 00000000 */   nop
endlabel iSNDmemconstrain
