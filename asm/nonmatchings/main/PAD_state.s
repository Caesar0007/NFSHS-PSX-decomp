.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PAD_state, 0x50

glabel PAD_state
    /* D49AC 800E41AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D49B0 800E41B0 1480033C */  lui        $v1, %hi(gPadinfo)
    /* D49B4 800E41B4 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* D49B8 800E41B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* D49BC 800E41BC 0000628C */  lw         $v0, 0x0($v1)
    /* D49C0 800E41C0 00000000 */  nop
    /* D49C4 800E41C4 08004010 */  beqz       $v0, .L800E41E8
    /* D49C8 800E41C8 0800822C */   sltiu     $v0, $a0, 0x8
    /* D49CC 800E41CC 06004010 */  beqz       $v0, .L800E41E8
    /* D49D0 800E41D0 C0100400 */   sll       $v0, $a0, 3
    /* D49D4 800E41D4 04006424 */  addiu      $a0, $v1, 0x4
    /* D49D8 800E41D8 7F90030C */  jal        PAD_convert
    /* D49DC 800E41DC 21204400 */   addu      $a0, $v0, $a0
    /* D49E0 800E41E0 7B900308 */  j          .L800E41EC
    /* D49E4 800E41E4 FFFF4230 */   andi      $v0, $v0, 0xFFFF
  .L800E41E8:
    /* D49E8 800E41E8 21100000 */  addu       $v0, $zero, $zero
  .L800E41EC:
    /* D49EC 800E41EC 1000BF8F */  lw         $ra, 0x10($sp)
    /* D49F0 800E41F0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* D49F4 800E41F4 0800E003 */  jr         $ra
    /* D49F8 800E41F8 00000000 */   nop
endlabel PAD_state
