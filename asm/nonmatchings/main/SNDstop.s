.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDstop, 0x88

glabel SNDstop
    /* D8680 800E7E80 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8684 800E7E84 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D8688 800E7E88 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D868C 800E7E8C 1800B0AF */  sw         $s0, 0x18($sp)
    /* D8690 800E7E90 21808000 */  addu       $s0, $a0, $zero
    /* D8694 800E7E94 03004014 */  bnez       $v0, .L800E7EA4
    /* D8698 800E7E98 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* D869C 800E7E9C BE9F0308 */  j          .L800E7EF8
    /* D86A0 800E7EA0 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E7EA4:
    /* D86A4 800E7EA4 4DA9030C */  jal        iSNDenteraudio
    /* D86A8 800E7EA8 00000000 */   nop
    /* D86AC 800E7EAC 71FB030C */  jal        iSNDgetchan
    /* D86B0 800E7EB0 21200002 */   addu      $a0, $s0, $zero
    /* D86B4 800E7EB4 21804000 */  addu       $s0, $v0, $zero
    /* D86B8 800E7EB8 0C000006 */  bltz       $s0, .L800E7EEC
    /* D86BC 800E7EBC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D86C0 800E7EC0 1000A2AF */  sw         $v0, 0x10($sp)
    /* D86C4 800E7EC4 21200002 */  addu       $a0, $s0, $zero
  .L800E7EC8:
    /* D86C8 800E7EC8 D3FB030C */  jal        iSNDpatchkey
    /* D86CC 800E7ECC 1000A527 */   addiu     $a1, $sp, 0x10
    /* D86D0 800E7ED0 06004010 */  beqz       $v0, .L800E7EEC
    /* D86D4 800E7ED4 00000000 */   nop
    /* D86D8 800E7ED8 1000A48F */  lw         $a0, 0x10($sp)
    /* D86DC 800E7EDC A4FF030C */  jal        iSNDstop
    /* D86E0 800E7EE0 00000000 */   nop
    /* D86E4 800E7EE4 B29F0308 */  j          .L800E7EC8
    /* D86E8 800E7EE8 21200002 */   addu      $a0, $s0, $zero
  .L800E7EEC:
    /* D86EC 800E7EEC 5BA9030C */  jal        iSNDleaveaudio
    /* D86F0 800E7EF0 00000000 */   nop
    /* D86F4 800E7EF4 21100002 */  addu       $v0, $s0, $zero
  .L800E7EF8:
    /* D86F8 800E7EF8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D86FC 800E7EFC 1800B08F */  lw         $s0, 0x18($sp)
    /* D8700 800E7F00 0800E003 */  jr         $ra
    /* D8704 800E7F04 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDstop
