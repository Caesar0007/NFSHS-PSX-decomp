.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__21tListIteratorCarColor7tPlayer, 0x98

glabel Increment__21tListIteratorCarColor7tPlayer
    /* 8DB0 800185B0 1000828C */  lw         $v0, 0x10($a0)
    /* 8DB4 800185B4 1800838C */  lw         $v1, 0x18($a0)
    /* 8DB8 800185B8 1C00868C */  lw         $a2, 0x1C($a0)
    /* 8DBC 800185BC 00004590 */  lbu        $a1, 0x0($v0)
    /* 8DC0 800185C0 1400828C */  lw         $v0, 0x14($a0)
    /* 8DC4 800185C4 1800A300 */  mult       $a1, $v1
    /* 8DC8 800185C8 21104500 */  addu       $v0, $v0, $a1
    /* 8DCC 800185CC 00004390 */  lbu        $v1, 0x0($v0)
    /* 8DD0 800185D0 0400C68C */  lw         $a2, 0x4($a2)
    /* 8DD4 800185D4 40100300 */  sll        $v0, $v1, 1
    /* 8DD8 800185D8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDC 800185DC 00190200 */  sll        $v1, $v0, 4
    /* 8DE0 800185E0 21104300 */  addu       $v0, $v0, $v1
    /* 8DE4 800185E4 80100200 */  sll        $v0, $v0, 2
    /* 8DE8 800185E8 2130C200 */  addu       $a2, $a2, $v0
    /* 8DEC 800185EC 0000C280 */  lb         $v0, 0x0($a2)
    /* 8DF0 800185F0 0400838C */  lw         $v1, 0x4($a0)
    /* 8DF4 800185F4 12280000 */  mflo       $a1
    /* 8DF8 800185F8 2110A200 */  addu       $v0, $a1, $v0
    /* 8DFC 800185FC 21186200 */  addu       $v1, $v1, $v0
    /* 8E00 80018600 00006290 */  lbu        $v0, 0x0($v1)
    /* 8E04 80018604 00000000 */  nop
    /* 8E08 80018608 01004224 */  addiu      $v0, $v0, 0x1
    /* 8E0C 8001860C 000062A0 */  sb         $v0, 0x0($v1)
    /* 8E10 80018610 0000C280 */  lb         $v0, 0x0($a2)
    /* 8E14 80018614 0400838C */  lw         $v1, 0x4($a0)
    /* 8E18 80018618 AD00C490 */  lbu        $a0, 0xAD($a2)
    /* 8E1C 8001861C 2128A200 */  addu       $a1, $a1, $v0
    /* 8E20 80018620 21286500 */  addu       $a1, $v1, $a1
    /* 8E24 80018624 AC00C390 */  lbu        $v1, 0xAC($a2)
    /* 8E28 80018628 0000A290 */  lbu        $v0, 0x0($a1)
    /* 8E2C 8001862C 21186400 */  addu       $v1, $v1, $a0
    /* 8E30 80018630 2A104300 */  slt        $v0, $v0, $v1
    /* 8E34 80018634 02004014 */  bnez       $v0, .L80018640
    /* 8E38 80018638 00000000 */   nop
    /* 8E3C 8001863C 0000A0A0 */  sb         $zero, 0x0($a1)
  .L80018640:
    /* 8E40 80018640 0800E003 */  jr         $ra
    /* 8E44 80018644 00000000 */   nop
endlabel Increment__21tListIteratorCarColor7tPlayer
