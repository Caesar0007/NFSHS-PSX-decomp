.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddEnviroEffect__FiiP8coorddefT2, 0x68

glabel TrgSfx_AddEnviroEffect__FiiP8coorddefT2
    /* AB868 800BB068 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AB86C 800BB06C 07008430 */  andi       $a0, $a0, 0x7
    /* AB870 800BB070 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* AB874 800BB074 1280023C */  lui        $v0, %hi(gTEnviroEffect)
    /* AB878 800BB078 B0E14224 */  addiu      $v0, $v0, %lo(gTEnviroEffect)
    /* AB87C 800BB07C 80200400 */  sll        $a0, $a0, 2
    /* AB880 800BB080 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* AB884 800BB084 21208200 */  addu       $a0, $a0, $v0
    /* AB888 800BB088 1800BFAF */  sw         $ra, 0x18($sp)
    /* AB88C 800BB08C 0000828C */  lw         $v0, 0x0($a0)
    /* AB890 800BB090 00000000 */  nop
    /* AB894 800BB094 23106200 */  subu       $v0, $v1, $v0
    /* AB898 800BB098 0B004228 */  slti       $v0, $v0, 0xB
    /* AB89C 800BB09C 08004014 */  bnez       $v0, .L800BB0C0
    /* AB8A0 800BB0A0 00000000 */   nop
    /* AB8A4 800BB0A4 000083AC */  sw         $v1, 0x0($a0)
    /* AB8A8 800BB0A8 2120C000 */  addu       $a0, $a2, $zero
    /* AB8AC 800BB0AC 2130E000 */  addu       $a2, $a3, $zero
    /* AB8B0 800BB0B0 21380000 */  addu       $a3, $zero, $zero
    /* AB8B4 800BB0B4 1000A0AF */  sw         $zero, 0x10($sp)
    /* AB8B8 800BB0B8 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* AB8BC 800BB0BC 1400A0AF */   sw        $zero, 0x14($sp)
  .L800BB0C0:
    /* AB8C0 800BB0C0 1800BF8F */  lw         $ra, 0x18($sp)
    /* AB8C4 800BB0C4 00000000 */  nop
    /* AB8C8 800BB0C8 0800E003 */  jr         $ra
    /* AB8CC 800BB0CC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TrgSfx_AddEnviroEffect__FiiP8coorddefT2
