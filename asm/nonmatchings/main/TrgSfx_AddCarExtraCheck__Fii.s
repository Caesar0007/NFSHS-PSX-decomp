.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddCarExtraCheck__Fii, 0x3C

glabel TrgSfx_AddCarExtraCheck__Fii
    /* AB9EC 800BB1EC 07008430 */  andi       $a0, $a0, 0x7
    /* AB9F0 800BB1F0 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* AB9F4 800BB1F4 1280023C */  lui        $v0, %hi(gTAddCarExtraSfx)
    /* AB9F8 800BB1F8 70E24224 */  addiu      $v0, $v0, %lo(gTAddCarExtraSfx)
    /* AB9FC 800BB1FC 80280500 */  sll        $a1, $a1, 2
    /* ABA00 800BB200 00210400 */  sll        $a0, $a0, 4
    /* ABA04 800BB204 2128A400 */  addu       $a1, $a1, $a0
    /* ABA08 800BB208 2128A200 */  addu       $a1, $a1, $v0
    /* ABA0C 800BB20C B0E0628C */  lw         $v0, %lo(D_8011E0B0)($v1)
    /* ABA10 800BB210 0000A38C */  lw         $v1, 0x0($a1)
    /* ABA14 800BB214 00000000 */  nop
    /* ABA18 800BB218 23104300 */  subu       $v0, $v0, $v1
    /* ABA1C 800BB21C 08004228 */  slti       $v0, $v0, 0x8
    /* ABA20 800BB220 0800E003 */  jr         $ra
    /* ABA24 800BB224 01004238 */   xori      $v0, $v0, 0x1
endlabel TrgSfx_AddCarExtraCheck__Fii
