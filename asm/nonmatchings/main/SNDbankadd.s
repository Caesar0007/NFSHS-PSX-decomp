.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDbankadd, 0x94

glabel SNDbankadd
    /* D85EC 800E7DEC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D85F0 800E7DF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* D85F4 800E7DF4 21908000 */  addu       $s2, $a0, $zero
    /* D85F8 800E7DF8 1480023C */  lui        $v0, %hi(sndgs)
    /* D85FC 800E7DFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8600 800E7E00 60785024 */  addiu      $s0, $v0, %lo(sndgs)
    /* D8604 800E7E04 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D8608 800E7E08 1400B1AF */  sw         $s1, 0x14($sp)
    /* D860C 800E7E0C 3C000282 */  lb         $v0, 0x3C($s0)
    /* D8610 800E7E10 00000000 */  nop
    /* D8614 800E7E14 13004010 */  beqz       $v0, .L800E7E64
    /* D8618 800E7E18 2188A000 */   addu      $s1, $a1, $zero
    /* D861C 800E7E1C EF09040C */  jal        iSNDbankalloc
    /* D8620 800E7E20 00000000 */   nop
    /* D8624 800E7E24 40180200 */  sll        $v1, $v0, 1
    /* D8628 800E7E28 21186200 */  addu       $v1, $v1, $v0
    /* D862C 800E7E2C 80180300 */  sll        $v1, $v1, 2
    /* D8630 800E7E30 21202002 */  addu       $a0, $s1, $zero
    /* D8634 800E7E34 000042AE */  sw         $v0, 0x0($s2)
    /* D8638 800E7E38 9800028E */  lw         $v0, 0x98($s0)
    /* D863C 800E7E3C 21288000 */  addu       $a1, $a0, $zero
    /* D8640 800E7E40 21104300 */  addu       $v0, $v0, $v1
    /* D8644 800E7E44 000051AC */  sw         $s1, 0x0($v0)
    /* D8648 800E7E48 040051AC */  sw         $s1, 0x4($v0)
    /* D864C 800E7E4C 0E80023C */  lui        $v0, %hi(SNDbankremove)
    /* D8650 800E7E50 74664224 */  addiu      $v0, $v0, %lo(SNDbankremove)
    /* D8654 800E7E54 9B09040C */  jal        iSNDdownloadbank
    /* D8658 800E7E58 7C0002AE */   sw        $v0, 0x7C($s0)
    /* D865C 800E7E5C 9A9F0308 */  j          .L800E7E68
    /* D8660 800E7E60 00000000 */   nop
  .L800E7E64:
    /* D8664 800E7E64 F6FF0224 */  addiu      $v0, $zero, -0xA
  .L800E7E68:
    /* D8668 800E7E68 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D866C 800E7E6C 1800B28F */  lw         $s2, 0x18($sp)
    /* D8670 800E7E70 1400B18F */  lw         $s1, 0x14($sp)
    /* D8674 800E7E74 1000B08F */  lw         $s0, 0x10($sp)
    /* D8678 800E7E78 0800E003 */  jr         $ra
    /* D867C 800E7E7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDbankadd
