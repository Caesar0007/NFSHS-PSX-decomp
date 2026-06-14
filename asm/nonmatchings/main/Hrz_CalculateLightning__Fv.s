.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_CalculateLightning__Fv, 0x3C

glabel Hrz_CalculateLightning__Fv
    /* C0BC8 800D03C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C0BCC 800D03CC 1280023C */  lui        $v0, %hi(gHrz_Lightning)
    /* C0BD0 800D03D0 BC084224 */  addiu      $v0, $v0, %lo(gHrz_Lightning)
    /* C0BD4 800D03D4 C8000324 */  addiu      $v1, $zero, 0xC8
    /* C0BD8 800D03D8 01000424 */  addiu      $a0, $zero, 0x1
    /* C0BDC 800D03DC 21280000 */  addu       $a1, $zero, $zero
    /* C0BE0 800D03E0 2130A000 */  addu       $a2, $a1, $zero
    /* C0BE4 800D03E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* C0BE8 800D03E8 640040A0 */  sb         $zero, 0x64($v0)
    /* C0BEC 800D03EC 6C40030C */  jal        Hrz_LightningAddFork__FScScSc
    /* C0BF0 800D03F0 600043AC */   sw        $v1, 0x60($v0)
    /* C0BF4 800D03F4 1000BF8F */  lw         $ra, 0x10($sp)
    /* C0BF8 800D03F8 00000000 */  nop
    /* C0BFC 800D03FC 0800E003 */  jr         $ra
    /* C0C00 800D0400 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hrz_CalculateLightning__Fv
