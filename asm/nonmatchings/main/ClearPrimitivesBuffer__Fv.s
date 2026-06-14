.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearPrimitivesBuffer__Fv, 0x68

glabel ClearPrimitivesBuffer__Fv
    /* AE79C 800BDF9C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AE7A0 800BDFA0 21200000 */  addu       $a0, $zero, $zero
    /* AE7A4 800BDFA4 1400BFAF */  sw         $ra, 0x14($sp)
    /* AE7A8 800BDFA8 1FB6030C */  jal        DrawSync
    /* AE7AC 800BDFAC 1000B0AF */   sw        $s0, 0x10($sp)
    /* AE7B0 800BDFB0 1280023C */  lui        $v0, %hi(gEnviro)
    /* AE7B4 800BDFB4 24F45024 */  addiu      $s0, $v0, %lo(gEnviro)
    /* AE7B8 800BDFB8 1400048E */  lw         $a0, 0x14($s0)
    /* AE7BC 800BDFBC 00000000 */  nop
    /* AE7C0 800BDFC0 03008010 */  beqz       $a0, .L800BDFD0
    /* AE7C4 800BDFC4 00000000 */   nop
    /* AE7C8 800BDFC8 5095030C */  jal        purgememadr
    /* AE7CC 800BDFCC 00000000 */   nop
  .L800BDFD0:
    /* AE7D0 800BDFD0 2C00048E */  lw         $a0, 0x2C($s0)
    /* AE7D4 800BDFD4 00000000 */  nop
    /* AE7D8 800BDFD8 03008010 */  beqz       $a0, .L800BDFE8
    /* AE7DC 800BDFDC 00000000 */   nop
    /* AE7E0 800BDFE0 5095030C */  jal        purgememadr
    /* AE7E4 800BDFE4 00000000 */   nop
  .L800BDFE8:
    /* AE7E8 800BDFE8 2C0000AE */  sw         $zero, 0x2C($s0)
    /* AE7EC 800BDFEC 38F7020C */  jal        Draw_DeInitViews__Fv
    /* AE7F0 800BDFF0 140000AE */   sw        $zero, 0x14($s0)
    /* AE7F4 800BDFF4 1400BF8F */  lw         $ra, 0x14($sp)
    /* AE7F8 800BDFF8 1000B08F */  lw         $s0, 0x10($sp)
    /* AE7FC 800BDFFC 0800E003 */  jr         $ra
    /* AE800 800BE000 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ClearPrimitivesBuffer__Fv
