.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_addbigsync, 0x78

glabel FILE_addbigsync
    /* DB1F8 800EA9F8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DB1FC 800EA9FC 1800B2AF */  sw         $s2, 0x18($sp)
    /* DB200 800EAA00 2190E000 */  addu       $s2, $a3, $zero
    /* DB204 800EAA04 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB208 800EAA08 21880000 */  addu       $s1, $zero, $zero
    /* DB20C 800EAA0C 21382002 */  addu       $a3, $s1, $zero
    /* DB210 800EAA10 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DB214 800EAA14 16B2030C */  jal        FILE_addbig
    /* DB218 800EAA18 1000B0AF */   sw        $s0, 0x10($sp)
    /* DB21C 800EAA1C 21804000 */  addu       $s0, $v0, $zero
    /* DB220 800EAA20 0B000012 */  beqz       $s0, .L800EAA50
    /* DB224 800EAA24 00000000 */   nop
    /* DB228 800EAA28 6FB0030C */  jal        FILE_waitop
    /* DB22C 800EAA2C 21200002 */   addu      $a0, $s0, $zero
    /* DB230 800EAA30 71AF030C */  jal        FILE_opstatus
    /* DB234 800EAA34 21200002 */   addu      $a0, $s0, $zero
    /* DB238 800EAA38 01004238 */  xori       $v0, $v0, 0x1
    /* DB23C 800EAA3C 0100512C */  sltiu      $s1, $v0, 0x1
    /* DB240 800EAA40 ACB0030C */  jal        FILE_completeop
    /* DB244 800EAA44 21200002 */   addu      $a0, $s0, $zero
    /* DB248 800EAA48 95AA0308 */  j          .L800EAA54
    /* DB24C 800EAA4C 000042AE */   sw        $v0, 0x0($s2)
  .L800EAA50:
    /* DB250 800EAA50 000040AE */  sw         $zero, 0x0($s2)
  .L800EAA54:
    /* DB254 800EAA54 21102002 */  addu       $v0, $s1, $zero
    /* DB258 800EAA58 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DB25C 800EAA5C 1800B28F */  lw         $s2, 0x18($sp)
    /* DB260 800EAA60 1400B18F */  lw         $s1, 0x14($sp)
    /* DB264 800EAA64 1000B08F */  lw         $s0, 0x10($sp)
    /* DB268 800EAA68 0800E003 */  jr         $ra
    /* DB26C 800EAA6C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_addbigsync
