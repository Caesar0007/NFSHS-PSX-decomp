.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateBrightness__16tScreenCarSelects, 0x84

glabel UpdateBrightness__16tScreenCarSelects
    /* 2CCB8 8003C4B8 002C0500 */  sll        $a1, $a1, 16
    /* 2CCBC 8003C4BC C32B0500 */  sra        $a1, $a1, 15
    /* 2CCC0 8003C4C0 21208500 */  addu       $a0, $a0, $a1
    /* 2CCC4 8003C4C4 78038684 */  lh         $a2, 0x378($a0)
    /* 2CCC8 8003C4C8 74038584 */  lh         $a1, 0x374($a0)
    /* 2CCCC 8003C4CC 74038394 */  lhu        $v1, 0x374($a0)
    /* 2CCD0 8003C4D0 2A10A600 */  slt        $v0, $a1, $a2
    /* 2CCD4 8003C4D4 0B004010 */  beqz       $v0, .L8003C504
    /* 2CCD8 8003C4D8 08006224 */   addiu     $v0, $v1, 0x8
    /* 2CCDC 8003C4DC 740382A4 */  sh         $v0, 0x374($a0)
    /* 2CCE0 8003C4E0 00140200 */  sll        $v0, $v0, 16
    /* 2CCE4 8003C4E4 2118C000 */  addu       $v1, $a2, $zero
    /* 2CCE8 8003C4E8 03140200 */  sra        $v0, $v0, 16
    /* 2CCEC 8003C4EC 2A186200 */  slt        $v1, $v1, $v0
    /* 2CCF0 8003C4F0 78038294 */  lhu        $v0, 0x378($a0)
    /* 2CCF4 8003C4F4 0F006010 */  beqz       $v1, .L8003C534
    /* 2CCF8 8003C4F8 00000000 */   nop
    /* 2CCFC 8003C4FC 0800E003 */  jr         $ra
    /* 2CD00 8003C500 740382A4 */   sh        $v0, 0x374($a0)
  .L8003C504:
    /* 2CD04 8003C504 2A10C500 */  slt        $v0, $a2, $a1
    /* 2CD08 8003C508 0A004010 */  beqz       $v0, .L8003C534
    /* 2CD0C 8003C50C F8FF6224 */   addiu     $v0, $v1, -0x8
    /* 2CD10 8003C510 740382A4 */  sh         $v0, 0x374($a0)
    /* 2CD14 8003C514 00140200 */  sll        $v0, $v0, 16
    /* 2CD18 8003C518 78038384 */  lh         $v1, 0x378($a0)
    /* 2CD1C 8003C51C 03140200 */  sra        $v0, $v0, 16
    /* 2CD20 8003C520 2A104300 */  slt        $v0, $v0, $v1
    /* 2CD24 8003C524 78038394 */  lhu        $v1, 0x378($a0)
    /* 2CD28 8003C528 02004010 */  beqz       $v0, .L8003C534
    /* 2CD2C 8003C52C 00000000 */   nop
    /* 2CD30 8003C530 740383A4 */  sh         $v1, 0x374($a0)
  .L8003C534:
    /* 2CD34 8003C534 0800E003 */  jr         $ra
    /* 2CD38 8003C538 00000000 */   nop
endlabel UpdateBrightness__16tScreenCarSelects
