.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_opensync, 0x78

glabel FILE_opensync
    /* DB0A8 800EA8A8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB0AC 800EA8AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* DB0B0 800EA8B0 2190E000 */  addu       $s2, $a3, $zero
    /* DB0B4 800EA8B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB0B8 800EA8B8 21880000 */  addu       $s1, $zero, $zero
    /* DB0BC 800EA8BC 21382002 */  addu       $a3, $s1, $zero
    /* DB0C0 800EA8C0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DB0C4 800EA8C4 DBB0030C */  jal        FILE_open
    /* DB0C8 800EA8C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* DB0CC 800EA8CC 21804000 */  addu       $s0, $v0, $zero
    /* DB0D0 800EA8D0 0B000012 */  beqz       $s0, .L800EA900
    /* DB0D4 800EA8D4 00000000 */   nop
    /* DB0D8 800EA8D8 6FB0030C */  jal        FILE_waitop
    /* DB0DC 800EA8DC 21200002 */   addu      $a0, $s0, $zero
    /* DB0E0 800EA8E0 71AF030C */  jal        FILE_opstatus
    /* DB0E4 800EA8E4 21200002 */   addu      $a0, $s0, $zero
    /* DB0E8 800EA8E8 01004238 */  xori       $v0, $v0, 0x1
    /* DB0EC 800EA8EC 0100512C */  sltiu      $s1, $v0, 0x1
    /* DB0F0 800EA8F0 ACB0030C */  jal        FILE_completeop
    /* DB0F4 800EA8F4 21200002 */   addu      $a0, $s0, $zero
    /* DB0F8 800EA8F8 41AA0308 */  j          .L800EA904
    /* DB0FC 800EA8FC 000042AE */   sw        $v0, 0x0($s2)
  .L800EA900:
    /* DB100 800EA900 000040AE */  sw         $zero, 0x0($s2)
  .L800EA904:
    /* DB104 800EA904 21102002 */  addu       $v0, $s1, $zero
    /* DB108 800EA908 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DB10C 800EA90C 1800B28F */  lw         $s2, 0x18($sp)
    /* DB110 800EA910 1400B18F */  lw         $s1, 0x14($sp)
    /* DB114 800EA914 1000B08F */  lw         $s0, 0x10($sp)
    /* DB118 800EA918 0800E003 */  jr         $ra
    /* DB11C 800EA91C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_opensync
