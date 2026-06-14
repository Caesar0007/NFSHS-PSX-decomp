.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_AddCarSplash__FiiP8coorddefiT2ii, 0xB4

glabel TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
    /* ABABC 800BB2BC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* ABAC0 800BB2C0 07008430 */  andi       $a0, $a0, 0x7
    /* ABAC4 800BB2C4 1280023C */  lui        $v0, %hi(simGlobal)
    /* ABAC8 800BB2C8 ACE04824 */  addiu      $t0, $v0, %lo(simGlobal)
    /* ABACC 800BB2CC 1280023C */  lui        $v0, %hi(gTAddCarWheelSfx)
    /* ABAD0 800BB2D0 F0E14224 */  addiu      $v0, $v0, %lo(gTAddCarWheelSfx)
    /* ABAD4 800BB2D4 80280500 */  sll        $a1, $a1, 2
    /* ABAD8 800BB2D8 00210400 */  sll        $a0, $a0, 4
    /* ABADC 800BB2DC 2128A400 */  addu       $a1, $a1, $a0
    /* ABAE0 800BB2E0 2128A200 */  addu       $a1, $a1, $v0
    /* ABAE4 800BB2E4 2800BFAF */  sw         $ra, 0x28($sp)
    /* ABAE8 800BB2E8 0400038D */  lw         $v1, 0x4($t0)
    /* ABAEC 800BB2EC 0000A48C */  lw         $a0, 0x0($a1)
    /* ABAF0 800BB2F0 4400A28F */  lw         $v0, 0x44($sp)
    /* ABAF4 800BB2F4 23186400 */  subu       $v1, $v1, $a0
    /* ABAF8 800BB2F8 2A104300 */  slt        $v0, $v0, $v1
    /* ABAFC 800BB2FC 18004010 */  beqz       $v0, .L800BB360
    /* ABB00 800BB300 2120C000 */   addu      $a0, $a2, $zero
    /* ABB04 800BB304 4000A28F */  lw         $v0, 0x40($sp)
    /* ABB08 800BB308 00000000 */  nop
    /* ABB0C 800BB30C 0000498C */  lw         $t1, 0x0($v0)
    /* ABB10 800BB310 04004A8C */  lw         $t2, 0x4($v0)
    /* ABB14 800BB314 08004B8C */  lw         $t3, 0x8($v0)
    /* ABB18 800BB318 1800A9AF */  sw         $t1, 0x18($sp)
    /* ABB1C 800BB31C 1C00AAAF */  sw         $t2, 0x1C($sp)
    /* ABB20 800BB320 2000ABAF */  sw         $t3, 0x20($sp)
    /* ABB24 800BB324 1800A28F */  lw         $v0, 0x18($sp)
    /* ABB28 800BB328 00000000 */  nop
    /* ABB2C 800BB32C 43100200 */  sra        $v0, $v0, 1
    /* ABB30 800BB330 1800A2AF */  sw         $v0, 0x18($sp)
    /* ABB34 800BB334 2000A28F */  lw         $v0, 0x20($sp)
    /* ABB38 800BB338 0400038D */  lw         $v1, 0x4($t0)
    /* ABB3C 800BB33C 43100200 */  sra        $v0, $v0, 1
    /* ABB40 800BB340 2000A2AF */  sw         $v0, 0x20($sp)
    /* ABB44 800BB344 0000A3AC */  sw         $v1, 0x0($a1)
    /* ABB48 800BB348 2128E000 */  addu       $a1, $a3, $zero
    /* ABB4C 800BB34C 4800A78F */  lw         $a3, 0x48($sp)
    /* ABB50 800BB350 1800A627 */  addiu      $a2, $sp, 0x18
    /* ABB54 800BB354 1000A0AF */  sw         $zero, 0x10($sp)
    /* ABB58 800BB358 C3DD020C */  jal        Souffle_Add__FP8coorddefiT0iii
    /* ABB5C 800BB35C 1400A0AF */   sw        $zero, 0x14($sp)
  .L800BB360:
    /* ABB60 800BB360 2800BF8F */  lw         $ra, 0x28($sp)
    /* ABB64 800BB364 00000000 */  nop
    /* ABB68 800BB368 0800E003 */  jr         $ra
    /* ABB6C 800BB36C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
