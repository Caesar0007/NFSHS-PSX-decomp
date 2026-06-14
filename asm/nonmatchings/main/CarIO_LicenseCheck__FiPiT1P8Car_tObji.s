.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_LicenseCheck__FiPiT1P8Car_tObji, 0x9C

glabel CarIO_LicenseCheck__FiPiT1P8Car_tObji
    /* ACE68 800BC668 2140A000 */  addu       $t0, $a1, $zero
    /* ACE6C 800BC66C 1000A38F */  lw         $v1, 0x10($sp)
    /* ACE70 800BC670 02008430 */  andi       $a0, $a0, 0x2
    /* ACE74 800BC674 1F008010 */  beqz       $a0, .L800BC6F4
    /* ACE78 800BC678 2148C000 */   addu      $t1, $a2, $zero
    /* ACE7C 800BC67C F811848F */  lw         $a0, %gp_rel(CarIO_licenseSFX_Count)($gp)
    /* ACE80 800BC680 00000000 */  nop
    /* ACE84 800BC684 0C008228 */  slti       $v0, $a0, 0xC
    /* ACE88 800BC688 1B004010 */  beqz       $v0, .L800BC6F8
    /* ACE8C 800BC68C 2110E300 */   addu      $v0, $a3, $v1
    /* ACE90 800BC690 1280023C */  lui        $v0, %hi(CarIO_licenseSFX_Vram)
    /* ACE94 800BC694 E8EB4224 */  addiu      $v0, $v0, %lo(CarIO_licenseSFX_Vram)
    /* ACE98 800BC698 80200400 */  sll        $a0, $a0, 2
    /* ACE9C 800BC69C 21208200 */  addu       $a0, $a0, $v0
    /* ACEA0 800BC6A0 2128E300 */  addu       $a1, $a3, $v1
    /* ACEA4 800BC6A4 00008684 */  lh         $a2, 0x0($a0)
    /* ACEA8 800BC6A8 0000028D */  lw         $v0, 0x0($t0)
    /* ACEAC 800BC6AC 02008484 */  lh         $a0, 0x2($a0)
    /* ACEB0 800BC6B0 3F00C330 */  andi       $v1, $a2, 0x3F
    /* ACEB4 800BC6B4 3F004230 */  andi       $v0, $v0, 0x3F
    /* ACEB8 800BC6B8 23186200 */  subu       $v1, $v1, $v0
    /* ACEBC 800BC6BC 80180300 */  sll        $v1, $v1, 2
    /* ACEC0 800BC6C0 CC08A3A0 */  sb         $v1, 0x8CC($a1)
    /* ACEC4 800BC6C4 00002291 */  lbu        $v0, 0x0($t1)
    /* ACEC8 800BC6C8 00000000 */  nop
    /* ACECC 800BC6CC 23108200 */  subu       $v0, $a0, $v0
    /* ACED0 800BC6D0 CE08A2A0 */  sb         $v0, 0x8CE($a1)
    /* ACED4 800BC6D4 000006AD */  sw         $a2, 0x0($t0)
    /* ACED8 800BC6D8 000024AD */  sw         $a0, 0x0($t1)
    /* ACEDC 800BC6DC F811828F */  lw         $v0, %gp_rel(CarIO_licenseSFX_Count)($gp)
    /* ACEE0 800BC6E0 00000000 */  nop
    /* ACEE4 800BC6E4 01004224 */  addiu      $v0, $v0, 0x1
    /* ACEE8 800BC6E8 F81182AF */  sw         $v0, %gp_rel(CarIO_licenseSFX_Count)($gp)
    /* ACEEC 800BC6EC 0800E003 */  jr         $ra
    /* ACEF0 800BC6F0 00000000 */   nop
  .L800BC6F4:
    /* ACEF4 800BC6F4 2110E300 */  addu       $v0, $a3, $v1
  .L800BC6F8:
    /* ACEF8 800BC6F8 CE0840A0 */  sb         $zero, 0x8CE($v0)
    /* ACEFC 800BC6FC 0800E003 */  jr         $ra
    /* ACF00 800BC700 CC0840A0 */   sb        $zero, 0x8CC($v0)
endlabel CarIO_LicenseCheck__FiPiT1P8Car_tObji
