.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memmove, 0x6C

glabel memmove
    /* EEB98 800FE398 21388000 */  addu       $a3, $a0, $zero
    /* EEB9C 800FE39C 2B10E500 */  sltu       $v0, $a3, $a1
    /* EEBA0 800FE3A0 0C004014 */  bnez       $v0, .L800FE3D4
    /* EEBA4 800FE3A4 2110C000 */   addu      $v0, $a2, $zero
    /* EEBA8 800FE3A8 13004018 */  blez       $v0, .L800FE3F8
    /* EEBAC 800FE3AC FFFFC624 */   addiu     $a2, $a2, -0x1
  .L800FE3B0:
    /* EEBB0 800FE3B0 2120E600 */  addu       $a0, $a3, $a2
    /* EEBB4 800FE3B4 2110A600 */  addu       $v0, $a1, $a2
    /* EEBB8 800FE3B8 2118C000 */  addu       $v1, $a2, $zero
    /* EEBBC 800FE3BC 00004290 */  lbu        $v0, 0x0($v0)
    /* EEBC0 800FE3C0 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* EEBC4 800FE3C4 FAFF601C */  bgtz       $v1, .L800FE3B0
    /* EEBC8 800FE3C8 000082A0 */   sb        $v0, 0x0($a0)
    /* EEBCC 800FE3CC FFF80308 */  j          .L800FE3FC
    /* EEBD0 800FE3D0 2110E000 */   addu      $v0, $a3, $zero
  .L800FE3D4:
    /* EEBD4 800FE3D4 08004018 */  blez       $v0, .L800FE3F8
    /* EEBD8 800FE3D8 FFFFC624 */   addiu     $a2, $a2, -0x1
  .L800FE3DC:
    /* EEBDC 800FE3DC 0000A290 */  lbu        $v0, 0x0($a1)
    /* EEBE0 800FE3E0 0100A524 */  addiu      $a1, $a1, 0x1
    /* EEBE4 800FE3E4 2118C000 */  addu       $v1, $a2, $zero
    /* EEBE8 800FE3E8 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* EEBEC 800FE3EC 0000E2A0 */  sb         $v0, 0x0($a3)
    /* EEBF0 800FE3F0 FAFF601C */  bgtz       $v1, .L800FE3DC
    /* EEBF4 800FE3F4 0100E724 */   addiu     $a3, $a3, 0x1
  .L800FE3F8:
    /* EEBF8 800FE3F8 2110E000 */  addu       $v0, $a3, $zero
  .L800FE3FC:
    /* EEBFC 800FE3FC 0800E003 */  jr         $ra
    /* EEC00 800FE400 00000000 */   nop
endlabel memmove
    /* EEC04 800FE404 00000000 */  nop
