.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_InitViewOT__Fv, 0x84

glabel Draw_InitViewOT__Fv
    /* AE3E0 800BDBE0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AE3E4 800BDBE4 1400B1AF */  sw         $s1, 0x14($sp)
    /* AE3E8 800BDBE8 21880000 */  addu       $s1, $zero, $zero
    /* AE3EC 800BDBEC 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AE3F0 800BDBF0 1000B0AF */  sw         $s0, 0x10($sp)
    /* AE3F4 800BDBF4 54EC5024 */  addiu      $s0, $v0, %lo(Draw_gView)
    /* AE3F8 800BDBF8 1800BFAF */  sw         $ra, 0x18($sp)
  .L800BDBFC:
    /* AE3FC 800BDBFC 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AE400 800BDC00 00000000 */  nop
    /* AE404 800BDC04 2A102202 */  slt        $v0, $s1, $v0
    /* AE408 800BDC08 11004010 */  beqz       $v0, .L800BDC50
    /* AE40C 800BDC0C 1480043C */   lui       $a0, %hi(D_8013D798)
    /* AE410 800BDC10 98D78424 */  addiu      $a0, $a0, %lo(D_8013D798)
    /* AE414 800BDC14 10000624 */  addiu      $a2, $zero, 0x10
    /* AE418 800BDC18 0000058E */  lw         $a1, 0x0($s0)
    /* AE41C 800BDC1C 01003126 */  addiu      $s1, $s1, 0x1
    /* AE420 800BDC20 CF94030C */  jal        reservememadr
    /* AE424 800BDC24 80280500 */   sll       $a1, $a1, 2
    /* AE428 800BDC28 1480043C */  lui        $a0, %hi(D_8013D79C)
    /* AE42C 800BDC2C 9CD78424 */  addiu      $a0, $a0, %lo(D_8013D79C)
    /* AE430 800BDC30 0000058E */  lw         $a1, 0x0($s0)
    /* AE434 800BDC34 10000624 */  addiu      $a2, $zero, 0x10
    /* AE438 800BDC38 C00002AE */  sw         $v0, 0xC0($s0)
    /* AE43C 800BDC3C CF94030C */  jal        reservememadr
    /* AE440 800BDC40 80280500 */   sll       $a1, $a1, 2
    /* AE444 800BDC44 C40002AE */  sw         $v0, 0xC4($s0)
    /* AE448 800BDC48 FFF60208 */  j          .L800BDBFC
    /* AE44C 800BDC4C C8001026 */   addiu     $s0, $s0, 0xC8
  .L800BDC50:
    /* AE450 800BDC50 1800BF8F */  lw         $ra, 0x18($sp)
    /* AE454 800BDC54 1400B18F */  lw         $s1, 0x14($sp)
    /* AE458 800BDC58 1000B08F */  lw         $s0, 0x10($sp)
    /* AE45C 800BDC5C 0800E003 */  jr         $ra
    /* AE460 800BDC60 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_InitViewOT__Fv
