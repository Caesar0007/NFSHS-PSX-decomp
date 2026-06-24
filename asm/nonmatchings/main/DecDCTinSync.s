.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCTinSync, 0x3C

glabel DecDCTinSync
    /* E9298 800F8A98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E929C 800F8A9C 05008014 */  bnez       $a0, .L800F8AB4
    /* E92A0 800F8AA0 1000BFAF */   sw        $ra, 0x10($sp)
    /* E92A4 800F8AA4 41E3030C */  jal        MDEC_in_sync
    /* E92A8 800F8AA8 00000000 */   nop
    /* E92AC 800F8AAC B1E20308 */  j          .L800F8AC4
    /* E92B0 800F8AB0 00000000 */   nop
  .L800F8AB4:
    /* E92B4 800F8AB4 8BE3030C */  jal        _MDEC_get_reg1
    /* E92B8 800F8AB8 00000000 */   nop
    /* E92BC 800F8ABC 42170200 */  srl        $v0, $v0, 29
    /* E92C0 800F8AC0 01004230 */  andi       $v0, $v0, 0x1
  .L800F8AC4:
    /* E92C4 800F8AC4 1000BF8F */  lw         $ra, 0x10($sp)
    /* E92C8 800F8AC8 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E92CC 800F8ACC 0800E003 */  jr         $ra
    /* E92D0 800F8AD0 00000000 */   nop
endlabel DecDCTinSync
