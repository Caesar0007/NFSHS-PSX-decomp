.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_init, 0x84

glabel FILE_init
    /* DC3F4 800EBBF4 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DC3F8 800EBBF8 88EA428C */  lw         $v0, %lo(gFileDevice)($v0)
    /* DC3FC 800EBBFC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DC400 800EBC00 1000B0AF */  sw         $s0, 0x10($sp)
    /* DC404 800EBC04 21808000 */  addu       $s0, $a0, $zero
    /* DC408 800EBC08 1400B1AF */  sw         $s1, 0x14($sp)
    /* DC40C 800EBC0C 2188A000 */  addu       $s1, $a1, $zero
    /* DC410 800EBC10 1800B2AF */  sw         $s2, 0x18($sp)
    /* DC414 800EBC14 2190C000 */  addu       $s2, $a2, $zero
    /* DC418 800EBC18 03004010 */  beqz       $v0, .L800EBC28
    /* DC41C 800EBC1C 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* DC420 800EBC20 18AF0308 */  j          .L800EBC60
    /* DC424 800EBC24 21100000 */   addu      $v0, $zero, $zero
  .L800EBC28:
    /* DC428 800EBC28 21200002 */  addu       $a0, $s0, $zero
    /* DC42C 800EBC2C 21282002 */  addu       $a1, $s1, $zero
    /* DC430 800EBC30 5DAF030C */  jal        FILE_overhead
    /* DC434 800EBC34 21304002 */   addu      $a2, $s2, $zero
    /* DC438 800EBC38 0580043C */  lui        $a0, %hi(D_80056C44)
    /* DC43C 800EBC3C 446C8424 */  addiu      $a0, $a0, %lo(D_80056C44)
    /* DC440 800EBC40 21284000 */  addu       $a1, $v0, $zero
    /* DC444 800EBC44 CF94030C */  jal        reservememadr
    /* DC448 800EBC48 21300000 */   addu      $a2, $zero, $zero
    /* DC44C 800EBC4C 21200002 */  addu       $a0, $s0, $zero
    /* DC450 800EBC50 21282002 */  addu       $a1, $s1, $zero
    /* DC454 800EBC54 21304002 */  addu       $a2, $s2, $zero
    /* DC458 800EBC58 1EAF030C */  jal        FILE_initwithmem
    /* DC45C 800EBC5C 21384000 */   addu      $a3, $v0, $zero
  .L800EBC60:
    /* DC460 800EBC60 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DC464 800EBC64 1800B28F */  lw         $s2, 0x18($sp)
    /* DC468 800EBC68 1400B18F */  lw         $s1, 0x14($sp)
    /* DC46C 800EBC6C 1000B08F */  lw         $s0, 0x10($sp)
    /* DC470 800EBC70 0800E003 */  jr         $ra
    /* DC474 800EBC74 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_init
