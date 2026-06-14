.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddCarSfx__FiP8coorddefiT1, 0x6C

glabel TrgSfx_AddCarSfx__FiP8coorddefiT1
    /* AB8D0 800BB0D0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AB8D4 800BB0D4 07008430 */  andi       $a0, $a0, 0x7
    /* AB8D8 800BB0D8 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* AB8DC 800BB0DC 1280023C */  lui        $v0, %hi(gTAddCarSfx)
    /* AB8E0 800BB0E0 D0E14224 */  addiu      $v0, $v0, %lo(gTAddCarSfx)
    /* AB8E4 800BB0E4 80200400 */  sll        $a0, $a0, 2
    /* AB8E8 800BB0E8 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* AB8EC 800BB0EC 21208200 */  addu       $a0, $a0, $v0
    /* AB8F0 800BB0F0 1800BFAF */  sw         $ra, 0x18($sp)
    /* AB8F4 800BB0F4 0000828C */  lw         $v0, 0x0($a0)
    /* AB8F8 800BB0F8 00000000 */  nop
    /* AB8FC 800BB0FC 23106200 */  subu       $v0, $v1, $v0
    /* AB900 800BB100 08004228 */  slti       $v0, $v0, 0x8
    /* AB904 800BB104 09004014 */  bnez       $v0, .L800BB12C
    /* AB908 800BB108 00000000 */   nop
    /* AB90C 800BB10C 000083AC */  sw         $v1, 0x0($a0)
    /* AB910 800BB110 2120A000 */  addu       $a0, $a1, $zero
    /* AB914 800BB114 2128C000 */  addu       $a1, $a2, $zero
    /* AB918 800BB118 2130E000 */  addu       $a2, $a3, $zero
    /* AB91C 800BB11C 21380000 */  addu       $a3, $zero, $zero
    /* AB920 800BB120 1000A0AF */  sw         $zero, 0x10($sp)
    /* AB924 800BB124 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* AB928 800BB128 1400A0AF */   sw        $zero, 0x14($sp)
  .L800BB12C:
    /* AB92C 800BB12C 1800BF8F */  lw         $ra, 0x18($sp)
    /* AB930 800BB130 00000000 */  nop
    /* AB934 800BB134 0800E003 */  jr         $ra
    /* AB938 800BB138 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TrgSfx_AddCarSfx__FiP8coorddefiT1
