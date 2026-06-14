.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_InitViewOTInGame__Fv, 0x7C

glabel Draw_InitViewOTInGame__Fv
    /* AE464 800BDC64 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AE468 800BDC68 1400B1AF */  sw         $s1, 0x14($sp)
    /* AE46C 800BDC6C 21880000 */  addu       $s1, $zero, $zero
    /* AE470 800BDC70 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AE474 800BDC74 1000B0AF */  sw         $s0, 0x10($sp)
    /* AE478 800BDC78 54EC5024 */  addiu      $s0, $v0, %lo(Draw_gView)
    /* AE47C 800BDC7C 1800BFAF */  sw         $ra, 0x18($sp)
  .L800BDC80:
    /* AE480 800BDC80 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AE484 800BDC84 00000000 */  nop
    /* AE488 800BDC88 2A102202 */  slt        $v0, $s1, $v0
    /* AE48C 800BDC8C 0F004010 */  beqz       $v0, .L800BDCCC
    /* AE490 800BDC90 1480053C */   lui       $a1, %hi(D_8013D798)
    /* AE494 800BDC94 98D7A524 */  addiu      $a1, $a1, %lo(D_8013D798)
    /* AE498 800BDC98 0000048E */  lw         $a0, 0x0($s0)
    /* AE49C 800BDC9C 01003126 */  addiu      $s1, $s1, 0x1
    /* AE4A0 800BDCA0 BA70030C */  jal        Platform_ReserveMemory__FiPc
    /* AE4A4 800BDCA4 80200400 */   sll       $a0, $a0, 2
    /* AE4A8 800BDCA8 1480053C */  lui        $a1, %hi(D_8013D79C)
    /* AE4AC 800BDCAC 0000048E */  lw         $a0, 0x0($s0)
    /* AE4B0 800BDCB0 9CD7A524 */  addiu      $a1, $a1, %lo(D_8013D79C)
    /* AE4B4 800BDCB4 C00002AE */  sw         $v0, 0xC0($s0)
    /* AE4B8 800BDCB8 BA70030C */  jal        Platform_ReserveMemory__FiPc
    /* AE4BC 800BDCBC 80200400 */   sll       $a0, $a0, 2
    /* AE4C0 800BDCC0 C40002AE */  sw         $v0, 0xC4($s0)
    /* AE4C4 800BDCC4 20F70208 */  j          .L800BDC80
    /* AE4C8 800BDCC8 C8001026 */   addiu     $s0, $s0, 0xC8
  .L800BDCCC:
    /* AE4CC 800BDCCC 1800BF8F */  lw         $ra, 0x18($sp)
    /* AE4D0 800BDCD0 1400B18F */  lw         $s1, 0x14($sp)
    /* AE4D4 800BDCD4 1000B08F */  lw         $s0, 0x10($sp)
    /* AE4D8 800BDCD8 0800E003 */  jr         $ra
    /* AE4DC 800BDCDC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_InitViewOTInGame__Fv
