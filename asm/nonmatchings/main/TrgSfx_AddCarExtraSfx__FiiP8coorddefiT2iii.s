.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii, 0x94

glabel TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
    /* ABA28 800BB228 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* ABA2C 800BB22C 07008430 */  andi       $a0, $a0, 0x7
    /* ABA30 800BB230 80280500 */  sll        $a1, $a1, 2
    /* ABA34 800BB234 00210400 */  sll        $a0, $a0, 4
    /* ABA38 800BB238 2128A400 */  addu       $a1, $a1, $a0
    /* ABA3C 800BB23C 2120C000 */  addu       $a0, $a2, $zero
    /* ABA40 800BB240 4000A28F */  lw         $v0, 0x40($sp)
    /* ABA44 800BB244 4400A38F */  lw         $v1, 0x44($sp)
    /* ABA48 800BB248 1800A627 */  addiu      $a2, $sp, 0x18
    /* ABA4C 800BB24C 2800BFAF */  sw         $ra, 0x28($sp)
    /* ABA50 800BB250 C3180300 */  sra        $v1, $v1, 3
    /* ABA54 800BB254 00004A8C */  lw         $t2, 0x0($v0)
    /* ABA58 800BB258 04004B8C */  lw         $t3, 0x4($v0)
    /* ABA5C 800BB25C 08004C8C */  lw         $t4, 0x8($v0)
    /* ABA60 800BB260 1800AAAF */  sw         $t2, 0x18($sp)
    /* ABA64 800BB264 1C00ABAF */  sw         $t3, 0x1C($sp)
    /* ABA68 800BB268 2000ACAF */  sw         $t4, 0x20($sp)
    /* ABA6C 800BB26C 4800A98F */  lw         $t1, 0x48($sp)
    /* ABA70 800BB270 1C00A28F */  lw         $v0, 0x1C($sp)
    /* ABA74 800BB274 4C00A88F */  lw         $t0, 0x4C($sp)
    /* ABA78 800BB278 21104300 */  addu       $v0, $v0, $v1
    /* ABA7C 800BB27C 1280033C */  lui        $v1, %hi(gTAddCarExtraSfx)
    /* ABA80 800BB280 70E26324 */  addiu      $v1, $v1, %lo(gTAddCarExtraSfx)
    /* ABA84 800BB284 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* ABA88 800BB288 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* ABA8C 800BB28C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* ABA90 800BB290 2128A300 */  addu       $a1, $a1, $v1
    /* ABA94 800BB294 0000A2AC */  sw         $v0, 0x0($a1)
    /* ABA98 800BB298 2128E000 */  addu       $a1, $a3, $zero
    /* ABA9C 800BB29C 21380000 */  addu       $a3, $zero, $zero
    /* ABAA0 800BB2A0 1000A9AF */  sw         $t1, 0x10($sp)
    /* ABAA4 800BB2A4 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* ABAA8 800BB2A8 1400A8AF */   sw        $t0, 0x14($sp)
    /* ABAAC 800BB2AC 2800BF8F */  lw         $ra, 0x28($sp)
    /* ABAB0 800BB2B0 00000000 */  nop
    /* ABAB4 800BB2B4 0800E003 */  jr         $ra
    /* ABAB8 800BB2B8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
