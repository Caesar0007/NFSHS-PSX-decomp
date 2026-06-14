.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxmemconstrain, 0x7C

glabel iSNDpsxmemconstrain
    /* FAD50 8010A550 1480023C */  lui        $v0, %hi(sndpd)
    /* FAD54 8010A554 18794824 */  addiu      $t0, $v0, %lo(sndpd)
    /* FAD58 8010A558 1A050795 */  lhu        $a3, 0x51A($t0)
    /* FAD5C 8010A55C 0000868C */  lw         $a2, 0x0($a0)
    /* FAD60 8010A560 00000000 */  nop
    /* FAD64 8010A564 2A10C700 */  slt        $v0, $a2, $a3
    /* FAD68 8010A568 07004010 */  beqz       $v0, .L8010A588
    /* FAD6C 8010A56C 2310E600 */   subu      $v0, $a3, $a2
    /* FAD70 8010A570 000087AC */  sw         $a3, 0x0($a0)
    /* FAD74 8010A574 0000A38C */  lw         $v1, 0x0($a1)
    /* FAD78 8010A578 00000000 */  nop
    /* FAD7C 8010A57C 23186200 */  subu       $v1, $v1, $v0
    /* FAD80 8010A580 0000A3AC */  sw         $v1, 0x0($a1)
    /* FAD84 8010A584 0000868C */  lw         $a2, 0x0($a0)
  .L8010A588:
    /* FAD88 8010A588 0000A28C */  lw         $v0, 0x0($a1)
    /* FAD8C 8010A58C 1C050395 */  lhu        $v1, 0x51C($t0)
    /* FAD90 8010A590 2110C200 */  addu       $v0, $a2, $v0
    /* FAD94 8010A594 2A106200 */  slt        $v0, $v1, $v0
    /* FAD98 8010A598 02004010 */  beqz       $v0, .L8010A5A4
    /* FAD9C 8010A59C 23106600 */   subu      $v0, $v1, $a2
    /* FADA0 8010A5A0 0000A2AC */  sw         $v0, 0x0($a1)
  .L8010A5A4:
    /* FADA4 8010A5A4 0000848C */  lw         $a0, 0x0($a0)
    /* FADA8 8010A5A8 0000A28C */  lw         $v0, 0x0($a1)
    /* FADAC 8010A5AC 1E050395 */  lhu        $v1, 0x51E($t0)
    /* FADB0 8010A5B0 21108200 */  addu       $v0, $a0, $v0
    /* FADB4 8010A5B4 2A106200 */  slt        $v0, $v1, $v0
    /* FADB8 8010A5B8 02004010 */  beqz       $v0, .L8010A5C4
    /* FADBC 8010A5BC 23106400 */   subu      $v0, $v1, $a0
    /* FADC0 8010A5C0 0000A2AC */  sw         $v0, 0x0($a1)
  .L8010A5C4:
    /* FADC4 8010A5C4 0800E003 */  jr         $ra
    /* FADC8 8010A5C8 00000000 */   nop
endlabel iSNDpsxmemconstrain
