.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Udff_Opena__FPcT0i, 0xC8

glabel Udff_Opena__FPcT0i
    /* AC208 800BBA08 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AC20C 800BBA0C 1800B2AF */  sw         $s2, 0x18($sp)
    /* AC210 800BBA10 21908000 */  addu       $s2, $a0, $zero
    /* AC214 800BBA14 1400B1AF */  sw         $s1, 0x14($sp)
    /* AC218 800BBA18 2188A000 */  addu       $s1, $a1, $zero
    /* AC21C 800BBA1C 0580043C */  lui        $a0, %hi(D_80056730)
    /* AC220 800BBA20 30678424 */  addiu      $a0, $a0, %lo(D_80056730)
    /* AC224 800BBA24 0C000524 */  addiu      $a1, $zero, 0xC
    /* AC228 800BBA28 10000624 */  addiu      $a2, $zero, 0x10
    /* AC22C 800BBA2C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* AC230 800BBA30 CF94030C */  jal        reservememadr
    /* AC234 800BBA34 1000B0AF */   sw        $s0, 0x10($sp)
    /* AC238 800BBA38 21804000 */  addu       $s0, $v0, $zero
    /* AC23C 800BBA3C 1E000012 */  beqz       $s0, .L800BBAB8
    /* AC240 800BBA40 21100000 */   addu      $v0, $zero, $zero
    /* AC244 800BBA44 05004016 */  bnez       $s2, .L800BBA5C
    /* AC248 800BBA48 00000000 */   nop
    /* AC24C 800BBA4C 05002012 */  beqz       $s1, .L800BBA64
    /* AC250 800BBA50 01000224 */   addiu     $v0, $zero, 0x1
    /* AC254 800BBA54 9FEE0208 */  j          .L800BBA7C
    /* AC258 800BBA58 000002AE */   sw        $v0, 0x0($s0)
  .L800BBA5C:
    /* AC25C 800BBA5C 0A002012 */  beqz       $s1, .L800BBA88
    /* AC260 800BBA60 21204002 */   addu      $a0, $s2, $zero
  .L800BBA64:
    /* AC264 800BBA64 14000012 */  beqz       $s0, .L800BBAB8
    /* AC268 800BBA68 21100000 */   addu      $v0, $zero, $zero
    /* AC26C 800BBA6C 5095030C */  jal        purgememadr
    /* AC270 800BBA70 21200002 */   addu      $a0, $s0, $zero
    /* AC274 800BBA74 AEEE0208 */  j          .L800BBAB8
    /* AC278 800BBA78 21100000 */   addu      $v0, $zero, $zero
  .L800BBA7C:
    /* AC27C 800BBA7C 040000AE */  sw         $zero, 0x4($s0)
    /* AC280 800BBA80 ADEE0208 */  j          .L800BBAB4
    /* AC284 800BBA84 080011AE */   sw        $s1, 0x8($s0)
  .L800BBA88:
    /* AC288 800BBA88 21280000 */  addu       $a1, $zero, $zero
    /* AC28C 800BBA8C EA95030C */  jal        loadfileadrz
    /* AC290 800BBA90 000000AE */   sw        $zero, 0x0($s0)
    /* AC294 800BBA94 080002AE */  sw         $v0, 0x8($s0)
    /* AC298 800BBA98 21184000 */  addu       $v1, $v0, $zero
    /* AC29C 800BBA9C 05006014 */  bnez       $v1, .L800BBAB4
    /* AC2A0 800BBAA0 040002AE */   sw        $v0, 0x4($s0)
    /* AC2A4 800BBAA4 5095030C */  jal        purgememadr
    /* AC2A8 800BBAA8 21200002 */   addu      $a0, $s0, $zero
    /* AC2AC 800BBAAC AEEE0208 */  j          .L800BBAB8
    /* AC2B0 800BBAB0 21100000 */   addu      $v0, $zero, $zero
  .L800BBAB4:
    /* AC2B4 800BBAB4 21100002 */  addu       $v0, $s0, $zero
  .L800BBAB8:
    /* AC2B8 800BBAB8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* AC2BC 800BBABC 1800B28F */  lw         $s2, 0x18($sp)
    /* AC2C0 800BBAC0 1400B18F */  lw         $s1, 0x14($sp)
    /* AC2C4 800BBAC4 1000B08F */  lw         $s0, 0x10($sp)
    /* AC2C8 800BBAC8 0800E003 */  jr         $ra
    /* AC2CC 800BBACC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Udff_Opena__FPcT0i
